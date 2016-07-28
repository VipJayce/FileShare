<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="java.util.List"%>
<%@ page import="rayoo.sales.pbcustomerservice.vo.PbcustomerserviceVo"%>
<%@ page
	import="rayoo.sales.pbcustomerservice.util.IPbcustomerserviceConstants"%>
<%String  servicecompany=request.getAttribute("servicecompany")==null?"":request.getAttribute("servicecompany").toString(); 
System.out.println("@@@@@@@@@@@@@@@@@"+servicecompany);
%>
<html>
<fmt:bundle basename="rayoo.salse.pbcustomerservice.pbcustomerservice_resource" prefix="rayoo.salse.pbcustomerservice.">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>codegen</title>
		</head>
	<body>

	<form name="form" method="post" action="<%=request.getContextPath()%>/PbcustomerserviceAction.do">
	<input type="hidden" name="cmd" value="queryAll">
	<input type="hidden" id="mid" name="mid" value="${mid }">
	
    <%   String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();%>
   <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >


	<div id="right">
	<script language="javascript">
	    writeTableTopFesco('<fmt:message key="allot_review"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	<div class="ringht_s">
		<div id="ccChild0" class="search">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			</table>
		</div>
	    <div style="margin-left: 10px;">
				<r:datacell id="celllist1"
				queryAction="/FAERP/PbcustomerserviceAction.do?cmd=simpleQuery&queryCondition=${requestScope.queryCondition}"
				paramFormId="form" width="99%" height="200px"
				xpath="SalcontractVo" readonly="true">
				<r:field fieldName="customer_name" messagekey="customer_name" width="180px">
			        <h:text />
			    </r:field>
				<r:field fieldName="contract_code" messagekey="contract_code" width="120px">
					<h:text />
				</r:field>
				<r:field fieldName="contract_name" messagekey="contract_name" width="230px">
					<h:text />
				</r:field>
				<r:field fieldName="contract_start_date" messagekey="contract_start_date" width="90px">
					<w:date format="yyyy-MM-dd"/>
				</r:field>
				<r:field fieldName="str" messagekey="str_status" width="120px">
					<h:text />
				</r:field>
				<r:field fieldName="create_type_bd" messagekey="create_type" width="70px">
			        <d:select dictTypeId="CREATE_TYPE_BD"></d:select>
				</r:field>
				<r:field fieldName="contract_type_bd" messagekey="contract_type" width="100px">
			        <d:select dictTypeId="CONTRACT_TYPE_BD"></d:select>
				</r:field>
				<r:field fieldName="create_user_name" messagekey="create_user_name" width="100px">
					<h:text />
				</r:field>
				<r:field fieldName="create_date" messagekey="create_date" width="180px">
					<h:text />
				</r:field>
				</r:datacell>
		</div>
	</div>
	<div class="xz_title" style="margin: 10px;"><fmt:message key="allot_person"/> </div>
		<div id="dbdiv" style="display: none;">
		       <!-- 客服分配经办人 -->
		        <!-- 派单客服 -->
		        <div style="display: none" id="pdkf">
		            <div class="box_tab" style="margin: 10px;">
		                    <table width="98%" height="40" border="0" cellpadding="0"
		                        cellspacing="1" bgcolor="#c5dbe2">
		                        <tr>
		                            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="pdkf"/></td>
		                            <td width="220">
		                             <r:comboSelect id="pdkfVal" name="pdkfVal"
		                               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getJingBanRenForHZ&flag=${flag}&type=pdkf"
		                                textField="name"
		                                valueField="partyid"
		                                xpath="Partyrelation"
		                                width="180" messagekey="please_choose"
		                                onChangeFunc="pushSelectName"
		                                >
		                            </r:comboSelect>
		                            <input type="hidden" id="pdkfVal_name" name="pdkfVal_name" value="">
		                            </td>
		                        </tr>
		                    </table>
		            </div>
		        </div>
		        
		        <!-- 接单客服 -->
		        <div style="display: none" id="jdkf">
		            <div class="box_tab" style="margin: 10px;">
		                    <table width="98%" height="40" border="0" cellpadding="0"
		                        cellspacing="1" bgcolor="#c5dbe2">
		                        <tr>
		                            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="jdkf"/></td>
		                            <td width="220">
		                             <r:comboSelect id="jdkfVal" name="jdkfVal"
		                               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getJingBanRenForHZ&flag=${flag}&type=jdkf"
		                                textField="name"
		                                valueField="partyid"
		                                xpath="Partyrelation"
		                                width="180" messagekey="please_choose"
		                                onChangeFunc="pushSelectName"
		                                >
		                            </r:comboSelect>
		                            <input type="hidden" id="jdkfVal_name" name="jdkfVal_name" value="">
		                            </td>
		                        </tr>
		                    </table>
		            </div>
		        </div>
		        
		        <!-- 员工关系专员 -->
		        <div style="display: none" id="yggxzy">
		            <div class="box_tab" style="margin: 10px;">
		                    <table width="98%" height="40" border="0" cellpadding="0"
		                        cellspacing="1" bgcolor="#c5dbe2">
		                        <tr>
		                            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="employee_relations_person"/></td>
		                            <td width="220">
		                             <r:comboSelect id="yggxzyVal" name="yggxzyVal"
		                               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getJingBanRenForHZ&flag=${flag}&type=yggxzy"
		                                textField="name"
		                                valueField="partyid"
		                                xpath="Partyrelation"
		                                width="180" messagekey="please_choose"
		                                onChangeFunc="pushSelectName"
		                                >
		                            </r:comboSelect>
		                            <input type="hidden" id="yggxzyVal_name"  name="yggxzyVal_name" value="">
		                            </td>
		                        </tr>
		                    </table>
		            </div>
		        </div>
		     
		        <!-- 运行部分配经办人 -->
		        <!-- 社保专员 -->
		        <div style="display: none" id="sbzy">
		            <div class="box_tab" style="margin: 10px;">
		                    <table width="98%" height="40" border="0" cellpadding="0"
		                        cellspacing="1" bgcolor="#c5dbe2">
		                        <tr>
		                            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="sbzy"/></td>
		                            <td width="220">
		                             <r:comboSelect id="sbzyVal" name="sbzyVal"
		                               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getJingBanRenForHZ&flag=${flag}&type=sbzy"
		                                textField="name"
		                                valueField="partyid"
		                                xpath="Partyrelation"
		                                width="180" messagekey="please_choose"
		                                onChangeFunc="pushSelectName"
		                                >
		                            </r:comboSelect>
		                            <input type="hidden" id="sbzyVal_name"  name="sbzyVal_name" value="">
		                            </td>
		                        </tr>
		                    </table>
		            </div>
		        </div>
		        
		        <!-- 公积金专员 -->
		        <div style="display: none" id="gjjzy">
		            <div class="box_tab" style="margin: 10px;">
		                    <table width="98%" height="40" border="0" cellpadding="0"
		                        cellspacing="1" bgcolor="#c5dbe2">
		                        <tr>
		                            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="gjjzy"/></td>
		                            <td width="220">
		                             <r:comboSelect id="gjjzyVal" name="gjjzyVal"
		                               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getJingBanRenForHZ&flag=${flag}&type=gjjzy"
		                                textField="name"
		                                valueField="partyid"
		                                xpath="Partyrelation"
		                                width="180" messagekey="please_choose"
		                                onChangeFunc="pushSelectName"
		                                >
		                            </r:comboSelect>
		                            <input type="hidden" id="gjjzyVal_name"  name="gjjzyVal_name" value="">
		                            </td>
		                        </tr>
		                    </table>
		            </div>
		        </div>
		    
		        <!-- 档案专员 -->
		        <div style="display: none" id="dazy">
		            <div class="box_tab" style="margin: 10px;">
		                    <table width="98%" height="40" border="0" cellpadding="0"
		                        cellspacing="1" bgcolor="#c5dbe2">
		                        <tr>
		                            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="dazy"/></td>
		                            <td width="220">
		                             <r:comboSelect id="dazyVal" name="dazyVal"
		                               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getJingBanRenForHZ&flag=${flag}&type=dazy"
		                                textField="name"
		                                valueField="partyid"
		                                xpath="Partyrelation"
		                                width="180" messagekey="please_choose"
		                                onChangeFunc="pushSelectName"
		                                >
		                            </r:comboSelect>
		                            <input type="hidden" id="dazyVal_name"  name="dazyVal_name" value="">
		                            </td>
		                        </tr>
		                    </table>
		            </div>
		        </div>
		</div>
		<div id="ybdiv" style="display: none;">
	          <!-- 派单客服 -->
	          <c:if test="${pdkfName != ''}">
		          <div style="display: none" id="pdkf_done">
		              <div class="box_tab" style="margin: 10px;">
		                      <table width="98%" height="40" border="0" cellpadding="0"
		                          cellspacing="1" bgcolor="#c5dbe2">
		                          <tr>
		                              <td class="td_1"><fmt:message key="pdkf"/></td>
		                              <td width="220">
		                              <input type="text" name="pdkfName" value="${pdkfName }">
		                              </td>
		                          </tr>
		                      </table>
		              </div>
		          </div>
	          </c:if>
	          <!-- 接单客服 -->
	          <c:if test="${jdkfName != ''}">
	               <div style="display: none" id="jdkf_done">
	                  <div class="box_tab" style="margin: 10px;">
	                          <table width="98%" height="40" border="0" cellpadding="0"
	                              cellspacing="1" bgcolor="#c5dbe2">
	                              <tr>
	                                  <td class="td_1"><fmt:message key="jdkf"/></td>
	                                  <td width="220">
	                                  <input type="text" name="jdkfName" value="${jdkfName }">
	                                  </td>
	                              </tr>
	                          </table>
	                  </div>
	              </div>
	          </c:if>
	          
	          <!-- 员工关系专员 -->
	          <c:if test="${yggxzyName != ''}">
		          <div style="display: none" id="yggxzy_done">
		              <div class="box_tab" style="margin: 10px;">
		                      <table width="98%" height="40" border="0" cellpadding="0"
		                          cellspacing="1" bgcolor="#c5dbe2">
		                          <tr>
		                              <td class="td_1"><fmt:message key="employee_relations_person"/></td>
		                              <td width="220">
		                              <input type="text" name="yggxzyName" value="${yggxzyName }">
		                              </td>
		                          </tr>
		                      </table>
		              </div>
		          </div>
	          </c:if>
	          
	          <!-- 运行部分配经办人 -->
	          <!-- 社保专员 -->
	          <c:if test="${sbzyName != ''}">
		          <div style="display: none" id="sbzy_done">
		              <div class="box_tab" style="margin: 10px;">
		                      <table width="98%" height="40" border="0" cellpadding="0"
		                          cellspacing="1" bgcolor="#c5dbe2">
		                          <tr>
		                              <td class="td_1"><fmt:message key="sbzy"/></td>
		                              <td width="220">
		                              <input type="text" name="sbzyName" value="${sbzyName }">
		                              </td>
		                          </tr>
		                      </table>
		              </div>
		          </div>
	          </c:if>
	          
	          <!-- 公积金专员 -->
	          <c:if test="${gjjzyName != ''}">
		          <div style="display: none" id="gjjzy_done">
		              <div class="box_tab" style="margin: 10px;">
		                      <table width="98%" height="40" border="0" cellpadding="0"
		                          cellspacing="1" bgcolor="#c5dbe2">
		                          <tr>
		                              <td class="td_1"><fmt:message key="gjjzy"/></td>
		                              <td width="220">
		                              <input type="text" name="gjjzyName" value="${gjjzyName }">
		                              </td>
		                          </tr>
		                      </table>
		              </div>
		          </div>
	          </c:if>
	          
	          <!-- 档案专员 -->
	          <c:if test="${dazyName != ''}">
		          <div style="display: none" id="dazy_done">
		              <div class="box_tab" style="margin: 10px;">
		                      <table width="98%" height="40" border="0" cellpadding="0"
		                          cellspacing="1" bgcolor="#c5dbe2">
		                          <tr>
		                              <td class="td_1"><fmt:message key="dazy"/></td>
		                              <td width="220">
		                              <input type="text" name="dazyName" value="${dazyName }">
		                              </td>
		                          </tr>
		                      </table>
		              </div>
		          </div>
	          </c:if>
	    </div>
    </div>
    <div class="foot_button">
	    <c:if test="${done=='false'}">
	       <input type="button" class="foot_icon_1" value="<fmt:message key="save"/>" onclick="sendSubmit()" />
	    </c:if>
        <input type="button" class="foot_icon_1" value="返回" onclick="back();" />
    </div>
    </form>
</fmt:bundle>
</body>
</html>

<script language="javascript">

    <%  //表单回写
    if(request.getAttribute(IPbcustomerserviceConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPbcustomerserviceConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
    %>
    
    var flag = "${flag}";
    var done = "${done}";
    var apprstate = "${apprstate}";
    var servicecompany="{servicecompany}";
    
    var pdkfDoneObj = document.getElementById("pdkf_done");
    var jdkfDoneObj = document.getElementById("jdkf_done");
    var yggxzyDoneObj = document.getElementById("yggxzy_done");
    var sbzyDoneObj = document.getElementById("sbzy_done");
    var gjjzyDoneObj = document.getElementById("gjjzy_done");
    var dazyDoneObj = document.getElementById("dazy_done");
    
    if(done == "true"){
		document.getElementById("ybdiv").style.display="block";
		
		if(flag == '00'){
			if(pdkfDoneObj != null){
	          document.getElementById("pdkf_done").style.display="block";
	        }
	        if(jdkfDoneObj != null){
	          document.getElementById("jdkf_done").style.display="block";
	        }
	        if(yggxzyDoneObj != null){
	          document.getElementById("yggxzy_done").style.display="block";
	        }
	        if(sbzyDoneObj != null){
	          document.getElementById("sbzy_done").style.display="block";
	        }
	        if(gjjzyDoneObj != null){
	          document.getElementById("gjjzy_done").style.display="block";
	        }
	        if(dazyDoneObj != null){
	          document.getElementById("dazy_done").style.display="block";
	        }
        }else{
            if(flag == '01'){
	            if(pdkfDoneObj != null){
	              document.getElementById("pdkf_done").style.display="block";
	            }
	            if(jdkfDoneObj != null){
	              document.getElementById("jdkf_done").style.display="block";
	            }
	            if(yggxzyDoneObj != null){
	              document.getElementById("yggxzy_done").style.display="block";
	            }
	        }
	     
	        if(flag == '02'){
	            if(sbzyDoneObj != null){
	              document.getElementById("sbzy_done").style.display="block";
	            }
	            if(gjjzyDoneObj != null){
	              document.getElementById("gjjzy_done").style.display="block";
	            }
	            if(dazyDoneObj != null){
	              document.getElementById("dazy_done").style.display="block";
	            }
	        }
        }
		
    }else{
        document.getElementById("dbdiv").style.display="block";
        if(flag == '01'){
            document.getElementById("pdkf").style.display="block";
            document.getElementById("jdkf").style.display="block";
            document.getElementById("yggxzy").style.display="block";
        }
     
        if(flag == '02'){
            document.getElementById("sbzy").style.display="block";
            document.getElementById("gjjzy").style.display="block";
            document.getElementById("dazy").style.display="block";
        }
    }
    
 
     //提交按钮
      function sendSubmit(){
        var datacellObj = $id("celllist1");
        var datacellEntity = datacellObj.getEntity(0);
        var customerID = datacellEntity.getProperty("customer_id");
        if(checkData()){
            form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?customerID="+customerID+"&flag=${flag}";
	        form.cmd.value = "submitHZ";
	        form.submit();
        }
      }
     
      
     function pushSelectName(slt,sltObj){
         var name = sltObj.id + "_name";
         document.getElementById(name).value = sltObj.getText();
     }
     
     function back(){
         form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done="+done;
         form.submit();
     }

    function checkData(){
        var result = true;
        if(flag == "01"){
            var pdkf = document.getElementById("pdkfVal_name").value;
	        var jdkf = document.getElementById("jdkfVal_name").value;
	        var yggxzy = document.getElementById("yggxzyVal_name").value;
	        if(pdkf == "" || pdkf == null || pdkf == "null"){
	           alert("请选择派单客服！");
	           result = false;
	           return;
	        }
	        if(jdkf == "" || jdkf == null || jdkf == "null"){
               alert("请选择接单客服！");
               result = false;
               return;
            }
            if(yggxzy == "" || yggxzy == null || yggxzy == "null"){
               alert("请选择员工关系专员！");
               result = false;
               return;
            }
        }
        if(flag == "02"){
            var sbzy = document.getElementById("sbzyVal_name").value;
	        var gjjzy = document.getElementById("gjjzyVal_name").value;
	        var dazy = document.getElementById("dazyVal_name").value;
	        if(sbzy == "" || sbzy == null || sbzy == "null"){
               alert("请选择派社保专员！");
               result = false;
               return;
            }
            if(gjjzy == "" || gjjzy == null || gjjzy == "null"){
               alert("请选择公积金专员！");
               result = false;
               return;
            }
            if(dazy == "" || dazy == null || dazy == "null"){
               alert("请选择档案专员！");
               result = false;
               return;
            }
        }
        return result;
    }
</script>
