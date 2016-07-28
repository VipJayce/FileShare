<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%@ page import="rayoo.job.job_chargeetransfertemplate.vo.Job_chargeetransfertemplateVo" %>
<%@ page import="rayoo.job.job_chargeetransfertemplate.util.IJob_chargeetransfertemplateConstants" %>

<%  //判断是否为修改页面
Job_orderchargetransfersetVo resultVo = null;  //定义一个临时的vo变量
boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
    isModify = true;  //赋值isModify为true
    if(request.getAttribute(IJob_orderchargetransfersetConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (Job_orderchargetransfersetVo)request.getAttribute(IJob_orderchargetransfersetConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
}
%>
<%@page import="rayoo.job.job_orderchargetransferset.vo.Job_orderchargetransfersetVo"%>
<%@page import="rayoo.job.job_orderchargetransferset.util.IJob_orderchargetransfersetConstants"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

    function insert_onClick(){  
    
           var form = jQuery("#orderchargetransfersetform");
          var orderchargetransferset_id=document.getElementById("orderchargetransferset_id").value; 
          var dept_id=$id("outdept_id").getValue();
             if(dept_id==null || dept_id==""){
                 alert("划出部门不能为空");
                 return;
             }
          if(orderchargetransferset_id!=null && orderchargetransferset_id!=""){
           document.getElementById("charge_id").value=orderchargetransferset_id;
          update_onClick();
          }else{  
                 
           jQuery("#save1").attr({"disabled":"disabled"});
        form.action="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=insert";
        ajaxRequest(form,
                function(data){
                    if(true != data.error){ 
	                    jQuery("#orderchargetransferset_id").val(data.id);	 
	                    jQuery("#orderchargetransferset_deptid").val(data.deptid); 
	                var table_show = jQuery("#table_show");
                              table_show.show();
                            jQuery("#save1").removeAttr("disabled");
                      
                      
                    }else {
                        alert("新增失败");
                         window.close();
                              window.opener.simpleQuery_onClick();
                    }
                } ,
                function(){
                    alert("程序错误");
                     window.close();
                }
            )
            }
    }
function update_onClick(){  //保存修改后的单条数据
      var dept_id=$id("outdept_id").getValue();
             if(dept_id==null || dept_id==""){
                 alert("划出部门不能为空");
                 return;
             }
       if(confirm('确定要修改数据？')) { 
         
                   var form = jQuery("#orderchargetransfersetform");
            form.action="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=update";
            
            ajaxRequest(form,
                function(data){
                    if(true != data.error){
                     
                     jQuery("#orderchargetransferset_deptid").val(data.deptid);
                      allrefresh(); 
                  alert("修改成功");
                  
                    }else {
                        alert("数据没有修改");
                    }                 
                } , 
                function(){
                    alert("error.");
                }
            )
    }
    }
    
    
    function allrefresh(){
                             $id("datacell_big").loadData();
                            $id("datacell_big").refresh();
                           refresh_onClick();
                            $id("datacell_param").loadData();
                            $id("datacell_param").refresh();
                            }
                   
                   function check_onClick(){  //检查 相关 公式是否合法
        var id = jQuery("#orderchargetransferset_id").val();

        if(id){
            var form = jQuery("#orderchargetransfersetform");
           
            form.action="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=checkFormula&date="+new Date().getTime()+"&id=" + id ;
            
            ajaxRequest(form,
                function(data){
                    alert(data.message);
                    if(data.isOk==true){
                        cancel_onClick();
                    }else{
                        
                    }
                } , 
                function(){
                    alert("error.");
                }
            )
        }else {
            alert("请先保存招聘订单划转单");
        }
    }         
       function cancel_onClick(){  //取消后返回列表页面
        window.close();
         window.opener.simpleQuery_onClick();
    }     
</script>
</head>
<body>
<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>
<div class="ringht">
<div id="ccChild1"     class="box_xinzeng" style="height: 180px">
<div class="xz_title" style="padding-top: 10px">基本信息</div>
<form name="orderchargetransfersetform" method="post" id="orderchargetransfersetform" >
<input type="hidden" name="id" id="charge_id" value="${bean.id }">
    <table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="23%">招聘订单</td>
            <td class="td_2">
                <input type="text" class="text_field" name="order_code" inputName="order_code" value="${bean.order_code }" maxLength="100" readonly="readonly" />
                <input type="hidden" name="order_id" value="${bean.order_id }" />
                <input type="hidden" name="settype" value="${bean.settype }" />
            </td>
            <td class="td_1" >费用划出部门</td>
            <td class="td_2" >
             <r:comboSelect id="outdept_id" name="outdept_id"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                    
                      property="bean/outdept_id"
                       xpath="DepartmentVo"
                       nullText="请选择"  />
            </td>
        </tr>
         <tr>
          <td class="td_1" >备注</td>  
          <td class="td_2" >
            <textarea rows="5" cols="70" name="description" id="transferset_description">${bean.description }</textarea>
            </td>
            <td class="td_1" colspan="2" rowspan="5">
             <input id="save1" type="button" class="icon_2" value='保存' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />   
                <input type="button" id="checkButton" class="icon_2" value='校验公式'  onClick="javascript:check_onClick()"/>
              <input type="button" class="foot_icon_2"  value='返回'  onClick="javascript:cancel_onClick()" /></div>
            </td>
        </tr>        
         </table>
         
   </form>
</div>

<!-- 模板大项的列表 -->

<script language="javascript">
//-------------------------------费用大项开始-----------------------------------------------------
     function refresh_onClick(){
                   var Rowtr= $id("datacell_big").getActiveRow();
                        var en= $id("datacell_big").getActiveEntity();
                    var t = Rowtr.getElementsByTagName("input");
                  t[0].setAttribute("checked","true");    
                 $id("orderchargebigitem_id").value=en.getProperty("id");
                 $id("datacell_small").loadData();
                 $id("datacell_small").refresh();
               
     }
   function  toAdd_big_onClick(){ 
     var orderchargetransferset_id=document.getElementById("orderchargetransferset_id").value;     
      if(orderchargetransferset_id==null||orderchargetransferset_id==""){
          alert("请先保存基本信息");
          return;
          }else{
             var datacell = $id("datacell_big");
           var row= datacell.addRow();
                $id("indept_ids").refresh();
           var entity=$id("datacell_big").getEntity(row);
         
           var orderchargetransferset_deptid=document.getElementById("orderchargetransferset_deptid").value;
          entity.setProperty("outdept_id",orderchargetransferset_deptid);       
          entity.setProperty("orderchargetransferset_id",orderchargetransferset_id);
            entity.setProperty("iscalculation","1");
          entity.setProperty("isshow","1");           
        // refresh_onClick();
         }
       }

      function  deleteMulti_big_onClick(){
             var datacell = $id("datacell_big");
               if(confirm('确定要删除？')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
   }
   }
     function  save_big_onClick(){
         var datacell_big = $id("datacell_big");
              var datacellset_big = datacell_big.dataset;//取得页面的datacell
              var flag=true;
                  for(var i=0; i<datacellset_big.getLength(); i++){
            var datasettr = datacellset_big.get(i); 
             if(datasettr.status!=Entity.STATUS_INIT){
                flag=false;
             }
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
                if(datasettr.getProperty("itemname")==null || datasettr.getProperty("itemname")==''){
                    alert('项目名称不能为空!');
                    return;
                }
                   if(checkNum(datasettr.getProperty("itemname"))){
                    alert('项目名称不能以数字，特殊字符开头!');
                    return;
                }
                if(datasettr.getProperty("itemcode")==null || datasettr.getProperty("itemcode")==''){
                    alert('项目代码不能为空!');
                    return;
                }              
                    
                  if(isChinese(datasettr.getProperty("itemcode"))){
                    alert('项目代码不能为中文!');
                    return;
                }
        
                if(datasettr.getProperty("formula")==null || datasettr.getProperty("formula")==''){
                    alert('公式不能为空!');
                    return;
                }
                           if(datasettr.getProperty("indept_id")==null || datasettr.getProperty("indept_id")==''){
                    alert('划入部门不能为空!');
                    return;
                }
          
            }
            
        }
        
        if(flag){
           alert('数据未修改');
           return;
        }
         var action = "<%=request.getContextPath()%>/Job_orderchargebigitemAction.do?cmd=saveList";
                var xmlSubmit = datacellset_big.getSubmitXML();
                   var myAjax = new Ajax(action);
                   myAjax.submitXML(xmlSubmit, 'UTF-8');      
             var returnNode = myAjax.getResponseXMLDom();
              if( returnNode ) {
                     if( myAjax.getValue("root/data/returnValue") !="0" ) {
                     alert("保存成功");
                    
                     }    else {
                  alert("保存失败");
                  }
                     }
                             $id("datacell_big").loadData();
                 $id("datacell_big").refresh();     
      
                   refresh_onClick();
       }
      function setCheckboxStatus_big(value,entity,rowNo,cellNo){

         
    return "<input type='radio'  name='radio_big'   onClick=ClickRow_big(\"" + entity.getProperty("id") + "\");>";
    }
        function ClickRow_big(value){
        $id("orderchargebigitem_id").value = value;  
      $id("datacell_small").loadData();
                 $id("datacell_small").refresh();
                 
    }
    
    var currentFormulaText = null;
    function toSetFormual(th,isBig) {
    currentFormulaText = th;
    // w为窗口宽度，h为高度
    var w = 950;
    var h = 600;
    var l = 150;// (screen.width - w) / 2;
    var t = 70;// (screen.height - h) / 2;
    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l;
    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=yes,resizable=yes,location=no,status=no';
    var url = "<%=request.getContextPath()%>/jsp/faerp/job/job_orderchargetransferset/tosetformual4quotation.jsp";
    if(isBig){
    
        var datacell = $id("datacell_big");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var sc_id = datasettr.getProperty("id");
    
        url +=  "?isRich=true&fromTpl=true&tpl_id="+jQuery("#orderchargetransferset_id").val()+
                "&sc_id="+sc_id;
    }else{
        url +=  "?isRich=true&fromorder=true&tpl_id="+jQuery("#orderchargetransferset_id").val()+
                "&sc_id="+sc_id;
    }
       
    window.open(url, 'newwindow', s);

}
  function moveUp_onClick_big() {  //上移
        
        var datacell = $id("datacell_big");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var big_status=datasettr.status;
 
        if(big_status!=1&&big_status!=2){
        alert("请选保存数据再上移");
            return;
        }
        var order_col = datasettr.getProperty("itemnumber");
        var pre = activeRow.previousSibling;
        if(pre == null){
            alert("已经到达顶端");
            return;
        }else {
            datacell.isModefied = true;
            
            var datasettr_pre = datacell.getEntity(pre);
            var order_col2 = datasettr_pre.getProperty("itemnumber");
            
            datasettr.setProperty("itemnumber", order_col2);
            datasettr_pre.setProperty("itemnumber", order_col);
            
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_pre.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveUp(activeRow);
        }
        
            
            
    }
    
    function moveDown_onClick_big() {  //下移
        var datacell = $id("datacell_big");
        var activeRow = datacell.activeRow;
        
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var order_col = datasettr.getProperty("itemnumber");
    
              var big_status=datasettr.status;
 
        if(big_status!=1&&big_status!=2){
        alert("请先保存数据再下移");
            return;
        }
        
        var next = activeRow.nextSibling;
        if(next == null){
            alert("已经到达最下端");
            return;
        }else {
            datacell.isModefied = true;
            
            var datasettr_next = datacell.getEntity(next);
            var order_col2 = datasettr_next.getProperty("itemnumber");
                              var bignex_status=datasettr_next.status;
 
        if(bignex_status!=1&&bignex_status!=2){
        alert("请先保存数据再下移");
            return;
        }
            datasettr.setProperty("itemnumber", order_col2);
            datasettr_next.setProperty("itemnumber", order_col);
            
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_next.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveDown(activeRow);
        }
        
        
     }
  
//-------费用大项结束-----------------------------------------------
  </script>

    <!--费用大项-->
  <div id="table_show"  style="display:<%=isModify?"block":"none" %> " >
        <form action="" id="orderchargebigitemform" method="post">
            <input type="hidden" id="orderchargetransferset_id" name="orderchargetransferset_id" value="${bean.id }">
            <input type="hidden" id="orderchargetransferset_deptid" name="orderchargetransferset_deptid" value="${bean.outdept_id }">
         </form>
         <form action="" id="orderchargemiditemform" method="post">
               <input type="hidden" id="orderchargebigitem_id" name="orderchargebigitem_id" value="">
        </form>
        
        <div style="padding: 8 10 8 8;">
            <div class="xz_title" style="padding-top: 10px">招聘订单费用大项</div> 
            <div id="ccParent1" class="button">
                        <div class="button_right">
                         <input class="c" type="button"   value="新增"    onClick="toAdd_big_onClick()">
        
            <input class="d" type="button"   value="删除"    onClick="deleteMulti_big_onClick();">
               <input class="e" type="button"   value="上移"    onClick="moveUp_onClick_big();">
                  <input class="e" type="button"   value="下移"    onClick="moveDown_onClick_big();">
               <input class="c" type="button"   value="保存"    onClick="save_big_onClick();">
             <div class="clear"></div>  
                          <!--   <ul>
                                <li class="c">      <a onClick="javascript:toAdd_big_onClick();">新增</a></li>
                                <li class="d">      <a onClick="javascript:deleteMulti_big_onClick();">删除</a> </li>
                                <li class="e">      <a onClick="javascript:moveUp_onClick_sc();">上移</a></li>
                                <li class="e">      <a onClick="javascript:moveDown_onClick_sc();">下移</a></li>
                                <li class="c">      <a onClick="javascript:toSave_onClick();">保存</a></li>
                            </ul>     -->
                        </div>
            </div>
            <r:datacell id="datacell_big" 
                queryAction="/FAERP/Job_orderchargebigitemAction.do?cmd=listBigData" width="90%" height="170px"
                submitAction="/FAERP/Job_orderchargebigitemAction.do?cmd=saveList"
                xpath="Job_orderchargebigitemVo" paramFormId="orderchargebigitemform"
                submitXpath="Job_orderchargebigitemVo" pageSize="-1"
                    >
              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
              <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus_big"  align="center" ></r:field>
              <r:field fieldName="itemname" label="名称" width="100px" >
              <h:text maxlength="100"/>
              </r:field>    
              <r:field fieldName="itemcode" label="代码" width="100px" ><h:text maxlength="100" /></r:field>    
              <r:field fieldName="formula" label="公式" width="300px" ><h:text ondblclick="toSetFormual(this,true);"  maxlength="100"/></r:field>
              
               <r:field fieldName="outdept_id" label="划出部门" width="100px" allowModify="false" >
                <r:comboSelect id="outdept_ids" name="outdept_ids"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       readonly="true"
                       xpath="DepartmentVo"
                       nullText="请选择"  />
                       </r:field>  
                        <r:field fieldName="indept_id" label="划入部门" width="100px" >
                <r:comboSelect id="indept_ids" name="indept_ids"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       xpath="DepartmentVo"
                       nullText="请选择"  />
                       </r:field> 
                  <r:field fieldName="iscalculation" label="是否计算" width="65px" >
                  <d:select dictTypeId="TrueOrFalse" name="iscalculations" id="iscalculations" value="1" />
                  </r:field>    
                   <r:field fieldName="isshow" label="是否显示" width="65px" >
                   <d:select dictTypeId="TrueOrFalse" name="isshows" id="isshows" value="1" />
                   </r:field>    
                   <r:field fieldName="description" label="备注" width="300px" >
                   <h:textarea rows="8" cols="35" />
                   </r:field>    
              </r:datacell>
              
        </div>


<!-- 模板大项的列表 -->

<script language="javascript">
//-------------------------------费用小项开始-----------------------------------------------------
  
 function  toAdd_small_onClick(){
               var orderchargebigitem_id=document.getElementById("orderchargebigitem_id").value
                var orderchargetransferset_id=document.getElementById("orderchargetransferset_id").value;
               if(orderchargebigitem_id==null||orderchargebigitem_id==""){
          alert("请先选择服务大项");
          return;
          }else{
         
             var datacell = $id("datacell_small");
           var row= datacell.addRow();
           var entity=$id("datacell_small").getEntity(row);
           
       //    var smalltransfertemplate_id=document.getElementById("smalltransfertemplate_id").value;
           
          entity.setProperty("orderchargetransferset_id",orderchargetransferset_id);
       //entity.setProperty("chargetransfertemplate_id",smalltransfertemplate_id);
          entity.setProperty("orderchargebigitem_id",orderchargebigitem_id);
     
         
          }
       }

      function  deleteMulti_small_onClick(){
             var datacell = $id("datacell_small");
               if(confirm('确定要删除？')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
   }
   }
     function  save_small_onClick(){
     
           var datacell_small= $id("datacell_small");
              var datacellset_small = datacell_small.dataset;//取得页面的datacell
              var flag=true;
                 for(var i=0; i<datacellset_small.getLength(); i++){
            var datasettr = datacellset_small.get(i);     
                         if(datasettr.status!=Entity.STATUS_INIT){
                flag=false;
             }
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
                if(datasettr.getProperty("itemname")==null || datasettr.getProperty("itemname")==''){
                    alert('项目名称不能为空!');
                    return;
                }
                if(datasettr.getProperty("itemcode")==null || datasettr.getProperty("itemcode")==''){
                    alert('项目代码不能为空!');
                    return;
                }              
                    
                  if(isChinese(datasettr.getProperty("itemcode"))){
                    alert('项目代码不能为中文!');
                    return;
                }
        
                if(datasettr.getProperty("formula")==null || datasettr.getProperty("formula")==''){
                    alert('公式不能为空!');
                    return;
                }
          
            }
            
        }
        if(flag){
         alert("数据未修改");
         return;
        }
            var action = "<%=request.getContextPath()%>/Job_orderchargemiditemAction.do?cmd=saveList";
                var xmlSubmit = datacellset_small.getSubmitXML();
                   var myAjax = new Ajax(action);
                   myAjax.submitXML(xmlSubmit, 'UTF-8');      
             var returnNode = myAjax.getResponseXMLDom();
              if( returnNode ) {
                     if( myAjax.getValue("root/data/returnValue") !="0" ) {
                     alert("保存成功");
                    
                     }    else {
                  alert("保存失败");
                  }
                     }
        
                      $id("datacell_small").loadData();
                            $id("datacell_small").refresh();
             
       }
   function moveUp_onClick_small() {  //上移
        
        var datacell = $id("datacell_small");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var small_status=datasettr.status;
 
        if(small_status!=1&&small_status!=2){
        alert("请选保存数据再上移");
            return;
        }
        var order_col = datasettr.getProperty("itemnumber");
        var pre = activeRow.previousSibling;
        if(pre == null){
            alert("已经到达顶端");
            return;
        }else {
            datacell.isModefied = true;
            
            var datasettr_pre = datacell.getEntity(pre);
            var order_col2 = datasettr_pre.getProperty("itemnumber");
            
            datasettr.setProperty("itemnumber", order_col2);
            datasettr_pre.setProperty("itemnumber", order_col);
            
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_pre.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveUp(activeRow);
        }
        
            
            
    }
    
    function moveDown_onClick_small() {  //下移
        var datacell = $id("datacell_small");
        var activeRow = datacell.activeRow;
        
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var order_col = datasettr.getProperty("itemnumber");
    
              var small_status=datasettr.status;
 
        if(small_status!=1&&small_status!=2){
        alert("请先保存数据再下移");
            return;
        }
        
        var next = activeRow.nextSibling;
        if(next == null){
            alert("已经到达最下端");
            return;
        }else {
            datacell.isModefied = true;
            
            var datasettr_next = datacell.getEntity(next);
            var order_col2 = datasettr_next.getProperty("itemnumber");
                              var smallnex_status=datasettr_next.status;
 
        if(smallnex_status!=1&&smallnex_status!=2){
        alert("请先保存数据再下移");
            return;
        }
            datasettr.setProperty("itemnumber", order_col2);
            datasettr_next.setProperty("itemnumber", order_col);
            
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_next.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveDown(activeRow);
        }
        
        
     }

//-------费用小项结束-----------------------------------------------

//-------------------------------费用参数开始-----------------------------------------------------
  
   function  toAdd_param_onClick(){
                   var orderchargetransferset_id=document.getElementById("orderchargetransferset_id").value;     
      if(orderchargetransferset_id==null||orderchargetransferset_id==""){
          alert("请先保存基本信息");
          return;
          }else{
             var datacell = $id("datacell_param");
           var row= datacell.addRow();
           var entity=$id("datacell_param").getEntity(row);
         //  var paramchargetransfertemplate_id=document.getElementById("bigchargetransfertemplate_id").value;
          //        entity.setProperty("chargetransfertemplate_id",paramchargetransfertemplate_id);
          entity.setProperty("orderchargetransferset_id",orderchargetransferset_id);
          entity.setProperty("datatype","0");
          }
       }

      function  deleteMulti_param_onClick(){
             var datacell = $id("datacell_param");
               if(confirm('确定要删除？')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
   }
   }
     function  save_param_onClick(){
           var datacell_param = $id("datacell_param");
              var datacellset_param = datacell_param.dataset;//取得页面的datacell
                   var flag=true;
                    for(var i=0; i<datacellset_param.getLength(); i++){
                    
            var datasettr = datacellset_param.get(i);     
                         if(datasettr.status!=Entity.STATUS_INIT){
                flag=false;
             }
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
                if(datasettr.getProperty("paramname")==null || datasettr.getProperty("paramname")==''){
                    alert('参数名称不能为空!');
                    return;
                }
                if(datasettr.getProperty("paramcode")==null || datasettr.getProperty("paramcode")==''){
                    alert('参数代码不能为空!');
                    return;
                }              
                                    if(isChinese(datasettr.getProperty("paramcode"))){
                    alert('参数代码不能为中文!');
                    return;
                }
         
        
        
                if(datasettr.getProperty("datatype")==null || datasettr.getProperty("datatype")==''){
                    alert('参数类型不能为空!');
                    return;
                }
                      if(datasettr.getProperty("defaultvalue")==null || datasettr.getProperty("defaultvalue")==''){
                    alert('默认值不能为空!');
                    return;
                }
          
            }
            
        } 
        if(flag){
        alert("数据未修改");
        return;
        }
               var action = "<%=request.getContextPath()%>/Job_orderchargeparamAction.do?cmd=saveList";
                var xmlSubmit = datacellset_param.getSubmitXML();
                   var myAjax = new Ajax(action);
                   myAjax.submitXML(xmlSubmit, 'UTF-8');      
             var returnNode = myAjax.getResponseXMLDom();
              if( returnNode ) {
                     if( myAjax.getValue("root/data/returnValue") !="0" ) {
                     alert("保存成功");
                    
                     }    else {
                  alert("保存失败");
                  }
                     }
        
                      $id("datacell_param").loadData();
                            $id("datacell_param").refresh();

       }
      function setCheckboxStatus_param(value,entity,rowNo,cellNo){

       return "<input type='radio'  name='radio_param'   onClick=ClickRow_param(\"" + entity.getProperty("id") + "\");>";
    }
        function ClickRow_param(reg){
         //  jQuery("#orderchargebigitem_id").val(reg);   
    }
//-------费用参数结束-----------------------------------------------

  </script>

<table width="100%" border="0">
  <tr>
     
    <td style="width: 60%">
        <!--    费用小项-->

   <div style="padding: 8 10 8 8;" >
    

        <div class="xz_title" style="padding-top: 10px">招聘订单费用小项</div> 
        <div id="ccParent1" class="button"> 
         <div class="button_right">
                 <input class="c" type="button"   value="新增"    onClick="toAdd_small_onClick()">
        
            <input class="d" type="button"   value="删除"    onClick="deleteMulti_small_onClick();">
              <input class="e" type="button"   value="上移"    onClick="moveUp_onClick_small();">
                  <input class="e" type="button"   value="下移"    onClick="moveDown_onClick_small();">
               <input class="c" type="button"   value="保存"    onClick="save_small_onClick();">
             <div class="clear"></div>  
                      <!--    <ul>
                            <li class="c">      <a onClick="javascript:toAdd_onClick_sc_item();"><fmt:message key="insert"/> </a></li>
                            <li class="d">      <a  onClick="javascript:deleteMulti_onClick_sc_item();"><fmt:message key="delete"/> </a> </li>
                            <li class="e">      <a onClick="javascript:moveUp_onClick_sc_item();">上移</a></li>
                            <li class="e">      <a onClick="javascript:moveDown_onClick_sc_item();">下移</a></li>
                            <li class="c">      <a onClick="javascript:toSave_onClick_sc_item();"><fmt:message key="save"/></a></li>
                        </ul>
                        -->
                 </div>
        </div>
        
          <r:datacell id="datacell_small" 
            queryAction="/FAERP/Job_orderchargemiditemAction.do?cmd=listSmallData" width="100%" height="198px"
            submitAction="/FAERP/Job_orderchargemiditemAction.do?cmd=saveList"
            xpath="Job_orderchargemiditemVo" paramFormId="orderchargemiditemform"
            submitXpath="Job_orderchargemiditemVo"
                >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="itemname" label="名称" width="100px" ><h:text maxlength="100" /></r:field>    
          <r:field fieldName="itemcode" label="代码" width="100px" ><h:text maxlength="100"/></r:field>    
          <r:field fieldName="formula"  label="公式" width="150px" ><h:text ondblclick="toSetFormual(this);" maxlength="100" /></r:field>
          <r:field fieldName="description" label="备注" width="250px" ><h:text  maxlength="200"/></r:field>    
          </r:datacell>
        </div>
    </td>
    
    <td>

     <!-- 服务费参数  -->
 <div style="padding: 8 10 8 8" >
        <div class="xz_title" style="padding-top: 10px">招聘订单服务费参数</div> 
        <div id="ccParent1" class="button"> 
         <div class="button_right">

                 <input class="c" type="button"   value="新增"    onClick="toAdd_param_onClick()">
        
            <input class="d" type="button"   value="删除"    onClick="deleteMulti_param_onClick();">
               <input class="c" type="button"   value="保存"    onClick="save_param_onClick();">
             <div class="clear"></div>  

                    
                 </div>
        </div>
        <r:datacell id="datacell_param" 
            queryAction="/FAERP/Job_orderchargeparamAction.do?cmd=listParamData" width="90%" height="198px"
            submitAction="/FAERP/Job_orderchargeparamAction.do?cmd=saveList"
            xpath="Job_orderchargeparamVo" paramFormId="orderchargebigitemform"
            submitXpath="Job_orderchargeparamVo"
            >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="id" label="" width="0px" ></r:field>
          <r:field fieldName="paramname" label="参数名称" width="100px" ><h:text maxlength="100"/></r:field>    
          <r:field fieldName="paramcode" label="参数代码" width="100px" ><h:text maxlength="100"/></r:field>    
          <r:field fieldName="datatype" label="类型" width="50px" >
            <d:select dictTypeId="DATA_TYPE_DB" extAttr="validateAttr='allowNull=false'"/>
          </r:field>
          <r:field fieldName="defaultvalue" label="默认值" width="100px" ><h:text maxlength="100"/></r:field>    
          <r:field fieldName="description" label="备注" width="250px" ><h:text maxlength="200"/></r:field>    
          </r:datacell>
          </div>
            </td>
    
        </tr>
    </table>

</div>

</div>
</fmt:bundle>
</body>
</html>

<script language="javascript">

/*function f_check_tpl_para(obj) {
    var str = obj.value;
    var datacell = $id("datacell_tpl_para");
    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);// 得到当前操作的行dataset
    
    if (datasettr.getProperty("data_type") == '0') {
        if (isNaN(str)) {
            f_alert(obj, "<fmt:message key="data_type_count"/>");
            return false;
        }
    }
    return true;
}*/

      /* $id("datacell_big").onClickRow=function(rowTR,rowIndex,entity,datacell){
       var t = rowTR.getElementsByTagName("input");
        t[0].setAttribute("checked","true");
       if($id("orderchargebigitem_id").value ==entity.getProperty("id")){
       }else{
      
         $id("orderchargebigitem_id").value = entity.getProperty("id");
                 $id("datacell_small").loadData();
                 $id("datacell_small").refresh();
                 }
    }
$id("datacell_big").afterRefresh = function(){ 
       refresh_onClick();
   }*/
function isChars(s,bag){
     var i,c;
     for(i=0;i<s.length;i++){
      c=s.charAt(i);    
       if(bag.indexOf(c)<0){
        return "";
        }
              }
        return bag;
     }
  
function isChinese(temp)  
{    
    var errorChar;
    var badChar="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"+
    "0123456789-$()|[],<>!";
  
    errorChar=isChars(temp,badChar);
 
    if(errorChar!=""){
    return false;
    }
    return true;
 
     }
       function checkNum(s){ 
        var pattern =/^[a-zA-Z\u4e00-\u9fa5]{1}/;
        if(!pattern.exec(s)){
          return true;
        }
        return false;    
    }
</script>
</script>
