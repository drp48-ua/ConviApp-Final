using System;
using System.Linq;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Comunidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) 
            { 
                pnlApp.Visible = false; 
                pnlDemo.Visible = true; 
                return; 
            }
            
            pnlApp.Visible = true; 
            pnlDemo.Visible = false;
            
            if (!IsPostBack)
            {
                CargarComunidades();
            }
        }

        private void CargarComunidades()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            var cadCu = new CADComunidadUsuario();
            var misComunidades = cadCu.ObtenerComunidadesDeUsuario(userId);

            if (misComunidades == null || misComunidades.Count == 0)
            {
                pnlVacio.Visible = true;
                rptComunidades.Visible = false;
            }
            else
            {
                pnlVacio.Visible = false;
                rptComunidades.Visible = true;
                rptComunidades.DataSource = misComunidades;
                rptComunidades.DataBind();
            }
        }

        protected void btnCrearComunidad_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDireccion.Text) || string.IsNullOrWhiteSpace(txtCiudad.Text))
            {
                lblMsg.Text = "⚠️ Dirección y ciudad son obligatorias para crear una comunidad.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            int hab; decimal precio;
            int.TryParse(txtHabitaciones.Text, out hab);
            decimal.TryParse(txtPrecio.Text, out precio);

            string codigo = GenerarCodigo(8);

            var cadPiso = new CADPiso();
            int nuevoPisoId = cadPiso.CrearPiso(new ENPiso
            {
                Nombre = !string.IsNullOrWhiteSpace(txtNombreComunidad.Text) ? txtNombreComunidad.Text.Trim() : txtDireccion.Text.Trim(),
                Direccion = txtDireccion.Text.Trim(),
                Ciudad = txtCiudad.Text.Trim(),
                NumeroHabitaciones = hab > 0 ? hab : 1,
                PrecioTotal = precio,
                Descripcion = txtDescripcion.Text.Trim(),
                CodigoComunidad = codigo,
                Disponible = true,
                PropietarioId = userId
            });

            if (nuevoPisoId > 0)
            {
                var cadCu = new CADComunidadUsuario();
                cadCu.UnirUsuarioAComunidad(nuevoPisoId, userId);
                
                // Entrar directamente a la nueva comunidad
                Session["ComunidadActivaId"] = nuevoPisoId;
                Session["ComunidadActivaNombre"] = !string.IsNullOrWhiteSpace(txtNombreComunidad.Text) ? txtNombreComunidad.Text.Trim() : txtDireccion.Text.Trim();
                
                Response.Redirect("Comunidades.aspx");
            }
            else
            {
                lblMsg.Text = "❌ Hubo un error al crear la comunidad.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }

        protected void btnUnirse_Click(object sender, EventArgs e)
        {
            string codigo = txtCodigoUnir.Text.Trim().ToUpper();
            if (string.IsNullOrWhiteSpace(codigo) || codigo.Length != 8)
            {
                lblMsg.Text = "⚠️ Debes ingresar un código válido de 8 caracteres.";
                lblMsg.CssClass = "alert alert-warning";
                lblMsg.Visible = true;
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            var cadCu = new CADComunidadUsuario();
            var piso = cadCu.BuscarComunidadPorCodigo(codigo);

            if (piso != null)
            {
                bool unido = cadCu.UnirUsuarioAComunidad(piso.Id, userId);
                if (unido)
                {
                    lblMsg.Text = "✅ ¡Te has unido a la comunidad en " + piso.Direccion + "!";
                    lblMsg.CssClass = "alert alert-success";
                    lblMsg.Visible = true;
                    txtCodigoUnir.Text = "";
                    CargarComunidades();
                }
                else
                {
                    lblMsg.Text = "⚠️ Ya eres miembro de esta comunidad o hubo un error.";
                    lblMsg.CssClass = "alert alert-warning";
                    lblMsg.Visible = true;
                }
            }
            else
            {
                lblMsg.Text = "❌ No se encontró ninguna comunidad con ese código.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }

        protected void rptComunidades_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Entrar")
            {
                int pisoId = Convert.ToInt32(e.CommandArgument);
                string nombre = e.CommandArgument.ToString(); // default

                // Buscar el nombre real del piso
                var cadPiso = new CADPiso();
                var piso = cadPiso.LeerPiso(pisoId);
                if (piso != null)
                {
                    nombre = !string.IsNullOrWhiteSpace(piso.Nombre) ? piso.Nombre : piso.Direccion;
                }

                Session["ComunidadActivaId"] = pisoId;
                Session["ComunidadActivaNombre"] = nombre;
                Response.Redirect("Index.aspx");
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
