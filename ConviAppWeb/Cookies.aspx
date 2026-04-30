<%@ Page Title="Política de Cookies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Cookies.aspx.cs" Inherits="ConviAppWeb.Cookies" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="glass-card" style="max-width:800px; margin:0 auto; padding:3rem;">
            <h1 style="margin-top:0;">🍪 Política de Cookies</h1>
            <p style="color:var(--text-muted);">Última actualización: Abril 2026</p>
            <h3>¿Qué son las cookies?</h3>
            <p>Las cookies son pequeños archivos de texto que se almacenan en tu dispositivo cuando visitas un sitio
                web. Ayudan a recordar tus preferencias y sesión.</p>
            <h3>Cookies que usamos</h3>
            <table class="data-table" style="margin-top:12px;">
                <thead>
                    <tr>
                        <th>Cookie</th>
                        <th>Tipo</th>
                        <th>Finalidad</th>
                        <th>Duración</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>ASP.NET_SessionId</td>
                        <td>Sesión</td>
                        <td>Mantiene la sesión del usuario autenticado</td>
                        <td>Al cerrar el navegador</td>
                    </tr>
                    <tr>
                        <td>__AntiXsrfToken</td>
                        <td>Seguridad</td>
                        <td>Protección CSRF</td>
                        <td>Sesión</td>
                    </tr>
                </tbody>
            </table>
            <h3 style="margin-top:1.5rem;">Control de cookies</h3>
            <p>Puedes deshabilitar las cookies desde la configuración de tu navegador. Ten en cuenta que deshabilitar
                las cookies de sesión impedirá el correcto funcionamiento del login.</p>
            <div style="margin-top:2rem;">
                <a href="Index.aspx" style="color:var(--text-muted); text-decoration:none;">← Volver al inicio</a>
            </div>
        </div>
    </asp:Content>