<%@ Page Title="Gestión de Incidencias" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AdminIncidencias.aspx.cs" Inherits="ConviAppWeb.AdminIncidencias" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <style>
            .filter-btn {
                border: 1px solid #d1d5db;
                background: white;
                padding: 6px 12px;
                border-radius: 16px;
                font-size: 0.85rem;
                cursor: pointer;
                color: #4b5563;
            }

            .filter-btn.active {
                background: #e0e7ff;
                color: #4338ca;
                border-color: #818cf8;
                font-weight: 600;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 24px;">
            <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Moderación de Incidencias</h2>
            <p style="color: #6b7280;">Supervisa los conflictos entre usuarios y problemas de la plataforma.</p>
        </div>

        <div class="glass-card" style="padding: 24px;">
            <div style="display:flex; gap:8px; margin-bottom:20px;">
                <button class="filter-btn active">Todas</button>
                <button class="filter-btn">Graves / Críticas</button>
                <button class="filter-btn">No resueltas</button>
            </div>

            <div
                style="border:1px solid #fee2e2; border-left:4px solid #ef4444; background:#fef2f2; border-radius:8px; padding:16px; margin-bottom:16px;">
                <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
                    <strong style="color:#991b1b;">[URGENTE] Conflicto impago de fianza - Piso #102</strong>
                    <span class="badge"
                        style="background:#fecaca; color:#b91c1c; padding:4px 8px; border-radius:12px; font-size:0.75rem;">Abierta</span>
                </div>
                <p style="font-size:0.85rem; color:#7f1d1d; margin-bottom:12px;">Un usuario ha reportado que el
                    compañero no devuelve la fianza tras 2 meses.</p>
                <div style="display:flex; gap:8px;">
                    <button class="btn btn-sm" style="background:#ef4444; color:white;">Contactar Usuarios</button>
                    <button class="btn btn-sm btn-outline">Cerrar disputa</button>
                </div>
            </div>
        </div>
    </asp:Content>


