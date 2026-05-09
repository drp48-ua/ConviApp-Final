using System;
using System.Linq;
using System.Web.UI.WebControls;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class ContratosYPagos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) { pnlApp.Visible = false; pnlDemo.Visible = true; return; }
            if (Session["ComunidadActivaId"] == null) { Response.Redirect("Comunidades.aspx"); return; }
            
            pnlApp.Visible = true; pnlDemo.Visible = false;
            
            if (!IsPostBack) {
                CargarDatos();
            }
        }

        private void CargarDatos()
        {
            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            int pisoId = Convert.ToInt32(Session["ComunidadActivaId"]);

            var cadC = new CADContrato();
            var contratos = cadC.ListarTodos(userId).Where(c => c.PropertyId == pisoId).ToList();

            bool tieneContratos = contratos != null && contratos.Count > 0;
            pnlVacioContratos.Visible = !tieneContratos;
            hContratos.Visible = tieneContratos;
            rptContratos.Visible = tieneContratos;

            if (tieneContratos)
            {
                rptContratos.DataSource = contratos;
                rptContratos.DataBind();
            }

            // Load all payments (no userId filter on CADPago — filter by user's contracts)
            var cadP = new CADPago();
            var pagos = cadP.ListarTodos(); // no filter — shows all user's payments via join on contracts
            bool tienePagos = pagos != null && pagos.Count > 0;
            hPagos.Visible = tienePagos;
            pnlPagos.Visible = tienePagos;
            if (tienePagos) { gvPagos.DataSource = pagos; gvPagos.DataBind(); }
        }

        protected void BtnCrear_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtFechaInicio.Text) || string.IsNullOrWhiteSpace(txtFechaFin.Text) || string.IsNullOrWhiteSpace(txtRenta.Text))
            { lblError.Text = "Rellena todos los campos obligatorios."; lblError.Visible = true; return; }

            DateTime inicio, fin;
            decimal renta, fianza;
            if (!DateTime.TryParse(txtFechaInicio.Text, out inicio) || !DateTime.TryParse(txtFechaFin.Text, out fin))
            { lblError.Text = "Fechas inválidas."; lblError.Visible = true; return; }
            decimal.TryParse(txtRenta.Text, out renta);
            decimal.TryParse(txtFianza.Text, out fianza);

            var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
            var cad = new CADContrato();
            try
            {
                bool result = cad.CrearContrato(new ENContrato
                {
                    Type = ddlTipo.SelectedValue,
                    StartDate = inicio,
                    EndDate = fin,
                    MonthlyRent = renta,
                    DepositAmount = fianza,
                    Status = "activo",
                    UserId = userId,
                    PropertyId = Convert.ToInt32(Session["ComunidadActivaId"])
                });
                
                if (!result) throw new Exception("Error al insertar el contrato en la base de datos.");

                // Guardar como documento si hay archivo
                if (fuContratoPDF.HasFile)
                {
                    var cadDoc = new CADDocumento();
                    cadDoc.CrearDocumento(new ENDocumento
                    {
                        FileName = fuContratoPDF.FileName,
                        FileData = fuContratoPDF.FileBytes,
                        ContentType = fuContratoPDF.PostedFile.ContentType,
                        FileSize = fuContratoPDF.PostedFile.ContentLength,
                        Type = "contrato",
                        Description = "Contrato de " + ddlTipo.SelectedItem.Text + " - Autogenerado",
                        UploadDate = DateTime.Now,
                        UserId = userId,
                        PropertyId = Convert.ToInt32(Session["ComunidadActivaId"])
                    });
                }
                
                txtFechaInicio.Text = ""; txtFechaFin.Text = ""; txtRenta.Text = ""; txtFianza.Text = "";
                lblError.Visible = false;
                CargarDatos();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error BD: " + ex.Message;
                lblError.Visible = true;
            }
        }

        protected void RptContratos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var cad = new CADContrato();
                cad.BorrarContrato(new ENContrato { Id = id });
                CargarDatos();
            }
            else if (e.CommandName == "Ver")
            {
                int contratoId = Convert.ToInt32(e.CommandArgument);
                var userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
                var cadDoc = new CADDocumento();
                var docs = cadDoc.ListarPorUsuario(userId);
                // Find the most recent doc of type "contrato" linked to this property
                var doc = docs != null ? docs.Find(d => d.Type == "contrato") : null;
                if (doc != null)
                    Response.Redirect("VerDocumento.aspx?id=" + doc.Id);
                else
                {
                    lblError.Text = "No hay PDF adjunto para este contrato.";
                    lblError.Visible = true;
                }
            }
        }
    }
}
