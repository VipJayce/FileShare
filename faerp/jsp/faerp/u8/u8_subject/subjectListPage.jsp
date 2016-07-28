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

     

    function return_value() {  //从多选框到修改页面
        //choose_datacell_row
        entity=choose_row_public("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("ccode_name");
        returnAry[2] = entity.getProperty("ccode");
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
          <td align="right">科目编码</td>
          <td align="left">
            <input type="text" name="ccode" class="sText" maxLength="50" width="100px"/>
          </td>
          <td align="right">科目类型</td>
          <td align="left">
          <d:select dictTypeId="CCLASS_DB"  name="cclass" value="" nullLabel="--请选择--"></d:select>    
          </td>  
        </tr>
        <tr>
          <td align="right">科目名称</td>
          <td align="left">
          <input type="text" name="ccode_name"  class="sText" maxLength="100" width="100px"/>
          </td>
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
            queryAction="/FAERP/U8_subjectAction.do?cmd=getSubjectListBySimpleQuery&v1_ccode=${requestScope.v1_ccode}&v2_ccode=${requestScope.v2_ccode}" 
            isCount="false"
            width="100%" 
            xpath="U8_subjectVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="305px"
            >
           <r:toolbar location="bottom" tools="nav,pagesize,info" />
           <r:field fieldName="ccode" width="80px" label="科目编码" >
           </r:field>
           <r:field fieldName="ccode_name" width="160px" label=" 科目名称"  >
           </r:field>
           <r:field fieldName="cclass" width="80px" label="科目类型" >
           </r:field>
           <r:field fieldName="cclass_engl" width="100px" label="CCLASS_ENGL"  >
           </r:field>
           <r:field fieldName="ccode_engl" width="100px" label=" CCODE_ENGL"  >
           </r:field>
           <r:field fieldName="igrade" width="100px" label=" 编码级次"  >
           </r:field>
           
           <r:field fieldName="cbook_type" width="100px" label=" CBOOK_TYPE"  >
           </r:field>
        </r:datacell>
</div>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    $id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
        return_value();
    }
</script>
</body>
</html>
