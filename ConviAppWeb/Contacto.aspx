<%@ Page Title="Contacto Enterprise" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Contacto.aspx.cs" Inherits="ConviAppWeb.Contacto" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div style="min-height:80vh; display:flex; align-items:center; justify-content:center; padding:2rem;">
            <div style="width:100%; max-width:560px;">
                <div style="text-align:center; margin-bottom:30px;">
                    <h1 style="font-size:2rem;">Solicitar Plan Enterprise 🏢</h1>
                    <p style="color:var(--text-muted);">Para inmobiliarias y gestores profesionales</p>
                </div>

                <asp:Panel ID="pnlConfirmacion" runat="server" Visible="false" CssClass="glass-card"
                    style="text-align:center; padding:3rem; margin-bottom:20px;">
                    <div style="font-size:3rem; margin-bottom:16px;">🎉</div>
                    <p style="color:var(--accent); font-weight:600;">¡Solicitud enviada! Nos pondremos en contacto
                        contigo pronto.</p>
                    <a href="Index.aspx" class="btn btn-primary" style="margin-top:16px;">Volver al inicio</a>
                </asp:Panel>

                <asp:Panel ID="pnlForm" runat="server" CssClass="glass-card" style="padding:32px;">
                    <div style="margin-bottom:16px;">
                        <label
                            style="color:var(--text-secondary); font-size:0.9rem; margin-bottom:6px; display:block;">Nombre
                            completo</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input" placeholder="Tu nombre" />
                    </div>
                    <div style="margin-bottom:16px;">
                        <label
                            style="color:var(--text-secondary); font-size:0.9rem; margin-bottom:6px; display:block;">Email
                            de contacto</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email"
                            placeholder="tu@empresa.com" />
                    </div>
                    <div style="margin-bottom:16px;">
                        <label
                            style="color:var(--text-secondary); font-size:0.9rem; margin-bottom:6px; display:block;">Empresa
                            / Inmobiliaria</label>
                        <asp:TextBox ID="txtEmpresa" runat="server" CssClass="form-input"
                            placeholder="Nombre de tu empresa" />
                    </div>
                    <div style="margin-bottom:24px;">
                        <label
                            style="color:var(--text-secondary); font-size:0.9rem; margin-bottom:6px; display:block;">Mensaje</label>
                        <asp:TextBox ID="txtMensaje" runat="server" CssClass="form-input" TextMode="MultiLine" Rows="4"
                            placeholder="Cuéntanos sobre tus necesidades..." style="resize:vertical;" />
                    </div>
                    <asp:Button ID="btnEnviar" runat="server" Text="Enviar solicitud →" CssClass="btn btn-primary"
                        style="width:100%; padding:14px; font-size:1rem;" OnClick="BtnEnviar_Click" />
                </asp:Panel>

                <div class="glass-card" style="margin-top:20px; padding:20px; text-align:center;">
                    <p style="color:var(--text-muted); margin:0;">
                        📧 También puedes escribirnos a
                        <a href="mailto:daniramonpoveda@gmail.com"
                            style="color:var(--primary-light);">daniramonpoveda@gmail.com</a>
                    </p>
                </div>
            </div>
        </div>
    </asp:Content>

