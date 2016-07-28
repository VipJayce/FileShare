<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.securitygroup.securitygroupstop.vo.SecuritygroupstopVo" %>
<%@ page import="rayoo.system.securitygroup.securitygroupstop.util.ISecuritygroupstopConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISecuritygroupstopConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISecuritygroupstopConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SecuritygroupstopVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/SecuritygroupstopAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/SecuritygroupstopAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/system/securitygroup/securitygroupstop/insertSecuritygroupstop.jsp";
		form.submit();
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
		form.action="<%=request.getContextPath()%>/SecuritygroupstopAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/SecuritygroupstopAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="right">社保公积金组ID</td>
			<td align="left">
				<input type="text" class="text_field" name="security_group_id" inputName="社保公积金组ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">停办类型编码</td>
			<td align="left">
				<input type="text" class="text_field" name="type_code" inputName="停办类型编码" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">停办类型名称</td>
			<td align="left">
				<input type="text" class="text_field" name="type_name" inputName="停办类型名称" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
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
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 <div style="margin-top:15px;">
         <div id="values_div1" class="box" style="width:28%; float:left;" style="margin-left:0px;"> 
                        <div class="button" style="margin:0 0 0 0 px;"> 
                              <div class="button_right">
                                    <ul>
                                        <li class="c">      <a onClick="javascript:toAddTbale3_onClick();"><fmt:message key="insert"/> </a></li>
                                        <li class="d">      <a onClick="javascript:toDeleteTbale3_onClick();"><fmt:message key="delete"/> </a> </li>
                                        <li class="bc">    <a onClick="javascript:toSaveTbale3_onClick();"><fmt:message key="save"/> </a> </li>
                                    </ul>
                                 </div>
                             <div class="box_title" style="margin-top:5px;">下属产品比例</div>
                             <div class="clear"></div>            
                        </div>
      <table  width="100%" cellspacing="0"  class="datagrid1" id="table3">
<tr>
<th  class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>停办类型编码</th>
<th>停办类型名称</th>
</tr>
<logic:iterate     name="beans"  id="data_stop" scope="request" indexId="indexs">
        <tr id="<bean:write name="data_stop" property="id"/>">
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data_stop" property="id"/>" displayName="<bean:write name="data_stop" property="id"/>"/></td>
         <input type="hidden" name="table3id" value="<bean:write name="data_stop" property="id"/>">
        <input type="hidden" name="security_group_id3" value="<bean:write name="data_stop" property="security_group_id"/>">
        <td><input type="text" class='text_field' style='width:100px;' name="type_code3" value="<bean:write name="data_stop" property="type_code"/>"></td>
        <td><input type="text" class='text_field' style='width:100px;' name="type_name3" value="<bean:write name="data_stop" property="type_name"/>"></td>
		</tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

</div>
</div>
</form>

<script language="javascript">
////////////////////////////////////////////////////////////////////table3从单选框中标记添加一条记录
     var table3Index=0;
     //新增大类行
     function toAddTbale3_onClick(){
         var obj=document.getElementById("table3");
         table3Index++;
         //添加行
         var rownum = obj.rows.length;
         var tr0=obj.insertRow(rownum);
         tr0.setAttribute("id","stop"+table3Index);
         var td0 = tr0.insertCell(0);
         td0.innerHTML="  <input type='hidden' name='table3id'/><input type='checkbox' name='checkbox_template' value='stop"+table3Index+"'/>";
         //添加单元格
         var td1 = tr0.insertCell(1);
         td1.innerHTML="<input type='hidden' name='security_group_id3' value='1099801000000000002'/> <input type='text' class='text_field' name='type_code3' validate='notNull;' inputName='停办类型编码' maxLength='20' style='width:100px;' value='code'/>";
          //添加单元格
         var td2 = tr0.insertCell(2);
         td2.innerHTML="<input type='text' class='text_field' name='type_name3' inputName='停办类型名称' validate='notNull;' maxLength='20' style='width:100px;' value='"+table3Index+"'/>";
     }
////////////////////////////////////////////////////////////////////table3从单选框中标记删除一条记录
      function toDeleteTbale3_onClick(){  
          var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
          if(ids == null) {  //如果ids为空
              alert('请至少选择一条记录');
              return;
          }
          if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
              //删除页面记录
              var ids_str='';
              var obj=document.getElementById("table3");
              for(var i=0;i<ids.length;i++){  //循环checkbox组
                  var table3id=ids[i];
                  alert("table3id="+table3id);
                  var j=document.getElementById(table3id).rowIndex;
                  obj.deleteRow(j);
                  if(i<=ids.length&&table3id.indexOf("stop")==-1){
                      ids_str=ids_str+ids[i]+",";
                  }
              }
              if(ids_str!=""){
              //数据库删除
              //alert("ids_str="+ids_str);
              validateDeleteStop(ids_str);
              }
          }
              
      }
      //ajax删除记录
      function validateDeleteStop(ids){
             var flags=true;
                 jQuery.ajax({
          url: '<%=request.getContextPath()%>/SecuritygroupstopAction.do?cmd=deleteMulti&ids='+ids,
          type: 'GET',
          dataType: 'html',
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
              if(text!=1){       
               flags=false;
               alert("删除成功！");
              }
          }
          });return flags;
      }
 ////////////////////////////////////////////////////////////////////table3保存所有记录   
     function toSaveTbale3_onClick(){
          form.action="<%=request.getContextPath()%>/SecuritygroupstopAction.do?cmd=insert&security_group_id=1099801000000000002";
          form.submit();
     }     
     
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(ISecuritygroupstopConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISecuritygroupstopConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
