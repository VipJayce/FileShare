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
        var big_name = document.form.big_name.value;
        var city_id = document.form.city_id.value;
        var remark = document.form.remark.value;
        if(big_name == null || big_name == ""){
            alert("大类名称不能为空！");
            return;
        }
        if(city_id == null || city_id == ""){
            alert("城市不能为空！");
            return;
        }
        
        jQuery.getJSON("<venus:base/>/PbservicebigtypeAction.do?cmd=saveBigType&date="+new Date()+"",{"big_name":big_name,"city_id":city_id,"remark":remark},function(json){
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
                <td class="td_1">大分类名称</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" name="big_name" inputName="大分类名称" maxLength="50"/>
                </td>
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
            </tr>
            <tr>
                <td class="td_1">备注</td>
                <td class="td_2 " colspan="3">
                    <input type="text" class="text_field" name="remark" inputName="备注" maxLength="200" style="width:300px"/>
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
