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

        <% if (Session["UserRole"]==null || Session["UserRole"].ToString()=="Basico" ) { %>
            <div class="ad-slider-wrap"
                style="margin-bottom:24px; position:relative; background:white; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; display:flex; align-items:center;">
                <div style="width:120px; height:80px; overflow:hidden; flex-shrink:0;">
                    <img src="https://images.unsplash.com/photo-1568225422896-e17f9ebdc6dd?w=400&h=300&fit=crop"
                        style="width:100%; height:100%; object-fit:cover;" />
                </div>
                <div style="padding:16px; flex:1;">
                    <div
                        style="position:absolute; top:0; right:0; background:#f3f4f6; padding:2px 8px; font-size:0.7rem; font-weight:600; color:#6b7280; border-bottom-left-radius:6px;">
                        PUBLICIDAD</div>
                    <strong style="color:var(--primary); font-size:1.1rem; display:block; margin-bottom:4px;">Gestoría
                        Legal Premium</strong>
                    <span style="color:#4b5563; font-size:0.9rem;">Revisión de cláusulas abusivas desde 10€.</span>
                </div>
            </div>
            <% } %>

                <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                    <div style="position:relative;">
                        <div class="glass-card" style="margin-bottom:24px; position:relative; pointer-events:none;">
                            <h4 style="margin-top:0; color:var(--primary-light);">📤 Subir documento</h4>
                            <div style="display:flex; gap:12px; flex-wrap:wrap; align-items:flex-end;">
                                <input type="text" class="form-input" placeholder="Nombre del documento"
                                    style="flex:2; min-width:200px;" disabled />
                                <select class="form-input" style="flex:1; min-width:150px;" disabled>
                                    <option>🪪 DNI/NIE</option>
                                </select>
                                <input type="text" class="form-input" placeholder="Descripción (opcional)"
                                    style="flex:1; min-width:150px;" disabled />
                                <div class="btn btn-primary btn-sm">Registrar</div>
                            </div>
                        </div>
                        <a href="Registro.aspx"
                            style="position:absolute; top:0; left:0; width:100%; height:120px; z-index:10; cursor:pointer;"
                            title="Registrate para subir documentos"></a>

                        <div class="glass-card" style="padding:0; overflow:hidden;">
                            <table class="data-table" style="width:100%; border-collapse:collapse;">
                                <tr>
                                    <th
                                        style="padding:12px; border-bottom:1px solid #e5e7eb; text-align:left; color:#6b7280; font-size:0.85rem;">
                                        Archivo</th>
                                    <th
                                        style="padding:12px; border-bottom:1px solid #e5e7eb; text-align:left; color:#6b7280; font-size:0.85rem;">
                                        Tipo</th>
                                    <th
                                        style="padding:12px; border-bottom:1px solid #e5e7eb; text-align:left; color:#6b7280; font-size:0.85rem;">
                                        Descripción</th>
                                    <th
                                        style="padding:12px; border-bottom:1px solid #e5e7eb; text-align:left; color:#6b7280; font-size:0.85rem;">
                                        Acciones</th>
                                </tr>
                                <tr>
                                    <td style="padding:12px; border-bottom:1px solid #e5e7eb;">DNI Inquilino.pdf</td>
                                    <td style="padding:12px; border-bottom:1px solid #e5e7eb;">dni</td>
                                    <td style="padding:12px; border-bottom:1px solid #e5e7eb;">Documento de Ana M.</td>
                                    <td style="padding:12px; border-bottom:1px solid #e5e7eb;">
                                        <a href="Registro.aspx" class="btn btn-sm"
                                            style="background:rgba(248,113,113,0.1); color:#f87171; border:1px solid rgba(248,113,113,0.3); text-decoration:none;">🗑</a>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="glass-card"
                            style="text-align: center; padding: 2rem; margin-top:24px; background:linear-gradient(135deg, rgba(239,246,255,0.8), rgba(219,234,254,0.8)); border:1px solid #bfdbfe; box-shadow:0 10px 15px -3px rgba(59,130,246,0.1);">
                            <div style="font-size: 2.5rem; margin-bottom: 8px;">📎</div>
                            <h3 style="color: var(--primary); font-size: 1.3rem; margin-bottom: 8px;">Repositorio de
                                documentos seguro</h3>
                            <p
                                style="color: var(--text-secondary); max-width: 500px; margin: 0 auto 16px; font-size:0.9rem;">
                                Almacena DNI, recibos, y facturas de forma segura para tenerlas siempre accesibles para
                                tus convivientes. Crea tu cuenta gratis para probar la App.</p>
                            <a href="Registro.aspx" class="btn btn-primary"
                                style="font-size: 1rem; padding: 10px 20px; box-shadow:0 4px 6px rgba(37,99,235,0.2);">Regístrate
                                gratis</a>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlApp" runat="server">

                    <div class="glass-card" style="margin-bottom:24px;">
                        <h4 style="margin-top:0; color:var(--primary-light);">📤 Subir documento</h4>
                        <div style="display:flex; gap:12px; flex-wrap:wrap; align-items:flex-end;">
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input"
                                placeholder="Nombre del documento" style="flex:2; min-width:200px;" />
                            <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-input"
                                style="flex:1; min-width:150px;">
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
                            <asp:GridView ID="gvDocumentos" runat="server" AutoGenerateColumns="false"
                                CssClass="data-table" style="width:100%;" GridLines="None"
                                OnRowCommand="GvDocumentos_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="FileName" HeaderText="Archivo" />
                                    <asp:BoundField DataField="Type" HeaderText="Tipo" />
                                    <asp:BoundField DataField="Description" HeaderText="Descripción" />
                                    <asp:BoundField DataField="UploadDate" HeaderText="Fecha"
                                        DataFormatString="{0:d}" />
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

                </asp:Panel>
    </asp:Content>