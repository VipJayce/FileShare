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
                _$.post("<%=request.getContextPath()%>/IndustryInjuryRatesAction.do", {"cmd": "obtainMaxCode"}, function (data) {
                    if (!!data) {
                        _$("#injury_code").html(data);
                    }
                });
            } else {
                var startValue="${industryInjuryRatesVo.valid_start_yearmonth}";
                var endValue="${industryInjuryRatesVo.valid_end_yearmonth}";
                _$("#valid_start_yearmonth_input").val(completionDate(startValue));
                _$("#valid_end_yearmonth_input").val(completionDate(endValue))
            }
            _$("#btnSave").click(function () {
                var $industryIdValue =_$("#industry_id_hidden").val();
                var $injuryBaseRatesValue = _$("#injury_base_rates").val();
                var $validStartYMValue = _$("#valid_start_yearmonth_input").val();
                var $validEndYMValue = _$("#valid_end_yearmonth_input").val();
                if ($industryIdValue == '') {
                    alert("请选择行业类别。");
                    return;
                }
                if ($injuryBaseRatesValue == '') {
                    alert("请输入基础费率。");
                    return;
                }
                if ($validStartYMValue == '') {
                    alert("请输入有效的起始年月。");
                    return;
                }
                if (!validateNumber($injuryBaseRatesValue)) {
                    alert("基础费率只能输入数字和小数点。");
                    return;
                }
                if ($validEndYMValue != '') {
                    $validEndYMValue = formatDate($validEndYMValue);
                }
                var data = {
                    "cmd" : "setData",
                    "op": "${param.op}",
                    "id" : _$("#industryInjuryRatesId").val(),
                    "injury_code" : _$("#injury_code").html(),
                    "industry_id" : $industryIdValue,
                    "injury_base_rates" : $injuryBaseRatesValue,
                    "valid_start_yearmonth" : formatDate($validStartYMValue),
                    "valid_end_yearmonth" : $validEndYMValue
                };
                _$.post("<%=request.getContextPath()%>/IndustryInjuryRatesAction.do", data, function(data){
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

        function completionDate(val) {
            if (!!val) {
                return val.substr(0,4)+'-'+val.substr(4,2) + '-01';
            }
        }

        function formatDate(val) {
           return val.replace("-","").substr(0,6);
        }

        function validateNumber(val) {
            var rex = /^-?[0-9.]{1,}$/;
            return rex.test(val);
        }
    </script>
</head>
<body>
<div class="ringht_x">
    <div id="ccChild0" class="box_3">
        <input type="hidden" id="industryInjuryRatesId" value="${industryInjuryRatesVo.id}" />
        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#c5dbe2" style="font-size:12px;font-family: 'Microsoft YaHei';">
            <tr>
                <td class="td_1">费率编号</td>
                <td class="td_2" colspan="3">
                    <label class="text_field" id="injury_code">${industryInjuryRatesVo.injury_code}</label>
                </td>
            </tr>
            <tr>
                <td class="td_1">行业类别</td>
                <td class="td_2 ">
                    <r:comboSelect id="industry_id" name="industry_id"
                                   queryAction="/FAERP/IndustryTypeAction.do?cmd=findAllTypes"
                                   textField="industry_name"
                                   valueField="id"
                                   xpath="IndustryTypeVo"
                                   allowInput="false"
                                   width="205px"
                                   value="${industryInjuryRatesVo.industry_id}"/>
                </td>
                <td class="td_1">行业基础费率</td>
                <td class="td_2 ">
                    <input class="text_field" id="injury_base_rates" inputName="行业基础费率" maxLength="10" value="${industryInjuryRatesVo.injury_base_rates}"/>
                </td>
            </tr>
            <tr>
                <td class="td_1">有效起始年月</td>
                <td class="td_2">
                    <w:date allowInput="false" allowNull="false" id="valid_start_yearmonth" name="valid_start_yearmonth" format="yyyyMM" style="width:189px;"/>
                </td>
                <td class="td_1">有效结束年月</td>
                <td class="td_2">
                    <w:date allowInput="false" allowNull="false" id="valid_end_yearmonth" name="valid_end_yearmonth" format="yyyyMM" style="width:189px;"/>
                </td>
            </tr>
        </table>
        <div class="foot_button">
            <input type="button" class="foot_icon_1" value="保存" id="btnSave"/>
            <input type="button" class="foot_icon_1" value="关闭" id="btnClose"/>
        </div>
    </div>
</div>
</fmt:bundle>
</body>
</html>
