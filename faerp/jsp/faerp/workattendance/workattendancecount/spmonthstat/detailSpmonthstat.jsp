<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考勤计算</title>
<script language="javascript">
  function export_onclick () {
             var period_id = $id("period_id").value ;
             $id("datacell_formid").action="<%=request.getContextPath()%>/SpmonthstatAction.do?cmd=exportMonthStatData&period_id="+period_id   ;
             $id("datacell_formid").submit();
    }
</script>
</head>
<body>
<form name="form" action="" id="datacell_formid" method="post"> 
<input type="hidden" id="period_id" name="period_id"   value="<%=request.getParameter("period_id") %>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">考勤明细</div></div>
  <div class="ringht_s">
    
  <div class="search">
  </div>
      <div class="button">
      <div class="button_right">
        <ul>
          <li class="e_3"><a onclick="javascript:export_onclick() ;">导出excel</a></li>
          <li class="m"><a onclick="javascript:history.go(-1);">返回</a></li>
        </ul>
      </div>
      <div class="clear"></div>
    </div>
    <div style="padding: 5 0 8 8;">
       <r:datacell 
        id="datacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/SpmonthstatAction.do?cmd=queryAll"
        width="98%"
        height="318px"
        xpath="SpmonthstatVo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="emp_code" label="唯一号" width="150px">
            </r:field>
            <r:field fieldName="emp_name" label="姓名" width="150px">
            </r:field>
            <r:field fieldName="tbmyear" label="年份" width="100px">
            </r:field>
            <r:field fieldName="tbmmonth" label="月份" width="100px">
            </r:field>  
            <r:field fieldName="earlylong" label="早退时长" width="100px">
            </r:field>              
            <r:field fieldName="latelong" label="迟到时长" width="130px">
            </r:field>        
              <r:field fieldName="nightshifthour" label="夜班工时" width="130px">
            </r:field>      
            <r:field fieldName="absenthour" label="旷工工时" width="100px">
            </r:field>          
            <r:field fieldName="earlycount" label="早退次数" width="130px">
            </r:field> 
            <r:field fieldName="latecount" label="迟到次数" width="130px">
            </r:field> 
            <r:field fieldName="nobrushcount" label="未刷次数" width="130px">
            </r:field> 
            <r:field fieldName="workdays" label="应出勤天数" width="130px">
            </r:field> 
            <r:field fieldName="workpercent" label="出勤率" width="130px">
            </r:field> 
            <r:field fieldName="sa_sickvacation" label="病假" width="130px">
            </r:field> 
            <r:field fieldName="sa_affairvacation" label="事假" width="130px">
            </r:field> 
            <r:field fieldName="sa_neglect" label="旷工" width="130px">
            </r:field> 
            <r:field fieldName="sa_overtime" label="加班" width="130px">
            </r:field> 
            <r:field fieldName="sa_late" label="迟到" width="130px">
            </r:field> 
            <r:field fieldName="sa_leave" label="早退" width="130px">
            </r:field> 
            <r:field fieldName="sa_hortation" label="奖励" width="130px">
            </r:field> 
            <r:field fieldName="sa_countpay" label="合计" width="130px">
            </r:field>
    </r:datacell>
</div>
    </div>
</div>
</form>
</body>
</html>
