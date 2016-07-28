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
    
    function count_onclick() {
	     var dc = $id("datacell");
	        var clz = dc.getActiveEntity();
	        if(!clz){
	            alert("请先选择一条记录");
	            return false ;
	        }
                var is_count = clz.getValue("is_count");
                if(is_count =='1'){
	                alert("该期间已经计算，如果要修改请到编辑页面") ;
	                return false ;
                }
                var jzflag = clz.getValue("jzflag");
	            if(jzflag =='1'){
	                alert("该期间已经结账不能再计算") ;
	                return false ;
	           }
    }
    
    
    function toeditpage(){
	      var dc = $id("datacell");
	        var clz = dc.getActiveEntity();
	        if(!clz){
	            alert("请先选择一条记录");
	            return ;
	        }
	               var period_id = clz.getValue("id");
	                var datacell_formid = $id("datacell_formid") ;
	                datacell_formid.action ="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendancecount/spmonthstat/edittSpmonthstat.jsp?period_id="+period_id;
	                datacell_formid.submit();    
    }
    function todetailpage(){
         var dc = $id("datacell");
            var clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }
                   var period_id = clz.getValue("id");
                    var datacell_formid = $id("datacell_formid") ;
                    datacell_formid.action ="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendancecount/spmonthstat/detailSpmonthstat.jsp?period_id="+period_id;
                    datacell_formid.submit();    
    }
    
    function toinputpage(){
         var dc = $id("datacell");
            var clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }
            var period_id = clz.getValue("id") ;
           url="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendancecount/spmonthstat/inputdata.jsp?period_id="+period_id;
           showModalCenter(url, window, callBack, 640, 310, '导入数据');  //增加子岗位
    }
    //导入返回操作
     function callBack(reg){
       return fasel ;
    }
    
    function toerrorpage(){
         var dc = $id("datacell");
            var clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }
            var period_id = clz.getValue("id") ;
           url="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendancecount/spmonthstat/listerrordata.jsp?period_id="+period_id;
           showModalCenter(url, window, callBack, 840, 410, '异常数据');  //增加子岗位
    }
    
    //考勤计算
    function workattendanceCount(){
          var dc = $id("datacell");
          var clz = dc.getActiveEntity();
           if(!clz){
                alert("请先选择一条记录");
                return ;
           }
           var is_count = clz.getValue("is_count");
            if(is_count =='1'){
                    alert("该期间已经计算，如果要修改请到编辑页面") ;
                    return false ;
            }
           var jzflag = clz.getValue("jzflag");
           if(jzflag =='1'){
                    alert("该期间已经结账不能再计算") ;
                    return false ;
          }
          var period_id = clz.getValue("id") ;
          var url ="<%=request.getContextPath()%>/SpmonthstatAction.do?cmd=WorkAttendanceCount&period_id="+period_id ;
            jQuery.ajax({
                   url: url,
                  type: 'post',
                  dataType: 'html',
                  timeout: 80000,
                  error: function(){
                      alert('系统编译错误！');
                      return  null;
                  },
                  success: function(text){
                     alert(text) ;
                  }
                  });
    }
    </script>
</head>
<body>
<form name="form" action="" id="datacell_formid" method="post"> 
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">考勤计算</div></div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="135" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div></td>
        <td width="80">考勤年月</td>
        <td width="220"><input type="text" class="sText" id="timeyearmonth" name="timeyearmonth"/></td>
        <td width="80">客户名称</td>
        <td width="220">
<w:lookup onReturnFunc="rtnFuncCustomer_s" readonly="true" id="cust_name_s" name="cust_name_s" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/> 
           <input type="hidden" name="cust_id" id="cust_id">
</td>
        <td width="80">客户编号</td>
        <td  width="220"><input type="text" class="sText" name="cust_code" id="cust_code"/></td>
      </tr>
      <tr>
        <td>工资年月</td>
        <td><input type="text" class="sText" id="sayearmonth" name="sayearmonth"/></td>
        <td>结帐标志</td>
        <td><select name="s_jzflag" class="sSelect" id="s_jzflag" >
          <option value="">请选择</option>
          <option value="1">已结账</option>
          <option value="0">未结账</option>
        </select>
        </td>
        <td>计算标志</td>
        <td><select name="s_is_count" class="sSelect" id="s_is_count" >
          <option value="">请选择</option>
          <option value="1">已计算</option>
          <option value="0">未计算</option>
        </select>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="center"><input type="button" class="icon_1" value="查询" onclick="search_onclick();" />&nbsp;&nbsp;&nbsp;<input type="reset" class="icon_1" value="重置" />
        </td>
      </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--按钮-->
        <div class="button">    
            <div class="button_right">
                <ul>
                    <li class="bl_1"><a onclick="workattendanceCount() ;">考勤计算</a></li>
                    <li class="bl_1"><a onclick="toeditpage();">编辑数据</a></li>
                    <li class="a_1"><a onclick="todetailpage();">明细数据</a></li>
                    <li class="e"><a onClick="toinputpage() ;" >导入</a></li> 
                    <li class="p_1"><a onclick="toerrorpage();">异常数据</a></li>
                </ul>
        </div>
            <div class="clear"></div>
        </div>
    <!--按钮 end-->
    <!--表格 -->
    <div style="padding: 5 0 8 8;">
       <r:datacell 
        id="datacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/SpperiodAction.do?cmd=queryAllByMonthStat"
        width="98%"
        height="318px"
        xpath="SpperiodVo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="customer_name" label="客户名称" width="200px">
            </r:field>
            <r:field fieldName="customer_code" label="客户编号" width="150px">
            </r:field>
            <r:field fieldName="timeyear" label="考勤年度" width="100px">
            </r:field>  
            <r:field fieldName="timemonth" label="考勤月" width="100px">
            </r:field>              
            <r:field fieldName="wageyear" label="工资年度" width="130px">
            </r:field>        
              <r:field fieldName="wagemonth" label="工资月" width="130px">
            </r:field>      
            <r:field fieldName="begindate" label="起始日期" width="100px">
            <w:date format="yyyy-MM-dd" disabled="true"/>
            </r:field>          
            <r:field fieldName="enddate" label="终止日期" width="130px">
            <w:date format="yyyy-MM-dd" disabled="true"/>
            </r:field> 
            <r:field fieldName="jzflag" label="结帐标志" width="130px">
            <h:select property="jzflag" disabled="true">
                         <h:option value="1" label="已结账"/>
                         <h:option value="0" label="未结账"/>
              </h:select>
            </r:field>   
            <r:field fieldName="is_count" label="计算标志" width="130px">
            <h:select property="is_count" disabled="true">
                         <h:option value="1" label="已计算"/>
                         <h:option value="0" label="未计算"/>
              </h:select>
            </r:field>          
    </r:datacell>
</div>
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>

