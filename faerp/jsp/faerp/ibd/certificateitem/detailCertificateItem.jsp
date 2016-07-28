<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%@ page import="rayoo.employeepost.empinfo.employee.util.IEmployeeConstants" %>
<%
EmployeeVo resultVo = null;  //定义一个临时的vo变量
resultVo = (EmployeeVo)request.getAttribute(IEmployeeConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
RmVoHelper.null2Nothing(resultVo);//把vo中的每个值过滤
%>

<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>IBD证件管理List页面</title>
	<script language="javascript">
	
    function simpleQuery_onClick(){  //简单的模糊查询'
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function setRadioStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  id='r_"+rowNo+"'  name='radio_template' value='"+value+"' onclick=\"getMatrialList('"+value+"');\">";
    }
    
    function close_onClick(){
	    var opener = window.opener;
	    if (opener){
	        window.close();
	    }else{
	        form.action="<%=request.getContextPath()%>/CertificateAction.do?cmd=queryAll";
            form.submit();
	    }
    }
    
    function getMatrialList(certificateItemId){
        $id("datacell2").queryAction = "/FAERP/CertificateMaterialAction.do?cmd=detailForMaterial&certificateItemId="+certificateItemId;
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
</script>
	</head>
	<body>

	<form name="form" method="post" id="datacell_formid">
	<input type="hidden" name="cmd" value="">
	<div id="right">
	<div class="right_title_bg">
	<div class=" right_title">员工证件管理</div>
	</div>
	<div class="ringht_s">
	<div class="box_3">
	<div class="xz_title">员工基本信息</div>
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr valign="middle">
			<td class="td_1">客户</td>
			<td class="td_2">${employee.cust_name }</td>
			<td class="td_1">唯一号</td>
			<td class="td_2">${employee.emp_code }</td>
		</tr>
		<tr valign="middle">
			<td class="td_1">姓名</td>
			<td class="td_2">${employee.emp_name }</td>
			<td class="td_1">国籍</td>
			<td class="td_2">${employee.country_name}</td>
		</tr>
		<tr valign="middle">
            <td class="td_1">证件号码</td>
            <td class="td_2">${employee.id_card }</td>
            <td class="td_1">E-mail</td>
            <td class="td_2">${employee.email }</td>
        </tr>
		<tr valign="middle">
			<td class="td_1">联系地址</td>
			<td class="td_2">${employee.address }</td>
			<td class="td_1">联系电话</td>
			<td class="td_2">${employee.tel }</td>
		</tr>
	</table>
	</div>
	<div class="box_3" style="margin-bottom: -2px;">
	   <div class="xz_title">办理证件</div>
    </div>
	   <div style="margin-left: 20px;">
            <r:datacell id="datacell1" queryAction="/FAERP/CertificateItemAction.do?cmd=detailForEmp&empId=${empId}&isChecked=true&showAll=showAll"
                width="96%" height="150px" xpath="CertificateItemVo" submitXpath="CertificateItemVo" paramFormId="datacell_formid">
                <r:field fieldName="id" label="" width="30px" sortAt="none" onRefreshFunc="setRadioStatus"  align="center"></r:field>
                <r:field fieldName="credentials_type_id" label="证件" width="150" allowModify="false">
                       <r:comboSelect id="credentials_name_list" name="id"
                               queryAction="/FAERP/CertificateItemAction.do?cmd=getCredentialsTypes"
                               valueField="id"
                               textField="credentials_name"
                               xpath="CredentialsTypeVo"
                               width="150"
                               validateAttr="message=证件类型;allowNull=false"/>
                 </r:field>
                <r:field fieldName="status" label="状态" width="100" allowModify="false">
                    <d:select name="status" id="status" dictTypeId="CERTIFICATE_STATUS" ></d:select>
                </r:field>
                <r:field fieldName="processing_time" label="办理日期" width="150" allowModify="false">
                      <w:date allowInput="true" id="processing_time" name="processing_time" format="YYYY-MM-DD" property="bean/processing_time" width="150px" />
                </r:field>
                <r:field fieldName="time_limit" label="有效期限(月)" width="100"></r:field>
                <r:field fieldName="start_time" label="签发日期" width="150" allowModify="false">
                      <w:date allowInput="true" id="start_time" name="start_time" format="YYYY-MM-DD" property="bean/start_time" width="150px" />
                </r:field>
                <r:field fieldName="end_time" label="到期日期" width="150" allowModify="false">
                      <w:date allowInput="true" id="end_time" name="end_time" format="YYYY-MM-DD" property="bean/end_time" width="150px" />
                </r:field>
                <r:field fieldName="remark" label="备注" width="275"></r:field>
                <r:field fieldName="cerView" label="预览" width="100"><a href="#">预览</a></r:field>
            </r:datacell>
        </div>


	<div class="box_3">
	   <div class="xz_title">材料扫描件</div>
	</div>
            
	<div style="margin-left: 20px;">
            <r:datacell id="datacell2" queryAction=""
                width="96%" height="150px" xpath="CertificateMaterialVo" submitXpath="CertificateMaterialVo" paramFormId="datacell_formid">
                <r:field fieldName="material_name" label="材料名称" width="300"></r:field>
                <r:field fieldName="receive_time" label="收取日期" width="300">
                    <w:date allowInput="true" id="receive_time" name="receive_time" format="YYYY-MM-DD" property="bean/receive_time" width="300" />
                </r:field>
                <r:field fieldName="receive_time" label="上传日期" width="300">
                    <w:date allowInput="true" id="upload_time" name="upload_time" format="YYYY-MM-DD" property="bean/upload_time" width="300" />
                </r:field>
                <r:field fieldName="materialView" label="查看" width="300"></r:field>
            </r:datacell>
        </div>
	<div class="xz_button" style="padding-left: 400px;">
        <input name="button" type="button" class="icon_2" value="返回"  onClick="javascript:close_onClick();"/>
    </div>
	</div>
	</div>
	</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>