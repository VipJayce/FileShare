<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ page errorPage="/jsp/include/errorpage.jsp" %>
<%@ page import="royoo.common.TagSortUitl" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
 <%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<%@ taglib uri="/WEB-INF/gap-i18n.tld" prefix="i18n" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/gap-authority.tld" prefix="au" %>
<%@ taglib uri="/WEB-INF/gap-bnLog.tld" prefix="bnLog" %>
<%@ taglib uri="/WEB-INF/gap-data.tld" prefix="data" %>
<%@ taglib uri="/WEB-INF/gap-faerp.tld" prefix="faerp" %>
<%@ page import="gap.authority.helper.LoginHelper" %>
<!DOCTYPE html>
<html lang="zh">
  <head>
  	<meta charset="utf-8" />
    <title>${billVo.cost_center_name }-账单修改明细</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- basic styles -->

	<link href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/font-awesome.min.css" />

	<!--[if IE 7]>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/font-awesome-ie7.min.css" />
	<![endif]-->

	<!-- page specific plugin styles -->

		<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/jquery-ui-1.10.3.full.min.css" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/chosen.css" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/datepicker.css" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ui.jqgrid.css" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/jquery.gritter.css" />

	<!-- fonts -->

	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace-fonts.css" />

	<!-- ace styles -->

	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace.min.css" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace-rtl.min.css" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace-skins.min.css" />

	<!--[if lte IE 8]>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace-ie.min.css" />
	<![endif]-->

	<!-- inline styles related to this page -->

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

	<!--[if lt IE 9]>
	<script src="<%=request.getContextPath()%>/assets/js/html5shiv.js"></script>
	<script src="<%=request.getContextPath()%>/assets/js/respond.min.js"></script>
	<![endif]-->
	
	<style>
	.row-style{
		background-color: rgb(249, 249, 249);
	}
	.frozen-bdiv{
		background-color:white;
	}
	
	.cell-green{
		background-color: #c8f8ad;
	}
	
	.cell-yellow{
		background-color: #f6f3a2;
	}
	</style>
  </head>
<body>
<input type="hidden" value="${billVo.id }" name="bill_id" id="bill_id"/>
<input type="hidden" value="${billVo.bill_amount }" name="bill_amount" id="bill_amount"/>
<input type="hidden" value="${billOthersAmount }" name="billOthersAmount" id="billOthersAmount"/>
	<div class="page-content">
		<div class="page-header">
			<h1>
				${billVo.cost_center_name }${fn:substring(billVo.bill_year_month, 0, 4) }年${fn:substring(billVo.bill_year_month, 4, 6) }月应付明细
			</h1>
		</div><!-- /.page-header -->
		
		<div class="row">
			<div class="col-xs-12">
				<div class="col-xs-7">
					<div class="form-group">
						<label class="col-sm-3 control-label no-padding-right" for="search-query"> 姓名/唯一号/服务年月:  </label>
						<div class="col-sm-6">
							<div class="input-group">
								<input id="emp-info" type="text" class="form-control search-query" >
								<span class="input-group-btn">
									<button id="query-btn" type="button" class="btn btn-purple btn-sm">
										查询
										<i class="icon-search icon-on-right bigger-110"></i>
									</button>
									<button id="reset-btn" type="reset" class="btn btn-sm">
										重置
										<i class="icon-undo icon-on-right bigger-110"></i>
									</button>
								</span>
							</div>
						</div>
						<div class="col-sm-3">
							<button id="export-btn" type="button" class="btn btn-success btn-sm">
								导出Excel
								<i class="icon-download icon-on-right bigger-110"></i>
							</button>
						</div>
					</div>
				</div>
				<div class="col-xs-3">
					账单号：${billVo.bill_code }
				</div>
				<div class="col-xs-2">
					账单总额：<span id="bill-amount-span">&nbsp;</span>
				</div>
			</div><!-- /.col -->
		</div><!-- /.row -->

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<table id="grid-table"></table>
				<div id="grid-pager"></div>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
		
		<div class="hr"></div>
		
		<div class="row">
			<div class="col-xs-6">
				<div class="widget-box" style="opacity: 1; z-index: 0;">
					<div class="widget-header header-color-blue">
						<h5 class="bigger lighter">
							<i class="icon-table"></i>
							一次收费项目表
						</h5>
					</div><!-- /widget-header -->

					<div class="widget-body" style="height:325px;">
						<div class="widget-main no-padding">
							<table class="table table-striped table-bordered table-hover">
								<thead class="thin-border-bottom">
									<tr>
										<th>
											项目名称
										</th>
										<th>
											<i class="icon-jpy"></i>
											金额
										</th>
										<th>
											<i class="icon-jpy"></i>
											增值税
										</th>
										<th>
											<i class="icon-jpy"></i>
											附加税
										</th>
										<th>
											备注
										</th>
										<th>
											时间
										</th>
									</tr>
								</thead>

								<tbody>
									<logic:iterate name="billOthersList" id="billOthers" scope="request" indexId="indexs">
											<tr>
												<td>${billOthers.charge_item_bd}</td>
												<td>
													${billOthers.amount}
												</td>
												<td>
													${billOthers.vat_amount}
												</td>
												<td>
													${billOthers.add_vate_amount}
												</td>
												<td>
													${billOthers.charge_desc}
												</td>
												<td>
													${billOthers.charge_item_name}
												</td>
											</tr>
									</logic:iterate>
								</tbody>
							</table>
						</div>
					</div><!-- /widget-body -->
				</div><!-- /widget-box -->
			</div><!-- /.col -->
			<div class="col-xs-6">
					
					<div class="widget-box">
						<div class="widget-header header-color-blue">
							<h5 class="bigger lighter">
								<i class="icon-file-text"></i>
								修改原因
							</h5>
						</div><!-- /widget-header -->
	
						<div class="widget-body">
							<div class="widget-main">
								<div class="form-group">
									<label for="bill_reason_big_type"><span style="color:red;">*&nbsp;</span>原因大类：</label>
									<select class="form-control" id="bill_reason_big_type" name="bill_reason_big_type">
										<option value="">&nbsp;</option>
										<option value="1">系统原因</option>
										<option value="2">客服原因</option>
										<option value="3">客户原因</option>
										<option value="4">其他</option>
									</select>
								</div>
								
								<div id="bill_other_reason-div" class="form-group hide">
									<label for="bill_other_reason"><span style="color:red;">*&nbsp;</span>请输入原因：</label>
									<textarea class="form-control" id="bill_other_reason" name="bill_other_reason" maxlength="200" rows="5"></textarea>
								</div>
								
								<div class="form-group">
									<label for="bill_reason_small_type"><span style="color:red;">*&nbsp;</span>原因小类：</label>
									<select multiple="" class="form-control width-80 chosen-select tag-input-style" id="bill_reason_small_type" data-placeholder="原因小类可以多选">
										<option value="1">补收代发工资服务费</option>
										<option value="2">补收实收与预收差额</option>
										<option value="3">补收补充福利服务费</option>
										<option value="4">服务费退补费</option>
										<option value="5">手工账单与系统账单不符</option>
										<option value="6">账期问题，本月收上月</option>
										<option value="7">客户打款问题</option>
										<option value="8">本公司费用在其他公司承担</option>
										<option value="9">历史费用退补费不收</option>
										<option value="10">工资不够扣</option>
										<option value="11">调整基数、比例差</option>
										<option value="12">工资、个税问题</option>
										<option value="13">系统问题，IT认证后需手工调整</option>
										<option value="14">精确度问题</option>
										<option value="15">综合类账单</option>
									</select>
								</div>
								
							</div>
						</div><!-- /widget-body -->
					</div><!-- /widget-box -->
					
					<div class="widget-box">
						<div class="widget-header header-color-blue">
							<h5 class="bigger lighter">
								<i class="icon-file-text"></i>
								备注
							</h5>
						</div><!-- /widget-header -->
	
						<div class="widget-body">
							<div class="widget-main no-padding">
								<textarea class="form-control" id="applymsg" maxlength="2000" rows="5"></textarea>
								还可输入<span id="surplus">2000</span>字符
							</div>
						</div><!-- /widget-body -->
					</div><!-- /widget-box -->
			</div><!-- /.col -->
		
		</div><!-- /.row -->
		
		<div class="hr"></div>
		
		<div class="row">
			<div class="col-xs-12 center">
				<button id="submit-btn" class="btn btn-success">
					<i class="icon-ok align-top bigger-125"></i>
					提交审核
				</button>
				<button id="close-btn" class="btn btn-danger">
					<i class="icon-undo align-top bigger-125"></i>
					关闭窗口
				</button>
			</div><!-- /.col -->
		</div><!-- /.row -->
		
		
	</div><!-- /.main-container -->

	<!-- basic scripts -->

	<!--[if !IE]> -->

	<script type="text/javascript">
		window.jQuery || document.write("<script src='<%=request.getContextPath()%>/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
	</script>

	<!-- <![endif]-->

	<!--[if IE]>
	<script type="text/javascript">
		window.jQuery || document.write("<script src='<%=request.getContextPath()%>/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
	</script>
	<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='<%=request.getContextPath()%>/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		
		<script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script>
		<script src="<%=request.getContextPath()%>/assets/js/typeahead-bs2.min.js"></script>
		<script src="<%=request.getContextPath()%>/assets/js/bootbox.min.js"></script>
		
		<!-- page specific plugin scripts -->
		<script src="<%=request.getContextPath()%>/assets/js/chosen.jquery.min.js"></script>
		<script src="<%=request.getContextPath()%>/assets/js/jqGrid/jquery.jqGrid.min.js"></script>
		<script src="<%=request.getContextPath()%>/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
		<script src="<%=request.getContextPath()%>/assets/js/jquery.gritter.min.js"></script>
		
		<!-- ace scripts -->

		<script src="<%=request.getContextPath()%>/assets/js/ace-elements.min.js"></script>
		<script src="<%=request.getContextPath()%>/assets/js/ace.min.js"></script>

		<!-- inline scripts related to this page -->

		<script type="text/javascript">
		var isFinish = false;
		$(function() {
			$.ajaxSetup({error: function(xhr, textStatus, errorThrown) {
				bootbox.dialog({
					message: "Oops! 出异常了，请把这个截图发给管理员！<br/>"+this.type + ' <br/>url:' + this.url + '; <br/>error:' + textStatus + ';' + xhr.status,
					buttons: 			
					{
						"button" :
						{
							"label" : "关闭",
							"className" : "btn-sm btn-danger"
						}
					}
				});
				return false;
			}});
			
			var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
			var lastsel;
			var cellOldValue;
			
		var myGrid =$(grid_selector).jqGrid({
					//direction: "rtl",
					//cellEdit: true,
					rownumbers: true,
					rownumWidth: 40,
					jsonReader : {id:"ID"},
					url:'<%=request.getContextPath()%>/BillmodifyAction.do?cmd=getBillItemData4Update&bill_id=${billVo.id}',
					datatype: "json",
					height: 250,
					//colNames:['姓名','唯一号','服务年月', '收费属性', 'Ship via','Notes', 'Stock', 'Ship via','Notes', 'Stock', 'Ship via','Notes', 'Stock', 'Ship via','Notes'],
					colModel:[
						//{name:'ID', index:'ID',sortable:false,hidden:true},
						{name:'EMP_NAME',label:'姓名',index:'EMP_NAME', width:60, sortable:false, frozen:true},
						{name:'EMP_CODE',label:'唯一号',index:'EMP_CODE',width:60, sortable:false, frozen:true},
						{name:'SERVICE_YEAR_MONTH',label:'服务年月',index:'SERVICE_YEAR_MONTH', sortable:false, width:70,editable: false, frozen:true},
						{name:'BILL_IMP_TYPE_DB',label:'收费属性',index:'BILL_IMP_TYPE_DB', align:'center', sortable:false, width:70, editable: false, frozen:true,formatter:function(cellvalue, options, rowObject){
							if(cellvalue=='1'){
								return "预提";
							}
							if(cellvalue=='2'){
								return "实收";
							}
							
							return "";
						}},
						<logic:iterate name="headerList" id="smallHeader" scope="request" indexId="indexs">
						<c:choose>
							<c:when test="${smallHeader.c_type =='1' }">
								{name:'${smallHeader.c_name}_CITY',label:'城市',index:'CITY', sortable:false, width:50, editable: false,jsonmap:"CITY"},
								{name:'${smallHeader.c_name}_BASE',label:'基数',index:'${smallHeader.c_name}_BASE', sortable:false, width:90, editable: false, align:"right",formatter:"number"},
								{name:'${smallHeader.c_name}_AMOUNT',label:'总额',index:'${smallHeader.c_name}_AMOUNT', sortable:false, width:90, editable: false, align:"right",formatter:"number"},
								{name:'${smallHeader.c_name}_ERATIO',label:'单位比例',index:'${smallHeader.c_name}_ERATIO', sortable:false, width:70, editable: false, align:"right",formatter:"number"},
								{name:'${smallHeader.c_name}_EMONEY',label:'单位金额',index:'${smallHeader.c_name}_EMONEY', sortable:false, width:90, editable: true, align:"right",formatter:"number"},
								{name:'${smallHeader.c_name}_PRATIO',label:'个人比例',index:'${smallHeader.c_name}_PRATIO', sortable:false, width:70, editable: false, align:"right",formatter:"number"},
								{name:'${smallHeader.c_name}_PMONEY',label:'个人金额',index:'${smallHeader.c_name}_PMONEY', sortable:false, width:90, editable: true, align:"right",formatter:"number"},
								{name:'${smallHeader.c_name}_ISSUM',label:'是否纳入总额',index:'${smallHeader.c_name}_ISSUM', sortable:false, width:10, editable: false, hidden:true},
								{name:'${smallHeader.c_name}_ISUPD',label:'是否修改',index:'${smallHeader.c_name}_ISUPD', sortable:false, width:10, editable: false, hidden:true},
						    </c:when>
						    <c:when test="${smallHeader.c_type =='3' }">
						    	{name:'${smallHeader.c_name}_MONEY',label:'${smallHeader.product_name}',index:'${smallHeader.c_name}_MONEY', sortable:false, width:90, editable: true, align:"right",formatter:"number"},
						    	{name:'${smallHeader.c_name}_ISSUM',label:'是否纳入总额',index:'${smallHeader.c_name}_ISSUM', sortable:false, width:10, editable: false, hidden:true},
						    	{name:'${smallHeader.c_name}_ISUPD',label:'是否修改',index:'${smallHeader.c_name}_ISUPD', sortable:false, width:10, editable: false, hidden:true},
						    </c:when>
						</c:choose>
						</logic:iterate>
						{name:'AMOUNT',label:'合计',index:'AMOUNT', sortable:false, width:90, editable: true, align:"right",formatter:"number"},
						{name:'AMOUNT_ISUPD',label:'是否修改',index:'AMOUNT_ISUPD', sortable:false, width:10, editable: false, hidden:true}
					], 
					viewrecords : true,
					rowNum:25,
					rowList:[10,25,50],
					pager : pager_selector,
					altRows: true,
					altclass: 'row-style',
					loadComplete : function() {
						var table = this;
						setTimeout(function(){
							updatePagerIcons(table);
							refreshColSum(true);
							tagSpecialCell();
						}, 0);
					},
					shrinkToFit:false,
					onCellSelect: function(rowid,iCol,cellcontent){
						myGrid.jqGrid('saveRow',lastsel,myGrid.getRowData(lastsel));
						myGrid.jqGrid('editRow',rowid,false);
						lastsel=rowid;
						var colModel = myGrid.getGridParam('colModel');
						var colName = colModel[iCol].name;
						var colLabel = colModel[iCol].label;
					    var input = $('#' + rowid + '_' + colName);
					    $("input.editable").focus(function(){ 
					       cellOldValue = this.value;
					     
					       for(var iCol=0; iCol<colModel.length; iCol++){
                               if(colModel[iCol].name == this.name){
                                   break;
                               }
                           }
                           
                           colName = colModel[iCol].name;
                           colLabel = colModel[iCol].label;
					     });
					    $("input.editable").unbind("blur");
					    $("input.editable").blur(function(){
					    	var editCell = this; 
					    	var cellNewValue = this.value;
					    	
					    	if(!/^-?\d+\.?\d{0,2}$/.test(cellNewValue)){
						        $.gritter.add({
									text: "请输入有效数字,最多2位小数",
									class_name: 'gritter-error'
								});
								this.value=cellOldValue;
								this.focus();
						        return;
						    }
						    
						    if((rowid=='col_amount'||this.name=='AMOUNT')
						    	&&Number(cellNewValue)!=Number(cellOldValue)
						    	&&Number(cellNewValue)!=0){
						    	$.gritter.add({
									text: "合计值不能输入非零值，只能清零！",
									class_name: 'gritter-error'
								});
								this.value=cellOldValue;
								this.focus();
						        return;
						    }
						    
						    if(rowid=='col_amount'&&this.name=='AMOUNT'&&Number(cellNewValue)!=Number(cellOldValue)){
						    	$.gritter.add({
									text: "不能清零整个账单！",
									class_name: 'gritter-error'
								});
								this.value=cellOldValue;
						        return;
						    }
						    
					    	if(Number(cellNewValue)!=Number(cellOldValue)){
					    		var record =  myGrid.getRowData(rowid);
					    		var json = {id:rowid,bill_id:'${billVo.id }',colName:colName,oldValue:cellOldValue,newValue:cellNewValue,colLabel:colLabel};
					    		if(rowid=='col_amount'){
					    			bootbox.confirm("确定清零 "+colLabel+" 整列金额￥"+cellOldValue+"?", function(result) {
										if(result) {
											$.post("<%=request.getContextPath()%>/BillmodifyAction.do?cmd=updateBillAmount",
								    			json,function(result,status){
								    			if(result.success){
								    				refreshColSum(false);
								    				$('#bill_amount').val(result.bill_amount);
								    				refreshBillAmount();
									    			
													//var jsonStr = "{"+colName+":"+cellNewValue+"}";
										    		//var obj = eval('(' + jsonStr + ')');
										    		if(rowid=='col_amount'){
										    			$.gritter.add({
															text: colLabel+'金额：'+result.oldValue+' 清零成功',
															class_name: 'gritter-success'
														});
										    			myGrid.trigger("reloadGrid");
										    		}else{
										    			$.gritter.add({
															text: record.EMP_NAME+record.SERVICE_YEAR_MONTH+result.colLabel+'金额：'+result.oldValue+' 修改为:'+result.newValue+";",
															class_name: 'gritter-success'
														});
										    			var su=myGrid.jqGrid('setRowData',rowid, result.record);
										    			myGrid.resetSelection();
										    			tagSpecialCell();
										    		}
										    		//myGrid.jqGrid('saveRow',rowid,myGrid.getRowData(rowid));
										    		//myGrid.jqGrid('editRow',rowid,true);
									    		}else{
									    			editCell.value=result.oldValue;
									    			$.gritter.add({
														text: "修改失败："+result.msg,
														class_name: 'gritter-error'
													});
									    		}
											});
										}else{
											editCell.value=cellOldValue;
						        			return;
										}
									});
					    		}else if(this.name=='AMOUNT'){
					    			bootbox.confirm("确定清零 "+record.EMP_NAME+" "+record.SERVICE_YEAR_MONTH+"合计金额￥"+cellOldValue+"?", function(result) {
										if(result) {
											$.post("<%=request.getContextPath()%>/BillmodifyAction.do?cmd=updateBillAmount",
								    			json,function(result,status){
								    			if(result.success){
								    				refreshColSum(false);
								    				$('#bill_amount').val(result.bill_amount);
								    				refreshBillAmount();
									    			
													//var jsonStr = "{"+colName+":"+cellNewValue+"}";
										    		//var obj = eval('(' + jsonStr + ')');
										    		if(rowid=='col_amount'){
										    			$.gritter.add({
															text: colLabel+'金额：'+result.oldValue+' 清零成功',
															class_name: 'gritter-success'
														});
										    			myGrid.trigger("reloadGrid");
										    		}else{
										    			$.gritter.add({
															text: record.EMP_NAME+record.SERVICE_YEAR_MONTH+result.colLabel+'金额：'+result.oldValue+' 修改为:'+result.newValue+";",
															class_name: 'gritter-success'
														});
										    			var su=myGrid.jqGrid('setRowData',rowid, result.record);
										    			myGrid.resetSelection();
										    			tagSpecialCell();
										    		}
										    		//myGrid.jqGrid('saveRow',rowid,myGrid.getRowData(rowid));
										    		//myGrid.jqGrid('editRow',rowid,true);
									    		}else{
									    			editCell.value=result.oldValue;
									    			$.gritter.add({
														text: "修改失败："+result.msg,
														class_name: 'gritter-error'
													});
							    				}
											});
										}else{
											editCell.value=cellOldValue;
						        			return;
										}
									});
					    		}else{
					    		
						    		$.post("<%=request.getContextPath()%>/BillmodifyAction.do?cmd=updateBillAmount",
						    			json,function(result,status){
						    			if(result.success){
						    				refreshColSum(false);
						    				$('#bill_amount').val(result.bill_amount);
						    				refreshBillAmount();
							    			
											//var jsonStr = "{"+colName+":"+cellNewValue+"}";
								    		//var obj = eval('(' + jsonStr + ')');
								    		if(rowid=='col_amount'){
								    			$.gritter.add({
													text: colLabel+'金额：'+result.oldValue+' 清零成功',
													class_name: 'gritter-success'
												});
								    			myGrid.trigger("reloadGrid");
								    		}else{
								    			$.gritter.add({
													text: record.EMP_NAME+record.SERVICE_YEAR_MONTH+result.colLabel+'金额：'+result.oldValue+' 修改为:'+result.newValue+";",
													class_name: 'gritter-success'
												});
								    			var su=myGrid.jqGrid('setRowData',rowid, result.record);
								    			myGrid.resetSelection();
								    			tagSpecialCell();
								    		}
								    		//myGrid.jqGrid('saveRow',rowid,myGrid.getRowData(rowid));
								    		//myGrid.jqGrid('editRow',rowid,true);
							    		}else{
							    			editCell.value=result.oldValue;
							    			$.gritter.add({
												text: "修改失败："+result.msg,
												class_name: 'gritter-error'
											});
							    		}
									});
					    		}
					    	}
					    });
					    
					    input.get(0).focus();
					    
					},
					autowidth: true
			
				});
				
				function updatePagerIcons(table) {
					var replacement = 
					{
						'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
						'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
						'ui-icon-seek-next' : 'icon-angle-right bigger-140',
						'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
					};
					$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
				}
				
				
				
				//表头分组
				myGrid.jqGrid('setGroupHeaders', {
				  useColSpanStyle: true, 
				  groupHeaders:[
				  <% boolean isFirst = true; %>
				  <logic:iterate name="headerList" id="smallHeader" scope="request" indexId="indexs">
						<c:choose>
							<c:when test="${smallHeader.c_type =='1' }">
					<% if(isFirst){isFirst=false;}else{ %>,<%}%>{startColumnName: '${smallHeader.c_name}_CITY', numberOfColumns: 7, titleText: '${smallHeader.product_name}'}
							</c:when>
						</c:choose>
					</logic:iterate>
				  ]	
				});
				
				//锁列
				$(grid_selector).jqGrid('setFrozenColumns');
				
				function refreshColSum(isNew){
					$.post("<%=request.getContextPath()%>/BillmodifyAction.do?cmd=getBillItemData4UpdateColSum&bill_id=${billVo.id }",
					    			null,function(result,status){
					    if(isNew){
					    	//更新账单总金额
					    	$('#bill_amount').val(result.AMOUNT);
						    refreshBillAmount();
						    
							$(grid_selector).jqGrid('addRowData','col_amount',result);
						}else{
							$(grid_selector).jqGrid('setRowData','col_amount',result);
						}
					});
 					
 				}
 				
 				function tagSpecialCell(){
 					var myIDs = myGrid.jqGrid('getDataIDs');
 					var testRow = myGrid.jqGrid( 'getRowData', myIDs[0] );
					for (var i = 0; i < myIDs.length; i++) {
					    var myRow = myGrid.jqGrid( 'getRowData', myIDs[i] );
					    <logic:iterate name="headerList" id="smallHeader" scope="request" indexId="indexs">
						<c:choose>
							<c:when test="${smallHeader.c_type =='1' }">
								if(myRow.${smallHeader.c_name}_ISSUM=='0'){
									myGrid.jqGrid('setCell',myIDs[i],"${smallHeader.c_name}_EMONEY","","cell-yellow");
									myGrid.jqGrid('setCell',myIDs[i],"${smallHeader.c_name}_PMONEY","","cell-yellow");
								}
								if(myRow.${smallHeader.c_name}_ISUPD=='1'){
									myGrid.jqGrid('setCell',myIDs[i],"${smallHeader.c_name}_EMONEY","","cell-green");
									myGrid.jqGrid('setCell',myIDs[i],"${smallHeader.c_name}_PMONEY","","cell-green");
								}
							</c:when>
						    <c:when test="${smallHeader.c_type =='3' }">
						    	if(myRow.${smallHeader.c_name}_ISSUM=='0'){
									myGrid.jqGrid('setCell',myIDs[i],"${smallHeader.c_name}_MONEY","","cell-yellow");
								}
								if(myRow.${smallHeader.c_name}_ISUPD=='1'){
									myGrid.jqGrid('setCell',myIDs[i],"${smallHeader.c_name}_MONEY","","cell-green");
								}
						    </c:when>
						</c:choose>
						</logic:iterate>
						if(myRow.AMOUNT_ISUPD=='1'){
							myGrid.jqGrid('setCell',myIDs[i],"AMOUNT","","cell-green");
						}
					}
 				}
				
				//统计备注输入字数
				$('#applymsg').keyup(function(){
					var totalLength = 2000;
				    var content = $("#applymsg").val();
				    var currentLength = content.length;
				    var count = parseFloat(totalLength) - parseFloat(currentLength);
				    if (count <= 0 ) {
				        var text = content.substring(0, 2000);
				        $("#applymsg").val(text);
				        count = 0;
				    }
				    $("#surplus").text(count);
				});
				
//查询姓名和唯一号
$('#query-btn').click(function() {
	var btn = $(this);
	btn.button('loading');
	var bill_id = $("#bill_id").val();
	var emp_info = $("#emp-info").val();
	if(emp_info==null||emp_info==""){
		bootbox.dialog({
			message: "查询姓名和唯一号不能为空",
			buttons: 			
				{
					"button" :
					{
						"label" : "关闭",
						"className" : "btn-sm btn-danger"
					}
				}
		});
		btn.button('reset');
		return false;
	}
	var url = "<%=request.getContextPath()%>/BillmodifyAction.do?cmd=getBillItemData4UpdateEmp";
	var json = {bill_id:bill_id,emp_info:emp_info};
	$.post(url,json,function(result,status){
		btn.button('reset');
		myGrid.jqGrid("clearGridData");
		$.gritter.add({
			text: '查询成功返回:'+result.length+"条记录！查询最多返回50条记录。",
			class_name: 'gritter-success'
		});
		$.each( result, function(i,n){
			$(grid_selector).jqGrid('addRowData',result[i].ID,result[i],"first");
		});
		refreshColSum(true);
	});
});

//重置查询
$('#reset-btn').click(function() {
	var btn = $(this);
	btn.button('loading');
	$('#emp-info').val('');
	myGrid.trigger("reloadGrid");
	btn.button('reset');
});

//导出Excel
$('#export-btn').click(function() {
	
	//导出数据
	var bill_id = $("#bill_id").val();
	var cost_center_name = "${billVo.cost_center_name }";
	var bill_year_month = "${billVo.bill_year_month }";
	var bill_code = "${billVo.bill_code }";
	var login_name = "<%=LoginHelper.getLoginName(request)%>";
	if(bill_id != null && bill_id !=""){
		var url="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillModifyReport.jsp?raq=bill_modify.raq&arg1="+bill_id+"&arg2="+cost_center_name+"&arg3="+bill_year_month+"&arg4="+bill_code+"&arg5="+login_name;
	    window.location.href = url;
	}else{
		bootbox.dialog({
			message: "Excel导出失败，请联系IT!",
			buttons: 			
				{
					"button" :
					{
						"label" : "关闭",
						"className" : "btn-sm btn-danger"
					}
				}
		});
		return;
	}
});

//关闭窗口
$('#close-btn').click(function() {
	isFinish = true;
	bootbox.dialog({
		message: "是否保存修改数据？",
		buttons: {
			"danger" : {
				"label" : "否",
				"className" : "btn-sm btn-danger",
				"callback": function() {
					var url = "<%=request.getContextPath()%>/BillmodifyAction.do?cmd=resetBillUpdate&bill_id=${billVo.id }";
					$.post(url,null,function(result,status){
						var opened=window.open('about:blank','_self');
						opened.opener=null;
						opened.close();
					});	
				}
			}, 
			"success" :{
				"label" : "<i class='icon-ok'></i> 是",
				"className" : "btn-sm btn-success",
				"callback": function() {
					var opened=window.open('about:blank','_self');
					opened.opener=null;
					opened.close();
				}
			}
		}
	});
});

//提交审核
var isSubmit = false;
$('#submit-btn').click(function() {
	if(isSubmit){
		return;
	}else{
		isSubmit = true;
	}
	var btn = $(this);
	btn.button('loading');
	
	var isValid = true;
	var msg = "";
	
	if($("#bill_reason_big_type").val()==null||$("#bill_reason_big_type").val()==""){
		isValid = false;
		msg = "请选择原因大类！";
	}else if($("#bill_reason_big_type").val()=="4"&&($("#bill_other_reason").val()==null||$("#bill_other_reason").val()=="")){
		isValid = false;
		msg = "其他原因请输入！";
	}else if($("#bill_reason_small_type").val()==null||$("#bill_reason_small_type").val()==""){
		isValid = false;
		msg = "请选择原因小类！";
	}
	
	if(!isValid){
		isSubmit = false;
		bootbox.dialog({
			message: "&nbsp;"+msg,
			buttons: 			
				{
					"button" :
					{
						"label" : "关闭",
						"className" : "btn-sm btn-danger"
					}
				}
		});
		
		btn.button('reset');
		return;
	}
	
	var json = {applymsg:$('#applymsg').val(),bill_reason_big_type:$("#bill_reason_big_type").val(),
		bill_other_reason:$("#bill_other_reason").val(),bill_reason_small_type:$("#bill_reason_small_type").val()};
	var url = "<%=request.getContextPath()%>/BillmodifyAction.do?cmd=modifyBillSubmit&bill_id=${billVo.id }";
	$.post(url,json,function(result,status){
		if(result.success){
			isFinish = true;
			var opened=window.open('about:blank','_self');
			opened.opener=null;
			opened.close();
		}else{
			isSubmit = false;
			bootbox.dialog({
			message: result.msg,
			buttons: 			
				{
					"button" :
					{
						"label" : "关闭",
						"className" : "btn-sm btn-danger"
					}
				}
			});
			btn.button('reset');
		}
	});	
});

	function refreshBillAmount(){
	var billAmount = $('#bill_amount').val();
	var billOthersAmount = $('#billOthersAmount').val();
	$('#bill-amount-span').html(Number(billAmount)+Number(billOthersAmount));
	}
	
	$(".chosen-select").chosen(); 
	$("#bill_reason_big_type").change(function(){
		if($(this).val()=="4"){
			$('#bill_other_reason-div').removeClass('hide');
		}else{
			$('#bill_other_reason-div').addClass('hide');
		}
	});
	
	$(window).unload(function(){
	 if(!isFinish){
		  var noClose = true;
		  if(confirm("是否保存修改数据？")){
		  	noClose = false;
		  }else{
		  	var url = "<%=request.getContextPath()%>/BillmodifyAction.do?cmd=resetBillUpdate&bill_id=${billVo.id }";
			$.post(url,null,function(result,status){
				noClose = false;
			});	
		  	
		  }
	 }
	});
	
});
		</script>
	</body>
</html>