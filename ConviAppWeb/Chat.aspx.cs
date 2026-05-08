using System;
using System.Web.UI;
using ConviAppWeb.DataAccess;
using ConviAppWeb.Models;

namespace ConviAppWeb
{
    public partial class Chat : Page
    {
        private int _myId;
        private int _otherId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) { Response.Redirect("Login.aspx"); return; }
            _myId = Convert.ToInt32(Session["UserId"]);

            string conStr = Request.QueryString["con"];
            if (string.IsNullOrWhiteSpace(conStr) || !int.TryParse(conStr, out _otherId) || _otherId == _myId)
            {
                pnlNotFound.Visible = true; pnlChat.Visible = false; return;
            }

            var cadU = new CADUsuario();
            var otro = cadU.LeerUsuario(_otherId);
            if (otro == null) { pnlNotFound.Visible = true; pnlChat.Visible = false; return; }

            pnlNotFound.Visible = false;
            pnlChat.Visible = true;

            // Header
            lblNombreOtro.Text = otro.Nombre;
            lblEmailOtro.Text = otro.Email;
            lblAvatarLetter.Text = otro.Nombre.Length > 0 ? otro.Nombre[0].ToString().ToUpper() : "?";

            // Estado bloqueo/silencio
            var cadB = new CADChatBloqueo();
            var cadS = new CADChatSilenciado();
            bool bloqueado = cadB.EstaBloqueado(_myId, _otherId);
            bool silenciado = cadS.EstaSilenciado(_myId, _otherId);

            pnlBloqueado.Visible = bloqueado;
            pnlSilenciado.Visible = silenciado && !bloqueado;
            btnEnviar.Enabled = !bloqueado;
            txtMensaje.Enabled = !bloqueado;

            // Botón toggle silencio
            btnSilenciar.Text = silenciado ? "🔔 Activar notificaciones" : "🔕 Silenciar";
            // Botón toggle bloqueo
            btnBloquear.Text = bloqueado ? "✅ Desbloquear" : "🚫 Bloquear";

            // Cargar mensajes y marcar como leídos
            var cadM = new CADMensaje();
            cadM.MarcarLeidos(_otherId, _myId); // marcar como leídos los del otro hacia mí

            rptMensajes.DataSource = cadM.ListarConversacion(_myId, _otherId);
            rptMensajes.DataBind();
        }

        protected void BtnEnviar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtMensaje.Text)) return;
            _myId = Convert.ToInt32(Session["UserId"]);
            int.TryParse(Request.QueryString["con"], out _otherId);

            var cadB = new CADChatBloqueo();
            if (cadB.EstaBloqueado(_myId, _otherId)) return;

            var cadM = new CADMensaje();
            cadM.CrearMensaje(new ENMensaje
            {
                Contenido  = txtMensaje.Text.Trim(),
                EmisorId   = _myId,
                ReceptorId = _otherId,
                FechaEnvio = DateTime.Now,
                Leido      = false
            });
            txtMensaje.Text = "";
            // Refresh messages
            rptMensajes.DataSource = cadM.ListarConversacion(_myId, _otherId);
            rptMensajes.DataBind();
        }

        protected void BtnSilenciar_Click(object sender, EventArgs e)
        {
            _myId = Convert.ToInt32(Session["UserId"]);
            int.TryParse(Request.QueryString["con"], out _otherId);
            var cadS = new CADChatSilenciado();
            if (cadS.EstaSilenciado(_myId, _otherId)) cadS.Dessilenciar(_myId, _otherId);
            else cadS.Silenciar(_myId, _otherId);
            Response.Redirect(Request.Url.ToString());
        }

        protected void BtnBloquear_Click(object sender, EventArgs e)
        {
            _myId = Convert.ToInt32(Session["UserId"]);
            int.TryParse(Request.QueryString["con"], out _otherId);
            var cadB = new CADChatBloqueo();
            if (cadB.EstaBloqueado(_myId, _otherId)) cadB.Desbloquear(_myId, _otherId);
            else cadB.Bloquear(_myId, _otherId);
            Response.Redirect(Request.Url.ToString());
        }

        protected void BtnEliminarChat_Click(object sender, EventArgs e)
        {
            _myId = Convert.ToInt32(Session["UserId"]);
            int.TryParse(Request.QueryString["con"], out _otherId);
            var cadM = new CADMensaje();
            cadM.EliminarConversacion(_myId, _otherId);
            Response.Redirect("Foro.aspx");
        }
    }
}
