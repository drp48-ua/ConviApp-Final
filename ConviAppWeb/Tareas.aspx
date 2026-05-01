<%@ Page Title="Tareas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Tareas.aspx.cs"
    Inherits="ConviAppWeb.Tareas" %>
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

        <% if (Session["UserRole"]==null || Session["UserRole"].ToString()=="Basico" ) { %>
            <div class="ad-slider-wrap"
                style="margin-bottom:24px; position:relative; background:white; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; display:flex; align-items:center;">
                <div style="width:120px; height:80px; overflow:hidden; flex-shrink:0;">
                    <img src="https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=400&h=300&fit=crop"
                        style="width:100%; height:100%; object-fit:cover;" />
                </div>
                <div style="padding:16px; flex:1;">
                    <div
                        style="position:absolute; top:0; right:0; background:#f3f4f6; padding:2px 8px; font-size:0.7rem; font-weight:600; color:#6b7280; border-bottom-left-radius:6px;">
                        PUBLICIDAD</div>
                    <strong style="color:var(--primary); font-size:1.1rem; display:block; margin-bottom:4px;">Limpieza a
                        Domicilio</strong>
                    <span style="color:#4b5563; font-size:0.9rem;">-10% en tu primer servicio de limpieza.</span>
                </div>
            </div>
            <% } %>

                <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                    <div style="position:relative;">
                        <div class="glass-card" style="margin-bottom:24px; position:relative; pointer-events:none;">
                            <h4 style="margin-top:0; color:var(--primary-light);">➕ Nueva tarea</h4>
                            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                                <input type="text" class="form-input" placeholder="Título de la tarea"
                                    style="flex:2; min-width:200px;" disabled />
                                <input type="text" class="form-input" placeholder="Descripción (opcional)"
                                    style="flex:2; min-width:200px;" disabled />
                                <select class="form-input" style="flex:1; min-width:120px;" disabled>
                                    <option>🟡 Media</option>
                                </select>
                                <div class="btn btn-primary btn-sm">Añadir</div>
                            </div>
                        </div>
                        <!-- OVERLAY PARA REDIRIGIR AL REGISTRO -->
                        <a href="Registro.aspx"
                            style="position:absolute; top:0; left:0; width:100%; height:120px; z-index:10; cursor:pointer;"
                            title="Regístrate para añadir tareas"></a>

                        <ul class="task-list">
                            <li class="task-item">
                                <a href="Registro.aspx"
                                    style="background:none; border:none; font-size:1.2rem; padding:0 8px; text-decoration:none;">⬜</a>
                                <div class="task-info">
                                    <div class="task-name">Limpiar la cocina a fondo</div>
                                    <div class="task-meta">Horno, nevera y microondas.</div>
                                </div>
                                <span class="task-priority high">Alta</span>
                                <a href="Registro.aspx" class="btn btn-sm"
                                    style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3); text-decoration:none;">🗑</a>
                            </li>
                            <li class="task-item completed">
                                <a href="Registro.aspx"
                                    style="background:none; border:none; font-size:1.2rem; padding:0 8px; text-decoration:none;">✅</a>
                                <div class="task-info">
                                    <div class="task-name" style="text-decoration:line-through; opacity:0.5;">Comprar
                                        productos de limpieza</div>
                                    <div class="task-meta">Lejía, friegasuelos y bayetas.</div>
                                </div>
                                <span class="task-priority medium">Media</span>
                                <a href="Registro.aspx" class="btn btn-sm"
                                    style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3); text-decoration:none;">🗑</a>
                            </li>
                        </ul>

                        <div class="glass-card"
                            style="text-align: center; padding: 2rem; margin-top:24px; background:linear-gradient(135deg, rgba(239,246,255,0.8), rgba(219,234,254,0.8)); border:1px solid #bfdbfe; box-shadow:0 10px 15px -3px rgba(59,130,246,0.1);">
                            <div style="font-size: 2.5rem; margin-bottom: 8px;">🚀</div>
                            <h3 style="color: var(--primary); font-size: 1.3rem; margin-bottom: 8px;">Estás en modo
                                Demostración</h3>
                            <p
                                style="color: var(--text-secondary); max-width: 500px; margin: 0 auto 16px; font-size:0.9rem;">
                                Interactúa con los botones o intenta añadir una tarea. Para utilizar la app real y
                                guardar los cambios, regístrate.</p>
                            <a href="Registro.aspx" class="btn btn-primary"
                                style="font-size: 1rem; padding: 10px 20px; box-shadow:0 4px 6px rgba(37,99,235,0.2);">Crear
                                mi cuenta gratis</a>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlApp" runat="server">

                    <div class="glass-card" style="margin-bottom:24px;">
                        <h4 style="margin-top:0; color:var(--primary-light);">➕ Nueva tarea</h4>
                        <div style="display:flex; gap:12px; flex-wrap:wrap;">
                            <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-input"
                                placeholder="Título de la tarea" style="flex:2; min-width:200px;" />
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-input"
                                placeholder="Descripción (opcional)" style="flex:2; min-width:200px;" />
                            <asp:DropDownList ID="ddlPrioridad" runat="server" CssClass="form-input"
                                style="flex:1; min-width:120px;">
                                <asp:ListItem Value="baja">🟢 Baja</asp:ListItem>
                                <asp:ListItem Value="media" Selected="True">🟡 Media</asp:ListItem>
                                <asp:ListItem Value="alta">🔴 Alta</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Button ID="btnAnadir" runat="server" Text="Añadir" CssClass="btn btn-primary btn-sm"
                                OnClick="BtnAnadir_Click" />
                        </div>
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"
                            style="margin-top:8px; display:block;" />
                    </div>

                    <asp:Panel ID="pnlVacio" runat="server" Visible="false">
                        <div class="glass-card" style="text-align:center; padding:3rem; color:var(--text-muted);">
                            <div style="font-size:3rem; margin-bottom:16px;">✅</div>
                            <p>No hay tareas pendientes. ¡Todo al día!</p>
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptTareas" runat="server" OnItemCommand="RptTareas_ItemCommand">
                        <HeaderTemplate>
                            <ul class="task-list">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li class="task-item <%# (string)Eval(" Estado")=="completada" ? "completed" : "" %>">
                                <asp:LinkButton ID="btnToggle" runat="server" CommandName="Toggle"
                                    CommandArgument='<%# Eval("Id") %>'
                                    style="background:none; border:none; cursor:pointer; font-size:1.2rem; padding:0 8px; color:inherit;">
                                    <%# (string)Eval("Estado")=="completada" ? "✅" : "⬜" %>
                                </asp:LinkButton>
                                <div class="task-info">
                                    <div class="task-name"
                                        style='<%# (string)Eval("Estado") == "completada" ? "text-decoration:line-through; opacity:0.5;" : "" %>'>
                                        <%# Eval("Titulo") %>
                                    </div>
                                    <div class="task-meta">
                                        <%# Eval("Descripcion") ?? "" %>
                                    </div>
                                </div>
                                <span
                                    class='task-priority <%# (string)Eval("Prioridad") == "alta" ? "high" : (string)Eval("Prioridad") == "media" ? "medium" : "low" %>'>
                                    <%# Eval("Prioridad") ?? "Normal" %>
                                </span>
                                <asp:LinkButton ID="btnEliminar" runat="server" CommandName="Eliminar"
                                    CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm"
                                    style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3);"
                                    OnClientClick="return confirm('¿Eliminar esta tarea?')">🗑</asp:LinkButton>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>

                </asp:Panel>
    </asp:Content>