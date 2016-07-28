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
	boolean isModify = true;
	if(request.getAttribute(IJcustomerConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (JcustomerVo)request.getAttribute(IJcustomerConstants.REQUEST_BEAN); 
	}
	String cust_id = request.getParameter("cust_id");
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
            var code = jQuery("#edit_id").val();
            var cust_code = jQuery("#cust_code").val();
	        form.action="<%=request.getContextPath()%>/JcustomerAction.do?cmd=insert2&id="+code+"&cust_code="+cust_code+"&cust_id="+<%=cust_id %>;
            form.submit();
            returnValue = ["0"];
            window.close();
            window.opener.insertcallBack(returnValue);
       }
       
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function onkeyupvaliname() {
        var name = document.getElementById("cust_name").value;
        if(name!=null&&name!=''){
	         jQuery.ajax({
	           url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=vailCustName&name='+encodeURI(name),
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	               error: function(){
	                  alert('客户名称重复!');
	                  jQuery("#customer_name").val("");
	                  return;
	               },
	                success: function(data){
		                if(data=='true'){
		                   alert('客户名称重复!');
		                   jQuery("#customer_name").val("");
		                   return;
		               }
	               }
	           });
           }
    }
    
    //获取客户code
	function gencode(){
       	var flags=true;
        jQuery.ajax({
        url: '<%=request.getContextPath()%>/JcustomerAction.do?cmd=getCustCode',
        type: 'POST',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(code){
	        document.getElementById("cust_code").value=code;
	        document.getElementById("custbtn").disabled="disabled";
	        document.getElementById("cust_code").disabled="disabled";
        }
        });
        return flags;
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
            <td class="td_1"><span class="style_required_red">* </span>客户编码</td>
            
            <td class="td_2">
            	 <input type="hidden" id="cust_id" name="cust_id" />
                 <input type="text" class="text_field"  id="cust_code" name="cust_code" inputName="客户编号" value="${bean.cust_code}" maxLength="25" validate="notNull;" disabled="disabled"  />
       		</td>
       		<td class="td_1"><span class="style_required_red">* </span>客户性质</td>
            <td class="td_2">
            	<d:select dictTypeId="CUSTOMER_PROPERTY" id="cust_quality" name="cust_quality" value="${bean.cust_quality}" disabled="true" />
       		</td>
        </tr>
		<tr>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span>客户名称</td>
            <td width="26%" class="td_2 " colspan="3">
                <input type="text" class="text_field"  name="cust_name" id="cust_name" inputName="客户名称" value="${bean.cust_name}" maxLength="50" validate="notNull;" onblur="onkeyupvaliname(); " disabled="disabled" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >客户简称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="cust_sname" name="cust_sname" inputName="客户简称" value="${bean.cust_sname}" maxLength="50" disabled="disabled" />
            </td>
            <td class="td_1" >客户英文名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="cust_ename" name="cust_ename" inputName="客户英文名" value="${bean.cust_ename}" maxLength="50" disabled="disabled" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >公司规模</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="lnsize" name="lnsize" inputName="公司规模" value="${bean.lnsize}" maxLength="50" />
            </td>
             <td class="td_1" ><span class="style_required_red">* </span>客户类型</td>
            <td class="td_2" >
            	<d:select dictTypeId="CUSTOMER_TYPE" id="cust_type" name="cust_type" value="${bean.cust_type}" disabled="true" />
            </td>
        </tr>
          <tr>
            <td class="td_1" >联系人</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_person" name="contact_person" inputName="联系人" value="${bean.contact_person}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_person2" name="contact_person2" inputName="联系人2" value="${bean.contact_person2}" maxLength="50" />
            </td>
        </tr>
         <tr>
            <td class="td_1" >联系人职位</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_position" name="contact_position" inputName="联系人职位" value="${bean.contact_position}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2职位</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_position2" name="contact_position2" inputName="联系人2职位" value="${bean.contact_position2}" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系人电话</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tel_phone" name="tel_phone" inputName="联系人电话" value="${bean.tel_phone}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2电话</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tel_phone2" name="tel_phone2" inputName="联系人2电话" value="${bean.tel_phone2}" maxLength="50" />
            </td>
        </tr>		
        <tr>
            <td class="td_1" >联系人地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_address" name="contact_address" inputName="联系人地址" value="${bean.contact_address}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_address2" name="contact_address2" inputName="联系人2地址" value="${bean.contact_address2}" maxLength="50" />
            </td>
        </tr>
         <tr>
            <td class="td_1" >联系人EMAIL</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="email" name="email" inputName="联系人EMAIL" value="${bean.email}" maxLength="50" />
            </td>
            <td class="td_1" >联系人2EMAIL</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="email2" name="email2" inputName="联系人2EMAIL" value="${bean.email2}" maxLength="50" />
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
