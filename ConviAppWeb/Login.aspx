<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="ConviAppWeb.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width:400px; margin:0 auto;" class="glass-card">
        <h2 style="text-align:center; color:#1e3a8a; margin-bottom:20px;">Iniciar Sesión</h2>
        
        <asp:Panel ID="pnlError" runat="server" Visible="false" style="color:red; margin-bottom:10px;">
            <asp:Label ID="lblError" runat="server" />
        </asp:Panel>

        <div style="margin-bottom:15px;">
            <label>Correo Electrónico:</label><br />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="El correo es requerido" ForeColor="Red" Display="Dynamic" />
        </div>
        
        <div style="margin-bottom:15px;">
            <label>Contraseña:</label><br />
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input" TextMode="Password" />
        </div>
        
        <asp:Button ID="btnLogin" runat="server" Text="Entrar" CssClass="btn btn-primary" Width="100%" OnClick="BtnLogin_Click" />
        
        <div style="margin-top:15px; text-align:center;">
            <a href="Registro.aspx">¿No tienes cuenta? Regístrate gratis</a>
        </div>
    </div>
</asp:Content>

