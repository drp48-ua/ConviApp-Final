<%@ Page Title="Gestión de Pisos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AdminPisos.aspx.cs" Inherits="ConviAppWeb.AdminPisos" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 24px;">
            <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Administración de Pisos</h2>
            <p style="color: #6b7280;">Revisa, elimina o suspende pisos reportados o inactivos.</p>
        </div>

        <div class="glass-card" style="padding: 24px;">
            <p style="color:#6b7280;">Buscador de inmuebles en plataforma...</p>
            <div style="margin-top: 16px; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 16px;">
                <asp:Repeater ID="rptPisos" runat="server">
                    <ItemTemplate>
                        <div style="border:1px solid #e5e7eb; border-radius:8px; padding:16px;">
                            <h4 style="margin-bottom:8px;">Piso #<%# Eval("Id") %> - <%# Eval("Ciudad") %></h4>
                            <p style="font-size:0.85rem; color:#6b7280; margin-bottom:12px;">
                                Dirección: <%# Eval("Direccion") %><br />
                                Habitaciones: <%# Eval("NumeroHabitaciones") %><br />
                                Precio: <%# Eval("PrecioTotal") %>€
                            </p>
                            <div style="display:flex; gap:8px;">
                                <a href="PisoDetail.aspx?id=<%# Eval("Id") %>" class="btn btn-sm btn-outline">Ver Detalle</a>
                                <button type="button" class="btn btn-sm" style="background:#ef4444; color:white;">Suspender</button>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </asp:Content>
