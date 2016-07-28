<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.radix.adjusttask.vo.AdjustTaskVo" %>
<%@ page import="rayoo.customerservice.radix.adjusttask.util.IAdjustTaskConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	AdjustTaskVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	String year = "";
	String logname = "";
	String lock  = request.getAttribute("lock")==null?"false":request.getAttribute("lock").toString();
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IAdjustTaskConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (AdjustTaskVo)request.getAttribute(IAdjustTaskConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		    logname = request.getAttribute("logname")==null?"":request.getAttribute("logname").toString();
  		}
	}else{
	    year = request.getAttribute("year").toString();
	    logname = request.getAttribute("logname")==null?"":request.getAttribute("logname").toString();
	    
	}
	
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/AdjustTaskAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/AdjustTaskAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/AdjustTaskAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function findSecuritygroup(){
        var data = window.showModalDialog('<venus:base/>/SecuritygroupAction.do?cmd=findSecuritygroup&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(data == undefined) return;
        document.getElementById('group_ids').value =data[0];
        document.getElementById('group_name').value =data[1];
    }
</script>
</head>
<body>

<form name="form" method="post">
<input type="hidden" name="backFlag" id="backFlag" value="false">
<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<input type="hidden" name="backFlag" id="backFlag" value="false">
<%
if(!isModify){
    %>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
        <td class="td_1" >调整任务的名称</td>
        <td class="td_2 ">
            <input type="text" class="text_field" name="adjust_task_name" inputName="调整任务的名称" value="" maxLength="50" />
        </td>
        <td class="td_1" >社保/公积金组</td>
        <td class="td_2 ">
            <input type="text" class="text_field_reference_readonly" name="group_name" id="group_name" inputName="社保/公积金组" value="" maxLength="250" /><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:findSecuritygroup();"/>
            <input type="hidden" name="group_ids" id="group_ids" value=""/>
        </td>
    </tr>
    <tr>
        <td class="td_1" >调整年份</td>
        <td class="td_2 ">
            <input type="text" class="text_field" readonly="readonly" name="adjust_year" inputName="调整年份" value="<%=year %>" maxLength="64" />
        </td>
        <td class="td_1" >是否在启用状态</td>
        <td class="td_2 ">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("task_status_bd", -1,"TrueOrFalse","0","",true) %>
        </td>
    </tr>
    <tr>
        <td class="td_1" >是否锁定</td>
        <td class="td_2 ">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_lock_bd", -1,"TrueOrFalse","1","",true) %>
        </td>
        <td class="td_1" >创建人</td>
        <td class="td_2 ">
            <input type="text" class="text_field" name="create_user_id" readonly="readonly" inputName="创建人" value="<%=logname %>" maxLength="64" />
        </td>
    </tr>
    <tr>
        <td class="td_1" >备注</td>
        <td class="td_2 ">
            <input type="text" class="text_field" name="remark" inputName="备注" value="" maxLength="1000" />
        </td>
        <td class="td_1" ></td>
        <td class="td_2 "></td>
    </tr>
</table>
    <%
}else{
    %>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
        <td class="td_1" >调整任务的名称</td>
        <td class="td_2 ">
            <%
            if(lock=="true" || lock.equals("true")){
                %>
                <input type="text" class="text_field" name="adjust_task_name" readonly="readonly" inputName="调整任务的名称" value="<%=resultVo.getAdjust_task_name() %>" maxLength="50" />
                <%
            }else{
                %>
                  <input type="text" class="text_field" name="adjust_task_name" inputName="调整任务的名称" value="<%=resultVo.getAdjust_task_name() %>" maxLength="50" />  
                <%
            }
            %>
            
        </td>
        <td class="td_1" >社保/公积金组</td>
        <td class="td_2 ">
         <%
            if(lock=="true" || lock.equals("true")){
                %>
                <input type="text" class="text_field_reference_readonly" name="group_name" id="group_name" inputName="社保/公积金组" value="<%=resultVo.getGroup_name() %>" maxLength="250" />
                <input type="hidden" name="group_ids" id="group_ids" value="<%=resultVo.getGroup_ids() %>"/>
                <%
            }else{
                %>
                  <input type="text" class="text_field_reference_readonly" name="group_name" id="group_name" inputName="社保/公积金组" value="<%=resultVo.getGroup_name() %>" maxLength="250" /><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:findSecuritygroup();"/>
                  <input type="hidden" name="group_ids" id="group_ids" value="<%=resultVo.getGroup_ids() %>"/>  
                <%
            }
            %>
            
        </td>
    </tr>
    <tr>
        <td class="td_1" >调整年份</td>
        <td class="td_2 ">
            <input type="text" class="text_field" readonly="readonly" name="adjust_year" inputName="调整年份" value="<%=resultVo.getAdjust_year() %>" maxLength="64" />
        </td>
        <td class="td_1" >是否在启用状态</td>
        <td class="td_2 ">
        <%
            if(lock=="true" || lock.equals("true")){
                %>
                <input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_lock_bd()) %>" />
                <%
            }else{
                %>
                  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("task_status_bd", -1,"TrueOrFalse",resultVo.getTask_status_bd(),"",true) %>  
                <%
            }
            %>          
        </td>
    </tr>
    <tr>
        <td class="td_1" >是否锁定</td>
        <td class="td_2 ">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_lock_bd", -1,"TrueOrFalse",resultVo.getIs_lock_bd(),"",true) %>
        </td>
        <td class="td_1" >创建人</td>
        <td class="td_2 ">
            <input type="text" class="text_field" readonly="readonly" value="<%=logname %>"/>
            <input type="hidden" class="text_field" name="create_user_id" readonly="readonly" inputName="创建人"  value="<%=resultVo.getCreate_user_id()%>" maxLength="64" />
        </td>
    </tr>
    <tr>
        <td class="td_1" >备注</td>
        <td class="td_2 ">
            <input type="text" class="text_field" name="remark" inputName="备注" value="<%=resultVo.getRemark() %>" maxLength="1000" />
        </td>
        <td class="td_1" ></td>
        <td class="td_2 "></td>
    </tr>
</table>
    <%
}
%>

 

            
   
   
<div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
