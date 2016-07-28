<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.employeepost.epoffimpinfo.epoffimpinfo_resource" prefix="rayoo.employeepost.epoffimpinfo.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   );>";
    }
    
     function setCheckboxStatus1(value,entity,rowNo,cellNo){
          var file_name = entity.getProperty("file_name");
          var offID= entity.getProperty("offID");
       //     alert(offID);
        if(offID!=null&&offID!=""){
       var url="/FAERP/EpOffImpInfoAction.do?cmd=down1&offID="+offID;
            return "<a href="+url+">"+file_name+"</a>";
        }
        
        
    }

   function ClickRow(value,value1){
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
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/EpOffImpInfoAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/EpOffImpInfoAction.do?ids=" + ids;
	    	form.cmd.value = "importExcelForEmployee";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "downLoad";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/epoffimpinfo/insertEpOffImpInfo.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
	  var product_name = document.getElementsByName("temp");
           var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var id="";
          var offID="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                      offID = enCurEntity.getProperty("offID"); 
                     break;
              }
           }
                if(offID==null||offID==""){
                    alert("<fmt:message key="select_records"/>");
                    return;
                }else{
                      jQuery("input[name='button_reset1']").attr('disabled','disabled');
	                  var flags=true;
	                  jQuery.ajax({
			            url: '<%=request.getContextPath()%>/EpOffImpInfoAction.do?cmd=importExcelForEmployee&id='+offID+"&date="+new Date(),
			            type: 'post',
			            dataType: 'html',
			            async: false,
			            timeout:7200000,
			            error: function() {
			                alert('Error loading XML document');
			                return null;
			            },
	                      success: function(text){
	                          if(text!=null){
	                             var array = text.split(",");   
	                             if(array[0]=="1"){
	                               alert("<fmt:message key="file_not_exise"/>");
	                          //    simpleQuery_onClick();
	                             }else if(array[0]=="2"){
	                                alert("<fmt:message key="operation_succuse"/>"+array[1]); 
	                             }else if(array[0]=="3"){
	                                alert("<fmt:message key="imp_error"/>"+array[1]); 
	                             }
	                          }
	                          alert("导入将持续在后台执行，请稍后点击“查看导入结果”按钮进行查询。");
	                          jQuery("input[name='button_reset1']").removeAttr("disabled");
	                      }
	                  });
	                  return flags;     
                  
                     //form.action="<%=request.getContextPath()%>/EpOffImpInfoAction.do?id=" + offID;
			        //form.cmd.value = "importExcelForEmployee";
			        //form.submit();
                
                }
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
				        form.action="<%=request.getContextPath()%>/EpOffImpInfoAction.do?id=" + ids;
				        form.cmd.value = "importExcelForEmployee";
				        form.submit();
                */
                
                
                
		
		
		
		
		
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
        form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?batch_id=" + ids+"&imp_flag=0";
        form.cmd.value = "queryAll";
        form.submit();
        
      */  
        
           var product_name = document.getElementsByName("temp");
          var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var id="";
          var offID="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                      offID = enCurEntity.getProperty("offID"); 
                     break;
              }
           }
                if(offID!=null&&offID!=""){
                     form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?id=" + offID+"&imp_flag=0";
                    form.cmd.value = "queryAll1";
                    //2016-04-11 by zhouxiaolong  优化导入离职页面提示信息  begin
                    setTimeout(form.submit(),1200);
                    //2016-04-11 by zhouxiaolong  优化导入离职页面提示信息  end
                }else{
                    alert("<fmt:message key="select_records"/>");
                    return;
                }
        
        
        
    }
	
	
	
	
	        //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2; 
        var t = (screen.height - h) / 2; 
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
     //   window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    //   window.open('<%=request.getContextPath() %>/jsp/faerp/employeepost/epoffimpinfo/attachUploadFrame.jsp','newwindow', s);
        window.open('<%=request.getContextPath() %>/jsp/faerp/employeepost/epoffimpinfo/attachUploadFrame.jsp','newwindow', s);
    }

</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid"  action="<%=request.getContextPath()%>/EpOffImpInfoAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="cmd1"   name="cmd1" value="queryAll">
 <input type="hidden"  id="action1"  name="action1" value="EpOffImpInfoAction.do">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="bacth_imp_post"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">




		
	
		<tr>
			<td/>
          
			<td/>
			<td/>
			  <td>
                
              
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="templete_downlord"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_4" type="button" value='<fmt:message key="one_uplord_file"/>' onClick="javascript:toAdd_onClick();">
                <input name="button_reset1" class="icon_4" type="button" value='<fmt:message key="two_imp"/>' onClick="javascript:detail_onClick()">
            </td>
            	<td/>
		</tr>
</table>
</div>


 

<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="a_3">      <a  onClick="javascript:view_onClick();"><fmt:message key="look_imp_rs"/></a> </li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
					

 
 
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EpOffImpInfoAction.do?cmd=queryAll"
        width="99%"
        height="320px"
        xpath="EpOffImpInfoVo"
        submitXpath="EpOffImpInfoVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>           
       <r:field fieldName="file_name" onRefreshFunc="setCheckboxStatus1"    messagekey="imp_file">
      </r:field>
      
      <r:field fieldName="import_time" messagekey="operation_time" allowModify="false">
       <w:date format="yyyy-MM-dd" />
      </r:field>
       <r:field fieldName="name" messagekey="operation_user">
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

</script>	
