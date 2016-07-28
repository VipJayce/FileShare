<%@ page contentType="text/html; charset=UTF-8" language="java" %>

/*****************内部样式重定义*****************/

/*内容样式*/
BODY {
    FONT-SIZE: 9pt;
    COLOR: #000000;
    FONT-FAMILY: 宋体,Arial;
    background-color: #FFFFFF;

    margin-bottom: 0px;
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;

    /*滚动样式*/
    SCROLLBAR-FACE-COLOR: #e5eef5;
    SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
    SCROLLBAR-SHADOW-COLOR: #b6d5ea;
    SCROLLBAR-3DLIGHT-COLOR: #b6d5ea;
    SCROLLBAR-ARROW-COLOR: #2b7fc1;
    SCROLLBAR-TRACK-COLOR: #ffffff;
    SCROLLBAR-DARKSHADOW-COLOR: #eeeeee;
    overflow:auto;
}
body, table, td {
    font-size:9pt
}


/* 链接样式 */
A {
    text-decoration: none;
}
A:link {
    text-decoration:none;color:#000000
}
A:visited {
    font-size: 9pt;
    color: #666666;
    text-decoration: none;
    font-family: "Arial";
}
A:Hover {
    text-decoration: underline;
    clip: rect();
    crosshair;Color:#99ccff;
    color:#FF9900;
}
/*因为与ext的grid冲突，而且没有发现使用到下面的样式属性，故去掉    
    position: relative;
    left: 0px;
    top: 0px;
}*/


/* 表单样式 */
FORM {
    FONT-WEIGHT: normal;
    LINE-HEIGHT: normal;
    FONT-STYLE: normal;
    FONT-FAMILY: MS Shell Dlg,tahoma;
}

/* 表单的列样式 */
TD {
    FONT-SIZE: 9pt;
    FONT-FAMILY: Verdana,Helvetica,Arial;
}


/* 输入控件样式 */
INPUT {
    font-family: "Arial";
    font-size: 9pt;
    color: #003300;
    height: 20px;
    vertical-align: middle;
    border: 0px solid #90b3cf;
}


/* 文本输入域样式 */
TEXTAREA {
    font-family: "Arial";
    font-size: 9pt;
    color: #163752;
    text-decoration: none;
    border-top: 1px solid #90b3cf;
    border-right: 1px solid #90b3cf;
    border-bottom: 1px solid #90b3cf;
    border-left: 1px solid #90b3cf;
    overflow:auto;
    width: 204px;
}

.textarea_reference {  
    font-family: "Arial";
    font-size: 9pt;
    color: #163752;
    text-decoration: none;
    border-top: 1px solid #90b3cf;
    border-right: 1px solid #90b3cf;
    border-bottom: 1px solid #90b3cf;
    border-left: 1px solid #90b3cf;
    overflow:auto;
    width: 186px;
}

.textarea_reference_readonly { 
    font-family: "Arial";
    font-size: 9pt;
    color: #163752;
    text-decoration: none;
    border-top: 1px solid #90b3cf;
    border-right: 1px solid #90b3cf;
    border-bottom: 1px solid #90b3cf;
    border-left: 1px solid #90b3cf;
    overflow:auto;
    background-color: #d6e8f4;
    width: 186px;
}


/* 下拉控件样式 */
SELECT {
    font-family: "Arial";
    font-size: 9pt;
    color: #003300;
    text-decoration: none;
    vertical-align: middle;
    border-top: 1px solid #90b3cf;
    border-right: 1px solid #90b3cf;
    border-bottom: 1px solid #90b3cf;
    border-left: 1px solid #90b3cf;
    width: 204px;
}



/* 表单基本元素的样式表 */
.text_field {
    /* 最长的text */
    font-size: 9pt;
    color: #163752;
    height: 20px;
    vertical-align: middle;
    border: 1px solid #90b3cf;
    width: 204px;
    background-color: #ffffff;
    margin-right:5px;
}

/* 表单基本元素的样式表 */
.text_field_half {
    /* 最长的text */
    font-size: 9pt;
    color: #163752;
    height: 20px;
    vertical-align: middle;
    border: 1px solid #90b3cf;
    width: 102px;
    background-color: #ffffff;
    margin-right:5px;
}

.text_field_reference {  
    /*参照左边的text，可写，长度为 (最长-参照width)*/
    font-size: 9pt;
    color: #003300;
    height: 20px;
    vertical-align: middle;
    border-top: 1px solid #90b3cf;
    border-right: 1px solid #90b3cf;
    border-bottom: 1px solid #90b3cf;
    border-left: 1px solid #90b3cf;
    line-height: 13px;
    width: 186px;
    background-color: #d6e8f4;
}
.text_field_readonly {
    /*参照左边的text，只读，长度为 (最长-参照width)*/
    font-size: 9pt;
    color: #003300;
    height: 20px;
    vertical-align: middle;
    border-top: 1px solid #bacedd;
    border-right: 1px solid #bacedd;
    border-bottom: 1px solid #bacedd;
    border-left: 1px solid #bacedd;
    line-height: 13px;
    background-color: #d6e8f4;
    width: 204px;
}
.text_field_reference_readonly { //参照左边的text，只读，长度为 (最长-参照width)
    font-size: 9pt;
    color: #003300;
    height: 20px;
    vertical-align: middle;
    border-top: 1px solid #bacedd;
    border-right: 1px solid #bacedd;
    border-bottom: 1px solid #bacedd;
    border-left: 1px solid #bacedd;
    line-height: 13px;
    background-color: #d6e8f4;
    width: 186px;
}
.text_field_half_reference_readonly { //参照左边的text，只读，长度为 (最长-参照width)
    font-size: 9pt;
    color: #003300;
    height: 20px;
    vertical-align: middle;
    border-top: 1px solid #bacedd;
    border-right: 1px solid #bacedd;
    border-bottom: 1px solid #bacedd;
    border-left: 1px solid #bacedd;
    line-height: 13px;
    background-color: #d6e8f4;
    width: 93px;
}
.textarea_limit_words {
   
}
.textarea_fckEditor {
    WIDTH: 100%;
    HEIGHT: 600px;
}


/* Div块区域的样式表 */
.table_div_control {
    font-family: "Arial";
    font-size: 9pt;
    font-weight: bolder;
    color: #edf4fd;
    text-decoration: none;
    margin-top: 2px;
    border: 1px solid #4a99d7;
    width: 100%;
    border-spacing: 0px;
    padding: 0px;
    background-image:url('<%=request.getContextPath()%>/images/templatestyle/main0_08.jpg');
    background-position:left top;
    background-repeat:repeat-x;
    background-color: #226ea9;
    height:25px;
}
.table_div_doublecontrol {
    font-family: "Arial";
    font-size: 9pt;
    font-weight: bolder;
    color: #edf4fd;
    text-decoration: none;
    margin-top: 2px;
    border: 1px solid #4a99d7;
    width: 100%;
    border-spacing: 0px;
    padding: 0px;
    background-image:url('<%=request.getContextPath()%>/images/templatestyle/main0_08double.jpg');
    background-position:left top;
    background-repeat:repeat-x;
    background-color: #226ea9;
    height:50px;
}
.table_div_content {
    border: 1px solid #bdd5e3;
    width: 100%;
    border-spacing: 0px;
    border-collapse: collapse;
    /* 折行 */
    /*table-layout:fixed;*/
    /*word-wrap: break-word;*/
    word-break: break-all;
    margin-bottom:8px;
    background-color: #f4fafe;
    background-image:url('<%=request.getContextPath()%>/images/templatestyle/main0_12.jpg');
    background-position:left bottom;
    background-repeat:repeat-x;
}
.table_div_content td {
    padding:2px;
}
.table_div_content2 {
  border-collapse: inherit;
}
.table_div_content2 td {
   padding:3px 10px;border-bottom:1px solid #c0d0dc; height:20px;
}
.div_control_image {
    width: 16px;
    height: 16px;
    vertical-align : middle;
    cursor: pointer;
    border: 0px;
}
.table_div_content_frame {
    border: 0px solid #bdd5e3;
    border-spacing: 0px;
    border-collapse: collapse;
    /* 折行 */
    table-layout:fixed;
    word-wrap: break-word;
    word-break: break-all;
    background-color: #f4fafe;
    background-image:url('<%=request.getContextPath()%>/images/templatestyle/main0_12.jpg');
    background-position:left bottom;
    background-repeat:repeat-x;
}


/* 按钮的样式表 */
.button_ellipse {
    border:1px solid #4999d8;
    font-size:12px;
    color:#082a45;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px;
    padding-bottom:0px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;

}
.btn3_mouseout { 
    border:1px solid #4999d8;
    font-size:12px;
    color:#082a45;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;
} 
.btn3_mouseover { 
    border:1px solid #d7c14a;
    font-size:12px;
    color:#a03717;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;
} 
.btn3_mousedown 
{ 
    border:1px solid #d7c14a;
    font-size:12px;
    color:#a03717;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;
} 
.btn3_mouseup { 
    border:1px solid #d7c14a;
    font-size:12px;
    color:#a03717;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;
}


/* 列表的样式表 */

.listCss td{padding:0px;}

table.listCss {
    vertical-align:middle;
    border-width:0px;
    border-spacing:px;
    border-collapse:1px;
    line-height: 130%;
    background-color: #b6d5ea;
}
th.listCss {
    vertical-align:middle;
    border:0px solid #9EB4CD;
    border-width:0px;
    border-spacing:0px;
    border-collapse:0px;
    margin: 1px auto;
    padding: 1px;
    line-height: 130%;
    background-color: #b9def7;
    color:#206ba4;
}
tr.listCss {
    /*background-color: #FFFFFF;*/
}
td.listCss {
    vertical-align:middle;
    border:0px solid #9EB4CD;
    border-width:0px;
    border-spacing:0px;
    border-collapse:0px;
    margin: 1px auto;
    padding: 1px;
    line-height: 130%;
    height: 22px;
}

/*新增查看样式*/
.viewlistCss{
    background-color: #d9e5f3;
    width:99%;
}
.viewlistCss td{
    background-color: #fdfefe;
    margin: 1px auto;
    padding: 2px;
    line-height: 130%;
 }
.viewlistCss th{
    background-color: #eaf3fd;
    color:#146497; 
    font-weight:normal;
    margin: 1px auto;
    padding: 2px;
    line-height: 130%;
    height: 22px;
}

.img_1 {
    width: 20px;
    height: 20px;
    vertical-align: middle;
    cursor: pointer;
    border: 0px;
}

/* For RM FrameWork */
.refButtonClass{
    width: 18px;
    height: 20px;
    vertical-align: middle;
    cursor: pointer;
    border: 0px;
}
/*以下为新做*/
.maintopbg01{
background-image:url("<%=request.getContextPath()%>/images/templatestyle/main0_03.jpg");
background-position:left top;
background-repeat:no-repeat;
}
.maintopbg02{
background-image:url("<%=request.getContextPath()%>/images/templatestyle/main0_05.jpg");
background-position:right top;
background-repeat:no-repeat;
}
.maintop_title_bg{
background-image:url("<%=request.getContextPath()%>/images/templatestyle/maintop_title_02.gif");
background-position:left top;
background-repeat:no-repeat;
}
.maintop_title_text{
color:#2b7fc1;
font-weight:bold;
line-height:25px;
}
.page_text{color:#3b4349;}
.page_text01{color:#e35406;}


/* 列表的样式表  固定表头和列*/

table.listCssgd {
    vertical-align:middle;
    border-width:0px;
    border-spacing:px;
    border-collapse:1px;
    line-height: 130%;
    background-color: #b6d5ea;
}



th.listCssgdtitle {
    vertical-align:middle;
    border:0px solid #9EB4CD;
    border-width:0px;
    border-spacing:0px;
    border-collapse:0px;
    margin: 1px auto;
    padding: 1px;
    line-height: 130%;
    background-color: #b9def7;
    color:#206ba4;
    
    POSITION: relative; 
    LEFT: expression(this.parentElement.offsetParent.scrollLeft); 
    WHITE-SPACE: nowrap;    

}

th.listCssgd {
    vertical-align:middle;
    border:0px solid #9EB4CD;
    border-width:0px;
    border-spacing:0px;
    border-collapse:0px;
    margin: 1px auto;
    /**padding: 1px;**/
    line-height: 130%;
    background-color: #b9def7;
    color:#206ba4;

}

tr.listCssgd {
    background-color: #FFFFFF;
}

td.listCssgdtitle {
    vertical-align:middle;
    border:0px solid #9EB4CD;
    border-width:0px;
    border-spacing:0px;
    border-collapse:0px;
    margin: 1px auto;
    padding: 1px;
    line-height: 130%;
    height: 22px;
    
    POSITION: relative; 
    LEFT: expression(this.parentElement.parentElement.parentElement.parentElement.offsetParent.parentElement.parentElement.scrollLeft);  
    WHITE-SPACE: nowrap; 
}

td.listCssgd {
    vertical-align:middle;
    border:0px solid #9EB4CD;
    border-width:0px;
    border-spacing:0px;
    border-collapse:0px;
    margin: 1px auto;
    padding: 1px;
    line-height: 130%;
    height: 22px;
}

.style_required_red{
    color:red;
}
.page{border:1px solid #c5dbe2; margin:0 10px 10px 10px; border-top:none; height:26px; background:#f2f8fa; padding:5px 10px 0 10px; line-height:28px; color:#075587;}
.page a{ color:#075587;}
.page a:hover{ color:#e60012;}
.page .pText{color:#817c7c;height:16px;	line-height:16px;background:#fff url(images/bk_field.png) repeat-x top right; padding:3px;border-top:1px solid #8d8e8d;
