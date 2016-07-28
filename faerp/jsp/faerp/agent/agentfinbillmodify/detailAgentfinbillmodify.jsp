<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>账单明细审核</title>
    <!-- 第一次加载数据 -->
    <script language="javascript" src="<venus:base/>/jsp/faerp/agent/agentfinbillmodify/billmodify.js"></script>
    <!-- 第二次加载对比数据 -->
    <script language="javascript" src="<venus:base/>/jsp/faerp/agent/agentfinbillmodify/billmodify4approval.js"></script>
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
   writeTableTopFesco('账单明细审核','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
    <input  type="hidden"  value="${taskuid}" name="taskuid" id="taskuid"  >
    <div style="padding-top:10px; text-align:center;" class="xz_title">${billVo.cost_center_name }${fn:substring(billVo.bill_year_month, 0, 4) }年${fn:substring(billVo.bill_year_month, 4, 6) }月应付明细</div>
    <div class="button_right">
        <li style="font-size:12px; font-weight:inherit; width:300px; margin-left:70%;">账单号：${billVo.bill_code }</li>
        <div class="clear"></div>
    </div>
    <input type="hidden" value="${billVo.id }" name="bill_id" id="bid">
    <input type="hidden" name="bill_id_old" id="bill_id_old"  >
    <div style="padding: 0 0 8 8;">
            <r:datacell pageSize="51"
            id="datacell2"
            paramFormId="datacell_formid"
            queryAction="#"
            submitAction="#"
            width="98%"
            height="304px"
            xpath="/root/data/itemVo"
            submitXpath="itemVo"
            freezeNumber="4"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" /><!-- 添加分页 谭彦军 -->
            <r:field fieldName="sno" label="编号"></r:field>
            <r:field fieldName="emp_name" label="姓名"></r:field>
            <r:field fieldName="emp_code" label="唯一号"></r:field>
            <r:field fieldName="service_year_month" label="服务年月"></r:field>
            <logic:iterate name="titleList" id="smalltitles" scope="request" indexId="indexs">
               <c:choose>
                   <c:when test="${smalltitles[0] == 1 }">
                       <logic:iterate name="smalltitles" id="title" scope="page">
                          <c:choose>
                            <c:when test="${fn:contains(title, '_city') }">
                                <r:field fieldName="${title }" label="城市" groupval="${smalltitles[8] }" allowModify="true">
                                </r:field>
                            </c:when>
                            <c:when test="${fn:contains(title, '_base') }">
                                <r:field fieldName="${title }" label="基数" groupval="${smalltitles[8] }">
                                </r:field>
                            </c:when>
                            <c:when test="${fn:contains(title, '_amount') }">
                              <r:field fieldName="${title }" label="总额" groupval="${smalltitles[8] }" allowModify="false">
                              </r:field>
                            </c:when>
                            <c:when test="${fn:contains(title, '_eratio') }">
                               <r:field fieldName="${title }" label="单位比例" groupval="${smalltitles[8] }" allowModify="false">
                               </r:field>
                            </c:when>
                            <c:when test="${fn:contains(title, '_emoney') }">
                                <r:field fieldName="${title }" label="单位金额" groupval="${smalltitles[8] }" allowModify="false">
                                </r:field>
                            </c:when>
                            <c:when test="${fn:contains(title, '_pratio') }">
                                <r:field fieldName="${title }" label="个人比例" groupval="${smalltitles[8] }" allowModify="false">
                                </r:field>
                            </c:when>
                            <c:when test="${fn:contains(title, '_pmoney') }">
                                <r:field fieldName="${title }" label="个人金额" groupval="${smalltitles[8] }" allowModify="false">
                                </r:field>
                            </c:when>
                          </c:choose>
                       </logic:iterate>
                   </c:when>
                   <c:otherwise>
                       <r:field fieldName="${smalltitles[1] }" label="${fn:substring(smalltitles[2], 4, fn:length(smalltitles[2]))}" allowModify="true">
                       </r:field>
                   </c:otherwise>
               </c:choose>
            </logic:iterate>
            <r:field fieldName="rightsum" label="合计">
                
            </r:field>
        </r:datacell>
    </div>
    <div class="box_tab">
      <table width="100%" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1">修改原因</td>
          <td class="td_2">
            <textarea id="text22" class="xText_d" rows="3" name="text22" readonly="readonly">${billVo.applyfor }</textarea></td>
          </tr>
      </table>
      <div style="margin-top:10px;" class="xz_title">审核内容</div>
      <table width="100%" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
        <!-- 
        <tr>
          <td class="td_1">审核意见</td>
          <td class="td_2">
              <textarea onkeyup="countChar();" id="approvemsg" class="xText_d" rows="3" name="approvemsg" ${billVo.approve_bd == 4 ? 'readonly="readonly"' : '' }>${billVo.approve }</textarea>
              <div>还可输入<span id="surplus">400</span>字符</div>
          </td>
        </tr>
         -->
        <tr>
          <td class="td_1">审批结果</td>
          <c:choose>
            <c:when test="${billVo.approve_bd == 4 }">
                <td class="td_2">
                    <input type="radio" value="1" id="radio1" name="apptype" disabled="disabled">
                    <label for="radio1">同意</label>
                    <input type="radio" value="2" id="radio2" name="apptype" checked="checked" disabled="disabled">
                    <label for="radio2">驳回</label>
                </td>
            </c:when>
            <c:when test="${billVo.approve_bd == 3 }">
                <td class="td_2">
                    <input type="radio" value="1" id="radio1" name="apptype" checked="checked">
                    <label for="radio1">同意</label>
                    <input type="radio" value="2" id="radio2" name="apptype">
                    <label for="radio2">驳回</label>
                </td>
            </c:when>
            <c:otherwise>
                <td class="td_2">
                    <input type="radio" value="1" id="radio1" name="apptype">
                    <label for="radio1">同意</label>
                    <input type="radio" value="2" id="radio2" name="apptype">
                    <label for="radio2">驳回</label>
                </td>
            </c:otherwise>
          </c:choose>
        </tr>
      </table>
      <div class="foot_button">
        <c:choose>
            <c:when test="${billVo.approve_bd == 4 }">
                <div style="margin-bottom: 10px;">驳回状态不能再次审批</div>
                <input type="button" value="提交" onclick="approvsub();" class="foot_icon_1" disabled="disabled">
            </c:when>
            <c:otherwise>
                <input type="button" value="提交" onclick="approvsub();" class="foot_icon_1">
            </c:otherwise>
        </c:choose>
      </div>
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script language="javascript">
//翻页事件
    
    $id("datacell2").gotoPage = function(pageParam) {
        this.pageParam = pageParam;
        this.reload();
        this.onPageChange();
    }
</script>
