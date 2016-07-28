<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%  //判断是否为修改页面
    Finout_expenseVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
    }
    if(request.getAttribute(IFinout_expenseConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (Finout_expenseVo)request.getAttribute(IFinout_expenseConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
    boolean wfShow = false;
    if(request.getParameter("wfShow") != null){
        wfShow = true;
    }
%>
<%@page import="rayoo.finout.finout_expense.util.IFinout_expenseConstants"%>
<%@page import="rayoo.finout.finout_expense.vo.Finout_expenseVo"%>
<%@page import="rayoo.common.DateUtils"%>
<html>
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
		form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}
	function view_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?id=" + ids;
		form.cmd.value = "view";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		for(var i = 0 ; i < ids.length; i++){
             var id = ids[i];
             var entity = datacellDatas[id];
             var is_use = entity.getValue("is_use");
             if(is_use == "1"){
                 alert(entity.getValue("name") + " 被引用不能删除！");
                 return;
             }else {
             }
        }
		
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/sales/Finout_expense/insertFinout_expense.jsp";
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
		form.action="<%=request.getContextPath()%>/Finout_expenseAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
</script>
</head>
<body>




<h:form checkType="keypress" name="form4datacell" id="form4datacell" method="post">
<!--blur, keypress-->
<input id="oid" name="oid" type="hidden" value="${bean.id}"/>
<input id="cmd" name="cmd" type="hidden" value=""/>
<div id="right">
    <div class="right_title_bg"><div class=" right_title">
        <%if(wfShow){%>
            报销审批
        <%} else if(request.getAttribute("view")!=null){%>
            报销查看
        <%} else if(isModify){%>
            报销修改
        <%} else {%>
            报销新增
        <%} %>
    </div></div>
    <div class="ringht_x">
    <!--表格 -->
        <div class="box_xinzeng"  style="height:80px">
        <div class="xz_title">基本信息</div>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1">选择合同：</td>
            <td class="td_2">
                
                 <input type="hidden" id="contract_id"  name="contract_id" value="${bean.contract_id }"/>
                 <w:lookup displayValue="${bean.contract_name }" onReturnFunc="toFindContract" readonly="true" id="contract_name"  name="contract_name" validateAttr="allowNull=false;"
                    lookupUrl="/jsp/faerp/common/sales/alllistSalcontract.jsp"  dialogTitle="选择合同" height="444" width="764" style="width:188px"/> 

<script type="text/javascript">

jq(function(){

    function beforeOpen(lookup){
        lookup.params = [];
        var customer_id=jq("#customer_id").val();
        lookup.addParam("contract_type_bd",10);
        return true;
    }

    
    $id("contract_name").beforeOpenDialog = beforeOpen;

});

function toFindContract(obj) {
    var contract_id = obj[0];
    jq('#contract_id').val(contract_id);
    //cc
    var contract_type_bd = obj[6];
    //document.form.contract_type_bd.value = contract_type_bd;//合同类型 1:劳务派遣协议 2:人事委托服务合同 3:服务外包合同 4:体检服务协议 4:补充福利 5:其他
    
    var lookup = $id("contract_name");
    lookup.setValue(obj[1]);
    lookup.setDisplayValue(obj[1]);
    refresh_finout_contract_product();
}


function refresh_finout_contract_product() {
    var contract_id = jq("#contract_id").val();
    var comSelect = $id("fin_contract_product_id1"); 
    //comSelect.params = [];
    //comSelect.addParam("city_id","sdjflkjsdklfjl");
    comSelect.queryParam= "<param><key>contract_id_bak</key><value>" + 123123 + 
                            "</value><key>contract_id</key><value>" + contract_id + "</value></param>";
    comSelect.loadData();
    comSelect.refresh();
    
}
</script>
            </td>
            <td class="td_1">支出金额</td>
            <td class="td_2" id="exp_sum_content" style="width: 300px;">
                &nbsp;${bean.expense_sum }
            
            </td>
          </tr>
          
          </table>

        </div>
    <!--表格 end-->
    
    
    
<!--    -->




<script type="text/javascript">

jq(function(){
    $id("datacell_cp").isQueryFirst = false;//
    var oid = jq("#oid").val();
    
    if(oid){
        simpleQuery_onClick();
        //window.setTimeout("refresh_finout_contract_product();", 1000);
        //refresh_finout_contract_product();
        var contract_name_lookup = $id("contract_name");
        contract_name_lookup.setDisabled(true);
        
        //alert("update");
    }else{
        //alert("insert");
        
        
    }

});

function setCheckboxStatus(value,entity,rowNo,cellNo){
    datacellDatas[value] = entity;
    return "<input type='checkbox' name='checkbox_template' value='"+value+"' is_use='" + entity.getValue("is_use") + "'>";
}
var datacellDatas = {};
function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell_cp").loadData();
    $id("datacell_cp").refresh();
}



function toAdd_onClick() {
    var contract_id = jq('#contract_id').val();
    if(!contract_id){
        alert("请先选择合同！");
        return;
    }
    $id("datacell_cp").addRow();
}

function deleteMulti_onClick(){
    $id("datacell_cp").deleteRow();
}
function insert_onClick() {
    
    
    var contract_id = jq('#contract_id').val();
    var finout_expense_id = jq('#oid').val();
    if(!contract_id){
        alert("请选择合同！");
        return false;
    }
    //refresh_finout_contract_product();
    var expense_sum = 0;
    var datacell1 = $id("datacell_cp");
    var dataset1 = datacell1.dataset;//取得页面的datacell
    for(var i=0; i<dataset1.getLength(); i++){
        var datasettr = dataset1.get(i);
        expense_sum += parseFloat(datasettr.getProperty("exp_sum"));
        if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
            
            if(datasettr.getProperty("fin_contract_product_id")==null || datasettr.getProperty("fin_contract_product_id")==''){
                alert('请选择报销项！');
                return;
            }
            if(datasettr.getProperty("exp_date")==null || datasettr.getProperty("exp_date")==''){
                alert('请输入发生日期！');
                return;
            }
            if(datasettr.getProperty("invoice_type")==null || datasettr.getProperty("invoice_type")==''){
                alert('请选择开票类型！');
                return;
            }
            //alert(datasettr.getProperty("name") + " / " + datasettr.getProperty("order_col") );
            datasettr.setProperty("contract_id",contract_id);
        }
    }
    jq('#exp_sum_content').html(expense_sum);
    if($id("datacell_cp").isModefied){
    
        $id("datacell_cp").addParam("finout_expense_id",finout_expense_id);
        $id("datacell_cp").addParam("contract_id",contract_id);
        $id("datacell_cp").addParam("expense_sum",expense_sum);
        if($id("datacell_cp").submit()){
            alert("保存成功！");
            //window.close();
            jq("#return_button").click();
        }else{
            alert("保存失败！");
        }
    }else {
        alert("没有做过修改！");
    }
}




</script>



<div id="list_div"  style="display: ;">

    <!---->
        <div style="padding: 8 10 8 8;">
        
            
            <div class="xz_title" style="padding-top: 10px">报销项选择</div> 
            <div id="ccParent1" class="button">
            
                <%if(wfShow==false && request.getAttribute("view")==null){%>
                
                        <div class="button_right">
                            <ul>
                                <li class="c">      <a onClick="javascript:toAdd_onClick();">添加 </a></li>
                                <li class="d">      <a  onClick="javascript:deleteMulti_onClick();">移除 </a> </li>
                            </ul>
                            
                        </div>
                        
                 <%} %>
            </div>
            
              <r:datacell id="datacell_cp" 
                queryAction="/FAERP/Finout_expense_itemAction.do?cmd=queryForDatacell" width="99%" height="280px"
                submitAction="/FAERP/Finout_expense_itemAction.do?cmd=saveList"
                xpath="Finout_expense_itemVo" paramFormId="form4datacell"
                submitXpath="Finout_expense_itemVo"
                    >
              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
              <r:field fieldName="id" label="操作" width="100px"  onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
              
              <r:field fieldName="fin_contract_product_id" label="报销项名称" width="200px">
                    
                    <r:comboSelect id="fin_contract_product_id1" name="fin_contract_product_id" validateAttr="allowNull=false;"
                               queryAction="/FAERP/Finout_contract_productAction.do?cmd=getProductListData&isExpense=true&contract_id=${requestScope.bean.contract_id}"
                               textField="product_name"
                               valueField="id"

                               xpath="Finout_contract_productVo"
                               width="100px" 
                               nullText="请选择"  />
                       
                       
              </r:field>    
              <r:field fieldName="exp_sum" label="支出金额" width="100px" ><h:text validateAttr="allowNull=false;type=double;fracDigit=2;"/></r:field>
             <!-- 2016-07-25   by zhouxiaolong  开票类型默认为财外 -->
              <r:field fieldName="invoice_type" label="开票类型" width="100px" defaultValue="6">
              <!-- 2016-07-25   by zhouxiaolong  开票类型默认为财外 -->
                            <d:select dictTypeId="SERVICE_TYPE"/>
              </r:field>   
              <r:field fieldName="exp_date" label="发生日期" width="100px" ><w:date format="yyyy-MM-dd" width="100px" maxValue="current_date" /></r:field>
              
              <r:field fieldName="o_remark" label="备注" width="200px" ><h:text validateAttr="allowNull=false;maxLength=100;"/></r:field>    
              
              </r:datacell>
        </div>
           
           
           
           
    
<!--    -->
    
    <div style = "text-align: center;">
        
        
        <%
        
        if(wfShow){
        %>
            <input id="taskuid" name="taskuid" type="hidden"  value="${taskuid }"/>
            <input id="info_msg" name="info_msg" type="hidden"  value=""/>
            <input type="button" class="icon_2" value="审批通过" onclick="javascript:appOperate_onClick();"/>
            <input type="button" class="icon_2" value="审批不通过" onclick="javascript:backOperate_onClick();"/>
            
        <%} else {%>
            <%if(request.getAttribute("view")==null) {%>
	            <input type="button" class="icon_2" value="保存" onclick="javascript:<%=isModify?"insert_onClick()":"insert_onClick()"%>"/>
	            
	        <%} %>
        <%} %>
        
        
        <input id="return_button" type="button" class="icon_2" value="返回" onclick="location.href='javascript:history.go(-1);'"/>
        </div>
    </div>
 
        

</div>


</h:form>


<script type="text/javascript">



var form;
// 审批操作
var wfShow = '<%=wfShow%>';
jq(function(){

    form = document.getElementById("form4datacell");

    if(wfShow == true){
        jq("[name=exp_type]").attr("disabled",true);
        jq("[name=exp_mony]").attr("readonly",true);
        jq("[name=remark]").attr("readonly",true);
    }else{
    }
});

function appOperate_onClick() {
    var message = addAppReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
        
    form.action = "<venus:base/>/Finout_expenseAction.do?message=" + message[0]
            + "&_ts=" + (new Date()).getTime();
    document.getElementById("cmd").value = "appOperate";

    form.submit();

}

// 驳回操作 不同意
function backOperate_onClick() {
    
    // 驳回原因
    var message = addBackReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
    var url = "<%=request.getContextPath()%>/Finout_expenseAction.do?date=" + new Date();
    form.action = url;
    document.getElementById("info_msg").value = message[0];
    document.getElementById("cmd").value = "backOperate";
    form.submit();

}

// 撤销操作
function cancelOperate_onClick() {
    // 驳回原因
    var message = addBackReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
    form.action = "<venus:base/>/SalcontractAction.do?message=" + message[0];
    document.getElementById("cmd").value = "cancelOperate";
    form.submit();
}
</script>

</body>
</html>
