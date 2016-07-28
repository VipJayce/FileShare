<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
    String Medicalkit = request.getAttribute("Medicalkit")==null?"":request.getAttribute("Medicalkit").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>选择税率表</title>
</head>
<script type="text/javascript">

//执行查询
function qry(){
    $id("dc_tax_clz").reload();
}
//选择税率表并返回
function doChoose(){
    dc = $id("dc_tax_clz");
    clz = dc.getActiveEntity();
    clzid = clz.getValue("id");
    clzname = clz.getValue("tax_table_name");
 

    var rtn = new Array();
    rtn[0] = clzid;
    rtn[1] = clzname;

 
    window.returnValue = rtn;
    window.close();
    //alert(clzid+"---"+clzname);
}
</script>
<body>


		<form id="form_qry" name="form_qry" action="/TaxTableAction.do?cmd=findAllTaxTable" method="post">
		<input type="hidden" name="cmd">
		
		
		  <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="270" rowspan="2" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            </td>
        </tr>
        <tr>
            <td width="166" align="left">值：</td>
            <td width="328" align="left">
              <input  type="text"  class="text_field" name="tax_table_name" inputName="税率表名称"  style="width: 200px;" />
                    </td>
          <td width="378" rowspan="2" align="left"> <input onclick="qry()" type="button" name="button_ok" class="icon_1" value="筛选" /></td>
        </tr>
         
    </table>
    </div>
          <div class="button_salary">
            <div class="button_right">
              <ul>
                <li class="bc" style="margin-left: 20px;"><a onclick="doChoose()">选择</a></li>
              </ul>
            </div>
            <div class="clear"></div>
          </div> 
          <div  id="div1" style="margin:5 0 0 10px;">         
          <r:datacell 
              id="dc_tax_clz"
              queryAction="/FAERP/TaxTableAction.do?cmd=findAllTaxTable"
              width="99%"
              xpath="TaxTableVo"
              paramFormId="form_qry" readonly="true" >
              <r:toolbar  tools="nav,pagesize,info"/>
      
              <r:field width="300" fieldName="tax_table_name" label="税率表名称"  >
                <h:text/>
              </r:field>
            </r:datacell>
		</div>
	</form>

</body>
</html>
<script type="text/javascript">
$id("dc_tax_clz").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
	doChoose();
}
</script>