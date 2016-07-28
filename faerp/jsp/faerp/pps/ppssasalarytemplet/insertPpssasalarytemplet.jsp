<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>薪资模版配置</title>
<script language="javascript">

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

       function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
           function setCheckboxStatus1(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template1' value='"+value+"' >";
    }
    
        function setCheckboxStatus2(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template2' value='"+value+"' >";
    }




	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/PpssasalarytempletAction.do?cmd=insert";
		form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form_treebasic.action="<%=request.getContextPath()%>/PpssasalarytempletAction.do?cmd=queryAll";
        form_treebasic.submit();
    }
    /*****************************************datacell1 相关*********************************************************/
      function toAddSalaryPro_onClick(){   
      var templetid=document.getElementById("templet_id").value;   
      var url="<%=request.getContextPath()%>/jsp/faerp/pps/ppssasalarytemplet/listppsSalaryProject.jsp";
      url=url+"?_ts="+(new Date()).getTime()+"&templet_id="+templetid;
       showModalCenter(url,window,callback, 700, 500, "薪资项目页面");       
   }
   
    function callback(obj)
    {
       var ids=checkpagesalary(obj);
        if(ids[1]!=null && ids[1]!="")
        {
            alert(ids[1]);
        }
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/PpssasalarytempletAction.do?cmd=getSalaryProByIds&date="+new Date()+"",{"ids":ids[0]},   function(json){
                   dc1=$id("datacell1");
              if(json.beans!=null&&json.beans!="")
              {
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("id", json.beans[i].id);
                       newEntity.setProperty("sa_item_name", json.beans[i].sa_item_name);
                       newEntity.setProperty("sa_item_ename", json.beans[i].sa_item_ename);
                       newEntity.setProperty("property", '0');//modify by sqp 新加进来默认增项
                       newEntity.setProperty("ishide", json.beans[i].ishide);  
                       newEntity.setProperty("display_order",i);     
                        dc1.insertRow(newEntity);
                        dc1.activeField.editor.hideEditor();   
            }   
                }
              });
              }
           }
              
 function checkpagesalary(obj){
        var addids="";
        var chid1 = document.getElementsByName("checkbox_template");
        var chid2=document.getElementsByName("checkbox_template1");
        var err_info="";
        var ids = obj; 
       for(var i = 0;i<ids.length;i++)
       {  
            var istrue='false';
            //datacell1循环判断
            for(var j=0;j<chid1.length;j++){
                var entity1=$id("datacell1").dataset.get(j);
                //alert(entity1);
                if(entity1!=null && entity1!="undefined"){
                    if(entity1.getProperty("id")==(ids+",").split(",")[i]){
                        istrue="true";
                        err_info+=entity1.getProperty("sa_item_name")+" 已经在收入，支出列表中，不能重复添加！\n ";
                        break;
                    }
                }else{
                    istrue="false";
                }
                  }
           if(istrue=="false"){
            //datacell2循环判断
            for(var j=0;j<chid2.length;j++){
                var entity2=$id("datacell2").dataset.get(j);
               if(entity2!=null && entity2!="undefined"){
                      if(entity2.getProperty("id")==(ids+",").split(",")[i]){
                          istrue="true";
                          err_info+=entity2.getProperty("sa_item_name")+" 已经在代扣、代缴列表中，不能重复添加！\n ";
                          break;
                      }
                }else{
                    istrue="false";
                }
            }
            }
               if(istrue=='false'){
                    addids+=(ids+",").split(",")[i]+",";
               }
       /**
            var istrue='false';
            for(var j=0;j<chid1.length;j++){
                var entity1=$id("datacell1").dataset.get(j);
                var entity2=$id("datacell2").dataset.get(j);
                if(entity1!=null && entity1!="undefined"){
	                if(entity1.getProperty("id")==(ids+",").split(",")[i]){
	                    istrue="true";
	                    err_info+=entity1.getProperty("sa_item_name")+" 已经在收入，支出列表中，不能重复添加！\n ";
	                    break;
	                }
                }else if(entity2!=null && entity2!="undefined"){
		              if(entity2.getProperty("id")==(ids+",").split(",")[i]){
		                  istrue="true";
		                  err_info+=entity2.getProperty("sa_item_name")+" 已经在代扣、代缴列表中，不能重复添加！\n ";
		                  break;
		              }
                }else{
                    istrue="false";
                }
            }
               if(istrue=='false'){
                    addids+=(ids+",").split(",")[i]+",";
               }
               */
        }
        
        var returnAry = new Array();
        returnAry[0]=addids;
        returnAry[1]=err_info;
        return returnAry;
    }
  //datacell1 的删除
  function deleteMultiSalaryPro1_onClick(){
             var ids = findSelections("checkbox_template");  //取得多选框的选择项      
                  if(ids == null) {  //如果ids为空
           alert('请至少选择一个产品！');
           return;
       }
       if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
            var datacell = $id("datacell1");
        var elementCheckbox = document.getElementsByName("checkbox_template");
                       for (var i = elementCheckbox.length - 1; i >= 0; i--) {          
                if (elementCheckbox[i].checked) { // 如果被选中
            var row = datacell.getRow(i);
            var datasettr = datacell.getEntity(row);
           datasettr.setProperty("display_order","");
           datacell.deleteRow(i);    
            }
            }
       }
    }  
 
 
 
 /*******************************************dataecll2开始*******************************************************/
        //datacell2到添加页面
       function toAddSalaryPro2_onClick(){   
      var templetid=document.getElementById("templet_id").value;   
      var url="<%=request.getContextPath()%>/jsp/faerp/pps/ppssasalarytemplet/listppsSalaryProject.jsp";
      url=url+"?_ts="+(new Date()).getTime()+"&templet_id="+templetid;
       showModalCenter(url,window,callback2, 700, 500, "薪资项目页面");       
   }
   
   
   function callback2(obj)
    {
       var ids=checkpagesalary2(obj);
        if(ids[1]!=null && ids[1]!="")
        {
            alert(ids[1]);
        }
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/PpssasalarytempletAction.do?cmd=getSalaryProByIds&date="+new Date()+"",{"ids":ids[0]},   function(json){
                   dc1=$id("datacell2");
              if(json.beans!=null&&json.beans!="")
              {
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell2").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("id", json.beans[i].id);
                       newEntity.setProperty("sa_item_name", json.beans[i].sa_item_name);
                       newEntity.setProperty("sa_item_ename", json.beans[i].sa_item_ename);
                       newEntity.setProperty("property", '1');//modify by sqp 新添加进来默认减项
                       newEntity.setProperty("ishide", json.beans[i].ishide);   
                        newEntity.setProperty("display_order", i);  
                        dc1.insertRow(newEntity);
                        dc1.activeField.editor.hideEditor();   
            }   
                }
              });
              }
           }
  
  
  
  function checkpagesalary2(obj){
        var addids="";
        var chid1 = document.getElementsByName("checkbox_template");
        var chid2=document.getElementsByName("checkbox_template1");
        var err_info="";
        var ids = obj; 
       for(var i = 0;i<ids.length;i++)
       { 
            var istrue='false';
            //datacell1循环判断
            for(var j=0;j<chid1.length;j++){
                var entity1=$id("datacell1").dataset.get(j);
                if(entity1!=null && entity1!="undefined"){
                    if(entity1.getProperty("id")==(ids+",").split(",")[i]){
                        istrue="true";
                        err_info+=entity1.getProperty("sa_item_name")+" 已经在收入，支出列表中，不能重复添加！\n ";
                        break;
                    }
                }else{
                    istrue="false";
                }
                  }
           if(istrue=="false"){
            //datacell2循环判断
            for(var j=0;j<chid2.length;j++){
                var entity2=$id("datacell2").dataset.get(j);
               if(entity2!=null && entity2!="undefined"){
                      if(entity2.getProperty("id")==(ids+",").split(",")[i]){
                          istrue="true";
                          err_info+=entity2.getProperty("sa_item_name")+" 已经在代扣、代缴列表中，不能重复添加！\n ";
                          break;
                      }
                }else{
                    istrue="false";
                }
            }
            }
               if(istrue=='false'){
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        
        var returnAry = new Array();
        returnAry[0]=addids;
        returnAry[1]=err_info;
        return returnAry;
    }
    //datacell2的删除
    function deleteMultiSalaryPro2_onClick(){
             var ids = findSelections("checkbox_template1");  //取得多选框的选择项      
                  if(ids == null) {  //如果ids为空
           alert('请至少选择一个产品！');
           return;
       }
       if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
            var datacell = $id("datacell2");
        var elementCheckbox = document.getElementsByName("checkbox_template1");
                       for (var i = elementCheckbox.length-1; i >= 0; i--) {
                if (elementCheckbox[i].checked) { // 如果被选中  
            var row = datacell.getRow(i);
            var datasettr = datacell.getEntity(row);
           datasettr.setProperty("display_order","");//显示顺序为空，则表示该项没有被配置
           datacell.deleteRow(i);
             }
           }
       }
    }  
/*************************************datacell3 相关*******************************************/
  //datacell3到添加页面
       function toAddSalaryPro3_onClick(){   
      var templetid=document.getElementById("templet_id").value;   
      var url="<%=request.getContextPath()%>/jsp/faerp/pps/ppssasalarytemplet/listpps12annualSalaryProject.jsp";
      url=url+"?_ts="+(new Date()).getTime()+"&templet_id="+templetid;
       showModalCenter(url,window,callback3, 700, 500, "薪资项目页面");       
   }
   
   
   function callback3(obj)
    {
       var ids=checkpagesalary3(obj);
        if(ids[1]!=null && ids[1]!="")
        {
            alert(ids[1]);
        }
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/PpssasalarytempletAction.do?cmd=getSalaryProByIds&datatype=annualsalary&date="+new Date()+"",{"ids":ids[0]},   function(json){
                   dc1=$id("datacell3");
              if(json.beans!=null&&json.beans!="")
              {
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell3").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("id", json.beans[i].id);
                       newEntity.setProperty("sa_item_name", json.beans[i].sa_item_name);
                       newEntity.setProperty("sa_item_ename", json.beans[i].sa_item_ename);
                       newEntity.setProperty("annualsalary_property", "0");
                        dc1.insertRow(newEntity);
                        dc1.activeField.editor.hideEditor();   
            }   
                }
              });
              }
           }
  function checkpagesalary3(obj){
        var addids="";
        var chid1 = document.getElementsByName("checkbox_template2");
        var err_info="";
        var ids = obj; 
       for(var i = 0;i<ids.length;i++)
       { 
            var istrue='false';
            //datacell1循环判断
            for(var j=0;j<chid1.length;j++){
                var entity1=$id("datacell3").dataset.get(j);
                if(entity1!=null && entity1!="undefined"){
                    if(entity1.getProperty("id")==(ids+",").split(",")[i]){
                        istrue="true";
                        err_info+=entity1.getProperty("sa_item_name")+" 已经在12万年薪列表中，不能重复添加！\n ";
                        break;
                    }
                }else{
                    istrue="false";
                }
                  }
               if(istrue=='false'){
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        returnAry[1]=err_info;
        return returnAry;
    }
    //datacell3的删除
    function deleteMultiSalaryPro3_onClick(){
             var ids = findSelections("checkbox_template2");  //取得多选框的选择项      
                  if(ids == null) {  //如果ids为空
           alert('请至少选择一个产品！');
           return;
       }
       if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
            var datacell = $id("datacell3");
        var elementCheckbox = document.getElementsByName("checkbox_template2");
                       for (var i = elementCheckbox.length-1; i >= 0; i--) {
                if (elementCheckbox[i].checked) { // 如果被选中  
            var row = datacell.getRow(i);
            var datasettr = datacell.getEntity(row);
           datasettr.setProperty("is_12annualsalary","1");//则表示该项没有被配置
           datasettr.setProperty("annualsalary_property","");
           datacell.deleteRow(i);
             }
           }
       }
    }      
/***********************************************************************************************/    
    //页面保存
    function to_saveData(){
        var action="<%=request.getContextPath()%>/PpssasalarytempletAction.do?cmd=updateppssalarytempletitem";
        var itemid=document.getElementById("sa_salaryitem_id").value;
      if(itemid==""){
        alert("请选择实发合计校验项！");
        return;
      }
      var templetid=document.getElementById("templet_id").value;
      var annualsalary12wdisplaydata=document.getElementById("annualsalary12wdisplaydata").value;
        var myAjax = new Ajax(action);
      myAjax.addParam('templet_id', templetid);
      myAjax.addParam('annualsalary12wdisplaydata',annualsalary12wdisplaydata);
      myAjax.addParam('sa_item_id', itemid);
        var data1=$id("datacell1");
        var data2=$id("datacell2");
        var data3=$id("datacell3");
        var xmlSubmit=null;
        if(data1.dataset.toString()!=""&&data2.dataset.toString()!=""){//datacell1 和datacell2都不为空
               xmlSubmit=data1.dataset.toString()+data2.dataset.toString()+data3.dataset.toString();
        }else if(data1.dataset.toString()!="" && data2.dataset.toString()==""){//datacell1不为空
               xmlSubmit=data1.dataset.toString()+data3.dataset.toString();
        }else if(data1.dataset.toString()==""&&data2.dataset.toString()!=""){//datacell2不为空
               xmlSubmit=data2.dataset.toString()+data3.dataset.toString();
        }else{
                alert("没有要配置的薪资项目，不需要保存!");
                return;
        } 
       myAjax.submitXML(xmlSubmit);
       var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      var oid = myAjax.getProperty("returnMessage");
                      //window.location.href=window.location.href;
                      //显示校验按钮
                      $id("verification").style.display="inline";
                      //隐藏部分按钮
                      $id("ccParent1").style.display="none";
                      $id("ccParent2").style.display="none";
                      $id("ccParent3").style.display="none";
                      $id("save").style.display="none";
                 }
    }
    
   /*******datacell1上移和下移*********/
     function upIt(){
        var dc1 = $id("datacell1");
        var curRow = dc1.getRowByCell(dc1.activeCell);
        if(curRow == null){
            alert("请选择一条数据!");
            return false ;
        }
        var curRowIndex =  curRow.getAttribute('__entity_rowno');
        if (curRowIndex <= 0) {
            alert("只能选择一条数据!");
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
        var dc1 = $id("datacell1");
        var curRow = dc1.getRowByCell(dc1.activeCell);
        if(curRow == null){
            alert("请选择一条数据!");
            return false ;
        }
        var curRowIndex =  curRow.getAttribute('__entity_rowno');
        var totalCount = dc1.dataset.getLength();
        //alert((curRowIndex-0) + 1);
        var curRowIndex_1 = (curRowIndex-0) + 1
        if (curRowIndex_1 >= totalCount) {
            alert("只能选择一条数据!");
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
    
    
    /*******datacell2上移和下移*********/
     function upIt2(){
        var dc1 = $id("datacell2");
        var curRow = dc1.getRowByCell(dc1.activeCell);
        if(curRow == null){
            alert("请选择一条数据!");
            return false ;
        }
        var curRowIndex =  curRow.getAttribute('__entity_rowno');
        if (curRowIndex <= 0) {
            alert("只能选择一条数据!");
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
    
    
    function downIt2(){
        var dc1 = $id("datacell2");
        var curRow = dc1.getRowByCell(dc1.activeCell);
        if(curRow == null){
            alert("请选择一条数据!");
            return false ;
        }
        var curRowIndex =  curRow.getAttribute('__entity_rowno');
        var totalCount = dc1.dataset.getLength();
        //alert((curRowIndex-0) + 1);
        var curRowIndex_1 = (curRowIndex-0) + 1
        if (curRowIndex_1 >= totalCount) {
            alert("只能选择一条数据!");
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
   /***********************************************datacell 结束********************************************************/
   
   /**************************************************校验历史***************************************/
   function  verification_onClick(){
        var action="<%=request.getContextPath()%>/PpssasalarytempletAction.do?cmd=verificationData";
        var myAjax = new Ajax(action);
        myAjax.addParam('templet_id', document.form_treebasic.templet_id.value);
        myAjax.submit();
       var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      var oid = myAjax.getProperty("returnMessage");
                      cancel_onClick();
                 }
   }
    
</script>
</head>
<body >
<div id="right">
<form name="form_treebasic" id="form_treebasic" method="post"  >
<input type="hidden" id="templet_id" name="templet_id" value="${bean.id}">
<script type="text/javascript">
writeTableTopFesco('薪资模版配置','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_x" style="height: 70px;">
<div id="ccChild1"     class="box_xinzeng" style="height: 70px;"> 
<table  width="100%" height="70" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ></span>客户名称</td>
            <td class="td_2"  >
                <input type="text" class="text_field"  id="customer_name"  name="customer_name" inputName="客户名称" value="${bean.customer_name}" maxLength="30" readonly="readonly""/> 
            </td>
            <td class="td_1" > </span>薪资模版代码</td>
            <td class="td_2 " >
            <input type="text" class="text_field"  id="salary_templet_code"  name="salary_templet_code" inputName="薪资模版代码" value="${bean.salary_templet_code}" maxLength="30" readonly="readonly""/>  
            </td>
             <td class="td_1" ></span>薪资模版名称</td>
            <td class="td_2" >
             <input type="text" class="text_field"  id="salary_templet_name"  name="salary_templet_name" inputName="薪资模版名称" value="${bean.salary_templet_name }" maxLength="30"  readonly="readonly""/>
             </td>
        </tr>
        <tr>
        <td  class="td_1" ><span class="style_required_red">* </span>实发合计校验项选择</td>
        <td class="td_2">
         <r:comboSelect id="sa_salaryitem_id" name="sa_salaryitem_id" queryAction="/FAERP/PpssasalarytempletAction.do?cmd=queryPpsSalaryItemData&salarytempletid=${bean.id}"
              textField="sa_item_name" valueField="id" xpath="PpssasalarytempletitemVo" width="200px" nullText="请选择" messagekey="please_choose" value="${itemid}" /> 
              </td>
              <td class="td_1">12万年薪是否显示&nbsp;</td>
              <td class="td_2">  <d:select dictTypeId="ANNUALSALARYDATA"  name="annualsalary12wdisplaydata" id="annualsalary12wdisplaydata" property="bean/annualsalary12wdisplaydata" /></td>
               <td class="td_1">&nbsp;</td>
              <td class="td_2">&nbsp;</td>
        </tr>
    </table>
  </div>
 </div>
    <!-- 收入、支出部分  begin-->
    <div id="ccParent1" class="button"  >
    <div class="xz_title" style="padding-top: 10px">收入、支出部分</div>
    <div class="button_right" style="padding-left: 10px">
        <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddSalaryPro_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiSalaryPro1_onClick();">
        <input class="q" type="button"   value="上移"    onClick="upIt();">
        <input class="q" type="button"   value="下移"    onClick="downIt();">
</div>    
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell1"
        queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getSalaryitemData_2&itemtype=salaryinout&templetid=${bean.id }"
        width="98%" height="198px" xpath="PpssasalarytempletitemVo" submitXpath="PpssasalarytempletitemVo" 
         paramFormId="datacell_formid1" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
      <r:field fieldName="id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
         <r:field fieldName="sa_item_name" label="薪资项目名称" width="180px" allowModify="false" >
        </r:field>
            <r:field fieldName="sa_item_ename" label="薪资项目英文名称" width="180px" allowModify="true" >
            <h:text/>
        </r:field>
             <r:field fieldName="payroll_name" label="工资单名称" width="245px" allowModify="true" >
            <h:text/>
        </r:field>
        <r:field fieldName="property" label="增减属性" width="245px" allowModify="true" >
        <d:select dictTypeId="PROPERTY"  />
        <h:text/>
        </r:field>
           <r:field fieldName="ishide" label="零值是否显示" width="260"  >
           <d:select dictTypeId="TrueOrFalse"  />
        </r:field>
        <r:field fieldName="display_order" label="排序" width="0"  >
        </r:field>
    </r:datacell>
     <!-- 收入、支出部分  end-->
     
     <!--代扣、代缴部分  begin-->
    <div id="ccParent2" class="button" >
    <div class="xz_title" style="padding-top: 10px">代扣、代缴部分</div>
    <div class="button_right" style="padding-left: 10px">
        <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddSalaryPro2_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiSalaryPro2_onClick();">
        <input class="q" type="button"   value="上移"    onClick="upIt2();">
         <input class="q" type="button"   value="下移"    onClick="downIt2();">
</div>    
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell2"
        queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getSalaryitemData_2&itemtype=salarydown&templetid=${bean.id }"
        width="98%" height="198px" xpath="PpssasalarytempletitemVo2" submitXpath="PpssasalarytempletitemVo2" 
         paramFormId="datacell_formid2" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
       <r:field fieldName="id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus1"  align="center" ></r:field>
         <r:field fieldName="sa_item_name" label="薪资项目名称" width="180px" allowModify="false" >
        </r:field>
           <r:field fieldName="sa_item_ename" label="薪资项目英文名称" width="180px" allowModify="true" >
            <h:text/>
        </r:field>
            <r:field fieldName="payroll_name" label="工资单名称" width="300px" allowModify="true" >
            <h:text/>
        </r:field>
        <r:field fieldName="property" label="增减属性" width="245px" allowModify="true" >
        <d:select dictTypeId="PROPERTY" />
        </r:field>
           <r:field fieldName="ishide" label="零值是否显示" width="260" >
           <d:select dictTypeId="TrueOrFalse" />
        </r:field>
         <r:field fieldName="display_order" label="排序" width="0"  >
        </r:field>
    </r:datacell>
     <!-- 代扣、代缴部分  end-->
     
      <!--12W年薪  begin-->
    <div id="ccParent3" class="button" >
    <div class="xz_title" style="padding-top: 10px">12万年薪部分</div>
    <div class="button_right" style="padding-left: 10px">
        <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddSalaryPro3_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiSalaryPro3_onClick();">
</div>    
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell3"
        queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getSalaryitemData_2&itemtype=12annualsalary&templetid=${bean.id }"
        width="98%" height="198px" xpath="PpssasalarytempletitemVo3" submitXpath="PpssasalarytempletitemVo3" 
         paramFormId="datacell_formid3" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
       <r:field fieldName="id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus2"  align="center" ></r:field>
         <r:field fieldName="sa_item_name" label="薪资项目名称" width="300px" allowModify="false" ></r:field>
            <r:field fieldName="sa_item_ename" label="薪资项目英文名称" width="300px" allowModify="true" >
            <h:text/>
        </r:field>
        <r:field fieldName="annualsalary_property" label="12万年薪增减属性" width="245px" allowModify="true" >
        <d:select dictTypeId="PROPERTY" />
        </r:field>
        <r:field fieldName="is_12annualsalary_property" label="12万年薪数据属性" width="245px" allowModify="true" >
        <d:select dictTypeId="annualsalary12wdata" />
        </r:field>
    </r:datacell>
     <!-- 12W年薪  end-->
     
     
     
     <table class="table_noFrame"  align="center">
    <tr>
         <td >
        <input name="button_back"   id="verification" style="display:none"  class="icon_2" type="button" value="检验历史"  onclick="javascript:verification_onClick();" >
        <input name="button_app" id="save" class="icon_2" type="button" value="保存"  onclick="javascript:to_saveData();" >
        <input name="button_back" class="icon_2" type="button" value="返回"  onclick="javascript:cancel_onClick();" >
        </td>
    </tr>
</table>
     
</form>

<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</div>
</div>
</body>

</fmt:bundle>
</html>
<script language="javascript">

</script>
