<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<script type="text/javascript">
jQuery.noConflict();
</script>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>费用划转单</title>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script language="javascript">
    var vpath='<%=request.getContextPath()%>';
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
		var datacell1 = $id("datacell1");
        var dataset = datacell1.dataset;//取得页面的datacell
        var entity = dataset.findEntity("id",ids);
        var status = entity.getProperty("status");
        if(status!=null && (status=='1' || status=='2' || status=='3' )){
            alert('该费用划转单已经审批，不能修改！');
            return;
        }
	    form.action="<%=request.getContextPath()%>/Job_chargetransbillAction.do?&isModify=true&id=" + ids;
		form.cmd.value = "find";
		form.submit();
		
		//var url = "<%=request.getContextPath()%>/Job_chargetransbillAction.do?cmd=find&isModify=true&id="+ids;
        //window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改费用划转单');
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		var datacell1 = $id("datacell1");
        var dataset = datacell1.dataset;//取得页面的datacell
        var entity = dataset.findEntity("id",ids);
        var status = entity.getProperty("status");
        if(status!=null && (status=='1' || status=='2' || status=='3' )){
            alert('该费用划转单已经审批，不能删除！');
            return;
        }
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Job_chargetransbillAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/Job_chargetransbillAction.do?cmd=toInsert&isModify=false";
		form.submit();
		//var url = "<%=request.getContextPath()%>/Job_chargetransbillAction.do?cmd=toInsert&isModify=false";
		//window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增费用划转单');
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
		form.action="<%=request.getContextPath()%>/Job_chargetransbillAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit(); 
		//var url="<%=request.getContextPath()%>/Job_chargetransbillAction.do?cmd=detail&id=" + ids;
        //window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看费用划转单');
	}
	
	function toWorkflow_onClick(){//提交确认审核，进入工作流
	   var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var datacell1 = $id("datacell1");
        var dataset = datacell1.dataset;//取得页面的datacell
        var entity = dataset.findEntity("id",ids);
        var status = entity.getProperty("status");
        //已经发起审批或已经审批了，不能再次提交审批
        if(status!=null && (status=='1' || status=='2' || status=='3' )){
            alert('该费用划转单已经进入审批，不能重复提交！');
            return;
        }
        //转入和转入部门没有领导岗位及具体人员，不能提交
        jQuery.ajax({
           url: vpath+'/Job_chargetransbillAction.do?cmd=checkLeader&id='+ids+'&date='+new Date(),
           type: 'GET',
           dataType: 'html',
           timeout: 100000,
           error: function(){
               alert('Error loading XML document');
                   return  null;
               },
           success: function(text){
               if(text==1){
                     alert('该划转单的转出部门没有领导岗位或领导岗位没有具体负责人，无法审批！');
                     return;
               }else if(text==2){
                     alert('该划转单的转入部门没有领导岗位或领导岗位没有具体负责人，无法审批！');
                     return;
               }else if(text==-1){
                     alert('该划转单无效，无法审批！');
                     return;
               }else{
                    form.action="<%=request.getContextPath()%>/Job_chargetransbillAction.do?id=" + ids;
			        form.cmd.value = "checktoWorkflow";
			        form.submit(); 
               }
           }
       });
       
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
        var wfname="Job_chargetransbill<%=   rayoo.common.filter.UserInfoFilter.geCompanyId()%>";//此业务对应合同审批名称     
        //已经发起审批或已经审批了，不能再次提交审批
        var datacell1 = $id("datacell1");
        var dataset = datacell1.dataset;//取得页面的datacell
        var entity = dataset.findEntity("id",ids);
        var status = entity.getProperty("status");
        if(status!=null && status=='0'){
            alert('该费用划转单尚未提交审批！');
            return;
        }else{
             //跳转到流程详细信息页面
            var url = "/FAERP/jsp/faerp/job/job_chargetransbill/processdetailpage.jsp?mid=" + ids +"&wfname="+wfname+"&_ts='+(new Date()).getTime()";
            showModalCenter(url, window, callBack,740, 360, "<fmt:message key="examine_info"/>"); 
        }     
    
    }
    
    function callBack(reg){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
    }
	
	//生成复选框
	 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    //合同参照
    function toFindContract(arg){
        var lookup = $id("lk_contract");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#contract_id").val(arg[0]);       
        return false;
    }
    
   //客户参照
    function rtnCustFunc(arg){
    var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }

</script>
</head>
<body>

<form name="form" id="form1" method="post" action="<%=request.getContextPath()%>/Job_chargetransbillAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('费用划转单','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
				<td align="right">划转单编号</td>
            <td align="left">
                <input type="text" class="text_field" name="transcode" inputName="划转单编号" maxLength="50"/>
            </td>
			<td align="right">划转单类型</td>
			<td align="left">
				<d:select name="transtype" id="transtype" dictTypeId="JOB_TRANSTYPE_BD" value="1" nullLabel="请选择"></d:select>
			</td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">关联合同</td> 
			<td align="left">
			 <input type="hidden" name="contract_id" id="contract_id" />
                <w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract" 
                    lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="444" width="764" style="width:188px"/> 
			</td>
			<td align="right">客户</td>
            <td align="left">
                 <w:lookup onReturnFunc="rtnCustFunc" readonly="false" displayValue="" id="lk_cust" 
                                   lookupUrl="/JcustomerAction.do?cmd=getJCustRef" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false" style="width:188px"/>
                <input type="hidden" name="cust_id" id="cust_id">
            </td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">划出部门</td>
			<td align="left">
				  <r:comboSelect id="outdept_id" name="outdept_id"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       readonly="false"
                      property="bean/outdept_id"
                       xpath="DepartmentVo"
                       nullText="请选择" width="205" ></r:comboSelect>
			</td>
			<td align="right">划转年月</td>
            <td align="left">
                <input type="text" class="text_field" name="transyearmonth" inputName="划转年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
            </td>
			<td align="right"></td>
		</tr>
		<!-- 
		<tr>
			<td align="right">员工ID</td>
			<td align="left">
				<input type="text" class="text_field" name="employee_id" inputName="员工ID" maxLength="9.5"/>
			</td>
			<td align="right">客户确认人</td>
            <td align="left">
                <input type="text" class="text_field" name="serviceconfirmor" inputName="客户确认人" maxLength="9.5"/>
            </td>
			<td align="right"></td>
		</tr>
		<tr>
		<td align="right">顾问确认人</td>
            <td align="left">
                <input type="text" class="text_field" name="counselconfirmor" inputName="顾问确认人" maxLength="9.5"/>
            </td>
			<td align="right">财务确认人</td>
			<td align="left">
				<input type="text" class="text_field" name="financeconfirmor" inputName="财务确认人" maxLength="9.5"/>
			</td>
			<td align="right"></td>
		</tr>
		 -->
		<tr>
			<td/>
			<td/>
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	<td/>
		</tr>
</table>
</div>

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="c">      <a  onClick="javascript:toWorkflow_onClick();">提交审批 </a> </li>
					<li class="a">      <a  onClick="javascript:spinto_onClick();">审批详细 </a> </li>
                 
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div style="padding: 8 8 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/Job_chargetransbillAction.do?cmd=simpleQuery" width="98%" height="318px" xpath="Job_chargetransbillVo" paramFormId="form1" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="transcode" label="划转单编号" width="100px" ></r:field>    
 <r:field fieldName="transtype" label="划转单类型" width="110px">
    <d:select id="transtype" dictTypeId="JOB_TRANSTYPE_BD" value="1" nullLabel="请选择"></d:select>
 </r:field>
 
 <r:field fieldName="dept_name" label="划出部门" allowModify="false" width="110px"></r:field>
 <r:field fieldName="transyearmonth" label="划转年月" allowModify="false" width="110px"></r:field>
 <r:field fieldName="status" label="审批状态" allowModify="false" width="110px">
    <d:select id="status" dictTypeId="JOB_CHECK_STATUS_BD" value="1" nullLabel="请选择"></d:select>
 </r:field>
 <!-- 
 <r:field fieldName="serviceconfirmor" label="客服确认人" allowModify="false" width="110px"></r:field>
 <r:field fieldName="counselconfirmor" label="顾问确认人" allowModify="false" width="110px"></r:field>
 <r:field fieldName="financeconfirmor" label="财务确认人" allowModify="false" width="110px"></r:field>
  -->
 <r:field fieldName="create_user_name" label="录入人" width="110px"></r:field>
 <r:field fieldName="create_date" label="录入时间" allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
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

</script>	
