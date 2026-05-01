<%@ Page Title="Pisos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Pisos.aspx.cs"
    Inherits="ConviAppWeb.Pisos" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 32px; display:flex; justify-content:space-between; align-items:center;">
            <div>
                <h1 style="font-size: 2.5rem; margin-bottom: 8px;">Encuentra tu piso ideal</h1>
                <p style="color: var(--text-muted);">
                    <asp:Label ID="lblSumaPisos" runat="server"></asp:Label> disponibles en la plataforma.
                </p>
            </div>
            <asp:Button ID="btnNuevo" runat="server" Text="+ Añadir Piso" CssClass="btn btn-primary"
                OnClick="BtnNuevo_Click" />
        </div>

        <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="glass-card"
            style="margin-bottom:20px; padding:20px;">
            <h3 style="margin-bottom:12px; color:var(--primary);">Nuevo Piso</h3>
            <div style="display:flex; gap:12px; margin-bottom:12px;">
                <asp:TextBox ID="txtDir" runat="server" CssClass="form-input" placeholder="Dirección" style="flex:2;" />
                <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-input" placeholder="Ciudad" style="flex:1;" />
            </div>
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary"
                OnClick="BtnGuardar_Click" />
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline"
                OnClick="BtnCancelar_Click" CausesValidation="false" />
        </asp:Panel>

        <!-- Filters Map -->
        <div class="glass-card" style="margin-bottom: 32px; padding: 20px;">
            <div style="display: flex; gap: 12px; flex-wrap: wrap; align-items: end;">
                <div style="flex: 2; min-width: 160px;">
                    <label style="color: var(--text-muted); font-size: 0.8rem; margin-bottom: 4px; display: block;">📍
                        Ciudad</label>
                    <asp:TextBox ID="txtFiltroCiudad" runat="server" CssClass="form-input"
                        placeholder="Ej: Madrid, Valencia..." />
                </div>
                <div style="flex: 1; min-width: 120px;">
                    <label style="color: var(--text-muted); font-size: 0.8rem; margin-bottom: 4px; display: block;">€
                        Precio mín.</label>
                    <asp:TextBox ID="txtFiltroMin" runat="server" TextMode="Number" CssClass="form-input"
                        placeholder="0" step="50" />
                </div>
                <div style="flex: 1; min-width: 120px;">
                    <label style="color: var(--text-muted); font-size: 0.8rem; margin-bottom: 4px; display: block;">€
                        Precio máx.</label>
                    <asp:TextBox ID="txtFiltroMax" runat="server" TextMode="Number" CssClass="form-input"
                        placeholder="2000" step="50" />
                </div>
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary btn-sm"
                    style="align-self: flex-end;" OnClick="BtnBuscar_Click" />
            </div>
        </div>

        <asp:Panel ID="pnlVacio" runat="server" Visible="false">
            <div class="glass-card" style="text-align: center; padding: 4rem; color: var(--text-muted);">
                <div style="font-size: 3rem; margin-bottom: 16px;">🏚️</div>
                <h3>Sin resultados</h3>
                <p>No hemos encontrado pisos con esos filtros.</p>
            </div>
        </asp:Panel>

        <div class="listings-grid">
            <asp:Repeater ID="rptPisos" runat="server">
                <ItemTemplate>
                    <a href="PisoDetail.aspx?id=<%# Eval(" Id") %>" class="listing-card">
                        <div class="listing-img" style="position:relative; overflow:hidden;">
                            <img src='<%# "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=600&q=80&sig=" + Eval("Id") %>'
                                style="position:absolute; top:0; left:0; width:100%; height:100%; object-fit:cover;"
                                alt="Portada Piso" />
                            <span class="listing-badge">
                                <%# (bool)Eval("Disponible") ? "Disponible" : "Ocupado" %>
                            </span>
                            <button class="wishlist-btn" onclick="event.preventDefault();">♡</button>
                        </div>
                        <div class="listing-body">
                            <div class="listing-price">
                                <%# Eval("PrecioTotal", "{0:0}" ) %>€ <span>/mes</span>
                            </div>
                            <div class="listing-title">
                                <%# Eval("Direccion") ?? "Piso" %>
                            </div>
                            <div class="listing-location">📍 <%# Eval("Ciudad") ?? "Ciudad" %>
                            </div>
                            <div class="listing-tags">
                                <span class="listing-tag">🛏️ <%# Eval("NumeroHabitaciones") %> hab.</span>
                                <span class="listing-tag listing-tag-arrow">Ver detalles →</span>
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </asp:Content>