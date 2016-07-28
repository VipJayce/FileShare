<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%@include file="/common/skins/skin0/component.jsp" %>
<%@include file="/jsp/faerp/finance/common.jsp" %>
<html>
<fmt:bundle basename="gap.security.security_resource" prefix="gap.rm.industrytype.">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <h:script src="/js/jquery/jquery-1.7.2.min.js"/>
    <script type="text/javascript">
        var _jQuery = window.jQuery, _$ = window.$;
        jQuery.noConflict();

        function simpleQuery_onClick() {
            var $industryCodeValue = _$("#industry_code").val();
            var $industryNameValue = _$("#industry_name").val();
            var dc = $id("dcListIndustryType");
            dc.queryAction = "<%=request.getContextPath()%>/IndustryTypeAction.do?cmd=queryAll&industry_code=" + $industryCodeValue + "&industry_name=" + $industryNameValue;
            dc.loadData();
            dc.refresh();
        }
    </script>
    <title>行业类型数据操作</title>
</head>
<body>
<form id="datacell_formid" name="form" method="post" action="<%=request.getContextPath()%>/IndustryTypeAction.do?backFlag=true">
    <input type="hidden" name="cmd" value="queryAll">
    <div id="ccChild0" class="search">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="164px" rowspan="4" style="padding-top:0;">
                    <div class="search_title">查询条件</div>
                </td>
            </tr>
            <tr>
                <td align="right">&nbsp;&nbsp;行业类别:&nbsp;&nbsp;</td>
                <td align="left">
                    <input type="text" class="text_field" id="industry_code" inputName="行业类别" maxLength="50"/>
                </td>
                <td align="right">&nbsp;&nbsp;行业名称:&nbsp;&nbsp;</td>
                <td align="left">
                    <input type="text" class="text_field" id="industry_name" inputName="行业名称" maxLength="50"/>
                </td>
                <td align="center">
                    <input class="icon_1" type="button" value='<fmt:message key="query"/>' onclick="simpleQuery_onClick();"/>
                    <input class="icon_1" type="reset" value='<fmt:message key="reset"/>'/>
                </td>
            </tr>
        </table>
    </div>
    <div id="ccParent1" class="button">
        <input type="hidden" value="" id="incomingID" name="incomingID"/>
        <div class="button_right">
            <ul>
                <li><input class="c" id="addType" type="button" value="新增" <au:authorityBtn code="dkrl_wzdrl" type="1"/>/></li>
                <li><input class="bl" id="updateType" type="button" value="修改" <au:authorityBtn code="dkrl_wzdrl" type="1"/>/></li>
                <li><input class="d" id="deleteType" type="button" value="删除" <au:authorityBtn code="dkrl_wzdrl" type="1"/>/></li>
            </ul>
        </div>
    </div>
    <div class="clear"></div>
    <div style="margin:8px">
        <r:datacell
                id="dcListIndustryType"
                paramFormId="datacell_formid"
                queryAction="/FAERP/IndustryTypeAction.do?cmd=queryAll"
                width="99%"
                height="319px"
                xpath="IndustryTypeVo"
                pageSize="100">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field fieldName="industry_code" messagekey="industry_code" width="80px;"/>
            <r:field fieldName="industry_type_bd" messagekey="industry_type_bd" width="150px;"/>
            <r:field fieldName="industry_name" messagekey="industry_name" width="580px;"/>
        </r:datacell>
    </div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');
    _$(document).ready(function () {
        _$("#addType").click(function () {
            var url = "<venus:base/>/jsp/faerp/system/security/industrytype/insertindustrytype.jsp?op=add&t=" + (new Date()).getTime();
            methods.showWindow(url);
        });
        _$("#updateType").click(function () {
            var selectedId = methods.getSelectedId();
            if (!!selectedId) {
                methods.showWindow("<venus:base/>/IndustryTypeAction.do?cmd=edit&id=" + selectedId + "&t=" + (new Date()).getTime());
            } else {
                alert("您并未选择要删除的数据，请选择后点击删除。");
            }
        });

        _$("#deleteType").click(function () {
            var selectedId = methods.getSelectedId();
            if (!!selectedId) {
                _$.post("<venus:base/>/IndustryTypeAction.do", {"cmd": "delete", "id": selectedId}, function (data) {
                    if (!!data) {
                        if (data.indexOf("成功")>=0) {

                        }
                        alert(data);
                    }
                });
            } else {
                alert("您并未选择要删除的数据，请选择后点击删除。");
            }
        });
    });

    var methods = {
        reloadDataCell: function () {  //简单的模糊查询
            $id("dcListIndustryType").loadData();
            $id("dcListIndustryType").refresh();
        },
        getSelectedId: function () {
            var dc = $id("dcListIndustryType");
            var activeRow = dc.activeRow;
            var entity = dc.getEntity(activeRow);
            if (!!entity) {
                return entity.getProperty("id");
            } else {
                return undefined;
            }
        },
        showWindow : function(url) {
            var handle = window.open(url,'','height=200px,width=700px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
            methods.setTimer(handle);
        },
        setTimer: function(handle) {
            var timer = setInterval(function(){
                if (handle.closed) {
                    clearInterval(timer)
                    methods.reloadDataCell();
                }
            },100);
        }
    }
</script>
</body>
</html>