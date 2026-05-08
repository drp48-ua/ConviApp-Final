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
            lblBanos.Text = p.NumeroBanos.ToString();
            lblDescripcion.Text = !string.IsNullOrWhiteSpace(p.Descripcion) ? p.Descripcion : "Piso compartido ideal para estudiantes y profesionales. Todas las zonas comunes incluidas. Precio total dividido entre los inquilinos.";
            
            if (!string.IsNullOrWhiteSpace(p.Caracteristicas))
            {
                string[] parts = p.Caracteristicas.Split(new string[] { ", " }, StringSplitOptions.RemoveEmptyEntries);
                string html = "";
                foreach (var part in parts)
                {
                    html += string.Format("<span class=\"listing-tag\">✨ {0}</span>", part);
                }
                lblCaracteristicas.Text = html;
            }
            else
            {
                lblCaracteristicas.Text = "";
            }
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
                    // Notificar al creador de la comunidad (PropietarioId), o al admin si no hay propietario
                    int destinatarioId = piso.PropietarioId > 0 ? piso.PropietarioId : 1;
                    cadN.CrearNotificacion(new ENNotificacion
                    {
                        UsuarioId = destinatarioId,
                        Titulo = "Nuevo interesado en tu comunidad",
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
