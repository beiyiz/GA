<%@ Control Language="c#" AutoEventWireup="true" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<div id="logo">
    <a href="/MylanInstitutionalProducts/index">
        <img id="img-logo" src="/assets/MylanInstitutionalProducts/images/logo-mobile.png" alt="mylan-logo" /></a>
</div>

<div id="email-head-box" class="head-black-bg">
    <a onmouseup="emailProductsRouter()">
        <img id="img-email" src="/assets/MylanInstitutionalProducts/images/email-icon-web.png" alt="email-icon" /></a>
</div>

<div id="search-head-box" class="head-black-bg">
    <div class="head-icons" id="search-box">
        <a onmouseup="revealSearch();">
            <img id="search-icon" src="/assets/MylanInstitutionalProducts/images/search.png" alt="search-icon" /></a>
        <div class="head-icons" id="search-form">
            <input type="text" id="SearchTerm" placeholder="Search Product List" />
            <input type="button" value="Go" id="search-btn" onmouseup="submitSearch(); return false;" />
        </div>
    </div>
</div>
