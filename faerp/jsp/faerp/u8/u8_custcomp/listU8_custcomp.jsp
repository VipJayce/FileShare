<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

 function detail_onClick(){  //实现转到详细页面
            dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }

             var url="<%=request.getContextPath()%>/U8_custcompAction.do?cmd=detail1&id="+clz.getValue("id"); 
             url=url+'&_ts='+(new Date()).getTime(); 
             showModalCenter(url, window, "", 800, 420, "查看详细");  //增加子岗位
}
    function callBack(reg){ 
            $id("datacell1").loadData();  
            $id("datacell1").refresh();
    }

 function toAdd_onClick() {  //到增加记录页面
     var url="<%=request.getContextPath()%>/U8_custcompAction.do?cmd=toInsert";
             url=url+'&_ts='+(new Date()).getTime(); 
             showModalCenter(url, window, callBack, 750, 250, "增加页面");       
    }
    
    
	function findCheckbox_onClick() {  //到修改页面
	  dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }
        var url="<%=request.getContextPath()%>/U8_custcompAction.do?cmd=find1&id=" + clz.getValue("id");
             url=url+'&_ts='+(new Date()).getTime(); 
             showModalCenter(url, window, callBack, 750, 270, "修改页面");  //增加子岗位
}
   
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 	     dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	var url="<%=request.getContextPath()%>/U8_custcompAction.do?cmd=deleteMulti&ids=" +clz.getValue("id");
	          jQuery.post(url,function(data){
         if(data!=0){
           alert("删除成功！");
               $id("datacell1").loadData();
              $id("datacell1").refresh();
       
         }else{
               alert("删除失败！");
                
         }
        })
    

		}
	}


	function simpleQuery_onClick(){//简单的查询
	
	
	   var effect_date = document.getElementById("startdate").value;
       var lapse_date = document.getElementById("enddate").value;
          if(effect_date!=""&&effect_date.trim().length!=0&&lapse_date!=""&&lapse_date.trim().length!=0 ){
              var beginTime = effect_date;
                            var endTime = lapse_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("截止日期小于生效日期！");
                                return ;
                            }
                            }
	$id("datacell1").loadData();
	$id("datacell1").refresh();
	}
</script>
</head>
<body>

<form name="form" id="U8_custcompFormId" method="post" >
<input type="hidden" id="u8_custcompid" name="u8_custcompid" value="">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('统一编码设置','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
				 <td align="right">U8客户名称</td>
            <td align="left">
                <w:lookup readonly="true" id="lk_u8_cust" validateAttr="allowNull=false;" name="lk_u8_cust"
                 lookupUrl="/FAERP/U8_customerAction.do?cmd=getAllU8CustomerByCondition" style="width:180px" dialogTitle="选择客户"
                 height="450" width="610" />
                  <input type="hidden" id="custcode_u8" name="custcode_u8" >
            </td>
			<td align="right">ERP客户名称</td>
			<td align="left">
			<w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust"
            lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" style="width:180px"
            dialogTitle="选择客户" height="450" width="610" /> 
           <input id="custid_erp"  name="custid_erp" type="hidden" />
			</td>
			<td align="right">业务类型</td>
			<td align="left"><d:select name="bus_type" id="bus_type" dictTypeId="BUS_TYPE" nullLabel="--请选择--" style="width: 197px"/></td>		
		</tr>
		<tr>
			<td align="right">生效日期</td>
			<td align="left">
			<w:date allowInput="true" id="startdate" name="startdate" format="yyyy-MM-dd" property="bean/startdate" width="180px"/>  
			</td>
		  <td align="right">截止日期</td>
            <td align="left">
                <w:date allowInput="true" id="enddate" name="enddate" format="yyyy-MM-dd" property="bean/enddate" width="180px"/>  
            </td>
             <td align="right">开票属性</td>
             <td align="left"><d:select name="open_invoice" id="open_invoice" dictTypeId="OPEN_INVOICE" nullLabel="--请选择--" style="width: 197px"/></td>
		</tr>
		<tr>
		    <td align="right">凭证属性</td>
            <td align="left"><d:select name="voucher_class" id="voucher_class" dictTypeId="VOUCHER_CLASS" nullLabel="--请选择--" style="width: 197px"/></td>
			<td colspan="3" align="right">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
			
				  <input class="a" type="button"   value="<fmt:message key="view"/>" onClick="detail_onClick();">
        <input class="c" type="button"   value="<fmt:message key="insert"/>" onClick="toAdd_onClick();">
        <input class="b" type="button"   value="<fmt:message key="modify"/>" onClick="findCheckbox_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>" onClick="deleteMulti_onClick();">
				
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/U8_custcompAction.do?cmd=searchU8_CustompData"
        width="88%"                                                                     
        height="320px"
        xpath="U8_custcompVo"
        paramFormId="U8_custcompFormId"
      
        >
         <r:toolbar location="bottom" tools="nav,pagesize,info"/>

        <r:field fieldName="custcode_u8" label="U8客户编码"></r:field>
        <r:field fieldName="ccusname" label="U8客户名称" width="165px;"></r:field>
        <r:field fieldName="customer_code" label="ERP客户编码"></r:field>
        <r:field fieldName="customer_name" label="ERP客户名称" width="165px;"></r:field> 
        <r:field fieldName="bus_type" label="业务类型">
        <d:select dictTypeId="BUS_TYPE"/>
        </r:field>      
        <r:field fieldName="startdate" label="生效日期" allowModify="false">   <w:date format="yyyy-MM-dd"/></r:field>
        <r:field fieldName="enddate" label="截止日期" allowModify="false">           <w:date format="yyyy-MM-dd"/></r:field>
        <r:field fieldName="open_invoice" label="开票属性">
        <d:select dictTypeId="OPEN_INVOICE"/>
        </r:field>    
        <r:field fieldName="voucher_class" label="凭证属性" allowModify="false"> 
            <d:select dictTypeId="VOUCHER_CLASS"/>
        </r:field>  
</r:datacell>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
     _$("#custid_erp").val(returnValue[0]);
    return false;
}
$id("lk_u8_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_u8_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
     _$("#custcode_u8").val(returnValue[1]);
    return false;
}
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
   detail_onClick();
   }
</script>	
