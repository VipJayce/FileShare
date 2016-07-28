<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salaryPayAudit.salaryPayAudit_resource" prefix="rayoo.salary.salaryPayAudit.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='title_bh'/></title>

</head>
<script type="text/javascript">
jQuery(function(_$){
    _$("#btn_reject").click(function(){
        batchId = _$("#h_batchId").val();
        cause = _$("#t_rejectCause").val();//驳回备注
      
        var reject_reason = _$("#reject_reason").val();//驳回原因  数据字典里的1 2
        var reject_number = _$("#reject_number").val();//驳回人数
        var reject_reason_text = _$("#reject_reason").find("option:selected").text();//select的中文值
        
        if(reject_number==null || reject_number==""){
            alert("请输入驳回人数");
            _$("#reject_number").focus();
            return;
        }
        
        if(isNaN(reject_number)){
            alert("请正确输入驳回人数");
            _$("#reject_number").focus();
             return;
        }
        
        if(reject_reason==null || reject_reason==""){
            alert("请选择驳回原因");
            return;
        }
        cause = encodeURI(cause);
        reject_reason_text = encodeURI(reject_reason_text);
        param = "&batchId="+batchId+"&cause="+cause+"&cs_id="+_$("#h_cs_id").val()+"&cust_id="
        								+_$("#h_cust_id").val()+"&batchCode="+_$("#h_batchCode").val()+"&reject_reason="+reject_reason+"&reject_number="+reject_number
        								+"&reject_reason_text="+reject_reason_text;
        _$.post("<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=rejectAudit"+param,function(data){
            if(data > 0){
                alert("<fmt:message key='alert_bh_complete'/>");
                window.close();
            }
        });
    });
});
</script>
<body>
<form id="rejectForm" action="" method="post">
<input type="hidden" name="cmd" value="rejectAudit"/> 
<div class="box_xinzeng" style="margin:0px;">
  <div></div>
  <div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
        <input type="hidden" id="h_batchId" name="batchId" value='<b:write property="batchId" />'/>
        <input type="hidden" id="h_cs_id" name="cs_id" value='<b:write property="cs_id" />'/>
        <input type="hidden" id="h_batchCode" name="batchCode" value='<b:write property="batchCode" />'/>
        <input type="hidden" id="h_cust_id" name="cust_id" value='<b:write property="cust_id" />'/>
      <tr>
        <td class="td_1"><fmt:message key='sa_batch_code'/></td>
        <td class="td_2"><b:write property="batchCode" /></td>
        </tr>
      <tr>
        <td class="td_1"><fmt:message key='submit_user'/></td>
        <td class="td_2"><b:write property="cs" /></td>
        </tr>
      <tr>
        <td class="td_1"><fmt:message key='customer_code'/></td>
        <td class="td_2"><b:write property="cust_cd" /></td>
        </tr>
      <tr>
        <td class="td_1"><fmt:message key='customer_name'/></td>
        <td class="td_2"><b:write property="cust_nm" /></td>
      </tr>
      <tr>
        <td class="td_1" style="width:18%"><span class="style_required_red">* </span>驳回人数</td>
        <td class="td_2"><input name="reject_number" class="sText" id="reject_number"/></td>
      </tr>
      <tr>
        <td class="td_1" style="width:18%"><span class="style_required_red">* </span>驳回原因</td>
        <td class="td_2">
            <d:select name= "reject_reason" id="reject_reason" dictTypeId= "REJECT_REASON" nullLabel="-----请选择-----" >
            </d:select >
        </td>
      </tr>
      <tr>
        <td class="td_1">驳回备注</td>
        <td class="td_2"><textarea id="t_rejectCause" name="rejectCause" rows="3" class="xText_d"></textarea></td>
      </tr>
  </table>
    <div class="foot_button">
      <input id="btn_reject" type="button" class="foot_icon_1" value="<fmt:message key='button_submit'/>"/>
    </div>
  </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
