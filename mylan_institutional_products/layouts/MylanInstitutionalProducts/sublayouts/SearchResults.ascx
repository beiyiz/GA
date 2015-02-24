<%@ Control Language="c#" AutoEventWireup="True" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" Inherits="layouts.Searchresults.SearchresultsSublayout" CodeBehind="~/layouts/MylanInstitutionalProducts/sublayouts/SearchResults.ascx.cs" %>
<asp:UpdatePanel ID="upSearch" runat="server" UpdateMode="Always" ChildrenAsTriggers="true">
    <ContentTemplate>
        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btn_Search">
            <p>
                <asp:TextBox ID="SearchTermField" runat="server"></asp:TextBox>
                <asp:Button OnClick="btn_search_clicked" ID="btn_Search" runat="server" Text="Search" />
            </p>
        </asp:Panel>
        <asp:Panel ID="pan_wholesaler" class="msg-container" runat="server">
            <h4>Find Your Wholesaler Ordering Numbers</h4>
            <p>Select your wholesaler from the dropdown list below</p>
            <div class="select-style">
                <asp:DropDownList ID="ddlWholesaler" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlWholesaler_SelectedIndexChanged"></asp:DropDownList>
            </div>
        </asp:Panel>
        <p>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </p>

        <asp:Panel ID="pn_Desktop" runat="server">
            <div id="div_ProductDisplay">
                <div id="div_ProductHeaders">
                    <ul class="products">
                        <asp:Repeater ID="rp_products_desktop" runat="server">
                            <ItemTemplate>
                                <li class="odd <%# Container.ItemIndex == 0 ? "first " : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %>">
                                    <!-- <input type="checkbox" id="<%# Eval("ProductID").ToString().Replace("{", "").Replace("}", "") %>" value="<%# Eval("ShortIdentifier") %>" class="product-cb" onclick="toggleSearchSelect(this)"> -->
                                    <span class="product-title"><a href="#"><%# Eval("ProductName")%></a></span>
                                    <div class="product-info">
                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                        <div class="product-warnings"><span><%# Eval("AttrWarnings") %> </span></div>
                                        <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_odd" runat="server" DataSource='<%# getNdcDetailById(Eval("ProductID").ToString()) %>'>
                                            <ItemTemplate>
                                                <table class="product-info-table">
                                                    <thead>
                                                        <tr>
                                                            <td class="product-cb-col"></td>
                                                            <%# Eval("NDC").ToString().Length > 0 && Eval("ProductCode").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : Eval("NDC").ToString().Length > 0 && Eval("ProductCode").ToString() == "1" ? "<td class='product-desc-title'>Product Code</td>" : "" %>
                                                            <%# Eval("ProductDescription").ToString().Length > 0 ? "<td class='product-desc-title'>Description</td>" : "" %>
                                                            <%# Eval("AttrStrength").ToString().Length > 0 ? "<td class='product-desc-title'>Strength</td>" : "" %>
                                                            <%# Eval("AttrFillVolume").ToString().Length > 0 ? "<td class='product-desc-title'>Fill Volume</td>" : "" %>
                                                            <%# Eval("AttrVialSize").ToString().Length > 0 ? "<td class='product-desc-title'>Vial Size</td>" : "" %>
                                                            <%# Eval("AttrClosureSize").ToString().Length > 0 ? "<td class='product-desc-title'>Closure Size</td>" : "" %>
                                                            <%# Eval("PkgPackSize").ToString().Length > 0 ? "<td class='product-desc-title'>Pack Size</td>" : "" %>
                                                            <%# Eval("PkgPackage").ToString().Length > 0 ? "<td class='product-desc-title'>Package</td>" : "" %>
                                                            <%# Eval("PkgBoxesPerCase").ToString().Length > 0 ? "<td class='product-desc-title'>Boxes Per Case</td>" : "" %>
                                                            <%# Eval("PkgOrderingMultiple").ToString().Length > 0 ? "<td class='product-desc-title'>Ordering Multiple</td>" : "" %>
                                                            <%# Eval("WholeSalerName").ToString().Length > 0 ? "<td class='product-desc-title'>"+Eval("WholeSalerName").ToString()+"</td>" : "<td class='product-desc-title'>Select a wholesaler</td>" %>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="grey-row">
                                                            <td class="product-cb-col">
                                                                <input type="checkbox" name="prod_<%# Eval("ProductID").ToString().Replace("{", "").Replace("}", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' />
                                                            </td>
                                                            <%# Eval("NDC").ToString().Length > 0 ? "<td nowrap>"+Eval("NDC").ToString()+"</td>" : "" %>
                                                            <%# Eval("ProductDescription").ToString().Length > 0 ? "<td>"+Eval("ProductDescription").ToString()+"</td>" : "" %>
                                                            <%# Eval("AttrStrength").ToString().Length > 0 ? "<td>"+Eval("AttrStrength").ToString()+"</td>" : "" %>
                                                            <%# Eval("AttrFillVolume").ToString().Length > 0 ? "<td>"+Eval("AttrFillVolume").ToString()+"</td>" : "" %>
                                                            <%# Eval("AttrVialSize").ToString().Length > 0 ? "<td>"+Eval("AttrVialSize").ToString()+"</td>" : "" %>
                                                            <%# Eval("AttrClosureSize").ToString().Length > 0 ? "<td>"+Eval("AttrClosureSize").ToString()+"</td>" : "" %>
                                                            <%# Eval("PkgPackSize").ToString().Length > 0 ? "<td>"+Eval("PkgPackSize").ToString()+"</td>" : "" %>
                                                            <%# Eval("PkgPackage").ToString().Length > 0 ? "<td>"+Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString()+"</td>" : "" %>
                                                            <%# Eval("PkgBoxesPerCase").ToString().Length > 0 ? "<td>"+Eval("PkgBoxesPerCase").ToString()+"</td>" : "" %>
                                                            <%# Eval("PkgOrderingMultiple").ToString().Length > 0 ? "<td>"+Eval("PkgOrderingMultiple").ToString()+"</td>" : "" %>
                                                            <%# Eval("WholeSaler").ToString().Length > 0 ? "<td>"+Eval("WholeSaler").ToString()+"</td>" : "<td>N/A</td>" %>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </li>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last " : "" %> ">
                                    <!-- <input type="checkbox" id="<%# Eval("ProductID").ToString().Replace("{", "").Replace("}", "") %>" value="<%# Eval("ShortIdentifier") %>" class="product-cb" onclick="toggleSearchSelect(this)"> -->
                                    <span class="product-title"><a href="#"><%# Eval("ProductName")%></a></span>
                                    <div class="product-info">
                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                        <div class="product-warnings">
                                            <span><%# Eval("AttrWarnings") %> </span>
                                        </div>
                                        <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_even" runat="server" DataSource='<%# getNdcDetailById(Eval("ProductID").ToString()) %>'>
                                            <ItemTemplate>
                                                <table class="product-info-table">
                                                    <thead>
                                                        <tr>
                                                            <td class="product-cb-col"></td>
                                                            <%# Eval("NDC").ToString().Length > 0 && Eval("ProductCode").ToString() != "1" ? "<td class='product-desc-title'>NDC</td>" : Eval("NDC").ToString().Length > 0 && Eval("ProductCode").ToString() == "1" ? "<td class='product-desc-title'>Product Code</td>" : "" %>
                                                            <%# Eval("ProductDescription").ToString().Length > 0 ? "<td class='product-desc-title'>Description</td>" : "" %>
                                                            <%# Eval("AttrStrength").ToString().Length > 0 ? "<td class='product-desc-title'>Strength</td>" : "" %>
                                                            <%# Eval("AttrFillVolume").ToString().Length > 0 ? "<td class='product-desc-title'>Fill Volume</td>" : "" %>
                                                            <%# Eval("AttrVialSize").ToString().Length > 0 ? "<td class='product-desc-title'>Vial Size</td>" : "" %>
                                                            <%# Eval("AttrClosureSize").ToString().Length > 0 ? "<td class='product-desc-title'>Closure Size</td>" : "" %>
                                                            <%# Eval("PkgPackSize").ToString().Length > 0 ? "<td class='product-desc-title'>Pack Size</td>" : "" %>
                                                            <%# Eval("PkgPackage").ToString().Length > 0 ? "<td class='product-desc-title'>Package</td>" : "" %>
                                                            <%# Eval("PkgBoxesPerCase").ToString().Length > 0 ? "<td class='product-desc-title'>Boxes Per Case</td>" : "" %>
                                                            <%# Eval("PkgOrderingMultiple").ToString().Length > 0 ? "<td class='product-desc-title'>Ordering Multiple</td>" : "" %>
                                                            <%# Eval("WholeSalerName").ToString().Length > 0 ? "<td class='product-desc-title'>"+Eval("WholeSalerName").ToString()+"</td>" : "<td class='product-desc-title'>Select a wholesaler</td>" %>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="grey-row">
                                                            <td class="product-cb-col">
                                                                <input type="checkbox" name="prod_<%# Eval("ProductID").ToString().Replace("{", "").Replace("}", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' />
                                                            </td>
                                                            <%# Eval("NDC").ToString().Length > 0 ? "<td nowrap>"+Eval("NDC").ToString()+"</td>" : "" %>
                                                            <%# Eval("ProductDescription").ToString().Length > 0 ? "<td>"+Eval("ProductDescription").ToString()+"</td>" : "" %>
                                                            <%# Eval("AttrStrength").ToString().Length > 0 ? "<td>"+Eval("AttrStrength").ToString()+"</td>" : "" %>
                                                            <%# Eval("AttrFillVolume").ToString().Length > 0 ? "<td>"+Eval("AttrFillVolume").ToString()+"</td>" : "" %>
                                                            <%# Eval("AttrVialSize").ToString().Length > 0 ? "<td>"+Eval("AttrVialSize").ToString()+"</td>" : "" %>
                                                            <%# Eval("AttrClosureSize").ToString().Length > 0 ? "<td>"+Eval("AttrClosureSize").ToString()+"</td>" : "" %>
                                                            <%# Eval("PkgPackSize").ToString().Length > 0 ? "<td>"+Eval("PkgPackSize").ToString()+"</td>" : "" %>
                                                            <%# Eval("PkgPackage").ToString().Length > 0 ? "<td>"+Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString()+"</td>" : "" %>
                                                            <%# Eval("PkgBoxesPerCase").ToString().Length > 0 ? "<td>"+Eval("PkgBoxesPerCase").ToString()+"</td>" : "" %>
                                                            <%# Eval("PkgOrderingMultiple").ToString().Length > 0 ? "<td>"+Eval("PkgOrderingMultiple").ToString()+"</td>" : "" %>
                                                            <%# Eval("WholeSaler").ToString().Length > 0 ? "<td>"+Eval("WholeSaler").ToString()+"</td>" : "<td>N/A</td>" %>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </li>
                            </AlternatingItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>

        </asp:Panel>

        <asp:Panel ID="pn_Mobile" runat="server" Visible="false">

            <div id="div_ProductDisplay">
                <div id="div_ProductHeaders">
                    <ul class="products">
                        <asp:Repeater ID="rp_products_mobile" runat="server">
                            <ItemTemplate>
                                <li class="odd <%# Container.ItemIndex == 0 ? "first" : "" %><%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %> "><span class="product-title"><a href="#"><%# Eval("ProductName")%></a></span> <span class="product-cat-and-line">
                                    <div class="product-info">
                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                        <div class="product-warnings">
                                            <span><%# Eval("AttrWarnings") %> </span>
                                        </div>
                                        <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_odd" runat="server" DataSource='<%# getNdcDetailById(Eval("ProductID").ToString()) %>'>
                                            <ItemTemplate>
                                                <table class="product-info-table">
                                                    <%# Eval("NDC").ToString().Length > 0 ? "<tr><td class='product-desc-title'>NDC</td><td class='blue-row'>"+Eval("NDC").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("ProductDescription").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Description</td><td class='grey-row'>"+Eval("ProductDescription").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrStrength").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Strength</td><td class='blue-row'>"+Eval("AttrStrength").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackage").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Package</td><td class='grey-row'>"+Eval("PkgPackage").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrFillVolume").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Fill Volume</td><td class='blue-row'>"+Eval("AttrFillVolume").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrClosureSize").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Closure Size</td><td class='grey-row'>"+Eval("AttrClosureSize").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackSize").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Pack Size</td><td class='blue-row'>"+Eval("PkgPackSize").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackage").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Package</td><td class='grey-row'>"+Eval("PkgPackage").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgBoxesPerCase").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Boxes Per Case</td><td class='blue-row'>"+Eval("PkgBoxesPerCase").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgOrderingMultiple").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Ordering Multiple</td><td class='grey-row'>"+Eval("PkgOrderingMultiple").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("WholeSalerName").ToString().Length > 0 ? "<td class='product-desc-title'>"+Eval("WholeSalerName").ToString()+"</td>" : "<td class='product-desc-title'>Select a wholesaler</td>" %>
                                                </table>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <table class="product-info-table">
                                                    <%# Eval("NDC").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Description</td><td class='blue-row'>"+Eval("NDC").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("ProductDescription").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Description</td><td class='grey-row'>"+Eval("ProductDescription").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrStrength").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Strength</td><td class='blue-row'>"+Eval("AttrStrength").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackage").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Package</td><td class='grey-row'>"+Eval("PkgPackage").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrFillVolume").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Fill Volume</td><td class='blue-row'>"+Eval("AttrFillVolume").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrClosureSize").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Closure Size</td><td class='grey-row'>"+Eval("AttrClosureSize").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackSize").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Pack Size</td><td class='blue-row'>"+Eval("PkgPackSize").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackage").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Package</td><td class='grey-row'>"+Eval("PkgPackage").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgBoxesPerCase").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Boxes Per Case</td><td class='blue-row'>"+Eval("PkgBoxesPerCase").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgOrderingMultiple").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Ordering Multiple</td><td class='grey-row'>"+Eval("PkgOrderingMultiple").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("WholeSaler").ToString().Length > 0 ? "<td>"+Eval("WholeSaler").ToString()+"</td>" : "<td>N/A</td>" %>
                                                </table>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </div></li>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <li class="even <%# Container.ItemIndex == (int.Parse(Eval("RowCount").ToString()) - 1) ? "last" : "" %> "><span class="product-title"><a href="#"><%# Eval("ProductName")%></a> </span>
                                    <div class="product-info">
                                        <%# Eval("InfoPrescribingInformationLink").ToString().Length > 0 ? "<div class='product-prescribing-info'><a href='" + Eval("InfoPrescribingInformationLink")+"' target='_new'>Full Prescribing Information</a></div>" : ""%>
                                        <div class="product-warnings">
                                            <span><%# Eval("AttrWarnings") %> </span>
                                        </div>
                                        <asp:Repeater ID="product_name_unitdosedrug_a2g_inner_even" runat="server" DataSource='<%# getNdcDetailById(Eval("ProductID").ToString()) %>'>
                                            <ItemTemplate>
                                                <table class="product-info-table">
                                                    <%# Eval("NDC").ToString().Length > 0 ? "<tr><td class='product-desc-title'>NDC</td><td class='blue-row'>"+Eval("NDC").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("ProductDescription").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Description</td><td class='grey-row'>"+Eval("ProductDescription").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrStrength").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Strength</td><td class='blue-row'>"+Eval("AttrStrength").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackage").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Package</td><td class='grey-row'>"+Eval("PkgPackage").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrFillVolume").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Fill Volume</td><td class='blue-row'>"+Eval("AttrFillVolume").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrClosureSize").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Closure Size</td><td class='grey-row'>"+Eval("AttrClosureSize").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackSize").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Pack Size</td><td class='blue-row'>"+Eval("PkgPackSize").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackage").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Package</td><td class='grey-row'>"+Eval("PkgPackage").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgBoxesPerCase").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Boxes Per Case</td><td class='blue-row'>"+Eval("PkgBoxesPerCase").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgOrderingMultiple").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Ordering Multiple</td><td class='grey-row'>"+Eval("PkgOrderingMultiple").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("WholeSalerName").ToString().Length > 0 ? "<td class='product-desc-title'>"+Eval("WholeSalerName").ToString()+"</td>" : "<td class='product-desc-title'>Select a wholesaler</td>" %>
                                                </table>

                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <table class="product-info-table">
                                                    <%# Eval("NDC").ToString().Length > 0 ? "<tr><td class='product-desc-title'>NDC</td><td class='blue-row'>"+Eval("NDC").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("ProductDescription").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Description</td><td class='grey-row'>"+Eval("ProductDescription").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrStrength").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Strength</td><td class='blue-row'>"+Eval("AttrStrength").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackage").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Package</td><td class='grey-row'>"+Eval("PkgPackage").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrFillVolume").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Fill Volume</td><td class='blue-row'>"+Eval("AttrFillVolume").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("AttrClosureSize").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Closure Size</td><td class='grey-row'>"+Eval("AttrClosureSize").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackSize").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Pack Size</td><td class='blue-row'>"+Eval("PkgPackSize").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgPackage").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Package</td><td class='grey-row'>"+Eval("PkgPackage").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgBoxesPerCase").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Boxes Per Case</td><td class='blue-row'>"+Eval("PkgBoxesPerCase").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("PkgOrderingMultiple").ToString().Length > 0 ? "<tr><td class='product-desc-title'>Ordering Multiple</td><td class='grey-row'>"+Eval("PkgOrderingMultiple").ToString()+"</td></tr>" : "" %>
                                                    <%# Eval("WholeSaler").ToString().Length > 0 ? "<td>"+Eval("WholeSaler").ToString()+"</td>" : "<td>N/A</td>" %>
                                                </table>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </li>
                            </AlternatingItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>

        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
