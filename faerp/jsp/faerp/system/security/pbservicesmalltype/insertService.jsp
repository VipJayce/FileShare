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
    function load_onClick(){
        var city_id = document.getElementById("city_id").value;
        if(city_id == null || city_id == ""){
            alert("请返回重新选择一条分类，此分类记录没有城市！");
            return;
        }
        $id("servicelist").queryParam= "<param><key>city_id</key><value>" + city_id + "</value></param>";
        $id("servicelist").loadData();
        $id("servicelist").refresh();
    }
    
    function insert_onClick(){
        var service_id = document.form.service_id.value;
        var small_type_id = document.form.small_type_id.value;
        var city_id = document.form.city_id.value;
        if(small_type_id == null || small_type_id == ""){
            alert("请重新操作，选择一条分类！");
            return;
        }
        if(service_id == null || service_id == ""){
            alert("服务名称不能为空！");
            return;
        }
        
        jQuery.getJSON("<venus:base/>/PbServiceSmallTypeAction.do?cmd=saveService&date="+new Date()+"",{"service_id":service_id,"small_type_id":small_type_id},function(json){
            if(json.saia != ""){
                alert(json.saia);
                return;
            }else{
                alert("保存成功！");
	            window['returnValue'] = [small_type_id];
	            window.close();
	        }
        });
        
    }
    
    function cancel_onClick(){
        var small_type_id = document.form.small_type_id.value;
        window['returnValue'] = [small_type_id];
        window.close();
    }
</script>
</head>
<body onload="javascript:load_onClick()">

<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="small_type_id" name="small_type_id" value="<%=request.getParameter("small_type_id") %>"/>
<input type="hidden" id="city_id" name="city_id" value="<%=request.getParameter("city_id") %>"/>
    <div class="ringht_x">
    <div id="ccChild0" class="box_3">
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
            <tr>
                <td class="td_1">服务名称</td>
                <td class="td_2 ">
                    <r:comboSelect id="servicelist" name="service_id"
                             queryAction="/FAERP/PbserviceAction.do?cmd=getServiceListData"
                             textField="service_name"
                             valueField="id"
                             xpath="PbserviceVo"
                             width="200px"
                             value=""
                             nullText="请选择"/>
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
