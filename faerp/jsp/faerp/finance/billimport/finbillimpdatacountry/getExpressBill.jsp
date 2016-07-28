<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.billimport.finbillimpdatacountry.finbillimpdatacountry_resource" prefix="rayoo.finance.billimport.finbillimpdatacountry.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function queryall(){
        $id("isfirstquery").value = "false" ;
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        $id("celllist2").loadData();
        $id("celllist2").refresh();
       
    }
    
	function chk_all(item){
	    if (jQuery(item).attr("checked")) {
	        jQuery("."+_$(item).attr("name")+":checkbox").attr("checked", true);
	    } else {
	        jQuery("."+_$(item).attr("name")+":checkbox").attr("checked", false);
	    }
	}
	
    function setEmpCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='checkbox'  class='empCheckAll' >";
    }
    
    function setCostCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='checkbox'  class='costCheckAll' >";
    }
    

    //选择客户的返回方法
    function rtnFuncCustomer(arg){
        var lookup = $id("customer_id");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        _$("#cust_id").val(arg[0]);
       /** $id("cost_center_id").addParam("cust_id", arg[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();**/
        return false;
    }    
    
    //获取EXPress账单数据
    /**
    function getExpressBill(type){
        var batch_name = _$("#batch_name").val();
        var bill_year_month = _$("#bill_year_month").val();
        var cust_id = _$("#cust_id").val();
        var cost_center_id = "";
         if(cust_id =="" || cust_id == null || cust_id == "undefined"){
            alert("请选择客户信息");
            return;
        }
        if(bill_year_month =="" || bill_year_month == null || bill_year_month == "undefined"){
            alert("请输入账单年月");
            return;
        } 
        if(bill_year_month != null || bill_year_month != ""){
            if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_tip_4'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_tip_5'/>");
               return;
           }
        }
       
        
        if(type == 1){
            //获得选择的成本中心id 
	        var myids = new Array(0);
	        var dc = $id("celllist2");
	        _$(".costCheckAll:checkbox").each(function(i) {
	                if ( _$(this).attr("checked")) {
	                    var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
	                    var entity = dc.getEntity(row);
	                    myids.push(entity.getValue("id"));
	                }
	        });
	        
	        if(myids == null || myids == '') {
	                alert("请选择成本中心数据！");
	                return  false ;
	        }
	        cost_center_id = myids ;
	        
	        if(cost_center_id =="" || cost_center_id == null || cost_center_id == "undefined"){
	            alert("请选择一个成本中心");
	            return;
	        }
        }
        
        var url = "<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=getExpressBill";
        //发送获取账单明细请求
        jQuery.ajax({
           url: url,
           type: 'post',
           dataType: 'html',
           data:{
                       "batch_name":batch_name,
                       "bill_year_month":bill_year_month,
                       "cust_id":cust_id,
                       "cost_center_id":cost_center_id,
                       "flag":"getData"
                     },
           async: false,
           //timeout: 10000,
           success: function(text){
                    if(text== "get_success"){
                        alert("账单明细获取成功！");
                    }else if(text == "no_data"){
                        if(confirm("EXPress系统内当前年月的账单明细还未生成，是否生成？")){
                            jQuery.ajax({
						           url: url,
						           type: 'post',
						           dataType: 'html',
						           data:{
						                       "batch_name":batch_name,
						                       "bill_year_month":bill_year_month,
						                       "cust_id":cust_id,
						                       "cost_center_id":cost_center_id,
						                       "flag":"createData"
						                     },
						           async: false,
						           timeout: 10000,
						           success: function(text){
						                    if(text== "get_success"){
						                        alert("请求EXPress系统生成账单明细成功，可在账单生成日志界面查询生成状态。");
						                    }else if(text == "get_error"){
						                        alert("调用数据生成接口异常！");
						                    }else{
						                        alert(text);
						                    }
						           }
					       }); 
                        }
                    }else if(text == "get_error"){
                        alert("调用数据获取接口异常");
                    }else if (text == "reCreate" || text == "reCreate_already"){
                            var msg;//提示语句
                            if(text == "reCreate"){
                                msg = "已经获取过数据，是否重新获取？";
                            }else if(text == "reCreate_already"){
                                msg = "已经获取过数据，且该客户下ERP已有成本中心生成社保类账单，是否重新获取？";
                            }
	                        if(confirm(msg)){
	                            jQuery.ajax({
	                                   url: url,
	                                   type: 'post',
	                                   dataType: 'html',
	                                   data:{
	                                               "batch_name":batch_name,
	                                               "bill_year_month":bill_year_month,
	                                               "cust_id":cust_id,
	                                               "cost_center_id":cost_center_id,
	                                               "flag":"reCreate"
	                                             },
	                                   async: false,
	                                   timeout: 10000,
	                                   success: function(text){
	                                            if(text== "get_success"){
	                                                alert("请求EXPress系统重新生成账单明细成功，可在账单生成日志界面查询生成状态。");
	                                            }else if(text == "get_error"){
	                                                alert("调用数据生成接口异常！");
	                                            }else{
	                                                alert(text);
	                                            }
	                                   }
	                           }); 
	                        }
                    }else{
                        alert(text);
                    }
           }
       });  
        
    }**/
    
    function getExpressBill(type){
        var batch_name = _$("#batch_name").val();
        var bill_year_month = _$("#bill_year_month").val();
        var cust_id = _$("#cust_id").val();
        var cost_center_id = "";
        
        if(cust_id =="" || cust_id == null || cust_id == "undefined"){
            alert("请选择客户信息");
            return;
        }
        
        if(bill_year_month =="" || bill_year_month == null || bill_year_month == "undefined"){
            alert("请输入账单年月");
            return;
        }
        if(bill_year_month != null || bill_year_month != ""){
            if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_tip_4'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_tip_5'/>");
               return;
           }
        }
      
        if(type == 1){
            //获得选择的成本中心id 
            var myids = new Array(0);
            var dc = $id("celllist2");
            _$(".costCheckAll:checkbox").each(function(i) {
                    if ( _$(this).attr("checked")) {
                        var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
                        var entity = dc.getEntity(row);
                        myids.push(entity.getValue("id"));
                        cust_id = entity.getValue("customer_id");
                    }
            });
            if(myids == null || myids == '') {
                    alert("请选择成本中心数据！");
                    return  false ;
            }
            cost_center_id = myids.join() ;
        }
        
        
        //验证是否有获取过数据
        _$.ajax({
           url: "<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=checkHistoryXpressData",
           type: 'post',
           dataType: 'html',
           data:{
                       "bill_year_month":bill_year_month,
                       "cust_id":cust_id,
                       "cost_center_id":cost_center_id
                     },
           async: false,
           success: function(text){
                    if(text != "" && text != null &&  text != "null"){
                        if(!confirm(text)){
                             return false; 
                        }
                    }
                    
                    //发送获取账单明细请求
                    _$.ajax({
                           url: "<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=getXpressBill",
                           type: 'post',
                           dataType: 'html',
                           data:{
                                       "batch_name":batch_name,
                                       "bill_year_month":bill_year_month,
                                       "cust_id":cust_id,
                                       "cost_center_id":cost_center_id
                                     },
                           async: false,
                           success: function(text){
                                        alert(text);
                           }
                    });
           }
        });
        
    }
    
    
    //获取EXPress账单数据
    /**function getExpressBillForEmp(){
        var batch_name = _$("#batch_name").val();
        var bill_year_month = _$("#bill_year_month").val();
        var cust_id = _$("#cust_id").val();
        var emp_post_ids = "" ;
         if(cust_id =="" || cust_id == null || cust_id == "undefined"){
            alert("请选择客户信息");
            return;
        }
        if(bill_year_month =="" || bill_year_month == null || bill_year_month == "undefined"){
            alert("请输入账单年月");
            return;
        }
        if(bill_year_month != null || bill_year_month != ""){
            if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_tip_4'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_tip_5'/>");
               return;
           }
        }
        
        //获得选择的emp_post_id 
        var myids = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
	    _$(".empCheckAll:checkbox").each(function(i) {
	            if ( _$(this).attr("checked")) {
	                var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
	                var entity = dc.getEntity(row);
	                myids.push(entity.getValue("emp_post_id"));
	            }
	    });
        if(myids == null || myids == '') {
		        alert("请选择员工数据！");
		        return  false ;
		}
		emp_post_ids = myids ;
        var url = "<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=getExpressBillForEmp&emp_post_ids="+emp_post_ids;
        //发送获取账单明细请求
        jQuery.ajax({
           url: url,
           type: 'post',
           dataType: 'json',
           data:{
                       "batch_name":batch_name,
                       "bill_year_month":bill_year_month,
                       "cust_id":cust_id,
                       "flag":"getData"
                     },
           async: false,
           success: function(text){
                    if(text.result_code== "get_success"){
                        alert("账单明细获取成功！");
                    }else if(text.result_code == "no_data"){
                        if(confirm("EXPress系统内当前年月的账单明细还未生成，是否生成？")){
                            jQuery.ajax({
						           url: url,
						           type: 'post',
						           dataType: 'json',
						           data:{
						                       "batch_name":batch_name,
						                       "bill_year_month":bill_year_month,
						                       "cust_id":cust_id,
						                     //  "cost_center_id":cost_center_id,
						                       "flag":"createData"
						                     },
						           async: false,
						           success: function(text){
						                    if(text.result_code== "0"){
						                         alert(text.description);
						                    }else if(text.result_code == "6"){
						                        alert(text.description);
						                        var batch_id = text.get_batch_id ;
						                        var urls = "/FAERP/FinbillimpdatacountryAction.do?cmd=toShowExpressLogList&get_batch_id="+batch_id  ;
						                        window.open(urls,'','height=200px,width=750px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
						                    }else{
						                        alert(text.description);
						                    }
						           }
					       }); 
                        }
                    }else if(text.result_code == "get_error"){
                        alert("调用数据获取接口异常");
                    }else if (text.result_code == "reCreate" || text.result_code == "reCreate_already"){
                            var msg;//提示语句
                            if(text.result_code == "reCreate"){
                                msg = "已经获取过数据，是否重新获取？";
                            }else if(text.result_code == "reCreate_already"){
                                msg = "已经获取过数据，且该客户下ERP已有成本中心生成社保类账单，是否重新获取？";
                            }
	                        if(confirm(msg)){
	                            jQuery.ajax({
	                                   url: url,
	                                   type: 'post',
	                                   dataType: 'json',
	                                   data:{
	                                               "batch_name":batch_name,
	                                               "bill_year_month":bill_year_month,
	                                               "cust_id":cust_id,
	                                               "flag":"reCreate"
	                                             },
	                                   async: false,
	                                   success: function(text){
	                                             if(text.result_code== "0"){
								                      alert(text.description);
								                    }else if(text.result_code == "6"){ //有获取异常数据
								                        alert(text.description);
								                        var batch_id = text.get_batch_id ;
								                        var urls = "/FAERP/FinbillimpdatacountryAction.do?cmd=toShowExpressLogList&get_batch_id="+batch_id  ;
								                        window.open(urls,'','height=200px,width=750px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
								                    }else{
								                        alert(text.description);
								                    }
	                                   }
	                           }); 
	                        }
                    }else{
                        alert(text);
                    }
           }
       });  
        
    }**/
    
    //获取EXPress账单数据
    function getExpressBillForEmp(){
        var bill_year_month = _$("#bill_year_month").val();
        var cust_id = _$("#cust_id").val();
        var emp_post_ids = "" ;
        if(cust_id =="" || cust_id == null || cust_id == "undefined"){
            alert("请选择客户信息");
            return;
        }
        if(bill_year_month =="" || bill_year_month == null || bill_year_month == "undefined"){
            alert("请输入账单年月");
            return;
        }
        if(bill_year_month != null || bill_year_month != ""){
            if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_tip_4'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_tip_5'/>");
               return;
           }
        }
        //获得选择的emp_post_id 
        var myids = new Array(0);
        var costCenterIds = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
        _$(".empCheckAll:checkbox").each(function(i) {
                if ( _$(this).attr("checked")) {
                    var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
                    var entity = dc.getEntity(row);
                    myids.push(entity.getValue("emp_post_id"));
                    //防止重复
                    if(_$.inArray(entity.getValue("cost_center_id"),costCenterIds) == -1){
                        costCenterIds.push(entity.getValue("cost_center_id"));
                    }
                }
        });
        
        if(myids == null || myids == '') {
                alert("请选择员工数据！");
                return  false ;
        }
        
        if(costCenterIds == null || costCenterIds == '') {
                alert("人员所属成本中心数据为空，请联系管理员！");
                return  false ;
        }
        
        emp_post_ids = myids.join() ;
        
        //验证是否有获取过数据
        _$.ajax({
           url: "<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=checkHistoryXpressData",
           type: 'post',
           dataType: 'html',
           data:{
                       "bill_year_month":bill_year_month,
                       "cust_id":cust_id,
                       "cost_center_id":costCenterIds.join(),
                       "flag":"fromEmp"
                     },
           async: false,
           success: function(text){
                if(text == "" || text == null || text == "null"){
                    //通过验证 则获取数据
                    var url = "<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=getExpressBillForEmp";
                    
			        //发送获取账单明细请求
			        jQuery.ajax({
			           url: url,
			           type: 'post',
			           dataType: 'json',
			           data:{  "emp_post_ids":emp_post_ids,
			                       "bill_year_month":bill_year_month,
			                       "cust_id":cust_id
			                     },
			           async: false,
			           success: function(text){
			                                        if(text.result_code == "6"){ //有获取异常数据
                                                        alert(text.description);
                                                        var batch_id = text.get_batch_id ;
                                                        var urls = "/FAERP/FinbillimpdatacountryAction.do?cmd=toShowExpressLogList&get_batch_id="+batch_id  ;
                                                        window.open(urls,'','height=200px,width=750px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
                                                    }else{
                                                        alert(text.description);
                                                    }
			           }
			        });
                    
                }else{
                    alert(text);
                }
           }
        });
    }
</script>
</head>
<body>
<form name="form" id="datacell_formid" action="" method="post"> 
<input type="hidden" id="isfirstquery" name="isfirstquery" value="true"/>
<input type="hidden" name="cmd" value="">
<div id="right">
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="right" ><fmt:message key='batch_name'/></td>
    <td align="left" >
     <div><input type="text" class="text_field" name="batch_name" id="batch_name"  style="width:150px"/>
    </td>
    <td align="right" ><span style="color:red">*</span><fmt:message key='bill_year_month'/></td>
    <td align="left"><input type="text" class="text_field" name="bill_year_month" id="bill_year_month"  maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" style="width:100px"/></td>
  	<td  align="right"  >姓名&nbsp;&nbsp;</td>
  	<td  align="left" >
        <input type="text" class="text_field" name="emp_name" id="emp_name"  style="width:100px"/>
    </td>
    <td  align="right" >唯一号&nbsp;&nbsp;</td>
    <td  align="left" ><input type="text" class="text_field" name="emp_code" id="emp_code"  style="width:100px"/></td>
    <td  align="right" style="width:80px">身份证&nbsp;&nbsp;</td>
    <td  align="left" ><input type="text" class="text_field" name="id_card" id="id_card"  style="width:150px"/></td>    
   </tr>
  <tr>
			<td align="right" ><span style="color:red">*</span>客户名称</td>
			<td align="left"> <w:lookup readonly="true" id="customer_id" name="customer_id"
	             onReturnFunc="rtnFuncCustomer"
	             lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
	             messagekey="select_cust" height="500" width="600" style="width:135px;" />
	              <input type="hidden" id="cust_id" name="cust_id" value="">
	             </td>
	             <td  align="right"  >委派城市&nbsp;&nbsp;</td>
            	<td  align="left" >
            	 <r:comboSelect id="city_name" name="city_name"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="100px"
                       nullText="请选择" />
              </td>
			  <td align="center" colspan="6" >
				<input type="button" id='submitid1' class="icon_2" value="查询" <au:authorityBtn code="cuteoff_byquery" type="1"/> onClick="javascript:queryall()" />&nbsp;&nbsp;&nbsp;
	            <input type="button" id='submitid4' class="icon_4" style="width: 100px;" value="按客户获取账单" <au:authorityBtn code="cuteoff_bycust" type="1"/>  onClick="javascript:getExpressBill(0)" />
	            <input type="button" id='submitid3' class="icon_4" style="width: 120px;" value="按成本中心获取账单" <au:authorityBtn code="cuteoff_bycost" type="1"/> onClick="javascript:getExpressBill(1)" />
	            <input type="button" id='submitid2' class="icon_4" style="width: 100px;" value="按员工获取账单" <au:authorityBtn code="cuteoff_byemp" type="1"/> onClick="javascript:getExpressBillForEmp()" />
              </td>
		</tr>
    </table>
     </div>
    <div style="padding: 8 10 8 8;">
    
        <!-- emp datacell strat -->
        <div style="float: left;width:48%;">
		    <r:datacell 
		        id="celllist1"
		        queryAction="/FAERP/FinbillimpdatacountryAction.do?cmd=queryEmpPostDataByXpress"
		        width="100%"
		        height="320px" 
		        xpath="EmppostXpressVo"
		        paramFormId="datacell_formid"
		        freezeNumber="3"
		        >
		      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
		      <r:field allowModify="false" fieldName="chk" sortAt="none" 
		                label="<input type='checkbox' name='empCheckAll' id='empCheckAll' onclick='chk_all(this);' />"
		                 width="30px" onRefreshFunc="setEmpCheckboxStatus">
		      </r:field>
		      <r:field fieldName="emp_name" label="员工姓名" width="100">
		      </r:field>
		      <r:field fieldName="emp_code" label="唯一号" width="100">
		      </r:field>
		      <r:field fieldName="id_card" label="身份证" width="130">
		      </r:field>
		      <r:field fieldName="customer_name" label="客户名称" width="190">
		      </r:field>
		      <r:field fieldName="customer_code" label="客户编号" width="100">
		      </r:field>
		      <r:field fieldName="post_status_bd" label="入离职状态" width="70">
		      </r:field>
		      <r:field fieldName="apply_on_post_date" label="入职时间" width="100">
		      </r:field>
		      <r:field fieldName="cost_center_name" label="成本中心" width="150">
		      </r:field>
		      <r:field fieldName="city_name" label="派往城市" width="70">
		      </r:field>
		    </r:datacell>
	    </div>
	    <!-- emp datacell end -->
	    
	    <!-- costcenter datacell start -->
	    <div style="float: right;width:48%;">
		    <r:datacell 
	            id="celllist2"
	            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerIDPage"
	            width="100%"
	            height="320px" 
	            xpath="CostcenterVo"
	            paramFormId="datacell_formid"
	            pageSize="30"
	            >
	          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	          <r:field allowModify="false" fieldName="chk" sortAt="none" 
	                    label="<input type='checkbox' name='costCheckAll' id='costCheckAll' onclick='chk_all(this);' />"
	                     width="30px" onRefreshFunc="setCostCheckboxStatus">
	          </r:field>
	          <r:field fieldName="customer_code" label="客户编号" width="100">
	          </r:field>
	          <r:field fieldName="customer_name" label="客户名称" width="180">
	          </r:field>
	          <r:field fieldName="cost_center_name" label="成本中心名称" width="180">
	          </r:field>
	        </r:datacell>
        </div>
        <!-- costcenter datacell end -->
        
    </div>
  </div>
    </div>
   
</form>
</body>
</fmt:bundle>
</html>
