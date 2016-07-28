<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.quotationtemplate.vo.QuotationVo"%>
<%@ page import="rayoo.sales.quotationtemplate.util.IQuotationConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">

	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").addParam("biz_type_bd",$name("biz_type_bd").value); 
        $id("datacell1").addParam("quotation_template_name",$id("quotation_template_name").value); 
        $id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function choose()
    {
        var quotationtempleteid=document.getElementById('quotationtempleteid').value;
        var quotationtempletename=document.getElementById('quotationtempletename').value;
        var returnAry = new Array();
        returnAry[0]=quotationtempleteid;
        returnAry[1]=quotationtempletename;
        window.returnValue=returnAry;
        window.close();
        
    }
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='id'   onClick=ClickRow(\"" + escape(entity.getProperty("id")) + "\",\"" + escape(entity.getProperty("quotation_template_name")) + "\");>";
    }
    function ClickRow(quotationtempleteid,quotationtempletename){
        document.getElementById('quotationtempleteid').value=unescape(quotationtempleteid);
        document.getElementById('quotationtempletename').value=unescape(quotationtempletename);
    }
</script>
	</head>
	<body>

	<form name="form" method="post" action="<%=request.getContextPath()%>/QuotationtemplateAction.do">
	<input type="hidden" name="cmd" value="">

	<div id="right">
	<div class="ringht_s">

	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title">查询条件</div>
			</td>
		</tr>
		<tr>
			<td width="80" align="right">模板名称</td>
			<td width="194" align="left"><input type="text" class="text_field" id="quotation_template_name" name="quotation_template_name"  inputName="模板名称"  maxLength="50" /></td>
			<td width="80" align="right">业务类别</td>
			<td width="249" align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("biz_type_bd", -1,"SAL_QUO_BIZ_TYPE_BD", "", "", false) %>
			</td>
			<td width="322">
			<input name="button_ok" class="icon_1" type="button"  onClick="javascript:simpleQuery_onClick()">
			</td>
				
		</tr>
		<tr></tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="a"><a onClick="javascript:choose();"><fmt:message
			key="choice" /> </a></li>
	</ul>

	</div>
	<div class="clear"></div>
	</div>
    <input type="hidden" id="quotationtempleteid"  name="quotationtempleteid"/>
    <input type="hidden" id="quotationtempletename"  name="quotationtempletename"/>
       <r:datacell 
        id="datacell1"
       queryAction="/FAERP/QuotationtemplateAction.do?cmd=simpleQuery1"
        width="100%"
        height="320"
        xpath="QuotationVo"
        submitXpath="QuotationVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       <r:field fieldName="quotation_template_name" width="120px" label="模板名称" >
       </r:field>    
      <r:field fieldName="effect_date" width="200px" label="生效日期" allowModify="false">
       <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>    
       <r:field fieldName="lapse_date" width="200px" label="失效日期" allowModify="false">
        <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>    
    </r:datacell>
    </div>
	</div>
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

