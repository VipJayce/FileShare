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
	form.action="<%=request.getContextPath()%>/BillTemplateConfigAction.do?cmd=getTemplateData&templateId="
			+"&templateType="+reg[2]+"&customerName="+encodeURIComponent(reg[4])
			+"&costCenterName="+encodeURIComponent(reg[3])+"&customerCode="+reg[0]+"&costCenterId="+reg[1]
	+"&customerId="+reg[5];
	form.submit();
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
	 $id("datacell1").addParam("customerName",jQuery("#customerName1").val()); 
     $id("datacell1").addParam("customerCode",jQuery("#customerCode1").val()); 
     $id("datacell1").addParam("costCenterName",jQuery("#costCenterName1").val()); 
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
     var templateId = entity.getValue("templateId"); 
     var rowIndex = entity.getValue("rowIndex"); 
     var appName = entity.getValue("appName"); 
     var titleRows = entity.getValue("titleRows"); 
     var beginTime = entity.getValue("effectiveTime"); 
     var historyDateType = entity.getValue("historyDateType"); 
     var customerName = entity.getValue("customerName"); 
     var costCenterName = entity.getValue("costCenterName")==null?"":entity.getValue("costCenterName"); 
     var customerCode = entity.getValue("customerCode"); 
     var costCenterId = entity.getValue("costCenterId")==null?"":entity.getValue("costCenterId"); 
     var customerId = entity.getValue("customerId"); 
     form.action="<%=request.getContextPath()%>/BillTemplateConfigAction.do?cmd=getTemplateData&templateId="
			+templateId+"&rowIndex="+rowIndex+"&appName="+appName
			+"&titleRows="+titleRows+"&beginTime="+beginTime
			+"&historyDateType="+historyDateType+"&customerName="+encodeURIComponent(customerName)
			+"&costCenterName="+encodeURIComponent(costCenterName)+"&customerCode="+customerCode+"&costCenterId="+costCenterId+"&customerId="+customerId;
	form.submit();     
}



    function detail_onClick(){  //实现转到详细页面
    		var url = "" ;
    	    url="<%=request.getContextPath()%>/jsp/faerp/finance/bill/billtemplateconf/templateAdd.jsp";
    	    showModalCenter(url, window, callBack, 640, 310, "新增模板");  //增加子岗位


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
    writeTableTopFesco("账单模板配置");  //显示本页的页眉
</script>

<!-- 新增账单模板 -->
	<div id="addTemplateModel" class="modal fade" role="dialog"  aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
        			<h4 class="modal-title">新增账单模板</h4>
				</div><!-- ./modal-header -->

				<div class="modal-body">
					<div class="row">
						<div class="col-xs-12"  style="padding-left: 10px;">
							<form action="" class="form-horizontal" role="form">
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="totalPrice">
										<span style="color: #d15b47">*</span>客户名称：
									</label>
									<div class="col-sm-9">
										<input id="searchCustomer" name="searchCustomer" style="width: 60%" data-placeholder="--请选择--"  />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="totalPrice">
										<span style="color: #d15b47">*</span>成本中心：
									</label>
									<div class="col-sm-9">
										<input id="searchCostCenter" name="searchCostCenter" style="width: 60%" data-placeholder="--请选择--"  />
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="totalPrice">
										<span style="color: #d15b47">*</span>模板类型：
									</label>
									<div class="col-sm-9">
										<select id="searchType" name="searchType" class="col-xs-12" data-placeholder="--请选择账单模板类型--">
												<option value=""></option>
												<option value="1">社保福利薪资</option>
												<option value="2">社保福利</option>
												<option value="3">薪资</option>
										</select>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>

				<div class="modal-footer">
		        	<button type="button" class="btn btn-info" onclick="Template.toConfig()">配置  <i class="icon-cloud-download"></i></button>
		      	</div><!-- ./modal-footer -->
			</div>
		</div>
	</div>
<div class="ringht_s">
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="55" rowspan="10" style="padding-top:0;" nowrap="nowrap"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right">客户名称</td>
             <td align="left" width="210">
                 <input type="text" class="text_field" name="customerName1" id="customerName1" inputName="客户名称" maxLength="50"/>
             </td>
            <td align="right">客户编号</td>
            <td align="left">
             <input type="text" class="text_field" name="customerCode1" id="customerCode1" inputName="客户编号" maxLength="50"/>
                  </td>
             <td align="right">成本中心</td>
            <td align="left"><input type="text" class="text_field" name="costCenterName1" id="costCenterName1" inputName="成本中心" maxLength="50"/>            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button">
    <div class="button_right">
        <input class="e" type="button"   value="查询"    onClick="query_onClick();">
    <input class="e" type="button"   value="新增"   onClick="detail_onClick();">
      <input class="e" type="button"   value="编辑"    onClick="edit_onClick();">
      <input class="e" type="button"   value="下载"   onClick="download();">
    </div>
    <div class="clear"></div>
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell
        id="datacell1"
        queryAction="/FAERP/BillTemplateConfigAction.do?cmd=queryTemplateData"
        width="78%"
        height="300px"
        xpath="BillTemplate"
        submitXpath="BillTemplate"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="templateId" width="0px">
      </r:field>
      <r:field fieldName="historyDateType" width="0px">
      </r:field>
      <r:field fieldName="rowIndex" width="0px">
      </r:field>
      <r:field fieldName="titleRows" width="0px">
      </r:field>
      <r:field fieldName="appName" width="0px">
      </r:field>
      <r:field fieldName="customerId" width="0px">
      </r:field>
      <r:field fieldName="customerCode" width="0px">
      </r:field>
      <r:field fieldName="costCenterId" width="0px">
      </r:field>
      <r:field fieldName="templatePath" width="0px">
      </r:field>
      <r:field fieldName="customerName" width="200px" label="客户名称" >
      </r:field>
      <r:field fieldName="costCenterName" width="200px" label="成本中心名称" >
      </r:field>
       <r:field fieldName="templateType" width="200px" label="模板类型">
       <d:select dictTypeId="TemplateType"/>
      </r:field>
      <r:field fieldName="effectiveTime"  width="200px" label="生效日期">
      </r:field>

    </r:datacell>
    </div>


</div>
</div>
</form>

</fmt:bundle>

</body>
</html>



