<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%
             SptimeruleVo beanvo  = (SptimeruleVo)request.getAttribute("bean") ;
             if (beanvo==null){
                 beanvo = new SptimeruleVo() ;
             }
%>
<%@page import="rayoo.workattendance.workattendancerule.sptimerule.vo.SptimeruleVo"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考勤规则修改</title>
<script language="javascript">

   
</script>
</head>
<body>
<form name="form" action="/FAERP/SptimeruleAction.do?cmd=update" method="post"> 
<input name="timeruleid"  id="timeruleid"  type="hidden" value="${bean.id }"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">考勤规则修改</div></div>
    <div class="ringht_s">
    <!--表格2-->
    <div class="box_3"></div>
    <!--表格2 end-->
    <!--社保公积金-->
    <div class="zbox"><!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div class="xz_title">规则设置--><%=beanvo.getCustomer_name() %></div>
    <div class="box_z3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1">&nbsp;&nbsp;考勤小数位</td>
          <td class="td_2"><input name="timedecimal" type="text" class="sText" id="timedecimal" value="<%=beanvo.getTimedecimal()==null?"":beanvo.getTimedecimal().toString()%>"  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;工作日折算</td>
          <td class="td_2"><input name="daytohour" type="text" class="sText" id="daytohour"  value="<%=beanvo.getDaytohour()==null?"":beanvo.getDaytohour()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;出差显示值</td>
          <td class="td_2"><input name="chuchaidisp" type="text" class="sText" id="chuchaidisp"  value="<%=beanvo.getChuchaidisp()==null?"":beanvo.getChuchaidisp() %>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;休假显示值</td>
          <td class="td_2"><input name="xiujiadisp" type="text" class="sText" id="xiujiadisp"  value="<%=beanvo.getXiujiadisp()==null?"":beanvo.getXiujiadisp()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;旷工显示值</td>
          <td class="td_2"><input name="absentdisp" type="text" class="sText" id="absentdisp"  value="<%=beanvo.getAbsentdisp()==null?"":beanvo.getAbsentdisp()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;早退显示值</td>
          <td class="td_2"><input name="earlydisp" type="text" class="sText" id="earlydisp"  value="<%=beanvo.getEarlydisp()==null?"":beanvo.getEarlydisp() %>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;迟到显示值</td>
          <td class="td_2"><input name="latedisp" type="text" class="sText" id="latedisp"  value="<%=beanvo.getLatedisp()==null?"":beanvo.getLatedisp() %>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;公休显示值</td>
          <td class="td_2"><input name="gxdisp" type="text" class="sText" id="gxdisp"  value="<%=beanvo.getGxdisp()==null?"":beanvo.getGxdisp()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;计为加班类别</td>
          <td class="td_2"><input name="overtmruletype" type="text" class="sText" id="overtmruletype"  value="<%=beanvo.getOvertmruletype()==null?"":beanvo.getOvertmruletype() %>"style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;正常显示值</td>
          <td class="td_2"><input name="normaldisp" type="text" class="sText" id="normaldisp"  value="<%=beanvo.getNormaldisp()==null?"":beanvo.getNormaldisp() %>"   style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1" style="width:500px;">&nbsp;&nbsp;下班时间超过规定下班刷卡时间多少分钟时，计为加班</td>
          <td class="td_2"><input name="overtmbeyond" type="text" class="sText" id="overtmbeyond"  value="<%=beanvo.getNormaldisp()==null?"":beanvo.getNormaldisp() %>"style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;是否启用加班规定</td>
          <td class="td_2">
          <%
            if (beanvo.getUseovertmrule() !=null&&beanvo.getUseovertmrule().trim().equals("1")){
          %>
                <input type="radio" name="useovertmrule" checked="checked" id="useovertmrule" value="1" />是 
                <input type="radio" name="useovertmrule" id="useovertmrule" value="0" />否
          <%
            }else{
          %>
               <input type="radio" name="useovertmrule" id="useovertmrule" value="1" />是 
                <input type="radio" name="useovertmrule" checked="checked" id="useovertmrule" value="0" />否
           <%} %>
          </td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;启用年假有效期否</td>
          <td class="td_2">
          <%
            if (beanvo.getIsleave() !=null&&beanvo.getIsleave().trim().equals("1")){
          %>
                 <input type="radio"  checked="checked" name="isleave" id="isleave" value="1" />是 
                 <input type="radio" name="isleave" id="isleave" value="0" />否
          <%
            }else{
          %>
                <input type="radio" name="isleave" id="isleave" value="1" />是 
                 <input type="radio" checked="checked" name="isleave" id="isleave" value="0" />否
           <%} %>
           </td>
          <td class="td_1">&nbsp;&nbsp;年假有效期到次年的日</td>
          <td class="td_2"><input name="leavetoday" type="text" class="sText" id="leavetoday"  value="<%=beanvo.getLeavetoday()==null?"":beanvo.getLeavetoday()%>" style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;年假有效期至次年的月份</td>
          <td class="td_2"><input name="leavetomonth" type="text" class="sText" id="leavetomonth"  value="<%=beanvo.getLeavetomonth()==null?"":beanvo.getLeavetomonth()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;导入的数据类型</td>
          <td class="td_2"><input name="importdatatype" type="text" class="sText" id="importdatatype"  value="<%=beanvo.getImportdatatype()==null?"":beanvo.getImportdatatype().toString()%>" style="width:50px;"/></td>
        </tr><tr>
          <td class="td_1">&nbsp;&nbsp;旷工时数大于等于N小时时，计为旷工一天</td>
          <td class="td_2"><input name="kgtoday" type="text" class="sText" id="kgtoday"  value="<%=beanvo.getKgtoday()==null?"":beanvo.getKgtoday()%>" style="width:50px;"/>&nbsp;小时</td>
          <td class="td_1">&nbsp;&nbsp;旷工时数大于等于N小时时，计为旷工半天</td>
          <td class="td_2"><input name="kgtohalfday" type="text" class="sText" id="kgtohalfday"  value="<%=beanvo.getKgtohalfday()==null?"":beanvo.getKgtohalfday()%>" style="width:50px;"/>&nbsp;小时</td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;旷工最小时间单位舍位方式</td>
          <td class="td_2"><input name="absentunittype" type="text" class="sText" id="absentunittype"  value="<%=beanvo.getAbsentunittype()==null?"":beanvo.getAbsentunittype().toString() %>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;月工作天数</td>
          <td class="td_2"><input name="monthworkdays" type="text" class="sText" id="monthworkdays"  value="<%=beanvo.getMonthworkdays()==null?"":beanvo.getMonthworkdays()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;旷工最小时间单位</td>
          <td class="td_2"><input name="absentunit" type="text" class="sText" id="absentunit"  value="<%=beanvo.getAbsentunit()==null?"":beanvo.getAbsentunit()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;空缺计算方式</td>
          <td class="td_2"><input name="nulltype" type="text" class="sText" id="nulltype"  value="<%=beanvo.getNulltype()==null?"":beanvo.getNulltype()%>"  style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;早退最小时间单位舍位方式</td>
          <td class="td_2"><input name="earlyunittype" type="text" class="sText" id="earlyunittype"  value="<%=beanvo.getEarlyunittype()==null?"":beanvo.getEarlyunittype().toString()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;导入方式</td>
          <td class="td_2"><input name="importtype" type="text" class="sText" id="importtype"  value="<%=beanvo.getImporttype()==null?"":beanvo.getImporttype().toString()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;早退最小时间单位</td>
          <td class="td_2"><input name="earlyunit" type="text" class="sText" id="earlyunit"  value="<%=beanvo.getEarlyunit()==null?"":beanvo.getEarlyunit().toString()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;迟到最小时间单位舍位方式</td>
          <td class="td_2"><input name="lateunittype" type="text" class="sText" id="lateunittype"  value="<%=beanvo.getLateunittype()==null?"":beanvo.getLateunittype().toString()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;迟到最小时间单位</td>
          <td class="td_2"><input name="lateunit" type="text" class="sText" id="lateunit"  value="<%=beanvo.getLateunit()==null?"":beanvo.getLateunit().toString()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;下班未刷卡，上班刷卡的计做类型</td>
          <td class="td_2"><input name="nocheckoutturntotype" type="text" class="sText" id="nocheckoutturntotype"  value="<%=beanvo.getNocheckoutturntotype()==null?"":beanvo.getNocheckoutturntotype().toString()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;下班未刷卡，上班刷卡类型计算时长</td>
          <td class="td_2"><input name="nocheckoutturnto" type="text" class="sText" id="nocheckoutturnto"  value="<%=beanvo.getNocheckoutturnto()==null?"":beanvo.getNocheckoutturnto().toString()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;节日转调休</td>
          <td class="td_2"><input name="holtorest" type="text" class="sText" id="holtorest"  value="<%=beanvo.getHoltorest()==null?"":beanvo.getHoltorest()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;公休转调休</td>
          <td class="td_2"><input name="gentorest" type="text" class="sText" id="gentorest"  value="<%=beanvo.getGentorest()==null?"":beanvo.getGentorest()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;普通转调休</td>
          <td class="td_2"><input name="ordtorest" type="text" class="sText" id="ordtorest"  value="<%=beanvo.getOrdtorest()==null?"":beanvo.getOrdtorest()%>" style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;缺省缺勤假种</td>
          <td class="td_2"><input name="defaultitem" type="text" class="sText" id="defaultitem"  value="<%=beanvo.getDefaultitem()==null?"":beanvo.getDefaultitem()%>"style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;最长早退时限</td>
          <td class="td_2"><input name="largeearly" type="text" class="sText" id="largeearly"  value="<%=beanvo.getLargeearly()==null?"":beanvo.getLargeearly()%>"   style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;上班未刷卡、下班刷卡的计做类型</td>
          <td class="td_2"><input name="nocheckinturntotype" type="text" class="sText" id="nocheckinturntotype"  value="<%=beanvo.getNocheckinturntotype()==null?"":beanvo.getNocheckinturntotype().toString()%>"   style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;允许早退时限</td>
          <td class="td_2"><input name="allowearly" type="text" class="sText" id="allowearly"  value="<%=beanvo.getAllowearly()==null?"":beanvo.getAllowearly()%> "style="width:50px;"/></td>
        </tr>
         <tr>
          <td class="td_1">&nbsp;&nbsp;上班未刷卡下班刷卡的类型计算时长</td>
          <td class="td_2"><input name="nocheckinturnto" type="text" class="sText" id="nocheckinturnto"  value="<%=beanvo.getNocheckinturnto()==null?"":beanvo.getNocheckinturnto()%>"  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;最长迟到时限</td>
          <td class="td_2"><input name="largelate" type="text" class="sText" id="largelate"  value="<%=beanvo.getLargelate()==null?"":beanvo.getLargelate()%>"   style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;是否启用未刷卡规则</td>
          <td class="td_2"><input name="nocheckflag" type="text" class="sText" id="nocheckflag"  value="<%=beanvo.getNocheckflag()==null?"":beanvo.getNocheckflag()%>"  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;允许迟到时限</td>
          <td class="td_2"><input name="allowlate" type="text" class="sText" id="allowlate"  value="<%=beanvo.getAllowlate()==null?"":beanvo.getAllowlate()%>" style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;考勤月报显示小数位数</td>
          <td class="td_2"><input name="mreportnode" type="text" class="sText" id="mreportnode"  value="<%=beanvo.getMreportnode()==null?"":beanvo.getMreportnode().toString()%>" style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;刷卡规定</td>
          <td class="td_2"><input name="pressrule" type="text" class="sText" id="pressrule"  value="<%=beanvo.getPressrule()==null?"":beanvo.getPressrule().toString()%>" style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;考勤月报是否审批</td>
          <td class="td_2"><input name="mreportchecktype" type="text" class="sText" id="mreportchecktype"  value="<%=beanvo.getMreportchecktype()==null?"":beanvo.getMreportchecktype()%>"   style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;舍入规则</td>
          <td class="td_2"><input name="rounding" type="text" class="sText" id="rounding"  value="<%=beanvo.getRounding()==null?"":beanvo.getRounding().toString()%>"  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;刷卡数据自动导入文本路径</td>
          <td class="td_2"><input name="datafilepath" type="text" class="sText" id="datafilepath"  value="<%=beanvo.getDatafilepath()==null?"":beanvo.getDatafilepath()%>"  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;签卡提示次数</td>
          <td class="td_2"><input name="signtimes" type="text" class="sText" id="signtimes"  value="<%=beanvo.getSigntimes()==null?"":beanvo.getSigntimes().toString()%>"  style="width:50px;"/></td>
        </tr>
        <tr>
          <td class="td_1">&nbsp;&nbsp;加班显示值</td>
          <td class="td_2"><input name="jiabandisp" type="text" class="sText" id="jiabandisp"  value="<%=beanvo.getJiabandisp()==null?"":beanvo.getJiabandisp()%>"  style="width:50px;"/></td>
          <td class="td_1">&nbsp;&nbsp;考勤机数据是否是签到、签退的门禁数据</td>
          <td class="td_2"><input name="importdataflag" type="text" class="sText" id="importdataflag"  value="<%=beanvo.getImportdataflag()==null?"":beanvo.getImportdataflag()%>"  style="width:50px;"/></td>
        </tr>
      </table>
      <div align="center" style="margin-top:10px;"><input name="submit" type="submit" class="icon_1" value="保存"/>&nbsp;&nbsp;<input type="button" class="icon_2" value="返回" onclick="javascript:history.go(-1);"/></div>
      
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