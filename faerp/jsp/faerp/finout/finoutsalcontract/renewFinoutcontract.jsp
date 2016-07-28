<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>

<%@include file="/common/common.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>

<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<script type="text/javascript">
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    /******************************  审批相关操作****************************************/
  function updatecontractdate() { //返回到列表页面
        var id=document.getElementById("contract_id").value;
        var contractstop_olddate=document.getElementById("contract_stop_date1").value;
        var contractstop_newdate=document.getElementById("contract_stop_date").value;
        var action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=update_finoutstopdate";
        if(contractstop_newdate>contractstop_olddate){
                 var myAjax = new Ajax(action);
                 myAjax.addParam('contract_stop_date', contractstop_newdate);
                 myAjax.addParam('id', id);
                 myAjax.submit();
                 var returnNode = myAjax.getResponseXMLDom();
                 if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      window.opener.showListData();//回调父页面函数
                      window.close();
                 }
                } else{
                 alert("请选择正确的合同终止时间!");
                 return;
                 }
    
    }

  function  go_back(){
   window.close();
   }
</script>
</head>
<body >
<div id="right">
<form name="form_treebasic" id="form_treebasic" method="post"  >
<script type="text/javascript">
writeTableTopFesco('合同信息','<%=request.getContextPath()%>/');
</script>
<input type="hidden" id="contract_id" name="contract_id" value="${bean.id }"/>
<input type="hidden" id="contract_stop_date1" name="contract_stop_date1" value="${bean.contract_stop_date }"/>
 <div class="ringht_x" style="height: 125px;">
<div id="ccChild1"     class="box_xinzeng" style="height: 125px;"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" > </span>合同名称</td>
            <td class="td_2 " nowrap="nowrap">  
              <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="${bean.contract_name }" maxLength="50" disabled="disabled"/>
            </td>
             <td class="td_1" ><span class="style_required_red">* </span>合同终止日期</td>
            <td class="td_2"  nowrap="nowrap">
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px" />
            </td>
        </tr>
        </table>
<table class="table_noFrame"  align="center">
    <tr>
         <td >
          <input name="button_back" class="icon_2" type="button" value="合同续签"  onclick="javascript:updatecontractdate();" >
        <input name="button_back" class="icon_2" type="button" value="返回"  onclick="javascript:go_back();" >
        </td>
    </tr>
</table>

</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</div>
</div>
</body>
</fmt:bundle>
</html>



