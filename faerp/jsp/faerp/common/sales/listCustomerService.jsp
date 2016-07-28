<%@ page contentType="text/html; charset=UTF-8" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@ page import="rayoo.sales.customer.util.ICustomerConstants" %>
<%  //取出List
List lResult = null;  //定义结果列表的List变量
if(request.getAttribute(ICustomerConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
    lResult = (List)request.getAttribute(ICustomerConstants.REQUEST_BEANS);  //赋值给resultList
}
Iterator itLResult = null;  //定义访问List变量的迭代器
if(lResult != null) {  //如果List变量不为空
    itLResult = lResult.iterator();  //赋值迭代器
}
CustomerVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择销售/客服</title>
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
   
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "simpleCustomerService";
        form.submit();
    }
   
    function confirm_onClick(){
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
        returnAry[1] = document.getElementById(ids+'name').value;
        window.returnValue=returnAry;
        window.close();
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CustomerAction.do">
<input type="hidden" name="cmd" value="simpleCustomerService">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
     </tr>
      <tr>
            <td align="left">员工</td>
            <td align="left">
                <input type="text" class="text_field" name="name" inputName="员工" maxLength="50"/>
            </td>
            <td align="left">角色</td>
            <td align="left">
                <input type="text" class="text_field" name="role_name" inputName="角色" maxLength="18"/>
            </td>
            <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button">
<div class="button_right">
    <ul>
        <li class="bc"><a onClick="javascript:confirm_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/CustomerAction.do?cmd=queryCustomerServiceData" width="98%" height="318px" xpath="CustomerVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="10%" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="name" label="客服名字" width="45%"></r:field>
 <r:field fieldName="role_name" label="角色" width="45%"></r:field>
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
<% //表单回写
    if(request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
