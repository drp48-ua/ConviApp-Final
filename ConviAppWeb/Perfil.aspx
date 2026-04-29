<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Perfil.aspx.cs" Inherits="ConviAppWeb.Perfil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width:600px; margin:0 auto;" class="glass-card">
        <h2>Mi Perfil</h2>
        Nombre: <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input" /><br/>
        Email: <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" /><br/>
        <asp:Button ID="btnGuardar" runat="server" Text="Actualizar Perfil" CssClass="btn btn-primary" OnClick="BtnGuardar_Click" />
    </div>
</asp:Content>

