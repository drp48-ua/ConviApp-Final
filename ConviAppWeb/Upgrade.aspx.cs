using System;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class Upgrade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Permitir que usuarios anónimos vean la página
        }

        protected void BtnPro_Click(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) 
            { 
                Response.Redirect("Registro.aspx"); 
                return; 
            }

            if (string.IsNullOrWhiteSpace(txtIBANPro.Text) || txtIBANPro.Text.Replace(" ", "").Length < 10)
            {
                lblErrPro.Text = "⚠️ Introduce un IBAN simulado de al menos 10 caracteres.";
                lblErrPro.Visible = true;
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            var cadU = new CADUsuario();
            var usuario = cadU.LeerUsuario(userId);
            if (usuario != null)
            {
                usuario.Rol.Nombre = "Profesional";
                cadU.ActualizarUsuario(usuario);
                Session["UserRole"] = "Profesional";
            }

            lblErrPro.Visible = false;
            Response.Redirect("Index.aspx?upgraded=1");
        }
    }
}
