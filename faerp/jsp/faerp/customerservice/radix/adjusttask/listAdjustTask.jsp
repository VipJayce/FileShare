<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.customerservice.radix.adjusttask.adjusttask_resource" prefix="rayoo.customerservice.radix.adjusttask.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datacell</title>
<script language="javascript">
        
        function simpleQuery_onClick(){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }

    //是否启用复选框
    function setCheckboxStatus1(value,entity,rowNo,cellNo){
        var task_status_bd=entity.getProperty("task_status_bd");
        if(task_status_bd!=null&&task_status_bd=='1'){
           return "<input type='checkbox' id='tsd_"+rowNo+"' name='task_status_bd' value='1' checked onclick='checktsd(\"" +rowNo+"\",\"" +entity.getProperty("task_status_bd")+"\" );'>";
        }else{
            return "<input type='checkbox' id='tsd_"+rowNo+"' name='task_status_bd' value='1' onclick='checktsd(\"" +rowNo+"\",\"" +entity.getProperty("task_status_bd")+"\" );'>";
        }
       
    }
    
    //是否启用勾选后设置值
    function checktsd(rowNo,code){
        var aa ="tsd_"+rowNo;
        var datacell = $id("datacell1");
        var dataset = datacell.dataset;
        if($id(aa).checked){//勾选上
            dataset.get(rowNo).setProperty("task_status_bd","1");
        }else{//勾选去掉
            dataset.get(rowNo).setProperty("task_status_bd","0");
        }
        if(dataset.get(rowNo).getProperty("id")!=null){
            dataset.get(rowNo).status=Entity.STATUS_MODIFIED;
        }
    }
    
    //是否锁定复选框
     function setCheckboxStatus2(value,entity,rowNo,cellNo){
        var is_lock_bd=entity.getProperty("is_lock_bd");
        if(is_lock_bd!=null&&is_lock_bd=='1'){
           return "<input type='checkbox' id='ilb_"+rowNo+"' name='is_lock_bd' value='1' checked disabled='disabled' onclick='checkilb(\"" +rowNo+"\",\"" +entity.getProperty("is_lock_bd")+"\" );'>";
        }else{
            return "<input type='checkbox' id='ilb_"+rowNo+"' name='is_lock_bd' value='1' disabled='disabled' onclick='checkilb(\"" +rowNo+"\",\"" +entity.getProperty("is_lock_bd")+"\" );'>";
        }
       
    }
    
    //是否锁定勾选后设置值(已作废)
    function checkilb(rowNo,code){
        var aa ="ilb_"+rowNo;
        var datacell = $id("datacell1");
        var dataset = datacell.dataset;
        if($id(aa).checked){//勾选上
            dataset.get(rowNo).setProperty("is_lock_bd","1");
        }else{//勾选去掉
            dataset.get(rowNo).setProperty("is_lock_bd","0");
        }
       if(dataset.get(rowNo).getProperty("id")!=null){
            dataset.get(rowNo).status=Entity.STATUS_MODIFIED;
        }
    }
    
        function toAdd_onClick() {
            $id("datacell1").addRow();
            
            var myDate = new Date();
            var datacell = $id("datacell1");
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            
            datasettr.setProperty("adjust_year",myDate.getFullYear());
        }
        
    
        function deleteMulti_onClick(){
            var datacell = $id("datacell1");
            //var dataset1 = datacell.dataset;//取得页面的datacell
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            
            if(datasettr.getProperty("is_lock_bd")==1){
                alert('<fmt:message key="adjust_task_lock_not_delete"/>');
                return;
            }
	       if(confirm('<fmt:message key="sure_delete_selected_adjust_task"/>')) {  //如果用户在确认对话框按"确定"
	            $id("datacell1").deleteRow();
	            //dataset1.removeEntity(datasettr,true);
	       }
        }
        
        function toSave_onClick() {  
            $id("datacell1").isModefied = true;
            
            var datacell1 = $id("datacell1");
            var dataset1 = datacell1.dataset;//取得页面的datacell
            for(var i=0; i<dataset1.getLength(); i++){
                var datasettr = dataset1.get(i);
                
                if(datasettr.getProperty("adjust_task_name")==null || datasettr.getProperty("adjust_task_name")==''){
                    alert('<fmt:message key="adjust_task_name_not_null"/>');
                    return;
                }
                if(datasettr.getProperty("group_ids")==null || datasettr.getProperty("group_ids")==''){
                    alert('<fmt:message key="please_choose_group_ids"/>');
                    return;
                }
            }
            if($id("datacell1").submit()){
                alert("<fmt:message key="adjust_task_save_seccuse"/>");
            }
        }   
        function toReload_onClick() {
             $id("datacell1").reload();
        }
           
        //列表组选择回调函数
        function rtnFuncGroup(arg){
	        var datacell = $id("datacell1");
        
	        var activeRow = datacell.activeRow;
	        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
	        
	        datasettr.setProperty("group_ids",arg[0]);
	        datasettr.setProperty("group_name",arg[1]);
	        
            var lookup = $id("lk_group");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
	        
	        datacell.refreshCell( datacell.activeCell,datacell.activeField );
	        
		    return false;
		}
       
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input id="security_group_id" name="security_group_id" type="hidden"  value="" />
<input id="selectcity_id" name="selectcity_id" type="hidden"  value="" />
<div id="right">
    <script language="javascript">
        writeTableTopFesco('<fmt:message key="adjust_task_set"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div> </td>
    </tr>
    <tr>

         <td align="left"><fmt:message key="ss_fund_group"/></td>

         <td align="left">

             <input type="text" class="text_field" name="group_name" inputName="包含的社保组id用,隔开" maxLength="250"/>

         </td>

         <td align="left"><fmt:message key="adjust_year"/></td>

         <td align="left">

             <input type="text" class="text_field" name="adjust_year" inputName="调整年份" maxLength="64"/>

         </td>

         <td align="left"></td>

         <td align="left">

             <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">

             <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">

         </td>        

   </tr>            
</table>
</div>


<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
                    <li class="a">      <a  onClick="javascript:toReload_onClick();">刷新 </a> </li>
                </ul>
         -->
         <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="tzrwsz_add" type="1"/>  onClick="toAdd_onClick();">
         <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="tzrwsz_del" type="1"/>  onClick="deleteMulti_onClick();">
         <input class="bc" type="button"   value="<fmt:message key="save"/>"  <au:authorityBtn code="tzrwsz_save" type="1"/>  onClick="toSave_onClick();">
         <input class="a" type="button"   value="<fmt:message key="refresh"/>"  <au:authorityBtn code="tzrwsz_sx" type="1"/>  onClick="toReload_onClick();">
         </div>
           <div class="clear"></div>            
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/AdjustTaskAction.do?cmd=searchAdjustTasks"
        submitAction="/FAERP/AdjustTaskAction.do?cmd=saveAdjustTasks"
        width="98%"
        height="318px"
        xpath="AdjustTaskVo"
        submitXpath="AdjustTaskVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>           
      <r:field fieldName="adjust_task_name" width="140px" messagekey="adjust_task_name" sortAt="server">
        <h:text />
      </r:field>
      <r:field width="350px" fieldName="group_name" messagekey="ss_fund_group" sortAt="server">
        <w:lookup onReturnFunc="rtnFuncGroup"  id="lk_group"   name="group_ids" lookupUrl="faerp/common/system/findSecuritygroup.jsp" messagekey="choose_ss_fund_group" height="440" width="600" style="width:170px"/>
       
      </r:field>
      <r:field fieldName="adjust_year" messagekey="adjust_year" allowModify="false" sortAt="server">
        <h:text />
      </r:field>
      <r:field fieldName="task_status_bd" messagekey="is_task_status" sortAt="server" onRefreshFunc="setCheckboxStatus1">
        
      </r:field>
      <r:field fieldName="is_lock_bd" messagekey="is_lock" sortAt="server" onRefreshFunc="setCheckboxStatus2">
        
      </r:field>
      <r:field fieldName="remark" messagekey="remark" sortAt="server">
        <h:text/>
      </r:field>
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script>
//初始化加载时，根据锁定状态修改alloeModify
$id("datacell1").afterRefresh = function(){
       
        var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        var islock = "";
        for(var k=0; k<dataset1.getLength(); k++){
            islock = dataset1.get(k).getProperty("is_lock_bd");
            if(islock=='1'){
                var aa ="tsd_"+k;
                jQuery("#"+aa).attr('disabled', 'disabled'); 
            }
        }
        
        return true;
}

$id("datacell1").beforeEdit= function(cell,colIndex,rowIndex){

    var datacell1 = $id("datacell1");
    var dataset1 = datacell1.dataset;//取得页面的datacell
    var datasettr = dataset1.get(rowIndex);
    
    var islock = datasettr.getProperty("is_lock_bd");
    if(islock=='1'){
        return false;
    }
    
    return true;
    
}
</script>
