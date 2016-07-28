<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@ page import="java.util.*"%>
<%@ page import="rayoo.employeepost.epwelfare.vo.EpwelfareVo"%>
<%@ page import="rayoo.employeepost.epwelfare.util.IEpwelfareConstants"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(IEpwelfareConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(IEpwelfareConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    EpwelfareVo resultVo = null; //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.employeepost.epwelfare.epwelfare_resource" prefix="rayoo.employeepost.epwelfare.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key="benefits_querys"/></title>
	<script>   
		    function deleteDataInterface(){
		        //alert(rows.length);
		        var isEnd = deleteRow();
		        while (!isEnd){
		            isEnd = deleteRow();
		        }
		   }
		    function deleteRow(){
		        var dc1 = $id("dc_inter");
		        var rows = $id("dc_inter").tbody.rows;
		        for(var i=0; i< rows.length; i++){
		            var row1 = rows[i];
		            var curEn = dc1.getEntity(row1);
		            //alert(curEn.getProperty("id") + "," + curEn.getProperty("id_checked"));
		            if(curEn.getProperty("id_checked") && curEn.getProperty("id_checked")=="true"){
		                dc1.deleteRow(row1);
		                return false;
		            }
		        
		        }    
		        return true;
		    }
		    function toSave_onclick() { 
		     $id("dc_inter").beforeSubmit = function(){
		        return window.confirm("<fmt:message key="sure_save_date"/>");
		        }    
		        $id("dc_inter").submit();
		    } 
		  
		  function setCheckbox(value,entity,rowNo,cellNo){
		     return "<input type='checkbox'  name='temp1'   value=" + entity.getProperty("id") + ">";
		     //  return "<input type='checkbox'  name='temp1'   onClick=\"ClickRow1(\'" + entity.getProperty("id") + "\')\";>";
		    }
		    function ClickRow1(idVa){
			    //alert(idVa);
		        var curEn = $id("dc_inter").dataset.findEntity("id", idVa); 
		        if (curEn && curEn.getProperty){
			        //alert(curEn.status);
			        curEn.status = Entity.STATUS_MODIFIED;
			        $id("dc_inter").isModefied = true;
			        //alert(curEn.status);
			        if (curEn.getProperty("id_checked") && curEn.getProperty("id_checked")== "true"){
			            curEn.setProperty("id_checked", "false");
			        }else{
			            curEn.setProperty("id_checked", "true");
			        }	    
		        }
		    }
		    
		    function checkMonth(mm){
		        if((mm+'').length!=6){
		        return false;
		        }
		        if(((mm+'').substr(0,4))<2000 || ((mm+'').substr(0,4))>2030){
		          return false;
		        }
		        if(((mm+'').substr(4,2))<1 || ((mm+'').substr(4,2))>12){
		          return false;
		        }
		        return true;
		    }
		    
		      //查询
		    function qryData(){
		      jQuery("#loading").css("display","block");
		        $id("dc_inter").reload();
		    }
		    
		    //导出
		     function exportExcel_onClick()
			 {
			    var form= document.getElementById("datacell_formid");
			    form.action="<%=request.getContextPath()%>/EpwelfareAction.do" ;
			    form.cmd.value = "exportExcel";
			    form.submit();
			 }
		   //选择客户
		    function rtnFunc(arg)
		    {
		        var lookup = $id("lk_clz");
		        lookup.value = arg[2];
		        lookup.displayValue = arg[2];
		        //jQuery("#h_customer_id").val(arg[0]);        
		        return false;
		    }
		    //删除（可多条记录）
		    function deleteMulti_onClick()
		    { 
		         //从多选框物理删除多条记录
		        var aegnt_check = document.getElementsByName("temp1");
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
		        //判断 被确认过的数据不能被删
		         if(!isSure(1)){
	               alert("<fmt:message key="ture_date_not_delete"/>");
	               return;
	             }
		        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
		           var form=document.getElementById("datacell_formid");
		           form.action="<%=request.getContextPath()%>/EpwelfareAction.do?ids=" + ids+"&label=list";
		           form.cmd.value = "deleteMulti";
		           form.submit();
		        }
		    }
		      //确定享受（可多条记录）
		     function toSure_onClick()
		     {  
		      var aegnt_check = document.getElementsByName("temp1");
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
		      if(confirm('<fmt:message key="true_operation_selected_date"/>')) {  //如果用户在确认对话框按"确定"
		          var  form=document.getElementById("datacell_formid");
		          form.action="<%=request.getContextPath()%>/EpwelfareAction.do?ids=" + ids+"&label=list";
		          form.cmd.value = "updateMulti";
		           form.submit();
		      }
		    }
		    
		     //确定全部享受
		    function toSureAll_onClick()
			 {
			 	if(confirm('<fmt:message key="true_query_conditions_all_enjoy"/>')) {
				    var form= document.getElementById("datacell_formid");
				    form.action="<%=request.getContextPath()%>/EpwelfareAction.do" ;
				    form.cmd.value = "updateEnjoyAll";
				    form.submit();
			    }
			 }
		    //全选
		    function checkAllList()
		    {
		      var element = document.getElementsByName("temp1"); 
		      for(var i=0;i<element.length;i++){
		          if(element[i].type=="checkbox" && element[i].name=="temp1") {
		              element[i].checked= !element[i].checked ? true : false;
		          }
		      } 
		  }
		  //判断所选择的记录 是否是已确认的
		   function isSure(status) { 
		   var b=true;                    
             var ds1 = $id("dc_inter").dataset;
             var fields = $id("dc_inter").fields;
             jQuery("input[name='temp1']").each(function (i){
             if(jQuery(this).attr("checked") == "checked") {
                 var curEnt = ds1.get(i);
                 var is_sure= curEnt.getValue("is_sure");                                
                 if(is_sure==status){
                    b=false;                    
                 }
               }              
           });
            return b;                  
          }
            
             function toReportPay_onClick()
             {  
              var aegnt_check = document.getElementsByName("temp1");
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
              if(ids!=null&&ids!=''&&ids.length >1 ){
	              alert("<fmt:message key="just_choose_one_date_print"/>") ;
	              return false ;
              }         
              if(confirm('<fmt:message key="true_operation_selected_date"/>')) {  //如果用户在确认对话框按"确定"
                  var  form=$id("datacell_formid");
                  form.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showWelfarePayReport.jsp?raq=reportPay.raq&arg1="+ids[0];
                  form.cmd.value = "updateMulti";
                   form.submit();
              }
            }
            
            //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#h_customer_name").val(arg[2]);
        jQuery("#h_customer_id").val(arg[0]);
        return false;
    }
    
    //可报销和不可报销产品转换 add by sqp  2013年9月23日
    function  tochangeproduct(){
    var type=document.getElementById("enjoy_type").value;
    if(type==2){
        document.getElementById("bukebaoxiao").style.display="none"
        document.getElementById("kebaoxiao").style.display="inline";
    }else{
        document.getElementById("bukebaoxiao").style.display="inline"
        document.getElementById("kebaoxiao").style.display="none";
    }
    }
    //下载模版 2014年2月17日 
        function toDownLoad_onclick(){
         var form= document.getElementById("datacell_formid");
         form.action="<%=request.getContextPath()%>/EpwelfareAction.do"
         form.cmd.value = "downLoadExcel" ;
         form.submit();
    }
    
 /**
 * 弹出显示上传到款信息时的异常数据
 */
function showUploadException() {
    var url ="<%=request.getContextPath()%>/jsp/faerp/employeepost/epwelfare/listWelfareErrorInfo.jsp";
    showModalCenter(url, "", showUploadincomPage_callback, "1000", "430", "导入发放数据时异常信息");
}

function showUploadincomPage_callback () {
    var dc = $id("dc_inter");
    dc.reload();
}
    
    </script>
	</head>
	<body>
	<form method="post" id="datacell_formid" name="datacell_formid"	action="">
	
	<input type="hidden" name="cmd" value="">
	<input type="hidden" name="c_name" id="h_customer_name" value=""/>     
     <input type="hidden" name="c_id" id="h_customer_id" value=""/>  
	<div id="right"><script language="javascript">
                         writeTableTopFesco('<fmt:message key="benefits_querys"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
            </script>
	<div class="ringht_s">
	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="135" rowspan="3" style="padding-top: 0;">
			<div class="search_title"><fmt:message key="query_conditions"/></div>
			</td>
			<td width="80"><fmt:message key="emp_name"/></td>
			<td width="220"><input type="text" class="text_field"
				name="emp_name" inputName="员工姓名" maxLength="50" /></td>
			<td width="80"><fmt:message key="cust_name"/></td>
			<td width="220">
			<!--   <input type="text" class="text_field" id="cust_name" name="cust_name" validators="isSearch" inputName="客户名称" maxLength="50" /><img class="refButtonClass"
                                    src="<venus:base/>/images/au/09.gif" onClick="javascript:getbyid();" /> 
                                    
                   <w:lookup onReturnFunc="rtnFunc"  id="lk_clz" name="c_name"
				lookupUrl="/CustomersimpleAction.do?cmd=queryAllGetByID"
				dialogTitle="选择客户" height="500" width="810" />--> 
				
				<w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_cust" height="440" width="600"  style="width:195px"/>
                
                
				<!-- <input type="hidden"	name="cust_name" id="h_customer_id" /> -->
				
				</td>
			<td width="60"><fmt:message key="emp_code"/></td>
			<td width="220">
			         <input type="text" class="text_field"	name="emp_code" inputName="唯一号" maxLength="25" />
			</td>
		</tr>
		<tr>
			<td><fmt:message key="benefits_type"/></td>
            <td>
            <select class="sSelect" name="enjoy_type" id="enjoy_type"  onchange="tochangeproduct();">
                <option selected="selected" value="1"><fmt:message key="non_reimbursable"/></option>
                <option value="2"><fmt:message key="may_be_reimbursable"/></option>
            </select>
            </td>
             <td width="15%" class="td_1"><fmt:message key="fuli_product"/>
            </td>
            <td width="20%" class="td_2"  id="bukebaoxiao">
            <select  id="product_id" name="product_id">
                 <option value=""><fmt:message key="please_choose"/></option>
                  <option value="1099110200000000102"><fmt:message key="ndtj"/></option>  
                 <option value="1099800100000000028"><fmt:message key="dgqfl"/></option>
                 <option value="1099800100000000024"><fmt:message key="zqybfl"/></option>
                 <option value="8099800100000000002"><fmt:message key="sgdhqfl"/></option>
                 <option value="1099800100000000041"><fmt:message key="dypfl"/></option>
                 <option value="8099800100000000004"><fmt:message key="etjlwfl"/></option>
                 <option value="1099110200000000188"><fmt:message key="tanxingfl"/></option>
            </select>
            </td>
                 <td width="20%" class="td_2"  id="kebaoxiao" style="display: none"><!-- 可报销产品 从福利报销页面copy add by sqp -->
            <select  id="product_id" name="product_id">
                 <option value=""><fmt:message key="please_choose"/></option>
                 <option value="1099110200000000114"><fmt:message key="home_equipment_fees"/></option>
                 <option value="1099110200000000115"><fmt:message key="green_allowance"/></option>
                 <option value="9099110200000000161"><fmt:message key="child"/></option><!-- 2013年9月12日 19:48:39 修改为 从产品1099110200000000161 到   9099110200000000161  -->
                 <option value="2012800100000000001"><fmt:message key="preschools"/></option>
                 <option value="1099800100000000041"><fmt:message key="movie_tickets"/></option>
                 <option value="1099110200000000102"><fmt:message key="ndtj"/></option>
                      <!-- 增加两个新的产品 供暖补贴和报刊费 2014年3月21日 sqp -->
                 <option value="1099110200000000090"><fmt:message key="gnbt"/></option><!-- 1099110200000000090    1099110200000000315-->
                 <option value="1099110200000000091"><fmt:message key="bkf"/></option>
                   <!-- 新增产品 入职体检 2014年5月20日 1 -->
                 <option value="2013800100000000188"><fmt:message key="rztj"/></option>
                 
            </select>
            </td>
            <td><fmt:message key="is_sure"/></td>
            <td>
                <d:select name="is_sure" id="is_sure" dictTypeId="TrueOrFalse" nullLabel="--请选择--" style="width: 205px" />
            </td>
		</tr>
		<tr>
			
			<td><fmt:message key="id_card_num"/></td>
            <td><input type="text" class="text_field" name="id_card" inputName="证件号码" maxLength="64" /></td>
			<td><fmt:message key="enjoy_benefits_month"/></td>
			<td>
			<input type="text" class="text_field" name="enjoy_month"
				inputName="福利享受月" maxLength="64" value="" />
			</td>
			<td><fmt:message key="send_status"/></td>
			<td>
			<select id="send_status" name="send_status">
			<option value="0"><fmt:message key="had_not_send"  /></option>
			<option value="1"><fmt:message key="had_send"/></option>    
			</select>
			</td>
		</tr>
		<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
        <td>&nbsp;</td>
		<td>
            <input onclick="qryData()" type="button" class="icon_1"
                value="<fmt:message key="query"/>" />
                </td>
                <td> <div id="loading" style="display: none;">
            <img  src="<%=request.getContextPath()%>/images/loading01.gif"
                height="20px" width="20px" /></div></td>
		</tr>
		
	</table>
	</div>
	<div id="ccParent1" class="button">
	<div class="button_right">
	<!--<ul>
		<li class="d" id="del"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete" /> </a></li>
		<li class="R" id="sure"><a onclick="javascript:toSure_onClick();">确定享受</a></li>
		<li class="p_1"><a onClick="javascript:exportExcel_onClick();">导出</a></li>
		<li class="p_1" id="print"><a onClick="javascript:toReportPay_onClick();">打印支出凭证</a></li>
	</ul>
	 -->
	 <input type="button" class="d"  id="del" value="<fmt:message key="delete"/>"  <au:authorityBtn code="flcx_del" type="1"/> onclick="deleteMulti_onClick();" >
	  <input type="button" class="R"  id="sure" value="<fmt:message key="true_enjoy"/>"  <au:authorityBtn code="flcx_qdxs" type="1"/> onclick="toSure_onClick();" >
	  <input type="button" class="R"  id="sure" value="<fmt:message key="all_enjoy"/>"  <au:authorityBtn code="flcx_qdxs" type="1"/> onclick="toSureAll_onClick();" >
	  <input type="button" class="e" value="<fmt:message key="export"/>"  <au:authorityBtn code="flcx_exp" type="1"/>  onclick="exportExcel_onClick();" >
	  <input type="button" class="e_1" id="importinfo"   <au:authorityBtn code="flcx_drall" type="1"/>   value="<fmt:message key="import"/>"  >
      <!--  <input type="button" class="p_1" value="<fmt:message key="print_out_card"/>"  <au:authorityBtn code="flcx_print" type="1"/> id="print"  onclick="toReportPay_onClick();" />  注释2014年5月6日-->
      <input class="xz" type="button"   value="<fmt:message key='button_donwload'/>"  <au:authorityBtn code="flcx_drall" type="1"/>  onClick="toDownLoad_onclick();">
      <input class="p_1" type="button"   value="<fmt:message key='button_errpr'/>"  <au:authorityBtn code="flcx_drall" type="1"/>   onClick="showUploadException();">
	</div>
	<div class="clear"></div>
	</div>
	<div style="padding: 8 10 8 8;">
	<r:datacell id="dc_inter"	queryAction="/FAERP/EpwelfareAction.do?cmd=searchData" 
	   submitAction="/FAERP/EpwelfareAction.do?cmd=updateData" width="98%"
		height="320px" xpath="EpwelfareTempVo" submitXpath="EpwelfareTempVo" 	paramFormId="datacell_formid"
		pageSize="100">

		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<!-- <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckbox" align="center" >
			               </r:field> -->
		<r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList();' />" width="40px" onRefreshFunc="setCheckbox">
		</r:field>
		<r:field fieldName="cust_name" messagekey="cust_name" width="150px">
		</r:field>
		<r:field fieldName="emp_name" messagekey="emp_name" width="150px">
		</r:field>
		<r:field fieldName="emp_code" messagekey="emp_code" width="150px">
		</r:field>
		<r:field fieldName="id_card" messagekey="id_card_num" width="150px">
		</r:field>
		 <r:field fieldName="bank_name" messagekey="bank_name" width="150px">
        </r:field>
            <r:field fieldName="account_num" messagekey="account_num" width="150px">
        </r:field>
		<r:field fieldName="name" messagekey="fuli_product" width="150px">
		</r:field>
		<r:field fieldName="product_name" messagekey="emp_act" width="150px">
		</r:field>
		<r:field fieldName="send_status" messagekey="send_status" width="150px">
        </r:field>
		<r:field fieldName="grant_counts" messagekey="distributed_num_copise" width="150px">
		</r:field>
		<r:field fieldName="remark" messagekey="remark" width="150px">
		</r:field>
		<r:field fieldName="is_sure" messagekey="is_sure" allowModify="false">
			<d:select dictTypeId="TrueOrFalse" />
		</r:field>
		<r:field fieldName="start_month" messagekey="benefits_begin_month" width="150px" allowModify="false">
		</r:field>
		<r:field fieldName="end_month" messagekey="benefits_end_month" width="150px" allowModify="false">
		</r:field>
		<!-- delete by sqp 2014年3月10日
		<r:field fieldName="enjoy_month" messagekey="enjoy_month" width="150px" allowModify="false">
		</r:field>
		 -->
		<r:field fieldName="order_money" messagekey="enjoy_money" width="150px">
		</r:field>
		<r:field fieldName="money" messagekey="order_money" width="150px">
		</r:field>
		<r:field fieldName="user_name" messagekey="user_name" width="150px">
		</r:field>
		<r:field fieldName="user_pary" messagekey="party_name" width="150px">
		</r:field>
		<r:field fieldName="input_date" messagekey="input_date1" width="150px">
		</r:field>
		<r:field fieldName="post_bd" label="寄送方式" width="150px">
        </r:field>
        <r:field fieldName="post_to" label="收件人" width="150px">
        </r:field>
		<r:field fieldName="active_contacts" label="员工活动联系人" width="150px">
        </r:field>
        <r:field fieldName="active_address" label="员工活动联系地址" width="150px">
        </r:field>
        <r:field fieldName="active_mobile" label="员工活动联系方式" width="150px">
        </r:field>
	</r:datacell></div>
	</div>
	</div>
	</form>
</fmt:bundle>
</body>
</html>
<script>
/*
 function changeSmallType(){
    var curValue = $id("small_product_code").getValue();     
        $id("product_id").disabled = false;   
         $id("product_id").addParam("code", curValue);
         $id("product_id").loadData();
         $id("product_id").refresh();
     }  
     
         */

    $id("dc_inter").beforeRefreshCell = function(cell,field1){
        //alert(field1);alert(field1.fieldName);
        if (field1 && field1.fieldName && field1.fieldName=="emp"){
            return false;
        }
    } 
    
    function hideBtn(){
        var enjoy_type=jQuery("#enjoy_type").val();
        if(enjoy_type=='2'){     //   1：福利发放 2：福利报销
           // jQuery("#del").hide().css('display', 'none'); 
           // jQuery("#sure").css('display', 'none'); 
           // jQuery("#print").css('display', 'inline'); 
        }
        else{
          //  jQuery("#del").hide().css('display', 'inline'); 
           // jQuery("#sure").css('display', 'inline'); 
            //jQuery("#print").css('display', 'inline'); 
           // jQuery("#print").css('display', 'none'); 
            }
            jQuery("#loading").css("display","none");
    }
  
    $id("dc_inter").afterRefresh = function () {
        hideBtn(); 
    }
    
    //初始化不加载页面信息<linamin添加>
	jQuery(function(){
	    $id("dc_inter").isQueryFirst = false;
	});
	
	//2014年2月14日  导入
	jQuery(document).ready(function(){
    jQuery("#importinfo").bind("click", function(){
       var weltype=document.getElementById("enjoy_type").value; //不可报销 1   可报销 2
       vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/employeepost/epwelfare/importInfoExcel.jsp?weltype="+weltype, "", "dialogWidth=600px; dialogHeight=250px");
      }
    );
});
      
</script>
