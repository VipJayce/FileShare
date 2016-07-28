<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
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
		var ids = findSelections("temp","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/AddbackapplyAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("temp","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
			$id("datacell").isModefied = false;
	    	document.form.action="<%=request.getContextPath()%>/AddbackapplyAction.do?cmd=deleteMulti&ids=" + ids;
	    	document.form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell").loadData();
        $id("datacell").refresh();
  	}
  	
  	function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='checkbox'  name='temp' id='temp'  value=" + entity.getProperty("id") + " />";
    }
    
    function checkAllList() {
        var element = document.getElementsByName("temp"); 
        for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="temp") {
             element[i].checked= !element[i].checked ? true : false;
            }
         } 
      }
  	
	function toAdd_onClick() {  //到增加记录页面
		//form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/addbackapply/insertAddbackapply.jsp";
		//form.submit();
		var url="<%=request.getContextPath()%>/jsp/faerp/insurance/addbackapply/insertAddbackapply.jsp";
        url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 500, 250, "生成加退保查询"); 
	}
	
	function toexp_onClick() {
		if(confirm('是否确定要导出数据？')) {
      		document.form.action="<%=request.getContextPath()%>/AddbackapplyAction.do?cmd=exportDate";
	    	document.form.submit();
      	}
	}
	
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("temp","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/AddbackapplyAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
	function rtnFunc(arg){
        var lookup = $id("cust_id");
        //alert(arg[0]+","+arg[1]+","+arg[2]);
        lookup.value = arg[0];
        lookup.displayValue = arg[2];      
        return false;
    }
    
    function rtnFuncForPolicy(arg){
        var lookup = $id("policy_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];   
        return false ;
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
	writeTableTopFesco('加退保查询','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="right">客户名称</td>
			<td align="left">
				<w:lookup onReturnFunc="rtnFunc" name="cust_id" lookupWidth="189px" id="cust_id" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="500" width="610"/>
			</td>
			<td align="right">员工姓名</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_id" id="emp_id" maxLength="9.5"/>
			</td>
			<td align="right">产品名称</td>
			<td align="left">
				<input type="text" class="text_field" name="product_id" id="product_id" maxLength="9.5"/>
			</td>
		</tr>
		<tr>
			<td align="right">结算年月</td>
			<td align="left">
				<input type="text" class="text_field" name="settlement_date_from" id="settlement_date_from" style="width: 90px;" /> 到 <input type="text" class="text_field" name="settlement_date_to" id="settlement_date_to" style="width: 90px;" />
			</td>
			<td align="right">投保价</td>
			<td align="left">
				<input type="text" class="text_field" name="insure_price" id="insure_price" decimalDigits="4" />
			</td>
			<td align="right">金额</td>
			<td align="left">
				<input type="text" class="text_field" name="preservation" id="preservation" decimalDigits="4" />
			</td>
		</tr>
		<tr>
			<td align="right">保险状态</td>
			<td align="left">
				<d:select dictTypeId="INSURANCE_STATUS_BD" id="insurance_status_bd" name="insurance_status_bd" nullLabel="--请选择--" />
			</td>
			<td align="right">生成结算类型</td>
			<td align="left">
				<d:select dictTypeId="SETTLEMENT_TYPE_BD" id="settlement_type_bd" name="settlement_type_bd" nullLabel="--请选择--" />
			</td>
			<td align="right">保险开始日期</td>
			<td align="left">
				<w:date format="yyyy-MM-dd" name="start_date_from" id="start_date_from" width="80px" /> 到 <w:date format="yyyy-MM-dd" name="start_date_to" id="start_date_to" width="80px" />
			</td>
		</tr>
		
		<tr>
            <td align="right">保险结束日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="end_date_from" id="end_date_from" width="80px" /> 到 <w:date format="yyyy-MM-dd" name="end_date_to" id="end_date_to" width="80px" />
            </td>
            <td align="right">请选择保单</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncForPolicy" readonly="true" id="policy_name" name="policy_name" lookupUrl="/PolicyAction.do?cmd=toPolicyLookup"  dialogTitle="选择保单" height="480"  width="770"/>
            </td>
            <td align="center" colspan="2">
                <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onclick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="reset" value='<fmt:message key="reset"/>'>
            </td>
        </tr>
	</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
	<input class="c" type="button"   value="生成" onClick="toAdd_onClick();">
	<input class="e" type="button"   value="导出" onClick="toexp_onClick();">
	<input class="d" type="button"   value="删除" onClick="deleteMulti_onClick();">
 </div>
           <div class="clear"></div>			
</div>
<r:datacell 
        id="datacell"
       queryAction="/FAERP/AddbackapplyAction.do?cmd=simpleQuery"       
       isCount="false"
        width="100%"
        xpath="AddbackapplyVo"
        height="320"        
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field allowModify="false" fieldName="id" sortAt="none" label="<input type='checkbox' name='checkbox_template' id='checkbox_template' value='' onclick='checkAllList();' />" width="50px" onRefreshFunc="setCheckboxStatus" >
       </r:field>   
       <r:field fieldName="cust_name" width="100px" label="客户名称">
       </r:field> 
       <r:field fieldName="emp_name" width="100px" label="员工姓名">
       </r:field> 
       <r:field fieldName="product_name" width="140px" label="产品名称">
       </r:field> 
       <r:field fieldName="settlement_date" width="100px" label="结算年月">
       </r:field> 
       <r:field fieldName="insure_price" width="100px" label="投保价">
       </r:field> 
       <r:field fieldName="preservation" width="100px" label="金额">
       </r:field>
       <r:field fieldName="insurance_status_bd" width="100px" label="保险状态" allowModify="false">
       <d:select dictTypeId="INSURANCE_STATUS_BD" />
       </r:field>
       <r:field fieldName="settlement_type_bd" width="100px" label="生成类型" allowModify="false">
       <d:select dictTypeId="SETTLEMENT_TYPE_BD" />
       </r:field>  
       <r:field fieldName="start_date" width="100px" label="保险开始日期" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field> 
       <r:field fieldName="end_date" width="100px" label="保险结束日期" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field> 
    </r:datacell>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
