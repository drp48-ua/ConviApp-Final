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
                CargarUsuarios();
                CargarPisos();
            }
        }

        private void CargarUsuarios()
        {
            var cad = new CADUsuario();
            var usuarios = cad.ObtenerTodos();
            ddlPropietarios.DataSource = usuarios;
            ddlPropietarios.DataTextField = "Nombre";
            ddlPropietarios.DataValueField = "Id";
            ddlPropietarios.DataBind();
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

            int userId = 0;
            int.TryParse(ddlPropietarios.SelectedValue, out userId);

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
                EsPrivado = true // IMPORTANTE: Es un piso privado
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
    }
}
