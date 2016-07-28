<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.jcustomer.vo.JcustomerVo" %>
<%@ page import="rayoo.job.jcustomer.util.IJcustomerConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IJcustomerConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IJcustomerConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	JcustomerVo resultVo = null;  //定义一个临时的vo变量
%>
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
    
    function valiUser(ids){
		var dc1 = $id("datacell1");
		var ds1 = dc1.dataset;
		for(var i=0; i<ds1.getLength(); i++){
             	var datarow =  ds1.get(i);
             	if(datarow.getProperty("id") == ids){
             		if(datarow.getProperty("create_user_id") == document.getElementById("user_id").value ){
             			return true;
             		}
             	}
        }
        return false;
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
		if(valiUser(ids)){
			var url = "<%=request.getContextPath()%>/JcustomerAction.do?cmd=find&id=" + ids+"&_ts="+(new Date()).getTime();
        	window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=客户修改');
        }else{
			alert("只能由创建用户修改！");
		}
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/JcustomerAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	 $id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		var url="<%=request.getContextPath()%>/JcustomerAction.do?cmd=toChoose";
        window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=客户新增');
        
	}
	
	function callBack(reg){
        alert("操作完成！");
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
	
	function insertcallBack(reg){
        if(reg=="0"){
            alert("新增成功！");
        }else{
            alert("新增失败！");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function updatecallBack(reg){
        if(reg=="0"){
            alert("更新成功！");
        }else{
            alert("更新失败！");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
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
		var url = "<%=request.getContextPath()%>/JcustomerAction.do?cmd=detail&id=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=430px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看客户信息');
        
	}
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }

</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/JcustomerAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="user_id" id="user_id" value="<%=rayoo.common.filter.UserInfoFilter.getLoginUserId() %>">
<div id="right">
<script language="javascript">
	writeTableTopFesco('客户维护','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td align="left">客户编号</td>
            <td width="left">
                <input type="text" class="text_field" id="customer_code"  name="customer_code" value="" inputName="客户编号" maxLength="25"/>
            </td>
            <td align="left">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_name" name="customer_name" value="" inputName="客户名称" maxLength="25"/>
            </td>
            
        </tr>
        <tr>
            <td align="left">客户类别</td>
            <td align="left">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("customer_type", -1,"CUSTOMER_TYPE","","",false) %> 
            </td>
            <td align="left"></td>
            <td align="left">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
            </td>
        </tr>
</table>
</div>
 

 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
		 <input class="a" type="button"   value="<fmt:message key="view"/>"    onClick="detail_onClick();">
		 <input class="c"  type="button"   value="<fmt:message key="insert"/>"   onClick="toAdd_onClick();">
         <input class="b"  type="button"   value="<fmt:message key="modify"/>"  onClick="findCheckbox_onClick();">
</div>
           <div class="clear"></div>			
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/JcustomerAction.do?cmd=simpleQuery" width="98%" height="318px" xpath="JcustomerVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="cust_name" label="客户名称" width="250px" ></r:field>    
 <r:field fieldName="cust_code" label="客户编号" width="110px"></r:field>
 <r:field fieldName="cust_quality" label="客户性质" allowModify="false" width="110px">
    <d:select dictTypeId="CUSTOMER_PROPERTY"></d:select>
 </r:field>
 <r:field fieldName="cust_type" label="客户类别" allowModify="false" width="110px">
    <d:select dictTypeId="CUSTOMER_TYPE"></d:select>
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
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IJcustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IJcustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
