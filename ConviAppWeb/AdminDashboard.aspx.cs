using System;
using System.Web;
using System.Web.UI;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class AdminDashboard : Page
    {
        protected global::System.Web.UI.WebControls.Label lblTotalUsuarios;
        protected global::System.Web.UI.WebControls.Label lblTotalPisos;
        protected global::System.Web.UI.WebControls.Label lblTotalIncidencias;
        protected global::System.Web.UI.WebControls.Label lblIngresos;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                var cadU = new CADUsuario();
                lblTotalUsuarios.Text = cadU.ObtenerTotal().ToString();

                var cadP = new CADPiso();
                lblTotalPisos.Text = cadP.ObtenerTotal().ToString();

                var cadI = new CADIncidencia();
                lblTotalIncidencias.Text = cadI.ObtenerTotalAbiertas().ToString();

                // Mock Ingresos calculation based on total users (e.g. 5% are Pro paying 4.99)
                int totalUsers = cadU.ObtenerTotal();
                double mrr = (totalUsers * 0.05) * 4.99;
                lblIngresos.Text = "$" + mrr.ToString("0.00");
            }
        }
    }
}


