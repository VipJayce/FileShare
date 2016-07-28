<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listModifyEmpsecurity_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listModifyEmpsecurity0000'/></title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listModifyEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数<fmt:message key='listModifyEmpsecurity0004'/>
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listModifyEmpsecurity0004'/>
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
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listModifyEmpsecurity0060'/><fmt:message key='listModifyEmpsecurity0010'/>页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listModifyEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  

    //检查<fmt:message key='listModifyEmpsecurity0006'/>没<fmt:message key='listModifyEmpsecurity0006'/>选择行,<fmt:message key='listModifyEmpsecurity0008'/>,<fmt:message key='listModifyEmpsecurity0009'/>“<fmt:message key='listModifyEmpsecurity0010'/>”<fmt:message key='listModifyEmpsecurity0011'/>
    function checkSelections(checkboxName) {
        var elementCheckbox = document.getElementsByName(checkboxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listModifyEmpsecurity0004'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                if(enCur.getProperty("security_status_bd")!='3'){
                    alert("<fmt:message key='listModifyEmpsecurity0013'/>");
                    return false;
                }
                if(enCur.getProperty("insert_back_reason")==null||enCur.getProperty("insert_back_reason")==""){
                    alert("<fmt:message key='listModifyEmpsecurity0014'/>");
                    return false;
                }
            }
        }
        return true;
    }
    //简单的模糊查询
    function simpleQuery_onClick(){  
        //$id("com2").refresh();
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
    
//操作
//<fmt:message key='listModifyEmpsecurity0067'/>
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listModifyEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

//停办
function stop_onClick(){
     if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('<fmt:message key='listModifyEmpsecurity0018'/>')) {
                $id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}

//<fmt:message key='listModifyEmpsecurity0070'/>openFailed_onClick(
function openFailed_onClick(){
    if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm("<fmt:message key='listModifyEmpsecurity0019'/>")) {
                //$id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}
//进入<fmt:message key='listModifyEmpsecurity0010'/>页面
function modify_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listModifyEmpsecurity0006'/>2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0]+"&isModify=1";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listModifyEmpsecurity0000'/>');
    //showModalCenter(url, window, callBack, 1024, 500, "<fmt:message key='listModifyEmpsecurity0000'/>");
}

//<fmt:message key='listModifyEmpsecurity0068'/>页面
function show_detail_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listModifyEmpsecurity0006'/>2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0]+"&isModify=2&viewtype=1";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listModifyEmpsecurity0030'/>');
    //showModalCenter(url, window, callBack, 1024, 500, "<fmt:message key='listModifyEmpsecurity0030'/>");
}

function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        setTimeout(simpleQuery_onClick,4000);
    }
}

     //<fmt:message key='listModifyEmpsecurity0075'/>
 function exportExcel_onClick(){  //<fmt:message key='listModifyEmpsecurity0075'/>Excel
       var queryType=document.getElementById("queryType").value;
       // var stopType=document.getElementById("stopType").value;
       var group_id=document.getElementById("security_group_id").value;
       form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcel7&queryType="+queryType+"&stopType="+""+"&group_id="+group_id;
       form.submit();
}
     //查看<fmt:message key='listModifyEmpsecurity0032'/>
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '<fmt:message key='listModifyEmpsecurity0032'/>');  //查看<fmt:message key='listModifyEmpsecurity0032'/>
        window.open('<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id='+id+'&flag=true','','height=830px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" id="Method" name="Method" value=""/>
<!--<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_2 %>">-->
<input type="hidden" id="queryType" name="queryType" value="modify"/>
<div id="right">
<script language="javascript">
   <%
  String security_type=request.getParameter("security_type");
if(security_type.equals("1")){
%>
   writeTableTopFesco("<fmt:message key='listModifyEmpsecurity0000'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    <%
}
if(security_type.equals("2")){
    %>
   writeTableTopFesco("<fmt:message key='listModifyEmpsecurity0034'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    <%
}
if(security_type.equals("3")){
    %>
   writeTableTopFesco("<fmt:message key='listModifyEmpsecurity0035'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    <%
}
%>
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
              <td align="right"><fmt:message key='listModifyEmpsecurity1000'/></td>
              <td align="left">
                    <select id="security_group_id" name="security_group_id" style="width: 205px" >
                       <c:choose>
                            <c:when test="${param.security_type=='1'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listModifyEmpsecurity0036'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='2'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key='listModifyEmpsecurity0037'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='3'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key='listModifyEmpsecurity0038'/></option>
                            </c:when>
                        </c:choose>
                    </select>
              </td>
              <td align="right"><fmt:message key='listModifyEmpsecurity0039'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listModifyEmpsecurity0039'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listModifyEmpsecurity0041'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listModifyEmpsecurity0041'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listModifyEmpsecurity0043'/></td>
              <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listModifyEmpsecurity0041'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
              <td align="right"><fmt:message key='listModifyEmpsecurity0045'/></td>
              <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="<fmt:message key='listModifyEmpsecurity0041'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listModifyEmpsecurity0047'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listModifyEmpsecurity0047'/>" maxLength="64" size="25"/>
            </td>
            <td align="right"><fmt:message key='listModifyEmpsecurity0049'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listModifyEmpsecurity0049'/>" maxLength="50" size="25"/>
            </td>
              <td align="right"><fmt:message key='listModifyEmpsecurity0051'/></td>
              <td align="left">
                <input type="text" class="text_field" name="receive_cs_name" inputName="<fmt:message key='listModifyEmpsecurity0041'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listModifyEmpsecurity0053'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_account" inputName="<fmt:message key='listModifyEmpsecurity0041'/>" maxLength="20" size="25"/>
            </td>
            <td align="right"><fmt:message key='listModifyEmpsecurity0055'/></td>
            <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                        queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                        textField="hire_unit_short_name" 
                        valueField="id" 
                        xpath="SocialunitVo"
                        nullText=''
                        width="205px">
                    </r:comboSelect> 
            </td>
            <td align="right"><fmt:message key='listModifyEmpsecurity0011'/></td>
            <td align="left">
                    <d:select name="security_status_bd" dictTypeId="SECU_MODIFY_STA" nullLabel="" style="width: 205px"/>
              </td>
              <td align="right"><fmt:message key='listModifyEmpsecurity0059'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="transact_date_from" size="8"/><fmt:message key='listModifyEmpsecurity0060'/><w:date format="yyyy-MM-dd" name="transact_date_to" size="8" />
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listModifyEmpsecurity0061'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="stop_date_from" size="8"/><fmt:message key='listModifyEmpsecurity0060'/><w:date format="yyyy-MM-dd" name="stop_date_to" size="8" />
            </td>
             <td align="right"><fmt:message key='listModifyEmpsecurity0063'/></td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER" name="order_type"  nullLabel="" style="width: 205px"/>
            </td>
            <td align="right"><fmt:message key='listModifyEmpsecurity0065'/></td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="" style="width: 205px"/>
            </td>
            <td align="left" colspan="2">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
                    <div class="button_right">
                        <!--<ul>
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listModifyEmpsecurity0067'/> </a> </li>
                            <li class="a_2">       <a  onClick="javascript:show_detail_onClick();"><fmt:message key='listModifyEmpsecurity0068'/> </a> </li>
                            <li class="bl_1">      <a  onClick="javascript:modify_onClick();"><fmt:message key='listModifyEmpsecurity0010'/></a></li>
                            <li class="f_1">       <a  onClick="javascript:openFailed_onClick();"><fmt:message key='listModifyEmpsecurity0070'/></a></li>
                        </ul>
                    -->
                     <input class="a_2" type="button"   value="<fmt:message key='listModifyEmpsecurity0067'/>"  <au:authorityBtn code="view_orderItem11" type="1"/>  onClick="detail_onClick();">  
                    <input class="a_2" type="button"   value="<fmt:message key='listModifyEmpsecurity0068'/>"  <au:authorityBtn code="sbxg_viewItem" type="1"/>  onClick="show_detail_onClick();">  
                    <input class="bl_1" type="button"   value="<fmt:message key='listModifyEmpsecurity0010'/>"  <au:authorityBtn code="sbxg_modify" type="1"/>  onClick="modify_onClick();">  
                    <input class="f_1" type="button"   value="<fmt:message key='listModifyEmpsecurity0070'/>"  <au:authorityBtn code="sbxg_khsb" type="1"/>  onClick="openFailed_onClick();">  
                    <input class="e" type="button"   value=" <fmt:message key='listModifyEmpsecurity0075'/>"   onClick="exportExcel_onClick();">
                    </div>
                </div>                    
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=modifySimpleQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=openFailed" width="98%"
        xpath="EmpsecurityVo"
        submitXpath="EmpsecurityVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" messagekey='listModifyEmpsecurity0041' sortAt="none" width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" messagekey='listModifyEmpsecurity0039' sortAt="none" width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      
      <r:field fieldName="id_card_type_bd" messagekey='listModifyEmpsecurity0078' sortAt="none" width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" messagekey='listModifyEmpsecurity0079' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_code" messagekey='listModifyEmpsecurity0047' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" messagekey='listModifyEmpsecurity0049' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" messagekey='listModifyEmpsecurity0051' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_big_type_name" messagekey='listModifyEmpsecurity0083' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_small_type_name" messagekey='listModifyEmpsecurity0084' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="social_unit_name" messagekey='listModifyEmpsecurity0055' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_man" messagekey='listModifyEmpsecurity0086' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_date" messagekey='listModifyEmpsecurity0059' sortAt="none" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="transact_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="transact_type_name" messagekey='listModifyEmpsecurity0088' sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="start_month" messagekey='listModifyEmpsecurity0089' sortAt="none" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="fund_month" messagekey='listModifyEmpsecurity0090' sortAt="none" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
         <r:field fieldName="feedback_info" label="精灵之手备注" width="100px" allowModify="false"></r:field>
      
      <r:field fieldName="pay_base" messagekey='listModifyEmpsecurity0091' sortAt="none" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="security_status_bd" messagekey='listModifyEmpsecurity0011' sortAt="none" width="100px" allowModify="false">
            <d:select dictTypeId="SECURITY_STATUS_BD" nullLabel=""/>      
      </r:field>
      
      <r:field fieldName="stop_date" messagekey='listModifyEmpsecurity0061' sortAt="none" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="stop_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="stop_man" messagekey='listModifyEmpsecurity0095' sortAt="none" width="100px" allowModify="false">
            
      </r:field>
      
      <r:field fieldName="stop_reason_bd" messagekey='listModifyEmpsecurity0096' sortAt="none" width="100px" allowModify="false">
            <d:select dictTypeId="OFF_POST_REASON" nullLabel=""/>  
      </r:field>
      
      <r:field fieldName="insert_back_reason" sortAt="none" messagekey='listModifyEmpsecurity0098' width="100px" >
            <h:text />      
      </r:field>
      
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
</fmt:bundle>
</html>

<script language="javascript">

    //解决<fmt:message key='listModifyEmpsecurity0010'/>行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell<fmt:message key='listModifyEmpsecurity0099'/>
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

    //实现beforeEdit<fmt:message key='listModifyEmpsecurity0100'/>
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        //alert(city_id);
        if (colIndex == 14){
            var combo1 = $id("com1");
            combo1.addParam("security_group_id",security_group_id);
            combo1.loadData();
            combo1.refresh();
        }
        return true;
    }
       /*  
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
    //忽略datacell的<fmt:message key='listModifyEmpsecurity0010'/>
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
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listModifyEmpsecurity0004'/>
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
   
</script>   
