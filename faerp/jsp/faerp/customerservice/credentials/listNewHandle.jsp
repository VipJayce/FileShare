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
String user_id= RmJspHelper.getParty_idFromRequest(request);
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

    function toAdd_onClick(){
        //form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=toAddNewHand" ;
        //form.submit();
        var url = "<%=request.getContextPath()%>/CredentialsAction.do?cmd=toAddNewHand&_ts="+(new Date()).getTime();
        window.open(url,'','height=400px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key="add_credentials_type"/>');
       // showModalCenter(url, window, callBack, 1024, 330, "新增证件办理"); 
    }
    
     function findType(){
        var credentials_type_id = document.getElementById('credentials_type_id');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('credentials_type_bd').value;
        if(type_bd == null || type_bd==''){
            return;
        }
        
         jQuery.getJSON("<venus:base/>/CredentialsAction.do?cmd=findCredentialsType&date="+new Date()+"",{"type_bd":type_bd},  function(json){
          for(var i = 0; i < json.saia.length; i++){
           var id=json.saia[i].id ;
           var name =json.saia[i].credentials_name;
           addAt(credentials_type_id,name,id,1);
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
    
    function toupdate_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
                var      id ="";
                var bl = document.getElementsByName("checkbox_template");
                               for(var i=0;i<bl.length;i++){  //循环checkbox组
                                          if(bl[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("datacell1").dataset.get(i); 
                                                        id  = enCurEntity.getProperty("create_user_id"); 
                                             }
                                   }
       var userid="<%=user_id%>";
    if(userid!=id){
         alert('<fmt:message key="create_user_modify"/>');
         return ;
    }
     var url = "<%=request.getContextPath()%>/CredentialsAction.do?cmd=findNewHandle&id="+ids+"&_ts="+(new Date()).getTime();
     window.open(url,'','height=400px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key="modify_credentials_type"/>');
       // showModalCenter(url, window, callBack, 1024, 330, "修改证件办理"); 
        //form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=findNewHandle&id="+ids ;
        //form.submit();
   
        
    }
    
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=deleteMulti&ids=" + ids;
            form.submit();
        }
    }
    
    function complete_onClick(){
         var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }       
            form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateComplete&id=" + ids;
            form.submit();
    }
    
    function nocomplete_onClick(){
         var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
            var data = window.showModalDialog('<venus:base/>/CredentialsAction.do?cmd=toNoComplete&id='+ids+'&date='+new Date(),'','dialogHeight:225px;dialogWidth:300px;center:yes;help:no;resizable:no;scroll:no;status:no;');
            if(data == undefined) return;
            form.action='<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateNoComplete&id='+data[0]+'&complete_remark='+data[1];
            form.submit();
    }
    
    function examine_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var enCurEntity = $id("datacell1").activeEntity;
        var is_complete = enCurEntity.getProperty('is_complete');
        if(is_complete=='0'){
        alert('<fmt:message key="nocomplete_perfect"/>');
        return;
        }
         form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateExamine&id=" + ids;
         form.submit();
    }
    
    function noexamine_onClick(){
         var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var enCurEntity = $id("datacell1").activeEntity;
        var is_complete = enCurEntity.getProperty('is_complete');
        if(is_complete=='0'){
        alert('<fmt:message key="select_one_record"/>');
        return;
        }
        var data = window.showModalDialog('<venus:base/>/CredentialsAction.do?cmd=toNoExamine&id='+ids+'&date='+new Date(),'','dialogHeight:225px;dialogWidth:300px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(data == undefined) return;
        form.action='<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateNoExamine&id='+data[0]+'&examine_remark='+data[1];
        form.submit();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    function callBack(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function rtnFuncCS(obj){
        document.getElementById('user_name').value=obj[0];
    }
    function reset_onClick(){
     var credentials_type_id = document.getElementById('credentials_type_id');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CredentialsAction.do">
<input type="hidden" name="cmd" value="simpleNewHandle">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
<div id="right">
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
            <select name="credentials_type_id" id="credentials_type_id" >
                <option value=""><fmt:message key="please_choose"/></option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="operate_type"/></td>
        <td align="left">
            <%=RmJspHelper.getSelectField("operate_type_bd",-1,"OPERATE_TYPE_BD","","",false) %>
        </td>
        <td align="left"><fmt:message key="create_date"/></td>
        <td align="left">
            <w:date allowInput="true" id="create_date_from" name="create_date_from" format="YYYY-MM-DD" style="width:70px;" />
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="true" id="create_date_to" name="create_date_to" format="YYYY-MM-DD" style="width:70px;"/>            
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="user_name"/></td>
        <td align="left" >
            <w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" 
                lookupUrl="/CustServiceAction.do?cmd=toCustService" messagekey="choose_user_name"  
                height="500" width="450" />
            <input type="hidden" id="user_name" name="user_name">
        </td>
        <td align="left"><fmt:message key="last_update_user_id"/></td>
        <td align="left">
            <input type="text" class="text_field" name="last_update_user_id" inputName="创建人" maxLength="50"/>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="is_examine"/></td>
        <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_examine", -1,"IS_EXAMINE","","",false) %>
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
 <div class="button_right"><!--
                <ul>
                  <li class="c">        <a href="#" onClick="javascript:toAdd_onClick();">新增</a></li>
                  <li class="b">       <a href="#" onClick="javascript:toupdate_onClick();">修改</a></li>
                  <li class="bl_1">  <a href="#" onclick="javascript:complete_onClick();">信息完整</a></li>
                  <li class="nbl_2"><a href="#" onClick="javascript:nocomplete_onClick();">信息不完整</a></li>
                  <li class="d">       <a href="#" onclick="javascript:deleteMulti_onClick();">删除</a></li>           
                  <li class="nbl_2"><a href="#" onClick="javascript:noexamine_onClick();">审核有问题</a></li>
                  <li class="nbl_2"><a href="#" onClick="javascript:examine_onClick();">审核没有问题</a></li>
                </ul>
         -->
          <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="zjfw_add" type="1"/>  onClick="toAdd_onClick();">
          <input class="b" type="button"   value=" <fmt:message key="modify"/>"  <au:authorityBtn code="zjfw_xg" type="1"/>  onClick="toupdate_onClick();">
          <input class="bl_1" type="button"   value="<fmt:message key="complete"/>"  <au:authorityBtn code="zjfw_xxwz" type="1"/>  onClick="complete_onClick();">
          <input class="nbl_2" type="button"   value=" <fmt:message key="nocomplete"/>"  <au:authorityBtn code="zjfw_xxbwz" type="1"/>  onClick="nocomplete_onClick();">
          <input class="d" type="button"   value=" <fmt:message key="delete"/>"  <au:authorityBtn code="zjfw_del" type="1"/>  onClick="deleteMulti_onClick();">
          <input class="nbl_2" type="button"   value="<fmt:message key="noexamine"/> "  <au:authorityBtn code="zjfw_shywt" type="1"/>  onClick="noexamine_onClick();">
          <input class="nbl_1" type="button"   value=" <fmt:message key="examine"/>"  <au:authorityBtn code="zjfw_shmwt" type="1"/>  onClick="examine_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/CredentialsAction.do?cmd=queryNewHandData" 
  width="98%" height="320px" xpath="CredentialsVo" paramFormId="datacell_formid">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="id"  messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus"></r:field>
  <r:field fieldName="employee_name" messagekey="employee_name"></r:field>
  <r:field fieldName="emp_card_no" messagekey="emp_card_no1"></r:field>
  <r:field fieldName="retinue_name" messagekey="retinue_name"></r:field>
  <r:field fieldName="retinue_card_no" messagekey="retinue_card_no"></r:field>
  <r:field fieldName="cust_name" messagekey="cust_name"></r:field>
  <r:field fieldName="user_name" messagekey="user_name"></r:field>
  <r:field fieldName="credentials_type_bd" messagekey="credentials_type_big" allowModify="false">
    <d:select dictTypeId="CREDENTIALS_TYPE_BD"></d:select>
  </r:field>
  <r:field fieldName="credentials_name" messagekey="credentials_type_small"></r:field>
  <r:field fieldName="name" messagekey="name"></r:field>
  <r:field fieldName="operate_type_bd" messagekey="operate_type" allowModify="false">
    <d:select dictTypeId="OPERATE_TYPE_BD"></d:select>
  </r:field>
  <r:field fieldName="create_date" messagekey="create_date" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="is_examine" messagekey="is_examine" allowModify="false">
    <d:select dictTypeId="TrueOrFalse"></d:select>
  </r:field>
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
</script>   
