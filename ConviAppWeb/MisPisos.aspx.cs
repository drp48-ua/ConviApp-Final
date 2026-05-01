using System;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class MisPisos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { pnlApp.Visible = false; pnlDemo.Visible = true; return; }
            pnlApp.Visible = true; pnlDemo.Visible = false;
            
            if (!IsPostBack)
                CargarPisos();
        }

        private void CargarPisos()
        {
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADPiso();
            var lista = cad.ListarTodos();
            if (lista == null || lista.Count == 0)
            {
                pnlVacio.Visible = true;
                rptPisos.Visible = false;
            }
            else
            {
                pnlVacio.Visible = false;
                rptPisos.Visible = true;
                rptPisos.DataSource = lista;
                rptPisos.DataBind();
            }
        }

        protected void BtnAnadir_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDireccion.Text) || string.IsNullOrWhiteSpace(txtCiudad.Text))
            { lblMsg.Text = "⚠️ Dirección y ciudad son obligatorios."; lblMsg.Visible = true; return; }

            int hab; decimal precio;
            int.TryParse(txtHabitaciones.Text, out hab);
            decimal.TryParse(txtPrecio.Text, out precio);

            var cad = new CADPiso();
            cad.CrearPiso(new ENPiso
            {
                Direccion = txtDireccion.Text.Trim(),
                Ciudad = txtCiudad.Text.Trim(),
                NumeroHabitaciones = hab > 0 ? hab : 1,
                PrecioTotal = precio
            });
            txtDireccion.Text = ""; txtCiudad.Text = ""; txtHabitaciones.Text = ""; txtPrecio.Text = "";
            lblMsg.Visible = false;
            CargarPisos();
        }
    }
}
