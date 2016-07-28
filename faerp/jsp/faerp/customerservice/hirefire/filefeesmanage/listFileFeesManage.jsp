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
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		var url="<%=request.getContextPath()%>/FileFeesManageAction.do?cmd=find&id="+ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 900, 300, "修改档案费管理"); 
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/FileFeesManageAction.do?cmd=deleteMulti&ids=" + ids;
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell").loadData();
        $id("datacell").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		//form.action="<%=request.getContextPath()%>/jsp/faerp/customerservice/hirefire/filefeesmanage/insertFileFeesManage.jsp";
		//form.submit();
		var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/hirefire/filefeesmanage/insertFileFeesManage.jsp";
        url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 900, 300, "新增档案费管理"); 
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
		var url="<%=request.getContextPath()%>/FileFeesManageAction.do?cmd=detail&id="+ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 900, 300, "查看档案费管理"); 
	}
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' id='checkbox_template'  value=" + entity.getProperty("id") + ">";
    }
    
    function checkAllList() {
      var element = document.getElementsByName("checkbox_template"); 
      for(var i=0;i<element.length;i++){
         if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
           element[i].checked= !element[i].checked ? true : false;
          }
       } 
    }
    
    function exportExcel_onClick()
	{
	  if(confirm('是否确定要导出数据？')) {
	      document.form.action="<%=request.getContextPath()%>/FileFeesManageAction.do?cmd=exportToExcelFileFees";
	      document.form.submit();
      }
	}
	
	function importExcel_onClick()
    {
         var url = "/FAERP/jsp/faerp/customerservice/hirefire/filefeesmanage/importExcel.jsp";
         showModalCenter(url, window,simpleQuery_onClick,350,200,"导入档案费");
    }

</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
	writeTableTopFesco('档案费管理查询','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="right">员工姓名</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" id="emp_name" inputName="员工姓名" maxLength="50"/>
			</td>
			<td align="right">唯一号</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code" id="emp_code" inputName="唯一号" maxLength="25"/>
			</td>
			<td align="right">证件号码</td>
			<td align="left">
				<input type="text" class="text_field" name="id_card" id="id_card" inputName="证件号码" maxLength="64"/>
			</td>
		</tr>
		<tr>
			<td align="right">缴费开始日期</td>
			<td align="left">
				<w:date format="yyyy-MM-dd" name="start_date_from" id="start_date_from" width="80px" /> 到 <w:date format="yyyy-MM-dd" name="start_date_to" id="start_date_to" width="80px" />
			</td>
			<td align="right">缴费结束日期</td>
			<td align="left">
				<w:date format="yyyy-MM-dd" name="end_date_from" id="end_date_from" width="80px" /> 到 <w:date format="yyyy-MM-dd" name="end_date_to" id="end_date_to" width="80px" />
			</td>
			<td align="right">缴费金额</td>
			<td align="left">
				<input type="text" class="text_field" name="money_from" inputName="缴费金额" value="" style="width: 90px"/> 到 <input type="text" class="text_field" name="money_to" inputName="缴费金额" value="" style="width: 90px;"/>
			</td>
		</tr>
		<tr>
			<td align="right">缴纳地点</td>
			<td align="left">
				<input type="text" class="text_field" name="payment_place" inputName="缴纳地点" maxLength="1000"/>
			</td>
			<td align="right">数据来源</td>
			<td align="left">
				<d:select dictTypeId="DATE_FROM" name="date_from" id="date_from" nullLabel="--请选择--" />
			</td>
			<td/>
			<td>
				<input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onclick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="reset" value='<fmt:message key="reset"/>'>
			</td>
			</tr>
	</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
	<input class="a" type="button"   value="<fmt:message key="view"/>" onClick="detail_onClick();">
 	<input class="c" type="button"   value="<fmt:message key="insert"/>" onClick="toAdd_onClick();">
 	<input class="b" type="button"   value="<fmt:message key="modify"/>" onClick="findCheckbox_onClick();">
 	<input class="d" type="button"   value="<fmt:message key="delete"/>" onClick="deleteMulti_onClick();">		
 	<input class="e_1" type="button"   value="导入"  onClick="importExcel_onClick();">
    <input class="e" type="button"   value="导出"  onClick="exportExcel_onClick();">
 </div>
 <div class="clear"></div>			
</div> 
<r:datacell 
        id="datacell"
       queryAction="/FAERP/FileFeesManageAction.do?cmd=simpleQuery"       
       isCount="false"
        width="100%"
        xpath="FileFeesManageVo"
        height="320"        
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field allowModify="false" fieldName="id" sortAt="none" label="<input type='checkbox' name='temp' id='temp' value='' onclick='checkAllList();' />" width="50px" onRefreshFunc="setCheckboxStatus" >
       </r:field> 
       <r:field fieldName="cust_code" width="80px" label="客户编号">
       </r:field> 
       <r:field fieldName="cust_name" width="150px" label="客户名称">
       </r:field>   
       <r:field fieldName="emp_name" width="80px" label="员工姓名">
       </r:field> 
       <r:field fieldName="emp_code" width="80px" label="唯一号">
       </r:field> 
       <r:field fieldName="id_card" width="160px" label="证件号码">
       </r:field> 
       <r:field fieldName="start_date" width="100px" label="缴费开始日期" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field> 
       <r:field fieldName="end_date" width="100px" label="缴费结束日期" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field>
       <r:field fieldName="money" width="80px" label="缴费金额">
       </r:field>
       <r:field fieldName="payment_place" width="100px" label="缴纳地点">
       </r:field>  
       <r:field fieldName="date_from" width="60px" label="数据来源" allowModify="false">
       <d:select dictTypeId="DATE_FROM" />
       </r:field>  
       <r:field fieldName="remark" width="130px" label="备注">
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
