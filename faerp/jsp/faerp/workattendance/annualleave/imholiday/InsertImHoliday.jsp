<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.workattendance.annualleave.imholiday.vo.ImHolidayVo" %>
<%@ page import="rayoo.workattendance.annualleave.imholiday.util.IImHolidayConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	ImHolidayVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IImHolidayConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (ImHolidayVo)request.getAttribute(IImHolidayConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>年假管理</title>
<script language="javascript">
	function vailform(){
        var  emp_id = jQuery("#empoyee_id").val();
        if(!emp_id){
            alert("请选择员工");
            return false;
        }
        var  restdayorhour = jQuery("#restdayorhour").val();
        if(!restdayorhour){
            alert("请输入结余假期");
            return false;
        }
        var  curyear = jQuery("#curyear").val();
        if(!curyear){
            alert("请选择年度");
            return false;
        }
        var  yidayorhour = jQuery("#yidayorhour").val();
        if(!yidayorhour){
            alert("请输入本年已休");
            return false;
        }
        return true;
    }
    
    //检查员工年假年度唯一性
    function onValiCuryear() {
        var emp_id = document.getElementById("emp_id").value;
        var cur_year = document.getElementById("curyear").value;
        if(emp_id!=null&&cur_year!=''&&cur_year!=null&&cur_year!=''){
	         jQuery.ajax({
	           url: '<%=request.getContextPath()%>/ImHolidayAction.do?cmd=vailCurYear&emp_id='+encodeURI(emp_id)+'&cur_year='+encodeURI(cur_year),
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	           error: function(){
	                  alert('同一员工在同一年度只能有一条有效记录!');
	                  jQuery("#curyear").val(null);
	                  return;
	               },
	           success: function(data){
		                if(data=='false'){
		                   alert(' 同一员工在同一年度只能有一条有效记录!');
		                   jQuery("#curyear").val(null);
		                   return;
		               }
	               }
	           });
           }
    }
	
	function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/ImHolidayAction.do?cmd=update1&id="+code;
            }else{
	            form.action="<%=request.getContextPath()%>/ImHolidayAction.do?cmd=insert&id="+code;
            }
            form.submit();
            window.close();
       }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function rtnFuncEmployee(arg){
		var lookup = $id("emp_name");
		lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    jQuery("#emp_id").val(arg[0]);
	    jQuery("#cust_id").val(arg[6]);
	    jQuery("#cust_name").val(arg[4]);
	    jQuery("#curyear").val(null);
	    return false;
	}
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng">
<div class="xz_title">基本信息</div> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" >
 	<% if(!isModify){ %>
        <tr>
        
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>客户名称</td>
            
            <td class="td_2 " width="28%">
            
                <w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust" 
                value="${bean.customer_name}" displayValue="${bean.customer_name}"
                lookupUrl="/FAERP/Sp_risk_fund_expAction.do?cmd=getAllCustomerByCondition" 
                dialogTitle="选择客户" height="450" width="610" /> 
                
                
                
                <input id="customer_id" name="cust_id" type="hidden"  value="${bean.cust_id }"/>
                <input id="customer_code" name="customer_code" type="hidden"  value="${bean.customer_code }"/>
<!--                <input id="customer_name" name="customer_name" type="hidden" value="${bean.customer_name}"/>-->
                
                
<!--        0729 之前        -->
<!--                <input type="text" id="cust_name" class="text_field" name="cust_name"  readonly="true" />-->
<!--                <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">-->
             </td>
             
             
             
        	<td class="td_1"  width="23%" ><span class="style_required_red">* </span>员工名称</td>
            
            <td class="td_2 " width="28%">


                <w:lookup onReturnFunc="rtnFuncEmployee" readonly="true" id="empoyee_name" name= "empoyee_name"  validateAttr="allowNull=false;"
                value="${bean.emp_name }" displayValue="${bean.emp_name}" 
                lookupUrl="/Sp_risk_fund_expAction.do?cmd=searchEmployeeToList"  dialogTitle="选择员工" height="450" width="800"  style="width:170px">
                    
                </w:lookup>
                <input type="hidden" id="empoyee_id" name="emp_id" value="${bean.emp_id }">
            </td>
<script type="text/javascript">

jq(function(){
    $id("lk_cust").onReturnFunc = function (returnValue){
        var lookup = $id("lk_cust");
        lookup.value = returnValue[0];
        lookup.displayValue = returnValue[2];
        
        jq("#customer_id").val(returnValue[0]);
        jq("#customer_code").val(returnValue[1]);
        jq("#customer_name").val(returnValue[2]);
        
        var lookup = $id("empoyee_name");
        lookup.setValue("");
        lookup.setDisplayValue("");
        return false;
    }
    
    function beforeOpenEmp(lookup){
        if(!jq("#customer_id").val()){
           alert("请先选择客户！");
           return false;
        }
        lookup.params = [];
        var customer_id=jq("#customer_id").val();
        lookup.addParam("customer_id",customer_id);
        
        var customer_code=jq("#customer_code").val();
        lookup.addParam("customer_code",customer_code);
        return true;
    }
    
    $id("empoyee_name").beforeOpenDialog= beforeOpenEmp;
    
    
});
function rtnFuncEmployee(arg){
    var lookup = $id("empoyee_name");
    
    lookup.value = arg[1];
    lookup.displayValue = arg[1];
    
    jq("#empoyee_id").val(arg[0]);//emp_id
    /*
    if(arg[2] !=null &&arg[2]!=''){
        $id("emp_code").value = arg[2] ;
    }
    
    $id("emp_id_card").value = arg[3] ;
    */
    return false;
}

</script>

        
            
        </tr>
        <%} else{ %>
          <tr>
        	<td class="td_1"  width="23%" ><span class="style_required_red">* </span>员工名称</td>
            
            <td class="td_2 " width="28%">
                <input type="hidden" name="emp_id" id="empoyee_id" value="${bean.emp_id}">
                <input type="text" id="emp_name" class="text_field" name="emp_name"  readonly="true" />
        	</td>
        
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>客户名称</td>
            
            <td class="td_2 " width="28%">
                <input type="text" id="cust_name" class="text_field" name="cust_name"  readonly="true" />
            	<input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">
        </tr>
        <%} %>
		<tr>
			</td>
            <td class="td_1" width="23%"><span class="style_required_red">* </span>结余假期</td>
            <td class="td_2"  width="28%">
            	<input type="text" class="text_field" name="restdayorhour" id="restdayorhour"  maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.restdayorhour}"/>
            </td>
		
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>年度</td>
			<td  class="td_2" width="28%">
				<%if(!isModify){ %>
				<d:select dictTypeId="SP_CURYEAR" id="curyear" name="curyear" value="${bean.curyear}" nullLabel="--请选择--" onchange="onValiCuryear()"/>
				<%}else{ %>
				<input type="text" id="curyear" class="text_field" name="curyear"  readonly="true" />
				<%} %>
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>本年已休</td>
            <td  class="td_2 " width="28%" >
            	<input type="text" class="text_field" name="yidayorhour" id="yidayorhour"  maxLength="5" integerDigits="4" decimalDigits="0"  value="${bean.yidayorhour}"/>
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>本年享有</td>
			<td  class="td_2" width="28%">
				<input type="text" class="text_field" name="curdayorhour" id="curdayorhour"  maxLength="5" integerDigits="4" decimalDigits="0"  value="${bean.curdayorhour}"/>
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>上年结余</td>
            <td  class="td_2 " width="28%" >
            	<input type="text" class="text_field" name="lastdayorhour" id="lastdayorhour"  maxLength="5" integerDigits="4" decimalDigits="0"  value="${bean.lastdayorhour}"/>
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>结余法定年假天数</td>
			<td  class="td_2" width="28%">
				<input type="text" class="text_field" name="lastAnnualLeaveDays" id="lastAnnualLeaveDays"  maxLength="5" integerDigits="4" decimalDigits="0"  value="${bean.lastAnnualLeaveDays}"/>
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>结余公司福利年假天数</td>
            <td  class="td_2 " width="28%" >
            	<input type="text" class="text_field" name="c_lastAnnualLeaveDays" id="c_lastAnnualLeaveDays"  maxLength="5" integerDigits="4" decimalDigits="0"  value="${bean.c_lastAnnualLeaveDays}"/>
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>计算时间</td>
			<td  class="td_2" width="28%">
				<w:date allowInput="true" id="calculatetime" name="calculatetime" format="YYYY-MM-DD hh:mm:ss" width="180px" property="bean/calculatetime"/>
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>是否使用</td>
            <td  class="td_2 " width="28%" >
            	<d:select dictTypeId="TrueOrFalse" id="isuse" name="isuse" value="${bean.isuse}" style="width:207px;"  nullLabel="--请选择--"/>
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>是否结算</td>
			<td  class="td_2" width="28%">
				<d:select dictTypeId="TrueOrFalse"   id="isseal" name="isseal" value="${bean.isseal}" style="width:207px;"  nullLabel="--请选择--"/>
			</td>
		</tr>
    </table>
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
	</div>
</div>
		

<input type="hidden" name="id" id="edit_id" value="${bean.id}">
<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="create_date" />
</form> 
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}

%>
</script>
