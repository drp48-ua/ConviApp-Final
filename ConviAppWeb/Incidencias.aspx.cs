using System;
using System.Web.UI.WebControls;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Incidencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { pnlApp.Visible = false; pnlDemo.Visible = true; return; }
            pnlApp.Visible = true; pnlDemo.Visible = false;
            if (!IsPostBack) CargarIncidencias();
        }

        private void CargarIncidencias()
        {
            var cad = new CADIncidencia();
            var lista = cad.ListarTodas();
            if (lista == null || lista.Count == 0)
            {
                pnlVacio.Visible = true;
                rptIncidencias.Visible = false;
            }
            else
            {
                pnlVacio.Visible = false;
                rptIncidencias.Visible = true;
                rptIncidencias.DataSource = lista;
                rptIncidencias.DataBind();
            }
        }

        protected void BtnReportar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTitulo.Text)) { lblError.Text = "El título es obligatorio."; lblError.Visible = true; return; }
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADIncidencia();
            cad.CrearIncidencia(new ENIncidencia
            {
                Titulo = txtTitulo.Text.Trim(),
                Descripcion = txtDescripcion.Text.Trim(),
                Estado = "abierta",
                ReportadaPorId = userId,
                FechaReporte = DateTime.Now
            });
            txtTitulo.Text = ""; txtDescripcion.Text = "";
            lblError.Visible = false;
            CargarIncidencias();
        }

        protected void RptIncidencias_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Avanzar")
            {
                var parts = e.CommandArgument.ToString().Split('|');
                int id = Convert.ToInt32(parts[0]);
                string estadoActual = parts.Length > 1 ? parts[1] : "abierta";
                string nuevoEstado = estadoActual == "abierta" ? "en_progreso" : "resuelta";
                var cad = new CADIncidencia();
                cad.ActualizarEstado(id, nuevoEstado);
                CargarIncidencias();
            }
        }
    }
}
