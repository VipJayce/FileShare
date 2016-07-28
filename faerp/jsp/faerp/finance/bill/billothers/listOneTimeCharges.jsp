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
<fmt:bundle basename="rayoo.finance.bill.billothers.billothers_resource" prefix="rayoo.finance.bill.billothers.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datacell</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "@" + entity.getProperty("bill_type_bd") + "\");>";
    }

   function ClickRow(value){
  		var ts = value.split("@");
		$id("bill_type_bd").value = ts[1];
        $id("bill_id").value = ts[0];
		jQuery.ajax({
	        type : "post",
	        url : "<%=request.getContextPath()%>/FinbillAction.do?cmd=retrieveBillStatus&bill_id=" + ts[0],
	        dataType : "html",
	        success : function(data) {
              	if(data == '0'){
              	
              		document.getElementById("changeButton").style.display = "none";
              		$id("datacell2").loadData();
        			$id("datacell2").refresh();
              	} else if(data == '2'){
              	    /**alert("账单数据财务已入账，如需调整，请联系财务部高燕先取消入账。");
              	    document.getElementById("changeButton").style.display = "none";
                    $id("datacell2").loadData();
                    $id("datacell2").refresh();
                    **/
                    document.getElementById("changeButton").style.display = "none";
                    if(confirm("账单数据财务已入账，是否邮件通知财务AR组取消入账！")){
                       _$.ajax({
                            type : "post",
                            url : "<%=request.getContextPath()%>/FinbillAction.do?cmd=sendEmailToARTeam&bill_id=" + ts[0],
                            dataType : "html",
                            success : function(data) {
                                                   alert(data);
								                   $id("datacell2").loadData();
								                   $id("datacell2").refresh();
                                             }
                        });
                   }
              	}else{
              		document.getElementById("changeButton").style.display = "block";
              		$id("datacell2").loadData();
        			$id("datacell2").refresh();
              	}
            }
	    });
		
      
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        $id("bill_id").value="";
    }
    
    function resetQuery(){
        $id("cust_id").value="";
        $id("cost_center_id").value="";
    }
    
    function setCheckbox(value,entity,rowNo,cellNo){
       
       return "<input type='radio'  name='temp1'   onClick=ClickRow1(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow1(value){
        $id("bill_others_id").value = value;
    }
    
    function toAdd_onClick() {
        var bill_id = $id("bill_id").value;
        var bill_type_bd = $id("bill_type_bd").value;
        if(bill_type_bd == null || bill_type_bd == 3){
        	alert("<fmt:message key='alert_bill_type_bd_3'/>");
        	return;
        }
        if(bill_id!=null&&bill_id!=""){
            //$id("datacell2").addRow();
      var url="<%=request.getContextPath()%>/jsp/faerp/finance/bill/billothers/insertOneTimeCharge.jsp";
      url=url+"?_ts="+(new Date()).getTime()+"&bill_id="+bill_id;
       showModalCenter(url,window,callback, 700, 260, "添加一次性收费");       
            
        }else{
            alert("<fmt:message key='alert_select_record'/>");
            return;
        }
    }
    
function to_update(){
    var entity=$id("datacell2").getActiveEntity();
    if(entity!=null){
    	var charge_item=entity.getProperty("charge_item_bd");
    	if("789" == charge_item || "101112" == charge_item){//尾差不能删除
    		alert("无法修改尾差！");
          	return;
    	}
	    var department=entity.getProperty("department_name");
	    var charge_item=entity.getProperty("charge_item_bd");
	    var  amount=entity.getProperty("amount");
	    var  remark=entity.getProperty("charge_desc");
	    var bill_others_id=entity.getProperty("id");
	    var bill_id = $id("bill_id").value;
	    //增值税及税金、附加税及税金
	    var action="<%=request.getContextPath()%>/FinbillAction.do?cmd=queryBillOthersById";
	    var myAjax = new Ajax(action);
	    myAjax.addParam("id",bill_others_id);
	    myAjax.submit();
	    var returnNode = myAjax.getResponseXMLDom();
	    var type = ""+myAjax.getProperty("returnValue");//返回结果类型
	   	var jsonMess = ""+myAjax.getProperty("returnMessage");//增值税税率
	   	if("1" == type){
	   		jsonMess = eval('(' + jsonMess + ')');
		    var value_added_tax_amount= jsonMess.vat_amount;
		    var value_added_tax_rate = jsonMess.vat_rate;
		    var additional_tax_amount= jsonMess.add_vat_amount;
		    var additional_tax_rate = jsonMess.add_vat_rate;
		    var service_type = jsonMess.service_type;
		    var department = jsonMess.department_name;
		    var charge_item = jsonMess.charge_item_bd;
		    var amount = jsonMess.amount;
		    var remark = jsonMess.charge_desc;
		    var addUrl = "&value_added_tax_amount="+value_added_tax_amount+""+"&value_added_tax_rate="+value_added_tax_rate+"&additional_tax_amount="+additional_tax_amount+"&additional_tax_rate="+additional_tax_rate+"&service_type="+service_type;
	   	}
	   	var url="<%=request.getContextPath()%>/jsp/faerp/finance/bill/billothers/updateOneTimeCharge.jsp";
	    url=url+"?_ts="+(new Date()).getTime()+"&bill_id="+bill_id+"&department="+department+"&charge_item="+charge_item+"&amount="+amount+"&remark="+remark+"&bill_others_id="+bill_others_id+addUrl;
	    showModalCenter(url,window,callback, 700, 260, "修改一次性收费");       
	}else{
		alert("请选择一条记录！");
		return;
	}
}    
    
    
    
    
      function callback(){
         $id("datacell1").loadData();
        $id("datacell1").refresh();
         $id("datacell2").loadData();
         $id("datacell2").refresh();
      }
    
     function deleteMulti_onClick(){
      var entity=$id("datacell2").getActiveEntity();
      var bill_id =entity.getProperty("id");
        if(bill_id!=null&&bill_id!=""){
        	var charge_item=entity.getProperty("charge_item_bd");
        	if("789" == charge_item || "101112" == charge_item){//尾差不能删除
        		alert("无法删除尾差！");
              	return;
        	}else{
	           $id("datacell2").deleteRow();
	            toSave_onClick();
        	}
        }else{
            alert("<fmt:message key='alert_select_record'/>");
            return;
        }
    }
    
    
    function toSave_onClick() { 
        var bill_id = $id("bill_id").value;
        if(bill_id!=null&&bill_id!=""){
            $id("datacell2").isModefied = true;
            if($id("datacell2").submit()){
                alert("<fmt:message key='alert_save_success'/>");
                $id("datacell1").loadData();
                $id("datacell1").refresh();
                $id("bill_id").value="";
                $id("datacell2").loadData();
                $id("datacell2").refresh();
            }
        }else{
            alert("<fmt:message key='alert_select_record'/>");
            return;
        }
    }
    
        function choose_row(tagid) {
             if($id(tagid).value==""){
                    alert("<fmt:message key='alert_select_one'/>");
                    return false;
             }
             return true;
        }
    function addOneTimeChargeBill(){
    	var customer = $id("lk_cust").value;
    	var cost_center = $id("cost_center_id").getValue();
    	var bill_year = $id("billyearmonth").value;
    	
    	if(!customer){
    		alert("<fmt:message key='alert_cust_null'/>");
    		return;
    	}
    	if(!cost_center){
    		alert("<fmt:message key='alert_cost_center_null'/>");
    		return;
    	}
    	if(!bill_year){
    		alert("<fmt:message key='alert_bill_year_null'/>");
    		return;
    	}else{
    	
    	if(bill_year.length != 6){
               alert("<fmt:message key='alert_bill_year_month_length'/>");
               return;
           }
           var year = bill_year.substring(0,4);
           var month = bill_year.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_bill_year_month'/>");
               return;
           }
           if (isNaN(bill_year)){
             alert("必须为正确的年月数字！") ;
             return;
           }
    	}
    	var obj = new Array();
    	obj.push(customer);
    	obj.push(cost_center);
    	obj.push(bill_year);
    	showModalCenter("<%=request.getContextPath()%>/FinbillAction.do?cmd=addOneTimeChargeBill&customer="+customer+"&cost_center="+cost_center+"&bill_year="+bill_year,obj,'','700','220',"<fmt:message key='title_add'/>");
    }
</script>
</head>
<body>
<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" id="bill_id" name="bill_id" value=""/>
<input type="hidden" id="bill_others_id" name="bill_others_id" value=""/>
<input type="hidden" id='bill_type_bd' name="bill_type_bd" value =""/>
<div id="right">
	<script language="javascript">
		writeTableTopFesco("<fmt:message key='title_billothers'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
          
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
        <tr>
            <td align="right"><span class="style_required_red">* </span><fmt:message key='customer_name'/></td>
	        <td align="left">
	            <w:lookup readonly="true"
	                id="lk_cust"
	                lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
	                messagekey="choose_cust"  height="450" width="610" style="width:180px" />
	            <input id="cust_id" name="cust_id" type="hidden"/>
	        </td>
	        <td align="right"><span class="style_required_red">* </span><fmt:message key='cost_center'/></td>
	        <td align="left">
	        <r:comboSelect id="cost_center_id" name="cost_center_id"
	            queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
	            textField="cost_center_name"
	            valueField="id"
	            xpath="CostcenterVo"
	            width="190" messagekey="please_select">
	        </r:comboSelect>
	        </td>
            <td width="100" align="right"><span class="style_required_red">* </span><fmt:message key='billyearmonth'/></td>
            <td width="213" align="left">
            <input type="text" class="text_field" id="billyearmonth" name="billyearmonth" inputName="账单年月" maxLength="50" value=""/>
            </td>
        </tr>
        
        <tr>
        	<td colspan='6' align='center'>
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="button_query"/>' onClick="javascript:showListData()">
                	<input name="button_reset2" class="icon_4" type="button" value='<fmt:message key="button_add"/>' onClick="javascript:addOneTimeChargeBill()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="button_reset"/>' onClick="javascript:this.form.reset();resetQuery()">
                  </td>
        </tr>
</table>
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinbillAction.do?cmd=searchOneTimeChargesData"
        width="99%"
        height="204px"
        xpath="FinbillVo"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center" >
       </r:field> 
      <r:field fieldName="cust_code" messagekey="customer_code" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="cust_name" messagekey="customer_name" width="190px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="cost_center_name" messagekey="cost_center" width="205px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="bill_year_month" messagekey="billyearmonth" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="version" messagekey="version" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="bill_amount" messagekey="bill_amount" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="bill_type_bd" messagekey="bill_type_bd" allowModify="false">
       <d:select dictTypeId="BILL_TYPE_BD" />
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date" allowModify="false">
       <w:date format="yyyy-MM-dd" />
      </r:field>
      <r:field fieldName="create_user_name" messagekey="create_user_name" allowModify="false">
        <h:text/>
      </r:field>
    </r:datacell>
</div>
    
<div class="button_right" id="changeButton" style="display:block">
       <!--<ul>
            <li class="c">      <a onClick="javascript:toAdd_onClick();">新增</a></li>
           <li class="d">      <a  onClick="javascript:deleteMulti_onClick();">删除</a> </li>
           <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
       </ul>
       -->
       <input class="c" type="button"   value="<fmt:message key="button_insert"/>"  <au:authorityBtn code="ycxsf_ycxsf" type="1"/>  onClick="toAdd_onClick();">
       <input class="d" type="button"   value="<fmt:message key="button_delete"/>"  <au:authorityBtn code="ycxsf_del" type="1"/>  onClick="deleteMulti_onClick();">
         <input class="bc" type="button"   value="<fmt:message key="button_modify"/>"  <au:authorityBtn code="ycxsf_save" type="1"/>  onClick="to_update();">
 </div>
 <div class="clear"></div>
     
<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell2"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinbillAction.do?cmd=searchOneTimeChargesDataByBillId"
        submitAction="/FAERP/FinbillAction.do?cmd=updateOneTimeChargesDataByBillId"
        width="99%"
        height="204px"
        xpath="BillOthersVo"
        submitXpath="BillOthersVo"
        pageSize="-1">
        <!-- 
       <r:field fieldName="emp" messagekey="operation" width="0px" onRefreshFunc="setCheckbox" align="center" >
       </r:field>  -->  
       <r:field  fieldName="department_name"  messagekey="department_name" width="100px">
       <r:comboSelect id="department"  name ="department" 
                queryAction="/FAERP/FinbillAction.do?cmd=getDeNameFromBaseData"
                textField="description"
                valueField="description"
                property="department_name"
                xpath="BillOthersVo"
                width="190"
                disabled="TRUE" >
            </r:comboSelect>
            </r:field>
      <r:field fieldName="charge_item_bd" messagekey="charge_item_bd" width="150px">
    <r:comboSelect id="charge_item"  name ="charge_item" 
                queryAction="/FAERP/FinbillAction.do?cmd=getChargeItemFromBaseData"
                textField="name"
                valueField="code"
                property="charge_item_bd"
                xpath="BillOthersVo"
                width="190" messagekey="please_select"
                disabled="TRUE" >
            </r:comboSelect>
      </r:field>
      <r:field fieldName="amount" messagekey="amount" width="80px" allowModify="false">
        <h:text validateAttr="minValue=0;totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
      </r:field>
      <r:field fieldName="charge_desc" messagekey="charge_desc" width="150px">
        <h:text/>
      </r:field>
      <r:field fieldName="last_update_date" messagekey="last_update_date" allowModify="false" width="150px">
       <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="add_vat_rate" messagekey="additional_tax_rate" width="100px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="add_vat_amount" messagekey="additional_tax_amount" width="100px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="vat_rate" messagekey="value_added_tax_rate" width="100px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="vat_amount" messagekey="value_added_tax_amount" width="100px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="total_amount" messagekey="total_amount" width="100px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="service_type" messagekey="create_user_name" width="0px" allowModify="false">
      </r:field>
    </r:datacell>
</div>  
     
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script>
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

_$(document).ready(function() {
    $id("datacell1").isQueryFirst = false;
        
        //修改cell值以后操作
    $id("datacell2").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        var oldValue=activeEntity.getProperty("charge_desc");
        if(activeFieldName == "charge_desc"){
            var charge_item_bd = activeEntity.getProperty("charge_item_bd");
	        //var charge_desc = activeEntity.getProperty("charge_desc");
	        if(newValue!="" && newValue != null && newValue != "null"){
	            if(charge_item_bd == "31" || charge_item_bd == "32"){
			        var newValueIndex = newValue.indexOf("20");
			        if(newValueIndex < 0){
			            alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
			            return false;
			        }else{
			            var newValueYear = newValue.substring(newValue.indexOf("20"),newValue.indexOf("20")+4);
			            var newValueYearCheck = newValue.substring(newValue.indexOf("20"),newValue.indexOf("20")+5);
			            var lengthVal=newValue.length-newValue.indexOf("20");
			            if(lengthVal > 4){
			               if(!isNaN(newValueYearCheck)){
			                    alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                                return false;
			                }
			            }else if(lengthVal == 4){
			               if(isNaN(newValueYear)){
			                    alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                                return false;
			                }
			            }else if(lengthVal < 4){
			               alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                           return false;
			            }
			        }
			    }
	        }else{
	           alert("备注中不能没有应付年份，例如：2014,在年分前后不可以出现任何数字");
               return false;
	        }
        }
    }
});
</script>
