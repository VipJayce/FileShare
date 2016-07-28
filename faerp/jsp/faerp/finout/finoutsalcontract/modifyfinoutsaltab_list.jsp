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
        business_type_bd=resultVo.getBusiness_type_bd();
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
 function update_onClick(){  //保存修改后的单条数据
             var contract_start_date=document.form_treebasic.contract_start_date.value.trim();;
             var contract_stop_date=document.form_treebasic.contract_stop_date.value.trim();;
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
                       
        //yangxu
       
       var datacell1 = $id("datacell1");
       var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
            	if(datasettr.getProperty("o_remark")==null || datasettr.getProperty("o_remark")==''){
	                alert('请输入备注！（'+datasettr.getProperty("product_name")+'）');
	                return;
	            }
	            if(datasettr.getProperty("product_price")==null || datasettr.getProperty("product_price")==''){
	                alert('请输入价格！（'+datasettr.getProperty("product_name")+'）');
	                return;
	            }
	            if(datasettr.getProperty("is_sales_tax")==null || datasettr.getProperty("is_sales_tax")==''){
	                alert('请选择是否收税！（'+datasettr.getProperty("product_name")+'）');
	                return;
	            }
	            if(datasettr.getProperty("business_type_bd")==null || datasettr.getProperty("business_type_bd")==''){
	                alert('请选择业务类型！（'+datasettr.getProperty("product_name")+'）');
	                return;
	            }
	            //2016-06-29  by zhouxiaolong    增加开票类型的保存    Begin
	            if(datasettr.getProperty("invoice_type")==null || datasettr.getProperty("invoice_type")==''){
	                alert('请选择开票类型！（'+datasettr.getProperty("product_name")+'）');
	                return;
	            }
	            //2016-06-29  by zhouxiaolong    增加开票类型的保存    End
	            
            }
            
        }
       
       //yangxu               
                       
                       
            <%if(create_type_bd!=null&&!create_type_bd.trim().equals("2")){%>
                var xmlSubmit=$id("datacell1").dataset.toString();
                <%}%>
                  if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
                    return false;
                     }
                 var action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=update_finoutcontract";
                 var myAjax = new Ajax(action);
                 myAjax.addParam('contract_name', document.form_treebasic.contract_name.value);
                 myAjax.addParam('contract_start_date', document.form_treebasic.contract_start_date.value);
                 myAjax.addParam('contract_stop_date', document.form_treebasic.contract_stop_date.value);
                myAjax.addParam('create_type_bd', document.form_treebasic.create_type_bd.value);
                myAjax.addParam('business_type_bd', document.form_treebasic.business_type_bd.value);
                if(document.form_treebasic.create_type_bd.value=='1' || document.form_treebasic.create_type_bd.value==1){
                 }else{
                    myAjax.addParam('attach_name', document.form_treebasic.attach_name.value);
                    myAjax.addParam('attach_address', document.form_treebasic.attach_address.value);
                 }
                 myAjax.addParam('cust_a_id', document.form_treebasic.cust_a_id.value);
                 myAjax.addParam('cust_a_name', document.form_treebasic.cust_a_name.value);
                 myAjax.addParam('customer_code', document.form_treebasic.customer_code.value);
                 myAjax.addParam('agent_b_id', document.form_treebasic.agent_b_id.value);
                 myAjax.addParam('agent_b_name', document.form_treebasic.agent_b_name.value);
                 myAjax.addParam('id', document.form_treebasic.ids.value);
        <%if(create_type_bd!=null&&!create_type_bd.trim().equals("2")){%>
               myAjax.submitXML(xmlSubmit);
                <%}else{%>
                myAjax.submit();
                <%}%>
                 var returnNode = myAjax.getResponseXMLDom();
                 if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      window.opener.showListData();//回调父页面函数
                      cancel_onClick1();
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
       form_treebasic.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=queryAll_tolistsal";
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
                       newEntity.setProperty("remark", json.beans[i].remark);     
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
<input id="ids"  name="ids" type="hidden" value="${bean.id }">
 <div class="ringht_x" style="height: 125px;">
<div id="ccChild1"     class="box_xinzeng" style="height: 125px;"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同业务类型</td>
            <td class="td_2"  nowrap="nowrap">
             <input type="hidden" class="text_field" name="business_type_bd"  id  =  "business_type_bd"   value="<%=business_type_bd %>" >
                   <%=gap.rm.tools.helper.RmJspHelper.getSelectField("business_type_bd", -1,"FINOUT_TYPE_BD",business_type_bd," id=business_type_bd  ",false) %> 
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>合同名称</td>
            <td class="td_2 " nowrap="nowrap">  
               <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>" maxLength="50" validate="notNull;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同甲方</td>
            <td class="td_2 " nowrap="nowrap">
               <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false"         disabled="${create_type_bd==1?'true':'false'}"           displayValue="<%=customer_name %>" id="lk_cust" lookupUrl="/Finout_contract_productAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择合同甲方" height="440" width="710" />
                <input type="hidden" name="cust_a_name" id="cust_a_name" value="${bean.customer_name }" />
                <input type="hidden" name="cust_a_id" id="cust_a_id" value="${bean.cust_a_id }"/>
                <input type="hidden" name="customer_code" id="customer_code" value="${bean.customer_code }"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>合同乙方</td>
            <td class="td_2 " nowrap="nowrap">                
                <w:lookup onReturnFunc="rtnFunc1" lookupWidth="189px"      disabled="${create_type_bd==1?'true':'false'}"                   displayValue="<%=agent_b_name %>" readonly="false" id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" dialogTitle="选择合同乙方" height="430" width="680"/>
                <input type="hidden" name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>" />
                <input type="hidden" name="agent_b_name" id="agent_b_name" value="<%=agent_b_name %>"/>
            </td>
        </tr>
        
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同起始日期</td>
            <td class="td_2" nowrap="nowrap">
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" width="189px"/>
            </td>
           <td class="td_1" ><%if(contract_type_bd!=null&&!contract_type_bd.trim().equals("1")){%><span class="style_required_red">* </span><%} %>合同终止日期</td>
            <td class="td_2"  nowrap="nowrap">
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px"/>
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
       <% 
          if("1".equals(create_type_bd)){
           %>
    <!-- 服务项  begin-->
    <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">产品配置</div>
    <div class="button_right" style="padding-left: 10px">
    <%  if(!"detail".equals(detail)) {%>
        <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddProduct_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiProduct_onClick();">
<%} %>
</div>    
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell1"
        queryAction="/FAERP/Finout_contract_productAction.do?cmd=getProductListData_1&id=${param.id}"
        width="98%" height="198px" xpath="Finout_contract_productVo" submitXpath="Finout_contract_productVo" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
       <r:field fieldName="id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
        <r:field fieldName="product_id" label="产品id" width="0px" allowModify="false" >
        </r:field>
         <r:field fieldName="product_name" label="服务项名称" width="150px" allowModify="false" >
        </r:field>
            <r:field fieldName="o_remark" label="备注" width="150px" allowModify="true" >
            <h:text/>
        </r:field>
        <r:field fieldName="product_price" label="价格" width="70px" allowModify="true" >
        <h:text validateAttr="type=formatStr;regExpr=^\d+.{0,1}\d*$;message=价格输入错误;"/>
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
          <!-- 2016-07-25   by zhouxiaolong  开票类型默认为财外 -->
         <r:field fieldName="invoice_type" label="开票类型" defaultValue="6" width="100px" allowModify="true" >
         <!-- 2016-07-25   by zhouxiaolong  开票类型默认为财外 -->
         <d:select dictTypeId="SERVICE_TYPE" nullLabel="请选择"/>
        </r:field>
        <%-- 
        <r:field fieldName="sales_tax" label="营业税比例" width="130px" >
        <h:text validateAttr="type=formatStr;regExpr=^\d+.{0,1}\d+$;message=营业税比例输入错误;"/>
        </r:field>
         --%>
    </r:datacell>
     <!-- 服务项  end-->
    <%} %>    
 <div class="mx_button" align="center">
        <input type="button" class="icon_2" id="btnsave" value='<fmt:message key="save"/>' onClick="javascript:update_onClick()" />
       <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick1()"/>
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



