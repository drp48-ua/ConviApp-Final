<%@ Page Title="Gestión de Publicidad" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AdminPublicidad.aspx.cs" Inherits="ConviAppWeb.AdminPublicidad" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 24px;">
            <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Campañas de Publicidad</h2>
            <p style="color: #6b7280;">Añade nuevos anuncios dirigidos a las cuentas Gratuitas.</p>
        </div>

        <div class="glass-card" style="padding:24px; margin-bottom:32px;">
            <h3 style="margin-bottom:16px;">Nuevo Anuncio</h3>
            <div style="display:flex; gap:16px; margin-bottom:16px;">
                <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" Placeholder="Título del anuncio" style="flex:1;"></asp:TextBox>
                <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" Placeholder="Descripción corta" style="flex:2;"></asp:TextBox>
                <asp:Button ID="btnAddAd" runat="server" Text="Guardar Anuncio" CssClass="btn btn-primary" OnClick="btnAddAd_Click" />
            </div>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 16px;">
            <asp:Repeater ID="rptAds" runat="server">
                <ItemTemplate>
                    <div class="glass-card" style="padding:0; overflow:hidden;">
                        <div style='height:120px; background:<%# Eval("Bg") %>; color:white; padding:20px; text-align:center;'>
                            <h3 style="font-size:1.2rem;"><%# Eval("Title") %></h3>
                        </div>
                        <div style="padding:16px;">
                            <p style="font-size:0.85rem; color:#4b5563; margin-bottom:12px;"><%# Eval("Desc") %></p>
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                                <span class="badge" style="background:#ecfdf5; color:#10b981; padding:4px 8px; border-radius:12px; font-size:0.75rem;">Activo</span>
                                <asp:LinkButton ID="btnDeleteAd" runat="server" CommandArgument='<%# Eval("Id") %>' OnCommand="btnDeleteAd_Command" CssClass="btn btn-sm" style="color:red; background:transparent; border:none;">❌ Borrar</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </asp:Content>


