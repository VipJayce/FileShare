<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

	<%
		String city_id= request.getParameter("city_id");
	    if(city_id==null || city_id.equals("")){
	        request.setAttribute("city_id","1099110100000000357");
	    }else{
	        request.setAttribute("city_id",city_id);
	    }
	    String security_group_id= request.getParameter("security_group_id");
		if(security_group_id==null || security_group_id.equals("")){
		    request.setAttribute("security_group_id","1099110700000000203");
		}else{
		    request.setAttribute("security_group_id",security_group_id);
		}
	   String report_month= request.getParameter("report_month");
	   if(report_month==null || report_month.equals("null") || report_month.equals("undefined")){
	       report_month = "";
	   }
	   String  isQuery = request.getParameter("isQuery")==null?"false":request.getParameter("isQuery");
	%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公积金办理</title>
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
                if(enCur.getProperty("insert_back_reason")==null||enCur.getProperty("insert_back_reason")==""){
                    alert(enCur.getProperty("emp_name")+" 回退原因不能为空！");
                    return false;
                }
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
                $id('applyMethod').value="apply";
                $id("datacell1").submit();//提交       
            }    
    }

    //简单的模糊查询
    function simpleQuery_onClick(){  
        var security_group_id=$id("security_group_id").getValue();
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
    
//进入办理界面
function in_Transaction_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids有2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    //var report_month=document.getElementById("report_month").value;
    var curId = '' + ids[0];
    var entity1 = $id("datacell1").dataset.findEntity("id", curId);
    var report_month = entity1.getProperty("report_month");
    //如果员工存在两条待办记录则给用户提示
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
                alert(entity.getProperty("emp_name")+' 没有有效订单明细记录，不能办理！');
                return;
              }
              else if(myAjax.getProperty("returnValue")=="updateerror"){
                alert(entity.getProperty("emp_name")+' 有变更待审核，请先审核！');
                return;
              }
              else if(myAjax.getProperty("returnValue")>1){
                if(confirm(entity.getProperty("emp_name")+' 存在'+myAjax.getProperty("returnValue")+'条待办理的记录，是否确认要办理？')){
                    window.open('<venus:base/>/EmpsecurityAction.do?cmd=getEmpSecurityById&id='+ids[0]+'&report_month='+report_month+'&_ts='+(new Date()).getTime()+'&applytype=1','','height=600px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
                }
              }else{
                window.open('<venus:base/>/EmpsecurityAction.do?cmd=getEmpSecurityById&id='+ids[0]+'&report_month='+report_month+'&_ts='+(new Date()).getTime()+'&applytype=1','','height=600px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
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
        if(confirm('确定所选员工退回吗？')) {
                $id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}
//批量不需办理
function batch_cancel_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('确定所选员工不需要办理公积金吗？')) {
                $id('Method').value="batchcancel";
                $id("datacell1").submit();//提交       
        }    
    }
    
   //批量办理
   function batch_transaction_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        //先判断是否有问题数据存在
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            //如果员工存在两条待办记录则给用户提示
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
                    alert(entity.getProperty("emp_name")+' 没有有效订单明细记录，不能办理！');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")=="ishaveerror"){
                    alert(entity.getProperty("emp_name")+' 已经存在在缴记录，不能办理！');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")=="updateerror"){
                    alert(entity.getProperty("emp_name")+' 有变更待审核，请先审核！');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")>1){
                    if(!confirm(entity.getProperty("emp_name")+' 存在'+myAjax.getProperty("returnValue")+'条待办理的记录，是否确认要办理？')){
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
                       if(confirm('确定所选员工要批量办理吗？')) {
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
//保存所选备注
function save_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('请勾选需要保存备注的记录！');
            return;
        }
        $id('Method').value="saveremark";
        $id("datacell1").submit();//提交       

}

//导出excel
    function exportExcel_onClick(){  //导出Excel
        var security_group_id=$id("security_group_id").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
        }
        var queryType=document.getElementById("queryType").value;
       // var stopType=document.getElementById("stopType").value;
       
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcel3&queryType="+queryType+"&stopType="+""+"&group_id="+security_group_id;
        //form.cmd.value="exportExcel;
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

function changeit(){
    //alert($id("security_group_id").value);
   $id("com1").addParam("security_group_id", $id("security_group_id").value);
   $id("com1").loadData();
   $id("com1").refresh();
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
<input type="hidden" id="report_month" name="report_month" value="<%=report_month %>"/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('公积金办理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
                 <td align="right" >
                 <p><font color="red">*</font>城市</p>
            </td>
            <td align="left">
                 <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="205px"
                       value="${requestScope.city_id }"
                       nullText="请选择"
                       />
            </td>
          
              <td align="right"><font color="red">*</font>公积金组</td>
              <td align="left">
                     <r:comboSelect id="security_group_id" name="security_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=2"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="205px"
                       linkId="city_idList_search"
                       value="${requestScope.security_group_id }"
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
            <td align="right">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" value="${param.customer_code }" inputName="客户编号" maxLength="64" size="25"/>
            </td>
            <td align="right">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" value="${param.customer_name }"  inputName="客户名称" maxLength="50" size="25"/>
            </td>
            <td align="right">办理类型</td>
            <td align="left">
                <r:comboSelect id="com1" name="transact_type_id" 
                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewTypeZj"
                    textField="type_name" 
                    valueField="id" 
                    xpath="SecuritygroupnewVo"     
                    linkId="security_group_id"                   
                    nullText="--请选择--" 
                    width="205px">
                </r:comboSelect>
            </td>
          
        </tr>
        <tr>
          <td align="right">用工状态</td>
            <td align="left">
                <select name="hire_fire_status" style="width: 205px">
                    <option value="">--请选择--</option>
                    <option value="0">用工办理中</option>
                    <option value="1">已用工</option>
                    <option value="2">已退工</option>
                </select>
<!--                    <d:select name="post_status_bd" dictTypeId="POST_STATUS_BD"  nullLabel="--请选择--" style="width: 205px"/>-->
              </td>
            <td align="right">福利办理方</td>
              <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                nullText="--请选择--"
                value="${param.social_unit_id }"
                width="205px">
                
            </r:comboSelect> 
              </td>
            <td align="right">申请日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_date_from" size="8"/>到<w:date format="yyyy-MM-dd" name="apply_date_to" size="8" />
            </td>
             <td align="right">排序方式</td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER" name="order_type"  value="1" nullLabel="--请选择--" style="width: 205px"/>
            </td>
        
        </tr>
        <tr>
        
             <td align="right">排序顺序</td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
        
            <td align="left" colspan="5">
                
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
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();">查看个人订单 </a> </li>
                            <li class="bl_1">      <a onClick="javascript:in_Transaction_onClick();">进入办理 </a></li>
                            <li class="pl">      <a onClick="javascript: batch_back_onClick();">批量退回申请 </a></li>
                            <li class="h_1">      <a onClick="javascript:batch_transaction_onClick();">批量办理 </a></li>
                            <li class="h_1">       <a  onClick="javascript:batch_cancel_onClick();">不需办理</a> </li>
                            <li class="bc">         <a  onClick="javascript:save_onClick();">保存 </a> </li>
                            <li class="e">         <a  onClick="javascript:exportExcel_onClick();">导出 </a> </li>
                              //<li class="dj">         <a  onClick="javascript:_onClick();">社保办事单 </a> </li> 
                        </ul>
                    -->
                     <input class="a_2" type="button"   value=" 查看个人订单"  <au:authorityBtn code="view_orderItem21" type="1"/>  onClick="detail_onClick();">
                     <input class="bl_1" type="button"   value=" 进入办理"  <au:authorityBtn code="gjjbl_jrbl" type="1"/>  onClick="in_Transaction_onClick();">
                     <input class="pl" type="button"   value=" 批量退回申请"  <au:authorityBtn code="gjjbl_plthsq" type="1"/>  onClick="batch_back_onClick();">
                     <input class="h_1" type="button"   value=" 批量办理"  <au:authorityBtn code="gjjbl_plbl" type="1"/>  onClick="batch_transaction_onClick();">
                     <input class="h_1" type="button"   value=" 不需办理"  <au:authorityBtn code="gjjbl_bubl" type="1"/>  onClick="batch_cancel_onClick();">
                     <input class="bc_1" type="button"   value=" 保存"  <au:authorityBtn code="gjjbl_save" type="1"/>  onClick="save_onClick();">
                     <input class="e" type="button"   value=" 导出"  <au:authorityBtn code="gjjbl_exp" type="1"/>  onClick="exportExcel_onClick();">
                    </div>
                </div>                    
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=transactionSimpleQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=transactionSecurity" width="98%"
        xpath="EmpsecurityVo"
        submitXpath="EmpsecurityVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" sortAt="none" label="唯一号" width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" sortAt="none" label="员工姓名" width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      
      <r:field fieldName="group_name" sortAt="none" label="社保/公积金组" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="internal_code" sortAt="none" label="客户方编号" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" sortAt="none" label="证件类别" width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" label="18位证件号码" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="emp_post_type_bd" sortAt="none" label="员工类别" width="100px" allowModify="false">
            <d:select dictTypeId="EMP_POST_TYPE_BD"/> 
      </r:field>
      
      <r:field fieldName="cust_code" sortAt="none" label="客户编号" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" sortAt="none" label="客户名称" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" sortAt="none" label="客服" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <!--<r:field fieldName="send_name" sortAt="none" label="委派单" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_big_type_name" sortAt="none" label="员工大类" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_small_type_name" sortAt="none" label="员工小类" width="100px" allowModify="false">
            <h:text />      
      </r:field>陈旭修改-->
      
      <r:field fieldName="cust_send_name" sortAt="none" label="派出单位" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <!--<r:field fieldName="cust_receive_name" sortAt="none" label="接收单位" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_on_post_date" sortAt="none" label="入职日期" width="100px" allowModify="false">
            <h:text />
      </r:field>
      
      <r:field fieldName="on_post_date" sortAt="none" label="报入职时间" width="100px" allowModify="false">
            <h:text />      
      </r:field>陈旭修改-->
      
      <r:field fieldName="on_post_desc" sortAt="none" label="入职备注" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_off_post_date" sortAt="none" label="离职日期" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="emp_account" sortAt="none" label="帐号" width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="transact_type_name" sortAt="none" label="办理类型" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="hire_fire_status" sortAt="none" label="用工状态" width="100px" allowModify="false">
            <d:select dictTypeId="HIRE_FIRE_STATUS_BD" />  
      </r:field>
      
      <r:field fieldName="social_unit_name" sortAt="none" label="福利办理方" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_man_name" sortAt="none" label="申请人" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_date" sortAt="none" label="申请日期" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="start_month" sortAt="none" label="起始月" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="report_month" width="100px" label="报表月">
        <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
       </r:field>
      
      <r:field fieldName="back_reason" sortAt="none" label="已有退回原因" width="100px" >
            <h:text />      
      </r:field>
      
      <r:field fieldName="insert_back_reason" sortAt="none" label="填写退回原因" width="100px" >
            <h:text />      
      </r:field>

      <r:field fieldName="transact_remarks" sortAt="none" label="办理备注" width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="fund_base" sortAt="none" label="公积金基数" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="fund_e_ratio" sortAt="none" label="企业比例" width="100px" allowModify="false">
            <h:text/>      
      </r:field>

      <r:field fieldName="fund_p_ratio" sortAt="none" label="个人比例" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="supplyfund_base" sortAt="none" label="补充公积金基数" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="supplyfund_e_ratio" sortAt="none" label="企业比例" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="supplyfund_p_ratio" sortAt="none" label="个人比例" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
<!--      <r:field fieldName="unemployment_base" sortAt="none" label="失业保险基数" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="unemployment_e_ratio" sortAt="none" label="企业比例" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="unemployment_p_ratio" sortAt="none" label="个人比例" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="industrial_base" sortAt="none" label="工伤保险基数" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="industrial_e_ratio" sortAt="none" label="企业比例" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="industrial_p_ratio" sortAt="none" label="个人比例" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="maternity_base" sortAt="none" label="生育保险基数" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="maternity_e_ratio" sortAt="none" label="企业比例" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="maternity_p_ratio" sortAt="none" label="个人比例" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="disability_base" sortAt="none" label="残疾保障金基数" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="disability_e_ratio" sortAt="none" label="企业比例" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="disability_p_ratio" label="个人比例" width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
      
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
             $id('Method').value="saveremark";//表单提交后修改方法为保存，翻页时提交表单用到
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
      
    
    //从公积金管理页面进来时，需要加载查询条件和报表月列
    $id("datacell1").afterInit = function (){
	    var isQuery= <%=isQuery%>;
	    var security_group_id ='<%=security_group_id%>';
	    
	    if(isQuery){
	         if(security_group_id=='<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>'){
	                document.getElementById("security_group_id").options[1].selected=true;
	        }
	        else if(security_group_id=='<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>'){
	               document.getElementById("security_group_id").options[2].selected=true;
	        }
	       $id('isClickQuery').value=true;
	       //$id("datacell1").loadData();
	       //$id("datacell1").refresh();
	      
	    }
	}
	
	
	$id("datacell1").afterLoadData = function(){
	       var report_month=document.getElementById("report_month").value;
           var dataset = $id("datacell1").dataset;
           if(report_month!=''){
                for(var i=0; i<dataset.getLength(); i++){
                    var entity1 = dataset.get(i);
                    entity1.setProperty("report_month",report_month);
                }         
           }
    }
</script>   
