<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
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
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
  
function select_onClick(){
      var ids = findSelections("checkbox_template","id");
        if(ids.length == 0){
            alert("请至少选择一条记录!");
            return;
        }
        window.returnValue=ids;
        window.close();
}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
    	$id("datacell1").refresh();
  	}

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
/*******************************************************************************************************/

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
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
	
		<tr>
	    
			    <td align="left">服务项目名称</td>
            <td align="left"><input type="text" class="text_field" id="product_name1" name="product_name1" ></td>
            <td>
            <!--  
              <td align="left">合同业务类型</td>
            <td align="left">
            <d:select dictTypeId="FINOUT_TYPE_BD" name="business_type_bd1" id="business_type_bd1" nullLabel="--请选择--"/>
            </td>
            -->
            <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	
		</tr>
</table>
</div>


 

					

    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell  id="datacell1"      
        queryAction="/FAERP/Finout_contract_productAction.do?cmd=queryfinoutProductData"
        width="98%" height="300px" xpath="ProductVo" 
         paramFormId="datacell_formid" readonly="true">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
    <r:field fieldName="id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
        <r:field fieldName="product_name" label="产品名称" width="150px">
        </r:field>
          <r:field fieldName="product_price" label="价格" width="70px">
        </r:field>
        <r:field fieldName="big_type_id" label="产品大类" width="75px">
         <d:select dictTypeId="big_type_id"></d:select>
        </r:field>
        <r:field fieldName="small_type_id" label="产品小类" width="130px">
         <d:select dictTypeId="big_type_id"></d:select>
        </r:field>
        <r:field fieldName="charging_frequency" label="收费频率" width="75px">
         <d:select dictTypeId="FINOUT_PRODUCT_TYPE"></d:select>
        </r:field>
        <r:field fieldName="remark" label="备注" width="150px">
        </r:field>
    </r:datacell>
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


