<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<%  
String ids= (String)request.getAttribute("ids");
String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();
   
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm."><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<title></title>

<script language="javascript">

    
        //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){
      var message =addAppReason("<%=request.getContextPath()%>");
      //alert('message='+message);
      if(message==null)return;
        //alert('操作成功！');
        form.action="<venus:base/>/HirefireAction.do?message="+message[0];
        document.getElementById("cmd").value="appOperate";
        form.submit();
         
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/HirefireAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
    }
    
</script>
</head>
<body>
 <div id="right">
    <div class="tab">
    
<form name="form" id="datacell_formid" method="post">
 <input  type="hidden"  value="" name="cmd" id="cmd"  >
<input  type="hidden"  value="" name="info_msg" id="info_msg"  >
 <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >
  <input  type="hidden"  value="<%=ids%>" name="ids" id="ids"  >
 
<div id="right">
<script language="javascript">
       writeTableTopFesco('用工不需办理审核','<%=request.getContextPath()%>/');
</script> 
<div>

    <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1"
        queryAction="/FAERP/HirefireAction.do?cmd=queryHireNotHandle" width="98%"
        height="320px" xpath="HirefireVo" submitXpath="HirefireVo" paramFormId="datacell_formid"
    >
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        
        <r:field fieldName="hireFireId" label="hireFireId" width="0px;"></r:field>
        <r:field fieldName="emp_id" label="员工id" width="0px;"></r:field>
        <r:field fieldName="emp_name" label="员工姓名" ></r:field>
        <r:field fieldName="emp_code" label="唯一号"></r:field>
        <r:field fieldName="id_card" label="身份证" width="150px;"></r:field>
        <r:field fieldName="bigname" label="入职大分类" width="180px;"></r:field>
        <r:field fieldName="cust_name" label="客户名称" width="150px;"></r:field>
        <r:field fieldName="hire_unit_short_name" label="用工方" width="180px;"></r:field>
        <r:field fieldName="classify_date" label="分类日期" allowModify="false">
            <w:date format="yyyy-MM-dd" />
        </r:field>
        <r:field fieldName="apply_on_post_date" label="入职日期"
            allowModify="false">
            <w:date format="yyyy-MM-dd" />
        </r:field>
        <r:field fieldName="apply_off_post_date" label="离职日期"
            allowModify="false">
            <w:date format="yyyy-MM-dd" />
        </r:field>
        <r:field fieldName="smallname" label="入职小分类"></r:field>
        <r:field fieldName="on_post_desc" label="入职备注"></r:field>
        <r:field fieldName="cs_name" label="客服"></r:field>
        <r:field fieldName="back_reason" label="回退原因" >
            <h:text name="back_reason" value="back_reason" onblur="batch_change_reason();"/>
        </r:field>
        <r:field fieldName="cancel_reason" label="撤销原因">
            <h:text name="cancel_reason" value="cancel_reason" onblur="batch_cancel_reason();"/>
        </r:field>
        <r:field fieldName="start_date" label="合同起止日期" allowModify="false">
            <w:date format="YYYY-MM-DD" />
        </r:field>
        <r:field fieldName="end_date" label="合同截止日期" allowModify="false">
            <w:date format="YYYY-MM-DD" />
        </r:field>
        <r:field fieldName="is_tiaodang" label="是否调档" allowModify="false">
            <d:select dictTypeId="TrueOrFalse"/>
        </r:field>
        <r:field fieldName="hire_memo" label="用工备注"></r:field>
    </r:datacell>
</div>

    <div class="foot_button">
        <input name="button_back" class="foot_icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <%
        if(request.getAttribute("isLook")==null||(request.getAttribute("isLook")!=null&&request.getAttribute("isLook").equals("false"))){
        %>
        <input name="button_app" class="foot_icon_2" type="button" value="审批"  onclick="javascript:appOperate_onClick();" >
        <input name="button_back" class="foot_icon_2" type="button" value="驳回"  onclick="javascript:backOperate_onClick();" >
        <%} %>
      </div>

    
</div>

</div>
</form>
</fmt:bundle>
</body>
</html>
