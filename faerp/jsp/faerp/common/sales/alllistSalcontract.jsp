<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo"%>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	var jq = jQuery.noConflict();
  	jq(function(){
  	     //$id("datacell1").isQueryFirst = false;// 
  	     simpleQuery1_onClick();
  	});
  	function simpleQuery1_onClick(){
  	   $id("datacell1").addParam("contract_code",$name("contract_code").value); 
        $id("datacell1").addParam("contract_name",$name("contract_name").value); 
        //alert($name("contract_code").value+"********"+$name("contract_name").value+"********"+$name("customer_name").value+"*********"+$name("customer_code").value);
        $id("datacell1").addParam("customer_code",$name("customer_code").value); 
        $id("datacell1").addParam("customer_name",$name("customer_name").value); 
        $id("datacell1").addParam("contract_type_bd",$name("contract_type_bd").value); 
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
     function choose()
    {
        entity=choose_row_public("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("contract_name");
        returnAry[2] = entity.getProperty("customer_id");
        returnAry[3]=entity.getProperty("customer_name");
        returnAry[4]=entity.getProperty("customer_code");
        returnAry[5]=entity.getProperty("company_id");
        
        returnAry[6]=entity.getProperty("contract_type_bd");
        returnAry[7]=entity.getProperty("contract_start_date");
        returnAry[8]=entity.getProperty("contract_stop_date");
        returnAry[9]=entity.getProperty("billing_user_id");
        window.returnValue=returnAry;
        window.close();
        /*
        var contractid=document.getElementById('contractid').value;
        var contractname=document.getElementById('contractname').value;
        var customerid=document.getElementById('customerid').value;
        var customername=document.getElementById('customername').value;
        var customercode=document.getElementById('customercode').value;
        var companyid=document.getElementById('companyid').value;
        var returnAry = new Array();
        returnAry[0]=contractid;
        returnAry[1]=contractname;
        returnAry[2]=customerid;
        returnAry[3]=customername;
        returnAry[4]=customercode;
        returnAry[5]=companyid;
        window.returnValue=returnAry;
        window.close();
        */
        
    }
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + escape(entity.getProperty("contract_name")) + "\",\"" + escape(entity.getProperty("id")) + "\",\"" + escape(entity.getProperty("customer_id")) + "\",\"" +  escape(entity.getProperty("customer_name")) + "\",\"" +  escape(entity.getProperty("customer_code")) + "\",\"" +  escape(entity.getProperty("company_id")) + "\");>";
    }
    function ClickRow(contractname,contractid,customerid,customername,customercode,companyid){
        document.getElementById('contractid').value=unescape(contractid);
        document.getElementById('contractname').value=unescape(contractname);
        document.getElementById('customerid').value=unescape(customerid);
        document.getElementById('customername').value=unescape(customername);
        document.getElementById('customercode').value=unescape(customercode);
        document.getElementById('companyid').value=unescape(companyid);
    }
</script>
	</head>
	<body>

	<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/SalcontractAction.do">
    
    <input type="hidden" name="contract_type_bd" value="${param.contract_type_bd }">
    
	<div id="right">
	<div class="ringht_s">


	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">


		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title">查询条件</div>
			</td>
			<td />
			<td />
			<td/>
			<td />
		</tr>



		<tr>
			<td align="right">合同编号</td>
			<td align="left">
			<input type="text" class="text_field"
				id="contract_code" name="contract_code" inputName="合同编号" maxLength="64" />
				
				
				
				</td>
			<td align="right">合同名称</td>
			<td align="left"><input type="text" class="text_field"
                id="contract_name" name="contract_name" inputName="合同名称" maxLength="50" /></td>
			<td align="right"></td>
		</tr>
		<tr>
		   <td align="right">客户编号</td>
            <td align="left"><input type="text" class="text_field"
                id="customer_code" name="customer_code" inputName="客户编号" maxLength="64" /></td>
		      <td align="right">客户名称</td>
            <td align="left"><input type="text" class="text_field"
                id="customer_name" name="customer_name" inputName="客户名称" maxLength="50" /></td>
            <td align="right"></td>
		</tr>
		<tr>
			<td />
			<td />
			<td />
			<td><input name="button_ok" class="icon_1" type="button"
				value='<fmt:message key="query"/>'
				onClick="javascript:simpleQuery1_onClick()"> <input
				name="button_reset" class="icon_1" type="button"
				value='<fmt:message key="reset"/>'
				onClick="javascript:this.form.reset()"></td>
			<td />
		</tr>
	</table>
	</div>





	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="g"><a onClick="javascript: choose();"><fmt:message
			key="choice" /> </a></li>

	</ul>

	</div>
	<div class="clear"></div>
	</div>
<input type="hidden" id="contractid" name="contractid"/>
<input type="hidden" id="contractname" name="contractname"/>
<input type="hidden" id="customerid" name="customerid"/>
<input type="hidden" id="customername" name="customername"/>
<input type="hidden" id="customercode" name="customercode"/>
<input type="hidden" id="companyid" name="companyid"/>
<r:datacell 
        id="datacell1"
       queryAction="/FAERP/SalcontractAction.do?cmd=simpleQuery1"
        width="100%" height="319px"
        xpath="SalcontractVo"
        submitXpath="SalcontractVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <!-- 
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       <h:hidden />
        -->
       <r:field fieldName="contract_code" width="110px" label="合同编号">
       </r:field>    
       <r:field fieldName="contract_name" width="150px" label="合同名称">
       </r:field>  
       <r:field fieldName="customer_code" width="70px" label="客户编号">
       </r:field>  
       <!--
       <r:field fieldName="customer_id" width="150px" label="客户ID">
       </r:field>  
       -->
       <r:field fieldName="customer_name" width="150px" label="合同甲方">
       </r:field>  
       <r:field fieldName="contract_start_date" width="90px" label="合同起始日期"  allowModify="false">
       <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>  
       <r:field fieldName="contract_stop_date" width="90px" label="合同终止日期"  allowModify="false">
       <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>  
       <r:field fieldName="contract_type_bd" width="100px" label="合同类型">
       <d:select dictTypeId="CONTRACT_TYPE_BD" />
       </r:field>  
    </r:datacell>
	</div>
	</form>
</fmt:bundle>
<script language="javascript">

    $id("datacell1").isQueryFirst = false;// 
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	
	$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    choose();
}
</script>
</body>
</html>
