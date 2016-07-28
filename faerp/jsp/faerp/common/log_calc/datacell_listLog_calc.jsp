<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.common.log_calc.log_calc_resource" prefix="rayoo.common.log_calc.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_log_calc'/></title>
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
    	if(arg[0]==null||arg[0]==''){
    	   return false ;
    	}
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
        $id("celllist1").isQueryFirst = false;
});

function  xiangxi(){
            dc = $id("celllist1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("<fmt:message key='alert_select_one'/>");
                return ;
            }

             var url="<%=request.getContextPath()%>/Log_calcAction.do?cmd=detail1&id="+clz.getValue("id")+"&aa=a"; 
             url=url+'&_ts='+(new Date()).getTime(); 
             showModalCenter(url, window, "", 700, 390, "<fmt:message key='title_detail'/>");  //增加子岗位

            
}
//异常账单处理
function  exception_status(){
			 if(!confirm("<fmt:message key='alert_update_status'/>")) {
			      return false ;
			 }
            dc = $id("celllist1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("<fmt:message key='alert_select_one'/>");
                return ;
            }
            if(clz.getValue("status") =="结束"){
                alert("<fmt:message key='alert_close_status'/>") ;
                return false ;
            }
            
             var url="<%=request.getContextPath()%>/Log_calcAction.do?cmd=updateExceptionStatus&id="+clz.getValue("id");      
            jQuery.ajax({
                   url: url,
                  type: 'post',
                  dataType: 'html',
                  error: function(){
                      alert("<fmt:message key='alert_sys_err'/>");
                      return  null;
                  },
                  success: function(text){
                      if(text!=null){       
                        alert(text);
                       queryall() ;
                      }
                  }
                  });
                  
}


            
</script>
</head>
<body>
<form name="form" action="" method="post" id="datacell_formid"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key='title_log_calc'/></div>
	</div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
            <td width="138" rowspan="5" style="padding-top:0;"><div class="search_title"><fmt:message key='title_query'/></div> </td>
          
            <td width="76"/>
            <td width="281"/>
              <td width="78">    </td>
                <td width="270"/>
        </tr>
  <tr>
   <td align="right"><fmt:message key='select_customer'/></td>
		<td class="td_2">
		<w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
			id="customer_id" name="customer_id" property="customer_id"
			displayProperty="customer_name"
			lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
			messagekey="select_customer" height="450" width="610" style="width:172px"  />
		</td>
		<td align="right"><fmt:message key='cost_center'/></td>
		<td align="left">
		<r:comboSelect id="cost_center_id"
			name="cost_center_id"
			queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			textField="cost_center_name" valueField="id" xpath="CostcenterVo"
		 width="190" >
		</r:comboSelect>
		</td>
        <td align="right"><fmt:message key='bill_year_month'/></td>
    <td width="212"><input type="text" value="" class="sText"
			id="bill_year_month" name="bill_year_month" /></td>
  </tr>
  <tr>
    <td align="right"><fmt:message key='starttime'/></td>
    <td align="left"><w:date format="yyyy-MM-dd" id="starttime" name="starttime" width="173px" readonly="true"/></td>
            
    <td align="right"><fmt:message key='endtime'/></td>
    <td align="left"><w:date format="yyyy-MM-dd" id="endtime" name="endtime" width="173px" readonly="true"/></td>

	 <td align="right"><fmt:message key='status'/></td>
     <td align="left">
          <select name='status' style='width:190px' id='status' >
		  <option value=""  selected ><fmt:message key='please_select'/></option>
		  <option value="0" ><fmt:message key='status_0'/></option>
		  <option value="1" ><fmt:message key='status_1'/></option>
		  </select>
	</td>
  </tr>
  <tr>
    <td align="right"><fmt:message key='username'/></td>
    <td align="left">
		<input type="text" class="sText" value="" name="username"/>
   </td>
     <td align="left">业务类型：</td>
        <td align="left">
        	<d:select  name="resource_type" id="resource_type" dictTypeId="LOG_RESOURCE_TYPE" nullLabel="--请选择--" style="width:190px"/>
        </td>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="button" class="icon_1" value="<fmt:message key='button_query'/>" onClick="queryall()"/>
     <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key='button_reset'/>' onClick="javascript:this.form.reset();queryall();">
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
        <input class="h_2" type="button"   value="<fmt:message key='button_xiangxi'/>" onClick="xiangxi()" />
        <input class="h_2" type="button"   value="<fmt:message key='button_exception_status'/>"  onClick="exception_status()" />
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/Log_calcAction.do?cmd=queryForList"
			paramFormId="datacell_formid" width="99%" height="318px"
			xpath="Log_calcVo" readonly="true" pageSize="50">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<r:field fieldName="customer_code" messagekey="customer_code" width="70px">
				<h:text />
			</r:field>
			 <r:field fieldName="customer_name" messagekey="customer_name" width="180px">
                <h:text />
            </r:field>
			<r:field fieldName="cost_center_name" messagekey="cost_center" width="180px">
				<h:text />
			</r:field>
			<r:field fieldName="bill_year_month" messagekey="bill_year_month" width="70px">
				<h:text />
			</r:field>
			<r:field fieldName="username" messagekey="username" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="starttime" messagekey="starttime" width="140px">
				<w:date format="yyyy-MM-dd HH:mm:ss" />
			</r:field>
			<r:field fieldName="endtime" messagekey="endtime" width="140px">
                <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
			<r:field fieldName="status" messagekey="status" width="70px">
				<h:text />
			</r:field>
			<r:field fieldName="endmsg" messagekey="endmsg" width="300px">
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
</fmt:bundle>
</html>
