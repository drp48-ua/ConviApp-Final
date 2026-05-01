<%@ Page Title="Gestión de Usuarios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AdminUsuarios.aspx.cs" Inherits="ConviAppWeb.AdminUsuarios" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 24px; display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Gestión de Usuarios</h2>
                <p style="color: #6b7280;">Búsqueda, modificación de roles y eliminación.</p>
            </div>
            <button class="btn btn-primary">+ Invitar Admin</button>
        </div>

        <div class="glass-card" style="padding: 24px;">
            <div
                style="display: flex; gap: 16px; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid #e5e7eb;">
                <input type="text" placeholder="Buscar por email o nombre..."
                    style="flex:1; padding:10px; border:1px solid #d1d5db; border-radius:6px; outline:none;" />
                <select style="padding:10px; border:1px solid #d1d5db; border-radius:6px; outline:none;">
                    <option value="">Todos los roles</option>
                    <option value="Basico">Básico</option>
                    <option value="Profesional">Profesional</option>
                    <option value="Enterprise">Enterprise</option>
                    <option value="Admin">Admin</option>
                </select>
                <button class="btn btn-outline">Buscar</button>
            </div>

            <table style="width:100%; border-collapse:collapse; text-align:left;">
                <thead>
                    <tr style="border-bottom:2px solid #e5e7eb;">
                        <th style="padding:12px; color:#6b7280; font-weight:600;">Usuario</th>
                        <th style="padding:12px; color:#6b7280; font-weight:600;">Rol</th>
                        <th style="padding:12px; color:#6b7280; font-weight:600;">Pisos</th>
                        <th style="padding:12px; color:#6b7280; font-weight:600; text-align:right;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptUsuarios" runat="server">
                        <ItemTemplate>
                            <tr style="border-bottom:1px solid #f3f4f6;">
                                <td style="padding:12px;">
                                    <strong><%# Eval("Nombre") %></strong><br />
                                    <small style="color:#6b7280"><%# Eval("Email") %></small>
                                </td>
                                <td style="padding:12px;">
                                    <span class="badge" style="background:#eff6ff; color:#3b82f6; padding:4px 8px; border-radius:12px; font-size:0.75rem;">
                                        <%# Eval("Rol.Nombre") %>
                                    </span>
                                </td>
                                <td style="padding:12px;">N/A</td>
                                <td style="padding:12px; text-align:right;">
                                    <button class="btn btn-sm btn-outline" type="button">Editar</button>
                                    <button class="btn btn-sm" type="button" style="color:red; background:transparent; border:none; cursor:pointer;">❌</button>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </asp:Content>
