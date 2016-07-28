<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.customersimple.vo.CustomersimpleVo" %>
<%@ page import="rayoo.sales.customersimple.util.ICustomersimpleConstants" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<%  //判断是否为修改页面
    CustomersimpleVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ICustomersimpleConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (CustomersimpleVo)request.getAttribute(ICustomersimpleConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    String date = request.getAttribute("date")==null?"":request.getAttribute("date").toString();
    String orgname = request.getAttribute("orgname") == null?"":request.getAttribute("orgname").toString();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<html>
<fmt:bundle basename="rayoo.salse.customersimple.customersimple_resource" prefix="rayoo.salse.customersimple.">
<head>
<base target="_self"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

<script language="javascript">
    function insert_onClick(){  //插入单条数据
        if(vailform()){
            if(checkAllForms()){
                form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=insert";
                form.submit();
                window.close();
            }
            
        }
       
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        if(vailform()){
            form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=update";
            form.submit();
            window.close();
            window.opener.callBack();
        }
        
    }

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=queryAll&backFlag=false";
        //form.submit();
        window.close();
    }
    
    function getbyid(){
        var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
        document.form.id.value=data[0];
        document.form.customer_code.value=data[1];
        document.form.customer_name.value=data[2];
    }
    
     function vailform(){
        var code = document.form.customer_code.value;
        if(code == null || code == ''){
            alert('<fmt:message key="choose_customer_code"/>');
            return false;
        }
        var name = document.form.customer_name;
        if(name==null || name==''){
            alert('<fmt:message key="choose_customer_name"/>');
            return false;
        }
        var handover_date = document.getElementById('handover_date').value;
        if(handover_date==null || handover_date==''){
            alert('<fmt:message key="input_handover_date"/>');
            return;
        }
        return true;
    }
    
    function rtnFuncCustomer(obj){
        document.getElementById('id').value = obj[0];
        document.getElementById('customer_code').value = obj[1];
        document.getElementById('customer_name').value = obj[2];
        var id  = obj[0];
        var flags=true;
        jQuery.ajax({
        url: '<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=getCustomerService&id='+id,
        type: 'POST',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(code){
           $id("service").setValue(code,true);
           
         }
        });
    }
    
    function getname(){
        var code  = $id("code").getValue();
         jQuery.ajax({
        url: '<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=getCustomerName&code='+code,
        type: 'POST',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('<fmt:message key="customer_name_isexise"/>');
            document.getElementById('customer_name').value='';
            return  null;
        },
        success: function(data){
           if(data == null || data == ''){
                alert('<fmt:message key="customer_name_isexise"/>');
                document.getElementById('customer_name').value='';
           }
           else{
                document.getElementById('customer_name').value=data;
           }
         }
        });
    }
    
</script>
</head>
<body>

<form name="form" method="post">
<div id="right">
   <div id="ccParent0" class="box_3"> 
<%if(!isModify){
    %>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="30%"><span class="style_required_red">* </span><fmt:message key="customer_code"/></td>
            <td class="td_2 " width="20%">
                <w:lookup readonly="false" id="code" validateAttr="allowNull=false;" name="code" style="width:185px"
            lookupUrl="/CustomersimpleAction.do?cmd=queryCustomerData" onblur="getname();"
          height="440" width="750"  onReturnFunc="rtnFuncCustomer" messagekey="choose_customer"/>
              
            </td>
            <td class="td_1" width="30%"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2 " width="20%">
                 <input type="text" class="text_field" disabled="disabled" id="customer_name" name="customer_name"/>
           </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="contract_type"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_type_bd", -1,"CUSTOMER_CONTRACT",""," id=contract_type_bd",false) %> 
            </td>
            <td class="td_1" ><fmt:message key="customer_char"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("customer_char", -1,"CUSTOMER_CUSTCHAR",""," id=customer_char",false) %>         
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="customer_service_name"/></td>
            <td class="td_2 ">
               <r:comboSelect id="service" name="customer_service1" queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=0"
                textField="name" valueField="partyid" xpath="Partyrelation" width="200px" messagekey="please_choose"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="handover_date"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="handover_date" name="handover_date" format="yyyy-MM-dd" width="185px"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_swhtyj"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_swhtyj", -1,"TrueOrFalse","0","",true) %>
            </td>
            <td class="td_1" ><fmt:message key="is_hkxyyj"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_hkxyyj", -1,"TrueOrFalse","0","",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_zzjgdmzfyj"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_zzjgdmzfyj", -1,"TrueOrFalse","0","",true) %>
            </td>
            <td class="td_1" ><fmt:message key="is_yyzzfyj"/></td>
            <td class="td_2 ">
                  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_yyzzfyj", -1,"TrueOrFalse","0","",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_wspzzsfyj"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_wspzzsfyj", -1,"TrueOrFalse","0","",true) %>
            </td>
            <td class="td_1" ><fmt:message key="is_htpsb"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_htpsb", -1,"TrueOrFalse","0","",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_bjdpsb"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_bjdpsb", -1,"TrueOrFalse","0","",true) %>
            </td>
            <td class="td_1" ><fmt:message key="is_quotation"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_quotation", -1,"TrueOrFalse","0","",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_sprzrymd"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_sprzrymd", -1,"TrueOrFalse","0","",true) %>
            </td>
            <td class="td_1" ><fmt:message key="attached_accu_item"/></td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("attached_accu_item_bd", -1,"TrueOrFalse","0","",true) %>  
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="other_info"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("other_info", -1,"CUSTOMER_OTHERINFO","0"," id=other_info",false) %>
            </td>
            <td class="td_1" ><fmt:message key="trade_type"/></td>
            <td class="td_2 ">
                        <r:comboSelect id="trade_type" name="trade_type" queryAction="/FAERP/CustomerAction.do?cmd=queryIndustryTypeData"
              textField="name" valueField="id" xpath="CustomerSelectVo" width="200px"  messagekey="please_choose" value="${bean.trade_type}" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="customer_simple_create_user"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="customer_simple_create_user" disabled="disabled"  inputName="客户简档录入人" value="<%=orgname %>" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="customer_simple_create_date"/></td>
            <td class="td_2">
                <input type="text" class="text_field" name="customer_simple_create_date" id="customer_simple_create_date" disabled="disabled" inputName="客户简档录入日期" value="<%=date %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="customer_simple_remarks"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="customer_simple_remarks" inputName="备注说明" value="" maxLength="1000" />
            </td>
            <td class="td_1"></td>
            <td class="td_2" >
                <input type="hidden" id="customer_code" name="customer_code">
                <input type="hidden" id="id" name="id" value="">      
            </td>
        </tr>
    </table>
    <%
}else{
    %>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="30%"><span class="style_required_red">* </span><fmt:message key="customer_code"/></td>
            <td class="td_2 " width="20%">
                <input type="text" class="text_field" disabled="disabled" name="customer_code" validators="isSearch" inputName="客户编号" value="<%=resultVo.getCustomer_code() %>" maxLength="25" validate="notNull;"/>
            </td>
            <td class="td_1" width="30%"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2 " width="20%">
                <input type="text" class="text_field" disabled="disabled" name="customer_name"  validators="isSearch" inputName="客户名称" value="<%=resultVo.getCustomer_name() %>" maxLength="50" validate="notNull;"/>
           </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="contract_type"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_type_bd", -1,"CUSTOMER_CONTRACT",resultVo.getContract_type_bd()," id=contract_type_bd",false) %> 
            </td>
            <td class="td_1" ><fmt:message key="customer_char"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("customer_char", -1,"CUSTOMER_CUSTCHAR",resultVo.getCustomer_char()," id=customer_char",false) %>         
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="customer_service_name"/></td>
            <td class="td_2 ">
               <r:comboSelect id="service" name="customer_service1" queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=0"
                textField="name" valueField="partyid" xpath="Partyrelation" width="205px" nullText="请选择" value="${bean.customer_service1}"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="handover_date"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="handover_date" name="handover_date" format="yyyy-MM-dd" property="bean/handover_date" width="185px"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_swhtyj"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_swhtyj", -1,"TrueOrFalse",resultVo.getIs_swhtyj()==null?"0":resultVo.getIs_swhtyj(),"",true) %>
            </td>
            <td class="td_1" ><fmt:message key="is_hkxyyj"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_hkxyyj", -1,"TrueOrFalse",resultVo.getIs_hkxyyj()==null?"0":resultVo.getIs_hkxyyj(),"",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_zzjgdmzfyj"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_zzjgdmzfyj", -1,"TrueOrFalse",resultVo.getIs_zzjgdmzfyj()==null?"0":resultVo.getIs_zzjgdmzfyj(),"",true) %>
            </td>
            <td class="td_1" ><fmt:message key="is_yyzzfyj"/></td>
            <td class="td_2 ">
                  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_yyzzfyj", -1,"TrueOrFalse",resultVo.getIs_zzjgdmzfyj()==null?"0":resultVo.getIs_zzjgdmzfyj(),"",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_wspzzsfyj"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_wspzzsfyj", -1,"TrueOrFalse",resultVo.getIs_wspzzsfyj()==null?"0":resultVo.getIs_wspzzsfyj(),"",true) %>
            </td>
            <td class="td_1" ><fmt:message key="is_htpsb"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_htpsb", -1,"TrueOrFalse",resultVo.getIs_htpsb()==null?"0":resultVo.getIs_htpsb(),"",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_bjdpsb"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_bjdpsb", -1,"TrueOrFalse",resultVo.getIs_bjdpsb()==null?"0":resultVo.getIs_bjdpsb(),"",true) %>
            </td>
            <td class="td_1" ><fmt:message key="is_quotation"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_quotation", -1,"TrueOrFalse",resultVo.getIs_quotation()==null?"0":resultVo.getIs_quotation(),"",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_sprzrymd"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_sprzrymd", -1,"TrueOrFalse",resultVo.getIs_sprzrymd()==null?"0":resultVo.getIs_sprzrymd(),"",true) %>
            </td>
            <td class="td_1" ><fmt:message key="attached_accu_item"/></td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("attached_accu_item_bd", -1,"TrueOrFalse",resultVo.getAttached_accu_item_bd(),"",true) %>  
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="other_info"/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("other_info", -1,"CUSTOMER_OTHERINFO",resultVo.getOther_info()," id=other_info",false) %>
            </td>
            <td class="td_1" ><fmt:message key="trade_type"/></td>
            <td class="td_2 ">
                       <r:comboSelect id="trade_type" name="trade_type" queryAction="/FAERP/CustomerAction.do?cmd=queryIndustryTypeData"
              textField="name" valueField="id" xpath="CustomerSelectVo" width="200px"  messagekey="please_choose" value="${bean.trade_type}" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="customer_simple_create_user"/></td>
            <td class="td_2 ">
                <input type="hidden" name ="customer_simple_create_user" value="${bean.customer_simple_create_user }">
                <input type="text" class="text_field" disabled="disabled" inputName="客户简档录入人" value="<%= OrgHelper.getPartyVoByID(resultVo.getCustomer_simple_create_user()).getName()%>" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="customer_simple_create_date"/></td>
            <td class="td_2">
                <input type="hidden" name ="customer_simple_create_date"   value="<%=resultVo.getCustomer_simple_create_date()==null?"":sdf.format(resultVo.getCustomer_simple_create_date())%>">
                <input type="text" class="text_field"  id="customer_simple_create_date" disabled="disabled" inputName="客户简档录入日期" value="<%=resultVo.getCustomer_simple_create_date()==null?"":sdf.format(resultVo.getCustomer_simple_create_date())%>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="customer_simple_remarks"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="customer_simple_remarks" inputName="备注说明" value="<%=resultVo.getCustomer_simple_remarks()==null?"":resultVo.getCustomer_simple_remarks() %>" maxLength="1000" />
            </td>
            <td class="td_1"><input type="hidden" id="id" name="id" value="<%=resultVo.getId() %>"></td>
            <td class="td_2" >             
            </td>
        </tr>
    </table>
       
    <%
}
%>
    
 

            
   
   
    <div class="mx_button" style="text-align: center;padding-top:10px;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:window.close();"/>
        </div>
    </div>         
  </div>
            

<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
        //out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
</script>
