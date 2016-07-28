<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@page import="gap.authority.helper.LoginHelper"%>
<%@page import="java.util.List"%>
<%@page import="rayoo.ge.empwelfarerecord.vo.EmpwelfarerecordVo"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="" prefix="">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
.fex_row_top
 {
  top:expression(document.getElementById('div_top').scrollTop-2); 
     position:relative; 
     z-index:1;
     background-color: #DEE7FE;
 }
 .yangshi{ font-weight:bold}
/*重点：固定行头样式*/

.scrollRowThead 
{
     position: relative; 
     left: expression(this.parentElement.parentElement.parentElement.parentElement.scrollLeft);
     z-index:0;
}
/*重点：固定表头样式*/

.scrollColThead {
     position: relative; 
     top: expression(this.parentElement.parentElement.parentElement.scrollTop);
     z-index:2;
}


 
</style>
<script language="JavaScript" src="../../scripts/common.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
    jQuery.noConflict();
    function rtnFuncCustomer(arg){
        var lookup = $id("customer_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        $id("customer_name").value = arg[2] ;
        $id("cost_center_id").addParam("cust_id", arg[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
    }
    
    function export_submit(){
	        $id("datacell_formid").submit() ;
    }
    
     function queryall(){
         $id("datacell_formid").submit();
    }
    function resetstr(){
    	$id("customer_id").setDisplayValue("")  ;
    	$id("customer_id").setValue("");
    	$id("customer_name").value = ""  ;
    	$id("customer_code").value = ""  ;
    	$id("emp_name").value = ""  ;
    	$id("emp_code").value = ""  ;
    	$id("product_type").value = ""  ;
    	$id("document_status").value = ""  ;
    	$id("confirm_date_start").setValue("")   ;
    	$id("confirm_date_end").setValue("")   ;
    	$id("account_bill_year_month").value = ""  ;
    	$id("create_date_start").setValue("")   ;
    	$id("create_date_end").setValue("")   ;
    	$id("id_card").value = ""  ;
    	$id("document_type").value = ""  ;
    	$id("internal_code").value = ""  ;
    }
    
    
    function checkAll(item) {
        if (_$(item).attr("checked")) {
            _$(":checkbox").attr("checked", true);
        } else {
            _$(":checkbox").attr("checked", false);
        }
    }
   
 //执行操作   
 function update_onClick(handle_type){
    var flag=document.getElementById("checkflag").value;
    if(flag=="0"){
   var myids = new Array(0);
        var errrow = 0 ;
        var errrow2 = 0 ;
        var errmsg = "" ;
        var document_type_new = null ;   //记录单据类型
        _$("input[type='checkbox']").each(function(i) {
            if (i != 0 && _$(this).attr("checked")) {
                   var ids =_$(this).attr("value") ; //bean.getId()+'_'+bean.getEmp_post_id()+'_'+bean.getDocument_status()+'_'+bean.getDocument_type()
	               var array = ids.split("_");  
                var document_status = array[2] ;
                var document_type = array[3]  ;
                if(handle_type == '1'){ //出当月
                 if(document_status !='待确认'){
                   errmsg="只有待确认的数据才能执行出当月操作！" ;
                   errrow++ ;
                 }
                }else if (handle_type == '2'){ //转下月
                 if(document_status !='待确认'){
                   errmsg="只有待确认的数据才能执行转下月操作！" ;
                   errrow++ ;
                 }
                }else if (handle_type == '3'){ //取消收费
                  if(document_status =='待确认'){
                   errmsg="待确认数据不能做取消操作！" ;
                   errrow++ ;
                  }
                  if (document_type_new != null&&document_type_new != document_type ){
                     errrow2++ ;
                  }else if (document_type_new == null){
                     document_type_new = document_type  ;
                  }
                }
                myids.push(array[0]);
            }
        });
        if(errrow > 0 ){
          alert(errmsg) ;
          return false ;
        }
        if(errrow2 >0 ){
           alert("做取消操作时所选的数据中单据类型必须是一样，可以先把报入职类型先取消再做变更取消！") ;
           return false ;
        }
   if(myids == null || myids == '') {
        alert("请选择操作数据！");
        return  false ;
   }
  jQuery.ajax({
              url: '<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=update&ids='+myids+'&handle_type='+handle_type,
                                type: 'post',
                                dataType: 'html',
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                       alert(text);
                                       $id("datacell_formid").submit();
                                    }
                                }
                                });
           }else{//全选类型提交
              var  d_type=document.getElementById("document_type").value;
               var  d_status=document.getElementById("document_status").value;            
             if(d_status==""){
                alert("请选择单据状态！");
                return;
              }
              if(d_type==""){
                alert("请选择单据类型！");
                return;
              }
             
              var action="<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=updateAll&handle_type="+handle_type;
              var myAjax = new Ajax(action);
              if(form){
                    for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
              }
                 myAjax.submit();
                var returnNode = myAjax.getResponseXMLDom();
        if(returnNode) {
              if(myAjax.getProperty("returnValue")) {
               alert(myAjax.getValue("root/data/returnValue"));
               queryall();
              } else {
                alert('提交失败');
              }
        } else {
            alert('提交失败');
       }
                                }
   
 }   
    
    
    function detail_onClick(){  //实现转到详细页面
        var myids = new Array(0);
	    _$("input[type='checkbox']").each(function(i) {
	            if (i != 0 && _$(this).attr("checked")) {
	               var ids =_$(this).attr("value") ;
	               var array = ids.split("_");  
	               myids.push(array[1]);
	            }
	        });
	        if(myids == null || myids == '') {
		        alert("请选择操作数据！");
		        return  false ;
		    }else if (myids.length >1){
		    	alert("选择的数据多于一条！");
		        return  false ;
		    }
           var emp_post_id="";
           emp_post_id = myids  ;
                if(emp_post_id!=null&&emp_post_id!=""){
                    window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
                }else{
                    alert("请选择记录！");
                    return;
                }
    }
    
    function  exportExcel_onClick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=exportExcel";
        $id("datacell_formid").submit();
        //重新设置action,避免action还是导出url
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=toConfirmedPage";
    }
    
       function toCheck(value){
       if(value=="全选"){
            document.getElementById("CheckAllFlag").value="取消全选";
            document.getElementById("noticeall").style.display="inline";
            document.getElementById("noticesingle").style.display="none";
            document.getElementById("checkflag").value="1";
       }else{
           document.getElementById("CheckAllFlag").value="全选";
           document.getElementById("noticeall").style.display="none";
           document.getElementById("noticesingle").style.display="inline";
           document.getElementById("checkflag").value="0";
       }
    }
    
</script>
</head>
<body>
<form name="form" id="datacell_formid" action="EmpwelfarerecordAction.do?cmd=toConfirmedPage" method="post"> 
<input type="hidden" name="cmd" value="">
<input type="hidden" name="company_id" id="company_id" value="<%=LoginHelper.getLoginVo(request).getCompany_id()%>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">福利办理反馈</div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="right" style="width:80px">客户名称&nbsp;&nbsp;</td>
    <td align="left" >
     <div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
            id="customer_id" name="customer_id" property="customer_id"
            displayProperty="customer_name"
            lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
            title="客户" height="450" width="610" style="width:100px"  value="${requestScope.customer_id}" displayValue="${requestScope.customer_name}"/></div>
            <input type="hidden" id="customer_name" name="customer_name" value="${requestScope.customer_name}"/>
    </td>
    <td align="right" style="width:80px">客户编号&nbsp;&nbsp;</td>
    <td align="left"><input type="text" value="${requestScope.customer_code}" class="sText" id="customer_code" name="customer_code" style="width:100px" /></td>
  	<td  align="right"  style="width:80px">成本中心&nbsp;&nbsp;</td>
  	<td  align="left" >
  	<r:comboSelect id="cost_center_id"
            name="cost_center_id"
            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name" valueField="id" xpath="CostcenterVo" 
            width="100" messagekey="please_select" value="${requestScope.cost_center_id}"  >
        </r:comboSelect>
    </td>
    <td  align="right" style="width:80px">产品类别&nbsp;&nbsp;</td>
    <td  align="left" ><d:select dictTypeId="GE_PRODUCT_TYPE" id="product_type" name="product_type" style="width:100px" nullLabel="--请选择--" value="${requestScope.product_type}"></d:select></td>
    <td  align="right" style="width:80px">单据状态&nbsp;&nbsp;</td>
    <td  align="left" ><d:select  dictTypeId="DOCUMENT_STATUS" id="document_status" name="document_status" style="width:100px"   nullLabel="--请选择--"  filterOp="in"  filterStr="2,3,4" value="${requestScope.document_status}"></d:select></td>    
      <td align="right" style="width:80px">单据类型&nbsp;&nbsp;</td>
    <td  align="left" ><d:select dictTypeId="DOCUMENT_TYPE" id="document_type" name="document_type" style="width:100px" nullLabel="--请选择--" value="${requestScope.document_type}"></d:select></td>
   </tr>
   
  <tr>
			<td align="right" style="width: 80px">唯一号&nbsp;&nbsp;</td>
			<td align="left"><input type="text" value="${requestScope.emp_code}" class="sText" id="emp_code" name="emp_code" style="width: 100px"  /></td>
			<td align="right" style="width: 80px">员工姓名&nbsp;&nbsp;</td>
			<td align="left"><input type="text" value="${requestScope.emp_name}" class="sText" id="emp_name" name="emp_name" style="width: 100px" /></td>
			<td align="right" style="width: 80px">客户方编号&nbsp;</td>
			<td align="left" colspan="2"><input type="text" value="${requestScope.internal_code}"	class="sText" id="internal_code" name="internal_code" style="width: 180px"  /></td>
			<td align="right" style="width: 80px">证件号&nbsp;&nbsp;</td>
			<td align="left" colspan="2"><input type="text" value="${requestScope.id_card}"class="sText" id="id_card" name="id_card"  style="width: 180px" /></td>
			<td align="right" style="width: 80px">计账年月&nbsp;&nbsp;</td>
			<td align="left"><input type="text" value="${requestScope.account_bill_year_month}" class="sText" id="account_bill_year_month" name="account_bill_year_month"  style="width: 100px" /></td>
		</tr>
  
  <tr>
  <td align=right style="width: 80px">运行确认时间</td>
    <td align="left" colspan="3"><w:date format="yyyy-MM-dd" value="${create_date_start}" name="create_date_start" id="create_date_start" width="100px"/>&nbsp;至&nbsp;<w:date format="yyyy-MM-dd" name="create_date_end" id="create_date_end" value="${create_date_end}" width="100px"/></td>
  
  	<td  align="right" style="width: 80px">客服确认时间</td>
  	<td  align="left" colspan="3"><w:date format="yyyy-MM-dd" value="${confirm_date_start}" name="confirm_date_start" id="confirm_date_start" width="100px"/>&nbsp;至&nbsp;<w:date format="yyyy-MM-dd" name="confirm_date_end" id="confirm_date_end" value="${confirm_date_end}" width="100px"/></td>
  <!--  
  	<td align="right">收费起始年月&nbsp;&nbsp;</td>
    <td align="left">
    <input type="text" value="" class="sText" id="start_date" name="start_date" />
    </td>
      -->
    <td  align="right">客户组&nbsp;&nbsp;</td>
      <td  align="left" >
               <r:comboSelect id="cust_group" name="cust_group" queryAction="/FAERP/Cust_groupAction.do?cmd=queryListCustname"
              textField="cust_group_name" valueField="cust_group_code" xpath="Cust_groupVo" width="100px"  messagekey="--请选择--"  value="${requestScope.cust_group}"/> 
      </td>
  	<td align="right"><input type="button" class="icon_1" value="查询" onClick="queryall()"/></td>
  	<td>  <input name="button_reset2" class="icon_1" type="button" value="重置" onclick="resetstr()" /></td>
  </tr>

    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right" style="width: 99%;">
        <input class="a_2" type="button"   value="查看订单明细"    onClick="detail_onClick();">
        <!--  <input class="b_1" type="button"   value="出当月"    onClick="update_onClick('1');">
        <input class="b_1" type="button"   value="转下月"    onClick="update_onClick('2');">-->
        <input class="b_1" type="button"   value="取消收费"    onClick="update_onClick('3');">
        <input type="button" class="e_1" value="导出" onClick="exportExcel_onClick()"/>
         <input  class="b_1"  id="CheckAllFlag"  type="button"  value="全选" onClick="toCheck(this.value);">
        <span style="color:red;">当前状态：
           <span style="color:red;display:inline" id="noticesingle">非全选</span>
           <span style="color:red;display:none;" id="noticeall">全选</span>
        </span>
        <input id="checkflag" type="hidden" value="0" readonly="readonly"></input>
      </div>
      <div class="clear"></div>
    </div>
        <div class="box" id="values_div"   style="overflow-y:scroll;" >
        <table width="100%"  class="datagrid1"    >
            <tr class="scrollColThead">
               <td style="background-color: #EBEBEB" ><input type='checkbox' name='checkall' onclick='checkAll(this);' /></td>
               <th style="background-color: #EBEBEB" class="yangshi">状态</th>
               <th style="background-color: #EBEBEB" class="yangshi">类型</th>
               <th style="background-color: #EBEBEB" class="yangshi">产品</th>
               <th style="background-color: #EBEBEB" class="yangshi">唯一号</th>
               <th style="background-color: #EBEBEB" class="yangshi">客户方编号</th>
               <th style="background-color: #EBEBEB" class="yangshi">姓名</th>
               <th style="background-color: #EBEBEB" class="yangshi">证件号</th>
               <th style="background-color: #EBEBEB" class="yangshi">成本中心</th>
               <th style="background-color: #EBEBEB" class="yangshi">客户名称</th>
               <th style="background-color: #EBEBEB" class="yangshi">客户编号</th>
               <th style="background-color: #EBEBEB" class="yangshi">收费起始</th>
               <th style="background-color: #EBEBEB" class="yangshi">运行确认时间</th>
               <th style="background-color: #EBEBEB" class="yangshi">客服确认时间</th>
               <th style="background-color: #EBEBEB" class="yangshi">计账年月</th>
               <th style="background-color: #EBEBEB" class="yangshi">版本</th>
            </tr>
            <%
            List beans = (List)request.getAttribute("beans") ;
            for (Object beanobj : beans) {
            	EmpwelfarerecordVo bean = (EmpwelfarerecordVo)beanobj ;
            %>
		            <tr>
		               <td><input type='checkbox' name='checkid' value="<%=bean.getId()+"_"+bean.getEmp_post_id()+"_"+bean.getDocument_status()+"_"+bean.getDocument_type() %>"/></td>
		               <td><%=bean.getDocument_status()==null?"":bean.getDocument_status() %></td>
		               <td><%=bean.getDocument_type()==null?"":bean.getDocument_type() %></td>
		               <td><%=bean.getProduct_type()==null?"":bean.getProduct_type() %></td>
		               <td><%=bean.getEmp_code()==null?"":bean.getEmp_code()%></td>
		               <td><%=bean.getInternal_code()==null?"": bean.getInternal_code() %></td>
		               <td><%=bean.getEmp_name()==null?"":bean.getEmp_name() %></td>
		               <td><%=bean.getId_card()==null?"":bean.getId_card() %></td>
		               <td><%=bean.getCost_center_name()==null?"":bean.getCost_center_name()%></td>
		               <td><%=bean.getCust_name()==null?"":bean.getCust_name() %></td>
		               <td><%=bean.getCust_code()==null?"":bean.getCust_code() %></td>
		               <td><%=bean.getStart_date()==null?"":bean.getStart_date() %></td>
		               <td><%=bean.getCreate_date()==null?"":bean.getCreate_date() %></td>
		               <td><%=bean.getConfirm_date()==null?"":bean.getConfirm_date() %></td>
		               <td><%=bean.getAccount_bill_year_month()==null?"":bean.getAccount_bill_year_month() %></td>
		               <td><%=bean.getV_version()==null?"":bean.getV_version() %></td>
		            </tr>
		            <%} %>
            
        </table>
       
        </div>
         <jsp:include page="/jsp/include/page.jsp" />
        </div>
    <!--表格 end-->
    <!--翻页 --><!--翻页 end-->
    </div>
</form>
</body>
</fmt:bundle>
</html>
