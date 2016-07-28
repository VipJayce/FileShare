<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.employeepost.epimpempdata.epimpempdata_resource" prefix="rayoo.employeepost.epimpempdata.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">

 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'   );>";
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
		form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/epimpempdata/insertEpimpempdata.jsp";
		form.submit();
	}
	
	
	
	function exp_onClick(){  //实现转到详细页面
		form.action="<%=request.getContextPath()%>/EmppostAction.do";
		form.cmd.value = "exp";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post"   id="datacell_formid"  action="<%=request.getContextPath()%>/EmppostAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="cmd1"   name="cmd1" value="queryAll">
    <input type="hidden"  id="action1"  name="action1" value="EmppostAction.do">
 
 <%   
String IMPORT_ID="";
 String INTERFACE_TYPE="";
 IMPORT_ID=(String)request.getAttribute("IMPORT_ID");
 INTERFACE_TYPE=(String)request.getAttribute("INTERFACE_TYPE");


%>
<input  type="hidden"  name="IMPORT_ID" id="IMPORT_ID" value="<%=IMPORT_ID %>">
<input  type="hidden"  name="INTERFACE_TYPE" id="INTERFACE_TYPE" value="<%=INTERFACE_TYPE %>">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco("查看导入结果");  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:exp_onClick();"><fmt:message key="export"/></a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=queryBatchTrans"
        width="99%"
        xpath="ImpClassVo"
        submitXpath="ImpClassVo"
        paramFormId="datacell_formid">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
       <!--<r:field fieldName="emp" messagekey="operate" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>    --> 
       <r:field fieldName="emp_name" label="员工姓名" >
       </r:field>    
        <r:field fieldName="emp_code"  label="唯一号">
      </r:field>
     
      <r:field fieldName="cust_code"  label="客户编号">
      </r:field>
       <r:field fieldName="cust_name"  label="客户名称">
      </r:field>
       <r:field fieldName="apply_on_post_date"  label="入职日期">
      </r:field>
       <r:field fieldName="big_class"  label="大分类">
      </r:field>
       <r:field fieldName="import_result"  label="导入状态">
      </r:field>
       <r:field fieldName="failure_reason"  label="失败原因" width="160px">
      </r:field>
      
    </r:datacell>
    </div>
 
 

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
</script>
</html>
	
