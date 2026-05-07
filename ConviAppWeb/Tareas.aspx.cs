using System;
using System.Linq;
using System.Web.UI.WebControls;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Tareas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { pnlApp.Visible = false; pnlDemo.Visible = true; return; }
            if (Session["ComunidadActivaId"] == null) { Response.Redirect("Comunidades.aspx"); return; }
            
            pnlApp.Visible = true; pnlDemo.Visible = false;
            
            if (!IsPostBack) CargarTareas();
        }

        private void CargarTareas()
        {
            int pisoId = Convert.ToInt32(Session["ComunidadActivaId"]);
            var cad = new CADTarea();
            var lista = cad.ListarTodas(pisoId); // Opcional: si ListarTodas recibe pisoId. Si no, Where(t => t.PisoId == pisoId)
            
            // Asumamos que CADTarea.ListarTodas(int?) ya filtra, si no lo haremos manual:
            if (lista.Count > 0 && lista[0].PisoId != pisoId) 
            {
                lista = lista.Where(t => t.PisoId == pisoId).ToList();
            }

            if (lista == null || lista.Count == 0)
            {
                pnlVacio.Visible = true;
                rptTareas.Visible = false;
            }
            else
            {
                pnlVacio.Visible = false;
                rptTareas.Visible = true;
                rptTareas.DataSource = lista;
                rptTareas.DataBind();
            }
        }

        protected void BtnAnadir_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTitulo.Text)) { lblError.Text = "El título es obligatorio."; lblError.Visible = true; return; }
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            int pisoId = Convert.ToInt32(Session["ComunidadActivaId"]);
            var cad = new CADTarea();
            cad.CrearTarea(new ENTarea
            {
                Titulo = txtTitulo.Text.Trim(),
                Descripcion = txtDescripcion.Text.Trim(),
                Prioridad = ddlPrioridad.SelectedValue,
                CreadaPorId = userId,
                PisoId = pisoId
            });
            txtTitulo.Text = "";
            txtDescripcion.Text = "";
            lblError.Visible = false;
            CargarTareas();
        }

        protected void RptTareas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            var cad = new CADTarea();
            if (e.CommandName == "Toggle")
                cad.ToggleEstado(id);
            else if (e.CommandName == "Eliminar")
                cad.BorrarTarea(new ENTarea { Id = id });
            CargarTareas();
        }
    }
}
