<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<fmt:bundle basename="rayoo.finance.bill.billsalaryrel.billsalaryrel_resource" prefix="rayoo.finance.bill.billsalaryrel.">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />

<style type="text/css">
tr.odd {
    background: #fff;
}

tr.even {
    background: #f9fcfd;
}

.box tr:hover,tr.hover {
    background: #c4e7f8;
}

.box tr:selected,tr.selected {
    background-color: #eef8ff;
    border-bottom-color: #daf1ff;
    border-right-color: #daf1ff;
}

.fex_row {
    LEFT: expression(document .   getElementById('values_div') .  
        scrollLeft );
    POSITION: relative;
}
</style>
<script language="javascript">
    jQuery.noConflict();
    /*
    function querySalaryDetail(){
        form.action="<%=request.getContextPath()%>/BillSalaryRelAction.do?";
        form.cmd.value = "queryForList";
       //   $id("cost_center_name").value=$id("cost_center_id").text.value;
        form.submit();
    }
    */

    function rtnFuncCustomer(arg){
        
        var lookup = $id("customer_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        $id("customer_name").value=arg[2];
        //var costCenter = $id("cost_center_id");
        
        $id("cost_center_id").addParam("cust_id", arg[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
      
        //alert(costCenter);
        return false;
    }

    function simpleQuery_onClick(){  
            var pay_year_month = $id("pay_year_month").value;
            var cost_center_id = $id("cost_center_id").getValue();
            var customer_id=$id("customer_id").value;
            if(customer_id==null || customer_id==""){
                alert("<fmt:message key='alert_select_customer'/>");
                return;
            }
            
            if(cost_center_id==""){
                alert("<fmt:message key='alert_cost_center'/>");
                return;
            }
            if(pay_year_month==""){
                alert("<fmt:message key='alert_pay_year_month'/>");
                return;
            }

            
        $id("celllist1").addParam("customer_id",$id("customer_id").value);
        $id("celllist1").addParam("pay_year_month",$id("pay_year_month").value);
        $id("bill_year_month").value=$id("pay_year_month").value;
        //$id("datacell1").addParam("customer_id",$id("customer_id").value);
        //$id("datacell1").addParam("cost_center_id",$id("cost_center_id").value);
        //$id("datacell1").addParam("pay_year_month",$id("pay_year_month").value);
        
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        $id("datacell1").loadData();
        $id("datacell1").refresh();

        $id("datacell2").addParam("t_id","");
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
      //datacell1 checkbox begin
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck3(" + rowNo + ",this);'  name='checkbox1' id='checkboxId' value='"+ entity.getProperty("id") + "'>";
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
    
    function changeCheck(rowNo,box){
        
    }
    
    // end
    //datacell3 checkbox begin
    function checkAllList3(all){
        if(all.checked){
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox3") {
                    element[i].checked= true;
                }
            } 
        }else{
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox3") {
                    element[i].checked= false;
                }
            } 
        }
        
    }
       
   
    function setCheckboxForCellList3(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck(" + rowNo + ",this);'  name='checkbox3' id='checkboxId3' value=" + entity.getProperty("id") + ">";
       return returnStr;
    }
    
     function changeCheck3(rowNo,box){
        
    }
    //end
    //删除工资查看明细
     function setRadiochecked(value,entity,rowNo,cellNo ){
          var returnStr = "";
       returnStr =  "<input type='radio' onclick='radiochange(" + rowNo + ",this);'  name='radioId' id='radioId' value=" + entity.getProperty("id") + ">";
       return returnStr;
     }
     
     //点击radio回调
     function radiochange(rowNo,rdo){
        //alert( rdo.value);
        $id("bill_id").value = rdo.value;
        $id("celllist3").addParam("bill_id",rdo.value);
        $id("celllist3").loadData();
        $id("celllist3").refresh();
     }
     //end
     function deleteRel(){
        var ids = findSelections("checkbox3","id");
        //alert("ids ===============" + ids);
        //return;
        if(ids=="" || ids==null){
            alert("<fmt:message key='alert_is_del'/>");
            return;
        }
        var bill_id = $id("bill_id").value;
        if(ids=="" || ids==null){
            alert("<fmt:message key='alert_bill_id_null'/>");
            return;
        }
       if(confirm("<fmt:message key='alert_is_clean'/>")){
            jQuery.getJSON("<venus:base/>/BillSalaryRelAction.do?cmd=deleteToRel&ids=" + ids + "&date=" + new Date(),{"bill_id":bill_id},function(json){
                alert(json.returnString);
                $id("celllist3").addParam("bill_id",$id("bill_id").value);
                $id("celllist3").loadData();
                $id("celllist3").refresh();
            });
       }
     }
     
     function saveRel(){
     
     
     
         var frm = $id("datacell_formid");
		      //表单验证
		      if( !checkForm(frm) ) {
		          
		          return;
		      }   
      
            var pay_year_month = $id("pay_year_month").value;
            var bill_year_month = $id("bill_year_month").value;
            var cost_center_id = $id("cost_center_id").getValue();
            var ids = findSelections("checkbox1","id");
            
            
            if(bill_year_month==""){
                alert("<fmt:message key='alert_bill_year_month_null'/>");
                return;
            }
            if(cost_center_id==""){
                alert("<fmt:message key='alert_cost_center'/>");
                return;
            }
            if(ids==null || ids== 'null'){
                alert("<fmt:message key='alert_select_record'/>");
                return;
            }
            
            
            var dataset1 = $id("celllist1").dataset;
	        var len1 = dataset1.getLength();
	        for(var i =0 ; i < len1 ; i++){
	            var v_bill_year_month = dataset1.get(i).getProperty("bill_year_month");
	            if(pay_year_month!=v_bill_year_month){
	                   alert("<fmt:message key='alert_v_bill_year_month'/>"+v_bill_year_month);
	                   return;
	            }
	        }
            
            $id("button_hb").disabled ="disabled" ;
            jQuery.getJSON("<venus:base/>/BillSalaryRelAction.do?cmd=saveToRelMerge&bill_year_month=" + bill_year_month + "&ids=" + ids + "&date=" + new Date(),{"customer_id": $id("customer_id").value ,"cost_center_id":cost_center_id},function(json){
                if(json.returnString.substring(0,1) == 5){
                    //未红冲 邮件通知AR
                   if(confirm("账单数据财务已入账，是否邮件通知财务AR组取消入账！")){
                           jQuery.ajax({
                                type : "post",
                                url :"<venus:base/>/FinbillAction.do?cmd=sendEmailToARTeam&bill_id=" + json.returnString.substring(2),
                                dataType : "html",
                                success : function(data) {
                                                       alert(data);
                                                 }
                        });
                     }
                }else{
                     alert(json.returnString);
                }
                $id("button_hb").disabled ="" ;
                
                $id("celllist1").addParam("customer_id",$id("customer_id").value);
                $id("celllist1").addParam("pay_year_month",$id("pay_year_month").value);
                $id("celllist1").loadData();
                $id("celllist1").refresh();
                json = null;
            });
            $id("datacell1").loadData();
            $id("datacell1").refresh();
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
    
</script>
</head>
<body>
<form action="/FAERP/BillSalaryRelAction.do?" name="form" id="datacell_formid" method="post"><input type="hidden" name="cmd" id="cmd" />
<input id="t_id" name="t_id" type="hidden"  value="" />
<div id="right">
<div class="right_title_bg">
<div class=" right_title"><fmt:message key='title_billsalaryrel'/></div>
</div>
<div class="ringht_s">
<div class="tab">
<div class="box_tab">

<table width="98%" border="0" cellspacing="1" cellpadding="0"
    bgcolor="#c5dbe2">
    <tr>
        <td class="td_1"><span class="style_required_red">* </span><fmt:message key='select_customer'/></td>
        <td class="td_2">
        <div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="false"
            id="customer_id" name="customer_id" property="customer_id"
            displayProperty="customer_name"  lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
            messagekey="select_customer" height="440" width="600" style="width:170px" /><input
            type="hidden" name="customer_name" id="customer_name"></div>
        </td>
        <td class="td_1"><span class="style_required_red">* </span><fmt:message key='cost_center'/></td>
        <td class="td_2"><r:comboSelect id="cost_center_id"
            name="cost_center_id"
            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
            property="cost_center_id" width="180" messagekey="please_select">
        </r:comboSelect><input type="hidden" name="cost_center_name" id="cost_center_name"></td>
    </tr>
    <tr>
        <td class="td_1"><span class="style_required_red">* </span><fmt:message key='pay_year_month'/></td>
        <td class="td_2"><input type="text" value="" class="sText"
            id="pay_year_month" name="pay_year_month" /></td>
        <td class="td_2">&nbsp;</td>
        <td class="td_2">&nbsp;</td>
    </tr>
</table>
        <div class="mx_button" style="text-align: center;margin-top: 10px;">
        <input type="button" class="icon_2" value="<fmt:message key='button_query'/>" onClick="javascript:simpleQuery_onClick();" />
        </div>  
</div>
<div id="bg" class="xixi1">
<div id="font1" class="tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'"><fmt:message key='title_xixi1'/></div>
<div id="font2" class="tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'"><fmt:message key='title_xixi2'/></div>
</div>
<div id="TabCon1"><!--表格1-->
<div class="xz_title" style="margin-top: 10px;"><fmt:message key='alert_select'/></div>
 <div id="values_div3" style="width:100%;height:200px; margin-top:5px;">
<r:datacell id="celllist1"
    queryAction="/FAERP/BillSalaryRelAction.do?cmd=queryForSalaryList"
    paramFormId="datacell_formid" width="100%" height="250px"
    xpath="SalaryBatchDetail" readonly="true">
     <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <r:field allowModify="false" fieldName="id" sortAt="none"
        label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
        width="70px" onRefreshFunc="setCheckboxStatus">
    </r:field>
    <r:field fieldName="pay_name" messagekey="pay_name" width="230px">
        <h:text />
    </r:field>
    <r:field fieldName="pay_year_month" messagekey="pay_year_month_" width="235px">
        <h:text />
    </r:field>
    <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="235px">
        <h:text />
    </r:field>
    <r:field fieldName="tax_month" messagekey="tax_month" width="235px">
        <h:text />
    </r:field>
    <!--<r:field fieldName="cost_center_name" label="成本中心" width="235px">
    </r:field>
--></r:datacell>
</div>
<div style="text-align: center; height: 2px; margin-top: 10px; width: 100%;">
<input type="hidden" class="sText" id="bill_year_month" name="bill_year_month" />
<!-- 
请输入合并的账单年月 
<h:text id="bill_year_month" name="bill_year_month"  style="width=180px" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/> (格式YYYYMM)<span  style="color:red;font-size:1.1em">
 -->
<input type="button" id="button_hb"  class="icon_2" value="<fmt:message key='button_hb'/>" <au:authorityBtn code="gzhbzd_hb" type="1"/> onclick="saveRel()"/><br />
</div>
<div style="margin: 10px 0px 0px 10px;"><span  style="color:red;font-size:1.1em"><fmt:message key='long_tip'/></span></div>
<!--表格 end--></div>
<!--表格1 end--></div>

<div id="TabCon2"><!--表格2-->
<div><!--按钮- <div class="xz_title" style="margin-top: 10px;">生成日志</div>-->
<div id="ccParent1" class="button"> 
 <div class="button_right" style="padding-right:0px;">
                <!--<ul>
                    <li class="xz">      <a  onClick="javascript:toMerge_onClick();">拆分</a> </li>
                </ul>
         -->
         <input type="button" id="button_cf"  class="xz" value="<fmt:message key='button_cf'/>" <au:authorityBtn code="gzhbzd_cf" type="1"/> onclick="toMerge_onClick();"/>
         </div>
           <div class="clear"></div>            
</div>
<table cellpadding="0" style="padding: 3 0 0 8;" border="0">
    <tr>
        <td valign="top" width="40%">
                <r:datacell 
                        id="datacell1"
                        isCount="false"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/BillSalaryRelAction.do?cmd=queryForBillMergeList"
                        width="99%" height="270px"
                        xpath="FinbillVo">
                      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                      <r:field fieldName="emp" messagekey="operation" width="50px" onRefreshFunc="setCheckboxMergeList" align="center">
                      </r:field>    
                      <r:field fieldName="cust_name" messagekey="customer_name" width="170px">
                      </r:field>
                      <r:field fieldName="cost_center_name" messagekey="cost_center" width="170px">
                      </r:field>
                      <r:field fieldName="bill_year_month" messagekey="pay_year_month" width="80px">
                      </r:field>
                      <r:field fieldName="bill_amount" messagekey="bill_amount" width="80px">
                      </r:field>
                    </r:datacell>
        </td>
        <td valign="top" width="35%">
                    <r:datacell 
                        id="datacell2"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/BillSalaryRelAction.do?cmd=queryForBillMergeItemList"
                        width="99%" height="270px"
                        xpath="SalaryBatchDetail">
                
                      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                      <r:field fieldName="pay_name" messagekey="pay_name" width="150px">
                      </r:field>
                      <r:field fieldName="pay_year_month" messagekey="pay_year_month_" width="100px">
                      </r:field>
                      <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="100px">
                      </r:field>
                      <r:field fieldName="tax_month" messagekey="tax_month" width="100px">
                      </r:field>
                    </r:datacell>
        </td>
     </tr>
   </table>
</div>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">

    jQuery(function(){
         $id("celllist1").isQueryFirst = false;
         $id("datacell1").isQueryFirst = false;
         $id("datacell2").isQueryFirst = false;
    });
    

    
    
    //tab切换
    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="";
            //document.getElementById("tab1inner").style.display="";
            document.getElementById("TabCon2").style.display="none";
            //document.getElementById("tab2inner").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            //document.getElementById("tab1inner").style.display="none";
            document.getElementById("TabCon2").style.display="";
            //document.getElementById("tab2inner").style.display="";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }
    
    jQuery(document).ready(function() {
    var isFirstLoad = true;
    $id("datacell2").afterRefresh = function(){
        if (isFirstLoad) {
            setTab03Syn(1);
            isFirstLoad = false;
        }       
    }
        
});
    
    
        function setCheckboxMergeList(value,entity,rowNo,cellNo){
            return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";//city_idList
        }
        
        function ClickRow(value){
            ///alert(value);
            $id("t_id").value = value;
            $id("datacell2").addParam("t_id",value);
            $id("datacell2").loadData();
            $id("datacell2").refresh();
        }
        
        function toMerge_onClick(){
            var billid=$id("t_id").value;
            if(billid==""){
                alert("<fmt:message key='alert_select_one'/>");
                return;
            }
            //设置button无效
            $id("button_cf").disabled ="disabled" ;
                jQuery.ajax({
                type : "post",
                url :  "<%=request.getContextPath()%>/BillSalaryRelAction.do?cmd=execProcedureSplitBill&billid=" + billid,
                dataType : "html",
                success : function(data) {
                     if(data!="") {
	                        if(data.substring(0,1) == 5){
			                    //未红冲 邮件通知AR
			                   if(confirm("账单数据财务已入账，是否邮件通知财务AR组取消入账！")){
			                           jQuery.ajax({
			                                type : "post",
			                                url :"<venus:base/>/FinbillAction.do?cmd=sendEmailToARTeam&bill_id=" + data.substring(2),
			                                dataType : "html",
			                                success : function(dt) {
			                                                       alert(dt);
			                                                 }
			                        });
			                     }
			                }else{
			                    alert(data);
			                }
                         //var retsinfo=data.split(",");
                         //alert(retsinfo[1]);
                         $id("datacell1").loadData();
                         $id("datacell1").refresh();
                         $id("datacell2").loadData();
                         $id("datacell2").refresh();
                         $id("t_id").value="";
                     }else{
                            alert("<fmt:message key='alert_fail'/>");
                     }
                      $id("button_cf").disabled ="" ;
                }
            });
        }
        
        
    jQuery(document).ready(function() {
    var isFirstLoad = true;
    $id("datacell2").afterRefresh = function(){
        if (isFirstLoad) {
            setTab03Syn(1);
            isFirstLoad = false;
        }       
    }
        
});
</script>
</fmt:bundle>