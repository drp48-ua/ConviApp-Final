<%@ Page Title="Contratos y Pagos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="ContratosYPagos.aspx.cs" Inherits="ConviAppWeb.ContratosYPagos" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">&#128202; Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">&#9989; Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">&#128182; Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab">&#9993; Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">&#128197; Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab">&#128295; Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab active">📄 Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">&#128206; Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">&#127968; Mis Pisos</a>
        </div>

        <h2 style="margin-bottom:20px;">📄 Contratos y Pagos</h2>

        <% if (Session["UserRole"]==null || Session["UserRole"].ToString()=="Basico" ) { %>
            <div class="ad-slider-wrap"
                style="margin-bottom:24px; position:relative; background:white; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; display:flex; align-items:center;">
                <div style="width:120px; height:80px; overflow:hidden; flex-shrink:0;">
                    <img src="https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=400&h=300&fit=crop"
                        style="width:100%; height:100%; object-fit:cover;" />
                </div>
                <div style="padding:16px; flex:1;">
                    <div
                        style="position:absolute; top:0; right:0; background:#f3f4f6; padding:2px 8px; font-size:0.7rem; font-weight:600; color:#6b7280; border-bottom-left-radius:6px;">
                        PUBLICIDAD</div>
                    <strong style="color:var(--primary); font-size:1.1rem; display:block; margin-bottom:4px;">Seguro de
                        Impago</strong>
                    <span style="color:#4b5563; font-size:0.9rem;">Protege tu alquiler por solo 5€ al mes.</span>
                </div>
            </div>
            <% } %>

                <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                    <div style="position:relative;">
                        <div class="glass-card" style="margin-bottom:24px; position:relative; pointer-events:none;">
                            <h4 style="margin-top:0; color:var(--primary-light);">➕ Nuevo contrato</h4>
                            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                                <select class="form-input" style="flex:1; min-width:150px;" disabled>
                                    <option>📋 Arrendamiento</option>
                                </select>
                                <input type="date" class="form-input" style="flex:1; min-width:140px;" disabled />
                                <input type="date" class="form-input" style="flex:1; min-width:140px;" disabled />
                                <input type="number" class="form-input" placeholder="Renta/mes €"
                                    style="flex:1; min-width:120px;" disabled />
                                <input type="number" class="form-input" placeholder="Fianza €"
                                    style="flex:1; min-width:120px;" disabled />
                                <div class="btn btn-primary btn-sm">Crear</div>
                            </div>
                        </div>
                        <a href="Registro.aspx"
                            style="position:absolute; top:0; left:0; width:100%; height:120px; z-index:10; cursor:pointer;"
                            title="Inicia sesi&oacute;n para firmar contratos"></a>

                        <h3 style="color:var(--primary-light); margin-bottom:12px;">📋 Mis Contratos</h3>
                        <ul class="task-list" style="margin-bottom:30px;">
                            <li class="task-item">
                                <div class="task-info">
                                    <div class="task-name">ARRENDAMIENTO — 850,00 €/mes</div>
                                    <div class="task-meta">01/01/2026 → 31/12/2026</div>
                                </div>
                                <span class="status-badge active">activo</span>
                                <a href="Registro.aspx" class="btn btn-sm"
                                    style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3); text-decoration:none;">🗑</a>
                            </li>
                        </ul>

                        <div class="glass-card"
                            style="text-align: center; padding: 2rem; margin-top:24px; background:linear-gradient(135deg, rgba(239,246,255,0.8), rgba(219,234,254,0.8)); border:1px solid #bfdbfe; box-shadow:0 10px 15px -3px rgba(59,130,246,0.1);">
                            <div style="font-size: 2.5rem; margin-bottom: 8px;">📄</div>
                            <h3 style="color: var(--primary); font-size: 1.3rem; margin-bottom: 8px;">Gestiona tus
                                contratos y cuotas</h3>
                            <p
                                style="color: var(--text-secondary); max-width: 500px; margin: 0 auto 16px; font-size:0.9rem;">
                                Supervisa vencimientos de alquiler, subarriendos, y unifica los cobros de tus inquilinos
                                de manera automática. Para usar la App, regístrate.</p>
                            <a href="Registro.aspx" class="btn btn-primary"
                                style="font-size: 1rem; padding: 10px 20px; box-shadow:0 4px 6px rgba(37,99,235,0.2);">Regístrate
                                gratis</a>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlApp" runat="server">

                    <div class="glass-card" style="margin-bottom:24px;">
                        <h4 style="margin-top:0; color:var(--primary-light);">➕ Nuevo contrato</h4>
                        <div style="display:flex; gap:12px; flex-wrap:wrap;">
                            <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-input"
                                style="flex:1; min-width:150px;">
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

                    <h3 id="hContratos" runat="server" visible="false"
                        style="color:var(--primary-light); margin-bottom:12px;">📋
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

                    <h3 id="hPagos" runat="server" visible="false" style="color:var(--accent); margin-bottom:12px;">💳
                        Historial de
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

                </asp:Panel>
    </asp:Content>

