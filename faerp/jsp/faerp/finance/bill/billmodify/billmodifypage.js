_$(document).ready(function() {
    //$id("datacell").isQueryFirst = false;
    var alldataset =  new Dataset("allsubmit");
    if ($id("lk_cust")) {
    	$id("lk_cust").onReturnFunc = function (returnValue){
            var lookup = $id("lk_cust");
            lookup.value = returnValue[0];
            _$("#cust_id").val(returnValue[0]);
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
       // datacell2.queryAction = "/FAERP/BillmodifyAction.do?cmd=getItemBybillid4DataCell";    
        datacell2.queryAction = "/FAERP/FinbillitemTempAction.do?cmd=getFinbillTempByDataCell";    
        datacell2.loadData();
       //刘平 2013-06-04 会加载访问二次
         //datacell2.refresh();
        //
        
        var fields = datacell2.fields;
        var count = 8;
        var k = 3;
        for (var i=0; i < fields.length; i++ ) {
        	//i=3锁4列
        	if (i > 3) {
        		if ((i-3) % count == 0) {
        			if (fields[i].groupVal) {//如果有分组,那么就为7列分组
        				var groupname = fields[i].groupVal;
        				var td = _$(".eos-hd-row td[class='eos-dc-col-datacell2-" + parseFloat(i-7) + "']");
    				    var a0 = td.clone();
    				    var a1 = td.next().clone();
    				    var a2 = td.next().next().clone();
    				    var a3 = td.next().next().next().clone();
    				    var a4 = td.next().next().next().next().clone();
    				    var a5 = td.next().next().next().next().next().clone();
    				    var a6 = td.next().next().next().next().next().next().clone();
    				    var a7 = td.next().next().next().next().next().next().next().clone();
    				    
                        a0.css("height", "23");
                        a1.css("height", "23");
                        a2.css("height", "23");
                        a3.css("height", "23");
                        a4.css("height", "23");
                        a5.css("height", "23");
                        a6.css("height", "23");
                        a7.css("height", "23");
                                               
                        td.next().next().next().next().next().next().next().remove();
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
                        + parseFloat(70*count) +";'>" 
                        + "<table border='0' cellpadding='0' cellspacing='0' style='border:0px;margin:0px;padding:0px'>"
                        + "<tr><td colspan='" + count + "' style='text-align:center;height:23px;'>" 
                        + " <span>" + groupname + "</span></td></tr>"
                        + "<tr class='oldHeadTr'></tr></table></td>");
                        newTable.find(".oldHeadTr").append(a0).append(a1).append(a2).append(a3).append(a4).append(a5).append(a6).append(a7);
                        _$(".eos-hd-row td[class='eos-dc-col-datacell2-" + key_css + "']").after(newTable);
                        k++;
        			}
        		}
        	}
        }
        
        
        
        $id("datacell2").afterRefresh = function() {
        	//添加最后一行用于显示统计
        	//为什么添加行的动作要放在afterrefresh中？
        	//合计都从后台读
             //$id("datacell2").addRow();
            // $id("datacell2").endEdit();
           //  _$(".eos-freeze-div tr").last().find("td[fieldId^='emp_name']").find("div").text("合计");
            datacell4rightsum();
            //datacell4bottomsum();
            ////标黄不纳入应收总额
            var Me = $id("datacell2");
            var rows = Me.allTR ;
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
        }
        
        $id("datacell2").afterEdit = function(newValue,oldValue) {
            datacell4rightsum();
            //datacell4bottomsum();
        }
        
//        $id("datacell2").beforeEdit = function (cell, colIndex, rowIndex){
//            if(rowIndex == $id("datacell2").dataset.getLength()-1){
//                return false;
//           }
//        }
    }
    
    //翻页事件
if ($id("datacell2")) {
    $id("datacell2").gotoPage = function(pageParam) {
    	var isupdate = $id("isupdate").value ;
    	if(isupdate =="yes"){
    	    var xmlSubmit = this.dataset.toString();
            var myAjax = new Ajax("/FAERP/FinbillitemTempAction.do?cmd=updateFinbillTemp");
            myAjax.addParam('bill_id', $id("bill_id").value);
            myAjax.addParam('bill_temp_id', $id("bill_temp_id").value);
            myAjax.loadData(xmlSubmit);
            var returnNode = myAjax.getResponseXMLDom();
    	}
        this.pageParam = pageParam;
        this.reload();
        this.onPageChange();
    }
}

    
//修改金额计算金额
if ($id("datacell2")) {
    $id("datacell2").onUpdateCell = function(activeCell, activeEntity, activeFieldName, newValue) {
    	newValue = clearNoNum(newValue);
     	//清零 
    	if(activeFieldName =="rightsum"){
    	   if(activeEntity.getValue(activeFieldName) != newValue) {
    	       if(newValue =='0'||newValue==0){
    	       	   if(confirm('您确定将该行数据清零吗?')) {
    	       	   	   if(activeEntity.getValue(activeFieldName) =='0'||activeEntity.getValue(activeFieldName)=='0.0000'){
    	       	   	   	  alert("当前行合计为零，可以不用做清零操作") ;
    	       	   	   	  return false  ;
    	       	   	   }else{
    	       	   	   		rowclearzero(activeCell, activeEntity, activeFieldName, newValue) ;
	                       //设置已经修改
	                       $id("isupdate").value = "yes" ;
    	       	   	   }
    	       	   }
    	         
    	       }else {
    	           alert("该单元格只能做清零修改,如果清零请填写'0'！") ;
    	           return false ;
    	       }
    	   }
    	}
    	//下排清零
    	var dcell = $id("datacell2");
        var rows = dcell.allTR;
        //判断是否是最后一行
        if(activeEntity.getValue(activeFieldName) != newValue) {
        	if(dcell.getRow(rows.length-1)==dcell.getRowByCell(activeCell)){
        	   if(activeFieldName.indexOf("_emoney") > 0 || 
               activeFieldName.indexOf("_pmoney") > 0 || 
               activeFieldName.indexOf("_amount") > 0){
               	if(newValue =='0'||newValue==0){
               	    if(confirm('您确定将该列数据清零吗?')) {
               	        cellclearzero(activeCell, activeEntity, activeFieldName, newValue) ;
                        //设置已经修改
                        $id("isupdate").value = "yes" ;
               	    }
               	}else {
                     alert("该单元格只能做清零修改,如果清零请填写'0'！") ;
                      return false ;
               	}
               }
        	}
    	}
    	if(activeEntity.getValue(activeFieldName) != newValue) {
    		//设置已经修改
    		if((typeof(activeEntity.getValue(activeFieldName)) == "undefined"&&(newValue==null||newValue==""||typeof(newValue) == "undefined"))||(activeEntity.getValue(activeFieldName) == ''&&newValue=='')){
                   return false ;
                }else{
            		//document.getElementById("isupdate").value = "yes" ;
                  $id("isupdate").value = "yes" ;
                }
        }
    	
        if(activeFieldName.indexOf("_emoney") > 0 || 
           activeFieldName.indexOf("_pmoney") > 0 || 
           activeFieldName.indexOf("_amount") > 0) {
            if(activeEntity.getValue(activeFieldName) != newValue) {
//            	if((typeof(activeEntity.getValue(activeFieldName)) == "undefined"&&(newValue==null||newValue==""||typeof(newValue) == "undefined"))||(activeEntity.getValue(activeFieldName) == ''&&newValue=='')){
//            	   return false ;
//            	}
            	if(typeof(newValue) == "undefined"||newValue==""){
            	   newValue = "0" ;
            	}
                //{
                    var amountFieldName = "" ; //总额fieldname
                    var emoneyFieldName = "" ; //单位金额fieldname
                    var pmoneyFieldName = "" ; //个人金额fieldname
                    var emoneyamount = 0 ;
                    var pmoneyamount = 0 ;
                    var issumFieldName =  "" ; //是否纳入应收总额fieldname
                    if(activeFieldName.indexOf("_emoney") > 0) {
                        amountFieldName = activeFieldName.replace('_emoney', '_amount');
                        emoneyFieldName = activeFieldName;
                        pmoneyFieldName = activeFieldName.replace('_emoney', '_pmoney');
                        issumFieldName = activeFieldName.replace('_emoney','_issum') ;
                        if(newValue == null || newValue == ""){
                            emoneyamount = 0 ;
                        } else {
                            emoneyamount = Number(newValue) ;
                        }
                        if(activeEntity.getValue(pmoneyFieldName) == null || 
                           activeEntity.getValue(pmoneyFieldName) == "") {
                            pmoneyamount = 0 ;
                        }else {
                            pmoneyamount = Number(activeEntity.getValue(pmoneyFieldName)) ;
                        }
                    }
                    if (activeFieldName.indexOf("_pmoney") > 0) {
                        amountFieldName = activeFieldName.replace('_pmoney','_amount');
                        emoneyFieldName = activeFieldName.replace('_pmoney','_emoney');
                        issumFieldName = activeFieldName.replace('_pmoney','_issum');
                        pmoneyFieldName = activeFieldName;  
                        if(newValue == null||newValue == "") {
                            pmoneyamount = 0 ;
                        } else {
                            pmoneyamount = Number(newValue);  
                        }
                        if(activeEntity.getValue(emoneyFieldName) == null ||
                           activeEntity.getValue(emoneyFieldName) == "") {
                            emoneyamount=0 ;
                        }else {
                            emoneyamount = Number(activeEntity.getValue(emoneyFieldName));
                        }
                    }
                    
                    if(activeFieldName.indexOf("_amount") > 0){
                        issumFieldName = activeFieldName.replace('_amount','_issum') ;
                    }
                    if (activeEntity.getValue(issumFieldName) == '1') {
                        //修改总额
                        if(activeFieldName.indexOf("_amount") > 0){
                        }else {
                        	//20160525 update by lbd
                            var amount = new Big(emoneyamount).plus(new Big(pmoneyamount)) ;
//                             var amount = emoneyamount + pmoneyamount ;
                             activeEntity.setProperty(amountFieldName, amount);
                             $id("datacell2").refreshRow(getRow(activeCell) ,activeEntity);
                        }
                        //datacell4bottomsum();
                        //订单总额
                        var td = $id("tdid") ;
                        var totalamount = 0 ;  //修改前账单总额
                        var oldamount =  0;    //修改前单元格数据
                        var newvalue = 0 ;     //修改后单元格数据
                        var Me = $id("datacell2");
                        var rows = Me.allTR;
//                        for (var i=0;i<rows.length;i++ ){
//                          var cells = rows[i].cells;
                        var rowss = $id("datacell2").getRow(rows.length-1) ;
                        if($id("totalamount").value != null&&$id("totalamount").value != ""){
                           totalamount = Number($id("totalamount").value) ;
                        }
                        if(activeEntity.getValue(activeFieldName) != null&&activeEntity.getValue(activeFieldName) != ""&&typeof(activeEntity.getValue(activeFieldName)) != "undefined"){
                            oldamount = Number(activeEntity.getValue(activeFieldName)) ;
                        }
                        if(newValue != null&&newValue!=""&&typeof(newValue) != "undefined" ){
                            newvalue = Number(newValue) ;
                        }
                        var total =  0 ;
                        //20160525 update by lbd
                        total = new Big(totalamount).plus((new Big(newvalue).minus(new Big(oldamount)))) ;
//                        total = totalamount + (newvalue - oldamount) ;
                        
//                            if(totalamount >= oldamount){
//                                total = (totalamount - oldamount)+ newvalue ;
//                            }else {
//                                total = (oldamount - totalamount)+ newvalue ;
//                            }
                        total = total.toFixed(10);
                        td.innerHTML=total ;
                        $id("totalamount").value = total ;
                        
                        //计算下排合计
                        var ds1 = this.dataset;
                        var entity = ds1.get(ds1.getLength()-1) ;
                        var floornewvalue = 0 ;   //修改后的单元格数据
                        var flooroldamount =  0;   //修改前的单元格数据
                        if(activeEntity.getValue(activeFieldName) != null&&activeEntity.getValue(activeFieldName) != ""&&typeof(activeEntity.getValue(activeFieldName)) != "undefined"){
                            flooroldamount = Number(activeEntity.getValue(activeFieldName)) ;
                        }
                        if(newValue != null&&newValue!=""&&typeof(newValue) != "undefined"){
                            floornewvalue = Number(newValue) ;
                        }
                        
                        var fName = activeFieldName.substring(0,activeFieldName.length-6) ;
                        var totalflooroldamount = entity.getValue(fName+"amount") ;
                        var numbertotalflooroldamount = 0 ;  //修改的单元格对应的下排合计数据
                        if(totalflooroldamount!=null&&totalflooroldamount!=""&&typeof(totalflooroldamount) != "undefined"){
                           numbertotalflooroldamount = Number(totalflooroldamount) ;
                        }
                        //总额
                        var sum = 0 ;
//                        if(numbertotalflooroldamount >= flooroldamount){
//                             sum = (numbertotalflooroldamount - flooroldamount)+ floornewvalue ;
//                        }else{
//                            sum = ( flooroldamount - numbertotalflooroldamount)+ floornewvalue ;
//                        }
                        
                        //20160525 update by lbd
                        sum = new Big(numbertotalflooroldamount).plus(new Big(floornewvalue).minus(new Big(flooroldamount))) ;
//                        sum = numbertotalflooroldamount + (floornewvalue - flooroldamount) ;
                        sum = sum.toFixed(10);
                        entity.setProperty(fName+"amount", sum);  
                        if(activeFieldName.indexOf("amount") > 0){
                        }else {
                            //个人企业金额
                            var totalflooroldmoney = entity.getValue(activeFieldName) ;
                            var numbertotalflooroldmoney = 0 ;
                            if(totalflooroldmoney!=null&&totalflooroldmoney!=""&&typeof(totalflooroldmoney) != "undefined"){
                               numbertotalflooroldmoney = Number(totalflooroldmoney) ;
                            }
                            var sum2  = 0 ;
//                            if(numbertotalflooroldmoney >= flooroldamount){
//                                 sum2  = (numbertotalflooroldmoney - flooroldamount)+floornewvalue ;
//                            }else{
//                                sum2  = (flooroldamount - numbertotalflooroldmoney)+floornewvalue ;
//                            }
                            
                            //20160525 update by lbd
                            sum2 = new Big(numbertotalflooroldmoney).plus(new Big(floornewvalue).minus(new Big(flooroldamount))) ;
//                            sum2  = numbertotalflooroldmoney + (floornewvalue - flooroldamount) ;
                            sum2 = sum2.toFixed(10);
                            entity.setProperty(activeFieldName, sum2); 
                        }
                        
                        $id("datacell2").refreshRow(rowss ,ds1.get(ds1.getLength()-1));
                        datacell4rightsum();
                    } else if (typeof(activeEntity.getValue(issumFieldName)) == "undefined" ||
                                activeEntity.getValue(issumFieldName) == null ||
                                activeEntity.getValue(issumFieldName) == '') {
                        //修改总额
                        if (activeFieldName.indexOf("_amount") > 0) {
                        }else {
                        	
                        	//20160525 update by lbd
                            var amount = new Big(emoneyamount).plus(new Big(pmoneyamount)) ;
//                             var amount = emoneyamount + pmoneyamount;
                             activeEntity.setProperty(amountFieldName, amount);
                             $id("datacell2").refreshRow(getRow(activeCell), activeEntity);
                        }
                        
                       //修改订单总额
                        var td = $id("tdid") ;
                        var totalamount = 0 ;
                        var oldamount =  0;
                        if($id("totalamount").value != null&&$id("totalamount").value != ""&&typeof($id("totalamount").value) != "undefined"){
                           totalamount = Number($id("totalamount").value) ;
                        }
                        if(activeEntity.getValue(activeFieldName) != null&&activeEntity.getValue(activeFieldName) != ""&&typeof(activeEntity.getValue(activeFieldName)) != "undefined"){
                            oldamount = Number(activeEntity.getValue(activeFieldName)) ;
                        }
                        if(newValue != null&&newValue!=""&&typeof(newValue) != "undefined" ){
                            newvalue = Number(newValue) ;
                        }
                        
                        var total =  0 ;
//                        if(totalamount >= oldamount){
//                            total = (totalamount - oldamount)+ newvalue ;
//                        }else {
//                            total = (oldamount - totalamount)+ newvalue ;
//                        }
                        
                        //20160525 update by lbd
                        total = new Big(totalamount).plus(new Big(newvalue).minus(new Big(oldamount))) ;
//                        total = totalamount + (newvalue-oldamount) ;
                        
                       // total = Math.round(total * 10000) / 10000;
                        total = total.toFixed(10);
                        td.innerHTML=total ;
                        $id("totalamount").value = total ;
                        //计算下排合计
                        var ds1 = this.dataset;
                        var floornewvalue = 0 ;
                        var flooroldamount =  0;
                        if(activeEntity.getValue(activeFieldName) != null&&activeEntity.getValue(activeFieldName) != ""&&typeof(activeEntity.getValue(activeFieldName)) != "undefined"){
                            flooroldamount = Number(activeEntity.getValue(activeFieldName)) ;
                        }
                        if(newValue != null&&newValue!=""&&typeof(newValue) != "undefined" ){
                            floornewvalue = Number(newValue) ;
                        }
                        var entity = ds1.get(ds1.getLength()-1) ;
                        var fName = activeFieldName.substring(0,activeFieldName.length-6) ;
                        var totalflooroldamount = entity.getValue(fName+"amount") ;
                        var numbertotalflooroldamount = 0 ;
                        if(totalflooroldamount!=null&&totalflooroldamount!=""&&typeof(totalflooroldamount) != "undefined" ){
                           numbertotalflooroldamount = Number(totalflooroldamount) ;
                        }
                        //总额
                        var sum = 0 ;
//                        if(numbertotalflooroldamount >= flooroldamount){
//                             
//                        }else{
//                            sum = ( flooroldamount - numbertotalflooroldamount)+ floornewvalue ;
//                        }
                        
                        //20160525 update by lbd
                        sum = new Big(numbertotalflooroldamount).plus(new Big(floornewvalue).minus(new Big(flooroldamount))) ;
//                        sum = numbertotalflooroldamount +(floornewvalue - flooroldamount) ;
                        sum = sum.toFixed(10);
                        //ds1.get(ds1.getLength()-1).setProperty(fName+"amount", sum);   
                        //var entity2 = getEntity(this.selectLastRow()) ; 
                        entity.setProperty(fName+"amount", sum) ;
                        if(activeFieldName.indexOf("amount") > 0){
                        }else {
                             //个人企业金额
                                var totalflooroldmoney = entity.getValue(activeFieldName) ;
                                var numbertotalflooroldmoney = 0 ;
                                if(totalflooroldmoney!=null&&totalflooroldmoney!=""&&typeof(totalflooroldmoney) != "undefined"){
                                   numbertotalflooroldmoney = Number(totalflooroldmoney) ;
                                }
                                var sum2  = 0 ;
//                                if(numbertotalflooroldmoney >= flooroldamount){
//                                     sum2  = (numbertotalflooroldmoney - flooroldamount)+floornewvalue ;
//                                }else{
//                                    sum2  = (flooroldamount - numbertotalflooroldmoney)+floornewvalue ;
//                                }
                                
                                //20160525 update by lbd
                                sum2 = new Big(numbertotalflooroldmoney).plus(new Big(floornewvalue).minus(new Big(flooroldamount))) ;
//                                sum2  = numbertotalflooroldmoney + (floornewvalue - flooroldamount) ;
                                sum2 = sum2.toFixed(10);
                                entity.setProperty(activeFieldName, sum2); 
                        }
                       
                        var Me = $id("datacell2");
                        var rows = Me.allTR;
                        $id("datacell2").refreshRow($id("datacell2").getRow(rows.length-1) ,ds1.get(ds1.getLength()-1));
                        datacell4rightsum();
                    }
                    return true ;
            }else{
              activeEntity.setProperty(activeFieldName, newValue) ;
              return true ;
            }
        }else {
           if(activeEntity.getValue(activeFieldName)!=newValue){
               activeEntity.setProperty(activeFieldName, newValue) ;
               return true ;
           }
        }
    }
    }
});


//右边清零
function  rowclearzero(activeCell, activeEntity, activeFieldName, newValue){
    var Me = $id("datacell2");
    var rows = Me.allTR;
    var issumstr = "";  //统计不纳入总额金额
    var issumarray = new Array();  //统计不纳入总额金额
    //计算当前修改行标
    var row = 0 ;
    for (var i=0;i<rows.length;i++ ){
        var cells = rows[i].cells;
        for (var j=0;j<cells.length;j++ ){
          var cell = cells[j];
          var field = Me.getField(cell);
          if(cell == activeCell){
            row = i ;
          }
        }
    }
    for (var i=0;i<rows.length;i++ ){
        var cells = rows[i].cells;
        for (var j=0;j<cells.length;j++ ){
          var cell = cells[j];
          var field = Me.getField(cell);
          var issumFieldName = "" ;
          if(i == row){
          	if(field.fieldName.indexOf("_amount")>0||field.fieldName.indexOf("_emoney")>0||field.fieldName.indexOf("_pmoney")>0){
          		var value = 0 ;
          		var cellentityvalue = $id("datacell2").getEntity($id("datacell2").getRow(i)).getValue(field.fieldName) ;
          		if(newValue !=null&&newValue!=""){
          		    value = Number(newValue) ;
          		}
          		 if(j == cells.length-1){
          		    value = value.toFixed(10);
          		 }
          		 else {
          		    value = value.toFixed(10);
          		 }
          		 if (cellentityvalue !=null&&cellentityvalue!=''){
          		 $id("datacell2").setCellValue(cell,value)  ;
                 $id("datacell2").refreshRow(getRow(cell) ,$id("datacell2").getEntityByCell(cell));
          		 }
          	     
                 
                 //重新计算下排合计
                 var lastentity = $id("datacell2").getEntity($id("datacell2").getRow(rows.length-1)) ;
                 var lastvalue = lastentity.getValue(field.fieldName) ;
                 var sum = 0 ;
                 var lvalue = 0 ;
                 var cellvalue = 0 ;  //修改的单元格对应的下排合计
                 if(lastvalue!=null&&lastvalue!=''){
                    lvalue = Number(lastvalue) ;
                 }
                 if(cellentityvalue!=null&&cellentityvalue!=''){
                    cellvalue = Number(cellentityvalue) ;
                 }
//                 if(lvalue >= cellvalue){
//                    
//                 }else{
//                    sum = cellvalue - lvalue ;
//                 }
                 
                 //20160525 update by lbd
                 sum = new Big(lvalue).plus(new Big(0).minus(new Big(cellvalue))) ;
//                 sum = lvalue + (0-cellvalue) ;
                 sum = sum.toFixed(10);
                 lastentity.setProperty(field.fieldName, sum) ;
                 $id("datacell2").refreshRow($id("datacell2").getRow(rows.length-1) ,lastentity);
                 
                 //判断是否纳入总额
                 var entity = $id("datacell2").getEntityByCell(cell) ;
                 if(field.fieldName.indexOf("_amount") > 0){
                        issumFieldName = activeFieldName.replace('_amount','_issum') ;
                 }
                 var  issum = entity.getValue(issumFieldName) ;
                 if(issum =='0'||issum==0){
                    issumstr = issumstr+entity.getValue(field.fieldName)+"," ;
                 }
          	}
          }
          issumFieldName = "" ;
        }
    }
    //计算账单总额
                        var td = $id("tdid") ;
                        var totalamount = 0 ;
                        var oldamount =  0;
                        var newvalue = 0 ;
                        if($id("totalamount").value != null&&$id("totalamount").value != ""){
                           totalamount = Number($id("totalamount").value) ;
                        }
                        if(activeEntity.getValue(activeFieldName) != null&&activeEntity.getValue(activeFieldName) != ""){
                            oldamount = Number(activeEntity.getValue(activeFieldName)) ;
                        }
                        if(newValue != null&&newValue!="" ){
                            newvalue = Number(newValue) ;
                        }
                        var total = 0 ;
//                        if(totalamount >= oldamount){
//                             total = (totalamount - oldamount)+ newvalue ;
//                        }else {
//                             total = (totalamount - oldamount)+ newvalue ;
//                        }
                        
                        //20160525 update by lbd
                        total = new Big(totalamount).plus(new Big(newvalue).minus(new Big(oldamount))) ;
//                        total = totalamount + (newvalue - oldamount) ;
                        //去除不纳入总额值
                        issumstr = issumstr.substring(0,issumstr.length-1) ;
                        issumarray = issumstr.split(",") ;
                        var sum = 0 ;
                        for (var index = 0; index < issumarray.length; index++) {
                        	if(issumarray[index]!=null){
                        		//20160525 update by lbd
                                sum = new Big(sum).plus(new Big(Number(issumarray[index]))) ;
//                        	   sum =sum+Number(issumarray[index]) ; 
                        	}
                        }
                        
                        //20160525 update by lbd
                        total = new Big(total).minus(new Big(sum)) ;
//                        total=total-sum ;
                        total = total.toFixed(10);
                        td.innerHTML=total ;
                        $id("totalamount").value = total ;     
}
//下排清零 
function  cellclearzero(activeCell, activeEntity, activeFieldName, newValue){
    var bill_temp_id = $id("bill_temp_id").value ;
    var url = venusbase+"/FinbillitemTempAction.do?cmd=ClearZeroByFloor" ;
            url = url+"&bill_temp_id="+bill_temp_id+"&activeFieldName="+activeFieldName+"&newValue="+newValue;
            jQuery.ajax({
                   url: url,
                  type: 'post',
                  dataType: 'html',
                  timeout: 80000,
                  error: function(){
                      alert('系统编译错误！');
                      return  null;
                  },
                  success: function(text){
                      if(text!=null){   
                      	if(text!=null){
                      		//将第一页要清零的数据清零，页面动作
                      		var Me = $id("datacell2");
                            var rows = Me.allTR;
                            //计算当前修改行标
                            var row = 0 ;
                            for (var i=0;i<rows.length;i++ ){
                                var cells = rows[i].cells;
                                for (var j=0;j<cells.length;j++ ){
                                  var cell = cells[j];
                                  var field = Me.getField(cell);
                                  if(field.fieldName == activeFieldName){
                                        var ent = $id("datacell2").getEntityByCell(cell) ;
                                        var value = 0 ;
                                        if(newValue != null&&newValue!=""&&typeof(newValue) != "undefined"){
                                            value = Number(newValue) ;
                                        }
                                        if(i == rows.length -1){
                                            value = value.toFixed(10);
                                        }else {
                                            value = value.toFixed(10);
                                        }
                                        var entfieldvalue = ent.getValue(field.fieldName) ;
                                        if(entfieldvalue!=null&&entfieldvalue!=""){
	                                        ent.setProperty(field.fieldName, value) ;
	                                        $id("datacell2").refreshRow(getRow(cell) ,$id("datacell2").getEntityByCell(cell));
                                        } 
                                        
                                  }
                                }
                            }
                      		//修改订单总金额
                            var totalamount = $id("totalamount").value ; //当前页修改后的总额
                            var tamount = 0 ;
                            var oldamount = 0  ;
                            var lastamount = 0 ; 
                            if(totalamount != null&&totalamount!=''&&typeof(totalamount) != "undefined"){
                                tamount = Number(totalamount) ;  //修改前总额
                            }
                            //因为text是从后台计算过了的总额 而totalamount包含了只是页面js计算总额， 计算统一起来
                      	    var total = Number(text) ;  //修改后的总额
                      	    //获得修改前金额
                      	    if(activeEntity.getValue(activeFieldName) != null&&activeEntity.getValue(activeFieldName) != ""){
                                oldamount = Number(activeEntity.getValue(activeFieldName)) ;
                             }
                             
//                      	    if(total >= tamount){
//                      	    	if(total >= total - tamount){
//                      	    	    total = total-(total - tamount) ;
//                      	    	}else {
//                      	    	    total = (total - tamount) - total ;
//                      	    	}
//                      	    }else {
//                                    total = total+(tamount - total) ;
//                      	    }
                      	    
                      	    //20160525 update by lbd
                      	    lastamount = new Big(tamount).plus(new Big(0).minus(new Big(oldamount))) ;
//                            lastamount = tamount +(0 - oldamount)   ;
                            lastamount = lastamount.toFixed(10);
                            var td = $id("tdid")  ;
                            td.innerHTML=lastamount ;
                            $id("totalamount").value = lastamount ;  
                            datacell4rightsum();
                      	}
                      }
                  }
                  });
}




/**
 * datacell右边最后一列统计
 */
function datacell4rightsum() {
	var  issumFieldName = ""   ;
	var  issumFieldValue = ""   ;
	var fName = "" ;
	var ds1 = $id("datacell2").dataset;
	_$(".eos-body-div").each(function(i){
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
		                	 //判断是否纳入总额
		                	fName = fieldidName.substring(0,fieldidName.length-5) ;
		                	issumFieldName = fName.replace('_amount','_issum') ;
		                	issumFieldValue =  ds1.get(i).getValue(issumFieldName) ;
//		                	if(i = 1 ){
//		                	      alert(fName) ;
//		                	      alert(issumFieldName) ;  
//                                  alert(issumFieldValue) ;
//		                		  alert(fieldidName) ;
//		                	}
		                	
		                	if(issumFieldValue !="0"){
		                		val = clearNoNum(val);
		                		//20160525 update by lbd
		                		sum = new Big(sum).plus(new Big(parseFloat(val))) ;
//		                	      sum += parseFloat(val);
		                	}
		                }
		            }
		        });
		        sum = sum.toFixed(2);
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
                	//20160525 update by lbd
              		sum = new Big(sum).plus(new Big(parseFloat(curSum))) ;
//                      sum += parseFloat(curSum);
                  }
              }
              sum = sum.toFixed(10);
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
     var bill_type_bd = entity.getValue("bill_type_bd");
     var approve_bd = entity.getValue("approve_bd");
     var is_bill_modify = entity.getValue("is_bill_modify");
     if(is_bill_modify!=null&&is_bill_modify=='0'){// 判断是否可以修改账单 tanyanjun   20150525
        alert("当前账单被设置成不能修改！");
        return ;
     }
     
     if((bill_type_bd == 5) && (approve_bd == 2 || approve_bd == 3)){// 财务外包账单 限制
        alert("当前账单审批状态不能修改！");
        return ;
    }
    // var bill_temp_id = entity.getValue("bill_temp_id");
    _$.ajax({
        type : "post",
        url : venusbase + "/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
        	if (data) {
        	   if(data == "5"){
        	       //未红冲 邮件通知AR
        	       if(confirm("账单数据财务已入账，是否邮件通知财务AR组取消入账！")){
        	           _$.ajax({
					        type : "post",
					        url : venusbase + "/FinbillAction.do?cmd=sendEmailToARTeam&bill_id=" + bill_id,
					        dataType : "html",
					        success : function(data) {
					                               alert(data);
					                         }
					    });
        	       }
        	   }else{
        	       alert(data);
        	   }
        	} else {
                if (bill_id) {
                	//w为窗口宽度，h为高度  modify by yanhuan 默认弹窗最大化，方便编辑 新增 yanhuan 2014.05.29
                    var w = screen.availWidth - 10;
                    var h = screen.availHeight-50;
                    var l = 0;//(screen.width - w) / 2;
                    var t = 0;//(screen.height - h) / 2;
                    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                    s += ', toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,status=no';
                    
                    if (bill_type_bd == "7" ){
                    	var url = venusbase + "/BillmodifyAction.do?cmd=ibdBillModify&bill_id=" + bill_id ;
                    }else{
                        var url = venusbase + "/BillmodifyAction.do?cmd=list2itemPageByUpdateNew&bill_id=" + bill_id ;
                    }
                    window.open(url, 'newwindow_'+bill_id, s);
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
	//var url = venusbase + "/jsp/faerp/finance/bill/billmodify/applyformsg.jsp?ts="+(new Date()).getTime();
    //showModalCenter(url, "", modifysub_callback, "400", "200", "修改原因");
	var retVal = $id("applymsg").value ;
	var smallCheckedVal = "";
    var smallCheckedStr = getReasonType();
    var smallVallArray = smallCheckedStr.split("*");
    if(smallVallArray[0] == "false"){
        alert(smallVallArray[1]);
        return;
    }else{
	   modifysub_callback(retVal,smallVallArray[2],smallVallArray[3]) ;
	}
}

/**
 * 点击修改界面的预览后，跳转页面
 */
function billModifyScan() {
	modifyScansub();
//	var bill_id = _$("#bill_id").val();
//	if (bill_id) {
//    	//w为窗口宽度，h为高度  modify by yanhuan 默认弹窗最大化，方便编辑 新增 yanhuan 2014.05.29
//		var w = screen.availWidth - 600;
//        var h = screen.availHeight - 350;
//        var l = (screen.width - w) / 2;
//        var t = (screen.height - h) / 2;
//        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
//        s += ', toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,status=no';
//		var url = venusbase + "/BillmodifyAction.do?cmd=billModifyScan&bill_id=" + bill_id ;
//		window.open(url, 'updateScan_'+bill_id, s);
//	}
}


function modifyScansub() {
	//var url = venusbase + "/jsp/faerp/finance/bill/billmodify/applyformsg.jsp?ts="+(new Date()).getTime();
    //showModalCenter(url, "", modifysub_callback, "400", "200", "修改原因");
	
	var retVal = $id("applymsg").value ;
//	var smallCheckedVal = "";
//    var smallCheckedStr = getReasonType();
//    var smallVallArray = smallCheckedStr.split("*");
//    if(smallVallArray[0] == "false"){
//        alert(smallVallArray[1]);
//        return;
//    }else{
//	   modifyScansub_callback(retVal,smallVallArray[2],smallVallArray[3]) ;
//	}
    modifyScansub_callback(retVal,"","") ;
}


function modifyScansub_callback(retVal,smallCheckedVal,otherReason) {
    var dc2 = $id("datacell2")
    //dc2.loadData();
    //dc2.refresh();
    var xmlSubmit = dc2.dataset.toString();
    var bill_year_month = document.form.bill_year_month.value;
    var myAjax = new Ajax("/FAERP/BillmodifyAction.do?cmd=editSaveBillItem4DataCell");
    myAjax.addParam('applymsg', retVal);
    myAjax.addParam('bill_id', $id("bill_id").value);
    myAjax.addParam('bill_temp_id', $id("bill_temp_id").value);
    myAjax.addParam('bigCheckedVal', bigCheckedVal);//原因分类大类
    myAjax.addParam('smallCheckedVal', smallCheckedVal);//原因分类小类
    myAjax.addParam('otherReason', otherReason);//原因大类为其他时，填写的原因
    myAjax.addParam('billYearMonth', bill_year_month);//账单年月   营改增 --UPDATE BY LCH
    myAjax.addParam('sub', 'scan');//原因大类为其他时，填写的原因

    myAjax.loadData(xmlSubmit);
    //myAjax.submit(xmlSubmit, 'UTF-8');
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode) {
        if(myAjax.getValue("root/data/returnValue")=='0') {
        	var old_bill_id = _$("#bill_id").val();
        	var bill_id = $id("bill_temp_id").value;
        	var bill_year_month = document.form.bill_year_month.value;
        	if (bill_id) {
        		var w = screen.availWidth - 600;
                var h = screen.availHeight - 350;
                var l = (screen.width - w) / 2;
                var t = (screen.height - h) / 2;
                var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                s += ', toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,status=no';
        		//var url = venusbase + "/BillmodifyAction.do?cmd=billModifyScan&old_bill_id=" + old_bill_id + "&bill_id=" + bill_id + "&bill_year_month=" + bill_year_month ;
        		//window.open(url, 'updateScan_'+bill_id, s);
                var url = "/FAERP/BillmodifyAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
	            url=url+"&_ts="+(new Date()).getTime(); 
	            window.open(url, 'newwindow', s);
        	}
        } else {
            alert('提交失败。');
            return;
        }
    } else {
        alert('提交失败');
        return;
    }
    //提示后返回list页面
    //window.location.href = venusbase + "/BillmodifyAction.do?cmd=queryAll";
}

/**
 * modifysub()的回调
 * @param {} retVal
 */
function modifysub_callback(retVal,smallCheckedVal,otherReason) {
    var dc2 = $id("datacell2")
    //dc2.loadData();
    //dc2.refresh();
    var xmlSubmit = dc2.dataset.toString();
    var bill_year_month = document.form.bill_year_month.value;
    var myAjax = new Ajax("/FAERP/BillmodifyAction.do?cmd=editSaveBillItem4DataCell");
    myAjax.addParam('applymsg', retVal);
    myAjax.addParam('bill_id', $id("bill_id").value);
    myAjax.addParam('bill_temp_id', $id("bill_temp_id").value);
    myAjax.addParam('bigCheckedVal', bigCheckedVal);//原因分类大类
    myAjax.addParam('smallCheckedVal', smallCheckedVal);//原因分类小类
    myAjax.addParam('otherReason', otherReason);//原因大类为其他时，填写的原因
    myAjax.addParam('billYearMonth', bill_year_month);//账单年月   营改增 --UPDATE BY LCH

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

//涉及到金额页面自动控制格式
function datasetNoNum(styleId,fieldName){
        var datacell = $id(styleId);
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var salary = datasettr.getProperty(fieldName);   
        
         //金额格式处理
        salary = clearNoNum(salary);
        datasettr.setProperty(fieldName,salary);
        datacell.endEdit();
        datacell1.refresh();
    }
    
    
    function clearNoNum(salary){
		if(salary!=null&&salary!=''){
			salary = salary+'';
		   //先把非数字的都替换掉，除了数字和.
			//tanyanjun  20150708和-号
		   salary = salary.replace(/[^\d.\-]/g,"");
		   //必须保证第一个为数字而不是.
		   salary = salary.replace(/^\./g,"");
		   //保证只有出现一个.而没有多个.
		   salary = salary.replace(/\.{2,}/g,".");
		   //tanyanjun  20150708 保证只有出现一个-而没有多个-
		   salary = salary.replace(/\-{2,}/g,"-");
		   //保证.只出现一次，而不能出现两次以上
		   salary = salary.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		}
	   return salary;
	}


function countChar() {
    var totalLength = 4000;
    var content = _$("#applymsg").val();
    var currentLength = content.length;
    var count = parseFloat(totalLength) - parseFloat(currentLength);
    if (count <= 0 ) {
        var text = content.substring(0, 4000);
        _$("#applymsg").val(text);
        count = 0;
    }
    _$("#surplus").text(count);
}



function closewin () {
    afterClose();
    window.close();
}


function afterClose() {
    var dc = window.opener.$id("datacell");
    dc.reload();
}


