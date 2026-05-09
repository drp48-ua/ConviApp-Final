using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Pisos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack)
            {
                CargarPisos();
                // Si viene desde Comunidades.aspx con ?crear=1, abrir el formulario directamente
                if (Request.QueryString["crear"] == "1")
                    pnlForm.Visible = true;
            }
        }

        private void CargarPisos()
        {
            var cad = new CADPiso();
            var filtrados = cad.ListarTodos().Where(p => !p.EsPrivado).ToList();
            
            if(!string.IsNullOrWhiteSpace(txtFiltroCiudad.Text)) {
                filtrados = filtrados.Where(p => p.Ciudad != null && p.Ciudad.IndexOf(txtFiltroCiudad.Text, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            }
            decimal mn;
            if(decimal.TryParse(txtFiltroMin.Text, out mn)) {
                filtrados = filtrados.Where(p => p.PrecioTotal >= mn).ToList();
            }
            decimal mx;
            if(decimal.TryParse(txtFiltroMax.Text, out mx)) {
                filtrados = filtrados.Where(p => p.PrecioTotal <= mx).ToList();
            }
            
            pnlVacio.Visible = filtrados.Count == 0;
            lblSumaPisos.Text = filtrados.Count.ToString();
            
            rptPisos.DataSource = filtrados;
            rptPisos.DataBind();
        }

        protected void BtnNuevo_Click(object sender, EventArgs e) { pnlForm.Visible = true; }
        
        protected void BtnCancelar_Click(object sender, EventArgs e) { pnlForm.Visible = false; }
        
        protected void BtnGuardar_Click(object sender, EventArgs e)
        {
            if(!string.IsNullOrWhiteSpace(txtDir.Text)) {
                int habs = 1; int banos = 1; int cocinas = 1; int garajes = 0;
                int.TryParse(txtHabitaciones.Text, out habs);
                int.TryParse(txtBanos.Text, out banos);
                int.TryParse(txtCocinas.Text, out cocinas);
                int.TryParse(txtGarajes.Text, out garajes);
                
                string caracteristicas = "";
                if (banos > 0) caracteristicas += string.Format("{0} Aseos, ", banos);
                if (cocinas > 0) caracteristicas += string.Format("{0} Cocinas, ", cocinas);
                if (garajes > 0) caracteristicas += string.Format("{0} Garajes, ", garajes);
                if (caracteristicas.EndsWith(", ")) caracteristicas = caracteristicas.Substring(0, caracteristicas.Length - 2);

                int userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;

                // Subida de foto
                string imagenUrl = null;
                if (fuFoto.HasFile)
                {
                    string ext = System.IO.Path.GetExtension(fuFoto.FileName).ToLower();
                    if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                    {
                        string fileName = string.Format("piso_{0}_{1}{2}", userId, DateTime.Now.Ticks, ext);
                        string savePath = Server.MapPath("~/img/pisos/") + fileName;
                        // Asegurar que el directorio existe
                        if (!System.IO.Directory.Exists(Server.MapPath("~/img/pisos/")))
                            System.IO.Directory.CreateDirectory(Server.MapPath("~/img/pisos/"));
                        fuFoto.SaveAs(savePath);
                        imagenUrl = "img/pisos/" + fileName;
                    }
                }

                var p = new ENPiso { 
                    Direccion = txtDir.Text, 
                    Ciudad = txtCiudad.Text, 
                    Descripcion = txtDescripcion.Text.Trim(),
                    NumeroHabitaciones = habs,
                    NumeroBanos = banos,
                    Caracteristicas = caracteristicas,
                    PrecioTotal = 350.00m, 
                    Disponible = true,
                    PropietarioId = userId,
                    ImagenUrl = imagenUrl,
                    Nombre = txtNombre.Text.Trim(),
                    CodigoComunidad = GenerarCodigo(8)
                };
                var cad = new CADPiso();
                int nuevoPisoId = cad.CrearPiso(p);
                
                if (nuevoPisoId > 0 && userId > 0)
                {
                    var cadCu = new CADComunidadUsuario();
                    cadCu.UnirUsuarioAComunidad(nuevoPisoId, userId);
                    
                    Session["ComunidadActivaId"] = nuevoPisoId;
                    Session["ComunidadActivaNombre"] = !string.IsNullOrWhiteSpace(p.Nombre) ? p.Nombre : p.Direccion;
                    
                    Response.Redirect("Index.aspx");
                }
                
                txtDir.Text = ""; txtCiudad.Text = ""; txtDescripcion.Text = "";
                txtHabitaciones.Text = "1"; txtBanos.Text = "1";
                txtCocinas.Text = "1"; txtGarajes.Text = "0";
                
                pnlForm.Visible = false;
                CargarPisos();
            }
        }
        
        protected void BtnBuscar_Click(object sender, EventArgs e)
        {
            CargarPisos();
        }

        protected void rptPisos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Unirse")
            {
                int pisoId = Convert.ToInt32(e.CommandArgument);
                int userId = Convert.ToInt32(Session["UserId"]);
                
                var cadCu = new CADComunidadUsuario();
                bool exito = cadCu.UnirUsuarioAComunidad(pisoId, userId);
                
                if (exito)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "unirse", "alert('¡Te has unido a la comunidad de este piso exitosamente!'); window.location.href='Comunidades.aspx';", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "errorUnir", "alert('Ya eres miembro de esta comunidad o hubo un error.');", true);
                }
            }
        }

        private string GenerarCodigo(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            return new string(System.Linq.Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}
