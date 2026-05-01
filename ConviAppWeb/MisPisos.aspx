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

        <% if (Session["UserRole"]==null || Session["UserRole"].ToString()=="Basico" ) { %>
            <div class="ad-slider-wrap"
                style="margin-bottom:24px; position:relative; background:white; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; display:flex; align-items:center;">
                <div style="width:120px; height:80px; overflow:hidden; flex-shrink:0;">
                    <img src="https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=300&fit=crop"
                        style="width:100%; height:100%; object-fit:cover;" />
                </div>
                <div style="padding:16px; flex:1;">
                    <div
                        style="position:absolute; top:0; right:0; background:#f3f4f6; padding:2px 8px; font-size:0.7rem; font-weight:600; color:#6b7280; border-bottom-left-radius:6px;">
                        PUBLICIDAD</div>
                    <strong style="color:var(--primary); font-size:1.1rem; display:block; margin-bottom:4px;">IKEA
                        Home</strong>
                    <span style="color:#4b5563; font-size:0.9rem;">Amuebla tu piso en alquiler al mejor precio.</span>
                </div>
            </div>
            <% } %>

                <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                    <div style="position:relative;">
                        <div class="glass-card" style="margin-bottom:24px; position:relative; pointer-events:none;">
                            <h4 style="margin-top:0; color:var(--primary-light);">➕ Añadir piso</h4>
                            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                                <input type="text" class="form-input" placeholder="Dirección"
                                    style="flex:2; min-width:200px;" disabled />
                                <input type="text" class="form-input" placeholder="📍 Ciudad"
                                    style="flex:2; min-width:200px;" disabled />
                                <input type="text" class="form-input" placeholder="Habitaciones"
                                    style="flex:1; min-width:100px;" disabled />
                                <input type="text" class="form-input" placeholder="Precio Total €/mes"
                                    style="flex:1; min-width:120px;" disabled />
                                <div class="btn btn-primary btn-sm">Añadir</div>
                            </div>
                        </div>
                        <!-- OVERLAY PARA REDIRIGIR AL REGISTRO -->
                        <a href="Registro.aspx"
                            style="position:absolute; top:0; left:0; width:100%; height:120px; z-index:10; cursor:pointer;"
                            title="Regístrate para añadir propiedades"></a>

                        <div class="listings-grid">
                            <div class="listing-card" style="position:relative;">
                                <a href="Registro.aspx"
                                    style="position:absolute; top:0; left:0; right:0; bottom:0; z-index:2;"></a>
                                <div class="listing-img" style="position:relative; overflow:hidden; height:180px;">
                                    <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=600&q=80"
                                        style="position:absolute; top:0; left:0; width:100%; height:100%; object-fit:cover;"
                                        alt="Piso" />
                                    <span class="listing-badge">Activo</span>
                                </div>
                                <div class="listing-body">
                                    <div class="listing-price">
                                        1200,00 € <span>/mes</span>
                                    </div>
                                    <div class="listing-title">
                                        Calle de Gran Vía, 45
                                    </div>
                                    <div class="listing-location">📍 Madrid</div>
                                    <div class="listing-tags">
                                        <span class="listing-tag">🛏 4 hab.</span>
                                    </div>
                                </div>
                            </div>

                            <div class="listing-card" style="position:relative;">
                                <a href="Registro.aspx"
                                    style="position:absolute; top:0; left:0; right:0; bottom:0; z-index:2;"></a>
                                <div class="listing-img" style="position:relative; overflow:hidden; height:180px;">
                                    <img src="https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=600&q=80"
                                        style="position:absolute; top:0; left:0; width:100%; height:100%; object-fit:cover;"
                                        alt="Piso" />
                                    <span class="listing-badge" style="background:#6b7280;">Mantenimiento</span>
                                </div>
                                <div class="listing-body">
                                    <div class="listing-price">
                                        850,00 € <span>/mes</span>
                                    </div>
                                    <div class="listing-title">
                                        Avenida de la Constitución 12
                                    </div>
                                    <div class="listing-location">📍 Sevilla</div>
                                    <div class="listing-tags">
                                        <span class="listing-tag">🛏 3 hab.</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="glass-card"
                            style="text-align: center; padding: 2rem; margin-top:24px; background:linear-gradient(135deg, rgba(239,246,255,0.8), rgba(219,234,254,0.8)); border:1px solid #bfdbfe; box-shadow:0 10px 15px -3px rgba(59,130,246,0.1);">
                            <div style="font-size: 2.5rem; margin-bottom: 8px;">🏠</div>
                            <h3 style="color: var(--primary); font-size: 1.3rem; margin-bottom: 8px;">Descubre el panel
                                de Propietario</h3>
                            <p
                                style="color: var(--text-secondary); max-width: 500px; margin: 0 auto 16px; font-size:0.9rem;">
                                Administra todas tus propiedades con un solo clic. Para usar el formulario de "Añadir
                                piso" te invitamos a registrarte gratis.</p>
                            <a href="Registro.aspx" class="btn btn-primary"
                                style="font-size: 1rem; padding: 10px 20px; box-shadow:0 4px 6px rgba(37,99,235,0.2);">Regístrate
                                ahora</a>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlApp" runat="server">

                    <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-danger" Visible="false"
                        style="margin-bottom:20px; display:block;" />

                    <div class="glass-card" style="margin-bottom:24px;">
                        <h4 style="margin-top:0; color:var(--primary-light);">➕ Añadir piso</h4>
                        <div style="display:flex; gap:12px; flex-wrap:wrap;">
                            <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-input" placeholder="Dirección"
                                style="flex:2; min-width:200px;" />
                            <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-input" placeholder="📍 Ciudad"
                                style="flex:2; min-width:200px;" />
                            <asp:TextBox ID="txtHabitaciones" runat="server" CssClass="form-input"
                                placeholder="Habitaciones" TextMode="Number" style="flex:1; min-width:100px;" />
                            <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-input"
                                placeholder="Precio Total €/mes" TextMode="Number" style="flex:1; min-width:120px;" />
                            <asp:Button ID="btnAnadir" runat="server" Text="Añadir" CssClass="btn btn-primary btn-sm"
                                OnClick="BtnAnadir_Click" />
                        </div>
                    </div>

                    <asp:Panel ID="pnlVacio" runat="server" Visible="false">
                        <div class="glass-card" style="text-align:center; padding:3rem; color:var(--text-muted);">
                            <div style="font-size:3rem; margin-bottom:16px;">🏠</div>
                            <p>No tienes pisos gestionados todavía.</p>
                            <a href="Pisos.aspx" class="btn btn-primary btn-sm" style="margin-top:16px;">Ver
                                Catálogo</a>
                        </div>
                    </asp:Panel>

                    <asp:Repeater ID="rptPisos" runat="server">
                        <HeaderTemplate>
                            <div class="listings-grid">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="listing-card">
                                <div class="listing-img" style="position:relative; overflow:hidden; height:180px;">
                                    <img src='<%# "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=600&q=80&sig=" + Eval("Id") %>'
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

                </asp:Panel>
    </asp:Content>