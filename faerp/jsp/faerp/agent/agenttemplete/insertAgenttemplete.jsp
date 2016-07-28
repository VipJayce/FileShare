<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.agent.agenttemplete.vo.AgenttempleteVo" %>
<%@ page import="rayoo.agent.agenttemplete.util.IAgenttempleteConstants" %>
<%  //判断是否为修改页面
	AgenttempleteVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IAgenttempleteConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (AgenttempleteVo)request.getAttribute(IAgenttempleteConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=isModify?"项目书模板修改":"项目书模板增加" %></title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
               var templete_name=document.getElementById("templete_name").value;
               var templete_content=document.getElementById("templete_content").value;
               var city_id=document.getElementById("city_id").value;
               if(templete_name==null||templete_name==""){
               alert("模板名称不能为空");
               return;
               }
                       if(city_id==null||city_id==""){
               alert("城市名称不能为空");
               return;
               }
                          if(templete_content==null||templete_content==""){
               alert("模板内容不能为空");
               return;
               }
		   var param = jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/AgenttempleteAction.do?cmd=insert&"+param;
       jQuery.post(url,function(data){
             if(data){
                 if(data==""){
                      alert('保存失败');
                      return;
              
                 } else{
                 alert("保存成功");
                 window.close();
                  window.opener.simpleQuery_onClick();
             }
            
             }else{
                 alert("保存失败");
              return;
                    }
       });
	}

  	function update_onClick(id){  //保存修改后的单条数据
         var templete_name=document.getElementById("templete_name").value;
               var templete_content=document.getElementById("templete_content").value;
               var city_id=document.getElementById("city_id").value;
               if(templete_name==null||templete_name==""){
               alert("模板名称不能为空");
               return;
               }
                       if(city_id==null||city_id==""){
               alert("城市名称不能为空");
               return;
               }
                          if(templete_content==null||templete_content==""){
               alert("模板内容不能为空");
               return;
               }
	 var param = jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/AgenttempleteAction.do?cmd=update&"+param;
        jQuery.post(url,function(data){
    
             if(data){
                 if(data==0){
                      alert('修改失败!');
                      return;
                 }else{
                    alert("修改成功");
                    window.close();
                     window.opener.simpleQuery_onClick();
                 }
                 
             }else{
                      alert('修改失败!');
          return;
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
 <div class="ringht_x">
<div id="ccChild0" class="box_3"> 
    <div class="xz_title" style="padding-top: 10px">基本信息</div>
<table  width="100%" height="313" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		
		<tr>
		<td class="td_1" nowrap="nowrap"><span class="style_required_red">*</span>条款模板名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="templete_name" id="templete_name" inputName="templete_name" value="${bean.templete_name }" maxLength="50"  />
            </td>
			<td class="td_1" ><span class="style_required_red">*</span>城市</td>
			<td class="td_2 " >			
                 <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" property="bean/city_id" />
			</td>		
		</tr>
	
		<tr>
			<td class="td_1">条款详细描述 (500字以内)</td>
			<td  class="td_2" colspan="3">
				<textarea class="textarea_limit_words" cols="62" rows="16" id="templete_content" name="templete_content" inputName="templete_content" maxLength="1000" >${bean.templete_content }</textarea>
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
<input type="hidden" name="id" value="">
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
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
