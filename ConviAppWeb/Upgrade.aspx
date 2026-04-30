<%@ Page Title="Actualizar Plan" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Upgrade.aspx.cs" Inherits="ConviAppWeb.Upgrade" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div style="min-height:80vh; display:flex; align-items:center; justify-content:center; padding:3rem 1rem;">
            <div style="width:100%; max-width:600px;">
                <div style="text-align:center; margin-bottom:2rem;">
                    <h1 style="font-size:2.2rem;">Actualizar Plan 🚀</h1>
                    <p style="color:var(--text-muted); font-size:1.1rem;">Desbloquea todo el potencial de ConviApp.</p>
                </div>

                <asp:Panel ID="pnlProfesional" runat="server" CssClass="glass-card"
                    style="padding:2.5rem; border-top:4px solid var(--primary); margin-bottom:24px;">
                    <div
                        style="display:flex; justify-content:space-between; align-items:center; padding-bottom:1.5rem; border-bottom:1px solid var(--border); margin-bottom:1.5rem;">
                        <div>
                            <div style="font-size:1.2rem; font-weight:600;">Plan Profesional</div>
                            <div style="color:var(--text-muted); font-size:0.9rem;">Para inquilinos y gestores</div>
                        </div>
                        <div style="font-size:2rem; font-weight:700; color:var(--primary);">€4.99<span
                                style="font-size:1rem; color:var(--text-muted); font-weight:400;">/mes</span></div>
                    </div>
                    <ul style="color:var(--text-secondary); margin-bottom:1.5rem; padding-left:1.2rem;">
                        <li>Reservas de zonas comunes</li>
                        <li>Gestión de incidencias</li>
                        <li>Contratos y pagos</li>
                        <li>Documentos (hasta 10)</li>
                    </ul>
                    <asp:Label ID="lblErrPro" runat="server" ForeColor="Red" Visible="false"
                        style="margin-bottom:12px; display:block;" />
                    <div style="display:flex; gap:12px; flex-wrap:wrap;">
                        <asp:TextBox ID="txtIBANPro" runat="server" CssClass="form-input"
                            placeholder="IBAN simulado (> 10 caracteres)" style="flex:1;" />
                        <asp:Button ID="btnPro" runat="server" Text="Activar Pro →" CssClass="btn btn-primary"
                            OnClick="BtnPro_Click" />
                    </div>
                </asp:Panel>

                <div class="glass-card" style="padding:2.5rem; border-top:4px solid var(--accent);">
                    <div
                        style="display:flex; justify-content:space-between; align-items:center; padding-bottom:1.5rem; border-bottom:1px solid var(--border); margin-bottom:1.5rem;">
                        <div>
                            <div style="font-size:1.2rem; font-weight:600;">Plan Enterprise 🏢</div>
                            <div style="color:var(--text-muted); font-size:0.9rem;">Para inmobiliarias y gestores pro
                            </div>
                        </div>
                        <div style="font-size:2rem; font-weight:700; color:var(--accent);">€19.99<span
                                style="font-size:1rem; color:var(--text-muted); font-weight:400;">/mes</span></div>
                    </div>
                    <ul style="color:var(--text-secondary); margin-bottom:1.5rem; padding-left:1.2rem;">
                        <li>Todo del plan Profesional</li>
                        <li>Pisos ilimitados</li>
                        <li>Documentos ilimitados</li>
                        <li>Panel de administración</li>
                    </ul>
                    <div style="text-align:center;">
                        <a href="Contacto.aspx" class="btn btn-primary"
                            style="background:var(--accent); border-color:var(--accent); display:inline-block; padding:14px 32px;">Solicitar
                            Enterprise →</a>
                    </div>
                </div>

                <div style="text-align:center; margin-top:1.5rem;">
                    <a href="Index.aspx" style="color:var(--text-muted); text-decoration:none;">← Volver al panel</a>
                </div>
            </div>
        </div>
    </asp:Content>