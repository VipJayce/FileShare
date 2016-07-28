<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>项目书模板信息</title>
<script language="javascript">

    function cancel_onClick(){  //取消后返回列表页面
     window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
 <div class="ringht_x">
<div id="ccChild0" class="box_3"> 
    <div class="xz_title" style="padding-top: 10px">基本信息</div>
<table  width="100%" height="313" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        
        <tr>
        <td class="td_1"  nowrap="nowrap">条款模板名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="templete_name" inputName="templete_name" value="${bean.templete_name }" maxLength="50" readonly="readonly" />
            </td>
            <td class="td_1" >城市</td>
            <td class="td_2 " >         
                 <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" property="bean/city_id" readonly="true" />
            </td>       
        </tr>
    
        <tr>
            <td class="td_1">条款详细描述</td>
            <td  class="td_2" colspan="3">
                <textarea class="textarea_limit_words" cols="90" rows="18" name="templete_content" inputName="templete_content" maxLength="500"  readonly="readonly">${bean.templete_content }</textarea>
            </td>
        </tr>

    </table>
    </div>
    <div class="foot_button">

        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>           
</div>                 
<input type="hidden" name="id" value="">
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
