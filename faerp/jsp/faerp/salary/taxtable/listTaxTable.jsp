<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.taxtable.taxTable_resource" prefix="rayoo.salary.taxtable.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>税率表</title>
<script language="javascript">
    jQuery(function($){
       
    });
   
	function simpleQuery_onClick(){  //简单的模糊查询
    	if(!qry_check()){
    	   return;
    	}
    	$id("dc_tax_table").reload();
  	}
  	//查询条件CHECK
  	function qry_check(){
  	 f = document.getElementById("txt_deductfrom").value;
  	 t = document.getElementById("txt_deductto").value;
  	 var reg = /^\d+(\.\d+)?$/;
  	 if (f && !reg.test(f)) {
  	    alert("<fmt:message key="alert_deduct_amount"/>");
        return false;
     }
     if (t && !reg.test(t)) {
        alert("<fmt:message key="alert_deduct_amount"/>");
        return false;
     }
     return true;
  	}
	function toAdd_onClick() {  //到增加记录页面
		
		form.action="<%=request.getContextPath()%>/TaxTableAction.do?pageModel=insert" ;
        form.cmd.value = "forwardDetail";
        form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var row = chooseRow();
		if(row){
			var taxId = row.getValue("id");
			form.action="<%=request.getContextPath()%>/TaxTableAction.do?id=" + taxId + "&pageModel=detail" ;
			form.cmd.value = "forwardDetail";
			form.submit();
		}
	}
	function toUpdate_onClick(){  //实现转到修改页面
		var row = chooseRow();
		if(row){
			var taxId = row.getValue("id");
			form.action="<%=request.getContextPath()%>/TaxTableAction.do?id=" + taxId + "&pageModel=update" ;
			form.cmd.value = "forwardDetail";
			form.submit();
		}
	}
	//删除
	function delete_onClick(){
		var row = chooseRow();
		if(row){
			if(confirm("<fmt:message key="alert_sure_to_delete"/>")){
				var taxId = row.getValue("id");
				jQuery.post(dir_base + "/TaxTableAction.do?cmd=delete&taxId="+taxId,function(data){
					if(data>0){
						$id("dc_tax_table").deleteRow();
						alert("<fmt:message key="alert_delete_success"/>");
					}
				});
			}
			
		}
	}
	
	function chooseRow(){
		var dc = $id("dc_tax_table");
		var entity = dc.getActiveEntity();
		if(!entity){
			alert("<fmt:message key="alert_select_one"/>");
			return null;
		}
		return entity;
	}

</script>
</head>
<body>
<form id="taxform" name="form" method="post" action="<%=request.getContextPath()%>/TaxTableAction.do">
<input type="hidden" name="cmd">
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key="taxtable"/></div>
    </div>
    <div class="ringht_s">
    	<!--查询 -->
	  <div class="search">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td width="150" rowspan="2" style="padding-top:0;"><div class="search_title"><fmt:message key="taxtable_search"/></div></td>
		    <td width="80"><fmt:message key="taxtable_name"/></td>
		    <td width="220"><input maxlength="50" class="sText" id="txt_taxname" name="tax_table_name"/></td>
		    <td width="80"><fmt:message key="taxtable_deduct_amount"/> &gt;=</td>
		    <td width="220"><input maxlength="18" class="sText" id="txt_deductfrom" name="deduct_amount_from"/></td>
		    <td width="80" ><fmt:message key="taxtable_deduct_amount"/> &lt;=</td>
		    <td ><input maxlength="18" class="sText" id="txt_deductto"  name="deduct_amount_to"/></td>
		  </tr>
		  <tr>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td >&nbsp;</td>
		    <td ><input onclick="simpleQuery_onClick()" class="icon_1" value="<fmt:message key="button_search"/>" /></td>
		  </tr>
	  	</table>
	  </div>
    	<!--查询 end-->
    	<!--按钮-->
        <div class="button">
            <div class="button_right">
                <!--<ul>
                    <li class="a"><a onclick="detail_onClick()">查看</a></li>
                    <li class="c"><a onclick="toAdd_onClick()">新增</a></li>
                   	<li class="b"><a onclick="toUpdate_onClick()">修改</a></li>
                    <li class="d"><a onclick="delete_onClick()">删除</a></li>   
                </ul>
                --><input class="a" type="button"   value="<fmt:message key="button_view"/>"  <au:authorityBtn code="slb_view" type="1"/>  onClick="detail_onClick();">
                <input class="c" type="button"   value="<fmt:message key="button_add"/>"  <au:authorityBtn code="slb_add" type="1"/>  onClick="toAdd_onClick();">
                 <input class="b" type="button"   value="<fmt:message key="button_modify"/>"  <au:authorityBtn code="slb_xg" type="1"/>  onClick="toUpdate_onClick();">
                 <input class="d" type="button"   value="<fmt:message key="button_del"/>"  <au:authorityBtn code="slb_del" type="1"/>  onClick="delete_onClick();">   
        	</div>
            <div class="clear"></div>
        </div>
    	<!--按钮 end-->
	    <!--表格 -->
	    <div style="padding: 8 0 8 8;">
	    <r:datacell 
	              id="dc_tax_table"
	              queryAction="/FAERP/TaxTableAction.do?cmd=findAllTaxTable"
	              submitAction="/FAERP/TaxTableAction.do?cmd=update"
	              width="99%"
	              xpath="TaxTableVo"
	              submitXpath="TaxTableVo"
	              paramFormId="taxform"
	              >
	          <r:field width="200px" fieldName="tax_table_name" messagekey="taxtable_name">
              </r:field>
              <r:field width="200px" fieldName="deductStr" messagekey="taxtable_deduct_amount">
              </r:field>
              <r:field width="200px" fieldName="fix_rate" messagekey="taxtable_fix_rate">
              </r:field>
	    </r:datacell>
	    </div>
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>

