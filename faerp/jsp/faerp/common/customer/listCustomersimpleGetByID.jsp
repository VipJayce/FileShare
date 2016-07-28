<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.customersimple.vo.CustomersimpleVo"%>
<%@ page import="rayoo.sales.customersimple.util.ICustomersimpleConstants"%>
<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(ICustomersimpleConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(ICustomersimpleConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    CustomersimpleVo resultVo = null; //定义一个临时的vo变量
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择客户</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
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
        form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?id=" + ids;
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
            form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "queryAllGetByID";
        form.submit();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/customersimple/insertCustomersimple.jsp";
        form.submit();
        //MyWin.Create('','修改客户简档','<%=request.getContextPath()%>/jsp/sales/customersimple/insertCustomersimple.jsp','920','470','100','30');
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
        var returnAry = new Array();
        returnAry[0] = ids;
        returnAry[1] = document.getElementById(ids+'customer_code').value;
        returnAry[2] = document.getElementById(ids+'customer_name').value;
        window.returnValue=returnAry;
        window.close();

    }

</script>
    </head>
    <body>
    
    <form name="form" method="post"
        action="<%=request.getContextPath()%>/CustomersimpleAction.do">
    <input type="hidden" name="cmd" value="queryAllGetByID">
    <input type="hidden" name="backFlag" id="backFlag" value="true">


    <div id="right"><script language="javascript">
    writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">


    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>
        </tr>
        <tr>
            <td align="left">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" name="customer_code" inputName="客户编号" maxLength="25"/>
            </td>
            <td align="left">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" name="customer_name" inputName="客户名称" maxLength="50"/>
            </td>
            <td><input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"> </td>
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="bc"><a onClick="javascript:detail_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>

    <div id="values_div" class="box">
    <table width="100%" cellspacing="0" class="datagrid1">
        <tr>
            <th class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);" pdType='control' control='checkbox_template' /></th>
            
                 <th><a href="/FAERP/CustomersimpleAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"customer_code")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"customer_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"customer_code")%>"></a>    
        客户编号</th>   
            
                <th><a href="/FAERP/CustomersimpleAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"customer_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"customer_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"customer_name")%>"></a>    
        客户名称</th>
        </tr>
        <logic:iterate name="beans" id="data" scope="request" indexId="indexs">
            <tr>
                <td class="fex_row"><input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>" /></td>
                <td><bean:write name="data" property="customer_code"/><input type="hidden" id="<bean:write name="data" property="id"/>customer_code" value="<bean:write name="data" property="customer_code"/>"/></td>
                <td><bean:write name="data" property="customer_name"/><input type="hidden" id="<bean:write name="data" property="id"/>customer_name" value="<bean:write name="data" property="customer_name"/>"> </td>
            </tr>
        </logic:iterate>
    </table>
    </div>
    <jsp:include page="/jsp/include/page.jsp" /></div>
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
    if(request.getAttribute(ICustomersimpleConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICustomersimpleConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>
