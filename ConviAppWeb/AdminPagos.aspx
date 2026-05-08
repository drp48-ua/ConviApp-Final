<%@ Page Title="Gestión de Contratos y Pagos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="AdminPagos.aspx.cs" Inherits="ConviAppWeb.AdminPagos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 24px;">
        <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Contratos de Pisos Privados</h2>
        <p style="color: #6b7280;">Gestiona los contratos asociados a los pisos privados y revisa los documentos adjuntos.</p>
    </div>

    <div class="glass-card" style="padding: 24px;">
        <h3 style="margin-bottom:16px;">Contratos Activos</h3>
        
        <table style="width:100%; border-collapse:collapse; text-align:left;">
            <thead>
                <tr style="border-bottom:2px solid #e5e7eb;">
                    <th style="padding:12px; color:#6b7280; font-weight:600;">ID Contrato</th>
                    <th style="padding:12px; color:#6b7280; font-weight:600;">ID Piso</th>
                    <th style="padding:12px; color:#6b7280; font-weight:600;">Usuario (Propietario)</th>
                    <th style="padding:12px; color:#6b7280; font-weight:600;">Renta Mensual</th>
                    <th style="padding:12px; color:#6b7280; font-weight:600;">Estado</th>
                    <th style="padding:12px; color:#6b7280; font-weight:600;">Documento</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptContratos" runat="server">
                    <ItemTemplate>
                        <tr style="border-bottom:1px solid #f3f4f6;">
                            <td style="padding:12px; font-weight:bold;">#<%# Eval("Id") %></td>
                            <td style="padding:12px;">Piso #<%# Eval("PropertyId") %></td>
                            <td style="padding:12px;">Usuario #<%# Eval("UserId") %></td>
                            <td style="padding:12px; font-weight:bold; color:var(--success);"><%# Eval("MonthlyRent") %> €</td>
                            <td style="padding:12px;">
                                <span class="badge" style="background:#d1fae5; color:#065f46; padding:4px 8px; border-radius:12px; font-size:0.75rem;"><%# Eval("Status") %></span>
                            </td>
                            <td style="padding:12px;">
                                <%# !string.IsNullOrEmpty(Eval("ArchivoUrl")?.ToString()) 
                                    ? string.Format("<a href='{0}' target='_blank' class='btn btn-sm btn-outline'>Ver Contrato PDF</a>", ResolveUrl("~/" + Eval("ArchivoUrl")))
                                    : "<span style='color:#9ca3af; font-size:0.85rem;'>Sin adjunto</span>" %>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
        
        <asp:Label ID="lblVacio" runat="server" Visible="false" style="display:block; text-align:center; padding:20px; color:#6b7280; font-style:italic;">No hay contratos registrados en el sistema.</asp:Label>
    </div>
</asp:Content>
