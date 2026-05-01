<%@ Page Title="Incidencias" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Incidencias.aspx.cs" Inherits="ConviAppWeb.Incidencias" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">&#128202; Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">&#9989; Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">&#128182; Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab">&#9993; Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">&#128197; Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab active">🔧 Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab">&#128196; Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">&#128206; Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">&#127968; Mis Pisos</a>
        </div>

        <h2 style="margin-bottom:20px;">🔧 Incidencias</h2>

        <% if (Session["UserRole"]==null || Session["UserRole"].ToString()=="Basico" ) { %>
            <div class="ad-slider-wrap"
                style="margin-bottom:24px; position:relative; background:white; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; display:flex; align-items:center;">
                <div style="width:120px; height:80px; overflow:hidden; flex-shrink:0;">
                    <img src="https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400&h=300&fit=crop"
                        style="width:100%; height:100%; object-fit:cover;" />
                </div>
                <div style="padding:16px; flex:1;">
                    <div
                        style="position:absolute; top:0; right:0; background:#f3f4f6; padding:2px 8px; font-size:0.7rem; font-weight:600; color:#6b7280; border-bottom-left-radius:6px;">
                        PUBLICIDAD</div>
                    <strong style="color:var(--primary); font-size:1.1rem; display:block; margin-bottom:4px;">Asistencia
                        Hogar 24h</strong>
                    <span style="color:#4b5563; font-size:0.9rem;">Reparamos cualquier imprevisto sin franquicia.</span>
                </div>
            </div>
            <% } %>

                <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                    <div style="position:relative;">
                        <div class="glass-card" style="margin-bottom:24px; position:relative; pointer-events:none;">
                            <h4 style="margin-top:0; color:var(--primary-light);">➕ Reportar incidencia</h4>
                            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                                <input type="text" class="form-input" placeholder="Título"
                                    style="flex:1; min-width:200px;" disabled />
                                <input type="text" class="form-input" placeholder="Descripción detallada"
                                    style="flex:2; min-width:200px;" disabled />
                                <div class="btn btn-primary btn-sm">Reportar</div>
                            </div>
                        </div>
                        <!-- OVERLAY PARA REDIRIGIR AL REGISTRO -->
                        <a href="Registro.aspx"
                            style="position:absolute; top:0; left:0; width:100%; height:120px; z-index:10; cursor:pointer;"
                            title="Regístrate para reportar incidencias"></a>

                        <ul class="task-list">
                            <li class="task-item">
                                <div class="task-info">
                                    <div class="task-name">Calefacción rota</div>
                                    <div class="task-meta">El radiador del salón no enciende y hace mucho frío. · Hoy
                                    </div>
                                </div>
                                <span class="status-badge open">abierta</span>
                                <a href="Registro.aspx" class="btn btn-sm"
                                    style="background:rgba(245,158,11,0.1);color:#f59e0b;border:1px solid rgba(245,158,11,0.3);text-decoration:none;">▶
                                    En progreso</a>
                            </li>
                            <li class="task-item">
                                <div class="task-info">
                                    <div class="task-name">Grifo de la cocina gotea</div>
                                    <div class="task-meta">El fontanero llegó por la mañana y lo arregló. · Ayer</div>
                                </div>
                                <span class="status-badge done">resuelta</span>
                            </li>
                        </ul>

                        <div class="glass-card"
                            style="text-align: center; padding: 2rem; margin-top:24px; background:linear-gradient(135deg, rgba(239,246,255,0.8), rgba(219,234,254,0.8)); border:1px solid #bfdbfe; box-shadow:0 10px 15px -3px rgba(59,130,246,0.1);">
                            <div style="font-size: 2.5rem; margin-bottom: 8px;">🔧</div>
                            <h3 style="color: var(--primary); font-size: 1.3rem; margin-bottom: 8px;">Mantén la
                                comunicación fluida con el casero</h3>
                            <p
                                style="color: var(--text-secondary); max-width: 500px; margin: 0 auto 16px; font-size:0.9rem;">
                                Registra cualquier incidencia, haz seguimiento de reparaciones y avisa a los inquilinos.
                                Crea una cuenta para gestionar tu piso de verdad.</p>
                            <a href="Registro.aspx" class="btn btn-primary"
                                style="font-size: 1rem; padding: 10px 20px; box-shadow:0 4px 6px rgba(37,99,235,0.2);">Regístrate
                                ahora gratis</a>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlApp" runat="server">

                    <div class="glass-card" style="margin-bottom:24px;">
                        <h4 style="margin-top:0; color:var(--primary-light);">➕ Reportar incidencia</h4>
                        <div style="display:flex; gap:12px; flex-wrap:wrap;">
                            <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-input" placeholder="Título"
                                style="flex:1; min-width:200px;" />
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-input"
                                placeholder="Descripción detallada" style="flex:2; min-width:200px;" />
                            <asp:Button ID="btnReportar" runat="server" Text="Reportar"
                                CssClass="btn btn-primary btn-sm" OnClick="BtnReportar_Click" />
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
                                        <%# Eval("Descripcion") ?? "" %> · <%#
                                                ((DateTime)Eval("FechaReporte")).ToShortDateString() %>
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

                </asp:Panel>
    </asp:Content>

