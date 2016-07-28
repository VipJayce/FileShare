<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@page import="rayoo.sales.customer.util.ICustomerConstants"%>
<%@page import="rayoo.sales.customersimple.vo.CustomersimpleVo"%>
<jsp:useBean id="agentaction" class="rayoo.sales.agent.action.AgentAction" scope="page" />
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ICustomerConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ICustomerConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    String policy_item_id = request.getAttribute("policy_item_id").toString();
    //String customer_ids = request.getAttribute("customer_ids").toString();
    CustomersimpleVo resultVo = null;  //定义一个临时的vo变量
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
    
    function simpleQuery1_onClick(){
        form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=queryAllCustomer&date="+new Date();
        form.submit();
    }
	
	function returnvalue() {  //从多选框到修改页面
	    var customer_ids="${requestScope.customer_ids}";
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        var new_customer_ids="";
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                if(customer_ids.indexOf(id_check[i].value)!=-1){
                    //ids.push(id_check[i].value);  //加入选中的checkbox
                    ids.push(id_check[i].getAttribute("customer_name"));  //加入选中的checkbox
                }else{
                    new_customer_ids+=id_check[i].value+",";
                }
            }
        }
        if(ids==null||ids==""){
            if(new_customer_ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
            }
        }
        addCustomerToPolicy(new_customer_ids);
        //alert("new_customer_ids="+new_customer_ids);
        window.returnValue=ids;
        window.close();
    }
    
    function resetQuery(){
        document.form.product_supplier.value="";
        document.form.product_supplier_name.value="";
    }
    
    function addCustomerToPolicy(new_customer_ids){
            jQuery.ajax({
            url: '<%=request.getContextPath()%>/PolicyAction.do?cmd=addCustomerToPolicy&policy_item_id=${requestScope.policy_item_id}&new_customer_ids='+new_customer_ids+'&test',
            type: 'POST',
            dataType: 'html',
            async: false,
            timeout: 10000,
            error: function(){
                alert('Error loading XML document');
                return ;
            },
            success: function(data){
                if(data=='true'){
                    //alert("添加成功！");
                }else{
                    //alert("添加失败！");
                    return ;
                }
            }
        });
    }
    
    
    
    
    function cancel_onClick(){
        window.close();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  customer_name=" + entity.getProperty("customer_name") + ">";
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAllCustomer">
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="policy_item_id" value="<%=policy_item_id %>">
 
<div id="right">
<div class="ringht_s">          
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="150" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>
                <tr>
            <td align="left">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_code"  name="customer_code" value="" inputName="客户编号" maxLength="25"/>
            </td>
             <td align="left">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_name" name="customer_name" value="" inputName="客户名称" maxLength="25"/>
            </td>
            <td align="left"> <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();"></td>
            <td align="left"></td>
        </tr>
</table>
</div>          
<div id="ccParent1" class="button"> 
    <div class="button_right">
         <ul>
            <li class="g"> <a  onClick="javascript:returnvalue();">确定</a></li>
         </ul>
    </div>
</div>
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/CustomersimpleAction.do?cmd=searchCustomersimpleData"
        width="98%"
        height="305px"
        xpath="CustomersimpleVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="customer_code"  label="客户编号">
      </r:field>
      <r:field fieldName="customer_name" width="180px" label="客户名称">
      </r:field>
      <r:field fieldName="contact_person" width="100px" label="客户联系人">
      </r:field>
      <r:field fieldName="bank_account" width="180px" label="银行账号">
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
    
<%  //表单回写
    if(request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
