<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.job.job_person.vo.JOB_PERSONVo" %>
<%@ page import="rayoo.job.job_person.util.IJOB_PERSONConstants" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@page import="rayoo.job.job_person.vo.JOB_JOBDETAILSVo"%>
<%@page import="rayoo.job.job_person.vo.JOB_EDUDETAILSVo"%>
<%@page import="rayoo.job.job_person.vo.JOB_LANDETAILSVo"%>
<%@page import="gap.authority.util.DateTools"%>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<%
	JOB_PERSONVo resultVo = null;
	if(request.getAttribute(IJOB_PERSONConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
	    resultVo = (JOB_PERSONVo)request.getAttribute(IJOB_PERSONConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	}
	String p_age = "";
	String p_birth = "";
	if(resultVo!=null){
		if(resultVo.getSbirthyear() != null && !"".equals(resultVo.getSbirthyear())){
			int now = Integer.parseInt(DateTools.getSysDate().substring(0,4));
			
			int birth = Integer.parseInt(resultVo.getSbirthyear());
			p_age = (now - birth)+"";
		}
		if(resultVo.getSbirthyear() != null && !"".equals(resultVo.getSbirthyear())
		&&resultVo.getSbirthmonth() != null && !"".equals(resultVo.getSbirthmonth())){
			p_birth = resultVo.getSbirthyear()+"-"+resultVo.getSbirthmonth();
		}
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    
    function cancel_onClick(){  //返回列表页面
        window.close();
    }

    function orderIdradiobox(value,entity,rowNo,cellNo){
       return "<input type='radio' name='temp' value=" + entity.getProperty("order_id") + "  >";
    }
    
    //查看候选人状态历史
   function candidateStateList(){
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var edit_id = document.getElementById("edit_id").value;
        
        var url="<%=request.getContextPath()%>/jsp/faerp/job/jobcandidate/candidateStateList.jsp?order_id="+ids+"&person_id="+edit_id;        
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.showModalDialog(url,"","dialogHeight :400px;dialogWidth:920px;center:yes;status:no;scroll:no;resizable:no;");
    }
</script>
</head>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_s">
<div id="ccChild1" class="box_3"> 
<div class="xz_title">基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" >
        <tr>
            <td class="td_1"  width="23%" >姓名</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="sname" id="sname" value="${bean.sname}" readonly="true"/>
            </td>
            <td class="td_1" width="23%">性别</td>
            <td class="td_2"  width="28%">
            	<d:select dictTypeId="YINGRUI_SEX" value="${bean.isex}" disabled="true" />
            </td>
            <td class="td_2"  width="28%" rowspan="4">
            	 <label>照片</label>
            </td>
        </tr>
		<tr>
			<td  class="td_1" width="23%" >年龄</td>
			<td  class="td_2" width="28%">
				<input type="text" class="text_field" value="<%=p_age%>" readonly="true"/>
			</td>
			<td  class="td_1"  width="23%" >出生年月</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" value="<%=p_birth%>" readonly="true"/>
            </td>
		</tr>
		<tr>
			<td  class="td_1" width="23%" >居住地</td>
			<td  class="td_2" width="28%">
				<d:select dictTypeId="YINGRUI_AREA" nullLabel=" " value="${bean.iresidencecity}" disabled="true" />
			</td>
			<td  class="td_1" width="23%" >户口</td>
			<td  class="td_2" width="28%">
				<d:select dictTypeId="YINGRUI_AREA" nullLabel=" " value="${bean.icity}" disabled="true" />
			</td>
		</tr>
		<tr>
			<td  class="td_1" width="23%" >电话</td>
			<td  class="td_2" width="28%">
				<input type="text" class="text_field"  value="${bean.mobile}" readonly="true" />
			</td>
			<td  class="td_1" width="23%" >E-mail</td>
			<td  class="td_2" width="28%">
				<input type="text" class="text_field" value="${bean.email}" readonly="true" />
			</td>
		</tr>
    </table>
	<p></p>
<div class="xz_title">自我评价</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" >
	<tr>
		<td  class="td_2" width="28%">
				<textarea "sevaluate" id="sevaluate" style="width:600px; height:60px;" class="xText_d" rows="4" readonly="true" >${bean.sevaluate}</textarea>
		</td>
	</tr>
</table>
<p></p>

<div class="xz_title">简历粘贴</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" >
	<tr>
		<td  class="td_2" width="28%">
				<textarea "sevaluate" id="sevaluate" style="width:600px; height:400px;" class="xText_d" rows="4" readonly="true" >${bean.sfullText}</textarea>
		</td>
	</tr>
</table>
<p></p>

</div>
<div style="padding-left: 10px;">
<div class="xz_title">相关订单信息</div>
<div class="button_right"  style="padding-left: 15px;">
    <ul>
        <li class="a_2"><a onClick="javascript:candidateStateList();">查看状态</a></li>
    </ul>
</div>

 <div class="clear"></div>
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" 
             queryAction="/FAERP/JOB_PERSONAction.do?cmd=queryPersonOrder&person_id=${bean.id}"
             width="700px" 
             xpath="JOB_PERSONORDERVo" 
             paramFormId="datacell_formid"
             showIndex="false"
 >
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="order_id" label="操作" width="35px" onRefreshFunc="orderIdradiobox"  align="center" ></r:field>
 <r:field fieldName="order_name" label="订单名称" allowModify="false" width="200px"></r:field>
 <r:field fieldName="order_status" label="订单状态" allowModify="false" width="100px">
    <d:select dictTypeId="ORDER_STATUS_BD"></d:select>
 </r:field>
 <r:field fieldName="position" label="职位名称" allowModify="false" width="200px"></r:field>
 <r:field fieldName="candidate_status" label="候选人状态" allowModify="false" width="100px">
    <d:select dictTypeId="CANDIDATE_STATUS_BD" ></d:select>
 </r:field>
 </r:datacell>
</div>
</div>
</div>
<div class="foot_button" style="text-align: center; margin-left: 0px;">
     <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
</div>
</div>
</div>

<input type="hidden" name="id" id="edit_id" value="${bean.id}">


</form>   
</body>
</fmt:bundle>
</html>
