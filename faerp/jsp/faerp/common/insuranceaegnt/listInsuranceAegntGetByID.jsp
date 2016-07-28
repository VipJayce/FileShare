<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.insurance.insuranceaegnt.vo.InsuranceAegntVo" %>
<%@ page import="rayoo.insurance.insuranceaegnt.util.IInsuranceAegntConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(IInsuranceAegntConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(IInsuranceAegntConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    InsuranceAegntVo resultVo = null; //定义一个临时的vo变量
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择保险供应商</title>
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
        form.action="<%=request.getContextPath()%>/InsuranceAegntAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "queryAllGetByID";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
        var aegnt_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
            if(aegnt_check[i].checked){
                ids.push(aegnt_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        entity=$id("datacell1").getActiveEntity();
        var returnAry = new Array();
        returnAry[0] = ids;
        returnAry[1] = entity.getProperty("agent_code");
        returnAry[2] = entity.getProperty("agent_name");
        window.returnValue=returnAry;
        window.close();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
</script>
    </head>
    <body>
    
    <form name="form" method="post" id="datacell_formid">
    <div id="right">
    <div class="ringht_s">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>
        </tr>
        <tr>
            <td align="left">供应商编号</td>
          <td align="left">
           <input type="text" class="text_field" name="agent_code" inputName="供应商编号" maxLength="64"/>
          </td>
          <td align="left">供应商名称</td>
          <td align="left">
              <input type="text" class="text_field" name="agent_name" inputName="供应商名称" maxLength="50"/>
          </td>
            <td><input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()"> </td>
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="a"><a onClick="javascript:detail_onClick();">选择</a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
     <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/InsuranceAegntAction.do?cmd=searchInsuranceData"
        width="98%"
        height="318px"
        xpath="InsuranceAegntVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="80px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="agent_code" label="供应商编号" width="300px">
      </r:field>
      <r:field fieldName="agent_name" label="供应商名称" width="389px">
      </r:field>
    </r:datacell>
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
    if(request.getAttribute(IInsuranceAegntConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IInsuranceAegntConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>
