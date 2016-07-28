<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>
<%@include file="/common/common.jsp"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<% String name = LoginHelper.getLoginId(request); %>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
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
    function find_to_renewcontract() {  
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
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
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
                 type=entity.getProperty("create_type_bd");
            }
        }
    if(constatus==5){
		            var url="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=find_to_renewcontract&id=" + ids;
		            url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
		            window.open(url,'','height=400px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=合同续签');
    } else{
         alert("只有分配完成的合同才能进行续签！");
          return;
    }  
    
        
    }  
    function callBack(reg){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
    }
    
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  >";
    }

    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //选择客户
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);      
    jQuery("#cust_a_name").val(arg[2]);       
    return false;
}
//待关闭合同
function   update_waitclosecontract(){
     var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
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
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
            }
        }
        if(constatus==5){
                 jQuery.ajax({
               url: "<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=update_contract_waitclose&id="+ids,
               type: 'POST',
               dataType: 'html',
               async: false,
               success: function(data){
                        if(data=="1"){
                        alert("合同状态更新成功！");
                        showListData();
                       }else{
                       alert("合同状态更新失败！");
                       showListData();
                       }
                   }
               });
        }else{
        alert("只有有效的合同才能转为待关闭状态！");
        return;
        }
}

/**********激活合同***********/
function   update_reactive(){
     var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
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
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
            }
        }
        if(constatus==6 || constatus==7){
                 jQuery.ajax({
               url: "<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=update_toactive&id="+ids,
               type: 'POST',
               dataType: 'html',
               async: false,
               success: function(data){
                        if(data=="1"){
                        alert("合同状态更新成功！");
                        showListData();
                       }else{
                       alert("合同状态更新失败！");
                       showListData();
                       }
                   }
               });
        }else{
        alert("只有处于待关闭或关闭状态的合同才能被激活！");
        return;
        }
}
/****************合同关闭*****************/
function   update_closecontract(){
     var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
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
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
            }
        }
        if(constatus==6){
         form.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=submitColseContract&id="+ids
         form.submit();
         }else{
         alert("只有待关闭合同才能被关闭！");
         return;
         }
}
/****************合同关闭*****************/
function   valuation_reactive(){
     var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
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
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
            }
        }
        if(constatus==5){
	         form.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=toValuation&id="+ids
	         form.submit();
         }else{
            alert("只有审批成功的合同才能维护标准计价！");
            return;
         }
}



</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" value="true">
<div id="right">
<script language="javascript">
    writeTableTopFesco('合同维护','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
         <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
         <td/>
         <td/>
         <td>    </td>
         <td>    </td>
         <td>    </td>
     </tr>
        <tr>
            <td align="right">合同业务类型</td>
            <td align="left">
                    <d:select dictTypeId="FINOUT_TYPE_BD" name="business_type_bd" id="business_type_bd" nullLabel="--请选择--"/>
            </td>
             <td align="right">合同状态</td>
            <td align="left">
            <!--<d:select dictTypeId="CONTRACT_STATUS_BD" name="contract_status_bd" />-->
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_status_bd", -1,"CONTRACT_STATUS_BD",""," id=contract_status_bd",false) %> 
            </td>
            <td align="right">合同甲方</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=${f}" dialogTitle="选择客户" height="500" width="810"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
            </td>
        </tr>
        <tr>
            <td align="right">合同编号</td>
            <td align="left">
                <input type="text" class="text_field" name="contract_code" inputName="合同编号" maxLength="64"/>
            </td>
            <td align="right">合同名称</td>
            <td align="left">
                <input type="text" class="text_field" name="contract_name" inputName="合同名称" maxLength="50"/>
            </td>
              <td colspan="2">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
        <tr>
            <td/>
          
            <td/>
            <td/>
            
                <td/>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <input class="approdetial" type="button"   value="合同续签"    onClick="find_to_renewcontract();">
                <input class="approdetial" type="button"   value="待关闭合同"    onClick="update_waitclosecontract();"> 
                <input class="approdetial" type="button"   value="关闭合同"    onClick="update_closecontract();">   
             <!--  <input class="approdetial" type="button"   value="合同激活"    onClick="update_reactive();">  方便测试加的按钮,现在注销 2013年11月16日 13:39:58 -->   
                <input class="approdetial" type="button"   value="标准计价维护"    onClick="valuation_reactive();">   
 <!--
                 <input class="a" type="button"   value="<fmt:message key="view"/>"    onClick="detail_onClick();">
				 <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAdd_onClick();">
				 <input class="b" type="button"   value="<fmt:message key="modify"/>"    onClick="findCheckbox_onClick();">
				 <input class="approdetial" type="button"   value="合同审批"    onClick="workflow_onClick();">              
				 <input class="approdetial" type="button"   value="审批详细"   onClick="spinto_onClick();">
 -->
         </div>
           <div class="clear"></div>            
</div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/Finout_contract_productAction.do?cmd=searchFinoutSalcontractData"
        width="98%"
        height="318px"
        xpath="SalcontractVo"
        submitXpath="SalcontractVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="contract_code" label="合同编号" width="110px">
      </r:field>
      <r:field fieldName="contract_type_bd" label="合同类型" allowModify="false" width="100px">
      <d:select dictTypeId="CONTRACT_TYPE_BD" />
      </r:field>
        <r:field fieldName="business_type_bd" label="业务类型" allowModify="false" width="100px">
      <d:select dictTypeId="FINOUT_TYPE_BD" />
      </r:field>
      <r:field fieldName="contract_name" label="合同名称" width="196px">
      </r:field>
      <r:field fieldName="customer_name" label="合同甲方" width="196px">
      </r:field>
      <r:field fieldName="contract_start_date" label="合同起始日期" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="contract_stop_date" label="合同终止日期" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="contract_status_bd" label="合同状态" allowModify="false" width="100px">
      <d:select dictTypeId="CONTRACT_STATUS_BD" />
      </r:field>
      <r:field fieldName="create_date" label="创建日期" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="create_user_id" label="创建人" width="80px">
      </r:field>
       <r:field fieldName="billing_user_id" label="开具账单人" width="80px">
      </r:field>
       <r:field fieldName="check_user_id" label="复核人员" width="80px">
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
    if(request.getAttribute(ISalcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISalcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
//初始化不加载页面信息<siqp添加>
 //jQuery(function(){
  //  $id("datacell1").isQueryFirst = false;
//});
</script>   
