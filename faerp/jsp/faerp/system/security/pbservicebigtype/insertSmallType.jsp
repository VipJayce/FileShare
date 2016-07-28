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
        var big_type_id = document.form.big_type_id.value;
        var small_name = document.form.small_name.value;
        var remark = document.form.remark.value;
        if(big_type_id == null || big_type_id == ""){
            alert("请重新操作，选择一条大类！");
            return;
        }
        if(small_name == null || small_name == ""){
            alert("小类名称不能为空！");
            return;
        }
        
        jQuery.getJSON("<venus:base/>/PbservicebigtypeAction.do?cmd=saveSmallType&date="+new Date()+"",{"big_type_id":big_type_id,"small_name":small_name,"remark":remark},function(json){
            if(json.saia != ""){
                alert(json.saia);
                return;
            }else{
                alert("保存成功！");
	            window['returnValue'] = [big_type_id];
	            window.close();
	        }
        });
        
    }
    
    function cancel_onClick(){
        var big_type_id = document.form.big_type_id.value;
        window['returnValue'] = [big_type_id];
        window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="big_type_id" name="big_type_id" value="<%=request.getParameter("big_type_id") %>"/>
    <div class="ringht_x">
    <div id="ccChild0" class="box_3">
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
            <tr>
                <td class="td_1">小分类名称</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" name="small_name" inputName="小分类名称" maxLength="50"/>
                </td>
                <td class="td_1">备注</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" name="remark" inputName="备注" maxLength="200"/>
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
