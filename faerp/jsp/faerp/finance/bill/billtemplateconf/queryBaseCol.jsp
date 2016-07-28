<%@ page contentType="text/html; charset=UTF-8" %>
<script src="<%=request.getContextPath()%>/js/jquery/jquery-1.7.2.min.js"></script>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script src="/js/calendar/bootstrap-datepicker.min.js"></script>
<link href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script>

<script type="text/javascript">
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="rayoo.employeepost.emppostclass.emppostclass_resource" prefix="rayoo.employeepost.emppostclass.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
String company_id=rayoo.common.filter.UserInfoFilter.geCompanyId();
String city_id = (String)request.getAttribute("city_id");
if(city_id==null || "".equals(city_id)){
    city_id = "1099110100000000050";
}
request.setAttribute("city_id",city_id);
%>
<script type="text/javascript">
function callBack(reg){
	$id("datacell1").reload();
    $id("datacell1").refresh();
}

function delete_onClick(){
	var dc = $id("datacell1");
    var entity = dc.getActiveEntity();
    var billColId = entity.getValue("billColId"); 
	if(window.confirm('确定删除？')){
		jQuery.ajax({
	        type : "post",
	        url : "<%=request.getContextPath()%>/BillTemplateConfigAction.do?cmd=delBaseCol&colId=" 
	        		+ billColId,
	        dataType : "html",
	        success : function(data) {
	                    alert(data);
	                    $id("datacell1").reload();
	                    $id("datacell1").refresh();
	          }
	   });
     }else{
        //alert("取消");
        return false;
    }
}

function download(){
	var dc = $id("datacell1");
    var entity = dc.getActiveEntity();
    var templatePath = entity.getValue("templatePath"); 
    if(templatePath==null||templatePath==""){
    	alert("该客户下没有模板可供下载！");
    	return;
    }
	form.action="<%=request.getContextPath()%>/BillTemplateConfigAction.do?templatePath=" + templatePath;
	form.cmd.value = "downLoadTemplate";
	form.submit();
}

function query_onClick(){
	 $id("datacell1").addParam("colName",jQuery("#baseName").val()==null?"":jQuery("#baseName").val()); 
     $id("datacell1").addParam("colCode",jQuery("#baseCode").val()==null?"":jQuery("#baseCode").val()); 
     $id("datacell1").loadData();
     $id("datacell1").refresh();
	
	
	
	 /* var customerName = jQuery("#customerName1").val();
	 var customerCode = jQuery("#customerCode1").val();
	 var costCenterName = jQuery("#costCenterName1").val();
     $id("datacell1").queryAction = "/FAERP/BillTemplateConfigAction.do?cmd=queryTemplateData&customerName"
    		 +encodeURIComponent(customerName)+"&customerCode="+customerCode+"&costCenterName="+costCenterName;
     $id("datacell1").loadData();
     $id("datacell1").refresh(); */
}

function edit_onClick(){  //实现转到详细页面
     var dc = $id("datacell1");
     var entity = dc.getActiveEntity();
     var billColId = entity.getValue("billColId"); 
     var colType = entity.getValue("colType"); 
     var colName = entity.getValue("colName"); 
     var colNameEn = entity.getValue("colNameEn"); 
     var colCode = entity.getValue("colCode")==null?"":entity.getValue("colCode"); 
     var isFixed = entity.getValue("isFixed"); 
     var isTotal = entity.getValue("isTotal"); 
     var parentCol = entity.getValue("parentBillCol")==null?"":entity.getValue("parentBillCol");
     url="<%=request.getContextPath()%>/jsp/faerp/finance/bill/billtemplateconf/baseColAdd.jsp?billColId="
			+billColId+"&col_type="+colType+"&col_name="+encodeURIComponent(colName)
			+"&col_name_en="+colNameEn+"&col_code="+colCode
			+"&is_fixed="+isFixed+"&is_total="+isTotal
			+"&parent_id="+parentCol;
     showModalCenter(url, window, callBack, 500, 360, "编辑基础项");  //增加子岗位    
}



    function detail_onClick(){  //实现转到详细页面
    		var url = "" ;
    	    url="<%=request.getContextPath()%>/jsp/faerp/finance/bill/billtemplateconf/baseColAdd.jsp";
    	    showModalCenter(url, window, callBack, 500, 360, "新增基础项");  //增加子岗位


    }

</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid">
<input type="hidden" name="cmd" value="queryClassList">
<input type="hidden" name="backFlag" value="true">
<input type="hidden" id="company_id" value="<%=company_id %>">


 <input type="hidden" id="cmd1"   name="cmd1" value="queryClassList">
    <input type="hidden"  id="action1"  name="action1" value="EmppostAction.do">
<div id="right">
<script language="javascript">
    writeTableTopFesco("基础项配置");  //显示本页的页眉
</script>

<div class="ringht_s">
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="55" rowspan="10" style="padding-top:0;" nowrap="nowrap"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right">基础项名称</td>
             <td align="left" width="210">
                 <input type="text" class="text_field" name="baseName" id="baseName" inputName="基础项名称" maxLength="50"/>
             </td>
            <td align="right">费用编号</td>
            <td align="left">
             <input type="text" class="text_field" name="baseCode" id="baseCode" inputName="产品ID" maxLength="50"/><font color="red">编号或产品Id</font>&nbsp;
                  </td>
             
        </tr>
</table>
</div>
<div id="ccParent1" class="button">
    <div class="button_right">
        <input class="e" type="button"   value="查询"    onClick="query_onClick();">
    <input class="e" type="button"   value="新增"   onClick="detail_onClick();">
      <input class="e" type="button"   value="编辑"    onClick="edit_onClick();">
      <input class="e" type="button"   value="删除"   onClick="delete_onClick();">
    </div>
    <div class="clear"></div>
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell
        id="datacell1"
        queryAction="/FAERP/BillTemplateConfigAction.do?cmd=queryTemplateBaseData"
        width="78%"
        height="300px"
        xpath="BillCol"
        submitXpath="BillCol"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="billColId" width="0px" label="ID" >
      </r:field>
      <r:field fieldName="colType" width="100px" label="费用类型" >
            <d:select dictTypeId="COL_TYPE"/>
      </r:field>
      <r:field fieldName="colName" width="130px" label="费用名称" >
      </r:field>
       <r:field fieldName="colNameEn" width="130px" label="费用名称英文">
      </r:field>
      <r:field fieldName="colCode"  width="180px" label="费用编号">
      </r:field>
      
      <r:field fieldName="isFixed"  width="100px" label="是否固定项">
      <d:select dictTypeId="IsFixed"/>
      </r:field>
      <r:field fieldName="isTotal"  width="100px" label="是否合计项">
      <d:select dictTypeId="IsTotal"/>
      </r:field>
      <r:field fieldName="parentBillCol"  width="100px" label="费用主项">
      </r:field>

    </r:datacell>
    </div>


</div>
</div>
</form>

</fmt:bundle>

</body>
</html>



