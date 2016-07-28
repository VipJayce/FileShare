<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.common.sales.sales_resource" prefix="rayoo.common.sales.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key="referto_page"/></title>
	<script language="javascript">
	 function setCheckbox(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + escape(entity.getProperty("agent_name")) + "\",\"" + escape(entity.getProperty("agent_code")) + "\");>";
     }
    function ClickRow(id,agentname,agentcode){
    document.getElementById("tid").value=id;
    document.getElementById("agentname").value=unescape(agentname);
    document.getElementById("agentcode").value=unescape(agentcode);
    }
	function simpleQuery_onClick(){  //简单的模糊查询queryAllGetByID
      // $id("datacell1").paramFormId = "datacell_formid";
       //$id("datacell1").addParam("agentname1",$id("agentname1").value);
       //$id("datacell1").addParam("city_id",$id("city_id").value);
       $id("datacell1").loadData();
       $id("datacell1").refresh();
  	}
    function detail_onClick(){  //实现转到详细页面
        var returnAry = new Array();
      returnAry[0] = document.getElementById("tid").value;
      returnAry[1] = document.getElementById("agentname").value;
      returnAry[2] = document.getElementById("agentcode").value;
        window.returnValue=returnAry;
        window.close();
    }
    
        function select_onClick(){
        entity=choose_row("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("agent_name");
        returnAry[2] = entity.getProperty("agent_code");
        window.returnValue=returnAry;
        window.close();

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
	<input type="hidden" id="agentname" />
	  <input type="hidden" id="tid" />
	       <input type="hidden" id="agentcode" />
	<div id="right">
	<div id="ccChild0" class="search">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="237" rowspan="3" style="padding-top: 0;">
          <div class="search_title"><fmt:message key="query_condition"/></div>            </td>
        </tr>
        <tr>
        <%-- 
            <td width="166" align="left"><fmt:message key="city"/></td>
            <td width="328" align="left">
                    <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData&queryType=${queryType}"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       messagekey="please_choose" />    
          </td> --%>
        </tr>
         <tr>
            <td align="left"><fmt:message key="agent_name"/></td>
            <td align="left">
                <input type="text" class="text_field" id="agentname1"
                name="agentname1" inputName="供应商名称" 
                maxLength="50" />   </td>
            <td align="left"><input name="button_ok" class="icon_1"  type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
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
	<r:datacell id="datacell1"
            queryAction="/FAERP/AgentAction.do?cmd=queryAllGetByID1&queryType=${queryType}" 
            isCount="false"
            width="100%" 
            xpath="AgentVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="300px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <!--
            <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='hidden' name='checkall' value='' onclick='' />" width="50px" onRefreshFunc="setCheckbox" >
                           </r:field>  
               -->
            <r:field fieldName="agent_code" width="100px" messagekey="agent_code" >
            </r:field>
              <r:field fieldName="agent_name" width="250px" messagekey="agent_name" >
            </r:field>
            <r:field fieldName="agent_type" width="100px" messagekey="agent_type">
            <d:select  dictTypeId="AGENT_TYPE" id="agent_type" name="agent_type" />
            </r:field>
            <!--
           <r:field fieldName="city_name" width="150px" messagekey="city"  >
            </r:field>-->
            </r:datacell>
	</div>
	</form>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>
<script type="text/javascript">
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>
