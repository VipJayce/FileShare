<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>无标题文档</title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
.fex_row_top
 {
  top:expression(document.getElementById('div_top').scrollTop-2); 
     position:relative; 
     z-index:1;
     background-color: #DEE7FE;
 }
</style>
<script language="JavaScript" src="../../scripts/common.js"></script>
<script type="text/javascript">
	var _jQuery = window.jQuery, _$ = window.$;
	jQuery.noConflict();
	function rtnFuncCustomer(arg){
		
    	var lookup = $id("customer_id");
    	lookup.value = arg[0];
    	lookup.displayValue = arg[2];
    	$id("cost_center_id").addParam("cust_id", arg[0]);
       	$id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
    	return false;
	}
	

	//end
	function queryall(){
        $id("celllist1").loadData();
        $id("celllist1").refresh();
	}


_$(document).ready(function() {
        //$id("celllist1").isQueryFirst = false;
});

         function add_code() { 
            var url="<%=request.getContextPath()%>/jsp/faerp/system/fin_invoice_code/insertFin_invoice_code.jsp";
            url=url+"?_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, retCallback, 850, 250, "新增code");  //增加子岗位
		 }
		 
         function edit_code() { 
            var entity=choose_row_public("celllist1");
            var url="<%=request.getContextPath()%>/FIN_INVOICE_CODEAction.do?cmd=editDataPageByID&id=" + entity.getValue("id");
            url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, retCallback, 850, 200, "修改code");  //增加子岗位
         }
		 
		 function retCallback() {
		      $id("celllist1").loadData();
              $id("celllist1").refresh();
		 }
		 
		 
		 function toDelete_onClick() {
	       if(!confirm('确定要删除所选择的记录么?')){
               return false;
            }
	        var entity=choose_row_public("celllist1");
	        var url="<%=request.getContextPath()%>/FIN_INVOICE_CODEAction.do?cmd=deleteData&id=" + entity.getValue("id");
	        url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            jQuery.post(url,function(data){
                if(data){
                        if(data!=""){
                            alert(data);
                        }else{
                            alert("删除失败！");
                        }
                 }
             });
             $id("celllist1").loadData();
             $id("celllist1").refresh();
		 }
		 
		 
            
</script>
</head>
<body>
<form name="form" action="" method="post" id="datacell_formid"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">发票code查询</div>
	</div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
            <td width="138" rowspan="5" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td width="76"/>
            <td width="281"/>
              <td width="78">    </td>
                <td width="270"/>
        </tr>
  <tr>
   <td align="right">项目名称</td>
		<td class="td_2">
		<input type="text" class="sText" value="" name="subjects_name"/>
		</td>
		<td align="right">创建人</td>
		<td align="left">
        <input type="text" class="sText" value="" name="username"/>
        </td>
        <td align="right">
	   <div align="center">
	      <input type="button" class="icon_1" value="查询" onClick="queryall()"/>
	     <input name="button_reset2" class="icon_1" type="button" value='重置' onClick="javascript:this.form.reset();queryall();">
	    </div>
    </td>
  </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right">
        <input class="h_1"  id="h_1"  type="button"   value="新增code" onclick="add_code();"/>
         <input class="b_1"  id="h_1"  type="button"   value="修改code" onclick="edit_code();"/>
        <input class="d" type="button"   value="删除" onClick="javascript:toDelete_onClick();">
      </div>
      <div class="clear"></div>
    </div><!--  fieldName="fin_subjects_bd" label="财务科目代码"   -->
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/FIN_INVOICE_CODEAction.do?cmd=getListBySimpleQuery"
			paramFormId="datacell_formid" width="99%" height="308px"
			xpath="FIN_INVOICE_CODEVo" readonly="true" pageSize="10">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<r:field fieldName="fin_subjects_bd" label="财务开票编码" width="100px">
			</r:field>
			<r:field fieldName="name" label="财务科目名称" width="140px">
            </r:field>
            <r:field fieldName="subjects_code" label="项目代码" width="100px">
            </r:field>
            <r:field fieldName="subjects_name" label="项目名称" width="200px">
            </r:field>
            <r:field fieldName="bill_year_month" label="账期" width="100px">
            </r:field>
			 <r:field fieldName="username" label="创建人" width="120px">
                <h:text />
            </r:field>
			<r:field fieldName="create_date" label="创建时间" width="150px">
                <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
		</r:datacell>
		</div>
		</div>
    <!--表格 end-->
    <!--翻页 --><!--翻页 end-->
    </div>
</form>
</body>
</html>
