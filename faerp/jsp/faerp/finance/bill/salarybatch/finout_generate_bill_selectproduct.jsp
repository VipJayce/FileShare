<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.sal_quotation_tpl.vo.Sal_quotation_tplVo" %>
<%@ page import="rayoo.sales.sal_quotation_tpl.util.ISal_quotation_tplConstants" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
    Sal_quotation_tplVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ISal_quotation_tplConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (Sal_quotation_tplVo)request.getAttribute(ISal_quotation_tplConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    boolean isView = request.getAttribute("isView") == null ? false : true;
    
    String id = "";
    if(resultVo != null) {
        id = resultVo.getId();
    }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>财务外包账单</title>
<script language="javascript">
var isView = "${isView}";
jQuery(function(){
/*
    if(isView=="true"){//查看页面
        jQuery(".button_right ul li").hide();
        jQuery("#update_button").hide();
        jQuery("#checkButton").hide();
    }else{
        
    }
    jQuery("#button_content").show();

    $id("datacell_sc").isQueryFirst = false;// 
    $id("datacell_tpl_para").isQueryFirst = false;// 
    $id("datacell_sc_item").isQueryFirst = false;// 
    var id= jQuery("#tpl_id").val();
    if(id){
        simpleQuery_onClick();
        var tpl_sc_list_div = jQuery("#tpl_sc_list_div");
        tpl_sc_list_div.show();
    }
    */
});
function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell_sc").loadData();
    $id("datacell_sc").refresh();
    
    $id("datacell_tpl_para").loadData();
    $id("datacell_tpl_para").refresh();
}
function checkAllForms(){
    return true;

}
function generatebill_onClick(){  //
    if(checkAllForms()){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(!ids || ids.length==0){
            alert("请选择服务项！");
            return;
        }
        
        var datacell_cp = $id("datacell_cp");
    
        
        var contract_id = jq("#contract_id", window.opener.document).val();
        jq("#contract_id").val(contract_id);
        var bill_year_month = jq("#bill_year_month", window.opener.document).val();
        jq("#bill_year_month").val(bill_year_month);
        var cust_id = jq("#cust_id", window.opener.document).val();
        jq("#cust_id").val(cust_id);
        var cost_center_id = jq("#cost_center_id_hidden", window.opener.document).val();
        jq("#cost_center_id").val(cost_center_id);
        var bill_type_bd = jq("#bill_type_bd", window.opener.document).val();
        jq("#bill_type_bd").val(bill_type_bd);
        var front_service_user_id = jq("#front_service_user_id_hidden", window.opener.document).val();
        jq("#front_service_user_id").val(front_service_user_id);
        
        var is_forecast = jq("#is_forecast", window.opener.document).val();
        
        datacell_cp.addParam("contract_id", contract_id);
        datacell_cp.addParam("bill_year_month", bill_year_month);
        datacell_cp.addParam("cust_id", cust_id);
        datacell_cp.addParam("cost_center_id", cost_center_id);
        datacell_cp.addParam("bill_type_bd", bill_type_bd);
        datacell_cp.addParam("front_service_user_id", front_service_user_id);
        datacell_cp.addParam("is_forecast", is_forecast);
        
        
        // check has bill
        var form = jQuery("#form4datacell_cp");
        //var update_button = jQuery("#update_button");
        //update_button.attr({"disabled":"disabled"});
        form.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?r="+ Math.random();
        jq("#cmd").val("checkHasBill");
        var idMap = {};
        for(var i=0; i< ids.length; i++){
            var id = ids[i];
            idMap[id] = true;
        }
        var dataset1 = datacell_cp.dataset;//取得页面的datacell
        datacell_cp.isModefied = true;
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            if(idMap[datasettr.getProperty("id")] == true ){
            //2014-8-19 yangyuting 特定产品 可是使用小数点
            //  if(datasettr.getProperty("product_name")=="代收代付项"){//2015-1-29 yangyuting 添加注释 所有产品都可以两位小数
                 //验证小数或者整数
                 var reslut=verifyNum(1,datasettr.getProperty("p_count"));
                if(reslut!='success'){
                     alert(datasettr.getProperty("product_name")+"的数量请输入"+reslut);
                     return;
                 }
          //    }
          //   else{
          //      //验证只能整数
          //      var reslut=verifyNum(2,datasettr.getProperty("p_count"));
          //        if(reslut!='success'){
          //          alert(datasettr.getProperty("product_name")+"的数量请输入"+reslut);
          //           return;
           //      }
          //     }
            
                datasettr.status = Entity.STATUS_NEW;
            }
        }
        var hasBill = false;
        ajaxRequest(form,
            function(data){
                if(true != data.error){
                    if(datacell_cp.submit()){
                        alert("生成账单成功！");
                        window.close();
                    }else{
                        alert("生成账单失败！");
                    }
                }else {
                    alert(data.message);
                    /*
                    if(confirm(data.message + " 点击确定可以重算账单！")) {
                    
                        
				        if(datacell_cp.submit()){
				            alert("生成账单成功！");
				            window.close();
				        }else{
				            alert("生成账单失败！");
				        }
				        
                    }else {
                        hasBill = true;
                    }
                    */
                }
            } , 
            function(){
                alert("error.");
            },false
        )
        
        if(hasBill){
            return;
        }
        
        
    }
}
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
        
function cancel_onClick(){  //取消后返回列表页面
    window.close();
}
 //yangyuting add   
function verifyNum(type,num){

    //整数
    var reg1 =/^\d+$/;
    //小数两位
    var reg2=/\.\d{0,2}$/;
    
    if(type=="1")//验证是否是整数或者小数
    {
       if(num.match(reg1)!= null||num.match(reg2)!=null){
           return "success";
       }
       else{
           return "整数或者两位小数";
       }
    }
    else{//验证是否是整数
    
         if(num.match(reg1)!= null){
                return "success";
           }
           else{
            return "整数";
           }
    }

}




</script>
</head>
<body>
<form action="" id="form4datacell_cp">
    <input type="hidden" id="contract_id" name="contract_id" value="${param.contract_id }">
    <input type="hidden" id="bill_year_month" name="bill_year_month">
    <input type="hidden" id="cust_id" name="cust_id">
    <input type="hidden" id="cost_center_id" name="cost_center_id">
    <input type="hidden" id="bill_type_bd" name="bill_type_bd">
    <input type="hidden" id="front_service_user_id" name="front_service_user_id">
    <input type="hidden" id="cmd" name="cmd">
    
</form>
<div id="right">
<script language="javascript">
</script>



 
<div class="ringht">
<div id="ccChild1"     class="box_xinzeng" style="height: 30px">

                <input id="update_button" type="button" class="icon_2" value='生成账单' onClick="javascript:generatebill_onClick()" />
                <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
                
</div>
   

<table >
<tr class="xz_title">
<td width="100" align="right">服务项合计：</td>
<td width="100"><input type="text" value="" id="serverCount" readOnly="readOnly"></td>
<td width="100"  align="right">报销合计：</td>
<td width="100"><input type="text" value="" id="baoxiaoCount" readOnly="readOnly"></td>
<td width="100"  align="right">账单总计：</td>
<td width="100"><input type="text" value="" id="allCount" readOnly="readOnly"></td>
</tr>
</table>


<div id="s_p_list_div"  style="">

    <div style="padding: 8 10 8 8;">
        
            
            <div class="xz_title" style="padding-top: 10px">服务项选择</div> 
            <div id="ccParent1" class="button">
                        <div class="button_right">
                            <ul>
<!--                                <li class="c">      <a onClick="javascript:toAdd_onClick();">添加 </a></li>-->
<!--                                <li class="d">      <a  onClick="javascript:deleteMulti_onClick();">移除 </a> </li>-->
                            </ul>
                            
                        </div>
            </div>
            
              <r:datacell id="datacell_cp" 
                queryAction="/FAERP/Finout_contract_productAction.do?cmd=getProductListData&contract_id=${param.contract_id}" width="99%" height="200px"
                submitAction="/FAERP/Finout_contract_productAction.do?cmd=generateBill"
                xpath="Finout_contract_productVo" paramFormId="form4datacell_cp"
                submitXpath="Finout_contract_productVo" pageSize="1000"
                    >
              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
              <r:field fieldName="id" label="操作" width="100px"  onRefreshFunc="setCheckboxStatus"   align="center" ></r:field>
              
              <r:field fieldName="product_name" label="服务项名称" width="200px">
                       
              </r:field>
              <r:field fieldName="rate" label="频率" width="100px" >
                
                <d:select dictTypeId="FINOUT_PRODUCT_TYPE" disabled="true"/>
              </r:field>
              <r:field fieldName="exp_date" label="类型" width="100px" ></r:field>
              
              <r:field fieldName="product_price" label="价格" width="100px" ></r:field>   
              
                
              
              
               <r:field fieldName="p_count" label="数量" width="100px" >
               
	                         <h:text validateAttr="allowNull=false;type=double;" />
                                
                </r:field>
             
            
             
              <r:field fieldName="o_remark" label="备注" width="200px" ><h:text validateAttr="maxLength=100;"/></r:field>
              
              <r:field fieldName="invoice_type" label="开票类型" width="100px" >
              	<d:select dictTypeId="SERVICE_TYPE" disabled="true"/>
              </r:field>  
              
              </r:datacell>
        </div>
        
        
           
           
           
           
           
<table width="100%" border="0">
  <tr>
    <td>
    
     <!-- 服务费参数  -->
    <div style="padding: 8 10 8 8;">
        
            
            <div class="xz_title" style="padding-top: 10px">报销项</div> 
            <div id="ccParent1" class="button">
                        <div class="button_right">
                            <ul>
                            </ul>
                            
                        </div>
            </div>
            <r:datacell id="datacell_cp_exp" queryAction="/FAERP/Finout_expenseAction.do?cmd=queryForDatacell&forbill=true&contract_id=${param.contract_id}" width="98%"  height="180px"
         xpath="Finout_expenseVo" paramFormId="datacell_formid" pageSize="1000">
         <r:toolbar location="bottom" tools="nav,pagesize,info"/>
         <r:field fieldName="contract_name" label="合同名称" width="120px"  ></r:field>
         <r:field fieldName="create_date" label="填报日期" width="120px"  ><w:date format="yyyy-MM-dd HH:mm" readOnly="true"/></r:field>
         <r:field fieldName="create_user_name" label="申请人" width="120px"  ></r:field>
         <r:field fieldName="expense_sum" label="报销金额" width="120px"  ></r:field>
         <r:field fieldName="expense_status" label="状态" onRefreshFunc="showStatus4onRefreshFunc" width="120px"  ></r:field>
         <r:field fieldName="approve_date" label="审批时间" width="120px"  ><w:date format="yyyy-MM-dd HH:mm" readOnly="true"/></r:field>
         <r:field fieldName="approve_user_name" label="审批人" width="120px"  ></r:field>
         <r:field fieldName="is_in_bill" label="计入账单" width="60px" align="center" onRefreshFunc="process_is_in_bill_exp"  ></r:field>
         
         
         </r:datacell>
         
         
              
        </div>
        
<!--           end-->
    </td>
  </tr>
</table>
      </div>
   </div>
</div>
    








</fmt:bundle>
</body>
</html>


<script type="text/javascript">

jq(function(){

    var contract_id = jq("#contract_id", window.opener.document).val();

    //$id("datacell_cp_exp").isQueryFirst = false;//
    
    if(contract_id){
    
        //simpleQuery_onClick_exp();
    }else{
    
        //alert("insert");
        
        
    }

});
function setCheckboxStatus(value,entity,rowNo,cellNo){
    datacellDatas[value] = entity;
    
    return "<input type='checkbox' onclick='setAllCount();' name='checkbox_template' value='"+value+"' is_use='" + entity.getValue("is_use") + "'>";
}

//yangyuting 2014-8-28 计算三个总计
function setAllCount(){
    var serverCount=0;
    var baoxiaoCount=0;
    var allCount=0;
    //----------------------------------服务项---------------------------------------------
	    var ids = findSelections("checkbox_template","id");  //取得选中的
	        if(ids || ids.length!=0){
		        //开始判断选择的是否有数量
		        var idMap = {};
		        for(var i=0; i< ids.length; i++){
		            var id = ids[i];
		            idMap[id] = true;
		        }
		      var datacell_cp = $id("datacell_cp");
	          var dataset1 = datacell_cp.dataset;//取得页面的datacell
	          datacell_cp.isModefied = true;
	          for(var i=0; i<dataset1.getLength(); i++){
		            var datasettr = dataset1.get(i);
		            if(idMap[datasettr.getProperty("id")] == true &&datasettr.getProperty("p_count")!=null){
		            var sum=datasettr.getProperty("product_price")*datasettr.getProperty("p_count");
		            serverCount=Number(serverCount)+Number(sum);
		            }
	           }
	        }
	   //----------------------------------报销项---------------------------------------------      
            var idMapb = {};
             var datacell_cp_exp = $id("datacell_cp_exp");
              var dataset2 = datacell_cp_exp.dataset;//取得页面的datacell
               datacell_cp_exp.isModefied = true;
                for(var i=0; i<dataset2.getLength(); i++){
                    var datasettr = dataset2.get(i);
                    var sum=datasettr.getProperty("expense_sum");
                    baoxiaoCount= Number(baoxiaoCount)+ Number(sum);
               }
	   //----------------------------------服务+报销 总额---------------------------------------------      
           allCount=serverCount+baoxiaoCount;
           document.getElementById("serverCount").value=serverCount;
           document.getElementById("baoxiaoCount").value=baoxiaoCount;
           document.getElementById("allCount").value=allCount;
}

function countFindSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
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


var datacellDatas = {};
function simpleQuery_onClick_exp(){  //简单的模糊查询
    $id("datacell_cp_exp").loadData();
    $id("datacell_cp_exp").refresh();
}
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
    if(!contract_id){R
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

<script language="javascript">

function f_check_tpl_para(obj) {
    var str = obj.value;
    var datacell = $id("datacell_tpl_para");
    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);// 得到当前操作的行dataset
    
    if (datasettr.getProperty("data_type") == '0') {
        if (isNaN(str)) {
            f_alert(obj, "数据类型为数字，不能输入字符！");
            return false;
        }
    }
    return true;
}

function process_is_in_bill_exp(value,entity,rowNo,cellNo){
    var result = "否";
    if(value=="1"){
        result = "是";
    }else if(value=="2"){
        result = "否";
    }
    return result;
}
//报销状态1，未审批2，审批中，3审批通过
function showStatus4onRefreshFunc(value,entity,rowNo,cellNo){
    var result = "未审批";
    if(value=="1"){
        result = "未审批";
    }else if(value=="2"){
        result = "审批中";
    }else if(value=="3"){
        result = "审批通过";
    }
    return result;
}
</script>
