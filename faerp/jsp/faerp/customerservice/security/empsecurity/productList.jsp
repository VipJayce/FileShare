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
<%String bigtypeid="";
String var=request.getParameter("bigtypeid");
if(var!=null&&var!=""){
    bigtypeid=var;
}
%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.productList_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

function setCheckbox(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'  value=" + entity.getProperty("security_product_id") + " />";
     }
     
 function checkselectitem(){
           var aegnt_check = document.getElementsByName("temp");
           var ids = null;  //定义id值的数<fmt:message key='productList0001'/>
           if(ids == null) {
               ids = new Array(0);
           }
           for(var i=0;i<aegnt_check.length;i++){  //循环checkbox<fmt:message key='productList0001'/>
               if(aegnt_check[i].checked){
                   ids.push(aegnt_check[i].value);  //加入选中的checkbox
               }
           }
           return ids;
}

    function returnvalue() {  //从多选框到修改页面
        var ids=checkselectitem();
        if(ids.length<=0){
            alert("<fmt:message key='productList0002'/>!");
            return false;
        }
        //alert(ids);
        window.returnValue=ids;
        window.close();
    }
    
    /**
	 * <fmt:message key='productList0003'/>
	 * <fmt:message key='productList0004'/>  selectId --<fmt:message key='productList0005'/>id;
	 *              key -- <fmt:message key='productList0006'/>option value<fmt:message key='productList0007'/>
	 *              value -- <fmt:message key='productList0006'/>option<fmt:message key='productList0009'/>
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
    
  
</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid">
 <input type="hidden" name="security_group_id" value="${param.security_group_id }"/>
 <input type="hidden" name="product_ids" value="${param.product_ids }"/>
 
<div id="right">
<div class="ringht_s">
 
<div id="ccParent1" class="button"> 
    <div class="button_right">
         <ul>
            <li class="g">     <a  onClick="javascript:returnvalue();"><fmt:message key="choice"/> </a> </li>
         </ul>
    </div>
</div>

<r:datacell id="datacell"
            queryAction="/FAERP/EmpsecurityAction.do?cmd=queryAddSupplyItem" 
            isCount="false"
            width="99%" 
            xpath="EmpsecuritysupplyitemVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="180px">
            <r:field allowModify="false" fieldName="security_product_id" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList();' />" width="30px" onRefreshFunc="setCheckbox" >
            </r:field>  
            <r:field fieldName="product_name" width="150px" messagekey='productList0010' >
            </r:field>
        </r:datacell>

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    //writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
    //getAllBigType(document.form.big_type_id,'code','name','<%=bigtypeid%>');
</script>
</body>
</fmt:bundle>
</html>
