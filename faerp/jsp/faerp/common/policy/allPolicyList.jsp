<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@page import="rayoo.insurance.welfareproduct.vo.WelfareProductVo"%>
<%@page import="rayoo.insurance.policy.util.IPolicyConstants"%>
<jsp:useBean id="agentaction" class="rayoo.sales.agent.action.AgentAction" scope="page" />
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IPolicyConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IPolicyConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    WelfareProductVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
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
	function returnvalue() {  //从多选框到修改页面
        var elementCheckbox = document.getElementsByName("checkbox_template");
        var number = 0;
        var ids = "";
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {
                number += 1;
                ids+=elementCheckbox[i].value+",";
            }
        }
        if(number == 0) {
            alert("请至少选择一条记录!");
            return;
        }
        window.returnValue=ids;
        window.close();
    }
	
    function simpleQuery_onClick(){
        form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=queryAllPolicy&date="+new Date();
        form.submit();
    }
    
    function resetQuery(){
        document.form.product_supplier.value="";
        document.form.product_supplier_name.value="";
    }
    
    function cancel_onClick(){
        window.close();
    }

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/PolicyAction.do">
<input type="hidden" name="cmd" value="queryAllPolicy">
<input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('选择产品','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">     
 <div id="ccChild0" class="search">
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                     <td width="140" rowspan="3" style="padding-top: 0;"><div class="search_title">查询条件</div>   </td>
                </tr>
                <tr>
                    <td align="left" width="80">产品名称</td>
                    <td align="left" width="140"><input type="text" class="text_field" name="product_name" inputName="产品名称" maxLength="50" /></td>
                    <td align="left">
                       <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"> 
                    </td>
              </tr>
           </table>
       </div>               
<div id="ccParent1" class="button"> 
    <div class="button_right">
         <ul>
            <li class="g">     <a  onClick="javascript:returnvalue();"><fmt:message key="choice"/> </a> </li>
         </ul>
    </div>
</div>
 
 <div id="values_div" class="box_xinzeng_table" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onClick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>
                
                <a href="/FAERP/PolicyAction.do?cmd=queryAllPolicy&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_name")%>">              </a>    
       
             产品名称</th>
            <th>
                    
                    <a href="/FAERP/PolicyAction.do?cmd=queryAllPolicy&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"big_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"big_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"big_type_id")%>">
            </a>    
       
     产品大类</th>
        <th>
                    
                    <a href="/FAERP/PolicyAction.do?cmd=queryAllPolicy&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"small_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"small_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"small_type_id")%>">
            </a>    
       
     产品小类</th>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
        <tr>
        <td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>
        <td><bean:write name="data" property="product_name" /></td>
            <td>&nbsp;<bean:define id="big_type_id" name="data" property="big_type_id"/>
            <%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(big_type_id))%>
            </td>       
            <td>&nbsp;<bean:define id="small_type_id" name="data" property="small_type_id"/>
            <%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(small_type_id))%>
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
    if(request.getAttribute(IPolicyConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPolicyConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
