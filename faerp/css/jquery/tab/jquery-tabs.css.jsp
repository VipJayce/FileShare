/* Caution! Ensure accessibility in print and other media types... */
@media projection, screen { /* Use class for showing/hiding tab content, so that visibility can be better controlled in different media types... */
    .ui-tabs-hide {
        display: none;
    }
}

/* Hide useless elements in print layouts... */
@media print {
    .ui-tabs-nav {
        display: none;
    }
}

/* Skin */
.ui-tabs-nav, .ui-tabs-panel {
    font-family: "Trebuchet MS", Trebuchet, Verdana, Helvetica, Arial, sans-serif;
    font-size: 12px;
}
.ui-tabs-nav {
    list-style: none;
    margin: 0;
    padding: 0 0 0 4px;
}
.ui-tabs-nav:after { /* clearing without presentational markup, IE gets extra treatment */
    display: block;
    clear: both;
    content: " ";
}
.ui-tabs-nav li {
    float: left;
    margin: 0 0 0 1px;
    min-width: 84px; /* be nice to Opera */
}
.ui-tabs-nav a, .ui-tabs-nav a span {
    display: block;
    padding: 0 10px;
    background: url(<%=request.getContextPath()%>/images/ajaxList/tab.png) no-repeat;
}
.ui-tabs-nav a {
    margin: 1px 0 0; /* position: relative makes opacity fail for disabled tab in IE */
    padding-left: 0;
    color: #27537a;
    font-weight: bold;
    line-height: 1.2;
    text-align: center;
    text-decoration: none;
    white-space: nowrap; /* required in IE 6 */    
    outline: 0; /* prevent dotted border in Firefox */
}
.ui-tabs-nav .ui-tabs-selected a {
    position: relative;
    top: 1px;
    z-index: 2;
    margin-top: 0;
    color: #000;
}
.ui-tabs-nav a span {
    width: 64px; /* IE 6 treats width as min-width */
    min-width: 64px;
    height: 18px; /* IE 6 treats height as min-height */
    min-height: 18px;
    padding-top: 6px;
    padding-right: 0;
}
*>.ui-tabs-nav a span { /* hide from IE 6 */
    width: auto;
    height: auto;
}
.ui-tabs-nav .ui-tabs-selected a span {
    padding-bottom: 1px;
}
.ui-tabs-nav .ui-tabs-selected a, .ui-tabs-nav a:hover, .ui-tabs-nav a:focus, .ui-tabs-nav a:active {
    background-position: 100% -150px;
}
.ui-tabs-nav a, .ui-tabs-nav .ui-tabs-disabled a:hover, .ui-tabs-nav .ui-tabs-disabled a:focus, .ui-tabs-nav .ui-tabs-disabled a:active {
    background-position: 100% -100px;
}
.ui-tabs-nav .ui-tabs-selected a span, .ui-tabs-nav a:hover span, .ui-tabs-nav a:focus span, .ui-tabs-nav a:active span {
    background-position: 0 -50px;
}
.ui-tabs-nav a span, .ui-tabs-nav .ui-tabs-disabled a:hover span, .ui-tabs-nav .ui-tabs-disabled a:focus span, .ui-tabs-nav .ui-tabs-disabled a:active span {
    background-position: 0 0;
}
.ui-tabs-nav .ui-tabs-selected a:link, .ui-tabs-nav .ui-tabs-selected a:visited, .ui-tabs-nav .ui-tabs-disabled a:link, .ui-tabs-nav .ui-tabs-disabled a:visited { /* @ Opera, use pseudo classes otherwise it confuses cursor... */
    cursor: text;
}
.ui-tabs-nav a:hover, .ui-tabs-nav a:focus, .ui-tabs-nav a:active,
.ui-tabs-nav .ui-tabs-deselectable a:hover, .ui-tabs-nav .ui-tabs-deselectable a:focus, .ui-tabs-nav .ui-tabs-deselectable a:active { /* @ Opera, we need to be explicit again here now... */
    cursor: pointer;
}
.ui-tabs-disabled {
    opacity: .4;
    filter: alpha(opacity=40);
}
.ui-tabs-panel {
    border-top: 1px solid #97a5b0;
    padding: 1em 8px;
    background: #fff; /* declare background color for container to avoid distorted fonts in IE while fading */
}
.ui-tabs-loading em {
    padding: 0 0 0 20px;
    background: url(<%=request.getContextPath()%>/images/ajaxList/ajax-loader2.gif) no-repeat 0 50%;
}

/* Additional IE specific bug fixes... */
* html .ui-tabs-nav { /* auto clear, @ IE 6 & IE 7 Quirks Mode */
    display: inline-block;
}
*:first-child+html .ui-tabs-nav  { /* @ IE 7 Standards Mode - do not group selectors, otherwise IE 6 will ignore complete rule (because of the unknown + combinator)... */
    display: inline-block;
}

