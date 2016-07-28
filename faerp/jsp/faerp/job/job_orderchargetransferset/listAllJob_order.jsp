<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>

    <title>选择员工</title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("order_name");
            returnAry[2] = entity.getProperty("order_code");
        window.returnValue = returnAry;
        window.close();

    }
        //客户参照
    function rtnFunc(arg){
    var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }
        //合同参照
    function toFindContract(arg){
        var lookup = $id("lk_contract");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#contract_id").val(arg[0]);       
        return false;
    }

    function simpleQuery_onClick(){  //简单的模糊查询
  
          $id("celllist1").loadData();
          $id("celllist1").refresh();
    }
    
    function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
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
       <div id="right">
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
            <td align="left">关联合同</td>
            <td align="left">
                <input type="hidden" name="contract_id" id="contract_id" />
                <w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract" 
                    lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="444" width="764" /> 
            </td>
             <td align="left">订单状态</td>
            <td align="left">
                 <d:select dictTypeId="ORDER_STATUS_BD" id="order_status" name="order_status" nullLabel="--请选择--"></d:select>
            </td>
          
        </tr>
        <tr>
          <td align="left">客户名称</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" readonly="false" displayValue="" id="lk_cust" 
                                   lookupUrl="/JcustomerAction.do?cmd=getJCustRef" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
                <input type="hidden" name="cust_id" id="cust_id">
            </td>
            <td align="left">订单编号</td>
            <td align="left">
                <input type="text" class="text_field" id="order_code" name="order_code" inputName="订单编号" maxLength="100"/>
            </td>
       
        </tr>
        <tr>
        <td></td>
        <td></td>
             <td align="left" colspan="2">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
                </td>
            <td align="left"></td>
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
         <div  id="div1" style="margin:5 0 0 10px;">
           
<r:datacell id="celllist1" queryAction="/FAERP/Job_orderAction.do?cmd=simpleQuery" width="98%" height="318px" xpath="Job_orderVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="order_code" label="订单编号" width="250px" ></r:field>    
 <r:field fieldName="order_name" label="订单名称" width="110px"></r:field>
 <r:field fieldName="contract_name" label="关联合同" allowModify="false" width="110px"></r:field>
 <r:field fieldName="customer_name" label="客户" allowModify="false" width="110px"></r:field>
 <r:field fieldName="warranty" label="担保期" allowModify="false" width="110px"></r:field>
 <r:field fieldName="order_status" label="订单状态" allowModify="false" width="110px">
    <d:select dictTypeId="ORDER_STATUS_BD"></d:select>
 </r:field>
 <r:field fieldName="create_user_name" label="录入人" width="110px"></r:field>
 <r:field fieldName="create_date" label="录入时间" allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
 </r:datacell>
            </div>
            </div>
            </div>
            
    </form>
</fmt:bundle>

</body>
</html>
<script type="text/javascript">
$id("celllist1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
	select_onClick();
}
</script>
