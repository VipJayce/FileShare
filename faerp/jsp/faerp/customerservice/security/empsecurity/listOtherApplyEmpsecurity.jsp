<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>

<html>
<fmt:bundle basename="rayoo.customerservice.security.empsecurity.empsecurity_resource" prefix="rayoo.customerservice.security.empsecurity.">
<head>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="yd_ss_apply"/></title>
<script language="javascript">
function citySecurityGroupchange(seletvalue){

      var group_type = $id("group_type").value;
      SecurityGroupAjax.getSecurityGroupbyCitys(seletvalue,group_type,{callback:function(data){
                    setSelectForBean("security_group_id",data,"id","group_name","");
                }
            });
    }
    
    
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listOtherApplyEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数<fmt:message key='listOtherApplyEmpsecurity0004'/>
        //alert(elementCheckbox.length);
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listOtherApplyEmpsecurity0004'/>
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
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listOtherApplyEmpsecurity0047'/><fmt:message key='listOtherApplyEmpsecurity0015'/>页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listOtherApplyEmpsecurity0006'/>2条以上的纪录
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
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"<fmt:message key='listOtherApplyEmpsecurity0009'/>"
            form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function toAdd_onClick() {  //<fmt:message key='listOtherApplyEmpsecurity0047'/>增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/empserviceitem/insertEmpserviceitem.jsp";
        form.submit();
    }

//操作
//<fmt:message key='listOtherApplyEmpsecurity0052'/>
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listOtherApplyEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
    //检查<fmt:message key='listOtherApplyEmpsecurity0006'/>没<fmt:message key='listOtherApplyEmpsecurity0006'/>选择行,<fmt:message key='listOtherApplyEmpsecurity0013'/>,并且把选择行对象<fmt:message key='listOtherApplyEmpsecurity0016'/>改成“<fmt:message key='listOtherApplyEmpsecurity0015'/>”<fmt:message key='listOtherApplyEmpsecurity0016'/>
    function checkSelections(checkboxName) {  
        var elementCheckbox = document.getElementsByName(checkboxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listOtherApplyEmpsecurity0004'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                //alert(enCur.getProperty("social_unit_id")+"--"+enCur.getProperty("is_social_not_stop")+"--"+enCur.getProperty("social_copy_month"));
                if(enCur.getProperty("social_unit_id")==null||enCur.getProperty("social_unit_id")==""){
                    alert("<fmt:message key="security_unit_id_not_null"/>")
                    return false;
                }else if(enCur.getProperty("transact_type_id")==null||enCur.getProperty("transact_type_id")==""){
                    alert( enCur.getProperty("emp_name")+ "<fmt:message key="transact_type_not_null"/> ")
                    return false;
                }
                if(enCur.getProperty("transact_type_name")!='<fmt:message key='listOtherApplyEmpsecurity0020'/>' && (enCur.getProperty("account")==null || enCur.getProperty("account")=='')){
                    alert( enCur.getProperty("emp_name")+ "<fmt:message key="fund_account_not_null"/> ")
                    return false;
                }
                //else if(enCur.getProperty("is_social_not_stop")=='1'&&enCur.getProperty("social_copy_month")==null||enCur.getProperty("social_copy_month")==''){
                //    alert(enCur.getProperty("emp_name")+" <fmt:message key='listOtherApplyEmpsecurity0022'/>");
                //    return false;
                //}else if(enCur.getProperty("transact_type_id")==null||enCur.getProperty("transact_type_id")==""){
                //    if(enCur.getProperty("apply_remark")==null||enCur.getProperty("apply_remark")==""){
                //        if(!confirm(enCur.getProperty("emp_name")+' <fmt:message key='listOtherApplyEmpsecurity0023'/>、<fmt:message key='listOtherApplyEmpsecurity0024'/>')){
                //            return false;
                //        }
                //    }
                //}
            }
        }
        if(ids==null){
            alert("<fmt:message key="select_records"/>");
            return false;
        }
        return true;
    }
     //提交社保申请
    function apply_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('<fmt:message key="sure_sbmit_apply"/>')) {
                $id('Method').value="apply";
                $id("datacell1").submit();//提交       
            }    
    }
    //<fmt:message key='listOtherApplyEmpsecurity0054'/>
    function back_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_selected_not_need_banli_ss"/>')) {
                $id('Method').value="back";
                $id("datacell1").submit();//提交       
        }    
    }
    //<fmt:message key='listOtherApplyEmpsecurity0055'/>excel
    function exportExcel_onClick(){  //<fmt:message key='listOtherApplyEmpsecurity0055'/>Excel
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do";
        form.cmd.value = "exportExcel";
        form.submit();
    }  
    
    //简单的模糊查询
    function simpleQuery_onClick(){  
        var security_group_id= $name('security_group_id').value;
        if(security_group_id==''){
            alert("<fmt:message key="please_choose_ss_group"/>");
            return;
        }
        //$id("com2").refresh();
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + ">";
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
    
    function rtnFuncEmpAccount(arg) {
     var lookup = $id("account");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            $id("datacell1").activeEntity.setProperty("account", arg[1]);
            return false;
    }
    
    function changeIt(){
        var displayValue = $id("account_input").value;       
        $id("datacell1").activeEntity.setProperty("account", displayValue);
   }
    
    //查看<fmt:message key='listOtherApplyEmpsecurity0030'/>
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '<fmt:message key='listOtherApplyEmpsecurity0030'/>');  //查看<fmt:message key='listOtherApplyEmpsecurity0030'/>
        window.open('<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id='+id+'&flag=true','','height=830px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" id="Method" name="Method" value=""/>
<input type="hidden" id="group_type" value="${param.group_type }">
<div id="right">
<script language="javascript">
    <c:choose>
                            <c:when test="${param.group_type=='1'}">
                               writeTableTopFesco('<fmt:message key="yd_ss_apply"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                            <c:when test="${param.group_type=='2'}">
                                 writeTableTopFesco('<fmt:message key="yd_fund_apply"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                                 
                            </c:when>
                           
                             
          </c:choose>
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="6" valign="middle" align="center" ><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        </tr>
              <td align="right"><fmt:message key="ss_fund_group"/></td>
              <td align="left">
                    <select id="security_group_id" name="security_group_id" style="width: 205px" >
                        
                    </select>
              </td>
              <td align="right"><fmt:message key="emp_code"/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='emp_code'/>" maxLength="9.5" size="25"/>
              </td>
              <td align="right"><fmt:message key="emp_name"/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='emp_name'/>" maxLength="9.5" size="25"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="cust_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='cust_code'/>" maxLength="64" size="25"/>
            </td>
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='cust_name'/>" maxLength="50" size="25"/>
            </td>
            <td align="right"><fmt:message key="post_status"/></td>
              <td align="left">
                    <d:select name="post_status_bd" dictTypeId="POST_STATUS_BD"  nullLabel="--请选择--" style="width: 205px"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="user_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="receive_cs_name" inputName="<fmt:message key='user_name'/>" maxLength="50" size="25"/>
            </td>
            <td align="right"><fmt:message key="apply_on_post_date"/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="on_post_date_from" size="8"/><fmt:message key="to"/><w:date format="yyyy-MM-dd" name="on_post_date_to" size="8"/>
            </td>
            <td align="right"><fmt:message key="on_post_date"/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_on_post_date_from" size="8"/><fmt:message key="to"/><w:date format="yyyy-MM-dd" name="apply_on_post_date_to" size="8"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="isback"/></td>
            <td align="left">
                <d:select dictTypeId="TrueOrFalse" name="isback"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
            <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
                    
<div id="ccParent1" class="button"> 
 <div class="button_right"><!--
                <ul>
                    <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listOtherApplyEmpsecurity0052'/> </a> </li>
                    <li class="bl_1">      <a onClick="javascript:apply_onClick();"><fmt:message key='listOtherApplyEmpsecurity0053'/> </a></li>
                    <li class="nbl">       <a  onClick="javascript:back_onClick();"><fmt:message key='listOtherApplyEmpsecurity0054'/></a> </li>
                    <li class="e">         <a  onClick="javascript:exportExcel_onClick();"><fmt:message key='listOtherApplyEmpsecurity0055'/> </a> </li>
                </ul>
         -->
          <input class="a_2" type="button"   value="<fmt:message key="look_person_order"/>"  <au:authorityBtn code="view_orderItem14" type="1"/>  onClick="detail_onClick();">
          <input class="a_2" type="button"   value="<fmt:message key="apply_banli"/>"  <au:authorityBtn code="ydsbsq_sqbl" type="1"/>  onClick="apply_onClick();">
          <input class="a_2" type="button"   value="<fmt:message key="buxu_banli"/>"  <au:authorityBtn code="ydsbsq_bxbl" type="1"/>  onClick="back_onClick();">
          <input class="a_2" type="button"   value="<fmt:message key="export"/>"  <au:authorityBtn code="ydsbsq_exp" type="1"/>  onClick="exportExcel_onClick();">
         </div>
           <div class="clear"></div>            
</div>


<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpserviceitemAction.do?cmd=simpleApplyQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=applySecurity" width="99%"
        xpath="EmpserviceitemVo"
        submitXpath="EmpserviceitemVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false"  fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" sortAt="none" messagekey="emp_code" width="100px" allowModify="false">
              
      </r:field>
      
      <r:field fieldName="emp_name" sortAt="none" messagekey="emp_name" width="100px" onRefreshFunc="tolistDetail">
      </r:field>
      <r:field fieldName="internal_code" sortAt="none" messagekey="internal_code" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" sortAt="none" messagekey="card_type" width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" disabled="true" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" messagekey="card_num" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="cust_code" sortAt="none" messagekey="cust_code" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="cust_name" sortAt="none" messagekey="cust_name" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="group_name" sortAt="none" messagekey="ss_group" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="apply_on_post_date" sortAt="none" messagekey="on_post_date" width="100px" allowModify="false">
            <h:text readonly="true"/>
<!--            <w:date format="yyyy-MM-dd"/>    -->
      </r:field>
      
      <r:field fieldName="on_post_date" sortAt="none" messagekey="apply_on_post_date" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="post_status_bd" sortAt="none" messagekey="post_status" width="100px" allowModify="false">
            <d:select dictTypeId="POST_STATUS_BD" disabled="true" />     
      </r:field>
      
      <r:field fieldName="service_big_type_name" sortAt="none" messagekey="big_name" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="service_small_type_name" sortAt="none" messagekey="small_name" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="classify_date" sortAt="none" messagekey="classify_date" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="transact_type_name" allowModify="true" sortAt="none" messagekey="transact_type" width="100px">
          <h:text/>
      </r:field>
      
     <c:choose>
        <c:when test="${param.group_type=='2'}">
            <r:field fieldName="account" messagekey="account" sortAt="none" width="100px" >
            <w:lookup onReturnFunc="rtnFuncEmpAccount"  readonly="false" id="account" name="account" onchange="changeIt()"
                            lookupUrl="/EmpserviceitemAction.do?cmd=toEmpAccountlistPage" 
                            messagekey="select_fund_account" height="340" width="250"  style="width:230px" />
            </r:field><!--    transact_type_name  -->
        </c:when>
      </c:choose>

      <r:field fieldName="social_unit_id" sortAt="none" messagekey="security_unit_id" width="100px">
            <r:comboSelect id="com2" 
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                messagekey="please_choose">
            </r:comboSelect>     
      </r:field>
      
      <r:field fieldName="back_reason" sortAt="none" messagekey="bank_reason" width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="is_social_not_stop" sortAt="none" messagekey="is_fl_not_stop" width="100px">
            <d:select dictTypeId="TrueOrFalse" />  
      </r:field>
      
      <r:field fieldName="social_copy_month" sortAt="none" messagekey="social_copy_month"  width="100px">
            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;" />      
      </r:field>
      
      <r:field fieldName="apply_remark" sortAt="none" messagekey="apply_remark" width="100px">
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
$id("datacell1").headTextAlign="center";
    //解决<fmt:message key='listOtherApplyEmpsecurity0015'/>行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell<fmt:message key='listOtherApplyEmpsecurity0084'/>
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
    
    <c:choose>
        <c:when test="${param.group_type=='2'}">
        $id("account").beforeOpenDialog = function(lookup1){
            lookup1.params = [];
            //alert($id("cust_id").getValue());
            var datacell = $id("datacell1");
            var row = datacell.getActiveRow();
            var entity = datacell.getEntity(row);
            var social_group_id = entity.getProperty("security_group_id") ;
            var emp_id = entity.getProperty("emp_id") ;
            lookup1.addParam("social_group_id", social_group_id);
            lookup1.addParam("emp_id", emp_id);
            return true;
        }
        </c:when>
    </c:choose>
        
                                
    //实现beforeEdit<fmt:message key='listOtherApplyEmpsecurity0085'/>
        var field = {
    entityField:"transact_type_id",
    fieldId:"transact_type_id_9999",
    fieldName:"transact_type_id",
    sort:"no",
    allowResize:true,
    label:"入职服务名称",
    allowModify:true
    };    
    var eos_orgEditor = null;
        //实现beforeEdit<fmt:message key='listOtherApplyEmpsecurity0085'/>
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        if (colIndex == 15){
            if (!$id("new_service_List" + colIndex) || eos_orgEditor == null){
                //div container
                var divA = $createElement("div");
                divA.id = "datacell1"+"_"+"transact_type_id"+"_9999"+"_field_editor_container";
                //alert(divA.style);
                divA.style.width = "0px";
                divA.style.height = "0px";
                //divA.style.z-index = "999";
                divA.style.display = "none";
                
                var htmlString ="" ;
                htmlString += "<div id=\"new_service_List15_container\"  class=\"eos-ic-container\" >";
                htmlString += "<input class=\"eos-combo-select-editor-text\" type=\"text\" id=\"new_service_List15_input\" /><img id='new_service_List15_button' class='eos-ic-button'  /><input type=\"hidden\" id=\"new_service_List15_hidden\" name=\"new_service_List15\" />";
                htmlString += "</div>";
                                
                //append them
                divA.innerHTML = htmlString;
                //alert(divA.toString());
                document.body.appendChild(divA);
                //alert("run hear");
                            
                eos_orgEditor =new ComboSelect('new_service_List' + colIndex); 
                eos_orgEditor.queryAction = "/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"; 
                eos_orgEditor.xpath = "SecuritygroupnewVo"; 
                eos_orgEditor.valueField = "id"; 
                eos_orgEditor.textField = "type_name"; 
                eos_orgEditor.isIeMode = false; 
                eos_orgEditor.readOnly = false; 
                eos_orgEditor.allowInput = false; 
                eos_orgEditor.allowFilter = true; 
                eos_orgEditor.disabled = false; 
                eos_orgEditor.nullText = "<fmt:message key='listOtherApplyEmpsecurity0043'/>";
                eos_orgEditor.onPageLoad();
            }
            
            orgEditor = eos_orgEditor;
            var dc1 = $id("datacell1");
            this.activeField = field ? field : null;
            this.activeField.editor = orgEditor;
            this.activeEditor = this.activeField ? this.activeField.editor : null;
            orgEditor.paramList = null;
            orgEditor.addParam("security_group_id",""+security_group_id);
            orgEditor.init();
            orgEditor.loadData();
            orgEditor.refresh(); 
            
        }
        return true;
    }   
   //实现on updateCell
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("transact_type_name") >= 0){
            var orgEditor = eos_orgEditor;
            var newDisValue = orgEditor.getDisplayValue(newValue);
            activeEntity.setProperty("transact_type_name", newDisValue);
        }
        //alert(activeEntity.getProperty("transact_type_name"));
        return true;
    }    
    //忽略datacell<fmt:message key='listOtherApplyEmpsecurity0089'/>
    $id("datacell1").afterEdit = function( newValue, oldValue , datacell1 ){
        $id("datacell1").isModefied = false;
    }    
   $id("datacell1").beforeRefresh = function(){
        //$id("com2").refresh();
   }
   /*
   //解决翻页不提示数据变化
   function is_datacell_change(checkBoxName){
        var is_change = false;        
        var elementCheckbox = document.getElementsByName(checkBoxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listOtherApplyEmpsecurity0004'/>
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
  //初始化社保<fmt:message key='listOtherApplyEmpsecurity0004'/>
    citySecurityGroupchange("0571','0520"); 
</script>   
