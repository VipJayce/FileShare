<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.workattendance.signh.signh.vo.SignhVo" %>
<%@ page import="rayoo.workattendance.signh.signh.util.ISignhConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	SignhVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ISignhConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SignhVo)request.getAttribute(ISignhConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function vailform(){
        var  emp_id = jQuery("#emp_id").val();
        if(!emp_id){
            alert("请选择员工");
            return false;
        }
        return true;
    }
	
	function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/SignhAction.do?cmd=update&id="+code;
            }else{
	            form.action="<%=request.getContextPath()%>/SignhAction.do?cmd=insert&id="+code;
            }
            form.submit();
       }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/SignhAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function rtnFunc(arg){
	    var lookup = $id("lk_cust");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    jQuery("#cust_id").val(arg[0]);       
	    return false;
	}
	
	function rtnFuncEmployee(arg){
		var lookup = $id("emp_name");
		lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    jQuery("#emp_id").val(arg[0]);
	    jQuery("#cust_id").val(arg[6]);
	    jQuery("#emp_code").val(arg[2]);
	    jQuery("#customer_name").val(arg[4]);
	    jQuery("#customer_code").val(arg[5]);
	    return false;
	}
</script>
</head>
<body>
<script language="javascript">
    if(<%=isModify%>)
        writeTableTop('签卡数据修改','<%=request.getContextPath()%>/');
    else
        writeTableTop('签卡数据新增','<%=request.getContextPath()%>/');
</script>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>员工名称</td>
            <td class="td_2 " width="28%">
             <input type="hidden" name="emp_id" id="emp_id" value="${bean.emp_id}">
             <w:lookup onReturnFunc="rtnFuncEmployee" readonly="false" 
             	displayValue="${bean.emp_name}"
             	id="emp_name" 
             	name= "emp_name" 
             	lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList"  
             	dialogTitle="选择员工" height="450" width="800"  style="width:170px"/>
        	</td>
        	<td class="td_1" width="23%"><span class="style_required_red">* </span>员工编号</td>
            <td class="td_2"  width="28%">
           	    <input type="text"  class="text_field" id="emp_code" name="emp_code"   maxLength="20" readonly="true"/>
            </td>
        </tr>
		<tr>
			
            <td class="td_1" width="23%"><span class="style_required_red">* </span>客户名称</td>
            <td class="td_2"  width="28%">
           	    <input type="text" id="customer_name" class="text_field" name="customer_name"  readonly="true" />
            	<input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>客户编号</td>
			<td  class="td_2" width="28%">
			    <input type="text" id="customer_code" class="text_field" name="customer_code"  readonly="true" />
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>签卡标志</td>
            <td  class="td_2 " width="28%" >
            	<d:select dictTypeId="SP_SIGNSTATUS" id="signstatus" name="signstatus" value="${bean.signstatus}"/>
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>签卡日期</td>
			<td  class="td_2" width="28%">
				<w:date  allowInput="true" name="signdate"  id="signdate"  property="bean/signdate"  format="YYYY-MM-DD"/>
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>签卡时间</td>
            <td  class="td_2 " width="28%" >
            	<w:time  property="signtime"  id="signtime"  value="${bean.signtime}" />
            </td>
            <td  class="td_1"  width="23%" ><span class="style_required_red">* </span>签卡原因</td>
            <td  class="td_2 " width="28%" >
            	<input type="text" property="signreason" name="signreason" class="text_field" id="signreason"  value="${bean.signreason}"/>
            </td>
		</tr>
    </table>
	<p></p>
</div>
		<div class="foot_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
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
