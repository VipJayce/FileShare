<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%@include file="/common/skins/skin0/component.jsp" %>
<%@include file="/jsp/faerp/finance/common.jsp" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <h:script src="/js/jquery/jquery-1.7.2.min.js"/>
    <script type="text/javascript">
        var _jQuery = window.jQuery, _$ = window.$;
        jQuery.noConflict();
        _$(document).ready(function(){
            if ("add" == "${param.op}") {
                _$.post("<%=request.getContextPath()%>/IndustryTypeAction.do", {"cmd": "obtainCode"}, function (data) {
                    if (!!data) {
                        _$("#industry_code").html(data);
                    }
                });
            }
            _$("#btnSave").click(function () {
                var $industryTypeBDValue =_$("#industry_type_bd").val();
                var $industryNameValue =_$("#industry_name").val();
                if ($industryTypeBDValue == '') {
                    alert("请输入行业类型。");
                    return;
                }
                if ($industryNameValue == '') {
                    alert("请输入行业名称。");
                    return;
                }
                var data = {
                    "cmd" : "setData",
                    "op":"${param.op}",
                    "id" : _$("#industryId").val(),
                    "industry_type_bd" : $industryTypeBDValue,
                    "industry_code" : _$("#industry_code").html(),
                    "industry_name" : $industryNameValue
                };
                _$.post("<%=request.getContextPath()%>/IndustryTypeAction.do", data, function(data){
                    if (!!data) {
                        alert(data);
                        window.close();
                    }
                });
            });
            _$("#btnClose").click(function () {
                window.close();
            });
        });
    </script>
    <title>codegen</title>
</head>
<body>
<div class="ringht_x">
    <div id="ccChild0" class="box_3">
        <input type="hidden" id="industryId" value="${industryType.id}"/>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#c5dbe2" style="font-size:12px;font-family: 'Microsoft YaHei';">
            <tr>
                <td class="td_1">行业编号</td>
                <td class="td_2">
                    <label class="text_field" id="industry_code">${industryType.industry_code}</label>
                </td>
                <td class="td_1">行业类别</td>
                <td class="td_2">
                    <input class="text_field" id="industry_type_bd" inputName="行业类别" maxLength="50" value="${industryType.industry_type_bd}"/>
                </td>
            </tr>
            <tr>
                <td class="td_1">行业名称</td>
                <td class="td_2" colspan="3">
                    <input class="text_field" id="industry_name" inputName="行业名称" maxLength="50" value="${industryType.industry_name}"/>
                </td>
            </tr>
        </table>
        <div class="foot_button">
            <input type="submit" class="foot_icon_1" value="保存" id="btnSave"/>
            <input type="button" class="foot_icon_1" value="关闭" id="btnClose"/>
        </div>
    </div>
</div>
</fmt:bundle>
</body>
</html>
