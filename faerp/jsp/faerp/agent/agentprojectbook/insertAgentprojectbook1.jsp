<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
        AgentprojectbookVo resultVo = null;  //定义一个临时的vo变量
        boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
        if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
            isModify = true;  //赋值isModify为true
            if(request.getAttribute(IAgentprojectbookConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
                resultVo = (AgentprojectbookVo)request.getAttribute(IAgentprojectbookConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
            }
        }
    
%>



<%@page import="rayoo.agent.agentprojectbook.vo.AgentprojectbookVo"%>
<%@page import="rayoo.agent.agentprojectbook.util.IAgentprojectbookConstants"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

	function insert_onClick(){  //插入单条数据  
	
	 var projectbook_type=document.getElementById("projectbook_type").value;
	 var start_date=document.getElementById("start_date").value;
	 var end_date=document.getElementById("end_date").value;
	 var city_id=document.getElementById("city_id").value;
	 var send_id=document.getElementById("send_id").value;
	    
	    if(projectbook_type==null||projectbook_type==""){  
       alert("项目书类型不能为空");
       return;
       }
     
        if(start_date==null||start_date==""){
            alert("开始时间不能为空");
           return;
       }
         if(projectbook_type=='1'){
             if(end_date==null||end_date==""){
               alert("短期项目书结束时间不能为空");
               return;
             }
       }
        if(send_id==null||send_id==""){  
       alert("委派单不能为空");
       return;
       }
          if(city_id==null||city_id==""){
       alert("城市不能为空");
       return;
       }
	  
	    var city_name=$id("city_id").getDisplayValue();    
	          var param=jQuery("form").serialize();      
		form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=insertPage&city_name="+city_name;
		form.submit();
	}



    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }

</script>
</head>
<body >

<form name="form" method="post" id="form">
<div id="right">
<script language="javascript">
        writeTableTopFesco('新增项目书','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
	<td  class="td_1"><span class="style_required_red">* </span>项目书类型</td>
          
            <td class="td_2 " colspan="3"><d:select dictTypeId="PROJECTBOOK_TYPE_BD" id="projectbook_type" name="projectbook_type" nullLabel="请选择" value="${bean.projectbook_type}" style="width: 201px"></d:select>
        </tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>开始时间</td>
            <td class="td_2 ">
                   <w:date id="start_date" name="start_date" format="yyyy-MM-dd" width="185px" property="bean/start_date" />  
           
            </td>
                    <td class="td_1" >结束时间</td>
            <td class="td_2 ">
                   <w:date   name="end_date" format="yyyy-MM-dd" width="185px" property="bean/end_date"/>  
            </td>
		</tr>
		<tr>
		  <td class="td_1" ><span class="style_required_red">* </span>委派单</td>
      <td align="left" class="td_2"><w:lookup readonly="true" id="lk_send" validateAttr="allowNull=false;" name="lk_send"
            lookupUrl="/FAERP/AgentprojectbookAction.do?cmd=getSendByCondition" style="width:185px"
            dialogTitle="选择客户" height="450" width="810" displayValue="${bean.send_name }" /></td>
			<td class="td_1" ><span class="style_required_red">* </span>城市</td>
			<td class="td_2 ">
			 <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       property="bean/city_id"
                       nullText="" readonly="true" />        
			</td>
	
		</tr>
		<tr>
			<td class="td_1" >客户</td>
			<td class="td_2 ">
				<input type="text" class="text_field" id="cust_name" name="cust_name" inputName="cust_code" value="" maxLength="25" readonly="readonly" width="185px" />
			</td>
			<td class="td_1">服务条款模板</td>
			<td class="td_2"  align="left"><w:lookup readonly="true" id="templete_id" validateAttr="allowNull=false;" name="templete_id"
            lookupUrl="/FAERP/AgenttempleteAction.do?cmd=getAlltempleteByCondition" style="width:185px"
            dialogTitle="添加模板" height="450" width="550" displayValue="${bean.templete_name}" /></td>
		</tr>

	</table>
    <div class="mx_button">
        <input type="button" class="icon_2" value='下一步' onClick="insert_onClick();"> 
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="cancel_onClick();"/>
 
        </div>
</div>         
<input type="hidden" id="send_id" name="send_id" value="">  
<input type="hidden" id="send_name" name="send_name" value="">
<input type="hidden" id="cust_id" name="cust_id" value="">  
<input type="hidden" id="payment_month" name="payment_month" value="">  
<input type="hidden" id="cust_code" name="cust_code" value="">  
<input type="hidden" id="cust_send_id" name="cust_send_id" value="">  
<input type="hidden" id="cust_receive_id" name="cust_receive_id" value="">
<input type="hidden" id="cust_send_customer" name="cust_send_customer" value="">
<input type="hidden" id="cust_receive_customer" name="cust_receive_customer" value="">
<input type="hidden" id="agent_id" name="agent_id" value="">
<textarea style="display: none" rows="2" name="special_description" inputName="特殊说明">${bean.special_description }</textarea>
<textarea  class="textarea_limit_words"  rows="16" cols="62" id="templete_content" name="templete_content" style="display: none">${bean.templete_content }</textarea>
    <input type="hidden" id="remark" name="remark" value="">
<input type="hidden" id="projectbook_code" name="projectbook_code" value="">
<input type="hidden" id="templete_name" name="templete_name" value="">

</form>
</fmt:bundle>
</body>
</html>
<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
        out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
</script>
<script language="javascript">
$id("templete_id").onReturnFunc = function (returnValue){
    var lookup = $id("templete_id");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
    _$("#templete_name").val(returnValue[2]);
    _$("#templete_content").val(returnValue[3])
    return false;
}
$id("lk_send").onReturnFunc = function (returnValue){
    var lookup = $id("lk_send");
    var city=$id("city_id");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
    _$("#send_id").val(returnValue[0]);
    _$("#send_name").val(returnValue[2]);
     _$("#cust_name").val(returnValue[3]);
      _$("#cust_code").val(returnValue[4]);
    _$("#cust_id").val(returnValue[5]);
   _$("#cust_send_id").val(returnValue[6]);
    _$("#cust_receive_id").val(returnValue[7]);
    _$("#agent_id").val(returnValue[7]);
     _$("#cust_send_customer").val(returnValue[8]);
    _$("#cust_receive_customer").val(returnValue[9]);
   city.setValue(returnValue[1]);
    return false;
}
</script>
