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
                <asp:Repeater ID="rptComunidades" runat="server" OnItemCommand="rptComunidades_ItemCommand">
                    <ItemTemplate>
                        <div style="background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:1.5rem; transition:box-shadow 0.2s; position:relative;"
                             onmouseover="this.style.boxShadow='0 10px 25px -5px rgba(0,0,0,0.1), 0 8px 10px -6px rgba(0,0,0,0.1)'"
                             onmouseout="this.style.boxShadow='none'">
                            
                            <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:12px;">
                                <h3 style="font-size:1.25rem; font-weight:700; color:#111827; margin:0;"><%# Eval("Nombre") != null && !string.IsNullOrEmpty(Eval("Nombre").ToString()) ? Eval("Nombre") : "Comunidad #" + Eval("Id") %></h3>
                                <span style="background:#eff6ff; color:#1d4ed8; padding:4px 10px; border-radius:20px; font-size:0.75rem; font-weight:600; font-family:monospace;" title="Código de invitación">
                                    <%# Eval("CodigoComunidad") %>
                                </span>
                            </div>
                            
                            <p style="color:#6b7280; font-size:0.9rem; margin-bottom:4px;">📍 <%# Eval("Ciudad") %></p>
                            <p style="color:#9ca3af; font-size:0.8rem; margin-bottom:8px; margin-left:18px;"><%# Eval("Direccion") %></p>
                            
                            <p style="color:#4b5563; font-size:0.9rem; margin-bottom:16px; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden;">
                                <%# Eval("Descripcion") %>
                            </p>

                            <asp:LinkButton ID="btnEntrar" runat="server" CommandName="Entrar" CommandArgument='<%# Eval("Id") %>' 
                                CssClass="btn btn-outline" style="width:100%; display:block; text-align:center;">
                                Entrar a la comunidad ➔
                            </asp:LinkButton>
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
