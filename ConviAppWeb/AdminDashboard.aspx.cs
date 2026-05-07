using System;
using System.Web;
using System.Web.UI;
using System.Linq;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class AdminDashboard : Page
    {
        protected global::System.Web.UI.WebControls.Label lblTotalUsuarios;
        protected global::System.Web.UI.WebControls.Label lblTotalPisos;
        protected global::System.Web.UI.WebControls.Label lblTotalIncidencias;
        protected global::System.Web.UI.WebControls.Label lblIngresos;
        protected global::System.Web.UI.WebControls.Label lblTopPiso;
        protected global::System.Web.UI.WebControls.Label lblTopCliente;
        protected global::System.Web.UI.WebControls.Label lblBottomCliente;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                var cadU = new CADUsuario();
                lblTotalUsuarios.Text = cadU.ObtenerTotal().ToString();

                var cadP = new CADPiso();
                lblTotalPisos.Text = cadP.ObtenerTotal().ToString();

                var cadI = new CADIncidencia();
                lblTotalIncidencias.Text = cadI.ObtenerTotalAbiertas().ToString();

                var cadC = new CADContrato();
                var contratos = cadC.ListarTodos();
                
                decimal ingresosTotales = contratos.Sum(c => c.TotalContractValue());
                lblIngresos.Text = ingresosTotales.ToString("C");

                if (contratos.Any())
                {
                    var topPisoGroup = contratos.GroupBy(c => c.PropertyId).OrderByDescending(g => g.Count()).FirstOrDefault();
                    if (topPisoGroup != null)
                    {
                        var piso = cadP.LeerPiso(topPisoGroup.Key);
                        lblTopPiso.Text = piso != null ? $"Piso #{piso.Id} ({topPisoGroup.Count()} contratos)" : $"Piso #{topPisoGroup.Key}";
                    }

                    var clientesPorRentabilidad = contratos.GroupBy(c => c.UserId)
                        .Select(g => new { UserId = g.Key, TotalInvertido = g.Sum(c => c.TotalContractValue()) })
                        .OrderByDescending(x => x.TotalInvertido).ToList();

                    if (clientesPorRentabilidad.Any())
                    {
                        var topCliente = clientesPorRentabilidad.First();
                        var bottomCliente = clientesPorRentabilidad.Last();

                        var uTop = cadU.LeerUsuario(topCliente.UserId);
                        var uBottom = cadU.LeerUsuario(bottomCliente.UserId);

                        lblTopCliente.Text = uTop != null ? $"{uTop.Email} ({topCliente.TotalInvertido:C})" : $"UID: {topCliente.UserId}";
                        lblBottomCliente.Text = uBottom != null ? $"{uBottom.Email} ({bottomCliente.TotalInvertido:C})" : $"UID: {bottomCliente.UserId}";
                    }
                }
            }
        }
    }
}
