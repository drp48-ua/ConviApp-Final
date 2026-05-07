<%@ Page Title="Planes y Precios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Upgrade.aspx.cs" Inherits="ConviAppWeb.Upgrade" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .plans-hero { text-align:center; padding:3rem 1rem 2rem; }
    .plans-hero h1 { font-size:2.6rem; font-weight:800; margin-bottom:.6rem; }
    .plans-hero p  { color:var(--text-muted); font-size:1.1rem; max-width:600px; margin:0 auto; }
    .plans-grid    { display:grid; grid-template-columns:repeat(auto-fit,minmax(290px,1fr)); gap:28px; max-width:1150px; margin:0 auto; padding:0 1rem 4rem; }

    .plan-card { background:var(--glass-bg); border:1px solid var(--border); border-radius:18px; padding:2rem 1.8rem; position:relative; display:flex; flex-direction:column; transition:transform .22s, box-shadow .22s; }
    .plan-card:hover { transform:translateY(-5px); box-shadow:0 16px 36px rgba(0,0,0,.14); }
    .plan-card.featured { border:2px solid var(--primary); box-shadow:0 0 0 4px rgba(37,99,235,.08); }
    .plan-card.enterprise { border-top:4px solid #7c3aed; }

    .plan-badge { position:absolute; top:-13px; left:50%; transform:translateX(-50%); background:var(--primary); color:#fff; padding:5px 18px; border-radius:20px; font-size:.73rem; font-weight:700; white-space:nowrap; letter-spacing:.5px; }
    .plan-name  { font-size:1.4rem; font-weight:800; margin-bottom:.15rem; }
    .plan-sub   { color:var(--text-muted); font-size:.88rem; margin-bottom:.8rem; }
    .plan-price { font-size:2.6rem; font-weight:800; line-height:1; margin-bottom:.2rem; }
    .plan-price small { font-size:1rem; font-weight:400; color:var(--text-muted); }
    .plan-tagline { font-size:.82rem; color:var(--text-muted); margin-bottom:1.2rem; min-height:36px; }

    .plan-section-title { font-size:.7rem; font-weight:700; text-transform:uppercase; letter-spacing:1px; color:var(--text-muted); margin:1rem 0 .6rem; }
    .feature { display:flex; align-items:flex-start; gap:9px; margin-bottom:9px; font-size:.88rem; line-height:1.4; }
    .feature .fi { flex-shrink:0; width:18px; text-align:center; }
    .feature.ok   { color:var(--text-secondary); }
    .feature.no   { color:var(--text-muted); opacity:.55; }
    .feature.star { color:#1d4ed8; font-weight:600; }

    .plan-hr { border:none; border-top:1px solid var(--border); margin:1.2rem 0; }
    .plan-cta { margin-top:auto; padding-top:1.4rem; }
    .badge-current { display:inline-block; background:rgba(52,211,153,.15); border:1px solid rgba(52,211,153,.4); color:#065f46; padding:7px 18px; border-radius:20px; font-size:.85rem; font-weight:700; text-align:center; width:100%; }
    .plan-note { font-size:.75rem; color:var(--text-muted); margin-top:8px; text-align:center; }
</style>

<div class="plans-hero">
    <h1>💎 Planes y Precios</h1>
    <p>Transparencia total. Sin letra pequeña. Elige el plan que encaje con tu vida en el piso y cancela cuando quieras.</p>
    <% if (Session["UserRole"] != null && Session["UserRole"].ToString() != "Basico") { %>
    <div style="display:inline-block; margin-top:1.2rem; background:rgba(52,211,153,.12); border:1px solid rgba(52,211,153,.35); color:#065f46; padding:9px 22px; border-radius:20px; font-size:.9rem; font-weight:600;">
        ✅ Tu plan actual: <strong><%= Session["UserRole"] %></strong> &nbsp;·&nbsp; <a href="Index.aspx" style="color:#065f46;">Ir al panel</a>
    </div>
    <% } %>
</div>

<div class="plans-grid">

    <%-- ═══════════════════════════════
         PLAN BÁSICO — GRATUITO
    ═══════════════════════════════ --%>
    <div class="plan-card">
        <div class="plan-name" style="color:var(--text-secondary);">🆓 Plan Básico</div>
        <div class="plan-sub">Para curiosos y nuevos usuarios</div>
        <div class="plan-price" style="color:var(--text-secondary);">€0 <small>/mes</small></div>
        <div class="plan-tagline">Acceso gratuito y permanente. Sin tarjeta de crédito.</div>

        <div class="plan-section-title">Lo que puedes hacer</div>
        <div class="feature ok"><span class="fi">✅</span><span>Ver el <strong>panel de resumen</strong> con el estado general del piso</span></div>
        <div class="feature ok"><span class="fi">✅</span><span>Consultar las <strong>tareas del piso</strong> (modo lectura)</span></div>
        <div class="feature ok"><span class="fi">✅</span><span>Ver los <strong>gastos compartidos</strong> que otros han registrado</span></div>
        <div class="feature ok"><span class="fi">✅</span><span>Consultar las <strong>reservas de zonas comunes</strong></span></div>
        <div class="feature ok"><span class="fi">✅</span><span>Leer el <strong>historial de mensajes</strong> del chat del piso</span></div>
        <div class="feature ok"><span class="fi">✅</span><span>Explorar la <strong>sección de pisos disponibles</strong></span></div>

        <div class="plan-section-title">Limitaciones</div>
        <div class="feature no"><span class="fi">🔒</span><span>No puedes <strong>crear ni gestionar incidencias</strong> (averías, reparaciones…)</span></div>
        <div class="feature no"><span class="fi">🔒</span><span>No puedes <strong>añadir gastos</strong> al piso</span></div>
        <div class="feature no"><span class="fi">🔒</span><span>No puedes <strong>enviar mensajes</strong> en el chat</span></div>
        <div class="feature no"><span class="fi">🔒</span><span>Sin acceso a <strong>contratos ni documentos</strong></span></div>
        <div class="feature no"><span class="fi">🔒</span><span>Sin acceso a <strong>Mis Pisos</strong> (no puedes publicar ni gestionar pisos)</span></div>
        <div class="feature no"><span class="fi">📢</span><span>Verás <strong>anuncios publicitarios</strong> en todas las secciones</span></div>

        <div class="plan-hr"></div>
        <div class="plan-cta">
            <% if (Session["UserRole"] == null || Session["UserRole"].ToString() == "Basico") { %>
            <div class="badge-current">✅ Tu plan actual</div>
            <% } else { %>
            <div style="text-align:center; color:var(--text-muted); font-size:.85rem;">Plan base incluido en todos los niveles</div>
            <% } %>
        </div>
    </div>


    <%-- ═══════════════════════════════
         PLAN PROFESIONAL
    ═══════════════════════════════ --%>
    <asp:Panel ID="pnlProfesional" runat="server" CssClass="plan-card featured">
        <div class="plan-badge">⭐ MÁS POPULAR</div>
        <div class="plan-name" style="color:var(--primary);">🚀 Plan Profesional</div>
        <div class="plan-sub">Para inquilinos activos y gestores de piso</div>
        <div class="plan-price" style="color:var(--primary);">€4.99 <small>/mes</small></div>
        <div class="plan-tagline">Todo lo que necesitas para gestionar tu piso de forma completa, sin complicaciones.</div>

        <div class="plan-section-title">Todo el Plan Básico, más…</div>
        <div class="feature star"><span class="fi">🔧</span><span><strong>Incidencias completas</strong> — crea, describe y haz seguimiento de averías (calefacción, grifos, electrodomésticos…)</span></div>
        <div class="feature star"><span class="fi">💸</span><span><strong>Gestión de gastos</strong> — registra los gastos compartidos del piso (luz, agua, internet, compra…)</span></div>
        <div class="feature star"><span class="fi">💬</span><span><strong>Chat del piso</strong> — envía y recibe mensajes con tus compañeros en tiempo real</span></div>
        <div class="feature star"><span class="fi">📄</span><span><strong>Contratos</strong> — guarda y gestiona contratos de arrendamiento (hasta 3 contratos activos)</span></div>
        <div class="feature star"><span class="fi">📁</span><span><strong>Documentos</strong> — adjunta y organiza documentos del piso: facturas, inventarios, DNI del casero… (hasta 10 archivos)</span></div>
        <div class="feature ok"><span class="fi">🗓️</span><span>Reserva y gestiona <strong>zonas comunes</strong> (lavandería, sala de reuniones, parking…)</span></div>
        <div class="feature ok"><span class="fi">🔔</span><span><strong>Notificaciones</strong> cuando el admin resuelve una incidencia tuya o te envía un mensaje</span></div>
        <div class="feature ok"><span class="fi">🚫</span><span><strong>Sin anuncios publicitarios</strong> en ninguna sección</span></div>

        <div class="plan-hr"></div>
        <asp:Label ID="lblErrPro" runat="server" ForeColor="Red" Visible="false" style="margin-bottom:10px; display:block;" />
        <div class="plan-cta">
            <% if (Session["UserEmail"] != null) { %>
                <% if (Session["UserRole"] != null && (Session["UserRole"].ToString() == "Profesional" || Session["UserRole"].ToString() == "Enterprise")) { %>
                <div class="badge-current">✅ Plan activo</div>
                <% } else { %>
                <div style="display:flex; gap:10px; flex-wrap:wrap; margin-bottom:8px;">
                    <asp:TextBox ID="txtIBANPro" runat="server" CssClass="form-input" placeholder="IBAN simulado (mín. 10 caracteres)" style="flex:1; min-width:160px;" />
                    <asp:Button ID="btnPro" runat="server" Text="Activar ✈" CssClass="btn btn-primary" OnClick="BtnPro_Click" />
                </div>
                <div class="plan-note">🔒 Pago simulado — introduce cualquier texto de más de 10 caracteres como IBAN</div>
                <% } %>
            <% } else { %>
                <asp:Button ID="btnProAnon" runat="server" Text="Regístrate y activa Pro →" CssClass="btn btn-primary" OnClick="BtnPro_Click" style="width:100%;" />
                <div class="plan-note">Crea tu cuenta gratis y activa el plan en segundos</div>
            <% } %>
        </div>
    </asp:Panel>


    <%-- ═══════════════════════════════
         PLAN ENTERPRISE
    ═══════════════════════════════ --%>
    <div class="plan-card enterprise">
        <div class="plan-name" style="color:#7c3aed;">🏢 Plan Enterprise</div>
        <div class="plan-sub">Para empresas inmobiliarias y gestores profesionales</div>
        <div class="plan-price" style="color:#7c3aed;">€19.99 <small>/mes</small></div>
        <div class="plan-tagline">Diseñado para quienes gestionan múltiples propiedades de forma profesional y a escala.</div>

        <div class="plan-section-title">Todo el Plan Profesional, más…</div>
        <div class="feature star"><span class="fi">🏘️</span><span><strong>Pisos ilimitados</strong> — publica y gestiona todos tus inmuebles sin restricción de número</span></div>
        <div class="feature star"><span class="fi">📁</span><span><strong>Documentos ilimitados</strong> — almacena contratos, inventarios, escrituras y más sin límite de archivos</span></div>
        <div class="feature star"><span class="fi">📄</span><span><strong>Contratos ilimitados</strong> — gestiona todos los arrendamientos activos que necesites simultáneamente</span></div>
        <div class="feature star"><span class="fi">👥</span><span><strong>Múltiples inquilinos</strong> por piso — asigna y gestiona varios perfiles de inquilinos en cada propiedad</span></div>
        <div class="feature ok"><span class="fi">📊</span><span>Acceso a <strong>métricas e informes</strong> de rentabilidad, ocupación y rendimiento de tus propiedades</span></div>
        <div class="feature ok"><span class="fi">📤</span><span>Exportación de <strong>informes financieros</strong> en formato texto (para contabilidad o asesorías)</span></div>
        <div class="feature ok"><span class="fi">⚡</span><span><strong>Soporte prioritario</strong> — tiempo de respuesta garantizado en menos de 24h laborables</span></div>
        <div class="feature ok"><span class="fi">🔒</span><span>Entorno <strong>completamente libre de anuncios</strong></span></div>

        <div style="background:rgba(124,58,237,.06); border:1px solid rgba(124,58,237,.2); border-radius:10px; padding:12px 14px; margin:1rem 0; font-size:.82rem; color:#5b21b6; line-height:1.5;">
            ℹ️ <strong>Nota:</strong> El panel de administración es exclusivo del equipo de ConviApp. Las cuentas Enterprise no tienen acceso a herramientas internas de la plataforma, sino a funcionalidades avanzadas de gestión de sus propias propiedades.
        </div>

        <div class="plan-hr"></div>
        <div class="plan-cta">
            <% if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Enterprise") { %>
            <div class="badge-current" style="background:rgba(124,58,237,.12);border-color:rgba(124,58,237,.35);color:#5b21b6;">✅ Plan Enterprise activo</div>
            <% } else { %>
            <a href="Contacto.aspx" class="btn btn-primary" style="background:#7c3aed; border-color:#7c3aed; display:block; text-align:center; text-decoration:none; padding:12px 16px; border-radius:8px;">
                Contactar para contratar →
            </a>
            <div class="plan-note">Nos pondremos en contacto contigo en menos de 24h</div>
            <% } %>
        </div>
    </div>

</div>

<div style="text-align:center; color:var(--text-muted); font-size:.82rem; padding-bottom:2rem;">
    ¿Dudas? <a href="Contacto.aspx" style="color:var(--primary);">Escríbenos</a> &nbsp;·&nbsp;
    <a href="Index.aspx" style="color:var(--text-muted);">← Volver al panel</a>
</div>

</asp:Content>
