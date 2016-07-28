<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择认领</title>
    <script language="javascript">
    
       //选择一条记录
        function select_onClick(){
            var entity=choose_row("celllist1");
            if(entity.getProperty("approval_status") == "申请中"){
                //如果为审批中则不让选择‘
                alert("该笔核销正在进行取消审批，请耐心等待！");
                return;
            }
            var returnAry = new Array();
                //返回选择的认领
            returnAry[0] = _$("#incomingid").val();//到款id
            returnAry[1] = entity.getProperty("id");//认领id
            returnAry[2] = entity.getProperty("ver_id");//核销id
            returnAry[3] = entity.getProperty("bill_id");//账单id
            returnAry[4] = entity.getProperty("inc_code");//到款编号
            window['returnValue'] =  returnAry;
            window.close();
        }
        
        //返回选择的记录
        function choose_row(dcId){
            var dc = $id(dcId);
            var obj = dc.getActiveEntity();
                if(!obj){
                   alert("请选择一条记录！");
                   return;
                }
             return obj;
        }
    </script>
</head>
<body>
   <form name="form" method="post"  id="datacell_formid">
    <input type="hidden" id="incomingid" value="${incomingid}">
    <div id="ccParent1" class="button">
        <div class="button_right">
            <ul>
                <li class="g"><a onClick="javascript:select_onClick();">确定</a></li>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    <div  id="div1" style="margin:5 0 0 10px;">
              <r:datacell 
	              queryAction="/FAERP/FinclaimAction.do?cmd=searchClaim&incomingid=${incomingid}"
	              id="celllist1"
	              paramFormId="datacell_formid" 
	              width="97%" height="305px" 
	              xpath="ClaimSelectVo"
	              readonly="true"
	              >
	                <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	                <r:field fieldName="id" label="认领id" width="0px">
	                </r:field>
	                <r:field fieldName="ver_id" label="核销id" width="0px">
                    </r:field>
	                <r:field fieldName="inc_code" label="到款编号" width="100px">
	                </r:field>
	                <r:field fieldName="inc_cust_name" label="到款客户" width="100px">
	                </r:field>
	                <r:field fieldName="inc_amout" label="到款金额" width="100px">
	                </r:field>
	                <r:field fieldName="name" label="认领人" width="100px">
	                </r:field>
	                <r:field fieldName="claim_amount" label="认领金额" width="100px">
	                </r:field>
	                <r:field fieldName="approval_status" label="取消认领状态" width="100px">
	                </r:field>
	                <r:field fieldName="bill_year_month" label="账单年月" width="100px">
                    </r:field>
                    <r:field fieldName="cust_code" label="客户编码" width="100px">
                    </r:field>
                    <r:field fieldName="cust_name" label="客户名称" width="150px">
                    </r:field>
                    <r:field fieldName="cost_center_name" label="成本中心名称" width="150px">
                    </r:field>
                    <r:field fieldName="ver_amount" label="核销金额" width="100px">
                    </r:field>
                    <r:field fieldName="bill_id" label="账单id" width="0px">
                    </r:field>
            </r:datacell>
   </div>
</form>
</body>
</html>
<script type="text/javascript">
$id("celllist1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>
