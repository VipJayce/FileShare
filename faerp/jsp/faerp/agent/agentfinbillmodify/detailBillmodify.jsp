<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper" %>
<script language="javascript" src="<venus:base/>/jsp/faerp/agent/agentfinbillmodify/billmodifypage.js"></script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>账单明细修改</title>
	
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
    <script language="javascript">
        function exportEXCEL_onClick(){
	        //导数据前先提交当前页面修改数据
	         var isupdate = $id("isupdate").value ;
                if(isupdate == "yes"){
                    var xmlSubmit = $id("datacell2").dataset.toString();
		            var myAjax = new Ajax("/FAERP/AgentfinbillmodifyAction.do?cmd=updateAgentFinbillModify");
		            myAjax.addParam('bill_id', $id("bill_id").value);
		            myAjax.addParam('agent_bill_modify_id', $id("agent_bill_modify_id").value);
		            myAjax.loadData(xmlSubmit);
		            var returnNode = myAjax.getResponseXMLDom();
                }
            //导出数据
	        var bill_id = $id("agent_bill_modify_id").value;
	        var cost_center_name = document.form.cost_center_name.value;
	        var bill_year_month = document.form.bill_year_month.value;
	        var bill_code = document.form.bill_code.value;
	        var login_name = document.form.login_name.value;
	        if(bill_id != null && bill_id !=""){
	            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillModifyReport.jsp?raq=agent_bill_modify_new.raq&arg1="+bill_id+"&arg2="+cost_center_name+"&arg3="+bill_year_month+"&arg4="+bill_code+"&arg5="+login_name;
	            $id("datacell_formid").submit();
	        }else{
	           alert("数据异常，请联系管理员！");
	           return;
	        }
	    }
	    //查询
	    function select_onClick(){
	        //var isbuttonselect = $id("isbuttonselect").value ;
	        //判断是否是第一次查询
	       // if(isbuttonselect == null||isbuttonselect==""){
	       //    $id("datacell2").reload() ;
	       // }else{
	            var isupdate = $id("isupdate").value ;
	            if(isupdate == "yes"){
	               var xmlSubmit = $id("datacell2").dataset.toString();
	                var myAjax = new Ajax("/FAERP/AgentfinbillmodifyAction.do?cmd=updateAgentFinbillModify");
	                myAjax.addParam('bill_id', $id("bill_id").value);
	                myAjax.addParam('agent_bill_modify_id', $id("agent_bill_modify_id").value);
	                myAjax.loadData(xmlSubmit);
	                var returnNode = myAjax.getResponseXMLDom();
	            }
	            $id("datacell2").reload() ;
	       // }
	       //$id("isbuttonselect").value = "yes" ;
	    }
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<!--<script language="javascript">
   writeTableTopFesco('账单明细修改','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
--><div class="ringht_s">
	<div style="padding-top:10px; text-align:center;" class="xz_title">${billVo.cost_center_name }${fn:substring(billVo.bill_year_month, 0, 4) }年${fn:substring(billVo.bill_year_month, 4, 6) }月应付明细</div>
     <table width="100%">
            <tr>
                <td align="center">员工姓名/唯一号:&nbsp;&nbsp;<input type="text" name="empnameorcode" id="empnameorcode" /></td>
                <td align="left"><input name="button1" type="button" class="icon_1" onclick="javascript:select_onClick();"  value="查 询" /></td>
                <td align="left"><input name="button2" type="button" class="icon_1" onclick="javascript:exportEXCEL_onClick();"  value="导出excel" /></td>
                <td ><li style="font-size:12px; font-weight:inherit; width:200px; margin-left:50%;">账单号：${billVo.bill_code }</li></td>
                <td align="right" ><li>账单总额：</li></td>
                <td align="left" id="tdid" ><li>${billVo.bill_amount}</li></td>
            </tr>
     
     </table>
     
    <input type="hidden" value="${billVo.cost_center_name }" name="cost_center_name"/>
    <input type="hidden" value="${billVo.bill_year_month }" name="bill_year_month"/>
    <input type="hidden" value="${billVo.bill_code }" name="bill_code"/>
    <input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
    <input type="hidden" value="${billVo.id }" name="bill_id" id="bill_id"/>
    <input type="hidden" value="${requestScope.agent_bill_modify_id }" name="agent_bill_modify_id" id="agent_bill_modify_id"/>
    <input type="hidden" value="${billVo.bill_amount }" name="totalamount" id="totalamount"/>
    <input type="hidden" name="isbuttonselect" id="isbuttonselect"/>
    <input type="hidden" name="isupdate" id="isupdate"/>
    <!-- /FAERP/BillmodifyAction.do?cmd=getItemBybillid4DataCell -->
	<div style="padding: 0 0 8 8;">
	        <r:datacell pageSize="51"
	        id="datacell2"
	        paramFormId="datacell_formid"
	        queryAction=""
	        submitAction=""
	        width="98%"
	        height="304px"
	        xpath="/root/data/itemVo"
	        submitXpath="itemVo"
	        freezeNumber="4"
	        >
	        <r:toolbar location="bottom" tools="nav,pagesize,info" />
	        <r:field fieldName="sno" label="编号"></r:field>
	        <r:field fieldName="emp_name" label="姓名"></r:field>
	        <r:field fieldName="emp_code" label="唯一号"></r:field>
	        <r:field fieldName="service_year_month" label="服务年月"></r:field>
	        
	        <logic:iterate name="titleList" id="smalltitles" scope="request" indexId="indexs">
	           <c:choose>
	               <c:when test="${smalltitles[0] == 1 }">
	                   <logic:iterate name="smalltitles" id="title" scope="page">
						  <c:choose>
						    <c:when test="${fn:contains(title, '_city') }">
						        <r:field fieldName="${title }" label="城市" groupval="${smalltitles[8] }" allowModify="true">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_base') }">
						        <r:field fieldName="${title }" label="基数" groupval="${smalltitles[8] }" allowModify="true">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_amount') }">
						    
						      <r:field fieldName="${title }" label="总额" groupval="${smalltitles[8] }" allowModify="true">
						          <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
						      </r:field>
						      
						    </c:when>
						    <c:when test="${fn:contains(title, '_eratio') }">
						       <r:field fieldName="${title }" label="单位比例" groupval="${smalltitles[8] }" allowModify="true">
						          <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
						       </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_emoney') }">
						        <r:field fieldName="${title }" label="单位金额" groupval="${smalltitles[8] }" allowModify="true">
						          <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_pratio') }">
						        <r:field fieldName="${title }" label="个人比例" groupval="${smalltitles[8] }" allowModify="true">
						          <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_pmoney') }">
						        <r:field fieldName="${title }" label="个人金额" groupval="${smalltitles[8] }" allowModify="true">
						          <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
						        </r:field>
						    </c:when>
						  </c:choose>
					   </logic:iterate>
	               </c:when>
	               <c:otherwise>
                       <r:field fieldName="${smalltitles[1] }" label="${fn:substring(smalltitles[2], 4, fn:length(smalltitles[2]))}" allowModify="true">
                        <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
                       </r:field>
	               </c:otherwise>
	           </c:choose>
            </logic:iterate>
            <r:field fieldName="rightsum" label="合计">
                <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field>
	    </r:datacell>
	</div>
    <table width="100%">
        <tr>
           <td width="50%">
                <div class="xz_title" style="margin-top:10px;width: 92%">一次收费项目表</div>
                    <r:datacell id="celllist1"
                    queryAction="/FAERP/AgentfinbillmodifyAction.do?cmd=queryAgentBillOther&bill_id=${billVo.id}"
                    paramFormId="datacell_formid" width="90%" height="150px"
                    xpath="AgentfinbillothersVo" readonly="true">
                    
                    <r:field fieldName="charge_item_bd" label="项目名称" width="145px">
                        <d:select dictTypeId="CHARGE_ITEM_BD"/>
                    </r:field>
                    <r:field fieldName="amount" label="金额" width="110px">
                    </r:field>
                    <r:field fieldName="charge_desc" label="备注" width="160px">
                        <h:text />
                    </r:field>
                    <r:field fieldName="last_update_date" label="时间" width="120px">
                        <w:date format="yyyy-MM-dd"/>
                    </r:field>
                </r:datacell>
           </td>
           <td width="40%" align="left">
                    <div class="xz_title" style="margin-top:10px;width: 98%">备注</div>
                    <div class="ringht_s">
					    <textarea rows="8" cols="63" id="applymsg" name="apply" onkeyup="countChar();"></textarea>
					</div>
					还可输入<span id="surplus">4000</span>字符
           </td>
        </tr>
    </table>
			
			
		</div>
	 <div class="foot_button">
       <input type="button" value="提交审核" class="foot_icon_2" onclick="modifysub();">
       <input type="button" onclick="closewin();" value="关闭窗口" class="foot_icon_1">
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
