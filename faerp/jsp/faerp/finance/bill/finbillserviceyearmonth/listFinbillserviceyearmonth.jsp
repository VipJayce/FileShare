<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
var jq = jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.bill.billmodify.billmodify_resource" prefix="rayoo.finance.bill.billmodify.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='title_billmodify'/></title>
	<script language="javascript" src="<venus:base/>/jsp/faerp/finance/bill/billmodify/billmodifypage.js"></script>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
    <script type="text/javascript">
    function save_onclick(){
      $id("datacell").submit() ;
      $id("datacell").refresh();
    }
    function close_onclick(){
		   // var Me = $id("datacell");
           // var rows = Me.allTR ;
           // for (var i=0;i<rows.length;i++ ){
           //   var cells = rows[i].cells;
           //   var amountName = "" ;
           //   for (var j=0;j<cells.length;j++ ){
           //     var cell = cells[j];
           //     var field = Me.getField(cell);
           //     var  entity = $id("datacell").getEntityByCell(cell) ;
           //     if(field.fieldName.indexOf("year_month") > 0){
           //         var  entity = $id("datacell").getEntityByCell(cell) ;
           //         if(entity.getValue("start_year_month")==null||entity.getValue("end_year_month")==null||entity.getValue("start_year_month")==''||entity.getValue("end_year_month")==''){
           //           	alert("开始时间和结束时间都不能为空！") ;
           //           	return false  ;
           //         }
            //    }
            //  }
           // }    
            window.close();
       		window.opener.callBack();   
    }
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="cost_center_id" name="cost_center_id" value="<%=request.getParameter("cost_center_id")%>"/>
<input type="hidden" id="bill_year_month" name="bill_year_month" value="<%=request.getParameter("bill_year_month")%>"/>
<div id="right">
<div class="ringht_s">
<div class="button">
    <div class="button_right">
        <!--<ul>
            <li class="b_1"><a href="javascript:void(0);" onclick="list2item();">修改明细</a></li>
        </ul>
        -->
        <input class="b_1" type="button"   value="保存" onclick="save_onclick() ;"  />
         <input class="b_1" type="button"   value="确定生成" onclick="close_onclick() ;"  />
    </div>
    <div class="clear"></div>
</div>
<!-- BillmodifyVo -->
<div style="padding: 5 0 8 8;">
        <r:datacell 
        id="datacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinbillserviceyearmonthAction.do?cmd=queryAll"
        submitAction="/FAERP/FinbillserviceyearmonthAction.do?cmd=update"
        width="98%"
        height="318px"
        xpath="FinbillserviceyearmonthVo"
        readonly="false"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="product_name" label="产品名称" sortAt="server" width="170px">
      </r:field>
      <r:field fieldName="start_year_month" label="开始年月" sortAt="server" width="160px" >
      <h:text />
      </r:field>
      <r:field fieldName="end_year_month" label="结束年月" sortAt="server" width="160px">
      <h:text />
      </r:field>
    </r:datacell>
</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
