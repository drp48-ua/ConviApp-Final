using System;
using System.Linq;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Comunidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) 
            { 
                pnlApp.Visible = false; 
                pnlDemo.Visible = true; 
                return; 
            }
            
            pnlApp.Visible = true; 
            pnlDemo.Visible = false;
            
            if (!IsPostBack)
            {
                CargarComunidades();
            }
        }

        private void CargarComunidades()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            var cadCu = new CADComunidadUsuario();
            var misComunidades = cadCu.ObtenerComunidadesDeUsuario(userId);

            if (misComunidades == null || misComunidades.Count == 0)
            {
                pnlVacio.Visible = true;
                rptComunidades.Visible = false;
            }
            else
            {
                pnlVacio.Visible = false;
                rptComunidades.Visible = true;
                rptComunidades.DataSource = misComunidades;
                rptComunidades.DataBind();
            }
        }

        protected void btnCrearComunidad_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDireccion.Text) || string.IsNullOrWhiteSpace(txtCiudad.Text))
            {
                lblMsg.Text = "⚠️ Dirección y ciudad son obligatorias para crear una comunidad.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            int hab; decimal precio;
            int.TryParse(txtHabitaciones.Text, out hab);
            decimal.TryParse(txtPrecio.Text, out precio);

            string codigo = GenerarCodigo(8);

            var cadPiso = new CADPiso();
            int nuevoPisoId = cadPiso.CrearPiso(new ENPiso
            {
                Nombre = !string.IsNullOrWhiteSpace(txtNombreComunidad.Text) ? txtNombreComunidad.Text.Trim() : txtDireccion.Text.Trim(),
                Direccion = txtDireccion.Text.Trim(),
                Ciudad = txtCiudad.Text.Trim(),
                NumeroHabitaciones = hab > 0 ? hab : 1,
                PrecioTotal = precio,
                Descripcion = txtDescripcion.Text.Trim(),
                CodigoComunidad = codigo,
                Disponible = true,
                PropietarioId = userId
            });

            if (nuevoPisoId > 0)
            {
                var cadCu = new CADComunidadUsuario();
                cadCu.UnirUsuarioAComunidad(nuevoPisoId, userId);
                
                // Entrar directamente a la nueva comunidad
                Session["ComunidadActivaId"] = nuevoPisoId;
                Session["ComunidadActivaNombre"] = !string.IsNullOrWhiteSpace(txtNombreComunidad.Text) ? txtNombreComunidad.Text.Trim() : txtDireccion.Text.Trim();
                
                Response.Redirect("Comunidades.aspx");
            }
            else
            {
                lblMsg.Text = "❌ Hubo un error al crear la comunidad.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }

        protected void btnUnirse_Click(object sender, EventArgs e)
        {
            string codigo = txtCodigoUnir.Text.Trim().ToUpper();
            if (string.IsNullOrWhiteSpace(codigo) || codigo.Length != 8)
            {
                lblMsg.Text = "⚠️ Debes ingresar un código válido de 8 caracteres.";
                lblMsg.CssClass = "alert alert-warning";
                lblMsg.Visible = true;
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            var cadCu = new CADComunidadUsuario();
            var piso = cadCu.BuscarComunidadPorCodigo(codigo);

            if (piso != null)
            {
                // Validación de capacidad máxima
                var miembros = cadCu.ObtenerUsuariosDeComunidad(piso.Id);
                if (miembros.Count >= piso.NumeroHabitaciones)
                {
                    lblMsg.Text = $"⚠️ La comunidad ya ha alcanzado su límite máximo de inquilinos ({piso.NumeroHabitaciones} habitaciones).";
                    lblMsg.CssClass = "alert alert-danger";
                    lblMsg.Visible = true;
                    return;
                }

                bool unido = cadCu.UnirUsuarioAComunidad(piso.Id, userId);
                if (unido)
                {
                    // Auto-ascender a Profesional si es comunidad privada y el usuario es Básico
                    if (piso.EsPrivado && Session["UserRole"] != null && Session["UserRole"].ToString() == "Basico")
                    {
                        var cadU = new CADUsuario();
                        var usuario = cadU.LeerUsuario(userId);
                        if (usuario != null)
                        {
                            usuario.Rol = new ENRol { Nombre = "Profesional" };
                            cadU.ActualizarUsuario(usuario);
                            Session["UserRole"] = "Profesional";
                        }
                    }

                    lblMsg.Text = "✅ ¡Te has unido a la comunidad en " + piso.Direccion + "!";
                    lblMsg.CssClass = "alert alert-success";
                    lblMsg.Visible = true;
                    txtCodigoUnir.Text = "";
                    CargarComunidades();
                }
                else
                {
                    lblMsg.Text = "⚠️ Ya eres miembro de esta comunidad o hubo un error.";
                    lblMsg.CssClass = "alert alert-warning";
                    lblMsg.Visible = true;
                }
            }
            else
            {
                lblMsg.Text = "❌ No se encontró ninguna comunidad con ese código.";
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Visible = true;
            }
        }

        protected void rptComunidades_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Entrar")
            {
                int pisoId = Convert.ToInt32(e.CommandArgument);
                string nombre = e.CommandArgument.ToString();

                var cadPiso = new CADPiso();
                var piso = cadPiso.LeerPiso(pisoId);
                if (piso != null)
                {
                    nombre = !string.IsNullOrWhiteSpace(piso.Nombre) ? piso.Nombre : piso.Direccion;
                    if (piso.EsPrivado)
                    {
                        if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Basico")
                        {
                            Session["OriginalUserRole"] = "Basico";
                            Session["UserRole"] = "Profesional";
                        }
                    }
                }

                Session["ComunidadActivaId"] = pisoId;
                Session["ComunidadActivaNombre"] = nombre;
                Response.Redirect("Index.aspx");
            }
            else if (e.CommandName == "Expulsar")
            {
                string[] args = e.CommandArgument.ToString().Split('_');
                if (args.Length == 2)
                {
                    int pId = Convert.ToInt32(args[0]);
                    int uId = Convert.ToInt32(args[1]);

                    var cadCu = new CADComunidadUsuario();
                    bool exito = cadCu.ExpulsarUsuario(pId, uId);

                    if (exito)
                    {
                        // Obtener nombre de la comunidad para la notificacion
                        var cadPiso = new CADPiso();
                        var piso = cadPiso.LeerPiso(pId);
                        string nombreComunidad = piso != null ? (!string.IsNullOrWhiteSpace(piso.Nombre) ? piso.Nombre : piso.Direccion) : "la comunidad";

                        // Enviar notificacion al usuario expulsado
                        var cadNot = new CADNotificacion();
                        cadNot.CrearNotificacion(new ENNotificacion
                        {
                            Titulo = "Has sido expulsado de una comunidad",
                            Mensaje = "El administrador de \"" + nombreComunidad + "\" te ha expulsado de la comunidad.",
                            Tipo = "expulsion",
                            Leida = false,
                            FechaCreacion = DateTime.Now,
                            UsuarioId = uId
                        });

                        lblMsg.Text = "✅ Usuario expulsado correctamente.";
                        lblMsg.CssClass = "alert alert-success";
                        lblMsg.Visible = true;
                    }
                    else
                    {
                        lblMsg.Text = "❌ No se pudo expulsar al usuario.";
                        lblMsg.CssClass = "alert alert-danger";
                        lblMsg.Visible = true;
                    }

                    CargarComunidades();
                }
            }
        }

        protected void rptComunidades_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == System.Web.UI.WebControls.ListItemType.Item || e.Item.ItemType == System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                var piso = (ENPiso)e.Item.DataItem;
                var rptMiembros = (System.Web.UI.WebControls.Repeater)e.Item.FindControl("rptMiembros");
                
                if (rptMiembros != null)
                {
                    var cadCu = new CADComunidadUsuario();
                    var miembros = cadCu.ObtenerUsuariosDeComunidad(piso.Id);
                    rptMiembros.DataSource = miembros;
                    rptMiembros.DataBind();
                    
                    // Solo mostrar botón de eliminar si soy el creador de la comunidad
                    int currentUserId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
                    bool soyCreador = (piso.PropietarioId == currentUserId);

                    foreach (System.Web.UI.WebControls.RepeaterItem item in rptMiembros.Items)
                    {
                        var btnExpulsar = (System.Web.UI.WebControls.LinkButton)item.FindControl("btnExpulsar");
                        // Extraemos el ID del usuario de CommandArgument "pisoId_usuarioId"
                        string[] args = btnExpulsar.CommandArgument.Split('_');
                        int userIdDelMiembro = Convert.ToInt32(args[1]);

                        // Mostramos el botón solo si soy creador y el miembro no soy yo mismo
                        if (soyCreador && userIdDelMiembro != currentUserId)
                        {
                            btnExpulsar.Visible = true;
                        }
                    }
                }
            }
        }

        protected void rptMiembros_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Expulsar")
            {
                string[] args = e.CommandArgument.ToString().Split('_');
                if (args.Length == 2)
                {
                    int pId = Convert.ToInt32(args[0]);
                    int uId = Convert.ToInt32(args[1]);

                    var cadCu = new CADComunidadUsuario();
                    bool exito = cadCu.ExpulsarUsuario(pId, uId);

                    if (exito)
                    {
                        var cadPiso = new CADPiso();
                        var piso = cadPiso.LeerPiso(pId);
                        string nombreComunidad = piso != null ? (!string.IsNullOrWhiteSpace(piso.Nombre) ? piso.Nombre : piso.Direccion) : "la comunidad";

                        var cadNot = new CADNotificacion();
                        cadNot.CrearNotificacion(new ENNotificacion
                        {
                            Titulo = "Has sido expulsado de una comunidad",
                            Mensaje = "El administrador de \"" + nombreComunidad + "\" te ha expulsado de la comunidad.",
                            Tipo = "expulsion",
                            Leida = false,
                            FechaCreacion = DateTime.Now,
                            UsuarioId = uId
                        });

                        lblMsg.Text = "✅ Usuario expulsado correctamente.";
                        lblMsg.CssClass = "alert alert-success";
                        lblMsg.Visible = true;
                        CargarComunidades();
                    }
                    else
                    {
                        lblMsg.Text = "❌ No se pudo expulsar al usuario.";
                        lblMsg.CssClass = "alert alert-danger";
                        lblMsg.Visible = true;
                    }
                }
            }
        }

        private string GenerarCodigo(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}
