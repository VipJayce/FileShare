<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="gap.rm.tools.helper.*"%>
<%@ page
    import="rayoo.finance.adjustarrearage.finbilladjust.vo.FinbilladjustVo"%>
<%@ page
    import="rayoo.finance.adjustarrearage.finbilladjust.util.IFinbilladjustConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@page
    import="rayoo.finance.adjustarrearage.finbilladjust.action.FinbilladjustAction"%>
<html>
<body>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<form  name="form" method="post" >
<script type="text/javascript">
function adjust_onClick(){
var check=/^[0-9]+(.[0-9]{2})?$/;
var  amount=document.getElementById("adjustamount").value;
var adjustdesc = document.getElementById("adjustdesc").value;
var id =document.getElementById("id").value;
if(amount ==null || amount==''){
     alert("请填写调整金额!");
     return;
 }
 if(!check.test(amount)){
alert("欠款金额格式为9999.99!");
return;
}
WfCommonAjax.checkAdjustArrearage(id,function(status){
        //未审批，可提交修改
        if(status=='0'||status=='2'){
          $.getJSON("<venus:base/>/FinbilladjustAction.do?cmd=update&date="+new Date()+"",{"id":id,"adjustamount":amount,"adjustdesc":adjustdesc},   function(json){
              if(json.saia!=null&&json.saia=="成功")
                {
                window.close();
                 }
                    });
              }
              else if(status=='1'){
                 alert("该报价单正走审批流程,不能修改!");
                  return;
            }else if(status=='3'){
                  alert("该报价单已生效,不能再修改!");
                  return;
            }   
});
}
</script>

<%
    String id = "";
    id = request.getParameter("cid");
    FinbilladjustAction finaction = new FinbilladjustAction();
    FinbilladjustVo finvo = finaction.getBs().find(id);
    request.setAttribute("vo", finvo);
%>
<div class="box_xinzeng">
<table width="100%" border="0" cellspacing="1" cellpadding="0"
    bgcolor="#c5dbe2">
    <input type="hidden" name="id" id="id" value="${vo.id }">
    <tr>
        <td class="td_1">调整金额</td>
        <td class="td_2"><input type="text" value="${vo.adjust_amout }"
            name="adjustamount" class="sText" id="adjustamount" onblur="check()"/></td>
    </tr>
    <tr>
        <td class="td_1">调整备注</td>
        <td class="td_2"><textarea name="adjustdesc" rows="3"
            class="xText_d" id="adjustdesc">${vo.adjust_desc}</textarea></td>
    </tr>
</table>
<div class="xz_button">
     <input type="button" class="icon_2" value='提交' onClick="javascript:adjust_onClick();" />
     <input name="button"  type="button" class="icon_2" value="取消" onclick="window.close()" /></div>
</div>
</form>
</body>
</html>