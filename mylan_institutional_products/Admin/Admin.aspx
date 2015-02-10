<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="mylan_institutional_products.Admin.Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-theme.min.css" />
    <script type="text/javascript" src="scripts/jquery-2.1.3.min.js"></script>   
   <script type="text/javascript" src="scripts/bootstrap.min.js"></script>


    <script type="text/javascript">
        $(document).ready(function () {

            $(".changeDetails").hide();
        });

        var displayHtml = function (changeId) {

            var win = window.open("ViewHtml.aspx?changeId=" + changeId, "Preview Item Change", "target=_new, width=1100, height=300");

        }

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

        <input type="hidden" id="hdnApprovedIds" runat="server" />
        <input type="hidden" id="hdnDeletedIds" runat="server"  />

    </div>
    <input type="button" id="btnSubmit" class="btn btn-default btn-success" value="Submit"  onclick="adminApproval()"/>
    </form>
</body>
</html>
