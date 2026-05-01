using System;
using System.Linq;
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
            var filtrados = cad.ListarTodos();
            
            if(!string.IsNullOrWhiteSpace(txtFiltroCiudad.Text)) {
                filtrados = filtrados.Where(p => p.Ciudad != null && p.Ciudad.IndexOf(txtFiltroCiudad.Text, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            }
            decimal mn;
            if(decimal.TryParse(txtFiltroMin.Text, out mn)) {
                filtrados = filtrados.Where(p => p.PrecioTotal >= mn).ToList();
            }
            decimal mx;
            if(decimal.TryParse(txtFiltroMax.Text, out mx)) {
                filtrados = filtrados.Where(p => p.PrecioTotal <= mx).ToList();
            }
            
            pnlVacio.Visible = filtrados.Count == 0;
            lblSumaPisos.Text = filtrados.Count.ToString();
            
            rptPisos.DataSource = filtrados;
            rptPisos.DataBind();
        }

        protected void BtnNuevo_Click(object sender, EventArgs e) { pnlForm.Visible = true; }
        
        protected void BtnCancelar_Click(object sender, EventArgs e) { pnlForm.Visible = false; }
        
        protected void BtnGuardar_Click(object sender, EventArgs e)
        {
            if(!string.IsNullOrWhiteSpace(txtDir.Text)) {
                var p = new ENPiso { Direccion = txtDir.Text, Ciudad = txtCiudad.Text, PrecioTotal = 350.00m, NumeroHabitaciones = 4, Disponible = true };
                var cad = new CADPiso();
                cad.CrearPiso(p);
                txtDir.Text = ""; txtCiudad.Text = "";
                pnlForm.Visible = false;
                CargarPisos();
            }
        }
        
        protected void BtnBuscar_Click(object sender, EventArgs e)
        {
            CargarPisos();
        }
    }
}
