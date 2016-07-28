<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@page import="rayoo.finance.received.fininvoice.vo.FininvoiceVo"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html xmlns="http://www.w3.org/1999/xhtml">

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	function insert_onClick(){  //插入单条数据
	   if(checkAllForms()){
           form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=insert";
           form.submit();
           return true ;
		}
	}
  	function submit_onClick(){  //保存修改后的单条数据
  	var type_bd2=jQuery('input:radio[name="type_bd2"]:checked').val(); 
	  	if(type_bd2=="1"){
	  	        if(checkAllForms()){
		            form.action="<%=request.getContextPath()%>/payWorkFlowAction.do?cmd=backOperate";
		            form.submit();
		        }
	  	}else{
	  	         if(checkAllForms()){
                    form.action="<%=request.getContextPath()%>/payWorkFlowAction.do?cmd=appOperate";
                    form.submit();
                }
	  	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=toListPage";
        form.submit();
    }
    
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){
      var message =addAppReason("<%=request.getContextPath()%>");
      //alert('message='+message);
      if(message==null)return;
        //alert('操作成功！');
        form.action="<venus:base/>/FininvoiceAction.do?message="+message[0] +"&flag=1" ;
        document.getElementById("cmd").value="appOperate";
        form.submit();
         
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/FininvoiceAction.do?message="+message[0] +"&flag=0" ;
        document.getElementById("cmd").value="appOperate";
        form.submit();
    }
    
         //查看明细
     function viewbillingdetails() {
           if($id("billid").value==""){
                alert("请选择一条发票记录！");
                return;
           }
           var url="<%=request.getContextPath()%>/FinverificationAction.do?cmd=getCustomer&billid="+$id("billid").value+"&cost_center_ids="+$id("costcenterid").value;
           url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
           showModalCenter(url, window, "", 800, 460, "查看明细");  //增加子岗位
      }
    
    
</script>
</head>
<body>
<form name="form" id="datacell_formid" method="post">
 <input type="hidden" id="taskuid" name="taskuid" value="${taskuid}">
<div id="right">
	<div class="ringht_s">
	<div id="ccChild1" class="box_xinzeng" style="height:100px; ">
	<table width="100%" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">客户编号</td>
			<td class="td_2">${bean.cust_code}</td>
				   
				    <input type="hidden" name="cmd">
                    
			<td class="td_1">客户名称</td>
			<td class="td_2">${bean.cust_name}</td>
			<td class="td_1">成本中心名称</td>
			<td class="td_2">${bean.cost_center_name}</td>
		</tr>
		<tr>
              <td class="td_1">开票状态</td>
            <td class="td_2"><d:select dictTypeId="INVOICE_STATUS_BD" value="${bean.type_bd}" disabled="true"></d:select></td>
            <td class="td_1">发票金额</td>
            <td class="td_2">${bean.invoice_amount}</td>
            <td class="td_1">申请说明</td>
            <td colspan="5" class="td_2">${reason}</td>
        </tr>
        <tr>
            <td colspan="6" class="td_2">
            
            
            </td>
        </tr>
	</table>
	
	
	
	</div>
	
	
	
                <w:panel id="panel2" title="发票明细">
         <div  id="div1" style="margin:10px 0px 0px 10px;">
                            <r:datacell 
                            queryAction="/FAERP/FininvoiceAction.do?cmd=queryItemForDatacell&invoicei_id=${bean.id}"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="255px" 
                            xpath="FininvoiceItemVo"
                            readonly="true"
                            >
                          <r:field fieldName="fin_small_subjects_bd" label="开票项目" width="300px">
                            <d:select dictTypeId="FIN_SUBJECTS_BD" />
                          </r:field>
                          <r:field fieldName="amount" label="金额" width="300px">
                            <h:text />
                          </r:field>
                        </r:datacell>
            </div>
            </w:panel>
            
            
            
            
            
            
            
	
      <div class="foot_button">
        <input name="button_back" class="foot_icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <%
        if(request.getAttribute("isLook")==null||(request.getAttribute("isLook")!=null&&request.getAttribute("isLook").equals("false"))){
        %>
        <input name="button_app" class="foot_icon_2" type="button" value="审批同意"  onclick="javascript:appOperate_onClick();" >
        <input name="button_back" class="foot_icon_2" type="button" value="驳回"  onclick="javascript:backOperate_onClick();" >
        <%} %>
      </div>

</div>
</div>
	</form>
</fmt:bundle>
</body>
</html>

