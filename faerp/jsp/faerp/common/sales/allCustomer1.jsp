<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     function simpleQuery_onClick(){
        $id("datacell1").addParam("customer_code",$id("customer_code").value); 
        $id("datacell1").addParam("customer_name",$id("customer_name").value); 
        $id("datacell1").addParam("customer_en_name",$name("customer_en_name").value); 
        $id("datacell1").addParam("customer_simple_name",$name("customer_simple_name").value); 
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

    function select_onClick(){
          entity=choose_row("datacell1");
          var returnAry = new Array();
          returnAry[0] = entity.getProperty("customer_code");
          returnAry[1] = entity.getProperty("customer_name");
          window.returnValue=returnAry;
          window.close();
    }
    function choose_row(dcId){
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

<form name="form" method="post" action="<%=request.getContextPath()%>/CustomerAction.do">
 
<div id="right">
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
            <td align="left">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_code"  name="customer_code" value="" inputName="客户编号"/>
            </td>
             <td align="left">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_name" name="customer_name" value="" inputName="客户名称"/>
            </td>
        </tr>
        <tr>
             <td align="left">客户英文名</td>
            <td align="left">
                 <input type="text" class="text_field" id="customer_en_name" name="customer_en_name" value="" inputName="客户英文名" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"/>
            </td>
            <td align="left">简称</td>
            <td align="left">
              <input type="text" class="text_field" id="customer_simple_name" name="customer_simple_name" value="" inputName="简称"/>
            </td>
          
        </tr>
        <tr>
                <td/>
                <td/>
                <td/>
              <td align="left">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                 <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
                </td>

        </tr>
</table>
</div>
 <div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                        <li class="g">   <a  onClick="javascript:select_onClick();"><fmt:message key="choice"/> </a> </li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
<input type="hidden" id="custcode" name="custcode"/>
<input type="hidden" id="custname" name="custname"/>
 <r:datacell 
        id="datacell1"
       queryAction="/FAERP/CustomerAction.do?cmd=simpleQuery1"
        width="100%" height="319px"
        xpath="CustomerVo"
        submitXpath="CustomerVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <!--<r:field fieldName="id"  label="" width="30px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>-->   
      <r:field fieldName="customer_code" width="120px" label="客户编号">
       </r:field>    
      <r:field fieldName="customer_name" width="250px" label="客户名称">
      </r:field>
       <r:field fieldName="customer_en_name" width="150px" label="英文名称">
      </r:field>
      <r:field fieldName="customer_simple_name" width="200px" label="简称">
      </r:field>
    </r:datacell>

                    

</div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>	
