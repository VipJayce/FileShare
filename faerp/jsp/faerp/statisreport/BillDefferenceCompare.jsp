<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>
<html>
<%
String login_user_id= RmJspHelper.getParty_idFromRequest(request);
//String login_user_name="";
//LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
//if(null!=loginVo){
    //login_user_name=loginVo.getName();
  //}
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账单差异对比报表</title>

<script language="javascript">
    function exportEXCEL_onClick(){
         var frm = $id("datacell_formid");
      //表单验证
      if( !checkForm(frm) ) {
          return;
      }
        
        var costcenter = document.getElementById("cost_center_id").value;
        var bill_yearmonth = document.getElementById("bill_yearmonth").value;
        var sal_show = document.getElementById("sal_show").value;//是否显示工资
        var raqName;
        if(sal_show == 0){
            raqName = "bill_difference_no_sal.raq";
        }else if(sal_show == 1){
            raqName = "bill_difference.raq";
        }
        
        var url="";
        
        if(costcenter==null || costcenter==""){
            alert("成本中心不能为空！");
            return;
        }
                
        if(bill_yearmonth==null || bill_yearmonth==""){
            alert("账单年月不能为空！");
            return;
        }
        
        url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillDifference.jsp?raq="+raqName+"&costcenter="+costcenter+"&bill_yearmonth="+bill_yearmonth+"&login_userid=<%=login_user_id%>";

        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
        
    }
    
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
       writeTableTopFesco('账单差异对比报表','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title">报表</div>
            <!--表格1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td  class="td_1">选择客户</td>
                    <td  class="td_2">
                        <w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust"
                        lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" style="width:165px"
                        dialogTitle="选择客户" height="450" width="610" /> 
                        <input id="cust_id" name="cust_id" type="hidden" />
                    </td>
                    <td  class="td_1">客户成本中心</td>
                      <td class="td_2">
                      <r:comboSelect id="cost_center_id"
			            name="cost_center_id"  
			            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
			            width="180" >
                     </r:comboSelect>
                     </td>
                  </tr>
                  <tr>
                    <td class="td_1">账单年月</td>
                    <td class="td_2">
                     <!--  <input type="text" class="text_field" id="bill_yearmonth" name="bill_yearmonth" inputName="账单年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/> -->
                     <h:text id="bill_yearmonth" name="bill_yearmonth"  style="width=180px" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/> (格式YYYYMM)<span  style="color:red;font-size:1.1em"></span>
                    </td>
                    <td class="td_1">是否显示工资</td>
                    <td class="td_2">
                        <select id="sal_show" style="width: 180px;">
                            <option value="1">是</option>
                            <option value="0">否</option>
                        </select>
                    </td>
                </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();">导出报表</a>
            </div>
            <!--表格1 end--></div>
            </td>
        </tr>
    </table>
    </form>
</body>

</html>
<script language="javascript">
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
    _$("#cust_id").val(returnValue[0]);
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}
</script>