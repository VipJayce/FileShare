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
<%@ page import="rayoo.customerservice.laborcontract.vo.LaborcontractVo" %>
<%@ page import="rayoo.customerservice.laborcontract.util.ILaborcontractConstants" %>

<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ILaborcontractConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ILaborcontractConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    LaborcontractVo resultVo = null;  //定义一个临时的vo变量
    Map map = request.getAttribute("map") == null?new HashMap():(Map)request.getAttribute("map");
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.laborcontract.listLaborEnd_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listLaborEnd0011'/>的checkbox
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
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listLaborEnd0039'/>修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listLaborEnd0011'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/LaborcontractAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"<fmt:message key='listLaborEnd0014'/>"
            form.action="<%=request.getContextPath()%>/LaborcontractAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //<fmt:message key='listLaborEnd0039'/>增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/customerservice/laborcontract/insertLaborcontract.jsp";
        form.submit();
    }
   

    function submit_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        form.action="<%=request.getContextPath()%>/LaborcontractAction.do?id=" + ids;
        form.cmd.value = "Save";
        form.submit();
    }
    
    function blur_change(str,obj){
        var popid = obj.name.substring(0,19);
        document.getElementById('popid').value =  popid;
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            return;
        }
        for(var i=0;i<ids.length;i++){
            var id = ids[i];
            document.getElementById(id+str).value = obj.value;
        }
        return true;
    }
    
    function torenew_onClick(){
         var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listLaborEnd0011'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var enCurEntity = $id("datacell1").activeEntity;
        var labor_status_bd = enCurEntity.getProperty('labor_status_bd');
            //form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=toRenew&id=" + ids;
            //form.submit();
            var url = "<%=request.getContextPath()%>/LaborcontractAction.do?cmd=toRemindRenew&id=" + ids+"&_ts='+(new Date()).getTime()";
            showModalCenter(url, window, callBack, 1024, 480, "劳动合同<fmt:message key='listLaborEnd0055'/>"); 
        
    }
    
     function info_onClick(){ 
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listLaborEnd0011'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var emp_code = document.getElementById(ids+'emp_code').value;
        var cust_id = document.getElementById(ids+'cust_id').value;
        form.action="<%=request.getContextPath()%>/LaborcontractAction.do?id=" + ids+'&emp_code='+emp_code+'&cust_id='+cust_id;
        form.cmd.value = "toPersonOrderInfo";
        form.submit();
    }
    
    function execl_onClick(){  //导出Excel
        oldCmd = form.cmd.value;
        form.cmd.value = "exportExcel";
        form.submit();
    }  
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    function toremind_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listLaborEnd0011'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=updateRemindById&id=" + ids;
        //form.submit();
        $id('datacell1').submitAction = "<%=request.getContextPath()%>/LaborcontractAction.do?cmd=updateRemindById&id=" + ids;
        $id('datacell1').submit();
    }
    
    function callBack(reg){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/LaborcontractAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true"> 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key='listLaborEnd0026'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="125px" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listLaborEnd0027'/></div> </td>
           </tr>
           
           <tr>
            <td align="left"><fmt:message key='listLaborEnd0028'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listLaborEnd0029'/>" value="" maxLength="50"/>
            </td>
            <td align="left"><fmt:message key='listLaborEnd0030'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listLaborEnd0030'/>" value="" maxLength="64"/>
            </td>
            <td align="left"><fmt:message key='listLaborEnd0032'/></td>
            <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listLaborEnd0032'/>" value="" maxLength="50"/>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborEnd0034'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listLaborEnd0034'/>" value="" maxLength="64"/>
            </td>
            <td align="left"><fmt:message key='listLaborEnd0036'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listLaborEnd0037'/>" value="" maxLength="50"/>
            </td>
            <td align="left"><fmt:message key='listLaborEnd0038'/></td>
            <td align="left">
                <w:date allowInput="true" id="send_start_date_from" name="send_start_date_from" format="yyyy-MM-dd" style="width:75px;"/>
                &nbsp;<fmt:message key='listLaborEnd0039'/>&nbsp;
                <w:date allowInput="true" id="send_start_date_to" name="send_start_date_to" format="yyyy-MM-dd" style="width:75px;"/>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborEnd0040'/></td>
            <td align="left">
                <w:date allowInput="true" id="last_update_date_from" name="last_update_date_from" format="yyyy-MM-dd" style="width:75px;"/>
                &nbsp;<fmt:message key='listLaborEnd0039'/>&nbsp;
                <w:date allowInput="true" id="last_update_date_to" name="last_update_date_to" format="yyyy-MM-dd" style="width:75px;"/>               
            </td>
            <td align="left"><fmt:message key='listLaborEnd0042'/>(<fmt:message key='listLaborEnd0043'/>)</td>
            <td align="left">
                <w:date allowInput="true" id="start_date_from" name="start_date_from" format="yyyy-MM-dd" style="width:75px;"/>
                &nbsp;<fmt:message key='listLaborEnd0039'/>&nbsp;
                <w:date allowInput="true" id="start_date_to" name="start_date_to" format="yyyy-MM-dd" style="width:75px;"/>                
            </td>
            <td align="left"><fmt:message key='listLaborEnd0042'/>(<fmt:message key='listLaborEnd0046'/>)</td>
            <td align="left">
                <w:date allowInput="true" id="try_start_date_from" name="try_start_date_from" format="yyyy-MM-dd" style="width:75px;"/>
                &nbsp;<fmt:message key='listLaborEnd0039'/>&nbsp;
                <w:date allowInput="true" id="try_start_date_to" name="try_start_date_to" format="yyyy-MM-dd" style="width:75px;"/>               
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborEnd0048'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("labor_status_bd", -1,"LABOR_STATUS_BD","","id=labor_status_bd",false) %>
            </td>
            <td align="left"><fmt:message key='listLaborEnd0049'/></td>
            <td align="left">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("labor_type_bd", -1,"LABOR_TYPE_BD",""," id=labor_type_bd",false) %>
            </td>
            <td align="left"><fmt:message key='listLaborEnd0050'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("post_status_bd", -1,"POST_STATUS_BD",""," id=post_status_bd",false) %>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborEnd0051'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_post_type_bd", -1,"EMP_POST_TYPE_BD",""," id=emp_post_type_bd",false) %>
            </td>
            <td align="left"><fmt:message key='listLaborEnd0052'/></td>
            <td align="left">
               <r:comboSelect id="combo_cs" name="user_id" queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                 textField="name" valueField="partyId" xpath="CustServiceVo" width="200px" nullText="<fmt:message key='listLaborEnd0053'/>" />
            </td>
            <td align="left" colspan="2">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            <input type="reset" class="icon_1"   type="button" value="<fmt:message key='listLaborEnd0054'/>" >
            </td>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="bl">   <a  onClick="javascript:torenew_onClick();"><fmt:message key='listLaborEnd0055'/></a></li>
                     <li class="bl_1">   <a  onClick="javascript:toremind_onClick();"><fmt:message key='listLaborEnd0056'/></a></li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
 
 
 
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/LaborcontractAction.do?cmd=queryLoborEndData" width="98%" height="318px" 
 xpath="LaborcontractVo" paramFormId="datacell_formid" >
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <r:field fieldName="id" messagekey='listLaborEnd0057' width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
    <r:field fieldName="emp_post_id" messagekey='listLaborEnd0058' width="0px;"></r:field>
    <r:field fieldName="emp_name" messagekey='listLaborEnd0029'></r:field>   
    <r:field fieldName="emp_code" messagekey='listLaborEnd0060'></r:field>
    <r:field fieldName="id_card" messagekey='listLaborEnd0061'></r:field>
    <r:field fieldName="emp_post_type_bd" messagekey='listLaborEnd0051' allowModify="false">
        <d:select dictTypeId="EMP_POST_TYPE_BD"></d:select>
    </r:field>
    <r:field fieldName="cust_name" messagekey='listLaborEnd0063'></r:field>
    <r:field fieldName="user_name" messagekey='listLaborEnd0052'></r:field>
    <r:field fieldName="salary" label="<fmt:message key='listLaborEnd0065'/>(<fmt:message key='listLaborEnd0043'/>)"></r:field>
    <r:field fieldName="labor_status_bd" messagekey='listLaborEnd0048' allowModify="false">
        <d:select dictTypeId="LABOR_STATUS_BD"></d:select>
    </r:field>
    <r:field fieldName="subscribe_date" messagekey='listLaborEnd0068' allowModify="false">
        <w:date allowInput="true" id="subscribe_date" name="subscribe_date" format="yyyy-MM-dd"/>
    </r:field>
    <r:field fieldName="welfare_address" messagekey='listLaborEnd0069' allowModify="false">
        <h:text name="welfare_address" value=""/>
    </r:field>
    <r:field fieldName="position" messagekey='listLaborEnd0070' allowModify="false">
        <h:text name="position" value=""/>
    </r:field>
    <r:field fieldName="working_bd" messagekey='listLaborEnd0071' allowModify="false">
        <d:select dictTypeId="WORKING_BD"></d:select>
    </r:field>
    <r:field fieldName="send_start_date" messagekey='listLaborEnd0038' allowModify="false">
         <w:date allowInput="true" id="send_start_date" name="send_start_date" format="yyyy-MM-dd"/>
    </r:field>
    <r:field fieldName="send_end_date" messagekey='listLaborEnd0073' allowModify="false">
         <w:date allowInput="true" id="send_end_date" name="send_end_date" format="yyyy-MM-dd"/>
    </r:field>
    <r:field fieldName="start_date" messagekey='listLaborEnd0042' allowModify="false">
         <w:date allowInput="true" id="start_date" name="start_date" format="yyyy-MM-dd"/>
    </r:field>
    <r:field fieldName="end_date" messagekey='listLaborEnd0075' allowModify="false">
         <w:date allowInput="true" id="end_date" name="end_date" format="yyyy-MM-dd"/>
    </r:field>
    <r:field fieldName="try_start_date" messagekey='listLaborEnd0076' allowModify="false">
         <w:date allowInput="true" id="true" name="true" format="YYYY-MM-DD"/>
    </r:field>
    <r:field fieldName="try_end_date" messagekey='listLaborEnd0077' allowModify="false">
         <w:date allowInput="true" id="try_end_date" name="try_end_date" format="yyyy-MM-dd"/>
    </r:field>
    <r:field fieldName="try_salary" messagekey='listLaborEnd0065' allowModify="false"></r:field>
    <r:field fieldName="labor_type_bd" messagekey='listLaborEnd0049' allowModify="false">
        <d:select dictTypeId="LABOR_TYPE_BD" ></d:select>
    </r:field>
    <r:field fieldName="last_update_date" messagekey='listLaborEnd0040' allowModify="false">
         <w:date allowInput="true" id="last_update_date" name="last_update_date" format="yyyy-MM-dd"/>
    </r:field>
    <r:field fieldName="remark" messagekey='listLaborEnd0082'></r:field>
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
<%  //表单回写
    if(request.getAttribute(ILaborcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ILaborcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
