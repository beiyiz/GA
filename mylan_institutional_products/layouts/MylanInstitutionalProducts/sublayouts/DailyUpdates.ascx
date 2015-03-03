<%@ Control Language="C#" AutoEventWireup="True" Inherits="MylanProducts.layouts.MylanInstitutionalProducts.sublayouts.DailyUpdates" CodeBehind="DailyUpdates.ascx.cs" %>


<script lang="javascript">
    var x = window.location.search;
    alert(x);
    if (x == '?print') {
        dvButtons.style.display = "none";
        window.print();
    }

    function trackItemsToApprove(itemID, object) {
        var x = document.getElementById("hfItemIDs");
        if (object.checked == true) {
            x.value += itemID + ",";
        }
        alert(object.checked);
        alert(x.value);
    }

</script>

<asp:Panel ID="pan_desktop" runat="server">
    <asp:HiddenField ID="hfItemIDs" ClientIDMode="Static" runat="server" Value="" />
    <!-- DeskTop Panel Output | Start -->
    <asp:Repeater ID="rptCategories" runat="server" OnItemDataBound="rptCategories_ItemDataBound">
        <ItemTemplate>
            <ul id="categoriess">
                <li>
                    <a id="CatAnch" runat="server">
                        <label id="lblCategory" runat="server"></label>
                    </a>
                    <asp:Panel ID="productGroup_panel" runat="server">
                        <ul class="products">
                            <asp:Repeater ID="rptGroups" runat="server" OnItemDataBound="rptGroups_ItemDataBound">
                                <ItemTemplate>
                                    <li>
                                        <div class="product-title-simple">
                                            <div class="title">
                                                <asp:Label ID="lblGroup" runat="server"></asp:Label>
                                                <%# Eval("AttrWarnings").ToString().Length > 0 ? "<div class='product-warnings'>"+Eval("AttrWarnings")+"</div>" : ""%>
                                            </div>
                                            <div class="product-info-simple">
                                                <asp:Repeater ID="rptDailyDetails" runat="server" OnItemDataBound="rptDailyDetails_ItemDataBound">
                                                    <HeaderTemplate>
                                                        <table class="product-info-table" border="1" style="margin: 20px;" align="center" cellpadding="5">
                                                            <thead>
                                                                <tr>
                                                                    <td class="product-cb-col"></td>
                                                                    <td class="product-desc-title">NDC</td>
                                                                    <td class="product-desc-title">Form</td>
                                                                    <td class="product-desc-title">Strength</td>
                                                                    <td class="product-desc-title">Package</td>
                                                                    <td class="product-desc-title"></td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr class="grey-row">
                                                            <td class="product-cb-col">
                                                                <%--<input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>--%>
                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                            <td><%# Eval("AttrStrength").ToString() %></td>
                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                            <td>
                                                                <input type="checkbox" runat="server" id="cbItmID" />
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <AlternatingItemTemplate>
                                                        <tr class="blue-row">
                                                            <td class="product-cb-col">
                                                                <%--<input type="checkbox" name="<%# Eval("ProductName").ToString().Trim().Replace(" ", "").Replace("&", "") %>" id='ndc_<%# Eval("NDC").ToString().Trim() %>' /></td>--%>
                                                            <td nowrap><%# Eval("NDC").ToString() %></td>
                                                            <td><%# Eval("ProductDescription").ToString() %></td>
                                                            <td><%# Eval("AttrStrength").ToString() %></td>
                                                            <td><%# Eval("PkgPackage").ToString() + " " + Eval("PkgPackageDetails").ToString() %></td>
                                                            <td>
                                                                <input type="checkbox" runat="server" id="cbItmID" />
                                                            </td>
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
                            </asp:Repeater>
                        </ul>
                    </asp:Panel>
                </li>
            </ul>
        </ItemTemplate>
        <FooterTemplate>
            <div id="dvButtons">
                <table border="0" style="margin: 15px;" cellpadding="10" cellspacing="0">
                    <thead>
                        <tr>
                            <th>
                                <input type="button" id="btnPDF" runat="server" value="Generate PDF" onclick="window.open('/mylaninstitutionalproducts/DailyNDCUpdate.aspx?print'); return (false);" />
                            </th>
                            <th>
                                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit for Processing" ClientIDMode="Static" />
                            </th>
                        </tr>
                    </thead>
                </table>
            </div>
        </FooterTemplate>
    </asp:Repeater>
</asp:Panel>
