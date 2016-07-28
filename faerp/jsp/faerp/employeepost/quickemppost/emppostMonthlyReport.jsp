<%@ page contentType="text/html; charset=UTF-8"  %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
 <%
           String companyId=rayoo.common.pub.PubHelper.getCompanyID(request);
    %>
	
	<script language="javascript">
		function applyreport_submit(){
		  if(confirm('确定生成报表')) {
			  var strs = "" ;
			  var cust_name = $id("cust_name").value ;
			  if(cust_name != null&&cust_name != ''){
			      strs=strs+"&arg1="+cust_name ;
			  }else{
			    alert("请选择客户，客户不能为空！") ;
			    return false ;
			  }
			  var reportyearmonth = $id("reportyearmonth").value ;
			  if(reportyearmonth != null&&reportyearmonth != ''){
	              strs=strs+"&arg2="+reportyearmonth ;
	          }else{
	          alert("请填写报表年月，报表年月不能为空！") ;
			    return false ;
	          }
			  var cust_name_value = $id("cust_name_value").value ;
			  if(cust_name_value != null&&cust_name_value != ''){
	              strs=strs+"&arg3="+cust_name_value ;
	          }
			  var myform = $id("myform") ;
			   myform.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/emppostReport.jsp?raq=emppostmonthly.raq"+strs+"&reporttype=1";
	           myform.submit();
		  
		  }
		}
		function rtnFuncCustomer(arg){
        var lookup = $id("cust_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];  
        $id("cust_name_value").value =arg[2] ;
        return false;
    }
  
    </script>
    
   
	</head>
	<body>
	<form name="myform" id="myform" method="post"
		action="">
		<input type="hidden" id="companyId" value="<%=companyId %>">
    <div id="right">
    <div class="right_title_bg">
      <div class=" right_title">员工入离职本月工作汇报</div></div>
    <div class="ringht_s">
    <!--表格2-->
    <div class="box_3"></div>
    <!--表格2 end-->
    <!--社保公积金-->
    <div class="zbox"><!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div class="xz_title">查询条件</div>
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        
        <tr>
          <td class="td_1"><font color="red">*</font>报表年月</td>
          <td class="td_2"><input name="text3" type="text" class="sText" id="reportyearmonth" value=""/></td>
          <td class="td_1"><font color="red">*</font>客户名称</td>
          <td class="td_2">
          <input type="hidden" id="cust_name_value" name="cust_name_value"  />
          <w:lookup onReturnFunc="rtnFuncCustomer" readonly="false" id="cust_name" name="cust_name" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/>
</td>
        </tr>
        <tr>
          <td colspan="4" align="center" class="td_2"> <input name="submit3" type="button" <au:authorityBtn code="bxbb_scbb" type="1"/> onclick="applyreport_submit();" class="icon_1" value="生成报表" />
           </td>
        </tr>
      </table>
    </div>
    <!--表格 end-->
    </div>
    <!--社保公积金 end-->
    <!--福利项目--><!--福利项目 end-->
    </div>
</div>
	</form>
</fmt:bundle>
</body>
<script type="text/javascript">
 //点击选择保单前事件
$id("policy_name").beforeOpenDialog= function(lookup){

        lookup.params = [];
         var policy_type = $id("policy_type").value ;
        if(policy_type!=""||policy_type!=null){
            lookup.addParam("policy_type",policy_type);
        return true;
        }
}
</script>
</html>


