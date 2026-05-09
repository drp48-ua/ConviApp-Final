using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class AdminPisos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                CargarPisos();
            }
        }

        private void CargarPisos()
        {
            var cad = new CADPiso();
            var todos = cad.ListarTodos();
            
            var privados = todos.Where(p => p.EsPrivado).ToList();
            var publicos = todos.Where(p => !p.EsPrivado).ToList();

            rptPisosPrivados.DataSource = privados;
            rptPisosPrivados.DataBind();
            lblNoPrivados.Visible = privados.Count == 0;

            rptPisosApp.DataSource = publicos;
            rptPisosApp.DataBind();
            lblNoPublicos.Visible = publicos.Count == 0;
        }

        protected void BtnGuardarPrivado_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrWhiteSpace(txtDir.Text)) {
                lblMsg.Text = "La dirección es obligatoria.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
                return;
            }

            int habs = 1; int banos = 1; int cocinas = 1; int garajes = 0; decimal precio = 800;
            int.TryParse(txtHabitaciones.Text, out habs);
            int.TryParse(txtBanos.Text, out banos);
            int.TryParse(txtCocinas.Text, out cocinas);
            int.TryParse(txtGarajes.Text, out garajes);
            decimal.TryParse(txtPrecio.Text, out precio);
            
            string caracteristicas = "";
            if (banos > 0) caracteristicas += string.Format("{0} Aseos, ", banos);
            if (cocinas > 0) caracteristicas += string.Format("{0} Cocinas, ", cocinas);
            if (garajes > 0) caracteristicas += string.Format("{0} Garajes, ", garajes);
            if (caracteristicas.EndsWith(", ")) caracteristicas = caracteristicas.Substring(0, caracteristicas.Length - 2);

            int userId = 0; // Sin propietario específico

            // Subida de foto del piso
            string imagenUrl = null;
            if (fuFotoPiso.HasFile)
            {
                string ext = System.IO.Path.GetExtension(fuFotoPiso.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                {
                    string fileName = string.Format("piso_{0}_{1}{2}", userId, DateTime.Now.Ticks, ext);
                    string savePath = Server.MapPath("~/img/pisos/") + fileName;
                    if (!System.IO.Directory.Exists(Server.MapPath("~/img/pisos/")))
                        System.IO.Directory.CreateDirectory(Server.MapPath("~/img/pisos/"));
                    fuFotoPiso.SaveAs(savePath);
                    imagenUrl = "img/pisos/" + fileName;
                }
            }

            string codigo = GenerarCodigo(8);

            var p = new ENPiso { 
                Direccion = txtDir.Text, 
                Ciudad = txtCiudad.Text, 
                Descripcion = txtDescripcion.Text.Trim(),
                NumeroHabitaciones = habs,
                NumeroBanos = banos,
                Caracteristicas = caracteristicas,
                PrecioTotal = precio, 
                Disponible = true,
                PropietarioId = userId,
                ImagenUrl = imagenUrl,
                EsPrivado = true, // IMPORTANTE: Es un piso privado
                Nombre = txtNombre.Text.Trim(),
                CodigoComunidad = codigo
            };
            var cadPiso = new CADPiso();
            int pisoId = cadPiso.CrearPiso(p);

            if (pisoId > 0)
            {
                // Guardar el contrato asociado
                string contratoUrl = null;
                if (fuContrato.HasFile)
                {
                    string ext = System.IO.Path.GetExtension(fuContrato.FileName).ToLower();
                    string fileName = string.Format("contrato_{0}_{1}{2}", pisoId, DateTime.Now.Ticks, ext);
                    string savePath = Server.MapPath("~/doc/") + fileName;
                    if (!System.IO.Directory.Exists(Server.MapPath("~/doc/")))
                        System.IO.Directory.CreateDirectory(Server.MapPath("~/doc/"));
                    fuContrato.SaveAs(savePath);
                    contratoUrl = "doc/" + fileName;
                }

                var c = new ENContrato {
                    PropertyId = pisoId,
                    UserId = userId,
                    Type = "arrendamiento",
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now.AddYears(1),
                    MonthlyRent = precio,
                    DepositAmount = precio * 2,
                    Status = "activo",
                    Notes = "Contrato de piso privado generado por administrador.",
                    CommissionRate = 5.0m,
                    ArchivoUrl = contratoUrl
                };
                var cadContrato = new CADContrato();
                cadContrato.CrearContrato(c);

                lblMsg.Text = "Piso privado y contrato creados correctamente.";
                lblMsg.CssClass = "alert alert-success";
                lblMsg.Visible = true;

                // Limpiar campos
                txtDir.Text = ""; txtCiudad.Text = ""; txtDescripcion.Text = "";
                txtHabitaciones.Text = "1"; txtBanos.Text = "1";
                txtCocinas.Text = "1"; txtGarajes.Text = "0"; txtPrecio.Text = "800";
                
                CargarPisos();
            }
            else
            {
                lblMsg.Text = "Error al crear el piso.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }

        protected void rptPisosPrivados_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == System.Web.UI.WebControls.ListItemType.Item || e.Item.ItemType == System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                var piso = (ENPiso)e.Item.DataItem;
                var rptMiembros = (System.Web.UI.WebControls.Repeater)e.Item.FindControl("rptMiembros");
                if (rptMiembros != null)
                {
                    var cadCu = new CADComunidadUsuario();
                    rptMiembros.DataSource = cadCu.ObtenerUsuariosDeComunidad(piso.Id);
                    rptMiembros.DataBind();
                }
            }
        }

        protected void btnExpulsarAdmin_Command(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            if (e.CommandName == "Expulsar")
            {
                string[] args = e.CommandArgument.ToString().Split('_');
                if (args.Length == 2)
                {
                    int pId = Convert.ToInt32(args[0]);
                    int uId = Convert.ToInt32(args[1]);
                    
                    var cadCu = new CADComunidadUsuario();
                    cadCu.ExpulsarUsuario(pId, uId);
                    
                    lblMsg.Text = "Miembro expulsado de la comunidad privada.";
                    lblMsg.CssClass = "alert alert-success";
                    lblMsg.Visible = true;
                    
                    CargarPisos();
                }
            }
        }

        protected void rptPisosPrivados_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Borrar")
            {
                int pId = Convert.ToInt32(e.CommandArgument);

                // Borrar contratos asociados primero
                var cadContrato = new CADContrato();
                cadContrato.BorrarContratosPorPiso(pId);

                var cadPiso = new CADPiso();
                cadPiso.BorrarPiso(pId);
                
                lblMsg.Text = "Comunidad privada y sus contratos eliminados correctamente.";
                lblMsg.CssClass = "alert alert-success";
                lblMsg.Visible = true;
                
                CargarPisos();
            }
        }

        protected void rptPisosApp_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Borrar")
            {
                int pId = Convert.ToInt32(e.CommandArgument);
                var cadPiso = new CADPiso();
                cadPiso.BorrarPiso(pId);
                
                lblMsg.Text = "Comunidad pública eliminada correctamente.";
                lblMsg.CssClass = "alert alert-success";
                lblMsg.Visible = true;
                
                CargarPisos();
            }
        }

        private string GenerarCodigo(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}
