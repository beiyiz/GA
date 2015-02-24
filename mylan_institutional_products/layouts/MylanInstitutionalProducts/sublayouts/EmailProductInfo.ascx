<%@ Control Language="c#" AutoEventWireup="true" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" Inherits="Layouts.Emailproductinfo.EmailproductinfoSublayout" CodeFile="~/layouts/MylanInstitutionalProducts/sublayouts/EmailProductInfo.ascx.cs" %>

<asp:UpdatePanel ID="upEmail" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>
        <asp:Panel ID="pn_MsgContainer" CssClass="msg-container" Visible="false" runat="server">
            <asp:Label ID="Messages" runat="server" Visible="true" />
        </asp:Panel>
        <div id="div_ProductDisplay">
            <div id="div_ProductHeaders">
                <ul class="products">
                    <asp:Repeater ID="rp_products" runat="server" OnItemCommand="rp_products_ItemCommand">
                        <ItemTemplate>
                            <li class="odd<%# Container.ItemIndex == 0 ? " first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? " last" : "" %> " id="li-<%# Eval("ProductID").ToString().Replace("{", "").Replace("}", "")%>">
                                <span class="product-title"><%# Eval("ProductName")%></span>
                                <a onclick="removeProduct(this)" id="<%# Eval("ProductID").ToString().Replace("{", "").Replace("}", "")%>" class="remove-button">
                                    <img src="/assets/MylanInstitutionalProducts/images/x-button.png" style="width: 100%;" /></a>
                                <div class="product-info">
                                    <div class="product-prescribing-info">
                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                    </div>
                                    <div class="product-warnings">
                                        <span><%# Eval("AttrWarnings") %> </span>
                                    </div>
                                    <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_odd" runat="server" DataSource='<%# GetProductDetailsByID(Eval("ProductID").ToString()) %>'>
                                        <HeaderTemplate>
                                            <table class="product-info-table">
                                                <thead>
                                                    <tr>
                                                        <td class="td-cb"></td>
                                                        <td class="td-ndc">NDC</td>
                                                        <td class="td-info">Product Information</td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="grey-row">
                                                <td class="td-cb"></td>
                                                <td class="td-ndc"><%# Eval("NDC").ToString() %></td>
                                                <td class="td-info">
                                                    <ul class="product-info-table-product-desc">
                                                        <%# Eval("ProductDescription").ToString() != "" ? ("<li>Form: " + Eval("ProductDescription").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrStrength").ToString() != "" ? ("<li>Strength: " + Eval("AttrStrength").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrDose").ToString() != "" ? ("<li>Dose: " + Eval("AttrDose").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrClosureSize").ToString() != "" ? ("<li>Closure Size: " + Eval("AttrClosureSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrFillVolume").ToString() != "" ? ("<li>Fill Volume: " + Eval("AttrFillVolume").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrVialSize").ToString() != "" ? ("<li>Vial Size: " + Eval("AttrVialSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgPackage").ToString() != "" ? ("<li>Package: " + Eval("PkgPackage").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgPackSize").ToString() != "" ? ("<li>Pack Size: " + Eval("PkgPackSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgBoxesPerCase").ToString() != "" ? ("<li>Boxed Per Case: " + Eval("PkgBoxesPerCase").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgOrderingMultiple").ToString() != "" ? ("<li>Ordering Multiple: " + Eval("PkgOrderingMultiple").ToString() + "</li>") : "" %>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <tr class="blue-row">
                                                <td class="td-cb"></td>
                                                <td class="td-ndc"><%# Eval("NDC").ToString() %></td>
                                                <td class="td-info">
                                                    <ul class="product-info-table-product-desc">
                                                        <%# Eval("ProductDescription").ToString() != "" ? ("<li>Form: " + Eval("ProductDescription").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrStrength").ToString() != "" ? ("<li>Strength: " + Eval("AttrStrength").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrDose").ToString() != "" ? ("<li>Dose: " + Eval("AttrDose").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrClosureSize").ToString() != "" ? ("<li>Closure Size: " + Eval("AttrClosureSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrFillVolume").ToString() != "" ? ("<li>Fill Volume: " + Eval("AttrFillVolume").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrVialSize").ToString() != "" ? ("<li>Vial Size: " + Eval("AttrVialSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgPackage").ToString() != "" ? ("<li>Package: " + Eval("PkgPackage").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgPackSize").ToString() != "" ? ("<li>Pack Size: " + Eval("PkgPackSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgBoxesPerCase").ToString() != "" ? ("<li>Boxed Per Case: " + Eval("PkgBoxesPerCase").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgOrderingMultiple").ToString() != "" ? ("<li>Ordering Multiple: " + Eval("PkgOrderingMultiple").ToString() + "</li>") : "" %>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </AlternatingItemTemplate>
                                        <FooterTemplate>
                                            </tbody>
                    </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </li>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <li class="even<%# Container.ItemIndex == 0 ? " first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? " last" : "" %>" id="li-<%# Eval("ProductID").ToString().Replace("{", "").Replace("}", "")%>">
                                <span class="product-title"><%# Eval("ProductName")%></span>
                                <a onclick="removeProduct(this)" id="<%# Eval("ProductID").ToString().Replace("{", "").Replace("}", "") %>" class="remove-button">
                                    <img src="/assets/MylanInstitutionalProducts/images/x-button.png" style="width: 100%;" /></a>
                                <div class="product-info">
                                    <div class="product-prescribing-info">
                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='/assets/MylanInstitutionalProducts/pdfs/"+Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                    </div>
                                    <div class="product-warnings">
                                        <span><%# Eval("AttrWarnings") %> </span>
                                    </div>
                                    <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_even" runat="server" DataSource='<%# GetProductDetailsByID(Eval("ProductID").ToString()) %>'>
                                        <HeaderTemplate>
                                            <table class="product-info-table">
                                                <thead>
                                                    <tr>
                                                        <td class="td-cb"></td>
                                                        <td class="td-ndc">NDC</td>
                                                        <td class="td-info">Product Information</td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="grey-row">
                                                <td class="td-cb"></td>
                                                <td class="td-ndc"><%# Eval("NDC").ToString() %></td>
                                                <td class="td-info">
                                                    <ul class="product-info-table-product-desc">
                                                        <%# Eval("ProductDescription").ToString() != "" ? ("<li>Form: " + Eval("ProductDescription").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrStrength").ToString() != "" ? ("<li>Strength: " + Eval("AttrStrength").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrDose").ToString() != "" ? ("<li>Dose: " + Eval("AttrDose").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrClosureSize").ToString() != "" ? ("<li>Closure Size: " + Eval("AttrClosureSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrFillVolume").ToString() != "" ? ("<li>Fill Volume: " + Eval("AttrFillVolume").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrVialSize").ToString() != "" ? ("<li>Vial Size: " + Eval("AttrVialSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgPackage").ToString() != "" ? ("<li>Package: " + Eval("PkgPackage").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgPackSize").ToString() != "" ? ("<li>Pack Size: " + Eval("PkgPackSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgBoxesPerCase").ToString() != "" ? ("<li>Boxed Per Case: " + Eval("PkgBoxesPerCase").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgOrderingMultiple").ToString() != "" ? ("<li>Ordering Multiple: " + Eval("PkgOrderingMultiple").ToString() + "</li>") : "" %>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <tr class="blue-row">
                                                <td class="td-cb"></td>
                                                <td class="td-ndc"><%# Eval("NDC").ToString() %></td>
                                                <td class="td-info">
                                                    <ul class="product-info-table-product-desc">
                                                        <%# Eval("ProductDescription").ToString() != "" ? ("<li>Form: " + Eval("ProductDescription").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrStrength").ToString() != "" ? ("<li>Strength: " + Eval("AttrStrength").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrDose").ToString() != "" ? ("<li>Dose: " + Eval("AttrDose").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrClosureSize").ToString() != "" ? ("<li>Closure Size: " + Eval("AttrClosureSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrFillVolume").ToString() != "" ? ("<li>Fill Volume: " + Eval("AttrFillVolume").ToString() + "</li>") : "" %>
                                                        <%# Eval("AttrVialSize").ToString() != "" ? ("<li>Vial Size: " + Eval("AttrVialSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgPackage").ToString() != "" ? ("<li>Package: " + Eval("PkgPackage").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgPackSize").ToString() != "" ? ("<li>Pack Size: " + Eval("PkgPackSize").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgBoxesPerCase").ToString() != "" ? ("<li>Boxed Per Case: " + Eval("PkgBoxesPerCase").ToString() + "</li>") : "" %>
                                                        <%# Eval("PkgOrderingMultiple").ToString() != "" ? ("<li>Ordering Multiple: " + Eval("PkgOrderingMultiple").ToString() + "</li>") : "" %>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </AlternatingItemTemplate>
                                        <FooterTemplate>
                                            </tbody>
                     </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </li>
                        </AlternatingItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>

        <div id="div_EmailForm">

            <div id="div_YourName">
                <div id="div_YourNameField" style="display: inline-block;">
                    <label id="div_YourNameLabel" for="Form_tbx_YourName">Your Name</label><br />
                    <asp:TextBox ID="tbx_YourName" runat="server" CssClass="required" minlength="2"></asp:TextBox>
                </div>
            </div>

            <div id="div_YourEmail">
                <div id="div_YourEmailField" style="display: inline-block;">
                    <label id="div_YourEmailLabel" for="Form_tbx_YourEmail">Your Email Address</label><br />
                    <asp:TextBox ID="tbx_YourEmail" runat="server" CssClass="required email"></asp:TextBox>
                </div>
            </div>

            <div id="div_RecipientEmail">
                <div id="div_RecipientEmailField" style="display: inline-block;">
                    <label id="div_RecipientEmailLabel">Recipient Email Address</label><br />
                    <asp:TextBox ID="tbx_RecipientEmail" runat="server" CssClass="required email"></asp:TextBox>
                </div>
            </div>

            <div id="div_SubjectLine">
                <div id="div_SubjectLineField" style="display: inline-block;">
                    <label id="div_SubjectLineLabel" for="Form_tbx_SubjectLine">Subject</label><br />
                    <asp:TextBox ID="tbx_SubjectLine" runat="server" CssClass="required"></asp:TextBox>
                </div>
            </div>

            <div id="div_Message">
                <div id="div_MessageField">
                    <label id="div_MessageLabel" for="tbx_Message">Message</label><br />
                    <asp:TextBox ID="tbx_Message" runat="server" TextMode="MultiLine" MaxLength="255" CssClass="required" Rows="10" Columns="75"></asp:TextBox>
                </div>
            </div>

            <div id="div_Button">
                <asp:Button ID="btn_Send" runat="server" Text="Send Email"
                    OnClientClick="_gaq.push(['_trackEvent', 'form', 'Click', 'Selections Sent']);" OnClick="btn_Send_Click" />
            </div>

        </div>
    </ContentTemplate>
</asp:UpdatePanel>
