<%@ Page Title="Informes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AdminInformes.aspx.cs" Inherits="ConviAppWeb.AdminInformes" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <style>
            .report-box {
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                padding: 20px;
                text-align: center;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 24px;">
            <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Informes y Métricas</h2>
            <p style="color: #6b7280;">Estadísticas globales de rendimiento y facturación.</p>
        </div>

        <div class="glass-card" style="padding: 24px;">
            <div style="display:grid; grid-template-columns: repeat(3, 1fr); gap:16px; margin-bottom:24px;">
                <div class="report-box">
                    <span style="font-size:2rem; display:block; margin-bottom:8px;">📈</span>
                    <strong style="display:block; font-size:1.1rem; color:#111827;">Ingresos del mes</strong>
                    <span style="color:#10b981; font-weight:bold;">$4,250.00</span>
                </div>
                <div class="report-box">
                    <span style="font-size:2rem; display:block; margin-bottom:8px;">✅</span>
                    <strong style="display:block; font-size:1.1rem; color:#111827;">Tareas Completadas</strong>
                    <span style="color:#3b82f6; font-weight:bold;">12,500</span>
                </div>
                <div class="report-box">
                    <span style="font-size:2rem; display:block; margin-bottom:8px;">⚡</span>
                    <strong style="display:block; font-size:1.1rem; color:#111827;">Suscripciones Pro</strong>
                    <span style="color:#8b5cf6; font-weight:bold;">842</span>
                </div>
            </div>

            <h3 style="margin-bottom:16px;">Descargar Reportes en CSV/PDF</h3>
            <button class="btn btn-outline" style="margin-right:8px;">🔽 Resumen Financiero</button>
            <button class="btn btn-outline">🔽 Exportar Usuarios Activos</button>
        </div>
    </asp:Content>


