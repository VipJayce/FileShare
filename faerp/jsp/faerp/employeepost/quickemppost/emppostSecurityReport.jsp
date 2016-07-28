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
			  var start_date = $id("start_date").value ;
			  if(start_date != null&&start_date != ''){
	              strs=strs+"&arg2="+start_date ;
	          }else{
	            alert("请选择开始时间，开始时间不能为空！") ;
			    return false ;
	          }
			  var end_date = $id("end_date").value ;
			  if(end_date!=null&&end_date != ''){
	              strs=strs+"&arg3="+end_date ;
	          }
			  
			  var myform = $id("myform") ;
			  myform.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/emppostReport.jsp?raq=emppostsecurity.raq"+strs+"&reporttype=2";
	          myform.submit();
		  }
		}
    function rtnFuncCustomer(arg){
        var lookup = $id("cust_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];  
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
      <div class=" right_title">福利办理明细报表</div></div>
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
          <td class="td_1"><font color="red">*</font>客户名称</td>
          <td class="td_2"><w:lookup onReturnFunc="rtnFuncCustomer" readonly="false" id="cust_name" name="cust_name" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/></td>
          <td class="td_1"><font color="red">*</font>报表开始时间</td>
          <td class="td_2"><w:date format="yyyy/MM/dd" id="start_date" name="start_date" width="170px"/></td>
          <td class="td_1">报表结束时间</td>
          <td class="td_2">
                    <w:date format="yyyy/MM/dd" id="end_date" name="end_date" width="170px"/>
          </td>
        </tr>
        <tr>
          <td colspan="6" align="center" class="td_2"> <input name="submit3" type="button" <au:authorityBtn code="bxbb_scbb" type="1"/> onclick="applyreport_submit();" class="icon_1" value="生成报表" />
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


