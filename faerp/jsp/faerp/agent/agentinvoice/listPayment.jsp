<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key="referto_page"/></title>
	<script language="javascript">
	 function setCheckbox(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + escape(entity.getProperty("agent_name")) + "\",\"" + escape(entity.getProperty("agent_code")) + "\");>";
     }
    function ClickRow(id,agentname,agentcode){
    document.getElementById("tid").value=id;
    document.getElementById("agentname").value=unescape(agentname);
    document.getElementById("agentcode").value=unescape(agentcode);
    }

    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
        function select_onClick(){
        entity=choose_row("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("payment_purpose");
        window.returnValue=returnAry;
        window.close();

    }
	
	
	    function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("<fmt:message key="select_one_record"/>");
           return;
        }
     return obj;
    }
</script>
	</head>
	<body>

	<form name="form" method="post"  id="datacell_formid">
	
	<div id="right">
	<div id="ccChild0" class="search">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td  rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            </td>
        </tr>
        <tr>
        <td align="right">申请付款金额</td>
          <td align="left"><input type="text" class="text_field" name="apply_amount_from" inputName="申请付款金额" maxLength="50" value="" style="width:80px"/>&nbsp;至&nbsp;<input type="text" class="text_field" name="apply_amount_to" inputName="申请付款金额" maxLength="50" value="" style="width:80px"/></td>
       <td align="left">  <input name="button_ok" class="icon_1"  type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()"></td>
         </tr>
       <tr>
        <td align="right">申请日期</td>
            <td align="left"><w:date format="yyyy-MM-dd" id="apply_date_from" name="apply_date_from" width="70px"/>至<w:date format="yyyy-MM-dd" id="apply_date_to" name="apply_date_to" width="70px"/></td>
       <td align="left"><input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()"></td>
       </tr>
   
    </table>
	</div>
	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="confirm" /> </a></li>
	</ul>
	</div>
	<div class="clear"></div>
	</div>
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/AgentInvoiceAction.do?cmd=searchAgentpayment&agent_id=${agent_id }" 
        width="98%"
        height="318px"
        xpath="FinpaymentVo"
        readonly="true"
        >
          <r:field fieldName="payment_purpose" label="付费用途" width="200px">
  
      </r:field>       
      
        <r:field fieldName="customer_name" label="客户名称" width="200px"></r:field>
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="receiver_type_bd" label="受款方类型">
      <d:select dictTypeId="RECEIVER_TYPE_BD"></d:select>
      </r:field>
      <r:field fieldName="receiver_name" label="受款方名称">
        
      </r:field>
      <r:field fieldName="payment_type_bd" label="付款类型" >
        <d:select dictTypeId="PAYMENT_TYPE_BD"></d:select>
      </r:field>
      <r:field fieldName="apply_amount" label="申请付款金额" >
        
      </r:field>
      <r:field fieldName="applyusername" label="申请人" >
       <h:text/>
      </r:field>
      <r:field fieldName="apply_date" label="申请日期" >
        <w:date format="yyyy-MM-dd"/>
      </r:field>  
      
            <r:field fieldName="payment_desc" label="备注"  width="200px">
       
      </r:field> 
    </r:datacell>
    
	</div>
	</form>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>
<script type="text/javascript">
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>
