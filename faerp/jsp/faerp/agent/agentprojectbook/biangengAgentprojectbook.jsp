<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.agent.agentprojectbook.vo.AgentprojectbookVo" %>
<%@ page import="rayoo.agent.agentprojectbook.util.IAgentprojectbookConstants" %>
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
<script language="javascript"><!--

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
  
  function setCheckboxStatus1(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template1' value='"+value+"' >";
    }
    
           function toAddProduct_onClick(){      
         var agentid=document.getElementById("agentId").value;
         var city_id=document.getElementById("city_id").value;
        
      var url="<%=request.getContextPath()%>/jsp/faerp/agent/agentserviceproduct/listAgentserviceproduct.jsp?agentId="+agentid+"&city_id="+city_id;
   url=url+"&_ts="+(new Date()).getTime();
             showModalCenter(url, window,callback1, 700, 800, "服务产品页面");       
   }
     function callback1(obj)
    {
    var start_date1=document.getElementById("start_date").value;
    var end_date1=document.getElementById("end_date").value;
       var ids=checkpageproduct(obj);
    
        if(ids!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/AgentServiceProductAction.do?cmd=AgentServiceProductByIds&date="+new Date()+"",{"ids":ids[0]},   function(json){
                        
                   dc1=$id("datacell1");
              if(json.beans!=null&&json.beans!="")
              {
            
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                                newEntity.setProperty("service_product_id", json.beans[i].id);
                       newEntity.setProperty("big_type_id", json.beans[i].big_type_id);
                       newEntity.setProperty("small_type_id", json.beans[i].small_type_id);
                       newEntity.setProperty("city_id", json.beans[i].city_id);
                       newEntity.setProperty("product_name", json.beans[i].product_name);
                        newEntity.setProperty("product_price", json.beans[i].product_price);                            
                        newEntity.setProperty("description", json.beans[i].description);
                        newEntity.setProperty("product_id",json.beans[i].product_id);
                          newEntity.setProperty("start_date",start_date1);
                            newEntity.setProperty("end_date",end_date1);
                        newEntity.setProperty("remark", json.beans[i].remark);                                         
                    
                         dc1.insertRow(newEntity);
                        dc1.activeField.editor.hideEditor();   
           
            }   
                       countAllMoney();
                }
             
                 
              }
              )} };
       
    
    function checkpageproduct(obj)
    {
          var addids="";
        var chid1 = document.getElementsByName("checkbox_template1");
        var ids = obj; 
   
        for(var i = 0;i<ids.length;i++)
        { 
            var istrue='false';
        /*    for(var j=0;j<chid1.length;j++)
            {
                var entity=$id("datacell1").dataset.get(j);   
                if(entity.getProperty("service_product_id")==(ids+",").split(",")[i])
                {
                   istrue="true";
                   alert(entity.getProperty("product_name")+"已经在列表中，请确认与列表中没有重复的才能添加！");
                   return;
                }
                else
                {
                     istrue="false";                       
                }
             }*/
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        return returnAry;
    }
    
    

    var delProducts={}
     function deleteMultiProduct_onClick(){
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
           
            //var id = datasettr.getProperty("id");
            
          // delProducts[id] = true;
           datasettr.setProperty("stauts","0");
            datacell.deleteRow(i);    
           
            }
            }
      countAllMoney();
       }
    }
    
     function setCheckboxStatus2(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template2' value='"+value+"' >";
    }
    
    function toAddItem_onClick(){
     
      var agentid=document.getElementById("agentId").value;
      var url="<%=request.getContextPath()%>/jsp/faerp/agent/agentserviceitem/listAgentserviceitem.jsp?agentId="+agentid;
      url=url+"&_ts="+(new Date()).getTime();
             showModalCenter(url, window,callback2, 700, 800, "服务手续页面");       
  }
  
  function callback2(obj){
  var ids=checkpageitem(obj);
            
        if(ids!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/AgentServiceItemAction.do?cmd=AgentServiceItemByIds&date="+new Date()+"",{"ids":ids[0]},   function(json){
              var dc2= $id("datacell2");
                
              if(json.beans!=null&&json.beans!="")
              {
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell2").styleEntity.clone(true);//只克隆行样式，不带值
                        newEntity.setProperty("service_item_id", json.beans[i].id);
                        newEntity.setProperty("city_id", json.beans[i].city_id);
                        newEntity.setProperty("contact_name", json.beans[i].contact_name);
                        newEntity.setProperty("post_belong", json.beans[i].post_belong);
                        newEntity.setProperty("remark", json.beans[i].remark);  
                     
                          dc2.insertRow(newEntity);
                        dc2.activeField.editor.hideEditor();   
                          
                }
         
              }
              })
        }
};

function checkpageitem(obj){
               var addids="";
        var chid1= document.getElementsByName("checkbox_template2");
        var ids = obj;  
        for(var i = 0;i<ids.length;i++)
        { 
            var istrue='false';
            for(var j=0;j<chid1.length;j++)
            { 
                var entity=$id("datacell2").dataset.get(j);   
                if(entity.getProperty("service_item_id")==(ids+",").split(",")[i])
                {
                   istrue="true";
                   alert(entity.getProperty("contact_name")+"已经在列表,请确认与列表中没有重复的才能添加！");
                   return;
                }
                else
                {
                     istrue="false";                       
                }
             }
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        return returnAry;
  }
var delItems={};
   function deleteMultiItem_onClick(){
         var ids = findSelections("checkbox_template2");  //取得多选框的选择项      
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
           
       //     var id = datasettr.getProperty("id");
            
          // delItems[id] = true;
            datasettr.setProperty("stauts","0");  
            datacell.deleteRow(i);    
           
            }
       }
              }
 
    }
   function  bianjiCheckbox_onClick(){//服务条款编辑。
       var ids=document.getElementById("templete_id").value;
       var projectbook_name=document.getElementById("projectbook_name").value;
           var pj1=$id("datacell1").dataset;
             var price=0;
               var entityAry=pj1.getAlltEntities();
              for( i=0;i<entityAry.length;i++){
                if("服务费"==entityAry[i].getValue("product_name")){
                     price=entityAry[i].getValue("product_price");
                };
              }
              
                         var start_date=document.getElementById("start_date").value;
                          var end_date=document.getElementById("end_date").value;
                       
                          var remark=document.getElementById("remark").value;
                          
                                        
            var url="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=find1&id="+ ids+"&pro_name="+encodeURI(projectbook_name)+"&price="+price;
                     url=url+"&start_date="+start_date+"&end_date="+end_date+"&remark="+encodeURI(remark);
                   url=url+"&_ts="+(new Date()).getTime();
                     
                      showModalCenter(url, window,callback3, 700, 450, "服务条款页面"); 
   }
  function callback3(reg){
          if(reg!=null){
          _$("#templete_content").val(reg[0]);
            _$("#remark").val(reg[1]);
            }
  }
   
   
        function insert_onClick(){  //插入单条数据
             var end_date=document.getElementById("end_date").value;
         var projectbook_type=document.getElementById("projectbook_type").value;
         
                 if(projectbook_type=='1'){
             if(end_date==null||end_date==""){
               alert("短期项目书结束时间不能为空");
               return;
             }
       }
      var myDate = new Date();
          if(end_date!=null||end_date!=""){          
          if(new   Date(end_date.replace(/-/g,   "/"))<myDate){
          alert("结束时间不能小于当前时间");
          return;
          }
       }
      jQuery("#save1").attr("disable",true);
                    var pj1=$id("datacell1");
                    var dc2=$id("datacell2");
           var xmlSubmit = pj1.dataset.toString();
            xmlSubmit +=  dc2.dataset.toString();
           var action="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=insertProjectbook";
                var myAjax = new Ajax(action);
           var form=document.getElementById("datacell_formid");
            
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                   
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                      
                    }
                }
            }  
           
                         myAjax.submitXML(xmlSubmit, 'UTF-8');
                            var returnNode = myAjax.getResponseXMLDom();
                                         if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue")!=""&& myAjax.getValue("root/data/returnValue")!=null  ) {
                    
                      alert( '项目书添加成功！' );
                      window.location.href="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=queryAll&backFlag=true";
                  } else {
                      alert( '项目书添加失败，请确认正确填写内容！' ); 
                        jQuery("#save1").attr("disable",false);
                        return;
                  }
             }
    }
    
   function IsProduct(){
        var dataset=$id("datacell1").dataset;
           
              var allEntities=dataset.getAlltEntities(); 
              var len=dataset.getLength();
        
              for(i=0;i<len;i++){
                  if(dataset.get(i).status == 3 || dataset.get(i).status == 4){
             continue;
          }
                       var star_date=allEntities[i].getProperty("start_date");
                      var end_date=allEntities[i].getProperty("end_date");
                           if(star_date==null||star_date==""){
                           alert("产品开始时间不能为空");
                                $id("datacell1").loadData();
                             $id("datacell1").refresh();
                           return false;
                           }
                           if(star_date>end_date&&end_date!=null&&end_date!=""){
                        alert("产品开始时间不能小于结束时间");
                             $id("datacell1").loadData();
                             $id("datacell1").refresh();
                        return false;
                     }
                for(j=i+1;j<len;j++){
                if(dataset.get(j).status == 3 || dataset.get(j).status == 4){
             continue;
          }
                  var star_date1=allEntities[j].getProperty("start_date");
                      var end_date1=allEntities[j].getProperty("end_date");
                  if(allEntities[i].getProperty("service_product_id")==allEntities[j].getProperty("service_product_id")){
                
                      if(star_date>star_date1&& star_date<end_date1){
                alert(allEntities[i].getProperty("product_name")+",已经在列表中，同一时间内不能有重复产品!");
                      $id("datacell1").loadData();
                             $id("datacell1").refresh();
                      return false;
                      }
                     if(end_date>star_date1&&end_date<end_date1){
                          alert(allEntities[i].getProperty("product_name")+",已经在列表中，同一时间内不能有重复产品!");
                            $id("datacell1").loadData();
                             $id("datacell1").refresh();
                      return false;
                     }
                  }
                  if(end_date==null||end_date==""){
                         if(allEntities[i].getProperty("service_product_id")==allEntities[j].getProperty("service_product_id")&&end_date1>star_date){
                          alert(allEntities[i].getProperty("product_name")+",已经在列表中，同一时间内不能有重复产品!");
                            $id("datacell1").loadData();
                             $id("datacell1").refresh();
                      return false;
                         }
                  }
                  if(end_date1==null||end_date1==""){
                        if(allEntities[i].getProperty("service_product_id")==allEntities[j].getProperty("service_product_id")&&end_date>star_date1){
                          alert(allEntities[i].getProperty("product_name")+",已经在列表中，同一时间内不能有重复产品!");
                            $id("datacell1").loadData();
                             $id("datacell1").refresh();
                      return false;
                         }
                  
                  }
                
                }
              }
              
             return  true;
  }
 function update_onClick(){
     var end_date=document.getElementById("end_date").value;
      var projectid=document.getElementById("projectbookid").value;
         var projectbook_type=document.getElementById("projectbook_type").value;
                 if(projectbook_type=='1'){
             if(end_date==null||end_date==""){
               alert("短期项目书结束时间不能为空");
               return;
             }
       }
       var myDate = new Date();
          if(end_date!=null||end_date!=""){          
          if(new   Date(end_date.replace(/-/g,   "/"))<myDate){
          alert("结束时间不能小于当前时间");
          return;
          }
       }
         var dataset1 = $id("datacell1").dataset;
              var len1 = dataset1.getLength();
                   for(var i =0 ; i < len1 ; i++){
                        var product_price= dataset1.get(i).getProperty("product_price");
                        if(product_price==""||product_price==null){
                        alert("价格不能为空");
                        retrun;
                        }
              }
              if( IsProduct()){
             $id("datacell1").isModefied=true;
             $id("datacell2").isModefied=true;
             if($id("datacell1").submit()&&$id("datacell2").submit()){
     jQuery("#save1").attr("disable",true);
     var param = jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=updateProjectbook&"+param;
        jQuery.post(url,function(data){
    
             if(data){
                 if(data==0){
                      alert('修改失败!');
                        jQuery("#save1").attr("disable",false);
                      return;
                 }else{
                    alert("修改成功");
                      
                     form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=queryAll";
                    form.submit();
                 }
                 
             }else{
                      alert('修改失败!');
              form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=queryAll";
                    form.submit();
                    }
       });
        }
        }
    }
  
  function toSaveProduct_onClick(){   //项目书服务产品的保存
    /*     var dataset1 = $id("datacell1").dataset;
              var len1 = dataset1.getLength();
                   for(var i =0 ; i < len1 ; i++){
                        var end_date = dataset1.get(i).getProperty("end_date");
                        if(end_date==""||end_date==null){
                        alert("服务产品截至日期不能为空");
                        retrun;
                        }
              }*/
         
   if( IsProduct()){
        $id("datacell1").isModefied = true;
        if($id("datacell1").submit()){
        alert("保存成功");
        };
}
  }
      function toSaveItem_onClick(){
              $id("datacell2").isModefied = true;
             if($id("datacell2").submit()){
               alert("保存成功");
             };
      }
      function dsep_onClick(){//返回到上一步页面
         form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=astep";
        form.submit();
      }
      function cancel_onClick(){
           form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=queryAll";
           form.submit();
      }
       window.onload=function(){//设置项目书开始时间不能修改
       $id("start_date").setReadOnly(true);
   
  }
--></script>

</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" id="projectbookid" name="projectbookid" value="${bean.id }">
 <input type="hidden"  id="templete_id" name="templete_id" value="${bean.templete_id }">
 <input type="hidden"  id="templete_name" name="templete_name" value="${bean.templete_name }">
  <input type="hidden"  id="agentId" name="agentId" value="${bean.agent_id}">
    <input type="hidden" id="remark" name="remark" value="${bean.remark }">
    <input type="hidden" id="agent_id" name="agent_id" value="${bean.agent_id }">
    <input type="hidden" id="cust_id" name="cust_id" value="${bean.cust_id }">
     <input type="hidden" id="cust_code" name="cust_code" value="${bean.cust_code}">
     <input type="hidden" id="send_id" name="send_id" value="${bean.send_id }">
     <input type="hidden" id="cust_send_id" name="cust_send_id" value="${bean.cust_send_id }">  
    <input type="hidden" id="cust_receive_id" name="cust_receive_id" value="${bean.cust_receive_id }">

   <div id="right">
<script language="javascript">

        writeTableTopFesco('变更项目书','<%=request.getContextPath()%>/');
</script>

 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng" style="height: 230px"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_1" >项目书编号</td>
			<td class="td_2 " >
				<input type="text" class="text_field" name="projectbook_code"  maxLength="25" value="${bean.projectbook_code }" readonly="readonly"/>
			</td>
			 <td class="td_1" ><span class="style_required_red">* </span>账单收取月</td>
            <td class="td_2 " >
                <d:select id="payment_month" name="payment_month" dictTypeId="PAYMENT_MONTH" value="${bean.payment_month}" ></d:select>           
            </td>
		</tr>
		<tr>
			<td class="td_1" >项目书名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" id="projectbook_name" name="projectbook_name" inputName="projectbook_name" value="${bean.projectbook_name }" maxLength="50" />
			</td>
		<td class="td_1" >城市</td>
            <td class="td_2 ">
             <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       property="bean/city_id"
                       width="200px"
                       nullText="请选择" readonly="true"/>        
            </td>
		</tr>
		<tr>
	       <td class="td_1" >客户名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="cust_name" name="cust_name" inputName="cust_code" value="${bean.cust_name }" maxLength="25" readonly="readonly"/>
            </td>
		<td class="td_1" >委派单</td>
      <td align="left" class="td_2"><input name="send_name" id="send_name" value="${bean.send_name }" readonly="readonly" size="28"> </td>
		</tr>
		<tr>
		<td class="td_1" >受托单位</td>
        <td class="td_2 ">
        <input name="cust_receive_customer" id="cust_receive_customer" value="${bean.cust_receive_customer}" readonly="readonly" size="28">
          
            </td>
		   <td class="td_1" >委托单位</td>
          <td class="td_2 ">
              <input name="cust_send_customer" id="cust_send_customer" value="${bean.cust_send_customer}" readonly="readonly" size="28">
            </td>
			
                
		</tr>
		<tr>
		  <td class="td_1" >开始时间</td>
            <td class="td_2 ">
                   <w:date allowInput="true" id="start_date" name="start_date" format="yyyy-MM-dd" width="185px" property="bean/start_date"  />  
            </td>
                    <td class="td_1" >结束时间</td>
            <td class="td_2 ">
                   <w:date allowInput="true" id="end_date" name="end_date" format="yyyy-MM-dd" width="185px" property="bean/end_date"  />  
       
            </td>
		</tr>
		<tr>
		<td  class="td_1" nowrap="nowrap">项目书类型</td>
          
            <td class="td_2 " >
          <d:select dictTypeId="PROJECTBOOK_TYPE_BD" id="projectbook_type" name="projectbook_type"  value="${bean.projectbook_type}" />
         
            </td>
		<td class="td_1">服务条款模板</td>
    
      <td class="td_2">
       <div id="ccParent1" class="button">
    <div class="button_right">
            
       <input class="b"  type="button"   value="编辑" onClick="bianjiCheckbox_onClick();"></div></div>
                     
        <textarea  class="textarea_limit_words"  rows="16" cols="62" id="templete_content" name="templete_content" style="display: none">${sessionScope.templete_content1 }</textarea>

      
       </td>
       
		</tr>
		  <tr>
            <td class="td_1">特殊说明</td>
            <td colspan="3" class="td_2"><textarea style="width: 500px" rows="2" name="special_description" inputName="特殊说明">${bean.special_description }</textarea></td>
        </tr>
	</table>
   
</div>
 
 <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">产品配置</div>
    <div class="button_right" style="padding-left: 10px">
        <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddProduct_onClick();">
        <!--  <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiProduct_onClick();">-->
       <input class="bc"  type="button" style="padding-left:1px"  value="<fmt:message key="save"/>"  onClick="toSaveProduct_onClick();">
    </div>
    <div class="clear"></div>
    </div>
    <div style="padding: 8 10 8 8;">
    <r:datacell  id="datacell1"
          queryAction="/FAERP/AgentpbserviceproductAction.do?cmd=querypbProduct"      
        submitAction="/FAERP/AgentpbserviceproductAction.do?cmd=biangengpbProduct"
        width="98%" height="190px" xpath="AgentpbserviceproductVo" submitXpath="AgentpbserviceproductVo" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
       <r:field fieldName="service_product_id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus1"  align="center" ></r:field>
        <r:field fieldName="big_type_id" label="产品大类" width="75px" allowModify="false">
         <d:select dictTypeId="big_type_id"  disabled="true"></d:select>
        </r:field>
        <r:field fieldName="small_type_id" label="产品小类" width="130px" allowModify="false">
         <d:select dictTypeId="big_type_id" disabled="true" ></d:select>
        </r:field>
        <r:field fieldName="city_id" label="福利地" width="100px" allowModify="false">
          <r:comboSelect id="cityList" name="cityList " queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText=""  xpath="PB_CITYVo" readonly="true" ></r:comboSelect>               
        </r:field>
        <r:field fieldName="product_name" label="产品名称" width="150px" allowModify="false">
        </r:field>
        <r:field fieldName="product_price" label="价格" width="70px" allowModify="true" ><h:text validateAttr="allowNull=false;type=float" onchange="countAllMoney(); "/>
        </r:field>
         <r:field fieldName="start_date" label="开始日期" width="85px" allowModify="false">
        <w:date format="yyyy-MM-dd"   />
        </r:field>
        <r:field fieldName="end_date" label="截止日期" width="85px" allowModify="true">
            <w:date format="yyyy-MM-dd" extAttr="validateAttr='allowNull=true'"  />
         </r:field>
        <r:field fieldName="description" label="产品说明" width="250px" allowModify="false">
        </r:field>
        <r:field fieldName="remark" label="备注" width="150px" allowModify="false" >
        </r:field>
   
    </r:datacell>
       合计：<input type="text" id="sumprice" name="sumprice" value="" readonly="readonly" >
    </div>
    
    
    
     <div id="ccParent1" >
    <div class="xz_title" style="padding-top: 10px">服务配置</div>
    <div class="button_right" style="padding-left: 10px">
  <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddItem_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"   onClick="deleteMultiItem_onClick();">
       <input class="bc"  type="button" style="padding-left:1px"  value="<fmt:message key="save"/>"    onClick="toSaveItem_onClick();">
    </div>
    <div class="clear"></div>
    </div>
    <div style="padding: 8 10 8 8;">
    <r:datacell  id="datacell2"      
        queryAction="/FAERP/AgentpbserviceitemAction.do?cmd=querypbItem"
        submitAction="/FAERP/AgentpbserviceitemAction.do?cmd=updatepbItem"
        width="98%" height="190px"  xpath="AgentpbserviceitemVo"  submitXpath="AgentpbserviceitemVo" 
         paramFormId="datacell_formid" pageSize="-1">
          <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="service_item_id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus2"  align="center" ></r:field>
        <r:field fieldName="city_id" label="办理城市" width="100px"  >
          <r:comboSelect id="cityList1" name="cityList1 " queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText=""  xpath="PB_CITYVo" readonly="true"></r:comboSelect>               
        </r:field>
        <r:field fieldName="contact_name" label="手续名称" width="150px"  >      
        </r:field>
        <r:field fieldName="post_belong" label="入离职归属" width="80px"  >
            <d:select dictTypeId="POST_BELONG_BD" nullLabel="请选择" disabled="true" ></d:select>
        </r:field>
        <r:field fieldName="remark" label="备注" width="350px" >
           
        </r:field>
    </r:datacell>
    </div>
<div class="mx_button" align="center">
         
       <input type="button" class="icon_2" id="save1" value='<fmt:message key="save"/>' onClick="javascript:update_onClick()" />  
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>  

         
            </div>


</form>
</fmt:bundle>
</body>
</html>
<script language="javascript">
    function countAllMoney(){
        var allmoney=0;
                 var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
      
           if(dataset1.get(i).status == 3){
             continue;
          }
            var mm = dataset1.get(i).getProperty("product_price");         
                allmoney+= parseFloat(mm);  
       }
       
           document.getElementById("sumprice").value=allmoney.toFixed(2);
    }
    $id("datacell1").afterLoadData=function(){
      countAllMoney();
    }
</script>

