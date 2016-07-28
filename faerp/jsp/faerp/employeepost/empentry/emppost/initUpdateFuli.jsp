<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostsendVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%  

String ids = (String)session.getAttribute("ids");
String quotation_id = (String)session.getAttribute("quotation_id");
    
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title>
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
. {LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
tr.hover1 {background:#c4e7f8;}
.fex_row {LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>
<script type="text/javascript">
    var vpath = "<%=request.getContextPath()%>";
    
    //查看个人订单信息 参数为PB_EMP_POST表中的主键id
    function detail_onClick(){
        var datacell = $id("firsttbody");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var post_id = datasettr.getProperty("id");
        if(post_id!=null && post_id!=""){
            //window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrder&id='+ids[0],'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
            
        }
    }
    
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=queryAllpost&backFlag=true";
        form.submit();
    }
    
    function submitAll(){//表单提交
        if(checkOrderAndItem()){
	        if(checkAllCont()){
	            jQuery("input[name='button_reset1']").attr('disabled','disabled');
	            
	            var dc2 = $id("fulitbody");
	            var dc3 = $id("firsttbody");
	            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=updatePostAll";
	            //将两个datacell的xml内容合并
	            var xmlSubmit = dc2.dataset.toString();
	            xmlSubmit +=  dc3.dataset.toString();
	            //alert(xmlSubmit);
	            var myAjax = new Ajax(action);
	            var form = $id("datacell_formid");
	            if (form) {
	                for (var i = 0; i < form.elements.length; i++) {
	                    var elem = form.elements[i];
	                    if (elem.name) {
	                        myAjax.addParam(elem.name, getElementValue(elem));
	                    }
	                }
	            }           
	             myAjax.submitXML(xmlSubmit, 'UTF-8');
	             var returnNode = myAjax.getResponseXMLDom();
	             if( returnNode ) {
	                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
	                      alert("<fmt:message key="reporte_change_success"/>");
	                      window.location.href="<%=request.getContextPath()%>/EmppostAction.do?cmd=queryAllpost&backFlag=true";
	                  }
	                  if( myAjax.getValue("root/data/returnValue") == 2 ) {
	                      alert("<fmt:message key="reselect_prompt3"/>");
	                      jQuery("input[name='button_reset1']").removeAttr("disabled");
	                      return;
	                  }
	                  if( myAjax.getValue("root/data/returnValue") == 3 ) {
	                      alert("<fmt:message key="reselect_prompt2"/>");
	                      jQuery("input[name='button_reset1']").removeAttr("disabled");
	                      return;
	                  }
	                  if( myAjax.getValue("root/data/returnValue") == 0 ) {
	                      alert("<fmt:message key="reporte_change_error"/>"); 
	                      jQuery("input[name='button_reset1']").removeAttr("disabled");
	                      return;
	                  }
	                  
	                  jQuery("input[name='button_reset1']").removeAttr("disabled");
	             }
	            
	        }
        }
    }
    
    //验证是否存在订单的时间与订单明细的时间不一致的记录，并让用户选择是否要继续变更
    function checkOrderAndItem(){
        var returnVal = true;
        var input_date_start = $id("pl_charge_start_date").getValue();
        var input_date_end = $id("pl_charge_end_date").getValue();
        
        //第一个列表更新收费结束日期
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        var ids = new Array();
        
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            ids.push(dataset.get(i).getProperty("id"));
        }
        
        var url = "<%=request.getContextPath()%>/EmppostAction.do?cmd=checkOrderAndItem&postIDs=" + ids+"&start_date="+input_date_start + "&end_date="+input_date_end;
        jQuery.ajax({
            url: url,
            type: 'post',
            dataType: 'html',
            async: false,
            timeout: 80000,
            error: function() {
                alert('Error loading XML document');
                return null;
            },
            success: function(text) {
                if (text != null) {
                    if (text != null && text != "1") {
	                    if(window.confirm(text)){
	                        returnVal = true;
	                    }else{
	                        returnVal = false;
	                    }
	                }else{
	                    returnVal = true;
	                }
                }
            }
        });
        return returnVal;
    }
    
    
     function checkAllCont(){//页面提交验证
        var ali = true;
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
                var datasettr = dataset.get(i);
                var post_id = datasettr.getProperty("id");
                if(datasettr.getProperty("charge_start_date")==null || datasettr.getProperty("charge_start_date")==''){
                    alert("<fmt:message key="emp_fee_begin_date"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("charge_end_date")==null || datasettr.getProperty("charge_end_date")==''){
                    alert("<fmt:message key="emp_fee_end_date"/>");
                    ali = false;
                    return ali;
                }
                var start_date = datasettr.getProperty("charge_start_date");
                var end_date = datasettr.getProperty("charge_end_date");
                if(end_date<start_date){
                    alert("<fmt:message key="emp_fee_b_gt_e"/>");
                    ali = false;
                    return ali;
                }
                
                var fields = datacell.fields;//获得页面所有的列
                //列循环，使用页面field名称设值
                for(var j=0; j<fields.length; j++){
                
                    var field = fields[j];
                    var fieldName = field.fieldName;
                    if(fieldName.indexOf("fl_sf_start_date") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="fl_sf_start_date_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("fl_money") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="fl_money_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("allmoney") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="emp_contract_allmoney_not_null"/>");
                            ali = false;
                            return ali;
                                
                        }
                    }
                }
                
        }
        return ali;
   }
            
           
    
    //判断新输入的时间区间不能同时跨越三个以上（含三个）原订单记录
    //比如：原记录有201201-2012-04,201205-2012-07,201208-201212三条订单记录，新输入了201201-201212，这样是不允许的
    function validateDate(post_id,start_date,end_date){
       var flags='0';
       jQuery.get('<%=request.getContextPath()%>/EmppostAction.do?cmd=checkUpdateDate&post_id='+post_id+'&start_date='+start_date+'&end_date='+end_date+'&date='+new Date()+'',{async:false},function(data){
          flags = data;
          jQuery.data("flags",flags);
          
       });
       return flags;
    }

    
    //全局的收费起始日期变化了，所有人的收费起始日期也要跟着变化(结束日期不变)
    function toAllChargeStartDate(){
        var input_date = $id("pl_charge_start_date").getValue();
        
        var date=input_date.split('-');
        if(date[2]!='01'){
            jQuery("#showal").show();
        }else{
            jQuery("#showal").hide();
        }
        
        //第一个列表更新收费起止日期、福利收费起始日期
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            dataset.get(i).setProperty("charge_start_date",input_date);
            //结束日期自动改为起始日期加两年
            var end_date=addYear(input_date,2);
            //如果加两年后的日期比该入离职订单中已有的某个订单的最大结束日期要小，则取该最大结束日期
            var max_end_date =dataset.get(i).getProperty("max_order_date");
            if(end_date<max_end_date){
                end_date = max_end_date;
            }
            dataset.get(i).setProperty("charge_end_date",end_date);
            
            //更新福利收费起始日期
            var fields = datacell.fields;//获得页面所有的列
            //列循环，使用页面field名称设值
            for(var j=0; j<fields.length; j++){
                var field = fields[j];
                var fieldName = field.fieldName;
                if (fieldName.indexOf("fl_sf_start_date") == 0){
                
                    dataset.get(i).setProperty(fieldName,input_date);
                }
            }
        }
        datacell.refresh();
    }
    
    //全局的收费结束日期变化了，所有人的收费结束日期也要跟着变化(起始日期不变)
    function toAllChargeEndDate(){
        var input_date = $id("pl_charge_end_date").getValue();
        
        //第一个列表更新收费结束日期
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            dataset.get(i).setProperty("charge_end_date",input_date);
        }
        datacell.refresh();
    }
    
    function setEnddate(){
         $id("pl_charge_end_date").setDisabled(false);
    }
    
    //当前日期直接年份加两年
    function addTwoYear(input_date){
        var date=input_date.split('-');
        var sf_end='';
        
        var year=parseInt(date[0])+2;
        //2月29日的情况
        if(date[1]=='02' && date[2]=='29'){
            sf_end=year+'-02-28';
        }else{
            sf_end=year+'-'+date[1]+'-'+date[2];
        }
        
        return sf_end;
    
    }
</script>

</head>
<body>
<form name="form" method="post" id="datacell_formid"> 
<input name="ids" type="hidden" value="<%=ids%>"/>
<input name="quotation_id" type="hidden" value="<%=quotation_id%>"/>
<div id="right">
    <div class="right_title_bg">
        <div class=" right_title"><fmt:message key="reporte_change"/></div>
    </div>

        
<!--表格1-->
  <div class="ringht_s" style=" border:1px solid #bfd8e0;">
    <div class="box_tab_2" style="border:1px solid #ffffff;">
                  
      <div class="box_3">
        <div class="xz_title"><fmt:message key="overall_set"/></div>
        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1" width="15%"><fmt:message key="reporte_start_date"/></td>
            <td class="td_2" width="35%">
                <w:date format="yyyy-MM-dd" id="pl_charge_start_date" name="pl_charge_start_date" width="120" onchange="toAllChargeStartDate();"/>
                &nbsp;<font color="red" id="showal" style="display:none;">*<fmt:message key="start_date_eq_oneday"/></font>
            </td>
         
            <td class="td_1" width="15%"><fmt:message key="reporte_end_date"/></td>
            <td class="td_2" width="35%">
                <w:date format="yyyy-MM-dd" id="pl_charge_end_date" name="pl_charge_end_date" width="120" disabled="true" onchange="toAllChargeEndDate();"/>
                <input type="button" name="setdis" value="<fmt:message key="set_reporte_end_date"/>" onclick="setEnddate();"/>
            </td>
          </tr>
        </table>
    </div>
    
    <div class="button_right">
         <input type="button" class="a_2" value="<fmt:message key="look_person_order"/>" <au:authorityBtn code="view_orderItem4" type="1"/> onClick="detail_onClick();" />
         </div>
         
            <!--表格 -->
            <div id="values_div">
                    <r:datacell 
                         id="firsttbody"
                         queryAction="/FAERP/EmppostAction.do?cmd=initUpdateAll2"
                         submitAction="/FAERP/EmppostAction.do?cmd=updatePostFuli"
                         width="100%"
                         xpath="EmppostVo"
                         submitXpath="EmppostVo"
                         paramFormId="datacell_formid"
                         pageSize="-1" readonly="false"
                         freezeNumber="2"
                         >
                         <r:field fieldName="emp_code" messagekey="emp_code" sortAt="none">
                         </r:field>
                         <r:field fieldName="emp_name" messagekey="emp_name" sortAt="none">
                         </r:field>
                         <r:field fieldName="id_card_type_bd" messagekey="id_card_type" allowModify="false">
                             <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                         </r:field>
                         <r:field fieldName="id_card" messagekey="emp_card_no1">
                         </r:field>
                         <r:field fieldName="internal_code" messagekey="internal_code">
                         </r:field>
                         <r:field fieldName="security_unit_id" messagekey="security_unit_id" allowModify="false">
                            <r:comboSelect id="com2" 
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="please_choose">
                            </r:comboSelect>              
                         </r:field>
                         <r:field fieldName="charge_start_date" messagekey="pay_begin">
                            <w:date format="yyyy-MM-dd" name="charge_start_date"/>
                         </r:field>
                         <r:field fieldName="charge_end_date" messagekey="pay_end">
                            <w:date format="yyyy-MM-dd" name="charge_end_date"/>
                         </r:field>
                         <r:field fieldName="on_post_desc" messagekey="on_post_desc1">
                            <h:text/>
                         </r:field>
                         <r:field width="0" fieldName="allmoney" messagekey="contract_all_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="checkallmoney();"/>
                         </r:field>
                         
                         <script>
                            //alert(array4.length);
                            var array2Index = 0;                            
                            var array2 = [];
                         </script>                         
                         <logic:iterate name="fulibeans"  id="data2" scope="request" indexId="indexid">
                             <bean:define id="product_id" name="data2" property="id" type="java.lang.String"/>
                             <bean:define id="money_dd" name="data2" property="money" type="java.math.BigDecimal"/>
                           
                             <r:field allowModify="false" fieldName="fl_money_${product_id}" messagekey="money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){if(cur.isFirstTimeRefresh==true ){ entity.setProperty('fl_money_${product_id}','${money_dd }');};if(cur.isFirstTimeRefresh ===false){return formatNumber(entity.getProperty('fl_money_${product_id}'),'#,###.##');}else{return formatNumber('${money_dd }','#,###.##');}})">
                                <h:text  onchange="anyFlMoney('${product_id}');"/>
                             </r:field>
                             <bean:define id="product_name2" name="data2" property="product_name" type="java.lang.String"/>
                             <script>array2Index++;array2[array2Index-1]="${product_name2}";</script>
                         </logic:iterate>
                      </r:datacell>
           
                </div>      
                  
                  
                  
                <div style="overflow:hidden;">
                    <div id="values_div3" style="width:98%; float:left;">
                      <r:datacell 
                         id="fulitbody"
                         queryAction="/FAERP/EmppostAction.do?cmd=initInsertOneFuli"
                         width="100%"
                         xpath="ProductVo"
                         submitXpath="ProductVo"
                         paramFormId="datacell_formid"
                         pageSize="-1"
                         >
                        
                         <r:field  fieldName="product_name" messagekey="product">
                         </r:field>
                         <r:field fieldName="is_prepay" label="是否预收<input type='checkbox' name='prepayall1' value='' onclick='prepayAll_onClick1(this);' />" sortAt="none">
                            <h:switchCheckbox id="is_prepay" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field fieldName="charge_frequency_bd" messagekey="pay_frequency" defaultValue="1">
                            <d:select id="dselect2" dictTypeId="FREQUENCY_BD" nullLabel="--请选择--" onchange="javascript:checkprepay1();"/>
                         </r:field>
                         <r:field width="120" fieldName="is_charge_on_security" messagekey="is_charge_on_security" onRefreshFunc="setCheckboxStatus2">
                         </r:field>
                         
                       </r:datacell>
                    </div>
                  </div>
                  <!--表格 end-->
                  <p></p>
                  
                </div>
                <div class="foot_button">
                      <input type="button" class="foot_icon_1" value="<fmt:message key="go_back"/>" onClick="javascript:back_onClick();"/>
                      <input type="button" name="button_reset1" class="foot_icon_1" value="<fmt:message key="application_change"/>" onClick="javascript:submitAll();"/>
                </div>
          </div>
             <!--表格1 end-->
</div>
</form>
</body>
</fmt:bundle>
<script>


    $id("firsttbody").headHeight = 23+23;
    $id("firsttbody").headTextAlign = "center";

</script>

<script language="javascript" src="<venus:base/>/jsp/faerp/employeepost/empentry/emppost/initProductbat.js"></script>
</html>
<script>

//初始化加载时，显示福利产品金额
$id("fulitbody").afterRefresh = function(){
        var allmoney=0;
           
        //获得该福利产品的各项属性
        var datacell1 = $id("fulitbody");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        var svalue = "";
        for(var k=0; k<dataset1.getLength(); k++){
            svalue = dataset1.get(k).getProperty("money");
            if(checkFloat(svalue)){
                allmoney+= getNumber(svalue);
            }
        }
                    
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
             dataset.get(i).setProperty("allmoney",allmoney.toFixed(2));
        }
        datacell.refresh();
        
        
        return true;
}

jQuery(document).ready(function() {
        var Me=$id("firsttbody");
        Me.afterInit = function(){
        
           //福利产品列头的设定
           var getIndex2 = 9;
           //alert(getIndex2);
            for (var i=0; i < array2.length; i++ ) {
               var key_css=""; 

               key_css= ".eos-hd-row td[class='eos-dc-col-firsttbody-" + (getIndex2+i+1) + "']";

               
                var td = jQuery(key_css);
                var a0 = td.clone();
        
                a0.css("height", "23");
        
                td.remove();

                var newTable = jQuery("<td class='eos-dc-col-firsttbody-new-" + (getIndex2+i+1) + "' style='text-align: left; height: 46px;width:100'>" 
                + "<table border='0' cellpadding='0' cellspacing='0' style='border:0px;margin:0px;padding:0px'>"
                + "<tr><td style='text-align:center;height:23px;'>" 
                + " <span>" + array2[i] + "</span></td></tr>"
                + "<tr class='oldHeadTr'></tr></table></td>");
                
                newTable.find(".oldHeadTr").append(a0);
                if(i<=0){
                    jQuery(".eos-hd-row td[class='eos-dc-col-firsttbody-" + (getIndex2+i) + "']").after(newTable);
                }else{
                    jQuery(".eos-hd-row td[class='eos-dc-col-firsttbody-new-" + (getIndex2+i) + "']").after(newTable);
                }

            }               
            
      }
        Me.afterRefresh = function(){
            Me.isFirstTimeRefresh = false;
        }
        Me.beforeRefresh = function(){

            Me.isFirstTimeRefresh = true;
        }      
  
      
});

    //预收勾选，要判断收费频率是否为每月付
    $id("fulitbody").onClickCell = function(targetTD, colIdx, rowIdx, activeEntity, curfield, datacell){
       
        var datacell = $id("fulitbody");
        var activeFieldName = curfield.fieldName;
        if (activeFieldName && activeFieldName != "is_prepay") return true;
        
        if(activeFieldName && activeFieldName == "is_prepay"){
            var prepay = activeEntity.getProperty("is_prepay");
            var frequence = activeEntity.getProperty("charge_frequency_bd");
            if(prepay=='1' && frequence!='1'){
                alert("<fmt:message key="sorry"/>");
                activeEntity.setProperty("is_prepay",'0');
                return false;
            }
        }
        
        datacell.endEdit();
        return true;
    }

</script>


