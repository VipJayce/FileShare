<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>派工单编辑</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    //更新服务手续项目
    function updateDataCell_onClick() { 
      var dataset = $id("datacell2").dataset;
         var allEntities=dataset.getAlltEntities(); 
              var len= dataset.getLength();
             
                   for(var i =0 ; i < len ; i++){
                  
                  if(dataset.get(i).status == 3 || dataset.get(i).status == 4){
                         continue;
              }
                   
                  for(j=i+1;j<len;j++){
                             
                                      if(dataset.get(j).status == 3 || dataset.get(j).status == 4){
                                     continue;
                                     
                                       }    
                      
                                if(allEntities[i].getProperty("service_item_id")==allEntities[j].getProperty("service_item_id")){
                                 alert("不能有重复服务手续");
                                 return;
                                }
                  }
              }
  $id("datacell2").isModefied = true;
        if($id("datacell2").submit()){
         alert("保存成功");
        }
    }
    
    //更新服务产品项目
    function updateProductCell_onClick(){
    
        $id("datacell1").submit();   
    }
    
    //校验
    function vailform(){
        var  projectbook_id = jQuery("#projectbook_id").val();
        if(!projectbook_id){
            alert("请选择项目书");
            return false;
        }
        var  emp_id = jQuery("#emp_id").val();
        if(!emp_id){
            alert("请选择员工");
            return false;
        }
        var  change_date = $id("change_date").getValue();
        if(!change_date){
            alert("请要求变化生效时间");
            jQuery("#change_date").focus();
            return false;
        }
        
        return true;
    }
    

    function save_onClick1(){
   var dataset = $id("datacell2").dataset;
         var allEntities=dataset.getAlltEntities(); 
              var len= dataset.getLength();
             
                   for(var i =0 ; i < len ; i++){
                  
                  if(dataset.get(i).status == 3 || dataset.get(i).status == 4){
                         continue;
              }
                   
                  for(j=i+1;j<len;j++){
			                 
			                          if(dataset.get(j).status == 3 || dataset.get(j).status == 4){
			                         continue;
			                         
					                   }    
			          
			                    if(allEntities[i].getProperty("service_item_id")==allEntities[j].getProperty("service_item_id")){
			                     alert("不能有重复服务手续");
			                     return;
			                    }
                  }
              }
     var  code = jQuery("#edit_id").val();
      var action = "<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=updateProductItem1";
                       datacell=$id("datacell1");
            var xmlSubmit = datacell.dataset.toString();
            var myAjax = new Ajax(action);
            var form =document.getElementById("sendPostForm");
          
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
                 if( myAjax.getValue("root/data/returnValue")!=0 ) {
                       
                        if ($id("datacell2").isModefied == true){
                    updateDataCell_onClick();
                }
                  } else {
                      alert( '未设定任何产品！' ); 
                      return;
                  }
             }
        
                   form.action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=updateapply&id="+code;
                   form.submit();
                 returnValue = ["0"];
            window.close();
            window.opener.insertcallBack(returnValue);
    }
    //保存
    function save_onClick(){  //保存
     if(vailform()){
            var  code = jQuery("#edit_id").val();
   
                if ($id("datacell1").isModefied == false){
           
                    updateProductCell_onClick();
                }
            
           
            form.submit();
            returnValue = ["0"];
            window.close();
            window.opener.insertcallBack(returnValue);
       }
    }
    
    //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
  
    //按项目书构建服务产品与手续
    function bulidProjectBookInfo(){
        $id("datacell1").addParam("projectbook_id",jQuery("#projectbook_id").val());
        $id("datacell2").addParam("projectbook_id",jQuery("#projectbook_id").val());
        $id("datacell1").addParam("sendpost_id",jQuery("#edit_id").val());
        $id("datacell2").addParam("sendpost_id",jQuery("#edit_id").val());
        
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        
        $id("datacell2").loadData();
        $id("datacell2").refresh();
        setServiceStatus();
    }
    
    function setServiceStatus(){
        var dc = $id("datacell2");
        var count = dc.getCurrentRowCount();
        for (var i = 0;i < count; i++){
	        dc.setCellValue(dc.getCell(i,5) ,"0"); 
        }
    }
    
    function toAdd_onClick() { 
        $id("datacell2").addRow(); 
           $id("service_idList").refresh();
        var datacell = $id("datacell2");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);
        datasettr.setProperty("status_bd",'0');
        var sendpost_id = jQuery("#edit_id").val();
        if (sendpost_id){
            datasettr.setProperty("sendpost_id",sendpost_id);
        }
      /*  var projectbook_id = jQuery("#projectbook_id").val();
        if (projectbook_id){
            datasettr.setProperty("projectbook_id",projectbook_id);
        }*/
    }
    
    //删除服务手续项
    function deleteMulti_onClick(){
    var datacell = $id("datacell2");
           var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);
        if( datasettr.getProperty("status_bd")=='1'&&datasettr.getProperty("id")!="" ){
        alert("服务已办理不能删除");
        return;
        }
        $id("datacell2").deleteRow();

    }
    
   
</script>
</head>
<body>

<form name="form" method="post" id="sendPostForm">
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="itemCellValues" id="itemCellValues"/>
    <input type="hidden" name="productCellValues" id="productCellValues"/>
    <input type="hidden" name="status" id="status" value="${bean.status}"/>
    <input type="hidden" name="isModify" id="isModify" value="${isModify}">
    <input type="hidden" name="isPost" id="isPost">
    <input type="hidden" name="emp_status" id="emp_status" value="${bean.emp_status }">
    <input type="hidden" name="end_date1" id="end_date1" value="${bean.charge_end_date }">
	<div id="right">
	    <script language="javascript">
		    writeTableTopFesco('离职派工单维护','<%=request.getContextPath()%>/');  //显示本页的页眉
		</script>
	    <div class="ringht_x">
	        <div id="ccChild1" class="box_xinzeng" style="height: 330px;"> 
	            <div class="xz_title">基本信息</div>
	            <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	                <tr>
	                    <td  class="td_1" width="23%" ><span style="color:red;">*</span>员工编号</td>
	                    <td  class="td_2" width="28%">
	                       <input type="hidden" name="emp_post_id" id="emp_post_id" value="${bean.emp_post_id}">
	                       <input type="hidden" name="emp_id" id="emp_id" value="${bean.emp_id}">
	                       <input type="text" class="text_field" name="emp_code" id="emp_code" value="${bean.emp_code }" readonly="readonly">
			             
	                    </td>
	                    <td  class="td_1" width="23%" >员工姓名</td>
	                    <td  class="td_2 " width="28%" >
	                        <input type="text" class="text_field" name="emp_name" id="emp_name" inputName="员工姓名" readonly="readonly" value="${bean.emp_name}"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td  class="td_1" width="23%" >员工联系方式</td>
	                    <td  class="td_2" width="28%">
	                        <input type="text" class="text_field" name="mobile" id="mobile" inputName="员工联系方式" readonly="readonly" value="${bean.emp_mobile}"/>
	                    </td>
	                    <td  class="td_1" width="23%" >E-MAIL</td>
	                    <td  class="td_2 " width="28%" >
	                        <input type="text" class="text_field" name="email" id="email" inputName="E-MAIL" readonly="readonly" value="${bean.emp_email}"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td  class="td_1" width="23%" >身份证号</td>
	                    <td  class="td_2" width="28%">
	                        <input type="text" class="text_field" name="id_card" id="id_card" inputName="身份证号" readonly="readonly" value="${bean.emp_idCard}"/>
	                    </td>
	                    <td  class="td_1" width="23%" >户口性质</td>
	                    <td  class="td_2 " width="28%" >
	                        <input type="text" class="text_field" name="resident_type_bd" id="resident_type_bd" readonly="readonly" inputName="户口性质" value="${bean.emp_resident_type}"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td  class="td_1" width="23%" >派往地区</td>
	                    <td  class="td_2" width="28%">
	                        <input type="text" class="text_field" name="" id="" inputName="派往地区" readonly="readonly"/>
	                    </td>
	                    <td  class="td_1" width="23%" >所属客户</td>
	                    <td  class="td_2 " width="28%" >
	                        <input type="text" class="text_field" name="cust_name" id="cust_name" inputName="所属客户"  readonly="readonly" value="${bean.cust_name}"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td  class="td_1" width="23%" >出生年月</td>
	                    <td  class="td_2" width="28%">
	                       <input type="text" class="text_field" name="birth_date" id="birth_date" inputName="出生年月"  readonly="readonly" value="<fmt:formatDate value="${bean.birth_date}" pattern="yyyy-MM-dd"/>" />
	                    </td>
	                    <td  class="td_1" width="23%" >入职时间</td>
	                    <td  class="td_2 " width="28%" >
	                        <w:date allowInput="true" id="entry_date" name="entry_date" format="YYYY-MM-DD" property="bean/entry_date" width="190px"/>
	                    </td>
	                </tr>
	                <tr>
                        <td  class="td_1" width="23%" ></span>项目书名称</td>
                        <td  class="td_2" width="28%">
                           <input type="hidden" name="projectbook_id" id="projectbook_id" value="${bean.projectbook_id}"/>
                           <input type="text" class="text_field" name="projectbook_name" id="projectbook_name" inputName="项目书名称" value="${bean.projectbook_name}" readonly="readonly"/>
                        </td>
                        <td  class="td_1" width="23%" >供应商名称</td>
                        <td  class="td_2 " width="28%" >
                           <input type="hidden" name="agent_id" id="agent_id"  value="${bean.agent_id}">
                            <input type="text" class="text_field" name="agent_name" id="agent_name" inputName="供应商名称" value="${bean.agent_name}" readonly="readonly"/>
                        </td>
                    </tr>
	                <tr>
	                    <td  class="td_1" width="23%" >入离职状态</td>
	                    <td  class="td_2" width="28%">
	                       <d:select dictTypeId="POST_STATUS_BD" property="bean/post_status_bd" disabled="true"></d:select></td>
	            
	                       </td>
	                    <td  class="td_1" width="23%" ><span style="color:red;">*</span>要求变化生效时间</td>
	                    <td  class="td_2" width="28%">
	                        <w:date allowInput="true" id="change_date" name="change_date" format="YYYY-MM-DD" property="bean/change_date" width="190px"/>
	                    </td>
	                </tr>
	    
	                <tr>
	                    <td  class="td_1" width="23%" >备注</td>
	                    <td  class="td_2" width="28%" colspan="3">
	                        <textarea rows="5" cols="80" name="remark">${bean.remark}</textarea>
	                    </td>
	                </tr>
	            </table>
	        </div>
	        <div id="ccParent1" class="button"> 
              
                <div class="clear"></div>           
            </div> 
            <div class="xz_title">服务产品</div>
            <div id="productCCParent" class="button"> 
              
                <div class="clear"></div>           
            </div> 
            <div style="padding: 8 10 8 8;">
			    <r:datacell id="datacell1" 
			                queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=queryProjectServiceProduct&projectbook_id=${bean.projectbook_id}&sendpost_id=${bean.id}"
			                submitAction="/FAERP/AgentEmpSendPostAction.do?cmd=updateProductItem"   
			                width="70%" height="200px" 
			                xpath="AgentSendPostOrderItemVo" 
			                submitXpath="AgentSendPostOrderItemVo"
			                paramFormId="sendPostForm" 
			                pageSize="100"
			                readonly="false">
                    <r:field fieldName="id" label="" width="0" ></r:field>
                    <r:field fieldName="service_product_id" label="" width="0" ></r:field>
			        <r:field fieldName="product_id" label="" width="0" ></r:field>
			        <r:field fieldName="product_name" label="产品名称"></r:field>
			        <r:field fieldName="money" label="产品价格">
                   
			        </r:field>
			        <r:field fieldName="frequency_bd" label="收费频率">
			             <d:select dictTypeId="FREQUENCY_BD" disabled="true"/>
                        <h:text/>
                    </r:field>
			        <r:field fieldName="start_date" label="开始时间">
                        <w:date  id="start_date" name="start_date" format="YYYY-MM-DD" property="bean/start_date" width="190px" disabled="true"/>
                    </r:field>
			        <r:field fieldName="end_date" label="结束时间">
                        <w:date allowInput="true" id="end_date" name="end_date" format="YYYY-MM-DD"  width="190px" />
                    </r:field>
			    </r:datacell>
			</div> 
			
			<div id="serviceCCParent" class="button"> 
			    <div class="button_right">
			        <ul>
			            <li class="c"><a onClick="javascript:toAdd_onClick();">新增</a></li>
			            <li class="bc"><a onClick="javascript:updateDataCell_onClick();">保存</a></li>
			            <li class="d"><a onClick="javascript:deleteMulti_onClick();">删除</a></li>
			        </ul>
			    </div>
			    <div class="clear"></div>           
			</div> 
			<div style="padding: 8 10 8 8;">
                <r:datacell id="datacell2" 
                            queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=querySendPostItem&sendpostid=${bean.id}&projectbookid=${bean.projectbook_id }&belong=${belongstatus }"
                            submitAction="/FAERP/AgentEmpSendPostAction.do?cmd=updateServiceItem"  
                            width="70%" 
                            height="200px" 
                            xpath="AgentSendPostServiceItemVo" 
                            pageSize="100"
                            paramFormId="sendPostForm">
                    <r:field fieldName="id" label="" width="0" ></r:field>
                    <r:field fieldName="sendpost_id" label=""  width="0"></r:field>
                    <r:field fieldName="projectbook_id" label=""  width="0"></r:field>
                    <r:field fieldName="service_item_id" label="服务名称">
                        <r:comboSelect id="service_idList" name="service_item_id"
                               queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=queryAgentItem&agent_id=${bean.agent_id}&belong=${belongstatus}"
                               valueField="id"
                               textField="contact_name"
                               xpath="AgentServiceItemVo"
                               width="150px"
                           onChangeFunc="modifydata;"
                        />
                    </r:field>
                    <r:field fieldName="post_belong" label="服务归属" >
                        <d:select dictTypeId="POST_BELONG_BD"  value="1" disabled="true" />
                    </r:field>
                    <r:field fieldName="status_bd" label="服务状态"> 
                        <d:select dictTypeId="AGENT_SERVICE_STATUS" />
                    </r:field>
                    <r:field fieldName="service_date" label="办理时间">
                        <w:date allowInput="true" id="service_date" name="service_date" format="YYYY-MM-DD" property="bean/service_date" width="190px" readonly="true"/>
                    </r:field>
                    <r:field fieldName="remark" label="备注">
                        <h:text/>
                    </r:field>
                </r:datacell>
            </div> 
            
            <div class="mx_button" style="text-align: center; margin-left: 0px;">
                <input type="button" id="save_2_btn" class="icon_2" value='离职' onClick="javascript:save_onClick1()"/>
                <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
            </div>  
	    </div>
	</div>     
</form>
</body>
</html>
<script>
 
 
 _jQuery(document).ready(function() {
        var falg=document.getElementById("emp_status").value;
        if(falg!="3"){
              $id("datacell1").afterLoadData = function(){
		           var report_month=document.getElementById("end_date1").value;
		          var dataset = $id("datacell1").dataset;
		                 
		           if(report_month!=''){
		               for(var i=0; i<dataset.getLength(); i++){
		                    var entity1 = dataset.get(i);
		                    
		                    entity1.setProperty("end_date",report_month);
		                   
		                    
		                }         
		           }
		    }
        }
 });
 function modifydata(){
         var projectbook_id=document.getElementById("projectbook_id").value;
           var entity=$id("service_idList").getSelectEntity();
          var service_id=entity.getProperty("id");
          var post_belong=entity.getProperty("post_belong");
           var entity1=$id("datacell2").getActiveEntity();
              entity1.setProperty("post_belong",post_belong);
              var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=isProjectbook&projectbook_id=" + projectbook_id+"&service_item_id="+service_id;   
                jQuery.post(url,function(data){
           if(data){
              if(data!=0){
              entity1.setProperty("projectbook_id",projectbook_id);
              }else{
                  entity1.setProperty("projectbook_id","");
              }
           }else{
           alert("程序出错");
           return;
           }
           });
        }
   $id("datacell2").beforeEdit= function(cell,colIndex,rowIndex){
                 var entity=this.getEntityByCell(cell);    
                  var status_bd=this.getEntityByCell(cell).getProperty("status_bd");  
                  var id=this.getEntityByCell(cell).getProperty("id");            
                  //alert("id="+id);      
    if(status_bd=='1'&&id!=""){
        return false;
    }
    
    return true;
    
}
    
</script>

