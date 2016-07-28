<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_chargeetransfertemplate.vo.Job_chargeetransfertemplateVo" %>
<%@ page import="rayoo.job.job_chargeetransfertemplate.util.IJob_chargeetransfertemplateConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IJob_chargeetransfertemplateConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IJob_chargeetransfertemplateConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	Job_chargeetransfertemplateVo resultVo = null;  //定义一个临时的vo变量
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
		//form.action="<%=request.getContextPath()%>/Job_orderAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
		if(valiUser(ids)){
			var url="<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?cmd=find&id=" + ids;
        	form.action = url;
        	form.submit();
        	//window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘订单修改');
		}else{
			alert("只能由创建用户修改！");
		}
	}  
	
	function valiUser(ids){
		var dc1 = $id("datacell1");
		var ds1 = dc1.dataset;
		for(var i=0; i<ds1.getLength(); i++){
             	var datarow =  ds1.get(i);
             	for(var j=0; j<ids.length; j++){
	             	if(datarow.getProperty("id") == ids[j]){
	             		if(datarow.getProperty("create_user_id") == document.getElementById("user_id").value ){
	             			return true;
	             		}
	             	}
             	}
        }
        return false;
	}
	
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
  	
	function toAdd_onClick() {  //到增加记录页面
	    var url="<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?cmd=toInsert";
	    form.action = url;
	    form.submit();
        //window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘订单新增');
	}
	
	
    
   function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
   function view_onClick() {  //从多选框到查看页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('请选择一条记录！');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('只能选择一条记录！');
	  		return;
		}
		form.action="/FAERP/Job_chargeetransfertemplateAction.do?id=" + ids;
		form.cmd.value = "view";
		form.submit();
	}  


</script>
</head>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="user_id" id="user_id" value="<%=rayoo.common.filter.UserInfoFilter.getLoginUserId() %>">
<div id="right">
<script language="javascript">
	writeTableTopFesco('费用划转单模板','<%=request.getContextPath()%>/');  //显示本页的页眉
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
            <td align="left">模板名称</td>
            <td align="left">
                <h:text style="width=200px"  id="name"  name="name" value="" />
            </td>
             <td align="left">生效日期</td>
            <td align="left">
                <w:date id="effectivedate" style="width=200px" name="effectivedate" format="YYYY-MM-DD"  />
            </td>
            <td align="left" colspan="2">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
                </td>
            <td align="left"></td>
        </tr>
</table>
</div>
 

 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
		<ul>
            <li class="a"><a onClick="javascript:view_onClick();"><fmt:message key="view" /> </a></li>
            <li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message key="insert" /> </a></li>
		    <li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify" /> </a></li>
		    <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete" /> </a></li>
        </ul>
</div>
           <div class="clear"></div>			
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/Job_chargeetransfertemplateAction.do?cmd=simpleQuery" width="98%" height="318px" xpath="Job_chargeetransfertemplateVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="code" label="模板编号" width="250px" ></r:field>    
 <r:field fieldName="name" label="模板名称" width="110px"></r:field>
 <r:field fieldName="outdept_id" label="划出部门" allowModify="false" width="110px">
 	<r:comboSelect id="outdept_id" name="outdept_id"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       readonly="false"
                       property="bean/outdept_id"
                       xpath="DepartmentVo"
                       nullText="请选择" width="205" >
    </r:comboSelect>
 </r:field>
 <r:field fieldName="effectivedate" label="生效日期" allowModify="false" width="110px">
 	<w:date format="YYYY-MM-DD"/>
 </r:field>	
 <r:field fieldName="expirydate" label="失效日期" allowModify="false" width="110px">
 	<w:date format="YYYY-MM-DD"/>
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
	if(request.getAttribute(IJob_chargeetransfertemplateConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IJob_chargeetransfertemplateConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
