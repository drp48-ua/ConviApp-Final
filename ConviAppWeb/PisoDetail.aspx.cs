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
    }
}


