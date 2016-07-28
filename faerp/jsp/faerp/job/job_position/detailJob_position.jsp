<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_position.vo.Job_positionVo" %>
<%@ page import="rayoo.job.job_position.util.IJob_positionConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
 var jq = jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function init(){
		//取得主页面传过来的参数
	
			var datacell = window["dialogArguments"];
			var entity = datacell.getActiveEntity();
            //document.getElementById("positiontype").value = entity.getProperty("positiontype")==null?"":entity.getProperty("positiontype");
            document.getElementById("is_invoiced").value = entity.getProperty("is_invoiced")==null?"":entity.getProperty("is_invoiced");
            document.getElementById("position").value = entity.getProperty("position")==null?"":entity.getProperty("position");
            document.getElementById("area").value =( entity.getProperty("area")==null?"":entity.getProperty("area"));
            document.getElementById("salary_range").value = entity.getProperty("salary_range")==null?"":entity.getProperty("salary_range");
            document.getElementById("job_number").value = entity.getProperty("job_number")==null?"":entity.getProperty("job_number");
            document.getElementById("requirement").value = entity.getProperty("requirement")==null?"":entity.getProperty("requirement");
            document.getElementById("position_status").value = entity.getProperty("position_status")==null?"":entity.getProperty("position_status");
            
	}

    function cancel_onClick(){  //取消后返回列表页面
       window.close();
    }
</script>
</head>
<body onload='init();'>

<form name="form" method="post" id="datacell_formid">
     <div id="right">
    <div class="ringht_s">
    <div id="ccChild1" class="box_3">
<div class="xz_title">基本信息</div> 
<table  width="97%" height="40" border="0"  cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 		<tr>
            <td class="td_1"  width="28%" nowrap="nowrap"><span class="style_required_red">* </span>职位名称</td>
            <td class="td_2 " >
               <input  type="text" class="text_field" disabled="true" name="position" id="position" inputName="职位名称" maxLength="23"   value="${bean.position}"/>
       		</td>
       		<td class="td_1"  width="28%" ><span class="style_required_red">* </span>招聘地区</td>
            <td class="td_2 " >
               <input type="text" class="text_field"  disabled="true" name="area" id="area" inputName="招聘地区" maxLength="23"   value="${bean.area}"/>
       		</td>
        </tr>
		<tr>
            <td class="td_1" width="28%" nowrap="nowrap"><span class="style_required_red">* </span>薪资范围</td>
            <td class="td_2"  >
            	<d:select dictTypeId="SALARY_RANGE_BD"  disabled="true" id="salary_range" name="salary_range" nullLabel="--请选择--" value="${bean.salary_range}"></d:select>
            </td>
			<td  class="td_1" width="28%" nowrap="nowrap"><span class="style_required_red">* </span>招聘数量</td>
			<td  class="td_2" >
				 <input type="text" class="text_field"  disabled="true" name="job_number" id="job_number" inputName="招聘数量" maxLength="23"   value="${bean.job_number}"/>
			</td>
		</tr>
		<tr>
         <!-- 
            <td class="td_1"  width="28%" nowrap="nowrap"><span class="style_required_red">* </span>职位类型</td>
            <td class="td_2 " >
               <d:select dictTypeId="POSITIONTYPE_BD" disabled="true" id="positiontype" name="positiontype" value="${bean.positiontype}" onchange="typeChange();"></d:select>
            </td>
         -->
                <td class="td_1"  width="28%" nowrap="nowrap"><span class="style_required_red">* </span>是否预开票</td>
            <td class="td_2 "  colspan="3">
               <d:select dictTypeId="TrueOrFalse" id="is_invoiced" name="is_invoiced" value="${bean.is_invoiced}" nullLabel="请选择"  disabled="true" ></d:select>
            </td>
        </tr>
		<tr>
            <td class="td_1" width="28%" nowrap="nowrap"><span class="style_required_red">* </span>职位要求</td>
            <td class="td_2"  colspan="3">
            	 <textarea id="requirement" style="width:400px; height:40px;" class="xText_d" rows="4" name="requirement"  disabled="true" ></textarea>
            	 <input type="hidden" name="position_status" id="position_status">
            </td>
		</tr>
    </table>
    </div>
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
    </div>
    
<input type="hidden" name="id" id="edit_id" value="">
<input type="hidden" name="create_date" id="create_date" value="">
<input type="hidden" name="create_user_id" id="create_user_id" value="">
<input type="hidden" name="company_id" id="company_id" value="">
<input type="hidden" name="create_date" />
</div>
</div>		

</form> 
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
