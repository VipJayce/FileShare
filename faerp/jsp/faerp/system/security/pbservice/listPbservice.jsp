<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.pbservice.vo.PbserviceVo" %>
<%@ page import="rayoo.system.pbservice.util.IPbserviceConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	int size=0;
	if(request.getAttribute(IPbserviceConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IPbserviceConstants.REQUEST_BEANS);  //赋值给resultList
		size = lResult.size();
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	PbserviceVo resultVo = null;  //定义一个临时的vo变量
	
	String fwlb=gap.rm.tools.helper.RmJspHelper.getSelectField("service_type_bd", -1, "SERVICE_TYPE_BD", "", "inputName='服务类别'", false);
	System.out.println(fwlb);
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<style type="text/css">
.box{ border:1px solid #c5dbe2; margin:5px 10px 0px 10px; width:98%; overflow-x:scroll;white-space:nowrap;overflow-y:scroll; height:280px;
Scrollbar-Highlight-Color:#fafafa; Scrollbar-Shadow-Color:#e8e8e8;Scrollbar-3Dlight-Color:#e4e4e4;scrollbar-dark-shadow-color:#7dc0e3;} 
</style>
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
		form.action="<%=request.getContextPath()%>/PbserviceAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/PbserviceAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/system/security/pbservice/insertPbservice.jsp";
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
		form.action="<%=request.getContextPath()%>/PbserviceAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/PbserviceAction.do?backFlag=true">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="6" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
		<tr>
			<td align="right">服务类别&nbsp;&nbsp; </td>
			<td align="left">
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("service_type_bd", -1, "SERVICE_TYPE_BD", "", "inputName='服务类别'", false) %>
			</td>

			<td align="right">城市&nbsp;&nbsp; </td>
			<td align="left">
				<faerp:cityTag  tagname="city_id" hasSearchTag="true" />
			</td>

			<td align="right">服务名称&nbsp;&nbsp; </td>
			<td align="left">
				<input type="text" class="text_field" name="service_name" inputName="服务名称" maxLength="50"/>
			</td>
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
            	<td/>
		</tr>
</table>
</div>
</form>

 

<form name="form1" method="post">	
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="c">  	<a onClick="javascript:addfwTableRow();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteFw_onClick();"><fmt:message key="delete"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
  <table  width="100%" cellspacing="0"  class="datagrid1" id="fwTab">
	<tr>
	<th><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
    <th>
                
                <a href="/FAERP/PbserviceAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"city_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"city_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"city_id")%>">
            </a>    
       
             城市</th>
    
    <th>
					
					<a href="/FAERP/PbserviceAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_type_bd")%>">
           	</a>	
       
	 服务类别</th>
     	
			<th>
				
			  	<a href="/FAERP/PbserviceAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_code")%>">
           	</a>	
       
			 服务编码</th>
			<th>
				
			  	<a href="/FAERP/PbserviceAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_name")%>">
           	</a>	
       
			 服务名称</th>
			<th>
				
			  	<a href="/FAERP/PbserviceAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remark")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remark")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remark")%>">
           	</a>	
       
			 备注</th>
			
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
	   <tr id="<bean:write name="data" property="id"/>" style="background-color:#dce6f5">
		    <td>
		         <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/>
		         <input type="hidden" name="fw_id" value="<bean:write name="data" property="id"/>"/>
		    </td>

            <td>
                 <faerp:cityTag beanname="data" attribute="city_id" tagname="city_id" className=""/>
            </td>
            
            <td>
                <bean:define id="service_type_bd" name="data" property="service_type_bd"/>
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("service_type_bd", -1, "SERVICE_TYPE_BD", String.valueOf(service_type_bd), "inputName='服务类别'", false) %>
            </td>
			
			<td>
			     <input type="text" class="text_field" name="service_code" inputName="服务编码" maxLength="50" style="width:120px;" value="<bean:write name="data" property="service_code"/>" />
			</td>
			
			<td>
			     <input type="text" class="text_field" name="service_name" inputName="服务名称" maxLength="50" style="width:180px;" value="<bean:write name="data" property="service_name"/>" />
            </td>
            
			<td>
			     <input type="text" class="text_field" name="remark" inputName="备注" maxLength="50" style="width:120px;" value="<bean:write name="data" property="remark"/>" />
            </td>
		</tr>
</logic:iterate>
            <script type="text/javascript">
                            
                            var rIndex=0;
                            
                             //新增大类行
                            function addfwTableRow(){
                                var obj=document.getElementById("fwTab");
                                var fuwuselect = "<%=fwlb%>";
                                rIndex++;
                                //添加行
                                var rownum = obj.rows.length;
                                var tr0=obj.insertRow(rownum);
                                tr0.setAttribute("id","fwTabTr"+rIndex);
                                //添加单元格
                                var td0 = tr0.insertCell(0);
                                td0.innerHTML="<input type='checkbox' name='checkbox_template' value='fwTabTr"+rIndex+"'/>"
                                               +"<input type='hidden' name='fw_id' value='fwTabTr"+rIndex+"'/> ";
                                //添加单元格
                                var td1 = tr0.insertCell(1);
                                td1.innerHTML="<faerp:cityTag  attribute='city_id' tagname='city_id'/>";
                                //添加单元格
                                var td2 = tr0.insertCell(2);
                                td2.innerHTML=fuwuselect;
                                //添加单元格
                                var td3 = tr0.insertCell(3);
                                td3.innerHTML="<input type='text' class='text_field' name='service_code' inputName='服务编号' maxLength='50' style='width:120px;' value=''/>";
                                //添加单元格
                                var td4 = tr0.insertCell(4);
                                td4.innerHTML="<input type='text' class='text_field' name='service_name' inputName='服务名称' maxLength='50' style='width:180px;' value=''/>";
                                //添加单元格
                                var td5= tr0.insertCell(5);
                                td5.innerHTML="<input type='text' class='text_field' name='remark' inputName='备注' maxLength='50' style='width:120px;' value=''/>";
                               
                                
                            }
                            
                            //从单选框中标记删除一条大类记录
                            function deleteFw_onClick(){  
                                var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
                                if(ids == null) {  //如果ids为空
                                    alert('请至少选择一条服务记录');
                                    return;
                                }
                                if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
                                    //删除页面记录
                                    var ids_str='';
                                    var obj=document.getElementById("fwTab");
                                    for(var i=0;i<ids.length;i++){  //循环checkbox组
                                        var fwid=ids[i];
                                        var j=document.getElementById(fwid).rowIndex;
                                        obj.deleteRow(j);
                                        ids_str=ids_str+ids[i];
                                        if(i<ids.length-1){
                                            ids_str=ids_str+",";
                                        }
                                    }
                                    //数据库删除
                                    validateDeleteFw(ids_str);
                                }
                                    
                            }
                                
                            //ajax删除大类记录
                            function validateDeleteFw(ids){
                                   var flags=true;
                                       jQuery.ajax({
                                url: '<%=request.getContextPath()%>/PbserviceAction.do?cmd=deleteFw&ids='+ids,
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
                                    }
                                }
                                });return flags;
                            }
                            
                            //保存大类列表
                            function saveFw_onClick(){  //保存修改后的单条数据
                                var elementCheckbox = document.getElementsByName("checkbox_template");
                                if(elementCheckbox==null || elementCheckbox.length==0){
                                    alert('服务列表为空，请至少新增一条后保存！');
                                    return;
                                }
                                form1.action="<%=request.getContextPath()%>/PbserviceAction.do?cmd=saveFw";
                                form1.submit();
                            }
            </script>
</table>
</div>

 <div class="mx_button">
        <table  width="100%" cellspacing="0"  class="datagrid1">
          <tr>
            <td align=center><input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="saveFw_onClick();" />
            </td>
          </tr>
      </table>
        
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
<%  //表单回写
	if(request.getAttribute(IPbserviceConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPbserviceConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
