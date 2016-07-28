<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.pbservicesmalltype.vo.PbServiceSmallTypeVo" %>
<%@ page import="rayoo.system.pbservice.vo.PbserviceVo" %>
<%@ page import="rayoo.system.pbservicesmalltype.util.IPbServiceSmallTypeConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IPbServiceSmallTypeConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IPbServiceSmallTypeConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	PbServiceSmallTypeVo resultVo = null;  //定义一个临时的vo变量
	
	
	//服务下拉框的liet
	String serviceSelect = "<select name='service_id'><option value=''>请选择</option>";
	List sResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IPbServiceSmallTypeConstants.REQUEST_SERVICE_BEANS) != null) {  //如果request中的beans不为空
        sResult = (List)request.getAttribute(IPbServiceSmallTypeConstants.REQUEST_SERVICE_BEANS);  //赋值给resultList
    }
    Iterator iter = null;  //定义访问List变量的迭代器
    if(sResult != null) {  //如果List变量不为空
        iter = sResult.iterator();  //赋值迭代器
        PbserviceVo serviceVo = null;  
        while(iter.hasNext()){
            serviceVo = (PbserviceVo) iter.next();
            serviceSelect = serviceSelect+"<option value='"+serviceVo.getId()+"'>"+serviceVo.getService_name()+"</option>";
        }
        serviceSelect=serviceSelect+"</select>";
    }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
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
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/PbServiceSmallTypeAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/PbServiceSmallTypeAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/system/security/pbservicesmalltype/insertPbServiceSmallType.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/PbServiceSmallTypeAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

    function checkradio(xlid){  //点击行，选中对应的radio
        var elementRadio = document.getElementsByName("radio_template");  //
       
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].value==xlid) {  //如果被选中
                elementRadio[i].checked=true;  
                break;
            }
        }
        
        showSmalldiv(xlid);
    }
    
    //显示小类的服务列表，则把服务列表清空即可，把小类id设在隐藏
    function showNewdiv(){
        selectAllRows();
        var ids = findSelections("checkbox_template","id");  //取得复选框的选择项
        if(ids == null) {  //如果ids为空
             return;
        }
        var obj=document.getElementById("fwTab");
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            var fwid=ids[i];
            var j=document.getElementById(fwid).rowIndex;
            obj.deleteRow(j);
        }
    }
    
    //显示数据库已有记录的服务项目列表
    function showSmalldiv(xlid){
        //先把服务项目列表清空
        showNewdiv();
        
        var ss = "<%=serviceSelect%>";
        //ajax请求数据加载到div中的列表
        $.getJSON("<venus:base/>/PbServiceSmallTypeAction.do?cmd=searchRel&date="+new Date()+"",{"id":xlid},  function(json){
         for(var i = 0; i < json.saia.length; i++){
            //alert(json.saia[i].id);
            //下拉框选中赋值
            var newstr = ss.replace("'"+json.saia[i].service_id+"'","'"+json.saia[i].service_id+"' selected='selected'");
            
            $("#fwTab").append("<tr id="+json.saia[i].id+"> <input type=\"hidden\" name=\"xlid\" value="+json.saia[i].service_small_type_id+">"
               +"  <td><input type=\"checkbox\" name=\"checkbox_template\" value="+json.saia[i].id+" /></td> "
               +"  <td>"+newstr+"</td>"
              +"</tr>");
            }
        }); 
        
    }
        
						    var hIndex=0;
						    //新增服务行
                            function addFwTableRow(){
                                var ss = "<%=serviceSelect%>";
                                var xlid = findSelection("radio_template","id");
                                if(xlid == null) {  //如果ids为空
                                    alert('请选择一条大分类');
                                    return;
                                }
                                var obj=document.getElementById("fwTab");
                                hIndex++;
                                //添加行
                                var rownum = obj.rows.length;
                                var tr0=obj.insertRow(rownum);
                                tr0.setAttribute("id","fwTabTr"+hIndex);
                                //添加单元格
                                var td0 = tr0.insertCell(0);
                                td0.innerHTML="<input type='checkbox' name='checkbox_template' value='fwTabTr"+hIndex+"'/>";
                                               
                                //添加单元格
                                var td1 = tr0.insertCell(1);
                                td1.innerHTML=ss;
                                
                              
                            }              
                            
                            //从多选框物理删除多条服务记录
                             function deleteFw_onClick(){
                                var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
                                if(ids == null) {  //如果ids为空
                                    alert('请从左边选择一条小分类');
                                    return;
                                }
                                if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
                                    //删除页面记录
                                    var ids_str='';
                                    var obj=document.getElementById("fwTab");
                                    for(var i=0;i<ids.length;i++){  //循环checkbox组
                                        var fwid=ids[i];
                                        var j=document.getElementById(fwid).rowIndex;
                                        obj.deleteRow(j);
                                        ids_str=ids_str+ids[i];
                                        if(i<ids.length-1){
                                            ids_str=ids_str+",";
                                        }
                                    }
                                    //数据库删除
                                    validateDeleteFw(ids_str);
                                }
                            }
                            
                            //ajax删除服务记录
                            function validateDeleteFw(ids_str){
                                   var flags=true;
                                       jQuery.ajax({
                                url: '<%=request.getContextPath()%>/PbServiceSmallTypeAction.do?cmd=deleteFw&ids='+ids_str,
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
                                
                            
                            //保存服务列表
                            function saveFw_onClick(){  //保存修改后的单条数据
                                var xlid = findSelection("radio_template","id");  //取得单选框的选择项
                                if(xlid == null) {  //如果id为空
                                    alert('请从左边选择一条小分类');
                                    return;
                                }
                                if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
                                    return false;
                                }
                                
                                var fwids = findNames("service_id");
                                if(fwids==''){
                                    //alert('所选的服务不能为空且不能重复，请重新选择！');
                                    return;
                                }
                                //使用ajax保存服务列表及其对应小类
                                validateSaveFw(xlid,fwids);
                                
                            }
                    
                            //从表单中把所有同名的下拉框取值拼接
                            function findNames(inputname) {  
                                var inputvalues = document.getElementsByName(inputname);
                                var str = '';  
                                for(var i=0;i<inputvalues.length;i++){
                                    var str0 ='';
                                    if(inputvalues[i].value!=null){
                                        str0 = inputvalues[i].value;
                                        str=str+str0;
                                    }else{
                                        str0='';
                                    }
                                    if(str0==''){
                                        alert('所选的服务不能为空！');
                                        str='';
                                        break;
                                    }
                                    
                                    //判断有没有重复
                                    var tt=0;
                                    for(var j=0;j<inputvalues.length;j++){
                                        if(inputvalues[j].value!=null && inputvalues[j].value!=''){
	                                        var str1=inputvalues[j].value;
	                                        if(i!=j && str0==str1){
	                                            alert('所选的服务有重复，请重新选择！');
	                                            tt=1;
                                                break;
	                                        }
	                                    }
                                    }
                                    if(tt==1){
                                        str='';
                                        break;
                                    }
                                    
                                    if(i<inputvalues.length-1){
                                        str=str+",";
                                    }
                                }
                                return str;
                            }
                            
                            //ajax提交保存数据
                            function validateSaveFw(xlid,fwids){
                                   var flags=true;
                                       jQuery.ajax({
                                url: '<%=request.getContextPath()%>/PbServiceSmallTypeAction.do?cmd=saveFw&id='+xlid+'&fwids='+fwids,
                                type: 'GET',
                                dataType: 'html',
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                        //服务列表重新刷新
	                                    showSmalldiv(xlid);
                                    }
                                    
                                }
                                });return flags;
                            }
</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/PbServiceSmallTypeAction.do?backFlag=true">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


		<tr>
            <td align="right">城市&nbsp;&nbsp;
            <td align="left">
                 <faerp:cityTag  tagname="city_id" />
            </td>
            <td align="right"></td>
        
            <td align="right">大分类名称&nbsp;&nbsp; </td>
            <td align="left">
                <input type="text" class="text_field" name="service_big_type_name" inputName="大分类名称" maxLength="50"/>
            </td>
            <td align="right"></td>
            
            
        </tr>
		
		<tr>
			<td/>
          
			<td/>
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	<td/>
		</tr>
</table>
</div>
</form>

 

<!-- 小分类列表 -->
<div style="width:55%; float:left;">
 <!--按钮-->                  
 <div id="ccParent1" class="button"> 
        <div class="button_right">
                <ul>
                    <li>      </li>
                </ul>
                
         </div>
         <div class="clear"></div>          
 </div>
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1" id="xlTab">
<tr>
<th></th>
<th>
				
			  	<a href="/FAERP/PbServiceSmallTypeAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_big_type_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_big_type_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_big_type_name")%>">
           	</a>	
       
			 大分类名称</th>
			<th>
				
			  	<a href="/FAERP/PbServiceSmallTypeAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"name")%>">
           	</a>	
       
			 小分类名称</th>
			<th>
				
			  	<a href="/FAERP/PbServiceSmallTypeAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remark")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remark")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remark")%>">
           	</a>	
       
			 备注</th>
			
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr onclick="checkradio('<bean:write name="data" property="id"/>');">
		<td> <input type="radio" name="radio_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/> </td>

            <td><bean:write name="data" property="service_big_type_name"/>   </td>
			
			<td><bean:write name="data" property="name"/>   </td>
			
			<td><bean:write name="data" property="remark"/>   </td>
			</tr>
</logic:iterate>
</table>
</div>
 
</div>
<!-- 小分类列表 end -->



<!-- 服务项目列表 -->
<div style="width:40%; float:left;">
 <!--按钮-->                  
 <div id="ccParent1" class="button"> 
        <div class="button_right">
                <ul>
                    <li class="c">      <a onClick="javascript:addFwTableRow();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteFw_onClick();"><fmt:message key="delete"/> </a> </li>
                </ul>
                
         </div>
         <div class="clear"></div>          
 </div>
 <!--按钮 end-->
 
 <!--服务表格 -->
     <div id="small_div" class="box"> 
      <table  width="100%" cellspacing="0"  class="datagrid1" id="fwTab">
          <tr>
            <th width="15%"><input type="checkbox" onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
            <th width="85%">服务</th>
          </tr>
      </table>
    </div>
 <!--服务表格 end-->
   <div class="mx_button">
        <table  width="100%" cellspacing="0"  class="datagrid1">
          <tr>
            <td align=center><input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="saveFw_onClick();" />
            </td>
          </tr>
      </table>
        
   </div>
</div>
<!-- 服务项目列表 end -->
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IPbServiceSmallTypeConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPbServiceSmallTypeConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
