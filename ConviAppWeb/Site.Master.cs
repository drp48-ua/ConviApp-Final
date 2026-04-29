using System;
using System.Web.UI;

namespace ConviAppWeb
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Index.aspx");
        }
    }
}

