<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jsonProductList.aspx.cs" Inherits="jsonProductList" debug="true" %>
[
<asp:Repeater ID="rpt_DistinctProductNames" runat="server">
    <ItemTemplate>
        {"product":"<%# Eval("ProductName").ToString() %>"},
    </ItemTemplate>
    <FooterTemplate>
        {"product":""}
    </FooterTemplate>
</asp:Repeater>
]