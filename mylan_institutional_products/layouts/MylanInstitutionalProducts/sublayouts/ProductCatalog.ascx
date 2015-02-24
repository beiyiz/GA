<%@ Control Language="c#" AutoEventWireup="True" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" Inherits="Layouts.Productcatalog.ProductcatalogSublayout" CodeBehind="ProductCatalog.ascx.cs" %>
<asp:UpdateProgress ID="updateProgress" runat="server">
    <ProgressTemplate>
        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
            <span style="border-width: 0px; position: fixed; padding: 50px; color: white; font-size: 36px; left: 40%; top: 40%;">Loading ...</span>
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:UpdatePanel ID="pnWholeSaler" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>
        <div id="body-prefix">
            <asp:Panel class="msg-container" runat="server">
                <h4>Search by Product or NDC</h4>
                <ul><li>Enter the name of the product or NDC number you’re looking for in the search bar at the top right, or click on the category toolbars below</li></ul>
            </asp:Panel>
            <asp:Panel ID="pan_wholesaler" class="msg-container" runat="server">
                <h4>Find Your Wholesaler Ordering Numbers</h4>
                <p>Select your wholesaler from the dropdown list below</p>
                <div class="select-style">
                    <asp:DropDownList ID="ddlWholesaler" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlWholesaler_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </asp:Panel>
            <div class="clearfix"></div>
        </div>
        <p class="blue">To send product information to yourself or a colleague, click the checkbox to the left of your product, then click on &ldquo;Email Selections&rdquo; above.</p>
        <asp:Panel ID="pan_desktop" runat="server" Visible="false">
            <!-- DeskTop Panel Output | Start -->
            <ul id="categories">
                <li name="unitdose" id="unitdose"><a href="#unitdose">Unit Dose</a>
                    <asp:Panel ID="unitdose_product_panel" runat="server">
                        <ul class="sub-category">
                            <li name="unitdose-unitdose" id="unitdose-unitdose"><a href="#unitdose-unitdose">Unit Dose</a>
                                <ul class="alpha-sort active">
                                    <li class="first" id="unitdose-unitdose-a-g"><a href="#">A-G</a>
                                        <ul class="products">
                                            <asp:Repeater ID="product_name_unitdosedrug_a2g" runat="server" OnItemDataBound="unitdosedrug_a2g_ItemDataBound">
                                                <ItemTemplate>
                                                    <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %> ">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                  </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %> ">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" name="<%# Eval("cbValue").ToString().Trim().Replace("prod_", "") %>" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%#Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                  </table>
                                                                    </FooterTemplate>

                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </li>
                                    <li id="unitdose-unitdose-h-n"><a href="#">H-N</a>
                                        <ul class="products">
                                            <asp:Repeater ID="product_name_unitdosedrug_h2n" runat="server" OnItemDataBound="product_name_unitdosedrug_h2n_ItemDataBound">
                                                <ItemTemplate>
                                                    <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %> ">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>

                                                                <asp:Repeater ID="product_name_unitdosedrug_h2n_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                            </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <li id="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %> ">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_unitdosedrug_h2n_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                            </table>
                                                                    </FooterTemplate>

                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </li>
                                    <li id="unitdose-unitdose-o-u"><a href="#">O-U</a>
                                        <ul class="products">
                                            <asp:Repeater ID="product_name_unitdosedrug_o2u" runat="server" OnItemDataBound="product_name_unitdosedrug_o2u_ItemDataBound">
                                                <ItemTemplate>
                                                    <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_unitdosedrug_o2u_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                            </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %> ">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_unitdosedrug_o2u_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                            </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </li>
                                    <li id="unitdose-unitdose-v-z"><a href="#">V-Z</a>
                                        <ul class="products">
                                            <asp:Repeater ID="product_name_unitdosedrug_v2z" runat="server" OnItemDataBound="product_name_unitdosedrug_v2z_ItemDataBound">
                                                <ItemTemplate>
                                                    <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %> ">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_unitdosedrug_v2z_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                            </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %> ">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_unitdosedrug_v2z_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                              </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li name="unitdose-control-a-dose" id="unitdose-control-a-dose"><a href="#unitdose-control-a-dose">Control-A-Dose<sup>&reg;</sup> (Reverse Number Pack)</a>
                                <ul class="alpha-sort-non-title">
                                    <li class="first">
                                        <ul class="products">
                                            <asp:Repeater ID="product_name_controladose_all" runat="server" OnItemDataBound="product_name_controladose_all_ItemDataBound">
                                                <ItemTemplate>
                                                    <li class="odd <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_controladose_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                        </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <li class="even <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_controladose_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                 
                                                                <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                        </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li name="unitdose-robot-rx-ready" id="unitdose-robot-rx-ready"><a href="#unitdose-robot-rx-ready">Robot-Rx<sup>&reg;</sup> Ready</a>
                                <ul class="alpha-sort-non-title">
                                    <li>
                                        <ul class="products">
                                            <asp:Repeater ID="product_name_robotrxready_all" runat="server" OnItemDataBound="product_name_robotrxready_all_ItemDataBound">
                                                <ItemTemplate>
                                                    <li class="odd <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_robotrxready_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                              </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <li class="even <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_robotrxready_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                              </table>
                                                                    </FooterTemplate>

                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li name="unitdose-punch-card" id="unitdose-punch-card"><a href="#unitdose-punch-card">Punch Card</a>
                                <ul class="alpha-sort-non-title">
                                    <li>
                                        <ul class="products">
                                            <asp:Repeater ID="product_name_punchcard_all" runat="server" OnItemDataBound="product_name_punchcard_all_ItemDataBound">
                                                <ItemTemplate>
                                                    <li class="odd <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_punchcard_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                            </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <li class="even <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                        <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                        <div class="product-title">
                                                            <div class="title">
                                                                <a href="#"><%# Eval("ProductName")%></a>
                                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                            </div>
                                                            <div class="product-info">
                                                                <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                <asp:Repeater ID="product_name_punchcard_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                    <HeaderTemplate>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="product-desc-title">Form</td>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Package</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                          </table>
                                                                    </FooterTemplate>

                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <!--
                    <li name="unitdose-emergi-script" id="unitdose-emergi-script"><a href="#unitdose-emergi-script">Emergi-Script</a>
                        <ul class="alpha-sort-non-title">
                            <li>
                                <ul class="products">
                                    <asp:Repeater ID="product_name_emergiscript_all" runat="server" OnItemDataBound="product_name_emergiscript_all_ItemDataBound">
                                        <ItemTemplate>
                                            <li class="odd <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                <div class="product-title">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                    </div>
                                                    <div class="product-info">
                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                        <asp:Repeater ID="product_name_emergiscript_all_inner_odd" runat="server">
                                                            <HeaderTemplate>
                                                                <table class="product-info-table">
                                                                    <thead>
                                                                        <tr>
                                                                            <td class="product-cb-col"></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="product-desc-title"><asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr class="grey-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td><%# Eval("ProductDescription").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr class="blue-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td><%# Eval("ProductDescription").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </AlternatingItemTemplate>
                                                            <FooterTemplate>
                                                                </tbody>
                                          </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <li class="even <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                <div class="product-title">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                    </div>
                                                    <div class="product-info">
                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                        <asp:Repeater ID="product_name_emergiscript_all_inner_even" runat="server">
                                                            <HeaderTemplate>
                                                                <table class="product-info-table">
                                                                    <thead>
                                                                        <tr>
                                                                            <td class="product-cb-col"></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="product-desc-title"><asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr class="grey-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td><%# Eval("ProductDescription").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr class="blue-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&","") %>" id="ndc_<%# Eval("NDC").ToString().Trim() %>" /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td><%# Eval("ProductDescription").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </AlternatingItemTemplate>
                                                            <FooterTemplate>
                                                                </tbody>
                                          </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </li>
                                        </AlternatingItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    -->
                        </ul>
                    </asp:Panel>
                </li>
                <li name="injectables" id="injectables"><a href="#injectables">Injectables</a>
                    <asp:Panel ID="injectables_product_panel" runat="server">
                        <ul>
                            <li>
                                <ul class="sub-category-non-alpha">
                                    <li>
                                        <ul class="alpha-sort">
                                            <li class="first" id="injectables-a-g"><a href="#">A-G</a>
                                                <ul class="products">
                                                    <asp:Repeater ID="product_name_Injectables_a2g" runat="server" OnItemDataBound="product_name_Injectables_a2g_ItemDataBound">
                                                        <ItemTemplate>
                                                            <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                                <div class="product-title">
                                                                    <div class="title">
                                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                                    </div>
                                                                    <div class="product-info">
                                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Code</td>" %>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <asp:Repeater ID="product_name_Injectables_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                                    <ItemTemplate>
                                                                                        <tr class="blue-row">
                                                                                            <td class="product-cb-col">
                                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString() %>' />
                                                                                            </td>
                                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                            <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                            <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                            <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                            <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                        </tr>
                                                                                    </ItemTemplate>
                                                                                    <AlternatingItemTemplate>
                                                                                        <tr class="grey-row">
                                                                                            <td class="product-cb-col">
                                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                            <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                            <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                            <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                            <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                        </tr>
                                                                                    </AlternatingItemTemplate>
                                                                                </asp:Repeater>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                                <div class="product-title">
                                                                    <div class="title">
                                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                                    </div>
                                                                    <div class="product-info">
                                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Code</td>" %>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <asp:Repeater ID="product_name_Injectables_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                                    <ItemTemplate>
                                                                                        <tr class="blue-row">
                                                                                            <td class="product-cb-col">
                                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                            <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                            <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                            <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                            <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                        </tr>
                                                                                    </ItemTemplate>
                                                                                    <AlternatingItemTemplate>
                                                                                        <tr class="grey-row">
                                                                                            <td class="product-cb-col">
                                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                            <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                            <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                            <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                            <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                        </tr>
                                                                                    </AlternatingItemTemplate>
                                                                                </asp:Repeater>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </ul>
                                            </li>
                                            <li class="first" id="injectables-h-n"><a href="#">H-N</a>
                                                <ul class="products">
                                                    <asp:Repeater ID="product_name_Injectables_h2n" runat="server" OnItemDataBound="product_name_Injectables_h2n_ItemDataBound">
                                                        <ItemTemplate>
                                                            <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                                <div class="product-title">
                                                                    <div class="title">
                                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                                    </div>
                                                                    <div class="product-info">
                                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Code</td>" %>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <asp:Repeater ID="product_name_Injectables_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                                    <ItemTemplate>
                                                                                        <tr class="blue-row">
                                                                                            <td class="product-cb-col">
                                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                            <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                            <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                            <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                            <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                        </tr>
                                                                                    </ItemTemplate>
                                                                                    <AlternatingItemTemplate>
                                                                                        <tr class="grey-row">
                                                                                            <td class="product-cb-col">
                                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                            <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                            <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                            <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                            <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                        </tr>
                                                                                    </AlternatingItemTemplate>
                                                                                </asp:Repeater>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                                <div class="product-title">
                                                                    <div class="title">
                                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                                    </div>
                                                                    <div class="product-info">
                                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                        <table class="product-info-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="product-cb-col"></td>
                                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Code</td>" %>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <asp:Repeater ID="product_name_Injectables_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                                    <ItemTemplate>
                                                                                        <tr class="blue-row">
                                                                                            <td class="product-cb-col">
                                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                            <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                            <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                            <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                            <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                        </tr>
                                                                                    </ItemTemplate>
                                                                                    <AlternatingItemTemplate>
                                                                                        <tr class="grey-row">
                                                                                            <td class="product-cb-col">
                                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                            <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                            <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                            <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                            <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                        </tr>
                                                                                    </AlternatingItemTemplate>
                                                                                </asp:Repeater>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </ul>
                                            </li>
                                            <li class="first" id="injectables-o-u"><a href="#">O-U</a>
                                                <ul class="products">
                                                    <asp:Repeater ID="product_name_Injectables_o2u" runat="server" OnItemDataBound="product_name_Injectables_o2u_ItemDataBound">
                                                        <ItemTemplate>
                                                            <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                                <div class="product-title">
                                                                    <div class="title">
                                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                                    </div>
                                                                    <div class="product-info">
                                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                        <asp:Repeater ID="product_name_Injectables_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                            <HeaderTemplate>
                                                                                <table class="product-info-table">
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <td class="product-cb-col"></td>
                                                                                            <td class="product-desc-title">NDC</td>
                                                                                            <td class="product-desc-title">Strength</td>
                                                                                            <td class="product-desc-title">Fill Volume</td>
                                                                                            <td class="product-desc-title">Vial Size</td>
                                                                                            <td class="product-desc-title">Closure Size</td>
                                                                                            <td class="product-desc-title">Pack Size</td>
                                                                                            <td class="product-desc-title">
                                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <tr class="blue-row">
                                                                                    <td class="product-cb-col">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </ItemTemplate>
                                                                            <AlternatingItemTemplate>
                                                                                <tr class="grey-row">
                                                                                    <td class="product-cb-col">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </AlternatingItemTemplate>
                                                                            <FooterTemplate>
                                                                                </tbody>
                                                                  </table>
                                                                            </FooterTemplate>
                                                                        </asp:Repeater>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                                <div class="product-title">
                                                                    <div class="title">
                                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                                    </div>
                                                                    <div class="product-info">
                                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                        <asp:Repeater ID="product_name_Injectables_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                            <HeaderTemplate>
                                                                                <table class="product-info-table">
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <td class="product-cb-col"></td>
                                                                                            <td class="product-desc-title">NDC</td>
                                                                                            <td class="product-desc-title">Strength</td>
                                                                                            <td class="product-desc-title">Fill Volume</td>
                                                                                            <td class="product-desc-title">Vial Size</td>
                                                                                            <td class="product-desc-title">Closure Size</td>
                                                                                            <td class="product-desc-title">Pack Size</td>
                                                                                            <td class="product-desc-title">
                                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <tr class="blue-row">
                                                                                    <td class="product-cb-col">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </ItemTemplate>
                                                                            <AlternatingItemTemplate>
                                                                                <tr class="grey-row">
                                                                                    <td class="product-cb-col">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </AlternatingItemTemplate>
                                                                            <FooterTemplate>
                                                                                </tbody>
                                                                  </table>
                                                                            </FooterTemplate>
                                                                        </asp:Repeater>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </ul>
                                            </li>
                                            <li class="first" id="injectables-v-z"><a href="#">V-Z</a>
                                                <ul class="products">
                                                    <asp:Repeater ID="product_name_Injectables_v2z" runat="server" OnItemDataBound="product_name_Injectables_v2z_ItemDataBound">
                                                        <ItemTemplate>
                                                            <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                                <div class="product-title">
                                                                    <div class="title">
                                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                                    </div>
                                                                    <div class="product-info">
                                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                        <asp:Repeater ID="product_name_Injectables_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                            <HeaderTemplate>
                                                                                <table class="product-info-table">
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <td class="product-cb-col"></td>
                                                                                            <td class="product-desc-title">NDC</td>
                                                                                            <td class="product-desc-title">Strength</td>
                                                                                            <td class="product-desc-title">Fill Volume</td>
                                                                                            <td class="product-desc-title">Vial Size</td>
                                                                                            <td class="product-desc-title">Closure Size</td>
                                                                                            <td class="product-desc-title">Pack Size</td>
                                                                                            <td class="product-desc-title">
                                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <tr class="blue-row">
                                                                                    <td class="product-cb-col">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </ItemTemplate>
                                                                            <AlternatingItemTemplate>
                                                                                <tr class="grey-row">
                                                                                    <td class="product-cb-col">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </AlternatingItemTemplate>
                                                                            <FooterTemplate>
                                                                                </tbody>
                                                                      </table>
                                                                            </FooterTemplate>
                                                                        </asp:Repeater>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                                <input type="checkbox" id='<%# Eval("cbValue") %>' value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                                <div class="product-title">
                                                                    <div class="title">
                                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                                    </div>
                                                                    <div class="product-info">
                                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                        <asp:Repeater ID="product_name_Injectables_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                            <HeaderTemplate>
                                                                                <table class="product-info-table">
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <td class="product-cb-col"></td>
                                                                                            <td class="product-desc-title">NDC</td>
                                                                                            <td class="product-desc-title">Strength</td>
                                                                                            <td class="product-desc-title">Fill Volume</td>
                                                                                            <td class="product-desc-title">Vial Size</td>
                                                                                            <td class="product-desc-title">Closure Size</td>
                                                                                            <td class="product-desc-title">Pack Size</td>
                                                                                            <td class="product-desc-title">
                                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <tr class="blue-row">
                                                                                    <td class="product-cb-col">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </ItemTemplate>
                                                                            <AlternatingItemTemplate>
                                                                                <tr class="grey-row">
                                                                                    <td class="product-cb-col">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </AlternatingItemTemplate>
                                                                            <FooterTemplate>
                                                                                </tbody>
                                                                    </table>
                                                                            </FooterTemplate>
                                                                        </asp:Repeater>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </asp:Panel>
                </li>
                <li name="burn-wound-care" id="burn-wound-care"><a href="#burn-wound-care">Creams, Ointments, Sprays, and Dressings</a>
                    <asp:Panel ID="burn_wound_care_product_panel" runat="server">
                        <ul class="sub-category-non-alpha">
                            <li>
                                <ul class="nonalpha products" id="bwc">
                                    <asp:Repeater ID="product_name_BurnWoundCare_all" runat="server" OnItemDataBound="product_name_BurnWoundCare_all_ItemDataBound">
                                        <ItemTemplate>
                                            <li class="odd <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                <div class="product-title">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                    </div>
                                                    <div class="product-info">
                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Instructions for Use</a></div>" : ""%>
                                                        <table class="product-info-table">
                                                            <thead>
                                                                <tr>
                                                                    <td class="product-cb-col"></td>
                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Number</td>" %>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <asp:Repeater ID="product_name_BurnWoundCare_all_inner_odd" runat="server">
                                                                    <ItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                            <td><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                            <td><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                    </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <li class="even <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                <div class="product-title">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                    </div>
                                                    <div class="product-info">
                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Instructions for Use</a></div>" : ""%>
                                                        <table class="product-info-table">
                                                            <thead>
                                                                <tr>
                                                                    <td class="product-cb-col"></td>
                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Number</td>" %>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <asp:Repeater ID="product_name_BurnWoundCare_all_inner_even" runat="server">
                                                                    <ItemTemplate>
                                                                        <tr class="blue-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                            <td><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <AlternatingItemTemplate>
                                                                        <tr class="grey-row">
                                                                            <td class="product-cb-col">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                                            <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                            <td><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                            <td><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                            <td><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </AlternatingItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                    </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                    </div>
                                                </div>
                                            </li>
                                        </AlternatingItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </li>
                        </ul>
                    </asp:Panel>
                </li>
                <li id="veterinary"><a href="#">Veterinary</a>
                    <asp:Panel ID="veterinary_product_panel" runat="server">
                        <ul class="sub-category-non-alpha">
                            <li>
                                <ul class="nonalpha products" id="vet">
                                    <asp:Repeater ID="product_name_Veterinary_all" runat="server" OnItemDataBound="product_name_Veterinary_all_ItemDataBound">
                                        <ItemTemplate>
                                            <li class="odd <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                <div class="product-title">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                    </div>
                                                    <div class="product-info">
                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                        <asp:Repeater ID="product_name_Veterinary_all_inner_odd" runat="server">
                                                            <HeaderTemplate>
                                                                <table class="product-info-table">
                                                                    <thead>
                                                                        <tr>
                                                                            <td class="product-cb-col"></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="product-desc-title">Boxes Per Case</td>
                                                                            <td class="product-desc-title">Ordering Multiple</td>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr class="blue-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td><%# Eval("ProductDescription").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                    <td><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                    <td><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr class="grey-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td><%# Eval("ProductDescription").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                    <td><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                    <td><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </AlternatingItemTemplate>
                                                            <FooterTemplate>
                                                                </tbody>
                                                    </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <li class="even <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                <div class="product-title">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                    </div>
                                                    <div class="product-info">
                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                        <asp:Repeater ID="product_name_Veterinary_all_inner_even" runat="server">
                                                            <HeaderTemplate>
                                                                <table class="product-info-table">
                                                                    <thead>
                                                                        <tr>
                                                                            <td class="product-cb-col"></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="product-desc-title">Boxes Per Case</td>
                                                                            <td class="product-desc-title">Ordering Multiple</td>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr class="blue-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td><%# Eval("ProductDescription").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                    <td><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                    <td><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr class="grey-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td><%# Eval("ProductDescription").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                    <td><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                    <td><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </AlternatingItemTemplate>
                                                            <FooterTemplate>
                                                                </tbody>
                                                    </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </li>
                                        </AlternatingItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </li>
                        </ul>
                    </asp:Panel>
                </li>
                <li id="cryopreserve-agent"><a href="#">Cryopreservative Solution Component</a>
                    <asp:Panel ID="cryopreserve_panel" runat="server">
                        <ul class="sub-category-non-alpha">
                            <li>
                                <ul class="nonalpha products" id="cryo">
                                    <asp:Repeater ID="product_name_cryopreserve_all" runat="server" OnItemDataBound="product_name_Cryoserv_all_ItemDataBound">
                                        <ItemTemplate>
                                            <li class="odd <%# Container.ItemIndex == 0 ? "first " : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                <div class="product-title">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                    </div>
                                                    <div class="product-info">
                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                        <asp:Repeater ID="product_name_Cryoserv_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                            <HeaderTemplate>
                                                                <table class="product-info-table">
                                                                    <thead>
                                                                        <tr>
                                                                            <td class="product-cb-col"></td>
                                                                            <td class="product-desc-title">Product Code</td>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="product-desc-title">Fill Volume</td>
                                                                            <td class="product-desc-title">Vial Size</td>
                                                                            <td class="product-desc-title">Closure Size</td>
                                                                            <td class="product-desc-title">Pack Size</td>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr class="blue-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr class="grey-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </AlternatingItemTemplate>
                                                            <FooterTemplate>
                                                                </tbody>
                                                    </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                        <AlternatingItemTemplate>
                                            <li class="even <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                <div class="product-title">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName")%></a>
                                                        <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                                    </div>
                                                    <div class="product-info">
                                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                        <asp:Repeater ID="product_name_Cryoserv_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                            <HeaderTemplate>
                                                                <table class="product-info-table">
                                                                    <thead>
                                                                        <tr>
                                                                            <td class="product-cb-col"></td>
                                                                            <td class="product-desc-title">Product Code</td>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="product-desc-title">Fill Volume</td>
                                                                            <td class="product-desc-title">Vial Size</td>
                                                                            <td class="product-desc-title">Closure Size</td>
                                                                            <td class="product-desc-title">Pack Size</td>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr class="blue-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr class="grey-row">
                                                                    <td class="product-cb-col">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td nowrap><%# Eval("NDC").ToString() %></td>
                                                                    <td nowrap><%# Eval("AttrStrength").ToString() %></td>
                                                                    <td><%# Eval("AttrFillVolume").ToString() %></td>
                                                                    <td><%# Eval("AttrVialSize").ToString() %></td>
                                                                    <td><%# Eval("AttrClosureSize").ToString() %></td>
                                                                    <td><%# Eval("PkgPackSize").ToString() %></td>
                                                                    <td><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </AlternatingItemTemplate>
                                                            <FooterTemplate>
                                                                </tbody>
                                                    </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </li>
                                        </AlternatingItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </li>
                        </ul>
                    </asp:Panel>
                </li>
            </ul>
            <!-- DeskTop Panel Output | End -->
        </asp:Panel>

        <asp:Panel ID="pan_mobile" runat="server">
            <ul id="categories">
                <li id="unitdose"><a href="#">Unit Dose</a>
                    <ul class="sub-category">
                        <li id="unitdose-unitdose"><a href="#">Unit Dose</a>
                            <ul class="alpha-sort">
                                <li id="unitdose-unitdose-a-g">
                                    <a href="#">A-G</a>
                                    <ul class="products">
                                        <asp:Repeater ID="product_name_unitdosedrug_a2g_mobile" runat="server" OnItemDataBound="unitdosedrug_a2g_mobile_ItemDataBound">
                                            <ItemTemplate>
                                                <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                </li>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </li>
                                <li id="unitdose-unitdose-h-n"><a href="#">H-N</a>
                                    <ul class="products">
                                        <asp:Repeater ID="product_name_unitdosedrug_h2n_mobile" runat="server" OnItemDataBound="product_name_unitdosedrug_h2n_mobile_ItemDataBound">
                                            <ItemTemplate>
                                                <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_unitdosedrug_h2n_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                        3
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_unitdosedrug_h2n_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </li>
                                <li id="unitdose-unitdose-o-u"><a href="#">O-U</a>
                                    <ul class="products">
                                        <asp:Repeater ID="product_name_unitdosedrug_o2u_mobile" runat="server" OnItemDataBound="product_name_unitdosedrug_o2u_mobile_ItemDataBound">
                                            <ItemTemplate>
                                                <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_unitdosedrug_o2u_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_unitdosedrug_o2u_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </li>
                                <li id="unitdose-unitdose-v-z"><a href="#">V-Z</a>
                                    <ul class="products">
                                        <asp:Repeater ID="product_name_unitdosedrug_v2z_mobile" runat="server" OnItemDataBound="product_name_unitdosedrug_v2z_mobile_ItemDataBound">
                                            <ItemTemplate>
                                                <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_unitdosedrug_v2z_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_unitdosedrug_v2z_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <div class="divider"></div>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                </li>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li id="unitdose-control-a-dose">
                            <a href="#">Control-A-Dose<sup>&reg;</sup> (Reverse Number Pack)</a>
                            <ul class="alpha-sort-non-title">
                                <li class="first">
                                    <ul class="products">
                                        <asp:Repeater ID="product_name_controladose_all_mobile" runat="server" OnItemDataBound="product_name_controladose_all_mobile_ItemDataBound">
                                            <ItemTemplate>
                                                <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_controladose_all_inner_odd" runat="server">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_controladose_all_inner_even" runat="server">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li id="unitdose-robot-rx-ready"><a href="#">Robot-Rx<sup>&reg;</sup> Ready</a>
                            <ul class="alpha-sort-non-title">
                                <li>
                                    <ul class="products">
                                        <asp:Repeater ID="product_name_robotrxready_all_mobile" runat="server" OnItemDataBound="product_name_robotrxready_all_mobile_ItemDataBound">
                                            <ItemTemplate>
                                                <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_robotrxready_all_inner_odd" runat="server">
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                    <div class="product-title">
                                                        <div class="title">
                                                            <a href="#"><%# Eval("ProductName") %></a>
                                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                        </div>
                                                        <div class="product-info">
                                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                            <asp:Repeater ID="product_name_robotrxready_all_inner_even" runat="server">
                                                                <ItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </ItemTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <table class="product-info-table">
                                                                        <tr>
                                                                            <td class="product-cb-col" rowspan="4">
                                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                            <td class="product-desc-title">NDC</td>
                                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Form</td>
                                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Strength</td>
                                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">Package</td>
                                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="product-desc-title">
                                                                                <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                        </tr>
                                                                    </table>
                                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                </AlternatingItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </li>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li id="unitdose-punch-card-drugs"><a href="#">Punch Card</a>
                            <ul class="products">
                                <asp:Repeater ID="product_name_punchcard_all_mobile" runat="server" OnItemDataBound="product_name_punchcard_all_mobile_ItemDataBound">
                                    <ItemTemplate>
                                        <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                            <div class="product-title">
                                                <div class="title">
                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                </div>
                                                <div class="product-info">
                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                    <asp:Repeater ID="product_name_punchcard_all_inner_odd" runat="server">
                                                        <ItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="4">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="4">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate>
                                        <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                            <div class="product-title">
                                                <div class="title">
                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                </div>
                                                <div class="product-info">
                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                    <asp:Repeater ID="product_name_punchcard_all_inner_even" runat="server">
                                                        <ItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="4">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="4">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </AlternatingItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </li>
                        <!--
                <li id="unitdose-emergi-script"><a href="#">Emergi-Script</a>
                    <ul class="products">
                        <asp:Repeater ID="product_name_emergiscript_all_mobile" runat="server" OnItemDataBound="product_name_emergiscript_all_mobile_ItemDataBound">
                            <ItemTemplate>
                                <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                    <div class="product-title">
                                        <div class="title">
                                            <a href="#"><%# Eval("ProductName") %></a>
                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                        </div>
                                        <div class="product-info">
                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                            <asp:Repeater ID="product_name_emergiscript_all_inner_odd" runat="server">
                                                <ItemTemplate>
                                                    <table class="product-info-table">
                                                        <tr>
                                                            <td class="product-cb-col" rowspan="4">
                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                            <td class="product-desc-title">NDC</td>
                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Form</td>
                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Strength</td>
                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Package</td>
                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title"><asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                        </tr>
                                                    </table>
                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <table class="product-info-table">
                                                        <tr>
                                                            <td class="product-cb-col" rowspan="4">
                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                            <td class="product-desc-title">NDC</td>
                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Form</td>
                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Strength</td>
                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Package</td>
                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title"><asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                        </tr>
                                                    </table>
                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </li>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                    <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                    <div class="product-title">
                                        <div class="title">
                                            <a href="#"><%# Eval("ProductName") %></a>
                                            <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                        </div>
                                        <div class="product-info">
                                            <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                            <asp:Repeater ID="product_name_emergiscript_all_inner_even" runat="server">
                                                <ItemTemplate>
                                                    <table class="product-info-table">
                                                        <tr>
                                                            <td class="product-cb-col" rowspan="4">
                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                            <td class="product-desc-title">NDC</td>
                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Form</td>
                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Strength</td>
                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Package</td>
                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title"><asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                        </tr>
                                                    </table>
                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <table class="product-info-table">
                                                        <tr>
                                                            <td class="product-cb-col" rowspan="4">
                                                                <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                            <td class="product-desc-title">NDC</td>
                                                            <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Form</td>
                                                            <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Strength</td>
                                                            <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title">Package</td>
                                                            <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="product-desc-title"><asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                            <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                        </tr>
                                                    </table>
                                                    <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                </AlternatingItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </li>
                            </AlternatingItemTemplate>
                        </asp:Repeater>
                    </ul>
                </li>
                -->
                    </ul>
                </li>
                <li id="injectables"><a href="#">Injectables</a>
                    <ul>
                        <li>
                            <ul class="sub-category-non-alpha">
                                <li>
                                    <ul class="alpha-sort">
                                        <li id="injectables-a-g"><a href="#">A-G</a>
                                            <ul class="products">
                                                <asp:Repeater ID="product_name_Injectables_a2g_mobile" runat="server" OnItemDataBound="product_name_Injectables_a2g_mobile_ItemDataBound">
                                                    <ItemTemplate>
                                                        <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                            <div class="product-title">
                                                                <div class="title">
                                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                                </div>
                                                                <div class="product-info">
                                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                    <asp:Repeater ID="product_name_Injectables_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                        <HeaderTemplate>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>

                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </AlternatingItemTemplate>
                                                                        <FooterTemplate>
                                                                        </FooterTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ItemTemplate>
                                                    <AlternatingItemTemplate>
                                                        <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                            <div class="product-title">
                                                                <div class="title">
                                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                                </div>
                                                                <div class="product-info">
                                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                    <asp:Repeater ID="product_name_Injectables_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                        <ItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </AlternatingItemTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </AlternatingItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                        </li>
                                        <li class="first" id="injectables-h-n"><a href="#">H-N</a>
                                            <ul class="products">
                                                <asp:Repeater ID="product_name_Injectables_h2n_mobile" runat="server" OnItemDataBound="product_name_Injectables_h2n_mobile_ItemDataBound">
                                                    <ItemTemplate>
                                                        <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                            <div class="product-title">
                                                                <div class="title">
                                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                                </div>
                                                                <div class="product-info">
                                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                    <asp:Repeater ID="product_name_Injectables_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                        <ItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </AlternatingItemTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ItemTemplate>
                                                    <AlternatingItemTemplate>
                                                        <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                            <div class="product-title">
                                                                <div class="title">
                                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                                </div>
                                                                <div class="product-info">
                                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                    <asp:Repeater ID="product_name_Injectables_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                        <ItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </AlternatingItemTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </AlternatingItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                        </li>
                                        <li class="first" id="injectables-o-u"><a href="#">O-U</a>
                                            <ul class="products">
                                                <asp:Repeater ID="product_name_Injectables_o2u_mobile" runat="server" OnItemDataBound="product_name_Injectables_o2u_mobile_ItemDataBound">
                                                    <ItemTemplate>
                                                        <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                            <div class="product-title">
                                                                <div class="title">
                                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                                </div>
                                                                <div class="product-info">
                                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                    <asp:Repeater ID="product_name_Injectables_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                        <ItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </AlternatingItemTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ItemTemplate>
                                                    <AlternatingItemTemplate>
                                                        <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                            <div class="product-title">
                                                                <div class="title">
                                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                                </div>
                                                                <div class="product-info">
                                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                    <asp:Repeater ID="product_name_Injectables_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                        <ItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </AlternatingItemTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </AlternatingItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                        </li>
                                        <li class="first" id="injectables-v-z"><a href="#">V-Z</a>
                                            <ul class="products">
                                                <asp:Repeater ID="product_name_Injectables_v2z_mobile" runat="server" OnItemDataBound="product_name_Injectables_v2z_mobile_ItemDataBound">
                                                    <ItemTemplate>
                                                        <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                            <div class="product-title">
                                                                <div class="title">
                                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                                </div>
                                                                <div class="product-info">
                                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                    <asp:Repeater ID="product_name_Injectables_all_inner_odd" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                        <ItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </AlternatingItemTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ItemTemplate>
                                                    <AlternatingItemTemplate>
                                                        <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %>">
                                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                                            <div class="product-title">
                                                                <div class="title">
                                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                                </div>
                                                                <div class="product-info">
                                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                                    <asp:Repeater ID="product_name_Injectables_all_inner_even" runat="server" OnItemDataBound="SetWholeSalerTitle">
                                                                        <HeaderTemplate>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </ItemTemplate>
                                                                        <AlternatingItemTemplate>
                                                                            <table class="product-info-table">
                                                                                <tr>
                                                                                    <td class="product-cb-col" rowspan="6">
                                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                                    <td class="product-desc-title">NDC</td>
                                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Strength</td>
                                                                                    <td class="grey-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Vial Size</td>
                                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Closure Size</td>
                                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">Pack Size</td>
                                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td class="product-desc-title">
                                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                                </tr>
                                                                            </table>
                                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                                        </AlternatingItemTemplate>
                                                                        <FooterTemplate>
                                                                        </FooterTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </AlternatingItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li id="burn-wound-care"><a href="#">Creams, Ointments, Sprays, and Dressings</a>
                    <ul class="sub-category-non-alpha">
                        <li>
                            <ul class="products">
                                <asp:Repeater ID="product_name_BurnWoundCare_all_mobile" runat="server" OnItemDataBound="product_name_BurnWoundCare_all_mobile_ItemDataBound">
                                    <ItemTemplate>
                                        <li class="odd <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                            <div class="product-title">
                                                <div class="title">
                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                </div>
                                                <div class="product-info">
                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Instructions for Use</a></div>" : ""%>
                                                    <asp:Repeater ID="product_name_BurnWoundCare_all_inner_odd" runat="server">
                                                        <ItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Number</td>" %>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="blue-row"><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="grey-row"><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Number</td>" %>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="blue-row"><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="grey-row"><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate>
                                        <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %><%# Container.ItemIndex == 0 ? "first " : "" %>">
                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                            <div class="product-title">
                                                <div class="title">
                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                </div>
                                                <div class="product-info">
                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Instructions for Use</a></div>" : ""%>
                                                    <asp:Repeater ID="product_name_BurnWoundCare_all_inner_even" runat="server">
                                                        <ItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Number</td>" %>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="blue-row"><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="grey-row"><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <%# Eval("AlternateTitle").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : "<td class='product-desc-title'>Product Number</td>" %>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="blue-row"><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="grey-row"><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </AlternatingItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li id="veterinary"><a href="#">Veterinary</a>
                    <ul class="sub-category-non-alpha">
                        <li>
                            <ul class="nonalpha products">
                                <asp:Repeater ID="product_name_Veterinary_all_mobile" runat="server" OnItemDataBound="product_name_Veterinary_all_mobile_ItemDataBound">
                                    <ItemTemplate>
                                        <li class="odd <%# Container.ItemIndex == 0 ? "first " : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                            <div class="product-title">
                                                <a href="#"><%# Eval("ProductName")%></a>
                                                <div class="product-info">
                                                    <div class="title">
                                                        <a href="#"><%# Eval("ProductName") %></a>
                                                        <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                    </div>
                                                    <asp:Repeater ID="product_name_Veterinary_all_inner_odd" runat="server">
                                                        <HeaderTemplate>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="blue-row"><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="grey-row"><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="blue-row"><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="grey-row"><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate>
                                        <li class="even <%# Container.ItemIndex == 0 ? "first " : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                            <div class="product-title">
                                                <div class="title">
                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                </div>
                                                <div class="product-info">
                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                    <asp:Repeater ID="product_name_Veterinary_all_inner_even" runat="server">
                                                        <ItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="blue-row"><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="grey-row"><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="grey-row"><%# Eval("ProductDescription").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Boxes Per Case</td>
                                                                    <td class="blue-row"><%# Eval("PkgBoxesPerCase").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Ordering Multiple</td>
                                                                    <td class="grey-row"><%# Eval("PkgOrderingMultiple").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </AlternatingItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li id="cryopreserve-agent"><a href="#">Cryopreservative Solution Component</a>
                    <ul class="sub-category-non-alpha">
                        <li>
                            <ul class="nonalpha products">
                                <asp:Repeater ID="product_name_cryopreserve_all_mobile" runat="server" OnItemDataBound="product_name_Cryoserv_all_mobile_ItemDataBound">
                                    <ItemTemplate>
                                        <li class="odd <%# Container.ItemIndex == 0 ? "first " : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                            <div class="product-title">
                                                <div class="title">
                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                </div>
                                                <div class="product-info">
                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                    <asp:Repeater ID="product_name_Cryoserv_all_mobile_inner_odd" runat="server">
                                                        <ItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">Product Code</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Vial Size</td>
                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Closure Size</td>
                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Pack Size</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">Product Code</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Vial Size</td>
                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Closure Size</td>
                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Pack Size</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate>
                                        <li class="even <%# Container.ItemIndex == 0 ? "first " : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                            <input type="checkbox" id="<%# Eval("cbValue") %>" value="<%# Eval("cbValue") %>" class="product-cb" onclick="toggleSelect(this)">
                                            <div class="product-title">
                                                <div class="title">
                                                    <a href="#"><%# Eval("ProductName") %></a>
                                                    <div class="product-warnings"><%# Eval("AttrWarnings") %></div>
                                                </div>
                                                <div class="product-info">
                                                    <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                                    <asp:Repeater ID="product_name_Cryoserv_all_mobile_inner_even" runat="server">
                                                        <ItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">Product Code</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Vial Size</td>
                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Closure Size</td>
                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Pack Size</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </ItemTemplate>
                                                        <AlternatingItemTemplate>
                                                            <table class="product-info-table">
                                                                <tr>
                                                                    <td class="product-cb-col" rowspan="6">
                                                                        <input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>
                                                                    <td class="product-desc-title">Product Code</td>
                                                                    <td class="blue-row"><%# Eval("NDC").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="blue-row"><%# Eval("AttrStrength").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Fill Volume</td>
                                                                    <td class="blue-row"><%# Eval("AttrFillVolume").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Vial Size</td>
                                                                    <td class="grey-row"><%# Eval("AttrVialSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Closure Size</td>
                                                                    <td class="blue-row"><%# Eval("AttrClosureSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">Pack Size</td>
                                                                    <td class="grey-row"><%# Eval("PkgPackSize").ToString() %></td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="product-desc-title">
                                                                        <asp:Label ID="lblWholesalerName" runat="server" Text="Select a wholesaler"></asp:Label></td>
                                                                    <td class="blue-row"><%# Eval("WholeSaler").ToString() %></td>
                                                                </tr>
                                                            </table>
                                                            <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "" : "<div class='divider'></div>" %>
                                                        </AlternatingItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </li>
                                    </AlternatingItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
        </asp:Panel>

    </ContentTemplate>
</asp:UpdatePanel>
