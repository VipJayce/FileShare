<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<%@ page import="rayoo.sales.costcenter.util.ICostcenterConstants" %>
<jsp:useBean id="costcenterAction" class="rayoo.sales.costcenter.action.CostcenterAction" scope="page" />
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ICostcenterConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ICostcenterConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    CostcenterVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.salse.costcenter.costcenter_resource" prefix="rayoo.salse.costcenter.">
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
        var ids = findSelections("checkbox1","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url = "<%=request.getContextPath()%>/CostcenterAction.do?cmd=find&id=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=430px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改成本中心');
        //showModalCenter(url, window, callBack, 750, 410, "修改成本中心"); 
        //form.action="<%=request.getContextPath()%>/CostcenterAction.do?id=" + ids;
        //form.cmd.value = "find";
        //form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox1","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"、
            var allowDel = checkCostCenter(ids);
            if(allowDel){
                var url = "<%=request.getContextPath()%>/CostcenterAction.do?cmd=deleteMulti&ids=" + ids;
	            jQuery.ajax({
	                url: url,
	                type: 'post',
	                dataType: 'html',
	                async: false,
	                timeout: 80000,
	                error: function() {
	                    alert('Error loading XML document');
	                    return null;
	                },
	                success: function(text) {
	                    if(text == 0){
	                        alert("删除失败！");
	                    }else{
	                        alert("删除成功！");
	                    }
	                    simpleQuery_onClick();
	                }
	            });
            }
        }
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("celllist1").addParam("customer_code",$id("customer_code").value);
        $id("celllist1").addParam("customer_name",$id("customer_name").value);
        $id("celllist1").addParam("receipt_title",$id("receipt_title").value);
        $id("celllist1").addParam("contact_person",$id("contact_person").value);
        $id("celllist1").addParam("is_finance_send",$id("is_finance_send").options[$id("is_finance_send").selectedIndex].value);
        $id("celllist1").addParam("cost_center_name",$id("cost_center_name").value);
        $id("celllist1").addParam("cost_center_code",$id("cost_center_code").value);//20160407 add by lbd
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        
        
        
    }
    function toAdd_onClick() {  //到增加记录页面
        var ids = findSelections("checkbox1","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url = "<%=request.getContextPath()%>/CostcenterAction.do?cmd=findToAdd&ids=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=430px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增成本中心');
       // showModalCenter(url, window, callBack, 750, 410, "新增成本中心"); 
        //form.action="<%//=request.getContextPath()%>/CostcenterAction.do?ids=" + ids;
        //form.cmd.value = "findToAdd";
        //form.submit();

    }
    
    function callBack(reg){
        if(reg=="1"){
            alert("操作完成！");
        }
        $id("celllist1").addParam("customer_code",$id("customer_code").value);
        $id("celllist1").addParam("customer_name",$id("customer_name").value);
        $id("celllist1").addParam("receipt_title",$id("receipt_title").value);
        $id("celllist1").addParam("contact_person",$id("contact_person").value);
        $id("celllist1").addParam("is_finance_send",$id("is_finance_send").options[$id("is_finance_send").selectedIndex].value);
        $id("celllist1").addParam("cost_center_name",$id("cost_center_name").value);
        
        $id("celllist1").reload();
      
    }
    
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox1","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/CostcenterAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }
    function exportExcel_onClick(){  //导出Excel
        oldCmd = form.cmd.value;
        form.cmd.value = "exportExcel";
        form.submit();
    }
    
        //datacell1 checkbox begin
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck(" + rowNo + ",this);'  name='checkbox1' id='checkboxId' value='" + entity.getProperty("id") + "'>";
       return returnStr;
    }
    function checkAllList(all){
        if(all.checked){
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
                    element[i].checked= true;
                }
            } 
        }else{
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
                    element[i].checked= false;
                }
            } 
        }
    }
    
    function changeCheck(rowNo,box){
        
    }
    
    //魏佳新增，检查该成本中心是否可以删除
    function checkCostCenter(ids) {
        var allowDel = true;
        var url = "<%=request.getContextPath()%>/CostcenterAction.do?cmd=checkCostCenter&ids=" + ids;
        jQuery.ajax({
            url: url,
            type: 'post',
            dataType: 'json',
            async: false,
            timeout: 80000,
            error: function() {
                alert('Error loading XML document');
                return null;
            },
            success: function(data) {
                if(data.costCenterMsg != ""){
                    allowDel = false;
                    alert("以下成本中心无法删除，在委派单中尚有有效的个人订单："+data.costCenterMsg);
                }else{
                    if(confirm("以下成本中心存在有效委派单："+data.sendMsg+"\n删除成本中心时将同时删除所对应的委派单，是否确定？")){
                        allowDel = true;
				    }else{
				        allowDel = false;
				    }
                }
            }
        });
        return allowDel;
    }
    
    // end
 </script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/CostcenterAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="cost_center"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div> </td>
           </tr>
            <tr>
            <td align="right"><fmt:message key="customer_code"/></td>
            <td align="left">
                <input type="text" class="text_field" id="customer_code" name="customer_code" value="" inputName="客户编号" maxLength="25"/>
            </td>
            <td align="right"><fmt:message key="customer_name"/></td>
            <td align="left"> 
                <input type="text" class="text_field" id="customer_name" value="" name="customer_name"  inputName="客户名称" maxLength="25"/>
           </td>
           <td align="right"><fmt:message key="receipt_title"/></td>
            <td align="left">
                <input type="text" class="text_field" id="receipt_title" name="receipt_title" value="" inputName="发票抬头" maxLength="64"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="contact_person"/></td>
            <td align="left">
                <input type="text" class="text_field" id="contact_person" name="contact_person" value="" inputName="联系人" maxLength="50"/>
            </td>
            <td align="right"><fmt:message key="is_finance_send"/></td>
            <td align="left">
                <%//=gap.rm.tools.helper.RmJspHelper.getSelectField("is_finance_send", -1,"TrueOrFalse",""," id='is_finance_send' ",false) %>
                <d:select name="is_finance_send" id="is_finance_send" dictTypeId="TrueOrFalse" nullLabel="--请选择--"/>
            </td>
            
             <td align="right"><fmt:message key="cost_center_name"/></td>
            <td align="left">
                <input type="text" class="text_field" id="cost_center_name" name="cost_center_name" value="" inputName="联系人" maxLength="50"/>
            </td>
        </tr>
        <tr>
        	<td align="right"><fmt:message key="cost_center_code"/></td>
            <td align="left">
                <input type="text" class="text_field" id="cost_center_code" name="cost_center_code" value="" inputName="成本中心编号" maxLength="50"/>
            </td>
        	<td align="right" colspan="3">
            </td>   
            <td align="left">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">         
            <input type="reset" class="icon_1"  />
            </td>    
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="c">      <a  onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    <li class="e">      <a  onClick="javascript:exportExcel_onClick();"><fmt:message key="export"/> </a> </li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
    <div style="padding: 8 10 8 8;">
    <r:datacell id="celllist1"
    queryAction="/FAERP/CostcenterAction.do?cmd=simpleQuery"
    paramFormId="form" width="98%" height="320px"
    xpath="CostcenterVo" readonly="true">
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <r:field allowModify="false" fieldName="id" sortAt="none"
        label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
        width="45px" onRefreshFunc="setCheckboxStatus">
    </r:field>
    <r:field fieldName="customer_code" messagekey="customer_code" width="80px">
        <h:text />
    </r:field>
    <r:field fieldName="customer_name" messagekey="customer_name" width="180px">
        <h:text />
    </r:field>
    <r:field fieldName="cost_center_code" messagekey="cost_center_code" width="120px">
        <h:text />
    </r:field>
    <r:field fieldName="cost_center_name" messagekey="cost_center_name"   width="180px">
        <h:text />
    </r:field>
    <r:field fieldName="receipt_title" messagekey="receipt_title" width="180px">
        <h:text />
    </r:field>
    <!--2016-04-12  by zhouxiaolong  begin-->
    <r:field fieldName="taxpayer_identity_type" label="纳税人身份类型" width="100px">
        <h:text />
    </r:field>
    <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
    <r:field fieldName="taxpayer_identification_number" label="纳税人识别号" width="180px">
    <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
        <h:text />
    </r:field>
    <r:field fieldName="tax_registration_address" label="税务登记地址" width="160px">
        <h:text />
    </r:field>
    <r:field fieldName="tax_registration_telnum" label="税务登记电话号码" width="120px">
        <h:text />
    </r:field>
    <r:field fieldName="tax_registration_bank" label="税务登记开户银行" width="100px">
        <h:text />
    </r:field>
    <r:field fieldName="tax_registration_bank_account" label="税务登记银行账号" width="120px">
        <h:text />
    </r:field>
    <!--2016-04-12  by zhouxiaolong  end-->
    <r:field fieldName="is_display_year_month" label="账期属性" width="100px">
        <d:select dictTypeId="IS_DISPLAY_YM"></d:select>
    </r:field>
    <r:field fieldName="is_account_limit" messagekey="is_account_limit" width="100px">
        <d:select dictTypeId="TrueOrFalse"></d:select>
    </r:field>
    <r:field fieldName="is_finance_send" messagekey="is_finance_send" width="100px">
        <d:select dictTypeId="TrueOrFalse"></d:select>
    </r:field>
    <r:field fieldName="agree_receive_money_date" messagekey="agree_receive_money_date" width="100px">
        <h:text />
    </r:field>
    <r:field fieldName="receive_money_month" messagekey="receive_money_month" width="100px" allowModify="false">
        <d:select dictTypeId="RECEIVE_MONEY_DATE"></d:select>
    </r:field>
    <r:field fieldName="contact_person" messagekey="contact_person" width="140px">
        <h:text />
    </r:field>
    <r:field fieldName="contact_address" messagekey="contact_address" width="160px">
        <h:text />
    </r:field>
    <r:field fieldName="contact_tel1" messagekey="contact_tel1" width="120px">
        <h:text />
    </r:field>
    <r:field fieldName="contact_tel2" messagekey="contact_tel2" width="80px">
        <h:text />
    </r:field>
    <r:field fieldName="fax" messagekey="fax" width="80px">
        <h:text />
    </r:field>
    <r:field fieldName="email" messagekey="email" width="120px">
        <h:text />
    </r:field>
    <r:field fieldName="voucher_rule" messagekey="voucher_rule" width="100px">
        <h:text />
    </r:field>
    <r:field fieldName="remarks" messagekey="remark" width="180px">
        <h:text />
    </r:field>
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
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("celllist1").isQueryFirst = false;
});
</script>