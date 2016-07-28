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
    <title>考勤期间</title>
<script type="text/javascript">
    
     //到添加页面
        function toinsert_pop()
        {
              url="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendancerule/spperiod/insertSpperiod.jsp";
              showModalCenter(url, window, '', 800, 430, '新增考勤期间');  
        }
       //到修改页面
         function toupdate_pop()
        {     
             var dc = $id("datacell");
             var entity = dc.getActiveEntity();
             if(!entity){
	            alert("请先选择一条记录");
	            return ;
	        }
             var period_id = entity.getValue("id");
              url="<%=request.getContextPath()%>/SpperiodAction.do?cmd=detail&id="+period_id;
              showModalCenter(url, window, '', 800, 430, '新增考勤修改');  
        }
       
       //客户名称
      function rtnFuncCustomer_s(arg){
        var lookup = $id("cust_name_s");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        $id("cust_id").value =arg[0] ;
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
	        var period_id = clz.getValue("id");
	        var datacell_formid = $id("datacell_formid") ;
	        datacell_formid.action ="<%=request.getContextPath()%>/SpperiodAction.do?cmd=delete&id="+period_id;
	        datacell_formid.submit();    
        }else {
            return false ;
        }
        
    }
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
    <script language="javascript">
        writeTableTopFesco('考勤期间','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="146" valign="top"><div class="search_title">查询条件</div></td>
        <td width="99">客户名称</td>
        <td width="200"> <w:lookup onReturnFunc="rtnFuncCustomer_s" readonly="true" id="cust_name_s" name="cust_name_s" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/> 
           <input type="hidden" name="cust_id" id="cust_id">
           </td>
        <td width="90">考勤期间</td>
        <td width="200"><input name="timemonth" type="text" class="sText" id="timemonth" value="" maxLength="2"/></td>
        <td width="78">考勤年度</td>
        <td width="200"><input name="timeyear" type="text" class="sText" id="timeyear" value="" maxlength="4"/></td>
        <td width="65">&nbsp;</td>
        <td width="218"><input name="submit2" type="button" class="icon_1" value="查询" onclick="search_onclick() ;"/></td>
      </tr>
      </table>
</div>


<div class="button">
            <div class="button_right">
                <ul>
                  <li class="c"><a onClick="javascript:toinsert_pop();">新增</a></li>
                  <li class="b"><a onClick="javascript:toupdate_pop();">修改</a></li>
                  <li class="d"><a onClick="javascript:delete_onclick();">删除</a></li>                      
                </ul>
            </div>
            <div class="clear"></div>
        </div>

<div style="padding: 5 0 8 8;">
       <r:datacell 
        id="datacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/SpperiodAction.do?cmd=queryAll"
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
            <r:field fieldName="timemonth" label="考勤期间" width="100px">
            </r:field>              
            <r:field fieldName="wageyear" label="工资年度" width="130px">
                    
            </r:field>        
              <r:field fieldName="wagemonth" label="工资期间" width="130px">
            </r:field>      
            <r:field fieldName="begindate" label="起始日期" width="100px">
            <w:date format="yyyy-MM-dd" disabled="true"/>
            </r:field>          
            <r:field fieldName="enddate" label="终止日期" width="130px">
            <w:date format="yyyy-MM-dd" disabled="true"/>
            </r:field> 
    </r:datacell>
</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

