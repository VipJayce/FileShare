<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.bill.salarybatch.salarybatch_resource" prefix="rayoo.finance.bill.salarybatch.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title><fmt:message key='ibd_bill'/></title>
  <script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    //生成账单
    function generatebill_onClick(){
      if(checkAllForms()){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(!ids || ids.length==0){
            alert("<fmt:message key='alert_ibd_select_item'/>");
            return;
        }
        jq("#ids").val(ids);
        
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
        var ibdRepeatFlag = jq("#ibdRepeatFlag", window.opener.document).val();
        jq("#ibdRepeatFlag").val(ibdRepeatFlag);
        
        var form = jQuery("#form4datacell_cp");
        var url ="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=ibdGenerateBill&r="+ Math.random();
        
        jq.ajax({
            cache: true,
            type: "POST",
            url:url,
            data:"contract_id="+contract_id +
                 "&bill_year_month="+bill_year_month +
                 "&cust_id="+cust_id +
                 "&cost_center_id="+cost_center_id +
                 "&bill_type_bd="+bill_type_bd +
                 "&ibdRepeatFlag="+ibdRepeatFlag +
                 "&ids="+ids,
            async: false,
            error: function(request) {
                alert("Connection error");
            },
            success: function(data) {
                if (data == "1"){
                    alert("<fmt:message key='alert_ibd_rs_1'/>");
                }else if (data == "0"){
                    alert("<fmt:message key='alert_ibd_rs_0'/>");
                }else if (data == "-1"){
                    alert("<fmt:message key='alert_ibd_rs_-1'/>");
                }else if(data == "2"){
                    alert("<fmt:message key='alert_ibd_rs_2'/>");
                }
                cancel_onClick();
            }
        });
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
    </script>
  </head>
  <body>
  <form action="" id="form4datacell_cp">
    <input type="hidden" id="contract_id" name="contract_id">
    <input type="hidden" id="bill_year_month" name="bill_year_month">
    <input type="hidden" id="cust_id" name="cust_id">
    <input type="hidden" id="cost_center_id" name="cost_center_id">
    <input type="hidden" id="bill_type_bd" name="bill_type_bd">
    <input type="hidden" id="ids" name="ids">
  </form>
  <div id="right">
    <div class="ringht">
      <div id="ccChild1" class="box_xinzeng" style="height: 30px">
        <input id="update_button" type="button" class="icon_2" value='<fmt:message key="button_generatebill"/>' onClick="javascript:generatebill_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="button_go_back"/>' onClick="javascript:cancel_onClick()" />
      </div>
      <div id="s_p_list_div" style="">
        <div style="padding: 8 10 8 8;">
          <div class="xz_title" style="padding-top: 10px"><fmt:message key="title_item_select"/></div>
          <r:datacell id="datacell_cp"
        queryAction="/FAERP/IbdContractProductEmpAction.do?cmd=queryProductItem&contractId=${param.contract_id}"
        width="99%" height="200px"
        xpath="Finout_contract_productVo" paramFormId="form4datacell_cp"
        submitXpath="Finout_contract_productVo">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="product_id" messagekey="ibd_operation" width="100px" onRefreshFunc="setCheckboxStatus" align="center">
            </r:field>
            <r:field fieldName="product_name" messagekey="ibd_item_name" width="200px"> </r:field>
            <r:field fieldName="rate" messagekey="ibd_rate" width="100px">
              <d:select dictTypeId="FINOUT_PRODUCT_TYPE" disabled="true" />
            </r:field>
            <r:field fieldName="exp_date" messagekey="ibd_type" width="100px"></r:field>
            <r:field fieldName="product_price" messagekey="ibd_price" width="100px"></r:field>
            <r:field fieldName="o_remark" messagekey="ibd_remark" width="200px">
              <h:text validateAttr="maxLength=100;" />
            </r:field>
          </r:datacell>
        </div>
      </div>
    </div>
  </div>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">
function setCheckboxStatus(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='checkbox_template' value='"+value+"' is_use='" + entity.getValue("is_use") + "'>";
}
</script>
