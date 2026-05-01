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
        protected global::System.Web.UI.WebControls.TextBox txtTitulo;
        protected global::System.Web.UI.WebControls.TextBox txtDesc;
        protected global::System.Web.UI.WebControls.Button btnAddAd;

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

        protected void btnAddAd_Click(object sender, EventArgs e)
        {
            var ads = Session["MockAds"] as List<MockAd>;
            if (ads == null) ads = new List<MockAd>();

            ads.Add(new MockAd {
                Id = Guid.NewGuid().ToString(),
                Title = txtTitulo.Text,
                Desc = txtDesc.Text,
                Bg = "linear-gradient(135deg,#10b981,#059669)" // default green
            });

            Session["MockAds"] = ads;
            txtTitulo.Text = "";
            txtDesc.Text = "";
            BindAds();
        }

        protected void btnDeleteAd_Command(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            var ads = Session["MockAds"] as List<MockAd>;
            if (ads != null)
            {
                ads.RemoveAll(a => a.Id == e.CommandArgument.ToString());
                Session["MockAds"] = ads;
                BindAds();
            }
        }
    }
}


