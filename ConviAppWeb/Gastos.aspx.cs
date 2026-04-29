using System;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Gastos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack) CargarGastos();
        }

        private void CargarGastos()
        {
            var cad = new CADGasto();
            gvGastos.DataSource = cad.ListarTodos();
            gvGastos.DataBind();
        }
        
        protected void BtnGuardar_Click(object sender, EventArgs e)
        {
            decimal imp;
            decimal.TryParse(txtImporte.Text, out imp);
            var cad = new CADGasto();
            cad.CrearGasto(new ENGasto { Concepto = txtConcepto.Text, Importe = imp, Fecha = DateTime.Today });
            CargarGastos();
        }
    }
}

