_$(document).ready(function() {
    //$id("datacell").isQueryFirst = false;
    var alldataset =  new Dataset("allsubmit");
    if ($id("lk_cust")) {
    	$id("lk_cust").onReturnFunc = function (returnValue){
            var lookup = $id("lk_cust");
            lookup.value = returnValue[0];
            _$("#cust_name").val(returnValue[2]);
            lookup.displayValue = returnValue[2];
            $id("cost_center_id").addParam("cust_id", returnValue[0]);
            $id("cost_center_id").loadData();
            $id("cost_center_id").refresh();
            return false;
        }
    }
    
    //代办任务中的账单修改审核list页面
    if(_$("#searchApproval")) {
    	_$("#searchApproval").click(function(){
            $id("datacell3").reload();
        });
    }
    
    //修改账单页面的查询按钮
    if(_$("#btnquery")) {
        _$("#btnquery").click(function(){
        	_$("#cust_name").val(_$("#lk_cust_input").val());
            $id("datacell").reload();
        });
    }
    
    
    if($id("datacell2")) {
    	$id("datacell2").afterSubmit = function(ajax) {
            var retval = ajax.getValue("root/data/returnValue");
            if(retval) {
                alert(retval); 
            }
        }
    }
    
    
    var datacell2 = $id("datacell2");
    if(datacell2) {
    	$id("datacell2").headHeight = 23+23;
    	$id("datacell2").headTextAlign = "center";
        datacell2.init();
        //加载数据
        datacell2.queryAction = "/FAERP/AgentfinbillitemAction.do?cmd=getHistoryItemByAgentbillid4DataCell";    
        //datacell2.queryAction = "/FAERP/FinbillitemTempAction.do?cmd=getFinbillTempByDataCell";    
        datacell2.loadData();
        datacell2.refresh();
        //
        
        var fields = datacell2.fields;
        var count = 7;
        var k = 3;
        for (var i=0; i < fields.length; i++ ) {
        	//i=3锁4列
        	if (i > 3) {
        		if ((i-3) % count == 0) {
        			if (fields[i].groupVal) {//如果有分组,那么就为7列分组
        				var groupname = fields[i].groupVal;
        				var td = _$(".eos-hd-row td[class='eos-dc-col-datacell2-" + parseFloat(i-6) + "']");
    				    var a0 = td.clone();
    				    var a1 = td.next().clone();
    				    var a2 = td.next().next().clone();
    				    var a3 = td.next().next().next().clone();
    				    var a4 = td.next().next().next().next().clone();
    				    var a5 = td.next().next().next().next().next().clone();
    				    var a6 = td.next().next().next().next().next().next().clone();
    				    
                        a0.css("height", "23");
                        a1.css("height", "23");
                        a2.css("height", "23");
                        a3.css("height", "23");
                        a4.css("height", "23");
                        a5.css("height", "23");
                        a6.css("height", "23");
                        
                        td.next().next().next().next().next().next().remove();
                        td.next().next().next().next().next().remove();
                        td.next().next().next().next().remove();
                        td.next().next().next().remove();
                        td.next().next().remove();
                        td.next().remove();
                        td.remove();
                        
                        var key_css = 0;
                        var key_css_w = 0;
                        //4列以后双表头
                        if (k == 3){
                        	key_css = k;
                        	key_css_W = parseFloat(999 + k + 1);
                        } else {
                        	key_css = parseFloat(999+k);
                            key_css_W = parseFloat(999 + k + 1);
                        }
                        
                        var newTable = _$("<td class='eos-dc-col-datacell2-" + key_css_W + "' style='text-align: left; height: 46px;width:"
                        + parseFloat(100*count) +";'>" 
                        + "<table border='0' cellpadding='0' cellspacing='0' style='border:0px;margin:0px;padding:0px'>"
                        + "<tr><td colspan='" + count + "' style='text-align:center;height:23px;'>" 
                        + " <span>" + groupname + "</span></td></tr>"
                        + "<tr class='oldHeadTr'></tr></table></td>");
                        newTable.find(".oldHeadTr").append(a0).append(a1).append(a2).append(a3).append(a4).append(a5).append(a6);
                        _$(".eos-hd-row td[class='eos-dc-col-datacell2-" + key_css + "']").after(newTable);
                        k++;
        			}
        		}
        	}
        }
        
        
        $id("datacell2").afterRefresh = function() {
        	//添加最后一行用于显示统计
        	//为什么添加行的动作要放在afterrefresh中？
//             $id("datacell2").addRow();
//             $id("datacell2").endEdit();
//             _$(".eos-freeze-div tr").last().find("td[fieldId^='emp_name']").find("div").text("合计");
            datacell4rightsum();
//            datacell4bottomsum();
            
            ////标黄不纳入应收总额
            var Me = $id("datacell2");
            var rows = Me.allTR;
            for (var i=0;i<rows.length;i++ ){
                  var cells = rows[i].cells;
                  var amountName = "" ;
                  for (var j=0;j<cells.length;j++ ){
                        var cell = cells[j];
                        var field = Me.getField(cell);
                        if(field.fieldName.indexOf("_base") > 0){
                            var  entity = $id("datacell2").getEntity(rows[i])   ;
                            var issumfieldName = field.fieldName.replace('_base','_issum') ;
                            if(entity.getValue(issumfieldName)=='0'){
                                amountName =field.fieldName.replace('_base','_amount')  ;
                            }
                        }
                       if(field.fieldName == amountName){
                            cell.style.backgroundColor = "#FFFF00";
                            amountName="" ;
                       } 
                  }
            }     
        }
        
        $id("datacell2").afterEdit = function(newValue,oldValue) {
            datacell4rightsum();
//            datacell4bottomsum();
        }
        
        $id("datacell2").beforeEdit = function (cell, colIndex, rowIndex){
            if(rowIndex == $id("datacell2").dataset.getLength()-1){
                return false;
            }
        }
    }
});

/**
 * datacell右边最后一列统计
 */
function datacell4rightsum() {
	var  issumFieldName = ""   ;
    var  issumFieldValue = ""   ;
    var fName = "" ;
    var ds1 = $id("datacell2").dataset;
	_$("#.eos-body-div").each(function(i){
		//取0表示取第一个datacell中的table
		if (i == 0) {
			//_$(".eos-table tr")
			_$(this).find(".eos-table tr").each(function(i){
		        var tds = _$(this).find("td");
		        var sum = 0;
		        _$(tds).each(function(j, n){
		            var fieldidName = _$(this).attr("fieldId")
		            var x = fieldidName.indexOf("amount")
		            if (x > -1) {
		                var val = _$(this).find("div").text();
		                if (val) {
		                	fName = fieldidName.substring(0,fieldidName.length-5) ;
                            issumFieldName = fName.replace('_amount','_issum') ;
                            issumFieldValue =  ds1.get(i).getValue(issumFieldName) ;
                            
                            if(issumFieldValue !="0"){
		                           sum += parseFloat(val);
                            }
		                }
		            }
		        });
		        sum = sum.toFixed(4);
		        _$(tds).last().find("div").text(sum);
		        ds1.get(i).setProperty("rightsum", sum);
		    });
		}
	});
	
}



/**
 * datacell右边最底下一行统计
 */
function datacell4bottomsum() {
	var ds1 = $id("datacell2").dataset;
	var fields = $id("datacell2").fields;
	for(var i=0;i<fields.length+1;i++){
		if (fields[i]) {
			var fieldName = fields[i].fieldName;
            if (fieldName.indexOf("amount") >= 0 
                    || fieldName.indexOf("money") >= 0
                    || fieldName.indexOf("rightsum") >= 0) {
              var sum = 0;
              for(var j=0; j<ds1.getLength()-1; j++){
                  var curEnt = ds1.get(j);
                  var curSum = curEnt.getProperty(fieldName);
                  if(curSum){
                      sum += parseFloat(curSum);
                  }
              }
              sum = sum.toFixed(4);
              ds1.get(ds1.getLength()-1).setProperty(fieldName, sum);
            }
		}
	}
	
    var curCell = $id("datacell2").freezeBodyTable.tBodies[0].rows[ds1.getLength()-1].firstChild;
    removeClass(curCell,'eos-row-modefied');
}

/**
 * 选择一条记录到明细修改页面
 */
function list2item() {
	
    var dc = $id("datacell");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("请先选择一条记录");
        return ;
    }
    var bill_id = entity.getValue("id");
    _$.ajax({
        type : "post",
        url : venusbase + "/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
        	if (data) {
        		alert(data);
        	} else {
                if (bill_id) {
                	//w为窗口宽度，h为高度
                    var w = 1250;
                    var h = 600;
                    var l = 70;//(screen.width - w) / 2;
                    var t = 70;//(screen.height - h) / 2;
                    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
                    var url = venusbase + "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
                    window.open(url, 'newwindow', s);
                    //window.location.href = venusbase + "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
                }
        	}
        }
    });
}

/**
 * 选择一条记录到明细审批页面
 */
function list2approvalItem() {
    var dc = $id("datacell3");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("请先选择一条记录");
        return ;
    }
    var bill_id = entity.getValue("id");
    _$.ajax({
        type : "post",
        url : venusbase + "/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
            if (data) {
                alert(data);
            } else {
                if (bill_id) {
                    window.location.href = venusbase + "/BillmodifyAction.do?cmd=list2item4approval&bill_id=" + bill_id;
                }
            }
        }
    });
}

/**
 * 修改账单明细后，提交申请
 */
function modifysub() {
	var url = venusbase + "/jsp/faerp/finance/bill/billmodify/applyformsg.jsp?ts="+(new Date()).getTime();
    showModalCenter(url, "", modifysub_callback, "400", "200", "修改原因");
}

/**
 * modifysub()的回调
 * @param {} retVal
 */
function modifysub_callback(retVal) {
	var dc2 = $id("datacell2")
	
	//dc2.loadData();
	//dc2.refresh();
    var xmlSubmit = dc2.dataset.toString();
    var myAjax = new Ajax("/FAERP/BillmodifyAction.do?cmd=editSaveBillItem4DataCell");
    myAjax.addParam('applymsg', retVal);
    myAjax.addParam('bill_id', $id("bill_id").value);
    myAjax.addParam('bill_temp_id', $id("bill_temp_id").value);

    myAjax.loadData(xmlSubmit);
    //myAjax.submit(xmlSubmit, 'UTF-8');
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode) {
        if(myAjax.getValue("root/data/returnValue")) {
            alert(myAjax.getValue("root/data/returnValue"));
            window.close();
        } else {
            alert('提交失败。');
        }
    } else {
        alert('提交失败');
    }
    //提示后返回list页面
    //window.location.href = venusbase + "/BillmodifyAction.do?cmd=queryAll";
    
}


/**
 * 导出excel
 */
function exportExcel() {
	var bill_id = _$("#bill_id").val();
	/*_$.ajax({
        type : "post",
        url : venusbase + "/BillmodifyAction.do?cmd=exportExcel&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
            if (data) {
                alert("导出异常。");
            }
        }
    });*/
	var url = venusbase + "/BillmodifyAction.do?cmd=exportExcel&bill_id=" + bill_id;
	window.location.href = url;
}


 
    





function afterClose() {
    var dc = window.opener.$id("datacell");
    dc.reload();
}
