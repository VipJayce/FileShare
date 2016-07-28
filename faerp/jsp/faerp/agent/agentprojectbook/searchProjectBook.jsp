<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
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
    function showListData(){
	    $id("datacell2").loadData();
	    $id("datacell2").refresh();
    }
    
    function toOK_onClick() {
        entity=choose_row("datacell2");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("projectbook_name");
        returnAry[2] = entity.getProperty("projectbook_code");
        returnAry[3] = entity.getProperty("agent_id");
        returnAry[4] = entity.getProperty("cust_name");
        returnAry[5] = entity.getProperty("cust_id");
        returnAry[6] = entity.getProperty("agent_name");
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

<form name="form" method="post" id="projectbook_formid">
 
<div id="right">
<div class="ringht_s" >
 
 
<div id="ccChild0" class="search"> 
<table width="90%" border="0" cellspacing="0" cellpadding="0">
		<tr>
            <td width="175" rowspan="3" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>
        </tr>
		<tr>
			<td width="23%" align="right">项目书名称</td>
			<td width="27%" align="left">
			  <input type="text" class="text_field" name="projectbook_name" inputName="项目书名称"/>			</td>
			<td width="21%" align="right">唯一号</td>
			<td width="29%" align="left">
		      <input type="text" class="text_field" name="projectbook_code" inputName="唯一号" />            </td>
			</tr>
		<tr>
		  <td align="right" colspan="3">
		      <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">          
              <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
		  </td>
        </tr>
</table>
</div>

<div id="ccParent1" class="button"> 
	 <div class="button_right">
		<ul>
			<li class="g">      <a onClick="javascript:toOK_onClick();">确定</a></li>
		</ul>
	</div>
    <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/AgentprojectbookAction.do?cmd=searchProjectBook"
        width="95%"
        xpath="AgentprojectbookVo"
        paramFormId="projectbook_formid"
        readonly="true"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="id" label="项目书ID" width="100px">
       </r:field>
      <r:field fieldName="projectbook_name" label="项目书名称" width="100px">
       </r:field>    
      <r:field fieldName="projectbook_code" label="唯一号">
      </r:field>
      <r:field fieldName="agent_id" label="供应商ID">
      </r:field>
      <r:field fieldName="agent_name" label="供应商名称">
      </r:field>
      <r:field fieldName="cust_name" label="客户名称">
      </r:field>
      <r:field fieldName="cust_id" label="客户ID">
      </r:field>
    </r:datacell>
</div>

</div>
</div>
</form>
</fmt:bundle>
<script type="text/javascript">
$id("datacell2").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    toOK_onClick();
}
</script>
</body>
</html>
