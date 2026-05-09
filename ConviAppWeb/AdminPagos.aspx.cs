using System;
using System.Web;
using System.Web.UI;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class AdminPagos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                CargarContratos();
            }
        }

        private void CargarContratos()
        {
            var cad = new CADContrato();
            var contratos = cad.ListarDePisosPrivados();
            
            rptContratos.DataSource = contratos;
            rptContratos.DataBind();
            
            lblVacio.Visible = contratos.Count == 0;
        }
    }
}
