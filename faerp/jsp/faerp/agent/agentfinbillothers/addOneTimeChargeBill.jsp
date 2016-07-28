<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datacell</title>
<script language="javascript">
	var obj = window.dialogArguments;
	function setCheckboxStatus(value,entity,rowNo,cellNo){
	   return "<input type='radio'  name='checkbox_template' id='checkbox_template' >";
	}
	 
   	function toAdd_onClick() {
       $id("datacell2").addRow();
   	}
    
    function deleteMulti_onClick(){
     	$id("datacell2").deleteRow();
    }
    function toSave_onClick() { 
        var customer_id = obj[0];
        var cost_center_id = obj[1];
        var billyearmonth = obj[2];
        var  agent_id = obj[3] ;
        if($id("datacell2").isModefied){
	        $id("datacell2").addParam("customer_id",customer_id); 
	        $id("datacell2").addParam("cost_center_id",cost_center_id ); 
	        $id("datacell2").addParam("billyearmonth",billyearmonth );
	        $id("datacell2").addParam("agent_id",agent_id );
	        if($id("datacell2").submit()){
	            alert("保存成功！");
	           	window.close();
	        }else{
	        	alert("保存失败！");
	        }
        }
    }
     
</script>
</head>
<body>
<div id="right">
	<script language="javascript">
		writeTableTopFesco('一次性收费','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
 
<div class="button_right">
      
       <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAdd_onClick();">
       <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMulti_onClick();">
       <input class="bc" type="button"   value="保存"    onClick="toSave_onClick();">
 </div>
 <div class="clear"></div>
     
<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell2"
        paramFormId="datacell_formid"
        submitAction="/FAERP/AgentfinbillothersAction.do?cmd=saveAgentBillAndOneTimeCharge"
        width="99%"
        height="304px"
        xpath="BillOthersVo"
        submitXpath="BillOthersVo"
        pageSize="-1"
        >
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>
      <r:field fieldName="charge_item_bd" label="项目名称" width="200px">
        <d:select dictTypeId="CHARGE_ITEM_BD" extAttr="validateAttr='allowNull=false'" />
      </r:field>
      <r:field fieldName="amount" label="金额" width="180px" allowModify="false">
        <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
      </r:field>
      <r:field fieldName="charge_desc" label="备注" width="300px">
        <h:text/>
      </r:field>
      <r:field fieldName="last_update_date" label="修改日期" allowModify="false" width="180px">
       <w:date format="yyyy-MM-dd"/>
      </r:field>
    </r:datacell>
</div>  
</div>
</form>
</fmt:bundle>
</body>
</html>

