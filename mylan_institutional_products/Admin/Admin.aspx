<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="mylan_institutional_products.Admin.Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-theme.min.css" />
    <script type="text/javascript" src="scripts/jquery-2.1.3.min.js"></script>   
    <script type="text/javascript" src="scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="scripts/html2canvas.js"></script>
    <script type="text/javascript" src="scripts/FileSaver.js"></script>

    <script type="text/javascript" src="scripts/jspdf.js"></script>
    <script type="text/javascript" src="scripts/jspdf.plugin.addhtml.js"></script>
    <script type="text/javascript" src="scripts/jspdf.plugin.addImage.js"></script>
    <script type="text/javascript" src="scripts/jspdf.plugin.cell.js"></script>
    <script type="text/javascript" src="scripts/jspdf.plugin.standard_fonts_metrics.js"></script>

    

    <script type="text/javascript">
        $(document).ready(function () {

            $(".changeDetails").hide();
            $("#divHtml").hide();
        });

        var displayHtml = function () {

            var win = window.open("ViewHtml.aspx", "Preview Product Changes", "target=_new, width=1100, height=500");

        }

        var viewPdf = function () {
            $('#divHtml').show();
            var pdf = new jsPDF('p', 'pt', 'letter');
            pdf.addHTML($('#divHtml')[0], function () {
                var today = new Date();
                pdf.save( today + '.pdf');

                $('#divHtml').hide();
            });

        };
        var viewDetails = function (changeId) {
            $("#tblDetails" + changeId).toggle();
        }
       
        var adminApproval = function () {
            var approveIds='';
            var deleteIds='';
            $(".actionApprove").each(function (i, e) {
                
                if ($(this).is(':checked')) {
                    approveIds += $(this).val() + ";";
                }
            });
            $(".actionDelete").each(function (i, e) {
                if ($(this).is(':checked')) {
                    deleteIds += $(this).val() + ";";
                }
            });

            $("#hdnApprovedIds").val(approveIds);
            $("#hdnDeletedIds").val(deleteIds);

            $("#btnSubmit").prop("disabled", true);
            $("#adminForm").submit();
        }
        
    </script>
</head>
<body>
    <form id="adminForm" runat="server">
    <div class="row well">
        <table class="table" >
            <thead>
                <tr>
                    <th>Product Category</th>
                    <th>Product Name</th>
                     <th>Item Name</th>
                    <th>Change Type</th>
                    <th>Change Date</th>
                    <th colspan="2">Html</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="tbChangeList" runat="server">

            </tbody>
        </table>
        <div id="divHtml" runat="server">

        </div>
               

        </div>
        <input type="hidden" id="hdnApprovedIds" runat="server" />
        <input type="hidden" id="hdnDeletedIds" runat="server"  />

    </div>
        <input type="button" id="btnPDF" class="btn btn-default btn-success" value="Download PDF"  onclick="displayHtml()"/>

    <input type="button" id="btnSubmit" class="btn btn-default btn-success" value="Submit"  onclick="adminApproval()"/>

    </form>
</body>
</html>
