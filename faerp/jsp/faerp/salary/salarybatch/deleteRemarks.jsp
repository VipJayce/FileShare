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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<script type="text/javascript">
jQuery(function(_$){
    _$("#btn_delete").click(function(){
        var remarks = _$("#delete_remarks").val();//删除原因
        var batchId =  _$("#batchId").val();//批次id
        
        if(remarks==null || remarks==""){
            alert("请输入删除原因");
            _$("#delete_remarks").focus();
            return;
        }
        var arr = new Array();
        arr[0] = batchId;
        arr[1] = remarks;
        window['returnValue'] =  arr;
        window.close();
    });
});
</script>
<body>
<div class="box_xinzeng" style="margin:0px;height:200px;" >
  <div></div>
  <input type="hidden" id="batchId" value="${batchId}">
  <div style="margin-top:20px;">
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
      <tr>
        <td class="td_1" style="width: 20%;"><span class="style_required_red">* </span>删除原因</td>
        <td class="td_2"><textarea id="delete_remarks" name="delete_remarks" rows="2" class="xText_d" style="width:300px;height:100px;"></textarea></td>
      </tr>
  </table>
    <div class="foot_button" style="margin-top:10px;">
      <input id="btn_delete" type="button" class="foot_icon_1" value="提交"/>
    </div>
  </div>
</div>
</body>
</html>
