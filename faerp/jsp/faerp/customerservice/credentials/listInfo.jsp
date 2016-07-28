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
<%@page import="gap.authority.helper.OrgHelper"%>
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
    
    function findType(){
        var credentials_type_id = document.getElementById('credentials_type_id');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        
        var credentials_status_id = document.getElementById('credentials_status_id');
        var   j=credentials_status_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_status_id.remove(i);
          }  
          
        var type_bd = document.getElementById('credentials_type_bd').value;
        //addAt(credentials_type_id,'---请选择---','',0);
        
        if(type_bd == null || type_bd==''){
            return;
        }else{
            jQuery.getJSON("<venus:base/>/CredentialsAction.do?cmd=findCredentialsType&date="+new Date()+"",{"type_bd":type_bd},  function(json){
             for(var i = 0; i < json.saia.length; i++){
              var id=json.saia[i].id ;
              var name =json.saia[i].credentials_name;
              addAt(credentials_type_id,name,id,1);
            }
        });  
        }
       
    }
    
    function reset_onClick(){
        var credentials_type_id = document.getElementById('credentials_type_id');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
          
        var credentials_status_id = document.getElementById('credentials_status_id');
        var   j=credentials_status_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_status_id.remove(i);
          }  
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

    function findStrtus(){
        var credentials_status_id = document.getElementById('credentials_status_id');
        var   j=credentials_status_id.options.length;     
          for(var   i=j-1;i>=0;i--)  
          {    
             credentials_status_id.remove(i);
          }  
          var type_id = document.getElementById('credentials_type_id').value;
          addAt(credentials_status_id,'<fmt:message key="please_choose"/>','',0);
          if(type_id == null || type_id == ''){
            return;
          }else{
            jQuery.getJSON("<venus:base/>/CredentialsAction.do?cmd=findCredentialsStatus&date="+new Date()+"",{"type_id":type_id},  function(json){
              for(var i = 0; i < json.saia.length; i++){
               var id=json.saia[i].id ;
                var name =json.saia[i].status_name;
              addAt(credentials_status_id,name,id,1);
            }
        });  
          }
    }
    
    function handle_onClick(){
     var entity1=choose_row_public("datacell1");
       //var entity1 = $id("datacell1").activeEntity;
       if(entity1!=null){
       var cardno=entity1.getProperty("emp_card_no");
       if(cardno!=null){
       document.getElementById("cardno1").value=cardno;
        var url = "<%=request.getContextPath()%>/CredentialsAction.do?cmd=simpleHandleInfo&cardno="+cardno;
        window.open(url,'','height=400px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=历史办证信息');
        //showModalCenter(url, window,"", 1024, 480, "历史办证信息"); 
         }
       }
    }
    
    function export_onClick(){
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=exportHandleInfo";
        form.submit();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       //return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
       return value;
    }
    
    function callBack(reg){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CredentialsAction.do">
<input type="hidden" name="cmd" value="simpleInfo">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="select_credentials"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
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
        <td align="left"><fmt:message key="emp_card_no"/></td>
        <td align="left">
            <input type="text" class="text_field" name="emp_card_no" value=""/>
        </td>
    </tr>            
     <tr>
        <td align="left"><fmt:message key="credentials_type_big"/></td>
        <td align="left">
            <%=RmJspHelper.getSelectField("credentials_type_bd",-1,"CREDENTIALS_TYPE_BD",""," id='credentials_type_bd' onclick='findType();'",false) %>
        </td>
        <td align="left"><fmt:message key="credentials_type_small"/></td>
        <td align="left">
            <select name="credentials_type_id" id="credentials_type_id" onclick="findStrtus();">
                <option value=""><fmt:message key="please_choose"/></option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="credentials_type_state"/></td>
        <td align="left">
            <select name="credentials_status_id" id="credentials_status_id">
                <option value=""><fmt:message key="please_choose"/></option>
            </select>
        </td>
        <td align="left"><fmt:message key="credentials_operate_state"/></td>
        <td align="left">
            <select name="is_complete">
                <option value=""><fmt:message key="please_choose"/></option>
                <option value="1"><fmt:message key="integrity"/></option>
                <option value="2"><fmt:message key="not_integrity"/></option>
             </select>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="submit_date"/></td>
        <td align="left">
            <w:date allowInput="true" id="submit_date_from" name="submit_date_from" format="YYYY-MM-DD"  width="70px"/>
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="true" id="submit_date_to" name="submit_date_to" format="YYYY-MM-DD" width="70px"/>            
        </td>
         <td align="left"><fmt:message key="finish_date"/></td>
        <td align="left">
            <w:date allowInput="true" id="finish_date_from" name="finish_date_from" format="YYYY-MM-DD" width="70px"/>
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="true" id="finish_date_to" name="finish_date_to" format="YYYY-MM-DD" width="70px"/>            
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="operate_type"/></td>
        <td align="left">
            <%=RmJspHelper.getSelectField("operate_type_bd",-1,"OPERATE_TYPE_BD","","",false) %>
        </td>
        <td align="left"><fmt:message key="create_date"/></td>
        <td align="left">
            <w:date allowInput="true" id="create_date_from" name="create_date_from" format="YYYY-MM-DD" width="70px"/>
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="true" id="create_date_to" name="create_date_to" format="YYYY-MM-DD" width="70px"/>            
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="last_update_user_id"/></td>
        <td align="left">
            <input type="text" class="text_field" name="last_update_user"  inputName="操作人" maxLength="50"/>
        </td>
        <td align="left"><fmt:message key="is_examine"/></td>
        <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_examine", -1,"IS_EXAMINE","","",false) %>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="credentials_is_finish"/></td>
        <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_finish", -1,"TrueOrFalse","","",false) %>
        </td>
        <td align="left"></td>
        <td align="left">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();reset_onClick();">
        </td>
    </tr>          
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="e">    <a href="#" onclick="javascript:export_onClick();">导出</a></li>
                    <li class="a_2"><a href="#" onClick="javascript:handle_onClick();">历史办证信息</a></li>
                </ul>
         -->
         <input class="e" type="button"   value="<fmt:message key="leading_out"/> "  <au:authorityBtn code="zjxxcx_exp" type="1"/>  onClick="export_onClick();">
          <input class="a_2" type="button"   value=" <fmt:message key="history_credentials"/>"  <au:authorityBtn code="zjxxcx_lsbzxx" type="1"/>  onClick="handle_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 <input type="hidden" id=cardno1 name="cardno1">
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/CredentialsAction.do?cmd=queryInfoData" 
  width="98%" height="319px" xpath="CredentialsVo" paramFormId="datacell_formid">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <!--   <r:field fieldName="id" label="操作" width="50px"  onRefreshFunc="setCheckboxStatus"></r:field>-->
  <r:field fieldName="employee_name" messagekey="employee_name"></r:field>
  <r:field fieldName="emp_card_no" messagekey="emp_card_no1"></r:field>
  <r:field fieldName="retinue_name" messagekey="retinue_name"></r:field>
  <r:field fieldName="retinue_card_no" messagekey="retinue_card_no"></r:field>
  <r:field fieldName="cust_name" messagekey="cust_name"></r:field>
  <r:field fieldName="credentials_type_bd" messagekey="credentials_type_bd" allowModify="false">
    <!--<d:select dictTypeId="CREDENTIALS_TYPE_BD"></d:select>
  --></r:field>
  <r:field fieldName="status_name" messagekey="credentials_type_state"></r:field>
  <r:field fieldName="submit_date" messagekey="submit_date" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="finish_date" messagekey="finish_date" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="validity" messagekey="validity" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="approve_date" messagekey="approve_date" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="get_card_date" messagekey="get_card_date" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="operate_type_bd" messagekey="operate_type" allowModify="false">
    <!--<d:select dictTypeId="OPERATE_TYPE_BD"></d:select>
  --></r:field>
  <r:field fieldName="create_date" messagekey="create_date" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="name" messagekey="last_update_user_id"></r:field>
  <r:field fieldName="is_examine" messagekey="is_examine"></r:field>
  <r:field fieldName="examine_remark" messagekey="examine_remark"></r:field>
  <r:field fieldName="remark" messagekey="remark"></r:field>
  </r:datacell>
</div>   
 

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
    jQuery(function(){
    $id("datacell1").isQueryFirst = false;
    });
</script>   
