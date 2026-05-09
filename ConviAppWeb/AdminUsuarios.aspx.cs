using System;
using System.Web;
using System.Web.UI;
using ConviAppWeb.DataAccess;

namespace ConviAppWeb
{
    public partial class AdminUsuarios : Page
    {
        protected global::System.Web.UI.WebControls.Repeater rptUsuarios;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString().ToLower().Trim() != "admin@conviapp.com")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        private void CargarUsuarios()
        {
            var cad = new CADUsuario();
            rptUsuarios.DataSource = cad.ObtenerTodos();
            rptUsuarios.DataBind();
        }

        protected void rptUsuarios_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var cad = new CADUsuario();
                cad.BorrarUsuario(new ConviAppWeb.Models.ENUsuario { Id = id });
                CargarUsuarios();
            }
            else if (e.CommandName == "Editar")
            {
                var pnlViewRole = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlViewRole");
                var pnlEditRole = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlEditRole");
                if (pnlViewRole != null && pnlEditRole != null)
                {
                    pnlViewRole.Visible = false;
                    pnlEditRole.Visible = true;
                }
            }
            else if (e.CommandName == "GuardarRol")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var ddlRol = (System.Web.UI.WebControls.DropDownList)e.Item.FindControl("ddlRol");
                if (ddlRol != null)
                {
                    var cad = new CADUsuario();
                    var usuario = cad.LeerUsuario(id);
                    if (usuario != null)
                    {
                        usuario.Rol = new ConviAppWeb.Models.ENRol { Nombre = ddlRol.SelectedValue };
                        cad.ActualizarUsuario(usuario);
                        CargarUsuarios();
                    }
                }
            }
        }

        protected void rptUsuarios_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == System.Web.UI.WebControls.ListItemType.Item || e.Item.ItemType == System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                var usuario = (ConviAppWeb.Models.ENUsuario)e.Item.DataItem;
                var ddlRol = (System.Web.UI.WebControls.DropDownList)e.Item.FindControl("ddlRol");
                if (ddlRol != null && usuario.Rol != null)
                {
                    ddlRol.SelectedValue = usuario.Rol.Nombre;
                }

                var lblNumPisos = (System.Web.UI.WebControls.Label)e.Item.FindControl("lblNumPisos");
                if (lblNumPisos != null)
                {
                    var cadP = new CADPiso();
                    lblNumPisos.Text = cadP.ContarPisosDeUsuario(usuario.Id).ToString();
                }
            }
        }
    }
}
