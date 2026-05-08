using System;
using System.Collections.Generic;
using System.Web.UI;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Foro : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) return;
            if (!IsPostBack)
            {
                CargarChats();
                CargarUsuarios(null);
            }
        }

        private void CargarChats()
        {
            int myId = Convert.ToInt32(Session["UserId"]);
            var cadM = new CADMensaje();
            var cadU = new CADUsuario();
            var cadS = new CADChatSilenciado();

            var interlocutores = cadM.ListarInterlocutores(myId);
            var items = new List<object>();

            foreach (int uid in interlocutores)
            {
                var u = cadU.LeerUsuario(uid);
                if (u == null) continue;
                var ultimo = cadM.UltimoMensaje(myId, uid);
                int noLeidos = 0;
                if (ultimo != null)
                {
                    // Count unread from this person
                    var conv = cadM.ListarConversacion(myId, uid);
                    foreach (var m in conv)
                        if (m.ReceptorId == myId && !m.Leido) noLeidos++;
                }
                items.Add(new {
                    Id = u.Id,
                    Nombre = u.Nombre,
                    Email = u.Email,
                    UltimoMsg = ultimo != null ? (ultimo.Contenido.Length > 40 ? ultimo.Contenido.Substring(0, 40) + "…" : ultimo.Contenido) : "",
                    NoLeidos = noLeidos,
                    Silenciado = cadS.EstaSilenciado(myId, uid)
                });
            }

            rptChats.DataSource = items;
            rptChats.DataBind();
            lblSinChats.Visible = items.Count == 0;
        }

        private void CargarUsuarios(string filtro)
        {
            int myId = Convert.ToInt32(Session["UserId"]);
            var cadU = new CADUsuario();
            var todos = cadU.ObtenerTodos();

            var lista = new List<ENUsuario>();
            foreach (var u in todos)
            {
                if (u.Id == myId) continue;
                if (!string.IsNullOrWhiteSpace(filtro))
                {
                    string f = filtro.Trim().ToLower();
                    if (!u.Nombre.ToLower().Contains(f) && !u.Email.ToLower().Contains(f)) continue;
                }
                lista.Add(u);
            }

            rptUsuarios.DataSource = lista;
            rptUsuarios.DataBind();
            lblSinResultados.Visible = lista.Count == 0 && !string.IsNullOrWhiteSpace(filtro);
        }

        protected void BtnBuscar_Click(object sender, EventArgs e)
        {
            CargarChats();
            CargarUsuarios(txtBuscar.Text);
        }
    }
}
