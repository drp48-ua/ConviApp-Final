<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Registro.aspx.cs" Inherits="ConviAppWeb.Registro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width:500px; margin:0 auto;" class="glass-card">
        <h2 style="text-align:center; color:#1e3a8a;">Registro de Usuario</h2>
        
        <div>
            <label>Nombre:</label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input" />
        </div>
        <div>
            <label>Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" />
        </div>
        <div>
            <label>Contraseña:</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-input" TextMode="Password" />
        </div>
        
        <asp:Button ID="btnRegistrar" runat="server" Text="Registrarse" CssClass="btn btn-primary" Width="100%" OnClick="BtnRegistrar_Click" />
    </div>
</asp:Content>


