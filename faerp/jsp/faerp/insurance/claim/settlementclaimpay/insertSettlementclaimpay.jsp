<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="gap.authority.helper.LoginHelper"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<% 
	String claimpaycode = request.getAttribute("claimpaycode")==null?"":request.getAttribute("claimpaycode").toString();
    String name = LoginHelper.getLoginName(request);
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(document.form.batch_num.value==null || document.form.batch_num.value==""){
           alert("批次号不能为空！");
           return;
        }
	    if(document.form.insurance_agent_id.value==null || document.form.insurance_agent_id.value==""){
            alert("保险公司名称不能为空！");
            return;
	    }
	    if("<%=name%>" == '系统管理员'){
            alert("系统管理员 不可以提交审批流程！");
            return;
         }
		$id("datacell1").isModefied = true;
		$id("datacell1").addParam('sett_claim_pay_code', document.form.sett_claim_pay_code.value);
        $id("datacell1").addParam('insurance_agent_id', document.form.insurance_agent_id.value);
        $id("datacell1").addParam('batch_num', document.form.batch_num.value);
        $id("datacell1").addParam('pay_type', document.form.pay_type.value);
        $id("datacell1").addParam('remark', document.form.remark.value);
        $id("datacell1").addParam('id', document.form.id.value);
        $id("datacell1").addParam('create_date', document.form.create_date.value);
        $id("datacell1").addParam('company_id', document.form.company_id.value);
        $id("datacell1").addParam('approval_state', document.form.approval_state.value);
        $id("datacell1").addParam('create_user', document.form.create_user.value);
        $id("datacell1").addParam('total_count',document.form.total_count.value);
        $id("datacell1").submit();
        window.close();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		if(document.form.batch_num.value==null || document.form.batch_num.value==""){
           alert("批次号不能为空！");
           return;
        }
		if(document.form.insurance_agent_id.value==null || document.form.insurance_agent_id.value==""){
            alert("保险公司名称不能为空！");
            return;
        }
    	$id("datacell1").isModefied = true;
    	$id("datacell1").addParam('sett_claim_pay_code', document.form.sett_claim_pay_code.value);
        $id("datacell1").addParam('insurance_agent_id', document.form.insurance_agent_id.value);
        $id("datacell1").addParam('batch_num', document.form.batch_num.value);
        $id("datacell1").addParam('pay_type', document.form.pay_type.value);
        $id("datacell1").addParam('remark', document.form.remark.value);
        $id("datacell1").addParam('id', document.form.id.value);
        $id("datacell1").addParam('create_date', document.form.create_date.value);
        $id("datacell1").addParam('company_id', document.form.company_id.value);
        $id("datacell1").addParam('approval_state', document.form.approval_state.value);
        $id("datacell1").addParam('create_user', document.form.create_user.value);
        $id("datacell1").submit();
        window.close();
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    //根据批次号查找保险公司信息
    function addInsuranList(batchNum) {
        var evt=window.event;
        if(13==evt.keyCode){
            jQuery.ajax({
            url: '<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=findInsuranByBatchNum&batchNum='+batchNum.value+'',
            type: 'POST',
            dataType: 'json',
            timeout: 10000,
            cache: false,
            error: function(){
                alert('Error loading XML document');
                return null;
            },
            success: function(data){         
                if(data!=null&&data.length>0){
	                jQuery("#insurance_agent_id").empty();   
	                jQuery.each(data, function(i, n){
	                    jQuery("#insurance_agent_id").append("<option value='" + data[i].id + "'>" + data[i].agent_name + "</option>");    
	                }); 
	                //jQuery("#insurance_agent_id").onchange(addBatchNumList(this));
                    //后台取到数据
                    var rows = $id("datacell1").getCurrentRowCount();
                    if(rows>0){
                        for(var i = 1;i<= rows;i++){
                          $id("datacell1").deleteRow();      
                          document.getElementById("total_count").value="";  
                        }
                    }    
                    var insurance_agent_id = document.getElementById("insurance_agent_id");
                    var batchNum = document.getElementById("batch_num");
			        jQuery.getJSON("<venus:base/>/SettlementclaimpayAction.do?cmd=getChooseByBatchNum&randID="+escape(new Date())+"&batchNum="+batchNum.value+"&insurance_agent_id="+insurance_agent_id.value,   function(json){
			           if(json.saia == null || json.saia == "" || json.total == null || json.total == ""){
			              alert("没有相关数据！");
			              return;
			           }
			           var rows = $id("datacell1").getCurrentRowCount();
			            if(rows>0){
			                for(var i = 1;i<= rows;i++){
			                  $id("datacell1").deleteRow();      
			                  document.getElementById("total_count").value="";  
			                }
			            }         
			           document.getElementById("total_count").value=json.total;
			           for(var i = 0; i < json.saia.length; i++){
			               var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
			               newEntity.setProperty("emp_name", json.saia[i].emp_name);
			               newEntity.setProperty("account_num", json.saia[i].account_num);
			               newEntity.setProperty("bank_name", json.saia[i].bank_name);
			               newEntity.setProperty("amount", json.saia[i].amount);
			               newEntity.setProperty("item_batch_num", json.saia[i].batch_num);
			               newEntity.setProperty("settlement_claim_id", json.saia[i].settlement_claim_id);
			               newEntity.setProperty("emp_code", json.saia[i].emp_code);
			               newEntity.setProperty("emp_id", json.saia[i].emp_id);
			               newEntity.setProperty("invoice_code", json.saia[i].invoice_code);
			               newEntity.setProperty("id_card", json.saia[i].id_card);
			               $id("datacell1").addRow(newEntity);
			           }
			    });      
                }else{
                    alert('找不到相应的保险公司,请确保批次号输入正确或确保该批次号正走审批！');
                    var rows = $id("datacell1").getCurrentRowCount();
                    if(rows>0){
                        for(var i = 1;i<= rows;i++){
                          $id("datacell1").deleteRow();      
                          document.getElementById("total_count").value="";  
                        }
                    }    
                    jQuery("#insurance_agent_id").empty();           
                    return null;
                }
            }
        });            
        }
    }
    
    //根据保险公司添加付款单明细
    function addBatchNumList(insurance_agent_id){
        var batchNum = document.getElementById("batch_num");
        jQuery.getJSON("<venus:base/>/SettlementclaimpayAction.do?cmd=getChooseByBatchNum&randID="+escape(new Date())+"&batchNum="+batchNum.value+"&insurance_agent_id="+insurance_agent_id.value,   function(json){
           if(json.saia == null || json.saia == "" || json.total == null || json.total == ""){
              alert("没有相关数据！");
              return;
           }
           var rows = $id("datacell1").getCurrentRowCount();
            if(rows>0){
                for(var i = 1;i<= rows;i++){
                  $id("datacell1").deleteRow();      
                  document.getElementById("total_count").value="";  
                }
            }         
           document.getElementById("total_count").value=json.total;
           for(var i = 0; i < json.saia.length; i++){
               var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
               newEntity.setProperty("emp_name", json.saia[i].emp_name);
               newEntity.setProperty("account_num", json.saia[i].account_num);
               newEntity.setProperty("bank_name", json.saia[i].bank_name);
               newEntity.setProperty("amount", json.saia[i].amount);
               newEntity.setProperty("item_batch_num", json.saia[i].batch_num);
               newEntity.setProperty("settlement_claim_id", json.saia[i].settlement_claim_id);
               newEntity.setProperty("emp_code", json.saia[i].emp_code);
               newEntity.setProperty("emp_id", json.saia[i].emp_id);
               newEntity.setProperty("invoice_code", json.saia[i].invoice_code);
               newEntity.setProperty("id_card", json.saia[i].id_card);
               $id("datacell1").addRow(newEntity);
           }
    }); 
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_s">
<div id="ccChild0" class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="10%"><span class="style_required_red">* </span>付款单编号</td>
			<td class="td_2" width="20%">
				<input type="text" class="text_field" style="width: 100px;" name="sett_claim_pay_code" value="<%=claimpaycode %>" inputName="付款单编号" maxLength="64"  readonly="readonly""/>
			</td>
			<td class="td_1" width="10%"><span class="style_required_red">* </span>批次号 </td>
            <td class="td_2" width="25%">
                <input type="text" class="text_field" name="batch_num" id="batch_num" style="width: 100px;" inputName="批次号 " value="" maxLength="250" onkeydown="javascript:addInsuranList(this)"/>
            </td>
			<td class="td_1" width="10%"><span class="style_required_red">* </span>保险公司</td>
			<td class="td_2" width="25%">
                <select style="width: 100px;" name="insurance_agent_id" id="insurance_agent_id" onchange="addBatchNumList(this);"></select>
			</td>			
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>付款类型</td>
			<td class="td_2 ">
			     <d:select dictTypeId="PAY_TYPE" name="pay_type" property="bean/pay_type"  style="width: 100px;"/>
			</td>
            <td class="td_1" >本次合计</td>
            <td class="td_2"><input type="text" class="text_field" name="total_count" id="total_count" style="width: 100px;" inputName="本次合计 " value="" maxLength="250" readonly="readonly"/></td>
            <td class="td_1">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="5" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="2" name="remark" inputName="备注" maxLength="1000" ></textarea>
			</td>
		</tr>
	</table>
	</div>
	<div id="values_div"> 
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SettlementclaimpayAction.do?cmd=searchSettlementclaimpayData&payid=${bean.id}"
        submitAction="/FAERP/SettlementclaimpayAction.do?cmd=insert"
        width="98%"
        height="302px"
        xpath="SettlementclaimpayVo"
        submitXpath="SettlementclaimpayVo"
        paramFormId="datacell_formid"
        >  
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="emp_name" width="200px" label="员工姓名">
      </r:field>
      <r:field fieldName="account_num" width="200px" label="银行账号">
      </r:field>
      <r:field fieldName="bank_name" width="200px" label="开户行">
      </r:field>
      <r:field fieldName="amount" width="150px" label="金额">
      </r:field>
      <r:field fieldName="emp_code" width="100px" label="员工code">
      </r:field>
      <r:field fieldName="emp_id" width="100px" label="员工Id">
      </r:field>
      <r:field fieldName="id_card" width="0px" label="">
      </r:field>
    </r:datacell>
</div>
    <div class="mx_button" style="margin: 10px 0px 0px 10px;" align="center">
        <input type="button" class="icon_2" value='保存并提交审批' onClick="javascript:insert_onClick()" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
    </div>
</div></div>
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />
<input type="hidden" name="create_user" />
<input type="hidden" name="company_id" />
<input type="hidden" name="approval_state" />
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<script language="javascript">
jQuery(document).ready(function() {
    $id("datacell1").afterRefresh = function() {
          var total=0;
          var Me = $id("datacell1");
          var rows = Me.allTR;
          for (var i=0;i<rows.length;i++ ){
            var entity1 = Me.dataset.get(i);
            total += parseFloat(entity1.getProperty("amount"));
          }
          document.getElementById("total_count").value = total;
    }
});
</script>
