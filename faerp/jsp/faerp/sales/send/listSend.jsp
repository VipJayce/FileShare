<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.send.vo.SendVo" %>
<%@ page import="rayoo.sales.send.util.ISendConstants" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<jsp:useBean id="sendAction" class="rayoo.sales.send.action.SendAction" scope="page" />
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ISendConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ISendConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    SendVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.salse.send.send_resource" prefix="rayoo.salse.send.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache"/> 
<title><fmt:message key="send_table"/></title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    function findCheckbox_onClick() {  //从多选框到修改页面
        var entity=choose_row_public("celllist1");
        if(entity!=undefined){
        var temp_id=entity.getProperty("id");
     /* var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        form.action="<%=request.getContextPath()%>/SendAction.do?id=" + temp_id;
        form.cmd.value = "find";
        form.submit();
          if(temp_id == null) {  //如果ids为空
         alert('<fmt:message key="select_one_record"/>');
            return;
          }
               */
       var url="<%=request.getContextPath()%>/SendAction.do?cmd=find&id=" + temp_id;
       url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
       window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改委派单');
       }
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var entity=choose_row_public("celllist1");
        if(entity!=undefined){
            var temp_id=entity.getProperty("id");
        /*  var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
       if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
           return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/SendAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
           if(temp_id == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
           return;
            }
                    */
        //判断订单表中有没有该入离职ID有没有对应的订单
            jQuery.getJSON("<%=request.getContextPath()%>/SendAction.do?cmd=checkrelpost&date="+new Date()+"",{"id":temp_id},  function(text){
                 if(text=='1'){
                     
                        alert("<fmt:message key="send_emp_not_delete"/>");
                     
                 }else{
                    if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
			            var dc = $id("celllist1");
			            dc.isModefied = true;
			            dc.submitAction = "<%=request.getContextPath()%>/SendAction.do?cmd=deleteMulti&ids=" + temp_id;
			            if (dc.submit()) {
			               alert('<fmt:message key="delete_success"/>');
			            } else {
			               alert('<fmt:message key="delete_false"/>');
			            }
		             }
		         }
                    
                 
             });
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        
        //$id("celllist1").addParam("contract_code",$id("contract_code").value);
     	//$id("celllist1").addParam("contract_name",$id("contract_name").value);
     	//$id("celllist1").addParam("contract_type",$id("contract_type").value);
     	//$id("celllist1").addParam("send_code",$id("send_code").value);
     	//$id("celllist1").addParam("send_name",$id("send_name").value);
     	//$id("celllist1").addParam("customer_name",$id("customer_name").value);
     	
        $id("celllist1").loadData();
        $id("celllist1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
      /*form.action="<%=request.getContextPath()%>/SendAction.do";
        form.cmd.value = "findToAdd";
        form.submit();
        */
    var url="<%=request.getContextPath()%>/SendAction.do?cmd=findToAdd";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增委派单');
    }
    function detail_onClick(){  //实现转到详细页面
     var entity=choose_row_public("celllist1");
      if(entity!=undefined){
     var temp_id=entity.getProperty("id");
       /* alert(temp_id);
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
         
        if(temp_id == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
           return;
       }
       */
    var url="<%=request.getContextPath()%>/SendAction.do?cmd=detail&id=" + temp_id;
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    //window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看委派单');
    window.showModalDialog (url,"","location:No;status:No;help:No;dialogWidth:1024px;dialogHeight:600px;scroll:yes;resizable:yes;");
    }
        //form.action="<%=request.getContextPath()%>/SendAction.do?id=" + ids;
      //  form.cmd.value = "detail";
     //   form.submit();
    }

	   //datacell1 checkbox begin
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck(" + rowNo + ",this);'  name='checkbox_template' id='checkbox_template' value='" + entity.getProperty("id") + "'>";
       return returnStr;
    }
    function checkAllList(all){
    	if(all.checked){
	        var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
	                element[i].checked= true;
	            }
	        } 
	    }else{
	    	var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
	                element[i].checked= false;
	            }
	        } 
	    }
    }
    
    function changeCheck(rowNo,box){
    	
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        //jQuery("#h_customer_id").val(arg[0]);        
        return false;
    }
    
  	// end

</script>
</head>
<body>

<form name="form" id="form" method="post" action="<%=request.getContextPath()%>/SendAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true"> 
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="send_manage"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div> </td>
            </tr>
            <tr>

            <td align="left"><fmt:message key="contract_code"/></td>

            <td align="left">

                <input type="text" class="text_field" id="contract_code" name="contract_code" inputName="合同编号" value="" maxLength="19"/>

            </td>

            <td align="left"><fmt:message key="contract_name"/></td>

            <td align="left">

                <input type="text" class="text_field" id="contract_name" name="contract_name" inputName="合同名称" value="" maxLength="50"/>

            </td>

            <td align="left"><fmt:message key="contract_type"/></td>

            <td align="left">
            
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_type", -1,"CONTRACT_TYPE_BD",""," id='contract_type' ",false) %> 

            </td>

            <td align="center"></td>

            </tr>

            <tr>

            <td align="left"><fmt:message key="send_code"/></td>

            <td align="left">

                <input type="text" class="text_field"  id="send_code" name="send_code" inputName="委派单编号" value="" maxLength="19"/>

            </td>

            <td align="left"><fmt:message key="send_name"/></td>

            <td align="left">

                <input type="text" class="text_field" id="send_name" name="send_name" inputName="委派单名称" value="" maxLength="50"/>

            </td>

            <td align="left"><fmt:message key="customer_name"/></td>

            <td align="left">
                <w:lookup name="customer_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
            
            </td>
            </tr>
            <tr>
            
            <td align="left"><fmt:message key="cost_center_name"/></td>

            <td align="left">

                <input type="text" class="text_field" id="cost_center_name" name="cost_center_name" inputName="成本中心名称" value="" maxLength="19"/>

            </td>

            <td align="center"><input name="button_ok"  class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
			<td><input type="reset" class="icon_1" value="重置"></td>
            </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="a">      <a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                </ul>
                
         -->
         <input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="send_view" type="1"/>  onClick="detail_onClick();">
	       <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="send_add" type="1"/>  onClick="toAdd_onClick();">
	       <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="send_del" type="1"/>  onClick="deleteMulti_onClick();">
	       <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="send_modify" type="1"/>  onClick="findCheckbox_onClick();">
         </div>
           <div class="clear"></div>            
</div>
	<r:datacell id="celllist1"
	queryAction="/FAERP/SendAction.do?cmd=simpleQuery"
	paramFormId="form" width="100%" height="320px"
	xpath="SendVo" readonly="true">
	<r:toolbar location="bottom" tools="nav,pagesize,info"/>
	<!--<r:field allowModify="false" fieldName="id" sortAt="none"
		label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
		width="45px" onRefreshFunc="setCheckboxStatus">
	</r:field>
	--><r:field fieldName="customer_code" messagekey="customer_code" width="70px">
		<h:text />
	</r:field>
	<r:field fieldName="customer_name" messagekey="customer_name" width="240px">
		<h:text />
	</r:field>
	<r:field fieldName="contract_type_bd" messagekey="contract_type" width="180px">
        <h:select name="is_account_limit" property="is_account_limit">
                   <h:option value="1" label="劳务派遣协议"></h:option>
                   <h:option value="2"  label="人事委托服务合同"></h:option>
                   <h:option value="3"  label="服务外包合同"></h:option>
                   <h:option value="4" label="体检服务协议"></h:option>
                   <h:option value="5"  label="补充福利"></h:option>
                   <h:option value="6" label="其他"></h:option>
                   <h:option value="7" label="专项外包（劳务）"></h:option>
        </h:select>
    </r:field>
   <r:field fieldName="city_id" messagekey="city_name" width="120px">
        <h:text />
    </r:field>
	<r:field fieldName="send_code" messagekey="send_code" width="120px">
        <h:text />
    </r:field>
    <r:field fieldName="send_name" messagekey="send_name" width="280px">
        <h:text />
    </r:field>
	<r:field fieldName="contract_code" messagekey="contract_code" width="130px">
		<h:text />
	</r:field>
	<r:field fieldName="contract_name" messagekey="contract_name" width="280px">
		<h:text />
	</r:field>
	<r:field fieldName="cust_send_name" messagekey="cust_send_name" width="240px">
		<h:text />
	</r:field>
	<r:field fieldName="cust_receive_name" messagekey="cust_receive_name" width="240px">
		<h:text />
	</r:field>
	<r:field fieldName="cust_payee_name" messagekey="cust_payee_name" width="240px">
		<h:text />
	</r:field>
	<r:field fieldName="cust_bill_name" messagekey="cust_bill_name" width="240px">
		<h:text />
	</r:field>
	<r:field fieldName="cost_center_name" messagekey="cost_center" width="240px">
		<h:text />
	</r:field>
	<r:field fieldName="send_cs_name" messagekey="send_cs_name" width="120px">
		<h:text />
	</r:field>
	<r:field fieldName="receive_cs_name" messagekey="receive_cs_name" width="120px">
		<h:text />
	</r:field>
	<r:field fieldName="payment_day" messagekey="payment_day" width="120px">
		<h:text />
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

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(ISendConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISendConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
if (${msg != null && msg != '' }) {
    alert('${msg }');
}
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("celllist1").isQueryFirst = false;
});
</script>   
