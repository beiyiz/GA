<%@ Page Language="C#" AutoEventWireup="true" Inherits="MylanProducts.ProductVerification" CodeFile="ProductVerification.aspx.cs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Verification - Comparer Tool</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Product Verfication - Item comparer tool</h1>
            <p>
                <span>Select the site on the Left (This will be used as the source to compare with the other site):</span>
                <asp:DropDownList ID="ddlDBLeft" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="Dev" Value="web"></asp:ListItem>
                    <asp:ListItem Text="Live" Value="prod"></asp:ListItem>
                </asp:DropDownList>
            </p>
        </div>
        <div>
            <div id="dvTest" runat="server"></div>
        </div>
    </form>
</body>
</html>
