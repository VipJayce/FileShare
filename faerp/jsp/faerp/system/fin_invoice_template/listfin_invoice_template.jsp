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

         function add_template() { 
            var url="<%=request.getContextPath()%>/jsp/faerp/system/fin_invoice_template/insertFin_invoice_template.jsp";
            url=url+"?_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, retCallback, 850, 200, "新增模板");  //增加子岗位
		 }
		 
         function edit_template() { 
            var entity=choose_row_public("celllist1");
            var url="<%=request.getContextPath()%>/Fin_invoice_templateAction.do?cmd=editDataPageByID&id=" + entity.getValue("id");
            url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, retCallback, 850, 200, "修改模板");  //增加子岗位
         }
		 
		 function retCallback() {
		      $id("celllist1").loadData();
              $id("celllist1").refresh();
		 }
		 
		 
		 function template_configuration(){
		 var entity=choose_row_public("celllist1");
          var url = "<%=request.getContextPath()%>/Fin_invoice_templateAction.do?cmd=showDataPageByID&id=" + entity.getValue("id");
          window.location.href = url;
		 }
		 
		 function toDelete_onClick() {
	       if(!confirm('确定要删除所选择的记录么?')){
               return false;
            }
	        var entity=choose_row_public("celllist1");
	        var url="<%=request.getContextPath()%>/Fin_invoice_templateAction.do?cmd=deleteData&id=" + entity.getValue("id");
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
		 
		 
		 function copy_onClick() {
           if(!confirm('您确定要复制所选择的模板么?')){
               return false;
            }
            var entity=choose_row_public("celllist1");
            var url="<%=request.getContextPath()%>/Fin_invoice_template_itemAction.do?cmd=copyData&id=" + entity.getValue("id");
            url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            jQuery.post(url,function(data){
                if(data){
                        if(data!=""){
                            alert(data);
                        }else{
                            alert("操作失败！");
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
	  <div class=" right_title">发票模板查询</div>
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
   <td align="right">模板名称</td>
		<td class="td_2">
		<input type="text" class="sText" value="" name="template_name"/>
		</td>
		<td align="right">创建人</td>
		<td align="left">
        <input type="text" class="sText" value="" name="create_user_id"/>
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
        <input class="h_1"  id="h_1"  type="button"   value="新增模板" onclick="add_template();"/>
         <input class="b_1"  id="h_1"  type="button"   value="修改模板" onclick="edit_template();"/>
        <input class="bl_3"  id="h_1"  type="button"   value="模板配置" onclick="template_configuration();"/>
        <input class="d" type="button"   value="删除" onClick="javascript:toDelete_onClick();">
        <input class="e_2" type="button"   value="复制模板" onClick="javascript:copy_onClick();">
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/Fin_invoice_templateAction.do?cmd=getListBySimpleQuery"
			paramFormId="datacell_formid" width="99%" height="308px"
			xpath="Fin_invoice_templateVo" readonly="true" pageSize="10">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<r:field fieldName="template_name" label="模板名称" width="250px">
				<h:text />
			</r:field>
		    <!--<r:field fieldName="is_display_year_month" label="是否显示账期" width="150px">
                <d:select dictTypeId="TrueOrFalse"></d:select>
            </r:field>-->
			 <r:field fieldName="create_user_id" label="创建人" width="150px">
                <h:text />
            </r:field>
			<r:field fieldName="create_date" label="创建时间" width="150px">
                <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
            <r:field fieldName="template_remark" label="模板备注" width="300px">
                <h:text />
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
