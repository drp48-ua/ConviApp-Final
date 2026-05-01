using System;
using System.Web;
using System.Web.UI;

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
        }
    }
}


