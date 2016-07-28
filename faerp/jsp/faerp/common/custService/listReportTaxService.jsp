<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择报税专员</title>
    <script type="text/javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("partyId");
        returnAry[1] = entity.getProperty("name");
        window.returnValue=returnAry;
        window.close();

    }
    //简单的模糊查询
    function simpleQuery_onClick(){  
          $id("celllist1").reload();
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
          <td width="100" rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            
          </td>
        </tr>
         <tr>
            <td align="left">姓名</td>
            <td align="left">
                <input class="text_field" name="name" id="t_name" maxLength="50"/>
            </td>
         </tr>
         <tr>
            <td>&nbsp;</td>
            <td align="center"><input onclick="simpleQuery_onClick()" type="button" class="icon_1" value="查询" /></td>
          </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onclick="select_onClick();">选择</a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
         <div  id="div1" style="margin:5 0 0 10px;">
               <r:datacell 
                   queryAction="/FAERP/CustServiceAction.do?cmd=simpleQueryByReportTaxService"
                   id="celllist1"
                   paramFormId="datacell_formid" 
                   width="97%" height="305px" 
                   xpath="CustServiceVo"
                   readonly="true"
                   >
                 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                 <r:field fieldName="name" label="姓名" width="300px">
                 </r:field>
               </r:datacell>
         </div>
    </form>
</body>
</html>

