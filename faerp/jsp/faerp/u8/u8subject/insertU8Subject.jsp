<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.u8subject.vo.U8SubjectVo" %>
<%@ page import="rayoo.u8.u8subject.util.IU8SubjectConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	U8SubjectVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IU8SubjectConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (U8SubjectVo)request.getAttribute(IU8SubjectConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		var ccode = document.form.ccode.value;
		var ccode_name = document.form.ccode_name.value;
		if(ccode == null || ccode == ""){
			alert("请输入科目编码！");
			return;
		}
		if(ccode_name == null || ccode_name == ""){
			alert("请输入科目名称！");
			return;
		}
		var param=jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/U8SubjectAction.do?cmd=insert&"+param;
        jQuery.post(url,function(msg){
         if(msg==""){
           alert("保存成功！");
           window.close();
         }else{
           alert(msg);
           return;
                //window.close();
         }
        })
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		var ccode = document.form.ccode.value;
		var ccode_name = document.form.ccode_name.value;
		if(ccode == null || ccode == ""){
			alert("请输入科目编码！");
			return;
		}
		if(ccode_name == null || ccode_name == ""){
			alert("请输入科目名称！");
			return;
		}
		var param=jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/U8SubjectAction.do?cmd=update&"+param;
        jQuery.post(url,function(msg){
	        if(msg==""){
	           alert("修改成功！");
	           window.close();
	         }else{
	           alert(msg);
	           return;
	                //window.close();
	         }
        })
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
 <div class="ringht">
<div id="ccChild1" class="box_3" > 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span style="color: red;">*</span>科目编码</td>
			<td class="td_2">
				<input type="text" class="text_field" style="width: 150px;" name="ccode" inputName="科目编码" <%if(isModify){ %> readonly="readonly"<%} %> />
			</td>
			<td class="td_1"><span style="color: red;">*</span>科目名称</td>
			<td class="td_2">
				<input type="text" class="text_field" style="width: 150px;" name="ccode_name" inputName="科目名称" />
			</td>
		</tr>
		<tr>
			<td class="td_1">编码级次</td>
			<td class="td_2">
			<%if(isModify){ %> 
				<input type="text" class="text_field" style="width: 150px;" name="igrade" inputName="编码级次" readonly="readonly" />
			<%}else{ %>
				<h:select name="igrade" style="width:150px;">
			        <h:option value="1" label="1"></h:option>
			        <h:option value="2" label="2"></h:option>
			        <h:option value="3" label="3"></h:option>
		        </h:select>
		     <%} %>
			</td>
			<td class="td_1">科目性质</td>
			<td class="td_2">
				<h:select name="bproperty" property="bean/bproperty" style="width:150px;">
			        <h:option value="0" label="借方"></h:option>
			        <h:option value="1" label="贷方"></h:option>
		        </h:select>
			</td>
		</tr>
</table> 
        </div> 
    <div class="foot_button" >
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>

    </div> 
       </div>  
<input type="hidden" name="id">
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
