<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>社保修改</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
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
                if(enCur.getProperty("security_status_bd")!='3'){
                    alert("该员工办理状态不为在缴，不能做开户失败操作！");
                    return false;
                }
                if(enCur.getProperty("insert_back_reason")==null||enCur.getProperty("insert_back_reason")==""){
                    alert(" 请输入开户失败原因！");
                    return false;
                }
            }
        }
        return true;
    }
    //简单的模糊查询
    function simpleQuery_onClick(){  
        var security_group_id=$id("group_List").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
        }
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

//停办
function stop_onClick(){
     if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('确定所选员工停办吗？')) {
                $id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}

//开户失败openFailed_onClick(
function openFailed_onClick(){
    if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('确定所选员工做开户失败操作吗？')) {
                //$id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}
//进入修改页面
function modify_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids有2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0]+"&isModify=1";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=社保修改');
    //showModalCenter(url, window, callBack, 1024, 500, "社保修改");
}

//查看详细页面
function show_detail_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids有2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0]+"&isModify=2&viewtype=1";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=社保查看');
    //showModalCenter(url, window, callBack, 1024, 500, "社保查看");
}

function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        setTimeout(simpleQuery_onClick,4000);
    }
}

     //导出
 function exportExcel_onClick(){  //导出Excel
       var security_group_id=$id("group_List").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
        }
       var queryType=document.getElementById("queryType").value;
       // var stopType=document.getElementById("stopType").value;
       
       form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcel7&queryType="+queryType+"&stopType="+""+"&group_id="+security_group_id;
       form.submit();
}
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
<!--<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_2 %>">-->
<input type="hidden" id="queryType" name="queryType" value="modify"/>
<div id="right">
<script language="javascript">
   <%
  String security_type=request.getParameter("security_type");

%>
   writeTableTopFesco('社保修改','<%=request.getContextPath()%>/');  //显示本页的页眉

</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td  align="right">
                 <p>城市</p>
            </td>
              <td align="left">
                        <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       value="1099110100000000357"
                       nullText="请选择" 
                       />
              </td>
                <td align="right">社保/公积金组</td>
              <td align="left">
                     <r:comboSelect id="group_List" name="security_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=1"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="200px"
                       linkId="city_idList_search"
                       nullText="请选择" />
              </td>
              <td align="right">员工姓名</td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="20" size="25"/>
              </td>
              <td align="right">唯一号</td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="20" size="25"/>
              </td>
             
        </tr>
        <tr>
                <td align="right">身份证</td>
                <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="唯一号" maxLength="18" size="25"/>
              </td>
              <td align="right">客户方编号</td>
              <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="唯一号" maxLength="20" size="25"/>
              </td>
              <td align="right">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="64" size="25"/>
            </td>
            <td align="right">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="客户名称" maxLength="50" size="25"/>
            </td>
              
        </tr>
        <tr>
            <td align="right">客服</td>
              <td align="left">
                <input type="text" class="text_field" name="receive_cs_name" inputName="唯一号" maxLength="18" size="25"/>
              </td>
            <td align="right">账号</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_account" inputName="唯一号" maxLength="20" size="25"/>
            </td>
            <td align="right">福利办理方</td>
            <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                        queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                        textField="hire_unit_short_name" 
                        valueField="id" 
                        xpath="SocialunitVo"
                        nullText="--请选择--"
                        width="205px">
                    </r:comboSelect> 
            </td>
            <td align="right">状态</td>
            <td align="left">
                    <d:select name="security_status_bd" dictTypeId="SECU_MODIFY_STA" nullLabel="--请选择--" style="width: 205px"/>
              </td>
             
        </tr>
        <tr>
         <td align="right">办理日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="transact_date_from" size="8"/>到<w:date format="yyyy-MM-dd" name="transact_date_to" size="8" />
            </td>
            <td align="right">停办日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="stop_date_from" size="8"/>到<w:date format="yyyy-MM-dd" name="stop_date_to" size="8" />
            </td>
             <td align="right">排序方式</td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER" name="order_type"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="right">排序顺序</td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
           
        </tr>
        <tr>
         <td align="center" colspan="8">
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
                            <li class="a_2">       <a  onClick="javascript:show_detail_onClick();">查看详细 </a> </li>
                            <li class="bl_1">      <a  onClick="javascript:modify_onClick();">修改</a></li>
                            <li class="f_1">       <a  onClick="javascript:openFailed_onClick();">开户失败</a></li>
                        </ul>
                    -->
                     <input class="a_2" type="button"   value="查看个人订单"  <au:authorityBtn code="view_orderItem11" type="1"/>  onClick="detail_onClick();">  
                    <input class="a_2" type="button"   value="查看详细"  <au:authorityBtn code="sbxg_viewItem" type="1"/>  onClick="show_detail_onClick();">  
                    <input class="bl_1" type="button"   value="修改"  <au:authorityBtn code="sbxg_modify" type="1"/>  onClick="modify_onClick();">  
                    <input class="f_1" type="button"   value="开户失败"  <au:authorityBtn code="sbxg_khsb" type="1"/>  onClick="openFailed_onClick();">  
                    <input class="e" type="button"   value=" 导出"   onClick="exportExcel_onClick();">
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
      <r:field fieldName="emp_code" label="唯一号" sortAt="none" width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" label="员工姓名" sortAt="none" width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      
      <r:field fieldName="id_card_type_bd" label="证件类别" sortAt="none" width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" label="证件号码" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_code" label="客户编号" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" label="客户名称" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" label="客服" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_big_type_name" label="员工大类" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_small_type_name" label="员工小类" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="social_unit_name" label="福利办理方" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_man" label="办理人" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_date" label="办理日期" sortAt="none" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="transact_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="transact_type_name" label="办理类型" sortAt="none" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="start_month" label="缴费起始月" sortAt="none" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="fund_month" label="报表月" sortAt="none" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="pay_base" label="基数" sortAt="none" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="security_status_bd" label="状态" sortAt="none" width="100px" allowModify="false">
            <d:select dictTypeId="SECURITY_STATUS_BD" nullLabel="--请选择--"/>      
      </r:field>
      
      <r:field fieldName="stop_date" label="停办日期" sortAt="none" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="stop_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="stop_man" label="停办人" sortAt="none" width="100px" allowModify="false">
            
      </r:field>
      
      <r:field fieldName="stop_reason_bd" label="离职原因" sortAt="none" width="100px" allowModify="false">
            <d:select dictTypeId="OFF_POST_REASON" nullLabel="--请选择--"/>  
      </r:field>
      
      <r:field fieldName="insert_back_reason" sortAt="none" label="开户失败原因" width="100px" >
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
    //忽略datacell的修改
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
   
</script>   
