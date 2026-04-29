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
                Response.Redirect("Index.aspx");
            }
        }
    }
}

