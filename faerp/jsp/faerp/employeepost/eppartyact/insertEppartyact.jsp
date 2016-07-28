<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartyact.vo.EppartyactVo" %>
<%@ page import="rayoo.employeepost.eppartyact.util.IEppartyactConstants" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%  //判断是否为修改页面
	EppartyactVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEppartyactConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EppartyactVo)request.getAttribute(IEppartyactConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
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
		form.action="<%=request.getContextPath()%>/EppartyactAction.do?cmd=insert";
		form.submit();
		
		
		       var flags=true;
                            jQuery.ajax({
                                url: '<%=request.getContextPath()%>/EppartyactAction.do?cmd=insert',
                                type: 'GET',
                                dataType: 'html',
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                      window.close();
                                      
                                    }
                                    
                                }
                                });return flags;
		}
		
		
		
		
		
		
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/EppartyactAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EppartyactAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_1" >活动名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="act_name" inputName="活动名称" value="" maxLength="50" />
			</td>
			<td class="td_1" >活动性质</td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("act_type", -1,"PARTY_ACT_TYPE", "", "", false) %>
            </td>
		</tr>
		<tr>
			<td class="td_1" >活动时间</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="act_date" id="act_date" inputName="活动时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('act_date','<venus:base/>/');"/>
			</td>
			 <td class="td_1" >活动地点</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="act_address" inputName="活动地点" value="" maxLength="50" />
            </td>
		</tr>
		
		<tr>
			<td class="td_1">备注</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="remarks" inputName="备注" maxLength="500" style="width: 400px;"></textarea>
			</td>
		</tr>
	</table>

    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         

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
