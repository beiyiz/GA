<%@ Control Language="c#" AutoEventWireup="True" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" Inherits="Layouts.Emailsignup.PreferenceUpdateSublayout" CodeFile="~/layouts/MylanInstitutionalProducts/sublayouts/PreferenceUpdate.ascx.cs" %>
<form action="http://cl.exct.net/subscribe.aspx" name="subscribeForm" method="post">
    <input type="hidden" name="thx" value="http://<%= HttpContext.Current.Request.Url.Host %>/MylanInstitutionalProducts/Updates-ThankYou" />
    <input type="hidden" name="err" value="http://<%= HttpContext.Current.Request.Url.Host %>/MylanInstitutionalProducts/EmailProductUpdates-Subscribe" />
    <input type="hidden" name="MID" value="10524116" />
    <div class="content-container">
    <div id="div_FirstName">
        <div id="div_FirstNameField">
            <label for="tbx_FirstName">First Name</label><br />
            <input runat="server" type="text" id="tbx_FirstName" name="First Name" class="required" />
        </div>
        <div><span id="tbx_FirstName-msg" style="color: red;"></span></div>
    </div>

    <div id="div_LastName">
        <div id="div_LastNameField">
            <label for="tbx_LastName">Last Name</label><br />
            <input runat="server" type="text" id="tbx_LastName" name="Last Name" class="required" />
        </div>
        <div><span id="tbx_LastName-msg" style="color: red;"></span></div>
    </div>

    <div id="div_YourEmail">
        <div id="div_YourEmailField" style="display: inline-block;">
            <label for="tbx_YourEmail">Email Addresses</label><br />
            <input runat="server" type="text" id="tbx_YourEmail" name="Email Address" class="required email" />
        </div>
        <div id="email-double" style="display: inline-block;"></div>
        <div><span id="tbx_YourEmail-msg" style="color: red;"></span></div>
    </div>

        <div id="div_ProductSection">
            <div id="dev_ProductSectionDesc" style="padding: 0 !important;">Please check the drug categories below that you would like to receive updates for</div>
            <div id="dev_ProductSectionDesc-msg" style="color: red;"></div>
            <input type="checkbox" style="display: none;" name="lid" value="18184147" checked="true" />
            <ul>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_udd" name="lid" value="17942355" />
                    Unit Dose</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_inj" name="lid" value="17942350" />
                    Injectables</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_bwc" name="lid" value="17942353" />
                    Creams, Ointments, Sprays, and Dressings</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_cad" name="lid" value="17942356" />
                    Control-A-Dose<sup>&reg;</sup> (Reverse Number Pack)</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_rbx" name="lid" value="17942359" />
                    Robot-Rx<sup>&reg;</sup> Ready</li>
                <li>
                    <input type="checkbox" id="cbx_ProdSelect_pun" name="lid" value="17942361" />
                    Punch Card</li>
                <!--<li><input type="checkbox" ID="cbx_ProdSelect_emi" name="lid" value="17942362" /> Emergi-Script</li>
                <li><input type="checkbox" ID="cbx_ProdSelect_vet" name="lid" value="17942354" /> Veterinary</li>-->
            </ul>
        </div>
        <div id="div_SubmitButton">
            <input type="submit" id="btn_Submit" value="Update" onclick="validateSubscription(); return false;" />
        </div>
    </div>
</form>
