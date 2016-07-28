<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%@include file="/common/skins/skin0/component.jsp" %>
<%@include file="/jsp/faerp/finance/common.jsp" %>
<html>
<head>
    <title>提示</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <h:script src="/js/jquery/jquery-1.7.2.min.js"/>
    <script type="text/javascript">
        var _jQuery = window.jQuery, _$ = window.$;
        jQuery.noConflict();
        function sendSubmit(type) {
            var returnAry = new Array(1);
            if (1 == type) {
                var cost_center_id = $id("cost_center_id").getValue();
                returnAry[0] = cost_center_id;
            } else {
                returnAry[0] = '';
            }
            window.returnValue = returnAry;
            window.close();
        }
    </script>
</head>
<body style="font-size:12px;">
<div class="dialog_div" style="width:350px;height:200px;position:static;border:0px;">
    <div class="dialog_div_title" style="font-size:16px;">发票类型<c:if test="${param.show_cost != 1}">和成本中心</c:if>选择</div>
    <div class="dialog_div_body">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="font-size:12px;color:#0a246a;">
            <tr <c:if test="${param.show_cost == 1}">style="display: none;"</c:if>>
                <td style="height: 50px;">请选择成本中心：</td>
                <td>
                    <r:comboSelect id="cost_center_id" name="cost_center_id"
                                   queryAction="/FAERP/FinverificationAction.do?cmd=getCostCenterByBillID&bill_id=${param.bill_id}"
                                   textField="cost_center_name" valueField="id" xpath="CostcenterVo"
                                   width="230" messagekey="please_select">
                    </r:comboSelect>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <input type="button" class="icon_1" value="确定" onclick="sendSubmit(1);"/>
        <input type="button" class="icon_1" value="取消" onclick="sendSubmit(0);"/>
    </div>
    <br/>
</div>
</body>
</html>
