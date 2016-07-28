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

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
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

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="agentId" value="${param.agentId }">
  <input type="hidden" name="city_id" value="${param.city_id }">
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
		<td align="left">服务手续名称</td>
            <td align="left">   
                <input type="text" class="text_field" name="contact_name" id="contact_name"  inputName="服务手续名称" value="" maxlength="50" >
            </td>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	<td/>
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
        queryAction="/FAERP/AgentServiceItemAction.do?cmd=searchItemDatabycondition"
        width="98%" height="300px" xpath="AgentServiceItemVo" 
         paramFormId="datacell_formid" readonly="true">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
    <r:field fieldName="id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
  <r:field fieldName="city_id" label="办理城市" width="100px"  >
          <r:comboSelect id="cityList1" name="cityList1 " queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText=""  xpath="PB_CITYVo" readonly="true"></r:comboSelect>               
        </r:field>
        <r:field fieldName="contact_name" label="手续名称" width="250px"></r:field>
       <r:field fieldName="post_belong" label="入离职归属" width="80px">    
       <d:select dictTypeId="POST_BELONG_BD" nullLabel="请选择"></d:select></r:field>
       <r:field fieldName="remark" label="备注" width="285px"></r:field>
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
