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
            lblCocinas.Text = "1";
            lblGarajes.Text = "0";

            if (!string.IsNullOrWhiteSpace(p.Caracteristicas))
            {
                string[] parts = p.Caracteristicas.Split(new string[] { ", " }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var part in parts)
                {
                    if (part.Contains("Cocinas")) lblCocinas.Text = part.Replace("Cocinas", "").Trim();
                    else if (part.Contains("Garajes")) lblGarajes.Text = part.Replace("Garajes", "").Trim();
                }
            }
            lblCaracteristicas.Text = "";
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
            if (!int.TryParse(idStr, out pisoId) || Session["UserId"] == null) return;

            int myId = Convert.ToInt32(Session["UserId"]);
            var cadPiso = new CADPiso();
            var piso = cadPiso.LeerPiso(pisoId);
            if (piso == null) return;

            int destinatarioId = 0;

            // Primero intentamos usar el PropietarioId registrado
            if (piso.PropietarioId > 0 && piso.PropietarioId != myId)
            {
                destinatarioId = piso.PropietarioId;
            }
            else
            {
                // Fallback: primer miembro de la comunidad que no sea yo
                var cadCu = new CADComunidadUsuario();
                var miembros = cadCu.ObtenerUsuariosDeComunidad(pisoId);
                foreach (var m in miembros)
                {
                    if (m.Id != myId) { destinatarioId = m.Id; break; }
                }
            }

            if (destinatarioId > 0)
                Response.Redirect("Chat.aspx?con=" + destinatarioId);
            else
                Response.Redirect("Foro.aspx"); // última opción: no hay otro usuario
        }
    }
}
