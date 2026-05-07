<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Login.aspx.cs"
    Inherits="ConviAppWeb.Login" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div style="display:flex; justify-content:center; align-items:center; min-height:80vh; padding:20px;">
            <div
                style="width:100%; max-width:440px; background:white; border-radius:24px; padding:48px 40px; box-shadow:0 20px 40px -15px rgba(0,0,0,0.1); border:1px solid #f3f4f6; position:relative; overflow:hidden;">
                <!-- Decoración top -->
                <div
                    style="position:absolute; top:0; left:0; width:100%; height:6px; background:linear-gradient(90deg, var(--primary), var(--accent));">
                </div>

                <div style="text-align:center; margin-bottom:32px;">
                    <div
                        style="width:64px; height:64px; background:linear-gradient(135deg, #eff6ff, #dbeafe); color:var(--primary); border-radius:16px; display:inline-flex; align-items:center; justify-content:center; font-size:2rem; margin-bottom:16px; border:1px solid #bfdbfe;">
                        👋
                    </div>
                    <h2 style="color:var(--text-primary); font-size:1.8rem; margin:0 0 8px;">&#128075; Bienvenido de nuevo
                    </h2>
                    <p style="color:var(--text-secondary); margin:0;">Inicia sesi&oacute;n para gestionar tu piso</p>
                </div>

                <asp:Panel ID="pnlError" runat="server" Visible="false"
                    style="background:#fef2f2; border:1px solid #fee2e2; border-radius:8px; padding:12px; margin-bottom:24px;">
                    <div style="display:flex; gap:8px; align-items:center;">
                        <span style="color:#ef4444; font-size:1.2rem;">⚠️</span>
                        <asp:Label ID="lblError" runat="server" style="color:#b91c1c; font-size:0.9rem;" />
                    </div>
                </asp:Panel>

                <div style="margin-bottom:20px;">
                    <label
                        style="display:block; font-size:0.9rem; font-weight:600; color:var(--text-secondary); margin-bottom:6px;">Correo
                        Electr&oacute;nico</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email"
                        placeholder="ejemplo@correo.com" style="width:100%; padding:14px; background:#f9fafb;" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="El correo es requerido" ForeColor="#ef4444" Display="Dynamic"
                        style="font-size:0.8rem; margin-top:4px;" />
                </div>

                <div style="margin-bottom:32px;">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
                        <label
                            style="font-size:0.9rem; font-weight:600; color:var(--text-secondary);">Contrase&ntilde;a</label>
                        <a href="#" style="font-size:0.8rem; color:var(--primary-light);">¿Olvidaste tu
                            contrase&ntilde;a?</a>
                    </div>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input" TextMode="Password"
                        placeholder="••••••••" style="width:100%; padding:14px; background:#f9fafb;" />
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Entrar a mi cuenta" CssClass="btn btn-primary"
                    Width="100%" OnClick="BtnLogin_Click"
                    style="padding:14px; font-size:1.05rem; box-shadow:0 10px 15px -3px rgba(59,130,246,0.3); border-radius:12px;" />

                <div style="margin-top:24px; text-align:center; position:relative;">
                    <div style="position:absolute; top:50%; left:0; width:100%; height:1px; background:#e5e7eb;">
                    </div>
                    <span
                        style="background:white; padding:0 16px; position:relative; font-size:0.85rem; color:#9ca3af;">O
                        nuevo en ConviApp</span>
                </div>

                <div style="margin-top:24px; text-align:center;">
                    <a href="Registro.aspx" class="btn btn-outline"
                        style="width:100%; padding:12px; border-radius:12px;">Crear cuenta gratis</a>
                </div>
            </div>
        </div>
    </asp:Content>

