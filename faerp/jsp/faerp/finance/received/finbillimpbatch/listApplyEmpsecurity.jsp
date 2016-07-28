<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>社保申请</title>
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
                    alert("福利办理方不能为空！")
                    return false;
                }else if(enCur.getProperty("is_social_not_stop")=='0'&&enCur.getProperty("social_copy_month")==null||enCur.getProperty("social_copy_month")==''){
                    alert(enCur.getProperty("emp_name")+" 需要填写福利复制月！");
                    return false;
                }else if(enCur.getProperty("transact_type_id")==null||enCur.getProperty("transact_type_id")==""){
                    if(enCur.getProperty("apply_remark")==null||enCur.getProperty("apply_remark")==""){
                        if(!confirm(enCur.getProperty("emp_name")+' 办理类型、申请备注都未填写，您确认要继续吗？')){
                            return false;
                        }
                    }
                }
            }
        }
        if(ids==null){
            alert("请选择记录！");
            return false;
        }
        return true;
    }
     //提交社保申请
    function apply_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('确认要提交申请吗？')) {
                $id('applyMethod').value="apply";
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
        if(confirm('确定所选员工不需要办理社保吗？')) {
                $id('applyMethod').value="back";
                $id("datacell1").submit();//提交       
        }    
    }
    //导出excel
    function exportExcel_onClick(){  //导出Excel
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do";
        form.cmd.value = "exportExcel";
        form.submit();
    }  
    
    //简单的模糊查询
    function simpleQuery_onClick(){  
        $id("com2").refresh();
    
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
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" id="applyMethod" name="applyMethod" value=""/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('社保申请','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="6" valign="middle" align="center" ><div class="search_title">查询条件</div> </td>
        </tr>
        </tr>
              <td align="right">社保/公积金组</td>
              <td align="left">
                    <select id="security_group_id" name="security_group_id" style="width: 185px" >
                       <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>">上海社保组</option>
                    </select>
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
                    <d:select name="post_status_bd" dictTypeId="POST_STATUS_BD"  nullLabel="--请选择--" style="width: 185px"/>
              </td>
        </tr>
        <tr>
            <td align="right">客服</td>
            <td align="left">
                <input type="text" class="text_field" name="receive_cs_name" inputName="客服" maxLength="50" size="25"/>
            </td>
            <td align="right">报入职日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="on_post_date_from" size="6"/>到<w:date format="yyyy-MM-dd" name="on_post_date_to" size="6"/>
            </td>
            <td align="right">入职日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_on_post_date_from" size="6"/>到<w:date format="yyyy-MM-dd" name="apply_on_post_date_to" size="6"/>
            </td>
        </tr>
        <tr>
            <td align="right">是否被退回</td>
            <td align="left">
                <d:select dictTypeId="TrueOrFalse" name="isback"  nullLabel="--请选择--" style="width: 185px"/>
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
 <div class="button_right">
                <ul>
                    <li class="a_2">       <a  onClick="javascript:detail_onClick();">查看个人订单 </a> </li>
                    <li class="bl_1">      <a onClick="javascript:apply_onClick();">申请办理 </a></li>
                    <li class="nbl">       <a  onClick="javascript:back_onClick();">不需办理</a> </li>
                    <li class="e">         <a  onClick="javascript:exportExcel_onClick();">导出 </a> </li>
                </ul>
                
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
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false"  fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" label="唯一号" width="100px" allowModify="false">
              
      </r:field>
      
      <r:field fieldName="emp_name" label="员工姓名" width="100px" expression="<a href='#'>$[emp_name]</a>">
      </r:field>
      <r:field fieldName="internal_code" label="客户方编号" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" label="证件类别" width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" disabled="true" />   
      </r:field>
      
      <r:field fieldName="id_card" label="证件号码" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="cust_code" label="客户编号" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="cust_name" label="客户名称" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="group_name" label="社保组" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="apply_on_post_date" label="入职时间" width="100px" allowModify="false">
            <h:text readonly="true"/>
<!--            <w:date format="yyyy-MM-dd"/>    -->
      </r:field>
      
      <r:field fieldName="on_post_date" label="报入职时间" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="post_status_bd" label="入离职状态" width="100px" allowModify="false">
            <d:select dictTypeId="POST_STATUS_BD" disabled="true" />     
      </r:field>
      
      <r:field fieldName="service_big_type_name" label="员工大类" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="service_small_type_name" label="员工小类" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="classify_date" label="分类时间" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="transact_type_name" label="办理类型" width="100px">
            <r:comboSelect id="com1" 
                queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
                textField="type_name" 
                valueField="id" 
                xpath="SecuritygroupnewVo"
                nullText="--请选择--">
            </r:comboSelect>
      </r:field>
      
      <r:field fieldName="social_unit_id" label="福利办理方" width="100px">
            <r:comboSelect id="com2" 
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                nullText="--请选择--">
            </r:comboSelect>     
      </r:field>
      
      <r:field fieldName="back_reason" label="回退原因" width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="is_social_not_stop" label="是否福利不停" width="100px">
            <d:select dictTypeId="TrueOrFalse" />  
      </r:field>
      
      <r:field fieldName="social_copy_month" label="福利复制月"  width="100px">
            <h:text validateAttr="type=number" />      
      </r:field>
      
      <r:field fieldName="apply_remark" label="申请备注" width="100px">
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
    //忽略datacell的修改
    $id("datacell1").afterEdit = function( newValue, oldValue , datacell1 ){
        $id("datacell1").isModefied = false;
    }    
   $id("datacell1").beforeRefresh = function(){
        $id("com2").refresh();
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
    */  
   
</script>   
