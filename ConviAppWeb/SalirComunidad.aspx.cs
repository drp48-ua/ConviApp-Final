using System;
using System.Web.UI;

namespace ConviAppWeb
{
    public partial class SalirComunidad : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("ComunidadActivaId");
            Session.Remove("ComunidadActivaNombre");
            Response.Redirect("Comunidades.aspx");
        }
    }
}
