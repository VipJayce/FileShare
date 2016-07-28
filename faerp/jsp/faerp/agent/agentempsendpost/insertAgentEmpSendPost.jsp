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
<title>员工派出</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript"><!--
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
    
    //派出
    function post_onClick(){
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
        jQuery("#isPost").val("1");
        jQuery("#status").val("1");
        save_onClick();
    }
    
    //保存
    function save_onClick(){  //保存
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
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                if ($id("datacell1").isModefied == true){
                    updateProductCell_onClick();
                }
                if ($id("datacell2").isModefied == true){
                    updateDataCell_onClick();
                }
                form.action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=update&id="+code;
            }else{
                //添加服务手续
                var item_datacell = $id("datacell2");
		        var itemCount =  item_datacell.getCurrentRowCount();
		        item_datacell.selectFirstRow(); 
		        var datacellValue = "";
		        for(var i=0;i<itemCount;i++){
		            entity=item_datacell.getActiveEntity();
		            var returnAry = new Array();
		            var str = entity.getProperty("service_item_id");
		            str += "," + entity.getProperty("status_bd");
		            str += "," + entity.getProperty("service_date");
		            str += "," + entity.getProperty("remark");
		            if (datacellValue.length != 0){
		                datacellValue += "_" + str;
		            }else{
		                datacellValue += str;
		            }
		            item_datacell.selectNextRow();
		        }
		        jQuery("#itemCellValues").val(datacellValue);
		        
		        //添加产品
		        datacellValue = "";
                item_datacell = $id("datacell1");
                itemCount =  item_datacell.getCurrentRowCount();
                item_datacell.selectFirstRow(); 
                var datacellValue = "";
                for(var i=0;i<itemCount;i++){
                    entity=item_datacell.getActiveEntity();
                    var returnAry = new Array();
                    var str = entity.getProperty("product_id");
                    str += "," + entity.getProperty("money");
                    str += "," + entity.getProperty("frequency_bd");
                    str += "," + entity.getProperty("start_date");
                    str += "," + entity.getProperty("end_date");
                    str += "," + entity.getProperty("service_product_id");
                    if (datacellValue.length != 0){
                        datacellValue += "_" + str;
                    }else{
                        datacellValue += str;
                    }
                    item_datacell.selectNextRow();
                }
                jQuery("#productCellValues").val(datacellValue);
                
                form.action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=insert&id="+code;
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
    
    //选择员工回调函数
    function rtnFuncEmp(arg){
        var lookup = $id("emp_code");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        jQuery("#emp_id").val(arg[0]);
        jQuery("#emp_name").val(arg[1]);
        jQuery("#id_card").val(arg[3]);
        jQuery("#mobile").val(arg[4]);
        jQuery("#email").val(arg[5]);
        jQuery("#resident_type_bd").val(arg[6]);
        jQuery("#birth_date").val(arg[7]);
        jQuery("#cust_name").val(arg[9]);
        jQuery("#projectbook_id").val(arg[10]);
        jQuery("#projectbook_name").val(arg[11]);
        jQuery("#agent_id").val(arg[12]);
        jQuery("#agent_name").val(arg[13]);
        jQuery("#emp_post_id").val(arg[14]);
        
        var empStatusSelect = document.getElementsByName("emp_status")[0];
        for(var i=0;i<empStatusSelect.options.length;i++){
            if(empStatusSelect.options[i].value == arg[8]){
                empStatusSelect.options[i].selected = "selected";
	            break;
	        }
        }      
        bulidProjectBookInfo();
        return false;
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
        var sendpost_id = jQuery("#edit_id").val();
          datasettr.setProperty("status_bd",'0');
        if (sendpost_id){
            datasettr.setProperty("sendpost_id",sendpost_id);
        }
    /*    var projectbook_id = jQuery("#projectbook_id").val();
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
    
    //员工订单
    function orderInfo_onClick(){ 
        var code = jQuery("#edit_id").val();
        var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=detailPerOrder&id=" + code;
        window.open(url,'','height=700px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工订单');
    }
--></script>
</head>
<body>

<form name="form" method="post" id="sendPostForm">
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="itemCellValues" id="itemCellValues"/>
    <input type="hidden" name="productCellValues" id="productCellValues"/>
    <input type="hidden" name="status" id="status" value="${bean.status}"/>
    <input type="hidden" name="isModify" id="isModify" value="${isModify}">
    <input type="hidden" name="isPost" id="isPost">
    
	<div id="right">
	    <script language="javascript">
		    writeTableTopFesco('派工单维护','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			                <w:lookup onReturnFunc="rtnFuncEmp" readonly="true" id="emp_code" name= "emp_code" displayValue="${bean.emp_code}" value="${bean.emp_code}"
			                                   lookupUrl="/AgentEmpSendPostAction.do?cmd=searchProjectBookEmp" dialogTitle="选择员工" height="450" width="800"  style="width:190px"/>
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
	                    <td  class="td_1" width="23%" >人员状态</td>
	                    <td  class="td_2" width="28%">
	                        <%
	                        rayoo.agent.agentempsendpost.vo.AgentEmpSendPostVo beanVo = (rayoo.agent.agentempsendpost.vo.AgentEmpSendPostVo)request.getAttribute("bean");
			                String empStatus = "";
			                if (beanVo != null){
			                    empStatus = String.valueOf(beanVo.getEmp_status());
			                }
			                %>
                            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_status", -1, "EMP_STATUS", empStatus, "", false) %> 
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
                <div class="button_right">
                    <ul>
                        <li class="h_2"><a  onClick="javascript:orderInfo_onClick();">员工订单</a> </li>
                    </ul>
                </div>
                <div class="clear"></div>           
            </div> 
            <div class="xz_title">服务产品</div>
            <div id="productCCParent" class="button"> 
                <div class="button_right">
                    <ul>
                        <li class="bc"><a onClick="javascript:updateProductCell_onClick();">保存</a></li>
                    </ul>
                </div>
                <div class="clear"></div>           
            </div> 
            <div style="padding: 8 10 8 8;">
			    <r:datacell id="datacell1" 
			                queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=queryProjectServiceProduct&projectbook_id=${bean.projectbook_id}&sendpost_id=${bean.id}"
			                submitAction="/FAERP/AgentEmpSendPostAction.do?cmd=updateProductItem"   
			                width="100%" height="200px" 
			                xpath="AgentSendPostOrderItemVo" 
			                paramFormId="sendPostForm" 
			                readonly="false" pageSize="100">
                    <r:field fieldName="id" label="" width="0" ></r:field>
                    <r:field fieldName="service_product_id" label="" width="0" ></r:field>
			        <r:field fieldName="product_id" label="" width="0" ></r:field>
			        <r:field fieldName="product_name" label="产品名称"></r:field>
			        <r:field fieldName="money" label="产品价格">
                        <h:text/>
			        </r:field>
			        <r:field fieldName="frequency_bd" label="收费频率" allowModify="false">
			             <d:select dictTypeId="FREQUENCY_BD"  />
                        <h:text/>
                    </r:field>
			        <r:field fieldName="start_date" label="开始时间">
                        <w:date allowInput="true" id="start_date" name="start_date" format="YYYY-MM-DD" property="bean/start_date" width="190px" readonly="true"/>
                    </r:field>
			        <r:field fieldName="end_date" label="结束时间">
                        <w:date allowInput="true" id="end_date" name="end_date" format="YYYY-MM-DD" property="bean/end_date" width="190px" readonly="true"/>
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
                            width="100%" 
                            height="200px" 
                            xpath="AgentSendPostServiceItemVo" 
                            paramFormId="sendPostForm"
                            pageSize="100">
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
                           
                               validateAttr="message=入职服务名称;allowNull=true" onChangeFunc="modifydata;"
                        />
                    </r:field>
                    <r:field fieldName="post_belong" label="服务归属" allowModify="false" >
                        <d:select dictTypeId="POST_BELONG_BD" disabled="true" />
                    </r:field>
                    <r:field fieldName="status_bd" label="服务状态" > 
                        <d:select dictTypeId="AGENT_SERVICE_STATUS"/>
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
                <input type="button" id="save_1_btn" class="icon_2" value='派出' onClick="javascript:post_onClick()"/>
                <input type="button" id="save_2_btn" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
                <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
            </div>  
	    </div>
	</div>     
</form>
</body>
</html>
<script>
    var status = jQuery("#status").val();
    var sendPostId = jQuery("#edit_id").val();
    if (sendPostId && status == 0 ){
        jQuery(".right_title").text("员工派出");
        jQuery("#save_2_btn").hide();
    }else {
        jQuery("#save_1_btn").hide();
    }
    
    jQuery(function(){
        if (!jQuery("#edit_id").val()){
            jQuery("#productCCParent").hide();
            jQuery("#serviceCCParent").hide();
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

