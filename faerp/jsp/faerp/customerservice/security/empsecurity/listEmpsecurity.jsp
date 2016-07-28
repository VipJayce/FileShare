<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.empsecurity.vo.EmpsecurityVo" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IEmpsecurityConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IEmpsecurityConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    EmpsecurityVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listEmpsecurity_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listEmpsecurity0011'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数<fmt:message key='listEmpsecurity0009'/>
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listEmpsecurity0009'/>
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
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listEmpsecurity0046'/>修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listEmpsecurity0011'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"<fmt:message key='listEmpsecurity0014'/>"
            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    
    function findSelections2(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listEmpsecurity0011'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数<fmt:message key='listEmpsecurity0009'/>
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listEmpsecurity0009'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value+":"+i);  //加入选中的checkbox
                }
        }
        return ids;
    }
    //检验列表中必输项checkAllForms
    function checkAllTableValue() {
       var elementsocial_unit = document.getElementsByName("social_unit_id_arr");  //<fmt:message key='listEmpsecurity0072'/>
        var elementtransact_type = document.getElementsByName("transact_type_id_arr");  //新开类型
        var elementis_social_not_stop = document.getElementsByName("is_social_not_stop_arr");  //<fmt:message key='listEmpsecurity0074'/>
        var elementsocial_copy_month = document.getElementsByName("social_copy_month_arr");  //<fmt:message key='listEmpsecurity0075'/>
        var elementapply_remark = document.getElementsByName("apply_remark_arr");  //<fmt:message key='listEmpsecurity0076'/>
        var elementemp_name=document.getElementsByName("emp_name_arr");  //员工名称
        var elementCheckbox = document.getElementsByName("checkbox_template");  //通过name取出所<fmt:message key='listEmpsecurity0011'/>的checkbox
        var number = 0;  //定义游标
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listEmpsecurity0009'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(elementsocial_unit[i].value==""){
                    alert("<fmt:message key='listEmpsecurity0021'/>");
                    return false ;
                }else if(elementis_social_not_stop[i].value=='0'){
                    if(elementsocial_copy_month[i].value==""){
                        alert(elementemp_name[i].value+" <fmt:message key='listEmpsecurity0022'/>");
                        return false;
                    }
                }else if(elementtransact_type[i].value==""||elementapply_remark[i].value==""){
                    if(!confirm(elementemp_name[i].value+' <fmt:message key='listEmpsecurity0023'/>')){
                        return false;
                    }
                    //return confirm(elementemp_name[i].value+' <fmt:message key='listEmpsecurity0023'/>');
                }
            }
        }
        return confirm('<fmt:message key='listEmpsecurity0025'/>');
    }
    
    //提交社保申请
    function apply_onClick(){
        if(!checkAllTableValue()){
            return;
        }
       var ids = findSelections2("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        //if(confirm('<fmt:message key='listEmpsecurity0025'/>')) {  //如果用户在确认对话框按"<fmt:message key='listEmpsecurity0014'/>"
            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?ids=" + ids;
            form.cmd.value = "applySecurity";
            form.submit();
        //}
    }
    
    function back_onClick(){
        
    
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "simpleQuery";
        form.submit();
    }
    function toAdd_onClick() {  //<fmt:message key='listEmpsecurity0046'/>增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/insertEmpsecurity.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转<fmt:message key='listEmpsecurity0046'/>详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listEmpsecurity0011'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/EmpsecurityAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_1 %>">
<input type="hidden" name="backFlag" id="backFlag" value="true"> 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="6" valign="middle" align="center" ><div class="search_title"><fmt:message key='listEmpsecurity0032'/></div> </td>
        </tr>
        </tr>
              <td align="right">社保/公积金<fmt:message key='listEmpsecurity0009'/></td>
              <td align="left">
                    <select id="security_group_id" name="security_group_id" >
                       <option value="1099110700000000152">上海社保<fmt:message key='listEmpsecurity0009'/></option>
                    </select>
              </td>
              <td align="right"><fmt:message key='listEmpsecurity0034'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listEmpsecurity0034'/>" maxLength="9.5"/>
              </td>
              <td align="right">员工姓名</td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="9.5"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listEmpsecurity0038'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listEmpsecurity0038'/>" maxLength="64"/>
            </td>
            <td align="right"><fmt:message key='listEmpsecurity0040'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listEmpsecurity0040'/>" maxLength="50"/>
            </td>
            <td align="right"><fmt:message key='listEmpsecurity0042'/></td>
              <td align="left">
                    <%=gap.rm.tools.helper.RmJspHelper.getSelectField("post_status_bd", -1,"POST_STATUS_BD",""," id=post_status_bd",false) %>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listEmpsecurity0043'/></td>
            <td align="left">
                <select id="" name="" ></select>
            </td>
            <td align="right">报<fmt:message key='listEmpsecurity0048'/></td>
            <td align="left">
               <input type="text" class="text_field_half_reference_readonly" name="on_post_date_from" id="on_post_date_from" inputName="报<fmt:message key='listEmpsecurity0048'/>"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_post_date_from','<venus:base/>/');"/>&nbsp;<fmt:message key='listEmpsecurity0046'/>&nbsp;<input type="text" class="text_field_half_reference_readonly" name="on_post_date_to" id="on_post_date_to" inputName="包<fmt:message key='listEmpsecurity0048'/>"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_post_date_to','<venus:base/>/');"/>
            </td>
            <td align="right"><fmt:message key='listEmpsecurity0048'/></td>
            <td align="left">
                <input type="text" class="text_field_half_reference_readonly" name="apply_on_post_date_from" id="apply_on_post_date_from" inputName="<fmt:message key='listEmpsecurity0048'/>"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_on_post_date_from','<venus:base/>/');"/>&nbsp;<fmt:message key='listEmpsecurity0046'/>&nbsp;<input type="text" class="text_field_half_reference_readonly" name="apply_on_post_date_to" id="apply_on_post_date_to" inputName="<fmt:message key='listEmpsecurity0048'/>"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_on_post_date_to','<venus:base/>/');"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listEmpsecurity0052'/></td>
            <td align="left">
                 <%=RmJspHelper.getSelectField("is_back", -1,"TrueOrFalse","","id=is_back",false) %>
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
            <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listEmpsecurity0053'/> </a> </li>
                    <li class="bl_1">      <a onClick="javascript:apply_onClick();"><fmt:message key='listEmpsecurity0054'/> </a></li>
                    <li class="nbl">       <a  onClick="javascript:back_onClick();"><fmt:message key='listEmpsecurity0055'/></a> </li>
                    <li class="e">         <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key='listEmpsecurity0056'/> </a> </li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1" id="listTable">
<tr>
<th><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
        <th>
                
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_code")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_code")%>">
            </a>    
       
             <fmt:message key='listEmpsecurity0034'/></th>
             <th>
                
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_name")%>">
            </a>    
       
             员工姓名</th>
              <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"internal_code")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"internal_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"internal_code")%>">
            </a>    
       
             <fmt:message key='listEmpsecurity0059'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"id_card_type_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"id_card_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"id_card_type_bd")%>">
            </a>    
             <fmt:message key='listEmpsecurity0060'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"id_card")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"id_card")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"id_card")%>">
            </a>    
             <fmt:message key='listEmpsecurity0061'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_code")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_code")%>">
            </a>    
       
             <fmt:message key='listEmpsecurity0038'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_name")%>">
            </a>    
             <fmt:message key='listEmpsecurity0040'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"group_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"group_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"group_name")%>">
            </a>    
             社保<fmt:message key='listEmpsecurity0009'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_on_post_date")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_on_post_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_on_post_date")%>">
            </a>    
             <fmt:message key='listEmpsecurity0065'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"on_post_date")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"on_post_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"on_post_date")%>">
            </a>    
            <fmt:message key='listEmpsecurity0066'/></th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"post_status_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"post_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"post_status_bd")%>">
            </a>    
            <fmt:message key='listEmpsecurity0042'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_small_type")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_small_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_small_type")%>">
            </a>    
             <fmt:message key='listEmpsecurity0068'/></th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_big_type")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_big_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_big_type")%>">
            </a>    
             <fmt:message key='listEmpsecurity0069'/></th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"classify_date")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"classify_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"classify_date")%>">
            </a>    
             <fmt:message key='listEmpsecurity0070'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"transact_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"transact_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"transact_type_id")%>">
            </a>    
       
             <fmt:message key='listEmpsecurity0071'/></th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"social_unit_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"social_unit_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"social_unit_id")%>">
            </a>    
             <fmt:message key='listEmpsecurity0072'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"back_reason")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"back_reason")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"back_reason")%>">
            </a>    
             <fmt:message key='listEmpsecurity0073'/></th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_social_not_stop")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_social_not_stop")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_social_not_stop")%>">
            </a>    
             <fmt:message key='listEmpsecurity0074'/></th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"social_copy_month")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"social_copy_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"social_copy_month")%>">
            </a>    
             <fmt:message key='listEmpsecurity0075'/></th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_remark")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_remark")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_remark")%>">
            </a>    
       
             <fmt:message key='listEmpsecurity0076'/></th>
            </tr>
    <logic:iterate name="beans"  id="data" scope="request" indexId="indexs">
        <tr>
          <td>&nbsp;<input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

            <td>&nbsp;<bean:write name="data" property="emp_code"/></td>
            
            <td>&nbsp;<bean:write name="data" property="emp_name"/><input type="hidden" name="emp_name_arr" value="<bean:write name="data" property="emp_name"/>"/></td>
            
            <td>&nbsp;<bean:write name="data" property="internal_code"/></td>
            
            <td>&nbsp;
                 <bean:define id="id_card_type_bd" name="data" property="id_card_type_bd"/>
                        <%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",String.valueOf(id_card_type_bd))%>
            <td>&nbsp;<bean:write name="data" property="id_card"/></td>
            
            <td>&nbsp;<bean:write name="data" property="cust_code"/></td>
            
            <td>&nbsp;<bean:write name="data" property="cust_name"/></td>
            
            <td>&nbsp;<bean:write name="data" property="group_name"/></td>
            
            <td>&nbsp;<bean:write name="data" property="apply_on_post_date" format="yyyy-MM-dd"/></td>
            
            <td>&nbsp;<bean:write name="data" property="on_post_date" format="yyyy-MM-dd"/></td>
            
            <td>&nbsp;
                 <bean:define id="post_status_bd" name="data" property="post_status_bd"/>
                  <%=BaseDataHelper.getNameByCode("POST_STATUS_BD",String.valueOf(post_status_bd))%>
            </td>
            
            <td>&nbsp;<bean:write name="data" property="service_big_type_name"/></td>
            
            <td>&nbsp;<bean:write name="data" property="service_small_type_name"/></td>
            
            <td>&nbsp;<bean:write name="data" property="classify_date"/></td>
            
            <td>&nbsp;
                <bean:define id="transact_type_id" name="data" property="transact_type_id"/>
                <faerp:SecurityGroupNewSelectTag beanname="data" group_id="1099110700000000152" attribute="transact_type_id" tagname="transact_type_id_arr" />
            <td>&nbsp;
                 <bean:define id="social_unit_id" name="data" property="social_unit_id"/>
                 <faerp:SoialunitSelectTag  beanname="data" attribute="social_unit_id" tagname="social_unit_id_arr"/>
            </td>
            
            <td>&nbsp;
                     <input type="text" class="text_field" name="back_reason_arr" value="<bean:write name="data" property="back_reason"/>"/>
            </td>
            
            <td align="center">
                     <bean:define id="is_social_not_stop" name="data" property="is_social_not_stop"/>
                     <%=RmJspHelper.getSelectField("is_social_not_stop_arr", -1,"TrueOrFalse",String.valueOf(is_social_not_stop)==""?"1":String.valueOf(is_social_not_stop),"",true) %>
            </td>
            
            <td>&nbsp;
                 <input type="text" class="text_field" name="social_copy_month_arr" value="<bean:write name="data" property="social_copy_month"/>"  size='2'/>
            </td>
            
            <td>&nbsp;
                     <input type="text" class="text_field" name="apply_remark_arr" value="<bean:write name="data" property="apply_remark"/>"  size='8'/>
                     </td>
            
            </tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

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
<%  //表单回写
    if(request.getAttribute(IEmpsecurityConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEmpsecurityConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
