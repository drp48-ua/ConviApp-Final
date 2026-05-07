using System;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class PisoDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) CargarDetalle();
        }

        private void CargarDetalle()
        {
            string idStr = Request.QueryString["id"];
            int id;
            if (string.IsNullOrWhiteSpace(idStr) || !int.TryParse(idStr, out id))
            {
                pnlNotFound.Visible = true;
                pnlDetalle.Visible = false;
                return;
            }

            var cad = new CADPiso();
            var p = cad.LeerPiso(id);
            if (p == null)
            {
                pnlNotFound.Visible = true;
                pnlDetalle.Visible = false;
                return;
            }

            pnlNotFound.Visible = false;
            pnlDetalle.Visible = true;
            lblDireccion.Text = p.Direccion ?? "Piso";
            lblCiudad.Text = p.Ciudad ?? "";
            lblHabitaciones.Text = p.NumeroHabitaciones.ToString();
            lblPrecio.Text = p.PrecioTotal.ToString("0.00");
        }

        protected void btnUnirse_Click(object sender, EventArgs e)
        {
            string idStr = Request.QueryString["id"];
            int pisoId;
            if (int.TryParse(idStr, out pisoId) && Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                var cadCu = new CADComunidadUsuario();
                bool exito = cadCu.UnirUsuarioAComunidad(pisoId, userId);
                
                if (exito)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "unirse", "alert('¡Te has unido a la comunidad exitosamente!'); window.location.href='Comunidades.aspx';", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "errorUnir", "alert('Ya eres miembro de esta comunidad o hubo un error.');", true);
                }
            }
        }

        protected void btnContactar_Click(object sender, EventArgs e)
        {
            string idStr = Request.QueryString["id"];
            int pisoId;
            if (int.TryParse(idStr, out pisoId) && Session["UserId"] != null)
            {
                string myName = Session["UserName"] != null ? Session["UserName"].ToString() : "Un usuario";
                var cadPiso = new CADPiso();
                var piso = cadPiso.LeerPiso(pisoId);
                
                if (piso != null)
                {
                    var cadN = new CADNotificacion();
                    // ID 1 suele ser el Admin global
                    cadN.CrearNotificacion(new ENNotificacion
                    {
                        UsuarioId = 1,
                        Titulo = "Nuevo interesado en comunidad",
                        Mensaje = string.Format("{0} está interesado en unirse a la comunidad de '{1}'.", myName, piso.Direccion),
                        FechaCreacion = DateTime.Now,
                        Leida = false,
                        Tipo = "Mensaje"
                    });
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "contactar", "alert('¡Se ha enviado tu solicitud al administrador!');", true);
                }
            }
        }
    }
}
