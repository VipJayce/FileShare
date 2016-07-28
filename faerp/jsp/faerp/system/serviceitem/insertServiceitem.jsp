<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面

    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <title>codegen</title>
    <script language="javascript">
 function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    function update_onClick(){

       
 
            
      var param=jQuery("#datacell_formid").serialize();      
        var url="<%=request.getContextPath()%>/ServiceitemAction.do?cmd=updateItem&"+param;
        jQuery.post(url,function(data){
     if(data){
         if(data!=0){
           alert("修改成功！");
           window.close();
         }else{
               alert("修改失败！");
                window.close();
         }
         }else{
           alert("修改失败！");
             jQuery("#save1").attr("disable",false);
           return;
         }
        })
    }   
    function  insert_onClick(){
   
        
            var post_belong=document.getElementById("post_belong").value;
            var contact_name=document.getElementById("contact_name").value;
                       if(post_belong==""||post_belong==null){
                alert("服务类型不能为空");
                return;
                }
                if(contact_name==""||contact_name==null){
                alert("手续名称不能为空");
                return;
                }
      
                jQuery("#save1").attr("disable",true);
     var param=jQuery("#datacell_formid").serialize();  
        var url="<%=request.getContextPath()%>/ServiceitemAction.do?cmd=insertItem&"+param;
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
           alert('保存失败!');
            jQuery("#save1").attr("disable",false);
           return;
         }
        })
    }
    function valiname(){
        var name = document.getElementById("contact_name").value;
        if(name!=null&&name!=''){
             jQuery.ajax({
               url: '<%=request.getContextPath()%>/ServiceitemAction.do?cmd=vailContactName&name='+encodeURI(name),
               type: 'POST',
               dataType: 'html',
               async: false,
               timeout: 10000,
                   error: function(){
                      alert('手续名称重复!');
                      jQuery("#contact_name").val("");
                      return;
                   },
                    success: function(data){
                        if(data=='true'){
                           alert('手续名称重复!');
                           jQuery("#contact_name").val("");
                           return;
                       }
                   }
               });
           }
           }
</script>
    </head>
    <body>

    <form name="form" method="post" id="datacell_formid">
 <input type="hidden" name="id" value="${bean.id }">

     <div id="right">
    <div class="ringht_s">
    <div id="ccChild1" class="box_3">
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
   <tr><td class="td_1" nowrap="nowrap"><span class="style_required_red">* </span>入离职归属</td>
    <c:choose>
 <c:when test="<%=isModify %>">
          <td class="td_2" ><d:select dictTypeId="POST_BELONG_BD" id="post_belong" name="post_belong" property="bean/post_belong" nullLabel="请选择" disabled="true"></d:select></td>
</c:when>
  <c:otherwise>
   <td class="td_2" ><d:select dictTypeId="POST_BELONG_BD" name="post_belong" property="bean/post_belong" nullLabel="请选择" ></d:select></td>
</c:otherwise>
</c:choose>
 <td class="td_1"><span class="style_required_red">* </span>手续名称</td>
 <c:choose>
 <c:when test="<%=isModify %>">
               <td class="td_2 "><input type="text" class="text_field" id="contact_name"
                name="contact_name" inputName="手续名称" value="${bean.contact_name }" maxLength="100" readonly="readonly" /></td>   
</c:when>
<c:otherwise>
    <td class="td_2 "><input type="text" class="text_field" id="contact_name"
                name="contact_name" inputName="手续名称" value="${bean.contact_name }" maxLength="100" onblur="valiname()"    /></td>   
</c:otherwise>
</c:choose>
</tr>
        <tr>
            <td class="td_1">备注</td>
            <td colspan="3" class="td_2"><textarea style="width: 500px" rows="2" name="remark" inputName="备注">${bean.remark }</textarea></td>
        </tr>
    </table>
    </div>
    <div class="foot_button"><input type="button" class="foot_icon_2" id="save1" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>"  >
    <input type="button" class="foot_icon_2"  value='关闭'  onClick="javascript:cancel_onClick()" /></div>
    </div>
    </div>
    </form>
</fmt:bundle>
</body>
</html>

