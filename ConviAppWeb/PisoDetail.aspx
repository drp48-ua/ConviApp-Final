<%@ Page Title="Detalle de Piso" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="PisoDetail.aspx.cs" Inherits="ConviAppWeb.PisoDetail" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <asp:Panel ID="pnlNotFound" runat="server" Visible="false">
            <div class="glass-card"
                style="text-align:center; padding:3rem; color:var(--text-muted); max-width:600px; margin:0 auto;">
                <div style="font-size:3rem; margin-bottom:16px;">🏠</div>
                <h2>Piso no encontrado</h2>
                <p>El piso que buscas no existe o ha sido eliminado.</p>
                <a href="Pisos.aspx" class="btn btn-primary" style="margin-top:16px;">Ver todos los pisos</a>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlDetalle" runat="server" Visible="false">
            <div style="max-width:900px; margin:0 auto;">
                <div
                    style="aspect-ratio:16/6; border-radius:16px; overflow:hidden; margin-bottom:32px; position:relative;">
                    <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1200&q=80"
                        style="width:100%; height:100%; object-fit:cover;" alt="Piso" />
                    <div style="position:absolute; top:16px; left:16px;">
                        <span class="listing-badge">Disponible</span>
                    </div>
                </div>

                <div style="display:grid; grid-template-columns:2fr 1fr; gap:24px;">
                    <div>
                        <div class="glass-card">
                            <div class="listing-price"
                                style="font-size:2rem; font-weight:700; color:var(--primary-light); margin-bottom:8px;">
                                <asp:Label ID="lblPrecio" runat="server" /> € <span
                                    style="font-size:1rem; color:var(--text-muted); font-weight:400;">/mes</span>
                            </div>
                            <h2 style="margin-top:0;">
                                <asp:Label ID="lblDireccion" runat="server" />
                            </h2>
                            <div
                                style="display:flex; align-items:center; gap:8px; color:var(--text-secondary); margin-bottom:20px;">
                                <span>📍</span>
                                <asp:Label ID="lblCiudad" runat="server" />
                            </div>
                            <hr style="border:1px solid var(--border); margin:20px 0;" />
                            <div style="display:flex; gap:24px; margin-bottom:20px;">
                                <div style="text-align:center;">
                                    <div style="font-size:2rem;">🛏</div>
                                    <div style="font-weight:700; font-size:1.3rem;">
                                        <asp:Label ID="lblHabitaciones" runat="server" />
                                    </div>
                                    <div style="color:var(--text-muted); font-size:0.85rem;">Habitaciones</div>
                                </div>
                            </div>
                            <p style="color:var(--text-secondary);">Piso compartido ideal para estudiantes y
                                profesionales. Todas las zonas comunes incluidas. Precio total dividido entre los
                                inquilinos.</p>
                        </div>
                    </div>
                    <div>
                        <div class="glass-card">
                            <h4 style="margin-top:0; color:var(--primary-light);">¿Interesado?</h4>
                            <p style="color:var(--text-muted); font-size:0.9rem;">Regístrate para ver el contacto del
                                propietario y gestionar tu reserva.</p>
                            <% if (Session["UserEmail"]==null) { %>
                                <a href="Registro.aspx" class="btn btn-primary"
                                    style="width:100%; display:block; text-align:center; margin-bottom:12px;">Registrarse
                                    gratis</a>
                                <a href="Login.aspx" class="btn btn-outline"
                                    style="width:100%; display:block; text-align:center;">Iniciar sesión</a>
                                <% } else { %>
                                    <a href="Mensajes.aspx" class="btn btn-primary"
                                        style="width:100%; display:block; text-align:center; margin-bottom:12px;">💬
                                        Contactar</a>
                                    <a href="MisPisos.aspx" class="btn btn-outline"
                                        style="width:100%; display:block; text-align:center;">🏠 Mis Pisos</a>
                                    <% } %>
                        </div>
                    </div>
                </div>

                <div style="margin-top:24px;">
                    <a href="Pisos.aspx" style="color:var(--text-muted); text-decoration:none;">← Volver a todos los
                        pisos</a>
                </div>
            </div>
        </asp:Panel>
    </asp:Content>