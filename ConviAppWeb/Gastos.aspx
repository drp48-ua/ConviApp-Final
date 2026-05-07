<%@ Page Title="Gastos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Gastos.aspx.cs"
    Inherits="ConviAppWeb.Gastos" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">&#128202; Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">&#9989; Tareas</a>
            <a href="Gastos.aspx" class="dash-tab active">💸 Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab">&#9993; Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">&#128197; Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab">&#128295; Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab">&#128196; Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">&#128206; Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">&#127968; Mis Pisos</a>
        </div>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2>💸 Gastos Comunes</h2>
            <div style="font-size: 1.5rem; font-weight: 800; font-family: 'Outfit', sans-serif; color: var(--danger);">
                Total: <asp:Label ID="lblTotal" runat="server">0.00 €</asp:Label>
            </div>
        </div>

        <% if (Session["UserRole"]==null || Session["UserRole"].ToString()=="Basico" ) { %>
            <div class="ad-slider-wrap"
                style="margin-bottom:24px; position:relative; background:white; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; display:flex; align-items:center;">
                <div style="width:120px; height:100px; overflow:hidden; flex-shrink:0;">
                    <img src="https://images.unsplash.com/photo-1550565118-3a14e8d0386f?w=400&h=300&fit=crop"
                        style="width:100%; height:100%; object-fit:cover;" />
                </div>
                <div style="padding:16px; flex:1;">
                    <div
                        style="position:absolute; top:0; right:0; background:#f3f4f6; padding:2px 8px; font-size:0.7rem; font-weight:600; color:#6b7280; border-bottom-left-radius:6px;">
                        PUBLICIDAD</div>
                    <strong style="color:var(--primary); font-size:1.1rem; display:block; margin-bottom:4px;">Ahorra en
                        Luz</strong>
                    <span style="color:#4b5563; font-size:0.9rem;">Contrata tarifa compartida y ahorra un 20%.</span>
                </div>
            </div>
            <% } %>

                <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                    <div style="position:relative;">
                        <div class="glass-card" style="margin-bottom: 24px; position:relative; pointer-events:none;">
                            <h4 style="margin-top: 0; color: var(--primary-light);">➕ Nuevo gasto</h4>
                            <div style="display: flex; gap: 12px; flex-wrap: wrap;">
                                <input type="text" class="form-input" placeholder="Concepto"
                                    style="flex: 2; min-width: 200px;" disabled />
                                <input type="number" class="form-input" placeholder="Importe (&euro;)"
                                    style="flex: 1; min-width: 120px;" disabled />
                                <div class="btn btn-primary btn-sm">A&ntilde;adir</div>
                            </div>
                        </div>

                        <a href="Registro.aspx"
                            style="position:absolute; top:0; left:0; width:100%; height:120px; z-index:10; cursor:pointer;"
                            title="Regístrate para añadir gastos"></a>

                        <div class="glass-card" style="padding: 0; overflow: hidden; margin-bottom:24px;">
                            <table class="data-table" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th style="text-align:left;">Concepto</th>
                                        <th style="text-align:left;">Fecha</th>
                                        <th style="text-align:left;">Estado</th>
                                        <th style="text-align: right;">Importe</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td
                                            style="font-weight: 500; text-align:left; padding:12px; border-bottom:1px solid #e5e7eb;">
                                            Internet Vodafone</td>
                                        <td
                                            style="color: var(--text-muted); text-align:left; padding:12px; border-bottom:1px solid #e5e7eb;">
                                            01/05/2026</td>
                                        <td style="text-align:left; padding:12px; border-bottom:1px solid #e5e7eb;">
                                            <span style="color: var(--warning)">⏳ Pendiente</span></td>
                                        <td
                                            style="text-align: right; font-weight: 700; color: var(--danger); padding:12px; border-bottom:1px solid #e5e7eb;">
                                            35,00 €</td>
                                    </tr>
                                    <tr>
                                        <td
                                            style="font-weight: 500; text-align:left; padding:12px; border-bottom:1px solid #e5e7eb;">
                                            Agua Canal Isabel II</td>
                                        <td
                                            style="color: var(--text-muted); text-align:left; padding:12px; border-bottom:1px solid #e5e7eb;">
                                            28/04/2026</td>
                                        <td style="text-align:left; padding:12px; border-bottom:1px solid #e5e7eb;">
                                            <span style="color: var(--success)">✅ Pagado</span></td>
                                        <td
                                            style="text-align: right; font-weight: 700; color: var(--danger); padding:12px; border-bottom:1px solid #e5e7eb;">
                                            22,50 €</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="glass-card"
                            style="text-align: center; padding: 2rem; background:linear-gradient(135deg, rgba(239,246,255,0.8), rgba(219,234,254,0.8)); border:1px solid #bfdbfe; box-shadow:0 10px 15px -3px rgba(59,130,246,0.1);">
                            <div style="font-size: 2.5rem; margin-bottom: 8px;">💸</div>
                            <h3 style="color: var(--primary); font-size: 1.3rem; margin-bottom: 8px;">Gestiona los
                                gastos comunes</h3>
                            <p
                                style="color: var(--text-secondary); max-width: 500px; margin: 0 auto 16px; font-size:0.9rem;">
                                Lleva el control de todas las facturas del piso, añade qué ha pagado cada uno y que la
                                app calcule quién debe a quién. Regístrate gratis para empezar a usarlo.</p>
                            <a href="Registro.aspx" class="btn btn-primary"
                                style="font-size: 1rem; padding: 10px 20px; box-shadow:0 4px 6px rgba(37,99,235,0.2);">Regístrate
                                gratis</a>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlApp" runat="server">

                    <!-- Add Expense Form -->
                    <div class="glass-card" style="margin-bottom: 24px;">
                        <h4 style="margin-top: 0; color: var(--primary-light);">➕ Nuevo gasto</h4>
                        <div style="display: flex; gap: 12px; flex-wrap: wrap;">
                            <asp:TextBox ID="txtConcepto" runat="server" CssClass="form-input" placeholder="Concepto"
                                required="true" style="flex: 2; min-width: 200px;" />
                            <asp:TextBox ID="txtImporte" runat="server" CssClass="form-input" placeholder="Importe (&euro;)"
                                required="true" step="0.01" type="number" style="flex: 1; min-width: 120px;" />
                            <asp:Button ID="btnGuardar" runat="server" Text="A&ntilde;adir" CssClass="btn btn-primary btn-sm"
                                OnClick="BtnGuardar_Click" />
                        </div>
                    </div>

                    <asp:Panel ID="pnlVacio" runat="server" Visible="false">
                        <div class="glass-card" style="text-align: center; padding: 3rem; color: var(--text-muted);">
                            <div style="font-size: 3rem; margin-bottom: 16px;">💸</div>
                            <p>No hay gastos registrados todavía.</p>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlTabla" runat="server">
                        <div class="glass-card" style="padding: 0; overflow: hidden;">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Concepto</th>
                                        <th>Fecha</th>
                                        <th>Estado</th>
                                        <th style="text-align: right;">Importe</th>
                                        <th style="width: 50px;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptGastos" runat="server" OnItemCommand="RptGastos_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td style="font-weight: 500;">
                                                    <%# Eval("Concepto") %>
                                                </td>
                                                <td style="color: var(--text-muted);">
                                                    <%# Eval("Fecha", "{0:d}" ) %>
                                                </td>
                                                <td>
                                                    <span
                                                        style='color: <%# (bool)Eval("Pagado") ? "var(--success)" : "var(--warning)" %>'>
                                                        <%# (bool)Eval("Pagado") ? "✅ Pagado" : "⏳ Pendiente" %>
                                                    </span>
                                                </td>
                                                <td style="text-align: right; font-weight: 700; color: var(--danger);">
                                                    <%# Eval("Importe", "{0:0.00}" ) %> €
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btnEliminar" runat="server"
                                                        CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>'
                                                        style="background: none; border: none; cursor: pointer; color: #f87171;"
                                                        OnClientClick="return confirm('¿Eliminar?')">🗑</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </asp:Panel>

                </asp:Panel>
    </asp:Content>

