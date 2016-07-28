<%@ page contentType="text/html; charset=UTF-8" language="java" %>


/*****************自定义样式*****************/

/*textfield备选样式，无框单行文本输入样式*/
TEXTAREA.textfield_noFrame {
	font-family: "宋体";
	font-size: 9pt;
	color: #000000;
	text-decoration: none;
	background-color: transparent;
	border-top: 1px none;
	border-right: 1px none;
	border-bottom: 1px solid #333300;
	border-left: 1px none;
	line-height: 150%;
	font-weight: normal;
}

/*灰色虚线边框效果*/
.table_dashed {
	BORDER-RIGHT: #999 1px dotted;
	PADDING-RIGHT: 5px;
	BORDER-TOP: #999 1px dotted;
	PADDING-LEFT: 5px;
	FONT-WEIGHT: normal;
	FONT-SIZE: small;
	BACKGROUND: #eee;
	MARGIN-BOTTOM: 10px;
	PADDING-BOTTOM: 5px;
	BORDER-LEFT: #999 1px dotted;
	COLOR: #666;
	PADDING-TOP: 5px;
	BORDER-BOTTOM: #999 1px dotted;
	FONT-FAMILY: verdana, arial, sans-serif;
	line-height: 130%;
}

/*一级表头，导航样式*/
.th_bar {
	FONT-SIZE: 15px;
	FONT-WEIGHT: bold;
	COLOR: #FFFFFF;
	BACKGROUND-COLOR: #34679e;
	text-align:center;
}

/*二级表头*/
.th_2 {
	COLOR: #2E2E2E;
	BACKGROUND-COLOR: #CFCFD1;
	border-top: 1px ridge #EBE9ED;
	border-right: 1px none #EBE9ED;
	border-bottom: 1px none #EBE9ED;
	border-left: 1px none #EBE9ED;
}

/*三级表头*/
.th_3 {
	BACKGROUND-COLOR: #eee;
	FONT-WEIGHT: bold;
	TEXT-ALIGN: center;
	line-height: 20px;
	/*color: #666666;*/
	padding: 2px;
}

/*列头样式*/
.th_1 {
	text-align:right;
	background-color: #EBE9ED;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 0px;
	border-top-style: solid;
	border-right-style: solid;
	border-bottom-style: solid;
	border-left-style: none;
	border-top-color: #ADADAD;
	border-right-color: #D4D0C8;
	border-bottom-color: #D4D0C8;
	border-left-color: #D4D0C8;
	padding-right: 15px;
}

/*工作流流程设计图背景色*/
.bg_workFlowPic {
	BACKGROUND-COLOR: #03C3F0;
}

/*表格底色样式*/
.bg_recmtBody {
	BACKGROUND-COLOR: #eee;
}

/*警告文字*/
.font_warnning {
	font-family: "Arial";
	font-size: 11pt;
	color: #CC0000;
	text-decoration: none;
	filter: Shadow(Color=#dfdfdf, Direction=180);
	font-weight: bold;
	line-height: 25px;
}

/*右键菜单*/
.rightmenu_up{
	background-color: #3A6EA5;
	border-left: 2 solid #A6C1DF;
	border-right: 2 solid #002200; 
	border-top: 2 solid #A6C1DF;
	border-bottom: 2 solid #002200;
}

/*web页面分页打印使用*/
.table_pageTabe {
	width: 574px;
	HEIGHT: 26.7cm
}

.td_page_title {
	font-family: "Arial";
	font-size: 9pt;
	/*color: #B8D5F5;*/ /* 网通风格 */
	color: #B0B9D5; /* 中冶风格 */
	text-decoration: none;
	font-weight: bold;	
}

.style_required_red {
	color: #FF0000
}

.font_remain_prompt {
	color: #CC0000; /* FF0000 */
	font-weight: bold; 
}

.td_hand {
	cursor: hand;
	width: 50px;
}

.refButtonClass {
	width: 18px;
	height: 20px;
	vertical-align : middle;
	cursor: hand;
	border: 0px;
}

.2button_01 {
	font-family: "Arial";
	font-size: 9pt;
	color: #5D7692;
	text-decoration: none;
	height: 24px;
	width: 48px;
	border: 0px none;
	background-attachment: fixed;
	background-image: url(<%=request.getContextPath()%>/images/button/2button_01.jpg);
	background-repeat: no-repeat;
	background-position: center center;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	margin-right: 5px;
	margin-left: 5px;
	cursor:hand;
}

.2button_01a {
	font-family: "Arial";
	font-size: 9pt;
	color: #5D7692;
	text-decoration: none;
	height: 24px;
	width: 48px;
	border: 0px none;
	background-attachment: fixed;
	background-image: url(<%=request.getContextPath()%>/images/button/2button_01a.jpg);
	background-repeat: no-repeat;
	background-position: center center;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	margin-right: 5px;
	margin-left: 5px;
	cursor:hand;
}

.2button_02{
	font-family: "Arial";
	font-size: 9pt;
	color: #5D7692;
	text-decoration: none;
	height: 24px;
	width: 65px;
	border: 0px none;
	background-attachment: fixed;
	background-image: url(<%=request.getContextPath()%>/images/button/2button_02.jpg);
	background-repeat: no-repeat;
	background-position: center center;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	margin-right: 5px;
	margin-left: 5px;
	cursor:hand;
}

.2button_02a{
	font-family: "Arial";
	font-size: 9pt;
	color: #5D7692;
	text-decoration: none;
	height: 24px;
	width: 65px;
	border: 0px none;
	background-attachment: fixed;
	background-image: url(<%=request.getContextPath()%>/images/button/2button_02a.jpg);
	background-repeat: no-repeat;
	background-position: center center;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	margin-right: 5px;
	margin-left: 5px;
	cursor:hand;
}

.2button_03{
	font-family: "Arial";
	font-size: 9pt;
	color: #5D7692;
	text-decoration: none;
	height: 24px;
	width: 90px;
	border: 0px none;
	background-attachment: fixed;
	background-image: url(<%=request.getContextPath()%>/images/button/2button_03.jpg);
	background-repeat: no-repeat;
	background-position: center center;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	margin-right: 5px;
	margin-left: 5px;
	cursor:hand;
}

.2button_03a{
	font-family: "Arial";
	font-size: 9pt;
	color: #5D7692;
	text-decoration: none;
	height: 24px;
	width: 90px;
	border: 0px none;
	background-attachment: fixed;
	background-image: url(<%=request.getContextPath()%>/images/button/2button_03a.jpg);
	background-repeat: no-repeat;
	background-position: center center;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	margin-right: 5px;
	margin-left: 5px;
	cursor:hand;
}

.2button_04{
	font-family: "Arial";
	font-size: 9pt;
	color: #5D7692;
	text-decoration: none;
	height: 24px;
	width: 110px;
	border: 0px none;
	background-attachment: fixed;
	background-image: url(<%=request.getContextPath()%>/images/button/2button_04.jpg);
	background-repeat: no-repeat;
	background-position: center center;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	margin-right: 5px;
	margin-left: 5px;
	cursor:hand;
}

.2button_04a{
	font-family: "Arial";
	font-size: 9pt;
	color: #5D7692;
	text-decoration: none;
	height: 24px;
	width: 110px;
	border: 0px none;
	background-attachment: fixed;
	background-image: url(<%=request.getContextPath()%>/images/button/2button_04a.jpg);
	background-repeat: no-repeat;
	background-position: center center;
	text-align: center;
	vertical-align: middle;
	line-height: 15px;
	margin-right: 5px;
	margin-left: 5px;
	cursor:hand;
}


/*列表控件表头色*/

.th_4 {
	vertical-align:middle;
	BACKGROUND-COLOR: #B0B9D5;
	FONT-WEIGHT: bold;
	TEXT-ALIGN: center;
	padding: 1px;
	font-size: 12px;
}

.th_5 {
	vertical-align:middle;
	border:1px solid #ADADAD;
	margin: 1px auto;
	padding: 1px;
}

.img_1 {
	width: 18px;
	height: 20px;
	vertical-align: middle;
	cursor: hand;
	border: 0px;
}

.referencePage {
	background-color: #DEE5F0;
}

.uploadPage {
	background-color: #DEE5F0;
}

.textarea_FCKeditor {
	WIDTH: 100%;
	HEIGHT: 600px;
}