<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listQueryInBack_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("securityId")+"\",\""+entity.getProperty("supplyId")+"\");>";
    }
    
    function ClickRow(value,value1,value2){
        $id("postId").value = value;
        $id("securityId").value = value1;
        $id("supplyId").value = value2;
    }

	function simpleQuery_onClick(){  //简单的模糊查询
	    var fund_month = document.getElementById("fund_month").value;
	    if(fund_month ==null || fund_month == ""){
	       alert("<fmt:message key='listQueryInBack0000'/>,<fmt:message key='listQueryInBack0001'/><fmt:message key='listQueryInBack0002'/>");
	       return;
	    }else{
	       if(fund_month.length != 6){
	           alert("<fmt:message key='listQueryInBack0003'/>,<fmt:message key='listQueryInBack0001'/><fmt:message key='listQueryInBack0002'/>");
	           return;
	       }
	       var year = fund_month.substring(0,4);
	       var month = fund_month.substring(4,6);
	       if(year<2000 || year>2030 || month<1 || month>12){
	           alert("<fmt:message key='listQueryInBack0007'/><fmt:message key='listQueryInBack0008'/><fmt:message key='listQueryInBack0009'/><fmt:message key='listQueryInBack0002'/>");
	           return;
	       }
	    }
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
  	
	function detail_onClick(){  //实现转<fmt:message key='listQueryInBack0035'/>详细页面
        var postId = document.getElementById("postId").value;
        if(postId == null || postId == ""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+postId,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
	}
	
	function detail_Click(){
	   var supplyId = document.getElementById("supplyId").value;
	   var securityId = document.getElementById("securityId").value;
        if(supplyId == null || supplyId == ""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQueryInBack&supplyId=" + supplyId+"&securityId="+securityId+"&types=social_security_in_back";
         window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listQueryInBack0011'/>');
        //$id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQueryInBack&supplyId=" + supplyId+"&securityId="+securityId+"&types=social_security_in_back";
        //$id("datacell_formid").submit();
	}
	
	//<fmt:message key='listQueryInBack0037'/>
    function exportToExcel(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportQueryInBackToExcel&para=social_security_in_back";
        $id("datacell_formid").submit();
    }
	
	//<fmt:message key='listQueryInBack0030'/>
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#h_customer_name").val(arg[2]);
        return false;
    }

</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" name="postId" id="postId" value="">
<input type="hidden" name="securityId" id="securityId" value="">
<input type="hidden" name="supplyId" id="supplyId" value="">

 
<div id="right">
<script language="javascript">
writeTableTopFesco('<fmt:message key='listQueryInBack0012'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
           <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listQueryInBack0013'/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listQueryInBack0014'/></td>
            <td align="left">
                 <select id="security_group_id" name="security_group_id" >
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listQueryInBack0015'/></option>
                 </select>
            </td>
            <td align="right"><fmt:message key='listQueryInBack0016'/></td>
            <td align="left">
               <input type="text" class="text_field" name="fund_month" id="fund_month" inputName="<fmt:message key='listQueryInBack0016'/>" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td>
            <td align="right"><fmt:message key='listQueryInBack0018'/></td>
            <td align="left"><faerp:SoialunitSelectTag  tagname="social_unit_id"  beanname="social_unit_id" style="width:200px"/>  </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listQueryInBack0019'/></td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="<fmt:message key='listQueryInBack0019'/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key='listQueryInBack0041'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="员工<fmt:message key='listQueryInBack0041'/>" maxLength="10"/>            </td>
            <td align="right"><fmt:message key='listQueryInBack0023'/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="<fmt:message key='listQueryInBack0023'/>" maxLength="64"/>            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listQueryInBack0025'/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="<fmt:message key='listQueryInBack0025'/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key='listQueryInBack0027'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="<fmt:message key='listQueryInBack0027'/>" maxLength="64"/>           </td>
            <td align="right"><fmt:message key='listQueryInBack0029'/></td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="listQueryInBack0030" height="440" width="600"  style="width:195px"/>
                 <input type="hidden" name="cust_name1" id="h_customer_name" value=""/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listQueryInBack0031'/></td>
            <td align="left">
                <r:comboSelect id="combo_cs" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey='listQueryInBack0032' />
           </td>
           <td align="right"><fmt:message key='listQueryInBack0033'/></td>
           <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("security_status_bd1", -1,"SECURITY_STATUS_BD", "","", false)%></td>
            <td align="right"><fmt:message key='listQueryInBack0034'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="create_date_from" width="80px"/>&nbsp;<fmt:message key='listQueryInBack0035'/>&nbsp;<w:date format="yyyy-MM-dd" name="create_date_to" width="80px"/>
            </td>
        </tr>
        <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>
                 <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             </td>
             <td>   
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
        </tr>
</table>
</div>

<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
					<li class="a">      <a onClick="javascript:detail_Click();"><fmt:message key='listQueryInBack0036'/></a></li>
                    <li class="e">      <a onclick="javascript:exportToExcel();"><fmt:message key='listQueryInBack0037'/></a></li>
				</ul>
		 -->
		   <input class="a" type="button"   value="<fmt:message key='listQueryInBack0036'/>"  <au:authorityBtn code="bjcx_view" type="1"/>  onClick="detail_Click();"> 
		   <input class="e" type="button"   value="<fmt:message key='listQueryInBack0037'/>"  <au:authorityBtn code="bjcx_exp" type="1"/>  onClick="exportToExcel();"> 
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=listQueryInBack"
        width="98%"
        height="320px"
        xpath="QuerySocialSecurityVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" messagekey='listQueryInBack0040' width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="emp_name" messagekey='listQueryInBack0041'>
               <h:text/>   
           </r:field>    
          <r:field fieldName="emp_code" messagekey='listQueryInBack0019'>
               <h:text/>   
           </r:field>
           <r:field fieldName="group_name" messagekey='listQueryInBack0014' allowModify="false">
                <h:text/>      
          </r:field>    
          <r:field fieldName="id_card" messagekey="listQueryInBack0044">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" messagekey='listQueryInBack0027'>
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey='listQueryInBack0029'>
            <h:text/>
          </r:field>
          <r:field fieldName="internal_code" messagekey='listQueryInBack0023'>
            <h:text/>
          </r:field>
          <r:field fieldName="user_name" messagekey='listQueryInBack0031'>
            <h:text/>
          </r:field>
          <r:field fieldName="big_name" messagekey='listQueryInBack0049'>
            <h:text/>
          </r:field>
          <r:field fieldName="small_name" messagekey='listQueryInBack0050'>
            <h:text/>
          </r:field>
          <r:field fieldName="hire_unit_short_name" messagekey='listQueryInBack0018'>
            <h:text/>
          </r:field>
          <r:field fieldName="start_month" messagekey='listQueryInBack0052'>
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" messagekey='listQueryInBack0053'>
            <h:text/>
          </r:field>
          <r:field fieldName="month_num" messagekey='listQueryInBack0054'>
            <h:text/>
          </r:field>
          <r:field fieldName="pay_base" messagekey='listQueryInBack0055'>
            <h:text/>
          </r:field>
          <r:field fieldName="money" messagekey='listQueryInBack0056'>
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" messagekey='listQueryInBack0057'>
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" messagekey='listQueryInBack0058'>
            <h:text/>
          </r:field>
          <r:field fieldName="create_date" messagekey='listQueryInBack0034'>
            <w:date format="yyyy-MM-dd"/>
          </r:field>
    </r:datacell>
    </div>
 
</div>
</div>
</form>
</fmt:bundle>
</body>
</fmt:bundle>
</html>
