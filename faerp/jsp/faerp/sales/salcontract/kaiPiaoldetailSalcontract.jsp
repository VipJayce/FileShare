<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>

<html>
<fmt:bundle basename="rayoo.salse.salcontract.salcontract_resource" prefix="rayoo.salse.salcontract.">

<head>
<script language="javascript">
    var dir_base = "/FAERP";
</script>

<link href="/FAERP/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/common/variable-i18n_zh.js'></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/common/gap-mainframe.js"></script>


<link href="<%=request.getContextPath()%>/css/alex-css.jsp" type="text/css" rel="stylesheet">
<!-- liuping add -->
<link href="<%=request.getContextPath()%>/css/common.css" type="text/css" rel="stylesheet">

<link href="<%=request.getContextPath()%>/css/index.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/tabs.css.jsp" rel="stylesheet" type="text/css">
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>


<script language="javascript" src="/FAERP/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key="not_title_word"/></title>
 <script  language="javascript">
 <% String  create_type_bd =(String)request.getParameter("create_type_bd") ;
       String  contract_type_bd =(String)request.getParameter("contract_type_bd") ;
       String  contract_template_id =(String)request.getParameter("contract_template_id") ;
      //判断是否为修改页面
    String id="";
    String  contract_name="";
    String  contract_start_date="";
    String contract_stop_date="";
    String  customer_name="";
    String agent_b_name="";
    String agent_b_id="";
    String cust_a_id="";
    String customer_code="";
    String detail=(String)request.getAttribute("detail");
    if(null==detail){
        detail=(String)request.getParameter("detail");
    }
    String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();
    SalcontractVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ISalcontractConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (SalcontractVo)request.getAttribute(ISalcontractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
            id=resultVo.getId();
            request.setAttribute("bean",resultVo);
            create_type_bd=resultVo.getCreate_type_bd();
            contract_type_bd=resultVo.getContract_type_bd();
            contract_template_id=resultVo.getContract_template_id();
            contract_name=resultVo.getContract_name();
            contract_start_date=String.valueOf(resultVo.getContract_start_date());
            contract_stop_date=String.valueOf(resultVo.getContract_stop_date());
            customer_name=String.valueOf(resultVo.getCustomer_name());
            agent_b_name=resultVo.getAgent_b_name();
            agent_b_id=resultVo.getAgent_b_id();
            cust_a_id=resultVo.getCust_a_id();
            customer_code=resultVo.getCustomer_name();
            
        }
    }
 %>
    var tabs;
     function updateData() { //定义修改状态时显示的标签页
    // alert('定义标标签信息');
        tabs  =  new Array(
            new Array ("<fmt:message key="contract_basic_info"/>","<%=request.getContextPath()%>/jsp/faerp/sales/salcontract/insertSalcontract.jsp?create_type_bd="+"<%=create_type_bd%>"+"&contract_type_bd="+"<%=contract_type_bd%>"+"&contract_template_id="+"<%=contract_template_id%>"+"&id="+"<%=id%>"+"&contract_name="+"<%=contract_name%>"+"&contract_start_date="+"<%=contract_start_date%>"+"&contract_stop_date="+"<%=contract_stop_date%>"+"&customer_name="+"<%=customer_name%>"+"&agent_b_name="+"<%=agent_b_name%>"+"&agent_b_id="+"<%=agent_b_id%>"+"&cust_a_id="+"<%=cust_a_id%>"+"&customer_code="+"<%=customer_code%>"+"&detail="+"<%=detail%>"),
            new Array ("<fmt:message key="recode_info"/>","<%=request.getContextPath()%>/jsp/faerp/sales/salcontract/treeSalcontract.jsp?contract_template_id="+"<%=contract_template_id%>"+"&ids="+"<%=id%>")
        );
        
  //alert(tabs);
    }
 updateData(); 
 
 	//返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){        
        var message =addAppReason("<%=request.getContextPath()%>");
        if(message==null)return;
   ///     alert('审批操作'+message);
      //  form.action="<venus:base/>/kaiPiaolWorkFlowAction.do?cmd=appOperate&message="+message[0]+"&taskuid=<%=taskuid%>";
      
      form.action="<venus:base/>/kaiPiaolWorkFlowAction.do?message="+message[0];
           document.getElementById("cmd").value="appOperate";
      
        form.submit();
        
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/kaiPiaolWorkFlowAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
        
    }
 </script>
 
 <script src="<%=request.getContextPath()%>/js/template/tabs.js"></script>

</head>
<body>
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="distribution_agent_approval_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form action="" name="form" id="form">
 <input  type="hidden"  value="" name="cmd" id="cmd"  >
 <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >
 
<table class="table_noFrame" >
	<tr>
		 <td >
        <input name="button_back" class="button_ellipse" type="button" value="<fmt:message key="go_back"/>"  onclick="javascript:backTask_onClick();" >
        <input name="button_app" class="button_ellipse" type="button" value="<fmt:message key="agree"/>"  onclick="javascript:appOperate_onClick();" >
        <input name="button_back" class="button_ellipse" type="button" value="<fmt:message key="reject"/>"  onclick="javascript:backOperate_onClick();" >
        </td>
	</tr>
</table>
</form>
    <table class="table_div_content" style="width:100%">
        <tr>
            <td>
                <table width="100%">
                  <tr>
                    <td>
                    <div id="tabsDiv"></div>
                    </td>
                </tr>
                </table>
            </td>
        </tr>
    </table>
</div>  

 
<script type="text/javascript">

writeTabs(400);
</script>
</body>
</fmt:bundle>
</html>

