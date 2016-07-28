<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<%@ page contentType="text/html; charset=UTF-8"%>

<metahttp-equiv ="X-UA-Compatible" content="IE=EmulateIE8" />
   <%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<link
    href="<%=request.getContextPath()%>/css/jqGrid-4.6.0/jquery-ui-custom.css"
    rel="stylesheet" type="text/css" />
<link
    href="<%=request.getContextPath()%>/css/jqGrid-4.6.0/ui.jqgrid.css"
    rel="stylesheet" type="text/css" />
<link
    href="<%=request.getContextPath()%>/css/jqGrid-4.6.0/ui.multiselect.css"
    rel="stylesheet" type="text/css" />

<style type="text/css">

/* 下拉控件样式 */
SELECT {
    font-family: "Arial";
    font-size: 9pt;
     width: 54px;
}

.ui-jqgrid .ui-jqgrid-sortable {
    cursor: default;
}
BODY {
    /*滚动样式*/
    SCROLLBAR-FACE-COLOR: #e5eef5;
    SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
    SCROLLBAR-SHADOW-COLOR: #b6d5ea;
    SCROLLBAR-3DLIGHT-COLOR: #b6d5ea;
    SCROLLBAR-ARROW-COLOR: #2b7fc1;
    SCROLLBAR-TRACK-COLOR: #ffffff;
    SCROLLBAR-DARKSHADOW-COLOR: #eeeeee;
}
</style>


<%@ taglib uri="http://taglib.gapext.com/tags/html" prefix="h"%>

<h:script src="/js/highcharts-4.0.3/jquery-1.8.3.min.js" />
<h:script src="/js/jqGrid-4.6.0/jquery-ui-1.9.2.custom.min.js" />
<h:script src="/js/jqGrid-4.6.0/jquery.jqGrid.src.js" />
<h:script src="/js/jqGrid-4.6.0/i18n/grid.locale-cn.js" />
<h:script src="/js/jqGrid-4.6.0/jquery.jqGrid.js" />
<h:script src="/js/jqGrid-4.6.0/jqModal.js" />


<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>


</head>
<body>
<table id="list2"></table> <div id="pager2"></div>

</body>
</html>
<script type="text/javascript"><!--
    $(window).bind('resize', function() {
$("#list2").setGridHeight($(window).height()*0.78);
});
    
    $(document).ready(function() {


        //jqgrid
        jQuery("#list2").jqGrid(
        { url:'/FAERP/AnalysisAction.do?cmd=getDjclShowDetailJson&type=${type}&year=${year}&month=${month}&customerCode=${customerCode}', 
        datatype: "json", 
        colNames:['客户code','客户名称','唯一号', '姓名', '证件号','手机号','户籍所在地','户籍类型','入职时间','报入职时间'], 
        colModel:[
        {name:'customerCode',index:'id', width:55},
         {name:'customerName',index:'name asc, invdate', width:155},
         {name:'empCode',index:'invdate', width:90}, 
         {name:'empName',index:'name asc, invdate', width:80}, 
         {name:'idCard',index:'amount', width:100, align:"right"}, 
         {name:'mobile',index:'tax', width:80, align:"right"}, 
         {name:'residentLocation',index:'tax', width:80, align:"right"}, 
         {name:'residentType',index:'tax', width:80, align:"right"}, 
         {name:'applyOnPostDateStr',index:'total', width:80,align:"right"}, 
         {name:'onPostDateStr',index:'total', width:80,align:"right"}], 
         autowidth: true, //自动匹配宽度 ,   //设置高度 
         loadonce:true,
         rowNum:20, rowList:[10,20,30], pager: '#pager2', sortname: 'empCode', viewrecords: true, sortorder: "desc" }); 
         jQuery("#list2").jqGrid('navGrid','#pager2',{edit:false,add:false,del:false,search:false });

    });
    
    
--></script>