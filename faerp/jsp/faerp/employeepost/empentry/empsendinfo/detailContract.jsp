<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.send.vo.SendVo" %>
<%@ page import="rayoo.sales.send.util.ISendConstants" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.employeepost.empentry.empsendinfo.empsendinfo_resource" prefix="rayoo.employeepost.empentry.empsendinfo.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title>
</head>
<body>
<div id="right">
    <div class="tab">
        <div id="bg" class="xixi1">
            <div id="font1" class="tab1" onmousedown="setTab03Syn(1);document.getElementById('bg').className='xixi1'"><fmt:message key="contract_information"/></div>
            <div id="font2" class="tab2" onmousedown="setTab03Syn(2);document.getElementById('bg').className='xixi2'"><fmt:message key="terms_use_information"/></div>
        </div>
        <div id="TabCon1">
            <!--表格1-->
              <div class="ringht_x">
                <div class="box_tab">
                  <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                  <tr>
                    <td class="td_1"><fmt:message key="contract_type"/></td>
                    <td class="td_2"><input type="text" value="人事委托服务合同" class="xText" id="user"/></td>
                    <td class="td_1"><fmt:message key="contract_name"/></td>
                    <td class="td_2"><input type="text" value="Adecco_Vizio" class="xText" id="user16"/></td>
                  </tr>
                  <tr>
                    <td class="td_1"><fmt:message key="contract_party"/></td>
                    <td class="td_2"><input type="text" value="寰域设计咨询(上海)公司 " class="xText" id="user17"/></td>
                    <td class="td_1"><fmt:message key="contract_B"/></td>
                    <td class="td_2"><input type="text" value="北京外企德科人力资源服务上海有限公司" class="xText" id="user15"/></td>
                  </tr>
                  <tr>
                    <td class="td_1"><fmt:message key="contract_begin_time"/></td>
                    <td class="td_2"><input type="text" value="2012-05-02" class="xText" id="user2"/></td>
                    <td class="td_1"><fmt:message key="contract_end_time"/></td>
                    <td class="td_2"><input type="text" value="2014-05-31" class="xText" id="user4"/></td>
                  </tr>
                  <tr>
                    <td class="td_1"><fmt:message key="contract_templete"/></td>
                    <td class="td_2"><input type="text" value="人事委托服务合同" class="xText" id="user6"/></td>
                    <td class="td_2">&nbsp;</td>
                    <td class="td_2">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="td_1"><fmt:message key="contract_code"/></td>
                    <td class="td_2"><input type="text" value="W-20120207-003" class="xText" id="user7"/></td>
                    <td class="td_1"><fmt:message key="user_name"/></td>
                    <td class="td_2"><input name="text2" type="text" class="xText" id="user13" value="骆岭"/></td>
                  </tr>
                  <tr>
                    <td class="td_1"><fmt:message key="social_security_name"/></td>
                    <td class="td_2"><input type="text" value="段美凤" class="xText" id="user8"/></td>
                    <td class="td_1"><fmt:message key="fund_name"/></td>
                    <td class="td_2"><input type="text" value="孙妍珏" class="xText" id="user12"/></td>
                  </tr>
                  <tr>
                    <td class="td_1"><fmt:message key="emp_relation_name"/></td>
                    <td class="td_2"><input name="text" type="text" class="xText" id="user9" value="欧月妃"/></td>
                    <td class="td_1"><fmt:message key="labor_emp_name"/></td>
                    <td class="td_2"><input type="text" value="冯建芸" class="xText" id="user3"/></td>
                  </tr>
                  <tr>
                    <td class="td_1"><fmt:message key="approval_view"/></td>
                    <td colspan="3" class="td_2"><textarea name="textarea" class="xText_d" id="textarea2">同意----------康怡   2009-08-10
同意----------曾颖   2009-08-10
                    </textarea></td>
                  </tr>
                  </table>
                     <div class="foot_button">
                       <input type="button" class="foot_icon_1" value="<fmt:message key="go_back"/>" onclick="location.href='javascript:history.go(-1);'"/>
                  </div>
                </div>
                 </div>
             <!--表格1 end-->
        </div>
        
        
        <div id="TabCon2" style="display:none;">
            <!--表格2-->
              <div class="ringht_x">
                <div class="box_tab_2">
      <div class="box_tab_2_left">
            <ul>
                <li><a href="###"><fmt:message key="clause1"/></a></li>
                <li><a href="###"><fmt:message key="clause2"/></a></li>
                <li><a href="###"><fmt:message key="clause3"/></a></li>
            </ul>
        </div>
    <!--表格 -->
        <div class="box_tab_2_right">
          <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key="names"/></td>
            <td class="td_2"><input type="text" value="附件一 甲方向乙方出具的《委托服务通知书》式样" class="xText_400" id="user"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key="context"/></td>
            <td class="td_2"><textarea name="user" rows="4" class="xText_d" id="user3">附件一 甲方向乙方出具的《委托服务通知书》式样</textarea></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key="english_name"/></td>
            <td class="td_2"><input type="text" value="Adecco_Vizio" class="xText_400" id="user2"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key="english_context"/></td>
            <td class="td_2"><textarea rows="4" class="xText_d" id="user6"></textarea></td>
            </tr>
          </table>
            
      </div>
      
    <!--表格 end-->
    
    <div class="clear"></div>
    
    </div>
 <div class="foot_button">
 <input type="button" class="foot_icon_1" value="<fmt:message key="go_back"/>" onclick="location.href='javascript:history.go(-1);'"/>
 </div>
 </div>
 <!--表格2 end-->        
 </div>    
</div>
</div>
</body>
</fmt:bundle>
</html>
