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
<title>考勤规则新增</title>
<script language="javascript">

   
</script>
</head>
<body>
<form name="form" action="<%=request.getContextPath()%>/SptimeruleAction.do?cmd=insert" method="post"> 
<input id="cust_id"   name="cust_id" type="hidden" value="<%=request.getParameter("cust_id") %>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">考勤规则新增</div></div>
    <div class="ringht_s">
    <!--表格2-->
    <div class="box_3"></div>
    <!--表格2 end-->
    <!--社保公积金-->
    <div class="zbox"><!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div class="xz_title">规则设置--><%=request.getParameter("cust_name") %></div>
    <div class="box_z3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1">&nbsp;&nbsp;考勤小数位</td>
          <td class="td_2"><input name="timedecimal" type="text" class="sText" id="timedecimal" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;工作日折算</td>
          <td class="td_2"><input name="daytohour" type="text" class="sText" id="daytohour" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;出差显示值</td>
          <td class="td_2"><input name="chuchaidisp" type="text" class="sText" id="chuchaidisp" value=""  style="width:50px;"/></td>
          <td class="td_1"><&nbsp;&nbsp;休假显示值</td>
          <td class="td_2"><input name="xiujiadisp" type="text" class="sText" id="xiujiadisp" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;旷工显示值</td>
          <td class="td_2"><input name="absentdisp" type="text" class="sText" id="absentdisp" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;早退显示值</td>
          <td class="td_2"><input name="earlydisp" type="text" class="sText" id="earlydisp" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;迟到显示值</td>
          <td class="td_2"><input name="latedisp" type="text" class="sText" id="latedisp" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;公休显示值</td>
          <td class="td_2"><input name="gxdisp" type="text" class="sText" id="gxdisp" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;计为加班类别</td>
          <td class="td_2"><input name="overtmruletype" type="text" class="sText" id="overtmruletype" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;正常显示值</td>
          <td class="td_2"><input name="normaldisp" type="text" class="sText" id="normaldisp" value=""  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1" style="width:500px;">&nbsp;&nbsp;下班时间超过规定下班刷卡时间多少分钟时，计为加班</td>
          <td class="td_2"><input name="overtmbeyond" type="text" class="sText" id="overtmbeyond" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;是否启用加班规定</td>
          <td class="td_2"><input type="checkbox" name="useovertmrule" id="useovertmrule" value="1" />是 
                           <input type="checkbox" name="useovertmrule" id="useovertmrule" value="0" />否
          </td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;启用年假有效期否</td>
          <td class="td_2"><input type="checkbox" name="isleave" id="isleave" value="1" />是 
                           <input type="checkbox" name="isleave" id="isleave" value="0" />否</td>
          <td class="td_1" >&nbsp;&nbsp;年假有效期到次年的日</td>
          <td class="td_2"><input name="leavetoday" type="text" class="sText" id="leavetoday" value=""  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;年假有效期至次年的月份</td>
          <td class="td_2"><input name="leavetomonth" type="text" class="sText" id="leavetomonth" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;导入的数据类型</td>
          <td class="td_2"><input name="importdatatype" type="text" class="sText" id="importdatatype" value=""  style="width:50px;"/></td>
        </tr><tr>
          <td class="td_1">&nbsp;&nbsp;旷工时数大于等于N小时时，计为旷工一天</td>
          <td class="td_2"><input name="kgtoday" type="text" class="sText" id="kgtoday" value=""  style="width:50px;"/>&nbsp;小时</td>
          <td class="td_1">&nbsp;&nbsp;旷工时数大于等于N小时时，计为旷工半天</td>
          <td class="td_2"><input name="kgtohalfday" type="text" class="sText" id="kgtohalfday" value=""  style="width:50px;"/>&nbsp;小时</td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;旷工最小时间单位舍位方式</td>
          <td class="td_2"><input name="absentunittype" type="text" class="sText" id="absentunittype" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;月工作天数</td>
          <td class="td_2"><input name="monthworkdays" type="text" class="sText" id="monthworkdays" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;旷工最小时间单位</td>
          <td class="td_2"><input name="absentunit" type="text" class="sText" id="absentunit" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;空缺计算方式</td>
          <td class="td_2"><input name="nulltype" type="text" class="sText" id="nulltype" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;早退最小时间单位舍位方式</td>
          <td class="td_2"><input name="earlyunittype" type="text" class="sText" id="earlyunittype" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;导入方式</td>
          <td class="td_2"><input name="importtype" type="text" class="sText" id="importtype" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;早退最小时间单位</td>
          <td class="td_2"><input name="earlyunit" type="text" class="sText" id="earlyunit" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;迟到最小时间单位舍位方式</td>
          <td class="td_2"><input name="lateunittype" type="text" class="sText" id="lateunittype" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;迟到最小时间单位</td>
          <td class="td_2"><input name="lateunit" type="text" class="sText" id="lateunit" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;下班未刷卡，上班刷卡的计做类型</td>
          <td class="td_2"><input name="nocheckoutturntotype" type="text" class="sText" id="nocheckoutturntotype" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;下班未刷卡，上班刷卡类型计算时长</td>
          <td class="td_2"><input name="nocheckoutturnto" type="text" class="sText" id="nocheckoutturnto" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;节日转调休</td>
          <td class="td_2"><input name="holtorest" type="text" class="sText" id="holtorest" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;公休转调休</td>
          <td class="td_2"><input name="gentorest" type="text" class="sText" id="gentorest" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;普通转调休</td>
          <td class="td_2"><input name="ordtorest" type="text" class="sText" id="ordtorest" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;缺省缺勤假种</td>
          <td class="td_2"><input name="defaultitem" type="text" class="sText" id="defaultitem" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;最长早退时限</td>
          <td class="td_2"><input name="largeearly" type="text" class="sText" id="largeearly" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">>&nbsp;&nbsp;上班未刷卡、下班刷卡的计做类型</td>
          <td class="td_2"><input name="nocheckinturntotype" type="text" class="sText" id="nocheckinturntotype" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;允许早退时限</td>
          <td class="td_2"><input name="allowearly" type="text" class="sText" id="allowearly" value=""  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;上班未刷卡下班刷卡的类型计算时长</td>
          <td class="td_2"><input name="nocheckinturnto" type="text" class="sText" id="nocheckinturnto" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;最长迟到时限</td>
          <td class="td_2"><input name="largelate" type="text" class="sText" id="largelate" value=""  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;是否启用未刷卡规则</td>
          <td class="td_2"><input name="nocheckflag" type="text" class="sText" id="nocheckflag" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;允许迟到时限</td>
          <td class="td_2"><input name="allowlate" type="text" class="sText" id="allowlate" value=""  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;考勤月报显示小数位数</td>
          <td class="td_2"><input name="mreportnode" type="text" class="sText" id="mreportnode" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;刷卡规定</td>
          <td class="td_2"><input name="pressrule" type="text" class="sText" id="pressrule" value=""  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;考勤月报是否审批</td>
          <td class="td_2"><input name="mreportchecktype" type="text" class="sText" id="mreportchecktype" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;舍入规则</td>
          <td class="td_2"><input name="rounding" type="text" class="sText" id="rounding" value=""  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;刷卡数据自动导入文本路径</td>
          <td class="td_2"><input name="datafilepath" type="text" class="sText" id="datafilepath" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;签卡提示次数</td>
          <td class="td_2"><input name="signtimes" type="text" class="sText" id="signtimes" value=""  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;加班显示值</td>
          <td class="td_2"><input name="jiabandisp" type="text" class="sText" id="jiabandisp" value=""  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;考勤机数据是否是签到、签退的门禁数据</td>
          <td class="td_2"><input name="importdataflag" type="text" class="sText" id="importdataflag" value=""  style="width:50px;"/></td>
        </tr>
      </table>
      <div align="center" style="margin-top:10px;"><input name="submit" type="submit" class="icon_1" value="保存"/>&nbsp;&nbsp;<input type="button" class="icon_2" value="返回" onclick="location.href='javascript:history.go(-1);'"/></div>
      
    </div>

    <!--表格 end-->
    </div>
    <!--社保公积金 end-->
    <!--福利项目--><!--福利项目 end-->
    </div>
</div>
</form>
</body>
</html>
