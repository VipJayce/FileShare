<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.customersimple.vo.CustomersimpleVo"%>
<%@ page import="rayoo.sales.customersimple.util.ICustomersimpleConstants"%>
<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(ICustomersimpleConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(ICustomersimpleConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    CustomersimpleVo resultVo = null; //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.salse.customersimple.customersimple_resource" prefix="rayoo.salse.customersimple.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
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
		var url = "<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=find&id="+ids+"&_ts="+(new Date()).getTime();
		window.open(url,'','height=430px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改客户简档');
        //showModalCenter(url, window, callBack, 900, 430, "修改客户简档"); 
		//form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		//form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=toAdd";
		//form.submit();
		var url = "<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=toAdd&_ts="+(new Date()).getTime();
		window.open(url,'','height=430px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增客户简档');
        //showModalCenter(url, window, callBack, 900, 430, "新增客户简档"); 
		//MyWin.Create('','修改客户简档','<%=request.getContextPath()%>/jsp/faerp/sales/customersimple/insertCustomersimple.jsp','920','470','100','30');
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
		var url = "<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=detail&id="+ids+"&_ts="+(new Date()).getTime();
		window.open(url,'','height=430px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看客户简档');
        //showModalCenter(url, window, callBack,  900, 430, "查看客户简档"); 
		//form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?id=" + ids;
		//form.cmd.value = "detail";
		//form.submit();
	}

     function exportExcel_onClick(){  //导出Excel
        oldCmd = form.cmd.value;
        form.cmd.value = "exportExcel";
        form.submit();
    }  
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    function callBack(reg){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
</script>
	</head>
	<body>

	<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CustomersimpleAction.do">
	<input type="hidden" name="cmd" value="queryAll">
    <input type="hidden" name="backFlag" id="backFlag" value="true">

	<div id="right"><script language="javascript">
	writeTableTopFesco('<fmt:message key="customersimple_name"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">


	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">

		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key="query_conditions"/></div>
			</td>
        </tr>
        <tr>
            <td align="left"><fmt:message key="customer_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="customer_code" value="" inputName="客户编号" maxLength="25"/>
            </td>
            <td align="left"><fmt:message key="customer_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="customer_name" value="" inputName="客户名称" maxLength="50"/>
            </td>
            <td></td>
         </tr>
         <tr>
            <td align="left"><fmt:message key="customer_service_name"/></td>
            <td align="left">
                <r:comboSelect id="service" name="customer_service1" queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=0"
                textField="name" valueField="partyid" xpath="Partyrelation" width="200px" messagekey="please_choose" />
            </td>
            <td align="left"><fmt:message key="handover_date"/></td>
            <td align="left">
                <w:date allowInput="true" id="handover_date_from" name="handover_date_from" format="YYYY-MM-DD" style=" width:70px"/>
                &nbsp;<fmt:message key="to"/>&nbsp;
                <w:date allowInput="true" id="handover_date_to" name="handover_date_to" format="YYYY-MM-DD"  style=" width:70px"/>               
            </td>
			<td>
			     <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"> 
			     <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()"></td>
			</td>
		</tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
	<!--<ul>                   
                    <li class="a">   <a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
                     <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li> 
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    <li class="e">   <a  onClick="javascript:exportExcel_onClick();"><fmt:message key="export"/> </a> </li>
                    
	</ul>

	-->
	<input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="s_cust_view" type="1"/>  onClick="detail_onClick();">
	<input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="s_cust_modify" type="1"/>  onClick="findCheckbox_onClick();">
	<input class="e" type="button"   value="<fmt:message key="export"/>"  <au:authorityBtn code="cs_cust_exp" type="1"/>  onClick="exportExcel_onClick();">
	</div>
	<div class="clear"></div>
	</div>

    <div style="padding: 8 10 8 8;">
        <r:datacell id="datacell1" queryAction="/FAERP/CustomersimpleAction.do?cmd=queryCustomerSimpleData" width="98%" height="318px" xpath="CustomersimpleVo" paramFormId="datacell_formid">
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
        <r:field fieldName="customer_name" messagekey="customer_name" width="250px"></r:field>
        <r:field fieldName="customer_code" messagekey="customer_code" ></r:field>
        <r:field fieldName="customer_service1" messagekey="customer_service_name" ></r:field>
        <r:field fieldName="handover_date" messagekey="handover_date" allowModify="false">
            <w:date format="YYYY-MM-DD"/>
        </r:field>
        <r:field fieldName="is_swhtyj" messagekey="is_swhtyj" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"></d:select>
        </r:field>
        <r:field fieldName="is_hkxyyj"  messagekey="is_hkxyyj" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"></d:select>
        </r:field>
        <r:field fieldName="is_zzjgdmzfyj" messagekey="is_zzjgdmzfyj" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"></d:select>
        </r:field>
        <r:field fieldName="is_yyzzfyj" messagekey="is_yyzzfyj" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"></d:select>
        </r:field>
        <r:field fieldName="is_wspzzsfyj" messagekey="is_wspzzsfyj" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"></d:select>
        </r:field>
        <r:field fieldName="is_htpsb" messagekey="is_htpsb" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"></d:select>
        </r:field>
        <r:field fieldName="is_bjdpsb" messagekey="is_bjdpsb" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"></d:select>
        </r:field>
        <r:field fieldName="is_sprzrymd" messagekey="is_sprzrymd" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"></d:select>
        </r:field>
        <r:field fieldName="customer_simple_create_user" messagekey="customer_simple_create_user"></r:field>
        <r:field fieldName="customer_simple_create_date" messagekey="customer_simple_create_date" allowModify="false">
            <w:date format="YYYY-MM-DD"/>
        </r:field>
        <r:field fieldName="customer_simple_remarks" messagekey="customer_simple_remarks"></r:field>
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
<%  //表单回写
	if(request.getAttribute(ICustomersimpleConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICustomersimpleConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
