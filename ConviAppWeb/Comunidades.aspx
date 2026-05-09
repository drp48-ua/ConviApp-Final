<%@ Page Title="Mis Comunidades" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Comunidades.aspx.cs" Inherits="ConviAppWeb.Comunidades" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width:1000px; margin:2rem auto; padding:0 1rem;">
        <h1 style="font-size:2rem; font-weight:800; color:#1e3a8a; margin-bottom:1.5rem;">Mis Comunidades</h1>
        
        <asp:Panel ID="pnlDemo" runat="server" Visible="false" CssClass="alert alert-warning" style="background:#fffbeb; color:#92400e; padding:1rem; border-radius:8px; border:1px solid #fcd34d;">
            ⚠️ Inicia sesión para gestionar y unirte a comunidades.
        </asp:Panel>

        <asp:Panel ID="pnlApp" runat="server">
            
            <asp:Label ID="lblMsg" runat="server" Visible="false" style="display:block; padding:1rem; border-radius:8px; margin-bottom:1rem; font-weight:600;"></asp:Label>

            <!-- Acciones -->
            <div style="display:flex; gap:16px; margin-bottom:2rem; flex-wrap:wrap;">
                <button type="button" class="btn btn-primary" onclick="window.location.href='Pisos.aspx?crear=1'">+ Crear nueva comunidad</button>
                <button type="button" class="btn btn-outline" onclick="document.getElementById('modalUnir').style.display='flex'">🔑 Unirse con código</button>
            </div>

            <!-- Listado de comunidades -->
            <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(300px, 1fr)); gap:20px;">
                <asp:Repeater ID="rptComunidades" runat="server" OnItemCommand="rptComunidades_ItemCommand" OnItemDataBound="rptComunidades_ItemDataBound">
                    <ItemTemplate>
                        <div style="background:linear-gradient(to bottom right, #ffffff, #f8fafc); border:1px solid #e2e8f0; border-radius:16px; padding:1.5rem; transition:all 0.3s ease; position:relative; overflow:hidden;"
                             onmouseover="this.style.boxShadow='0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)'; this.style.transform='translateY(-4px)'"
                             onmouseout="this.style.boxShadow='0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)'; this.style.transform='none'">
                            
                            <!-- Header Decorativo Privado -->
                            <asp:Panel runat="server" Visible='<%# Convert.ToBoolean(Eval("EsPrivado")) %>' style="position:absolute; top:0; left:0; right:0; height:4px; background:var(--accent);"></asp:Panel>

                            <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:12px;">
                                <h3 style="font-size:1.35rem; font-weight:800; color:#0f172a; margin:0; display:flex; align-items:center; gap:6px;">
                                    <%# Convert.ToBoolean(Eval("EsPrivado")) ? "🔒" : "🏘️" %>
                                    <%# Eval("Nombre") != null && !string.IsNullOrEmpty(Eval("Nombre").ToString()) ? Eval("Nombre") : "Comunidad #" + Eval("Id") %>
                                </h3>
                                <span style="background:#eff6ff; color:#1d4ed8; padding:4px 10px; border-radius:20px; font-size:0.75rem; font-weight:700; font-family:monospace; box-shadow:inset 0 0 0 1px rgba(29, 78, 216, 0.2);" title="Código de invitación">
                                    <%# Eval("CodigoComunidad") %>
                                </span>
                            </div>
                            
                            <div style="display:flex; align-items:center; gap:6px; color:#475569; font-size:0.9rem; margin-bottom:4px;">
                                <span style="font-size:1rem;">📍</span> <span style="font-weight:600;"><%# Eval("Ciudad") %></span>
                            </div>
                            <p style="color:#94a3b8; font-size:0.8rem; margin-bottom:12px; margin-left:22px;"><%# Eval("Direccion") %></p>
                            
                            <p style="color:#334155; font-size:0.9rem; margin-bottom:16px; line-height:1.5; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden; border-left:3px solid #cbd5e1; padding-left:10px;">
                                <%# string.IsNullOrEmpty(Convert.ToString(Eval("Descripcion"))) ? "Sin descripción" : Eval("Descripcion") %>
                            </p>

                            <!-- Lista de Miembros -->
                            <div style="margin-bottom:16px; background:#f1f5f9; border-radius:8px; padding:12px; border:1px solid #e2e8f0;">
                                <h4 style="font-size:0.8rem; font-weight:700; color:#64748b; margin-bottom:8px; text-transform:uppercase; letter-spacing:0.05em;">👥 Integrantes</h4>
                                <div style="display:flex; flex-direction:column; gap:6px;">
                                    <asp:Repeater ID="rptMiembros" runat="server" OnItemCommand="rptMiembros_ItemCommand">
                                        <ItemTemplate>
                                            <div style="display:flex; justify-content:space-between; align-items:center; background:white; padding:6px 10px; border-radius:6px; border:1px solid #e2e8f0; font-size:0.85rem; color:#334155;">
                                                <div style="display:flex; align-items:center; gap:6px;">
                                                    <div style="width:24px; height:24px; border-radius:50%; background:linear-gradient(135deg, var(--primary), var(--primary-light)); color:white; display:flex; align-items:center; justify-content:center; font-weight:bold; font-size:0.7rem;">
                                                        <%# Eval("Nombre") != null && Eval("Nombre").ToString().Length > 0 ? Eval("Nombre").ToString().Substring(0,1).ToUpper() : "?" %>
                                                    </div>
                                                    <span><%# Eval("Nombre") %> <%# Eval("Apellidos") %></span>
                                                </div>
                                                <asp:LinkButton ID="btnExpulsar" runat="server" CommandName="Expulsar" 
                                                    CommandArgument='<%# DataBinder.Eval(((RepeaterItem)Container.Parent.Parent).DataItem, "Id") + "_" + Eval("Id") %>'
                                                    Visible="false"
                                                    style="color:#ef4444; font-size:1rem; text-decoration:none; transition:transform 0.1s;" 
                                                    onmouseover="this.style.transform='scale(1.2)'" onmouseout="this.style.transform='scale(1)'"
                                                    title="Expulsar usuario" OnClientClick="return confirm('¿Seguro que deseas expulsar a este usuario de la comunidad?');">
                                                    ❌
                                                </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>

                            <div style="display:flex; gap:8px;">
                                <asp:LinkButton ID="btnEntrar" runat="server" CommandName="Entrar" CommandArgument='<%# Eval("Id") %>' 
                                    CssClass="btn btn-primary" style="flex:1.5; display:flex; align-items:center; justify-content:center; gap:8px; padding:12px; font-weight:600; border-radius:8px; box-shadow:0 4px 6px -1px rgba(var(--primary-rgb), 0.2);">
                                    Entrar <span style="font-size:1.1rem;">➔</span>
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnAbandonar" runat="server" CommandName="Abandonar" CommandArgument='<%# Eval("Id") %>'
                                    Visible='<%# Convert.ToInt32(Eval("PropietarioId")) != Convert.ToInt32(Session["UserId"]) %>'
                                    CssClass="btn btn-outline" style="flex:1; display:flex; align-items:center; justify-content:center; padding:12px; font-weight:600; border-radius:8px; color:#ef4444; border-color:#ef4444; background:white;"
                                    OnClientClick="return confirm('¿Seguro que deseas abandonar esta comunidad?');" ToolTip="Abandonar Comunidad">
                                    🚪 Salir
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnBorrar" runat="server" CommandName="Borrar" CommandArgument='<%# Eval("Id") %>'
                                    Visible='<%# Convert.ToInt32(Eval("PropietarioId")) == Convert.ToInt32(Session["UserId"]) %>'
                                    CssClass="btn btn-outline" style="flex:1; display:flex; align-items:center; justify-content:center; padding:12px; font-weight:600; border-radius:8px; color:#ef4444; border-color:#ef4444; background:white;"
                                    OnClientClick="return confirm('¿Seguro que deseas BORRAR toda la comunidad?');" ToolTip="Borrar Comunidad">
                                    🗑️ Borrar
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlVacio" runat="server" Visible="false" style="text-align:center; padding:4rem 2rem; background:#f9fafb; border-radius:12px; border:2px dashed #d1d5db; margin-top:2rem;">
                <div style="font-size:3rem; margin-bottom:1rem;">🏠</div>
                <h3 style="color:#374151; font-weight:600; margin-bottom:0.5rem;">Aún no estás en ninguna comunidad</h3>
                <p style="color:#6b7280;">Crea una nueva o únete usando el código de invitación que te hayan pasado.</p>
            </asp:Panel>

        </asp:Panel>

        <!-- Modal Crear Comunidad -->
        <div id="modalCrear" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:50; align-items:center; justify-content:center;">
            <div style="background:#fff; padding:2rem; border-radius:12px; width:90%; max-width:500px; position:relative; max-height:90vh; overflow-y:auto;">
                <button type="button" onclick="document.getElementById('modalCrear').style.display='none'" style="position:absolute; top:16px; right:16px; background:none; border:none; font-size:1.5rem; cursor:pointer; color:#6b7280;">&times;</button>
                <h2 style="font-size:1.5rem; font-weight:700; color:#111827; margin-bottom:1.5rem;">Crear Comunidad</h2>
                
                <div style="margin-bottom:1rem;">
                    <label style="display:block; font-size:0.875rem; font-weight:600; color:#374151; margin-bottom:0.5rem;">Nombre de la comunidad</label>
                    <asp:TextBox ID="txtNombreComunidad" runat="server" CssClass="form-control" style="width:100%; padding:0.75rem; border:1px solid #d1d5db; border-radius:8px;" placeholder="Ej: Piso Malasaña, Casa de la Playa..."></asp:TextBox>
                </div>

                <div style="margin-bottom:1rem;">
                    <label style="display:block; font-size:0.875rem; font-weight:600; color:#374151; margin-bottom:0.5rem;">Dirección del piso</label>
                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" style="width:100%; padding:0.75rem; border:1px solid #d1d5db; border-radius:8px;" placeholder="Ej: Calle Principal 123"></asp:TextBox>
                </div>
                
                <div style="margin-bottom:1rem;">
                    <label style="display:block; font-size:0.875rem; font-weight:600; color:#374151; margin-bottom:0.5rem;">Ciudad</label>
                    <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-control" style="width:100%; padding:0.75rem; border:1px solid #d1d5db; border-radius:8px;" placeholder="Ej: Madrid"></asp:TextBox>
                </div>

                <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px; margin-bottom:1rem;">
                    <div>
                        <label style="display:block; font-size:0.875rem; font-weight:600; color:#374151; margin-bottom:0.5rem;">Habitaciones</label>
                        <asp:TextBox ID="txtHabitaciones" runat="server" TextMode="Number" CssClass="form-control" style="width:100%; padding:0.75rem; border:1px solid #d1d5db; border-radius:8px;" placeholder="3"></asp:TextBox>
                    </div>
                    <div>
                        <label style="display:block; font-size:0.875rem; font-weight:600; color:#374151; margin-bottom:0.5rem;">Precio (€)</label>
                        <asp:TextBox ID="txtPrecio" runat="server" TextMode="Number" step="0.01" CssClass="form-control" style="width:100%; padding:0.75rem; border:1px solid #d1d5db; border-radius:8px;" placeholder="800"></asp:TextBox>
                    </div>
                </div>

                <div style="margin-bottom:1.5rem;">
                    <label style="display:block; font-size:0.875rem; font-weight:600; color:#374151; margin-bottom:0.5rem;">Descripción de la comunidad</label>
                    <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" style="width:100%; padding:0.75rem; border:1px solid #d1d5db; border-radius:8px;" placeholder="Normas del piso, ambiente, etc..."></asp:TextBox>
                </div>
                
                <asp:Button ID="btnCrearComunidad" runat="server" Text="Crear y generar código" CssClass="btn btn-primary" style="width:100%; padding:12px;" OnClick="btnCrearComunidad_Click" />
            </div>
        </div>

        <!-- Modal Unirse Comunidad -->
        <div id="modalUnir" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:50; align-items:center; justify-content:center;">
            <div style="background:#fff; padding:2rem; border-radius:12px; width:90%; max-width:400px; position:relative;">
                <button type="button" onclick="document.getElementById('modalUnir').style.display='none'" style="position:absolute; top:16px; right:16px; background:none; border:none; font-size:1.5rem; cursor:pointer; color:#6b7280;">&times;</button>
                <h2 style="font-size:1.5rem; font-weight:700; color:#111827; margin-bottom:0.5rem;">Unirse a Comunidad</h2>
                <p style="color:#6b7280; font-size:0.9rem; margin-bottom:1.5rem;">Pídele a un compañero el código de invitación de 8 caracteres.</p>
                
                <div style="margin-bottom:1.5rem;">
                    <asp:TextBox ID="txtCodigoUnir" runat="server" CssClass="form-control" style="width:100%; padding:1rem; border:2px solid #e5e7eb; border-radius:8px; font-family:monospace; font-size:1.2rem; text-align:center; letter-spacing:2px; text-transform:uppercase;" placeholder="XXXXXXXX" MaxLength="8"></asp:TextBox>
                </div>
                
                <asp:Button ID="btnUnirse" runat="server" Text="Unirse a la comunidad" CssClass="btn btn-primary" style="width:100%; padding:12px;" OnClick="btnUnirse_Click" />
            </div>
        </div>

    </div>
</asp:Content>
