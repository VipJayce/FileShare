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

function  xiangxi(){
            dc = $id("celllist1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }

             var url="<%=request.getContextPath()%>/Log_calcAction.do?cmd=detail1&id="+clz.getValue("id")+"&aa=a"; 
             url=url+'&_ts='+(new Date()).getTime(); 
             showModalCenter(url, window, "", 700, 390, "查看详细");  //增加子岗位

            
}

 function toAdd_onClick() {  //到增加记录页面
     form.action="<%=request.getContextPath()%>/jsp/faerp/u8/u8_product_master_subjcom/insertU8_product_master_subjcom.jsp";
     form.submit();
 }
 
 
        //选择一级科目回调方法
        function rtnFuncSubjcode(arg){
            var lookup = $id("subjcode");
            lookup.value = arg[2];
            lookup.displayValue = arg[1];
            return false;
        }
        
        function rtnFunc(arg){
            var lookup = $id("voucher_remark_id");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            return false;
        }
        
        
         //添加一级科目
         function add_subjcode() { 
            var url="<%=request.getContextPath()%>/jsp/faerp/u8/u8_product_master_subjcom/insertU8_product_master_subjcom.jsp";
            url=url+"?_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, retCallback, 850, 240, "凭证与一级科目对照设置");  //增加子岗位
		 }
		 
		 function retCallback() {
		      $id("celllist1").loadData();
              $id("celllist1").refresh();
		 }
		 
		 
		 function add_subproject(){
		 var entity=choose_row_public("celllist1");
          var url = "<%=request.getContextPath()%>/U8_product_master_subjcomAction.do?cmd=showAddSubprojectPageByID&id=" + entity.getValue("id")+"&classtype=" + entity.getValue("classtype");
          window.location.href = url;
		 }
		 
		 function toDelete_onClick() {
	       if(!confirm('确定要删除所选择的记录么?')){
               return false;
            }
	        var entity=choose_row_public("celllist1");
	        var url="<%=request.getContextPath()%>/U8_product_master_subjcomAction.do?cmd=deleteData&id=" + entity.getValue("id");
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
	  <div class=" right_title">凭证与科目对照设置查询</div>
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
   <td align="right">选择凭证</td>
		<td class="td_2">
		<w:lookup onReturnFunc="rtnFunc" readonly="true"  id="voucher_remark_id" name="voucher_remark_id"
            lookupUrl="/U8_voucher_remarkAction.do?cmd=queryAllVoucherPage"
            dialogTitle="选择凭证" height="450" width="850" style="width:188px" />
		</td>
		<td align="right">选择一级科目</td>
		<td align="left">
        <w:lookup onReturnFunc="rtnFuncSubjcode" readonly="true"  id="subjcode" name="subjcode"
            displayProperty="subject_name"  lookupUrl="/U8_subjectAction.do?cmd=getQueryPage"
            dialogTitle="选择科目" height="450" width="850" style="width:188px" />  
        </td>
        <td align="right"> 时间节点</td>
    <td width="212"><d:select dictTypeId="TIME_NODE" id="time_node" name="time_node" nullLabel="--请选择--"></d:select></td>
  </tr>
  <tr>
    <td align="right">对照生效日期</td>
    <td align="left"><w:date format="yyyy-MM-dd" id="startend" name="startend" width="188px" readonly="true"/></td>
            
    <td align="right">对照失效日期</td>
    <td align="left"><w:date format="yyyy-MM-dd" id="enddate" name="enddate" width="188px" readonly="true"/></td>

	 <td align="right">创建人</td>
     <td align="left">
          <input type="text" class="sText" value="" maxLength="50" name="username" style="width: 200px"/>
	</td>
  </tr>
  <tr>
    <td align="right"></td>
    <td align="left">
   </td>
     <td align="left"></td>
        <td align="left">
        </td>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="button" class="icon_1" value="查询" onClick="queryall()"/>
     <input name="button_reset2" class="icon_1" type="button" value='重置' onClick="javascript:this.form.reset();queryall();">
    </div></td>
  </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right">
        <!--<ul>
           <li class="b_1"><a href="javascript:void(0);" onClick="list2approvalItem()">查看明细</a></li>
        </ul>
        -->
        <input class="h_2"  id="h_1"  type="button"   value="添加一级科目" onclick="add_subjcode();"/>
        <input class="bl_3"  id="h_1"  type="button"   value="添加子项" onclick="add_subproject();"/>
        <input class="d" type="button"   value="删除" onClick="javascript:toDelete_onClick();">
        <!--  <input class="h_2" type="button"   value="查看详细" onClick="xiangxi()">  -->
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/U8_product_master_subjcomAction.do?cmd=getListBySimpleQuery"
			paramFormId="datacell_formid" width="99%" height="308px"
			xpath="U8_product_master_subjcomVo" readonly="true" pageSize="10">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<r:field fieldName="voucher_name" label="凭证名称" width="200px">
				<h:text />
			</r:field>
			 <r:field fieldName="subjcode" label="一级科目编码" width="100px">
                <h:text />
            </r:field>
            <r:field fieldName="ccode_name" label="一级科目名称" width="100px">
                <h:text />
            </r:field>
			<r:field fieldName="startend" label="对照生效日期" width="90px">
				<w:date format="yyyy-MM-dd" />
			</r:field>
			<r:field fieldName="enddate" label="对照失效日期" width="90px">
				<w:date format="yyyy-MM-dd" />
			</r:field>
			<r:field fieldName="username" label="创建人" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="create_date" label="创建时间" width="130px">
                <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
			<r:field fieldName="classtype" label="凭证类型" width="70px">
				<h:select name="classtype1" property="classtype1">
                <h:option value="0" label="借方"></h:option>
                <h:option value="1" label="贷方"></h:option>
                </h:select>
			</r:field>
            <r:field fieldName="mark" label="备注" width="220px">
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
