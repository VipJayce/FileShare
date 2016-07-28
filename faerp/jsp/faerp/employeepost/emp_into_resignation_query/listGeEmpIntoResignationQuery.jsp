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
<fmt:bundle basename="rayoo.employeepost.emp_into_resignation_query.emp_into_resignation_query_resource" prefix="rayoo.employeepost.emp_into_resignation_query.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });
    
    jQuery(document).ready(function() {
     if($id("datacell1")==null)return;
     $id("datacell1").afterRefresh = function(){
        var Me = $id("datacell1");
        var rows = Me.allTR;
        for (var i=0;i<rows.length;i++ ){
          var entity1 = Me.dataset.get(i);
          var post_status_bd = entity1.getProperty("post_status_bd");
          if(post_status_bd!=null && post_status_bd=='3'){
            rows[i].style.backgroundColor = "#cce8cf";
          }
          
        }        
    }
});
    
    function showListData(){
         $id("datacell1").loadData();
         $id("datacell1").refresh();
     }
     
    function exp_onClick(){  //实现转到详细页面
        form.action="<%=request.getContextPath()%>/EmppostAction.do";
        form.cmd.value = "exportGepost";
        form.submit();
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="empIntoResigQuery_formid">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="emp_post_query"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

		<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
		</tr>
		<tr>
		    <td align="right"><fmt:message key="cust_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="64" style="width:215"/>           </td>
			<td align="right"><fmt:message key="cust_name"/></td>
			<td align="left">
			     <w:lookup id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"  name="cust_name1"
		            messagekey="choose_cust" height="500" width="810" style="width:195px"/>
			</td>
			<td align="right"><fmt:message key="ge_status"/></td>
			<td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("ge_status", -1,"GE_EMP_STATUS", "", "style='width:210'", false) %></td>
		</tr>
		<tr>
		    <td align="right"><fmt:message key="ge_off_post_reason"/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("ge_off_post_reason", -1,"GE_OFF_POST_REASON", "", "style='width:210'", false) %>
            </td>
            <td align="right"><fmt:message key="off_post_date"/></td>
            <td align="left"><w:date format="yyyy-MM-dd" name="off_post_date_from" width="80px"/>&nbsp;<fmt:message key="to"/>&nbsp;<w:date format="yyyy-MM-dd" name="off_post_date_to" width="80px"/></td>
            <td align="right"><fmt:message key="business"/></td>
            <td align="left"><input name="business" type="text"></td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="off_post_date1"/></td>
            <td align="left"><w:date format="yyyy-MM-dd" name="apply_off_post_date_from" width="80px"/>&nbsp;<fmt:message key="to"/>&nbsp;<w:date format="yyyy-MM-dd" name="apply_off_post_date_to" width="80px"/></td>
            <td align="right"><fmt:message key="apply_on_post_date"/></td>
            <td align="left"><w:date format="yyyy-MM-dd" name="apply_on_post_date_from" width="80px"/>&nbsp;<fmt:message key="to"/>&nbsp;<w:date format="yyyy-MM-dd" name="apply_on_post_date_to" width="80px"/></td>
			  <td>
			     <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
             </td>
             <td>   
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
		</tr>
</table>
</div>

<input type="hidden" name="postid" id="postid" value="">
<input type="hidden" name="cmd" id="cmd" value="">
<div id="ccParent1" class="button"> 
	 <div class="button_right">
	   <input type="button" class="bl" value='<fmt:message key="leading_out"/>'  onClick="exp_onClick();" />
	</div>
    <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=searchEmpIntoResignationData"
        submitAction="/FAERP/EmppostAction.do?cmd=updateEmpIntoResignationForInternalCode"
        width="98%"
        height="320px"
        xpath="EmppostVo"
        submitXpath="EmppostVo"
        paramFormId="empIntoResigQuery_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="emp_code" messagekey="emp_code">
      </r:field>
      <r:field fieldName="emp_name" messagekey="emp_name">
       </r:field>    
      <r:field fieldName="id_card" messagekey="emp_card_no1">
      </r:field>
      <r:field fieldName="city_name" label="福利城市"></r:field>
      <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date" allowModify="false">
        <w:date format="yyyy-MM-dd" name=""/>
      </r:field>
      <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1" allowModify="false">
        <w:date format="yyyy-MM-dd" name=""/>
      </r:field>
      <r:field fieldName="hro" label="GE HR"></r:field>
      <r:field fieldName="business" label="业务部门"></r:field>
      <r:field fieldName="job_num" label="SSO号"></r:field>
      <r:field fieldName="post_status_bd" messagekey="status_name" allowModify="false">
        <d:select dictTypeId="POST_STATUS_BD"/>
      </r:field>
      <r:field fieldName="ge_off_post_reason" messagekey="ge_off_post_reason" allowModify="false">
        <d:select dictTypeId="GE_OFF_POST_REASON"/>
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
    lookup.value = returnValue[2];
    lookup.displayValue = returnValue[2];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}
</script>
