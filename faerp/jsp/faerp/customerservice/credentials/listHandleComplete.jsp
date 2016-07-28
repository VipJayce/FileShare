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
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_status_id.remove(i);
          }  
          var type_id = document.getElementById('credentials_type_id').value;
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
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=toCredentialsHandle&id="+ids ;
        //form.submit();
        var url = "<%=request.getContextPath()%>/CredentialsAction.do?cmd=toCredentialsHandle&id="+ids+"&_ts="+(new Date()).getTime();
       window.open(url,'','height=400px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=证件办理');
        //showModalCenter(url, window, callBack, 1024, 480, "证件办理"); 
    }
    
    function finish_onClick(){
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
        var status_name = enCurEntity.getProperty('status_name');
        if(status_name == null){
            alert('<fmt:message key="please_credentials_type"/>');
        }else{
            form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=upFinishHandle&id="+ids ;
            form.submit();
        }
        
    }
    
    function export_onClick(){
        var examine=document.getElementById("examine_remark1").value;
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=exportExeclHandle&examine="+examine;
        form.submit();
    }
    
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
    
    function import_onClick(){
        var attachNameInput = document.getElementById('attachNameInput').value;
        if(attachNameInput == null || attachNameInput == ''){
            alert('<fmt:message key="please_unload"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=importHandleComplete";
        form.submit();
    }
    
    function rtnFuncCS(obj){
        document.getElementById('user_name').value=obj[0];
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    function end_onClick(){
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=endSendMail";
        form.submit();
    }
    
    function callBack(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
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
    //跳转到导入错误证件信息
    function detailError_onClick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=queryerr";
       $id("datacell_formid").submit();
    }
    //模板下载
    function toDownLoad_onclick(){
      window.location="<%=request.getContextPath()%>/CredentialsAction.do?cmd=downLoad" ;
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CredentialsAction.do">
<input type="hidden" name="cmd" value="simpleHandleComplete">
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" class="text_field" id="attackAddressInput" name="attach_address" value=""/>
<input type="hidden" class="text_field" id="attachNameInput" name="attachNameInput" value=""/> 
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
             <%=RmJspHelper.getSelectField("operate_type_bd",-1,"OPERATE_TYPE_BD","","",false) %>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="submit_date"/></td>
        <td align="left">
            <w:date allowInput="true" id="submit_date_from" name="submit_date_from" format="YYYY-MM-DD" style="width:70px" />
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="true" id="submit_date_to" name="submit_date_to" format="YYYY-MM-DD" style="width:70px"/>            
        </td>
        <td align="left"><fmt:message key="create_date"/></td>
        <td align="left">
            <w:date allowInput="true" id="create_date_from" name="create_date_from" format="YYYY-MM-DD" style="width:70px"/>
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="true" id="create_date_to" name="create_date_to" format="YYYY-MM-DD" style="width:70px"/>           
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="last_update_user_id"/></td>
        <td align="left">
            <input type="text" class="text_field" name="last_update_user_id" inputName="创建人" maxLength="50"/>
        </td>
        <td align="left"><fmt:message key="finish_date"/></td>
        <td align="left">
            <w:date allowInput="true" id="finish_date_from" name="finish_date_from" format="YYYY-MM-DD" style="width:70px"/>
            &nbsp;<fmt:message key="to"/>&nbsp;
            <w:date allowInput="true" id="finish_date_to" name="finish_date_to" format="YYYY-MM-DD" style="width:70px"/>           
        </td>
    </tr>
    <tr>
    <!--  
        <td align="left">审核是否有问题</td>
        <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_examine", -1,"IS_EXAMINE","","",false) %>
        </td>
        -->
        <td align="left"> <fmt:message key="is_history_examine"/></td>
        <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("examine_remark1", -1,"TrueOrFalse","","",false) %>
        </td>
        <td align="left"><fmt:message key="user_name"/></td>
        <td align="left">
            <r:comboSelect id="combo_cs" name="user_name" queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                 textField="name" valueField="partyId" xpath="CustServiceVo" width="200px"  messagekey="please_choose" />
        </td>
    </tr> 
     <tr>
        <td align="left"></td>
        <td align="left"></td>
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
                  <li class="bl">   <a href="#" onClick="javascript:handle_onClick();">办理</a></li>
                  <li class="g">    <a href="#" onClick="javascript:finish_onClick();">完成</a></li>
                  <li class="e_1"><a href="#" onClick="javascript:UploadFileWindow();">上传</a></li>
                  <li class="e_1"><a href="#" onClick="javascript:import_onClick();">导入</a></li>
                  <li class="e">    <a href="#" onClick="javascript:export_onClick();">导出</a></li>
                  <li class="nbl_2"><a href="#" onClick="javascript:HRreback_onClick();">人才中心反馈</a></li>
                  <li class="p_1">    <a onClick="javascript:detailError_onClick();">查看导入错误信息</a> </li>
                  //  <li class="e">    <a href="#" onClick="javascript:end_onClick();">续办提醒</a></li>
                </ul>
         -->
          <input class="bl" type="button"   value=" <fmt:message key="handle"/>"  <au:authorityBtn code="zjfw_bl" type="1"/>  onClick="handle_onClick();">
          <input class="g" type="button"   value=" <fmt:message key="integrity"/>"  <au:authorityBtn code="zjfw_wc" type="1"/>  onClick="finish_onClick();">
          <input class="e_1" type="button"   value=" <fmt:message key="unload"/>"  <au:authorityBtn code="zjfw_sc" type="1"/>  onClick="UploadFileWindow();">
          <input class="e_1" type="button"   value=" <fmt:message key="leading_in"/>"  <au:authorityBtn code="zjfw_imp" type="1"/>  onClick="import_onClick();">
          <input class="e" type="button"   value=" <fmt:message key="leading_out"/>"  <au:authorityBtn code="zjfw_exp" type="1"/>  onClick="export_onClick();">
          <input type="button"  class="p_1" value='<fmt:message key="download"/>' onClick="toDownLoad_onclick();"  />
          <input class="nbl_2" type="button"   value=" <fmt:message key="personnel_feedback"/>"  <au:authorityBtn code="zjfw_rczxfk" type="1"/>  onClick="HRreback_onClick();">
          <input class="p_1" type="button"   value=" <fmt:message key="erroneous_information"/>"    onClick="detailError_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/CredentialsAction.do?cmd=queryHandleCompleteData" 
  width="98%" height="318px" xpath="CredentialsVo" paramFormId="datacell_formid">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="id" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus"></r:field>
  <r:field fieldName="employee_name" messagekey="employee_name"></r:field>
  <r:field fieldName="emp_card_no" messagekey="emp_card_no1"></r:field>
  <r:field fieldName="retinue_name" messagekey="retinue_name"></r:field>
  <r:field fieldName="retinue_card_no" messagekey="retinue_card_no"></r:field>
  <r:field fieldName="cust_name" messagekey="cust_name"></r:field>
  <r:field fieldName="user_name" messagekey="user_name"></r:field>
  <r:field fieldName="credentials_name" messagekey="credentials_type_bd"></r:field>
  <r:field fieldName="status_name" messagekey="credentials_type_state"></r:field>
  <r:field fieldName="submit_date" messagekey="submit_date" allowModify="false">
    <w:date id="submitdate"  format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="validity" messagekey="validity" allowModify="false">
    <w:date id="validitydate" format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="approve_date" messagekey="approve_date" allowModify="false">
    <w:date id="approvedate" format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="get_card_date" messagekey="get_card_date" allowModify="false">
    <w:date  id="getcarddate" format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="operate_type_bd" messagekey="operate_type" allowModify="false">
    <d:select dictTypeId="OPERATE_TYPE_BD"></d:select>
  </r:field>
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

<script language="javascript"><!--
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
  
  $id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    var id1= entity.getProperty("id");
    handle_onClick1(id1);
}

  function handle_onClick1(ids){
        var url = "<%=request.getContextPath()%>/CredentialsAction.do?cmd=toCredentialsHandle&id="+ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=400px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=证件办理');
        //showModalCenter(url, window, callBack, 1024, 480, "证件办理"); 
    }
    
    /*
//datacell表单页面修改
 function clickIt (){
       var newsubmit = $id("submitdate").inputObject.value;
       var newvalidity = $id("validitydate").inputObject.value;
       var newapprove = $id("approvedate").inputObject.value;
       var newgetcard = $id("getcarddate").inputObject.value;
       
       var entity1 = $id("datacell1").activeEntity;
    
      if(null!=newsubmit&&!""==newsubmit){
       var submit=getDate(newsubmit);
       entity1.setProperty("submit_date", submit);
      } 
       if(null!=newvalidity&&!""==newvalidity){
       var validity=getDate(newvalidity);
       entity1.setProperty("validity", validity);
      } 
       if(null!=newapprove&&!""==newapprove){
       var approve=getDate(newvalidity);
       entity1.setProperty("approve_date", approve);
      } 
       if(null!=newgetcard&&!""==newgetcard){
       var getcard=getDate(newgetcard);
       entity1.setProperty("get_card_date", getcard);
      } 
       $id("datacell1").refreshRow($id("datacell1").activeRow);
  }
eventManager.add($id("submitdate").inputObject,"change",clickIt);
eventManager.add($id("validitydate").inputObject,"change",clickIt);
eventManager.add($id("approvedate").inputObject,"change",clickIt);
eventManager.add($id("getcarddate").inputObject,"change",clickIt);
      
        
        //保存
         function save_onClick(){
        form.action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=updateSaveHandle";
        form.submit();
        window.close();
    }
   */ 
    function HRreback_onClick(){
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
            form.action='<%=request.getContextPath()%>/CredentialsAction.do?cmd=HRreback&id='+data[0]+'&complete_remark='+data[1];
            form.submit();
    }

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
</fmt:bundle>