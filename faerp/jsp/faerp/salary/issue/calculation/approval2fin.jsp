<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.issue.calculation.calculation_resource" prefix="rayoo.salary.issue.calculation.">
<head>
    <base target="_self"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
    <script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/sararyCal.js"></script>
    <script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/calcommon.js"></script>
    <style type="text/css">
		element.style {
		    height: 450px;
		}
		.box_xinzeng_me {
		    height: 100%;
		    margin: 10px;
		    overflow-y: auto;
		    width: 99%;
		}
		body {
		    color: #333333;
		    font-family: "宋体";
		    font-size: 12px;
		    line-height: 150%;
		}
		
		.box_xinzeng_me td{ height:30px; padding:0 10px;}
        .box_xinzeng_me .td_1{ background:#f1f7f9; text-align:right;}
        .box_xinzeng_me .xz_button {
            margin-top: 10px;
            text-align: center;
        }
		span {
            color: red;
        }
        .sText{color:#333333;   line-height:12px; width:188px;background:#fff url(images/bk_field.png) repeat-x top right; padding:3px;border-top:1px solid #8d8e8d;border-left:1px solid #8d8e8d;border-right:1px solid #e0e1e0;border-bottom:1px solid #e0e1e0;}
    </style>
</head>
<body>
<form name="form" method="post" id="submitAuditform">
<input type="hidden" name="batch_id" id="batch_id" value="${salarybatchVo.id }"/>
<input type="hidden" name="batch_code" id="batch_code" value="${salarybatchVo.sa_batch_code }"/>
<input type="hidden" name="customer_id" id="customer_id" value="${salarybatchVo.customer_id }"/>
<input type="hidden" name="type" id="type" value="${type }"/>

<div class="box_xinzeng_me" style="margin: 10px;">
    <div><strong><fmt:message key='customer_info'/></strong></div>
  <div>
    <table cellspacing="0" cellpadding="0" border="0">
      <tbody>
        <tr>
          <td> <fmt:message key='customer_code'/>：</td>
          <td>${salarybatchVo.customer_code }</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><fmt:message key='customer_name'/>：</td>
          <td>${salarybatchVo.customer_name }</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><fmt:message key='sa_batch_code'/>：</td>
          <td>${salarybatchVo.sa_batch_code }</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><fmt:message key='must_day'/>：</td>
          <td>${salarybatchVo.must_day }</td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr>
          <td valign="top"><span>*</span><fmt:message key='select_import_file'/>：</td>
          <td valign="top">
               <input type="text" id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="" hiddenInputId="attach_name"/>
               <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
               <input type="hidden" id="attackAddressInput" name="attach_address" value="">
          </td>
          <td valign="top"><span>*</span><fmt:message key='e_tax_list'/>：</td>
          <td valign="top"><input type="text" id="e_tax_list" name="e_tax_list" class="sText" value="无" ></td>
        </tr>
        <tr>
          <td valign="top" align="right"><span>*</span><fmt:message key='rblPassWord'/>：</td>
          <td valign="top">
                <div style="float:left;">
                    <input type="radio" checked="checked" value="0" id="rblPassWord_0" name="is_pasword" />
                    <label for="rblPassWord_0"><fmt:message key='rblPassWord_0'/></label>
                    <input type="radio" value="1" name="is_pasword" id="rblPassWord_1" />
                    <label for="rblPassWord_1"><fmt:message key='rblPassWord_1'/></label>
                </div> 
                <div id="div1" style="display:none; float:right; margin-top:2px;">
                    <input type="text" id="file_pwd" name="file_pwd" style="width:90px;" class="sText">
                </div>
          </td>
          <td valign="top" align="right"><span>*</span><fmt:message key='e_fund_list'/>：</td>
          <td valign="top" align="left"><input type="text" id="e_fund_list" name="e_fund_list" class="sText" value="无"></td>
        </tr>
        <tr>
          <td valign="top" align="right"><span>*</span><fmt:message key='emp_differ_list'/>：</td>
          <td valign="top" align="left"><input type="text" id="emp_differ_list" name="emp_differ_list" class="sText" value="无"></td>
          <td valign="top" align="right"><span>*</span><fmt:message key='only_tax_list'/>：</td>
          <td valign="top" align="left"><input type="text" id="only_tax_list" name="only_tax_list" class="sText" value="无"></td>
        </tr>
        <tr>
          <td valign="top" align="right"><span>*</span><fmt:message key='emp_differ_cause'/>：</td>
          <td valign="top" align="left"><input type="text" id="emp_differ_cause" name="emp_differ_cause" class="sText" value="无"></td>
          <td valign="top" align="right"><span>*</span><fmt:message key='alien_list'/>：</td>
          <td valign="top" align="left"><input type="text" id="alien_list" name="alien_list" class="sText" value="无"></td>
        </tr>
        <tr>
          <td valign="top" align="right"><span>*</span><fmt:message key='sum_differ_list'/>：</td>
          <td valign="top" align="left"><input type="text" id="sum_differ_list" name="sum_differ_list" class="sText" value="无"></td>
          <td valign="top" align="right"><span>*</span><fmt:message key='other_cause'/>：</td>
          <td valign="top" align="left"><input type="text" id="other_cause" name="other_cause" class="sText" value="无"></td>
        </tr>
        <tr>
          <td valign="top" align="right"><span>*</span><fmt:message key='sum_differ_cause'/>：</td>
          <td valign="top" align="left"><input type="text" id="sum_differ_cause" name="sum_differ_cause" class="sText" value="无"></td>
          <td valign="top" align="left"></td>
          <td valign="top" align="left"></td>
        </tr>
        <tr>
          <td valign="top" align="right">&nbsp;</td>
          <td valign="top" align="center" colspan="2">
            <div class="foot_button">
            <input type="button" value="<fmt:message key='button_submit'/>" class="foot_icon_1" onclick="subAudit(${type });">
            </div>
          </td>
          <td valign="top" align="left"></td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
<script type="text/javascript" language="javascript">
if (${msg != null } && ${msg != "" }) {
    alert('${msg}');
}
_$(document).ready(function(){

});
    //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2;
        var t = (screen.height - h) / 2;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
       
        //window.showModalDialog('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', "dialogWidth=600px; dialogHeight=400px");
    }
</script>
