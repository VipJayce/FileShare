<%@ page contentType="text/html; charset=UTF-8"%>
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
	<title>添加服务产品</title>
	<script language="javascript">
	      function setCheckboxStatus1(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template1' value='" + value + "' >";
    }
    function toAddItem_onClick() {  //到增加记录页面
    /*
     *    var agentId = document.getElementById("agentId").value;
     *   jQuery.ajax({
     *       type : "post",
     *       url : "<%=request.getContextPath()%>/SalagentAction.do?cmd=checkAgentIsUse&agentId="+agentId,
     *       dataType : "html",
     *       success : function(data) {
     *           if (data > 0 ){
     *               alert("当前供应商已引用，无法添加或删除操作");
     *               return;
     *           }else{
     */
            var url="<%=request.getContextPath()%>/jsp/faerp/common/system/allServiceitemAgent.jsp";
                      showModalCenter(url, window,toaddItemlistrollback,750,455,"添加服务手续"); 
     /*
      *          }
      *      }
      *  });
      */  
    }
    function toaddItemlistrollback(obj){
       var ids=checkpageitem(obj);
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/ServiceitemAction.do?cmd=SimpleProductByIDS&date="+new Date()+"",{"ids":ids[0]},   function(json){
                        
              if(json.beans!=null&&json.beans!="")
              {
              $id("cityList1").refresh();
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("service_item_id", json.beans[i].id);
                       newEntity.setProperty("contact_name", json.beans[i].contact_name);
                       newEntity.setProperty("post_belong", json.beans[i].post_belong);
                       newEntity.setProperty("remark", json.beans[i].remark);                   
                      $id("datacell1").addRow(newEntity);
                         $id("datacell1").activeField.editor.hideEditor();   
                }
                
              }
              });
        }
    }
        function checkpageitem(obj)
    {
          var addids="";
        var chid1 = document.getElementsByName("checkbox_template1");
        var ids = obj; 
        for(var i = 0;i<ids.length;i++)
        {        
                    addids+=(ids+",").split(",")[i]+",";
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        return returnAry;
    }
 var delProducts={};
  var delItems={};
    function deleteMultiItem_onClick(){ //到删除页面
        var agentId = document.getElementById("agentId").value;
        jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/SalagentAction.do?cmd=checkAgentIsUse&agentId="+agentId,
            dataType : "html",
            success : function(data) {
                if (data > 0 ){
                    alert("当前供应商已引用，无法添加或删除操作");
                    return;
                }else{
			        var ids = findSelections("checkbox_template1");  //取得多选框的选择项 
			        if(ids == null) {  //如果ids为空
			           alert('请至少选择一个产品！');
			           return;
			       }
			  
			       if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
			            var datacell = $id("datacell1");
			            var elementCheckbox = document.getElementsByName("checkbox_template1");
			            for (var i = elementCheckbox.length - 1; i >= 0; i--) {
			                if (elementCheckbox[i].checked) { // 如果被选中
			                    var row = datacell.getRow(i);
			                    var datasettr = datacell.getEntity(row);
			                    var id = datasettr.getProperty("id");
			                    delItems[id] = true;
			                    datacell.deleteRow(i);    
			                }
			            }
			        }
                }
            }
        });
    }


    function toSaveItem_onClick(){
               var dataset=$id("datacell1").dataset;
              var allEntitiess=dataset.getAlltEntities();     
               var modifyEntities=dataset.getModifiedEntities();      
               var insertEntities=dataset.getInsertEntities();
            
                    for(i=0;i<insertEntities.length;i++){ 
                    var allEntities=allEntitiess.remove(insertEntities[i]);
             for(j=0;j<allEntities.length;j++){
              if(insertEntities[i].getProperty("city_id")==allEntities[j].getProperty("city_id")&&insertEntities[i].getProperty("contact_name")==allEntities[j].getProperty("contact_name")){
                   alert(insertEntities[i].getProperty("contact_name")+",已经在列表中，请确认与列表中没有重复的才能添加！");
                $id("datacell1").loadData();
           $id("datacell1").refresh();       
                 return;
              }
             }
             } 
                                  for(i=0;i<modifyEntities.length;i++){ 
                                    var allEntities=allEntitiess.remove(modifyEntities[i]);
             for(j=0;j<allEntities.length;j++){      
              if(modifyEntities[i].getProperty("city_id")==allEntities[j].getProperty("city_id")&&modifyEntities[i].getProperty("contact_name")==allEntities[j].getProperty("contact_name")){
                   alert(modifyEntities[i].getProperty("contact_name")+",已经在列表中，请确认与列表中没有重复的才能添加！");
          $id("datacell1").loadData();
           $id("datacell1").refresh();
                 return;
              }
             }
             }    
               
      $id("datacell1").isModefied =true;  
      if($id("datacell1").submit()){
         alert("服务手续保存成功");
         $id("datacell1").loadData();
           $id("datacell1").refresh();
      }
    }
    
   
    
    function checkpageproduct(obj)
    {

          var addids="";
        var chid1 = document.getElementsByName("checkbox_template2");
        var ids = obj; 
        for(var i = 0;i<ids.length;i++)
        { 
                    addids+=(ids+",").split(",")[i]+",";
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        return returnAry;
    }
    
        function toaddProductlistrollback(obj)
    {
    var city_id=document.getElementById("city_id1").value;
       var ids=checkpageproduct(obj);  
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/ProductAction.do?cmd=SimpleProductByIDS1&date="+new Date()+"",{"ids":ids[0]},   function(json){
                        
              if(json.beans!=null&&json.beans!="")
              {
       $id("cityList").refresh();
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell2").styleEntity.clone(true);//只克隆行样式，不带值
                         newEntity.setProperty("product_id", json.beans[i].id);
                         newEntity.setProperty("big_type_id", json.beans[i].big_type_id);
                                 newEntity.setProperty("small_type_id", json.beans[i].small_type_id);
                      newEntity.setProperty("city_id",city_id);
                       newEntity.setProperty("product_name", json.beans[i].product_name);
                  
                     $id("datacell2").addRow(newEntity);
                         $id("datacell2").activeField.editor.hideEditor();   
                }
                
              }
              });
        }
        }
    function toAddProduct_onClick1(){
    /*    
    *    var agentId = document.getElementById("agentId").value;
    *    jQuery.ajax({
    *        type : "post",
    *        url : "<%=request.getContextPath()%>/SalagentAction.do?cmd=checkAgentIsUse&agentId="+agentId,
    *        dataType : "html",
    *        success : function(data) {
    *            if (data > 0 ){
    *                alert("当前供应商已引用，无法添加或删除操作");
    *                return;
    *            }else{
    */
		            var url="<%=request.getContextPath()%>/jsp/faerp/common/system/allProductAgent.jsp";
                    showModalCenter(url, window,toaddProductlistrollback,750,455,"添加产品");
     /*
     *           }
     *       }
     *   });
     */
    }
          function setCheckboxStatus2(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template2'  value ="+value+" >";
    }
       function findSelections(checkboxName) {  //从列表中找出选中的id值列表
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
      function deleteMultiProduct_onClick(){
        var agentId = document.getElementById("agentId").value;
        jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/SalagentAction.do?cmd=checkAgentIsUse&agentId="+agentId,
            dataType : "html",
            success : function(data) {
                if (data > 0 ){
                    alert("当前供应商已引用，无法添加或删除操作");
                    return;
                }else{
                    var ids= findSelections("checkbox_template2");  //取得多选框的选择项      
                    if(ids == null) {  //如果ids为空
                        alert('请至少选择一个产品！');
                        return;
		            }
		            if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
			            var datacell = $id("datacell2");         
			            var elementCheckbox = document.getElementsByName("checkbox_template2");
			            for (var i = elementCheckbox.length - 1; i >= 0; i--) {     
			                if (elementCheckbox[i].checked) { // 如果被选中        
			                    var row = datacell.getRow(i);
			                    var datasettr = datacell.getEntity(row);
			                    var id = datasettr.getProperty("id");
			                    delProducts[id] = true;
			                    datacell.deleteRow(i);    
			                }
			            }
			        }
                }
            }
        });
    }
    
    function toSaveProduct_onClick(){
              var dataset=$id("datacell2").dataset;
              var allEntitiess=dataset.getAlltEntities();     
               var modifyEntities=dataset.getModifiedEntities();      
               var insertEntities=dataset.getInsertEntities();
             
                    for(i=0;i<insertEntities.length;i++){ 
                    var allEntities=allEntitiess.remove(insertEntities[i]);
   
             for(j=0;j<allEntities.length;j++){
             
              if(insertEntities[i].getProperty("city_id")==allEntities[j].getProperty("city_id")&&insertEntities[i].getProperty("product_name")==allEntities[j].getProperty("product_name")){
                   alert(insertEntities[i].getProperty("product_name")+",已经在列表中，请确认与列表中没有重复的才能添加！");
                $id("datacell2").loadData();
           $id("datacell2").refresh();       
                 return;
              }
             }
             } 
                                  for(i=0;i<modifyEntities.length;i++){ 
                                    var allEntities=allEntitiess.remove(modifyEntities[i]);
             for(j=0;j<allEntities.length;j++){      
              if(modifyEntities[i].getProperty("city_id")==allEntities[j].getProperty("city_id")&&modifyEntities[i].getProperty("product_name")==allEntities[j].getProperty("product_name")){
                   alert(modifyEntities[i].getProperty("product_name")+",已经在列表中，请确认与列表中没有重复的才能添加！");
          $id("datacell2").loadData();
           $id("datacell2").refresh();
                 return;
              }
             }
             }    
               
      $id("datacell2").isModefied =true;  
      if($id("datacell2").submit()){
         alert("服务产品保存成功");
         $id("datacell2").loadData();
           $id("datacell2").refresh();
           
      }
    }
   function save_onClick(){ 
     var dataset=$id("datacell2").dataset;
              var allEntitiess=dataset.getAlltEntities();     
               var modifyEntities=dataset.getModifiedEntities();      
               var insertEntities=dataset.getInsertEntities();
             
                    for(i=0;i<insertEntities.length;i++){ 
                    var allEntities=allEntitiess.remove(insertEntities[i]);
   
             for(j=0;j<allEntities.length;j++){
             
              if(insertEntities[i].getProperty("city_id")==allEntities[j].getProperty("city_id")&&insertEntities[i].getProperty("product_name")==allEntities[j].getProperty("product_name")){
                   alert(insertEntities[i].getProperty("product_name")+",已经在列表中，请确认与列表中没有重复的才能添加！");
                $id("datacell2").loadData();
           $id("datacell2").refresh();       
                 return;
              }
             }
             } 
                                  for(i=0;i<modifyEntities.length;i++){ 
                                    var allEntities=allEntitiess.remove(modifyEntities[i]);
             for(j=0;j<allEntities.length;j++){      
              if(modifyEntities[i].getProperty("city_id")==allEntities[j].getProperty("city_id")&&modifyEntities[i].getProperty("product_name")==allEntities[j].getProperty("product_name")){
                   alert(modifyEntities[i].getProperty("product_name")+",已经在列表中，请确认与列表中没有重复的才能添加！");
          $id("datacell2").loadData();
           $id("datacell2").refresh();
                 return;
              }
             }
             }
                    var len1 = dataset.getLength();
                   for(var i =0 ; i < len1 ; i++){
                        var product_price= dataset.get(i).getProperty("product_price");
                        if(product_price==""||product_price==null){
                        alert("价格不能为空");
                        retrun;
                        }
              }    
    var dataset1=$id("datacell1").dataset;
              var allEntitiess1=dataset1.getAlltEntities();     
               var modifyEntities1=dataset1.getModifiedEntities();      
               var insertEntities1=dataset1.getInsertEntities();
            
                    for(i=0;i<insertEntities1.length;i++){ 
                    var allEntities1=allEntitiess1.remove(insertEntities1[i]);
             for(j=0;j<allEntities1.length;j++){
              if(insertEntities1[i].getProperty("city_id")==allEntities1[j].getProperty("city_id")&&insertEntities1[i].getProperty("contact_name")==allEntities1[j].getProperty("contact_name")){
                   alert(insertEntities1[i].getProperty("contact_name")+",已经在列表中，请确认与列表中没有重复的才能添加！");
                $id("datacell1").loadData();
           $id("datacell1").refresh();       
                 return;
              }
             }
             } 
                                  for(i=0;i<modifyEntities1.length;i++){ 
                                    var allEntities1=allEntitiess1.remove(modifyEntities1[i]);
             for(j=0;j<allEntities1.length;j++){      
              if(modifyEntities1[i].getProperty("city_id")==allEntities1[j].getProperty("city_id")&&modifyEntities1[i].getProperty("contact_name")==allEntities1[j].getProperty("contact_name")){
                   alert(modifyEntities1[i].getProperty("contact_name")+",已经在列表中，请确认与列表中没有重复的才能添加！");
          $id("datacell1").loadData();
           $id("datacell1").refresh();
                 return;
              }
             }
             }    
      $id("datacell1").isModefied = true;
                $id("datacell2").isModefied = true;
               
                $id("datacell2").submit();
                 $id("datacell1").submit();
              alert("操作成功")
                        window.close();
                    }
    
                    
                    
</script>
	</head>
	<body>

	<form name="form" method="post" id="datacell_formid"><input
		type="hidden" name="cmd" value="queryAll"> <input
		type="hidden" id="agentId" name="agentId" value="${bean.id }">
	<input type="hidden" id="Item_id" name="Item_id" value="">
	<input type="hidden" id="city_id1" name="city_id1" value="${bean.city_id }">
	<div class="ringht_s">
	<div id="ccParent1" class="button">
	<div class="xz_title">产品配置</div>
	<div class="button_right">
	<ul>
	    <input class="c" type="button"   value="<fmt:message key="insert"/>"   onClick="toAddProduct_onClick1();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiProduct_onClick();">
	<input class="bc"  type="button" style="padding-left:1px"  value="<fmt:message key="save"/>"    onClick="toSaveProduct_onClick();">
</ul>
	</div>
	<div class="clear"></div>
	</div>
	<div style="padding: 8 10 8 8;">
	<r:datacell  id="datacell2"      
        queryAction="/FAERP/AgentServiceProductAction.do?cmd=queryProductData2"
        submitAction="/FAERP/AgentServiceProductAction.do?cmd=updateServiceProduct&city_id=${bean.city_id}"
        width="98%" height="190px" xpath="AgentServiceProductVo"
        submitXpath="AgentServiceProductVo" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
    <r:toolbar location="bottom" tools="nav,pagesize,info" />
          <r:field fieldName="product_id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus2"  align="center" ></r:field>
        <r:field fieldName="big_type_id" label="产品大类" width="100px" allowModify="false">
         <d:select dictTypeId="big_type_id" disabled="true"></d:select>
        </r:field>
        <r:field fieldName="small_type_id" label="产品小类" width="130px" allowModify="false">
         <d:select dictTypeId="big_type_id" disabled="true"></d:select>
        </r:field>
        <r:field fieldName="city_id" label="福利地" width="100px" allowModify="true" >
        <r:comboSelect id="cityList" name="cityList" queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText="请选择"  xpath="PB_CITYVo" validateAttr="allowNull=false"  property="bean/city_id" ></r:comboSelect>  
       </r:field>
        <r:field fieldName="product_name" label="产品名称" width="150px" allowModify="false">
        </r:field>
        <r:field fieldName="product_price" label="价格" width="100px" allowModify="true"><h:text validateAttr="allowNull=false;type=float"/>
        </r:field>
       
        <r:field fieldName="description" label="产品说明" width="250px"><h:text />
        </r:field>
        <r:field fieldName="remark" label="备注" width="200px"><h:text/>
        </r:field>
    </r:datacell></div>
 <div id="ccParent1" class="button">
    <div class="xz_title">服务手续</div>
    <div class="button_right">
    <ul>
        <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddItem_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiItem_onClick();">
        <input class="bc"  type="button" style="padding-left:1px"  value="<fmt:message key="save"/>"    onClick="javascript:toSaveItem_onClick();">
    </ul>
    </div>
    <div class="clear"></div>
    </div>
    <div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
        queryAction="/FAERP/AgentServiceItemAction.do?cmd=searchItemData"
        submitAction="/FAERP/AgentServiceItemAction.do?cmd=updateItemData&city_id=${bean.city_id}"
        width="98%" height="190px" xpath="AgentServiceItemVo"
        submitXpath="AgentServiceItemVo" paramFormId="datacell_formid" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
       <r:field fieldName="service_item_id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus1"  align="center" ></r:field>
           <r:field fieldName="city_id" label="办理城市" width="100px" allowModify="true" >
          <r:comboSelect id="cityList1" name="cityList1" queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText="请选择"  xpath="PB_CITYVo" validateAttr="allowNull=false"  property="bean/city_id" ></r:comboSelect>               
        </r:field>
        <r:field fieldName="contact_name" label="手续名称" width="150px" >
            
        </r:field>
        <r:field fieldName="post_belong" label="服务类型" width="80px" allowModify="false">
            <d:select dictTypeId="POST_BELONG_BD"  disabled="true" ></d:select>
        </r:field>
        <r:field fieldName="remark" label="备注" width="350px" allowModify="true">
            <h:text />
        </r:field>
    </r:datacell></div>
   <div class="mx_button" style="text-align: center;padding-top:5px;">
        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick();" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:window.close();"/>
        </div>
	</div>
	</div>
	</form>
</fmt:bundle>
</body>
</html>
