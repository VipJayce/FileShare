<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.auuserip.vo.AuUserIPVo" %>
<%@ page import="rayoo.u8.auuserip.util.IAuUserIPConstants" %>
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
	AuUserIPVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IAuUserIPConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (AuUserIPVo)request.getAttribute(IAuUserIPConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
        var  au_user_id = jQuery("#au_user_id").val();
        if(!au_user_id){
            alert("请选择ERP用户");
            return false;
        }
        var  ip = jQuery("#ip").val();
        if(!ip){
            alert("请输入IP地址");
            return false;
        }
        return true;
       }
	function save_onClick(){  //保存
		if(vailform()){
			var  code = jQuery("#edit_id").val();
			 if (code){
                form.action="<%=request.getContextPath()%>/AuUserIPAction.do?cmd=update&id="+code;
            }else{
	            form.action="<%=request.getContextPath()%>/AuUserIPAction.do?cmd=insert&id="+code;
            }
            form.submit();
            window.opener.location.reload();
            window.close();
		}
	}


    function cancel_onClick(){  //取消后返回列表页面
       window.close();
    }
    
     function erpFunc(arg){
	    var lookup = $id("lk_erp");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    jQuery("#au_user_id").val(arg[1]);       
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
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>ERP用户</td>
            
            <td class="td_2 " width="28%">
                <input type="hidden" name="au_user_id" id="au_user_id" value="${bean.au_user_id}">
                <w:lookup onReturnFunc="erpFunc" lookupWidth="189px" readonly="false" displayValue="${bean.au_user_name}" id="lk_erp" 
                                   lookupUrl="/Erp_userAction.do?cmd=getErpRef" dialogTitle="选择ERP用户" 
                                   height="440" width="710" allowInput="false"/>
       		</td>
       		<td class="td_1"  width="23%" ><span class="style_required_red">* </span>IP地址</td>
       		<td class="td_2 " width="28%">
       			<input type="text" class="text_field" name="ip" id="ip"  maxLength="35"    value="${bean.ip}"/>
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