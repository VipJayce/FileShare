<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择客服部门</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
    <script language="javascript">
    function detail_onClick(){  //实现转到详细页面
        var dept_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        var names = null;
        if(ids == null) {
            ids = new Array(0);
        }
        if(names == null) {
            names = new Array(0);
        }
        for(var i=0;i<dept_check.length;i++){  //循环checkbox组
            if(dept_check[i].checked){
                ids.push(dept_check[i].value);  //加入选中的checkbox
                var entity=$id("datacell1").getEntity(i);
                names.push(entity.getProperty("name"));
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var returnAry = new Array();
        returnAry[0] = ids;
        returnAry[1] = names;
        window.returnValue=returnAry;
        window.close();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function selectall(obj){
        if(obj.checked){
            var elements = document.getElementsByName("temp");
	        for(var i=0;i<elements.length;i++){
	            elements[i].checked = true;
	        }
        }else{
            var elements = document.getElementsByName("temp");
            for(var i=0;i<elements.length;i++){
                elements[i].checked = false;
            }
        }
    }
</script>
    </head>
    <body>
    
    <form name="form" method="post" id="datacell_formid">
    <div id="right">
    <div class="ringht_s">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>
        </tr>
        <tr>
          <td align="left">客服部门名称</td>
          <td align="left">
              <input type="text" class="text_field" name="dept_name" inputName="客服部门名称" maxLength="50"/>
          </td>
            <td><input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()"> </td>
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="a"><a onClick="javascript:detail_onClick();">选择</a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
     <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/FinbillAction.do?cmd=queryAllDeptByCondition"
        width="98%"
        height="318px"
        xpath="AupartyVO"
        paramFormId="datacell_formid"
        pageSize="50"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作<input type='checkbox' name='ch_operate' onclick='selectall(this);'/>" width="80px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="name" label="客服部门名称" width="300px">
      </r:field>
    </r:datacell>
    </div>
    </div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
