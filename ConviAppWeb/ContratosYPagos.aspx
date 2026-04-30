<%@ Page Title="Contratos y Pagos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="ContratosYPagos.aspx.cs" Inherits="ConviAppWeb.ContratosYPagos" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">📊 Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">✅ Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">💸 Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab">💬 Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">📅 Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab">🔧 Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab active">📄 Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">📎 Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">🏠 Mis Pisos</a>
        </div>

        <h2 style="margin-bottom:20px;">📄 Contratos y Pagos</h2>

        <div class="glass-card" style="margin-bottom:24px;">
            <h4 style="margin-top:0; color:var(--primary-light);">➕ Nuevo contrato</h4>
            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-input" style="flex:1; min-width:150px;">
                    <asp:ListItem Value="arrendamiento">📋 Arrendamiento</asp:ListItem>
                    <asp:ListItem Value="temporal">⏱️ Temporal</asp:ListItem>
                    <asp:ListItem Value="subarriendo">🔄 Subarriendo</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-input" TextMode="Date"
                    style="flex:1; min-width:140px;" />
                <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-input" TextMode="Date"
                    style="flex:1; min-width:140px;" />
                <asp:TextBox ID="txtRenta" runat="server" CssClass="form-input" placeholder="Renta/mes €"
                    TextMode="Number" style="flex:1; min-width:120px;" />
                <asp:TextBox ID="txtFianza" runat="server" CssClass="form-input" placeholder="Fianza €"
                    TextMode="Number" style="flex:1; min-width:120px;" />
                <asp:Button ID="btnCrear" runat="server" Text="Crear" CssClass="btn btn-primary btn-sm"
                    OnClick="BtnCrear_Click" />
            </div>
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"
                style="margin-top:8px; display:block;" />
        </div>

        <asp:Panel ID="pnlVacioContratos" runat="server" Visible="false">
            <div class="glass-card" style="text-align:center; padding:3rem; color:var(--text-muted);">
                <div style="font-size:3rem; margin-bottom:16px;">📄</div>
                <p>No hay contratos registrados.</p>
            </div>
        </asp:Panel>

        <h3 id="hContratos" runat="server" visible="false" style="color:var(--primary-light); margin-bottom:12px;">📋
            Mis Contratos</h3>
        <asp:Repeater ID="rptContratos" runat="server" OnItemCommand="RptContratos_ItemCommand">
            <HeaderTemplate>
                <ul class="task-list" style="margin-bottom:30px;">
            </HeaderTemplate>
            <ItemTemplate>
                <li class="task-item">
                    <div class="task-info">
                        <div class="task-name">
                            <%# ((string)Eval("Type") ?? "" ).ToUpper() %> — <%#
                                    ((decimal)Eval("MonthlyRent")).ToString("C") %>/mes
                        </div>
                        <div class="task-meta">
                            <%# ((DateTime)Eval("StartDate")).ToShortDateString() %> → <%#
                                    ((DateTime)Eval("EndDate")).ToShortDateString() %>
                        </div>
                    </div>
                    <span
                        class='status-badge <%# (string)Eval("Status") == "activo" ? "active" : (string)Eval("Status") == "vencido" ? "pending" : "done" %>'>
                        <%# Eval("Status") %>
                    </span>
                    <asp:LinkButton ID="btnEliminar" runat="server" CommandName="Eliminar"
                        CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm"
                        style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3);"
                        OnClientClick="return confirm('¿Eliminar contrato?')">🗑</asp:LinkButton>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>

        <h3 id="hPagos" runat="server" visible="false" style="color:var(--accent); margin-bottom:12px;">💳 Historial de
            Pagos</h3>
        <asp:Panel ID="pnlPagos" runat="server" Visible="false">
            <div class="glass-card" style="padding:0; overflow:hidden;">
                <asp:GridView ID="gvPagos" runat="server" AutoGenerateColumns="false" CssClass="data-table"
                    style="width:100%;" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Concept" HeaderText="Concepto" />
                        <asp:BoundField DataField="Method" HeaderText="Método" />
                        <asp:BoundField DataField="Date" HeaderText="Fecha" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Status" HeaderText="Estado" />
                        <asp:BoundField DataField="Amount" HeaderText="Importe" DataFormatString="{0:C}" />
                    </Columns>
                </asp:GridView>
            </div>
        </asp:Panel>
    </asp:Content>