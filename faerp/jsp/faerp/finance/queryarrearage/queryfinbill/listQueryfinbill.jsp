<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page
    import="rayoo.finance.queryarrearage.queryfinbill.vo.QueryfinbillVo"%>
<%@ page
    import="rayoo.finance.queryarrearage.queryfinbill.util.IQueryfinbillConstants"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="rayoo.finance.queryarrearage.queryfinbill.queryfinbill_resource" prefix="rayoo.finance.queryarrearage.queryfinbill.">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <script language="javascript">
function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='id'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";
    }
    //魏佳新增--默认账单年月为当前日期的年月
    function setDefaultDate(iuput_id){
        var myDate = new Date();
        var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
        var month = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
        var day = myDate.getDate();         //获取当前星期X(0-6,0代表星期天)
        if(month<10){
          month = "0"+month;
        }
        if(day<10){
          day = "0"+day;
        }
        var ym = year.toString()+"-"+month.toString()+"-"+day.toString();
        $id(iuput_id).value = ym;
        _$("#"+iuput_id+"_input").val(ym);
        _$("#"+iuput_id+"_hidden").val(ym);
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
                    return false;
                }
            }
            $id("datacell1").isQueryFirst = false;
            setDefaultDate("input_date");
    });
    
    //单选
function selType(chkVal){
  if(chkVal=="1"){
   alert(chkVal);
  }else{
     alert(chkVal);
  }
}

function simpleQuery_onClick(){  //简单的模糊查询
       var billyear1=$id("bill_year_month1").value;
       var billyear2=$id("bill_year_month2").value;
       var input_date = $id("input_date").value;
         var check=/^[0-9]{4}(0[1-9])|(1[0-2])$/;
     if( (billyear1 == null || billyear1 == "") && (billyear2 == null || billyear2 == "") ){
        alert("请至少输入一个账单年月！");
        return;
     }
     if((billyear1!=null&&billyear1!="")&&(billyear2==null || billyear2=="")) {
        if(!check.test(billyear1)){
            alert("<fmt:message key='alert_billyear_error'/>");
            return;
            }
    }
    if((billyear2!=null&&billyear2!="")&&(billyear1==null || billyear1=="")) {
        if(!check.test(billyear2)){
            alert("<fmt:message key='alert_billyear_error'/>");
            return;
            }
    }
    if((billyear1!=null&&billyear1!="")&&(billyear2!=null&&billyear2!="")) {
        if(billyear1>billyear2){
        alert("<fmt:message key='alert_billyear_error_1'/>");
        return;
        }
    }
    if(input_date == null || input_date == ""){
        alert("请选择认领日期！");
        return;
    }
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").addParam("cust_name",$id("cust_name").value);
       $id("datacell1").addParam("cost_center_id",$id("cost_center_id").getValue());
       $id("datacell1").addParam("lk_cs",$id("lk_cs").getValue());
       $id("datacell1").addParam("bill_year_month1",billyear1);
       $id("datacell1").addParam("bill_year_month2",billyear2);
       $id("datacell1").addParam("bill_type_bd1",$name("bill_type_bd1").value);
           $id("datacell1").addParam("bustype_db",$name("bustype_db").value);
       
       $id("datacell1").addParam("arrearage1",$id("arrearage1").value);
       $id("datacell1").addParam("arrearage2",$id("arrearage2").value);
       $id("datacell1").addParam("input_date",$id("input_date").value);
       $id("datacell1").addParam("cust_code",$id("cust_code").value);
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
 
 
 
   function toExport_onClick(){
       var billyear1=$id("bill_year_month1").value;
       var billyear2=$id("bill_year_month2").value;
       //alert("billyear1="+billyear1+"billyear2="+billyear2);
       var custname=$id("cust_name").value;
       var costcenterid=$id("cost_center_id").getValue();
       var billtypebd=$name("bill_type_bd1").value;
       var arrearage1=$id("arrearage1").value;
       var arrearage2=$id("arrearage2").value;
       var lk_cs=$id("lk_cs").getValue();
       var cust_dept=$id("cust_dept").getValue();
     //  alert('test');
      var  bustype_db=$name("bustype_db").value;
      var  input_date=$id("input_date").value;
      if(input_date == null || input_date == ""){
        alert("请选择认领日期！");
        return;
     }
     if( (billyear1 == null || billyear1 == "") && (billyear2 == null || billyear2 == "") ){
        alert("请至少输入一个账单年月！");
        return;
     }
      ///alert('bustype_db'+bustype_db);
       $id("datacell1").addParam("arrearage2",$id("arrearage2").value);
       var url="<%=request.getContextPath()%>/QueryfinbillAction.do?cmd=exportArrearage&billyear1="+billyear1+"&billyear2="+billyear2+"&bustype_db="+bustype_db+"&custname="+ custname+"&costcenterid="+costcenterid+"&billtypebd="+billtypebd+"&arrearage1="+arrearage1;
       url=url+"&lk_cs="+lk_cs+"&cust_dept="+cust_dept+"&input_date="+input_date+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
     // alert(url);
       $id("datacell_formid").action=url;
       $id("datacell_formid").submit();
    }
</script>
    </head>
    <body>
    <form name="datacell_formid" method="post" id="datacell_formid">
    <div id="right"><script language="javascript">
    writeTableTopFesco("<fmt:message key='title_queryfinbill'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">


    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">


        <tr>
            <td width="174" rowspan="11" style="padding-top: 0;">
            <div class="search_title"><fmt:message key='title_search'/></div>
            </td>

            <td />
            <td />
            <td></td>
            <td />
        </tr>
        <tr>
            <td align="right"><fmt:message key='select_cust_name'/></td>
            <td align="left"><w:lookup readonly="true" id="lk_cust"
                lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                messagekey="select_cust_name" height="500" width="600" style="width:162px" /></td>
            <input type="hidden" name="cust_name" id="cust_name">
            </td>
            <td align="right"><fmt:message key='cost_center'/></td>
            <td align="left"><r:comboSelect id="cost_center_id"
                name="cost_center_id"
                queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                textField="cost_center_name" valueField="id" xpath="CostcenterVo"
                width="180" messagekey="please_select">
            </r:comboSelect></td>
            <td align="right"><fmt:message key='bill_year_month'/></td>
            <td align="left"><input type="text" name="bill_year_month1" id="bill_year_month1" onKeyUp="if(isNaN(value))execCommand('undo')" style="width: 82px" />－<input type="text"  onKeyUp="if(isNaN(value))execCommand('undo')"
                name="bill_year_month2" id="bill_year_month2" style="width: 82px" />
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='lk_cs'/></td>
            <td align="left">
            <!-- 
            <w:lookup readonly="true" id="lk_cs"
                name="lk_cs" lookupUrl="/CustServiceAction.do?cmd=toCustService"
                dialogTitle="选择客服" height="500" width="400" style="width:162px" />
            -->               
                                
              <r:comboSelect id="lk_cs" name="lk_cs"
                 queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                 textField="name"
                 valueField="partyId"
                 xpath="CustServiceVo"
                 width="180px"
                 messagekey="please_select" />

                </td>
            </td>
            <td align="right"><fmt:message key='cust_dept'/></td>
            <td align="left">
            <r:comboSelect id="cust_dept" name="cust_dept" queryAction="/FAERP/FinbillAction.do?cmd=getCustDeptListData"
                       textField="name" valueField="id" xpath="AupartyVO" width="180px" messagekey="please_select" />
            </td>
            <td align="right"><fmt:message key='bill_type_bd'/></td>
            <td align="left">
                            <d:select dictTypeId="FB_BILL_TYPE_BD" property="bill_type_bd1" name="bill_type_bd1"  id="bill_type_bd1" style="width:180px" nullLabel="--请选择--"/>
            </td>
        </tr>

        <tr>
            <td align="right"><fmt:message key='is_account_limit'/></td>
            <td>
            <d:select dictTypeId="TrueOrFalse" property="is_account_limit" name="is_account_limit"  id="is_account_limit" style="width:180px" nullLabel="--请选择--"/>
            </td>
            <td align="right"><fmt:message key='dates1'/></td>
            <td><input type="text" name="dates1" id="dates1" onKeyUp="if(isNaN(value))execCommand('undo')"
                style="width: 84px" />－<input type="text" name="dates2" onKeyUp="if(isNaN(value))execCommand('undo')"
                id="dates2" style="width: 84px" /></td>
            <td align="right"><fmt:message key='withinpayment'/></td>
            <td>
            <d:select dictTypeId="TrueOrFalse" property="withinpayment" name="withinpayment"  id="withinpayment" style="width:180px" nullLabel="--请选择--"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='arrearage'/></td>
            <td align="left"><input type="text" name="arrearage1"
                id="arrearage1" style="width: 84px" onKeyUp="if(isNaN(value))execCommand('undo')"/>－<input type="text"
                name="arrearage2" id="arrearage2" style="width: 84px" onKeyUp="if(isNaN(value))execCommand('undo')"/></td>
            <td ><fmt:message key='bustype_db'/></td>
            <td >                          <d:select dictTypeId="BUSTYPE_DB" property="bustype_db" name="bustype_db"  id="bustype_db" style="width:180px" nullLabel="--请选择--"/>
    </td>
            <td align="right">认领日期</td>
            <td align="left">
            <w:date format="yyyy-MM-dd" name="input_date" width="163px" id="input_date"/>
            </td>
        </tr>
        <tr>
	        <td align="right">客户编号</td>
            <td align="left">
                <input type="text" name="cust_code" id="cust_code" style="width: 180px;" />
            </td>
	        <td/>
	        <td/>
	        <td/>
            <td><input name="button_ok" class="icon_1" type="button"
                value='<fmt:message key="query"/>'
                onClick="javascript:simpleQuery_onClick()"> <input
                name="button_reset" class="icon_1" type="button"
                value='<fmt:message key="reset"/>'
                onClick="javascript:this.form.reset()"></td>
            <td />
        </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <!--<ul>
        <li class="e_3"><a onClick="javascript:toExport_onClick();">导出
        </a></li>
    </ul>
-->
<input class="e_3" type="button"   value="<fmt:message key='button_export'/>"  <au:authorityBtn code="qkcx_exp" type="1"/>  onClick="toExport_onClick();">
    </div>
    <div class="clear"></div>
    </div>
    <div style="padding: 5 0 0 5;" >
    <r:datacell id="datacell1"
        queryAction="/FAERP/QueryfinbillAction.do?cmd=queryArrearage"
        isCount="false" width="99%" xpath="QueryfinbillVo" readonly="true"
        paramFormId="datacell_formid" height="318px">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
  
        <r:field fieldName="cust_code" width="80px" messagekey="cust_code">
        </r:field>
        
        <r:field fieldName="cust_name" width="200px" messagekey="cust_name">
        </r:field>
        <r:field fieldName="cost_center_name" width="200px" messagekey="cost_center">
        </r:field>
              <r:field fieldName="bill_code" width="80px" messagekey="bill_code">
        </r:field>
        <r:field fieldName="bill_year_month" width="80px" label="账单年月">
        </r:field>
        <r:field fieldName="ys_date" width="80px" label="应收日期">
            <w:date format="yyyy-MM-dd"/>
        </r:field>
        <r:field fieldName="paymentdays" width="80px" messagekey="paymentdays">
        </r:field>
        <r:field fieldName="debt_days" width="80px" label="欠款天数">
        </r:field>
        <r:field fieldName="bill_amount" width="80px" messagekey="bill_amount">
        </r:field>
        <r:field fieldName="verification_amount" width="80px" messagekey="verification_amount">
        </r:field>
        <r:field fieldName="rate_odds" width="80px" messagekey="rate_odds">
        </r:field>
        <r:field fieldName="rate_amount" width="80px" messagekey="rate_amount">
        </r:field>
        <r:field fieldName="arrearage" width="80px" messagekey="arrearage">
        </r:field>
        <r:field fieldName="debt_property" width="80px" label="欠款性质">
        </r:field>
        <r:field fieldName="debt_in_payment" width="80px" label="账期内欠款">
        </r:field>
        <r:field fieldName="debt_out_payment" width="80px" label="账期外欠款">
        </r:field>
        <r:field fieldName="bill_type_bd" width="100px" messagekey="bill_type_bd">
            <d:select dictTypeId="FB_BILL_TYPE_BD" id="bill_type_bd"
                name="bill_type_bd" />
        </r:field>
           <r:field fieldName="bustype_db" width="100px" messagekey="bustype_db">
            <d:select dictTypeId="BUSTYPE_DB" id="bustype_db"
                name="bustype_db" />
        </r:field>
        <r:field fieldName="user_name" width="80px" messagekey="user_name">
        </r:field>
        <r:field fieldName="deptname" width="80px" messagekey="cust_dept">
        </r:field>
        <r:field fieldName="create_user_name" width="100px" label="账单生成人">
        </r:field>
        <r:field fieldName="last_update_date" width="130px" label="账单生成时间">
        <w:date format="yyyy-MM-dd HH:mm:ss" />
        </r:field>

    </r:datacell>
    </div>
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
    if(request.getAttribute(IQueryfinbillConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IQueryfinbillConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>
