<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function insert_onClick(){
        var city_id = document.form.city_id.value;
        var service_type_bd = document.form.service_type_bd.value;
        var service_code = document.form.service_code.value;
        var service_name = document.form.service_name.value;
        var remark = document.form.remark.value;
        if(city_id == null || city_id == ""){
            alert("城市不能为空！");
            return;
        }
        if(service_type_bd == null || service_type_bd == ""){
            alert("服务类别不能为空！");
            return;
        }
        if(service_code == null || service_code == ""){
            alert("服务编码不能为空！");
            return;
        }
        if(service_name == null || service_name == ""){
            alert("服务名称不能为空！");
            return;
        }
        
        jQuery.getJSON("<venus:base/>/PbserviceAction.do?cmd=saveService&date="+new Date()+"",{"city_id":city_id,"service_type_bd":service_type_bd,"service_code":service_code,"service_name":service_name,"remark":remark},function(json){
            if(json.saia != ""){
                alert(json.saia);
                return;
            }else{
                alert("保存成功！");
	            window['returnValue'] = [''];
	            window.close();
	        }
        });
        
    }
    
    function cancel_onClick(){
        window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
    <div class="ringht_x">
    <div id="ccChild0" class="box_3">
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
            <tr>
                <td class="td_1">城市</td>
                <td class="td_2 ">
                    <r:comboSelect id="city_idList_search" name="city_id"
                               queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                               textField="city_name"
                               valueField="id"
                               xpath="PB_CITYVo"
                               width="200px"
                               value=""
                               nullText="请选择"/>
                </td>
                <td class="td_1">服务类别</td>
                <td class="td_2 ">
                    <%=gap.rm.tools.helper.RmJspHelper.getSelectField("service_type_bd", -1, "SERVICE_TYPE_BD", "", "", false) %>
                </td>
            </tr>
            <tr>
                <td class="td_1">服务编码</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" name="service_code" inputName="服务编码" maxLength="50"/>
                </td>
                <td class="td_1">服务名称</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" name="service_name" inputName="服务名称" maxLength="50"/>
                </td>
            </tr>
            <tr>
                <td class="td_1">备注</td>
                <td class="td_2 " colspan="3">
                    <input type="text" class="text_field" name="remark" inputName="服务编码" maxLength="200" style="width:300px"/>
                </td>
            </tr>
        </table>
        <div class="foot_button">
            <input type="button" class="foot_icon_1" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()"/>
            <input type="button" class="foot_icon_1" value='关闭' onClick="javascript:cancel_onClick()" />
        </div>
    </div>
    </div>
</form>
</fmt:bundle>
</body>
</html>
