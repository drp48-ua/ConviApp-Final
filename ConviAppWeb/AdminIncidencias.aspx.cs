using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class AdminIncidencias : Page
    {
        protected global::System.Web.UI.WebControls.Repeater rptIncidencias;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                CargarIncidencias();
            }
        }

        private void CargarIncidencias()
        {
            var cadI = new CADIncidencia();
            rptIncidencias.DataSource = cadI.ListarTodas().OrderByDescending(i => i.Id).ToList();
            rptIncidencias.DataBind();
        }

        protected void rptIncidencias_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var cadI = new CADIncidencia();
            
            if (e.CommandName == "Cerrar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                cadI.ActualizarEstado(id, "Resuelta");
                CargarIncidencias();
            }
            else if (e.CommandName == "Contactar")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int incidenciaId = Convert.ToInt32(args[0]);
                int userId = Convert.ToInt32(args[1]);

                TextBox txtRespuesta = (TextBox)e.Item.FindControl("txtRespuesta");
                string mensaje = txtRespuesta.Text.Trim();

                if (!string.IsNullOrEmpty(mensaje))
                {
                    int adminId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 1; // 1 as fallback for admin

                    var cadM = new CADMensaje();
                    cadM.CrearMensaje(new ENMensaje
                    {
                        EmisorId = adminId,
                        ReceptorId = userId,
                        Contenido = $"[Incidencia #{incidenciaId} Admin]: " + mensaje,
                        FechaEnvio = DateTime.Now
                    });

                    // También se podría insertar en notificaciones si existiera un campo específico
                    var cadN = new CADNotificacion();
                    cadN.CrearNotificacion(new ENNotificacion
                    {
                        UsuarioId = userId,
                        Titulo = "Mensaje del Administrador",
                        Mensaje = $"Tienes un nuevo mensaje del Administrador sobre la incidencia #{incidenciaId}.",
                        FechaCreacion = DateTime.Now,
                        Leida = false,
                        Tipo = "Sistema"
                    });

                    txtRespuesta.Text = "";
                    
                    // Alerta simple a traves de script
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mensaje enviado al usuario exitosamente.');", true);
                }
            }
        }
    }
}
