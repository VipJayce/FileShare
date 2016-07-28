<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择U8用户</title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("cuse_name");
        returnAry[2] = entity.getProperty("cdept");
        window.returnValue = returnAry;
        window.close();

    }
    

    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").addParam("cuser_name",$id("cuse_name").value);
          $id("celllist1").loadData();
          $id("celllist1").refresh();
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
    
    <form name="form" method="post"  id="datacell_formid">
    
  

    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="270" rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div> </td>
        </tr>
        <tr>
            <td width="166" align="left">U8用户名</td>
            <td width="328" align="left">
          <input type="text" class="text_field" name="cuse_name" id="cuse_name" maxLength="25"/> </td>
          <td width="378" rowspan="2" align="left"><input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()"></td>
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
                            queryAction="/FAERP/U8_userAction.do?cmd=getU8UserList"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="305px" 
                            xpath="U8_userVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="id" label="用户ID" width="150px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cuse_name" label="用户名" width="300px">
                          <h:text />
                          </r:field>
                          <r:field fieldName="cdept" label="用户部门" width="300px">
                          <h:text />
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
