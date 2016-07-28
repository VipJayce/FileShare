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
<title>codegen</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
         var reg=document.getElementById("templete_content").value;
       var remark=  document.getElementById("remark").value;
            var returnAry=new Array();
            if(reg!=null&&reg!=""){
              returnAry[0]=reg;
              }else{
               returnAry[0]="";
              }
           if(remark!=null&&remark!=""){
              returnAry[1]=remark;}
              else{
               returnAry[1]="";
              }
               window.returnValue=returnAry;
              window.close();
    }

  
    function cancel_onClick(){  //取消后返回列表页面
      window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="id" value="">
<div id="right">
  <div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="313" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">   
        <tr>
        <td class="td_1"  >项目名称</td>
            <td class="td_2 " >
                ${requestScope.projectbook_name }
            </td>
          
        </tr>
    
        <tr>
            <td class="td_1">条款详细描述(500字以内)</td>
            <td  class="td_2" colspan="3">
                <textarea class="textarea_limit_words" cols="62" rows="16" id="templete_content" name="templete_content" inputName="templete_content" maxLength="1000" >${sessionScope.templete_content1 }</textarea>
            </td>
        </tr>
       <tr> <td class="td_1" >服务费</td>
            <td class="td_2 ">
         每人每月<input type="text" id="price" name="price" size="10" value="${requestScope.price }"  readonly="readonly">元，<input type="text" id="remark" name="remark"  value="${requestScope.remark }" >
            </td></tr> 
             <tr> <td class="td_1" >服务时间</td>
            <td class="td_2 ">
               <input type="text" id="start_date" name="start_date"  value="${requestScope.start_date}" readonly="readonly"> 起，至<input type="text" id="end_date" name="end_date" value="${requestScope.end_date}"  readonly="readonly">
                 
            </td></tr> 
    </table>
    </div>
     <div class="foot_button"><input type="button" class="foot_icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()"  >
    <input type="button" class="foot_icon_2"  value='关闭'  onClick="javascript:cancel_onClick()" /></div>
    </div>
</div>                

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
