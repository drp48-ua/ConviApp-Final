<%@ Page Title="Documentos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Documentos.aspx.cs" Inherits="ConviAppWeb.Documentos" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dash-tabs">
            <a href="Index.aspx" class="dash-tab">📊 Resumen</a>
            <a href="Tareas.aspx" class="dash-tab">✅ Tareas</a>
            <a href="Gastos.aspx" class="dash-tab">💸 Gastos</a>
            <a href="Mensajes.aspx" class="dash-tab">💬 Mensajes</a>
            <a href="Reservas.aspx" class="dash-tab">📅 Reservas</a>
            <a href="Incidencias.aspx" class="dash-tab">🔧 Incidencias</a>
            <a href="ContratosYPagos.aspx" class="dash-tab">📄 Contratos</a>
            <a href="Documentos.aspx" class="dash-tab active">📎 Documentos</a>
            <a href="MisPisos.aspx" class="dash-tab">🏠 Mis Pisos</a>
        </div>

        <h2 style="margin-bottom:20px;">📎 Documentos</h2>

        <div class="glass-card" style="margin-bottom:24px;">
            <h4 style="margin-top:0; color:var(--primary-light);">📤 Subir documento</h4>
            <div style="display:flex; gap:12px; flex-wrap:wrap; align-items:flex-end;">
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input" placeholder="Nombre del documento"
                    style="flex:2; min-width:200px;" />
                <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-input" style="flex:1; min-width:150px;">
                    <asp:ListItem Value="contrato">📋 Contrato</asp:ListItem>
                    <asp:ListItem Value="recibo">🧾 Recibo</asp:ListItem>
                    <asp:ListItem Value="factura">📄 Factura</asp:ListItem>
                    <asp:ListItem Value="dni">🪪 DNI/NIE</asp:ListItem>
                    <asp:ListItem Value="otro">📎 Otro</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-input"
                    placeholder="Descripción (opcional)" style="flex:1; min-width:150px;" />
                <asp:Button ID="btnSubir" runat="server" Text="Registrar" CssClass="btn btn-primary btn-sm"
                    OnClick="BtnSubir_Click" />
            </div>
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"
                style="margin-top:8px; display:block;" />
        </div>

        <asp:Panel ID="pnlVacio" runat="server" Visible="false">
            <div class="glass-card" style="text-align:center; padding:3rem; color:var(--text-muted);">
                <div style="font-size:3rem; margin-bottom:16px;">📎</div>
                <p>No hay documentos registrados.</p>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlTabla" runat="server" Visible="false">
            <div class="glass-card" style="padding:0; overflow:hidden;">
                <asp:GridView ID="gvDocumentos" runat="server" AutoGenerateColumns="false" CssClass="data-table"
                    style="width:100%;" GridLines="None" OnRowCommand="GvDocumentos_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="FileName" HeaderText="Archivo" />
                        <asp:BoundField DataField="Type" HeaderText="Tipo" />
                        <asp:BoundField DataField="Description" HeaderText="Descripción" />
                        <asp:BoundField DataField="UploadDate" HeaderText="Fecha" DataFormatString="{0:d}" />
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="Eliminar"
                                    CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm"
                                    style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3);"
                                    OnClientClick="return confirm('¿Eliminar?')">🗑</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </asp:Panel>
    </asp:Content>