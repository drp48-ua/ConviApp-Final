<%@ Page Title="Pisos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Pisos.aspx.cs" Inherits="ConviAppWeb.Pisos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Gestión de Pisos</h2>
    <asp:Button ID="btnNuevo" runat="server" Text="Añadir Piso" CssClass="btn btn-primary" OnClick="BtnNuevo_Click" />
    <br/><br/>
    
    <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="glass-card" style="margin-bottom:20px;">
        <h3>Nuevo Piso</h3>
        Dirección: <asp:TextBox ID="txtDir" runat="server" /><br/>
        Ciudad: <asp:TextBox ID="txtCiudad" runat="server" /><br/>
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="BtnGuardar_Click" />
        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" OnClick="BtnCancelar_Click" CausesValidation="false" />
    </asp:Panel>

    <asp:GridView ID="gvPisos" runat="server" AutoGenerateColumns="true" CssClass="grid" style="width:100%; border-collapse:collapse;" />
</asp:Content>


