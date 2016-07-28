<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.pbservicebigtype.vo.PbservicebigtypeVo" %>
<%@ page import="rayoo.system.pbservicebigtype.util.IPbservicebigtypeConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	int size=0;
	if(request.getAttribute(IPbservicebigtypeConstants.REQUEST_DLBEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IPbservicebigtypeConstants.REQUEST_DLBEANS);  //赋值给resultList
		size = lResult.size();
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	PbservicebigtypeVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工分类</title>
<style type="text/css">
.box{ border:1px solid #c5dbe2; margin:5px 10px 0px 10px; width:98%; overflow-x:scroll;white-space:nowrap;overflow-y:scroll; height:280px;
Scrollbar-Highlight-Color:#fafafa; Scrollbar-Shadow-Color:#e8e8e8;Scrollbar-3Dlight-Color:#e4e4e4;scrollbar-dark-shadow-color:#7dc0e3;} 
</style>
<script language="javascript">
    function findSelection(radioName, idName) {  //从radio中找出选中的id值列表
        var elementRadio = document.getElementsByName(radioName);  //
        var ids = null;  //定义id值
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].checked) {  //如果被选中
                ids=elementRadio[i].value;  
            }
        }
        return ids;
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
		var ids = findSelections("radio_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/PbservicebigtypeAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  

	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/system/security/pbservicebigtype/insertPbservicebigtype.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("radio_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/PbservicebigtypeAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
	//*******************以下为对小类div的操作js********************
    //显示临时大类的小类列表，则把小类列表清空即可，把大类id设在隐藏
    function showNewdiv(){
        selectAllRows();
        var ids = findSelections("checkbox_template","id");  //取得复选框的选择项
        if(ids == null) {  //如果ids为空
             return;
        }
        var obj=document.getElementById("xlTab");
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            var xlid=ids[i];
            var j=document.getElementById(xlid).rowIndex;
            obj.deleteRow(j);
        }
    }
    
    //显示数据库已有记录的小类列表
    function showSmalldiv(div_id){
        //先把小类列表清空
        showNewdiv();
        //ajax请求数据加载到div中的列表
        $.getJSON("<venus:base/>/PbservicebigtypeAction.do?cmd=searchXltype&date="+new Date()+"",{"id":div_id},  function(json){
         for(var i = 0; i < json.saia.length; i++){
            //alert(json.saia[i].id);
            
            $("#xlTab").append("<tr id="+json.saia[i].id+"> <input type=\"hidden\" name=\"dlid\" value="+json.saia[i].service_big_type_id+">"
               +"  <td><input type=\"checkbox\" name=\"checkbox_template\" value="+json.saia[i].id+" ></td> "
               +"   <td><input type=\"text\" class=\"text_field\" name=\"xlname\" inputName=\"小类名称\" maxLength=\"50\" style=\"width:120px;\" value="+json.saia[i].name+" ></td>"
               +"  <td><input type=\"text\" class=\"text_field\" name=\"xlremark\" inputName=\"备注\" maxLength=\"50\" style=\"width:100px;\" value="+json.saia[i].remark+"></td>"
               +"</tr>");
            }
        }); 
        
    }

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/PbservicebigtypeAction.do?backFlag=true">
<input type="hidden" name="cmd" value="">
 

 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

	  <tr>
			<td align="right" width="15%">城市&nbsp;&nbsp;
			<td align="left" width="30%">
			     <faerp:cityTag  tagname="city_id"  />
			</td>
			<td align="right" width="5%"></td>
		
			<td align="right" width="15%">大分类名称&nbsp;&nbsp; </td>
			<td align="left" width="30%">
				<input type="text" class="text_field" name="name" inputName="大分类名称" maxLength="50"/>
			</td>
			<td align="right" width="5%"></td>
			
			
		</tr>
		<tr>
			<td/>
			<td colspan="4" align="center">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            <td/>
		</tr>
</table>
</div>
</form>

 

<form name="form1" method="post">
<!-- 大类列表 -->
<div style="width:55%; float:left;">
 <!--按钮-->					
 <div id="ccParent1" class="button"> 
        <div class="button_right">
				<ul>
					<li class="c">  	<a onClick="javascript:adddlTableRow();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteDl_onClick();"><fmt:message key="delete"/> </a> </li>
				</ul>
				
		 </div>
         <div class="clear"></div>			
 </div>
 <!--按钮 end-->
 
 <!--表格 -->
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1" id="dlTab">
		<tr>
		<th width="7%">&nbsp;</th>
		
     	<th width="35%">
			<a href="/FAERP/PbservicebigtypeAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"name")%>">
           	</a>	
			 大分类名称</th>
			 
		<th width="20%">
            <a href="/FAERP/PbservicebigtypeAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"city_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"city_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"city_id")%>">
            </a>    
        城市</th>
        
		<th width="38%">
			<a href="/FAERP/PbservicebigtypeAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remark")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remark")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remark")%>">
           	</a>	
		备注</th>
		
		</tr>
		
<logic:iterate     name="dlbeans"  id="data" scope="request" indexId="indexs">
		<tr  id="<bean:write name="data" property="id"/>" style="background-color:#dce6f5">
		    <td> 
		      <input type="radio" name="radio_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>" onclick="showSmalldiv('<bean:write name="data" property="id"/>');"/>
		      <input type="hidden" name="big_id" value="<bean:write name="data" property="id"/>" />
		    </td>
            <td>
                <input type="text" class="text_field" name="name" inputName="大类名称" maxLength="50" style="width:120px;" value="<bean:write name="data" property="name"/>" />
            </td>
           
            <td> 
                <faerp:cityTag beanname="data" attribute="city_id" tagname="city_id" className=""/>
            </td>		
			
			<td>
			    <input type="text" class="text_field" name="remark" inputName="备注" maxLength="50" style="width:100px;" value="<bean:write name="data" property="remark"/>" />
            </td>
           
           
			
		</tr>
</logic:iterate>

<!-- 处理自动增加一行 -->
    <input type="hidden" id="dlSize" value="<%=size %>" />
            <script type="text/javascript">
                            
                            var size=document.getElementById("dlSize").value;
                            var rIndex=size;
                            
                             //新增大类行
                            function adddlTableRow(){
                                var obj=document.getElementById("dlTab");
                                rIndex++;
                                //添加行
                                var rownum = obj.rows.length;
                                var tr0=obj.insertRow(rownum);
                                tr0.setAttribute("id","dlTabTr"+rIndex);
                                //添加单元格
                                var td0 = tr0.insertCell(0);
                                td0.innerHTML="<input type='radio' name='radio_template' value='dlTabTr"+rIndex+"' onclick='showNewdiv("+rIndex+");'/>"
                                +" <input type='hidden' name='big_id' value='dlTabTr"+rIndex+"'/> ";
                                               
                                //添加单元格
                                var td1 = tr0.insertCell(1);
                                td1.innerHTML="<input type='text' class='text_field' name='name' inputName='大类名称' maxLength='50' style='width:120px;' value=''/>";
                                //添加单元格
                                var td2 = tr0.insertCell(2);
                                td2.innerHTML="<faerp:cityTag  attribute='city_id' tagname='city_id'/>";
                                //添加单元格
                                var td3 = tr0.insertCell(3);
                                td3.innerHTML="<input type='text' class='text_field' name='remark' inputName='备注' maxLength='50' style='width:100px;' value=''/>";
                               
                                
                            }
                            
                            //从单选框中标记删除一条大类记录
                            function deleteDl_onClick(){  
							        var ids = findSelection("radio_template","id");  //取得单选框的选择项
							        if(ids == null) {  //如果ids为空
							            alert('<fmt:message key="select_records"/>');
							            return;
							        }
							        var obj=document.getElementById("dlTab");
							        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
							           
							            if(ids.indexOf('dlTabTr')==-1){
							                 //删除页面节点
                                             var i=document.getElementById(ids).rowIndex;
                                             obj.deleteRow(i);
                                             
							                //var f_obj=document.getElementById(ids);
                                            //f_obj.parentNode.removeChild(f_obj);
                                            
							                //AJAX删除数据库记录（级联删除小类）
							                validateDeleteDl(ids);
							            }else{
							                //删除页面节点
							                 var i=document.getElementById(ids).rowIndex;
                                             //alert("删除的行号"+i);
                                             obj.deleteRow(i);
							                
							            }
							            
							            //清除右侧对应的小类列表
                                        showNewdiv();
							        }
							        
							    }
							    
							//ajax删除大类记录
							function validateDeleteDl(ids){
						           var flags=true;
						               jQuery.ajax({
						        url: '<%=request.getContextPath()%>/PbservicebigtypeAction.do?cmd=deleteOne&ids='+ids,
						        type: 'GET',
						        dataType: 'html',
						        timeout: 10000,
						        error: function(){
						            alert('Error loading XML document');
						            return  null;
						        },
						        success: function(text){
						            if(text!=1){       
						             flags=false;
						            }
						        }
						        });return flags;
						    }
						    
						    //保存大类列表
                            function saveDl_onClick(){  //保存修改后的单条数据
                                var elementRadio = document.getElementsByName("radio_template");
                                if(elementRadio==null || elementRadio.length==0){
                                    alert('大分类列表为空，请新增后保存！');
                                    return;
                                }
						        form1.action="<%=request.getContextPath()%>/PbservicebigtypeAction.do?cmd=saveDl";
						        form1.submit();
                            }
						    
						    
						    var hIndex=0;
			                 //新增小类行
                            function addxlTableRow(){
                                var dlid = findSelection("radio_template","id");
                                if(dlid == null) {  //如果ids为空
						            alert('请选择一条大分类');
						            return;
						        }
                                var obj=document.getElementById("xlTab");
                                hIndex++;
                                //添加行
                                var rownum = obj.rows.length;
                                var tr0=obj.insertRow(rownum);
                                tr0.setAttribute("id","xlTabTr"+hIndex);
                                //添加单元格
                                var td0 = tr0.insertCell(0);
                                td0.innerHTML="<input type='checkbox' name='checkbox_template' value='xlTabTr"+hIndex+"'>";
                                               
                                //添加单元格
                                var td1 = tr0.insertCell(1);
                                td1.innerHTML="<input type='text' class='text_field' name='xlname' inputName='小类名称' maxLength='50' style='width:120px;' value='' />";
                                
                                //添加单元格
                                var td2 = tr0.insertCell(2);
                                td2.innerHTML="<input type='text' class='text_field' name='xlremark' inputName='备注' maxLength='50' style='width:100px;' value='' />";
                                
                                
                            }			   
                            
                            //从多选框物理删除多条小类记录
                             function deleteXl_onClick(){
						        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
						        if(ids == null) {  //如果ids为空
						            alert('请选择一条大分类');
						            return;
						        }
						        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
						            //删除页面记录
						            var ids_str='';
						            var obj=document.getElementById("xlTab");
							        for(var i=0;i<ids.length;i++){  //循环checkbox组
							            var xlid=ids[i];
							            var j=document.getElementById(xlid).rowIndex;
							            obj.deleteRow(j);
							            ids_str=ids_str+ids[i];
							            if(i<ids.length-1){
                                            ids_str=ids_str+",";
                                        }
							        }
						            //数据库删除
						            validateDeleteXl(ids_str);
						        }
						    }
							
							//ajax删除小类记录
                            function validateDeleteXl(ids_str){
                                   var flags=true;
                                       jQuery.ajax({
                                url: '<%=request.getContextPath()%>/PbservicebigtypeAction.do?cmd=deleteXl&ids='+ids_str,
                                type: 'GET',
                                dataType: 'html',
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=1){       
                                     flags=false;
                                    }
                                }
                                });return flags;
                            }
							    
							
						    //保存小类列表
						    function saveXl_onClick(){  //保存修改后的单条数据
						        var dlid = findSelection("radio_template","id");  //取得单选框的选择项
						        if(dlid == null) {  //如果id为空
						            alert('请选择一条大分类');
                                    return;
						        }
						        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
						            return false;
						        }
						        //使用ajax保存小类列表及其对应大类
						        var names = findNames("xlname");
						        var remarks = findNames("xlremark");
						       
						        var dlname = $($($("#"+dlid)[0]).children()[1].children[0]).val();
						        var dlcity = $($($("#"+dlid)[0]).children()[2].children[0]).val();
						        var dlremark = $($($("#"+dlid)[0]).children()[3].children[0]).val();
						       
						        validateSaveXl(dlid,dlname,dlcity,dlremark,names,remarks);
						        
						        
						    }
					
							//从表单中把所有同名的input取值拼接
							function findNames(inputname) {  
						        var inputvalues = document.getElementsByName(inputname);  //
						        var str = '';
						        
						        for(var i=0;i<inputvalues.length;i++){
						            if(inputvalues[i].value!=null){
						                str=str+inputvalues[i].value;
						            }else{
						                str='';
						            }
						            if(i<inputvalues.length-1){
						                str=str+",";
						            }
						        }
						        return str;
						    }
						    
						    //ajax提交保存数据
                            function validateSaveXl(dlid,dlname,dlcity,dlremark,names,remarks){
                                   var flags=true;
                                       jQuery.ajax({
                                url: '<%=request.getContextPath()%>/PbservicebigtypeAction.do?cmd=saveXl&id='+dlid+'&dlname='+encodeURI(encodeURI(dlname))+'&dlcity='+dlcity+'&dlremark='+encodeURI(encodeURI(dlremark))+'&names='+encodeURI(encodeURI(names))+'&remarks='+encodeURI(encodeURI(remarks)),
                                type: 'GET',
                                dataType: 'html',
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
	                                     //小类列表重新刷新
	                                    if(dlid.indexOf("dlTabTr")==-1){
	                                        showSmalldiv(dlid);
	                                    }else{
	                                       //把新的大类id赋值给tr/radio/onclick
		                                     $($("#"+dlid)[0]).attr("id",text);
		                                     $($("#"+text)[0]).attr("style","background-color:#dce6f5");
		                                     $($($("#"+text)[0]).children()[0].children[0]).val(text);
		                                     $($($("#"+text)[0]).children()[0].children[0]).bind("click", function(){
		                                        showSmalldiv(text);
		                                     });
	                                        showSmalldiv(text);
	                                    }
                                    }
                                    
                                }
                                });return flags;
                            }
            </script>
            <tr id="dlTabTr<%=size %>" style="display: none;">
                <td height="0" >&nbsp;</td>
                <td height="0" >&nbsp;</td>
                <td height="0" >&nbsp;</td>
                <td height="0" >&nbsp;</td>
             </tr>
            
    

    </table>
    </div>
    <!--表格 end-->

    <div class="mx_button">
        <table  width="100%" cellspacing="0"  class="datagrid1">
          <tr>
            <td align=center><input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="saveDl_onClick();" />
            </td>
          </tr>
      </table>
        
   </div>
</div>
<!-- 大类列表 end -->
</form>


<!-- 小类列表 -->
<div style="width:40%; float:left;">
 <!--按钮-->                  
 <div id="ccParent1" class="button"> 
        <div class="button_right">
                <ul>
                    <li class="c">      <a onClick="javascript:addxlTableRow();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteXl_onClick();"><fmt:message key="delete"/> </a> </li>
                </ul>
                
         </div>
         <div class="clear"></div>          
 </div>
 <!--按钮 end-->
 
 <!--小类表格 -->
     <div id="small_div" class="box"> 
	  <table  width="100%" cellspacing="0"  class="datagrid1" id="xlTab">
	      <tr>
	        <th width="7%"><input type="checkbox" onclick="checkAllList_onClick(this);"  pdType="control" control="checkbox_template"></th>
	        <th width="45%">小分类名称</th>
	        <th width="45%">备注</th>
	      </tr>
	  </table>
	</div>
 <!--小类表格 end-->
   <div class="mx_button">
        <table  width="100%" cellspacing="0"  class="datagrid1">
          <tr>
            <td align=center><input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="saveXl_onClick();" />
            </td>
          </tr>
      </table>
        
   </div>
</div>
<!-- 小类列表 end -->


</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%
//表单回写
	if(request.getAttribute(IPbservicebigtypeConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPbservicebigtypeConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
