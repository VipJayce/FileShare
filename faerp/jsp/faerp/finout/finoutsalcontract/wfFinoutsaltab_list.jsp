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

<% 
 String taskuid=request.getAttribute("taskuid").toString();

String  create_type_bd=(String)request.getParameter("create_type_bd"); 
		if(null==create_type_bd||"".equals(create_type_bd)||create_type_bd=="null"){
		    create_type_bd=(String)request.getAttribute("create_type_bd");
		}
String contract_template_id= (String)request.getParameter("contract_template_id")  ;
String ids= (String)request.getParameter("ids")  ;
String detail=(String)request.getAttribute("detail");
if(null==detail){
    detail=(String)request.getParameter("detail");
}
String  contract_type_bd=(String)request.getParameter("contract_type_bd");
String  id=(String)request.getParameter("id");
if(id==null||id.equals("")){
    id=request.getAttribute("id").toString();
}
System.out.println(id+"@@@@@@@@@");
String  contract_name=(String)request.getParameter("contract_name");
//System.out.println(contract_type_bd+"aaa");
String  contract_start_date=(String)request.getParameter("contract_start_date");
String  contract_stop_date=String.valueOf(request.getParameter("contract_stop_date"));

String customer_name=(String)request.getParameter("customer_name");
String agent_b_name=(String)request.getParameter("agent_b_name");
if(agent_b_name!=null&&agent_b_name.equals("null")){
    agent_b_name="";
}
String agent_b_id=(String)request.getParameter("agent_b_id");
String cust_a_id=(String)request.getParameter("cust_a_id");
String customer_code=(String)request.getParameter("customer_code");
    SalcontractVo resultVo = null;  //定义一个临时的vo变量
     AttachmentfileVo avo=null;//附件VO
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
  //  if( id != null && !"".equals(id)) {  //如果从request获得参数"isModify"不为空
      if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute("bean") != null) {  //如果request中取出的bean不为空
            resultVo = (SalcontractVo)request.getAttribute(ISalcontractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
          contract_name=resultVo.getContract_name();
        contract_start_date=String.valueOf(resultVo.getContract_start_date());
        contract_stop_date=String.valueOf(resultVo.getContract_stop_date());
        if(null!=contract_start_date&&!"".equals(contract_start_date)&&contract_start_date!="null"){
            contract_start_date=contract_start_date.substring(0,10);
        }else{
            contract_start_date="";
        }
        if(null!=contract_stop_date&&!"".equals(contract_stop_date)&&contract_stop_date!="null"){
            contract_stop_date=contract_stop_date.substring(0,10);
        }else{
            contract_stop_date="";
        }
        id=resultVo.getId();
        ids=resultVo.getId();
      String  service_company=resultVo.getService_company();
        customer_name=resultVo.getCustomer_name().trim();
        agent_b_name=resultVo.getAgent_b_name();
        agent_b_id=resultVo.getAgent_b_id();
        cust_a_id=resultVo.getCust_a_id();
        customer_code=resultVo.getCustomer_code();
        contract_type_bd=resultVo.getContract_type_bd();
        create_type_bd=resultVo.getCreate_type_bd();
        contract_template_id=resultVo.getContract_template_id();
        if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
            avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
        }
        }
    }
    
     String attachName = avo==null?"":avo.getAttachment_file_name().toString();
     String attachAddress = avo==null?"":avo.getAttachment_file_path().toString();
    
%>
<script src="<%=request.getContextPath()%>/dwr/interface/TreeAjax.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>
<script type="text/javascript">
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
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
    }
    /******************************  审批相关操作****************************************/
     function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){        
        var message =addAppReason("<%=request.getContextPath()%>");
        if(message==null)return;
      form.action="<venus:base/>/Finout_contract_productAction.do?message="+message[0]+"&_ts="+(new Date()).getTime();
           document.getElementById("cmd").value="appOperate";
      
        form.submit();
        
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        var url="/FAERP/Finout_contract_productAction.do?date=" + new Date();
        form.action=url;
        document.getElementById("info_msg").value=message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
        
    }
    
    //撤销操作
        function cancelOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/Finout_contract_productAction.do?message="+message[0];
        document.getElementById("cmd").value="cancelOperate";
        form.submit();
    }
    
</script>
</head>
<body >
<div id="right">
<form name="form_treebasic" id="form_treebasic" method="post"  >
<script type="text/javascript">
writeTableTopFesco('合同信息','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_x" style="height: 125px;">
<div id="ccChild1"     class="box_xinzeng" style="height: 125px;"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同类型</td>
            <td class="td_2"  nowrap="nowrap">
             <input type="hidden" class="text_field" name="contract_type_bd"  id  =  "contract_type_bd"   value="<%=contract_type_bd %>" >
                   <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_type_bd", -1,"CONTRACT_TYPE_BD",contract_type_bd," id=contract_type_bd  disabled='disabled'  ",false) %> 
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>合同名称</td>
            <td class="td_2 " nowrap="nowrap">  
              <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>" maxLength="50" validate="notNull;"   readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同甲方</td>
            <td class="td_2 " nowrap="nowrap">
                <w:lookup onReturnFunc="rtnFunc" displayValue="<%=customer_name %>" lookupWidth="189px"  readOnly="true" readonly="false" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择合同甲方" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
                <input type="hidden" name="customer_code" id="customer_code"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>合同乙方</td>
            <td class="td_2 " nowrap="nowrap">                
               <%  if(null!=detail&&!"detail".equals(detail)) {%>
                <w:lookup onReturnFunc="rtnFunc1" lookupWidth="189px" displayValue="<%=agent_b_name %>" readonly="false" id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" dialogTitle="选择合同乙方" height="430" width="680"/>
                <input type="hidden" name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>" />
                <input type="hidden" name="agent_b_name" id="agent_b_name" value="<%=agent_b_name %>"/>
                <%}else{ %>
                <w:lookup onReturnFunc="rtnFunc1" displayValue="<%=agent_b_name %>" lookupWidth="189px"  readOnly="true" id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" dialogTitle="选择合同乙方" height="430" width="680"/>
                <input type="hidden" name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>"/>
                <input type="hidden" name="agent_b_name" id="agent_b_name"  value="<%=agent_b_name %>"/>
                <%} %>
            </td>
        </tr>
        
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同起始日期</td>
            <td class="td_2" nowrap="nowrap">
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" readOnly="true" width="189px"/>
            </td>
           <td class="td_1" ><span class="style_required_red">* </span>合同终止日期</td>
            <td class="td_2"  nowrap="nowrap">
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px" readOnly="true"/>
            </td>
        </tr>
                <input type="hidden" class="text_field"   id="create_type_bd"  name="create_type_bd" inputName="合同生成方式" value="<%= create_type_bd%>" maxLength="64" validate="notNull;"/>
        <tr>
        <% 
          if("1".equals(create_type_bd)){
           %>
              <td class="td_1" >合同模板</td>
            <td class="td_2 "    colspan="3">
            <% 
            request.setAttribute("contract_template_id",contract_template_id);
            %>
                <input type="hidden"  id="contract_template_id"  class="text_field" name="contract_template_id"  value="<%=contract_template_id %>" >
                 <faerp:contractTemplateSelectTag  beanname="contract_template_id"   strproperty=" disabled='disabled'  "  style="width:205px"/>
            </td>
           <% 
          }else{
        %>
                 <td class="td_1" ><span class="style_required_red">* </span>合同附件</td>
            <td class="td_2 "    >
               <% if(isModify&&avo!=null)out.print("<a href='"+request.getContextPath()+"/ProductAction.do?cmd=downLoad&attachment_id="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");
               {%>
            </td>
            <td class="td_1" ></td>
            <td  class="td_2 " ></td>
        <%}%>
         <%}%>
        </tr>
    </table>
  </div>
 </div>
       <% 
          if("1".equals(create_type_bd)){
           %>
    <!-- 服务项  begin-->
    <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">产品配置</div>
    <div class="button_right" style="padding-left: 10px">
</div>    
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell1"
        queryAction="/FAERP/Finout_contract_productAction.do?cmd=getProductListData_1&id=${id}"
        width="98%" height="198px" xpath="Finout_contract_productVo" submitXpath="Finout_contract_productVo" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="product_id" label="产品id" width="0px" allowModify="false" >
        </r:field>
         <r:field fieldName="product_name" label="服务项名称" width="150px" allowModify="false" >
        </r:field>
            <r:field fieldName="o_remark" label="备注" width="150px" allowModify="true" >
            <h:text/>
        </r:field>
        <r:field fieldName="product_price" label="价格" width="70px" allowModify="true" >
        <h:text/>
        </r:field>
           <r:field fieldName="charging_frequency" label="频率" width="70px" >
           <d:select dictTypeId="FINOUT_PRODUCT_TYPE" disabled="true"/>
        </r:field>
        <r:field fieldName="small_type_id" label="类型" width="130px">
         <d:select dictTypeId="big_type_id" disabled="true"/>
        </r:field>
        <r:field fieldName="is_sales_tax" label="是否可收增值税" width="130px" allowModify="true" >
         <d:select dictTypeId="FINOUT_IS_SALES_TAX"/>
        </r:field>
        <r:field fieldName="business_type_bd" label="业务类型" width="130px" allowModify="true" >
         <d:select dictTypeId="FINOUT_TYPE_BD" nullLabel=""/>
        </r:field>
          <!-- 2016-06-30  by zhouxiaolong   增加开票类型的显示    Begin -->
         <r:field fieldName="invoice_type" label="开票类型" width="100px" allowModify="true" >
         <d:select dictTypeId="SERVICE_TYPE" nullLabel="请选择"  extAttr="allowNull=false;"/>
        </r:field>
        <!-- 2016-06-30  by zhouxiaolong   增加开票类型的显示    End -->
        <%-- 
        <r:field fieldName="sales_tax" label="营业税比例" width="130px" >
        <h:text validateAttr="type=formatStr;regExpr=^\d+.{0,1}\d+$;message=营业税比例输入错误;"/>
        </r:field>
         --%>
    </r:datacell>
     <!-- 服务项  end-->
    <%} %>
   
</form>

 <form action="" name="form" id="form">
 <input  type="hidden"  value="" name="cmd" id="cmd"  >
<input  type="hidden"  value="" name="info_msg" id="info_msg"  >
 <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >
 
<table class="table_noFrame"  align="center">
    <tr>
         <td >
        <input name="button_back" class="icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <input name="button_app" class="icon_2" type="button" value="同意"  onclick="javascript:appOperate_onClick();" >
        <input name="button_back" class="icon_2" type="button" value="驳回"  onclick="javascript:backOperate_onClick();" >
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

<script language="javascript">
        //选择合同甲方
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);       
    jQuery("#cust_a_name").val(arg[2]);     
    jQuery("#customer_code").val(arg[1]);   
    return false;
}
        //选择合同乙方
function rtnFunc1(arg){
    var lookup = $id("lk_cust1");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    jQuery("#agent_b_id").val(arg[0]);    
    jQuery("#agent_b_name").val(arg[1]);    
    return false;
}

</script>



