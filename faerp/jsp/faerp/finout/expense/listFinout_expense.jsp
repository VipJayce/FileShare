<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IFinout_expenseConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IFinout_expenseConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	Finout_expenseVo resultVo = null;  //定义一个临时的vo变量
%>
<%@page import="rayoo.finout.finout_expense.util.IFinout_expenseConstants"%>
<%@page import="rayoo.finout.finout_expense.vo.Finout_expenseVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
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
		
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		/*
		var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var ids = datasettr.getProperty("id");
        */
        var datasettr = datacellDatas[ids];
        if(datasettr.getProperty("expense_status")!='1' && datasettr.getProperty("expense_status")!='4' ){
            alert('当前状态下不能修改！');
            return;
        }else{
	        form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?id=" + ids;
	        form.cmd.value = "find";
	        form.submit();
       }
		
		
	}
	function view_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?id=" + ids;
		form.cmd.value = "view";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		for(var i = 0 ; i < ids.length; i++){
             var id = ids[i];
             var entity = datacellDatas[id];
             var is_use = entity.getValue("is_use");
             if(is_use == "1"){
                 alert(entity.getValue("name") + " 被引用不能删除！");
                 return;
             }else {
             }
        }
		
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	
	    	form.submit();
		}
	}
	
	function updateMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		for(var i = 0 ; i < ids.length; i++){
             var id = ids[i];
             var entity = datacellDatas[id];
             var expense_status = entity.getValue("expense_status");
             if(expense_status != "3"){
                 alert(entity.getValue("contract_name") + "金额：" + entity.getValue("expense_sum") + " 没有审批通过不能计入账单！");
                 return;
             }else { 
 
 
             }
        }
		
		if(confirm('确定要计入当前账单吗？')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?ids=" + ids;
	    	form.cmd.value = "updateMultiIsInBillStatus";
	    	
	    	form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		window.location = "<%=request.getContextPath()%>/jsp/faerp/finout/expense/insertFinout_expense.jsp";
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
function setCheckboxStatus(value,entity,rowNo,cellNo){
    datacellDatas[value] = entity;
    return "<input type='checkbox' name='checkbox_template' value='"+value+"' is_use='" + entity.getValue("is_use") + "'>";
}
var datacellDatas = {};
function simpleQuery_onClick(){  //简单的模糊查询
	var create_date_s = form.create_date_s.value;
	var create_date_e = form.create_date_e.value;
    if(create_date_e!=""&&create_date_e.length!=0){
		 var beginTime = create_date_s;
		 var endTime = create_date_e;
		 var beginTimes=beginTime.substring(0,10).split('-');
		 var endTimes=endTime.substring(0,10).split('-');
		 beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
		 endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
		 if(beginTime>endTime){
		     alert("填报终止日期小于填报起始日期！");
		     return ;
		 }
     }
    /**
     if(create_date_e!=""&&create_date_e.length!=0){
    
         var beginTime = new Date(Date.parse(create_date_s));
         var endTime = new Date(Date.parse(create_date_e));
         alert(beginTime);
         if(beginTime>endTime){
             alert("填报终止日期小于填报起始日期！");
             return ;
         }
     }
    */
    
    
    var expense_sum_s = form.expense_sum_s.value;
    var expense_sum_e = form.expense_sum_e.value;
    if(expense_sum_e!=""&&expense_sum_e.length!=0){
         //expense_sum_s = parseInt(expense_sum_s);
         //expense_sum_s = parseInt(expense_sum_s);
         if(expense_sum_s>expense_sum_e){
             alert("填报终止 报销金额小于填报起始报销金额！");
             return ;
         }
     }
     
    
    
    $id("datacell1").loadData();
    $id("datacell1").refresh();
}



    function submit_appState_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("expense_status")!='1' && datasettr.getProperty("expense_status")!='4' ){
            alert('当前状态下不能提交审批！');
            return;
        }else{
            form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?id=" + ids;
            form.cmd.value = "createWF";
            form.submit();
       }
       
    }
    
    
</script>
</head>
<body>
<h:form checkType="keypress" name="form" id="datacell_formid" method="post">
<!--<form name="form" method="post" action="<%=request.getContextPath()%>/Finout_expenseAction.do" id="datacell_formid">-->
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="4" style="padding-top:0;">
			     <div class="search_title">查询条件</div> 
			</td>
			  <td>
              </td>

		</tr>
		<tr>
			<td align="right">填报日期：</td>
			<td align="left">
				<w:date format="yyyy-MM-dd" name="create_date_s"/>
			</td>
			<td align="center">至</td>
			<td align="left">
			     <w:date format="yyyy-MM-dd" name="create_date_e"/>
			</td>
		</tr>
		<tr>
			<td align="right">报销金额：</td>
			<td align="left">
			     <h:text name="expense_sum_s" value="" validateAttr="type=double;fracDigit=2" styleClass="xText"/>
			</td>
			<td align="center">至</td>
			<td align="left">
			     <h:text name="expense_sum_e" value="" validateAttr="type=double;fracDigit=2" styleClass="xText"/>
			</td>
		</tr>
		<tr>
			<td align="right"> 选择合同：</td>
			<td align="left">
			     <input type="hidden" id="contract_id"  name="contract_id" />
                 <w:lookup onReturnFunc="toFindContract" readonly="true" id="contract_name"   name="contract_name" 
                    lookupUrl="/jsp/faerp/common/sales/alllistSalcontract.jsp"  dialogTitle="选择合同" height="444" width="764" style="width:188px"/> 

<script type="text/javascript">

jq(function(){

    function beforeOpen(lookup){
        lookup.params = [];
        //var customer_id=jq("#customer_id").val();
        lookup.addParam("contract_type_bd",10);
        return true;
    }
    
    $id("contract_name").beforeOpenDialog= beforeOpen;
    

});

function toFindContract(obj) {
    jq('#contract_id').val(obj[0]);
    //cc
    var contract_type_bd = obj[6];
    //document.form.contract_type_bd.value = contract_type_bd;//合同类型 1:劳务派遣协议 2:人事委托服务合同 3:服务外包合同 4:体检服务协议 4:补充福利 5:其他
    
    var lookup = $id("contract_name");
    lookup.setValue(obj[1]);
    lookup.setDisplayValue(obj[1]);
}



//审批详细操作
    function spinto_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //var contract_id=ids[0].split(",")[0];//单据主键
        var contract_id=ids[0];
        
        var wfname="finout_expense_work_flow<%=   rayoo.common.filter.UserInfoFilter.geCompanyId()%>";//此业务对应合同审批名称     
        var wfname1="finout_expense_work_flow<%=   rayoo.common.filter.UserInfoFilter.getCompanyId()%>";//此业务对应分配经办人
        //检查此单据是否正在走流程
         //alert('spinto_onClick审批详细');
        WfCommonAjax.checkCurrentWf_Info(wfname,wfname1,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    alert("没有发起过审批流程,不能进行此操作!");
                    return;
                }
                else{
                     //跳转到流程详细信息页面
                    var url = "/FAERP/jsp/faerp/sales/salcontract/processdetailpage.jsp?contract_id=" + contract_id+"&wfname="+wfname+"&wfname1="+wfname1+"&_ts='+(new Date()).getTime()";
                    showModalCenter(url, window, callBack,740, 360, "审批详细"); 
                }   
            }
         );        
    
    }
    
    function callBack(reg){
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
         
</script>

                    
			</td>
			<td align="center"></td>
			<td align="left">
			</td>
		</tr>
		
		<tr>
		      <td>
            <td/>
		      <td>
		         
            <td/>
			<td>
                
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
		</tr>
</table>
</div>

 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="b">  	<a  onClick="javascript:view_onClick();">查看</a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:updateMulti_onClick();">计入账单 </a> </li>
					<li class="bl_1">      <a  onClick="javascript:submit_appState_onClick();">提交审批</a> </li>
					<li class="approdetial"><a  onClick="javascript:spinto_onClick();">审批详细 </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>


<!-- <div id="values_div" class="box" > -->
      <div style="padding: 8 10 8 8;">
		 <r:datacell id="datacell1" queryAction="/FAERP/Finout_expenseAction.do?cmd=queryForDatacell" width="98%" height="318px" 
		 xpath="Finout_expenseVo" paramFormId="datacell_formid">
		 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
		 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
		 <r:field fieldName="contract_code" label="合同编号" width="120px" ></r:field>
		 <r:field fieldName="contract_name" label="合同名称" width="120px"  ></r:field>
		 <r:field fieldName="create_date" label="填报日期" width="120px"  ><w:date format="yyyy-MM-dd HH:mm" readOnly="true"/></r:field>
		 <r:field fieldName="create_user_name" label="申请人" width="120px"  ></r:field>
		 <r:field fieldName="expense_sum" label="报销金额" width="120px"  ></r:field>
		 <r:field fieldName="expense_status" label="状态" onRefreshFunc="showStatus4onRefreshFunc" width="120px"  ></r:field>
		 <r:field fieldName="approve_date" label="审批时间" width="120px"  ><w:date format="yyyy-MM-dd HH:mm" readOnly="true"/></r:field>
		 <r:field fieldName="approve_user_name" label="审批人" width="120px"  ></r:field>
<!--		 <r:field fieldName="is_in_bill" label="计入账单" width="60px" align="center" onRefreshFunc="process_is_in_bill"  ></r:field>-->
		 
		 
		 </r:datacell>
	   </div>
<!--</div>-->
 
 

</div>
</div>
<!--</form>-->
</h:form>
</fmt:bundle>
<script language="javascript">
//报销状态1，未审批2，审批中，3审批通过
function showStatus4onRefreshFunc(value,entity,rowNo,cellNo){
    var result = "未审批";
    if(value=="1"){
        result = "未审批";
    }else if(value=="2"){
        result = "审批中";
    }else if(value=="3"){
        result = "审批通过";
    }else if(value=="4"){
        result = "审批驳回";
    }
    return result;
}
function process_is_in_bill(value,entity,rowNo,cellNo){
    var result = "否";
    if(value=="1"){
        result = "是";
    }else if(value=="2"){
        result = "否";
    }
    return result;
}

</script>
</body>
</html>
