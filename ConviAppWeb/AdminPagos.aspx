<%@ Page Title="Gestión de Pagos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AdminPagos.aspx.cs" Inherits="ConviAppWeb.AdminPagos" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 24px;">
            <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Contratos y Pagos</h2>
            <p style="color: #6b7280;">Valida transacciones sospechosas y revisa disputas de alquiler.</p>
        </div>

        <div class="glass-card" style="padding: 24px;">
            <h3 style="margin-bottom:16px;">Pagos Pendientes de Validación</h3>
            <table style="width:100%; border-collapse:collapse; text-align:left;">
                <thead>
                    <tr style="border-bottom:2px solid #e5e7eb;">
                        <th style="padding:12px; color:#6b7280; font-weight:600;">ID Pago</th>
                        <th style="padding:12px; color:#6b7280; font-weight:600;">Usuario</th>
                        <th style="padding:12px; color:#6b7280; font-weight:600;">Monto</th>
                        <th style="padding:12px; color:#6b7280; font-weight:600;">Estado</th>
                        <th style="padding:12px; color:#6b7280; font-weight:600;">Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <tr style="border-bottom:1px solid #f3f4f6;">
                        <td style="padding:12px;">TX-9938</td>
                        <td style="padding:12px;">luisa@example.com</td>
                        <td style="padding:12px; font-weight:bold;">450.00 €</td>
                        <td style="padding:12px;"><span class="badge"
                                style="background:#fffbeb; color:#d97706; padding:4px 8px; border-radius:12px; font-size:0.75rem;">En
                                revisión</span></td>
                        <td style="padding:12px;">
                            <button class="btn btn-sm btn-primary">Validar</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </asp:Content>
