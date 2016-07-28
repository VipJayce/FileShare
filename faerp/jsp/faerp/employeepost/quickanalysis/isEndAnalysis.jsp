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
.loading {
   
    height: 42px;
  
}
</style>


<%@ taglib uri="http://taglib.gapext.com/tags/html" prefix="h"%>

<h:script src="/js/highcharts-4.0.3/jquery-1.8.3.min.js" />
<!-- highcharts插件 -->
<h:script src="/js/highcharts-4.0.3/highcharts.js" />

<h:script src="/js/highcharts-4.0.3/modules/exporting.js" />
<h:script src="/js/highcharts-4.0.3/idealHighcharts.js" />
<h:script src="/js/highcharts-4.0.3/modules/exporting.js" />
<h:script src="/js/highcharts-4.0.3/idealHighcharts.js" />





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

<div id="right">
<div id="ccChild0" class="search">

<table width="100%" cellspacing="0">
	<tr>
		<td width="130" rowspan="10" style="padding-top: 0;">
		<div class="search_title">查询条件</div>
		</td>
	</tr>
	<tr>
        <td width="20%">员工完成E化入职的统计表格(按客户) </td>
		<td align="right">年：</td>
		<td align="left" width="210">
		            <r:comboSelect id="year_idList_search" name="year_id"
                       queryAction="/FAERP/AnalysisAction.do?cmd=getYears"
                       textField="value"
                       valueField="key"
                       xpath="AnalysisYear"
                       width="200px"
                       messagekey="please_choose"
                       value=""
                        />
		</td>
		<td align="right"  >月：</td>
		<td align="left" width="200"><select class='tableMonthDiv' style="width:150px" id='table_month_id'>
			<option value='0'>--请选择--</option>
			<option value='1'>1</option>
			<option value='2'>2</option>
			<option value='3'>3</option>
			<option value='4'>4</option>
			<option value='5'>5</option>
			<option value='6'>6</option>
			<option value='7'>7</option>
			<option value='8'>8</option>
			<option value='9'>9</option>
			<option value='10'>10</option>
			<option value='11'>11</option>
			<option value='12'>12</option>
		</select></td>
		<td align="right">客户</td>
        <td align="left" width="210">
         <r:comboSelect id="cust_idList_search" name="cust_id"
                       queryAction="/FAERP/AnalysisAction.do?cmd=getCusts"
                       textField="customer_name"
                       valueField="customer_code"
                       xpath="CustomerVo"
                       width="200px"
                       messagekey="please_choose"
                       value=""
                        />
        </td>
        <td align="right"></td>
       <td>
       <input class="icon_1" type="button"   value="查询" id="find_btn">
        </td>
	</tr>
</table>
<!--<div id="myjsonData"><table><tr><td></td></tr></table></div>


-->

<div style="float:rigth;padding-left: 30px; "><table id="list2"></table> <div id="pager2"></div></div>

<table width="100%" cellspacing="0">
    <tr>
        <td width="130" rowspan="10" style="padding-top: 0;">
        <div class="search_title">查询条件</div>
        </td>
    </tr>
	<tr>
	<td>员工完成E化入职统计 </td>
		<td align="right">年：</td>
		<td align="left" width="210">
				
				   <r:comboSelect id="pie_year_idList_search" name="pie_year_id" 
                       queryAction="/FAERP/AnalysisAction.do?cmd=getYears"
                       textField="value"
                       valueField="key"
                       xpath="AnalysisYear"
                       width="200px"
                       messagekey="please_choose"
                       value="${year}"
                        />
		</td>
		<td align="right">月：</td>
		<td align="left" width="210"><select class='pieMonthDiv' id="pie_month_id" class="pieMonthDiv" style="width:150px" >
		   <option value='${month}'>${month}</option>
			<option value='1'>1</option>
			<option value='2'>2</option>
			<option value='3'>3</option>
			<option value='4'>4</option>
			 <option value='5'>5</option>
            <option value='6'>6</option>
            <option value='7'>7</option>
            <option value='8'>8</option>
            <option value='9'>9</option>
            <option value='10'>10</option>
            <option value='11'>11</option>
            <option value='12'>12</option>
		</select></td>
		<td align="right">客户：</td>
		<td align="left" width="210">
		    <r:comboSelect id="pie_cust_idList_search" name="pie_cust_id"
                       queryAction="/FAERP/AnalysisAction.do?cmd=getCusts"
                       textField="customer_name"
                       valueField="customer_code"
                       xpath="CustomerVo"
                       width="200px"
                       messagekey="please_choose"
                         value="${cust_code}"
                        />
		</td>
	</tr>
</table>${requestScope.custname}
</div>

<div id="pie_container"
	style="max-width: 430px; height: 290px; margin: 0px auto"></div>
</div>
</div>


</body>
</html>


<script type="text/javascript"><!--
 if (window.navigator.appName == "Microsoft Internet Explorer")
{
      // 这是一个 IE 浏览器。引擎处于哪种模式下？
      if (document.documentMode) // IE8
         engine = document.documentMode;
      else // IE 5-7
      {
         engine = 8; // 假设为 quirks 模式；除非另外证实是其他模式
         if (document.compatMode)
         {
            if (document.compatMode == "CSS1Compat")
               engine = 8; // 标准模式
         }
      }
      // 引擎变量现在包含文本兼容性模式。
}
    //饼状图
    var MyHighchartsPie = new MyHighcharts({
        chartType:2,
        yUnit:'人',
        renderTo:'pie_container',//div id
        url:"/FAERP/AnalysisAction.do?cmd=getIsEndPieAnalysis"     //ajax URL
        
    });
    
    $(document).ready(function() {
        /**饼图年份及度量下拉框**/
        
        /**单击饼图年份**/
       $("#pie_year_idList_search_input").bind("propertychange", function() { 
            //月份和客户
             var pie_Month = document.getElementById("pie_month_id").value;
             var pie_Cust =document.getElementById("pie_cust_idList_search_hidden").value; 
            //年份
            var pie_year = document.getElementById("pie_year_idList_search_hidden").value;
            //度量类型改变生成饼图
            MyHighchartsPie.draw({param:{pie_Year:pie_year,pie_Month:pie_Month,pie_Cust:pie_Cust}});
        });
        
        /**单击饼图月份度量**/
        $(".pieMonthDiv").change(function(){
            //年份和客户
           var pie_Year =document.getElementById("pie_year_idList_search_hidden").value;
           var pie_Cust = document.getElementById("pie_cust_idList_search_hidden").value; 
            //月份
             var pie_Month =  document.getElementById("pie_month_id").value;
            //度量类型改变生成饼图
            MyHighchartsPie.draw({param:{pie_Year:pie_Year,pie_Month:pie_Month,pie_Cust:pie_Cust}});
        });
               /**单击饼图客户度量**/
         $("#pie_cust_idList_search_input").bind("propertychange", function() { 
            //年份和月份
           var pie_Year = document.getElementById("pie_year_idList_search_hidden").value;
           var pie_Month = document.getElementById("pie_month_id").value;
            //客户
            var pie_Cust = document.getElementById("pie_cust_idList_search_hidden").value; 
            //度量类型改变生成饼图
             MyHighchartsPie.draw({param:{pie_Year:pie_Year,pie_Month:pie_Month,pie_Cust:pie_Cust}});
         //   $('#select_pie_Cust').text(pie_Cust);
         //   $('#select_pie_Cust').attr('title',pie_Cust);
        });
        
        //构建饼图
        MyHighchartsPie.draw({param:{pie_Year:document.getElementById("pie_year_idList_search_hidden").value,pie_Month:document.getElementById("pie_month_id").value,pie_Cust:document.getElementById("pie_cust_idList_search_hidden").value}});


		//table-jqgrid
		jQuery("#list2").jqGrid(
		{ url:'/FAERP/AnalysisAction.do?cmd=getIsEndTableAnalysis', 
		datatype: "json", 
		colNames:['客户code','客户名称','完成人数', '完成占比', '未完成人数','未完成占比','总人数','year','month'], 
		colModel:[
		{name:'customerCode',index:'customerCode', width:80,sortable:false},
		 {name:'customerName',index:'customerName', width:150,sortable:false},
		 {name:'finish',index:'finish', width:50,  align:"right",formatter: endLink,sortable:false}, 
		 {name:'finishPercent',index:'visitPercent',  align:"right",width:50,sortable:false}, 
		 {name:'process',index:'express', width:50, align:"right",formatter: noEndLink,sortable:false}, 
		 {name:'processPercent',index:'expressPercent', width:50, align:"right",sortable:false}, 
		 {name:'all',index:'all', width:50,align:"right",sortable:false},
		 {name:'year',index:'year', width:1,align:"right"},
		 {name:'month',index:'month', width:1,align:"right"}
		 ], 
		autowidth: true,//自动匹配宽度 ,   //设置高度 
		  sortable:true,
		 sortname: 'all',
		  sortorder: 'desc',
		// loadonce:true,
		 rowNum:100, rowList:[10,20,30], pager: '#pager2', sortname: 'id', viewrecords: true, sortorder: "desc" }); 
		 jQuery("#list2").jqGrid('navGrid','#pager2',{edit:false,add:false,del:false,search:false });
        function endLink(cellvalue, options, rowObject) {
             return "<a target='_blank' href =' /FAERP/AnalysisAction.do?cmd=getIsEndShowDetail&type=END&month="+ rowObject['month']+"&year="+ rowObject['year']+"&customerCode="+ rowObject['customerCode']+"'>" + cellvalue +"</a>";
         }
        function noEndLink(cellvalue, options, rowObject) {
             return "<a target='_blank' href =' /FAERP/AnalysisAction.do?cmd=getIsEndShowDetail&type=NOTEND&month="+ rowObject['month']+"&year="+ rowObject['year']+"&customerCode="+ rowObject['customerCode']+"'>" + cellvalue +"</a>";
         }

        jQuery("#list2").setGridParam().hideCol("month").trigger("reloadGrid");
         jQuery("#list2").setGridParam().hideCol("year").trigger("reloadGrid");
      


    });
        //table 查询
        $("#find_btn").click(function(){ 
                var custid =document.getElementById("cust_idList_search_hidden").value; 
                var year =document.getElementById("year_idList_search_input").value; 
                var month =document.getElementById("table_month_id").value; 
               
                  if(custid=="")
                        custid="";
                  if(year=="--请选择--")
                        year="";
                  if(month=="0")
                        month="";
                $("#list2").jqGrid('setGridParam',{ 
                    url:"/FAERP/AnalysisAction.do?cmd=getIsEndTableAnalysis", 
                    postData:{'table_Cust':custid,'table_year':year,'table_month':month}, //发送数据 
                    page:1 
                }).trigger("reloadGrid"); //重新载入 
             }); 

          

--></script>
