<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%@include file="/common/skins/skin0/component.jsp" %>
<%@include file="/jsp/faerp/common/common.jsp" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.salary.reporttax.reporttax_resource" prefix="rayoo.salary.reporttax.">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
</head>
<body>
    <form method="post" action="<%=request.getContextPath()%>/ReporttaxAction.do?cmd=exportEmpTaxData" name="taxformid" id="taxformid">
        <div id="right">
            <script language="javascript">
                writeTableTopFesco('选择OS', '<%=request.getContextPath()%>/'); //显示本页的页眉
            </script>
            <div class="ringht_s">
                <div id="ccChild0" class="search">
                    <div style="width: 80%;text-align: center;">
                        <table>
	                        <tr>
	                            <td class="td_1">是否通知OS</td>
	                            <td class="td_2">
	                                <select id="is_email" name="is_email" style="width: 200px;">
	                                    <option value="1">是</option>
	                                    <option value="0">否</option>
	                                </select>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="td_1">请选择OS</td>
	                            <td class="td_2">
	                                <r:comboSelect id="os_id" name="os_id"
	                                   queryAction="/FAERP/ReporttaxAction.do?cmd=getOSData"
	                                   textField="name"
	                                   valueField="id"
	                                   xpath="AupartyVo"
	                                   width="200px"
	                                   messagekey="please_choose" />
	                            </td>
	                        </tr>
                            <tr>
	                            <td class="td_1" colspan="2">
	                                <div id="ccParent1" class="button">
	                                    <div class="button_right">
	                                        <ul>
	                                            <li class="g">
	                                                <a onClick="javascript:select_onClick();">确定</a>
	                                            </li>
	                                        </ul>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                    </table>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript">
    function select_onClick(){
        var is_email = document.getElementById("is_email").value;
        var os_id = document.getElementById("os_id").value;
        var returnAry = new Array();
        if(is_email == "1" && (os_id == "" || os_id == null)){
            alert("请选择一位OS人员！");
            return;
        }else{
            returnAry[0] = is_email;
            returnAry[1] = os_id;
        }
        window.returnValue=returnAry;
        window.close();
    }
</script>
</fmt:bundle>
</html>
