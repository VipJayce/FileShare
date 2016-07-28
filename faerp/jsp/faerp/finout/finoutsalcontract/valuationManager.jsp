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
String business_type_bd=request.getParameter("business_type_bd");
System.out.print("@@@@@@@@@@@@@@@@@@"+business_type_bd);
String  contract_type_bd=(String)request.getParameter("contract_type_bd");
String  id=(String)request.getParameter("id");

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
function insert_onClick(gapwf){  //插入单条数据
 var contract_start_date=document.form_treebasic.contract_start_date.value.trim();;
 var contract_stop_date=document.form_treebasic.contract_stop_date.value.trim();;
                 if(document.form_treebasic.create_type_bd.value=='1' || document.form_treebasic.create_type_bd.value==1){
                 }else{
                    var attach_name=document.form_treebasic.attach_name.value.trim();
                         if(attach_name==""&&attach_name.length==0){
                            alert("合同附件不能为空！");
                            return;
                         }
                 }
      if(document.getElementById("cust_a_id").value==null || document.getElementById("cust_a_id").value==""){
        alert("合同甲方不能为空！");
        return;
      }
 
     if(contract_start_date==""&&contract_start_date.length==0){
        alert("合同起始日期不能为空！");
        return;
     }
     
    <%if(contract_type_bd!=null&&!contract_type_bd.trim().equals("1")){%>
            if(contract_stop_date==""&&contract_stop_date.length==0){
                alert("合同终止日期不能为空！");
                return;
             }
       <%}%>
       
      if(contract_stop_date!=""&&contract_stop_date.length!=0){
                            var beginTime = contract_start_date;
                            var endTime = contract_stop_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("合同终止日期小于合同起始日期！");
                                return ;
                            }
       }
                <%if(create_type_bd!=null&&!create_type_bd.trim().equals("2")){%>
                var xmlSubmit=$id("datacell1").dataset.toString();
                <%}%>
                var action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=insert_finoutcontract";
                var myAjax = new Ajax(action);
                 myAjax.addParam('gapwf', gapwf);
                 myAjax.addParam('agent_b_id', document.form_treebasic.agent_b_id.value);
                 myAjax.addParam('agent_b_name', document.form_treebasic.agent_b_name.value);
                 myAjax.addParam('contract_name', document.form_treebasic.contract_name.value);
                 myAjax.addParam('contract_start_date', document.form_treebasic.contract_start_date.value);
                 myAjax.addParam('contract_stop_date', document.form_treebasic.contract_stop_date.value);
                 myAjax.addParam('create_type_bd', document.form_treebasic.create_type_bd.value);
                 myAjax.addParam('business_type_bd', document.form_treebasic.business_type_bd.value);
                 if(document.form_treebasic.create_type_bd.value=='1' || document.form_treebasic.create_type_bd.value==1){
                    myAjax.addParam('contract_template_id', document.getElementById('contract_template_id').value);
                 }else{
                    myAjax.addParam('attach_name', document.form_treebasic.attach_name.value);
                    myAjax.addParam('attach_address', document.form_treebasic.attach_address.value);
                 }
                 myAjax.addParam('contract_type_bd', document.getElementById('contract_type_bd').value);
                 myAjax.addParam('cust_a_id', document.form_treebasic.cust_a_id.value);
                 myAjax.addParam('cust_a_name', document.form_treebasic.cust_a_name.value);
                 myAjax.addParam('customer_code', document.form_treebasic.customer_code.value);
                   <%if(create_type_bd!=null&&!create_type_bd.trim().equals("2")){%>
               myAjax.submitXML(xmlSubmit);
                <%}else{%>
                myAjax.submit();
                <%}%>
                 var returnNode = myAjax.getResponseXMLDom();
                 if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      var oid = myAjax.getProperty("returnMessage");
                      beanId = "ISalcontractitemBs";
                      _$("#btnsave").hide();
                      cancel_onClick()
                 }
    }


</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
       form_treebasic.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=queryAll_tomaintainSal";
       form_treebasic.submit();
    }
    //详细页面关闭
   function  cancel_onClick1(){
   window.close();
   }
    
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
    
/************************************服务项相关*****************************************/
    function toAddProduct_onClick(){      
      var url="<%=request.getContextPath()%>/jsp/faerp/finout/finoutsalcontract/listfinoutproduct.jsp";
      url=url+"?_ts="+(new Date()).getTime();
       //window.open(url,'','height=500px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=服务产品页面');
       showModalCenter(url,window,callback, 700, 500, "服务产品页面");       
   }
   
      function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
  function callback(obj)
    {
   // var start_date1=document.getElementById("contract_start_date").value;
   // var end_date1=document.getElementById("contract_end_date").value;
       var ids=checkpageproduct(obj);
        if(ids!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/Finout_contract_productAction.do?cmd=getFinoutProductByIds&date="+new Date()+"",{"ids":ids[0]},   function(json){
                   dc1=$id("datacell1");
              if(json.beans!=null&&json.beans!="")
              {
            
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("id", json.beans[i].id);
                       newEntity.setProperty("product_id", json.beans[i].id);
                       newEntity.setProperty("product_name", json.beans[i].product_name);
                       newEntity.setProperty("o_remark", json.beans[i].remark);     
                       newEntity.setProperty("product_price", json.beans[i].product_price);
                       newEntity.setProperty("charging_frequency", json.beans[i].charging_frequency);                
                       newEntity.setProperty("small_type_id", json.beans[i].small_type_id);
                       newEntity.setProperty("is_sales_tax", json.beans[i].is_sales_tax);
                       newEntity.setProperty("sales_tax",json.beans[i].sales_tax);
                    
                         dc1.insertRow(newEntity);
                        dc1.activeField.editor.hideEditor();   
           
            }   
                }
              });
              }
           }
              
 function checkpageproduct(obj)
    {
          var addids="";
        var chid1 = document.getElementsByName("checkbox_template");
        var ids = obj; 
       for(var i = 0;i<ids.length;i++)
        { 
            var istrue='false';
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        
        var returnAry = new Array();
        returnAry[0]=addids;
        return returnAry;
    }
  
  function deleteMultiProduct_onClick(){
             var ids = findSelections("checkbox_template");  //取得多选框的选择项      
                  if(ids == null) {  //如果ids为空
           alert('请至少选择一个产品！');
           return;
       }
       if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
            var datacell = $id("datacell1");
        var elementCheckbox = document.getElementsByName("checkbox_template");
                       for (var i = elementCheckbox.length - 1; i >= 0; i--) {          
                if (elementCheckbox[i].checked) { // 如果被选中   
            var row = datacell.getRow(i);
            var datasettr = datacell.getEntity(row);
           datasettr.setProperty("is_del","1");
            datacell.deleteRow(i);    
           
            }
            }
       }
    }  
    
</script>
</head>
<body >
<div id="right">
<form name="form_treebasic" id="form_treebasic" method="post"  >
<script type="text/javascript">
writeTableTopFesco('合同信息','<%=request.getContextPath()%>/');
</script>
<input type="hidden" id="business_type_bd" name ="business_type_bd" value="<%=business_type_bd %>"> 
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
        <%  if(null!=detail&&!"detail".equals(detail)) {%>
               <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>" maxLength="50" validate="notNull;"/>
                <%}else{ %>
              <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>" maxLength="50" validate="notNull;"   readonly="readonly"/>
        
                <%} %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同甲方</td>
            <td class="td_2 " nowrap="nowrap">
               <%  if(null!=detail&&!"detail".equals(detail)) {%>
               <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false" displayValue="<%=customer_name %>" id="lk_cust" lookupUrl="/Finout_contract_productAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择合同甲方" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"  />
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
                <input type="hidden" name="customer_code" id="customer_code"/>
                <%}else{ %>
                <w:lookup onReturnFunc="rtnFunc" displayValue="<%=customer_name %>" lookupWidth="189px"  readOnly="true" readonly="false" id="lk_cust" lookupUrl="/Finout_contract_productAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择合同甲方" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
                <input type="hidden" name="customer_code" id="customer_code"/>
                <%} %>
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
            <%  if(null!=detail&&!"detail".equals(detail)) {%>
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" width="189px"/>
                 <%}else{ %>
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" readOnly="true" width="189px"/>
                 <%} %>
            </td>
           <td class="td_1" ><%if(contract_type_bd!=null&&!contract_type_bd.trim().equals("1")){%><span class="style_required_red">* </span><%} %>合同终止日期</td>
            <td class="td_2"  nowrap="nowrap">
                <%  if(null!=detail&&!"detail".equals(detail)) {%>
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px"/>
                <%}else{ %>
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px" readOnly="true"/>
                <%} %>
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
                 <%  if(null!=detail&&!"detail".equals(detail)) {%>
                   <input type="text"   value=""   id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="" hiddenInputId="attach_name"  /><img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"  />
                  <input type="hidden" id="attackAddressInput" name="attach_address" >
                  </td>
                  <td class="td_1" ></td>
            <td  class="td_2 " ></td>
                <%  } else   {%>
               <% if(isModify&&avo!=null)out.print("<a href='"+request.getContextPath()+"/ProductAction.do?cmd=downLoad&attachment_id="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");
               {%>
            </td>
            <td class="td_1" ></td>
            <td  class="td_2 " ></td>
        <%}%>
         <%}%>
         <%}%>
        </tr>
    </table>
  </div>
 </div>
 
 
  
     <!-- 服务项  begin-->
    <div id="ccParent1" class="button"  style="float: left;width: 68%;">
	    <div class="xz_title" style="padding-top: 10px">产品配置</div>
	    <div class="button_right" style="padding-left: 10px"></div>    
	    <div class="clear"></div>
	    
	    <r:datacell  id="datacell1"
	        queryAction="/FAERP/Finout_contract_productAction.do?cmd=getProductListData_1&id=${bean.id}"
	        width="98%" height="198px" xpath="Finout_contract_productVo" submitXpath="Finout_contract_productVo" 
	         paramFormId="datacell_formid" readonly="false" pageSize="-1">
	        <r:toolbar location="bottom" tools="nav,pagesize,info" />
	        <r:field fieldName="product_id" label="产品id" width="0px" allowModify="false" >
	        </r:field>
	         <r:field fieldName="product_name" label="服务项名称" width="150px" allowModify="false" >
	        </r:field>
	            <r:field fieldName="o_remark" label="备注" width="150px" allowModify="false" >
	            <h:text/>
	        </r:field>
	        <r:field fieldName="product_price" label="价格" width="70px" allowModify="false" >
	        <h:text/>
	        </r:field>
	           <r:field fieldName="charging_frequency" label="频率" width="70px" >
	           <d:select dictTypeId="FINOUT_PRODUCT_TYPE" disabled="true"/>
	        </r:field>
	        <r:field fieldName="small_type_id" label="类型" width="130px" >
	         <d:select dictTypeId="big_type_id" disabled="true"/>
	        </r:field>
	        <r:field fieldName="is_sales_tax" label="是否可收增值税" width="70px" allowModify="true" >
	         <d:select dictTypeId="FINOUT_IS_SALES_TAX" disabled="true"/>
	        </r:field>
	        <r:field fieldName="business_type_bd" label="业务类型" width="80px" allowModify="true" >
	         <d:select dictTypeId="FINOUT_TYPE_BD" nullLabel="" disabled="true"/>
	        </r:field>
	         <r:field fieldName="invoice_type" label="开票类型" width="80px" allowModify="true" >
	         <d:select dictTypeId="SERVICE_TYPE" nullLabel="" disabled="true"/>
	        </r:field>
	        
	        <%-- 
	        <r:field fieldName="sales_tax" label="营业税比例" width="130px" >
	        <h:text validateAttr="type=formatStr;regExpr=^\d+.{0,1}\d+$;message=营业税比例输入错误;"/>
	        </r:field>
	         --%>
	        <%-- 
	        <r:field fieldName="finout_service_userid" label="服务人员" width="130px"  >
	        <r:comboSelect id="cus0" name="cus0"
	                queryAction="/FAERP/Finout_contract_productAction.do?cmd=getFinoutSSEmp"
	                textField="name"
	                valueField="partyid"
	                xpath="Partyrelation"
	                width="180"  nullText="--请选择--"
	                validateAttr="allowNull=false"
	                >
	            </r:comboSelect>
	        </r:field>
	          <r:field fieldName="standard_price" label="标准计价" width="130px" allowModify="true" >
	          <h:text validateAttr="type=formatStr;regExpr=^\d+.{0,1}\d*$;message=标准计价输入错误;"/>
	        </r:field>
	         --%>
	    </r:datacell>
    </div>
     <!-- 服务项  end-->
     
     
     
    <!-- 标准计价配置  begin-->
    <div id="ccParent1" class="button" style="width: 100%;">
        <div class="xz_title" style="padding-top: 10px">标准计价配置</div>
         <div class="button_right">
                <ul>
                    <li class="c">      <a onClick="javascript:toAdd_onClick_service();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:delete_onClick_service();"><fmt:message key="delete"/> </a> </li>
                </ul>
                
         </div>
        <div class="clear"></div>
    
        <r:datacell  id="datacell2"
            queryAction="/FAERP/Finout_contract_serviceAction.do?cmd=queryForDatacell&id=${bean.id}"
            submitAction="/FAERP/Finout_contract_serviceAction.do?cmd=saveList&id=${bean.id}"
            width="98%" height="158px" xpath="Finout_contract_serviceVo" submitXpath="Finout_contract_serviceVo" 
             paramFormId="form_treebasic" readonly="false" pageSize="1000">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            
            <r:field fieldName="service_user_id" label="服务人员" width="100px"  >
            <r:comboSelect id="cus0" name="cus0"
                    queryAction="/FAERP/Finout_contract_productAction.do?cmd=getFinoutSSEmp"
                    textField="name"
                    valueField="partyid"
                    xpath="Partyrelation"
                    width="180"  nullText="--请选择--"
                    validateAttr="allowNull=false"
                    >
                </r:comboSelect>
            </r:field>
              <r:field fieldName="valuation" label="标准计价" width="100px" allowModify="true" >
              <h:text validateAttr="type=formatStr;regExpr=^\d+.{0,1}\d*$;message=标准计价输入错误;"/>
            </r:field>
            
        </r:datacell>
        
     </div> 
     <!-- 标准计价配置  end-->
     
    
     
   <div class="xz_title" style="margin: 10px;">分配薪资服务人员</div>
    <div class="box_tab" style="margin: 10px;">
    <table width="98%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1"><span class="style_required_red">* </span>开具账单人员</td>
            <td width="220">
             <r:comboSelect id="billing_user_id" name="billing_user_id"
               queryAction="/FAERP/Finout_contract_productAction.do?cmd=getFinoutSSEmp"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180"     nullText="--请选择--"
                property="bean/billing_user_id"
                >
            </r:comboSelect>
            </td>
        </tr>
    </table>
    </div>
    
    <div class="box_tab" style="margin: 10px;">
    <table width="98%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1">复核人员</td>
            <td width="220">
             <r:comboSelect id="check_user_id" name="check_user_id" 
               queryAction="/FAERP/Finout_contract_productAction.do?cmd=getFinoutSSEmp"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" nullText="--请选择--"
                property="bean/check_user_id"
                >
            </r:comboSelect>
            </td>
            <td>
            <span class="style_required_red">如果不选则默认为财务外包部经理</span>
            </td>
        </tr>
    </table>
    </div>
    
    
     
 <div class="mx_button" align="center">
         
        <input type="button" class="icon_2" id="btnsave" value='<fmt:message key="save"/>' onClick="javascript:save();" />
       <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
</div>
<!-- 
<div id="TabCon2" style="display:none;">
<input type="hidden" name="create_date" />
<input id="ids" name="ids" type="hidden" class="text_field" inputName="节点id" value="${bean.id }"   readonly="true">
<input id="detail" name="detail" type="hidden" value="<%=detail %>" />
<input id="contract_template_id1" name="contract_template_id1" type="hidden" class="text_field" inputName="节点id" value="${bean.contract_template_id}"   readonly="true">
</div>
 -->
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




    function save() {
        var da_service=$id("datacell2");
        
        //var cannot=true;
        if(da_service.dataset.getLength()==0){
            alert("请设置标准计价配置！");
            return;
        }
         for (var i=0;i<da_service.dataset.getLength();i++) {
            var datasettr = da_service.dataset.get(i);
            var service_user_id=datasettr.getProperty("service_user_id");
            var valuation=datasettr.getProperty("valuation");
                if((service_user_id) && (valuation)){
                    
                }else {
                    alert("请正确 设置标准计价配置！");
                    return;
                }
         }
         if(document.form_treebasic.billing_user_id.value==null || document.form_treebasic.billing_user_id.value==""){
	        alert("请选择开具账单人员");
	        return;
         }
         da_service.isModefied = true;
        if(da_service.submit()){
            alert("保存成功！");
            cancel_onClick();
        }
    
    }
    function toAdd_onClick_service() {  //到增加记录页面
            
            var datacell = $id("datacell2");
            datacell.addRow();
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            
            
            //datasettr.setProperty("is_indie_bd",'0');
    }
    
    
    function delete_onClick_service(){
        
        var datacell = $id("datacell2");
        //var dataset1 = obj.dataset;//取得页面的datacell
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="yinyong_delete"/>');
            return;
        }else{
           if(confirm('确定要删除吗？')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
              //datacell.dataset.removeEntity(datacell.dataset.getActiveEntity(),true);
              //dataset1.removeEntity(obj.getActiveEntity(),true);
           }
       }
    }




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



