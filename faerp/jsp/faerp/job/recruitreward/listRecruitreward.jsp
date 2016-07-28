<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*"%>

<%@ page import="rayoo.job.job_order.vo.Job_orderVo"%>
<%@ page import="rayoo.job.job_order.util.IJob_orderConstants"%>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IJob_orderConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IJob_orderConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    Job_orderVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>业绩分配</title>
	<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
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
        form.action="<%=request.getContextPath()%>/Job_orderAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/Job_orderAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
       var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var activeEntity = $id("datacell1").getActiveEntity();
        if(activeEntity.getProperty("position_status") != 5){
            alert("该职位状态未成功，不能进行业绩分配！");
            return;
        }
        var position_id=activeEntity.getProperty("position_id");
      var isExiseurl="<%=request.getContextPath()%>/RecruitrewardAction.do?cmd=IsExiseRecruitreward&id="+position_id;
        jQuery.post(isExiseurl,function(data){
             if(data){
                if(data==0){
                 var url="<%=request.getContextPath()%>/RecruitrewardAction.do?cmd=submitRecruitreward&id="+ids+"&position_id="+position_id;
        window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=业绩分配');
                }else{
                  alert("此职位业绩已分配，不需要重新分配");
                }
             
             }else{
                alert("程序错误,请重试");
                return;
             }
        })
       
        
    }
    function detail_onClick(){  //实现转到详细页面
     
        form.action="<%=request.getContextPath()%>/Job_orderAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
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
    function rtnFunc(arg){
    var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }
    function simpleQuery_onClick(){  //查询所有记录
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
</script>
	</head>
	<form name="form" method="post" id="datacell_formid"
		action="<%=request.getContextPath()%>/Job_orderAction.do"><input
		type="hidden" name="cmd" value="queryAll" /> <input type="hidden"
		name="backFlag" id="backFlag" value="true"> <input
		type="hidden" name="company_id" id="company_id"
		value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
	<div id="right"><script language="javascript">
    writeTableTopFesco('业绩分配','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_x">


	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title">查询条件</div>
			</td>
			<td />
			<td />
			<td></td>
			<td />
		</tr>
		<tr>
			<td align="left">关联合同</td>
			<td align="left"><input type="hidden" name="contract_id"
				id="contract_id" /> <w:lookup onReturnFunc="toFindContract"
				readonly="true" id="lk_contract"
				lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"
				dialogTitle="选择合同" height="444" width="764" style="width:188px" /></td>

			<td align="left">客户名称</td>
			<td align="left"><w:lookup onReturnFunc="rtnFunc"
				readonly="false" displayValue="" id="lk_cust"
				lookupUrl="/JcustomerAction.do?cmd=getJCustRef" dialogTitle="选择客户"
				height="440" width="710" allowInput="false" style="width:188px" />
			<input type="hidden" name="cust_id" id="cust_id"></td>
			<td align="left">订单编号</td>
			<td align="left"><input type="text" class="text_field"
				id="order_code" name="order_code" inputName="订单编号" maxLength="100" />
			</td>
		</tr>
		<tr>
			<td align="left">业绩分配状态</td>
			<td align="left">
			     <d:select dictTypeId="IS_ASSGN_BD" value="1" id="assgn_status" name="assgn_status" nullLabel="--请选择--">
		  </d:select>
			</td>
			<td align="left">职位状态</td>
			<td align="left">
			     <d:select id="position_status" name="position_status" nullLabel="--请选择--" dictTypeId="ORDER_STATUS_BD" value="5" ></d:select>
			</td>
			<td align="left"></td>
			<td align="left"><input name="button_ok" class="icon_1"
				type="button" value='<fmt:message key="query"/>'
				onClick="javascript:simpleQuery_onClick()"> <input
				type="reset" class="icon_1" /></td>
		</tr>
	</table>
	</div>



	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>

		<li class="h_1"><a onClick="javascript:toAdd_onClick();">分配业绩</a></li>

	</ul>
	</div>
	<div class="clear"></div>
	</div>

	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction="/FAERP/Job_orderAction.do?cmd=searchRrecruitreward"
		width="98%" height="318px" xpath="Job_orderVo"
		paramFormId="datacell_formid" readonly="true">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="id" label="操作" width="50px"
			onRefreshFunc="setCheckboxStatus" align="center"></r:field>
        <r:field fieldName="position_id" label="" width="0px"></r:field>
		<r:field fieldName="order_code" label="订单编号" width="150px"></r:field>
		<r:field fieldName="order_name" label="订单名称" width="150px"></r:field>
		<r:field fieldName="position" label="职位名称" width="150px"></r:field>
		<r:field fieldName="contract_name" label="关联合同" allowModify="false"
			width="150px"></r:field>
		<r:field fieldName="cust_name" label="客户" allowModify="false"
			width="150px"></r:field>
		<r:field fieldName="warranty" label="担保期" allowModify="false"
			width="110px"></r:field>
		<r:field fieldName="name" label="录入人" width="110px"></r:field>
		<r:field fieldName="create_date" label="录入时间" allowModify="false"
			width="110px">
			<w:date format="YYYY-MM-DD" />
		</r:field>
		<r:field fieldName="position_status" label="职位状态" allowModify="false"
			width="110px">
			<d:select dictTypeId="ORDER_STATUS_BD"></d:select>
		</r:field>
	</r:datacell></div>

	</div>
	</div>
	</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">

</script>
