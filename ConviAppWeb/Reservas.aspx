<%@ Page Title="Reservas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Reservas.aspx.cs" Inherits="ConviAppWeb.Reservas" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">📊 Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">✅ Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">💸 Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab">💬 Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab active">📅 Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab">🔧 Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab">📄 Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">📎 Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">🏠 Mis Pisos</a>
        </div>

        <h2 style="margin-bottom:20px;">📅 Reservas de Zonas Comunes</h2>

        <div class="glass-card" style="margin-bottom:24px;">
            <h4 style="margin-top:0; color:var(--primary-light);">➕ Nueva reserva</h4>
            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                <asp:TextBox ID="txtMotivo" runat="server" CssClass="form-input"
                    placeholder="Zona o motivo (ej: Lavadora, Salón)" style="flex:1; min-width:150px;" />
                <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-input" TextMode="DateTimeLocal"
                    style="flex:1; min-width:180px;" />
                <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-input" TextMode="DateTimeLocal"
                    style="flex:1; min-width:180px;" />
                <asp:Button ID="btnReservar" runat="server" Text="Reservar" CssClass="btn btn-primary btn-sm"
                    OnClick="BtnReservar_Click" />
            </div>
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"
                style="margin-top:8px; display:block;" />
        </div>

        <asp:Panel ID="pnlVacio" runat="server" Visible="false">
            <div class="glass-card" style="text-align:center; padding:3rem; color:var(--text-muted);">
                <div style="font-size:3rem; margin-bottom:16px;">📅</div>
                <p>No hay reservas activas.</p>
            </div>
        </asp:Panel>

        <asp:Repeater ID="rptReservas" runat="server" OnItemCommand="RptReservas_ItemCommand">
            <HeaderTemplate>
                <ul class="task-list">
            </HeaderTemplate>
            <ItemTemplate>
                <li class="task-item">
                    <div class="task-info">
                        <div class="task-name">📍 <%# Eval("Motivo") ?? "Zona común" %>
                        </div>
                        <div class="task-meta">
                            <%# ((DateTime)Eval("FechaInicio")).ToString("g") %> → <%#
                                    ((DateTime)Eval("FechaFin")).ToString("g") %>
                        </div>
                    </div>
                    <span class="status-badge active">
                        <%# Eval("Estado") ?? "confirmada" %>
                    </span>
                    <asp:LinkButton ID="btnCancelar" runat="server" CommandName="Cancelar"
                        CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm"
                        style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3);"
                        OnClientClick="return confirm('¿Cancelar reserva?')">✕</asp:LinkButton>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Content>