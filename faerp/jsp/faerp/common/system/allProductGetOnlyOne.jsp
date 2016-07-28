<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.system.product.vo.ProductVo" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

function setCheckbox(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'  value=" + entity.getProperty("id") + " />";
     }
     
 function checkselectitem()
{
           var aegnt_check = document.getElementsByName("temp");
           var ids = null;  //定义id值的数组
           if(ids == null) {
               ids = new Array(0);
           }
           for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
               if(aegnt_check[i].checked){
                   ids.push(aegnt_check[i].value);  //加入选中的checkbox
               }
           }
           return ids;
}

    function return_value() {  //从多选框到修改页面
        //choose_datacell_row
        entity=choose_row_public("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("product_name");
        window.returnValue=returnAry;
        window.close();
    }
    
    /**
	 * 功能描述：动态生成产品大类下拉菜单的内容
	 * 参数：  selectId --下拉框id;
	 *              key -- 填充时作为option value的对象属性
	 *              value -- 填充时作为option展示的对象属性
	 */    
	function getAllBigType(selectObject,key,value,selectvalue){
	    if(selectObject.length==1) {
	        AjaxControl.getBigTypeId("big_type_id",{callback:function(data){
	                if (data != null && typeof data == 'object') 
	                {
	                    setSelectForBean(selectObject.id,data,key,value,selectvalue);
	                }
	            }
	        });
	    }else{
	        return;
	    }
	}
	
	//查询异地代理商名称
	//function getSupplierList(){
//	 var url="<%=request.getContextPath()%>/jsp/faerp/common/sales/listCustomerGetByID.jsp";
   // showModalCenter(url, window,,750,490,"选择供应商");
	 //  var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
	  //  if(ids==undefined)return;
	  //  document.form.product_supplier.value=ids[0];
	   // document.form.product_supplier_name.value=ids[1];
  //  }
	
    function simpleQuery_onClick(){
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    function resetQuery(){
        document.form.product_supplier.value="";
        document.form.product_supplier_name.value="";
    }
 function checkAllList() {
        var element = document.getElementsByName("temp"); 
        for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="temp") {
             element[i].checked= !element[i].checked ? true : false;
            }
         } 
      }
      
_$(document).ready(function() {
            if ($id("lk_cust")) {
                $id("lk_cust").onReturnFunc = function (returnValue){
                    var lookup = $id("lk_cust");
                    lookup.value = returnValue[0];
                    _$("#product_supplier_name").val(returnValue[1]);
                    _$("#product_supplier1").val(returnValue[0]);
                    lookup.displayValue = returnValue[1];
                }
            }
    });
    
   function choose_datacell_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
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
 <input type="hidden" name="prodesc" />
 
<div id="right">
<div class="ringht_s">
 
 
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
            <td width="140" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        </tr>
                
        <tr>
          <td align="right">产品名称</td>
          <td align="left">
            <input type="text" name="productname1"  class="sText" inputName="产品名称" maxLength="50" width="100px"/>
          </td>
          <%//if(bigtypeid==""){%>
          <td align="right">产品大类</td>
          <td align="left"><select id="big_type_id" name="big_type_id"><option value="">--请选择--</option></select></td>  
          <%//} %>
        </tr>
        <tr>
          <td align="right">异地代理商</td>
          <td align="left">
            <w:lookup readonly="true" id="lk_cust" 
                    lookupUrl="/FAERP/jsp/faerp/common/sales/listCustomerGetByID.jsp"
                    dialogTitle="选择代理商" height="347" width="750"  style="width:175px"/></td>
             <input type="hidden" class="text_field" validators="isSearch"  hiddenInputId="product_supplier1" id="product_supplier_name" name="product_supplier_name" inputName="异地代理商"  maxLength="10" value=""/>
            <input type="hidden" id="product_supplier1" name="product_supplier1" value=""/>
          <td align="right">&nbsp;</td>
          <td align="left">
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
           </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
    <div class="button_right">
         <ul>
            <li class="g">     <a  onClick="javascript:return_value();"><fmt:message key="choice"/> </a> </li>
         </ul>
    </div>
</div>
<div style="padding : 8 5 0 8px">
<r:datacell id="datacell1"
            queryAction="/FAERP/ProductAction.do?cmd=simpleQuery2&big_type_id=${param.bigtypeid}&cust_id=${requestScope.cust_id}" 
            isCount="false"
            width="100%" 
            xpath="ProductVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="305px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="product_name" width="260px" label="产品名称" >
            </r:field>
              <r:field fieldName="scheme_type" width="130px" label="方案类型" >
            </r:field>
            <!--
            <r:field fieldName="big_type_id" width="230px" label=" 产品大类"  >
           </r:field>
            -->  
             <r:field fieldName="product_price" width="90px" label=" 标准价格"  >
            </r:field>
               <r:field fieldName="prodesc" width="200px" label=" 产品描述"  >
            </r:field>
        </r:datacell>
</div>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    //writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
    getAllBigType(document.form.big_type_id,'code','name','');
    
    $id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
        return_value();
    }
</script>
</body>
</html>
