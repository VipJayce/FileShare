<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.socialunit.listSocialunit_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listSocialunit0005'/>的checkbox
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
    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listSocialunit0005'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/SocialunitAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    
    function deleteMulti_onClick(){
        
                var datacell = $id("datacell1");
                //var dataset1 = obj.dataset;//取得页面的datacell
                var activeRow = datacell.activeRow;
                var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
                if(datasettr.getProperty("is_use")=='1'){
	                alert('该用工方已经被引用，不可以<fmt:message key='listSocialunit0022'/>！');
	                return;
	            }else{
	               if(confirm('<fmt:message key='listSocialunit0009'/>要<fmt:message key='listSocialunit0022'/>所选的用工方信息吗？')) {  //如果用户在确认对话框按"<fmt:message key='listSocialunit0009'/>"
		              datacell.deleteRow();
		              //dataset1.removeEntity(obj.getActiveEntity(),true);
		           }
                
               }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        var   temp=document.getElementById("provider_id_input").value;
        $id("p_id").value=temp;
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        //form.cmd.value = "simpleQuery";
        //form.submit();
    }
    function toAdd_onClick() {  //到增加记录页面
            $id("datacell1").addRow();
            
            var datacell = $id("datacell1");
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            
            datasettr.setProperty("is_indie_bd",'0');
    }
    
    function toSave_onClick() { 
        $id("datacell1").isModefied = true;
        
        var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            
            if(datasettr.getProperty("agent_id")==null || datasettr.getProperty("agent_id")==''){
                alert('请选择一个<fmt:message key='listSocialunit0019'/>！');
                return;
            }
            if(datasettr.getProperty("hire_unit_real_name")==null || datasettr.getProperty("hire_unit_real_name")==''){
                alert('<fmt:message key='listSocialunit0011'/>');
                return;
            }
            if(datasettr.getProperty("hire_unit_short_name")==null || datasettr.getProperty("hire_unit_short_name")==''){
                alert('请输入<fmt:message key='listSocialunit0030'/>！');
                return;
            }
        }
        if($id("datacell1").submit()){
                alert("<fmt:message key='listSocialunit0013'/>!");
        }
    } 
        
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listSocialunit0005'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/SocialunitAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }

    //查询<fmt:message key='listSocialunit0019'/>名称
    function getSupplierList(){
        var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.agent_id.value=ids[0];
        document.form.agentName.value=ids[1];
    }
    
    function rtnFuncProvider(arg){
        var lookup = $id("provider_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        $id("p_id").value=arg[1];
        return false;
    }
    function rtnFuncAgent(arg){
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        datasettr.setProperty("agent_id",arg[0]);
        datasettr.setProperty("agent_name",arg[1]);
        var lookup = $id("agent_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        datacell.refreshCell( datacell.activeCell,datacell.activeField );
        return false;
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key='listSocialunit0017'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listSocialunit0018'/></div> </td>
            <td align="right"><fmt:message key='listSocialunit0019'/></td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncProvider" readonly="false" id="provider_id" name="provider_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" messagekey="listSocialunit0020" height="500" width="700" style="width:170px">
                </w:lookup>
                <input type="hidden" id="p_id" name="p_id">
           </td>

           <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key='listSocialunit0021'/></a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key='listSocialunit0022'/></a> </li>
                    <li class="d">      <a  onClick="javascript:toSave_onClick();"><fmt:message key='listSocialunit0023'/></a> </li>
                </ul>
         -->
         <input class="c" type="button"   value=" <fmt:message key='listSocialunit0021'/>"  <au:authorityBtn code="ygfwh_add" type="1"/>  onClick="toAdd_onClick();">
         <input class="c" type="button"   value=" <fmt:message key='listSocialunit0022'/>"  <au:authorityBtn code="ygfwh_del" type="1"/>  onClick="deleteMulti_onClick();">
         <input class="c" type="button"   value=" <fmt:message key='listSocialunit0023'/>"  <au:authorityBtn code="ygfwh_save" type="1"/>  onClick="toSave_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SocialunitAction.do?cmd=simpleQuery" 
        submitAction="/FAERP/SocialunitAction.do?cmd=saveList" width="99%"
        xpath="SocialunitVo"
        submitXpath="SocialunitVo"
        paramFormId="datacell_formid" height="318px"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="agent_name" messagekey='listSocialunit0019' width="200px" >
            <w:lookup onReturnFunc="rtnFuncAgent" readonly="false" id="agent_id" displayValue="agent_name"   name="agent_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" messagekey="listSocialunit0020" height="500" width="700" style="width:170px">
            </w:lookup>     
      </r:field>
      
      <r:field fieldName="hire_unit_real_name" messagekey='listSocialunit0029' width="250px" >
        <h:text/>
      </r:field>
      
      <r:field fieldName="hire_unit_short_name" messagekey='listSocialunit0030' width="150px" >
            <h:text/>      
      </r:field>
      
      <r:field fieldName="is_indie_bd" messagekey='listSocialunit0031' width="150px" >
            <d:select dictTypeId="TrueOrFalse"  />
      </r:field>
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
</fmt:bundle>
</html>

<script language="javascript">
$id("datacell1").afterSubmit= function(ajax){
           alert(""+ajax.getProperty("returnValue"));
    }





jQuery(function(){
     $id("datacell1").isQueryFirst = false;
});
    



//初始化加载时，根据引用状态 判断是否可以修改
$id("datacell1").beforeEdit= function(cell,colIndex,rowIndex){

    var datacell1 = $id("datacell1");
    var dataset1 = datacell1.dataset;//取得页面的datacell
    var datasettr = dataset1.get(rowIndex);
    var isUse = datasettr.getProperty("is_use");
    if(isUse=='1'){
        return false;
    }
    
    return true;
    
}
</script>