using System;
using System.Collections.Generic;
using System.Linq;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public class MensajeVM
    {
        public int Id { get; set; }
        public string Contenido { get; set; }
        public DateTime FechaEnvio { get; set; }
        public int EmisorId { get; set; }
        public bool EsMio { get; set; }
    }

    public partial class Mensajes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { pnlApp.Visible = false; pnlDemo.Visible = true; return; }
            pnlApp.Visible = true; pnlDemo.Visible = false;
            if (!IsPostBack) CargarMensajes();
        }

        private void CargarMensajes()
        {
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADMensaje();
            var raw = cad.ListarTodos().Where(m => m.EmisorId == userId || m.ReceptorId == userId).ToList();
            var lista = new List<MensajeVM>();
            foreach (var m in raw)
                lista.Add(new MensajeVM { Id = m.Id, Contenido = m.Contenido, FechaEnvio = m.FechaEnvio, EmisorId = m.EmisorId, EsMio = m.EmisorId == userId });

            if (lista.Count == 0)
            {
                pnlVacio.Visible = true;
                rptMensajes.Visible = false;
            }
            else
            {
                pnlVacio.Visible = false;
                rptMensajes.Visible = true;
                rptMensajes.DataSource = lista;
                rptMensajes.DataBind();
            }
        }

        protected void BtnEnviar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtMensaje.Text)) return;
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADMensaje();
            cad.CrearMensaje(new ENMensaje { Contenido = txtMensaje.Text.Trim(), EmisorId = userId, FechaEnvio = DateTime.Now });
            txtMensaje.Text = "";
            CargarMensajes();
        }
    }
}
