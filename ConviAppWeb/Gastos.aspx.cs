using System;
using System.Web.UI.WebControls;
using System.Linq;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Gastos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { pnlApp.Visible = false; pnlDemo.Visible = true; return; }
            pnlApp.Visible = true; pnlDemo.Visible = false;
            if (!IsPostBack) CargarGastos();
        }

        private void CargarGastos()
        {
            var cad = new CADGasto();
            var lista = cad.ListarTodos();
            
            pnlVacio.Visible = lista.Count == 0;
            pnlTabla.Visible = lista.Count > 0;
            
            rptGastos.DataSource = lista;
            rptGastos.DataBind();
            
            decimal total = lista.Sum(g => g.Importe);
            lblTotal.Text = total.ToString("0.00") + " €";
        }
        
        protected void BtnGuardar_Click(object sender, EventArgs e)
        {
            decimal imp;
            decimal.TryParse(txtImporte.Text, out imp);
            if(imp > 0 && !string.IsNullOrWhiteSpace(txtConcepto.Text)) {
                var cad = new CADGasto();
                cad.CrearGasto(new ENGasto { Concepto = txtConcepto.Text, Importe = imp, Fecha = DateTime.Today, Pagado = false });
                txtConcepto.Text = "";
                txtImporte.Text = "";
                CargarGastos();
            }
        }
        
        protected void RptGastos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int id = int.Parse(e.CommandArgument.ToString());
                new CADGasto().BorrarGasto(new ENGasto { Id = id });
                CargarGastos();
            }
        }
    }
}
