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
            
            // Restore Original Role if it was modified dynamically
            if (Session["OriginalUserRole"] != null)
            {
                Session["UserRole"] = Session["OriginalUserRole"];
                Session.Remove("OriginalUserRole");
            }
            
            Response.Redirect("Comunidades.aspx");
        }
    }
}
