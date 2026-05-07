using System;
using System.Web;
using System.Web.UI;
using System.Collections.Generic;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class AdminPublicidad : Page
    {
        protected global::System.Web.UI.WebControls.Repeater rptAds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                BindAds();
            }
        }

        private void BindAds()
        {
            var cad = new CADAnuncio();
            var ads = cad.ListarTodos();
            rptAds.DataSource = ads;
            rptAds.DataBind();
        }

        protected void rptAds_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Guardar")
            {
                var cad = new CADAnuncio();
                string idStr = e.CommandArgument.ToString();
                
                var txtTitulo = (System.Web.UI.WebControls.TextBox)e.Item.FindControl("txtEditTitulo");
                var txtDesc = (System.Web.UI.WebControls.TextBox)e.Item.FindControl("txtEditDesc");
                var txtImg = (System.Web.UI.WebControls.TextBox)e.Item.FindControl("txtEditImg");
                
                if (txtTitulo != null && txtDesc != null && txtImg != null)
                {
                    cad.Actualizar(new ENAnuncio {
                        Id = Convert.ToInt32(idStr),
                        Titulo = txtTitulo.Text.Trim(),
                        Subtitulo = txtDesc.Text.Trim(),
                        ImagenUrl = txtImg.Text.Trim()
                    });
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Anuncio guardado con éxito.');", true);
                    BindAds();
                }
            }
        }
    }
}
