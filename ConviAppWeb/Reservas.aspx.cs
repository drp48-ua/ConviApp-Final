using System;
using System.Web.UI.WebControls;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Reservas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { pnlApp.Visible = false; pnlDemo.Visible = true; return; }
            pnlApp.Visible = true; pnlDemo.Visible = false;
            
            if (!IsPostBack) CargarReservas();
        }

        private void CargarReservas()
        {
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADReserva();
            var lista = cad.ListarTodas(userId);
            if (lista == null || lista.Count == 0)
            {
                pnlVacio.Visible = true;
                rptReservas.Visible = false;
            }
            else
            {
                pnlVacio.Visible = false;
                rptReservas.Visible = true;
                rptReservas.DataSource = lista;
                rptReservas.DataBind();
            }
        }

        protected void BtnReservar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtMotivo.Text) || string.IsNullOrWhiteSpace(txtFechaInicio.Text) || string.IsNullOrWhiteSpace(txtFechaFin.Text))
            { lblError.Text = "Rellena todos los campos."; lblError.Visible = true; return; }

            DateTime inicio, fin;
            if (!DateTime.TryParse(txtFechaInicio.Text, out inicio) || !DateTime.TryParse(txtFechaFin.Text, out fin))
            { lblError.Text = "Fechas inválidas."; lblError.Visible = true; return; }

            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADReserva();
            cad.CrearReserva(new ENReserva
            {
                Motivo = txtMotivo.Text.Trim(),
                FechaInicio = inicio,
                FechaFin = fin,
                Estado = "confirmada",
                UsuarioId = userId,
                ZonaComunId = 1
            });
            txtMotivo.Text = ""; txtFechaInicio.Text = ""; txtFechaFin.Text = "";
            lblError.Visible = false;
            CargarReservas();
        }

        protected void RptReservas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Cancelar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var cad = new CADReserva();
                cad.CancelarReserva(new ENReserva { Id = id });
                CargarReservas();
            }
        }
    }
}


