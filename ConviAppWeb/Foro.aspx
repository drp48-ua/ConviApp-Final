<%@ Page Title="Foro | Usuarios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Foro.aspx.cs" Inherits="ConviAppWeb.Foro" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
    .foro-layout { display: grid; grid-template-columns: 340px 1fr; gap: 0; min-height: 80vh; max-width: 1100px; margin: 0 auto; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 32px rgba(0,0,0,0.1); }
    .foro-sidebar { background: #fff; border-right: 1px solid #e5e7eb; display: flex; flex-direction: column; }
    .foro-sidebar-header { padding: 20px 20px 12px; border-bottom: 1px solid #f3f4f6; }
    .foro-sidebar-header h2 { margin:0 0 12px; font-size:1.2rem; color:#111827; }
    .foro-search-box { display:flex; align-items:center; gap:8px; background:#f9fafb; border:1px solid #e5e7eb; border-radius:10px; padding:8px 12px; }
    .foro-search-box input { border:none; background:transparent; outline:none; width:100%; font-size:0.9rem; color:#111827; }
    .foro-list { flex:1; overflow-y:auto; }
    .foro-section-title { padding: 12px 20px 6px; font-size:0.7rem; font-weight:700; color:#9ca3af; text-transform:uppercase; letter-spacing:.08em; }
    .foro-user-item { display:flex; align-items:center; gap:12px; padding:12px 20px; cursor:pointer; transition:background 0.15s; border-bottom:1px solid #f9fafb; text-decoration:none; }
    .foro-user-item:hover { background:#f0f9ff; }
    .foro-user-item.active { background:#eff6ff; }
    .foro-avatar { width:42px; height:42px; border-radius:50%; background:linear-gradient(135deg,#667eea,#764ba2); display:flex; align-items:center; justify-content:center; color:white; font-weight:700; font-size:1rem; flex-shrink:0; }
    .foro-user-info { flex:1; min-width:0; }
    .foro-user-name { font-weight:600; color:#111827; font-size:0.9rem; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
    .foro-user-sub { font-size:0.78rem; color:#9ca3af; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
    .foro-unread { background:var(--primary); color:white; border-radius:20px; font-size:0.7rem; font-weight:700; padding:2px 8px; flex-shrink:0; }
    .foro-main { background:#f9fafb; display:flex; flex-direction:column; align-items:center; justify-content:center; }
    .foro-empty { text-align:center; color:#9ca3af; }
    .foro-empty .icon { font-size:3.5rem; margin-bottom:16px; }
    .badge-silenciado { font-size:0.7rem; background:#fef3c7; color:#92400e; border-radius:8px; padding:2px 6px; margin-left:4px; }
    @media(max-width:700px) { .foro-layout { grid-template-columns: 1fr; } .foro-main { display:none; } }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% if (Session["UserId"] == null) { %>
        <div class="glass-card" style="text-align:center; padding:3rem; max-width:500px; margin:4rem auto;">
            <div style="font-size:3rem; margin-bottom:16px;">💬</div>
            <h2>Acceso Restringido</h2>
            <p style="color:#6b7280;">Inicia sesión para acceder al Foro Social.</p>
            <a href="Login.aspx" class="btn btn-primary" style="margin-top:16px;">Iniciar sesión</a>
        </div>
    <% } else { %>

    <div style="padding: 20px 0 8px; max-width:1100px; margin:0 auto;">
        <h1 style="font-size:1.5rem; font-weight:800; color:#111827; margin-bottom:4px;">💬 Foro Social</h1>
        <p style="color:#6b7280; font-size:0.9rem; margin-bottom:20px;">Habla con cualquier usuario de ConviApp. Contacta con propietarios de comunidades.</p>
    </div>

    <div class="foro-layout">
        <!-- SIDEBAR -->
        <div class="foro-sidebar">
            <div class="foro-sidebar-header">
                <h2>Mensajes</h2>
                <div class="foro-search-box">
                    <span>🔍</span>
                    <asp:TextBox ID="txtBuscar" runat="server" placeholder="Buscar por nombre o email..." style="border:none; background:transparent; outline:none; flex:1; min-width:0; font-size:0.9rem;" />
                    <asp:Button ID="btnBuscar" runat="server" Text="↵" CssClass="btn btn-sm btn-primary" OnClick="BtnBuscar_Click" style="padding:4px 8px; font-size:1rem; border-radius:8px;" />
                </div>
            </div>

            <div class="foro-list">
                <!-- Conversaciones activas -->
                <asp:Panel ID="pnlChats" runat="server">
                    <div class="foro-section-title">Conversaciones</div>
                    <asp:Repeater ID="rptChats" runat="server">
                        <ItemTemplate>
                            <a href='Chat.aspx?con=<%# Eval("Id") %>' class="foro-user-item">
                                <div class="foro-avatar"><%# ((string)Eval("Nombre") ?? "?")[0].ToString().ToUpper() %></div>
                                <div class="foro-user-info">
                                    <div class="foro-user-name"><%# Eval("Nombre") %>
                                        <%# (bool)Eval("Silenciado") ? "<span class='badge-silenciado'>🔕</span>" : "" %>
                                    </div>
                                    <div class="foro-user-sub"><%# Eval("UltimoMsg") %></div>
                                </div>
                                <%# (int)Eval("NoLeidos") > 0 ? string.Format("<span class='foro-unread'>{0}</span>", Eval("NoLeidos")) : "" %>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label ID="lblSinChats" runat="server" Visible="false" style="display:block; padding:12px 20px; color:#9ca3af; font-size:0.85rem; font-style:italic;">Sin conversaciones activas.</asp:Label>
                </asp:Panel>

                <!-- Todos los usuarios -->
                <div class="foro-section-title" style="margin-top:8px;">Todos los usuarios</div>
                <asp:Repeater ID="rptUsuarios" runat="server">
                    <ItemTemplate>
                        <a href='Chat.aspx?con=<%# Eval("Id") %>' class="foro-user-item">
                            <div class="foro-avatar" style="background:linear-gradient(135deg,#f093fb,#f5576c);"><%# ((string)Eval("Nombre") ?? "?")[0].ToString().ToUpper() %></div>
                            <div class="foro-user-info">
                                <div class="foro-user-name"><%# Eval("Nombre") %></div>
                                <div class="foro-user-sub"><%# Eval("Email") %></div>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Label ID="lblSinResultados" runat="server" Visible="false" style="display:block; padding:12px 20px; color:#9ca3af; font-size:0.85rem;">Sin resultados para tu búsqueda.</asp:Label>
            </div>
        </div>

        <!-- MAIN PANEL (placeholder) -->
        <div class="foro-main">
            <div class="foro-empty">
                <div class="icon">💬</div>
                <h3 style="color:#374151; margin-bottom:8px;">Selecciona una conversación</h3>
                <p style="font-size:0.9rem;">Elige un usuario de la lista para empezar a chatear.</p>
            </div>
        </div>
    </div>

    <% } %>
</asp:Content>
