<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="/common/common.jsp"%>
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
		String social_unit_id= request.getParameter("social_unit_id");
		String cust_name= request.getParameter("customer_name");
		String cust_code= request.getParameter("customer_code");
		String report_month = request.getParameter("report_month")==null || request.getParameter("report_month").equals("undefined")?"":request.getParameter("report_month");
        String the_end_date_to = "";
        if(report_month!=null && !report_month.equals("")){
            String year = report_month.substring(0,4);
            String month = report_month.substring(4);
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.YEAR,Integer.parseInt(year));
            cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
            cal.set(Calendar.DAY_OF_MONTH, 1);
            cal.add(Calendar.DAY_OF_MONTH, -1);
            Date lastDate = cal.getTime();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            the_end_date_to = format.format(lastDate);
        }
		String  isQuery = request.getParameter("isQuery")==null?"false":request.getParameter("isQuery");
	%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公积金停办</title>
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
                if(enCur.getProperty("end_month")==null||enCur.getProperty("end_month")==""){
                    alert(enCur.getProperty("emp_name")+" 收费截止月不能为空！");
                    return false;
                }
                //if(enCur.getProperty("stop_reason_bd")==null||enCur.getProperty("stop_reason_bd")==""){
                //    alert(enCur.getProperty("emp_name")+" 停办原因不能为空！");
                //    return false;
                //}
            }
        }
        if(ids==null){
            alert("请选择记录！");
            return false;
        }
        return true;
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
                //$id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}

//导出excel
    function exportExcel_onClick(){  //导出Excel
        var security_group_id=$id("security_group_id").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
        }
       var queryType=document.getElementById("queryType").value;
       var stopType=document.getElementById("stopType").value;
       
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcel4&queryType="+queryType+"&stopType="+stopType+"&group_id="+security_group_id;
        //form.cmd.value="exportExcel;
        form.submit();
    } 
    
     //查看员工详细信息
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
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
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0]+"&isModify=2&applytype=1&viewtype=1";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金查看');
    //showModalCenter(url, window, callBack, 1024, 500, "社保查看");
}

function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        setTimeout(simpleQuery_onClick,4000);
    }
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
<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_3 %>">
<input type="hidden" id="Method" name="Method" value=""/>
<input type="hidden" id="queryType" name="queryType" value="stop"/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('公积金停办','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
                       <td align="right" >
                 <font color="red">*</font>城市
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
          
              <td align="right"><font color="red">*</font>社保/公积金组</td>
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
                          value="${param.social_unit_id }"
                        width="205px">
                    </r:comboSelect> 
            </td>
            <td align="right">收费截止日</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="the_end_date_from" size="8"/>到<w:date format="yyyy-MM-dd" name="the_end_date_to" value="<%=the_end_date_to %>" size="8" />
            </td>
            <!--
            <td align="right">退工状态</td>
            <td align="left">
                <select name="post_status_bd" style="width: 205px">
                    <option value="">--请选择--</option>
                    <option value="2">已退工</option>
                </select>
                    <d:select name="hire_fire_status" dictTypeId="HIRE_FIRE_STATUS_BD"  nullLabel="--请选择--" style="width: 205px"/>
              </td>
              -->
        </tr>
        <tr><!--
            <td align="right">办理日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="transact_date_from" size="8"/>到<w:date format="yyyy-MM-dd" name="transact_date_to" size="8" />
            </td>
            -->
            <td align="right">停缴原因</td>
            <td align="left">
                    <d:select name="stopType" dictTypeId="STOP_TYPE" nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="right">报离职日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="off_post_date_from" size="8"/>到<w:date format="yyyy-MM-dd" name="off_post_date_to" size="8" />
            </td>
             <td align="right">排序方式</td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER1" name="order_type"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="right">排序顺序</td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="right">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
                    <div class="button_right"><!--
                        <ul>
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();">查看个人订单 </a> </li>
                            <li class="a_2">       <a  onClick="javascript:show_detail_onClick();">查看详细 </a> </li>
                            <li class="bl_1">      <a onClick="javascript:stop_onClick();">停办 </a></li>
                            <li class="e">         <a  onClick="javascript:exportExcel_onClick();">导出 </a> </li>
                        </ul>
                    -->
                    <input class="a_2" type="button"   value=" 查看个人订单"  <au:authorityBtn code="view_orderItem22" type="1"/>  onClick="detail_onClick();">
                    <input class="a_2" type="button"   value=" 查看详细"  <au:authorityBtn code="gjjtb_item" type="1"/>  onClick="show_detail_onClick();">
                    <input class="bl_1" type="button"   value=" 停办"  <au:authorityBtn code="gjjtb_tb" type="1"/>  onClick="stop_onClick();">
                    <input class="e" type="button"   value=" 导出"  <au:authorityBtn code="gjjtb_exp" type="1"/>  onClick="exportExcel_onClick();">
                    </div>
                </div>                    
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=simpleQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=stopSecurity" width="98%"
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
      
      <r:field fieldName="id_card_type_bd" sortAt="none" label="证件类别" width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" label="证件号码" width="100px" allowModify="false">
            <h:text />      
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
      
      <r:field fieldName="social_unit_name" sortAt="none" label="福利办理方" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_date" sortAt="none" label="办理日期" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd hh:mm:ss" />  
      </r:field>
      
      <!--siqiaopeng注
      <r:field fieldName="hire_fire_status" sortAt="none" label="用退工状态" width="100px" allowModify="false">
            <d:select dictTypeId="HIRE_FIRE_STATUS_BD" />
      </r:field>
      --><r:field fieldName="service_big_type_name" sortAt="none" label="员工大类" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="next_cust_name" sortAt="none" label="下家公司名称" width="100px">
            <h:text/>      
      </r:field>
      <r:field fieldName="nextcust_account" sortAt="none" label="下家公积金账号" width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="the_end_date" sortAt="none" label="收费截止日期" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" />
      </r:field>
      
      <r:field fieldName="end_month" sortAt="none" label="收费截止月" width="100px" >
            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;"/>      
      </r:field>
      
      <r:field fieldName="stop_type_name" sortAt="none" label="停办类型" allowModify="true"   >
        <h:text/>
      </r:field>
      
         <r:field fieldName="stop_remarks" sortAt="none" label="停办备注" width="100px">
            <h:text/>      
      </r:field>
      
       <r:field fieldName="stop_type" sortAt="none" label="停缴原因" width="100px" allowModify="false">
            <d:select dictTypeId="STOP_TYPE" nullLabel="--请选择--"/>  
      </r:field><!--siqiaopeng注
      <r:field fieldName="stop_reason_bd" sortAt="none" label="离职原因" width="100px" allowModify="false">
            <d:select dictTypeId="OFF_POST_REASON" nullLabel="--请选择--"/>  
      </r:field>
      <r:field fieldName="off_post_desc" sortAt="none" label="离职备注" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      <r:field fieldName="transact_date" sortAt="none" label="办理日期" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="transact_date" size="6"/>  
      </r:field>
       -->
      <r:field fieldName="apply_off_post_date" sortAt="none" label="离职日期" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="apply_off_post_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="off_post_date" sortAt="none" label="报离职日期" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd hh:mm:ss" name="off_post_date"/>  
      </r:field>
          
      <r:field fieldName="start_month" sortAt="none" label="缴费起始月" width="100px" allowModify="false">
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
        if (colIndex == 16){
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
   
   
   var field = {
    entityField:"stop_type_id",
    fieldId:"stop_type_id_9999",
    fieldName:"stop_type_id",
    sort:"no",
    allowResize:true,
    label:"停办类型",
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
                divA.id = "datacell1"+"_"+"stop_type_id"+"_9999"+"_field_editor_container";
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
                eos_orgEditor.queryAction = "/FAERP/SecuritygroupstopAction.do?cmd=getListStopType"; 
                eos_orgEditor.xpath = "SecuritygroupstopVo"; 
                eos_orgEditor.valueField = "id"; 
                eos_orgEditor.textField = "type_name"; 
                eos_orgEditor.isIeMode = false; 
                eos_orgEditor.readOnly = false; 
                eos_orgEditor.allowInput = false; 
                eos_orgEditor.allowFilter = true; 
                eos_orgEditor.disabled = false; 
                eos_orgEditor.nullText = "--请选择--";
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
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("stop_type_name") >= 0){
            var orgEditor = eos_orgEditor;
            var newDisValue = orgEditor.getDisplayValue(newValue);
            activeEntity.setProperty("stop_type_name", newDisValue);
        }
        return true;
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
	    var security_group_id='<%=security_group_id%>';
	    var social_unit_id='<%=social_unit_id%>';
	    var cust_name='<%=cust_name%>';
	    var cust_code='<%=cust_code%>';
	    if(isQuery)
	    {
	         if(security_group_id=='<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>')
	        {
	                document.getElementById("security_group_id").options[1].selected=true;
	        }
	        else if(security_group_id=='<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>')
	        {
	                  document.getElementById("security_group_id").options[2].selected=true;
	        }
	        document.all.form.social_unit_id.value= social_unit_id;
	        document.all.form.cust_name.value= cust_name;
	        document.all.form.cust_code.value= cust_code;
	        
	        $id('isClickQuery').value=true;
            $id("datacell1").loadData();
            $id("datacell1").refresh();
	    }
	}

//  make it all default value =  封存
//上海公积金：1099110700000000155/1099111000000000002 上海补充公积金 1099110700000000156/1099111000000000007

    $id("datacell1").afterLoadData = function(){
	    var datacelll1 = $id("datacell1");
	    var dataset1 = datacelll1.dataset;
	    for(var i=0; i< dataset1.getLength(); i++){
	        //dataset1.setProperty("security_group_id", "1099110700000000155");
	        var entity1 = dataset1.get(i);
	        var group_id=entity1.getProperty("security_group_id");
	        if(group_id='1099110700000000155'){
	            entity1.setProperty("stop_type_id", "1099111000000000002");
                entity1.setProperty("stop_type_name", "封存");
	        }else if(group_id='1099110700000000156'){
	            entity1.setProperty("stop_type_id", "1099111000000000007");
                entity1.setProperty("stop_type_name", "封存");
	        }
	    }
	    datacelll1.refresh();
    };    

</script>   
