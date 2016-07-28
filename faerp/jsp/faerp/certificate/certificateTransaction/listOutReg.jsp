<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.certificate.certificateTransaction.util.ICertificateTransactionConstants" %>
<html>
<fmt:bundle basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh" prefix="rayoo.certificate.certificateTransaction.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="outworkerReg"/></title>
<script language="javascript">
    jQuery(document).ready(function()
    {
       $id("datacell1").isQueryFirst = false;
    });
//选择框后续处理方法
    function rtnFuncOutworkerName(arg){
        var lookup = $id("outworkerName");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        jQuery("#companyNumber").text(arg[1]);
        return false;
    }
    
        function rtnFuncBackUpPersonName(arg){
        var lookup = $id("backUpPersonName");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        jQuery("#companyNumber").text(arg[1]);
        return false;
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
        var url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=findOutReg&id=" + ids;
        window.open(url,'',"height=485px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMultiOutReg";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
        var url="<%=request.getContextPath()%>/jsp/faerp/certificate/certificateTransaction/insertOutReg.jsp";
        window.open(url,'','height=485px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=证件办理材料新增');
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
		var url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=detailOutReg&id=" + ids;
        window.open(url,'',"height=275px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");
	}
//-------------------------------
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio' name='checkbox_template' value='"+value+"' >";
    }
    
    function insertcallBack(reg){
        if(reg=="0"){
            alert("<fmt:message key='operate_success'/>");
        }else if(reg=="-1"){
            return;
        }else{
            alert("<fmt:message key='operate_fail'/>");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CredentialsTypeAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco("<fmt:message key='outworkerReg'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='Query_conditions'/></div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right"><fmt:message key='outworker'/></td>
			<td align="left">
				  <w:lookup name="outworkerName" 
                        onReturnFunc="rtnFuncOutworkerName" id="outworkerName"
                        lookupUrl="/CertificateTransactionAction.do?cmd=getCertificateSpecialistPage"
                        messagekey="choose_certificateSpecialist" height="440" width="600"
                        style="width:170px" />
			</td>
			<td align="right"><fmt:message key='outTimeRange'/></td>
			<td align="left">
				<w:date format="yyyy-MM-dd HH:mm:ss"   name="createDateFrom" id="create_date_from" style="width: 125px" />
			</td>
			<td align="right"></td>
            <td align="left">
              
            </td>
		</tr>
		<tr>
		  <td></td>
			  <td colspan="3">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
		</tr>
</table>
</div>
					
<div id="ccParent1" class="button"> 
 <div class="button_right">
					<input class="a" type="button"  onClick="javascript:detail_onClick();" value="<fmt:message key="view"/>"<au:authorityBtn code="view_outReg" type="1"/>>
					<input class="c" type="button" onClick="javascript:toAdd_onClick();" value="<fmt:message key="insert"/>"<au:authorityBtn code="insert_outReg" type="1"/>>
					<input class="b" type="button"  onClick="javascript:findCheckbox_onClick();" value="<fmt:message key="modify"/>"<au:authorityBtn code="modify_outReg" type="1"/>>
				    <input class="d" type="button" onClick="javascript:deleteMulti_onClick();" value="<fmt:message key="delete"/>"<au:authorityBtn code="delete_outReg" type="1"/>>
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
<div style="padding: 8 10 8 8;">
    <r:datacell id="datacell1" queryAction="/FAERP/CertificateTransactionAction.do?cmd=simpleQueryOutReg"  width="98%" height="303px" xpath="OutRegVo" paramFormId="datacell_formid" readonly="true">
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field fieldName="id" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
        <r:field fieldName="outworkerName" messagekey="outworker" width="200px"></r:field>
        <r:field fieldName="createDateFrom" messagekey="createDateFrom" width="200px">
             <w:date format="yyyy-MM-dd HH:mm"/>
        </r:field>
        <r:field fieldName="createDateTo" messagekey="createDateTo" width="200px">
             <w:date format="yyyy-MM-dd HH:mm"/>
        </r:field>
    </r:datacell>
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

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(ICertificateTransactionConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICertificateTransactionConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
