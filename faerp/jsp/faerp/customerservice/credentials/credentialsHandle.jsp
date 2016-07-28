<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%
Map map = (Map)request.getAttribute("map");
%>
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function save_onClick(){
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateSaveHandle";
        form.submit();
        window.close();
        window.opener.callBack();
    }
    
    function finish_onClick(){
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateFinishHandle";
        form.submit();
        window.close();
        window.opener.callBack();
         //var url = "<%=request.getContextPath()%>/CredentialsAction.do?cmd=toHandleEmail&ts="+(new Date()).getTime();
        //showModalCenter(url, window, callBack, 360,240, "发送邮件"); 
    }
</script>
</head>
<body>

<form name="form" method="post">
<input type="hidden" class="text_field" id="sendName" name="sendName"/>
<input type="hidden" class="text_field" id="mailSend" name="mailSend" />
<input type="hidden" class="text_field" id="mailText" name="mailText" />
<div id="right">
<div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
            <td class="td_1" ><fmt:message key="employee_name1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="employee_name" readonly="readonly" inputName="雇员姓名" value="<%=map.get("employee_name") %>" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="emp_card_no"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_card_no" readonly="readonly" inputName="员工证件号" value="<%=map.get("emp_card_no") %>" maxLength="64" />
            </td>
      </tr>
       <tr>
            <td class="td_1" ><fmt:message key="retinue_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  readonly="readonly" inputName="随员姓名" value="<%=map.get("retinue_name") %>" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="retinue_card_no1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  readonly="readonly" inputName="随员证件号码" value="<%=map.get("retinue_card_no") %>" maxLength="64" />
            </td>
        </tr> 
        <tr>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  readonly="readonly" inputName="公司名称" value="<%=map.get("cust_name") %>" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="operate_type"/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field"  readonly="readonly" inputName="操作类型" value="<%=BaseDataHelper.getNameByCode("OPERATE_TYPE_BD",String.valueOf(map.get("operate_type_bd")))%>" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="credentials_big"/></td>
            <td class="td_2">
                <input type="text" class="text_field"  readonly="readonly" inputName="证件办理大类" value="<%=BaseDataHelper.getNameByCode("CREDENTIALS_TYPE_BD",String.valueOf(map.get("credentials_type_bd"))) %>" />
            </td>
            <td class="td_1"><fmt:message key="credentials_small"/></td>
            <td class="td_2">
                <input type="text" class="text_field"  readonly="readonly" inputName="证件办理大类" value="<%=map.get("credentials_name") %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="talent_center"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="talent_center" inputName="受理点" value="<%=map.get("talent_center") %>" maxLength="64" />
            </td>
            <td class="td_1"><fmt:message key="credentials_type_state"/></td>
            <td class="td_2">
                 <select name="credentials_status_id" id="credentials_status_id">
                    
                 </select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="submit_date"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="submit_date" name="submit_date" format="YYYY-MM-DD" property="map/submit_date"/>                
            </td>
            <td class="td_1" ><fmt:message key="get_card_date"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="get_card_date" name="get_card_date" format="YYYY-MM-DD" property="map/get_card_date"/>                
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="approve_date"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="approve_date" name="approve_date" format="YYYY-MM-DD" property="map/approve_date"/>               
            </td>
            <td class="td_1" ><fmt:message key="validity"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="validity" name="validity" format="YYYY-MM-DD" property="map/validity"/>                
            </td>
        </tr>
</table>
 
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:save_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="finish"/>' onClick="javascript:finish_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="<%=map.get("id") %>">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
    findStrtus();
    function addAt(selectCtl,optionValue,optionText,position){
         var userAgent = window.navigator.userAgent;
        if (userAgent.indexOf("MSIE") > 0) {
             var option = document.createElement("option");
             if(optionText == '<%=map.get("credentials_status_id")%>'){
                option.innerText = optionValue;
                option.value = optionText;
                selectCtl.selectedIndex = '<%=map.get("credentials_status_id")%>';
             }else{
                option.innerText = optionValue;
                option.value = optionText;
             }            
             selectCtl.insertBefore(option, selectCtl.options[position]);
         }else{
        selectCtl.insertBefore(new Option(optionValue, optionText), selectCtl.options[position]);
        }
    } 

    function findStrtus(){
          var credentials_status_id = document.getElementById('credentials_status_id');
          var type_id ='<%=map.get("type_id").toString().trim()%>';
            jQuery.getJSON("<venus:base/>/CredentialsAction.do?cmd=findCredentialsStatus&date="+new Date()+"",{"type_id":type_id},  function(json){
              for(var i = 0; i < json.saia.length; i++){
               var id=json.saia[i].id ;
                var name =json.saia[i].status_name;
              addAt(credentials_status_id,name,id,0);
            }
        });  
          
    }
</script>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>