<%@ page errorPage="/jsp/include/errorpage.jsp" %>
<%@ page import="royoo.common.TagSortUitl" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
 <%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<%@ taglib uri="/WEB-INF/gap-i18n.tld" prefix="i18n" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/gap-authority.tld" prefix="au" %>
<%@ taglib uri="/WEB-INF/gap-bnLog.tld" prefix="bnLog" %>
<%@ taglib uri="/WEB-INF/gap-data.tld" prefix="data" %>
<%@ taglib uri="/WEB-INF/gap-faerp.tld" prefix="faerp" %>

<%System.out.println("jsp-----------"+request.getRequestURI()); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<script language="javascript">
	var dir_base = "<venus:base/>";
</script>


<i18n:javascript src="/js/common/variable-i18n.js"/>
<link href="<venus:base/>/css/alex-css.jsp" type="text/css" rel="stylesheet">
<!-- liuping add -->
<link href="<venus:base/>/css/common.css" type="text/css" rel="stylesheet">
<link href="<venus:base/>/css/index.css" type="text/css" rel="stylesheet">


<style type="text/css">

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

.refButtonClass {
    border: 0 none;
    cursor: pointer;
    height: 20px;
    vertical-align: middle;
    width: 18px;
}


.text_field_reference_readonly {
    background-color: #D6E8F4;
    border-color: #BACEDD;
    border-style: solid;
    border-width: 1px;
    color: #003300;
    height: 20px;
    line-height: 13px;
    vertical-align: middle;
    width: 186px;
}

tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
BODY {
    /*滚动样式*/
    SCROLLBAR-FACE-COLOR: #e5eef5;
    SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
    SCROLLBAR-SHADOW-COLOR: #b6d5ea;
    SCROLLBAR-3DLIGHT-COLOR: #b6d5ea;
    SCROLLBAR-ARROW-COLOR: #2b7fc1;
    SCROLLBAR-TRACK-COLOR: #ffffff;
    SCROLLBAR-DARKSHADOW-COLOR: #eeeeee;
}
*{
    /*滚动样式*/
    SCROLLBAR-FACE-COLOR: #e5eef5;
    SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
    SCROLLBAR-SHADOW-COLOR: #b6d5ea;
    SCROLLBAR-3DLIGHT-COLOR: #b6d5ea;
    SCROLLBAR-ARROW-COLOR: #2b7fc1;
    SCROLLBAR-TRACK-COLOR: #ffffff;
    SCROLLBAR-DARKSHADOW-COLOR: #eeeeee;
}
</style>

<script language="javascript" src="<venus:base/>/js/common/gap-mainframe.js"></script>
<script language="javascript" src="<venus:base/>/js/common/gap-validate.js"></script>

<script language="javascript" src="<venus:base/>/js/common/gap-collection.js"></script>
<script language="javascript" src="<venus:base/>/js/common/gap-status.js"></script>


<script language="javascript" src="<venus:base/>/js/rm-tools.js"></script>
<script language="javascript" src="<venus:base/>/js/common.js"></script>

</html>
<!--msg start-->
<venus:message kind="script"/>
<!--msg end-->