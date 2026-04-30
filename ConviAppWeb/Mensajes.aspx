<%@ Page Title="Mensajes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Mensajes.aspx.cs" Inherits="ConviAppWeb.Mensajes" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">📊 Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">✅ Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">💸 Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab active">💬 Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">📅 Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab">🔧 Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab">📄 Contratos</a>
            <a href="Documentos.aspx" class="dash-tab">📎 Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">🏠 Mis Pisos</a>
        </div>

        <h2 style="margin-bottom:20px;">💬 Chat del Piso</h2>

        <div style="max-width:700px;">
            <asp:Panel ID="pnlVacio" runat="server" Visible="false">
                <div class="glass-card"
                    style="text-align:center; padding:3rem; color:var(--text-muted); margin-bottom:20px;">
                    <div style="font-size:3rem; margin-bottom:16px;">💬</div>
                    <p>No hay mensajes aún. ¡Sé el primero en escribir!</p>
                </div>
            </asp:Panel>

            <asp:Repeater ID="rptMensajes" runat="server">
                <HeaderTemplate>
                    <div
                        style="display:flex; flex-direction:column; gap:12px; margin-bottom:20px; max-height:500px; overflow-y:auto; padding-right:8px;">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="glass-card"
                        style='padding:14px 18px; <%# (bool)Eval("EsMio") ? "border-left:3px solid var(--primary-light);" : "" %>'>
                        <div
                            style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
                            <span style="font-weight:700; color:var(--primary-light);">
                                <%# (bool)Eval("EsMio") ? "Tú" : "Usuario #" + Eval("EmisorId") %>
                            </span>
                            <span style="color:var(--text-muted); font-size:0.8rem;">
                                <%# ((DateTime)Eval("FechaEnvio")).ToString("g") %>
                            </span>
                        </div>
                        <p style="margin:0; color:var(--text-primary);">
                            <%# Eval("Contenido") %>
                        </p>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
        </div>
        </FooterTemplate>
        </asp:Repeater>

        <div style="display:flex; gap:12px; margin-top:16px;">
            <asp:TextBox ID="txtMensaje" runat="server" CssClass="form-input" placeholder="Escribe un mensaje..."
                style="flex:1;" />
            <asp:Button ID="btnEnviar" runat="server" Text="Enviar →" CssClass="btn btn-primary btn-sm"
                OnClick="BtnEnviar_Click" />
        </div>
        </div>
    </asp:Content>