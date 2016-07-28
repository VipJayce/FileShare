<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
    <title>考勤计算</title>
<script type="text/javascript">
          //客户名称
          function rtnFuncCustomer_s(arg){
            var lookup = $id("cust_name_s");
            lookup.value = arg[2];
            lookup.displayValue = arg[2];
            $id("cust_id").value =arg[0] ;
            $id("cust_name").value =  arg[2];
            return false;
        }
      function search_onclick() {
        $id("datacell").reload() ;
    }
     function delete_onclick() {
        var dc = $id("datacell");
        var clz = dc.getActiveEntity();
        if(!clz){
            alert("请先选择一条记录");
            return ;
        }
         if(confirm('您确定删除这条数据吗?')) {
               var timerule_id = clz.getValue("id");
                var datacell_formid = $id("datacell_formid") ;
                datacell_formid.action ="<%=request.getContextPath()%>/SptimeruleAction.do?cmd=delete&id="+timerule_id;
                datacell_formid.submit();    
         }
    }
    
    
     function toUpdate_onclick(){
        $id("datacell").submit() ;
    }
    </script>
</head>
<body>
<form name="form" action=""  id="datacell_formid"  method="post"> 
<input type="hidden" id="period_id" name="period_id"   value="<%=request.getParameter("period_id") %>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">考勤编辑</div></div>
  <div class="ringht_s">
    <!--查询 -->
  <div class="search"></div>
    <!--查询 end-->
  <!--按钮-->
    <!--表格 -->
    <div class="button">
      <div class="button_right">
        <ul>
          <li class="bc"><a onclick="javascript:toUpdate_onclick() ;">保存</a></li>
          <li class="js"><a>考勤重算</a></li>
           <li class="h_2"><a onClick="javascript:alert('已提交审批！')">提交审核</a></li>
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
        submitAction="/FAERP/SpmonthstatAction.do?cmd=updateeditmonthstat"
        width="98%"
        height="318px"
        xpath="SpmonthstatVo"
        readonly="false"
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
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field>              
            <r:field fieldName="latelong" label="迟到时长" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！" readonly="false"/>
            </r:field>        
              <r:field fieldName="nightshifthour" label="夜班工时" width="130px">
              <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field>      
            <r:field fieldName="absenthour" label="旷工工时" width="100px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field>          
            <r:field fieldName="earlycount" label="早退次数" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="latecount" label="迟到次数" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="nobrushcount" label="未刷次数" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="workdays" label="应出勤天数" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="workpercent" label="出勤率" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="sa_sickvacation" label="病假" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="sa_affairvacation" label="事假" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="sa_neglect" label="旷工" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="sa_overtime" label="加班" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="sa_late" label="迟到" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="sa_leave" label="早退" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="sa_hortation" label="奖励" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field> 
            <r:field fieldName="sa_countpay" label="合计" width="130px">
            <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
            </r:field>
    </r:datacell>
</div>
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>

