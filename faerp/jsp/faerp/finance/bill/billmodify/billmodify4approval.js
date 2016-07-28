_$(document).ready(function() {
    var queryAction = venusbase + "/BillmodifyAction.do?cmd=getOldItemBybillid4DataCell&bill_id="+_$("#bid").val();
    var myAjax = new Ajax(queryAction);
    myAjax.submit();
    var returndom = myAjax.getResponseXMLDom();
    var olddataset = Dataset.create(returndom, "root/data/itemVo", "olditemVo");
    if (olddataset != null && olddataset.getLength()>0) {
    	var bill_id_old = olddataset.get(0).getValue("bill_id");
    	_$("#bill_id_old").val(bill_id_old);
    }
    
    $id("datacell2").afterRefresh = function(){
    	    //先对不纳入总额标黄 2013-02-01  tanyanjun
            var Me = $id("datacell2");
            var rows = Me.allTR;
            for (var i=0;i<rows.length;i++ ){
              var cells = rows[i].cells;
              var amountName = "" ;
              for (var j=0;j<cells.length;j++ ){
                var cell = cells[j];
                var field = Me.getField(cell);
                if(field.fieldName.indexOf("_base") > 0){
                    var  entity = $id("datacell2").getEntityByCell(cell) ;
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
       // var Me = $id("datacell2");
        //var rows = Me.allTR;
        for (var i=0; i<rows.length; i++ ){
          var entity1 = Me.dataset.get(i);
          //var entityOld = olddataset.findEntity("emp_id", entity1.getProperty("emp_id"));
          var entityOld = olddataset.findEntity("emp_id_sym", entity1.getProperty("emp_id_sym"));
          var cells = rows[i].cells;
          for (var j=0;j<cells.length;j++ ){
            var cell = cells[j];
            var field = Me.getField(cell);
            var fvalue = entity1.getProperty(field.fieldName);
            var oValue = null;
            if(entityOld == null){//如果为空说明该账单只有一个版本
            	 oValue = fvalue;
            }else{ //不为空说明有多个版本 
            	 oValue = entityOld.getProperty(field.fieldName);
            }
            //TODO 这里做判断是否变色
            if (fvalue != oValue) {
            	if(parseFloat(fvalue).toFixed(2) != parseFloat(oValue).toFixed(2)){
            		var fvalue1 = parseFloat(fvalue).toFixed(2) ;
            		var oValue1 = parseFloat(oValue).toFixed(2) ;
            		if(fvalue1 == 0 && oValue1 == 0){
            			continue;
            		}
            		if(fvalue1 != null){
                cell.firstChild.title = (oValue == null ? '空' : oValue);
                cell.style.backgroundColor = "red";
            }
          }
        }        
          }
        }        
        //添加最后一行用于显示统计
        datacell4rightsum();
//        $id("datacell2").addRow();
//        $id("datacell2").endEdit();
//        _$(".eos-freeze-div tr").last().find("td[fieldId^='emp_name']").find("div").text("合计");
//        datacell4bottomsum();
    }
});
    
/**
 *
 *提交审核意见
 */
function approvsub() {
    if (!_$("#radio1").attr("checked") && !_$("#radio2").attr("checked")) {
        alert('请选择审批结果。');
        return false;
    }
    var taskuid = $id("taskuid").value;
    var confirmmsg = "";
    if (_$("#radio1").attr("checked")) {
        confirmmsg = "确定 同意 此修改吗？";
        //审核结果标识位
        flag = 0;
    } else if (_$("#radio2").attr("checked")) {
        confirmmsg = "确定 驳回 此修改吗？";
        flag = 1;
    }
    
    if(!confirm(confirmmsg + '?')){
        return false;
    } else {
    
    	_$.ajax({
            type : "post",
            url : venusbase + "/BillmodifyAction.do?cmd=approvalsub&taskuid=" +taskuid+"&flag="+flag,
            data : _$("#datacell_formid").serialize(),
            dataType : "html",
            success : function(data) {
            	if (data == '1') {
            		alert("提交成功。");
            		window.location.href = venusbase + "/dynamicQueryTaskByPersonIDAction.do?done=false";
            	} else {
            		alert("提交失败。");
            	}
            }
        });
    	//_$("#datacell_formid").attr("action", venusbase + "/BillmodifyAction.do?cmd=approvalsub");
    	//_$("#datacell_formid").submit();
    }
}


function countChar() {
    var totalLength = 4000;
    var content = _$("#approvemsg").val();
    var currentLength = content.length;
    var count = parseFloat(totalLength) - parseFloat(currentLength);
    if (count <= 0 ) {
        var text = content.substring(0, 4000);
        _$("#approvemsg").val(text);
        count = 0;
    }
    _$("#surplus").text(count);
}
    