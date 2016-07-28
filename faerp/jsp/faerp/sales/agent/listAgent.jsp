<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<html>
<fmt:bundle basename="rayoo.salse.agent.agent_resource" prefix="rayoo.salse.agent.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	
	 function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
     }
    
    function ClickRow(value){
        $id("agentId").value = value;
    }
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
         $id("datacell1").refresh();
  	}
  	
    function toAdd_onClick() {  //到增加记录页面
        var url="<%=request.getContextPath()%>/AgentAction.do?cmd=getAgentCode";
        window.open(url,'','height=400px,width=950,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增异地代理商');
        //showModalCenter('<%=request.getContextPath()%>/AgentAction.do?cmd=getAgentCode',window,refesh,950,400,"新增异地代理商");
    }
    
    function detail_onClick(){  //实现转到详细页面
        var ids = document.form.agentId.value;
        if(ids == null || ids == ""){
          alert("<fmt:message key='select_one_record'/>");
          return;
        }
        var url="<%=request.getContextPath()%>/AgentAction.do?cmd=detail&id="+ids;
         window.open(url,'','height=400px,width=950,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=异地代理商详细页面');
       // showModalCenter('<%=request.getContextPath()%>/AgentAction.do?cmd=detail&id='+ids,window,'',950,400,"异地代理商详细页面");
    }
  	
	function findCheckbox_onClick() {//修改页面
		var ids = document.form.agentId.value;
		if(ids == null || ids == ""){
		  alert("<fmt:message key='select_one_record'/>");
		  return;
		}
		var url="<%=request.getContextPath()%>/AgentAction.do?cmd=find&id="+ids;
		window.open(url,'','height=400px,width=950,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改异地代理商');
		//showModalCenter('<%=request.getContextPath()%>/AgentAction.do?cmd=find&id='+ids,window,refesh,950,400,"修改异地代理商");
	}
	
	function refesh(ref){
	   $id("datacell1").loadData();
       $id("datacell1").refresh();
	}
	
	function deleteMulti_onClick(){//删除
 		var ids = document.form.agentId.value;
        if(ids == null || ids == ""){
          alert("<fmt:message key='select_one_record'/>");
          return;
        }
         //校验该报价单是否已提交审批或是否已审批完成
        var wfname="AgentDeleteWorkFlow";//此业务对应报价单审批名称
        //检查此单据是否正在走流程
		  WfCommonAjax.checkCurrentWf(wfname,ids,function(reData){
	    if(reData=="0"){
	        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	        	showModalCenter('<%=request.getContextPath()%>/jsp/faerp/sales/agent/confirmMsg.jsp?',document,refesh,300,240,"删除原因");
	        } 
	    }else{
	        alert("<fmt:message key='delete_procedures'/>");
	        	return;
	        }
	    });
	}

</script>
	</head>
	<body>

	<form name="form" method="post" id="agentFormId">
	<input type="hidden" id="agentId" name="agentId" value="">

	<div id="right"><script language="javascript">
	writeTableTopFesco('<fmt:message key='agent_message'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">

	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="175" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key='query_conditions'/></div>
			</td>
		</tr>
		<tr>
			<!--  <td height="59" align="right">
			     <p><fmt:message key='city_id'/>&nbsp;&nbsp;</p>
			</td>-->
			<%--<td align="left">
			     <r:comboSelect id="city_idList_search" name="city_id1" queryAction="PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" xpath="PB_CITYVo"  width="200px" messagekey="please_choose" />
			</td>  --%>
			
			<td align="right">
			     <p><fmt:message key='agent_name'/>&nbsp;&nbsp;</p>
			</td>
			<td align="left">
			     <input type="text" class="text_field" name="agent_name1" inputName="供应商名称" value="" maxLength="50"  /> 
			     <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
			     <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
			 </td>
		</tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
	<!-- 
	<ul>
        <li class="a"><a onClick="javascript:detail_onClick();"  <au:authorityBtn code="agent_view" type="1"/> > <fmt:message   key="view"  /> </a></li>
        <li class="b"><a onClick="javascript:findCheckbox_onClick();"  <au:authorityBtn code="agent_modify" type="1"/> > <fmt:message   key="modify" /> </a></li>
        <li class="c"><a onClick="javascript:toAdd_onClick();"  <au:authorityBtn code="agent_add" type="1"/> > <fmt:message key="insert" /> </a></li>
        <li class="d"><a onClick="javascript:deleteMulti_onClick();"  <au:authorityBtn code="agent_del" type="1"/> > <fmt:message   key="delete" /> </a></li>
    </ul>
	 -->	
		
		<input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="agent_view" type="1"/>  onClick="detail_onClick();">
		<input class="b"  type="button"   value="<fmt:message key="modify"/>"   <au:authorityBtn code="agent_modify" type="1"/> onClick="findCheckbox_onClick();">
		<input class="c"  type="button"   value="<fmt:message key="insert"/>"   <au:authorityBtn code="agent_add" type="1"/> onClick="toAdd_onClick();">
		<input class="d"  type="button"   value="<fmt:message key="delete"/>"   <au:authorityBtn code="agent_del" type="1"/> onClick="deleteMulti_onClick();">
		

	</div>
	<div class="clear"></div>
	</div>
	
	<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/AgentAction.do?cmd=searchAgentData"
        width="98%"
        height="320px"
        xpath="AgentVo"
        paramFormId="agentFormId"
        readonly="true"
        >

	      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	       <r:field fieldName="emp"   messagekey="operation"  width="50px" onRefreshFunc="setCheckboxStatus" align="center">
	      </r:field>
	      <r:field fieldName="agent_code" messagekey="agent_code">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="agent_name" messagekey="agent_name">
	           <h:text/>   
	       </r:field>    
	      <r:field fieldName="agent_en_name" messagekey="agent_en_name">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="agent_type" messagekey="agent_type">
	           <d:select dictTypeId="AGENT_TYPE"/>
	       </r:field>
	       <%--
	        <r:field fieldName="city_id" messagekey="city_id" width="100px">
	            <r:comboSelect id="countryList" name="city_id"
	                 queryAction="PB_CITYAction.do?cmd=getListData"
	                 textField="city_name"
	                 valueField="id"
	                 xpath="PB_CITYVo"
	                 width="150px"/>
	       </r:field>   --%>
	       <r:field fieldName="corporation" messagekey="corporation">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="tax_registration_number" messagekey="tax_registration_number">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="contact_dept" messagekey="contact_dept">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="contact_person" messagekey="contact_person">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="contact_tel1" messagekey="contact_tel1">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="contact_tel2" messagekey="contact_tel2">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="email" label="EMAIL">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="fax" messagekey="fax">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="contact_address" messagekey="contact_address">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="zip_code" messagekey="zip_code">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="reckoning_address1" messagekey="reckoning_address1">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="reckoning_zip_code1" messagekey="reckoning_address_code1">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="reckoning_address2" messagekey="reckoning_address2">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="reckoning_zip_code2" messagekey="reckoning_address_code2">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="bank1" messagekey="bank1">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="bank_account1" messagekey="bank_account1">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="bank2" messagekey="bank2">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="bank_account2" messagekey="bank_account2">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="del_approval_state" messagekey="delete_examine_status">
	      	<d:select dictTypeId="AGENT_DEL_STATE"></d:select>
	      </r:field>
    </r:datacell>
    </div>

	</div>
	</div>
	</form>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">
//初始化不加载页面信息<siqp添加>
_$(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
