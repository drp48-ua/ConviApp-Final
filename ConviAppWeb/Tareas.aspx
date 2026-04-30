<%@ Page Title="Tareas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Tareas.aspx.cs" Inherits="ConviAppWeb.Tareas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dash-tabs">
        <a href="Index.aspx" class="dash-tab">📊 Resumen</a>
        <a href="Tareas.aspx" class="dash-tab active">✅ Tareas</a>
        <a href="Gastos.aspx" class="dash-tab">💸 Gastos</a>
        <a href="Mensajes.aspx" class="dash-tab">💬 Mensajes</a>
        <a href="Reservas.aspx" class="dash-tab">📅 Reservas</a>
        <a href="Incidencias.aspx" class="dash-tab">🔧 Incidencias</a>
        <a href="ContratosYPagos.aspx" class="dash-tab">📄 Contratos</a>
        <a href="Documentos.aspx" class="dash-tab">📎 Documentos</a>
        <a href="MisPisos.aspx" class="dash-tab">🏠 Mis Pisos</a>
    </div>

    <h2 style="margin-bottom:20px;">✅ Tareas del Piso</h2>

    <div class="glass-card" style="margin-bottom:24px;">
        <h4 style="margin-top:0; color:var(--primary-light);">➕ Nueva tarea</h4>
        <div style="display:flex; gap:12px; flex-wrap:wrap;">
            <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-input" placeholder="Título de la tarea" style="flex:2; min-width:200px;" />
            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-input" placeholder="Descripción (opcional)" style="flex:2; min-width:200px;" />
            <asp:DropDownList ID="ddlPrioridad" runat="server" CssClass="form-input" style="flex:1; min-width:120px;">
                <asp:ListItem Value="baja">🟢 Baja</asp:ListItem>
                <asp:ListItem Value="media" Selected="True">🟡 Media</asp:ListItem>
                <asp:ListItem Value="alta">🔴 Alta</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnAnadir" runat="server" Text="Añadir" CssClass="btn btn-primary btn-sm" OnClick="BtnAnadir_Click" />
        </div>
        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false" style="margin-top:8px; display:block;" />
    </div>

    <asp:Panel ID="pnlVacio" runat="server" Visible="false">
        <div class="glass-card" style="text-align:center; padding:3rem; color:var(--text-muted);">
            <div style="font-size:3rem; margin-bottom:16px;">✅</div>
            <p>No hay tareas pendientes. ¡Todo al día!</p>
        </div>
    </asp:Panel>

    <asp:Repeater ID="rptTareas" runat="server" OnItemCommand="RptTareas_ItemCommand">
        <HeaderTemplate><ul class="task-list"></HeaderTemplate>
        <ItemTemplate>
            <li class="task-item <%# (string)Eval("Estado") == "completada" ? "completed" : "" %>">
                <asp:LinkButton ID="btnToggle" runat="server" CommandName="Toggle" CommandArgument='<%# Eval("Id") %>'
                    style="background:none; border:none; cursor:pointer; font-size:1.2rem; padding:0 8px; color:inherit;">
                    <%# (string)Eval("Estado") == "completada" ? "✅" : "⬜" %>
                </asp:LinkButton>
                <div class="task-info">
                    <div class="task-name" style='<%# (string)Eval("Estado") == "completada" ? "text-decoration:line-through; opacity:0.5;" : "" %>'>
                        <%# Eval("Titulo") %>
                    </div>
                    <div class="task-meta"><%# Eval("Descripcion") ?? "" %></div>
                </div>
                <span class='task-priority <%# (string)Eval("Prioridad") == "alta" ? "high" : (string)Eval("Prioridad") == "media" ? "medium" : "low" %>'>
                    <%# Eval("Prioridad") ?? "Normal" %>
                </span>
                <asp:LinkButton ID="btnEliminar" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>'
                    CssClass="btn btn-sm" style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3);"
                    OnClientClick="return confirm('¿Eliminar esta tarea?')">🗑</asp:LinkButton>
            </li>
        </ItemTemplate>
        <FooterTemplate></ul></FooterTemplate>
    </asp:Repeater>
</asp:Content>
