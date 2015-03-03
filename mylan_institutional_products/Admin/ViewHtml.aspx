<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewHtml.aspx.cs" Inherits="mylan_institutional_products.Admin.ViewHtml" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="scripts/html2canvas.js"></script>
        <script type="text/javascript" src="scripts/FileSaver.js"></script>

    <script type="text/javascript" src="scripts/jspdf.js"></script>
    <script type="text/javascript" src="scripts/jspdf.plugin.addhtml.js"></script>
     <script type="text/javascript" src="scripts/jspdf.plugin.addImage.js"></script>
    <script type="text/javascript" src="scripts/jspdf.plugin.cell.js"></script>
    <script type="text/javascript" src="scripts/jspdf.plugin.standard_fonts_metrics.js"></script>
   <script type="text/javascript" src="scripts/jquery-2.1.3.min.js"></script>

    <script type="text/javascript">
        var viewPdf = function () {

            var pdf = new jsPDF('p', 'pt', 'letter');
            pdf.addHTML($('#divHtml')[0], function () {
                pdf.save($("#hdnItemId").val() + '.pdf');
            });

        };

        $(document).ready(function () {
            viewPdf();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divHtml" runat="server">
    
    </div>
       <%-- <input type="button" value=" Download PDF " onclick="viewPdf();" />--%>
       <input type="hidden" id="hdnItemId" runat="server" />
    </form>
</body>
</html>
