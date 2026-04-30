<%@ Page Title="Mis Pisos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="MisPisos.aspx.cs" Inherits="ConviAppWeb.MisPisos" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">📊 Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">✅ Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">💸 Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab">💬 Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">📅 Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab">🔧 Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab">📄 Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">📎 Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab active">🏠 Mis Pisos</a>
        </div>

        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
            <h2>🏠 Mis Pisos</h2>
        </div>

        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-danger" Visible="false"
            style="margin-bottom:20px; display:block;" />

        <div class="glass-card" style="margin-bottom:24px;">
            <h4 style="margin-top:0; color:var(--primary-light);">➕ Añadir piso</h4>
            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-input" placeholder="Dirección"
                    style="flex:2; min-width:200px;" />
                <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-input" placeholder="📍 Ciudad"
                    style="flex:2; min-width:200px;" />
                <asp:TextBox ID="txtHabitaciones" runat="server" CssClass="form-input" placeholder="Habitaciones"
                    TextMode="Number" style="flex:1; min-width:100px;" />
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-input" placeholder="Precio Total €/mes"
                    TextMode="Number" style="flex:1; min-width:120px;" />
                <asp:Button ID="btnAnadir" runat="server" Text="Añadir" CssClass="btn btn-primary btn-sm"
                    OnClick="BtnAnadir_Click" />
            </div>
        </div>

        <asp:Panel ID="pnlVacio" runat="server" Visible="false">
            <div class="glass-card" style="text-align:center; padding:3rem; color:var(--text-muted);">
                <div style="font-size:3rem; margin-bottom:16px;">🏠</div>
                <p>No tienes pisos gestionados todavía.</p>
                <a href="Pisos.aspx" class="btn btn-primary btn-sm" style="margin-top:16px;">Ver Catálogo</a>
            </div>
        </asp:Panel>

        <asp:Repeater ID="rptPisos" runat="server">
            <HeaderTemplate>
                <div class="listings-grid">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="listing-card">
                    <div class="listing-img" style="position:relative; overflow:hidden; height:180px;">
                        <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=600&q=80"
                            style="position:absolute; top:0; left:0; width:100%; height:100%; object-fit:cover;"
                            alt="Piso" />
                        <span class="listing-badge">Activo</span>
                    </div>
                    <div class="listing-body">
                        <div class="listing-price">
                            <%# ((decimal)Eval("PrecioTotal")).ToString("0.00") %> € <span>/mes</span>
                        </div>
                        <div class="listing-title">
                            <%# Eval("Direccion") ?? "Piso" %>
                        </div>
                        <div class="listing-location">📍 <%# Eval("Ciudad") ?? "" %>
                        </div>
                        <div class="listing-tags">
                            <span class="listing-tag">🛏 <%# Eval("NumeroHabitaciones") %> hab.</span>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Content>