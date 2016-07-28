<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.salaryitem.salaryitem_resource" prefix="rayoo.salary.salaryitem.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script>
    function upIt(){
        var dc1 = $id("dc_salaeyitemid");
        var curRow = dc1.getRowByCell(dc1.activeCell);
        if(curRow == null){
            alert("<fmt:message key='alert_select_row'/>");
            return false ;
        }
        var curRowIndex =  curRow.getAttribute('__entity_rowno');
        if (curRowIndex <= 0) {
            alert("<fmt:message key='alert_at_frist'/>");
            return;
        }
        var curEntity = dc1.activeEntity.clone();
        //alert(curRowIndex - 1);
        var upEntity = dc1.getEntity(curRowIndex-1).clone();
        //设置
        var curData = dc1.dataset;
        
        curData.values[curRowIndex] = upEntity;
        curData.values[curRowIndex-1] = curEntity; 
        dc1.refresh();
        dc1.setActiveCell(dc1.getCell(curRowIndex-1, 0));

    }
    
    
    function downIt(){
        var dc1 = $id("dc_salaeyitemid");
        var curRow = dc1.getRowByCell(dc1.activeCell);
        if(curRow == null){
            alert("<fmt:message key='alert_select_row'/>");
            return false ;
        }
        var curRowIndex =  curRow.getAttribute('__entity_rowno');
        var totalCount = dc1.dataset.getLength();
        //alert((curRowIndex-0) + 1);
        var curRowIndex_1 = (curRowIndex-0) + 1
        if (curRowIndex_1 >= totalCount) {
            alert("<fmt:message key='alert_at_last'/>");
            return;
        }
        var curEntity = dc1.activeEntity.clone();
        //alert(curRowIndex - 1);
        var downEntity = dc1.getEntity(curRowIndex_1).clone();
        //设置
        var curData = dc1.dataset;
        
        curData.values[curRowIndex] = downEntity; 
        curData.values[curRowIndex_1] = curEntity;
        dc1.refresh();
        dc1.setActiveCell(dc1.getCell(curRowIndex_1, 0));
    }
    
    function OnSubmint_Onclick(){
        var dc1 = $id("dc_salaeyitemid");
        var ajax = new HideSubmit("/FAERP/SaleryitemAction.do?cmd=updateseachSalaeryComputeor");
        ajax.loadData(dc1.dataset.toString());
        xmlDom = ajax.retDom;
        var ret = xmlDom.selectSingleNode("/root/data/returnValue");       
        if ((ret!=null)){
            alert("<fmt:message key='alert_options_success'/>");
        } else{
            alert("<fmt:message key='alert_options_fail'/>");
        }
    }
    
    function onclose(){
       window.close() ;
    }
</script>
</head>
<body>
<form name="datacell_formid" id="datacell_formid" action="" method="post"> 
<input type="hidden" id="sa_class_id" name="sa_class_id" value="<%=request.getParameter("sa_class_id") %>"/>

  <div  id="values_div" style="width:80%; float:left;">
         <r:datacell id="dc_salaeyitemid"
            queryAction="/FAERP/SaleryitemAction.do?cmd=seachSalaeryComputeor"
            submitAction="#"
            width="99%" xpath="SaleryitemVo" submitXpath="SaleryitemVo"
            paramFormId="datacell_formid" height="300px" pageSize="-1">
            <r:field fieldName="sa_item_name" messagekey="sa_item_name" width="300px" >
            </r:field>
        </r:datacell>
  </div>
  <div style="width:50px; float:left; margin-top:50px;">
    <button name="" type="button" style="width:50px; height:25px;" onClick="upIt();"><fmt:message key='button_up'/></button>
    </br>
    <button name="" type="button" style="width:50px; height:25px;" onClick="downIt();"><fmt:message key='button_down'/></button>
    </br>
    <button name="" type="button" onclick="OnSubmint_Onclick()" style="width:50px; height:25px;"><fmt:message key='button_confirm'/></button>
    </br>
    <button name="" type="button" onclick="onclose()" style="width:50px; height:25px;"><fmt:message key='button_close'/></button>
  </div>

</form>
</fmt:bundle>
</body>
</html>
