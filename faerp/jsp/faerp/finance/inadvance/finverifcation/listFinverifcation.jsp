<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.inadvance.finverifcation.util.IFinverifcationConstants" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<html>
<fmt:bundle basename="rayoo.finance.receivable.finclaim.finclaim_resource" prefix="rayoo.finance.receivable.finclaim.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
  
    function showListData(){  //简单的模糊查询
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
 _$(document).ready(function() {
            if ($id("lk_cust")) {
                $id("lk_cust").onReturnFunc = function (returnValue){
                    var lookup = $id("lk_cust");
                    lookup.value = returnValue[0];
                    _$("#cust_name").val(returnValue[2]);
                    lookup.displayValue = returnValue[2];
                    $id("cost_center_id").addParam("cust_id", returnValue[0]);
                    $id("cost_center_id").loadData();
                    $id("cost_center_id").refresh();
                    showListData();
                    return false;
                }
            }
            $id("datacell1").isQueryFirst = false;
            $id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
            doChoose();
            }
    });
    
    
    //2014-6-30 yangyuting start 
        function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("used_verid") + "\",\"" + entity.getProperty("id") + "\");>";
    }
   function ClickRow(vid,inc_code){
 //alert("used_verid:"+tid);
  // alert("id:"+inc_code);
   
          //$id("tid").value = tid+"";
          $id("celllist1").addParam("verification_id",vid); //2014-7-18 yangyuting 
          $id("celllist1").loadData();
         $id("celllist1").refresh();
    }
    //查询数据
    function showListData(){
        var checked=jQuery('input:radio[name="used_verid"]:checked').val(); 
        $id("datacell1").addParam("used_verid",checked);
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    //2014-6-30 yangyuting end   
</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid">
<div id="right">
<script language="javascript">
    if (${ver != null && ver != ""}) {
        writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
    } else {
    }
    
</script>
<div id="right">
    <script language="javascript">
        //writeTableTopFesco('预收查询','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='select_cust'/></td>
                <td align="left"><w:lookup readonly="true" id="lk_cust"
                    lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                    messagekey="select_cust" height="500" width="600" /></td>
                     <input type="hidden" name="cust_name" id="cust_name">
                </td>
                <td align="right"><fmt:message key='cost_center'/></td>
            <td align="left">
            <r:comboSelect id="cost_center_id" name="cost_center_id"
               queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                textField="cost_center_name"
                valueField="id"
                xpath="CostcenterVo"
                width="180" messagekey="please_select">
            </r:comboSelect>
           </td>
            <td/>
            <td/>
              <td><input type="radio" name="used_verid" id="used_verid"  value="1" >已使用&nbsp;<input type="radio"  name="used_verid" id="used_verid"  value="0" checked="checked" >未使用</</td>
                <td/><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="button_query"/>' onClick="javascript:showListData()">
                <input name="button_ok2" class="icon_1"   type="reset" value='<fmt:message key="button_reset"/>' >
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
          <div class="clear"></div>         
</div>
    <div style="padding: 8 0 8 8;">
    <r:datacell id="datacell1"
            queryAction="/FAERP/FinverifcationAction.do?cmd=queryAll1" 
            isCount="false"
            width="99%" 
            xpath="FinverifcationVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="320px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
               <r:field fieldName="emp" label="操作" width="50px" align="center" onRefreshFunc="setCheckboxStatus" >
            </r:field> 
            <r:field fieldName="cust_code" width="75px" messagekey="cust_code">
            </r:field>
            <r:field fieldName="cust_name" width="165px" messagekey="cust_name">
            </r:field>
            <r:field fieldName="cost_center_name" width="165px" messagekey="cost_center_name">
            </r:field>
            <r:field fieldName="inc_code" width="95px" messagekey="inc_code" >
            </r:field>
            <r:field fieldName="inc_date" width="95px" messagekey="intoinc_date" allowModify="false">
                <w:date format="yyyy-MM-dd"/>
            </r:field>
            <!-- 
            <r:field fieldName="bill_type_bd" width="100px" label="应收类型">
          <d:select  dictTypeId="FB_BILL_TYPE_BD" id="bill_type_bd" name="bill_type_bd" />
            </r:field>
             -->
            <r:field fieldName="inc_amout" width="75px" messagekey="into_amout" >
            </r:field>
            <r:field fieldName="ver_amount" width="75px" messagekey="table1_1" ><!-- 准确说法应该是核销金额 -->
            </r:field>
              <r:field fieldName="balance" width="75px" messagekey="balance" >
            </r:field>
             <r:field fieldName="create_date" width="130px" label="认领时间"  allowModify="false">
             <w:date format="yyyy-MM-dd HH:mm:ss"/>
            </r:field>
        </r:datacell>
        </div>
        <!-- 2014-6-27 yangyuting  -->
     <table cellpadding="0" style="padding: 8 0 8 8;" border="0" width="99%">
    <tr>
        <td valign="top" width="70%">
            
                    <r:datacell 
                        id="celllist1"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/FININCOMINGAction.do?cmd=getFinverificationByVerificationID"
                        width="100%" height="250px"
                        xpath="FinverificationVo"
                        readonly="true"
                        >
                
                      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                      <r:field fieldName="cust_code" label="客户编号" width="70px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="cust_name" label="客户名称" width="190px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="cost_center_name" label="成本中心" width="190px">
                        <h:text/>
                      </r:field>        
                      <r:field fieldName="create_date" label="认领日期" width="90px">
                        <w:date format="yyyy-MM-dd"/>
                      </r:field>
                      <r:field fieldName="ver_amount" label="核销金额" width="90px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="balance_amount" label="预收金额" width="70px">
                        <h:text/>
                      </r:field>
                       <r:field fieldName="create_user_id" label="认领人" width="70px">
                        <h:text/>
                      </r:field>                     
                      <r:field fieldName="bill_type_bd" label="应收类型" width="90px">
                        <d:select dictTypeId="BILL_TYPE_BD"/>
                      </r:field>
                      <r:field fieldName="bill_year_month" label="应收年月" width="70px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="bill_amount" label="应收金额" width="90px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="ver_invoice_status_bd" label="开票状态" width="90px">
                        <d:select dictTypeId="INVOICE_STATUS_BD"/>
                      </r:field>
                    </r:datacell>
        </td>
     </tr>
   </table>
        
       
</div>
</div>
</form>
</fmt:bundle>
<c:if test="${ver != null && ver != '' }">
    <div class="foot_button">
        <input type="button" onclick="closewin();" value="<fmt:message key='button_close'/>" class="foot_icon_1">
    </div>
</c:if>




<script language="javascript">
    writeTableBottomFesco("<fmt:message key='title_finclaim_search'/>",'<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(IFinverifcationConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IFinverifcationConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
<script>
/*
_$(document).ready(function() {
    $id("lk_cust").onReturnFunc = function (returnValue){
        var lookup = $id("lk_cust");
        lookup.value = returnValue[0];
        _$("#cust_name").val(returnValue[2]);
        lookup.displayValue = returnValue[2];
        return false;
    }
    
    $id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
        doChoose();
    }
    
});
*/

function selectEntity() {
    var dc = $id("datacell1");
    var entity = dc.getActiveEntity();
    return entity;
}



/**
 * 关闭按钮，把产生预收的到款ID传到认领页面
 */
function doChoose() {
    var entity = selectEntity();
    var inc_id = entity.getValue("incoming_id");
    var cust_id = entity.getValue("cust_id");
    var cost_center_id = entity.getValue("cost_center_id");
    var inc_code = entity.getValue("inc_code");
    var returnValue = new Array();
    returnValue[0] = inc_id;
    returnValue[1] = cust_id;
    returnValue[2] = cost_center_id;
    returnValue[3] = inc_code;
    window['returnValue']= returnValue;
    window.close();
}
</script>
