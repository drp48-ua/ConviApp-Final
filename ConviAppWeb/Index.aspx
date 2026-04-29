<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="ConviAppWeb.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="text-align:center; padding: 40px;">
        <h1 style="color:#1e3a8a;">Bienvenido a ConviApp HADA</h1>
        <p>Tu plataforma académica de gestión de pisos compartidos.</p>

        <%-- Panel para usuarios NO autenticados --%>
        <asp:Panel ID="pnlPublico" runat="server" Visible="false">
            <div style="margin-top:20px; padding: 20px; background:#e0e7ff; border-radius:8px;">
                <h3>Demostración de capacidades públicas</h3>
                <p>Navega a la zona de registro o explora nuestras landing pages simuladas.</p>
                <a href="Registro.aspx" class="btn btn-primary">Regístrate gratis</a>
            </div>
        </asp:Panel>

        <%-- Panel para usuarios autenticados --%>
        <asp:Panel ID="pnlDashboard" runat="server" Visible="false">
            <div style="display:flex; justify-content:center; gap:20px; margin-top:30px; flex-wrap:wrap;">
                <div class="glass-card" style="padding:20px; min-width:160px;">
                    <h3>Pisos</h3>
                    <p><asp:Label ID="lblNumPisos" runat="server" Font-Bold="true" Font-Size="24px" /></p>
                </div>
                <div class="glass-card" style="padding:20px; min-width:160px;">
                    <h3>Gastos</h3>
                    <p><asp:Label ID="lblTotalGastos" runat="server" Font-Bold="true" Font-Size="24px" /></p>
                </div>
                <div class="glass-card" style="padding:20px; min-width:160px;">
                    <h3>Tareas</h3>
                    <p><asp:Label ID="lblNumTareas" runat="server" Font-Bold="true" Font-Size="24px" /></p>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
