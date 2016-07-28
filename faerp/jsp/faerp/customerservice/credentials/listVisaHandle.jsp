<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.credentials.vo.CredentialsVo" %>
<%@ page import="rayoo.customerservice.credentials.util.ICredentialsConstants" %>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ICredentialsConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ICredentialsConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    CredentialsVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
   
    function toAdd_onClick(){
        //form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=toAddVisaHandle" ;
        //form.submit();
        var url = "<%=request.getContextPath()%>/CredentialsAction.do?cmd=toAddVisaHandle&_ts="+(new Date()).getTime();
        window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增签证办理');
        //showModalCenter(url, window, callBack, 1024, 480, "新增签证办理"); 
    }
    
    function toUpdate_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=toUpdateVisaHandle&id="+ids;
        //form.submit();
        var url = "<%=request.getContextPath()%>/CredentialsAction.do?cmd=toUpdateVisaHandle&id="+ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改签证办理');
        //showModalCenter(url, window, callBack, 1024, 480, "修改签证办理"); 
    }
    
    function export_onClick(){
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=exportVisaHandle";
        form.submit();
    }
    
    function toemail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var data = window.showModalDialog('<venus:base/>/CredentialsAction.do?cmd=toVisaEmail&id='+ids+'&date='+new Date(),'','dialogHeight:200px;dialogWidth:360px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(data == undefined) return;
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    function callBack(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CredentialsAction.do">
<input type="hidden" name="cmd" value="simpleVisaHandle">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="visa"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="Query_conditions"/></div> </td>
     </tr>
     <tr>
        <td align="left"><fmt:message key="employee_name"/></td>
        <td align="left">
            <input type="text" class="text_field" name="employee_name" value=""/>
        </td>
        <td align="left"><fmt:message key="emp_card_no2"/></td>
        <td align="left">
            <input type="text" class="text_field" name="emp_card_no" value=""/>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="emp_name_phonetic"/></td>
        <td align="left">
            <input type="text" class="text_field" name="emp_name_phonetic" inputName="员工姓名拼音" maxLength="64"/>
        </td>
        <td align="left"><fmt:message key="birthday_from"/></td>
        <td align="left">
            <w:date allowInput="false" id="birthday_from" name="birthday_from" format="YYYY-MM-DD" style="width:70px" />
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="false" id="birthday_to" name="birthday_to" format="YYYY-MM-DD" style="width:70px"/>           
        </td>           
    </tr>
    <tr>
        <td align="left"><fmt:message key="route_date"/></td>
        <td align="left">
            <input type="text" class="text_field" name="route_date" inputName="行程日期" maxLength="64"/>
        </td>
        <td align="left"><fmt:message key="interview_time_from"/></td>
        <td align="left">
            <w:date allowInput="false" id="interview_time_from" name="interview_time_from" format="YYYY-MM-DD" style="width:70px"/>
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="false" id="interview_time_to" name="interview_time_to" format="YYYY-MM-DD" style="width:70px"/>           
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="cust_name"/></td>
        <td align="left">
            <input type="text" class="text_field" name="cust_name" inputName="公司名称" maxLength="50"/>
        </td>
        <td align="left"><fmt:message key="credentials_type_state"/></td>
        <td align="left">
            <select name="credentials_status_id" id="credentials_status_id">
                <option value=""><fmt:message key="please_choose"/></option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left"></td>
        <td align="left"></td>
        <td align="left"></td>
        <td align="left">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
        </td>
    </tr>    
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                      <li class="c"><a href="#" onClick="javascript:toAdd_onClick();">新增</a></li>
                      <li class="b"><a href="#" onClick="javascript:toUpdate_onClick();">修改</a></li>
                      <li class="yj"><a href="#" onclick="javascript:toemail_onClick();">发送邮件</a></li>
                      <li class="e"><a href="#" onclick="javascript:export_onClick();">导出</a></li>
                </ul>              
         -->
          <input class="c" type="button"   value=" <fmt:message key="insert"/>"  <au:authorityBtn code="qzbl_add" type="1"/>  onClick="toAdd_onClick();">
          <input class="b" type="button"   value="<fmt:message key="modify"/> "  <au:authorityBtn code="qzbl_xg" type="1"/>  onClick="toUpdate_onClick();">
          <input class="yj" type="button"   value=" <fmt:message key="send_email"/>"  <au:authorityBtn code="qzbl_smail" type="1"/>  onClick="toemail_onClick();">
          <input class="e" type="button"   value=" <fmt:message key="leading_out"/>"  <au:authorityBtn code="qzbl_exp" type="1"/>  onClick="export_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/CredentialsAction.do?cmd=queryVisaHandleData" 
  width="98%" height="318px" xpath="CredentialsVo" paramFormId="datacell_formid">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="id" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus"></r:field>
  <r:field fieldName="employee_name" messagekey="employee_name"></r:field>
  <r:field fieldName="emp_card_no" messagekey="emp_card_no2"></r:field>
  <r:field fieldName="emp_name_phonetic" messagekey="emp_name_phonetic1"></r:field>
  <r:field fieldName="birthday" messagekey="birthday_from" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="cust_name" messagekey="cust_name"></r:field>
  <r:field fieldName="route_date" messagekey="route_date1"  width="160"></r:field>
  <r:field fieldName="interview_time" messagekey="interview_time_from" allowModify="false"  width="80">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="status_name" messagekey="status_name"></r:field>
  <r:field fieldName="remark" messagekey="remark"></r:field>
  </r:datacell>
<div>   
 
 
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(ICredentialsConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICredentialsConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
findStrtus();
function findStrtus(){
        var credentials_status_id = document.getElementById('credentials_status_id');
        var   j=credentials_status_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_status_id.remove(i);
          }  
          var type_id = '1000000000000000031';
   //         addAt(credentials_status_id,'---请选择---','',0);
            jQuery.getJSON("<venus:base/>/CredentialsAction.do?cmd=findCredentialsStatus&date="+new Date()+"",{"type_id":type_id},  function(json){
              for(var i = 0; i < json.saia.length; i++){
               var id=json.saia[i].id ;
                var name =json.saia[i].status_name;
              addAt(credentials_status_id,name,id,1);
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
    jQuery(function(){
    $id("datacell1").isQueryFirst = false;
    });
</script>   
