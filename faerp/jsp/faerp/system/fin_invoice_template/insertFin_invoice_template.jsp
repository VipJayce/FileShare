<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

	function insert_onClick(){  //插入单条数据
		var template_name = $id("template_name").value;
		if(template_name==""||template_name==null){
		  alert("请输入模板名称！");
		  return;
		}
		
		onKey_Up(template_name);
		
          var param = jQuery("#datacell_formid").serialize();
          var url="<%=request.getContextPath()%>/Fin_invoice_templateAction.do?cmd=insertData&"+param;
	        jQuery.post(url,function(data){
	            if(data){
		                if(data!=""){
		                alert("保存成功！");
                        window.close();
		                }else{
		                alert("保存失败！");
		                window.close();
		                }
	             }else{
                        alert("保存失败！");
                        window.close();
                        }
             });
	}

    
    function onKey_Up(v_str) {
        if(v_str==""||v_str==null){
          alert("请输入模板名称！");
          return;
        }
        
        var url="<%=request.getContextPath()%>/Fin_invoice_templateAction.do?cmd=checkTemplateName&template_name=" + v_str;
        url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        url = encodeURI(url);
        jQuery.post(url,function(data){
            if(data){
                    if(data!=""){
	                        if(data == '1'){
	                              alert("【"+v_str+"】此模板名称已存在！");
	                              $id("template_name").value="";
	                              form.template_name.focus();
	                              return;
	                         }
                    }else{
                        alert("操作失败！");
                    }
             }
         });
    }
    

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height: 155px">
<div class="xz_title" style="padding-top: 5px">新增模板</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td  class="td_1" ><span class="style_required_red">* </span>模板名称</td>
			<td  class="td_2 "><input type="text" class="sText" value="" name="template_name" id="template_name" onblur="onKey_Up(this.value)"/></td>
			<td  class="td_1" >创建人</td>
			<td  class="td_2" ><input type="text" class="sText"  readonly="true" value="<%=LoginHelper.getLoginName(request)%>"  name="username"/><input type="hidden" class="sText" value="<%=LoginHelper.getPartyId(request)%>" name="create_user_id"/> </td>
		</tr>
		
	<!--  <tr>
            <td  class="td_1" ><span class="style_required_red">* </span>是否显示账期</td>
            <td  class="td_2 ">
            <input name="is_display_year_month" type="radio" id="is_display_year_month" value="1">
            是
            <label for="radio">
              <input type="radio" name="is_display_year_month"  value="0"  checked="checked">
            </label>
           否
            </td>
            <td  class="td_1" >&nbsp;</td>
            <td  class="td_2" >&nbsp;</td>
        </tr>-->    
        
		<tr>
            <td class="td_1" >模板备注</td>
            <td class="td_2 " colspan="4">
                <textarea id="template_remark" style="width:400px; height:40px;" class="xText_d" rows="4" name="template_remark"></textarea>
            </td>
        </tr>
	</table>
	   <div  align="center" style="padding-top: 10px;">
            <input type="button" id="bc" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()" />
            <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
         </div>  
 
</div>         

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>