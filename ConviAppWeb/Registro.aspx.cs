using System;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) {}

        protected void BtnRegistrar_Click(object sender, EventArgs e)
        {
            var en = new ENUsuario { Nombre = txtNombre.Text, Email = txtEmail.Text, PasswordHash = txtPassword.Text, FechaRegistro = DateTime.Today };
            var cad = new CADUsuario();
            if (cad.CrearUsuario(en))
            {
                Session["UserEmail"] = en.Email;
                Session["UserName"] = en.Nombre;
                Session["UserRole"] = Request.Form["planSelected"] ?? "Basico";
                if (en.Email.ToLower().Trim() == "admin@conviapp.com")
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
                lblError.Text = "No se pudo crear la cuenta. Es posible que el correo ya esté registrado o haya un problema con la base de datos.";
            }
        }
    }
}


