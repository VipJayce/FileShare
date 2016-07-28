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
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
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
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    
    function findSelections2(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
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
       var elementsocial_unit = document.getElementsByName("social_unit_id_arr");  //福利办理方
        var elementtransact_type = document.getElementsByName("transact_type_id_arr");  //新开类型
        var elementis_social_not_stop = document.getElementsByName("is_social_not_stop_arr");  //是否福利不停
        var elementsocial_copy_month = document.getElementsByName("social_copy_month_arr");  //福利复制月
        var elementapply_remark = document.getElementsByName("apply_remark_arr");  //申请备注
        var elementemp_name=document.getElementsByName("emp_name_arr");  //员工名称
        var elementCheckbox = document.getElementsByName("checkbox_template");  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(elementsocial_unit[i].value==""){
                    alert("福利办理方不能为空！");
                    return false ;
                }else if(elementis_social_not_stop[i].value=='0'){
                    if(elementsocial_copy_month[i].value==""){
                        alert(elementemp_name[i].value+" 福利复制月不能为空！");
                        return false;
                    }
                }else if(elementtransact_type[i].value==""||elementapply_remark[i].value==""){
                    if(!confirm(elementemp_name[i].value+' 办理类型或者申请备注为空，确认要提交吗？')){
                        return false;
                    }
                    //return confirm(elementemp_name[i].value+' 办理类型或者申请备注为空，确认要提交吗？');
                }
            }
        }
        return confirm('确认要提交申请吗？');
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
        //if(confirm('确认要提交申请吗？')) {  //如果用户在确认对话框按"确定"
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
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/insertEmpsecurity.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
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
            <td width="174" rowspan="6" valign="middle" align="center" ><div class="search_title">查询条件</div> </td>
        </tr>
        </tr>
              <td align="right">社保/公积金组</td>
              <td align="left">
                    <select id="security_group_id" name="security_group_id" >
                       <option value="1099110700000000152">上海社保组</option>
                    </select>
              </td>
              <td align="right">唯一号</td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="9.5"/>
              </td>
              <td align="right">员工姓名</td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="9.5"/>
              </td>
        </tr>
        <tr>
            <td align="right">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="64"/>
            </td>
            <td align="right">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="客户名称" maxLength="50"/>
            </td>
            <td align="right">入离职状态</td>
              <td align="left">
                    <%=gap.rm.tools.helper.RmJspHelper.getSelectField("post_status_bd", -1,"POST_STATUS_BD",""," id=post_status_bd",false) %>
              </td>
        </tr>
        <tr>
            <td align="right">客服</td>
            <td align="left">
                <select id="" name="" ></select>
            </td>
            <td align="right">报入职日期</td>
            <td align="left">
               <input type="text" class="text_field_half_reference_readonly" name="on_post_date_from" id="on_post_date_from" inputName="报入职日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_post_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="on_post_date_to" id="on_post_date_to" inputName="包入职日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_post_date_to','<venus:base/>/');"/>
            </td>
            <td align="right">入职日期</td>
            <td align="left">
                <input type="text" class="text_field_half_reference_readonly" name="apply_on_post_date_from" id="apply_on_post_date_from" inputName="入职日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_on_post_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="apply_on_post_date_to" id="apply_on_post_date_to" inputName="入职日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_on_post_date_to','<venus:base/>/');"/>
            </td>
        </tr>
        <tr>
            <td align="right">是否被退回</td>
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
                    <li class="a_2">       <a  onClick="javascript:detail_onClick();">查看个人订单 </a> </li>
                    <li class="bl_1">      <a onClick="javascript:apply_onClick();">申请办理 </a></li>
                    <li class="nbl">       <a  onClick="javascript:back_onClick();">不需办理</a> </li>
                    <li class="e">         <a  onClick="javascript:findCheckbox_onClick();">导出 </a> </li>
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
       
             唯一号</th>
             <th>
                
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_name")%>">
            </a>    
       
             员工姓名</th>
              <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"internal_code")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"internal_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"internal_code")%>">
            </a>    
       
             客户方编号</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"id_card_type_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"id_card_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"id_card_type_bd")%>">
            </a>    
             证件类别</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"id_card")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"id_card")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"id_card")%>">
            </a>    
             证件号码</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_code")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_code")%>">
            </a>    
       
             客户编号</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_name")%>">
            </a>    
             客户名称</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"group_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"group_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"group_name")%>">
            </a>    
             社保组</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_on_post_date")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_on_post_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_on_post_date")%>">
            </a>    
             入职时间</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"on_post_date")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"on_post_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"on_post_date")%>">
            </a>    
            报入职时间</th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"post_status_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"post_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"post_status_bd")%>">
            </a>    
            入离职状态</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_small_type")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_small_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_small_type")%>">
            </a>    
             员工大类</th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_big_type")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_big_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_big_type")%>">
            </a>    
             员工小类</th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"classify_date")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"classify_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"classify_date")%>">
            </a>    
             分类时间</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"transact_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"transact_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"transact_type_id")%>">
            </a>    
       
             办理类型</th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"social_unit_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"social_unit_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"social_unit_id")%>">
            </a>    
             福利办理方</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"back_reason")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"back_reason")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"back_reason")%>">
            </a>    
             回退原因</th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_social_not_stop")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_social_not_stop")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_social_not_stop")%>">
            </a>    
             是否福利不停</th>
            <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"social_copy_month")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"social_copy_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"social_copy_month")%>">
            </a>    
             福利复制月</th>
             <th>
                <a href="/FAERP/EmpsecurityAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_remark")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_remark")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_remark")%>">
            </a>    
       
             申请备注</th>
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
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(IEmpsecurityConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEmpsecurityConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
