<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@ page import="rayoo.sales.customer.util.ICustomerConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ICustomerConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ICustomerConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	CustomerVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    var buttonType = "";//魏佳新增--点击的是什么功能的按钮，用于判断是否可以再次操作
    var cust_status_for_detailOrModify = "";
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var datacell = $id("datacell1");
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        var errorCode = "";
        var reload = false;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            var row = datacell.table.tBodies[0].rows[i];//获取选中行对象
            var entity = datacell.getEntity(row);//获取选中行的数据对象
            var cust_status = entity.getValue("cust_status");
            if(elementCheckbox[i].checked) {  //如果被选中
                if(buttonType == "delCust" && cust_status == "1"){
                    alert("该客户已撤销过，请重新选择！");
                    reload = true;
                    errorCode = "error";
                    break;
                }else if(buttonType == "zanBuCheHu" && cust_status == "2"){
                    alert("该客户已做过暂不撤户操作，请重新选择！");
                    reload = true;
                    errorCode = "error";
                    break;
                }else if(buttonType == "zanBuCheHu" && cust_status == "1"){
                    alert("该客户已撤户，请先恢复撤户！");
                    reload = true;
                    errorCode = "error";
                    break;
                }else if(buttonType == "hfDelCust"){
                    if(cust_status == "3"){
                        alert("该客户恢复撤户正在审核中，请重新选择！");
	                    reload = true;
	                    errorCode = "error";
	                    break;
	                }else if(cust_status != "1"){
	                   alert("只有已撤户的客户才可以恢复撤户，请重新选择！");
	                   reload = true;
	                   errorCode = "error";
	                   break;
	                }
                }else if(buttonType == "modify" || buttonType == "detail"){
                    cust_status_for_detailOrModify = cust_status;
                }
               number += 1;  //游标加1
               if(ids == null) {
                   ids = new Array(0);
               }
               ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        if(reload){
            return errorCode;
        }else{
            return ids;
        }
    }
    function findCheckbox_onClick() {  //从多选框到修改页面
        buttonType = "modify";
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url = "<%=request.getContextPath()%>/CustomerAction.do?cmd=find&id=" + ids+"&cust_status="+cust_status_for_detailOrModify+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=客户修改');
        //showModalCenter(url, window, callBack, 750, 400, "客户修改"); 
        //form.action="<%=request.getContextPath()%>/CustomerAction.do?id=" + ids;
        //form.cmd.value = "find";
        //form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/CustomerAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
        //form.action="<%=request.getContextPath()%>/jsp/faerp/sales/customer/insertCustomer.jsp";
        //form.submit();
        //var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0];
        //url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        var url="<%=request.getContextPath()%>/jsp/faerp/sales/customer/insertCustomer.jsp";
         window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=客户新增');
        //showModalCenter("<%=request.getContextPath()%>/jsp/faerp/sales/customer/insertCustomer.jsp", window, callBack, 750, 400, "客户新增");  
    }
    
    function callBack(reg){
        alert("<fmt:message key='operation_over'/>");
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function insertcallBack(reg){
        if(reg=="0"){
            alert("<fmt:message key='add_success'/>");
        }else{
            alert("<fmt:message key='add_false'/>");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function detail_onClick(){  //实现转到详细页面
        buttonType = "detail";
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url = "<%=request.getContextPath()%>/CustomerAction.do?cmd=detail&id=" + ids+"&cust_status="+cust_status_for_detailOrModify+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=430px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看客户信息');
        //showModalCenter(url, window, callBack, 750, 430, "查看客户信息"); 
        //form.action="<%=request.getContextPath()%>/CustomerAction.do?id=" + ids;
        //form.cmd.value = "detail";
        //form.submit();
    }

    function exportExcel_onClick(){  //导出Excel
        //oldCmd = form.cmd.value;
        form.cmd.value = "exportExcel";
        form.submit();
    }  
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    /*
     * 撤户
     *	
     */
    
    function cust_del_onClick(){
         buttonType = "delCust";
    	 var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    	 if(ids == "error"){
            return;
        }else if(ids.length > 1) {  
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        if(confirm("是否确定撤户！")){
            jQuery.ajax({
	            type : "post",
	            url : "<%=request.getContextPath()%>/CustomerAction.do?cmd=checkDelCutomer&ids=" + ids,
	            dataType : "html",
	            success : function(data) {
	                   if(!data){
	                        alert("撤户成功！");
	                        $id("datacell1").reload();
	                        $id("datacell1").refresh();
	                   }else{
	                        var alertMsg = "该客户 :\n";
	                        var strArray = data.split(",");
	                        for (var i=0;i<strArray.length;i++){
	                            if(strArray[i] == '1'){
	                                alertMsg += "        最近3月有员工在职，或者有员工入职和离职 \n";
	                            }else if(strArray[i] == '2'){
	                                alertMsg += "        最近3月有生成账单  \n";
	                            }else if(strArray[i] == '3'){
	                                alertMsg += "        有人在缴社保公积金\n";
	                            }else if(strArray[i] == '4'){
	                                alertMsg += "        有在用员工 \n";
	                            }else if(strArray[i] == '5'){
	                                alertMsg += "        有在保员工 \n";
	                               //add by sjx for bug 713 start
	                            }else if(strArray[i] == '6'){
	                                alertMsg += "        有欠款账单\n";
		                           //add by sjx for bug 713 end
	                            }
	                        }
	                        alertMsg += "        ------不能撤户！"
	                        alert(alertMsg);
	                   }
	              }
	            });
        }
    }
    
    //查询可撤账户
    function check_del_onClick(){
    	exportReport();
    }
    
    
    function exportReport(){
          	form.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showDelCustomerPrintReport.jsp?raq=customer_del.raq&company_id="+document.getElementById('company_id').value;
            form.submit();
       
    }
    
    function zanBuCheHu(){
        buttonType = "zanBuCheHu";
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }else if(ids == null || ids == ""){
            alert("请选择一条数据！");
            return;
        }else if(ids.length > 1) {  
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        if(confirm("是否确定暂不撤户！")){
            var val = window.showModalDialog('/FAERP/CustomerAction.do?cmd=inputReason&type=1&id='+ids,'','dialogHeight:300px;dialogWidth:600px;center:yes;help:no;resizable:no;scroll:no;status:no;');
	        if(val=='1'){
	            simpleQuery_onClick();
	        }
        }
        
    }
    
    //恢复撤户，并发起审批流程
    function cust_hf_onClick(){  //发起工作流
        var wfname="CustomerCancleDelete";//此业务对应合同审批名称 
        buttonType = "hfDelCust";
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }else if(ids == null || ids == ""){
            alert("请选择一条数据！");
            return;
        }else if(ids.length > 1) {  
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        if(confirm("是否确定申请恢复撤户！")){
            //检查此单据是否正在走流程
	        WfCommonAjax.checkCurrentWf(wfname,ids,function(reData){
	               var val = window.showModalDialog('/FAERP/CustomerAction.do?cmd=inputReason&type=2&id='+ids,'','dialogHeight:300px;dialogWidth:600px;center:yes;help:no;resizable:no;scroll:no;status:no;');
		            if(val=='1'){
		                simpleQuery_onClick();
		            }
	                /*
	                jQuery.ajax({
	                    url: "<%=request.getContextPath()%>/CustomerAction.do?cmd=submitAPProvalCust&cust_id=" + ids,
	                    type: 'post',
	                    dataType: 'html',
	                    timeout: 10000,
	                    error: function(){
	                        alert('Error loading XML document');
	                        return  null;
	                    },
	                    success: function(text){ 
	                       if(text==1){
	                           alert("申请恢复撤户提交成功！");  
	                           $id("datacell1").loadData();
                               $id("datacell1").refresh();
	                       }else if(text==2){
	                           alert("申请恢复撤户提交失败！");
	                           return;
	                       }
	                    }
                    });*/
	            }
	         ); 
        }
    }
</script>
 

</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CustomerAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 <input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="customer_maintain"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='query_conditions'/></div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
            <td align="left"><fmt:message key='customer_code'/></td>
            <td align="left">
                <input type="text" class="text_field" id="customer_code"  name="customer_code" value="" inputName="客户编号" maxLength="25"/>
            </td>
             <td align="left"><fmt:message key='customer_name'/></td>
            <td align="left">
                <input type="text" class="text_field" id="customer_name" name="customer_name" value="" inputName="客户名称" maxLength="25"/>
            </td>
            <td align="left">legal entity code</td>
            <td align="left"><input type="text" class="text_field" id="legal_entity_code" name="legal_entity_code" value="" inputName="legal entity code" maxLength="25"/></td>
        </tr>
        <tr>
             <td align="left"><fmt:message key='customer_type'/></td>
            <td align="left">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("customer_type", -1,"CUSTOMER_TYPE","","",false) %> 
            </td>
            <td align="left"><fmt:message key='industry_type_name'/></td>
            <td align="left">
               <r:comboSelect id="trade_type" name="trade_type1" queryAction="/FAERP/CustomerAction.do?cmd=queryIndustryTypeData"
              textField="name" valueField="id" xpath="CustomerSelectVo" width="200px" messagekey="please_choose"/> 
            </td>
            <td align="left">客户状态</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("cust_status", -1,"CUST_STATUS","0","",false) %> 
            </td>
         </tr>
        
        <tr>
            <td align="left">集团户名称</td>
            <td align="left"><input type="text" class="text_field" id="group_family_prop_name" name="group_family_prop_name" value="" inputName="集团户名称" maxLength="25"/></td>
            <td align="left">集团户编号</td>
            <td align="left"><input type="text" class="text_field" id="group_family_prop_code" name="group_family_prop_code" value="" inputName="集团户编号" maxLength="25"/></td>
            <td align="left">集团户类型</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("prop_type", -1,"PROP_TYPE","0","",false) %> 
            </td>
        </tr>
        <tr>
            <td align="left" colspan="6">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
            </td>
        </tr>
</table>
</div>
 

 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
		 <input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="cust_view" type="1"/>  onClick="detail_onClick();">
		 <input class="c"  type="button"   value="<fmt:message key="insert"/>"   <au:authorityBtn code="cust_add" type="1"/> onClick="toAdd_onClick();">
        <input class="b"  type="button"   value="<fmt:message key="modify"/>"   <au:authorityBtn code="cust_modify" type="1"/> onClick="findCheckbox_onClick();">
        <input class="e"  type="button"   value="<fmt:message key="export"/>"   <au:authorityBtn code="cust_exp" type="1"/> onClick="exportExcel_onClick();">
        <input class="d"  type="button"   value="<fmt:message key="remove_user"/>"   <au:authorityBtn code="cust_del" type="1" /> onClick="cust_del_onClick();">
        <input class="approdetial"  type="button"   value="恢复撤户" <au:authorityBtn code="hf_cust_del" type="1" /> onClick="cust_hf_onClick();">
        <input class="approdetial"  type="button"   value="暂不撤户" <au:authorityBtn code="zbch_cust" type="1" />  onClick="zanBuCheHu();">
        <input class="approdetial"  type="button"   value="<fmt:message key="remove_customer_query"/>"   onClick="check_del_onClick();">
		 </div>
           <div class="clear"></div>			
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/CustomerAction.do?cmd=queryCustomerData" width="98%" height="318px" xpath="CustomerVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="customer_name" messagekey="customer_name" width="250px" ></r:field>    
 <r:field fieldName="customer_code" messagekey="customer_code" width="100px"></r:field>
 <r:field fieldName="customer_property" messagekey="customer_property" allowModify="false" width="100px">
    <d:select dictTypeId="CUSTOMER_PROPERTY"></d:select>
 </r:field>
 <r:field fieldName="country_area" messagekey="country_name" allowModify="false" width="100px">
    <r:comboSelect id="country_area" name="country_area" queryAction="/FAERP/CustomerAction.do?cmd=queryCountryData" 
    textField="name" valueField="id" xpath="CustomerSelectVo"  messagekey="please_choose"  /> 
 </r:field>
 <r:field fieldName="customer_type" messagekey="customer_type" allowModify="false" width="100px">
    <d:select dictTypeId="CUSTOMER_TYPE"></d:select>
 </r:field>
 <r:field fieldName="add_trade_type" messagekey="industry_type_name" allowModify="false" width="100px">
 </r:field>
 <r:field fieldName="create_user_name" messagekey="name" width="100px"></r:field>
 <r:field fieldName="create_date" messagekey="create_date"  allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
 <r:field fieldName="legal_entity_code" label="legal entity code" allowModify="false" width="130">
 </r:field>
 <r:field fieldName="remarks" label="备注" allowModify="false" width="130">
 </r:field>
 <r:field fieldName="group_family_prop_name" label="集团户名称" width="100">
 </r:field>
 <r:field fieldName="group_family_prop_code" label="集团户编号" width="80">
 </r:field>
 <r:field fieldName="cust_status" messagekey="customer_status" width="100px" allowModify="false">
    <d:select dictTypeId="CUST_STATUS"></d:select>
 </r:field>
 <r:field fieldName="customer_by_beijing_code" label="北京委托户编号" width="100px" allowModify="false">
 </r:field>
 </r:datacell>
</div>

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
<% //表单回写
    if(request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        //out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>	
