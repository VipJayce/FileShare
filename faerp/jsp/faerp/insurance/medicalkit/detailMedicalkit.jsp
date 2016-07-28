<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.medicalkit.vo.MedicalkitVo" %>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>
<%@ page import="rayoo.insurance.medicalkit.util.IMedicalkitConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
    MedicalkitVo resultVo = null;  //定义一个临时的vo变量
    AttachmentfileVo avo=null;//附件VO    
    if(request.getAttribute(IMedicalkitConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (MedicalkitVo)request.getAttribute(IMedicalkitConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
    if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
        avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
    }
    String attachName = avo==null?"":avo.getAttachment_file_name().toString();
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">    
    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=queryAll&backFlag=false";
       // form.submit();
       window.close();
    }
</script>
</head>
<body>
<form name="form" method="post">

<div id="right" style="height: 195px;"> 
<div id="ccChild1"   style="height: 180px;"   class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
        <td class="td_1" width="20%">客户名称</td>
        <td class="td_2 " width="30%"><%=resultVo.getCustomer_name()==null?"":resultVo.getCustomer_name() %></td>
        <td class="td_1" width="20%">药箱属性</td>
        <td class="td_2" width="30%"><%=BaseDataHelper.getNameByCode("MEDICINE_ATTRIBUTES",String.valueOf(resultVo.getMedicine_attributes()))%></td>
    </tr>
    <tr>
        <td  class="td_1" >药品价值</td>
        <td  class="td_2" ><%=resultVo.getMedicine_value()==null?"":resultVo.getMedicine_value() %></td>
        <td  class="td_1" >药品成本</td>
        <td  class="td_2" ><%=resultVo.getMedicine_cost()==null?"":resultVo.getMedicine_cost() %></td>
    </tr>
    <tr>
        <td class="td_1">添加附件</td>
        <td class="td_2" colspan="3"> 
            <span><% out.print("<font color=blue>"+attachName+"</font>");%>&nbsp;</span>
        </td>
    </tr>
    <tr>
        <td class="td_1">备注</td>     
        <td colspan="3" class="td_2"><%=resultVo.getRemark()==null?"":resultVo.getRemark() %></td>
    </tr>
</table>
    <div class="mx_button" style="margin: 10px 0px 0px 10px;" align="center">
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div></div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
   out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
%>
</script>
