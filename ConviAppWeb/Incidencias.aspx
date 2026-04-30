<%@ Page Title="Incidencias" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Incidencias.aspx.cs" Inherits="ConviAppWeb.Incidencias" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">📊 Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">✅ Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">💸 Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab">💬 Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">📅 Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab active">🔧 Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab">📄 Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">📎 Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">🏠 Mis Pisos</a>
        </div>

        <h2 style="margin-bottom:20px;">🔧 Incidencias</h2>

        <div class="glass-card" style="margin-bottom:24px;">
            <h4 style="margin-top:0; color:var(--primary-light);">➕ Reportar incidencia</h4>
            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-input" placeholder="Título"
                    style="flex:1; min-width:200px;" />
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-input"
                    placeholder="Descripción detallada" style="flex:2; min-width:200px;" />
                <asp:Button ID="btnReportar" runat="server" Text="Reportar" CssClass="btn btn-primary btn-sm"
                    OnClick="BtnReportar_Click" />
            </div>
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"
                style="margin-top:8px; display:block;" />
        </div>

        <asp:Panel ID="pnlVacio" runat="server" Visible="false">
            <div class="glass-card" style="text-align:center; padding:3rem; color:var(--text-muted);">
                <div style="font-size:3rem; margin-bottom:16px;">🔧</div>
                <p>No hay incidencias registradas. ¡Todo en orden!</p>
            </div>
        </asp:Panel>

        <asp:Repeater ID="rptIncidencias" runat="server" OnItemCommand="RptIncidencias_ItemCommand">
            <HeaderTemplate>
                <ul class="task-list">
            </HeaderTemplate>
            <ItemTemplate>
                <li class="task-item">
                    <div class="task-info">
                        <div class="task-name">
                            <%# Eval("Titulo") %>
                        </div>
                        <div class="task-meta">
                            <%# Eval("Descripcion") ?? "" %> · <%# ((DateTime)Eval("FechaReporte")).ToShortDateString()
                                    %>
                        </div>
                    </div>
                    <span
                        class='status-badge <%# (string)Eval("Estado") == "resuelta" ? "done" : (string)Eval("Estado") == "en_progreso" ? "pending" : "open" %>'>
                        <%# Eval("Estado") ?? "abierta" %>
                    </span>
                    <asp:LinkButton ID="btnAvanzar" runat="server" CommandName="Avanzar"
                        CommandArgument='<%# Eval("Id") + "|" + Eval("Estado") %>' CssClass="btn btn-sm"
                        style='<%# (string)Eval("Estado") == "resuelta" ? "display:none" : (string)Eval("Estado") == "abierta" ? "background:rgba(245,158,11,0.1);color:#f59e0b;border:1px solid rgba(245,158,11,0.3);" : "background:rgba(52,211,153,0.1);color:#34d399;border:1px solid rgba(52,211,153,0.3);" %>'>
                        <%# (string)Eval("Estado")=="abierta" ? "▶ En progreso" : "✓ Resolver" %>
                    </asp:LinkButton>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Content>