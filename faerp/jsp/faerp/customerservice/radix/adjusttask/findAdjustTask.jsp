<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<html>
<fmt:bundle basename="rayoo.customerservice.radix.adjusttask.adjusttask_resource" prefix="rayoo.customerservice.radix.adjusttask.">
<head>
<base target="_self"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="choose_adjust_task_name"/></title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       
       return "<input type='radio'  name='temp'  value=\"" + entity.getProperty("id") + "\">";
    }
    
    function findSelection(radioName) {  //从radio中找出选中的id值列表
        var elementRadio = document.getElementsByName(radioName);  //
        var ids = null;  //定义id值
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].checked) {  //如果被选中
                ids=elementRadio[i].value; 
            }
        }
        return ids;
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("adjusttask_init").loadData();
        $id("adjusttask_init").refresh();
    }
    
    function detail_onClick(){
        var ids = findSelection("temp");  //取得单选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        
        var datacell = $id("adjusttask_init");
        var dataset = datacell.dataset;
        var datasettr = dataset.findEntity("id",ids);
        
        var returnAry = new Array();
        returnAry[0] = datasettr.getProperty("group_ids");
        returnAry[1] = datasettr.getProperty("adjust_task_name");
        returnAry[2] = datasettr.getProperty("adjust_year");
        returnAry[3] = ids;
        window.returnValue=returnAry;
        window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="simpleQuery">
<input type="hidden" name="task_status_bd" id="task_status_bd" value="1">
<div id="right">
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div> </td>
    </tr>
    <tr>
         <td align="left"><fmt:message key="ss_group"/></td>
         <td align="left">
             <input type="text" class="text_field" name="group_name" inputName="包含的社保组id用,隔开" maxLength="250"/>
         </td>
         <td align="left" rowspan="2">
             <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
         </td> 
     </tr>
     <tr>
         <td align="left"><fmt:message key="adjust_year"/></td>
         <td align="left">
             <input type="text" class="text_field" name="adjust_year" inputName="调整年份" maxLength="64"/>
         </td>
         <td align="left"></td>
     </tr>
     
                
            
</table>
</div>


 

                    
<div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="bc"><a onClick="javascript:detail_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
 
    <div>
        <r:datacell 
            id="adjusttask_init"
            queryAction="/FAERP/AdjustTaskAction.do?cmd=findAdjustTask"
            width="100%"
            xpath="AdjustTaskVo"
            submitXpath="AdjustTaskVo"
            paramFormId="simpleQuery" 
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field fieldName="emp" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
            </r:field>  
            <r:field width="150" fieldName="id" messagekey="adjust_task_code">
            </r:field>
            <r:field width="250" fieldName="adjust_task_name" messagekey="adjust_task_name">
            </r:field>
            <r:field fieldName="adjust_year" messagekey="adjust_year">
            </r:field>
            
        </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

