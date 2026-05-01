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

        <% if (Session["UserRole"]==null || Session["UserRole"].ToString()=="Basico" ) { %>
            <div class="ad-slider-wrap"
                style="margin-bottom:24px; position:relative; background:white; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; display:flex; align-items:center;">
                <div style="width:120px; height:80px; overflow:hidden; flex-shrink:0;">
                    <img src="https://images.unsplash.com/photo-1543326727-cf6c39e8f84c?w=400&h=300&fit=crop"
                        style="width:100%; height:100%; object-fit:cover;" />
                </div>
                <div style="padding:16px; flex:1;">
                    <div
                        style="position:absolute; top:0; right:0; background:#f3f4f6; padding:2px 8px; font-size:0.7rem; font-weight:600; color:#6b7280; border-bottom-left-radius:6px;">
                        PUBLICIDAD</div>
                    <strong style="color:var(--primary); font-size:1.1rem; display:block; margin-bottom:4px;">Gimnasio
                        Urban Fit</strong>
                    <span style="color:#4b5563; font-size:0.9rem;">Prueba 7 días gratis. A solo 2 minutos de tu
                        piso.</span>
                </div>
            </div>
            <% } %>

                <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                    <div style="position:relative;">
                        <div class="glass-card" style="margin-bottom:24px; position:relative; pointer-events:none;">
                            <h4 style="margin-top:0; color:var(--primary-light);">➕ Nueva reserva</h4>
                            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                                <input type="text" class="form-input" placeholder="Zona o motivo (ej: Lavadora, Salón)"
                                    style="flex:1; min-width:150px;" disabled />
                                <input type="datetime-local" class="form-input" style="flex:1; min-width:180px;"
                                    disabled />
                                <input type="datetime-local" class="form-input" style="flex:1; min-width:180px;"
                                    disabled />
                                <div class="btn btn-primary btn-sm">Reservar</div>
                            </div>
                        </div>
                        <!-- OVERLAY PARA REDIRIGIR AL REGISTRO -->
                        <a href="Registro.aspx"
                            style="position:absolute; top:0; left:0; width:100%; height:120px; z-index:10; cursor:pointer;"
                            title="Regístrate para reservar zonas comunes"></a>

                        <ul class="task-list">
                            <li class="task-item">
                                <div class="task-info">
                                    <div class="task-name">📍 Lavadora Secadora</div>
                                    <div class="task-meta">Hoy 16:00 → Hoy 17:30</div>
                                </div>
                                <span class="status-badge active">confirmada</span>
                                <a href="Registro.aspx" class="btn btn-sm"
                                    style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3); text-decoration:none;">✕</a>
                            </li>
                            <li class="task-item">
                                <div class="task-info">
                                    <div class="task-name">📍 Salón de invitados</div>
                                    <div class="task-meta">Mañana 20:00 → Mañana 23:30</div>
                                </div>
                                <span class="status-badge active">confirmada</span>
                                <a href="Registro.aspx" class="btn btn-sm"
                                    style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3); text-decoration:none;">✕</a>
                            </li>
                        </ul>

                        <div class="glass-card"
                            style="text-align: center; padding: 2rem; margin-top:24px; background:linear-gradient(135deg, rgba(239,246,255,0.8), rgba(219,234,254,0.8)); border:1px solid #bfdbfe; box-shadow:0 10px 15px -3px rgba(59,130,246,0.1);">
                            <div style="font-size: 2.5rem; margin-bottom: 8px;">📅</div>
                            <h3 style="color: var(--primary); font-size: 1.3rem; margin-bottom: 8px;">Evita conflictos
                                por las zonas comunes</h3>
                            <p
                                style="color: var(--text-secondary); max-width: 500px; margin: 0 auto 16px; font-size:0.9rem;">
                                Interactúa con el calendario en tiempo real para organizar los turnos de baño, lavadora
                                o visitas. Regístrate ahora para acceder.</p>
                            <a href="Registro.aspx" class="btn btn-primary"
                                style="font-size: 1rem; padding: 10px 20px; box-shadow:0 4px 6px rgba(37,99,235,0.2);">Regístrate
                                gratis</a>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlApp" runat="server">

                    <div class="glass-card" style="margin-bottom:24px;">
                        <h4 style="margin-top:0; color:var(--primary-light);">➕ Nueva reserva</h4>
                        <div style="display:flex; gap:12px; flex-wrap:wrap;">
                            <asp:TextBox ID="txtMotivo" runat="server" CssClass="form-input"
                                placeholder="Zona o motivo (ej: Lavadora, Salón)" style="flex:1; min-width:150px;" />
                            <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-input"
                                TextMode="DateTimeLocal" style="flex:1; min-width:180px;" />
                            <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-input" TextMode="DateTimeLocal"
                                style="flex:1; min-width:180px;" />
                            <asp:Button ID="btnReservar" runat="server" Text="Reservar"
                                CssClass="btn btn-primary btn-sm" OnClick="BtnReservar_Click" />
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

                </asp:Panel>
    </asp:Content>