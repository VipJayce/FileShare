<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
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
	function insert_onClick(){  //插入单条数据
	 if(checkAllForms()){
	 var lk_u8_cust=document.form.lk_u8_cust.value;
	  var lk_cust=document.form.lk_cust.value;
	    var effect_date = document.getElementById("startdate").value;
    var lapse_date = document.getElementById("enddate").value;
    var bus_type = document.getElementById("bus_type").value;
	     if(lk_u8_cust==""||lk_u8_cust==null){
	     alert("u8客户不能为空");
	     return;
	     }
    if(lk_cust==""||lk_cust==null){
         alert("ERP客户不能为空");
         return;
         }
         if(effect_date==""||effect_date==null){
         alert("生效日期不能为空");
         return;
         }
                if( lapse_date==""|| lapse_date==null){
         alert("截至日期不能为空");
         return;
         }
           if(effect_date!=""||effect_date.trim().length!=0&&lapse_date!=""||lapse_date.trim().length!=0){
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
	    
		  var param=jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/U8_custcompAction.do?cmd=insert&"+param;
        jQuery.post(url,function(msg){
         if(msg==""){
           alert("保存成功！");
           window.close();
         }else{
           alert(msg);
           return;
                //window.close();
         }
        })
	
	}
}
function checklength(obj) {
        var max = obj.maxlength; 
        if(max == null || max == "" || max == undefined) {
            return;
        }
        if(obj.value.length > max) {
            alert("请不要超过最大长度200个字符:" + max);
            obj.value=obj.value.substring(0,(max-1));
            return;
        }
    }
    function cancel_onClick(){  //取消后返回列表页面
      window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
 <div class="ringht">
<div id="ccChild1"     class="box_xinzeng"  style="height: 150px"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
<tr>
        
          <td class="td_1" ><span class="style_required_red">* </span>U8客户名称</td>
           <td align="left" class="td_2">
                <w:lookup readonly="true" id="lk_u8_cust"  name="lk_u8_cust"
                 lookupUrl="/FAERP/U8_customerAction.do?cmd=getAllU8CustomerByCondition" style="width:180px" dialogTitle="选择客户"
                 height="450" width="610"
                >
                </w:lookup>
                <input type="hidden" id="custcode_u8" name="custcode_u8" >
            </td>
      
			<td class="td_1" ><span class="style_required_red">* </span>ERP客户名称</td>
			<td align="left" class="td_2"><w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust"
            lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" style="width:180px"
            dialogTitle="选择客户" height="450" width="610" /> <input id="custid_erp"
            name="custid_erp" type="hidden" /></td>
              </tr>

        <tr>
        
	
			<td class="td_1" ><span class="style_required_red">* </span>生效日期</td>
			<td class="td_2 ">
				   <w:date allowInput="true" id="startdate" name="startdate" format="YYYY-MM-DD" property="bean/startdate" width="180px"/>  
			</td>
		    <td class="td_1" ><span class="style_required_red">* </span>截止日期</td>
            <td class="td_2 ">
               <w:date allowInput="true" id="enddate" name="enddate" format="YYYY-MM-DD" property="bean/enddate" width="180px"/>        
            </td>
			 </tr>
    		<tr>
    			<td class="td_1">业务类型</td>
				<td class="td_2"><d:select name="bus_type" id="bus_type" dictTypeId="BUS_TYPE" nullLabel="--请选择--" style="width: 197px"/></td>	
				<td class="td_1">开票属性</td>
				<td class="td_2"><d:select name="open_invoice" id="open_invoice" dictTypeId="OPEN_INVOICE" value="0" style="width: 197px"/></td>
    		</tr>
    		<tr>
                <td class="td_1">凭证属性</td>
                <td class="td_2" colspan="3"><d:select name="voucher_class" id="voucher_class" dictTypeId="VOUCHER_CLASS" value="0" style="width: 197px"/></td>
            </tr>
  
           <tr>
			<td class="td_1" >备注</td>

			 <td colspan="3" class="td_2"><textarea class="xText_d"  onkeydown="checklength(this);" rows="2" name="remark" inputName="备注" style="width: 96%"></textarea></td>
        </tr>
			</td>
			</tr>
	</table> 
        </div> 
    <div class="foot_button" >
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>

    </div> 
       </div>  
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
    _$("#custid_erp").val(returnValue[0]);
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    
    return false;
}
$id("lk_u8_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_u8_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
    _$("#custcode_u8").val(returnValue[1]);
    return false;
}

</script>
