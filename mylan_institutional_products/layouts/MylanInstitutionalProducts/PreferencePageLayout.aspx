<%@ Page Language="c#" CodePage="65001" AutoEventWireup="true"  EnableEventValidation="false" %>

<%@ Register TagPrefix="sc" Namespace="Sitecore.Web.UI.WebControls" Assembly="Sitecore.Kernel" %>
<%@ OutputCache Location="None" VaryByParam="none" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content=''>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sc:Text runat="server" ID="id_HTML_PageTitle" Field="HTML_PageTitle" /></title>

    <link rel="canonical" href="http://mylaninstitutional-usproducts.com/" />

    <link rel="stylesheet" href="/assets/MylanInstitutionalProducts/styles/normalize.css" />
    <link rel="stylesheet" href="/assets/MylanInstitutionalProducts/styles/main.css" />
    <link rel="Stylesheet" href="/assets/MylanInstitutionalProducts/styles/jquery-ui.css" />

    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/plugins.js"></script>
    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/vendor/jquery-1.9.0.min.js"></script>
    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/vendor/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/vendor/jquery.cookie.js"></script>
    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/vendor/jquery.csv-0.71.js"></script>
    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/vendor/jquery.validate.min.js"></script>
    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/vendor/modernizr-2.6.2.min.js"></script>
    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/vendor/respond.min.js"></script>
    <script type="text/javascript" src="/assets/MylanInstitutionalProducts/scripts/main.js"></script>

    <sc:VisitorIdentification runat="server" />
    <script type="text/javascript" src="http://10524116.collect.igodigital.com/collect.js"></script>

    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),

            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-45354722-2', 'mylaninstitutional-usproducts.com');
        ga('send', 'pageview');


        //Begin Eloqua
        var _elqQ = _elqQ || [];
        _elqQ.push(['elqSetSiteId', '1825014871']);
        _elqQ.push(['elqTrackPageView']);

        (function () {
            function async_load() {
                var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true;
                s.src = '//img03.en25.com/i/elqCfg.min.js';
                var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x);
            }
            if (window.addEventListener) window.addEventListener('DOMContentLoaded', async_load, false);
            else if (window.attachEvent) window.attachEvent('onload', async_load);
        })();
        //End Eloqua

        _etmc.push(['setOrgId', '10524116']);
        _etmc.push(["trackPageView"]);
    
    </script>

</head>
<body>
    <noscript><div>To view this site correctly please enable JavaScript.</div></noscript>
    <form id="frmProducts" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="content-container" id="ctl1">
            <div class="head" data-role="header" id="ctl2">
                <div id="logo">
                    <a href="/MylanInstitutionalProducts/index">
                        <img id="img-logo" src="/assets/MylanInstitutionalProducts/images/logo-mobile.png" alt="mylan-logo" /></a>
                </div>

                <div id="email-head-box" class="head-black-bg">
                    <a onmouseup="emailProductsRouter()">
                        <img id="img-email" src="/assets/MylanInstitutionalProducts/images/email-box.png" alt="email-icon" /></a>
                </div>

                <div id="search-head-box" class="head-black-bg">
                    <div class="head-icons" id="search-box">
                        <a onmouseup="revealSearch();"><img id="search-icon" src="/assets/MylanInstitutionalProducts/images/search.png" alt="search-icon" /></a>
                        <div class="head-icons" id="search-form">
                            <input type="text" id="SearchTerm" placeholder="Search Product List" onkeyup="if (event.keyCode == 13) {submitSearch('SearchTerm'); return false;}" />
                            <input type="button" value="Go" id="search-btn" onmouseup="submitSearch('SearchTerm'); return false;" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="body" id="ctl3">
                <sc:Text runat="server" ID="id_PageTitle" Field="Body_PageTitle"></sc:Text>
                <sc:Text runat="server" ID="id_PageContent" Field="Body_PageContent"></sc:Text>
                <sc:Placeholder runat="server" Key="main"></sc:Placeholder>
            </div>

            <div class="footer" id="ctl10">
                <div class="footer-container">
                    <ul>
                        <li>Control-A-Dose unit dose packages is a registered trademark of Mylan.</li>
                        <li>Robot-Rx is a registered trademark of Aesynt Inc.</li>
                        <li>The Mylan logo is a registered trademark of Mylan Inc.</li>
                        <li>The trademarks displayed on this web page not registered to Mylan Inc. are the property of their respective owners.</li>
                    </ul>
                    <div id="info-phone" class="grey-bar">For more information call 1.800.848.0462</div>
                    <div id="sign-up"><a href="/MylanInstitutionalProducts/updates">Sign Up for Product Updates</a></div>
                    <div class="black" id="bottom-links">
                        <div id="copyright">&copy;2015 Mylan Institutional</div>
                        <div id="disclaimer"><a href="http://mylan.com/disclaimer.aspx">Copyright and Legal Disclaimer</a> &nbsp;|&nbsp; <a href="http://mylan.com/privacy.aspx">Privacy Policy</a> &nbsp;|&nbsp; <a href="/MylanInstitutionalProducts/Help">Help</a></div>
                        <div id="last-updated">Last Updated 01/2015</div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
