<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base target="_self"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>选择发票抬头</title>
	<script language="javascript">
	
	   //选择一条记录
		function select_onClick(){
		    var entity=choose_row("celllist1");
		    var returnAry = new Array();
	        //返回发票抬头
	        returnAry[0] = entity.getProperty("receipt_title");
		    window['returnValue'] =  returnAry;
            window.close();
		}
		
		//查询
		function simpleQuery_onClick(){  //简单的模糊查询
		      $id("celllist1").loadData();
		      $id("celllist1").refresh();
		}
		
		//返回选择的记录
		function choose_row(dcId){
			var dc = $id(dcId);
			var obj = dc.getActiveEntity();
			    if(!obj){
			       alert("请选择一条记录！");
			       return;
			    }
			 return obj;
		}
	</script>
</head>
<body>
   <form name="form" method="post"  id="datacell_formid">
    <div id="ccChild0" class="search">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	            <td width="270" rowspan="3" style="padding-top: 0;">
	                <div class="search_title">查询条件</div> 
	            </td>
	        </tr>
            <tr>
                <td width="166" align="left">发票抬头</td>
                <td width="328" align="left">
                    <input type="text" class="text_field" name="receipt_title" id="receipt_title" inputName="发票抬头"/>            
                </td>
                <td width="378" rowspan="2" align="left"><input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()"></td>
            </tr>
	         
	    </table>
    </div>
    
    <div id="ccParent1" class="button">
	    <div class="button_right">
		    <ul>
		        <li class="g"><a onClick="javascript:select_onClick();">确定</a></li>
		    </ul>
	    </div>
        <div class="clear"></div>
    </div>
    <div  id="div1" style="margin:5 0 0 10px;">
          <r:datacell 
          queryAction="/FAERP/SalcontractAction.do?cmd=searchReceiptTitle&cust_id=${cust_id}"
          id="celllist1"
          paramFormId="datacell_formid" 
          width="97%" height="305px" 
          xpath="CostcenterVo"
          readonly="true"
          >
	        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	        <r:field fieldName="cost_center_name" label="成本中心名称" width="250px">
            </r:field>
	        <r:field fieldName="receipt_title" label="发票抬头" width="250px">
            </r:field>
        </r:datacell>
   </div>
</form>
</body>
</html>
<script type="text/javascript">
$id("celllist1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>
