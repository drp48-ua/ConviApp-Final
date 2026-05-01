<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Index.aspx.cs"
    Inherits="ConviAppWeb.Index" %>
    <asp:Content ID="HContent" ContentPlaceHolderID="HeadContent" runat="server">
        <!-- Hide global Site.Master right sidebar on Index: managed inside the page -->
        <style>
            .sidebar-right-global {
                display: none !important;
            }
        </style>
    </asp:Content>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <% var userEmail=Session["UserEmail"] as string; bool isLoggedIn=userEmail !=null; var
            userRole=Session["UserRole"] as string ?? "" ; bool showSidebarAds=!isLoggedIn || userRole=="Basico" ; bool
            _isDemo=!isLoggedIn; int _adSeed=Math.Abs(Request.Url.AbsolutePath.GetHashCode()) % 6; %>
            <style>
                /* Specific FlatManager Layout Styles */
                .dashboard-layout {
                    display: flex;
                    gap: 24px;
                    padding-top: 24px;
                    max-width: 1400px;
                    margin: 0 auto;
                }

                .sidebar-right {
                    width: 300px;
                    flex-shrink: 0;
                    display: flex;
                    flex-direction: column;
                }

                .sidebar-left {
                    width: 250px;
                    flex-shrink: 0;
                    display: flex;
                    flex-direction: column;
                }

                .flat-card {
                    background: white;
                    border-radius: 8px;
                    border: 1px solid #e5e7eb;
                    padding: 20px;
                    margin-bottom: 24px;
                    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
                }

                .profile-card {
                    text-align: center;
                }

                .profile-card img {
                    width: 64px;
                    height: 64px;
                    border-radius: 50%;
                    margin-bottom: 12px;
                }

                .profile-card h4 {
                    margin: 0 0 4px;
                    font-size: 1.1rem;
                }

                .profile-card p {
                    color: #6b7280;
                    font-size: 0.85rem;
                    margin-bottom: 16px;
                }

                .menu-link {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    padding: 10px 12px;
                    color: #4b5563;
                    text-decoration: none;
                    border-radius: 6px;
                    font-weight: 500;
                    margin-bottom: 4px;
                }

                .menu-link:hover {
                    background: #f3f4f6;
                    color: #1e3a8a;
                }

                .welcome-banner {
                    background: linear-gradient(135deg, #f0f4f8, #e0e7ff);
                    border: 1px solid #c7d2fe;
                    border-radius: 8px;
                    padding: 32px;
                    margin-bottom: 24px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .welcome-banner h2 {
                    margin: 0 0 8px;
                    color: #1e3a8a;
                }

                .welcome-banner p {
                    color: #4b5563;
                    margin-bottom: 20px;
                    max-width: 600px;
                }

                .services-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                    gap: 16px;
                    margin-bottom: 24px;
                }

                .service-card {
                    background: white;
                    border: 1px solid #e5e7eb;
                    border-radius: 8px;
                    padding: 16px;
                    text-align: center;
                    transition: all 0.2s;
                    cursor: pointer;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    text-decoration: none;
                    color: inherit;
                }

                .service-card:hover {
                    border-color: #3b82f6;
                    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                    transform: translateY(-2px);
                }

                .service-icon {
                    font-size: 2rem;
                    margin-bottom: 12px;
                }

                .service-card h4 {
                    margin: 0 0 8px;
                    font-size: 1rem;
                    color: #1f2937;
                }

                .service-card p {
                    font-size: 0.8rem;
                    color: #6b7280;
                    margin: 0;
                    line-height: 1.4;
                }

                .summary-grid {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 16px;
                    margin-bottom: 24px;
                }

                .summary-item {
                    background: #f9fafb;
                    border: 1px solid #f3f4f6;
                    border-radius: 8px;
                    padding: 16px;
                }

                .summary-item .label {
                    font-size: 0.85rem;
                    color: #6b7280;
                    font-weight: 500;
                }

                .summary-item .value {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: #111827;
                    margin: 4px 0;
                }

                .summary-item .trend {
                    font-size: 0.75rem;
                    color: #10b981;
                    font-weight: 500;
                }

                .tab-content {
                    display: none;
                }

                .tab-content.active {
                    display: block;
                    animation: fadeIn 0.3s ease;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(10px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                @media (max-width: 900px) {
                    .dashboard-layout {
                        flex-direction: column;
                    }

                    .sidebar-left,
                    .sidebar-right {
                        width: 100%;
                    }

                    .summary-grid {
                        grid-template-columns: 1fr;
                    }

                    .services-grid {
                        grid-template-columns: 1fr 1fr;
                    }
                }
            </style>

            <div class="dashboard-layout" style="align-items:flex-start;">
                <!-- LEFT SIDEBAR -->
                <div class="sidebar-left">
                    <% if (isLoggedIn) { %>
                        <div class="flat-card profile-card" style="margin-bottom: 24px;">
                            <svg width="64" height="64" viewBox="0 0 64 64"
                                style="display:block;margin:0 auto 12px;border-radius:50%;background:#e0e7ff;"
                                xmlns="http://www.w3.org/2000/svg">
                                <circle cx="32" cy="26" r="12" fill="#a5b4fc" />
                                <ellipse cx="32" cy="50" rx="20" ry="14" fill="#c7d2fe" />
                            </svg>
                            <h4>
                                <%= Session["UserName"] !=null ? Session["UserName"].ToString() : "Usuario" %>
                            </h4>
                            <p>
                                <%= userEmail %>
                            </p>
                            <a href="Upgrade.aspx" class="btn btn-outline btn-sm" style="width:100%">Mejorar
                                cuenta</a>
                        </div>

                        <div class="flat-card" style="padding: 16px; margin-bottom: 24px;">
                            <h4
                                style="font-size: 0.9rem; color: #6b7280; margin-bottom: 12px; font-weight: 600; text-transform: uppercase;">
                                Accesos rápidos</h4>
                            <a href="#tab-tareas" onclick="switchMainTab('tareas'); return false;"
                                class="menu-link"><span>✅</span> Mis tareas</a>
                            <a href="#tab-contratos" onclick="switchMainTab('contratos'); return false;"
                                class="menu-link"><span>🔧</span> Contratos</a>
                            <a href="#tab-reservas" onclick="switchMainTab('reservas'); return false;"
                                class="menu-link"><span>📅</span> Calendario</a>
                        </div>
                        <% } %>

                            <% if (showSidebarAds) { %>
                                <div style="flex-grow: 1; display: flex; flex-direction: column;">
                                    <div class="flat-card"
                                        style="background: linear-gradient(to bottom, #10b981, #059669); color: white; padding: 0; text-align: center; overflow: hidden; margin-bottom: 24px;">
                                        <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=300&q=80"
                                            style="width:100%; height:120px; object-fit:cover;" alt="Habitación" />
                                        <div style="padding: 16px;">
                                            <div
                                                style="font-size:0.6rem;color:rgba(255,255,255,0.7);letter-spacing:2px;margin-bottom:6px;">
                                                PUBLICIDAD</div>
                                            <h3 style="font-size: 1.2rem; margin-bottom: 8px;">Habitación Premium
                                            </h3>
                                            <p style="font-size: 0.85rem; color: #d1fae5; margin-bottom: 16px;">
                                                Encuentra las mejores habitaciones para estudiantes.</p>
                                            <a href="Registro.aspx" class="btn btn-outline btn-sm"
                                                style="color:white; border-color:rgba(255,255,255,0.4);">Registrarse
                                                gratis</a>
                                        </div>
                                    </div>

                                    <!-- Exceso de anuncios borrado para no desbordar la altura -->
                                </div>
                                <% } %>
                </div>

                <!-- MAIN INTERACTIVE AREA -->
                <div class="main-content">
                    <!-- TAB INICIO -->
                    <div id="tab-inicio" class="tab-content active">
                        <div class="welcome-banner">
                            <div>
                                <h2>¡Bienvenida a ConviApp!</h2>
                                <p>La forma más fácil de gestionar tu piso compartido de manera organizada.
                                </p>
                                <div style="display: flex; gap: 12px;">
                                    <button type="button" onclick="switchMainTab('pisos')" class="btn btn-primary">Ver
                                        mis pisos</button>
                                    <button type="button" onclick="switchMainTab('tareas')" class="btn btn-outline"
                                        style="background:white">Ir a mis
                                        tareas</button>
                                </div>
                            </div>
                        </div>

                        <h3 style="font-size: 1.1rem; margin-bottom: 16px; color: #1e3a8a;">Servicios
                            principales</h3>

                        <div class="services-grid">
                            <a href="#" onclick="switchMainTab('pisos'); return false;" class="service-card">
                                <div class="service-icon">🏠</div>
                                <h4>Pisos</h4>
                                <p>Consulta y gestiona los pisos disponibles.</p>
                            </a>
                            <a href="#" onclick="switchMainTab('contratos'); return false;" class="service-card">
                                <div class="service-icon">📄</div>
                                <h4>Contratos</h4>
                                <p>Gestiona los contratos y documentos.</p>
                            </a>
                            <a href="#" onclick="switchMainTab('tareas'); return false;" class="service-card">
                                <div class="service-icon">✅</div>
                                <h4>Tareas</h4>
                                <p>Organiza y asigna tareas del hogar.</p>
                            </a>
                            <a href="#" onclick="switchMainTab('reservas'); return false;" class="service-card">
                                <div class="service-icon">📅</div>
                                <h4>Reservas</h4>
                                <p>Reserva zonas y espacios comunes.</p>
                            </a>
                        </div>

                        <% if (isLoggedIn) { %>
                            <div class="flat-card">
                                <h3 style="font-size: 1.1rem; margin-bottom: 16px; color: #1e3a8a;">Resumen
                                    del mes</h3>
                                <div class="summary-grid">
                                    <div class="summary-item">
                                        <div class="label">Tareas completadas</div>
                                        <div class="value">12</div>
                                        <div class="trend" style="color:#6b7280">+3 esta semana</div>
                                    </div>
                                    <div class="summary-item">
                                        <div class="label">Incidencias abiertas</div>
                                        <div class="value" style="color:#ef4444">2</div>
                                        <div class="trend" style="color:#ef4444">-1 que el mes pasado</div>
                                    </div>
                                    <div class="summary-item">
                                        <div class="label">Reservas este mes</div>
                                        <div class="value">5</div>
                                        <div class="trend" style="color:#3b82f6"><a href="#"
                                                onclick="switchMainTab('reservas')">Ver calendario</a></div>
                                    </div>
                                </div>
                            </div>
                            <% } %>

                                <!-- PLANES DE SUSCRIPCIÓN -->
                                <% if (!isLoggedIn) { %>
                                    <div style="margin-top:32px;" id="planes">
                                        <h3 style="font-size:1.3rem;color:#1e3a8a;margin-bottom:6px;text-align:center;">
                                            📦 Nuestros planes</h3>
                                        <p style="color:#6b7280;text-align:center;margin-bottom:24px;font-size:0.9rem;">
                                            Elige el plan que mejor se adapte a ti. Sin permanencia.</p>
                                        <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:20px;">
                                            <!-- BÁSICO -->
                                            <div style="border:1px solid #e5e7eb;border-radius:12px;padding:24px;text-align:center;background:#fff;transition:box-shadow 0.2s;"
                                                onmouseover="this.style.boxShadow='0 8px 20px rgba(0,0,0,0.08)'"
                                                onmouseout="this.style.boxShadow='none'">
                                                <div style="font-size:2rem;margin-bottom:8px;">🏠</div>
                                                <h4 style="color:#1f2937;margin-bottom:4px;">Básico</h4>
                                                <div
                                                    style="font-size:2rem;font-weight:700;color:#111827;margin:12px 0;">
                                                    <span style="font-size:1rem;font-weight:400;color:#6b7280;">Siempre
                                                    </span>0€
                                                </div>
                                                <ul
                                                    style="list-style:none;padding:0;margin:0 0 20px;font-size:0.85rem;color:#4b5563;text-align:left;">
                                                    <li style="padding:4px 0;">✅ Gestión de piso básica</li>
                                                    <li style="padding:4px 0;">✅ Hasta 3 compañeros</li>
                                                    <li style="padding:4px 0;">✅ Tareas y gastos</li>
                                                    <li style="padding:4px 0;color:#9ca3af;">❌ Sin soporte
                                                        prioritario
                                                    </li>
                                                    <li style="padding:4px 0;color:#9ca3af;">❌ Con
                                                        publicidad</li>
                                                </ul>
                                                <a href="Registro.aspx?plan=Basico" class="btn btn-outline"
                                                    style="width:100%;display:block;">Comenzar gratis</a>
                                            </div>
                                            <!-- PROFESIONAL -->
                                            <div
                                                style="border:2px solid #3b82f6;border-radius:12px;padding:24px;text-align:center;background:#eff6ff;position:relative;box-shadow:0 4px 12px rgba(59,130,246,0.15);">
                                                <div
                                                    style="position:absolute;top:-12px;left:50%;transform:translateX(-50%);background:#3b82f6;color:white;font-size:0.7rem;font-weight:700;padding:4px 12px;border-radius:100px;letter-spacing:1px;">
                                                    MÁS POPULAR</div>
                                                <div style="font-size:2rem;margin-bottom:8px;">⭐</div>
                                                <h4 style="color:#1e40af;margin-bottom:4px;">Profesional
                                                </h4>
                                                <div
                                                    style="font-size:2rem;font-weight:700;color:#1e3a8a;margin:12px 0;">
                                                    4.99€<span
                                                        style="font-size:1rem;font-weight:400;color:#6b7280;">/mes</span>
                                                </div>
                                                <ul
                                                    style="list-style:none;padding:0;margin:0 0 20px;font-size:0.85rem;color:#1e40af;text-align:left;">
                                                    <li style="padding:4px 0;">✅ Compañeros ilimitados</li>
                                                    <li style="padding:4px 0;">✅ Sin publicidad</li>
                                                    <li style="padding:4px 0;">✅ Contratos y documentos</li>
                                                    <li style="padding:4px 0;">✅ Soporte prioritario</li>
                                                    <li style="padding:4px 0;">✅ Exportación a Excel/PDF
                                                    </li>
                                                </ul>
                                                <a href="Registro.aspx?plan=Profesional" class="btn btn-primary"
                                                    style="width:100%;display:block;">Elegir Profesional</a>
                                            </div>
                                            <!-- ENTERPRISE -->
                                            <div style="border:1px solid #e5e7eb;border-radius:12px;padding:24px;text-align:center;background:#fff;transition:box-shadow 0.2s;"
                                                onmouseover="this.style.boxShadow='0 8px 20px rgba(0,0,0,0.08)'"
                                                onmouseout="this.style.boxShadow='none'">
                                                <div style="font-size:2rem;margin-bottom:8px;">🏢</div>
                                                <h4 style="color:#1f2937;margin-bottom:4px;">Enterprise</h4>
                                                <div
                                                    style="font-size:2rem;font-weight:700;color:#111827;margin:12px 0;">
                                                    19.99€<span
                                                        style="font-size:1rem;font-weight:400;color:#6b7280;">/mes</span>
                                                </div>
                                                <ul
                                                    style="list-style:none;padding:0;margin:0 0 20px;font-size:0.85rem;color:#4b5563;text-align:left;">
                                                    <li style="padding:4px 0;">✅ Multi-piso (ilimitados)
                                                    </li>
                                                    <li style="padding:4px 0;">✅ Panel de administración
                                                    </li>
                                                    <li style="padding:4px 0;">✅ API de integración</li>
                                                    <li style="padding:4px 0;">✅ Gestor de propietarios</li>
                                                    <li style="padding:4px 0;">✅ SLA 24/7 garantizado</li>
                                                </ul>
                                                <a href="mailto:info@conviapp.com?subject=Enterprise%20ConviApp"
                                                    class="btn btn-outline" style="width:100%;display:block;">Contactar
                                                    ventas ✉️</a>
                                            </div>
                                        </div>
                                    </div>
                                    <% } %>
                    </div>

                    <!-- MOCK TABS FOR THE UI DEMO -->
                    <div id="tab-pisos" class="tab-content flat-card">
                        <h2 style="margin-bottom:8px;">🏠 Mis pisos</h2>
                        <p style="color:#6b7280;margin-bottom:16px;">Consulta y gestiona todos los pisos que
                            administras. Añade fotos, detalles de habitaciones y más.</p>
                        <% if (_isDemo) { %>
                            <div class="demo-cta-box" style="margin-bottom:20px;">
                                <img style="width:100%; border-radius:8px; margin-bottom:16px; border:1px solid #e5e7eb;"
                                    src="https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=800&q=80"
                                    alt="Demo Pisos" />
                                <div
                                    style="background:#f0f4ff;border-radius:8px;padding:16px;margin-bottom:16px;border-left:4px solid #3b82f6;">
                                    <strong style="color:#1e3a8a;">Vista previa del módulo de Pisos</strong>
                                    <p style="color:#6b7280;font-size:0.9rem;margin:6px 0 0;">Con ConviApp
                                        podrás ver el
                                        listado de pisos disponibles, añadir los tuyos, ver planos, fotos y
                                        disponibilidad en tiempo real.</p>
                                </div>
                                <a href="Registro.aspx" class="btn btn-primary">🚀 Regístrate para ver tus
                                    pisos</a>
                                <button type="button" onclick="switchMainTab('inicio')" class="btn btn-outline"
                                    style="margin-left:8px;">← Volver</button>
                            </div>
                            <% } else { %>
                                <p><a href="MisPisos.aspx" class="btn btn-primary">Ir a mis pisos →</a></p>
                                <button type="button" onclick="switchMainTab('inicio')" class="btn btn-outline"
                                    style="margin-top:20px;">← Volver</button>
                                <% } %>
                    </div>

                    <div id="tab-tareas" class="tab-content flat-card">
                        <h2 style="margin-bottom:8px;">✅ Tareas del hogar</h2>
                        <p style="color:#6b7280;margin-bottom:16px;">Organiza y asigna tareas domésticas
                            entre todos los
                            compañeros de forma equitativa.</p>
                        <% if (_isDemo) { %>
                            <div class="demo-cta-box" style="margin-bottom:20px;">
                                <img style="width:100%; border-radius:8px; margin-bottom:16px; border:1px solid #e5e7eb;"
                                    src="https://images.unsplash.com/photo-1540350394557-8d14678e7f91?auto=format&fit=crop&w=800&q=80"
                                    alt="Demo Tareas" />
                                <div
                                    style="background:#f0fdf4;border-radius:8px;padding:16px;margin-bottom:16px;border-left:4px solid #10b981;">
                                    <strong style="color:#065f46;">Vista previa: Gestión de Tareas</strong>
                                    <p style="color:#6b7280;font-size:0.9rem;margin:6px 0 0;">Crea listas de
                                        tareas,
                                        asígnalas a compañeros con fechas límite y recibe notificaciones
                                        automáticas
                                        cuando se completen.</p>
                                </div>
                                <a href="Registro.aspx" class="btn btn-primary">🚀 Regístrate para gestionar
                                    tareas</a>
                                <button type="button" onclick="switchMainTab('inicio')" class="btn btn-outline"
                                    style="margin-left:8px;">← Volver</button>
                            </div>
                            <% } else { %>
                                <a href="Tareas.aspx" class="btn btn-primary">Ir a Tareas →</a>
                                <button type="button" onclick="switchMainTab('inicio')" class="btn btn-outline"
                                    style="margin-top:20px;">← Volver</button>
                                <% } %>
                    </div>

                    <div id="tab-contratos" class="tab-content flat-card">
                        <h2 style="margin-bottom:8px;">📄 Contratos y Pagos</h2>
                        <p style="color:#6b7280;margin-bottom:16px;">Guarda y gestiona todos los contratos y
                            documentos
                            legales del piso.</p>
                        <% if (_isDemo) { %>
                            <div class="demo-cta-box" style="margin-bottom:20px;">
                                <img style="width:100%; border-radius:8px; margin-bottom:16px; border:1px solid #e5e7eb;"
                                    src="https://images.unsplash.com/photo-1562664377-709f2c337eb2?auto=format&fit=crop&w=800&q=80"
                                    alt="Demo Contratos" />
                                <div
                                    style="background:#f5f3ff;border-radius:8px;padding:16px;margin-bottom:16px;border-left:4px solid #7c3aed;">
                                    <strong style="color:#5b21b6;">Vista previa: Contratos</strong>
                                    <p style="color:#6b7280;font-size:0.9rem;margin:6px 0 0;">Sube contratos
                                        de
                                        alquiler, recibos de pago y cualquier documento importante. Firma
                                        digital,
                                        alertas de vencimiento e historial completo.</p>
                                </div>
                                <a href="Registro.aspx" class="btn btn-primary">🚀 Regístrate para ver
                                    contratos</a>
                                <button type="button" onclick="switchMainTab('inicio')" class="btn btn-outline"
                                    style="margin-left:8px;">← Volver</button>
                            </div>
                            <% } else { %>
                                <a href="ContratosYPagos.aspx" class="btn btn-primary">Ir a Contratos →</a>
                                <button type="button" onclick="switchMainTab('inicio')" class="btn btn-outline"
                                    style="margin-top:20px;">← Volver</button>
                                <% } %>
                    </div>

                    <div id="tab-reservas" class="tab-content flat-card">
                        <h2 style="margin-bottom:8px;">📅 Reservas de zonas comunes</h2>
                        <p style="color:#6b7280;margin-bottom:16px;">Reserva la lavadora, sala de estar,
                            parking u otros
                            espacios del piso sin conflictos.</p>
                        <% if (_isDemo) { %>
                            <div class="demo-cta-box" style="margin-bottom:20px;">
                                <img style="width:100%; border-radius:8px; margin-bottom:16px; border:1px solid #e5e7eb;"
                                    src="https://images.unsplash.com/photo-1506784951206-aa92b158bce0?auto=format&fit=crop&w=800&q=80"
                                    alt="Demo Reservas" />
                                <div
                                    style="background:#eff6ff;border-radius:8px;padding:16px;margin-bottom:16px;border-left:4px solid #3b82f6;">
                                    <strong style="color:#1e40af;">Vista previa: Reservas</strong>
                                    <p style="color:#6b7280;font-size:0.9rem;margin:6px 0 0;">Calendario
                                        compartido en
                                        tiempo real. Reserva franjas horarias para zonas comunes y evita
                                        conflictos.</p>
                                </div>
                                <a href="Registro.aspx" class="btn btn-primary">🚀 Regístrate para hacer
                                    reservas</a>
                                <button type="button" onclick="switchMainTab('inicio')" class="btn btn-outline"
                                    style="margin-left:8px;">← Volver</button>
                            </div>
                            <% } else { %>
                                <a href="Reservas.aspx" class="btn btn-primary">Ir a Reservas →</a>
                                <button type="button" onclick="switchMainTab('inicio')" class="btn btn-outline"
                                    style="margin-top:20px;">← Volver</button>
                                <% } %>
                    </div>

                </div>

                <!-- RIGHT COLUMN (Ads or Pro Suggestions) -->
                <% bool _showSugerencias=isLoggedIn && (userRole=="Profesional" || userRole=="Enterprise" ); %>
                    <% if (showSidebarAds || _showSugerencias) { %>
                        <div class="sidebar-right">
                            <% if (showSidebarAds) { var _ads=new[] { new { Bg="linear-gradient(135deg,#1e3a8a,#3b82f6)"
                                , Color="white" , Img="photo-1581578731548-c64695cc6952" , Title="Limpieza a domicilio"
                                , Desc="Primera limpieza al 50% con código CONVI50." , Btn="Ver ofertas" ,
                                BtnCls="btn-outline" , BtnStyle="color:white;border-color:rgba(255,255,255,0.4);" }, new
                                { Bg="#ecfdf5" , Color="#065f46" , Img="photo-1555041469-a586c61ea9bc" ,
                                Title="Muebles para el piso" , Desc="15% en camas y escritorios. Código CONVI15." ,
                                Btn="Descubrir" , BtnCls="btn-primary" , BtnStyle="background:#10b981;" }, new {
                                Bg="#fffbeb" , Color="#92400e" , Img="photo-1473341304170-971dccb5ac1e" ,
                                Title="Tarifa de luz" , Desc="Octopus Energy: renovable desde 0.09€/kWh." ,
                                Btn="Comparar" , BtnCls="btn-sm" , BtnStyle="background:#fbbf24;color:#fff;" }, new {
                                Bg="linear-gradient(135deg,#7c3aed,#4f46e5)" , Color="white" ,
                                Img="photo-1544197150-b99a580bb7a8" , Title="Fibra 600Mb" ,
                                Desc="Internet ultra-rápido desde 24.90€/mes." , Btn="Ver oferta" , BtnCls="btn-outline"
                                , BtnStyle="color:white;border-color:rgba(255,255,255,0.4);" }, new { Bg="#eff6ff" ,
                                Color="#1e3a8a" , Img="photo-1450101499163-c8848c66ca85" , Title="Seguro de hogar" ,
                                Desc="Protege tus pertenencias desde solo 5€/mes." , Btn="Más info" ,
                                BtnCls="btn-primary" , BtnStyle="background:#3b82f6;" }, new {
                                Bg="linear-gradient(135deg,#ef4444,#f97316)" , Color="white" ,
                                Img="photo-1416879595882-3373a0480b5b" , Title="Plantas para tu piso" ,
                                Desc="Dale vida a tu hogar. Envío gratis en pedidos +20€." , Btn="Ver tienda" ,
                                BtnCls="btn-outline" , BtnStyle="color:white;border-color:rgba(255,255,255,0.4);" } };
                                int _a1=_adSeed % 6; int _a2=(_adSeed+2) % 6; var _ad1=_ads[_a1]; var _ad2=_ads[_a2]; %>
                                <div class="flat-card"
                                    style="background:<%= _ad1.Bg %>;color:<%= _ad1.Color %>;padding:0;text-align:center;margin-bottom:24px;overflow:hidden;border-radius:12px;">
                                    <img src="https://images.unsplash.com/<%= _ad1.Img %>?auto=format&fit=crop&w=300&q=80"
                                        style="width:100%;height:120px;object-fit:cover;" />
                                    <div style="padding:16px;">
                                        <div style="font-size:0.6rem;letter-spacing:2px;margin-bottom:6px;opacity:0.7;">
                                            PUBLICIDAD</div>
                                        <h3 style="font-size:1.05rem;margin-bottom:8px;">
                                            <%= _ad1.Title %>
                                        </h3>
                                        <p style="font-size:0.82rem;margin-bottom:14px;opacity:0.9;">
                                            <%= _ad1.Desc %>
                                        </p>
                                        <a href="Upgrade.aspx" class="btn <%= _ad1.BtnCls %> btn-sm"
                                            style="<%= _ad1.BtnStyle %>">
                                            <%= _ad1.Btn %>
                                        </a>
                                    </div>
                                </div>
                                <div class="flat-card"
                                    style="background:<%= _ad2.Bg %>;color:<%= _ad2.Color %>;padding:0;text-align:center;margin-bottom:16px;overflow:hidden;border-radius:12px;">
                                    <img src="https://images.unsplash.com/<%= _ad2.Img %>?auto=format&fit=crop&w=300&q=80"
                                        style="width:100%;height:120px;object-fit:cover;" />
                                    <div style="padding:16px;">
                                        <div style="font-size:0.6rem;letter-spacing:2px;margin-bottom:6px;opacity:0.7;">
                                            PUBLICIDAD</div>
                                        <h3 style="font-size:1.05rem;margin-bottom:8px;">
                                            <%= _ad2.Title %>
                                        </h3>
                                        <p style="font-size:0.82rem;margin-bottom:14px;opacity:0.9;">
                                            <%= _ad2.Desc %>
                                        </p>
                                        <a href="Upgrade.aspx" class="btn <%= _ad2.BtnCls %> btn-sm"
                                            style="<%= _ad2.BtnStyle %>">
                                            <%= _ad2.Btn %>
                                        </a>
                                    </div>
                                </div>
                                <div style="text-align:center;">
                                    <a href="Upgrade.aspx?plan=Profesional"
                                        style="font-size:0.75rem;color:#6b7280;text-decoration:underline;">&#x1F48E;
                                        Actualizar a Pro para eliminar anuncios</a>
                                </div>
                                <% } %>

                                    <% if (_showSugerencias) { %>
                                        <div class="flat-card" style="padding: 20px; border-radius:12px;">
                                            <h4 style="margin-bottom: 16px; color: #1e3a8a;">✨ Sugerencias Pro</h4>
                                            <p style="font-size: 0.85rem; color: #4b5563; margin-bottom: 16px;">
                                                Aprovecha al máximo tu suscripción ad-free revisando estos atajos
                                                útiles.</p>

                                            <a href="MisPisos.aspx" class="btn"
                                                style="background:#ef4444; color:white; justify-content:center; margin-bottom:12px; display:flex; align-items:center; gap:8px; padding:10px; border-radius:6px; text-decoration:none; width: 100%;">+
                                                Añadir piso rápido</a>
                                            <a href="ContratosYPagos.aspx" class="btn"
                                                style="background:#3b82f6; color:white; justify-content:center; margin-bottom:12px; display:flex; align-items:center; gap:8px; padding:10px; border-radius:6px; text-decoration:none; width: 100%;">📑
                                                Subir contrato nuevo</a>
                                            <a href="Reservas.aspx" class="btn"
                                                style="background:#10b981; color:white; justify-content:center; margin-bottom:12px; display:flex; align-items:center; gap:8px; padding:10px; border-radius:6px; text-decoration:none; width: 100%;">📅
                                                Hacer una reserva</a>

                                            <div
                                                style="margin-top: 24px; padding-top: 16px; border-top: 1px solid #e5e7eb;">
                                                <div style="display:flex; align-items:center; gap:8px;">
                                                    <span style="font-size:2rem;">🎧</span>
                                                    <div>
                                                        <strong style="display:block; font-size:0.9rem;">Soporte
                                                            Premium</strong>
                                                        <span style="font-size:0.75rem; color:#6b7280;">Te respondemos
                                                            en &lt; 1h</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                        </div>
                        <% } %>

            </div>


            <script>
                function switchMainTab(tabId) {
                    document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
                    var targetSection = document.getElementById('tab-' + tabId);
                    if (targetSection) targetSection.classList.add('active');

                    if (window.history.pushState) {
                        var url = tabId === 'inicio' ? window.location.pathname : window.location.pathname + '?tab=' + tabId;
                        window.history.replaceState(null, '', url);
                    }
                }

                document.addEventListener('DOMContentLoaded', function () {
                    var params = new URLSearchParams(window.location.search);
                    var tab = params.get('tab');
                    if (tab) switchMainTab(tab);
                });
            </script>
    </asp:Content>