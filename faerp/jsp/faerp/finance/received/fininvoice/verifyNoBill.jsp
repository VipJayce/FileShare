<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _$ = window.jQuery;
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/editbatch.js"></script>
<script language="javascript">
    //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        var isLook = _$("#isLook").val();
        if(isLook !="" && isLook != null ){
             form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true";
        }else{
            form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        }
        form.submit();
    }
    
    //审批操作
    function operate_onClick(opState){
         //任务id
        var taskuid = _$("#taskuid").val();
        //发票
        var fin_invoice_id = _$("#fin_invoice_id").val();
        var info ;
        //驳回原因
        var message;
        if(opState == 0){
           info = "您确认驳回该发票申请吗？";
           message = encodeURI(addBackReason("<%=request.getContextPath()%>")[0]);
        }else if(opState ==1){
           info = "您确认审核通过该发票申请吗？"
        }
        if(confirm(info)){
              _$.ajax({
                   type: "POST",
                   url: venusbase + "/FininvoiceAction.do?cmd=verifyNoBill&taskuid="+ taskuid+"&fin_invoice_id="+fin_invoice_id+"&opState="+opState+"&message="+message,
                   data:"",
                   dataType: "html",
                   success: function(msg){
                         alert(msg);
                         _$("#isLook").val("true");
                         backTask_onClick();
                   }
           });
        }
    }
    //账单申请的发票附件下载
	function downloadAttachment(){
	   var fin_invoice_id = _$("#fin_invoice_id").val();
       form.action="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=downloadAttachment&fin_invoice_id="+fin_invoice_id;
       form.submit();
       form.action="";
	}
    
</script>
</head>
<body> 
<form name="form" method="post">
  <input  type="hidden"  value="${taskuid}" name="taskuid" id="taskuid"  >
  <input  type="hidden"  value="${fininvoiceVo.id}" name="fin_invoice_id" id="fin_invoice_id"  >
  <input  type="hidden"  value="${isLook}" name="isLook" id="isLook"  >
 
    <table class="table_noFrame" >
        <tr>
             <td >
            <input name="button_back" class="button_ellipse" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
           <%
            if(request.getAttribute("isLook")==null||(request.getAttribute("isLook")!=null&&request.getAttribute("isLook").equals("false"))){
            %>
            <input name="button_app" class="button_ellipse" type="button" value="同意"  onclick="javascript:operate_onClick(1);" >
            <input name="button_back" class="button_ellipse" type="button" value="驳回"  onclick="javascript:operate_onClick(0);" >
         <%} %>
            <input name="button_download" class="button_ellipse" type="button" value="附件下载"  onclick="javascript:downloadAttachment();" >
            </td>
        </tr>
    </table>
    <div id="right" class="box_3">
     <div class="right_title_bg">
        <div class=" right_title">发票详情</div>
     </div>
     <table  width="54%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >申请人</td>
            <td class="td_2 " nowrap="nowrap">
                   ${proposer}
            </td>
            <td class="td_1" >所属部门</td>
            <td class="td_2 " nowrap="nowrap">
                   ${dept_name}
            </td>
        </tr>
        <tr>
            <td class="td_1" >发票抬头</td>
            <td class="td_2 " nowrap="nowrap">
               ${fininvoiceVo.receipt_title}
            </td>
            <td class="td_1" >开票金额</td>
            <td class="td_2"  nowrap="nowrap">
                ${fininvoiceVo.invoice_amount}
            </td>
        </tr>
        <tr>
            <td class="td_1" >申请原因</td>
            <td class="td_2 " nowrap="nowrap" style="height:60px;width:540px;overflow: visible" colspan="3">
               ${fininvoiceVo.apply_reason}
            </td>
        </tr>
     </table>
     
     <div  id="div1">
                        <r:datacell 
                        queryAction="/FAERP/FininvoiceAction.do?cmd=queryItemForDatacell&invoicei_id=${fininvoiceVo.id}"
                        id="celllist1"
                        paramFormId="datacell_formid" 
                        width="54%" height="255px" 
                        xpath="FininvoiceItemVo"
                        readonly="true"
                        >
                      <r:field fieldName="fin_small_subjects_name" label="开票项目" width="300px">
                      </r:field>
                      <r:field fieldName="amount" label="金额" width="300px">
                        <h:text />
                      </r:field>
                    </r:datacell>
        </div>
</div>
</form>
</fmt:bundle>
</body>
</html>
