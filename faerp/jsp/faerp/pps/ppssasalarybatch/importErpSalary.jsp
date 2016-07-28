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
<html>
<fmt:bundle basename="rayoo.ibd.ibdcredentialstep.ibdcredentialstep_resource" prefix="rayoo.ibd.ibdcredentialstep.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>codegen</title>
  <script language="javascript">
    function insert_onClick(){  //插入单条数据
        var batchId = jQuery("#batchId").val();
        var pay_year_month = jQuery("#pay_year_month").val();
        var pay_name = jQuery("#pay_name").val();
        var bill_year_month = jQuery("#bill_year_month").val();
        var tax_month = jQuery("#tax_month").val();
        
        if (!pay_name){
            alert("请输入发放名称");
            return false;
        }
        if (!pay_year_month){
            alert("请输入应发年月");
            return false;
        }else{
            if (!checkyearmonth(pay_year_month)){
                alert("请正确输入应发年月，如201401");
                return false;
            }
        }
        if (!bill_year_month){
            alert("请输入账单年月");
            return false;
        }else{
            if (!checkyearmonth(bill_year_month)){
                alert("请正确输入账单年月，如201401");
                return false;
            }
        }
        if (!tax_month){
            alert("请输入计税年月");
            return false;
        }else{
            if (!checkyearmonth(tax_month)){
                alert("请正确输入计税年月，如201401");
                return false;
            }
        }
        
        jQuery("#import_button").attr('disabled', 'disabled');
        url = encodeURI("<%=request.getContextPath()%>/PpssasalarybatchAction.do?cmd=importErpSalary" 
          + "&batchId=" + batchId
          + "&pay_year_month=" + pay_year_month
          + "&pay_name=" + pay_name
          + "&bill_year_month=" + bill_year_month
          + "&tax_month=" + tax_month);

       jQuery.post(url,function(msg){
            alert(msg);
            jQuery("#import_button").removeAttr('disabled');
            window.close();
       });
    }

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function checkyearmonth(yearmonth){
        var re=/^[12]\d{3}(0\d|1[0-2])$/; 
        return re.test(yearmonth);
    }
    
</script>
  </head>
  <body>
  <form name="form" method="post" id="datacell_formid">
    <input type="hidden" id="id" name="id" value="${bean.id }">
    <div id="right">
      <div class="ringht">
        <div id="ccChild1"     class="box_xinzeng"  style="height: 150px">
          <table  width="100%" height="100" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
            <tr>
              <td class="td_1" style="width: 135px;"><span class="style_required_red">* </span>发放名称</td>
              <td align="left" class="td_2">
                <input type="text" name="pay_name" id="pay_name" value="${bean.cust_name}${bean.pay_year_month}">
                <input type="hidden" name="batchId" id="batchId" value="${batchId}">
              </td>
            </tr>
            <tr>
              <td class="td_1" style="width: 135px;"><span class="style_required_red">* </span>应发年月</td>
              <td align="left" class="td_2">
                <input type="text" name="pay_year_month" id="pay_year_month" value="${bean.pay_year_month}">(201301)
              </td>
            </tr>
            <tr>
              <td class="td_1" style="width: 135px;"><span class="style_required_red">* </span>账单年月</td>
              <td align="left" class="td_2">
                <input type="text" name="bill_year_month" id="bill_year_month" value="${bean.pay_year_month}">(201301)
              </td>
            </tr>
            <tr>
              <td class="td_1" style="width: 135px;"><span class="style_required_red">* </span>计税年月</td>
              <td align="left" class="td_2">
                <input type="text" name="tax_month" id="tax_month" value="${bean.pay_year_month}">(201301)
              </td>
            </tr>
          </table>
        </div>
        <div class="foot_button" >
          <input id="import_button" type="button" class="icon_2" value='导入' onClick="javascript:insert_onClick()" />
          <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
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
</script>
