<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.finance.bill.salarybatch.salarybatch_resource" prefix="rayoo.finance.bill.salarybatch.">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datacell</title>
<%
String cust_id = request.getParameter("cust_id");
System.out.println("cust_id:"+cust_id);
%>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }

   function ClickRow(value){
        $id("precision_id").value = value
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function resetQuery(){
        $id("product_id1").value="";
    }
    
    function toAdd_onClick() {
        $id("datacell2").addRow();
    }
    
     function deleteMulti_onClick(){
        $id("datacell2").deleteRow();
    }
    
    function toSave_onClick() { 
           var info = checkBeforeSubmit();
           if(info.length>1){
                alert(info);
                return;
           }
           
	       $id("datacell1").isModefied = true;
	       if($id("datacell1").submit()){
	           alert("<fmt:message key='alert_success'/>");
	       }
    }
    
    function checkBeforeSubmit(){
            var err = "";
            var dataset =  $id("datacell1").dataset;
            var len = dataset.getLength();
            for(var i = 0;i < len;i ++){
                var e_precision_bd = dataset.get(i).getProperty("e_precision_bd");//企业金额精度
                var e_calculate_type_bd = dataset.get(i).getProperty("e_calculate_type_bd");//企业金额进位
                var p_precision_bd = dataset.get(i).getProperty("p_precision_bd");//个人金额精度
                var p_calculate_type_bd = dataset.get(i).getProperty("p_calculate_type_bd");//个人金额进位
                
                var h = i+1;
                if(e_precision_bd == null || e_precision_bd == "")
                    err += "<fmt:message key='alert_precision_calculate'/>"+ h +"<fmt:message key='alert_precision_null_e'/>\n";
                if(e_calculate_type_bd == null || e_calculate_type_bd == "")
                    err +=  "<fmt:message key='alert_precision_calculate'/>"+ h +"<fmt:message key='alert_calculate_null_e'/>\n";
                if(p_precision_bd == null || p_precision_bd == "")
                    err +=  "<fmt:message key='alert_precision_calculate'/>"+ h +"<fmt:message key='alert_precision_null_p'/>\n";
                 if(p_calculate_type_bd == null || p_calculate_type_bd == "")
                    err +=  "<fmt:message key='alert_precision_calculate'/>"+ h +"<fmt:message key='alert_calculate_null_p'/>\n";
            }
            
            /**
            var role_ids =  _$("#v_product").val();
            var arr = role_ids.split(","); 
            var obj = {};
            for(var i=0;i<arr.length;i++)
            {
                var item = arr[i];
                if(obj[item]==null)obj[item] = 1;
                else obj[item] = obj[item]+1;
            }
           
            for(a in obj)
            {
                var item = obj[a];
                if(item>1){
                        err += "产品"+a+"有重复；";
                 }
            } 
            **/
            
           return err;
    }

    
    function returnFunc(arg){
        var role_ids = "";        
        var entities = $id("datacell1").dataset.getEntities();
        var len1= entities.length;
        for(var i =0 ; i < len1 ; i++){
           role_ids += entities[i].getProperty("product_id")+",";
        }
        _$("#v_product").val(role_ids);
         if(role_ids.search(arg[0]) == -1){
	        var lookup = $id("lookupID1");
	        lookup.value = arg[0];
	        lookup.displayValue = arg[1];
	        
	        var row = $id("datacell1").getActiveRow();
	        var entity = $id("datacell1").getEntity(row);
	        entity.setProperty("product_id",arg[0]);
	        entity.setProperty("product_name",arg[1]);
	        $id("datacell1").refreshRow(row);      
        }
        return false;
    }
    
    
    function toAdd_onClick() {
        $id("datacell1").addRow();
    }
    
    
     function deleteMulti_onClick(){
        if(choose_datacell_row("datacell1")==""){
            return;
        }
       if(!confirm("<fmt:message key='alert_is_delete'/>")) {
                return;
       }
       $id("datacell1").deleteRow();
       if($id("datacell1").submit()){
            //alert("操作成功！");
       }
    }
    

    
</script>
</head>
<body>
<form name="datacell_formid" method="post" id="datacell_formid">
<input id="precision_id" name="precision_id" type="hidden"/>
<input id="v_product" name="v_product" type="hidden"/>
<div id="right">
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="right"><fmt:message key='select_product'/></td>
            <td align="left">
                <w:lookup readonly="true"
                    id="lk_cust"
                    onReturnFunc="rtnFunc"
                    lookupUrl="/FAERP/ProductAction.do?cmd=queryAllProductGetOnlyOne&cust_id=${param.cust_id}"
                    messagekey="choose_product" height="450" width="780" style="width:190px"/>
                    
                <input id="product_id1" name="product_id1" type="hidden"/>
            </td>
            <td align="right"><fmt:message key='e_precision_bd'/></td>
            <td align="left">
	            <d:select  name="e_precision_bd" id="e_precision_bd" dictTypeId="FBP_E_PRECISION_BD" nullLabel="--请选择--" style="width:200px"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='e_calculate_type_bd'/></td>
            <td align="left">
                <d:select  name="e_calculate_type_bd" id="e_calculate_type_bd" dictTypeId="FBP_E_CAL_TYPE_BD" nullLabel="--请选择--" style="width:200px"/>
            </td>
            <td align="right"><fmt:message key='p_precision_bd'/></td>
            <td align="left">
                <d:select  name="p_precision_bd" id="p_precision_bd" dictTypeId="FBP_E_PRECISION_BD" nullLabel="--请选择--" style="width:200px"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='p_calculate_type_bd'/></td>
            <td align="left">
                <d:select  name="p_calculate_type_bd" id="p_calculate_type_bd" dictTypeId="FBP_E_CAL_TYPE_BD" nullLabel="--请选择--" style="width:200px"/>
            </td>
            <td colspan="2">
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();resetQuery()">
            </td>
        </tr>
</table>
</div>

<div class="button_right">
       <ul>
            <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key='button_add'/></a></li>
           <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key='button_del'/></a> </li>
           <li class="bc">      <a  onClick="javascript:toSave_onClick();"><fmt:message key='button_save'/></a> </li>
       </ul>
 </div>
 <div class="clear"></div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/BillPrecisionAction.do?cmd=searchBillPrecisionData&cost_center_id=${requestScope.cost_center_id}"
        submitAction="/FAERP/BillPrecisionAction.do?cmd=updateBillPrecisionData&cost_center_id=${requestScope.cost_center_id}"
        width="98%"
        height="280px"
        xpath="BillPrecisionVo"
        submitXpath="BillPrecisionVo"
        pageSize="-1"
        >

      <r:field fieldName="product_name" messagekey="product_name" width="150px">
        <w:lookup id="lookupID1"  lookupUrl="/ProductAction.do?cmd=queryAllProductGetOnlyOne&cust_id=${param.cust_id}"
            width="780" height="450" top="0"  messagekey="choose_product" readonly="true" onReturnFunc="returnFunc"></w:lookup> 
      </r:field>
      <r:field fieldName="e_precision_bd" messagekey="e_precision_bd">
        <d:select dictTypeId="FBP_E_PRECISION_BD" />
      </r:field>
      <r:field fieldName="e_calculate_type_bd" messagekey="e_calculate_type_bd">
        <d:select dictTypeId="FBP_E_CAL_TYPE_BD" />
      </r:field>
      <r:field fieldName="p_precision_bd" messagekey="p_precision_bd">
        <d:select dictTypeId="FBP_E_PRECISION_BD" />
      </r:field>
      <r:field fieldName="p_calculate_type_bd" messagekey="p_calculate_type_bd">
        <d:select dictTypeId="FBP_E_CAL_TYPE_BD" />
      </r:field>
      <!-- 
      <r:field fieldName="last_update_date" label="变更生效日期">
        <w:date format="yyyy-MM-dd" />
      </r:field>
       -->
    </r:datacell>
</div>
     
</div>
</div>
</form>
</body>
</html>
<script>
    function rtnFunc(arg){
	    var lookup = $id("lk_cust");
	    lookup.value = arg[0];
	    _$("#product_id1").val(arg[0]);
	    lookup.displayValue = arg[1];
        return false;
    }
    
    
    function choose_datacell_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("<fmt:message key='alert_select_one'/>");
           return;
        }
     return obj;
    }
    
    
    $id("datacell1").afterSubmit= function(ajax){
     //alert(ajax.getProperty("returnValue"));
    }
    
</script>
</fmt:bundle>