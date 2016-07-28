<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>候选人状态变化</title>
</head>
<body>
 
<form name="form" method="post">
       <div id="right">
       <div class="right_title_bg">
       <div class=" right_title">候选人状态历史</div>
     </div>
    <div class="ringht_s">
 <div class="clear"></div>
<div class="box_bjd" id="values_div" style="padding-left: 0px;" >
 <r:datacell id="datacell1" 
 queryAction="/FAERP/JobcandidateAction.do?cmd=getCandidateStateList&id=${param.id}&order_id=${param.order_id}&person_id=${param.person_id}"
 xpath="JobcandidateStatListVo"
 width="98%" height="318px" >
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="person_name" label="姓名" width="120px" allowModify="false">
 </r:field>
 <r:field fieldName="status" label="状态" width="120px" allowModify="false">
    <d:select dictTypeId="CANDIDATE_STATUS_BD" ></d:select>
 </r:field>
 <r:field fieldName="remark" label="备注" width="500px" allowModify="false">
    <h:textarea rows="8" cols="60" />
 </r:field>
 <r:field fieldName="audition_date" label="日期" width="150px" align="center" allowModify="false">
     <w:date format="yyyy-MM-dd HH:mm:ss"/>
 </r:field>
 </r:datacell>  
 </div>
    
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:window.close();" />
</div>


</div>

</div>

</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>

</body>
</html>
