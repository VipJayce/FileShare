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
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listQuerySocialSecurity_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
	    $id("datacell1").isQueryFirst = false;
	});

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("securityId")+"\");>";
    }
    
    function ClickRow(value,value1){
        $id("postId").value = value;
        $id("securityId").value = value1;
    }
    
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
  	
	function detail_onClick(){  //实现转<fmt:message key='listQuerySocialSecurity0022'/>详细页面
        var postId = document.getElementById("postId").value;
        if(postId == null || postId == ""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+postId,'<fmt:message key='listQuerySocialSecurity0000'/>','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        //window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+postId,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
	}
	
	function detail_Click(){
	   var securityId = document.getElementById("securityId").value;
        if(securityId == null || securityId == ""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.open('<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQuerySocialSecurity&securityId=' + securityId+'&types=social_security','<fmt:message key='listQuerySocialSecurity0001'/>','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        //$id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQuerySocialSecurity&securityId=" + securityId+"&types=social_security";
        //$id("datacell_formid").submit();
	}
	
	//<fmt:message key='listQuerySocialSecurity0032'/>
    function exportToExcel(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportQuerySocialSecurityToExcel&para=social_security";
        $id("datacell_formid").submit();
    }
	
	//<fmt:message key='listQuerySocialSecurity0017'/>
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
<!--        jQuery("#h_customer_name").val(arg[2]);-->
        return false;
    }

</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" name="postId" id="postId" value="">
<input type="hidden" name="securityId" id="securityId" value="">

 
 <div  id="right">

<script language="javascript">
writeTableTopFesco('<fmt:message key='listQuerySocialSecurity0002'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
           <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listQuerySocialSecurity0003'/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listQuerySocialSecurity0004'/></td>
            <td align="left">
                 <select id="security_group_id" name="security_group_id" >
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listQuerySocialSecurity0005'/></option>
                 </select>
            </td>
            <td align="right"><fmt:message key='listQuerySocialSecurity0006'/></td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="<fmt:message key='listQuerySocialSecurity0006'/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key='listQuerySocialSecurity0008'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="<fmt:message key='listQuerySocialSecurity0008'/>" maxLength="10"/>            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listQuerySocialSecurity0010'/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="<fmt:message key='listQuerySocialSecurity0010'/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key='listQuerySocialSecurity0012'/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="<fmt:message key='listQuerySocialSecurity0012'/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key='listQuerySocialSecurity0014'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="<fmt:message key='listQuerySocialSecurity0014'/>" maxLength="64"/>           </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key='listQuerySocialSecurity0016'/></td>
          <td align="left">
                <w:lookup name="cust_name1" onReturnFunc="rtnFuncCustomer" readonly="false" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="listQuerySocialSecurity0017" height="440" width="600"  style="width:195px"/>
           </td>
          <td align="right"><fmt:message key='listQuerySocialSecurity0018'/></td>
          <td align="left">
            <r:comboSelect id="combo_cs" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey='listQuerySocialSecurity0019' />
          </td>
          <td align="right"><fmt:message key='listQuerySocialSecurity0020'/></td>
          <td align="left"><faerp:SoialunitSelectTag  tagname="social_unit_id"  beanname="social_unit_id" style="width:200px"/>  </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key='listQuerySocialSecurity0021'/></td>
          <td align="left">
            <w:date format="yyyy-MM-dd" name="transact_date_from" width="80px"/>&nbsp;<fmt:message key='listQuerySocialSecurity0022'/>&nbsp;<w:date format="yyyy-MM-dd" name="transact_date_to" width="80px"/>
          </td>
          <td align="right"><fmt:message key='listQuerySocialSecurity0023'/></td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("security_status_bd1", -1,"SECURITY_STATUS_BD", "","", false)%></td>
            <td align="right"><fmt:message key='listQuerySocialSecurity0024'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="stop_date_from" width="80px"/>&nbsp;<fmt:message key='listQuerySocialSecurity0022'/>&nbsp;<w:date format="yyyy-MM-dd" name="stop_date_to" width="80px"/>
            </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key='listQuerySocialSecurity0026'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_date_from" width="80px"/>&nbsp;<fmt:message key='listQuerySocialSecurity0022'/>&nbsp;<w:date format="yyyy-MM-dd" name="apply_date_to" width="80px"/>
            </td>
          <td align="right"><fmt:message key='listQuerySocialSecurity0028'/></td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_by1", -1,"SORT_BY1", "","", false)%></td>
            <td align="right"><fmt:message key='listQuerySocialSecurity0029'/></td>
            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_order", -1,"SORT_ORDER", "","", false)%></td>
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
					<li class="a_2">      <a  onClick="javascript:detail_onClick();"><fmt:message key='listQuerySocialSecurity0031'/>个人订单</a> </li>
					<li class="a">      <a onClick="javascript:detail_Click();"><fmt:message key='listQuerySocialSecurity0031'/></a></li>
                    <li class="e">      <a onclick="javascript:exportToExcel();"><fmt:message key='listQuerySocialSecurity0032'/></a></li>
				</ul>
		 -->
		 <input class="a_2" type="button"   value="<fmt:message key='listQuerySocialSecurity0030'/>"  <au:authorityBtn code="view_orderItem13" type="1"/>  onClick="detail_onClick();">  
         <input class="a" type="button"   value="<fmt:message key='listQuerySocialSecurity0031'/>"  <au:authorityBtn code="sbcx_view" type="1"/>  onClick="detail_Click();">  
         <input class="e" type="button"   value="<fmt:message key='listQuerySocialSecurity0032'/>"  <au:authorityBtn code="sbcx_exp" type="1"/>  onClick="exportToExcel();">  
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=listQuerySocialSecurity"
        width="98%"
        height="320px"
        xpath="QuerySocialSecurityVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" messagekey='listQuerySocialSecurity0036' width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="emp_code" messagekey='listQuerySocialSecurity0006'>
               <h:text/>   
           </r:field>    
          <r:field fieldName="emp_name" messagekey='listQuerySocialSecurity0038'>
               <h:text/>   
           </r:field>
           <r:field fieldName="group_name" messagekey='listQuerySocialSecurity0004' allowModify="false">
                <h:text/>      
          </r:field>
          <r:field fieldName="id_card_type_bd" messagekey='listQuerySocialSecurity0040'>
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="id_card" messagekey="listQuerySocialSecurity0049">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" messagekey='listQuerySocialSecurity0014'>
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey='listQuerySocialSecurity0016'>
            <h:text/>
          </r:field>
          <r:field fieldName="user_name" messagekey='listQuerySocialSecurity0018'>
            <h:text/>
          </r:field>
          <r:field fieldName="big_name" messagekey='listQuerySocialSecurity0045'>
            <h:text/>
          </r:field>
          <r:field fieldName="small_name" messagekey='listQuerySocialSecurity0046'>
            <h:text/>
          </r:field>
          <r:field fieldName="hire_unit_short_name" messagekey='listQuerySocialSecurity0020'>
            <h:text/>
          </r:field>
          <r:field fieldName="transact_man" messagekey='listQuerySocialSecurity0048'>
            <h:text/>
          </r:field>
          <r:field fieldName="transact_date" messagekey='listQuerySocialSecurity0021'>
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="type_name_new" messagekey='listQuerySocialSecurity0050'>
            <h:text/>
          </r:field>
          <r:field fieldName="feedback_info"  label="精灵之手备注" >
            <h:text/>
          </r:field>
          <r:field fieldName="transact_remarks" messagekey='listQuerySocialSecurity0051'>
            <h:text/>
            </r:field>
          <r:field fieldName="start_month" messagekey='listQuerySocialSecurity0052'>
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" messagekey='listQuerySocialSecurity0053'>
            <h:text/>
          </r:field>
          <r:field fieldName="fund_month" messagekey='listQuerySocialSecurity0054'>
            <h:text/>
          </r:field>
          <r:field fieldName="pay_base" messagekey='listQuerySocialSecurity0055'>
            <h:text/>
          </r:field>
          <r:field fieldName="security_status_bd" messagekey='listQuerySocialSecurity0023'>
            <d:select dictTypeId="SECURITY_STATUS_BD" />
          </r:field>
          <r:field fieldName="stop_date" messagekey='listQuerySocialSecurity0024'>
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="stop_man" messagekey='listQuerySocialSecurity0058'>
            <h:text/>
          </r:field>
          <r:field fieldName="type_name_stop" messagekey='listQuerySocialSecurity0059'>
            <h:text/>
          </r:field>
          <r:field fieldName="stop_remarks" messagekey='listQuerySocialSecurity0060'>
            <h:text/>
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
