<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmailSignup.ascx.cs" Inherits="mylan_institutional_products.layouts.MylanInstitutionalProducts.sublayouts.EmailSignup" %>
<script type="text/javascript">
    function updateCategories(chk) {
        var categories = document.getElementsByClassName("categories")[0];
        
        var val = categories.value;
        if (chk.checked) { 
            categories.value = val + chk.value + ";";
        } else {
            categories.value = val.replace(chk.value + ";", "");
        }
        console.log(categories.value)
    }

    function subscribe() {
        var email = document.getElementsByClassName("Email")[0];
        var firstName = document.getElementsByClassName("FirstName")[0];
        var lastName = document.getElementsByClassName("LastName")[0];
        var categories = document.getElementsByClassName("categories")[0];
        var firstNameMsg = document.getElementById("tbx_FirstName-msg");
        var lastNameMsg = document.getElementById("tbx_LastName-msg");
        var emailMsg = document.getElementById("tbx_YourEmail-msg");
        var categoriesMsg = document.getElementById("dev_ProductSectionDesc-msg");

        firstNameMsg.innerHTML = "";
        lastNameMsg.innerHTML = "";
        emailMsg.innerHTML = "";
        categoriesMsg.innerHTML = "";

        if (firstName.value.length == 0) {
            firstNameMsg.innerHTML = "Please enter your First Name";

            return false;
        }
        if (lastName.value.length == 0) {
            lastNameMsg.innerHTML = "Please enter your Last Name";

            return false;
        }
        if (email.value.length == 0) {
            emailMsg.innerHTML = "Please enter your Email Address";

            return false;
        }
        if (categories.value.length == 0) {
            categoriesMsg.innerHTML = "Please select at least one drug category";

            return false;
        }
        var form = document.getElementById("frmProducts");

        form.submit();
    }
</script>

<form  name="subscriptionform" id="subscriptionform" method="post"> <%--action="http://cl.exct.net/subscribe.aspx"--%>
    <input type="hidden" name="thx" value="http://<%= HttpContext.Current.Request.Url.Host %>/MylanInstitutionalProducts/Updates-ThankYou" />
    <input type="hidden" name="err" value="http://<%= HttpContext.Current.Request.Url.Host %>/MylanInstitutionalProducts/EmailProductUpdates-Subscribe" />
    <input type="hidden" name="MID" value="10524116" />
    <div class="content-container">
        <div id="div_FirstName"> 
            <div id="div_FirstNameField">
                <label for="tbx_FirstName">First Name</label><br />
                <input type="text" id="tbx_FirstName" name="First Name" class="FirstName"  runat="server" />
            </div>
            <div><span id="tbx_FirstName-msg" style="color: red;"></span></div>
        </div>

        <div id="div_LastName">
            <div id="div_LastNameField">
                <label for="tbx_LastName">Last Name</label><br />
                <input type="text" id="tbx_LastName" name="Last Name" class="LastName" runat="server" />
            </div>
            <div><span id="tbx_LastName-msg" style="color: red;"></span></div>
        </div>

        <div id="div_YourEmail">
            <div id="div_YourEmailField" style="display: inline-block;">
                <label for="tbx_YourEmail">Email Addresses</label><br />
                <input type="text" id="tbx_YourEmail" name="Email Address" class="Email"  runat="server" />
            </div>
            <div id="email-double" style="display: inline-block;"></div>
            <div><span id="tbx_YourEmail-msg" style="color: red;"></span></div>
        </div>
        <input type="hidden" id="categories" class="categories" runat="server" />

        <div id="div_ProductSection">
            <div id="dev_ProductSectionDesc" style="padding: 0 !important;">Please check the drug categories below that you would like to receive updates for</div>
            <span id="dev_ProductSectionDesc-msg" style="color: red;"></span>
            <input type="checkbox" style="display: none;" name="lid" value="18184147" checked="true" />
            <ul>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_udd" name="lid" value="17942355" onclick="updateCategories(this)" runat="server"  />
                    Unit Dose</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_inj" name="lid" value="17942350" onclick="updateCategories(this)" runat="server" />
                    Injectables</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_bwc" name="lid" value="17942353" onclick="updateCategories(this)" runat="server"  />
                    Creams, Ointments, Sprays, and Dressings</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_cad" name="lid" value="17942356" onclick="updateCategories(this)"  runat="server" />
                    Control-A-Dose<sup>&reg;</sup> (Reverse Number Pack)</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_rbx" name="lid" value="17942359"  onclick="updateCategories(this)" runat="server" />
                    Robot-Rx<sup>&reg;</sup> Ready</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_pun" name="lid" value="17942361" onclick="updateCategories(this)" runat="server" />
                    Punch Card</li>
                <!--<li><input type="checkbox" ID="cbx_ProdSelect_emi" name="lid" value="17942362" /> Emergi-Script</li>
                <li><input type="checkbox" ID="cbx_ProdSelect_vet" name="lid" value="17942354" /> Veterinary</li>-->
            </ul> 
        </div>
        <div id="div_SubmitButton">
            <input type="button" runat="server" id="btn_Submit" value="Subscribe" onclick="subscribe();" />
        </div>
    </div>
</form>
