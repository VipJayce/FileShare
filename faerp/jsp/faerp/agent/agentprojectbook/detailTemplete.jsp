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
<title>codegen</title>
<script language="javascript">
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
        <td class="td_1" >项目名称</td>
            <td class="td_2 ">
                ${bean.projectbook_name }
            </td>
          
        </tr>
    
        <tr>
            <td class="td_1">条款详细描述</td>
            <td  class="td_2" colspan="3">
                <textarea class="textarea_limit_words" cols="62" rows="16" id="templete_content" name="templete_content" inputName="templete_content" maxLength="500" readonly="readonly">${bean.templete_content }</textarea>
            </td>
        </tr>
       <tr> <td class="td_1" >服务费</td>
            <td class="td_2 ">
         每人每月<input type="text" id="price" name="price" size="10" value="${requestScope.price }" readonly="readonly" >元，<input type="text" id="remark" name="remark"   value="${bean.remark }" readonly="readonly">
            </td></tr> 
             <tr> <td class="td_1" >服务时间</td>
            <td class="td_2 ">
               <input type="text" id="start_date" name="start_date" value="${requestScope.start_date}"  readonly="readonly"> 起，至<input type="text" id="end_date" name="end_date" value="${requestScope.end_date}" readonly="readonly" >
            </td></tr> 
    </table>
    </div>
    <div class="foot_button"><input type="button" class="foot_icon_2"  value='关闭'  onClick="javascript:cancel_onClick()" /></div>
    </div>
</div>                

</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
