<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		//$id("submit2").disabled="disabled" 
		var settlement_date = $id("settlement_date").value;
		var settlement_type_bds = document.getElementsByName("settlement_type_bd");
		var policy_id =  $id("policy_name").value;//魏佳新增，选择的保单id
		var product_type_id =  $id("productid").getValue();//魏佳新增，产品小类
		var settlement_type_bd;
		if(policy_id == "" || policy_id == null || policy_id == "null"){
		    alert("请选择保单！");
            $id("submit2").disabled="" 
            return;
		}
		
		if(settlement_type_bds.length>0){
	       for(var i = 0;i<settlement_type_bds.length;i++){
	          if(settlement_type_bds[i].checked){
	              settlement_type_bd = settlement_type_bds[i].value;
	          }
	       }
	    }  
		if(settlement_date == null || settlement_date == ""){
			alert("请输入结算年月！");
			$id("submit2").disabled="" 
			return;
		}else{
			if(!checkMonth(settlement_date)){      
	           alert('结算年月 要求YYYYMM 格式 ，范围在200001在203012之间！');
	           $id("submit2").disabled="" 
	           return;
	        } 
		}
		
		if(product_type_id == "" || product_type_id == null || product_type_id == "null"){
            alert("请选择产品三级分类！");
            $id("submit2").disabled="" 
            return;
        }
		if(confirm('确定生成数据')) {
			//var action = "<%=request.getContextPath()%>/AddbackapplyAction.do?cmd=insert";
			var url="<%=request.getContextPath()%>/AddbackapplyAction.do?cmd=insert&settlement_date="+settlement_date+"&settlement_type_bd="+settlement_type_bd+"&policy_id="+policy_id+"&product_type_id="+product_type_id;
			jQuery.ajax({
	                  url: url,
	                 type: 'post',
	                 dataType: 'html',
	                 error: function(){
	                     alert('系统编译错误！');
	                     $id("submit2").disabled="" 
	                     return null;
	                 },
	                 success: function(text){
	                     if(text!=null){       
	                       alert(text);
	                       //$id("submit2").disabled=""
	                       window.close(); 
	                     }
	                 }
	                 });
	           }
	   /*
       var myAjax = new Ajax(action);
       myAjax.addParam('settlement_date', settlement_date);
       myAjax.addParam('settlement_type_bd', settlement_type_bd);
       myAjax.submit();
       var returnNode = myAjax.getResponseXMLDom();
       if( returnNode ) {
       	alert(""+myAjax.getProperty("returnValue"));
           window['returnValue'] = ""+myAjax.getProperty("returnValue");
           window.close();
       }*/
	}
	
	function checkMonth(mm){
        if((mm+'').length!=6){
        	return false;
        }
        if(((mm+'').substr(0,4))<2000 || ((mm+'').substr(0,4))>2030){
            return false;
        }
        if(((mm+'').substr(4,2))<1 || ((mm+'').substr(4,2))>12){
            return false;
        }
        return true;
    }

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function rtnFunc(arg){
        var lookup = $id("policy_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];   
        return false ;
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
 <div class="ringht_s">
   <div id="ccParent0" class="box_3"> 
           <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
        <td class="td_1" style="width: 30%"><span style="color: red">*</span>选择保单</td>
        <td class="td_2" style="width: 70%">
            <w:lookup onReturnFunc="rtnFunc" readonly="true" id="policy_name" name="policy_name" lookupUrl="/PolicyAction.do?cmd=toPolicyLookup"  dialogTitle="选择保单" height="480"  width="770"/>
        </td>
    </tr>
	<tr>
		<td class="td_1" style="width: 30%"><span style="color: red">*</span>结算年月</td>
		<td class="td_2" style="width: 70%">
			<input type="text" class="text_field" name="settlement_date" id="settlement_date" style="width: 120px;" />如：201304
		</td>
	</tr>
	<tr>
        <td class="td_1" style="width: 30%"><span style="color: red">*</span>产品三级类别</td>
        <td class="td_2" style="width: 70%">
            <r:comboSelect
                id="productid" name="productid_name"
                queryAction="/FAERP/ProductAction.do?cmd=getAllThreetypeProduct"
                textField="product_name" valueField="three_type_id" xpath="ProductVo"
                width="170px" nullText="请选择" />
            </span>
            <input name="product_type_id" type="hidden" class="sText" id="product_type_id" value="" />
        </td>
    </tr>
	
	<tr>
		<td class="td_1">生成结算类型</td>
		<td class="td_2"><d:radio dictTypeId="SETTLEMENT_TYPE_BD" name="settlement_type_bd" id="settlement_type_bd" value="1" /></td>
	</tr>
	<tr>
		<td colspan="2" class="td_2"><center><input type="button" id="submit2" name="submit2" class="icon_2" value="生成" onclick="javascript:insert_onClick();">&nbsp;&nbsp;<input class="icon_2" type="button" value="返回" onclick="javascript:cancel_onClick();"></center></td>
	</tr>
</table>
</div>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
