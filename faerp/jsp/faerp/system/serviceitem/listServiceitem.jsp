<%@ page contentType="text/html; charset=UTF-8" %>
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
   
    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = document.form.itemid.value;
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
      var url="<%=request.getContextPath()%>/ServiceitemAction.do?cmd=UpdateItemPage&id="+ids;
             showModalCenter(url, window, callBack, 750, 160, "修改页面");    
    }  

      function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = document.form.itemid.value;
  
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
        var url="<%=request.getContextPath()%>/ServiceitemAction.do?cmd=deleteItem&id="+ ids;
       jQuery.post(url,function(data){
         if(data){
         if(data==-1){
         alert("该服务项被引用，不能删除");
         }else{
             if(data==0){
                 alert("删除失败");
                   
             }else{
                 alert("删除成功");
                   simpleQuery_onClick();
             }
             }
         
         }else{
                    alert("删除失败");            
         }
       
       })
      
        }
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell1").loadData();
    $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面

      var url="<%=request.getContextPath()%>/jsp/faerp/system/serviceitem/insertServiceitem.jsp";
             showModalCenter(url, window, callBack, 750, 160, "增加页面");       
    }
    function callBack(reg){ 
            $id("datacell1").loadData();  
            $id("datacell1").refresh();
    }
  function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
 

         function ClickRow(value){
            $id("itemid").value = value;      
        }

</script>
</head>
<body>

<form name="form" method="post" action="" id="form1">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="itemid" name="itemid" >
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('供应商服务项维护','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
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
              <td align="right">服务类型</td>
            <td align="left">
                    <d:select dictTypeId="POST_BELONG_BD" nullLabel="请选择" name="post_belong" id="post_belong"></d:select>
            </td>
          <td align="right">服务手续名称</td>
            <td align="left">
                <input type="text" class="text_field" name="contact_name" id="contact_name" inputName="服务手续名称" maxLength="100" />
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
        

        <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAdd_onClick();">
        <input class="b" type="button"   value="<fmt:message key="modify"/>"    onClick="findCheckbox_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMulti_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/ServiceitemAction.do?cmd=searchItem"
        width="98%"                                                                     
        height="308px"
        xpath="ServiceitemVo"
        paramFormId="form1"  
        readonly="true" 
       >
         <r:toolbar location="bottom" tools="nav,pagesize,info"/>
<r:field fieldName="emp" label="操作" width="35px"
            onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>

        <r:field fieldName="contact_name" label="手续名称" width="150px">
            
        </r:field>
        <r:field fieldName="post_belong" label="服务类型" width="80px" >
            <d:select dictTypeId="POST_BELONG_BD" nullLabel="请选择" ></d:select>
        </r:field>
        <r:field fieldName="remark" label="备注" width="350px">
          
        </r:field>
 </r:datacell>

 

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script language="javascript">
   
        $id("datacell1").afterRefresh=function(){
        if($id("itemid").value!=null||$id("itemid").value!=""){
         $id("itemid").value="";
         }
        }
</script>
