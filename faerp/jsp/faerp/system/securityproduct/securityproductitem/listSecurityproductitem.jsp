<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.securityproductitem.vo.SecurityproductitemVo" %>
<%@ page import="rayoo.system.securityproductitem.util.ISecurityproductitemConstants" %>
<%  //取出List
    String security_product_id=request.getAttribute("security_product_id")==null ? "" : request.getAttribute("security_product_id").toString();
    String city_id=request.getAttribute("city_id")==null ? "" : request.getAttribute("city_id").toString();
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISecurityproductitemConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISecurityproductitemConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SecurityproductitemVo resultVo = null;  //定义一个临时的vo变量
%>
<html>

<script type="text/javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
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
		form.action="<%=request.getContextPath()%>/SecurityproductitemAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	 //从多选框删除多条记录
	function deleteMulti_onClick(){ 
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		var arrayObj = new Array(); 
         function selectIdCount(){
         selecCount=0;
         var idTag=  document.getElementsByName("checkbox_template");
          for(i=0;i<idTag.length;i++)
          {
            if(idTag[i].checked==true){
              selecCount++;
              arrayObj.push(idTag[i].value);
              }
          }
         }
         selectIdCount();
           if(selecCount<1)
           {  alert('请选择一条以上的记录');
           return;
           }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	        for(var i =0;i<arrayObj.length;i++){
	        //alert(arrayObj[i]);
	        $("#tr"+arrayObj[i]).remove();
	        }
		}
	}
	
	
	
	    //从多选框删除多条记录
    function deleteMulti_onClick1(){ 
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        var arrayObj = new Array(); 
         function selectIdCount(){
         selecCount=0;
         var idTag=  document.getElementsByName("checkbox_template");
          for(i=0;i<idTag.length;i++)
          {
            if(idTag[i].checked==true){
              selecCount++;
              arrayObj.push(idTag[i].value);
              }
          }
         }
         selectIdCount();
           if(selecCount<1)
           {  alert('请选择一条以上的记录');
           return;
           }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            for(var i =0;i<arrayObj.length;i++){
            //alert(arrayObj[i]);
            $("#tr1"+arrayObj[i]).remove();
            }
        }
    }
	
	function update_onClick(){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        form.action="<%=request.getContextPath()%>/SecurityproductitemAction.do?cmd=update";
        form.submit();
    }
    
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
  	var number=0;
  	var number1=0;
	function toAdd_onClick() {  //到增加记录页面
	number++;
	jQuery("#tab").append("<tr id=\"tr"+number+"\"><td class=\"fex_row\"> <input type=\"checkbox\" name=\"checkbox_template\"  value=\""+number+"\"/></td><td><input type=\"text\" class=\"text_field\" name=\"start_month\" style=\"width:80px;\" maxLength=\"7\" /></td><td><input type=\"text\" class=\"text_field\" name=\"end_month\" style=\"width:80px;\" maxLength=\"7\" /></td><td><input type=\"text\" class=\"text_field\" name=\"company_fixed_radix\" style=\"width:80px;\" maxLength=\"7\" /></td><td><input type=\"text\" class=\"text_field\" name=\"personal_fixed_radix\" style=\"width:80px;\" maxLength=\"7\" /></td><td><input type=\"text\" class=\"text_field\" name=\"social_average_salary\" style=\"width:80px;\" maxLength=\"7\" /></td><td><input type=\"text\" class=\"text_field\" name=\"personal_top_radix\" style=\"width:80px;\" maxLength=\"7\" /></td><td><input type=\"text\" class=\"text_field\" name=\"personal_low_base\" style=\"width:80px;\" maxLength=\"7\" /></td><td><input type=\"text\" class=\"text_field\" name=\"company_top_radix\" style=\"width:80px;\" maxLength=\"7\" /></td><td><input type=\"text\" class=\"text_field\" name=\"company_low_radix\" style=\"width:80px;\" maxLength=\"7\" /></td></tr>");    
	}
	
	
	function toAdd_onClick1() {  //到增加记录页面
    number1++;
    jQuery("#tab1").append("<tr id=\"tr1"+number1+"\"><td class=\"fex_row\"> <input type=\"checkbox\" name=\"checkbox_template\"  value=\""+number1+"\"/></td><td><select id=\"pb_security_group"+number1+"\" name=\"pb_security_group_id\"></td></tr>");    
	SecurityGroupAjax.getCitySecurityGroup('<%=city_id%>',{callback:function(data){
                   setSelectForBean("pb_security_group"+number1,data,"id","group_name","");
               }
           });
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
		form.action="<%=request.getContextPath()%>/SecurityproductitemAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}


    function cancel_onClick(){  //返回
        form.action="<%=request.getContextPath()%>/SecurityproductAction.do?cmd=queryAll";
        form.submit();
    }
    
     
    

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/SecurityproductitemAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="security_product_id" value="<%=security_product_id%>">
 <input type="hidden" name="city_id" value="<%=city_id%>">
 
<div id="right">

<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">			
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
				</ul>
		 </div>
           <div class="clear"></div>			
</div>
 <div id="values_div" class="box_xinzeng_table" style="margin-left:10px;"> 
<table  id="tab" width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onClick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"start_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"start_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"start_month")%>">
           	</a>	
			 起始月</th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"end_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"end_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"end_month")%>">
           	</a>	
			 终止月</th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_fixed_radix")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_fixed_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_fixed_radix")%>">
           	</a>	
			 企业固定基数</th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"personal_fixed_radix")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"personal_fixed_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"personal_fixed_radix")%>">
           	</a>	
       
			 个人固定基数</th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"social_average_salary")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"social_average_salary")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"social_average_salary")%>">
           	</a>	
       
			 社会平均工资</th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"personal_top_radix")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"personal_top_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"personal_top_radix")%>">
           	</a>	
			 个人最高基数</th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"personal_low_base")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"personal_low_base")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"personal_low_base")%>">
           	</a>	
			 个人最低基数</th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_top_radix")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_top_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_top_radix")%>">
           	</a>	
			 企业最高基数</th>
			<th>
			  	<a href="/FAERP/SecurityproductitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_low_radix")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_low_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_low_radix")%>">
           	</a>	
			 企业最低基数</th>
			</tr>
			<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
					<tr id="tr<bean:write name="data" property="id"/>">
					<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>
						<td><input type="text" class="text_field" name="start_month" style="width:80px;"  value="<bean:write name="data" property="start_month"/>" maxLength="7" /></td>
						<td><input type="text" class="text_field" name="end_month" style="width:80px;"  value="<bean:write name="data" property="end_month"/>" maxLength="7" /></td>
						<td><input type="text" class="text_field" name="company_fixed_radix" style="width:80px;"  value="<bean:write name="data" property="company_fixed_radix"/>" maxLength="7" /></td>
						<td><input type="text" class="text_field" name="personal_fixed_radix" style="width:80px;"  value="<bean:write name="data" property="personal_fixed_radix"/>" maxLength="7" /></td>
						<td><input type="text" class="text_field" name="social_average_salary" style="width:80px;"  value="<bean:write name="data" property="social_average_salary"/>" maxLength="7" /></td>
						<td><input type="text" class="text_field" name="personal_top_radix" style="width:80px;"  value="<bean:write name="data" property="personal_top_radix"/>" maxLength="7" /></td>
						<td><input type="text" class="text_field" name="personal_low_base" style="width:80px;"  value="<bean:write name="data" property="personal_low_base"/>" maxLength="7" /></td>
			            <td><input type="text" class="text_field" name="company_top_radix" style="width:80px;"  value="<bean:write name="data" property="company_top_radix"/>" maxLength="7" /></td>
			            <td><input type="text" class="text_field" name="company_low_radix" style="width:80px;"  value="<bean:write name="data" property="company_low_radix"/>" maxLength="7" /></td>
						</tr>
			</logic:iterate>
</table>
</div>


<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="c">      <a onClick="javascript:toAdd_onClick1();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick1();"><fmt:message key="delete"/> </a> </li>
                </ul>
         </div>
           <div class="clear"></div>            
</div>

 <div  class="box_xinzeng_table" style="margin-left:10px;"> 
      <table   id="tab1" width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th width="4%"  class="fex_row"><input type='checkbox' onClick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
     <th width="96%" align="left">所属社保组</th>
<td width="5%">
        <logic:iterate     name="securitygrouprelbeans"  id="relbeans" scope="request" indexId="indexs">
        <bean:define id="securitygroupid" name="relbeans" property="security_group_id"/>
        <tr id="tr1<bean:write name="relbeans" property="id"/>">
		<td class="fex_row"> 
		    <input type="checkbox" name="checkbox_template" value="<bean:write name="relbeans" property="id"/>" displayName=""/></td>
            <td><select  name="pb_security_group_id"> 
            <logic:iterate     name="securitygroupbeans"  id="groupbeans" scope="request" indexId="indexs">
            <bean:define id="securitygroup_id" name="groupbeans" property="id"/>
            <option value='<bean:write name="groupbeans" property="id"/>' <%if(securitygroup_id.equals(securitygroupid))out.print(" selected "); %>><bean:write name="groupbeans" property="group_name"/></option>
            </logic:iterate>
            </select>
            </td>
        </tr>
        </logic:iterate>
        
        
        
</table>
</div>

      <div style="text-align:center; margin-top:10px;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:update_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
      </div>
      <p>
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
	if(request.getAttribute(ISecurityproductitemConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISecurityproductitemConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
