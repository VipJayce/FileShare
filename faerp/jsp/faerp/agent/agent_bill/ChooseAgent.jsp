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
<body>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择员工</title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("agent_code");
        returnAry[2] = entity.getProperty("agent_name");
        window.returnValue = returnAry;
        window.close();
    }
    

    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").addParam("agent_code",$id("agent_code").value);
          $id("celllist1").addParam("agent_name",$id("agent_name").value);
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
    <input type="hidden" name="backFlag" id="backFlag" value="true">
    <input type="hidden" name="Medicalkit" id="Medicalkit" value="<%=Medicalkit %>">

    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
         <td height="40" align="right">
                 <p>城市&nbsp;&nbsp;</p>
            </td>
            <td align="left">
                 <r:comboSelect id="city_idList_search" name="city_id1"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
            </td>
            <td align="right">
                 <p>供应商名称&nbsp;&nbsp;</p>
            </td>
            <td align="left">
                 <input type="text" class="text_field" name="agent_name1" inputName="供应商名称" value="" maxLength="50"  /> 
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div style="float: right;">
    <input   name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
    </div>
    <div class="clear"></div>
    </div>
         <div  id="div1" style="margin:5 0 0 10px;">
                          <r:datacell 
        id="datacell1"
        queryAction="/FAERP/AgentAction.do?cmd=searchAgentData"
        width="98%"
        height="320px"
        xpath="AgentVo"
        paramFormId="agentFormId"
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="agent_name" label="供应商名称"  width="390px">
           </r:field>    
            <r:field fieldName="city_id" label="城市" width="190px">
                <r:comboSelect id="countryList" name="city_id"
                     queryAction="PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px"/>
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
