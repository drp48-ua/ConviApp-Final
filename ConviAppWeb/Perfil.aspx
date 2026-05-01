<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Perfil.aspx.cs"
    Inherits="ConviAppWeb.Perfil" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div style="max-width: 600px; margin: 0 auto; padding-top: 40px; padding-bottom: 80px;">
            <div class="glass-card">
                <h2 style="margin-bottom: 24px; color: var(--primary);">Mi Perfil</h2>

                <asp:Panel ID="pnlSuccess" runat="server" Visible="false"
                    style="background: rgba(16, 185, 129, 0.1); border: 1px solid var(--success); color: var(--success); padding: 12px; border-radius: var(--radius-sm); margin-bottom: 24px;">
                    <asp:Label ID="lblMensaje" runat="server" />
                </asp:Panel>

                <div style="display: flex; flex-direction: column; gap: 20px;">
                    <div style="text-align: center; margin-bottom: 12px;">
                        <svg width="100" height="100" viewBox="0 0 64 64"
                            style="border-radius:50%;background:#e0e7ff;margin-bottom:12px;"
                            xmlns="http://www.w3.org/2000/svg">
                            <circle cx="32" cy="26" r="12" fill="#818cf8" />
                            <ellipse cx="32" cy="50" rx="20" ry="14" fill="#a5b4fc" />
                        </svg>
                    </div>

                    <div>
                        <label style="display: block; font-weight: 500; margin-bottom: 8px;">URL Foto de perfil</label>
                        <asp:TextBox ID="txtPhotoUrl" runat="server" CssClass="form-control"
                            style="width: 100%; padding: 10px; border-radius: var(--radius-md); border: 1px solid var(--border);"
                            placeholder="https://ejemplo.com/mifoto.jpg" />
                    </div>

                    <div>
                        <label style="display: block; font-weight: 500; margin-bottom: 8px;">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"
                            style="width: 100%; padding: 10px; border-radius: var(--radius-md); border: 1px solid var(--border);" />
                    </div>

                    <div>
                        <label style="display: block; font-weight: 500; margin-bottom: 8px;">Correo Electrónico</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                            style="width: 100%; padding: 10px; border-radius: var(--radius-md); border: 1px solid var(--border);" />
                    </div>

                    <hr style="border:0; border-top:1px solid #e5e7eb; margin: 16px 0;" />
                    <h4 style="color:var(--text-primary); margin-bottom:12px;">Cambiar Contraseña</h4>

                    <div>
                        <label style="display: block; font-weight: 500; margin-bottom: 8px;">Contraseña Actual</label>
                        <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" CssClass="form-control"
                            style="width: 100%; padding: 10px; border-radius: var(--radius-md); border: 1px solid var(--border);" />
                    </div>

                    <div>
                        <label style="display: block; font-weight: 500; margin-bottom: 8px;">Nueva Contraseña</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control"
                            style="width: 100%; padding: 10px; border-radius: var(--radius-md); border: 1px solid var(--border);" />
                    </div>

                    <div>
                        <label style="display: block; font-weight: 500; margin-bottom: 8px;">Confirmar Nueva
                            Contraseña</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"
                            style="width: 100%; padding: 10px; border-radius: var(--radius-md); border: 1px solid var(--border);" />
                    </div>

                    <div style="display: flex; gap: 12px; margin-top: 20px;">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary"
                            style="flex: 1; justify-content: center;" OnClick="BtnGuardar_Click" />
                        <a href="Index.aspx" class="btn btn-outline"
                            style="flex: 1; justify-content: center; text-decoration:none; text-align:center;">Volver</a>
                    </div>
                </div>
            </div>
        </div>
    </asp:Content>