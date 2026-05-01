<%@ Page Title="Mensajes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Mensajes.aspx.cs" Inherits="ConviAppWeb.Mensajes" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">📊 Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">✅ Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">💸 Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab active">💬 Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">📅 Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab">🔧 Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab">📄 Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">📎 Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">🏠 Mis Pisos</a>
        </div>

        <h2 style="margin-bottom:20px;">💬 Chat del Piso</h2>

        <% if (Session["UserRole"]==null || Session["UserRole"].ToString()=="Basico" ) { %>
            <div class="ad-slider-wrap"
                style="margin-bottom:24px; position:relative; background:white; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; display:flex; align-items:center; max-width:700px;">
                <div style="width:120px; height:80px; overflow:hidden; flex-shrink:0;">
                    <img src="https://images.unsplash.com/photo-1512428559087-560fa5ceab42?w=400&h=300&fit=crop"
                        style="width:100%; height:100%; object-fit:cover;" />
                </div>
                <div style="padding:16px; flex:1;">
                    <div
                        style="position:absolute; top:0; right:0; background:#f3f4f6; padding:2px 8px; font-size:0.7rem; font-weight:600; color:#6b7280; border-bottom-left-radius:6px;">
                        PUBLICIDAD</div>
                    <strong style="color:var(--primary); font-size:1.1rem; display:block; margin-bottom:4px;">Fibra
                        Óptica Compartida</strong>
                    <span style="color:#4b5563; font-size:0.9rem;">Mejora tu conexión con planes para
                        estudiantes.</span>
                </div>
            </div>
            <% } %>

                <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                    <div style="max-width:700px; position:relative;">
                        <div
                            style="display:flex; flex-direction:column; gap:12px; margin-bottom:20px; max-height:500px; overflow-y:auto; padding-right:8px; pointer-events:none;">
                            <div class="glass-card"
                                style="padding:14px 18px; border-left:3px solid var(--primary-light);">
                                <div
                                    style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
                                    <span style="font-weight:700; color:var(--primary-light);">Tú</span>
                                    <span style="color:var(--text-muted); font-size:0.8rem;">Hoy 10:00</span>
                                </div>
                                <p style="margin:0; color:var(--text-primary);">Hola chicas, he comprado papel
                                    higiénico.</p>
                            </div>
                            <div class="glass-card" style="padding:14px 18px;">
                                <div
                                    style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
                                    <span style="font-weight:700; color:var(--primary-light);">Compañero 1</span>
                                    <span style="color:var(--text-muted); font-size:0.8rem;">Hoy 10:15</span>
                                </div>
                                <p style="margin:0; color:var(--text-primary);">¡Genial, gracias! Luego te hago Bizum.
                                </p>
                            </div>
                        </div>

                        <div style="display:flex; gap:12px; margin-top:16px; pointer-events:none;">
                            <input type="text" class="form-input" placeholder="Escribe un mensaje..." style="flex:1;"
                                disabled />
                            <div class="btn btn-primary btn-sm">Enviar →</div>
                        </div>

                        <a href="Registro.aspx"
                            style="position:absolute; top:0; left:0; width:100%; height:100%; z-index:10; cursor:pointer;"
                            title="Inicia sesión para enviar mensajes al piso"></a>

                        <div class="glass-card"
                            style="text-align: center; padding: 2rem; margin-top:24px; background:linear-gradient(135deg, rgba(239,246,255,0.8), rgba(219,234,254,0.8)); border:1px solid #bfdbfe; box-shadow:0 10px 15px -3px rgba(59,130,246,0.1);">
                            <div style="font-size: 2.5rem; margin-bottom: 8px;">💬</div>
                            <h3 style="color: var(--primary); font-size: 1.3rem; margin-bottom: 8px;">Comunícate con tus
                                compañeros</h3>
                            <p
                                style="color: var(--text-secondary); max-width: 500px; margin: 0 auto 16px; font-size:0.9rem;">
                                Mantén un chat directo con tu piso. Olvídate del grupo de WhatsApp para quejas o turnos.
                                Regístrate gratis para empezar a charlar.</p>
                            <a href="Registro.aspx" class="btn btn-primary"
                                style="font-size: 1rem; padding: 10px 20px; box-shadow:0 4px 6px rgba(37,99,235,0.2);">Crear
                                mi cuenta gratis</a>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlApp" runat="server">

                    <div style="max-width:700px;">
                        <asp:Panel ID="pnlVacio" runat="server" Visible="false">
                            <div class="glass-card"
                                style="text-align:center; padding:3rem; color:var(--text-muted); margin-bottom:20px;">
                                <div style="font-size:3rem; margin-bottom:16px;">💬</div>
                                <p>No hay mensajes aún. ¡Sé el primero en escribir!</p>
                            </div>
                        </asp:Panel>

                        <asp:Repeater ID="rptMensajes" runat="server">
                            <HeaderTemplate>
                                <div
                                    style="display:flex; flex-direction:column; gap:12px; margin-bottom:20px; max-height:500px; overflow-y:auto; padding-right:8px;">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="glass-card"
                                    style='padding:14px 18px; <%# (bool)Eval("EsMio") ? "border-left:3px solid var(--primary-light);" : "" %>'>
                                    <div
                                        style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
                                        <span style="font-weight:700; color:var(--primary-light);">
                                            <%# (bool)Eval("EsMio") ? "Tú" : "Usuario #" + Eval("EmisorId") %>
                                        </span>
                                        <span style="color:var(--text-muted); font-size:0.8rem;">
                                            <%# ((DateTime)Eval("FechaEnvio")).ToString("g") %>
                                        </span>
                                    </div>
                                    <p style="margin:0; color:var(--text-primary);">
                                        <%# Eval("Contenido") %>
                                    </p>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                    </div>
                    </FooterTemplate>
                    </asp:Repeater>

                    <div style="display:flex; gap:12px; margin-top:16px;">
                        <asp:TextBox ID="txtMensaje" runat="server" CssClass="form-input"
                            placeholder="Escribe un mensaje..." style="flex:1;" />
                        <asp:Button ID="btnEnviar" runat="server" Text="Enviar →" CssClass="btn btn-primary btn-sm"
                            OnClick="BtnEnviar_Click" />
                    </div>
                    </div>
                </asp:Panel>
    </asp:Content>