<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.employeepost.emimpempinfo.emimpempinfo_resource" prefix="rayoo.employeepost.emimpempinfo.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">

 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   );>";
    }
    
     function setCheckboxStatus1(value,entity,rowNo,cellNo){
	          var file_name = entity.getProperty("file_name");
	          var offID= entity.getProperty("offID");
	       //     alert(offID);
	      	  if(offID!=null&&offID!=""){
	      	 var url="/FAERP/EmimpempinfoAction.do?cmd=down1&id="+offID;
	            return "<a href="+url+">"+file_name+"</a>";
        }
        
        
    }
    
    
    
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
	function save_onClick() {  //从多选框到修改页面
		  var product_name = document.getElementsByName("temp");
          var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var offID="";
          var imp_remarks="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                      offID += enCurEntity.getProperty("offID"); 
                      imp_remarks+=enCurEntity.getProperty("imp_remarks"); 
              }
           }
        if(offID==null||offID==""){
            alert('<fmt:message key="select_records"/>');
            return;
        }else{
                    var flags=true;
                                jQuery.ajax({
                                url: '<%=request.getContextPath()%>/EmimpempinfoAction.do?cmd=update&id='+offID+"&date="+new Date()+"&imp_remarks="+encodeURIComponent(imp_remarks),
                                type: 'GET',
                                dataType: 'html',
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                       if(text=="1"){
                                         alert("<fmt:message key="operate_succese"/>");
                                        simpleQuery_onClick();
                                       }else if(text=="2"){
                                          alert("<fmt:message key="operate_error"/>"); 
                                       }
                                    }
                                    
                                }
                                });return flags;     
        
        }
		
		
		
		
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/EmimpempinfoAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
		var cust_name = jQuery("input[name='cust_name']").val();
    	 var isStop = jQuery("select[name='isStop']").val();
    	 if(cust_name==""){
    	 	alert("请选择客户名称");
    	 	return;
    	 }
		form.action="<%=request.getContextPath()%>/EmppostAction.do?cust_name=" + cust_name;
    	form.cmd.value = "downLoadClassTemplate";
    	form.submit();
  	}
  	function simpleQuery_onClick1(flag){  //简单的模糊查询
        form.cmd.value = "downLoad1";
        if(flag == 2){
            //新模板
            jQuery("#qg_download").val("new");
        }else{
            jQuery("#qg_download").val("old");
        }
        form.submit();
    }
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/emppostclass/insertClassInfo.jsp";
		form.submit();
	}
	function imp_onClick(){  //实现转到详细页面
	/*
	
	   var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmimpempinfoAction.do?id=" + ids;
        form.cmd.value = "imp";
        form.submit();
	*/

			  var product_name = document.getElementsByName("temp");
	          var number = 0;  //定义游标
	         var ids = null;  //定义id值的数组
	          var offID="";
	          var imp_remarks="";
	         for(var i=0;i<product_name.length;i++){  //循环checkbox组
	          if(product_name[i].checked) {  //如果被选中
	                     var enCurEntity = $id("datacell1").dataset.get(i); 
	                      offID += enCurEntity.getProperty("offID"); 
	                      
	              }
	           }
	        if(offID==null||offID==""){
	            alert("<fmt:message key="select_records"/>");
	            return;
	        }else{
	           var isStop = jQuery("select[name='isStop']").val();
        			if(isStop==""){
	    	 			alert("请选择是否福利不停！");
	    	 			return;
    	 			}
                  jQuery("input[name='button_reset1']").attr('disabled','disabled');
                  var flags=true;
                  
                  jQuery.ajax({
                      url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=imp&id='+offID+"&date="+new Date()+"&type="+isStop,
                      type: 'GET',
                      dataType: 'html',
                      //async: false,
                      error: function(){
                          alert('Error loading XML document');
                          return  null;
                      },
                      success: function(text){
                          if(text!=null){       
                             if(text=="1"){
                               alert("<fmt:message key="file_not_exits"/>");
                          //    simpleQuery_onClick();
                             }else if(text=="2"){
                                alert("<fmt:message key="operate_succese"/>"); 
                             }else if(text=="3"){
                                alert("<fmt:message key="other_notice"/>"); 
                             }else if(text=="4"){
                                alert("该文件有其他用户在操作，请稍后再试！"); 
                             }
                          }
                          jQuery("input[name='button_reset1']").removeAttr("disabled");
                      }
                  });
                  return flags;     
        
             }
		
		
		
		
		
		
	}
	
	
	   function view_onClickall(){  //实现转到详细页面
      /*
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?IMPORT_ID=" + ids+"&INTERFACE_TYPE=2";
        form.cmd.value = "queryAll";
        form.submit();
        */  
        
            var product_name = document.getElementsByName("temp");
          var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var offID="";
          var imp_remarks="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                      offID += enCurEntity.getProperty("offID"); 
              }
           }
        if(offID==null||offID==""){
            alert("<fmt:message key="select_records"/>");
            return;
        }else{
	         form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?IMPORT_ID=" + offID+"&INTERFACE_TYPE=2";
	        form.cmd.value = "queryAll1";
	        form.submit();
         }
        
        
    }
    
       function view_onClick(){  //实现转到详细页面
       /*
		        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		        if(ids == null) {  //如果ids为空
		            alert('<fmt:message key="select_one_record"/>');
		            return;
		        }
		        if(ids.length > 1) {  //如果ids有2条以上的纪录
		            alert('<fmt:message key="only_can_a_record"/>');
		            return;
		        }
		        form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?IMPORT_ID=" + ids+"&INTERFACE_TYPE=1";
		        form.cmd.value = "queryAll";
		        form.submit();
      */  
        
        
         var product_name = document.getElementsByName("temp");
          var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var offID="";
          var imp_remarks="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                      offID += enCurEntity.getProperty("offID"); 
              }
           }
        if(offID==null||offID==""){
            alert("<fmt:message key="select_records"/>");
            return;
        }else{
               form.action="<%=request.getContextPath()%>/EmppostAction.do?IMPORT_ID=" + offID;
                form.cmd.value = "queryAll1";
                form.submit();
         }
   } 
    
    
    
    
	
	   function exp_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmimpempinfoAction.do?id=" + ids;
        form.cmd.value = "imp";
        form.submit();
    }
    
  	    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("cust_name");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        //jQuery("#h_customer_id").val(arg[0]);        
        return false;
    }
	


</script>
</head>
<body>

<form name="form"   id="datacell_formid"  method="post" action="<%=request.getContextPath()%>/EmimpempinfoAction.do" >
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="result" name="result" value="0">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco("分类导入",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<input type="hidden" id="qg_download" name="qg_download" value="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	




		<tr>
		<td>客户名称</td>
		<td>
              <w:lookup onReturnFunc="rtnFuncCustomer" id="cust_name" name="cust_name"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="choose_customer" height="440" width="600"  style="width:170px"/>
                  </td>
			  <td>
			  <td>是否福利不停：</td>
			  <td>
			  	<select name="isStop" id="isStop">
			  	    <option value="">请选择</option>
			  		<option value="2">是</option>
			  		<option value="1">否</option>
			  	</select>
			  </td>
		
		</tr>
		<tr>
			<td/>
          
			<td/>
			<td/>
                <input name="button_ok" class="icon_4"   type="button" value="分类模板下载" onClick="javascript:simpleQuery_onClick()">
  
                <input name="button_reset" class="icon_4" type="button" value="<fmt:message key="one_import_file"/>" onClick="javascript:toAdd_onClick();">
                <input name="button_reset1" class="icon_4" type="button" value="<fmt:message key="two_import_file"/>" onClick="javascript:imp_onClick()">
                <div style="margin-top: 10px;">
                    <font color="red" style="margin-top: 25px;">请勿更改分类模板中已有的任何数据，保证导入数据的有效性！</font>
                </div>
                
            </td>
            	<td/>
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a_4">    	<a  onClick="javascript:view_onClick();">查看导入结果</a> </li>
								
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmimpempinfoAction.do?cmd=queryAll&file_type=3"
        width="99%"
        height="320px"
        xpath="EmimpempinfoVo"
        submitXpath="EmimpempinfoVo"
        paramFormId="datacell_formid"
        >

       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="operate" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>           
       <r:field width="200" fieldName="file_name" onRefreshFunc="setCheckboxStatus1"    messagekey="first_file_name">
      </r:field>
      
        <r:field fieldName="imp_remarks" messagekey="remarks"  width="200px">
        <h:text/>
      </r:field>
      <r:field width="150" fieldName="imp_date" messagekey="imp_date" allowModify="false">
       <w:date format="yyyy-MM-dd hh:mm:ss" />
      </r:field>
       <r:field fieldName="name" messagekey="imp_user">
      </r:field>
      <r:field width="150" fieldName="exe_date" messagekey="last_time_imp_data" allowModify="false">
       <w:date format="yyyy-MM-dd hh:mm:ss" />
      </r:field>
    </r:datacell>
    </div>
 
 

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
</script>
</body>
</html>

<script language="javascript">
    //解决修改行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("emp") >= 0){
            return false;
        }
        return true;
    } 
</script>	
