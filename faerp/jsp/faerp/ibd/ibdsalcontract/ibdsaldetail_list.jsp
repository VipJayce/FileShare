<%@ page contentType="text/html; charset=UTF-8" %>

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
String  create_type_bd=(String)request.getParameter("create_type_bd"); 
if(null==create_type_bd||"".equals(create_type_bd)||create_type_bd=="null"){
    create_type_bd=(String)request.getAttribute("create_type_bd");
}
String  contract_type_bd=(String)request.getParameter("contract_type_bd");
String contract_template_id= (String)request.getParameter("contract_template_id")  ;
AttachmentfileVo avo=null;
if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
    avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
}
%>

<script src="<%=request.getContextPath()%>/dwr/interface/TreeAjax.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
       form_treebasic.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=queryAll_tolistIbdsal";
       form_treebasic.submit();
    }
    //详细页面关闭
   function  cancel_onClick1(){
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
 <div class="ringht_x" style="height: 125px;">
<div id="ccChild1"     class="box_xinzeng" style="height: 125px;"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同类型</td>
            <td class="td_2"  nowrap="nowrap">
                <input type="text" class="text_field" inputName="合同类型" value="${contract_type_name}" maxLength="50" validate="notNull;"   readonly="readonly"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>合同名称</td>
            <td class="td_2 " nowrap="nowrap">  
              <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="${bean.contract_name }" maxLength="50" validate="notNull;"   readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同甲方</td>
            <td class="td_2 " nowrap="nowrap">
                <input type="text" class="text_field"  inputName="合同甲方" value="${bean.cust_a_name }" maxLength="50" validate="notNull;"   readonly="readonly"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>合同乙方</td>
            <td class="td_2 " nowrap="nowrap">
                <input type="text" class="text_field"  inputName="合同乙方" value="${bean.agent_b_name }" maxLength="50" validate="notNull;"   readonly="readonly"/>             
            </td>
        </tr>
        
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同起始日期</td>
            <td class="td_2" nowrap="nowrap">
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" readOnly="true" width="189px"/>
            </td>
           <td class="td_1" ><%if(contract_type_bd!=null&&!contract_type_bd.trim().equals("1")){%><span class="style_required_red">* </span><%} %>合同终止日期</td>
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
                <input type="hidden"  id="contract_template_id"  class="text_field" name="contract_template_id"  value="<%=contract_template_id %>" >
                 <faerp:contractTemplateSelectTag  beanname="contract_template_id"   strproperty=" disabled='disabled'  "  style="width:205px"/>
            </td>
           <% 
          }else{
        %>
                 <td class="td_1" ><span class="style_required_red">* </span>合同附件</td>
            <td class="td_2 "    >
               <% if(avo!=null)out.print("<a href='"+request.getContextPath()+"/ProductAction.do?cmd=downLoad&attachment_id="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");%>
            </td>
            <td class="td_1" ></td>
            <td  class="td_2 " ></td>
         <%}%>
        </tr>
    </table>
  </div>
 </div>
    <!-- 服务项  begin-->
    <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">产品配置</div>
    <div class="button_right" style="padding-left: 10px">
</div>    
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell1"
        queryAction="/FAERP/Finout_contract_productAction.do?cmd=getProductListData_1&id=${param.id}"
        width="98%" height="198px" xpath="Finout_contract_productVo" submitXpath="Finout_contract_productVo" 
         paramFormId="form_treebasic" readonly="false" pageSize="-1">
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
        <r:field fieldName="is_sales_tax" label="是否可收营业税" width="130px" allowModify="true" >
         <d:select dictTypeId="TrueOrFalse" disabled="true"/>
        </r:field>
        <r:field fieldName="sales_tax" label="营业税比例" width="130px" >
        </r:field>
    </r:datacell>
     <!-- 服务项  end-->
 <div class="mx_button" align="center">
         <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick1()"/>
</div>
</form>

<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</div>
</div>
</body>
</fmt:bundle>
</html>

