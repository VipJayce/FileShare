<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公积金申请</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        //alert(elementCheckbox.length);
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
    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
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
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/empserviceitem/insertEmpserviceitem.jsp";
        form.submit();
    }

//操作
//查看个人订单
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
    //检查有没有选择行,验证必输项,并且把选择行对象状态改成“修改”状态
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
                if(enCur.getProperty("social_unit_id")==null||enCur.getProperty("social_unit_id")==""){
                    alert(enCur.getProperty("emp_name")+" 福利办理方不能为空！")
                    return false;
                }else if(enCur.getProperty("transact_type_id")==null||enCur.getProperty("transact_type_id")==""){
                    alert( enCur.getProperty("emp_name")+ " 办理类型不能为空！")
                    return false;
                }
                
                if(enCur.getProperty("transact_type_name")!='新开' && (enCur.getProperty("account")==null || enCur.getProperty("account")=='')){
                    alert( enCur.getProperty("emp_name")+ " 公积金账号不能为空！")
                    return false;
                }
                //else if(enCur.getProperty("is_social_not_stop")=='1'&&enCur.getProperty("social_copy_month")==null||enCur.getProperty("social_copy_month")==''){
                //    alert(enCur.getProperty("emp_name")+" 需要填写福利复制月！");
                //    return false;
                //}
                //else if(enCur.getProperty("transact_type_id")==null||enCur.getProperty("transact_type_id")==""){
                //    if(enCur.getProperty("apply_remark")==null||enCur.getProperty("apply_remark")==""){
                //        if(!confirm(enCur.getProperty("emp_name")+' 办理类型、申请备注都未填写，您确认要继续吗？')){
                //            return false;
                //        }
                //    }
                //}
            }
        }
        if(ids==null){
            alert("请选择记录！");
            return false;
        }
        return true;
    }
     //提交公积金申请
    function apply_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('确认要提交申请吗？')) {
                $id('Method').value="apply";
                $id("datacell1").submit();//提交       
            }    
    }
    //不需办理
    function back_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('确定所选员工不需要办理公基金吗？')) {
                $id('Method').value="back";
                $id("datacell1").submit();//提交       
        }    
    }
    //导出excel
    function exportExcel_onClick(){  //导出Excel
        var security_group_id=$id("group_List").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do";
        form.cmd.value = "exportExcel";
        form.submit();
    }  
    
    //简单的模糊查询
    function simpleQuery_onClick(){  
        //$id("com2").refresh();
        //$id("com1").refresh();
        var security_group_id=$id("group_List").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' id='temp_"+rowNo+"' name='checkbox_template' value=" + entity.getProperty("id") + ">";
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
    
    /*
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
   */
   
       //查看员工详细信息
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '员工详细信息');  //查看员工详细信息
        window.open('<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id='+id+'&flag=true','','height=830px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
   
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" id="Method" name="Method" value=""/>
<div id="right">
<script language="javascript">
<%
String flag="2";
flag=request.getParameter("flag");
if(!"1".equals(flag)){
%>
    writeTableTopFesco('公积金申请','<%=request.getContextPath()%>/');  //显示本页的页眉
    <%
}
    %>
    
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>

           <td align="right" >
                 <p>城市</p>
            </td>
            <td align="left">
                 <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="205px"
                       value="1099110100000000357"
                       nullText="请选择" 
                       />
            </td>
          
              <td align="right">公积金组</td>
              <td align="left">
                     <r:comboSelect id="group_List" name="security_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=2"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="205px"
                       linkId="city_idList_search"
                       nullText="请选择" />
              </td>
        
         
              <td align="right">唯一号</td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="9.5" size="25"/>
              </td>
              <td align="right">员工姓名</td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="9.5" size="25"/>
              </td>
        </tr>
        <tr>
            <td align="right">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="64" size="25"/>
            </td>
            <td align="right">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="客户名称" maxLength="50" size="25"/>
            </td>
            <td align="right">入离职状态</td>
              <td align="left">
                    <d:select name="post_status_bd" dictTypeId="POST_STATUS_BD"  nullLabel="--请选择--" style="width: 205px"/>
              </td>
               <td align="right">客服</td>
            <td align="left">
                <input type="text" class="text_field" name="receive_cs_name" inputName="客服" maxLength="50" size="25"/>
            </td>
        </tr>
        <tr>
           
            <td align="right">报入职日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="on_post_date_from" size="8"/>到<w:date format="yyyy-MM-dd" name="on_post_date_to" size="8"/>
            </td>
            <td align="right">入职日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_on_post_date_from" size="8"/>到<w:date format="yyyy-MM-dd" name="apply_on_post_date_to" size="8"/>
            </td>
            
             <td align="right">是否被退回</td>
            <td align="left">
                <d:select dictTypeId="TrueOrFalse" name="isback"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="right"></td>
         
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
                    <li class="a_2">       <a  onClick="javascript:detail_onClick();">查看个人订单 </a> </li>
                    <li class="bl_1">      <a onClick="javascript:apply_onClick();">申请办理 </a></li>
                    <li class="nbl">       <a  onClick="javascript:back_onClick();">不需办理</a> </li>
                    <li class="e">         <a  onClick="javascript:exportExcel_onClick();">导出 </a> </li>
                </ul>
         -->
         <input class="a_2" type="button"   value=" 查看个人订单"  <au:authorityBtn code="view_orderItem20" type="1"/>  onClick="detail_onClick();">
         <input class="bl_1" type="button"   value=" 申请办理"  <au:authorityBtn code="gjjsq_sqbl" type="1"/>  onClick="apply_onClick();">
         <input class="nbl" type="button"   value=" 不需办理"  <au:authorityBtn code="gjjsq_bxbl" type="1"/>  onClick="back_onClick();">
         <input class="e" type="button"   value=" 导出"  <au:authorityBtn code="gjjsq_exp" type="1"/>  onClick="exportExcel_onClick();">
         </div>
           <div class="clear"></div>            
</div>


<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpserviceitemAction.do?cmd=simpleApplyQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=applySecurity" width="98%"
        xpath="EmpserviceitemVo"
        submitXpath="EmpserviceitemVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false"  fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" sortAt="none" label="唯一号" width="100px" allowModify="false">
              
      </r:field>
      
      <r:field fieldName="emp_name" sortAt="none" label="员工姓名" width="100px" onRefreshFunc="tolistDetail">
      </r:field>
      <r:field fieldName="internal_code" sortAt="none" label="客户方编号" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" sortAt="none" label="证件类别" width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" disabled="true" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" label="证件号码" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="cust_code" sortAt="none" label="客户编号" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="cust_name" sortAt="none" label="客户名称" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="group_name" sortAt="none" label="社保/公积金组" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="apply_on_post_date" sortAt="none" label="入职时间" width="100px" allowModify="false">
            <h:text readonly="true"/>
<!--            <w:date format="yyyy-MM-dd"/>    -->
      </r:field>
      
      <r:field fieldName="on_post_date" sortAt="none" label="报入职时间" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="post_status_bd" sortAt="none" label="入离职状态" width="100px" allowModify="false">
            <d:select dictTypeId="POST_STATUS_BD" disabled="true" />     
      </r:field>
      
      <r:field fieldName="service_big_type_name" sortAt="none" label="员工大类" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="service_small_type_name" sortAt="none" label="员工小类" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="classify_date" sortAt="none" label="分类时间" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      <r:field fieldName="account" label="帐号" sortAt="none" width="100px" >
            <h:text/>
      </r:field>

      <r:field fieldName="transact_type_name" label="办理类型" allowModify="true" sortAt="none">
        <h:text/>
      </r:field>
      <r:field fieldName="social_unit_id" sortAt="none" label="福利办理方" width="100px">
            <r:comboSelect id="com2" 
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                nullText="--请选择--">
            </r:comboSelect>     
      </r:field>
      
      <r:field fieldName="back_reason" sortAt="none" label="回退原因" width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="is_social_not_stop" sortAt="none" label="是否福利不停" width="100px">
            <d:select dictTypeId="TrueOrFalse" />  
      </r:field>
      
      <r:field fieldName="social_copy_month" sortAt="none" label="福利复制月"  width="100px">
            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;" />      
      </r:field>
      
      <r:field fieldName="apply_remark" sortAt="none" label="申请备注" width="100px">
            <h:text/>      
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
</html>

<script language="javascript">
$id("datacell1").headTextAlign="center";
    //解决修改行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell不进行查询
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
 
    //忽略datacell的修改
    $id("datacell1").afterEdit = function( newValue, oldValue , datacell1 ){
        $id("datacell1").isModefied = false;
    }    
   $id("datacell1").beforeRefresh = function(){
        //$id("com2").refresh();
        //$id("com1").refresh();
   }
   /*
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
    */
   
   /*
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
    */
    
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
        //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        if (colIndex == 16){
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
                htmlString += "<div id=\"new_service_List16_container\"  class=\"eos-ic-container\" >";
                htmlString += "<input class=\"eos-combo-select-editor-text\" type=\"text\" id=\"new_service_List16_input\" /><img id='new_service_List16_button' class='eos-ic-button'  /><input type=\"hidden\" id=\"new_service_List16_hidden\" name=\"new_service_List16\" />";
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
                eos_orgEditor.nullText = "请选择";
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
            
            //其他打钩的行也要默认选中一样
            var activeRow = $id("datacell1").activeRow;
             var rowNo=activeRow.rowIndex;
             if($id("temp_"+rowNo).checked){//已经勾选上
	             var temps = document.getElementsByName("checkbox_template");
	             var number = 0;  //定义游标
	             var ids = null;  //定义id值的数组
	             for(var i=0;i<temps.length;i++){  //循环checkbox组
	                  if(temps[i].checked) {  //如果被选中,则替换
	                       var enCurEntity = $id("datacell1").dataset.get(i);
	                       enCurEntity.setProperty("transact_type_id", newValue);
	                       enCurEntity.setProperty("transact_type_name", newDisValue);
	                           
	                       $id("datacell1").refreshRow($id("datacell1").getRow(i));
	                       
	                   }
	             }
	        }
	    }
        //alert(activeEntity.getProperty("transact_type_name"));
        return true;
    } 
</script>   
