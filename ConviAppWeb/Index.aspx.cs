using System;

namespace ConviAppWeb
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null && Session["UserEmail"].ToString().ToLower().Trim() == "admin@conviapp.com")
            {
                Response.Redirect("AdminDashboard.aspx");
            }
            // All presentation logic is now handled in the ASPX markup using inline syntax.
        }
    }
}


