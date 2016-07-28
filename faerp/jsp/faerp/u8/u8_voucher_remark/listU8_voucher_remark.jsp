<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function return_value() {  //从多选框到修改页面
        entity=choose_row_public("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("voucher_name");
        window.returnValue=returnAry;
        window.close();
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
          <td align="right">凭证名称</td>
          <td align="left">
            <input type="text" name="voucher_name" class="sText" maxLength="50" width="100px"/>
          </td>
          <td align="right">凭证编码</td>
          <td align="left">
          <input type="text" name="voucher_code"  class="sText" maxLength="100" width="100px"/>
          </td>  
        </tr>
        <tr>
          <td align="right"></td>
          <td align="left">
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
            queryAction="/FAERP/U8_voucher_remarkAction.do?cmd=getVoucherListBySimpleQuery" 
            isCount="false"
            width="100%" 
            xpath="U8_voucher_remarkVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="305px"
            >
           <r:toolbar location="bottom" tools="nav,pagesize,info" />
           <r:field fieldName="voucher_name" width="120px" label="凭证名称" >
           </r:field>
           <r:field fieldName="voucher_code" width="160px" label=" 凭证编码"  >
           </r:field>
           <r:field fieldName="voucher_demo" width="180px" label="凭证备注" >
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
