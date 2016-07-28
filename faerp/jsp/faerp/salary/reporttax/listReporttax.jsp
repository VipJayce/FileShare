<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.salary.reporttax.reporttax_resource" prefix="rayoo.salary.reporttax.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	//tab切换
    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabConInner1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("TabConInner2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("TabConInner2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }


    function submit_onclick(){
    	/*
        var tax_month = $id("tax_month").value ;
        if(tax_month == ''){
         alert("请选择报税所属期") ;
         return false ;
        }
        var tax_flag = $id("tax_flag").value ;
        if(tax_flag == ''){
            alert("请选择报税属性") ;
            return false  ;
        }
        if(tax_flag == '0'){
            alert("报税属性为不要报税，不能下载员工纳税文件") ;
            return false  ;
        }*/
        var entity = $id("dc_emp").getActiveEntity();
        if(entity){
        	$id("taxInfoId").value=entity.getValue("id");
        }else{
        	alert("<fmt:message key='alert_select_one'/>");
        	return false;
        }
	    var taxform  = $id("taxformid") ;
	    taxform.submit() ;
	    return true ;
    }
    
    //弹出导出层
    function reporttax_pop(){
        var tax_month = $id("tax_month").value ;
        if(tax_month == ''){
            alert("<fmt:message key='alert_select_tax_month'/>") ;
            return false ;
        }
        var tax_flag = $id("tax_flag").value ;
        if(tax_flag == ''){
            alert("<fmt:message key='alert_select_tax_flag'/>") ;
            return false  ;
        }
        if(tax_flag == '3'){
            alert("<fmt:message key='alert_select_tax_flag_3'/>") ;
            return false  ;
        }
        url="<%=request.getContextPath()%>/ReporttaxAction.do?cmd=initFinPayment&tax_month="+tax_month+"&tax_flag="+tax_flag;
        showModalCenter(url, "", "freshTaxInfo", 730, 480, "<fmt:message key='button_freshTaxInfo'/>");  
    }
    /**
    * 报税申请完刷新列表
    */
    function freshTaxInfo(){
    	$id("dc_emp").reload();
    }
    /**
    * 触发查询
    */
    function doQryTaxInfo(){
    	if(check_pay_ym($id("tax_month").value)){
    		$id("dc_emp").reload();
    	}else{
    		alert("<fmt:message key='alert_tax_month_err'/>");
    		$id("tax_month").value="";
    	}
    	
    }
   //验证所属期
   function check_pay_ym(str){
   	var p = /^[12]\d{3}(0\d|1[0-2])$/;
   	if(!p.test(str)){
   		return false;
   	}
   	return true;
   }
</script>
</head>
<body>
 		<div id="bg" class="xixi1" >
            <div id="font1" class="tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'"><fmt:message key='title_xixi1'/></div>
            <div id="font2" class="tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'"><fmt:message key='title_xixi2'/></div>
        </div>
        <div id="TabCon1">
        <div id="right" class="search" >
        <form method="post" action="<%=request.getContextPath()%>/ReporttaxAction.do?cmd=exportEmpTaxData" name="taxformid" id="taxformid">
            <input type="hidden" name="taxInfoId" id="taxInfoId"/>
	        <div id="right">
	            <div class="ringht_s">
	                <div id="ccChild0" class="search">
	                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                        <tr>
	                            <td width="174" rowspan="10" style="padding-top: 0;">
	                                <div class="search_title"><fmt:message key='searchTitle'/></div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="td_1"><fmt:message key='tax_month'/></td>
	                            <td class="td_2">
	                                <input type="text" class="text_field" name="tax_month" id="tax_month" onchange="doQryTaxInfo()" maxLength="6" style="width:200px" />(201201)
	                            <td class="td_1"><fmt:message key='tax_flag'/></td>
	                            <td class="td_2">
	                                <d:select value="1" dictTypeId="TAX_FLAG" name="tax_flag" property="tax_flag" id="tax_flag" style="width:190px" onchange="doQryTaxInfo()"/>
	                            </td>
	                            <td class="td_1"></td>
	                            <td class="td_2">
	                                <input name="submit2" type="button" class="icon_3" value="<fmt:message key='button_freshTaxInfo'/>" 
	                                    <au:authorityBtn code="bssb_bszfsh" type="1"/> onClick="reporttax_pop()"/>
	                            </td>
	                        </tr>
	                    </table>
	                </div>
	            </div>
	        </div>
            <div id="ccParent1" class="button">
		        <div class="button_right">
		            <input type="button" class="p_1" onclick="return submit_onclick();" 
                     <au:authorityBtn code="bssb_xzygnswj" type="1"/> value="<fmt:message key='button_xzygnswj'/>"/>
                     <input type="button" class="R" onclick="taxSubmit();" 
                     <au:authorityBtn code="bswc" type="1"/> value="<fmt:message key='finishTax'/>"/>
		        </div>
		        <div class="clear"></div>
		    </div>
       </form>
	</div>
	</div>
	<div id="TabConInner1">
	        <r:datacell id="dc_emp"
	            queryAction="/FAERP/ReporttaxAction.do?cmd=qryTaxRptInfo"
	            submitAction="/FAERP/ReporttaxAction.do?cmd=update"
	            width="99%" xpath="TaxRptInfoVo" submitXpath="TaxRptInfoVo"
	            pageSize="100"
	            paramFormId="taxformid" height="340px">
	            <r:toolbar location="bottom" tools="nav,pagesize,info" />
	            <r:field fieldName="rpt_month" messagekey="tax_month" width="150px">
	            </r:field>
	            <r:field fieldName="tax_flag" messagekey="tax_flag" width="150px" allowModify="false">
	            	<d:select dictTypeId="TAX_FLAG"/>
	            </r:field>
	            <r:field fieldName="input_date" messagekey="input_date" width="150px">
	            </r:field>
	            <r:field fieldName="total_tax" messagekey="total_tax" width="150px">
	            </r:field>
	            <r:field fieldName="tax_status_bd" messagekey="tax_status" width="150px">
	               <d:select dictTypeId="tax_status_bd"/>
                </r:field>
                <r:field fieldName="last_modify_user_name" messagekey="last_modify_user_name" width="150px">
                </r:field>
                <r:field fieldName="last_modify_date" messagekey="last_modify_date" width="150px" allowModify="false">
                    <w:date format="yyyy-MM-dd"/>
                </r:field>
	        </r:datacell>
	        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
		       <tr>
		         <td colspan="2" align="left">
		             <div style="margin-left: 200px;margin-top: 10px;">
		              <fmt:message key='text_1'/><br>
		              <fmt:message key='text_3'/><br>
		              <fmt:message key='text_5'/><br><br>
		              
		             </div>
		         </td>
		         <td colspan="2" align="left">
		              <div style="margin-left: 10px;margin-top: 10px;">
		                  <fmt:message key='text_2'/><br>
		                  <fmt:message key='text_4'/><br>
		                  <fmt:message key='text_6'/><br><br>
		             </div>
		         </td>
		       </tr>
		   </table>
	</div>
   <div id="TabCon2" style="display:none;">
   <div id="right" class="search"> 
   <form name="datacell_formid" id="datacell_formid" method="post" action="<%=request.getContextPath()%>/ReporttaxAction.do">
 <div id="right">
            <div class="ringht_s">
                <div id="ccChild0" class="search">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="174" rowspan="10" style="padding-top: 0;">
                                <div class="search_title"><fmt:message key='searchTitle'/></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_1"><fmt:message key='customer_name'/></td>
                            <td class="td_2">
                                <w:lookup
                                onReturnFunc="rtnFuncCustomer" readonly="false" id="lk_cust"
                                name="customer_name"
                                lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                messagekey="select_cust" height="440" width="600" style="width:170px" />
                            <td class="td_1"><fmt:message key='submit_user'/></td>
                            <td class="td_2">
                                <r:comboSelect id="combo_cs" name="cs_name"
                                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                                       textField="name"
                                       valueField="name"
                                       xpath="CustServiceVo"
                                       width="200px"
                                       nullText="" />
                            </td>
                            <td class="td_1"><fmt:message key='tax_name'/></td>
                            <td class="td_2">
                                <r:comboSelect id="combo_tax" name="tax_name"
                                       queryAction="/FAERP/ReporttaxAction.do?cmd=qryTaxTeam"
                                       textField="user_name"
                                       valueField="user_name"
                                       xpath="CustTaxVo"
                                       width="200px"
                                       nullText="" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td_1"></td>
                            <td class="td_2"></td>
                            <td align="right"></td>
                            <td align="left"></td>
                            <td>
                                <input type="button" onclick="toselect_onclick()" class="icon_1" value="<fmt:message key='button_search'/>" />
                            </td>
                            <td>
                                <input name="button_reset2" class="icon_1" type="button" value="重置" onClick="javascript:this.form.reset()">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
	</form>
	</div>
	</div>

	<div id="TabConInner2" style="display:none">
	        <r:datacell id="dc_reporttaxid"
	            queryAction="/FAERP/ReporttaxAction.do?cmd=qryAssignTax"
	            submitAction="/FAERP/ReporttaxAction.do?cmd=update"
	            width="99%" xpath="CustTaxVo" submitXpath="CustTaxVo"
	            paramFormId="datacell_formid" height="340px">
	            <r:toolbar location="bottom" tools="nav,pagesize,info" />
	            <r:field fieldName="id" messagekey="customer_code" width="0px"></r:field>
	            <r:field fieldName="customer_code" messagekey="customer_code" width="150px">
	            </r:field>
	            <r:field fieldName="customer_name" messagekey="customer_name" width="250px">
	            </r:field>
	            <r:field fieldName="cs_name" messagekey="submit_user" width="150px">
	            </r:field>
	            <r:field fieldName="dept_name" messagekey="dept_name" width="150px">
	            </r:field>
	            <r:field fieldName="tax_name" messagekey="tax_name" width="150px">
	            </r:field>
	        </r:datacell>
	</div>
</body>
<script type="text/javascript">
function toselect_onclick() { 
        $id("dc_reporttaxid").reload() ;
}

 function rtnFuncCustomer(arg){
    var lookup = $id("lk_cust");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
 }
 
 function init(){
        var day = new Date(); 
        var year=day.getFullYear();
        var month=day.getMonth()+1; 
        if(month<=9){
            month="0"+month;
        }
        var yearmonth=year+""+month;
        $id("tax_month").value=yearmonth ;
        
 }
 
 function taxSubmit(){
        var dc = $id("dc_emp");
        var entity =dc.getActiveEntity();
        if(entity==null || entity==''){
            alert("<fmt:message key='nodata'/>");
            return ;
        }
        var id = entity.getProperty("id");
        if(id==null || id==''){
            alert("<fmt:message key='chooseOneData'/>");
            return ;
        }
        
        if(window.confirm("<fmt:message key='sureFinishTax'/>")){
            jQuery.ajax({
	          url: "<%=request.getContextPath()%>/ReporttaxAction.do?cmd=taxSubmit&id="+id,
	          type: 'GET',
	          dataType: 'html',
	          timeout: 9999999,
	          error: function(){
	              alert('Error loading XML document');
	              return  null;
	          },
	          success: function(text){ 
	              if(text=="1"){
	                 alert("报税成功！");
	                 $id("dc_emp").loadData();
	                 $id("dc_emp").refresh();                  
	              }else{
	                 alert("报税失败！");
	              }
	          }
	       });
		}else{
			return;
		}
    }
</script>
</fmt:bundle>
</html>
