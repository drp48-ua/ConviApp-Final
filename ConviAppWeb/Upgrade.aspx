<%@ Page Title="Planes y Precios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Upgrade.aspx.cs" Inherits="ConviAppWeb.Upgrade" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .plans-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(280px,1fr)); gap:24px; max-width:1100px; margin:0 auto; }
        .plan-card { background:var(--glass-bg); border:1px solid var(--border); border-radius:16px; padding:2rem; position:relative; transition:transform .2s, box-shadow .2s; }
        .plan-card:hover { transform:translateY(-4px); box-shadow:0 12px 30px rgba(0,0,0,.15); }
        .plan-card.featured { border-color:var(--primary); box-shadow:0 0 0 2px rgba(37,99,235,.2); }
        .plan-badge { position:absolute; top:-12px; left:50%; transform:translateX(-50%); background:var(--primary); color:white; padding:4px 16px; border-radius:20px; font-size:0.75rem; font-weight:700; white-space:nowrap; }
        .plan-price { font-size:2.4rem; font-weight:800; margin:1rem 0 0.2rem; }
        .plan-price span { font-size:1rem; font-weight:400; color:var(--text-muted); }
        .plan-feature { display:flex; align-items:flex-start; gap:10px; margin-bottom:10px; font-size:0.92rem; color:var(--text-secondary); }
        .plan-feature .icon { flex-shrink:0; font-size:1rem; margin-top:1px; }
        .plan-feature.locked { color:var(--text-muted); opacity:.6; }
        .plan-separator { border:none; border-top:1px solid var(--border); margin:1.2rem 0; }
    </style>

    <div style="padding:3rem 1rem;">
        <div style="text-align:center; margin-bottom:2.5rem;">
            <h1 style="font-size:2.4rem; margin-bottom:.5rem;">💎 Planes y Precios</h1>
            <p style="color:var(--text-muted); font-size:1.1rem; max-width:560px; margin:0 auto;">
                Elige el plan que mejor se adapta a tu situación. Sin permanencia, cancela cuando quieras.
            </p>

            <% if (Session["UserRole"] != null && Session["UserRole"].ToString() != "Basico") { %>
            <div style="display:inline-block; margin-top:1rem; background:rgba(52,211,153,.15); border:1px solid rgba(52,211,153,.4); color:#065f46; padding:8px 20px; border-radius:20px; font-size:.9rem; font-weight:600;">
                ✅ Tu plan actual: <strong><%= Session["UserRole"] %></strong>
            </div>
            <% } %>
        </div>

        <div class="plans-grid">

            <%-- ══ PLAN BÁSICO ══ --%>
            <div class="plan-card">
                <div style="font-size:1.5rem; margin-bottom:.3rem;">🆓</div>
                <div style="font-size:1.3rem; font-weight:700;">Plan Básico</div>
                <div style="color:var(--text-muted); font-size:.9rem;">Para empezar gratis</div>
                <div class="plan-price" style="color:var(--text-secondary);">€0<span>/mes</span></div>
                <hr class="plan-separator" />
                <div class="plan-feature"><span class="icon">✅</span> Acceso al panel de resumen</div>
                <div class="plan-feature"><span class="icon">✅</span> Ver tareas del piso</div>
                <div class="plan-feature"><span class="icon">✅</span> Ver gastos compartidos (lectura)</div>
                <div class="plan-feature"><span class="icon">✅</span> Mensajes del piso (lectura)</div>
                <div class="plan-feature"><span class="icon">✅</span> Ver reservas del piso</div>
                <div class="plan-feature locked"><span class="icon">🔒</span> Crear incidencias (bloqueado)</div>
                <div class="plan-feature locked"><span class="icon">🔒</span> Añadir gastos (bloqueado)</div>
                <div class="plan-feature locked"><span class="icon">🔒</span> Contratos y documentos (bloqueado)</div>
                <div class="plan-feature locked"><span class="icon">🔒</span> Enviar mensajes (bloqueado)</div>
                <hr class="plan-separator" />
                <% if (Session["UserRole"] == null || Session["UserRole"].ToString() == "Basico") { %>
                <div class="btn" style="width:100%;text-align:center;background:var(--glass-bg);color:var(--text-muted);border:1px solid var(--border);cursor:default;">Plan actual</div>
                <% } else { %>
                <div class="btn" style="width:100%;text-align:center;background:var(--glass-bg);color:var(--text-muted);border:1px solid var(--border);cursor:default;">Plan incluido</div>
                <% } %>
            </div>

            <%-- ══ PLAN PROFESIONAL ══ --%>
            <asp:Panel ID="pnlProfesional" runat="server" CssClass="plan-card featured">
                <div class="plan-badge">⭐ Más popular</div>
                <div style="font-size:1.5rem; margin-bottom:.3rem;">🚀</div>
                <div style="font-size:1.3rem; font-weight:700; color:var(--primary);">Plan Profesional</div>
                <div style="color:var(--text-muted); font-size:.9rem;">Para inquilinos y gestores</div>
                <div class="plan-price" style="color:var(--primary);">€4.99<span>/mes</span></div>
                <hr class="plan-separator" />
                <div class="plan-feature"><span class="icon">✅</span> Todo del plan Básico</div>
                <div class="plan-feature"><span class="icon">✅</span> <strong>Crear y gestionar incidencias</strong></div>
                <div class="plan-feature"><span class="icon">✅</span> <strong>Añadir y controlar gastos</strong></div>
                <div class="plan-feature"><span class="icon">✅</span> <strong>Enviar mensajes al piso</strong></div>
                <div class="plan-feature"><span class="icon">✅</span> Contratos de alquiler (hasta 3)</div>
                <div class="plan-feature"><span class="icon">✅</span> Documentos del piso (hasta 10)</div>
                <div class="plan-feature"><span class="icon">✅</span> Reservas de zonas comunes</div>
                <div class="plan-feature"><span class="icon">✅</span> Notificaciones en tiempo real</div>
                <hr class="plan-separator" />
                <asp:Label ID="lblErrPro" runat="server" ForeColor="Red" Visible="false" style="margin-bottom:10px; display:block;" />
                <% if (Session["UserEmail"] != null) { %>
                    <% if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Profesional") { %>
                    <div class="btn btn-primary" style="width:100%;text-align:center;cursor:default;opacity:.7;">✅ Plan activo</div>
                    <% } else { %>
                    <div style="display:flex; gap:10px; flex-wrap:wrap;">
                        <asp:TextBox ID="txtIBANPro" runat="server" CssClass="form-input" placeholder="IBAN simulado (>10 caracteres)" style="flex:1; min-width:160px;" />
                        <asp:Button ID="btnPro" runat="server" Text="Activar Pro →" CssClass="btn btn-primary" OnClick="BtnPro_Click" />
                    </div>
                    <div style="color:var(--text-muted);font-size:0.78rem;margin-top:8px;">🔒 Pago simulado — introduce cualquier IBAN de más de 10 caracteres</div>
                    <% } %>
                <% } else { %>
                    <asp:Button ID="btnProAnon" runat="server" Text="Regístrate para Activar →" CssClass="btn btn-primary" OnClick="BtnPro_Click" style="width:100%; justify-content:center;" />
                <% } %>
            </asp:Panel>

            <%-- ══ PLAN ENTERPRISE ══ --%>
            <div class="plan-card" style="border-top:4px solid var(--accent);">
                <div style="font-size:1.5rem; margin-bottom:.3rem;">🏢</div>
                <div style="font-size:1.3rem; font-weight:700; color:var(--accent);">Plan Enterprise</div>
                <div style="color:var(--text-muted); font-size:.9rem;">Para inmobiliarias y gestores pro</div>
                <div class="plan-price" style="color:var(--accent);">€19.99<span>/mes</span></div>
                <hr class="plan-separator" />
                <div class="plan-feature"><span class="icon">✅</span> Todo del plan Profesional</div>
                <div class="plan-feature"><span class="icon">✅</span> <strong>Pisos ilimitados</strong></div>
                <div class="plan-feature"><span class="icon">✅</span> <strong>Documentos ilimitados</strong></div>
                <div class="plan-feature"><span class="icon">✅</span> <strong>Contratos ilimitados</strong></div>
                <div class="plan-feature"><span class="icon">✅</span> Panel de analíticas y métricas</div>
                <div class="plan-feature"><span class="icon">✅</span> Acceso a panel de administración</div>
                <div class="plan-feature"><span class="icon">✅</span> Soporte prioritario 24h</div>
                <div class="plan-feature"><span class="icon">✅</span> Exportación de informes en PDF/TXT</div>
                <hr class="plan-separator" />
                <a href="Contacto.aspx" class="btn btn-primary" style="background:var(--accent); border-color:var(--accent); display:block; text-align:center; text-decoration:none; padding:12px;">
                    Solicitar Enterprise →
                </a>
            </div>

        </div>

        <div style="text-align:center; margin-top:2rem; color:var(--text-muted); font-size:.85rem;">
            ¿Preguntas? <a href="Contacto.aspx" style="color:var(--primary);">Contáctanos</a> ·
            <a href="Index.aspx" style="color:var(--text-muted); margin-left:8px;">← Volver al panel</a>
        </div>
    </div>

</asp:Content>
