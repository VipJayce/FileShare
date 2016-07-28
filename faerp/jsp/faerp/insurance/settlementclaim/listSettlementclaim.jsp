<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.settlementclaim.util.ISettlementclaimConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
	jQuery(document).ready(function() {
	     if($id("datacell")==null)return;
	     $id("datacell").afterRefresh = function(){
	        var Me = $id("datacell");
	        var rows = Me.allTR;
	        var  sum_real_applied_amount=0;
	        var  sum_payAmount=0;
	        var  sum_wholly_payment=0;
	        var  sum_real_claims_amount=0;
	        var  sum_rejected_amount=0;
	        for (var i=0;i<rows.length;i++ ){
	          var entity1 = Me.dataset.get(i);
	          var real_claims_amount = entity1.getProperty("real_claims_amount");
	          var systemCalculateAmount = entity1.getProperty("systemCalculateAmount");
	          var id = entity1.getProperty("id");
	          //需要合计的列
	          sum_real_applied_amount+=parseFloat(entity1.getProperty("real_applied_amount")==null?0:entity1.getProperty("real_applied_amount"));
	          sum_payAmount+=parseFloat(entity1.getProperty("payAmount")==null?0:entity1.getProperty("payAmount"))  ;
	          sum_wholly_payment+=parseFloat(entity1.getProperty("wholly_payment")==null?0:entity1.getProperty("wholly_payment"));
	          sum_real_claims_amount+=parseFloat(entity1.getProperty("real_claims_amount")==null?0:entity1.getProperty("real_claims_amount"));
	          sum_rejected_amount+=parseFloat(entity1.getProperty("rejected_amount")==null?0:entity1.getProperty("rejected_amount"));
              if(id!=null && id!=""){	          
		          if(real_claims_amount!=systemCalculateAmount){
		            rows[i].style.backgroundColor = "red";
		          }
	          }
	        }
	        //添加合计列2014年8月15日
	         if(sum_real_applied_amount!=0){
	         $id("datacell").addRow();
             $id("datacell").endEdit();
	            jQuery(".eos-body-div tr").last().find("td[fieldId^='batch_code']").find("div").text("合计");
                jQuery(".eos-body-div tr").last().find("td[fieldId^='real_applied_amount']").find("div").text(sum_real_applied_amount.toFixed(2) );
                jQuery(".eos-body-div tr").last().find("td[fieldId^='payAmount']").find("div").text(sum_payAmount.toFixed(2) );
                jQuery(".eos-body-div tr").last().find("td[fieldId^='wholly_payment']").find("div").text(sum_wholly_payment.toFixed(2));
                jQuery(".eos-body-div tr").last().find("td[fieldId^='real_claims_amount']").find("div").text(sum_real_claims_amount.toFixed(2));
                jQuery(".eos-body-div tr").last().find("td[fieldId^='rejected_amount']").find("div").text(sum_rejected_amount.toFixed(2));
                }
	    }
	    $id("datacell").afterEdit = function(newValue,oldValue) {
	       $id("datacell").isModefied=false;
	       }
	});

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
    function showListData(){
        $id("datacell").loadData();
        $id("datacell").refresh();
    }
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = selectIds();
		var flag = true;
        if(ids == null || ids == '') {
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		jQuery.ajax({
            url: '<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=checksettlementclaimState&settlementclaim_id='+ids,
            type: 'POST',
            dataType: 'html',
            timeout: 10000,
            error: function(){
                alert('Error loading XML document');
                return null;
            },
            success: function(data){
            //后台取到数据
            if(data=='0'){
                //未审批，可修改理赔申请单
                $id("datacell").isModefied = false;
                var url="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=find&id=" + ids;
		        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
		        showModalCenter(url, window, callBack, 900, 350, "修改理赔申请单"); 
            }else{
                  $id("datacell").isModefied = false;
                  alert("该理赔申请单已提审批,不能进行修改!");
                  flag = false;
            }
          }
         });  
         if(flag==false){
            return;
         } 
		//form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
		//var url="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=find&id=" + ids;
        //url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        //showModalCenter(url, window, callBack, 900, 350, "修改理赔申请单"); 
	  // form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/settlementclaim/insertSettlementclaim.jsp?id="+ids;
      //  form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = selectIds();
 		var flag = true;
        if(ids == null || ids == '') {
			alert('<fmt:message key="select_one_record"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
		 /*jQuery.ajax({
            url: '<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=checksettlementclaimState&settlementclaim_id='+ids,
            type: 'POST',
            dataType: 'html',
            async: false,
            timeout: 10000,
            error: function(){
                alert('Error loading XML document');
                return null;
            },
            success: function(data){
            //后台取到数据
            if(data=='0'){*/
                //未审批，可删除理赔申请单
                $id("datacell").isModefied = false;
                document.form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=batchDeleteMulti&ids=" + ids;
                document.form.submit();
            /*}else{
                  $id("datacell").isModefied = false;
                  alert("有已提审理赔申请单,不能进行删除,请确认该申请单为未提审!");
                  flag = false;
            }
          }
         });
         if(flag==false){
            return;
         }  */
		
	    	//form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?ids=" + ids;
	    	//form.cmd.value = "batchDeleteMulti";
	    	//form.submit();
	    	//$id("datacell").deleteRow();
            //$id("datacell").submit();
		}
		 
	}
	
	function deleteMulti_onClick1(){  //根据批次号批量物理删除
        var query_batch_code = $id("query_batch_code").value;
        var policyCode = $id("policyCode").value;
        var flag = true;
        if(query_batch_code == null || query_batch_code == '') {
            alert('请输入批次号！');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            $id("datacell").isModefied = false;
            var action="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=batchDelete&Date="+(new Date()).getTime();  
	        var myAjax = new Ajax(action);
	        myAjax.addParam('query_batch_code', query_batch_code);
	        myAjax.addParam('policyCode',policyCode);
	        myAjax.submit();
	        var returnNode = myAjax.getResponseXMLDom();
	        if( returnNode ) {
	             alert(""+myAjax.getProperty("returnValue"));
	             window['returnValue'] = ""+myAjax.getProperty("returnValue");
	        }
            $id("datacell").loadData();
            $id("datacell").refresh();
        }
    }
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	//form.cmd.value = "simpleQuery";
    	//form.submit();
       //$id("datacell").addParam("query_batch_code",$id("query_batch_code").value); 
       //$id("datacell").addParam("query_emp_code",$id("query_emp_code").value); 
       //$id("datacell").addParam("query_emp_name",$id("query_emp_name").value); 
       var issuing_date_from=$id("issuing_date_from");
       var issuing_date_to=$id("issuing_date_to");
       var last_update_date_from=$id("last_update_date_from");
       var last_update_date_to=$id("last_update_date_to");
       var create_date_from=$id("create_date_from");
       var create_date_to=$id("create_date_to");
       if(issuing_date_to.value!=null&&issuing_date_to.value.trim().length!=0){
           if(issuing_date_from.value!=null){
		       var beginTime = issuing_date_from.value.trim();
		       var endTime = issuing_date_to.value.trim();
	           var beginTimes=beginTime.substring(0,10).split('-');
	           var endTimes=endTime.substring(0,10).split('-');
	           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
	           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
	           if(beginTime>endTime){
	               alert("初险终止日期小于初险起始日期！");
	               return;
	           }
           }
       }
       if(last_update_date_to.value!=null&&last_update_date_to.value.trim().length!=0){
           if(last_update_date_from.value!=null){
	           var beginTime = last_update_date_from.value.trim();
	           var endTime = last_update_date_to.value.trim();
	           var beginTimes=beginTime.substring(0,10).split('-');
	           var endTimes=endTime.substring(0,10).split('-');
	           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
	           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
	           if(beginTime>endTime){
	               alert("申请终止日期小于申请起始日期！");
	               return;
	           }
           }
       }
       if(create_date_to.value!=null&&create_date_to.value.trim().length!=0){
           if(create_date_from.value!=null){
	           var beginTime = create_date_from.value.trim();
	           var endTime = create_date_to.value.trim();
	           var beginTimes=beginTime.substring(0,10).split('-');
	           var endTimes=endTime.substring(0,10).split('-');
	           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
	           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
	           if(beginTime>endTime){
	               alert("导入终止日期小于导入起始日期！");
	               return;
	           }
           }
       }
       $id("datacell").loadData();
       $id("datacell").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		//form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/settlementclaim/insertSettlementclaim.jsp";
		//form.submit();
		var url="<%=request.getContextPath()%>/jsp/faerp/insurance/settlementclaim/insertSettlementclaim.jsp";
        url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 900, 350, "新增理赔申请单"); 
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = selectIds();
        if(ids == null || ids == '') {
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		//form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?id=" + ids;
		//form.cmd.value = "detail";
		//form.submit();
		var url="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, showListData, 900, 350, "查看理赔申请单"); 
	}
	
	function callBack(reg){
        if(reg!=""&&reg!=null){
            $id("datacell").loadData();
            $id("datacell").refresh();
        }
    }
    
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' value='"+ entity.getProperty("id")+"' name='checkbox_template' >";
    }
   function checkAll(){
   var element = document.getElementsByTagName("input");
   for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
               element[i].checked= !element[i].checked ? true : false;
           }
   } 
 }
	function exportExcel_onClick()
	{
	  if(confirm('是否确定要导出数据？')) {
	      document.form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=exportToExcelSettlementclaim";
	      document.form.submit();
      }
	}
	
	function exportSMS_onClick()
	{
	  if(confirm('是否确定要导出短信？')) {
	      document.form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=exportSMSSettlementclaim";
	      document.form.submit();
      }
	}
	
    function importExcel_onClick()
    {
         var url = "<%=request.getContextPath()%>/jsp/faerp/insurance/settlementclaim/importExcel.jsp";
         showModalCenter(url, window,toFindMemer,750,200,"导入理赔信息");
    }
    
    function toFindMemer(obj)
    {
        $id("datacell").loadData();
        $id("datacell").refresh();
    }
     function save_onClick()
    {
          $id("datacell").submit();
    }
    
    /**
	 * 点击全选按钮
	 * @param {} item
	 */
	function checkAll(item) {
	    if (_$(item).attr("checked")) {
	        changeEntityChk(true);
	        _$(":checkbox").attr("checked", true);
	    } else {
	        changeEntityChk(false);
	        _$(":checkbox").attr("checked", false);
	    }
	}
	
	/**
	 * 改变datacell中的chk的值
	 * @param {} flag
	 */
	function changeEntityChk(flag) {
	    var dc1 = $id("datacell").dataset;
	    var values = dc1.values;
	    for(var i=0; i<values.length; i++){
	        var entity = values[i];
	        entity.setProperty("chk", flag);
	    }
	}
	
	/**
	 * 选择行后返回ids
	 */
	function selectIds() {
	    var myids = new Array(0);
	    var dc = $id("datacell");
	    var ds = dc.dataset;
	    _$("input[type='checkbox']").each(function(i) {
	        //第0个为全选按钮
	        if (i != 0 && _$(this).attr("checked")) {
	            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	            var entity = dc.getEntity(row);
	            //此id为post_id
	            //myids += entity.getValue("id") + ",";
	            myids.push(entity.getValue("id"));
	        }
	    });
	    return myids;
	}
	function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];      
        return false;
    }
</script>
</head>
<body>

<form id="datacell_formid" name="form" method="post">
<div id="right">
<script language="javascript">
	writeTableTopFesco('理赔申请单管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
		<tr>
			<td align="right">批次号</td>
			<td align="left">
				<w:date format="yyyy-MM-dd" id="query_batch_code" name="query_batch_code" width="190px"/>
			</td>
		    <td align="right">申请人唯一号</td>
            <td align="left">
                <input type="text" class="text_field" id="query_emp_code" name="query_emp_code" inputName="申请人唯一号" maxLength="64"/>
            </td>
            <td align="right">申请人名称</td>
            <td align="left">
                <input type="text" class="text_field" id="query_emp_name" name="query_emp_name" inputName="申请人名称" maxLength="50"/>
            </td>              
		</tr>
		<tr>
            <td align="right">证件号</td>
            <td align="left">
                <input type="text" class="text_field" id="id_card" name="id_card" inputName="证件号" maxLength="64"/>
            </td>
            <td align="right">生日</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" id="birth_date_search" name="birth_date_search" width="189px"/>
            </td>
            <td align="right">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" id="custCode" name="custCode" inputName="客户编号" maxLength="64"/>
            </td>  
        </tr>
        <tr>
            <td align="right">客户</td>
            <td align="left">
                <w:lookup   onReturnFunc="rtnFunc" name="custName" lookupWidth="189px" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="500" width="810"/>
            </td>   
            <td align="right">出险时间</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" id="issuing_date_from" name="issuing_date_from" width="80px"/>到<w:date format="yyyy-MM-dd" id="issuing_date_to" name="issuing_date_to" width="80px"/>
            </td>
            <td align="right">申请日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" id="last_update_date_from" name="last_update_date_from" width="80px"/>到<w:date format="yyyy-MM-dd" id="last_update_date_to" name="last_update_date_to" width="80px"/>
            </td>
        </tr>
        <tr>
            <td align="right">保单编号</td>
            <td align="left"><input type="text" class="text_field" id="policyCode" name="policyCode" inputName="保单编号" maxLength="64"/></td>
            <td align="right">导入日期</td>
            <td align="left"><w:date format="yyyy-MM-dd" id="create_date_from" name="create_date_from" width="80px"/>到<w:date format="yyyy-MM-dd" id="create_date_to" name="create_date_to" width="80px"/></td>
            <td align="right">&nbsp;</td>
            <td align="left"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">&nbsp;&nbsp;<input name="button_ok" class="icon_1"   type="reset" value='<fmt:message key="reset"/>'></td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
				    <li class="a">     <a  onClick="javascript:detail_onClick();"><fmt:message key="view" /> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="b">     <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>					
					<li class="e_1">     <a  onClick="javascript:importExcel_onClick();">导入 </a> </li>
					<li class="e">     <a  onClick="javascript:exportExcel_onClick();">导出 </a> </li>					
				</ul>		
				--><input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="lpsqd_view" type="1"/>  onClick="detail_onClick();">
				 <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="lpsqd_add" type="1"/>  onClick="toAdd_onClick();">
				 <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="lpsqd_xg" type="1"/>  onClick="findCheckbox_onClick();">
				 <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="lpsqd_del" type="1"/>  onClick="deleteMulti_onClick();">		
				 <input class="e_1" type="button"   value="导入"  <au:authorityBtn code="lpsqd_imp" type="1"/>  onClick="importExcel_onClick();">
                 <input class="e" type="button"   value="导出"  <au:authorityBtn code="lpsqd_exp" type="1"/>  onClick="exportExcel_onClick();">
                 <input class="e_3" type="button"   value="导出短信"  <au:authorityBtn code="lpsqd_exp" type="1"/>  onClick="exportSMS_onClick();">        
                 <input class="d_1" type="button"   value="批量删除"  <au:authorityBtn code="lpsqd_del" type="1"/>  onClick="deleteMulti_onClick1();">  
		 </div>
           <div class="clear"></div>			
</div>
        <r:datacell 
        id="datacell"
       queryAction="/FAERP/SettlementclaimAction.do?cmd=queryAll"       
       isCount="false"
        width="100%"
        xpath="SettlementclaimVo"
        height="320"        
        paramFormId="datacell_formid" pageSize="10"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <!--<r:field fieldName="id"  label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       -->
       <r:field allowModify="false" fieldName="chk"
            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            sortAt="none" width="30px" >
            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
                uncheckedValue="0" />
        </r:field>
       <r:field fieldName="batch_code" width="100px" label="批次号">
       </r:field> 
       <r:field fieldName="policy_code" width="100px" label="保单编号">
       </r:field> 
       <r:field fieldName="emp_code" width="100px" label="唯一号">
       </r:field> 
       <r:field fieldName="emp_name" width="100px" label="申请人名称">
       </r:field> 
       <r:field fieldName="id_card" width="100px" label="证件号">
       </r:field> 
       <r:field fieldName="birth_date" width="100px" label="生日" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field> 
       <r:field fieldName="custCode" width="100px" label="客户编号">
       </r:field> 
       <r:field fieldName="custName" width="100px" label="客户">
       </r:field> 
       <r:field fieldName="additional_name" width="100px" label="附险人姓名">
       </r:field> 
       <r:field fieldName="invoice_code" width="100px" label="发票编号">
       </r:field> 
       <r:field fieldName="visiting_hospital" width="100px" label="就诊医院">
       </r:field> 
       <r:field fieldName="disease_name" width="100px" label="疾病名称">
       </r:field> 
       <r:field fieldName="face_amount" width="100px" label="票面金额（初次申请金额）">
       </r:field> 
       <r:field fieldName="issuing_date" width="100px" label="出险日期" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field> 
       <r:field fieldName="visting_date" width="100px" label="就诊日期" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field> 
       <r:field fieldName="claim_no" width="100px" label="理赔号">
       </r:field> 
       <r:field fieldName="takingover_date" width="100px" label="交接日期" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field> 
       <r:field fieldName="item_name_bd" width="100px" label="项目名称">
       </r:field> 
       <r:field fieldName="real_applied_amount" width="100px" label="实际申请金额">
       </r:field> 
       <r:field fieldName="payAmount" width="100px" label="自费">
       </r:field> 
       <r:field fieldName="wholly_payment" width="100px" label="统筹支付">
       </r:field> 
       <r:field fieldName="attached_payment" width="100px" label="附加支付">
       </r:field>       
       <r:field fieldName="conceitedAmount" width="100px" label="分类自负">
       </r:field>     
       <!--<r:field fieldName="reason_substract" width="100px" label="扣除原因">
       </r:field>
       <r:field fieldName="substracted_amount" width="100px" label="扣除金额">
       </r:field>  
       --><r:field fieldName="deductible_amount" width="100px" label="免赔额">
       </r:field>  
       <r:field fieldName="percentage_claims" width="100px" label="赔付比例（险种）">
       </r:field>  
       <r:field fieldName="real_claims_amount" width="100px" label="实际赔付金额">
       </r:field>  
       <r:field fieldName="total_real_claims" width="100px" label="总实际赔付">
       </r:field> 
       <r:field fieldName="systemCalculateAmount" width="100px" label="系统计算金额">
       </r:field> 
       <r:field fieldName="reason_refuse" width="100px" label="拒赔原因">
       </r:field>  
       <r:field fieldName="absent_docs" width="100px" label="缺少材料">
       </r:field>  
       <r:field fieldName="contents_absent_docs" width="100px" label="拒赔内容">
       </r:field>  
       <r:field fieldName="claims_rejected_bd" width="100px" label="拒赔张数">
       </r:field>  
       <r:field fieldName="rejected_amount" width="100px" label="拒赔金额">
       </r:field>     
       <r:field fieldName="account_num" width="100px" label="银行账号">
       </r:field>       
       <r:field fieldName="bank_name" width="100px" label="开户行">
       </r:field>       
       <r:field fieldName="province_name" width="100px" label="账号省名">
       </r:field>       
       <r:field fieldName="city_area_name" width="100px" label="账号市区名">
       </r:field>       
       <r:field fieldName="user_name" width="100px" label="客服">
       </r:field>         
       <r:field fieldName="claims_state" width="100px" label="付款状态" allowModify="false">
       <d:select dictTypeId="CLAIMS_STATE_BD" />
       </r:field>
       <r:field fieldName="last_update_date" width="100px" label="申请日期" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field>
    </r:datacell>

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
	if(request.getAttribute(ISettlementclaimConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISettlementclaimConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
