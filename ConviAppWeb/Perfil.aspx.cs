using System;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["UserId"] == null) { Response.Redirect("Login.aspx"); return; }
            if(!IsPostBack) {
                txtNombre.Text = Session["UserName"] != null ? Session["UserName"].ToString() : "";
                txtEmail.Text = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "";
            }
        }
        protected void BtnGuardar_Click(object sender, EventArgs e)
        {
            // Update logic here
            Session["UserName"] = txtNombre.Text;
            Session["UserEmail"] = txtEmail.Text;
        }
    }
}

