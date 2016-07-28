<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.common.sales.sales_resource" prefix="rayoo.common.sales.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key="choose_quotation"/></title>
	<script type="text/javascript">
	/*
	 function setCheckbox(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + escape(entity.getProperty("quotation_code")) + "\",\"" + escape(entity.getProperty("quotation_name")) + "\");>";
     }
    function ClickRow(id,quotationcode,quotationname){
	    document.getElementById("ids").value=id;
	    document.getElementById("quotationcode").value=unescape(quotationcode);
	    document.getElementById("quotationname").value=unescape(quotationname);
    }*/
	function simpleQuery1_onClick(){
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
	function detail_onClick(){  //实现转到详细页面
        var returnAry = new Array();
        var quo = $id("datacell1").getActiveEntity();
        //报价单ID
        returnAry[0] = quo.getValue("id");
        //报价单名称
        returnAry[1] = quo.getValue("quotation_name");
        //报价单编号
        returnAry[2] = quo.getValue("quotation_code");
        returnAry[3] = quo.getValue("biz_type_bd");
        
        window.returnValue=returnAry;
        window.close();
	}
	</script>
	</head>
	<body>
	<form name="form" method="post"  id="datacell_formid">
		<input type="hidden" id="ids" />
      	<input type="hidden" id="quotationcode" />
        <input type="hidden" id="quotationname" />
        <input type="hidden" name="customer_id" value="${param.customer_id }"/>
        <input type="hidden" name="biz_type_bd" value="${param.biz_type_bd }"/>
        <input type="hidden" name="quotatus_status" value="3"/>
	<div id="right">
	<div class="ringht_s">
	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key="query_condition"/></div>
			</td>

			<td align="right"><fmt:message key="quotation_code"/></td>
			<td align="left">
			<input type="text" class="text_field"  id="quotationcode1"
				name="quotationcode1" inputName="报价单编号" maxLength="64" />
			</td>

            <td align="right"><fmt:message key="quotation_name"/></td>
            <td align="left">
            <input type="text" class="text_field" id="quotationname1"
                name="quotationname1" inputName="报价单名称" maxLength="50" />
            </td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="cust_name"/></td>
			<td align="left">
			<input type="text" class="text_field" id="customername1"
				name="customername1" inputName="客户名称" maxLength="50" />
			</td>

            <td><input name="button_ok" class="icon_1" type="button"
                value="<fmt:message key="query"/>" onClick="javascript:simpleQuery1_onClick()" />
            </td>
		</tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="a">
		  <a onClick="javascript:detail_onClick();"><fmt:message key="choose"/></a>
		</li>
	</ul>

	</div>
	<div class="clear"></div>
	</div>
	
	<r:datacell id="datacell1"
            queryAction="/FAERP/QuotationAction.do?cmd=queryAll1" 
            isCount="false"
            width="100%" 
            xpath="QuotationVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="320px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <!-- 
            <r:field allowModify="false" fieldName="id" sortAt="none" label="选择" width="50px" onRefreshFunc="setCheckbox" >
                           </r:field>   -->
            <r:field fieldName="quotation_code" width="150px" messagekey="quotation_code" >
            </r:field>
              <r:field fieldName="quotation_name" width="300px" messagekey="quotation_name" >
            </r:field>
           <r:field fieldName="customer_name" width="230px" messagekey="cust_name"  >
            </r:field>
        </r:datacell>
	</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
<script type="text/javascript">
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
	detail_onClick();
}
</script>