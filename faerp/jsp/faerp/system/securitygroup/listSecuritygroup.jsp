<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.securitygroup.vo.SecuritygroupVo" %>
<%@ page import="rayoo.system.securitygroup.util.ISecuritygroupConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	int size=0;
	if(request.getAttribute(ISecuritygroupConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISecuritygroupConstants.REQUEST_BEANS);  //赋值给resultList
		size = lResult.size();
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SecuritygroupVo resultVo = null;  //定义一个临时的vo变量
	
	
    //String city_id1= (request.getAttribute("city_id1")!=null) ? request.getAttribute("city_id1").toString() : "";
    String groupname=(request.getAttribute("group_name")!=null) ? request.getAttribute("group_name").toString() : "";
    String serviceid=(request.getAttribute("service_id")!=null) ? request.getAttribute("service_id").toString() : "";
    String adjustmonth=(request.getAttribute("adjust_month")!=null) ? request.getAttribute("adjust_month").toString() : "";
    String transactday_from=(request.getAttribute("transact_day_from")!=null) ? request.getAttribute("transact_day_from").toString() : "";
    String transactday_to=(request.getAttribute("transact_day_to")!=null) ? request.getAttribute("transact_day_to").toString() : "";
    String stopday_from=(request.getAttribute("stop_day_from")!=null) ? request.getAttribute("stop_day_from").toString() : "";
    String stopday_to=(request.getAttribute("stop_day_to")!=null) ? request.getAttribute("stop_day_to").toString() : "";
	//组类别
	String group_type=RmJspHelper.getSelectField("group_type_bd1", -1,"GROUP_TYPE_BD","1","style='width:100px' inputName='组类别'",false);
    //补缴月类型
	String supply_month_type=RmJspHelper.getSelectField("supply_month_type_bd1", -1,"SUPPLY_MONTH_TYPE_BD","1","style='width:100px' inputName='补缴月类型'",false);
    //保险托收
	String ss_collection_type=RmJspHelper.getSelectField("ss_collection_type_bd1", -1,"SS_COLLECTION_TYPE","1"," style='width:100px' inputName='保险托收' ",false);
    //保险托收方式
	String collection_type=RmJspHelper.getSelectField("collection_type_bd1", -1,"COLLECTION_TYPE_BD","1","style='width:100px' inputName='保险托收方式'",false);
    //默认显示
	String is_default=RmJspHelper.getSelectField("is_default_show1", -1,"TrueOrFalse","1","style='width:100px' inputName='默认显示'",false);
	//绑定基数
	String bind_radix=RmJspHelper.getSelectField("bind_radix_bd1", -1,"TrueOrFalse","1","style='width:100px' inputName='绑定基数'",false);
	//使用账号序号
	String use_account_or_num=RmJspHelper.getSelectField("use_account_or_num_bd1", -1,"USE_ACCOUNT_OR_NUM","1","style='width:100px' inputName='使用账号序号'",false);
	//企业支付方式
	String e_pay_policy=RmJspHelper.getSelectField("e_pay_policy_bd1", -1,"E_PAY_POLICY_BD","1","style='width:100px' inputName='企业支付方式'",false);
	//个人支付方式
	String p_pay_policy=RmJspHelper.getSelectField("p_pay_policy_bd1", -1,"P_PAY_POLICY_BD","1","style='width:100px' inputName='个人支付方式'",false);
	//停办方式
	String stop_month_type=RmJspHelper.getSelectField("stop_month_type_bd1", -1,"STOP_MONTH_TYPE_BD", "1"," style='width:100px;' inputName='停办方式'",false);

%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

    function saveTableData() { 
        if(checkAllForms()){
            form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=insert";
            form.cmd.value="insert";
            form.submit();
        }
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
		form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	
	   function exportToExcel() {  //导出数据
	       if(confirm('是否确定要导出数据？')) {
	        form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=exportToExcel";
	        form.submit();
            }
    }  
    


	
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项

		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/system/securitygroup/insertSecuritygroup.jsp";
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
		form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
	   $("tr").live("click", function(){
	   //alert($(this).attr("id"));
	   checkradio($(this).attr("id"));
	   });
</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/SecuritygroupAction.do">
<input type="hidden" name="cmd" id="cmd" value="queryAll">
 <input type="hidden" id="dlSize" value="<%=size%>" />
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="182" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td width="115"/>
			<td width="185"/>
			  <td width="158">    </td>
            	<td width="291"/>
		</tr>
				<tr>
			<td align="right">省市</td>
			<td align="left"><!-- hasSearchTag="true" -->
				<faerp:cityTag  tagname="city_id1" beanname="city_id1" className="sSelect"/></td>
			<td align="right">社保组名称</td>
			<td align="left"><input type="text" class="text_field" name="group_name" inputName="社保组名称" maxLength="50" value="<%=groupname%>"/>            </td>
			<td width="102" align="right">入职服务名称</td>
			<td width="304" align="left"><input type="text" class="text_field" name="service_id" inputName="入职服务名称" maxLength="50" value="<%=serviceid%>"/></td>
		</tr>
		
		
		<tr>
			<td align="right">年度调整月</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_month" inputName="年度调整月" maxLength="50" value="<%=adjustmonth%>"/>			</td>
			<td align="right">办理截止日</td>
						<td align="left">
			  <input type="text" class="text_field"  style="width:50px" name="transact_day_from" value="<%=transactday_from%>" id="transact_day_from" inputName="每月办理截止日"/>&nbsp;到&nbsp;<input type="text" class="text_field" style="width:50px" name="transact_day_to" value="<%=transactday_to%>"  id="transact_day_to" inputName="每月办理截止日"/></td>
			<td align="right">停办截止日</td>
						<td align="left">
				<input type="text" class="text_field"  style="width:50px" name="stop_day_from" value="<%=stopday_from%>" id="stop_day_from" inputName="每月停办截止日"/>&nbsp;到&nbsp;<input type="text" class="text_field" style="width:50px" name="stop_day_to" value="<%=stopday_to%>" id="stop_day_to" inputName="每月停办截止日"/></td>
		</tr>
		
		<tr>
			<td/>
			<td/>
			  <td>&nbsp;</td>
            	<td/><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
                    <li class="bc">     <a onClick="javascript:saveTableData();"><fmt:message key="save"/> </a></li>
					<li class="c">     <a onClick="javascript:adddlTableRow();"><fmt:message key="insert"/> </a></li>
					<li class="d">     <a onClick="javascript:deleteDl_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="e_3">   <a href="###" id="a_exp">导出分组</a> </li>
					
					<!--
					<li class="a">      <a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    <li class="e_3">   <a onClick="javascript:exportToExcel();">导出分组</a> </li>
                     -->
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1" id="dlTab">
<tr>
<th>&nbsp;</th><!--  -->
<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"city_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"city_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"city_id")%>">
           	</a>	
       
			 省市</th>
			<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"group_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"group_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"group_name")%>">
           	</a>	社保组名称</th>
			<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_id")%>">
           	</a>	入职服务名称</th>
			<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"group_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"group_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"group_type_bd")%>">
           	</a>	 组类别</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"adjust_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"adjust_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"adjust_month")%>">
           	</a>	年度调整月</th>
			<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"transact_day")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"transact_day")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"transact_day")%>">
           	</a>每月办理截止日</th>
			<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"stop_day")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"stop_day")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"stop_day")%>">
           	</a>	每月停办截止日</th>
			<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ss_collection_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ss_collection_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ss_collection_type_bd")%>">
           	</a>	保险托收</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"collection_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"collection_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"collection_type_bd")%>">
           	</a>	保险托收方式</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"stop_month_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"stop_month_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"stop_month_type_bd")%>">
           	</a>	停办方式</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"supply_month_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"supply_month_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"supply_month_type_bd")%>">
           	</a>	补缴月类型</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_default_show")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_default_show")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_default_show")%>">
           	</a>	默认显示</th>
			<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bind_radix_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bind_radix_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bind_radix_bd")%>">
           	</a>	绑定基数</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"use_account_or_num_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"use_account_or_num_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"use_account_or_num_bd")%>">
           	</a>	 使用账号/序号</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_pay_policy_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_pay_policy_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_pay_policy_bd")%>">
           	</a>	企业支付方式</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_pay_policy_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_pay_policy_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_pay_policy_bd")%>">
           	</a>	 个人支付方式</th>
     	<th><a href="/FAERP/SecuritygroupAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"explanation")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"explanation")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"explanation")%>">
           	</a>	说明</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<input type="hidden" name="tableid1" value="<bean:write name="data" property="id"/>">
		<tr  id="tr<bean:write name="data" property="id"/>" name="tr">
		<td >
		<input type="radio" name="radio_template"  value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>" onclick="showSmalldiv('<bean:write name="data" property="id"/>');"/>
		</td>
			<td >
			<div  class='select'> <div><faerp:cityTag beanname="data" attribute="city_id" tagname="city_id"  style="width:100px"/></div> </div>
			</td>
			<td ><input type="text" class="text_field" name="group_name1" style="width:100px;"  value="<bean:write name="data" property="group_name"/>" maxLength="7" inputName="社保组名称" validate="notNull;"/>    </td>
			<td><input type="text" class="text_field" name="service_id1" style="width:100px;"  value="<bean:write name="data" property="service_id"/>" maxLength="7" inputName="入职服务名称" validate="notNull;"/>    </td>
			<td >
            <bean:define id="group_type_bd" name="data" property="group_type_bd"/>
            <%//=BaseDataHelper.getNameByCode("GROUP_TYPE_BD",String.valueOf(group_type_bd))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("group_type_bd1", -1, "GROUP_TYPE_BD", String.valueOf(group_type_bd), " style='width:100px;' inputName='停办方式'", false) %>
			</td>		
			<td ><input type="text" class="text_field" name="adjust_month1" style="width:100px;"  value="<bean:write name="data" property="adjust_month"/>" maxLength="7" /> </td>
			<td ><input type="text" class="text_field" name="transact_day1" style="width:100px;"  value="<bean:write name="data" property="transact_day"  format="yyyy-MM-dd"/>" maxLength="7" />   </td>
			<td ><input type="text" class="text_field" name="stop_day1" style="width:100px;"  value="<bean:write name="data" property="stop_day"  format="yyyy-MM-dd"/>" maxLength="7" />  </td>
			<td >
            <bean:define id="ss_collection_type_bd" name="data" property="ss_collection_type_bd"/>
            <%//=BaseDataHelper.getNameByCode("SS_COLLECTION_TYPE",String.valueOf(ss_collection_type_bd))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("ss_collection_type_bd1", -1, "SS_COLLECTION_TYPE", String.valueOf(ss_collection_type_bd), " style='width:100px;' inputName='停办方式'", false) %>
            </td>		
			<td >
            <bean:define id="collection_type_bd" name="data" property="collection_type_bd"/>
            <%//=BaseDataHelper.getNameByCode("COLLECTION_TYPE_BD",String.valueOf(collection_type_bd))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("collection_type_bd1", -1, "COLLECTION_TYPE_BD", String.valueOf(collection_type_bd), " style='width:100px;' inputName='停办方式'", false) %>
			</td>		
			<td >
            <bean:define id="stop_month_type_bd" name="data" property="stop_month_type_bd"/>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("stop_month_type_bd1", -1, "STOP_MONTH_TYPE_BD", String.valueOf(stop_month_type_bd), " style='width:100px;' inputName='停办方式'", false) %>
			</td>		
			<td >
            <bean:define id="supply_month_type_bd" name="data" property="supply_month_type_bd"/>
            <%//=BaseDataHelper.getNameByCode("SUPPLY_MONTH_TYPE_BD",String.valueOf(supply_month_type_bd))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("supply_month_type_bd1", -1, "SUPPLY_MONTH_TYPE_BD", String.valueOf(supply_month_type_bd), " style='width:100px;' inputName='停办方式'", false) %>
			 </td>		
			<td >
            <bean:define id="is_default_show" name="data" property="is_default_show"/>
            <%//=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_default_show))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_default_show1", -1, "TrueOrFalse", String.valueOf(is_default_show), " style='width:100px;' inputName='停办方式'", false) %>
			</td>
			<td >
            <bean:define id="bind_radix_bd" name="data" property="bind_radix_bd"/>
            <%//=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(bind_radix_bd))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bind_radix_bd1", -1, "TrueOrFalse", String.valueOf(bind_radix_bd), " style='width:100px;' inputName='停办方式'", false) %>
			</td>		
			<td >
            <bean:define id="use_account_or_num_bd" name="data" property="use_account_or_num_bd"/>
            <%//=BaseDataHelper.getNameByCode("USE_ACCOUNT_OR_NUM",String.valueOf(use_account_or_num_bd))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("use_account_or_num_bd1", -1, "USE_ACCOUNT_OR_NUM", String.valueOf(use_account_or_num_bd), " style='width:100px;' inputName='停办方式'", false) %>
			 </td>		
			<td >
            <bean:define id="e_pay_policy_bd" name="data" property="e_pay_policy_bd"/>
            <%//=BaseDataHelper.getNameByCode("E_PAY_POLICY_BD",String.valueOf(e_pay_policy_bd))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("e_pay_policy_bd1", -1, "E_PAY_POLICY_BD", String.valueOf(e_pay_policy_bd), " style='width:100px;' inputName='停办方式'", false) %>
			  </td>		
			<td >
            <bean:define id="p_pay_policy_bd" name="data" property="p_pay_policy_bd"/>
            <%//=BaseDataHelper.getNameByCode("P_PAY_POLICY_BD",String.valueOf(p_pay_policy_bd))%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("p_pay_policy_bd1", -1, "P_PAY_POLICY_BD", String.valueOf(p_pay_policy_bd), " style='width:100px;' inputName='停办方式'", false) %>
			</td>		
			<td ><input type="text" class="text_field" name="explanation1" style="width:100px;"  value="<bean:write name="data" property="explanation"/>" maxLength="7" />    </td>
			</tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />


<iframe  name="childlistFrame" id="childlistFrame"   frameborder="0" scrolling="yes" width="100%" align="top" height="1%">
</iframe>

</div>
</div>

</form>

<script language="javascript">

     var rIndex=0;
     //新增大类行
     function adddlTableRow(){
         var obj=document.getElementById("dlTab");
         rIndex++;
         //添加行
         var rownum = obj.rows.length;
         var tr0=obj.insertRow(rownum);
         tr0.setAttribute("id","tr"+rIndex);
        // $($("#tr"+rIndex)[0]).bind("click", function(){
         //   checkradio("tr"+rIndex);
        // });
        // tr0.setAttribute("onclick","checkradio('"+rIndex+"');");
         //onclick="checkradio('tr');"
         //添加单元格
         var td0 = tr0.insertCell(0);
         //td0.setAttribute("style","padding: 0px 0px;");
         td0.innerHTML="<input type='radio' name='radio_template' value='"+rIndex+"' onclick='showNewdiv("+rIndex+");'/>"
         +" <input type='hidden' name='tableid1' value=''>";
         //添加单元格
         var td1 = tr0.insertCell(1);
         //td1.setAttribute("style","padding: 0px 0px;");
         td1.innerHTML="<faerp:cityTag  attribute='city_id' tagname='city_id' style='width:100px'/>";
         //添加单元格
         var td2 = tr0.insertCell(2);
         //td2.setAttribute("style","padding: 0px 0px;");
         td2.innerHTML="<input type='text' class='text_field' name='group_name1' inputName='社保组名称' validate='notNull;' maxLength='50' style='width:100px;' value='1'/>";
         //添加单元格
         var td3 = tr0.insertCell(3);
        // td3.setAttribute("style","padding: 0px 0px;");
         td3.innerHTML="<input type='text' class='text_field' name='service_id1' inputName='入职服务名称' validate='notNull;' maxLength='50' style='width:100px;' value='1'/>";
         //添加单元格
         var td4 = tr0.insertCell(4);
        // td4.setAttribute("style","padding: 0px 0px;");
         td4.innerHTML="<%=group_type%>";
         //添加单元格
         var td5 = tr0.insertCell(5);
        // td5.setAttribute("style","padding: 0px 0px;");
         td5.innerHTML="<input type='text' class='text_field' name='adjust_month1' inputName='年度调整月' maxLength='50' style='width:100px;' value='1'/>";
         //添加单元格
         var td6 = tr0.insertCell(6);
        // td6.setAttribute("style","padding: 0px 0px;");
         td6.innerHTML="<input type='text' class='text_field' name='transact_day1' inputName='每月办理截止日' maxLength='50' style='width:100px;' value='1'/>";
          //添加单元格
         var td7 = tr0.insertCell(7);
         //td7.setAttribute("style","padding: 0px 0px;");
         td7.innerHTML="<input type='text' class='text_field' name='stop_day1' inputName='每月停缴截止日' maxLength='50' style='width:100px;' value='1'/>";
         //添加单元格
         var td8 = tr0.insertCell(8);
         //td8.setAttribute("style","padding: 0px 0px;");
         td8.innerHTML="<%=ss_collection_type%>";
         //添加单元格
         var td9 = tr0.insertCell(9);
        // td9.setAttribute("style","padding: 0px 0px;");
         td9.innerHTML="<%=collection_type%>";
         //添加单元格
         var td10 = tr0.insertCell(10);
        // td10.setAttribute("style","padding: 0px 0px;");
         td10.innerHTML="<%=stop_month_type%>";
         //添加单元格
         var td11 = tr0.insertCell(11);
         //td11.setAttribute("style","padding: 0px 0px;");
         td11.innerHTML="<%=supply_month_type%>";
         //添加单元格
         var td12 = tr0.insertCell(12);
        // td12.setAttribute("style","padding: 0px 0px;");
         td12.innerHTML="<%=is_default%>";
         //添加单元格
         var td13 = tr0.insertCell(13);
         //td13.setAttribute("style","padding: 0px 0px;");
         td13.innerHTML="<%=bind_radix%>";
         //添加单元格
         var td14 = tr0.insertCell(14);
        // td14.setAttribute("style","padding: 0px 0px;");
         td14.innerHTML="<%=use_account_or_num%>";
         //添加单元格
         var td15 = tr0.insertCell(15);
        // td15.setAttribute("style","padding: 0px 0px;");
         td15.innerHTML="<%=e_pay_policy%>";
         //添加单元格
         var td16 = tr0.insertCell(16);
        // td16.setAttribute("style","padding: 0px 0px;");
         td16.innerHTML="<%=p_pay_policy%>";
          //添加单元格
         var td17 = tr0.insertCell(17);
         //td17.setAttribute("style","padding: 0px 0px;");
         td17.innerHTML="<input type='text' class='text_field' name='explanation1' inputName='说明' maxLength='50' style='width:100px;' value='1'/>";
     }


    function checkradio(xlid){  //点击行，选中对应的radio
             var trs = document.getElementsByTagName("tr");
             for(var i=1; i<trs.length; i++){
                 var tr = trs[i];
                 tr.className ="";
            }
        var elementRadio = document.getElementsByName("radio_template");  //
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].value==xlid.substring(2)) {  //如果被选中\
                elementRadio[i].checked=true;
                //点击行变颜色
                document.getElementById(xlid).className="hover";
                //得到ID
	            var id=xlid.substring(2);
	            var frame = document.getElementById("childlistFrame"); 
				frame.height = "88%";  
                frame.src="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=getChildTableList&security_group_id="+id+"&date="+new Date();
                break;
            }
        } 
    }
    
    //从单选框中标记删除一条大类记录
    function deleteDl_onClick(){  
            var ids = findSelection("radio_template","id");  //取得单选框的选择项
            if(ids == null) {  //如果ids为空
                alert('<fmt:message key="select_records"/>');
                return;
            }
            var obj=document.getElementById("dlTab");
            if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
                if(ids.indexOf('tr')==-1){
                     //删除页面节点
                     var i=document.getElementById("tr"+ids).rowIndex;
                     obj.deleteRow(i);
                    validateDeleteData(ids);
                }else{
                    //删除页面节点
                     var i=document.getElementById(ids).rowIndex;
                     obj.deleteRow(i);
                }
                //清除右侧对应的小类列表
                //showNewdiv();
            }
            
        }
        
      //ajax逻辑删除记录
      function validateDeleteData(ids){
             var flags=true;
                 jQuery.ajax({
          url: '<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=deleteMulti&ids='+ids,
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
           
      function findSelection(radioName, idName) {  //从radio中找出选中的id值列表
          var elementRadio = document.getElementsByName(radioName);  //
          var ids = null;  //定义id值
          for(var i=0;i<elementRadio.length;i++){  //循环radio组
              if(elementRadio[i].checked) {  //如果被选中
                      ids=elementRadio[i].value;  
                  }
                }
            return ids;
        }                     
        

	$(document).ready(function(){
	    $("#a_exp").bind("click", function(){
	        $("#cmd").val("exportToExcel");
	        $("form").submit();
	       $("#cmd").val("queryAll");
	    });
	});
	
	

	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">
     
<%  //表单回写
	if(request.getAttribute(ISecuritygroupConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISecuritygroupConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
