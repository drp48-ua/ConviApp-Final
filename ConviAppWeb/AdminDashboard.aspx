<%@ Page Title="Panel Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AdminDashboard.aspx.cs" Inherits="ConviAppWeb.AdminDashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 24px;">
            <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Panel de Administrador</h2>
            <p style="color: #6b7280;">Resumen general de ConviApp: usuarios, pisos, pagos e incidencias.</p>
        </div>

        <!-- KPI Cards -->
        <div
            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-bottom: 32px;">
            <div class="glass-card" style="padding: 20px;">
                <div style="font-size: 0.85rem; color: #6b7280; font-weight: 600; text-transform: uppercase;">Usuarios
                    Registrados</div>
                <div style="font-size: 2rem; font-weight: 800; color: #111827; margin-top: 8px;">
                    <asp:Label ID="lblTotalUsuarios" runat="server" Text="0"></asp:Label>
                </div>
                <div style="font-size: 0.8rem; color: #10b981; font-weight: 500;">+12% este mes</div>
            </div>
            <div class="glass-card" style="padding: 20px;">
                <div style="font-size: 0.85rem; color: #6b7280; font-weight: 600; text-transform: uppercase;">Pisos
                    Activos</div>
                <div style="font-size: 2rem; font-weight: 800; color: #111827; margin-top: 8px;">
                    <asp:Label ID="lblTotalPisos" runat="server" Text="0"></asp:Label>
                </div>
                <div style="font-size: 0.8rem; color: #10b981; font-weight: 500;">+5% este mes</div>
            </div>
            <div class="glass-card" style="padding: 20px;">
                <div style="font-size: 0.85rem; color: #6b7280; font-weight: 600; text-transform: uppercase;">
                    Incidencias Abiertas</div>
                <div style="font-size: 2rem; font-weight: 800; color: #111827; margin-top: 8px;">
                    <asp:Label ID="lblTotalIncidencias" runat="server" Text="0"></asp:Label>
                </div>
                <div style="font-size: 0.8rem; color: #ef4444; font-weight: 500;">-2% desde ayer</div>
            </div>
            <div class="glass-card" style="padding: 20px;">
                <div style="font-size: 0.85rem; color: #6b7280; font-weight: 600; text-transform: uppercase;">Ingresos
                    (MRR)</div>
                <div style="font-size: 2rem; font-weight: 800; color: #111827; margin-top: 8px;">
                    <asp:Label ID="lblIngresos" runat="server" Text="$0"></asp:Label>
                </div>
                <div style="font-size: 0.8rem; color: #10b981; font-weight: 500;">+8% este mes</div>
            </div>
        </div>

        <!-- Recent Activity Placeholder -->
        <div class="glass-card" style="padding: 24px;">
            <h3 style="font-size: 1.2rem; margin-bottom: 16px;">Actividad Reciente</h3>
            <p style="color: #6b7280; margin-bottom: 16px;">Mostrando las últimas alertas administrativas...</p>
            <ul style="list-style: none; padding: 0; margin: 0;">
                <li
                    style="padding: 12px 0; border-bottom: 1px solid #e5e7eb; display: flex; justify-content: space-between;">
                    <span>🔴 Nueva incidencia crítica en Piso #102</span>
                    <span class="badge"
                        style="background:#fef2f2; color:#ef4444; padding:4px 8px; border-radius:12px; font-size:0.75rem;">Hace
                        10 min</span>
                </li>
                <li
                    style="padding: 12px 0; border-bottom: 1px solid #e5e7eb; display: flex; justify-content: space-between;">
                    <span>🟢 Nuevo usuario suscrito a plan Profesional</span>
                    <span class="badge"
                        style="background:#ecfdf5; color:#10b981; padding:4px 8px; border-radius:12px; font-size:0.75rem;">Hace
                        1 hora</span>
                </li>
                <li style="padding: 12px 0; display: flex; justify-content: space-between;">
                    <span>🏢 Piso #452 ha sido verificado</span>
                    <span class="badge"
                        style="background:#eff6ff; color:#3b82f6; padding:4px 8px; border-radius:12px; font-size:0.75rem;">Hace
                        2 horas</span>
                </li>
            </ul>
        </div>
    </asp:Content>
