using System;
using System.Web;
using System.Web.UI;
using System.Collections.Generic;

namespace ConviAppWeb
{
    public class MockAd
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Desc { get; set; }
        public string Bg { get; set; }
    }

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
                if (Session["MockAds"] == null)
                {
                    Session["MockAds"] = new List<MockAd> {
                        new MockAd { Id = Guid.NewGuid().ToString(), Title = "Limpieza a domicilio", Desc = "Primera limpieza al 50%.", Bg = "linear-gradient(135deg,#1e3a8a,#3b82f6)" }
                    };
                }
                BindAds();
            }
        }

        private void BindAds()
        {
            var ads = Session["MockAds"] as List<MockAd>;
            rptAds.DataSource = ads;
            rptAds.DataBind();
        }

        protected void rptAds_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Guardar")
            {
                var ads = Session["MockAds"] as List<MockAd>;
                if (ads != null)
                {
                    string id = e.CommandArgument.ToString();
                    var adToEdit = ads.Find(a => a.Id == id);
                    if (adToEdit != null)
                    {
                        var txtTitulo = (System.Web.UI.WebControls.TextBox)e.Item.FindControl("txtEditTitulo");
                        var txtDesc = (System.Web.UI.WebControls.TextBox)e.Item.FindControl("txtEditDesc");
                        
                        if (txtTitulo != null) adToEdit.Title = txtTitulo.Text;
                        if (txtDesc != null) adToEdit.Desc = txtDesc.Text;
                        
                        Session["MockAds"] = ads;
                        BindAds();
                    }
                }
            }
        }
    }
}
