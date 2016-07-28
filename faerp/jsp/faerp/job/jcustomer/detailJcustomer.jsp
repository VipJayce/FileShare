<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.jcustomer.vo.JcustomerVo" %>
<%@ page import="rayoo.job.jcustomer.util.IJcustomerConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	JcustomerVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = true;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getAttribute(IJcustomerConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		 resultVo = (JcustomerVo)request.getAttribute(IJcustomerConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  	}
	
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function vailform(){
        var  erp_partid = jQuery("#erp_partid").val();
        if(!erp_partid){
            return true;
        }
        return true;
    }
	
	function save_onClick(){  //保存
       
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/JcustomerAction.do?cmd=update&id="+code;
            }
            form.submit();
            returnValue = ["0"];
            window.close();
            window.opener.updatecallBack(returnValue);
       }
       
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
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
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>客户编码</td>
            
            <td class="td_2 " width="28%">
                <input type="text" readonly="true" class="text_field" name="cust_code" id="cust_code" value="${bean.cust_code}" maxlength="25"  disabled="disabled"/>
       		</td>
       		<td class="td_1"  width="23%" ><span class="style_required_red">* </span>客户性质</td>
            <td class="td_2 " width="28%">
            	<d:select disabled="true" dictTypeId="CUSTOMER_PROPERTY" id="cust_quality" name="cust_quality" value="${bean.cust_quality}"/>
       		</td>
        </tr>
		<tr>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span>客户名称</td>
            <td width="26%" class="td_2 " colspan="3">
                <input type="text" readonly="true" class="text_field"  name="cust_name" id="cust_name" inputName="客户名称" value="${bean.cust_name}" maxLength="50" validate="notNull;" onblur="onkeyupvaliname();" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >客户简称</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="cust_sname" name="cust_sname" inputName="客户简称" value="${bean.cust_sname}" maxLength="50" />
            </td>
            <td class="td_1" >客户英文名称</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="cust_ename" name="cust_ename" inputName="客户英文名" value="${bean.cust_ename}" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >公司规模</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="lnsize" name="lnsize" inputName="公司规模" value="${bean.lnsize}" maxLength="50" />
            </td>
             <td class="td_1" ><span class="style_required_red">* </span>客户类型</td>
            <td class="td_2" >
            	<d:select disabled="true" dictTypeId="CUSTOMER_TYPE" id="cust_type" name="cust_type" value="${bean.cust_type}"/>
            </td>
        </tr>
          <tr>
            <td class="td_1" >联系人</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="contact_person" name="contact_person" inputName="联系人" value="${bean.contact_person}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="contact_person2" name="contact_person2" inputName="联系人2" value="${bean.contact_person2}" maxLength="50" />
            </td>
        </tr>
         <tr>
            <td class="td_1" >联系人职位</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="contact_position" name="contact_position" inputName="联系人职位" value="${bean.contact_position}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2职位</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="contact_position2" name="contact_position2" inputName="联系人2职位" value="${bean.contact_position2}" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系人电话</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="tel_phone" name="tel_phone" inputName="联系人电话" value="${bean.tel_phone}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2电话</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="tel_phone2" name="tel_phone2" inputName="联系人2电话" value="${bean.tel_phone2}" maxLength="50" />
            </td>
        </tr>		
        <tr>
            <td class="td_1" >联系人地址</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="contact_address" name="contact_address" inputName="联系人地址" value="${bean.contact_address}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2地址</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="contact_address2" name="contact_address2" inputName="联系人2地址" value="${bean.contact_address2}" maxLength="50" />
            </td>
        </tr>
         <tr>
            <td class="td_1" >联系人EMAIL</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="email" name="email" inputName="联系人EMAIL" value="${bean.email}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2EMAIL</td>
            <td class="td_2 ">
                <input type="text" readonly="true" class="text_field" id="email2" name="email2" inputName="联系人2EMAIL" value="${bean.email2}" maxLength="50" />
            </td>
        </tr>
    </table>
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
    </div>
</div>
<input type="hidden" name="id" id="edit_id" value="${bean.id}">
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
