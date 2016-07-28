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
<title>考勤期间</title>
<script language="javascript">

function  goto_submit(){
     var cust_id = $id("cust_id").value ;
     var timemonth = $id("timemonth").value ;
     var timeyear = $id("timeyear").value ;
     var wageyear = $id("wageyear").value ;
     var wagemonth = $id("wagemonth").value ;
      var begindate = $id("begindate").value ;
     var enddate = $id("enddate").value ;
     //
     if(cust_id ==null||cust_id==''){
        alert("请选择客户，客户名称不能为空！") ;
        return false ;
     }
     if(timemonth ==null||timemonth==''){
        alert("请填写考勤期间，考勤期间不能为空！") ;
        return false ;
     }
     if(timeyear ==null||timeyear==''){
        alert("请填写考勤年度，考勤年度不能为空！") ;
        return false ;
     }
     if(wagemonth ==null||wagemonth==''){
         alert("请填写工资期间，工资期间不能为空！") ;
        return false ;
     }
      if(wageyear ==null||wageyear==''){
         alert("请填写工资年度，工资年度不能为空！") ;
        return false ;
      }
     if(begindate ==null||begindate==''){
        alert("请填写起始日期，起始日期不能为空！") ;
        return false ;
     }
      if(enddate ==null||enddate==''){
        alert("请填写终止日期，终止日期不能为空！") ;
        return false ;
     }
     if (isNaN(timemonth)){
         alert("请正确填写考勤期间！") ;
           return false ;
     }
     if (isNaN(timeyear)){
         alert("请正确填写考勤年度！") ;
           return false ;
     }
     if (isNaN(wagemonth)){
         alert("请正确填写工资期间！") ;
           return false ;
     }
     if (isNaN(timemonth)){
         alert("请正确填写考勤期间！") ;
           return false ;
     }
     

    $id("myform").submit() ;
}
  //客户名称
      function rtnFuncCustomer_s(arg){
        var lookup = $id("cust_name_s");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        $id("cust_id").value =arg[0] ;
        return false;
    }
    
    function winclose(){
        window.close() ;
    }
</script>
</head>
<body>
<form name="myform" method="post"  action="/FAERP/SpperiodAction.do?cmd=insert" id="myform" >
<div id="right">
    <div class="right_title_bg"><div class=" right_title">考勤期间新增</div></div>
    <div class="ringht_x">
    <!--表格 -->
        <div class="box_xinzeng" style="height:420px">
        <div class="xz_title">基本信息</div>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1">客户名称</td>
            <td class="td_2">
            <w:lookup onReturnFunc="rtnFuncCustomer_s" readonly="false" id="cust_name_s" name="cust_name_s" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/> 
            <input type="hidden" value="" class="xText" id="cust_id" name="cust_id"/>
            </td>
            <td class="td_1">考勤年度</td>
            <td class="td_2"><input type="text" value="" class="xText" id="timeyear" name="timeyear" maxlength="4"/></td>
          </tr>
          <tr>
            <td class="td_1">考勤期间</td>
            <td class="td_2"><input type="text" value="" class="xText" id="timemonth" name="timemonth" maxlength="2"/></td>
            <td class="td_1">工资年度</td>
            <td class="td_2"><input type="text" value="" class="xText" id="wageyear" name="wageyear" maxlength="4"/></td>
          </tr>
          <tr>
            <td class="td_1">工资期间</td>
            <td class="td_2"><input type="text" value="" class="xText" id="wagemonth" name="wagemonth" maxlength="2"/></td>
            <td class="td_1">起始日期</td>
            <td class="td_2">
            <w:date allowInput="false" id="begindate" name="begindate" format="yyyy-MM-dd" style="width:165px;"/>
            </td>
          </tr>
          <tr>
            <td class="td_1">终止日期</td>
            <td class="td_2">
            <w:date allowInput="false" id="enddate" name="enddate" format="yyyy-MM-dd" style="width:165px;"/>
            </td>
            <td class="td_1"></td>
            <td class="td_2"></td>
          </tr>
          </table>
    <!--表格 end-->   <br/> <br/> <br/> <br/>
     <div style = "text-align: center;">
        <input type="button" class="icon_2" value="保存" onclick="javascript:goto_submit();"/>
        <input type="button" class="icon_2" value="关闭" onclick="javascript:winclose() ;"/>
     </div>
    </div>
    </div>
</div>
</form>
</body>
</html>
