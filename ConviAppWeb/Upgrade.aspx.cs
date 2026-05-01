using System;

namespace ConviAppWeb
{
    public partial class Upgrade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { Response.Redirect("Login.aspx"); return; }
        }

        protected void BtnPro_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtIBANPro.Text) || txtIBANPro.Text.Replace(" ", "").Length < 10)
            {
                lblErrPro.Text = "⚠️ Introduce un IBAN simulado de al menos 10 caracteres.";
                lblErrPro.Visible = true;
                return;
            }
            // Simulate plan upgrade
            Session["UserRole"] = "Profesional";
            lblErrPro.Visible = false;
            Response.Redirect("Index.aspx?upgraded=1");
        }
    }
}


