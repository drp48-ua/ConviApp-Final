using System;
using System.Web.UI.WebControls;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Documentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack) CargarDocumentos();
        }

        private void CargarDocumentos()
        {
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADDocumento();
            var lista = cad.ListarPorUsuario(userId);
            if (lista == null || lista.Count == 0)
            {
                pnlVacio.Visible = true;
                pnlTabla.Visible = false;
            }
            else
            {
                pnlVacio.Visible = false;
                pnlTabla.Visible = true;
                gvDocumentos.DataSource = lista;
                gvDocumentos.DataBind();
            }
        }

        protected void BtnSubir_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNombre.Text)) { lblError.Text = "El nombre es obligatorio."; lblError.Visible = true; return; }
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADDocumento();
            cad.CrearDocumento(new ENDocumento
            {
                FileName = txtNombre.Text.Trim(),
                Type = ddlTipo.SelectedValue,
                Description = txtDescripcion.Text.Trim(),
                UploadDate = DateTime.Now,
                UserId = userId,
                FileSize = 0,
                ContentType = "application/octet-stream"
            });
            txtNombre.Text = ""; txtDescripcion.Text = "";
            lblError.Visible = false;
            CargarDocumentos();
        }

        protected void GvDocumentos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var cad = new CADDocumento();
                cad.BorrarDocumento(new ENDocumento { Id = id });
                CargarDocumentos();
            }
        }
    }
}
