<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<%
String user_name = LoginHelper.getLoginName(request);
%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<head>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_queryfinbill'/></title>
<link href="<%=request.getContextPath()%>/css/index.css" rel="stylesheet" type="text/css" />
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
.fex_row_top
 {
  top:expression(document.getElementById('div_top').scrollTop-2); 
     position:relative; 
     z-index:1;
     background-color: #DEE7FE;
 }
 #postit{
position:absolute;
width:250;
padding:5px;
background-color:#333333;
border:1px solid #333333;
visibility:hidden;
z-index:100;
cursor:hand;
}
</style>
<script language="JavaScript" src="../../scripts/common.js"></script>
<script type="text/javascript">
	var _jQuery = window.jQuery, _$ = window.$;
	jQuery.noConflict();
	function rtnFuncCustomer(arg){

    	var lookup = $id("customer_id");
    	lookup.value = arg[2];
    	lookup.displayValue = arg[2];
    	_$("#select_cust_id").val(arg[0]);
    	$id("cost_center_id").addParam("cust_id", arg[0]);
       	$id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
    	return false;
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
	
	//datacell checkbox begin
	function setCheckboxStatus(value,entity,rowNo,cellNo){
	     var returnStr = "";
	    returnStr =  "<input   type='checkbox' name='checkbox1'  id='" + entity.getProperty("id") + "'  onclick=\"loadMoreData('"+ entity.getProperty("id") +"')\"  value='" + entity.getProperty("id") + "'>";
	    return returnStr;
	}
    function checkAllList(all){
    	if(all.checked){
	        var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= true;
	            }
	        } 
	    }else{
	    	var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= false;
	            }
	        } 
	    }
    }
    
   
	//end
	function queryall(){
		$id("celllist1").addParam("customer_id",$id("customer_id").value);
     	$id("celllist1").addParam("cost_center_id",$id("cost_center_id").getValue());
     	$id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
     	$id("celllist1").addParam("bill_type_bd",$id("bill_type_bd").options[$id("bill_type_bd").selectedIndex].value);
     	$id("celllist1").addParam("max",$id("max").value);
     	$id("celllist1").addParam("min",$id("min").value);
     	$id("celllist1").addParam("bill_invoice_status_bd",$id("bill_invoice_status_bd").options[$id("bill_invoice_status_bd").selectedIndex].value);
     	$id("celllist1").addParam("bill_gather_status_bd",$id("bill_gather_status_bd").options[$id("bill_gather_status_bd").selectedIndex].value);
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        
        $id("celllist2").clear();
        //$id("celllist2").loadData();
        $id("celllist2").refresh();
        
        $id("celllist3").clear();
        $id("celllist3").refresh();
        $id("bill_id").value="";
	}
	
	
	   //导出数据
     function exportToExcel() {
     var customer_id=$id("customer_id").value;
     var cost_center_id=$id("cost_center_id").getValue();
     var bill_year_month=$id("bill_year_month").value;
     var bill_type_bd=$id("bill_type_bd").options[$id("bill_type_bd").selectedIndex].value;
     var max=$id("max").value;
     var min=$id("min").value;
     var bill_invoice_status_bd=$id("bill_invoice_status_bd").options[$id("bill_invoice_status_bd").selectedIndex].value;
     var bill_gather_status_bd=$id("bill_gather_status_bd").options[$id("bill_gather_status_bd").selectedIndex].value;
     //alert(customer_id+"___"+cost_center_id+"___"+bill_year_month+"___"+bill_type_bd+"___"+max+"___"+min+"___"+bill_invoice_status_bd+"___"+bill_gather_status_bd);
       if((customer_id==""||customer_id==null)&&cost_center_id==""&&bill_year_month==""&&bill_type_bd==""&&max==""&&min==""&&bill_invoice_status_bd==""&&bill_gather_status_bd==""){
            alert("<fmt:message key='alert_select_one_export'/>");
            return;
       }
     
     
         if(confirm("<fmt:message key='alert_confirm_export'/>")) {
               var param = jQuery("#datacell_formid").serialize();
               form.action="<%=request.getContextPath()%>/FinbillAction.do?cmd=exportDataToExcel&"+param;
               form.submit();
          }
      }  
	
	 function setRadiochecked(value,entity,rowNo,cellNo ){
       var returnStr = "";
       returnStr =  "<input type='radio' onclick='radiochange(" + rowNo + ",this);'  name='radioId' id='radioId' value=" + entity.getProperty("id") + ">";
       return returnStr;
     }
     
     

     
     //点击radio回调
     function radiochange(rowNo,rdo){
     	alert("rowNo="+rowNo);
     	$id("bill_id").value = rdo.value;
     	$id("celllist2").addParam("bill_id",rdo.value);
        $id("celllist2").loadData();
        $id("celllist2").refresh();
        $id("celllist3").clear();
     }
     
     
     //radio2  //点击radio回调
	 function  setRadiochecked2(value,entity,rowNo,cellNo ){
       var returnStr = "";
       returnStr =  "<input type='radio' onclick='radiochange2(" + rowNo + ",this);'  name='radioId2' id='radioId2' value=" + entity.getProperty("invoice_id") + ">";
       return returnStr;
     }
   
     function radiochange2(rowNo,rdo){
     	//alert( rdo.value);
     	//$id("bill_id").value = rdo.value;
     	$id("celllist3").addParam("invoice_id",rdo.value);
        $id("celllist3").loadData();
        $id("celllist3").refresh();
     }
     //end
     
     //申请开票
     function submitInvoiceApproval_bak(){
     	var is_checked = 0;
     	var radio = document.getElementsByName("radioId");
     	for(var i=0;i<radio.length;i++){
     		if(radio[i].checked){
     			is_checked = 1;
     			var bill_id = radio[i].value;
     			WfCommonAjax.checkInvoiceStatus(bill_id,function(reData){
     			    //0已经开票不需要再走审批流程！      1 允许预开票不需要走流程   2   可以走流程  3 已在审核中，不允许走流程   4 已审核  不允许走流程 
     			    if(reData=="0"){
     			        alert("<fmt:message key='alert_no_approve'/>");
				    }else if(reData=="5"){
                        alert("<fmt:message key='alert_apply_success'/>");
                    }else if(reData=="2"){
				        	showModalCenter('/FAERP/jsp/faerp/finance/receivable/finbill/confirmMsg.jsp',bill_id,"",300,240,"申请说明");
				    }else if(reData=="1"){
						//alert( "该账单的成本中心允许预开票不需要走审批流程！" );
						alert("<fmt:message key='alert_apply_success'/>");
					}else if(reData=="3"){
						alert("<fmt:message key='alert_no_approve_1'/>");
					}else if(reData=="4"){
						alert("<fmt:message key='alert_no_approve_2'/>");
				    }
			    });
     		} 
     	}
     	if(is_checked==0){
     		alert("<fmt:message key='alert_select_bill'/>");
     		return;
     	}
     }

	// 杜辉阳添加0、5 状态 确定营业税是否已经被
	function showInvoiceApproval(type) {
		var v_custcode = new Array(0);
		var v_bill_id = "";
		var str = "";
		var invoice_status_str = "";
		var return_str = "";
		var is_hand_str = "";//手工开票 待开票判断
		var template_id = "";//模板id
		var part_invoice_bill_id = new Array(0);//部分开票id
		var wait_invoice_bill_id = new Array(0);//等待开票id
		var open_invoice_bd = "";//开票属性
		var ids = new Array(0);
		var v_myids = new Array(0);
		var name_result = new Array(0);//招聘验证结果
		var desc = "增票";

		if (_$("#jelle_test_div").is(":hidden")) {//判断是否批量提交 隐藏 则走之前的
			var datacell = $id("celllist1");
			var dataset1 = datacell.dataset;
			ids = selectIds1();
			if (ids == null || ids == '') {
				alert("<fmt:message key='alert_select_bill'/>");
				return;
			}
			for (var i = 0; i < ids.length; i++) {
				var datasettr1 = dataset1.findEntity("id", ids[i]);
				var cust_name = datasettr1.getValue("cust_name");
				var custcode = datasettr1.getValue("cust_code");
				var bill_type_bd = datasettr1.getValue("bill_type_bd");//得到账单类型  帐单类型1社保福利+工资 2仅社保福利
				var open_invoice = datasettr1.getValue("open_invoice");//手工开票还是系统开票
				var cs = datasettr1.getValue("user_name");//客服名称 by 20140808
				//如果是招聘账单,当前用不不是账单的客服,则不能进行开票
				if (bill_type_bd == "6") {
					var name = $id('cs_name').value;
					if (name != cs) {
						name_result.push(name);
					}
				}
				if (bill_type_bd == "1" || bill_type_bd == "2") {
					v_myids.push(ids[i]);
				}
				v_custcode.push(custcode + "");
				var bill_invoice_status_bd = datasettr1.getValue("bill_invoice_status_bd");
				if (bill_invoice_status_bd == "2" || bill_invoice_status_bd == "3") {//开票状态1未开票2已预开票3已开票4作废(预开)5作废(实收)
					invoice_status_str += cust_name + "\n\n";
				}
				if (bill_invoice_status_bd == "6") {//部分开票
					part_invoice_bill_id.push(ids[i]);
				}
				if (bill_invoice_status_bd == "7") {//待开票
					wait_invoice_bill_id.push(ids[i]);
				}
				str += cust_name + "\n\n";
				if (open_invoice == "1") {//手工开票不允许申请系统开票  add by whj
					is_hand_str += cust_name + "\n\n";
				}
			}
		} else {//显示则走批量
			var datacell = $id("celllist4");
			var dataset1 = datacell.dataset;
			var count = datacell.getCurrentRowCount();//记录数
			if (count == 0) {
				alert("请选择一个账单，再进行申请！");
				return;
			}

			for (var i = 0; i < count; i++) {
				var row = datacell.table.tBodies[0].rows[i];
				var entity = datacell.getEntity(row);
				var cust_name = entity.getValue("cust_name");
				var custcode = entity.getValue("cust_code");
				var bill_type_bd = entity.getValue("bill_type_bd");//得到账单类型  帐单类型1社保福利+工资 2仅社保福利
				var open_invoice = entity.getValue("open_invoice");//手工开票还是系统开票
				var b_id = entity.getValue("id");//账单id
				ids.push(b_id);
				v_custcode.push(custcode + "");
				str += cust_name + "\n\n";
				if (bill_type_bd == "1" || bill_type_bd == "2") {
					v_myids.push(b_id);
				}
				var bill_invoice_status_bd = entity.getValue("bill_invoice_status_bd");
				if (bill_invoice_status_bd == "2" || bill_invoice_status_bd == "3") {//开票状态1未开票2已预开票3已开票4作废(预开)5作废(实收)
					invoice_status_str += cust_name + "\n\n";
				}
				if (bill_invoice_status_bd == "6") {//部分开票
					part_invoice_bill_id.push(ids[i]);
				}
				if (bill_invoice_status_bd == "7") {//待开票
					wait_invoice_bill_id.push(ids[i]);
				}
				if (open_invoice == "1") {//手工开票不允许申请系统开票  add by whj
					is_hand_str += cust_name + "\n\n";
				}
			}
		}
		if (v_myids.length > 0) {
			v_bill_id = v_myids;
		}

		if (invoice_status_str != "" && is_hand_str == "") {
			alert(invoice_status_str + "以上账单已申请开" + desc  + "完成，不需要再次申请！");
			return;
		}
		if (is_hand_str != "" && type == 0) {
			alert(is_hand_str + "以上账单是手工开票,不允许申请系统开票！");
			return;
		}

		var bill_id = ids + "";
		DWREngine.setAsync(false);//取消DWR的异步操作
		var flag = "0";
		//判断是否要重新计算账单
		WfCommonAjax.isRecalcBill(bill_id, function(reData){
			if (!!reData) {
				if ("0" != reData) {
					alert(reData);
					flag = "1";
				}
			} else {
				alert("系统异常，请联系IT。");
				flag = "1";
			}
		});

		if ("0" != flag) {
			return;
		}
		WfCommonAjax.hasProductTypeAndServiceType(bill_id, function(reData){
			if (!!reData) {
				if ('0' != reData) {
					alert(reData);
					flag = "1";
				}
			} else {
				systemErrorLog();
				flag = "1";
			}
		});
		if ("0" != flag) {
			return;
		}
		WfCommonAjax.checkInvoiceHaveRate(bill_id, function(reData){
			if (!!reData) {
				if ('0' != reData) {
					alert(reData);
					flag = "1";
				}
			} else {
				systemErrorLog();
				flag = "1";
			}
		});
		if ("0" != flag) {
			return;
		}
		WfCommonAjax.hasRateOfPPSBill(bill_id, function(reData){
			if (!!reData) {
				if ('0' != reData) {
					alert(reData);
					flag = "1";
				}
			} else {
				systemErrorLog();
				flag = "1";
			}
		});
		if ("0" != flag) {
			return;
		}
		//判断是否开具过营业税发票，如果开过就不能再开具增值税发票
		WfCommonAjax.isRejectTicket(bill_id, function (reData) {
			if (reData != "0") {
				if (reData == "1") {
					alert("用户已经开具营业税发票。");
				} else {
					alert("没有获取营业税的相关金额，无法开具增票。");
				}
				flag = "1";
				return false;
			}
		});

		if ("0" != flag) {
			return;
		}

		//全部为系统开票的才允许申请 2014年4月1日 修改 2014年4月8日 之前开票属性查询总账表，现在改为查询账单 update by whj 20140624 只有点系统开票才判断
		if (type == 0) {
			var is_system = "";
			WfCommonAjax.checkCustomerOpenInvoice(bill_id, function (reData) {
				if (reData != "" && reData != null) {
					if (reData != "0") {
						alert("手工开票客户请点击 “申请手工开票” 按钮！");
						is_system = "false";
					}
				}
			});
			if (is_system != "") {
				return;
			}
		} else if (flag == 1) {//设置为手工开票属性
			open_invoice_bd = "1";
		}

		if (bill_id.indexOf(",") != -1) {
			WfCommonAjax.checkInvoiceTemplateSame(bill_id, function (reData) {
				if (reData != "0") {
					if (str != "") {
						alert(str + "以上账单的发票模板不一致不可一起申请！");
						return_str = "1";
					}
				}
			});
		}

		if (return_str != "") {//发票模板不一致不可一起开票
			return;
		}

		if (bill_id.indexOf(",") != -1) {
			WfCommonAjax.checkDisplayYearMonthSame(bill_id, function (reData) {
				if (reData != "0") {
					if (str != "") {
						alert(str + "以上账单的成本中心账期属性不一致不可一起申请！");
						return_str = "1";
					}
				}
			});
		}

		if (return_str != "") {//成本中心账期属性不一致不可一起开票
			return;
		}

		if (type == 0) {//只有系统开票才判断部分开票和待开票 //部分开票时 只能用上一次的模板进行开票  并且如果是合并开票的 只能是之前的账单继续合并开
			var part_invoice_bill_str = "";
			if (part_invoice_bill_id != "") {
				if (part_invoice_bill_id != bill_id) {
					alert("账单的开票状态不一致不允许合并申请。" + desc + "");
					return;
				} else {
					WfCommonAjax.checkCompleteBill(bill_id, function (reData) {
						if (reData[0] == "0") {
							//未通过验证
							alert(reData[1]);
							part_invoice_bill_str = "1";
						} else if (reData[0] == "1") {
							//赋值给template_id
							template_id = reData[1];
						}
					});
				}
			}
			if (part_invoice_bill_str != "") {
				return;
			}

			//待开票时 只能用上一次的模板进行开票  并且如果是合并开票的 只能是之前的账单继续合并开
			var wait_invoice_bill_str = "";
			if (wait_invoice_bill_id != "") {
				if (wait_invoice_bill_id != bill_id) {
					alert("待开" + desc + "的账单不能与其他状态的账单合并申请！");
					return;
				} else {
					WfCommonAjax.checkCompleteBill(bill_id, function (reData) {
						if (reData[0] == "0") {
							//未通过验证
							alert(reData[1]);
							wait_invoice_bill_str = "1";
						} else if (reData[0] == "1") {
							template_id = reData[1];
						}
					});
				}
			}
			if (wait_invoice_bill_str != "") {
				return;
			}
		}
		var cFlag;
		WfCommonAjax.isSameTaxerType(bill_id, function(v_reData){
			if(!!v_reData) {
				if ("1" == v_reData) {
					alert("纳税人类型不同的账单不能合并开票。");
					cFlag = false;
				}
			} else {
				alert("系统异常，请联系IT。");
				cFlag = false;
			}
		});
		if (cFlag == false) {
			return;
		}
		var cost_center_ids = fetchCostCenterId(bill_id, ids[0]);
		if (!cost_center_ids) return;
		/**  选择完成本中心  需判断成本中心的模板 如果是标准 模板 则根据金额自适应模板**/
		if (template_id == "") {
			var fg = "";
			WfCommonAjax.checkInvoiceTempletData(bill_id, cost_center_ids, function (reData) {
				if (reData[0] == "2") {
					alert(reData[1]);
					fg = "1";
				} else {
					template_id = reData[1];
				}
			});
			if (fg != "") {
				return;
			}
		}
		WfCommonAjax.isNotUseBillOfServiceTemplate(bill_id, template_id, function(reData){
			if (!!reData) {
				if ('0' != reData) {
					alert(reData);
					flag = "1";
				}
			} else {
				systemErrorLog();
				flag = "1";
			}
		});
		if ("0" != flag) {
			return;
		}
		WfCommonAjax.checkInvoiceAmount(bill_id, cost_center_ids, function(reData) {
			if (reData != "0") {
				if (reData == "1") {
					alert("无其它金额可再次申请！");
				} else {
					alert("此客户的发票模板未设置请到成本中心选择具体开票模版！");
				}
				flag = "1";
				return false;
			}
		});
		if ("0" != flag) {
			return;
		}
		openWindow("<%=request.getContextPath()%>/FinverificationAction.do?cmd=getCustomer&bill_id=" + bill_id + "&cost_center_ids=" + cost_center_ids + "&v_bill_id=" + v_bill_id + "&template_id=" + template_id + "&open_invoice_bd=" + open_invoice_bd + "&type=" + type);
	}

	function systemErrorLog() {
		alert("系统异常，请联系IT。");
	}

	//手工开票
	function submit_handwork_InvoiceApproval() {
		var is_gather_str = "";//实收 部分实收
		var no_gather_str = "";//未实收
		var template_id = "";//开票模板id
		var is_hand_str = "";
		var ids = new Array(0);//账单id
		//判断是否批量提交
		if (_$("#jelle_test_div").is(":hidden")) {
			//隐藏 则走之前的方法
			var datacell = $id("celllist1");
			var dataset1 = datacell.dataset;
			//获得选中的账单id
			ids = selectIds1();
			if (ids == null || ids == '') {
				alert("<fmt:message key='alert_select_bill'/>");
				return;
			}
			//循环数据
			for (var i = 0; i < ids.length; i++) {
				var datasettr1 = dataset1.findEntity("id", ids[i]);
				var cust_name = datasettr1.getValue("cust_name");
				var bill_gather_status_bd = datasettr1.getValue("bill_gather_status_bd");//实收状态
				var open_invoice = datasettr1.getValue("open_invoice");//手工开票还是系统开票

				if (bill_gather_status_bd != "3") {//实收状态
					is_gather_str += cust_name + "\n\n";
				} else {
					no_gather_str += cust_name + "\n\n";
				}
				//系统开票不允许申请手工开票
				if (open_invoice == "0") {
					is_hand_str += cust_name + "\n\n";
				}
			}
		} else {
			//显示 则是批量提交
			var datacell = $id("celllist4");
			var dataset1 = datacell.dataset;
			var count = datacell.getCurrentRowCount();//记录数
			if (count == 0) {
				alert("请选择要开票的账单！");
				return;
			}

			for (var i = 0; i < count; i++) {
				var row = datacell.table.tBodies[0].rows[i];
				var entity = datacell.getEntity(row);
				var cust_name = entity.getValue("cust_name");
				var bill_gather_status_bd = entity.getValue("bill_gather_status_bd");//实收状态
				var open_invoice = entity.getValue("open_invoice");//手工开票还是系统开票
				//赋值账单id
				ids.push(entity.getValue("id"));
				if (bill_gather_status_bd != "3") {//实收状态
					is_gather_str += cust_name + "\n\n";
				} else {
					no_gather_str += cust_name + "\n\n";
				}
				//系统开票不允许申请手工开票  add by whj
				if (open_invoice == "0") {
					is_hand_str += cust_name + "\n\n";
				}
			}
		}
		if (is_hand_str != "") {
			alert(is_hand_str + "以上账单是系统开票,不允许申请手工开票！");
			return;
		}
		if (is_gather_str != "" && no_gather_str == "") {
			//如果是部分实收+实收完成 则走系统开票的方法
			showInvoiceApproval(1);
			return;
		} else if (is_gather_str != "" && no_gather_str != "") {
			alert("实收状态不一致的账单，不允许合并申请手工开票！");
			return;
		}

		var cFlag = true;
		var bill_id = ids + "";
		DWREngine.setAsync(false);//数据同步
		WfCommonAjax.isRecalcBill(bill_id, function(reData){
			if (!!reData) {
				if ("0" != reData) {
					alert(reData);
					cFlag = false;
				}
			} else {
				systemErrorLog();
				cFlag = false;
			}
		});
		if (cFlag == false) {
			return;
		}
		WfCommonAjax.hasProductTypeAndServiceType(bill_id, function(reData){
			if (!!reData) {
				if ('0' != reData) {
					alert(reData);
					cFlag = false;
				}
			} else {
				systemErrorLog();
				cFlag = false;
			}
		});
		if (cFlag == false) {
			return;
		}
		WfCommonAjax.checkInvoiceHaveRate(bill_id, function(reData){
			if (!!reData) {
				if ('0' != reData) {
					alert(reData);
					cFlag = false;
				}
			} else {
				systemErrorLog();
				cFlag = false;
			}
		});
		if (cFlag == false) {
			return;
		}
		//判断是否开具过营业税发票，如果开过就不能再开具增值税发票
		WfCommonAjax.isRejectTicket(bill_id, function (reData) {
			if (!!reData) {
				if (reData != "0") {
					if (reData == "1") {
						alert("用户已经开具营业税发票。");
					} else {
						alert("没有获取营业税的相关金额，无法开具增票。");
					}
					cFlag = false;
				}
			} else {
				systemErrorLog();
				cFlag = false;
			}
		});
		if (cFlag == false) {
			return;
		}
		//查询账单总共开了几次票
		WfCommonAjax.checkInvoiceCountBill(bill_id, function(v_reData) {
			var invoice_msg = v_reData;
			if (!!invoice_msg) {
				if ("no_ticket" != invoice_msg) {
					cFlag = confirm("您选择的账单已开过" + invoice_msg + "，是否继续申请?");
				}
			} else {
				systemErrorLog();
				cFlag = false;
			}
		});
		if (cFlag == false) {
			return;
		}
		WfCommonAjax.isSameTaxerType(bill_id, function(v_reData){
			if(!!v_reData) {
				if ("1" == v_reData) {
					alert("纳税人类型不同的发票不能合并开票。");
					cFlag = false;
				}
			} else {
				systemErrorLog();
				cFlag = false;
			}
		});
		if (cFlag == false) {
			return;
		}
		//多个账单判断成本中心是否一样如果不一样须要选择一个成本中心作为发票抬头
		var cost_center_ids = fetchCostCenterId(bill_id, ids[0]);
		if (!cost_center_ids) return;

		//获得成本中心的开票模板
		WfCommonAjax.getCostCenterTemplate(cost_center_ids, function (reData) {
			if (!!reData) {
				if (reData[0] == 1) {
					template_id = reData[1];
				} else {
					alert(reData[1]);
					cFlag = false;
				}
			} else {
				systemErrorLog();
				cFlag = false;
			}
		});
		if (cFlag == false) {
			return;
		}
		openWindow("<%=request.getContextPath()%>/FinverificationAction.do?cmd=toManualInvoice&bill_id=" + bill_id + "&cost_center_ids=" + cost_center_ids + "&template_id=" + template_id);
	}
    
    /**
 * 选择一条记录到明细审批页面
 */
function list2approvalItem() {
	var bill_id = $id("bill_id").value;
	if(bill_id==null||bill_id==""){
		alert("<fmt:message key='alert_select_one'/>");
		return ;
	}

	if (bill_id) {
		//w为窗口宽度，h为高度
		var w = 1250;
		var h = 600;
		var l = 70;//(screen.width - w) / 2;
		var t = 70;//(screen.height - h) / 2;
		var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l;
		s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no';
		var url = "/FAERP/FinbillAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
		window.open(url, 'newwindow', s);
	}
}

//无账单开票
function no_Bill_Fininvoice(flag) {
	var strUrl = "<%=request.getContextPath()%>/FinclaimAction.do?cmd=showFininvoicePageByIncomingId&no_amount_flag="+flag;
	showModalCenter(strUrl, "", "", "880", "450", "无账单开票");
}   
//批量添加账单
 function addBill(){
       var datacell = $id("celllist1");
       var datacell2 = $id("celllist4");
       var dataset1 = datacell.dataset;
       var dataset2 = datacell2.dataset;
       var ids = selectIds1();
       if(ids == null || ids == '') {
             alert("<fmt:message key='alert_select_bill'/>");
             return;
       }
       _$("#jelle_test_div").show();  
       var count = datacell2.getCurrentRowCount();//当前已经存在的记录数
       for(var i=0;i<ids.length;i++){
                var datasettr1 = dataset1.findEntity("id",ids[i]);
                //不允许重复
               // var datasettr2 = dataset2.findEntity("id",ids[i]);
                for(var j=0;j<count;j++){
                        var row = datacell2.table.tBodies[0].rows[j];
                        var entity = datacell2.getEntity(row);
                        var bill_id = entity.getValue("id");//账单id
                        if(bill_id == ids[i]){
                            alert("请勿重复选择账单");
                            return false;
                        }
                }
                datacell2.insertRow(datasettr1);
       }
}

//关闭批量选择
function hideDiv(){
    _$("#jelle_test_div").hide();
}
//删除行
function deleteSelectRow(){
    var entity = $id("celllist4").getActiveEntity();
    var totalCount = $id("celllist4").getCurrentRowCount();//员工记录数
    if(entity == "" || entity == null || totalCount==0){
         alert("请选中一条记录！");
         return;
     }
     $id("celllist4").deleteRow();
}

//跳转进入选择集团户账单页面
function addGroupBill(){
        var cust_id = _$("#select_cust_id").val();
        if(cust_id == null || cust_id == ""){
            alert("请先选择一个客户！");
            return false;
        }
        var bill_year_month = _$("#bill_year_month").val();
        var strUrl = "<%=request.getContextPath()%>/FinbillAction.do?cmd=toSelectGroupBill&cust_id="+cust_id+"&bill_year_month="+bill_year_month;
        showModalCenter(strUrl, "", selectBillReturn, "1200", "450", "选择集团户账单");
}
//选择完集团户账单的返回方法
function selectBillReturn(retVal){
    var datacell2 = $id("celllist4");
    var dataset2 = datacell2.dataset;
    _$("#jelle_test_div").show();  
    var count = datacell2.getCurrentRowCount();//当前已经存在的记录数
    for(var i=0;i<retVal.length;i++){
             var datasettr1 =retVal[i];
             var et = new Entity();
             et.setProperty("id",retVal[i].getValue("id"));
             et.setProperty("cust_code",retVal[i].getValue("cust_code"));
             et.setProperty("cust_name",retVal[i].getValue("cust_name"));
             et.setProperty("cost_center_name",retVal[i].getValue("cost_center_name"));
             et.setProperty("cost_center_id",retVal[i].getValue("cost_center_id"));
             et.setProperty("bill_year_month",retVal[i].getValue("bill_year_month"));
             et.setProperty("version",retVal[i].getValue("version"));
             et.setProperty("bill_amount",retVal[i].getValue("bill_amount"));
             et.setProperty("verification_amount",retVal[i].getValue("verification_amount"));
             et.setProperty("rate_odds",retVal[i].getValue("rate_odds"));
             et.setProperty("rate_amount",retVal[i].getValue("rate_amount"));
             et.setProperty("outstanding_amount",retVal[i].getValue("outstanding_amount"));
             et.setProperty("invoice_code",retVal[i].getValue("invoice_code"));
             et.setProperty("bill_gather_status_bd",retVal[i].getValue("bill_gather_status_bd"));
             et.setProperty("bill_invoice_status_bd",retVal[i].getValue("bill_invoice_status_bd"));
             et.setProperty("bill_type_bd",retVal[i].getValue("bill_type_bd"));
             et.setProperty("user_name",retVal[i].getValue("user_name"));
             et.setProperty("is_finance_invoice",retVal[i].getValue("is_finance_invoice"));
             et.setProperty("open_invoice",retVal[i].getValue("open_invoice"));
             
             //不允许重复
             for(var j=0;j<count;j++){
                     var row = datacell2.table.tBodies[0].rows[j];
                     var entity = datacell2.getEntity(row);
                     var bill_id = entity.getValue("id");//账单id
                     if(bill_id == retVal[i].getValue("id")){
                         alert("请勿重复选择账单");
                         return false;
                     }
             }
             datacell2.insertRow(et);
    }
}
</script>
</head>
<body>
<form name="form" action="" method="post" id="datacell_formid"> 
<input type="hidden" id="cs_name" value="<%=user_name %>"/>
<input type="hidden" id="bill_id" name="bill_id" value="">
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key='title_queryfinbill'/></div>
	</div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
        <td width="156" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
        <td width="120"/>
        <td width="294"/>
        <td width="124"/>
        <td width="298"/>
    </tr>
  <tr>
   <td align="right"><fmt:message key='select_customer'/></td>
		<td class="td_2">
		<div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="false"
			id="customer_id" name="customer_id" property="customer_id"
			displayProperty="customer_name"
			lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
			messagekey="select_customer" height="440" width="600" style="width:170px" /></div>
		</td>
		<input type="hidden" id="select_cust_id" value="" />
		<td align="right"><fmt:message key='cost_center'/></td>
		<td align="left"><r:comboSelect id="cost_center_id"
			name="cost_center_id"
			queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			textField="cost_center_name" valueField="id" xpath="CostcenterVo"
		 width="190" messagekey="please_select">
		</r:comboSelect></td>
        <td width="71" align="right"><fmt:message key='bill_year_month_0'/></td>
    <td width="238"><input type="text" value="" class="sText"
			id="bill_year_month" name="bill_year_month" /></td>
  </tr>
  <tr>
    <td align="right"><fmt:message key='debt_amount'/></td>
    <td>
    <input type="text" class="text_field_half" id="min" name="min"  maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')"  style="width: 88px"/><fmt:message key='debt_amount_to'/><input type="text" class="text_field_half" maxLength="15"  onKeyUp="if(isNaN(value))execCommand('undo')" id="max" name="max" style="width: 88px"/>
    </td>
    <td align="right"><fmt:message key='invoice_code'/></td>
    <td><input type="text" value="" class="sText" id="invoice_code" name="invoice_code"/></td>
	<td width="71" align="right"><fmt:message key='bill_invoice_status_bd'/></td>
    <td align="left">
		<%=gap.rm.tools.helper.RmJspHelper.getSelectField("bill_invoice_status_bd", -1,"INVOICE_STATUS_BD", request.getAttribute("bill_invoice_status_bd") == null ? "" : String.valueOf(request.getAttribute("bill_invoice_status_bd")), "inputName='开票状态'  style='width:190px' id='bill_invoice_status_bd'", false)%>
	</td>
  </tr>
  <tr>
    <td align="right"><fmt:message key='bill_gather_status_bd'/></td>
   <td align="left">
		<%=gap.rm.tools.helper.RmJspHelper.getSelectField( "bill_gather_status_bd", -1,"GATHER_STATUS_BD", request.getAttribute("bill_gather_status_bd") == null ? "" : String.valueOf(request.getAttribute("bill_gather_status_bd")), "inputName='实收状态'  style='width:190px' id='bill_gather_status_bd'", false)%>
   </td>
   <td align="right"><fmt:message key='bill_type_bd_0'/></td>
   <td align="left">
		  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bill_type_bd", -1,"FB_BILL_TYPE_BD",  request.getAttribute("bill_type_bd") == null ? "" : String.valueOf(request.getAttribute("bill_type_bd")),"inputName='应收类型' style='width:190px' id='bill_type_bd'", false)%>
	</td>
	<td align="center" colspan="2">
		<input type="button" class="icon_1" id="findId"  value="<fmt:message key='button_query'/>" onClick="queryall()"/>
		<input type="button" class="icon_1" value="<fmt:message key='button_reset'/>" onClick="javascript:this.form.reset();">
   </td>
  </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right">
      <input type="button" class="h_2" value="<fmt:message key='button_sqkp'/>" <au:authorityBtn code="cxys_sqkp" type="1"/> onClick="showInvoiceApproval(0);" />
      <input type="button" class="h_2" value="申请手工开票" <au:authorityBtn code="cxys_sqsgkp" type="1"/> onClick="submit_handwork_InvoiceApproval();" />
      <input type="button" class="dj_3" value="无账单预开票" <au:authorityBtn code="cxys_wrlkp" type="1"/>  onclick="no_Bill_Fininvoice(1);"  >
      <input type="button" class="dj_3" value="批量添加账单" <au:authorityBtn code="cxys_pltjzd" type="1"/>  onclick="addBill();"  >
      <input type="button" class="c_4" value="添加集团户账单" <au:authorityBtn code="cxys_tjjthzd" type="1"/>  onclick="addGroupBill();"  >
      <input type="button" class="e" value="<fmt:message key='button_export'/>" <au:authorityBtn code="cxys_dc" type="1"/> onClick="exportToExcel();" />
      <input type="button" class="c_1" value="<fmt:message key='button_ckmx'/>" <au:authorityBtn code="cxys_ckmx" type="1"/> onClick="list2approvalItem();" />
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; margin:5 0 0 5;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/FinbillAction.do?cmd=queryForYs&cust_id=${custId}&cost_center_id=${costId}&bill_year_month=${bill_year_month}"
			paramFormId="datacell_formid" width="99%" height="320px" pageSize="50"
			xpath="FinbillVo" readonly="true">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			
            <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" />
			<r:field fieldName="cust_code" messagekey="customer_code" width="60px">
				<h:text />
			</r:field>
			<r:field fieldName="cust_name" messagekey="customer_name" width="160px">
				<h:text />
			</r:field>
			<r:field fieldName="cost_center_name" messagekey="cost_center" width="160px">
				<h:text />
			</r:field>
			<r:field fieldName="bill_year_month" messagekey="bill_year_month_0" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="version" messagekey="version" width="60px">
            </r:field>
			<r:field fieldName="bill_amount" messagekey="bill_amount_0" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="verification_amount" messagekey="verification_amount" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="rate_odds" messagekey="rate_odds" width="80px">
                <h:text />
            </r:field>
            <r:field fieldName="rate_amount" messagekey="rate_amount" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="outstanding_amount" messagekey="outstanding_amount" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="invoice_code" messagekey="invoice_code" width="100px">
                <h:text />
            </r:field>
			<r:field fieldName="bill_gather_status_bd" messagekey="bill_gather_status_bd" width="100px">
				<d:select dictTypeId="GATHER_STATUS_BD" />
			</r:field>
			<r:field fieldName="bill_invoice_status_bd" messagekey="bill_invoice_status_bd" width="100px">
				<d:select dictTypeId="INVOICE_STATUS_BD" />
			</r:field>
			<%--<r:field fieldName="bill_receipt_status_bd" messagekey="bill_receipt_status_bd" width="100px">
				<d:select dictTypeId="INVOICE_STATUS_BD" />
			</r:field>--%>
			<r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="100px">
				<d:select dictTypeId="FB_BILL_TYPE_BD"/>
			</r:field>
			<r:field fieldName="user_name" messagekey="user_name" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="is_finance_invoice" label="是否需要开票" width="100px">
                <d:select dictTypeId="TrueOrFalse"/>
            </r:field>
            <r:field fieldName="open_invoice" label="开票类型" width="70px">
                <d:select dictTypeId="OPEN_INVOICE"/>
            </r:field>
		</r:datacell>
		</div>
		</div>
    <!--表格 end-->
    <!--翻页 --><!--翻页 end-->
    </div>
       <div style="width:60%; float:left; margin-left:5px; font-weight:bold; margin-top:10px;"><fmt:message key='title_dkjhxb'/></div>
    <div style="width:38%; float:left; margin-left:15px; font-weight:bold; margin-top:10px;"><fmt:message key='title_kpxxb'/></div>
    <div style="float:left; width:60%;margin:5 0 0 5;" id="values_div2" >
         <r:datacell id="celllist2"
			queryAction="/FAERP/FinbillAction.do?cmd=queryForHx"
			paramFormId="datacell_formid" width="99%" height="180px"
			xpath="IncomingAndVerify" readonly="true">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<!-- 
			<r:field allowModify="false" fieldName="id" sortAt="none" label="" width="30px" onRefreshFunc="setRadiochecked2" >
			</r:field>
			 -->
			<r:field fieldName="inc_code" messagekey="inc_code" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="inc_amout" messagekey="inc_amout" width="70px">
				<h:text />
			</r:field>
			<r:field fieldName="inc_date" messagekey="inc_date" width="80px">
				<w:date format="yyyy-MM-dd" />
			</r:field>
			<r:field fieldName="ver_amount" messagekey="ver_amount" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="rate_odds" messagekey="rate_odds" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="rate_amount" messagekey="rate_amount" width="70px">
				<h:text />
			</r:field>
			<r:field fieldName="create_date" messagekey="ver_create_date" width="130px">
				<w:date format="yyyy-MM-dd HH:mm:ss" />
			</r:field>
			<r:field fieldName="create_user_name" messagekey="ver_create_user_name" width="70px">
				<h:text />
			</r:field>
		</r:datacell>
      </div>
    <div style="float:right; width:38%;margin:5 0 0 5;" id="values_div4" >
         <r:datacell id="celllist3"
			queryAction="/FAERP/FinbillAction.do?cmd=queryForFp"
			paramFormId="datacell_formid" width="99%" height="180px"
			xpath="FininvoiceVo" readonly="true">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<r:field fieldName="id" label="id" width="0px">
            </r:field>
			<r:field fieldName="type_bd" messagekey="bill_invoice_status_bd" width="70px">
				<d:select dictTypeId="INVOICE_STATUS_BD" />
			</r:field>
			<r:field fieldName="create_date" messagekey="kp_create_date" width="150px">
				<w:date format="yyyy-MM-dd HH:mm:ss" />
			</r:field>
			<r:field fieldName="invoice_amount" messagekey="invoice_amount" width="80px">
				<h:text />
			</r:field>
		</r:datacell>
             </table>
    </div>
    
</form>

   <div id="jelle_test_div" style="border: 2px solid #ECF5FF; position: absolute; width: 30%; height: 350px; cursor: move;right:0px;top:128px;background-color: #ECF5FF;display: none;">
        <div class="right_title" style="color:#075587;padding:10px 0 4px 15px;;font-family:'宋体'; ">批量选择的账单</div>
        <r:datacell id="celllist4"
            paramFormId="datacell_formid" width="100%" height="290px" 
            xpath="FinbillVo">
            
            <r:field fieldName="cust_code" messagekey="customer_code" width="60px" allowModify="false">
            </r:field>
            <r:field fieldName="cost_center_name" messagekey="cost_center" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="bill_year_month" messagekey="bill_year_month_0" width="80px" allowModify="false">
            </r:field>
            <r:field fieldName="bill_amount" messagekey="bill_amount_0" width="80px" allowModify="false">
            </r:field>
            <!-- 20160617  by zhouxiaolong  增加成本中心ID BEGIN-->
            <r:field fieldName="cost_center_id" messagekey="cost_center_id"  width="1px" allowModify="false">
            </r:field>
            <!-- 20160617  by zhouxiaolong  增加成本中心ID END-->
        </r:datacell>
        <div style="text-align: center;">
	        <input type="button" class="icon_2" value="删除" onclick="deleteSelectRow();"/>
	        <input type="button" class="icon_2" value="关闭" onclick="hideDiv();"/>
	    </div>
    </div>
</body>
</fmt:bundle>
</html>
<script language="javascript">
	function fetchCostCenterId(bill_id, firstBillId) {
		var datacell = $id("celllist1");
		var dataset1 = datacell.dataset;
		<!-- 20160617  by zhouxiaolong  修改获取到的成本中心ID BEGIN-->
		var datacell4 = $id("celllist4");
		var dataset14 = datacell4.dataset;
		<!-- 20160617  by zhouxiaolong  修改获取到的成本中心ID END-->
		var cost_center_ids;
		if (bill_id.indexOf(",") != -1) {//判断是否有多个成本中心
			var is_same_costcenter = "0";
			WfCommonAjax.checkCostCenterSame(bill_id, function (v_reData) {
				if (v_reData != "0") {
					is_same_costcenter = "1";
				}
			});
			if (is_same_costcenter != "0") {
				var url = '<venus:base/>/jsp/faerp/finance/receivable/finbill/select_cost_center.jsp?bill_id=' + bill_id + '&date=' + new Date();
				var retArray = window.showModalDialog(url, '提示', 'dialogHeight:200px;dialogWidth:350px;center:yes;help:no;resizable:no;scroll:no;status:no;');
				cost_center_ids = retArray[0];
			} else {
				<!-- 20160617  by zhouxiaolong  修改获取到的成本中心ID BEGIN-->
				var datasettr1= dataset1.findEntity("id", firstBillId);
				var datasettr4 = dataset14.findEntity("id", firstBillId);
				if(datasettr1==""||datasettr1==null){
					cost_center_ids = datasettr4.getValue("cost_center_id");
				}else{
					cost_center_ids = datasettr1.getValue("cost_center_id");
				}
				<!-- 20160617  by zhouxiaolong  修改获取到的成本中心ID END-->
			}
		} else {
			var datasettr1 = dataset1.findEntity("id", bill_id);
			cost_center_ids = datasettr1.getValue("cost_center_id");
		}
		return cost_center_ids;
	}

	function openWindow(url) {
		url = url + '&_ts=' + (new Date()).getTime();//防止IE缓存，在每次打开时加个时间差的参数
		var w = screen.width;
		var h = screen.height;
		var s = 'width=' + w + ', height=' + h + ', top=0, left=0';
		s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no';
		window.open(url, 'newwindow', s);
	}

	_$(document).ready(function(){
         if (${custId != null } && ${custId != "" } && ${costId != null } && ${costId != "" } && ${bill_year_month != null } && ${bill_year_month != "" } ) {
            $id("celllist1").isQueryFirst = true;
         }else{
            $id("celllist1").isQueryFirst = false;
            //魏佳新增--默认费用账期为当前日期的年月
		    jQuery(function(){
		        var myDate = new Date();
		        var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
		        var month = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
		        //var day = myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
		        if(month<10){
		          month = "0"+month;
		        }
                var ym = year.toString()+month.toString();
		        document.getElementById("bill_year_month").value=ym;
		    });
         }
   		 $id("celllist2").isQueryFirst = false;
   		 $id("celllist3").isQueryFirst = false;
	});
	
	 function loadMoreData(bill_id){
	       if(_$("#"+bill_id).attr("checked") == "checked"){
              $id("bill_id").value = bill_id;
	          $id("celllist2").addParam("bill_id",bill_id);
	          $id("celllist2").loadData();
	          $id("celllist2").refresh();
	          
	          $id("celllist3").addParam("bill_id",bill_id);
	          $id("celllist3").loadData();
	          $id("celllist3").refresh();
	       }
     }
     
     
     function checkAll(item) {
	    if (_$(item).attr("checked")) {
	        changeEntityChk(true);
	        _$(":checkbox").attr("checked", true);
	    } else {
	        changeEntityChk(false);
	        _$(":checkbox").attr("checked", false);
	    }
	}
	
	function changeEntityChk(flag) {
	    var dc1 = $id("celllist1").dataset;
	    var values = dc1.values;
	    for(var i=0; i<values.length; i++){
	        var entity = values[i];
	        entity.setProperty("chk", flag);
	    }
    }
    
    function selectIds1() {
        var myids = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if ( _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                myids.push(entity.getValue("id"));
            }
        });
        //去重
        var dic = {};
        for (var i = myids.length; i--; ) {
            dic[myids[i]]=myids[i];
        }
        var r = [];
        for (var v in dic) {
            r.push(dic[v]);
        }
        return r;
    }
</script>

<script type="text/javascript">
var $j=function(id){return document.getElementById(id);};
var getMouseP=function (e){
    //获取鼠标坐标 请传递evnet参数
    e = e || window.event;
    var m=(e.pageX || e.pageY)?{ x:e.pageX, y:e.pageY } : { x:e.clientX + document.body.scrollLeft - document.body.clientLeft, y:e.clientY + document.body.scrollTop  - document.body.clientTop };
    return m;
};
    
move=function(o,t){
    o=$j(o);
    t=$j(t);
    o.onmousedown=function(ev){
        var mxy=getMouseP(ev);//获取当前鼠标坐标
        var by={x:mxy.x-(t.offsetLeft),y:mxy.y-(t.offsetTop)};
        o.style.cursor="move";
        document.onmousemove=function(ev){
            var mxy=getMouseP(ev);
            t.style.left=mxy.x-by.x+"px";
            t.style.top=mxy.y-by.y+"px";
        };
        document.onmouseup=function(){
            window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
            this.onmousemove=null;
        }
    }
}
move("jelle_test_div","jelle_test_div");
</script>