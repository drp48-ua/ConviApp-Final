using System;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Pisos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack) CargarPisos();
        }

        private void CargarPisos()
        {
            var cad = new CADPiso();
            gvPisos.DataSource = cad.ListarTodos();
            gvPisos.DataBind();
        }

        protected void BtnNuevo_Click(object sender, EventArgs e) { pnlForm.Visible = true; }
        
        protected void BtnCancelar_Click(object sender, EventArgs e) { pnlForm.Visible = false; }
        
        protected void BtnGuardar_Click(object sender, EventArgs e)
        {
            var p = new ENPiso { Direccion = txtDir.Text, Ciudad = txtCiudad.Text };
            var cad = new CADPiso();
            cad.CrearPiso(p);
            pnlForm.Visible = false;
            CargarPisos();
        }
    }
}
