<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@ page import="rayoo.sales.customer.util.ICustomerConstants" %>
<html>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
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
        var url = "<%=request.getContextPath()%>/Pps_customerAction.do?cmd=find&id=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=PPS客户修改');
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/CustomerAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function callBack(reg){
        alert("<fmt:message key='operation_over'/>");
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function insertcallBack(reg){
        if(reg=="0"){
            alert("<fmt:message key='add_success'/>");
        }else{
            alert("<fmt:message key='add_false'/>");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
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
        var url = "<%=request.getContextPath()%>/Pps_customerAction.do?cmd=detail&id=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看PPS客户信息');
    }

    function exportExcel_onClick(){  //导出Excel
        form.cmd.value = "exportExcel";
        form.submit();
    }  
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
</script>
 

</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/Pps_customerAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 <input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="customer_maintain"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='query_conditions'/></div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>
                <tr>
            <td align="left"><fmt:message key='customer_code'/></td>
            <td align="left">
                <input type="text" class="text_field" id="customer_code"  name="customer_code" value="" inputName="客户编号" maxLength="25"/>
            </td>
             <td align="left"><fmt:message key='customer_name'/></td>
            <td align="left">
                <input type="text" class="text_field" id="customer_name" name="customer_name" value="" inputName="客户名称" maxLength="25"/>
            </td>
            <td align="right">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td><td>
                <input type="reset" class="icon_1"  />
                </td>
            <td align="left"></td>
        </tr>
</table>
</div>
 

 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
         <input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="cust_view" type="1"/>  onClick="detail_onClick();">
        <input class="b"  type="button"   value="<fmt:message key="modify"/>"   <au:authorityBtn code="cust_modify" type="1"/> onClick="findCheckbox_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/Pps_customerAction.do?cmd=queryCustomerData" width="98%" height="318px" xpath="Pps_customerVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="customer_name" messagekey="customer_name" width="251px" ></r:field>    
 <r:field fieldName="customer_code" messagekey="customer_code" width="251px"></r:field>
 <r:field fieldName="customer_en_name" label="客户英文名" width="251px"></r:field>
 <r:field fieldName="create_date" messagekey="create_date"  allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
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
<% //表单回写
    if(request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        //out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>   
