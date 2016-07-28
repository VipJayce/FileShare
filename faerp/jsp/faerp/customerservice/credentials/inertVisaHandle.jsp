
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
            RmVoHelper.null2Nothing(resultVo); 
        }
       
    }
    if(resultVo==null)
        resultVo=new CredentialsVo();
%>
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
                            var passport_validity_from=   $id("passport_validity_from").value;
            var passport_validity_to=   $id("passport_validity_to").value;
            
            var route_date_from =$id("route_date_from").value;
             var route_date_to =$id("route_date_to").value;
             
            
            if(null!=passport_validity_from&&passport_validity_from.trim().length>0&&null!=passport_validity_to&&passport_validity_to.trim().length>0){
                     passport_validity_from=passport_validity_from.replace("-","").replace("-","");
                     passport_validity_to=passport_validity_to.replace("-","").replace("-","");
                        if(passport_validity_from>passport_validity_to){
                             alert('<fmt:message key="passport_validity_from"/>');
                             return ;
                        }
            }
            
            
            if(null!=route_date_from&&route_date_from.trim().length>0&&null!=route_date_to&&route_date_to.trim().length>0){
                         route_date_from=route_date_from.replace("-","").replace("-","");
                         route_date_to=route_date_to.replace("-","").replace("-","");
                        if(route_date_from>route_date_to){
                             alert('<fmt:message key="route_date_from"/>');
                             return ;
                        }
            }
    
    
    
    
        if(checkAllForms()){
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=insertVisaHandle";
        form.submit();
        window.close();
        window.opener.callBack();
        }
    }

    function update_onClick(id){  //保存修改后的单条数据
		    var passport_validity_from=   $id("passport_validity_from").value;
		    var passport_validity_to=   $id("passport_validity_to").value;
		    
		    var route_date_from =$id("route_date_from").value;
		     var route_date_to =$id("route_date_to").value;
		    
		    if(null!=passport_validity_from&&passport_validity_from.trim().length>0&&null!=passport_validity_to&&passport_validity_to.trim().length>0){
				     passport_validity_from=passport_validity_from.replace("-","").replace("-","");
				     passport_validity_to=passport_validity_to.replace("-","").replace("-","");
					    if(passport_validity_from>passport_validity_to){
					         alert('<fmt:message key="passport_validity_from"/>');
					         return ;
					    }
		    }
		    
		    
		    if(null!=route_date_from&&route_date_from.trim().length>0&&null!=route_date_to&&route_date_to.trim().length>0){
					     route_date_from=route_date_from.replace("-","").replace("-","");
					     route_date_to=route_date_to.replace("-","").replace("-","");
		                if(route_date_from>route_date_to){
		                     alert('<fmt:message key="route_date_from"/>');
		                     return ;
		                }
		    }
    
    

    
    
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
            if(checkAllForms()){

        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateVisaHandle";
        form.submit();
        window.close();
        window.opener.callBack();
        }
    }

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=queryVisaHandle&backFlag=false";
        //form.submit();
        window.close();
    }
    
    function checkAllForms(){
    var employeename=document.getElementById("employee_name").value;
    if(employeename==null || employeename==""){
    alert('<fmt:message key="employeename_null"/>');
    return false;
    }
    var empcardno=document.getElementById("emp_card_no").value;
    if(empcardno==null || empcardno==""){
    alert('<fmt:message key="empcardno_null"/>');
    return false;
    }
        var  credentials_status_id=$id("credentials_status_id").value;
       if(null==credentials_status_id||""==credentials_status_id){
         alert('<fmt:message key="choose_status"/>');
         return false;
           }
   return true;
    }
    
      function test9(){
		    var  insurance_day  =document.getElementById("insurance_day").value;
		    var regu = /^(\d+)$/; 
		             if(!regu.test(insurance_day)){
		                alert('<fmt:message key="insurance_day_null"/>');
		                 document.getElementById("insurance_day").focus();
		             return;
		             }
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
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="employee_name1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="employee_name" id="employee_name" inputName="雇员姓名" value="" maxLength="50" style='width:170px;'/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="emp_card_no2"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_card_no" id="emp_card_no" inputName="员工证件号" value="" maxLength="64" style='width:170px;'/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="emp_name_phonetic"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_name_phonetic" inputName="员工姓名拼音" value="" maxLength="64" style='width:170px;' />
            </td>
            <td class="td_1" ><fmt:message key="post"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="post" inputName="职位" value="" maxLength="64" style='width:170px;'/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="birthday_from"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="birthday" name="birthday" format="YYYY-MM-DD" style="width:153px;" />               
            </td>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
            <td class="td_2 ">
                <input type="text"   class="text_field" name="cust_name" inputName="公司名称" value="" maxLength="50" style="width:170px;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="visa_country"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="visa_country" inputName="签证国家" value="" maxLength="50" style='width:200px;' />              
            </td>
            <td class="td_1" ><fmt:message key="passport_validity"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="passport_validity_from" name="passport_validity_from" format="YYYY-MM-DD" style="width:70px;" />
                &nbsp;<fmt:message key="to"/>&nbsp;
                <w:date allowInput="false" id="passport_validity_to" name="passport_validity_to" format="YYYY-MM-DD" style="width:70px;" />                             
             </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="status_name"/></td>
            <td class="td_2 ">
                <select name="credentials_status_id" id="credentials_status_id">
                </select>
            </td>
            <td class="td_1" ><fmt:message key="emp_nature"/></td>
            <td class="td_2 ">
                <%=RmJspHelper.getSelectField("emp_nature_bd",-1,"EMP_NATURE_BD","","",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="sex"/></td>
            <td class="td_2 ">
                <%=RmJspHelper.getSelectField("sex_bd",-1,"SEX_BD","","",true) %>
            </td>
            <td class="td_1" ><fmt:message key="route_date1"/></td>
            <td class="td_2 ">

                <w:date allowInput="false" id="route_date_from" name="route_date_from" format="YYYY-MM-DD" style="width:70px;"/>
                &nbsp;<fmt:message key="to"/>&nbsp;
                <w:date allowInput="false" id="route_date_to" name="route_date_to" format="YYYY-MM-DD" style="width:70px;" />               
            </td>
        </tr>
        <tr>
            <td  class="td_1" ><fmt:message key="insurance_day"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field"   id="insurance_day"   name="insurance_day" inputName="保险天数" maxLength="19" integerDigits="18" decimalDigits="0"  onblur="test9();"/>
            </td>
            <td class="td_1" ><fmt:message key="interview_time_from"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="interview_time" name="interview_time" format="YYYY-MM-DD" style="width:185px;" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="tel"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="tel" inputName="联系电话" value="" maxLength="11" />
            </td>
            <td class="td_1" ><fmt:message key="e_mail"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="e_mail" inputName="邮箱" value="" maxLength="64" />
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
    <input type="hidden" name="id" value="<%=resultVo.getId() %>">
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="employee_name1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="employee_name" inputName="雇员姓名" value="<%=resultVo.getEmployee_name() %>" maxLength="50" style='width:200px;' />
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="emp_card_no2"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_card_no" inputName="员工证件号" value="<%=resultVo.getEmp_card_no() %>" maxLength="64"  style='width:200px;'/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="emp_name_phonetic"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_name_phonetic" inputName="员工姓名拼音" value="<%=resultVo.getEmp_name_phonetic() %>" maxLength="64"  style='width:200px;'/>
            </td>
            <td class="td_1" ><fmt:message key="post"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="post" inputName="职位" value="<%=resultVo.getPost() %>" maxLength="64"  style='width:200px;'/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="birthday_from"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="birthday" name="birthday" format="YYYY-MM-DD" style="width:183px;" property="bean/birthday"  />
            </td>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cust_name" inputName="公司名称" value="<%=resultVo.getCust_name() %>" maxLength="50" style="width:200px;" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="visa_country"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="visa_country" inputName="签证国家" value="<%=resultVo.getVisa_country() %>" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="passport_validity"/></td>
            <td class="td_2">
                 <w:date allowInput="false" id="passport_validity_from" name="passport_validity_from" format="YYYY-MM-DD" style="width:70px;" property="bean/passport_validity_from" />
                &nbsp;<fmt:message key="to"/>&nbsp;
                <w:date allowInput="false" id="passport_validity_to" name="passport_validity_to" format="YYYY-MM-DD" style="width:70px;" property="bean/passport_validity_to" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="status_name"/></td>
            <td class="td_2 ">
                <select name="credentials_status_id" id="credentials_status_id" >
                </select>
            </td>
            <td class="td_1" ><fmt:message key="emp_nature"/></td>
            <td class="td_2 ">
                <%=RmJspHelper.getSelectField("emp_nature_bd",-1,"EMP_NATURE_BD",resultVo.getEmp_nature_bd(),"",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="sex"/></td>
            <td class="td_2 ">
                <%=RmJspHelper.getSelectField("sex_bd",-1,"SEX_BD",resultVo.getSex_bd(),"",true) %>
            </td>
            <td class="td_1" ><fmt:message key="route_date1"/></td>
            <td class="td_2 ">
                <w:date allowInput="false" id="route_date_from" name="route_date_from" format="YYYY-MM-DD" style="width:70px;" property="bean/route_date_from" />
                &nbsp;<fmt:message key="to"/>&nbsp;
                <w:date allowInput="false" id="route_date_to" name="route_date_to" format="YYYY-MM-DD" style="width:70px;" property="bean/route_date_to" />  
            </td>
        </tr>
        <tr>
            <td  class="td_1" ><fmt:message key="insurance_day"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" name="insurance_day" inputName="保险天数" value="${bean.insurance_day }"  maxLength="19" integerDigits="18" decimalDigits="0"  onblur="test9();"/>
            </td>
            <td class="td_1" ><fmt:message key="interview_time_from"/></td>
            <td class="td_2">
                <w:date allowInput="false" id="interview_time" name="interview_time" format="YYYY-MM-DD" style="width:190px;" property="bean/interview_time" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="tel"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="tel" inputName="联系电话" value="<%=resultVo.getTel() %>" maxLength="11" />
            </td>
            <td class="td_1" ><fmt:message key="e_mail"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="e_mail" inputName="邮箱" value="<%=resultVo.getE_mail() %>" maxLength="64" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="remark"/></td>
            <td colspan="3" class="td_2" >
                <textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName="备注" maxLength="1000" ><%=resultVo.getRemark() %></textarea>
            </td>
        </tr>
    </table>
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
        findStrtus();
        <%
%>


function findStrtus(){
        var credentials_status_id = document.getElementById('credentials_status_id');
        var type_id = '1000000000000000031';
        addAt(credentials_status_id,'<fmt:message key="please_choose"/>','',0);
            jQuery.getJSON("<venus:base/>/CredentialsAction.do?cmd=findCredentialsStatus&date="+new Date()+"",{"type_id":type_id},  function(json){
              for(var i = 0; i < json.saia.length; i++){
               var id=json.saia[i].id ;
                var name =json.saia[i].status_name;
                addAt(credentials_status_id,name,id,0);
            }
        });  
    }
    
    function addAt(selectCtl,optionValue,optionText,position){
         var userAgent = window.navigator.userAgent;
        if (userAgent.indexOf("MSIE") > 0) {
             var option = document.createElement("option");
                 if(optionText == '<%=resultVo.getCredentials_status_id()%>'){  
                     option.innerText = optionValue;
                     option.value = optionText;
                     selectCtl.selectedIndex = '<%=resultVo.getCredentials_status_id()%>';
                 }
                 else{
                     option.innerText = optionValue;
                     option.value = optionText;
                  }
             selectCtl.insertBefore(option, selectCtl.options[position]);
         }else{
        selectCtl.insertBefore(new Option(optionValue, optionText), selectCtl.options[position]);
        }
    } 
</script>
</fmt:bundle>
