<%@ Page Title="Gastos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Gastos.aspx.cs" Inherits="ConviAppWeb.Gastos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Gastos</h2>
    <div class="glass-card" style="margin-bottom:20px;">
        Nuevo Gasto: Concepto: <asp:TextBox ID="txtConcepto" runat="server" /> 
        Importe: <asp:TextBox ID="txtImporte" runat="server" />
        <asp:Button ID="btnGuardar" runat="server" Text="Añadir" OnClick="BtnGuardar_Click" />
    </div>
    <asp:GridView ID="gvGastos" runat="server" AutoGenerateColumns="true" CssClass="grid" style="width:100%;" />
</asp:Content>

