<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper" %>

<html>
    <fmt:bundle basename="rayoo.finance.bill.billprint.billprint_resource" prefix="rayoo.finance.bill.billprint.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
  	
    function exportEXCEL_onClick(){
        var bill_year_month = document.form.bill_year_month.value;
        var create_type=document.getElementById("create_type").value;
        var user_id = "";
        var cust_name = document.form.cust_name.value;
        var cost_center_id = document.form.cost_center_id.value;
        var bill_type_bd = document.form.bill_type_bd.value;
        //var cust_type = document.form.cust_type.value;
        var login_name = document.form.login_name.value;
        var company_id = document.form.company_id.value;
        var cust_group=document.getElementById("cust_group").value;
        //以下两个时间为服务年月“起止”年月
         var bill_year_month4f = document.form.bill_year_month4f.value;
         var bill_year_month4s = document.form.bill_year_month4s.value;
        if(create_type=='2'){//客服
        if(bill_year_month ==null || bill_year_month == ""){
           alert("<fmt:message key='alert_bill_year_month_null'/>");
           return;
        }else{
           if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_bill_year_month_length'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_bill_year_month'/>");
               return;
           }
        }
            var cust_service_man=document.getElementById("customer_service_hidden").value;
            if(cust_service_man==""){
                alert("<fmt:message key='alert_select_customer_service_first'/>");
                return;
            }
                 //必须选择客户组
            if(cust_group==null || cust_group==""){
                alert("请选择所属客户!");
                return;
            }
            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeBillPrintReport4CustomerService.jsp?raq=ge_bill_print4customer_service.raq&arg1="+bill_year_month+"&arg2=&arg3=&arg4=&arg5="+bill_type_bd+"&arg7="+login_name+"&arg8="+company_id+"&arg9="+cust_service_man+"&arg10="+cust_group);
            $id("datacell_formid").submit();
            $id("exportbutton").disabled="disabled" ;
        }else if(create_type=='4'){//客户组
          if(bill_year_month ==null || bill_year_month == ""){
           alert("<fmt:message key='alert_bill_year_month_null'/>");
           return;
        }else{
           if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_bill_year_month_length'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_bill_year_month'/>");
               return;
           }
        }
         //必须选择客户组
            if(cust_group==null || cust_group==""){
                alert("请选择所属客户!");
                return;
            }
            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeBillPrintReport4CustGroup.jsp?raq=ge_bill_print4cust_group.raq&arg1="+bill_year_month+"&arg2="+bill_type_bd+"&arg3="+cust_group);
            $id("datacell_formid").submit();
            $id("exportbutton").disabled="disabled" ;
          }else{
       //校验时间,起始年月
       if(bill_year_month4f ==null || bill_year_month4f == ""){
              alert("<fmt:message key='alert_bill_year_month_null'/>");
              return;
        }else{
         if(bill_year_month4f.length != 6){
               alert("<fmt:message key='alert_bill_year_month_length'/>");
               return;
           }
               var year = bill_year_month4f.substring(0,4);
               var month = bill_year_month4f.substring(4,6);
               if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_bill_year_month'/>");
               return;
             }
         }
         //校验结束年月
          if(bill_year_month4s ==null || bill_year_month4s == ""){
              alert("<fmt:message key='alert_bill_year_month_null'/>");
              return;
          }else{
              if(bill_year_month4s.length != 6){
               alert("<fmt:message key='alert_bill_year_month_length'/>");
               return;
           }
               var year = bill_year_month4s.substring(0,4);
               var month = bill_year_month4s.substring(4,6);
               if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_bill_year_month'/>");
               return;
             }
         }
            if(bill_year_month4f>bill_year_month4s){
                 alert("起始年月不能超过结束年月!");
                 return;
            }
            
        if(create_type=="1"){//成本中心
        if(cust_name ==null || cust_name == ""){
            alert("<fmt:message key='alert_select_customer'/>");
            return;
        }
        if(cost_center_id == null || cost_center_id == ""){
            alert("<fmt:message key='alert_select_cost_center'/>");
            return;
        }
            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeBillPrintReport.jsp?raq=ge_bill_print.raq&arg1="+bill_year_month4f+"&arg2="+cust_name+"&arg3="+cost_center_id+"&arg4="+bill_type_bd+"&arg5="+bill_year_month4s);
            $id("datacell_formid").submit();
            $id("exportbutton").disabled="disabled" ;
        }else if(create_type=="3"){//员工
            var  emp_code=document.getElementById("emp_code").value;
            var  emp_internal_code=document.getElementById("emp_internal_code").value;
            if(emp_code==""&&emp_internal_code==""){
                alert("<fmt:message key='alert_select_code_first'/>");
                return;
                }
                
             $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeBillPrintReport4Employee.jsp?raq=ge_bill_print4employee.raq&arg1="+bill_year_month4f+"&arg2="+bill_type_bd+"&arg3="+login_name+"&arg4="+company_id+"&arg5="+emp_code+"&arg6="+emp_internal_code+"&arg7="+bill_year_month4s);
             $id("datacell_formid").submit();
             $id("exportbutton").disabled="disabled" ;
        }else if(create_type=="5"){//客户
            var cust_name4cust=document.getElementById("cust_name4cust").value;
            if(cust_name4cust ==null || cust_name4cust == ""){
                alert("<fmt:message key='alert_select_customer'/>");
                return;
             }
              $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeBillPrintReport4Cust.jsp?raq=ge_bill_print4cust.raq&arg1="+bill_year_month4f+"&arg2="+bill_type_bd+"&arg3="+login_name+"&arg4="+company_id+"&arg5="+cust_name4cust+"&arg10="+bill_year_month4s+"&arg11="+cust_group);
              $id("datacell_formid").submit();
              $id("exportbutton").disabled="disabled" ;
        }
        }
    }
    
    
    function  export_AnalysisReport(){
        var bill_year_month = document.form.bill_year_month.value;
        var create_type=document.getElementById("create_type").value;
        var cust_id = document.getElementById("cust_id").value;
        var cost_center_id = document.form.cost_center_id.value;
        var bill_type_bd = document.form.bill_type_bd.value;
        //var cust_type = document.form.cust_type.value;
        var login_name = document.form.login_name.value;
        var company_id = document.form.company_id.value;
        //以下两个时间为服务年月“起止”年月
         var bill_year_month4f = document.form.bill_year_month4f.value;
         var bill_year_month4s = document.form.bill_year_month4s.value;
         var cust_group=document.getElementById("cust_group").value;
         
         var bill_lm="";//上一月
         
           //校验时间,起始年月
	        if(bill_year_month4f ==null || bill_year_month4f == ""){
	                  alert("<fmt:message key='alert_bill_year_month_null'/>");
	                  return;
	            }else{
	             if(bill_year_month4f.length != 6){
	                   alert("<fmt:message key='alert_bill_year_month_length'/>");
	                   return;
	               }
	                   var year = bill_year_month4f.substring(0,4);
	                   var month = bill_year_month4f.substring(4,6);
	                   if(year<2000 || year>2030 || month<1 || month>12){
	                   alert("<fmt:message key='alert_bill_year_month'/>");
	                   return;
	                 }
			        if (month == '01'){
			            bill_lm = parseInt(year)-1 + "12";
			        }else{
			            bill_lm = parseInt(bill_year_month4f)-1 + "";
			        }
			             }
	             
	         if(cust_id ==null || cust_id == ""){
	            alert("<fmt:message key='alert_select_customer'/>");
	            return;
		        }
	        if(cost_center_id == null || cost_center_id == ""){
	            alert("<fmt:message key='alert_select_cost_center'/>");
	            return;
	        }
        
            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeAnalysisReport.jsp?raq=ge_Analysis_group.rpg&arg1="+bill_year_month4f+"&arg2="+cust_id+"&arg3="+cost_center_id+"&arg4="+bill_type_bd+"&arg5="+bill_lm);
            $id("datacell_formid").submit();
            $id("exportAnalysis").disabled="disabled" ;
      }
    
	
</script>
	</head>
	<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
<input type="hidden" name="company_id" id="company_id" value="<%=LoginHelper.getLoginVo(request).getCompany_id()%>"/>
	<div id="right">
	<script language="javascript">
	   writeTableTopFesco("<fmt:message key='title_gebillprint'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	<div class="ringht_s">


	<table width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<div class="zbox">
			<div class="xz_title"><fmt:message key='report'/></div>
			<!--表格1-->
			<div class="box_3">
			<table width="100%" height="40" border="0" cellpadding="0"
				cellspacing="1" bgcolor="#c5dbe2">
				<tr>
                    <!-- 账单年月开始 -->
                    <td class="td_1" ><fmt:message key='billyearmonth'/></td>
                    <td class="td_2" id="billyear4all" style="display:none">
                       <input type="text" class="text_field" name="bill_year_month" inputName="账单年月" maxLength="50" value="" />
                     </td>
                    <td class="td_2"  id="billyear4emp"  style="display:inline"><span>起</span>
                       <input type="text" class="text_field" name="bill_year_month4f" inputName="账单年月" maxLength="50" value="" style="width:170px" />
                       </br>
                       <span>止</span>
                       <input type="text" class="text_field" name="bill_year_month4s" inputName="账单年月" maxLength="50" value="" style="width:170px" />
                     </td>
                     <!-- 账单年月结束 -->
                     <td   class="td_1"><fmt:message key='create_type'/></td>
                      <td  class="td_2">
                      <select id="create_type" name="create_type" onchange="do_ex()">
                                      <option value="5" ><fmt:message key='customer_name_4option'/></option><!-- 客户-->
                                      <option value="2"><fmt:message key='customer_service'/></option><!-- 客服-->
                                      <option value="3"><fmt:message key='emp_name'/></option><!-- 员工-->
                                      <option value="4"><fmt:message key='cust_group'/></option><!-- 客户组-->
                                      <option value="1" selected="selected"><fmt:message key='cost_center'/></option><!-- 成本中心-->
                      </select>
                      </td>
                    </tr>
				<tr style="display: inline" id="tr4kehuCBZX">
				    <td class="td_1"><fmt:message key='customer_name'/></td>
                    <td class="td_2">
                            <w:lookup readonly="true"  id="lk_cust"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                messagekey="choose_cust"  height="450" width="610" style="width:183px" />
                        <input id="cust_id" name="cust_id" type="hidden">
                        <input id="cust_name" name="cust_name" type="hidden"/>
                    </td>
		            <td class="td_1"><fmt:message key='cost_center'/></td>
		            <td class="td_2">
			            <r:comboSelect id="cost_center_id" name="cost_center_id"
			                queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			                textField="cost_center_name"
			                valueField="id"
			                xpath="CostcenterVo"
			                width="200" messagekey="please_select">
			            </r:comboSelect>
		            </td>
                </tr>
                <tr style="display:none" id="tr4kefu">
                        <td class="td_1"><fmt:message key='customer_service'/></td>
                         <td class="td_2">  
                                    <r:comboSelect id="customer_service" name="customer_service1" queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                textField="name" valueField="partyid" xpath="Partyrelation" width="183px" messagekey="please_select" />
                     </td>
                     <td class="td_1"></td>
                     <td class="td_2"></td>
                    </tr>
                    <!-- *************************************************************** -->                    
                    <tr style="display:none" id="tr4yuangong">
                            <td  class="td_1"><fmt:message key='emp_code'/></td>
                            <td  class="td_2">
                            <input type="text" class="text_field" id="emp_code" name="emp_code" inputName="唯一号" maxLength="50" value=""/>
                            </td>
                            <td  class="td_1"><fmt:message key='emp_internal_code'/></td>
                            <td  class="td_2">
                            <input type="text" class="text_field" id="emp_internal_code" name="emp_internal_code" inputName="客户方编号" maxLength="50" value=""/>
                            </td>
                    </tr>
                    <!-- *************************************************************** -->
                    <tr style="display: none" id="tr4Cust">
                    <td class="td_1"><fmt:message key='customer_name'/></td>
                    <td class="td_2">
                            <w:lookup readonly="true"  id="lk_cust4cust"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                messagekey="choose_cust"  height="450" width="610" style="width:183px" />
                        <input id="cust_id4cust" name="cust_id4cust" type="hidden">
                        <input id="cust_name4cust" name="cust_name4cust" type="hidden"/>
                    </td>
                    <td class="td_1"></td>
                    <td class="td_2"></td>
                </tr>
                <!-- ********************************************************************* -->
                    
			 <tr>
                    <td class="td_1"><fmt:message key='bill_type_bd'/></td>
                    <td class="td_2">
                        <d:select dictTypeId="BILL_TYPE_BD" id="bill_type_bd" name="bill_type_bd" 
                                  style="width:200px" nullLabel="--请选择--" filterOp="in" filterStr="1,2,3" />
                    </td>
                    <td class="td_1" >所属客户</td>
                    <td class="td_2">
                    <!--
                       <select id="cust_type" name="cust_type"  style="width:183px">
                          <option value="2" selected="selected">GE</option>
                       </select>
                       -->
              <r:comboSelect id="cust_group" name="cust_group" queryAction="/FAERP/Cust_groupAction.do?cmd=queryListCustname"
              textField="cust_group_name" valueField="cust_group_code" xpath="Cust_groupVo" width="200px" messagekey="please_select"/> 
                    </td>
                </tr>
				
				<tr class="td_1">
                <td  align="right" colspan="2">
                 <input  id="exportbutton"  class="foot_icon_3" type="button"   value="导出账单"  <au:authorityBtn code="zddy_exp" type="1"/>  onClick="exportEXCEL_onClick();">
            </td>
            <td align="left" colspan="2">
            <div  id="but_aa" style="display: inline">
            <input  id="exportAnalysis"  class="foot_icon_3" type="button"   value="分析报表组"    onClick="export_AnalysisReport();">
            <input type="button" id="butt_22" class="icon_3"    onclick="create();" value="计算报表" />
            </div>
            </td>
                </tr>
				
			</table>
			</table>
			</div>
			</div>
			</td>
		</tr>
	</table>
	
	</form>
</fmt:bundle>
</body>
</html>
<script>
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    jQuery("#cust_name").val(returnValue[2]);
    jQuery("#cust_id").val(returnValue[0]);
    lookup.displayValue = returnValue[2];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}

/****************************************************************************************/
$id("lk_cust4cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust4cust");
    lookup.value = returnValue[0];
    jQuery("#cust_name4cust").val(returnValue[2]);
    lookup.displayValue = returnValue[2];
    return false;
}


 /********************************选择生成方式***************************************/
    function do_ex(){
    var type=document.getElementById("create_type").value;
       if(type==1){
             document.getElementById("tr4kehuCBZX").style.display="inline";//显示成本中心行
             document.getElementById("tr4kefu").style.display="none";//隐藏客服
             document.getElementById("tr4yuangong").style.display="none";//隐藏员工
             document.getElementById("tr4Cust").style.display="none";//隐藏客户
             document.getElementById("billyear4all").style.display="none";//单个账单年月框
             document.getElementById("billyear4emp").style.display="inline";//多个账单年月框
             jQuery("#but_aa").css("display","inline");
        }
        else if(type==2){
             document.getElementById("tr4kehuCBZX").style.display="none";//隐藏成本中心行
             document.getElementById("tr4kefu").style.display="inline";//显示客服
             document.getElementById("tr4yuangong").style.display="none";//隐藏员工
             document.getElementById("tr4Cust").style.display="none";//隐藏客户
             document.getElementById("billyear4all").style.display="inline";//单个账单年月框
             document.getElementById("billyear4emp").style.display="none";//多个账单年月框
             jQuery("#but_aa").css("display","none");
        }else if(type==3){
             document.getElementById("tr4kehuCBZX").style.display="none";//隐藏成本中心行
             document.getElementById("tr4kefu").style.display="none";//隐藏客服
             document.getElementById("tr4yuangong").style.display="inline";//显示员工
             document.getElementById("tr4Cust").style.display="none";//隐藏客户
             document.getElementById("billyear4all").style.display="none";//单个账单年月框
             document.getElementById("billyear4emp").style.display="inline";//多个账单年月框
             jQuery("#but_aa").css("display","none");
        }else if(type==5){
             document.getElementById("tr4kehuCBZX").style.display="none";//隐藏成本中心行
             document.getElementById("tr4kefu").style.display="none";//隐藏客服
             document.getElementById("tr4yuangong").style.display="none";//隐藏员工
             document.getElementById("tr4Cust").style.display="inline";//显示客户
             document.getElementById("billyear4all").style.display="none";//单个账单年月框
             document.getElementById("billyear4emp").style.display="inline";//多个账单年月框
             jQuery("#but_aa").css("display","none");
        }else if(type==4){
             document.getElementById("tr4kehuCBZX").style.display="none";//隐藏成本中心行
             document.getElementById("tr4kefu").style.display="none";//隐藏客服
             document.getElementById("tr4yuangong").style.display="none";//隐藏员工
             document.getElementById("tr4Cust").style.display="none";//隐藏客户
             document.getElementById("billyear4all").style.display="inline";//单个账单年月框
             document.getElementById("billyear4emp").style.display="none";//多个账单年月框
             jQuery("#but_aa").css("display","none");
        }
    }
    
    
    
    
     function create(){
        var cust_id = document.getElementById("cust_id").value;
        var cost_center_id = document.form.cost_center_id.value;
     //以下两个时间为服务年月“起止”年月
         var bill_year_month4f = document.form.bill_year_month4f.value;
         var bill_year_month4s = document.form.bill_year_month4s.value;
         var bill_lm="";//上一月
           //校验时间,起始年月
            if(bill_year_month4f ==null || bill_year_month4f == ""){
                      alert("请填写账单年月,如“201203”!");
                      return;
                }else{
                 if(bill_year_month4f.length != 6){
                       alert("账单年月条件必须为6位数字,如“201203”！");
                       return;
                   }
                       var year = bill_year_month4f.substring(0,4);
                       var month = bill_year_month4f.substring(4,6);
                       if(year<2000 || year>2030 || month<1 || month>12){
                       alert("请正确输入账单年月查询条件，年份在2000~2030之间，月份在01~12之间，如“201203”！");
                       return;
                     }
                    if (month == '01'){
                        bill_lm = parseInt(year)-1 + "12";
                    }else{
                        bill_lm = parseInt(bill_year_month4f)-1 + "";
                    }
                         }
                 
             if(cust_id ==null || cust_id == ""){
                alert("请选择客户");
                return;
                }
            if(cost_center_id == null || cost_center_id == ""){
                alert("请选择成本中心！");
                return;
            }
         jQuery("#butt_22").css("display","none");
         jQuery.ajax({
            url: "<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=toCreateGEAnalysis&yearmonth="+bill_year_month4f+"&b_yearmonth="+bill_lm+"&cust_id="+cust_id+"&cost_center_id="+cost_center_id,
            type: "POST",
            dataType: "html",
            timeout: 10000000,
            error: function(){
                alert("系统错误，请刷新后重新计算");
                return ;
            },
            success: function(data){
            alert("已经提交后台计算，稍后可导出分析报表!");
            return;
            }
             });  
        
    }

</script>