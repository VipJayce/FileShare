<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
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
      <div class=" right_title">查看明细</div></div>
  <div class="ringht_s">
    <!--查询 -->
  <div class="search"></div>
    <!--查询 end-->
  <!--按钮-->
    <!--表格 -->
    <div class="box" id="values_div">
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="4%"  class="fex_row">
            <input type="checkbox" name="checkbox" value="checkbox" onClick="CheckAll()">
          </th>
          <th  class="fex_row">唯一号</th>
          <th>姓名</th>
          <th>年</th>
          <th>月</th>
          <th>应发合计</th>
          <th>扣款合计</th>
          <th>实发合计</th>
          <th>税前总额</th>
          <th>扣税基数</th>
          <th>本次扣税</th>
          <th>基本工资</th>
          <th>加班费</th>
          <th>补贴</th>
          <th>补其他</th>
          <th>十三薪</th>
          <th>奖金</th>
          <th>年终奖金</th>
          <th>社保基数</th>
          <th>养老自付</th>
          <th>医疗支付</th>
          <th>失业支付</th>
          <th>公积金基数</th>
          <th>公积金支付</th>
          <th>个人社保总计</th>
          <th>补充公积金（企业部分）</th>
          <th>补充公积金（个人部分）</th>
          <th>税后扣除</th>
          <th>税后增加</th>
          <th>工资代收代付</th>
          <th>备注</th>
          </tr>
        <tr>
          <td class="fex_row">
            <input type="checkbox" name="checkbox22" value="checkbox">
          </td>
          <td class="fex_row"> 1000096 </td>
          <td> 赵树深 </td>
          <td> 2007 </td>
          <td>12</td>
          <td> 3,720.00 </td>
          <td> 193.00 </td>
          <td> 3,527.00 </td>
          <td> 3,720.00 </td>
          <td> 3,720.00</td>
          <td> 193.00 </td>
          <td> 3,500.00 </td>
          <td>0.00</td>
          <td> 220.00 </td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td class="fex_row"><input type="checkbox" name="checkbox2" value="checkbox"></td>
          <td class="fex_row"> 1004016 </td>
          <td> 赵丽君 </td>
          <td> 2007 </td>
          <td>12</td>
          <td> 3,670.00 </td>
          <td> 804.44 </td>
          <td> 2,865.56 </td>
          <td> 2,978.40 </td>
          <td> 2,978.40 </td>
          <td> 112.84 </td>
          <td> 3,500.00 </td>
          <td>0.00</td>
          <td> 170.00 </td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>393.60</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>298.00</td>
          <td>691.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>&nbsp;</td>
          </tr>
        <tr>
          <td class="fex_row"><input type="checkbox" name="checkbox3" value="checkbox"></td>
          <td class="fex_row"> 1004077 </td>
          <td> 李湘媛 </td>
          <td> 2007 </td>
          <td>12</td>
          <td> 15,220.00 </td>
          <td> 2,349.00 </td>
          <td> 12,871.00 </td>
          <td> 15,220.00 </td>
          <td> 15,220.00 </td>
          <td> 2,349.00 </td>
          <td> 15,000.00 </td>
          <td>0.00</td>
          <td> 220.00 </td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
          <td>0.00</td>
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
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
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
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
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
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
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
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
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
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
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
          <td class="box_img">&nbsp;</td>
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
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
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
            <td class="box_img">&nbsp;</td>
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
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
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
              <td>共 6 条记录，每页 10 条</td>
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
<div class="foot_button">
  <input type="button" class="foot_icon_1" value="返回"/>
  <input type="button" class="foot_icon_3" value="导出excel工资条"/>
  <input type="button" class="foot_icon_2" value="导出excel"/>
</div>
    <!--翻页 end-->
    </div>
</div>
</form>
</body>
</html>
