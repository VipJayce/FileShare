<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listOtherTransactionEmpsecurity_resource' prefix='auto.'>
<head>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listOtherTransactionEmpsecurity0000'/></title>
<script language="javascript">

function citySecurityGroupchange(seletvalue){
      var group_type = $id("group_type").value;
      SecurityGroupAjax.getSecurityGroupbyCitys(seletvalue,group_type,{callback:function(data){
                    setSelectForBean("security_group_id",data,"id","group_name","");
                }
            });
    }
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listOtherTransactionEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                //alert(elementCheckbox[i].value);
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                number += 1;  //游标加1
               if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listOtherTransactionEmpsecurity0065'/><fmt:message key='listOtherTransactionEmpsecurity0012'/>页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listOtherTransactionEmpsecurity0006'/>2<fmt:message key='listOtherTransactionEmpsecurity0007'/>
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"<fmt:message key='listOtherTransactionEmpsecurity0009'/>"
            form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function toAdd_onClick() {  //<fmt:message key='listOtherTransactionEmpsecurity0065'/>增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/empserviceitem/insertEmpserviceitem.jsp";
        form.submit();
    }
    //检查<fmt:message key='listOtherTransactionEmpsecurity0006'/>没<fmt:message key='listOtherTransactionEmpsecurity0006'/>选择行,<fmt:message key='listOtherTransactionEmpsecurity0010'/>,并且把选择行对象<fmt:message key='listOtherTransactionEmpsecurity0013'/>改成“<fmt:message key='listOtherTransactionEmpsecurity0012'/>”<fmt:message key='listOtherTransactionEmpsecurity0013'/>
    function checkSelections(checkboxName) {  
        var elementCheckbox = document.getElementsByName(checkboxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                //alert(enCur.getProperty("social_unit_id")+"--"+enCur.getProperty("is_social_not_stop")+"--"+enCur.getProperty("social_copy_month"));
                if(enCur.getProperty("insert_back_reason")==null||enCur.getProperty("insert_back_reason")==""){
                    alert(enCur.getProperty("emp_name")+" <fmt:message key='listOtherTransactionEmpsecurity0015'/>");
                    return false;
                }
            }
        }
        if(ids==null){
            alert("<fmt:message key='listOtherTransactionEmpsecurity0016'/>");
            return false;
        }
        return true;
    }
     //提交社保申请
    function apply_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('<fmt:message key='listOtherTransactionEmpsecurity0017'/>')) {
                $id('applyMethod').value="apply";
                $id("datacell1").submit();//提交       
            }    
    }

    //简单的模糊查询
    function simpleQuery_onClick(){  
        //$id("com2").refresh();
        var security_group_id= $name('security_group_id').value;
        if(security_group_id==''){
            alert("<fmt:message key='listOtherTransactionEmpsecurity0018'/>");
            return;
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + " />";
    }
    
    function changeCheck(rowNo,checkB){
        //alert(checkB.value + "" + rowNo);
        //alert(rowNo);
        var enCur = $id("datacell1").dataset.get(rowNo);
        $id("datacell1").isModefied = true;
        enCur.status = Entity.STATUS_MODIFIED;
    }
    
    function ClickRow(value,value1){
        //document.getElementById("div1").style.display='';
        //alert("id="+value+"city_id="+value1);
        $id("security_group_id").value = value;
        $id("selectcity_id").value = value1;
        
        $id("product_id").queryParam= "<param><key>security_group_id</key><value>" + value + "</value><key>city_id</key><value>" + value1 + "</value></param>";
       
        $id("celllist1").loadData();
        //$id("celllist1").refresh();
        $id("product_id").loadData();
        $id("product_id").refresh();
        $id("celllist1").refresh();
        
        
        
        $id("celllist2").loadData();
        $id("celllist2").refresh();
        
        $id("celllist3").loadData();
        $id("celllist3").refresh();
    }
    
    
//操作
//<fmt:message key='listOtherTransactionEmpsecurity0070'/>
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listOtherTransactionEmpsecurity0006'/>2<fmt:message key='listOtherTransactionEmpsecurity0007'/>
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
//<fmt:message key='listOtherTransactionEmpsecurity0071'/>界面
function in_Transaction_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listOtherTransactionEmpsecurity0006'/>2<fmt:message key='listOtherTransactionEmpsecurity0007'/>
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
   //如果员工<fmt:message key='listOtherTransactionEmpsecurity0027'/>两条待办记录则给用户提示
    var entity = $id("datacell1").dataset.findEntity("id", ids[0]);
    //alert(entity.getProperty("security_group_id"));
    var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkRepeatEmp");
    myAjax.addParam("emp_id", entity.getProperty("emp_id"));
    myAjax.addParam("security_group_id", entity.getProperty("security_group_id"));
    myAjax.addParam("emp_post_id", entity.getProperty("emp_post_id"));
    myAjax.submit();
    var returnNode = myAjax.getResponseXMLDom();
    if( returnNode ) {
          if(myAjax.getProperty("returnValue")=="ordererror"){
            alert(entity.getProperty("emp_name")+' <fmt:message key='listOtherTransactionEmpsecurity0025'/>');
            return;
          }
          else if(myAjax.getProperty("returnValue")=="updateerror"){
            alert(entity.getProperty("emp_name")+' <fmt:message key='listOtherTransactionEmpsecurity0026'/>');
            return;
          }
          else if(myAjax.getProperty("returnValue")>1){
            if(confirm(entity.getProperty("emp_name")+' <fmt:message key='listOtherTransactionEmpsecurity0027'/>'+myAjax.getProperty("returnValue")+'<fmt:message key='listOtherTransactionEmpsecurity0028'/>')){
                window.open('<venus:base/>/EmpsecurityAction.do?cmd=getEmpSecurityById&id='+ids[0],'','height=600px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
            }
          }else{
            window.open('<venus:base/>/EmpsecurityAction.do?cmd=getEmpSecurityById&id='+ids[0],'','height=600px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
          }
     }
}

function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        setTimeout(simpleQuery_onClick,4000);
    }
}
//批量退回操作
function batch_back_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('<fmt:message key='listOtherTransactionEmpsecurity0029'/>')) {
                $id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}
//批量<fmt:message key='listOtherTransactionEmpsecurity0074'/>
function batch_cancel_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key='listOtherTransactionEmpsecurity0031'/>')) {
                $id('Method').value="batchcancel";
                $id("datacell1").submit();//提交       
        }    
    }
    
   //<fmt:message key='listOtherTransactionEmpsecurity0073'/>
   function batch_transaction_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        //先判断是否<fmt:message key='listOtherTransactionEmpsecurity0006'/>问题数据<fmt:message key='listOtherTransactionEmpsecurity0027'/>
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            //如果员工<fmt:message key='listOtherTransactionEmpsecurity0027'/>两条待办记录则给用户提示
            var entity = $id("datacell1").dataset.findEntity("id", ids[i]);
            var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkRepeatEmp");
            myAjax.addParam("emp_id", entity.getProperty("emp_id"));
            myAjax.addParam("security_group_id", entity.getProperty("security_group_id"));
            myAjax.addParam("emp_post_id", entity.getProperty("emp_post_id"));
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            var isali = true;
            if( returnNode ) {
                  if(myAjax.getProperty("returnValue")=="ordererror"){
                    alert(entity.getProperty("emp_name")+' <fmt:message key='listOtherTransactionEmpsecurity0025'/>');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")=="ishaveerror"){
                    alert(entity.getProperty("emp_name")+' <fmt:message key='listOtherTransactionEmpsecurity0035'/>');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")=="updateerror"){
                    alert(entity.getProperty("emp_name")+' <fmt:message key='listOtherTransactionEmpsecurity0026'/>');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")>1){
                    if(!confirm(entity.getProperty("emp_name")+' <fmt:message key='listOtherTransactionEmpsecurity0027'/>'+myAjax.getProperty("returnValue")+'<fmt:message key='listOtherTransactionEmpsecurity0028'/>')){
                        isali = true;
                    }else{
                        isali = false;
                        return;
                    }
                  }else{
                       isali = true;
                  }
                  //验证全部通过
                  if(isali){
                       if(confirm('<fmt:message key='listOtherTransactionEmpsecurity0039'/>')) {
                            $id('Method').value="batchtransaction";
                            $id("datacell1").submit();//提交       
                        }
                  }else{
                       break;
                       return;
                  }
                  
             }
            
        }
   }
//<fmt:message key='listOtherTransactionEmpsecurity0075'/>所选备注
function save_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key='listOtherTransactionEmpsecurity0041'/>');
            return;
        }
        $id('Method').value="saveremark";
        $id("datacell1").submit();//提交       

}

//<fmt:message key='listOtherTransactionEmpsecurity0076'/>excel
    function exportExcel_onClick(){  //<fmt:message key='listOtherTransactionEmpsecurity0076'/>Excel
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do";
        form.cmd.value = "exportExcel";
        form.submit();
    } 
    
     //查看<fmt:message key='listOtherTransactionEmpsecurity0042'/>
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '<fmt:message key='listOtherTransactionEmpsecurity0042'/>');  //查看<fmt:message key='listOtherTransactionEmpsecurity0042'/>
        window.open('<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id='+id+'&flag=true','','height=830px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_2 %>">
<input type="hidden" id="Method" name="Method" value=""/>
<input type="hidden" id="queryType" name="queryType" value="transact"/>
<input type="hidden" id="group_type" value="${param.group_type }">
<div id="right">
<script language="javascript">
    <c:choose>
                            <c:when test="${param.group_type=='1'}">
                               writeTableTopFesco('<fmt:message key='listOtherTransactionEmpsecurity0000'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                            <c:when test="${param.group_type=='2'}">
                                 writeTableTopFesco('<fmt:message key='listOtherTransactionEmpsecurity0044'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                           
                             
          </c:choose>
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
              <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0051'/></td>
              <td align="left">
                    <select id="security_group_id" name="security_group_id" style="width: 205px" >
                       <c:choose>
                            <c:when test="${param.security_type=='1'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listOtherTransactionEmpsecurity0045'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='2'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key='listOtherTransactionEmpsecurity0046'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='3'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key='listOtherTransactionEmpsecurity0047'/></option>
                            </c:when>
                        </c:choose>
                    </select>
              </td>
              <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0048'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listOtherTransactionEmpsecurity0048'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0050'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listOtherTransactionEmpsecurity0050'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0052'/></td>
              <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listOtherTransactionEmpsecurity0050'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0054'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listOtherTransactionEmpsecurity0054'/>" maxLength="64" size="25"/>
            </td>
            <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0056'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listOtherTransactionEmpsecurity0056'/>" maxLength="50" size="25"/>
            </td>
            <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0058'/></td>
            <td align="left">
                <r:comboSelect id="com1" name="transact_type_id" 
                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
                    textField="type_name" 
                    valueField="id" 
                    xpath="SecuritygroupnewVo"                   
                    messagekey='listOtherTransactionEmpsecurity0059'
                    width="205px">
                    <h:param name="security_group_id" value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"/>
                </r:comboSelect>
            </td>
            <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0060'/></td>
            <td align="left">
                    <d:select name="post_status_bd" dictTypeId="POST_STATUS_BD"  nullLabel="--请选择--" style="width: 205px"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0062'/></td>
              <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                messagekey='listOtherTransactionEmpsecurity0059'
                width="205px">
            </r:comboSelect> 
              </td>
            <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0064'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_date_from" size="8"/><fmt:message key='listOtherTransactionEmpsecurity0065'/><w:date format="yyyy-MM-dd" name="apply_date_to" size="8" />
            </td>
             <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0053'/></td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER" name="order_type"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
             <td align="right"><fmt:message key='listOtherTransactionEmpsecurity0055'/></td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="7">
                
            </td>
            <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
                    <div class="button_right">
                        <!--<ul>
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listOtherTransactionEmpsecurity0070'/> </a> </li>
                            <li class="bl_1">      <a onClick="javascript:in_Transaction_onClick();"><fmt:message key='listOtherTransactionEmpsecurity0071'/> </a></li>
                            <li class="pl">      <a onClick="javascript: batch_back_onClick();"><fmt:message key='listOtherTransactionEmpsecurity0072'/> </a></li>
                            <li class="h_1">      <a onClick="javascript:batch_transaction_onClick();"><fmt:message key='listOtherTransactionEmpsecurity0073'/> </a></li>
                            <li class="h_1">       <a  onClick="javascript:batch_cancel_onClick();"><fmt:message key='listOtherTransactionEmpsecurity0074'/></a> </li>
                            <li class="bc">         <a  onClick="javascript:save_onClick();"><fmt:message key='listOtherTransactionEmpsecurity0075'/> </a> </li>
                            <li class="e">         <a  onClick="javascript:exportExcel_onClick();"><fmt:message key='listOtherTransactionEmpsecurity0076'/> </a> </li>
                            <li class="dj">         <a  onClick="javascript:_onClick();"><fmt:message key='listOtherTransactionEmpsecurity0077'/> </a> </li>
                        </ul>
                    -->
                     <input class="a_2" type="button"   value=" <fmt:message key='listOtherTransactionEmpsecurity0070'/>"  <au:authorityBtn code="view_orderItem15" type="1"/>  onClick="detail_onClick();">
                     <input class="bl_1" type="button"   value=" <fmt:message key='listOtherTransactionEmpsecurity0071'/>"  <au:authorityBtn code="ydsbbl_jrbl" type="1"/>  onClick="in_Transaction_onClick();">
                     <input class="pl" type="button"   value=" <fmt:message key='listOtherTransactionEmpsecurity0072'/>"  <au:authorityBtn code="ydsbbl_plthsq" type="1"/>  onClick="batch_back_onClick();">
                     <input class="h_1" type="button"   value=" <fmt:message key='listOtherTransactionEmpsecurity0073'/>"  <au:authorityBtn code="ydsbbl_plbl" type="1"/>  onClick="batch_transaction_onClick();">
                     <input class="h_1" type="button"   value=" <fmt:message key='listOtherTransactionEmpsecurity0074'/>"  <au:authorityBtn code="ydsbbl_bxbl" type="1"/>  onClick="batch_cancel_onClick();">
                     <input class="bc" type="button"   value=" <fmt:message key='listOtherTransactionEmpsecurity0075'/>"  <au:authorityBtn code="ydsbbl_save" type="1"/>  onClick="save_onClick();">
                     <input class="e" type="button"   value=" <fmt:message key='listOtherTransactionEmpsecurity0076'/>"  <au:authorityBtn code="ydsbbl_exp" type="1"/>  onClick="exportExcel_onClick();">
                     <input class="dj" type="button"   value=" <fmt:message key='listOtherTransactionEmpsecurity0077'/>"  <au:authorityBtn code="ydsbbl_sbbsd" type="1"/>  onClick="_onClick();">
                    </div>
                </div>                    
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=transactionSimpleQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=transactionSecurity" width="99%"
        xpath="EmpsecurityVo"
        submitXpath="EmpsecurityVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" sortAt="none" messagekey='listOtherTransactionEmpsecurity0050' width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0048' width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      
      <r:field fieldName="group_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0088' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="internal_code" sortAt="none" messagekey='listOtherTransactionEmpsecurity0089' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" sortAt="none" messagekey='listOtherTransactionEmpsecurity0090' width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" messagekey="listOtherTransactionEmpsecurity0091" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="emp_post_type_bd" sortAt="none" messagekey='listOtherTransactionEmpsecurity0092' width="100px" allowModify="false">
            <d:select dictTypeId="EMP_POST_TYPE_BD"/> 
      </r:field>
      
      <r:field fieldName="cust_code" sortAt="none" messagekey='listOtherTransactionEmpsecurity0054' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0056' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0095' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="send_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0096' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_big_type_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0097' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_small_type_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0098' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_send_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0099' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_receive_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0100' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_on_post_date" sortAt="none" messagekey='listOtherTransactionEmpsecurity0101' width="100px" allowModify="false">
            <h:text />
      </r:field>
      
      <r:field fieldName="on_post_date" sortAt="none" messagekey='listOtherTransactionEmpsecurity0102' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="on_post_desc" sortAt="none" messagekey='listOtherTransactionEmpsecurity0103' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_off_post_date" sortAt="none" messagekey='listOtherTransactionEmpsecurity0104' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="serial_no" sortAt="none" messagekey='listOtherTransactionEmpsecurity0105' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_type_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0058' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="social_unit_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0062' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_man_name" sortAt="none" messagekey='listOtherTransactionEmpsecurity0108' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_date" sortAt="none" messagekey='listOtherTransactionEmpsecurity0064' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="start_month" sortAt="none" messagekey='listOtherTransactionEmpsecurity0110' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="back_reason" sortAt="none" messagekey='listOtherTransactionEmpsecurity0111' width="100px" >
            <h:text />      
      </r:field>
      
      <r:field fieldName="insert_back_reason" sortAt="none" messagekey='listOtherTransactionEmpsecurity0112' width="100px" >
            <h:text />      
      </r:field>

      <r:field fieldName="transact_remarks" sortAt="none" messagekey='listOtherTransactionEmpsecurity0113' width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="pension_base" sortAt="none" messagekey='listOtherTransactionEmpsecurity0114' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="pension_e_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0115' width="100px" allowModify="false">
            <h:text/>      
      </r:field>

      <r:field fieldName="pension_p_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0116' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="medical_base" sortAt="none" messagekey='listOtherTransactionEmpsecurity0117' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="medical_e_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0115' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="medical_p_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0116' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="unemployment_base" sortAt="none" messagekey='listOtherTransactionEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="unemployment_e_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0115' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="unemployment_p_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0116' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="industrial_base" sortAt="none" messagekey='listOtherTransactionEmpsecurity0123' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="industrial_e_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0115' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="industrial_p_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0116' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="maternity_base" sortAt="none" messagekey='listOtherTransactionEmpsecurity0126' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="maternity_e_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0115' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="maternity_p_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0116' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="disability_base" sortAt="none" messagekey='listOtherTransactionEmpsecurity0129' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="disability_e_ratio" sortAt="none" messagekey='listOtherTransactionEmpsecurity0115' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="disability_p_ratio" messagekey='listOtherTransactionEmpsecurity0116' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
    </r:datacell>
    </div>

</div>
</div>
</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">

    //解决<fmt:message key='listOtherTransactionEmpsecurity0012'/>行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell<fmt:message key='listOtherTransactionEmpsecurity0132'/>
    $id("datacell1").beforeLoadData = function(){
	    if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
	       //alert("run hear");
	       return false;
	    }
	    return true;
    }
    //后台返回的信息
    $id("datacell1").afterSubmit= function(ajax){
           alert(""+ajax.getProperty("returnValue"));
    }
    /* 
    //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        //alert(city_id);
        if (colIndex == 15){
            var combo1 = $id("com1");
            combo1.addParam("security_group_id",security_group_id);
            combo1.loadData();
            combo1.refresh();
        }
        return true;
    }
       
   //实现on updateCell
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        //alert(activeCell.getAttribute("fieldId").indexOf("service_name2"));
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("transact_type_name") >= 0){
            var activeEditor = $id("datacell1").activeEditor;
            activeEntity.setProperty("transact_type_name", activeEditor.getDisplayValue(newValue));
            activeEntity.setProperty("transact_type_id", newValue);
        }
        return true;
    }    
    //忽略datacell的<fmt:message key='listOtherTransactionEmpsecurity0012'/>
    $id("datacell1").afterEdit = function( newValue, oldValue , datacell1 ){
        $id("datacell1").isModefied = false;
    }    
   $id("datacell1").beforeRefresh = function(){
        $id("com2").refresh();
   }*/
   
   
   //解决翻页不提示数据变化
   function is_datacell_change(checkBoxName){
        var is_change = false;        
        var elementCheckbox = document.getElementsByName(checkBoxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                //alert(enCur.getProperty("social_unit_id")+"--"+enCur.getProperty("is_social_not_stop")+"--"+enCur.getProperty("social_copy_month"));
            }
        }
        //alert(ids);
        if(ids==null){
            is_change = false;
        }else{
            is_change = true;     
        }   
        return is_change;
   }
    /*
    function reload(){
        $id("datacell1").endEdit();
        var pilot = $id("datacell1_toolbar")
        //alert(datacell.dataset.get(0).getProperty("deptcode"));
        //是否变化
        var is_change = is_datacell_change("checkbox_template");
        if (is_change && confirm(DATACELL_MODIFY_CONFIRM)) {
            pilot.datacell.submit();
        } else {
            pilot.datacell.reload();
        }
        eventManager.stopBubble();
    }  
    */  
   //初始化<fmt:message key='listOtherTransactionEmpsecurity0088'/>
    citySecurityGroupchange("0571','0520"); 
</script>   