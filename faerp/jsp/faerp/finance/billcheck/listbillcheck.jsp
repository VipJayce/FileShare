<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
  
    
</script>
</script>
</head>
<body>
<form name="form" action="" method="post"> 
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"> 开票审核</div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="135" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div></td>
    <td width="60">选择客户</td>
    <td width="240"><select name="select3" class="sSelect" id="select3">
      <option value="ro1">请选择</option>
      <option>北京移数通电讯有限公司上海分公司</option>
    </select></td>
    <td width="60"> 客户付款方</td>
    <td width="240"><select name="select2" class="sSelect" id="select">
      <option value="ro1">请选择</option>
      <option>北京移数通电讯有限公司上海分公司</option>
    </select></td>
        <td width="60">票据号</td>
    <td width="200"><input type="text" value="" class="sText" id="user"/></td>
  </tr>
  <tr>
    <td> 应收年月</td>
    <td><input type="text" value="" class="sText" id="user2"/></td>
    <td>开票申请人</td>
    <td><input type="text" value="" class="sText" id="user3"/></td>
        <td width="60">开票日期</td>
    <td width="200"><span class="td_2">
      <input name="text" type="text" class="sText_1" id="text" value=""/>
      <input name="text" type="text" class="sText_1" id="text2" value=""/>
    </span></td>
  </tr>
  <tr>
    <td>票据金额</td>
    <td><span class="td_2">
      <input name="text5" type="text" class="sText_1" id="text6" value=""/>
      <input name="text5" type="text" class="sText_1" id="text7" value=""/>
    </span></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="button" class="icon_1" value="查询" />
      </div></td>
  </tr>
  </table>
  </div>
    <!--查询 end-->
    <!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right">
        <ul>
          <li class="a"><a href="../应收应付管理/查看开票明细.html">明细</a></li>
          <li class="g"><a onClick="MyWin.Create('','审核','[pg]开票审核审核.html','800','220','100','30');">审核</a></li>
        </ul>
      </div>
      <div class="clear"></div>
    </div>
    <div class="box" id="values_div">
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="4%"  > <input type="checkbox" name="checkbox" value="checkbox" onClick="CheckAll()"></th>
          <th width="13%"   >唯一号</th>
          <th width="7%"  >客户名称</th>
          <th width="7%"  >客户付款方</th>
          <th width="9%"  >票据号</th>
          <th width="7%"  >票据日期</th>
          <th width="9%"  >票据金额</th>
          <th width="48%"  >开票日期</th>
          <th width="48%"  >发票状态</th>
          <th width="48%"  >开票明细</th>
          <th width="48%"  >备注</th>
          </tr>
        <tr>
          <td ><input type="checkbox" name="checkbox22" value="checkbox"></td>
          <td >100017</td>
          <td>北京移数通电讯有限公司上海分公司</td>
          <td>北京移数通电讯有限公司上海分公司</td>
          <td>12887483512</td>
          <td>2007-12-12</td>
          <td>131,834.87</td>
          <td>2007-12-12 16:41:55</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>1006手工</td>
          </tr>
        <tr>
          <td ><input type="checkbox" name="checkbox2" value="checkbox"></td>
          <td >100017</td>
          <td>北京移数通电讯有限公司上海分公司</td>
          <td>北京移数通电讯有限公司上海分公司</td>
          <td>12887480498</td>
          <td>2008-12-12</td>
          <td>141,173.90</td>
          <td>2008-12-12 12:46:43</td>
          <td>预开发票</td>
          <td>&nbsp;</td>
          <td>1007手工</td>
          </tr>
        <tr>
          <td ><input type="checkbox" name="checkbox3" value="checkbox"></td>
          <td >100017</td>
          <td>北京移数通电讯有限公司上海分公司</td>
          <td>北京移数通电讯有限公司上海分公司</td>
          <td>12887483332</td>
          <td>2008-03-03</td>
          <td>141,832.08</td>
          <td>2008-03-03 15:21:06</td>
          <td>实收发票</td>
          <td>&nbsp;</td>
          <td>1008手工</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
      </table>
    </div>
    <!--表格 end-->
    <!--翻页 -->
<div class="page">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="12"><img src="../images/page_icon_1.gif"/></td>
              <td>共5条记录，每页 10 条</td>
              <td width="30"><a href="###">首页</a></td>
              <td width="20"><a href="###"><img src="../images/page_icon_2.gif"/></a></td>
              <td width="50" align="center">1/1页</td>
              <td width="20"><a href="###"><img src="../images/page_icon_3.gif" alt=""/></a></td>
              <td width="50"><a href="###">尾页</a></td>
              <td width="40">转到第</td>
              <td width="45"><input type="text" value="" class="pText"/></td>
              <td width="20">页</td>
              <td width="20"><a href="###"><img src="../images/page_icon_4.gif" width="16" height="16" /></a></td>
              <td width="10"><a href="###">转</a></td>
            </tr>
          </table>
  </div>
      <div class="box"  style="width:30%; float:left;">
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="2%" > <input type="checkbox" name="checkbox" value="checkbox" onClick="CheckAll()"></th>
          <th width="40%" >应收年月</th>
          <th width="50%">应收金额</th>
          <th width="50%">应收类型</th>
          </tr>
        <tr>
          <td ><input type="checkbox" name="checkbox22" value="checkbox"></td>
          <td >200811</td>
          <td><A href="http://10.11.70.209:8080/finance/oughtReceive.paymentDetail.d?PAYMENT_VERSION_ID=7795351&paymentVersionId=7795351&paymentType=1" target="_blank">94,137.60</A></td>
          <td>仅含社保福利</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
         </tr>
      </table>
    </div>
      <div class="box" style="width:65%; float:right;">
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="2%"  > <input type="checkbox" name="checkbox" value="checkbox" onClick="CheckAll()"></th>
          <th width="6%"  class="fex_row">到款编号</th>
          <th width="6%"  class="fex_row">到款日期</th>
          <th width="5%">到帐金额</th>
          <th width="50%">核销时间</th>
          <th width="40%"  >核销金额</th>
          <th width="50%">小额调整</th>
          <th width="50%">备注</th>
          </tr>
        <tr>
          <td ><input type="checkbox" name="checkbox22" value="checkbox"></td>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">2012-03-23</td>
          <td>2,746.49</td>
          <td>2008-01-10 09:59:32</td>
          <td >187,256.35</td>
          <td>0.00</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">2012-03-22</td>
          <td>1,070.99</td>
          <td>&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td >&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td class="fex_row">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td >&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
      </table>
  </div>
     
<!--翻页 end-->
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>
