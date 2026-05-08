<%@ Page Title="Chat" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Chat.aspx.cs" Inherits="ConviAppWeb.Chat" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .chat-wrap { max-width:900px; margin:0 auto; display:grid; grid-template-rows:auto 1fr auto; height:calc(100vh - 200px); background:#fff; border-radius:16px; overflow:hidden; box-shadow:0 4px 32px rgba(0,0,0,0.1); }
    .chat-header { padding:16px 20px; border-bottom:1px solid #e5e7eb; display:flex; align-items:center; justify-content:space-between; background:#fff; }
    .chat-header-info { display:flex; align-items:center; gap:12px; }
    .chat-avatar { width:44px; height:44px; border-radius:50%; background:linear-gradient(135deg,#667eea,#764ba2); display:flex; align-items:center; justify-content:center; color:#fff; font-weight:700; font-size:1.1rem; flex-shrink:0; }
    .chat-header-name { font-weight:700; font-size:1rem; color:#111827; }
    .chat-header-email { font-size:0.8rem; color:#9ca3af; }
    .chat-header-actions { display:flex; gap:8px; }
    .chat-header-actions button { border:none; background:none; cursor:pointer; font-size:1.2rem; border-radius:8px; padding:6px 8px; transition:background 0.15s; }
    .chat-header-actions button:hover { background:#f3f4f6; }
    .chat-messages { overflow-y:auto; padding:20px; display:flex; flex-direction:column; gap:10px; background:#f9fafb; }
    .msg-bubble { max-width:65%; padding:10px 16px; border-radius:18px; font-size:0.92rem; line-height:1.5; word-break:break-word; }
    .msg-mine { align-self:flex-end; background:var(--primary); color:#fff; border-bottom-right-radius:4px; }
    .msg-other { align-self:flex-start; background:#fff; color:#111827; border:1px solid #e5e7eb; border-bottom-left-radius:4px; }
    .msg-meta { font-size:0.72rem; margin-top:3px; opacity:0.65; text-align:right; }
    .msg-other .msg-meta { text-align:left; }
    .chat-input-area { padding:14px 16px; background:#fff; border-top:1px solid #e5e7eb; display:flex; gap:10px; align-items:flex-end; }
    .chat-input-area textarea { flex:1; resize:none; border:1px solid #e5e7eb; border-radius:12px; padding:10px 14px; font-size:0.95rem; outline:none; font-family:inherit; transition:border-color 0.2s; min-height:44px; max-height:120px; }
    .chat-input-area textarea:focus { border-color:var(--primary); }
    .chat-send-btn { background:var(--primary); color:#fff; border:none; border-radius:12px; padding:10px 20px; font-weight:600; cursor:pointer; font-size:0.95rem; transition:background 0.2s; flex-shrink:0; }
    .chat-send-btn:hover { background:var(--primary-dark, #1d4ed8); }
    .chat-blocked-banner { background:#fef2f2; color:#b91c1c; padding:10px 20px; text-align:center; font-size:0.9rem; border-top:1px solid #fecaca; }
    .chat-muted-banner { background:#fffbeb; color:#92400e; padding:10px 20px; text-align:center; font-size:0.9rem; border-top:1px solid #fcd34d; }
    .options-menu { position:fixed; background:#fff; border:1px solid #e5e7eb; border-radius:12px; box-shadow:0 8px 24px rgba(0,0,0,0.15); z-index:9999; min-width:180px; display:none; }
    .options-menu a { display:flex; align-items:center; gap:8px; padding:10px 16px; color:#374151; text-decoration:none; font-size:0.9rem; transition:background 0.15s; cursor:pointer; }
    .options-menu a:hover { background:#f9fafb; }
    .options-menu a.danger { color:#dc2626; }
    .options-menu a:first-child { border-radius:12px 12px 0 0; }
    .options-menu a:last-child { border-radius:0 0 12px 12px; border-top:1px solid #f3f4f6; }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (Session["UserId"] == null) { Response.Redirect("Login.aspx"); return; } %>

    <div style="margin-bottom:12px;">
        <a href="Foro.aspx" style="color:#6b7280; text-decoration:none; font-size:0.9rem;">← Volver al Foro</a>
    </div>

    <asp:Panel ID="pnlNotFound" runat="server" Visible="false">
        <div class="glass-card" style="text-align:center; padding:3rem; max-width:500px; margin:0 auto;">
            <div style="font-size:3rem;">🤷</div>
            <h2>Usuario no encontrado</h2>
            <a href="Foro.aspx" class="btn btn-primary" style="margin-top:16px;">Volver al Foro</a>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlChat" runat="server" Visible="false">
        <div class="chat-wrap">
            <!-- HEADER -->
            <div class="chat-header">
                <div class="chat-header-info">
                    <div class="chat-avatar"><asp:Label ID="lblAvatarLetter" runat="server" /></div>
                    <div>
                        <div class="chat-header-name"><asp:Label ID="lblNombreOtro" runat="server" /></div>
                        <div class="chat-header-email"><asp:Label ID="lblEmailOtro" runat="server" /></div>
                    </div>
                </div>
                <div class="chat-header-actions">
                    <button type="button" title="Más opciones" onclick="toggleMenu(event)">⋮</button>
                    <div class="options-menu" id="optionsMenu">
                        <asp:LinkButton ID="btnSilenciar" runat="server" OnClick="BtnSilenciar_Click">🔕 Silenciar</asp:LinkButton>
                        <asp:LinkButton ID="btnBloquear" runat="server" OnClick="BtnBloquear_Click" style="color:#dc2626;">🚫 Bloquear</asp:LinkButton>
                        <asp:LinkButton ID="btnEliminarChat" runat="server" OnClick="BtnEliminarChat_Click" style="color:#dc2626;">🗑️ Eliminar chat</asp:LinkButton>
                    </div>
                </div>
            </div>

            <!-- MENSAJES -->
            <div class="chat-messages" id="chatMessages">
                <asp:Panel ID="pnlBloqueado" runat="server" Visible="false">
                    <div class="chat-blocked-banner">🚫 Has bloqueado a este usuario. No puedes enviar mensajes.</div>
                </asp:Panel>
                <asp:Panel ID="pnlSilenciado" runat="server" Visible="false">
                    <div class="chat-muted-banner">🔕 Has silenciado este chat. Recibirás mensajes pero sin notificación.</div>
                </asp:Panel>

                <asp:Repeater ID="rptMensajes" runat="server">
                    <ItemTemplate>
                        <div class='msg-bubble <%# (int)Eval("EmisorId") == (int)Session["UserId"] ? "msg-mine" : "msg-other" %>'>
                            <%# System.Web.HttpUtility.HtmlEncode(Eval("Contenido").ToString()) %>
                            <div class="msg-meta"><%# ((DateTime)Eval("FechaEnvio")).ToString("dd/MM HH:mm") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- INPUT -->
            <div class="chat-input-area">
                <asp:TextBox ID="txtMensaje" runat="server" TextMode="MultiLine" Rows="1"
                    placeholder="Escribe un mensaje..." style="flex:1; resize:none; border:1px solid #e5e7eb; border-radius:12px; padding:10px 14px; font-size:0.95rem; outline:none; font-family:inherit;" />
                <asp:Button ID="btnEnviar" runat="server" Text="Enviar →" CssClass="chat-send-btn" OnClick="BtnEnviar_Click" />
            </div>
        </div>
    </asp:Panel>

    <script>
        // Auto-scroll al fondo
        window.onload = function () {
            var el = document.getElementById('chatMessages');
            if (el) el.scrollTop = el.scrollHeight;
        };
        // Auto-refresco cada 5s (solo si el chat está visible)
        if (document.getElementById('chatMessages')) {
            setInterval(function () { __doPostBack('', ''); }, 5000);
        }
        // Menú opciones
        function toggleMenu(e) {
            e.stopPropagation();
            var m = document.getElementById('optionsMenu');
            var rect = e.currentTarget.getBoundingClientRect();
            m.style.top = (rect.bottom + window.scrollY + 4) + 'px';
            m.style.left = (rect.right - 180 + window.scrollX) + 'px';
            m.style.display = m.style.display === 'block' ? 'none' : 'block';
        }
        document.addEventListener('click', function () {
            var m = document.getElementById('optionsMenu');
            if (m) m.style.display = 'none';
        });
        // Enter para enviar (Shift+Enter = nueva línea)
        document.addEventListener('keydown', function (e) {
            var ta = document.querySelector('textarea');
            if (ta && document.activeElement === ta && e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                var btn = document.querySelector('.chat-send-btn');
                if (btn) btn.click();
            }
        });
    </script>
</asp:Content>
