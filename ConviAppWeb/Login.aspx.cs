using System;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) {}

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                var cad = new CADUsuario();
                var user = cad.BuscarPorEmail(txtEmail.Text.Trim());
                if (user != null && user.PasswordHash == txtPassword.Text)
                {
                    Session["UserId"] = user.Id;
                    Session["UserEmail"] = user.Email;
                    Session["UserName"] = user.Nombre;
                    Session["UserRole"] = "Basico";
                    if (user.Email.ToLower().Trim() == "admin@conviapp.com")
                    {
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("Index.aspx");
                    }
                }
                else
                {
                    pnlError.Visible = true;
                    lblError.Text = "Credenciales incorrectas.";
                }
            }
        }
    }
}
