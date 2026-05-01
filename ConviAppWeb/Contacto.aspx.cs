using System;

namespace ConviAppWeb
{
    public partial class Contacto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void BtnEnviar_Click(object sender, EventArgs e)
        {
            // In a real app, this would send an email. Here we just show confirmation.
            pnlForm.Visible = false;
            pnlConfirmacion.Visible = true;
        }
    }
}


