<%@ Page Title="Gestión de Pisos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="AdminPisos.aspx.cs" Inherits="ConviAppWeb.AdminPisos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 24px; display:flex; justify-content:space-between; align-items:center;">
        <div>
            <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Administración de Pisos</h2>
            <p style="color: #6b7280;">Añade pisos privados por contrato, o revisa los pisos públicos de la app.</p>
        </div>
        <button type="button" class="btn btn-primary" onclick="document.getElementById('pnlCrearPisoPrivado').style.display='block';">+ Añadir Comunidad Privada</button>
    </div>

    <asp:Label ID="lblMsg" runat="server" Visible="false" style="display:block; padding:1rem; border-radius:8px; margin-bottom:1rem; font-weight:600;"></asp:Label>

    <!-- FORMULARIO PISO PRIVADO (Oculto por defecto) -->
    <div id="pnlCrearPisoPrivado" class="glass-card" style="display:none; padding: 24px; margin-bottom:24px; border:2px solid var(--primary-light);">
        <h3 style="margin-bottom:16px; color:var(--primary);">🏢 Crear Piso Privado (Con Contrato)</h3>
        
        <div style="margin-bottom:12px;">
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre del Piso/Comunidad" style="width:100%; padding:10px; border-radius:6px; border:1px solid #ccc;" />
        </div>

        <div style="display:flex; gap:12px; margin-bottom:12px; flex-wrap:wrap;">
            <asp:TextBox ID="txtDir" runat="server" CssClass="form-control" placeholder="Dirección completa" style="flex:2; min-width:200px; padding:10px; border-radius:6px; border:1px solid #ccc;" />
            <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-control" placeholder="Ciudad" style="flex:1; min-width:150px; padding:10px; border-radius:6px; border:1px solid #ccc;" />
        </div>
        
        <div style="margin-bottom:12px;">
            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" placeholder="Descripción de la propiedad" TextMode="MultiLine" Rows="3" style="width:100%; padding:10px; border-radius:6px; border:1px solid #ccc;" />
        </div>

        <div style="display:flex; gap:16px; margin-bottom:16px; align-items:center; flex-wrap:wrap;">
            <div style="display:flex; align-items:center; gap:8px;">
                <span style="font-size:1.2rem;">🛏️</span>
                <label style="color:var(--text-secondary); font-size:0.9rem;">Habitaciones:</label>
                <asp:TextBox ID="txtHabitaciones" runat="server" CssClass="form-control" TextMode="Number" Text="1" style="width:65px; padding:8px; text-align:center; border:1px solid #ccc; border-radius:6px;" />
            </div>
            <div style="display:flex; align-items:center; gap:8px;">
                <span style="font-size:1.2rem;">🚿</span>
                <label style="color:var(--text-secondary); font-size:0.9rem;">Aseos:</label>
                <asp:TextBox ID="txtBanos" runat="server" CssClass="form-control" TextMode="Number" Text="1" style="width:65px; padding:8px; text-align:center; border:1px solid #ccc; border-radius:6px;" />
            </div>
            <div style="display:flex; align-items:center; gap:8px;">
                <span style="font-size:1.2rem;">🍳</span>
                <label style="color:var(--text-secondary); font-size:0.9rem;">Cocinas:</label>
                <asp:TextBox ID="txtCocinas" runat="server" CssClass="form-control" TextMode="Number" Text="1" style="width:65px; padding:8px; text-align:center; border:1px solid #ccc; border-radius:6px;" />
            </div>
            <div style="display:flex; align-items:center; gap:8px;">
                <span style="font-size:1.2rem;">🚗</span>
                <label style="color:var(--text-secondary); font-size:0.9rem;">Garajes:</label>
                <asp:TextBox ID="txtGarajes" runat="server" CssClass="form-control" TextMode="Number" Text="0" style="width:65px; padding:8px; text-align:center; border:1px solid #ccc; border-radius:6px;" />
            </div>
            <div style="display:flex; align-items:center; gap:8px;">
                <label style="color:var(--text-secondary); font-size:0.9rem; font-weight:bold;">Precio/Mes (€):</label>
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number" step="0.01" Text="800" style="width:100px; padding:8px; border:1px solid #ccc; border-radius:6px;" />
            </div>
        </div>

        <div style="display:flex; gap:20px; margin-bottom:16px; flex-wrap:wrap; background:#f9fafb; padding:16px; border-radius:8px; border:1px solid #e5e7eb;">
            <div style="flex:1; min-width:250px;">
                <label style="color:var(--text-secondary); font-size:0.85rem; display:block; margin-bottom:6px; font-weight:bold;">👤 Propietario (Usuario asignado)</label>
                <asp:DropDownList ID="ddlPropietarios" runat="server" CssClass="form-control" style="width:100%; padding:8px; border-radius:6px; border:1px solid #ccc;">
                </asp:DropDownList>
            </div>
            <div style="flex:1; min-width:250px;">
                <label style="color:var(--text-secondary); font-size:0.85rem; display:block; margin-bottom:6px; font-weight:bold;">📄 Documento Contrato (PDF/Img)</label>
                <asp:FileUpload ID="fuContrato" runat="server" CssClass="form-control" style="padding:6px; width:100%; background:white; border-radius:6px; border:1px solid #ccc;" />
            </div>
            <div style="flex:1; min-width:250px;">
                <label style="color:var(--text-secondary); font-size:0.85rem; display:block; margin-bottom:6px; font-weight:bold;">📷 Foto Piso (Opcional)</label>
                <asp:FileUpload ID="fuFotoPiso" runat="server" CssClass="form-control" style="padding:6px; width:100%; background:white; border-radius:6px; border:1px solid #ccc;" />
            </div>
        </div>

        <div style="display:flex; gap:12px;">
            <asp:Button ID="btnGuardarPrivado" runat="server" Text="✅ Guardar Piso y Contrato" CssClass="btn btn-primary" OnClick="BtnGuardarPrivado_Click" />
            <button type="button" class="btn btn-outline" onclick="document.getElementById('pnlCrearPisoPrivado').style.display='none'">Cancelar</button>
        </div>
    </div>

    <!-- PISOS PRIVADOS -->
    <h3 style="margin-top:32px; margin-bottom:16px; color:#1f2937; border-bottom:2px solid #e5e7eb; padding-bottom:8px;">🔒 Pisos Privados (Gestión Admin)</h3>
    <div style="margin-bottom:32px; display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 16px;">
        <asp:Repeater ID="rptPisosPrivados" runat="server">
            <ItemTemplate>
                <div class="glass-card" style="padding:16px; border-left:4px solid var(--accent);">
                    <h4 style="margin-bottom:8px;"><%# Eval("Nombre") != null && !string.IsNullOrEmpty(Eval("Nombre").ToString()) ? Eval("Nombre") : "Piso #" + Eval("Id") %></h4>
                    <p style="font-size:0.85rem; color:#6b7280; margin-bottom:12px;">
                        <strong>Ciudad:</strong> <%# Eval("Ciudad") %><br />
                        <strong>Dirección:</strong> <%# Eval("Direccion") %><br />
                        <strong>Precio:</strong> <%# Eval("PrecioTotal") %>€/mes<br />
                        <strong>Habitaciones:</strong> <%# Eval("NumeroHabitaciones") %>
                    </p>
                    <div style="display:flex; gap:8px;">
                        <a href="AdminPagos.aspx" class="btn btn-sm" style="background:#f3f4f6; color:#374151; border:1px solid #d1d5db;">Ver Contrato ➔</a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Label ID="lblNoPrivados" runat="server" Visible="false" style="grid-column: 1 / -1; color:#6b7280; font-style:italic;">No hay pisos privados registrados.</asp:Label>
    </div>

    <!-- PISOS PÚBLICOS APP -->
    <h3 style="margin-top:32px; margin-bottom:16px; color:#1f2937; border-bottom:2px solid #e5e7eb; padding-bottom:8px;">📱 Pisos Públicos (Creados en App)</h3>
    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 16px;">
        <asp:Repeater ID="rptPisosApp" runat="server">
            <ItemTemplate>
                <div class="glass-card" style="padding:16px; border-left:4px solid var(--primary-light);">
                    <h4 style="margin-bottom:8px;"><%# Eval("Nombre") != null && !string.IsNullOrEmpty(Eval("Nombre").ToString()) ? Eval("Nombre") : "Comunidad #" + Eval("Id") %></h4>
                    <p style="font-size:0.85rem; color:#6b7280; margin-bottom:12px;">
                        <strong>Ciudad:</strong> <%# Eval("Ciudad") %><br />
                        <strong>Dirección:</strong> <%# Eval("Direccion") %><br />
                        <strong>Habitaciones:</strong> <%# Eval("NumeroHabitaciones") %><br />
                        <strong>Precio:</strong> <%# Eval("PrecioTotal") %>€
                    </p>
                    <div style="display:flex; gap:8px;">
                        <a href="PisoDetail.aspx?id=<%# Eval("Id") %>" class="btn btn-sm btn-outline">Ver Detalle</a>
                        <button type="button" class="btn btn-sm" style="background:#ef4444; color:white;">Suspender</button>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Label ID="lblNoPublicos" runat="server" Visible="false" style="grid-column: 1 / -1; color:#6b7280; font-style:italic;">No hay pisos públicos registrados.</asp:Label>
    </div>

</asp:Content>
