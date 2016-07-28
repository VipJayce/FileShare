<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<%@page import="rayoo.common.filter.UserInfoFilter"%>
<%
String login_user_id = UserInfoFilter.getLoginUserId();
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分配招聘顾问</title>
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
		form.action="<%=request.getContextPath()%>/Job_adviserAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Job_adviserAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var entity = $id("datacell1").getActiveEntity();
        var create_user_id = entity.getProperty("create_user_id");
        //if(create_user_id != <%=login_user_id%>){
       //    alert("只有录入人才能分配招聘顾问！");
       //   return ;
        //}
        
        var url="<%=request.getContextPath()%>/Job_adviserAction.do?cmd=detail&id=" + ids+"&state=modify";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=600px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看顾问信息');
	}
	function detail_onClick(){  //实现转到详细页面
		var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/Job_adviserAction.do?cmd=detail&id=" + ids+"&state=detail";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=600px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看顾问信息');
	}

</script>


<script type="text/javascript">

//每行数据第一列生成复选框
function setCheckboxStatus(value,entity,rowNo,cellNo){
       //return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  >";
       //return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";
       return "<input type='radio' name='temp' value=" + entity.getProperty("id") + "  >";
    }

//选择合同
    function toFindContract(arg){
        var lookup = $id("lk_contract");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#contract_id").val(arg[0]);       
        return false;
    }

 //选择客户
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);      
    jQuery("#cust_a_name").val(arg[2]);       
    return false;
}

</script>

</head>
<body>

<form name="form" method="post"  id = "datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
  <input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">

<div id="right">
<script language="javascript">
    writeTableTopFesco('分配招聘顾问','<%=request.getContextPath()%>/');  //显示本页的页眉
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
            <td align="left">关联合同</td>
            <td align="left">
                <input type="hidden" name="contract_id" id="contract_id"/>
                <w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract" 
                    lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="460" width="760" style="width:188px"/>
            </td>
            <td align="left">客户名称</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=zp" dialogTitle="选择客户" height="460" width="600"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
            </td>
        </tr>
        <tr>
            <td align="left">订单编号</td>
            <td align="left"><input type="text" class="text_field" name="order_code" id="order_code" inputName="订单编号" maxLength="25" /></td>
            <td align="left">订单状态</td>
            <td align="left">
                <%=RmJspHelper.getSelectField("order_status",-1,"ORDER_STATUS_BD","","",false) %>
            </td>
        </tr>
        <tr>
            <td align="left">职位名称</td>
            <td align="left">
                <input type="text" class="text_field" name="position_name" id="position_name" inputName="职位名称" maxLength="25"/>
            </td>
                 <td align="left">订单类型</td>
            <td align="left">
                <%=RmJspHelper.getSelectField("recruittype",-1,"RECURITTYPE","","",false) %>
            </td>
            <td align="left" colspan="2">
                 <!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
                 <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
 

 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
        <ul>
            <li class="a"><a onClick="javascript:detail_onClick();">查看顾问</a></li>
            <li class="c"><a  onClick="javascript:toAdd_onClick();">指派顾问</a></li>
        </ul>
</div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/Job_adviserAction.do?cmd=simpleQuery" width="98%" height="318px" xpath="JobPositionVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
  <r:field fieldName="position" label="招聘职位" allowModify="false" width="110px"> </r:field>
 <r:field fieldName="order_code" label="订单编号" width="110px" ></r:field>    
 <r:field fieldName="order_name" label="订单名称" width="110px"></r:field>
 <r:field fieldName="contract_name" label="关联合同" allowModify="false" width="110px"></r:field>
 <r:field fieldName="customer_name" label="客户" allowModify="false" width="160px"></r:field>
 <r:field fieldName="warranty" label="担保期" allowModify="false" width="110px"></r:field>
 <r:field fieldName="order_status" label="订单状态" allowModify="false" width="110px">
    <d:select dictTypeId="ORDER_STATUS_BD"></d:select>
 </r:field>
 <r:field fieldName="create_user_name" label="录入人" width="110px"></r:field>
 <r:field fieldName="create_date" label="录入时间" allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
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
<script language="javascript">
    $id("datacell1").onClickRow=function(rowTR,rowIndex,entity,datacell){
       var t = rowTR.getElementsByTagName("input");
       t[0].setAttribute("checked","true");
    }
</script>
</body>
</html>

