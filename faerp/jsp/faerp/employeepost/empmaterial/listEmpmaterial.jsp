<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    //获得所有选中的checkbox 
    function findSelections(checkboxName) {  
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
    
        jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });
    
    //获得所有的checkbox yangyuting2014-7-31 
    function getAllSelections(checkboxName) {  
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        var dc2 = $id("datacell2");
       
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
             entity = dc2.getEntity(i);
                if(entity.getValue("is_receive")=="2"){
	                number += 1;  //游标加1
	                if(ids == null) {
	                    ids = new Array(0);
	                }
	                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
                }
        }
        return ids;
    }
    //获得选中的材料的备注
    function getAllRemarks(checkboxName){
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var dc2 = $id("datacell2");
        var remarks = null;//返回的备注 
        var entity = null;//材料datacell对象
        for(var i=0;i<elementCheckbox.length;i++){
                if(remarks == null) {
                    remarks = new Array(0);
                }
                entity = dc2.getEntity(i);
                remarks.push(encodeURI(entity.getValue("remark")+" "));  //加入选中的checkbox
        }
        
        return remarks;
    }
    //获得选中的材料的备注
    function findRemarks(checkboxName){
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var dc2 = $id("datacell2");
        var remarks = null;//返回的备注 
        var entity = null;//材料datacell对象
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {  //如果被选中
                if(remarks == null) {
                    remarks = new Array(0);
                }
                entity = dc2.getEntity(i);
                remarks.push(encodeURI(entity.getValue("remark")+" "));  //加入选中的checkbox
            } 
        }
        
        return remarks;
    }
    function getIsSupplement(checkboxName){
    	var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var dc2 = $id("datacell2");
        var isSupplement = null;//返回的备注 
        var entity = null;//材料datacell对象
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {  //如果被选中
                if(isSupplement == null) {
                    isSupplement = new Array(0);
                }
                entity = dc2.getEntity(i);
                isSupplement.push(entity.getValue("is_supplement"));  //加入选中的checkbox
            } 
        }
        
        return isSupplement;
    }

    //删除员工所有材料
    function deleteByEmp(){
        var entity = $id("datacell1").getActiveEntity();
        var d1Total = $id("datacell1").getCurrentRowCount();//员工记录数
         if(entity == "" || entity == null || d1Total==0){
             alert("请选择一个员工");
             return;
         }else{
             var emp_post_id= entity.getValue("emp_post_id"); 
            //var dc2Total = $id("datacell2").getCurrentRowCount();//材料记录数
           /* if(dc2Total == 0){
                //还没有新增材料 则直接删
                $id("datacell1").deleteRow();
                
            }else{*/
                 if(confirm('您确定要删除该员工的所有材料信息吗？')) {  //如果用户在确认对话框按"确定"
	                /*var dc2Real = $id("datacell2").getTotalRowCount();//查询 增加删除前的记录数
	                if(dc2Real == 0){
	                   //如果是新增的数据删除 则直接删
	                   $id("datacell1").deleteRow();
	                }else{*/
                         _$.ajax({
		                      type : "post",
		                      url : "<%=request.getContextPath()%>/EmpMaterialAction.do?cmd=deleteByEmp&emp_post_id=" + emp_post_id,
		                      dataType : "html",
		                      success : function(data) {
		                                  alert("删除成功！");
		                                  $id("datacell1").reload();
		                                  $id("datacell1").refresh();
		                        }
		                 });
	                //}
	                //找到刷新datacell1之后 选择的员工  刷新该员工的材料  如果没有 则初始化材料
			         var newSelectEntity = $id("datacell1").getActiveEntity();
			          if(newSelectEntity == "" || newSelectEntity == null){
			            /*$id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_id=";
			            $id("datacell2").loadData();
			            $id("datacell2").refresh();*/
			            $id("datacell2").clear();
			          }else{
			            $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_post_id="+newSelectEntity.getValue("emp_post_id"); ;
			            $id("datacell2").loadData();
			            $id("datacell2").refresh();
			          }
	            }
            }
        //}
    }
    //删除材料
    /*function deleteMulti_onClick(){
	    if(_$('input:checkbox[name="checkbox_template"]:checked').length == 0){
	        alert("请选择一个材料！");
	    }else{
	        //获取选中的节点
	        var dc = $id("datacell2");
	        _$("input[name='checkbox_template']").each(function(i) {
	            if (_$(this).attr("checked")) {
	                var row = dc.table.tBodies[0].rows[i];
	                dc.deleteRow();
	            }
	        });
	    }
    }*/
    
     //简单的模糊查询
    function simpleQuery_onClick(){ 
        $id("datacell1").loadData();
        $id("datacell1").refresh();
         //初始化材料
         //$id("datacell2").clear();
         //找到刷新datacell1之后 选择的员工  刷新该员工的材料  如果没有 则初始化材料
         var entity = $id("datacell1").getActiveEntity();
          if(entity == "" || entity == null){
            //$id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_id=";
	        //$id("datacell2").loadData();
	        //$id("datacell2").refresh();
	        $id("datacell2").clear();
          }else{
            $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_post_id="+entity.getValue("emp_post_id"); ;
            $id("datacell2").loadData();
            $id("datacell2").refresh();
          }
         
    }
    
     //选择员工或者材料页面
    function toAdd_onClick(type) { 
        if(type == 1){
            //跳转查询员工
            showModalCenter("<%=request.getContextPath()%>/EmpMaterialAction.do?cmd=selectPage&type=" + type,null,empReturn,850,600,"选择员工");
        }else if(type == 2){
           /*var entity = $id("datacell1").getActiveEntity();
           var d1Total = $id("datacell1").getCurrentRowCount();//员工记录数
           if(entity == "" || entity == null || d1Total==0){
                alert("请选择一个员工");
                return;
            }else{
                var emp_id= entity.getValue("emp_id"); 
                //跳转查询材料
                showModalCenter("<%=request.getContextPath()%>/EmpMaterialAction.do?cmd=selectPage&type=" + type+"&emp_id="+emp_id,null,matReturn,600,400,"选择材料");
            }*/
        }
        
    }
    
    //选择员工 返回方法
	function empReturn(retVal){
	      var dc = $id("datacell1");
          var rcBefore = dc.getCurrentRowCount();
          var flag = true;
          for (var i = 0;i < rcBefore;i++){
               var row = dc.table.tBodies[0].rows[i];
               var entity = dc.getEntity(row);
               var typeVal = entity.getValue("emp_post_id");
               if(typeVal == retVal[4]){
                   alert("员工入离职信息已存在! ");
                   flag = false;
                   break;
               }
          }
         if(flag == true){
            dc.addRow();
	        //获得datacell的总记录数（addrow之后）
	        var rc = dc.getCurrentRowCount();
	        //给新增行设值
	        dc.setCellValue(dc.getCell(rc-1,0),retVal[0]);
	        dc.setCellValue(dc.getCell(rc-1,1),retVal[2]);
	        dc.setCellValue(dc.getCell(rc-1,2),retVal[1]);
	        dc.setCellValue(dc.getCell(rc-1,3),retVal[7]);
	        dc.setCellValue(dc.getCell(rc-1,4),retVal[6]);
	        dc.setCellValue(dc.getCell(rc-1,5),retVal[3]);
            dc.setCellValue(dc.getCell(rc-1,6),retVal[4]);
            dc.setCellValue(dc.getCell(rc-1,7),retVal[5]);
            dc.setCellValue(dc.getCell(rc-1,8),retVal[8]);//新增了是否入职E化列
            dc.setCellValue(dc.getCell(rc-1,9),retVal[9]);//新增了入职日期
            dc.setCellValue(dc.getCell(rc-1,10),retVal[10]);//新增了入离职状态
	        dc.endEdit();
	        
         }
	}
    //选择材料 返回方法
   /* function matReturn(retVal){
        var dc = $id("datacell2");
        var rcBefore = dc.getCurrentRowCount();
        var flag = true;
        for (var i = 0;i < rcBefore;i++){
             var row = dc.table.tBodies[0].rows[i];
             var entity = dc.getEntity(row);
             var typeVal = entity.getValue("material_id");
             if(typeVal == retVal[0]){
                 alert("材料已存在! ");
                 flag = false;
                 break;
             }
        }
        if(flag == true){
            dc.addRow();
	        //获得datacell的总记录数
	        var rc = dc.getCurrentRowCount();
	        //给新增行设值
	        dc.setCellValue(dc.getCell(rc-1,1),retVal[0]);
	        dc.setCellValue(dc.getCell(rc-1,2),retVal[1]);
	        dc.setCellValue(dc.getCell(rc-1,3),"0");
	        dc.endEdit();
        }
    }*/
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
   //提交datacell2
   /* function submitPage(){
        var entity = $id("datacell1").getActiveEntity();
        if(entity == "" || entity == null){
           alert("请选择一个员工！");
           return;
        }else{
            var emp_id= entity.getValue("emp_id"); 
            if($id("datacell2").isModefied == true){
	               $id("datacell2").submitAction = "/FAERP/EmpMaterialAction.do?cmd=updateMulti&emp_id="+emp_id;
	               $id("datacell2").submit();
	         }else{
		            alert("材料没有任何更改！");
		            return;
	         }
            alert("提交成功！");
	        $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_id="+emp_id;
	        $id("datacell2").loadData();
	        $id("datacell2").refresh();
	        $id("datacell2").isModefied = false;
        }
    }*/
   
    //选择是否接受材料
   /* function selectIsReceive(value){
        if(value == 1){
            _$.ajax({
                   type : "post",
                   url : "<%=request.getContextPath()%>/EmpMaterialAction.do?cmd=selectIsReceive",
                   dataType : "html",
                   success : function(data) {
                               var arry = data.split(";");
                                var dc = $id("datacell2");
                                var row = dc.getActiveRow();
                                dc.setCellValue(dc.getCell(row.rowIndex,4),arry[0]);
                                dc.setCellValue(dc.getCell(row.rowIndex,5),arry[1]);
                                //dc.getCell(row.rowIndex,5).setReadonly(false);
                     }
             });
        }else{
               var dc = $id("datacell2");
               var row = dc.getActiveRow();
               dc.setCellValue(dc.getCell(row.rowIndex,4),"");
               dc.setCellValue(dc.getCell(row.rowIndex,5),"");
        }
    }*/
    //1 确认收到 2 取消收到
    function operate(opFlag){
        //获得材料id
        var material_ids = findSelections("checkbox_template");
        if(material_ids == null){
            alert("请勾选材料信息！");
            return;
        }
        var remarks = findRemarks("checkbox_template");//获得材料备注
        //获得员工入离职id
        var entity = $id("datacell1").getActiveEntity();
        var d1Total = $id("datacell1").getCurrentRowCount();//员工记录数
         if(entity == "" || entity == null || d1Total==0){
             alert("请选择一个员工");
             return;
         }
           var isSupplement = getIsSupplement("checkbox_template");
        //发送ajax
        _$.ajax({
             type : "post",
             url : "<%=request.getContextPath()%>/EmpMaterialAction.do?cmd=operateMaterial&emp_post_id=" + entity.getValue("emp_post_id")+"&opFlag="+opFlag+"&material_ids="+material_ids+"&emp_id="+entity.getValue("emp_id")+"&remarks="+remarks+"&isSupplement="+isSupplement,
             dataType : "html",
             success : function(data) {
                         alert(data);
                         //刷新材料信息
                         $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_post_id="+entity.getValue("emp_post_id"); ;
						 $id("datacell2").loadData();
						 $id("datacell2").refresh();
               }
        });
    }
    //1 确认收到 材料完整 yangyuting 2014-7-31
    function operateAll(opFlag){
        //获得材料ids
        var material_ids = getAllSelections("checkbox_template");
        var remarks = getAllRemarks("checkbox_template");//获得材料备注
        var emp_id_card= $id("datacell1").getActiveEntity().getValue("emp_id_card"); 
        //获得员工入离职id
        var entity = $id("datacell1").getActiveEntity();
        var d1Total = $id("datacell1").getCurrentRowCount();//员工记录数
        
        if(material_ids==null){
            alert("该员工材料已经完整，不能重复提交！");
            return;
        }
        
         if(entity == "" || entity == null || d1Total==0){
             alert("请选择一个员工");
             return;
         }
         //yangyuting 2014-8-1
         if(emp_id_card==""){
            alert("选择的员工证件号不能为空");
             return;
         }
       
        //发送ajax
        _$.ajax({
             type : "post",
             url : "<%=request.getContextPath()%>/EmpMaterialAction.do?cmd=operateMaterial&emp_post_id=" + entity.getValue("emp_post_id")+"&opFlag="+opFlag+"&material_ids="+material_ids+"&emp_id="+entity.getValue("emp_id")+"&remarks="+remarks+"&emp_id_card="+emp_id_card,
             dataType : "html",
             success : function(data) {
                         alert(data);
                         //刷新材料信息
                         $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_post_id="+entity.getValue("emp_post_id"); ;
						 $id("datacell2").loadData();
						 $id("datacell2").refresh();
               }
        });
    }
    
    //1 通知员工 2通知客服
    function sendEmail(opFlag){
     //获得材料id
        var material_ids = findSelections("checkbox_template");
        if(material_ids == null){
            alert("请勾选材料信息！");
            return;
        }
        var remarks = findRemarks("checkbox_template");//获得材料备注
        //获得员工id
        var entity = $id("datacell1").getActiveEntity();
        var d1Total = $id("datacell1").getCurrentRowCount();//员工记录数
      
         if(entity == "" || entity == null || d1Total==0){
             alert("请选择一个员工");
             return;
         }
         
         var emp_id= $id("datacell1").getActiveEntity().getValue("emp_id"); 
        //发送ajax
        _$.ajax({
             type : "post",
             url : "<%=request.getContextPath()%>/EmpMaterialAction.do?cmd=notifyEmail&emp_post_id=" + entity.getValue("emp_post_id")+"&opFlag="+opFlag+"&material_ids="+material_ids+"&remarks="+remarks+"&emp_id="+emp_id,
             dataType : "html",
             success : function(data) {
                         alert(data);
                          //刷新材料信息
                         $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_post_id="+entity.getValue("emp_post_id"); ;
                         $id("datacell2").loadData();
                         $id("datacell2").refresh();
               }
        });
    }
    
    //查看个人订单信息 
    function detail_update_onClick(){
        //获得员工入离职id
        var entity = $id("datacell1").getActiveEntity();
        var d1Total = $id("datacell1").getCurrentRowCount();//员工记录数
         if(entity == "" || entity == null || d1Total==0){
             alert("请选择一个员工");
             return;
         }
        window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+entity.getValue("emp_post_id"),'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
    }
    function changeRemark(checkboxName){
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var flag = _$("#old_check_status").val()
        if(flag == "true"){
            elementCheckbox[$id("datacell2").activeRow.rowIndex].checked  = true;
       }
    }
    //导出 
    function export_onClick(){
    	$id("datacell_formid").action="<%=request.getContextPath()%>/EmpMaterialAction.do?&cmd=exportMaterialAll";
        $id("datacell_formid").submit();
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmployeeAction.do";
    }
</script>
 

</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/EmployeeAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
 <input type="hidden" name="backFlag" id="backFlag" value="true">
  <input type="hidden" name="old_emp_id" id="old_emp_id" value="">
   <input type="hidden" name="old_data" id="old_data" value="">
   <input type="hidden" name="old_check_status" id="old_check_status" value="">
<div id="right">
	<script language="javascript">
	       writeTableTopFesco('员工材料管理','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
    <div class="ringht_s">
       <!--  div ccChild0 start -->
	   <div id="ccChild0" class="search"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				     <tr>
				       <td width="174" rowspan="10" style="padding-top:0;" height="40px;"><div class="search_title">查询条件</div> </td>
			         </tr>
			         <tr>
			           <td align="left">员工姓名</td>
			           <td align="left">
			               <input type="text" class="text_field" id="emp_name"  name="emp_name" value="" inputName="员工姓名" />
			           </td>
			           <td align="left">员工编号</td>
			           <td align="left">
			               <input type="text" class="text_field" id="emp_code" name="emp_code" value="" inputName="员工编号"/>
			           </td>
			            <td align="left">签收日期</td>
			           <td align="left">
			                <w:date format="yyyy-MM-dd" id="start_date" name="start_date" width="80px"/>&nbsp;
			                至&nbsp;
			                <w:date format="yyyy-MM-dd" id="end_date" name="end_date" width="80px"/>
			           </td>
			         </tr>
			         <tr>
			           <td align="left">证件号</td>
			           <td align="left">
			               <input type="text" class="text_field" id="emp_id_card" name="emp_id_card" value="" inputName="证件号"/>
			           </td>
			            <td align="left">客户名称</td>
                       <td align="left">
                           <input type="text" class="text_field" id="cust_name" name="cust_name" value="" inputName="客户名称"/>
                       </td>
                         <td align="left" colspan="2">                 
			              <input name="button_ok" class="icon_1"   type="button" value='查询' onClick="javascript:simpleQuery_onClick()">
			              <input type="reset" class="icon_1"  />
			              <input name="button_export" class="icon_1"   type="button" value='导出' onClick="javascript:export_onClick()">
			            </td>
			          </tr>
<!--			         <tr>-->
<!--			           <td align="left"></td>-->
<!--			           <td align="left"></td>-->
<!--			          -->
<!--			          </tr>-->
			</table>
	   </div>
        <!--  div ccChild0 end -->
        <div style="margin-top: 5px;">
            <div class="xz_title" style="width:45%;float: left;">员工信息</div>
            <div class="xz_title" style="width:48%;float: right;">材料信息</div>
        </div>
        
        <!--  div ccParent1 start -->
	   <div id="ccParent1" class="button" style="float: left;width:100%;overflow: visible;"> 
			  <div class="button_right" style="width: 48%;float: left;">
			        <input class="c"  type="button"   value="新增"    onClick="toAdd_onClick(1);">
			        <input class="d"  type="button"   value="删除"    onClick="deleteByEmp();">
			        <input type="button" class="a_2" value='查看个人订单'  onClick="detail_update_onClick();" />
	           </div>
	                   <!--  div ccParent2 start -->
		       <div id="ccParent2"  style="width:40%;float: left;margin-left: 50px;"> 
		              <div class="button_right">
		                    <!--<input class="dj_3"  type="button"   value="确认收到"    onClick="operate(1);">--><!-- 2014-7-31 yangyuting -->
		                    <input class="dj_3"  type="button"   value="保存"    onClick="operate(1);">
		                    <input class="dj_3"  type="button"   value="取消收到"    onClick="operate(2);">
		                    <!--<input class="dj_3"  type="button"   value="通知员工"    onClick="sendEmail(1);">--><!-- 2014-7-31 yangyuting -->
		                    <input class="dj_3"  type="button"   value="未办反馈"    onClick="sendEmail(2);">
		                    <input class="dj_3"  type="button"   value="材料完整"    onClick="operateAll(1);">
		               </div>
		               <div class="clear"></div>            
		        </div>
		        <!--  div ccParent2 end -->
        
	           <div class="clear"></div>            
	    </div>
	    <!--  div ccParent1 end -->
	    
        <!--  div start -->
        <div style="padding: 8 10 8 8;">
            <div style="float: left;">
				 <r:datacell id="datacell1" queryAction="/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=1" 
				 width="530px" height="300px" xpath="EmpMaterialVo" paramFormId="datacell_formid" pageSize="10">
					 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
					  <r:field fieldName="emp_id" label="员工id" width="0px"></r:field>
					 <r:field fieldName="emp_name" label="员工姓名" width="60px"></r:field>    
					 <r:field fieldName="emp_code" label="员工编号" width="80px"></r:field>
					 <r:field fieldName="user_name" label="客服" width="45px"></r:field>
                     <r:field fieldName="cust_name" label="客户名称" width="150px"></r:field>
					 <r:field fieldName="emp_id_card" label="证件号" width="140px"></r:field>
					 <r:field fieldName="emp_post_id" label="员工入离职id" width="0px"></r:field>
					 <r:field fieldName="cust_code" label="客户编号" width="80px"></r:field>
					  <r:field fieldName="is_phoenix" label="入职E化" width="80px">
                     <select onchange="selectIsReceive(this.value)">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                     </r:field>
                  <r:field fieldName="apply_on_post_date" label="入职日期" width="80px"></r:field>
                  <r:field fieldName="post_status_bd" label="状态" width="100px">
                            <d:select dictTypeId="POST_STATUS_BD" />
                  </r:field>
				  </r:datacell>
		    </div>
			 <div style="float: right;margin-right:11px;">
		             <r:datacell id="datacell2" queryAction="/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll" 
		             submitAction="/FAERP/EmpMaterialAction.do?cmd=updateMulti" submitXpath="EmpMaterialVo" pageSize="100"
		             width="550px" height="300px" xpath="EmpMaterialVo" >
		             <r:toolbar location="bottom" tools="nav,pagesize,info"/>
		                 <r:field fieldName="material_id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
		                 <r:field fieldName="material_name" label="材料名称" width="110px"  allowModify="false"><h:text ></h:text> </r:field>    
		                 <r:field fieldName="remark" label="备注" width="110px"  allowModify="true" ><h:text onchange="changeRemark('checkbox_template');" ></h:text> </r:field>    
		                 <r:field fieldName="is_receive" label="是否收到" width="80px"  allowModify="false">
		                    <select onchange="selectIsReceive(this.value)">
		                        <option value="0">否</option>
		                        <option value="1">是</option>
		                        <option value="2">缺失</option>
		                    </select>
		                </r:field>
		                <r:field fieldName="is_supplement" label="补充材料" width="65px">
		                    <select name="is_supplement">
		                        <option value="0">否</option>
		                        <option value="1">是</option>
		                    </select>
		                </r:field>      
		                 <r:field fieldName="receive_user" label="签收人员" width="80px"  allowModify="false"></r:field>
		                 <r:field fieldName="receive_date" label="签收日期" width="80px"  allowModify="false">
		                    <w:date allowInput="true" id="receive_date1" name="receive_date1" format="YYYY-MM-DD" property="bean/receive_date" width="110px" />
		                 </r:field>     
		             </r:datacell>
             </div>
             
        </div>
        <!--  div end -->
        
        
</div>
</div>
</form>
</body>
</html>

<script language="javascript">
//解决修改行数据，多选框勾选消失BUG
    $id("datacell2").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("material_id") >= 0){
            return false;
        }
        return true;
    }

//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell2").isQueryFirst = false;
    $id("datacell1").afterSelectRow  = function(row){
        //value 为新选择的empid
        var value= $id("datacell1").getActiveEntity().getValue("emp_post_id"); 
        //当前选中的emp_id
       // var emp_id = _$("#old_emp_id").val();
       /*if($id("datacell2").isModefied == true){
            if(confirm("材料信息已变更，是否保存?")){
                   $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_id="+value;
                   $id("datacell2").submitAction = "/FAERP/EmpMaterialAction.do?cmd=updateMulti&emp_id="+emp_id;//保存之前emp的操作
                   $id("datacell2").submit();
                   $id("datacell2").loadData();
                   $id("datacell2").refresh();
            }else{
                    $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_id="+value;
                    $id("datacell2").loadData();
                    $id("datacell2").refresh();
            }
        }else{*/
        $id("datacell2").isQueryFirst = true;
                   $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_post_id="+value+"&start_date="+$id("start_date").value+"&end_date="+$id("end_date").value;
                   $id("datacell2").loadData();
                   $id("datacell2").refresh();
       // }
        //_$("#old_emp_id").val(value);//设置之前选择的emp_id 
    }
    
        $id("datacell2").afterSelectRow  = function(row){
             var elementCheckbox = document.getElementsByName("checkbox_template");  //通过name取出所有的checkbox
	         _$("#old_check_status").val(elementCheckbox[row.rowIndex].checked);
        }
    
});

</script>   
