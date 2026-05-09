using System;
using System.Web.UI;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class VerDocumento : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (Request.QueryString["id"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                var cad = new CADDocumento();
                var doc = cad.LeerDocumento(id);
                
                if (doc != null && doc.FileData != null && doc.FileData.Length > 0)
                {
                    Response.Clear();
                    Response.ContentType = doc.ContentType ?? "application/octet-stream";
                    Response.AddHeader("Content-Disposition", "inline; filename=\"" + doc.FileName + "\"");
                    Response.BinaryWrite(doc.FileData);
                    Response.End();
                }
                else
                {
                    Response.Write("Documento no encontrado o vacío.");
                }
            }
        }
    }
}
