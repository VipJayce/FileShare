<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
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
    
    <title></title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("city_id");
        returnAry[2] = entity.getProperty("send_name");
        returnAry[3] = entity.getProperty("customer_name");
        returnAry[4] = entity.getProperty("customer_code");
        returnAry[5] = entity.getProperty("customer_id");
        returnAry[6] = entity.getProperty("cust_send_id");
        returnAry[7] = entity.getProperty("cust_receive_id");
         returnAry[8] = entity.getProperty("cust_send_name");
        returnAry[9]=entity.getProperty("cust_receive_name");
        returnAry[10] = entity.getProperty("is_remittance_error");
        window.returnValue = returnAry;
        window.close();
    }
    

    function simpleQuery_onClick(){  //查询所有记录
        $id("datacell1").loadData();
        $id("datacell1").refresh();
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
        
    <input type="hidden" name="backFlag" id="backFlag" value="true">
  
      <div id="right">
      <div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="140" rowspan="10" style="padding-top: 0;">
            <div class="search_title" >查询条件</div>
            </td>
        </tr>
        <tr>
          
            <td align="left" nowrap="nowrap">委派单编号</td>
            <td align="left">
                <input type="text" name="send_code" value="" maxlength="100"  >
            </td>
               <td align="left" nowrap="nowrap">委派单名称</td>
            <td align="left">
                 <input type="text" name="send_name" value="" maxLength="1000"   />
            </td>          
          <td align="left" nowrap="nowrap">供应商名称</td>
          <td align="left">
                 <input type="text"  name="cust_receive_name" value="" maxLength="1000"  />
            </td>       
        </tr>
        
        <tr>
            <td align="left">客户名称</td>
            <td align="left">
                 <input type="text"  name="customer_name" value="" maxLength="100"  />
            </td>
            
            <td colspan="4" align="center">
            
            <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
           <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();"></td>
 
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
                            queryAction="/FAERP/AgentprojectbookAction.do?cmd=allSend"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="99%" height="305px" 
                            xpath="SendVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="send_code" label="委派单编号" width="100px">
                          </r:field>
                          <r:field fieldName="send_name" label="委派单名称"  width="220px"> </r:field>
                     <r:field fieldName="cust_receive_name" label="供应商名称"  width="220px"> </r:field>
                           <r:field fieldName="customer_name" label="客户名称" width="220px"> </r:field>
                        </r:datacell>
            </div>
            </div>
            </div>
    </form>
</fmt:bundle>

</body>
</html>
<script type="text/javascript">
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>