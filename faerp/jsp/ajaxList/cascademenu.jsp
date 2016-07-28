<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<html>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>

<script language="javascript"> 
    
/**
 * 功能描述：动态生成下拉菜单的内容
 * 参数：	selectId --下拉框id;
 *				key -- 填充时作为option value的对象属性
 *				value -- 填充时作为option展示的对象属性
 */    
function loadCompanySelect(selectObject,key,value){
	if(selectObject.length==1) {
		AjaxControl.findFactorys({callback:function(data){
				if (data != null && typeof data == 'object') 
				{
					setSelectForBean(selectObject.id,data,key,value);
				}
			}
		});
	}else{
		return;
	}
}

/**
 * 功能描述：动态生成下拉菜单的内容
 * 参数：	selectId --下拉框id;
 *				key -- 填充时作为option value的对象属性
 *				value -- 填充时作为option展示的对象属性
 */    
function loadCategorySelect(selectObject,targetId){
	AjaxControl.findCategorysOfFactory(selectObject.value,{callback:function(data){
			if (data != null && typeof data == 'object') 
			{
				DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
				DWRUtil.addOptions(targetId,{000:'--请选择--'});
				AjaxControl.getEnumList("ProductType",function(beans){
						for(var i=0;i<data.length;i++){
							for(var j=0;j<beans.length;j++){
								if(data[i] == beans[j].value){
									data[i] = beans[j];
									break;
								}
							}
						}
						DWRUtil.addOptions(targetId,data,"value","label");
					});
			}
		}
	});
}

	
/**
 * 功能描述：动态生成下拉菜单的内容
 * 参数：	selectId --下拉框id;
 *				key -- 填充时作为option value的对象属性
 *				value -- 填充时作为option展示的对象属性
 */    
function loadProductSelect(selectObject,targetId,key,value){
	AjaxControl.findProductsByCategoryAndFactory(DWRUtil.byId("company_name").value,selectObject.value,{callback:function(data){
			if (data != null && typeof data == 'object') 
			{
				setSelectForBean(targetId,data,key,value);
			}
		}
	});
}

/**
 * 功能描述：显示所选产品信息
 * 参数：	selectObject --下拉框所选中的产品的id值;
 */   	
function displayProduct(selectObject,divId){
/*
	if($(divId)==null){
		include('/jsp/ajaxList/product.jsp','forward',getProducts(selectObject));
	}else{
		getProducts(selectObject)
	}
*/
	if(DWRUtil.byId(divId)==null){
		AjaxControl.getInclude('/jsp/ajaxList/product.jsp',function(data) {
		if (data != null && typeof data == 'object') {
			alert(dwr.util.toDescriptiveString(data, 2));
		}
		else dwr.util.setValue('forward', data, { escapeHtml:false });getProducts(selectObject);	});
	}else{
		getProducts(selectObject)
	}
}

function getProducts(selectObject){
	AjaxControl.findProductById(selectObject,function(data) {
	     if (data != null && typeof data == 'object') {
     		setForms(data);
	     } 
	  });
}

</script>
<body>
<script language="javascript">
	writeTableTop('查询列表','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			按条件查询
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
	<tr>
	<td align="right" width="15%" nowrap>(一级)厂家名称</td>
	<td align="left">
		<select id="company_name" name="company_name" onmouseover="javascript:loadCompanySelect(this,'factoryid','name')" onchange="javascript:loadCategorySelect(this,'category_name')">
			<option value="000">--请选择--</option>
		</select>
	</td>
</tr>
<tr>
	<td align="right" width="15%" nowrap>(二级)产品类别</td>
	<td>
        <select id="category_name"  onchange="javascript:loadProductSelect(this,'product_name','productid','name')">
            <option value="000">--------</option>
        </select>
     </td>
</tr>
<tr>
	<td align="right" width="15%" nowrap>(三级)产品名称</td>
	<td>
        <select id="product_name"  onchange="displayProduct(this.value,'productDiv')">
            <option value="000">--------</option>
        </select>
     </td>
</tr>
</table>
</div>
<div id="forward"></div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>