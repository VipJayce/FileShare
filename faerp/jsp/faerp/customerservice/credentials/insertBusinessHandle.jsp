<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.credentials.vo.CredentialsVo" %>
<%@ page import="rayoo.customerservice.credentials.util.ICredentialsConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
    CredentialsVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ICredentialsConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (CredentialsVo)request.getAttribute(ICredentialsConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
%>
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
        if(vaildate()){
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=inertBusinessHandle";
        form.submit();
        window.close();
        window.opener.callBack();
        }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
            if(vaildate()){

        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateBusinessHandle";
        form.submit();
        window.close();
        window.opener.callBack();
        }
    }

    function cancel_onClick(){  //取消后返回列表页面
       // form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=simpleBusinessHandle&backFlag=false";
       // form.submit();
       window.close();
    }
    
     function findType(){
        var credentials_type_id = document.getElementById('credentials_type_id');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>=0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('credentials_type_bd').value;
        if(type_bd == null || type_bd==''){
            addAt(credentials_type_id,'<fmt:message key="please_choose"/>','',0);
            
            alert('<fmt:message key="choose_credentials_type_big"/>');
            return;
        }
        
        
         jQuery.getJSON("<venus:base/>/CredentialsAction.do?cmd=findCredentialsType&date="+new Date()+"",{"type_bd":type_bd},  function(json){
          for(var i = 0; i < json.saia.length; i++){
           var id=json.saia[i].id ;
           var name =json.saia[i].credentials_name;
           addAt(credentials_type_id,name,id,0);
            }
        });  
    }
    
    function addAt(selectCtl,optionValue,optionText,position){
         var userAgent = window.navigator.userAgent;
        if (userAgent.indexOf("MSIE") > 0) {
             var option = document.createElement("option");
             option.innerText = optionValue;
             option.value = optionText;
             selectCtl.insertBefore(option, selectCtl.options[position]);
         }else{
        selectCtl.insertBefore(new Option(optionValue, optionText), selectCtl.options[position]);
        }
    } 
    
    function selectname(){
        var data = window.showModalDialog('<venus:base/>/CredentialsAction.do?cmd=simpleEmployee&date='+new Date(),'','dialogHeight:525px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(data == undefined) return;
        document.getElementById('employee_name').value = data[1];
    }
    
    function rtnFuncCustomer(obj){
        var lookup = $id('employee_name');
        lookup.value=obj[1];
        lookup.displayValue = obj[1];
        if(obj[2]!=null&&obj[2]!=""){
           document.getElementById('cust_name').value=obj[2];
        }
        if(obj[3]!=null&&obj[3]!=""){
           document.getElementById('emp_card_no').value=obj[3];
        }
        return false;
    }     
    
    function vaildate(){
       var  employee_name=document.getElementById("employee_name").value;
        if(employee_name == null || employee_name==''){
       
            alert('<fmt:message key="choose_employee_name"/>');
            return false;
        }
        var emp_card_no = document.getElementById('emp_card_no').value;
        if(emp_card_no == null || emp_card_no == ''){
            alert('<fmt:message key="choose_emp_card_no"/>');
            return false;
        }
        var credentials_type_bd = document.getElementById('credentials_type_bd').value;
        if(credentials_type_bd == null || credentials_type_bd== ''){
            alert('<fmt:message key="choose_credentials_type_big"/>');
            return false;
        }
        var credentials_type_id = document.getElementById('credentials_type_id').value;
        if(credentials_type_id == null || credentials_type_id == ''){
            alert('<fmt:message key="choose_credentials_type_small"/>');
            return false;
        }
        return true;
    }
</script>
</head>
<body>

<form name="form" method="post">
<div id="right">
<div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<%
if(!isModify){
    %>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="employee_name"/></td>
            <td class="td_2 ">
            <w:lookup id="employee_name" validateAttr="allowNull=false;" name="employee_name"
            lookupUrl="/CredentialsAction.do?cmd=simpleEmployee" 
            messagekey="employee_name" height="500" width="810"  onReturnFunc="rtnFuncCustomer" style="width:155px;"/>  
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="emp_card_no"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_card_no" inputName="员工证件号" value="" maxLength="64" style="width:170px"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="retinue_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="retinue_name" inputName="随员姓名" value="" maxLength="50" style="width:170px"/>
            </td>
            <td class="td_1" ><fmt:message key="retinue_card_no"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="retinue_card_no" inputName="随员证件号码" value="" maxLength="64" style="width:170px" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cust_name" inputName="公司名称" value="" maxLength="50" style="width:170px" />
            </td>
            <td class="td_1" ><fmt:message key="validity"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="validity" name="validity" format="YYYY-MM-DD" style="width:155px;" />  
            </td>
        </tr>
        <tr>
        <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="credentials_type_big"/></td>
        <td class="td_2 " width="170px">
            <%=RmJspHelper.getSelectField("",-1,"BUSINESS_TYPE_BD",""," id='credentials_type_bd' onchange='findType();'  style='width:170px;'",false) %>
        </td>
        <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="credentials_type_small"/></td>
        <td class="td_2 ">
            <select name="credentials_type_id" id="credentials_type_id" style="width:170px" >
                <option value=""><fmt:message key="please_choose"/></option>
            </select>
        </td>
    </tr>
    <tr>
            <td class="td_1" ><fmt:message key="submit_date"/></td>
            <td class="td_2" >
                <w:date allowInput="false" id="submit_date" name="submit_date" format="YYYY-MM-DD" style="width:155px;" />               
            </td>
            <td class="td_1" ><fmt:message key="finish_date"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="finish_date" name="finish_date" format="YYYY-MM-DD"  style="width:155px;" />                
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="remark"/></td>
            <td colspan="3" class="td_2" >
                <textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName="备注" maxLength="1000" ></textarea>
            </td>
        </tr>
   </table>
 
    <% 
}else{
    %>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="employee_name"/></td>
            <td class="td_2 ">
                <w:lookup id="employee_name" validateAttr="allowNull=false;" name="employee_name"
            lookupUrl="/CredentialsAction.do?cmd=simpleEmployee" displayValue="${bean.employee_name}" value="${bean.employee_name}"
            messagekey="choose_employee" height="500" width="810"  onReturnFunc="rtnFuncCustomer"  style="width:155px;"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="emp_card_no"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_card_no" inputName="员工证件号" value="${bean.emp_card_no}" maxLength="64" style="width:170px" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="retinue_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="retinue_name" inputName="随员姓名" value="${bean.retinue_name}" maxLength="50" style="width:170px"  />
            </td>
            <td class="td_1" ><fmt:message key="retinue_card_no"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="retinue_card_no" inputName="随员证件号码" value="${bean.retinue_card_no}" maxLength="64" style="width:170px"  />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cust_name" inputName="公司名称" value="${bean.cust_name}" maxLength="50"  style="width:170px" />
            </td>
            <td class="td_1" ><fmt:message key="validity"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="validity" name="validity" format="YYYY-MM-DD" property="bean/validity" style="width:155px;" />                
            </td>
        </tr>
        <tr>
        <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="credentials_type_big"/></td>
        <td class="td_2 ">
            <%=RmJspHelper.getSelectField("",-1,"BUSINESS_TYPE_BD",resultVo.getCredentials_type_bd()," id='credentials_type_bd' onchange='findType();' style='width:170px;'",false) %>
        </td>
        <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="credentials_type_small"/></td>
        <td class="td_2 ">
            <select name="credentials_type_id" id="credentials_type_id" style="width:170px"  >
                <option value="<%=resultVo.getCredentials_type_id() %>"><%=resultVo.getCredentials_name() %></option>
            </select>
        </td>
    </tr>
    <tr>
            <td class="td_1" ><fmt:message key="submit_date"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="submit_date" name="submit_date" format="YYYY-MM-DD"  property="bean/submit_date" style="width:155px;" />                
            </td>
            <td class="td_1" ><fmt:message key="finish_date"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="finish_date" name="finish_date" format="YYYY-MM-DD"  property="bean/finish_date" style="width:155px;" />                
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="remark"/></td>
            <td colspan="3" class="td_2" >
                <textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName="备注" maxLength="1000" >${bean.remark}</textarea>
            </td>
        </tr>
    </table>
    <input type="hidden" name="id" value="${bean.id}">
    <%
}
%>
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
         <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:window.close()"/>
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
    //if(isModify) {  //如果本页面是修改页面
        //out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
        %>
      //  $id('employee_name').setValue('<%//=resultVo.getEmployee_name()%>');
        <%       
   // }
%>
</script>
 