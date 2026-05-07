<%@ Page Title="Gestión de Publicidad" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AdminPublicidad.aspx.cs" Inherits="ConviAppWeb.AdminPublicidad" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div style="margin-bottom: 24px;">
            <h2 style="font-size: 1.8rem; color: #111827; margin-bottom: 8px;">Campañas de Publicidad</h2>
            <p style="color: #6b7280;">Añade nuevos anuncios dirigidos a las cuentas Gratuitas.</p>
        </div>

        <div class="glass-card" style="padding:24px; margin-bottom:32px; background-color:#eff6ff; border-left:4px solid #3b82f6;">
            <h3 style="margin-bottom:8px;">Modo de Edición</h3>
            <p style="color:#1e40af; font-size:0.9rem;">
                La creación de nuevos anuncios ha sido deshabilitada por motivos de diseño del overlay. Solo puedes modificar los textos de los anuncios actuales.
            </p>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 16px;">
            <asp:Repeater ID="rptAds" runat="server" OnItemCommand="rptAds_ItemCommand">
                <ItemTemplate>
                    <div class="glass-card" style="padding:0; overflow:hidden;">
                        <div style='height:120px; background:<%# Eval("Bg") %>; color:white; padding:20px; text-align:center;'>
                            <h3 style="font-size:1.2rem;"><%# Eval("Title") %></h3>
                        </div>
                        <div style="padding:16px;">
                            <asp:TextBox ID="txtEditTitulo" runat="server" Text='<%# Eval("Title") %>' CssClass="form-control" style="margin-bottom:8px; width:100%; font-weight:bold;" />
                            <asp:TextBox ID="txtEditDesc" runat="server" Text='<%# Eval("Desc") %>' CssClass="form-control" TextMode="MultiLine" Rows="2" style="margin-bottom:12px; width:100%; font-size:0.85rem;" />
                            
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                                <span class="badge" style="background:#ecfdf5; color:#10b981; padding:4px 8px; border-radius:12px; font-size:0.75rem;">Activo</span>
                                <asp:Button ID="btnSaveAd" runat="server" Text="Guardar" CommandName="Guardar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-primary" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </asp:Content>


