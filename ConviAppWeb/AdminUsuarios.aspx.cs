using System;
using System.Web;
using System.Web.UI;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class AdminUsuarios : Page
    {
        protected global::System.Web.UI.WebControls.Repeater rptUsuarios;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                var cad = new CADUsuario();
                rptUsuarios.DataSource = cad.ObtenerTodos();
                rptUsuarios.DataBind();
            }
        }
    }
}


