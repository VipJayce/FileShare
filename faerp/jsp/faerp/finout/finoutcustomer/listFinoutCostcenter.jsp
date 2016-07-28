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
        var ids = findSelections("checkbox1","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //2016-06-30  by zhouxiaolong  财务外包的成本中心增加“代收付开票税率”信息的维护    Begin
        var url = "<%=request.getContextPath()%>/CostcenterAction.do?cmd=find&id=" + ids+"&_ts="+(new Date()).getTime()+"&flag="+1;
        //2016-06-30  by zhouxiaolong  财务外包的成本中心增加“代收付开票税率”信息的维护    End
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
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/Finout_customerAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti_costcenter";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("celllist1").addParam("customer_code",$id("customer_code").value);
        $id("celllist1").addParam("customer_name",$id("customer_name").value);
        $id("celllist1").addParam("receipt_title",$id("receipt_title").value);
        $id("celllist1").addParam("contact_person",$id("contact_person").value);
        $id("celllist1").addParam("is_finance_send",$id("is_finance_send").options[$id("is_finance_send").selectedIndex].value);
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
        //2016-06-30  by zhouxiaolong  财务外包的成本中心增加“代收付开票税率”信息的维护    Begin
        var url = "<%=request.getContextPath()%>/CostcenterAction.do?cmd=findToAdd&ids=" + ids+"&_ts="+(new Date()).getTime()+"&flag="+1;
        //2016-06-30  by zhouxiaolong  财务外包的成本中心增加“代收付开票税率”信息的维护    End
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
        form.action="<%=request.getContextPath()%>/Finout_customerAction.do?cmd=exportExcel_FinoutCost";
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
    
    // end
 </script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/CostcenterAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('成本中心','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
           </tr>
            <tr>
            <td align="right">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_code" name="customer_code" value="" inputName="客户编号" maxLength="25"/>
            </td>
            <td align="right">客户名称</td>
            <td align="left"> 
                <input type="text" class="text_field" id="customer_name" value="" name="customer_name"  inputName="客户名称" maxLength="25"/>
           </td>
           <td align="right">发票抬头</td>
            <td align="left">
                <input type="text" class="text_field" id="receipt_title" name="receipt_title" value="" inputName="发票抬头" maxLength="64"/>
            </td>
        </tr>
        <tr>
            <td align="right">联系人</td>
            <td align="left">
                <input type="text" class="text_field" id="contact_person" name="contact_person" value="" inputName="联系人" maxLength="50"/>
            </td>
            <td align="right">是否财务快递</td>
            <td align="left">
                <%//=gap.rm.tools.helper.RmJspHelper.getSelectField("is_finance_send", -1,"TrueOrFalse",""," id='is_finance_send' ",false) %>
                <d:select name="is_finance_send" id="is_finance_send" dictTypeId="TrueOrFalse" nullLabel="--请选择--"/>
            </td>
             <td align="right">
                   
                
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
    queryAction="/FAERP/Finout_customerAction.do?cmd=simpleQuery"
    paramFormId="form" width="98%" height="320px"
    xpath="CostcenterVo" readonly="true">
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <r:field allowModify="false" fieldName="id" sortAt="none"
        label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
        width="45px" onRefreshFunc="setCheckboxStatus">
    </r:field>
    <r:field fieldName="customer_code" label="客户编号" width="80px">
        <h:text />
    </r:field>
    <r:field fieldName="customer_name" label="客户名称" width="180px">
        <h:text />
    </r:field>
    <r:field fieldName="cost_center_name" label="成本中心名称" width="180px">
        <h:text />
    </r:field>
    <r:field fieldName="receipt_title" label="发票抬头" width="180px">
        <h:text />
    </r:field>
    <r:field fieldName="is_account_limit" label="是否有账期" width="100px">
        <d:select dictTypeId="TrueOrFalse"></d:select>
    </r:field>
    <r:field fieldName="is_finance_send" label="是否财务快递" width="100px">
        <d:select dictTypeId="TrueOrFalse"></d:select>
    </r:field>
    <r:field fieldName="agree_receive_money_date" label="约定到款日" width="100px">
        <h:text />
    </r:field>
    <r:field fieldName="receive_money_month" label="到款日所属月" width="100px" allowModify="false">
        <d:select dictTypeId="RECEIVE_MONEY_DATE"></d:select>
    </r:field>
    <r:field fieldName="contact_person" label="联系人" width="65px">
        <h:text />
    </r:field>
    <r:field fieldName="contact_address" label="联系人地址" width="160px">
        <h:text />
    </r:field>
    <r:field fieldName="contact_tel1" label="联系电话1" width="80px">
        <h:text />
    </r:field>
    <r:field fieldName="contact_tel2" label="联系电话2" width="80px">
        <h:text />
    </r:field>
    <r:field fieldName="fax" label="传真" width="80px">
        <h:text />
    </r:field>
    <r:field fieldName="email" label="电子邮件" width="120px">
        <h:text />
    </r:field>
    <r:field fieldName="voucher_rule" label="开票规则" width="100px">
        <h:text />
    </r:field>
    <r:field fieldName="remarks" label="备注" width="180px">
        <h:text />
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
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("celllist1").isQueryFirst = false;
});
</script>