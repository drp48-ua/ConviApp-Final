<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Registro.aspx.cs" Inherits="ConviAppWeb.Registro" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div style="display:flex; justify-content:center; align-items:center; min-height:80vh; padding:20px;">
            <div
                style="width:100%; max-width:550px; background:white; border-radius:24px; padding:48px 40px; box-shadow:0 20px 40px -15px rgba(0,0,0,0.1); border:1px solid #f3f4f6; position:relative; overflow:hidden;">
                <!-- Decoración top -->
                <div
                    style="position:absolute; top:0; left:0; width:100%; height:6px; background:linear-gradient(90deg, var(--primary), var(--accent));">
                </div>

                <div style="text-align:center; margin-bottom:32px;">
                    <div
                        style="width:64px; height:64px; background:linear-gradient(135deg, #eff6ff, #dbeafe); color:var(--primary); border-radius:16px; display:inline-flex; align-items:center; justify-content:center; font-size:2rem; margin-bottom:16px; border:1px solid #bfdbfe;">
                        🚀
                    </div>
                    <h2 style="color:var(--text-primary); font-size:1.8rem; margin:0 0 8px;">Crea tu cuenta</h2>
                    <p style="color:var(--text-secondary); margin:0;">Únete a miles de pisos organizados</p>
                </div>

                <!-- Selector de Plan Simulado con Radios -->
                <div style="margin-bottom:24px;">
                    <label
                        style="display:block; font-size:0.9rem; font-weight:600; color:var(--text-secondary); margin-bottom:12px;">Elige
                        tu plan</label>
                    <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:12px;">
                        <label
                            style="border:2px solid #e5e7eb; border-radius:12px; padding:16px; cursor:pointer; display:flex; flex-direction:column; gap:8px; position:relative; transition:all 0.2s; text-align:center;"
                            onmouseover="this.style.borderColor='#bfdbfe';"
                            onmouseout="this.style.borderColor='#e5e7eb';">
                            <input type="radio" name="planSelected" value="Basico" checked
                                style="position:absolute; top:12px; left:12px;" />
                            <div style="margin-top:16px;">
                                <div style="font-weight:700; color:#1f2937;">Básico</div>
                                <div style="font-size:0.75rem; color:#6b7280; margin-top:4px;">0€/m - Con anuncios</div>
                            </div>
                        </label>
                        <label
                            style="border:2px solid #3b82f6; border-radius:12px; padding:16px; cursor:pointer; display:flex; flex-direction:column; gap:8px; position:relative; background:#eff6ff; text-align:center;">
                            <input type="radio" name="planSelected" value="Profesional"
                                style="position:absolute; top:12px; left:12px;" />
                            <div style="margin-top:16px;">
                                <div style="font-weight:700; color:#1e3a8a;">Pro</div>
                                <div style="font-size:0.75rem; color:#3b82f6; margin-top:4px;">4.99€/m - Sin anuncios
                                </div>
                            </div>
                        </label>
                        <label
                            style="border:2px solid #e5e7eb; border-radius:12px; padding:16px; cursor:pointer; display:flex; flex-direction:column; gap:8px; position:relative; transition:all 0.2s; text-align:center;"
                            onmouseover="this.style.borderColor='#bfdbfe';"
                            onmouseout="this.style.borderColor='#e5e7eb';">
                            <input type="radio" name="planSelected" value="Enterprise"
                                style="position:absolute; top:12px; left:12px;" />
                            <div style="margin-top:16px;">
                                <div style="font-weight:700; color:#1f2937;">Enterprise</div>
                                <div style="font-size:0.75rem; color:#6b7280; margin-top:4px;">19.99€/m - Multi-piso
                                </div>
                            </div>
                        </label>
                    </div>
                </div>

                <div style="margin-bottom:20px;">
                    <label
                        style="display:block; font-size:0.9rem; font-weight:600; color:var(--text-secondary); margin-bottom:6px;">Nombre
                        completo</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input" placeholder="Ej. María García"
                        style="width:100%; padding:14px; background:#f9fafb;" />
                </div>

                <div style="margin-bottom:20px;">
                    <label
                        style="display:block; font-size:0.9rem; font-weight:600; color:var(--text-secondary); margin-bottom:6px;">Correo
                        Electrónico</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email"
                        placeholder="ejemplo@correo.com" style="width:100%; padding:14px; background:#f9fafb;" />
                </div>

                <div style="margin-bottom:32px;">
                    <label
                        style="display:block; font-size:0.9rem; font-weight:600; color:var(--text-secondary); margin-bottom:6px;">Contraseña</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input" TextMode="Password"
                        placeholder="Crea una contraseña segura"
                        style="width:100%; padding:14px; background:#f9fafb;" />
                </div>

                <asp:Button ID="btnRegistrar" runat="server" Text="Registrarse ahora" CssClass="btn btn-primary"
                    Width="100%" OnClick="BtnRegistrar_Click"
                    style="padding:14px; font-size:1.05rem; box-shadow:0 10px 15px -3px rgba(59,130,246,0.3); border-radius:12px;" />

                <div style="margin-top:24px; text-align:center;">
                    <span style="font-size:0.9rem; color:var(--text-secondary);">¿Ya tienes una cuenta?</span>
                    <a href="Login.aspx" style="font-size:0.9rem; font-weight:600;">Iniciar sesión</a>
                </div>

                <script>
                    // Preset the plan based on query string
                    document.addEventListener('DOMContentLoaded', function () {
                        const urlParams = new URLSearchParams(window.location.search);
                        const plan = urlParams.get('plan');
                        if (plan === 'Profesional' || plan === 'Enterprise') {
                            const radios = document.getElementsByName('planSelected');
                            radios.forEach(r => {
                                if (r.value === plan) {
                                    r.checked = true;
                                    r.parentElement.style.borderColor = '#3b82f6';
                                    r.parentElement.style.background = '#eff6ff';
                                } else {
                                    r.parentElement.style.borderColor = '#e5e7eb';
                                    r.parentElement.style.background = 'white';
                                }
                            });
                        }
                    });
                </script>
            </div>
        </div>
    </asp:Content>