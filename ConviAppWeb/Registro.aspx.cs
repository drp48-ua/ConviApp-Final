using System;
using System.Linq;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) {}

        protected void BtnRegistrar_Click(object sender, EventArgs e)
        {
            pnlError.Visible = false;
            lblError.Text = "";

            if (!txtEmail.Text.Trim().EndsWith("@gmail.com", StringComparison.OrdinalIgnoreCase))
            {
                pnlError.Visible = true;
                lblError.Text = "El correo electrónico debe ser de @gmail.com.";
                return;
            }

            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                pnlError.Visible = true;
                lblError.Text = "Las contraseñas no coinciden.";
                return;
            }

            if (txtPassword.Text.Length < 6 || !txtPassword.Text.Any(char.IsUpper) || !txtPassword.Text.Any(c => !char.IsLetterOrDigit(c)))
            {
                pnlError.Visible = true;
                lblError.Text = "La contraseña debe tener al menos 6 caracteres, incluir una mayúscula y un signo especial.";
                return;
            }

            var en = new ENUsuario { Nombre = txtNombre.Text, Email = txtEmail.Text.Trim(), PasswordHash = txtPassword.Text, FechaRegistro = DateTime.Today };
            var cad = new CADUsuario();
            if (cad.CrearUsuario(en))
            {
                var dbUser = cad.BuscarPorEmail(en.Email);
                if (dbUser != null)
                {
                    Session["UserId"] = dbUser.Id;
                }
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
                lblError.Text = "Error al crear el usuario. Asegúrate de que el correo no esté ya en uso.";
            }
        }
    }
}
