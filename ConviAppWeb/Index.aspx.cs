using System;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserEmail"] != null)
                {
                    pnlPublico.Visible = false;
                    pnlDashboard.Visible = true;

                    var cadPiso = new CADPiso();
                    lblNumPisos.Text = cadPiso.ListarTodos().Count.ToString();

                    var cadGasto = new CADGasto();
                    decimal total = 0m;
                    foreach (var g in cadGasto.ListarTodos()) total += g.Importe;
                    lblTotalGastos.Text = total.ToString("0.00") + " €";

                    var cadTarea = new CADTarea();
                    lblNumTareas.Text = cadTarea.ListarTodas().Count.ToString();
                }
                else
                {
                    pnlPublico.Visible = true;
                    pnlDashboard.Visible = false;
                }
            }
        }
    }
}
