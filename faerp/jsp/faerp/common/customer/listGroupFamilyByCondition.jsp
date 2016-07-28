<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.common.customer.customer_resource" prefix="rayoo.common.customer.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key="choose_customer"/></title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("prop_code");
        returnAry[2] = entity.getProperty("prop_name");
        returnAry[3] = entity.getProperty("prop_type");
        returnAry[4] = entity.getProperty("prop_type_str");
        window.returnValue = returnAry;
        window.close();
    }

    function simpleQuery_onClick(){  //简单的模糊查询
	    $id("celllist1").addParam("prop_code",$id("prop_code").value);
	    $id("celllist1").addParam("prop_name",$id("prop_name").value);
	    $id("celllist1").loadData();
	    $id("celllist1").refresh();
    }
    
    function choose_row(dcId){
	    dc = $id(dcId);
	    obj = dc.getActiveEntity();
        if(!obj){
           alert("<fmt:message key="select_one_record"/>");
           return;
        }
	    return obj;
    }

</script>
    </head>
    <body>
    <form name="form" method="post"  id="datacell_formid">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td rowspan="5" style="padding-top: 0;">
          <div class="search_title"><fmt:message key="query_condition"/></div>            </td>
        </tr>
        <tr>
            <td align="left">集团户编号</td>
            <td align="left">
          <input type="text" onkeypress="if(event.keyCode==13){simpleQuery_onClick();return false;}" class="text_field" name="prop_code" id="prop_code" inputName="集团户编号" style="width: 100px;" maxLength="25"/>            </td>
          <td align="left">集团户名称</td>
            <td align="left">
                <input type="text" onkeypress="if(event.keyCode==13){simpleQuery_onClick();return false;}" class="text_field" name="prop_name" id="prop_name" inputName="集团户名称" style="width: 100px;" maxLength="50"/>            </td>
          <td align="left"><input name="button_ok" class="icon_1" type="button" value="<fmt:message key="query"/>" onClick="javascript:simpleQuery_onClick()"></td>
        </tr>
         <tr>
            
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
         <div  id="div1" style="margin:5 0 0 10px;">
             <r:datacell 
             queryAction="/FAERP/CustomerAction.do?cmd=getGroupFamilyPropList"
             id="celllist1"
             paramFormId="datacell_formid" 
             width="97%" height="200px" 
             xpath="GroupFamilyPropVo"
             readonly="true"
             >
           <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="prop_code" label="集团户编号" width="100px">
           </r:field>
           <r:field fieldName="prop_name" label="集团户名称" width="200px">
           </r:field>
           <r:field fieldName="prop_type" label="集团户类型" width="100px">
           <d:select dictTypeId="PROP_TYPE" />
           </r:field>
           <r:field fieldName="prop_type_str" label="集团户类型" width="0px">
           </r:field>
           <r:field fieldName="remark" label="说明" width="200px">
           </r:field>
         </r:datacell>
            </div>
    </form>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">
$id("celllist1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
	select_onClick();
}
</script>
