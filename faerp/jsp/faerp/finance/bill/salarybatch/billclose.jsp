<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>账单结账</title>

<style type="text/css"> 
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>
<script language="JavaScript">

function closeBill( ){
    var ajax = new Ajax("/FAERP/BillCreateAction.do?cmd=closeBill");
    ajax.submitForm(frm);
     var returnNode = ajax.getResponseXMLDom();
     if( returnNode ) {
         if( ajax.getValue("root/data/returnValue") == 1 ) {
             alert( '调用成功!');
         } else if (ajax.getValue("root/data/returnValue") == 0 ){
             alert( '保存失败!');
         }else{
             alert(ajax.getValue("root/data/returnValue"));
         }
     } else {
          alert( '保存失败!');
     }
      return;
}

</script>
</head>
<body>
<form name="form" action="" method="post"> 
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">账单结账</div></div>
    <div class="ringht_s">
    <!--表格2-->
    <div class="box_3"></div>
    <!--表格2 end-->
    <!--社保公积金-->
    <div class="zbox" ><!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div class="xz_title">结账</div>
    <div class="box_3" style="height:30px;">
      <div><div style="width:400px; float:left;"> 本操作将进行<b:write property="currentbillym/pValue" />月份的应收、实收数据结账！&nbsp;结帐操作无法恢复！</div><div style="width:100px; float:right;"><span class="td_2">
        <input name="submit3" type="submit" onClick="closeBill();" class="icon_1" value="结账" />
      </span></div> </div>
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

