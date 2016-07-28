<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page
	import="rayoo.certificate.certificateTransaction.util.ICertificateTransactionConstants"%>
<html>
<fmt:bundle
	basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh"
	prefix="rayoo.certificate.certificateTransaction.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key="cardTran" /></title>
	<script language="javascript">
	var _jQuery = window.jQuery, _$ = window.$;
    jQuery.noConflict();
	
	jQuery(document).ready(function()
	{
	   $id("datacell1").isQueryFirst = false;
	   
	    jQuery("#importEmployee").bind("click", function() {
            vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/employeepost/empinfo/employee/importEmpExcel.jsp", "", "dialogWidth=600px; dialogHeight=250px");
            if (vReturnValue == '1') {
                jQuery("#button_ok22").click();
            }
	    });
	});
	    //选择框后续处理方法
    function rtnFuncNew(arg)
    {
      var lookup = $id("newUser");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
	
	//批量更换证件办理专员
    function changeSave(){
        var newUserId = $id("newUser").getValue();
        var ids = findSelections("checkbox_template","id");
        if(newUserId == ""){
            alert("请选择新证件专员");
            return;
        }
        if(ids == null || ids == "" || ids == undefined){
            alert("<fmt:message key="select_one_record"/>");
            return;
        }
        jQuery.getJSON("/FAERP/CertificateTransactionAction.do?cmd=changeSaveCredentialsTran"  +"&ids=" + ids +"&newUserId=" + newUserId ,{ random: Math.random() },function(json){
            alert(json.returnString);
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        });
    }
	//办理证件类别、办理证件小类联动
   function findType(){
        var credentials_type_id = document.getElementById('cardTranType');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('credentialsTypeBdID').value;
        if(type_bd == null || type_bd==''){
            return;
        }
         jQuery.getJSON("<venus:base/>/CertificateTransactionAction.do?cmd=findCredentialsType&flg=1&date="+new Date()+"",{"type_bd":type_bd},  function(json){
          for(var i = 0; i < json.saia.length; i++){
           var id=json.saia[i].id ;
           var name =json.saia[i].credentialsName;
           addAt(credentials_type_id,name,id,1);
            }
        });  
    }
    //为select添加option
      function addAt(selectCtl,optionValue,optionText,position){
         var userAgent = window.navigator.userAgent;
        if (userAgent.indexOf("MSIE") > 0) {
             var option = document.createElement("option");
             option.innerText = optionValue;
             option.value = optionText;
             selectCtl.insertBefore(option, selectCtl.options[position]);
         }else{
        selectCtl.insertBefore(new Option(optionValue, optionText), selectCtl.options[position]);
        }
    } 
//选择框后续处理方法
    function rtnFunc(arg)
    {
      var lookup = $id("certificateSpecialistID");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    function rtnFuncCS(arg)
    {
         var lookup = $id("lk_cs");
	     lookup.value = arg[0];
	     lookup.displayValue = arg[1];
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
        jQuery.ajax({
		                     url:"<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailPartyCredentialsTran&id="+ids,
		                     type: 'POST',
		                     dataType: 'html',
		                     async: false,
		                     cache:false,
		                     timeout: 10000,
		                     success: function(data)
		                         {        
                                          var x =screen.width;
                                          var y =screen.height;
		                                   data= eval("("+data+")");
		                                   if(data.status=='true')
		                                   {
		                                       var url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=findCredentialsTran&id=" + ids;
                                                window.open(url,'',"width="+(x-18)+",height="+ (y-75) +",top =0,left=0,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");
		                                      
		                                   }
		                                   else
		                                   {
		                                      alert("很抱歉，您无法操作此单据");
		                                   }
		                         }
                             });
       	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMultiCredentialsTran";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
        var url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=insertPageFilter";
        var x =screen.width;
        var y =screen.height;
        window.open(url,'',"width="+(x-18)+",height="+ (y-75) +",top =0,left=0,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=证件办理材料新增");
	}
   function toAddBat_onClick() {  //到批量增加记录页面
       var url="<%=request.getContextPath()%>/jsp/faerp/certificate/certificateTransaction/insertCredentialsTranBat.jsp";
       var x =screen.width;
       var y =screen.height;
       window.open(url,'',"width="+(x-18)+",height="+ (y-75) +",top =0,left=0,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=证件办理材料新增");
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
		 var x =screen.width;
         var y =screen.height;
		var url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=detailCredentialsTran&id=" + ids;
        window.open(url,'',"top =0,left=0,width="+(x-18)+",height="+ (y-75) +",help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");
	}
//-------------------------------
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' id='temp_checkbox_template' value='"+value+"' >";
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
    //导入
   function import_onClick() {
        vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/certificate/certificateTransaction/importFile.jsp", "", "dialogWidth=600px; dialogHeight=250px");
        jQuery("#button_ok").click();
    }
    
    function checkValidDate() {
        var entity = $id("datacell1").activeEntity;
        //证件办理大类
        var credentialsType = entity.getProperty('credentialsTypeBdID');
        //证件小类
        var cardTranTypeName = entity.getProperty('cardTranTypeName');
         //var datacell1 = $id("datacell1");
         //var dataset1 = datacell1.dataset;//取得页面的datacell
         //alert(credentialsType);
         alert(cardTranTypeName);
         if (credentialsType != '16' && cardTranTypeName != '录入') {
            alert('不允许修改有效日期！');
            alert($id("validDate"));
            return false;
         }
    }
    
    //保存有效日期 by liangyixiong 20150421
    function save_validDate_onClick() {
        var ids = findSelections2("checkbox_template","id"); 
        if (ids == null || ids == "") {
            alert('请勾选需要保存的证件办理信息！');
            return false;
        }
        /*
        var key_value = new Array()
        for (var i = 0; i < ids.length; i++) {
             var enCurEntity = $id("datacell1").dataset.get(i);
             key_value.push(enCurEntity.getProperty("id") + ':' + enCurEntity.getProperty("validDate"));
        }
        */
        jQuery.getJSON("/FAERP/CertificateTransactionAction.do?cmd=saveValidDate"  +"&ids=" + ids, { random: Math.random() },function(json){
        alert(json.returnString);
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        });
    }
    
    function findSelections2(checkboxName, idName) {  //从列表中找出选中的id值列表
        var dc = $id("datacell1");
        var ds = dc.dataset;
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                var row = dc.table.tBodies[0].rows[i];
                var entity = dc.getEntity(row);
                ids.push(entity.getProperty("id") + ':' + entity.getProperty("validDate"));  //加入选中的checkbox
            }
        }
        return ids;
    }
    
    //导出查询数据
    function exp_onClick() {
        form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do";
        form.cmd.value = "exportCredentialsTran";
        form.submit();
    }
    
    //证件查询数据导入
    function import_searchData_onClick() {
        vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/certificate/certificateTransaction/importSearchDataFile.jsp", "", "dialogWidth=600px; dialogHeight=250px");
        if (vReturnValue == '1') {
            jQuery("#button_ok").click();
        }
    }
    
    //查看证件办理有效日期导入错误信息
    function view_impData_error_onClick() {

 //       var url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=viewImpDataErrorMsg";
  //      var x =screen.width;
 //       var y =screen.height;
  //      window.open(url,'',"width="+(x-18)+",height="+ (y-75) +",top =0,left=0,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=证件办理有效日期导入错误信息查看");    
        
        form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do?";
        form.cmd.value = "viewImpDataErrorMsg";
        form.submit();
    }
</script>
	</head>
	<body>

	<form name="form" method="post" id="datacell_formid"
		action="<%=request.getContextPath()%>/CredentialsTypeAction.do">
	<input type="hidden" name="cmd" value="queryAll"> <input
		type="hidden" name="backFlag" id="backFlag" value="true"> <input
		type="hidden" name="company_id" id="company_id"
		value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">

	<div id="right"><script language="javascript">
	writeTableTopFesco("<fmt:message key='cardTran'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">


	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">


		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key='Query_conditions' /></div>
			</td>
			<td />
			<td />
			<td></td>
			<td />
		</tr>
		<tr>
			<td align="right"><fmt:message key='identity' /></td>
			<td align="left">
			     <input type="text" class="text_field" name="employeeNumber" inputName="唯一号" maxLength="50"/>
			</td>
			</td>
			<td align="right"><fmt:message key='employeeName' /></td>
			<td align="left">
			     <input type="text" class="text_field" name="employeeName" inputName="员工姓名" maxLength="50"/>
			</td>
			 <td align="right"><fmt:message key='employeeCardNumber' /></td>
            <td align="left">
                 <input type="text" class="text_field" name="employeeCardNumber" inputName="证件号码" maxLength="50"/>
            </td>
		</tr>
		<tr>
            <td align="right"><fmt:message key='customerNumber' /></td>
            <td align="left">
                 <input type="text" class="text_field" name="companyNumber" inputName="客户编号" maxLength="50"/>
            </td>
            </td>
            <td align="right"><fmt:message key='customerName' /></td>
            <td align="left">
                 <input type="text" class="text_field" name="companyName" inputName="客户名称" maxLength="50"/>
            </td>
             <td align="right"><fmt:message key='certificateSpecialist' /></td>
            <td align="left">
                 <w:lookup name="certificateTranSpecialist"  onReturnFunc="rtnFunc" id="certificateSpecialistID"  lookupUrl="/CertificateTransactionAction.do?cmd=getCertificateSpecialistPage&personnelCategory=0"  messagekey="choose_certificateSpecialist" height="440"  width="550" style="width:187px" />
            </td>
        </tr>
        <tr>
             <td align="right"><fmt:message key='cardTranTypeBD'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("credentialsTypeBdID", -1, "CREDENTIALS_TYPE", "", " id='credentialsTypeBdID' onchange=\"findType()\"'", false)%>    
            </td>
             <td align="right"><fmt:message key='credentials_name'/></td>
            <td align="left">
               <select name="cardTranType" id="cardTranType">
                        <option value=""><fmt:message key="please_choose" /></option>
                    </select>
            </td>
            <td align="right"><fmt:message key='tranState'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("tranState", -1, "BILLS_STATUS", "", " id='tranState' ", false)%>    
            </td>
        </tr>
        <tr>
            </td>
        </tr>
		<tr>
		<td align="right"><fmt:message key='customerService' /></td>
            <td align="left">
                 <w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" name="commitPersonId" lookupUrl="/CustServiceAction.do?cmd=toCustService" messagekey="choose_customerService" width="450" height="440"  style="width:187px" />
            </td>
			<td colspan="4" style="text-align: center;">
				<input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"> 
				<input	name="button_reset" class="icon_1" type="button" 	value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
			</td>
		</tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
		<input class="a" type="button" onClick="javascript:detail_onClick();" value="<fmt:message 	key="view" />"<au:authorityBtn code="view_CredentTran" type="1"/> >
		<input class="c" type="button" onClick="javascript:toAdd_onClick();" value="<fmt:message	key="insert" /> "<au:authorityBtn code="insert_CredentTran" type="1"/>>
		<input class="b" type="button" onClick="javascript:findCheckbox_onClick();" value="<fmt:message	key="tran"/>"<au:authorityBtn code="modify_CredentTran" type="1"/>>
		 <input class="a" style="width: 95px;background-repeat:no-repeat\9; background-image:none\9;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%=request.getContextPath()%>/images/fesco/button_a.gif', sizingMethod='scale')\9;"  type="button" onClick="javascript:toAddBat_onClick();" value="<fmt:message    key="addBat"/>"<au:authorityBtn code="addBat_CredentTran" type="1"/>>
		<input class="d" type="button" onClick="javascript:deleteMulti_onClick();" value="<fmt:message   key="delete"/>"<au:authorityBtn code="delete_CredentTran" type="1"/>>
		<input class="p_1" type="button" id="import_file" onclick="import_onClick();" value="<fmt:message   key="import_file"/>"<au:authorityBtn code="export_CredentTran" type="1"/>>
		<input class="g_1" type="button" id="save_validDate" onclick="save_validDate_onClick();" value="保存有效期"<au:authorityBtn code="save_CredentTran_validDate" type="1"/>>
		<input class="p_1" type="button" id="export_searchData" onclick="exp_onClick();" value="导出查询数据"<au:authorityBtn code="export_ct_data" type="1"/>>
		<input class="p_1" type="button" id="import_searchData" onclick="import_searchData_onClick();" value="导入查询数据"<au:authorityBtn code="import_ct_data" type="1"/>>
        <input class="a_4" type="button" id="view_impData_error" onclick="view_impData_error_onClick();" value="查看有效日期导入错误"<au:authorityBtn code="view_ct_error_msg" type="1"/>>
		
	</div>
	<div class="clear"></div>
	</div>



	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction="/FAERP/CertificateTransactionAction.do?cmd=simpleQueryCredentialsTran"
		width="98%" height="303px" xpath="CredentialsTranVO"
		paramFormId="datacell_formid" readonly="true">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field allowModify="false" fieldName="id" messagekey="Operation" width="35px" onRefreshFunc="setCheckboxStatus" align="center"></r:field>
		<r:field fieldName="employeeName"	messagekey="employeeName" width="60px"></r:field>
		<r:field fieldName="employeeNumber" messagekey="identity" width="55px"></r:field>
		<r:field fieldName="employeeCardNumber" messagekey="employeeCardNumber" width="130px"></r:field>
		<r:field fieldName="companyNumber"  messagekey="companyNumber" width="80px"></r:field>
        <r:field fieldName="companyName"  messagekey="companyName" width="300px"></r:field>
        <r:field fieldName="commitPersonName"  messagekey="customerService" width="80px"></r:field>
        <r:field fieldName="credentialsTypeBdID"  messagekey="cardTranTypeBD" width="100px">
            <d:select dictTypeId="CREDENTIALS_TYPE"/>
        </r:field>
        <r:field fieldName="cardTranTypeName"  messagekey="credentials_name" width="100px"></r:field>
        <r:field fieldName="certificateTranSpecialistName"  messagekey="certificateTranSpecialist" width="85px"></r:field>
        <r:field fieldName="tranState"  messagekey="tranState" width="120px">
             <d:select dictTypeId="BILLS_STATUS"/>
        </r:field>
        <r:field fieldName="validDate" label="有效日期"  messagekey="validDate" width="120px" allowModify="true"><!--onRefreshFunc="checkValidDate" -->
            <w:date format="yyyy-MM-dd" value=""/>    <!--onchange="checkValidDate();"
        <h:text name="salary" value="" onblur="batch_blue('validDate');"/> -->
        </r:field>
        <r:field fieldName="state"  messagekey="state" width="80px">
            <d:select dictTypeId="POST_STATUS_BD"/>
        </r:field>
	</r:datacell></div>
	   <!--翻页 end--> 
	   <div class="box_2" <au:authorityBtn code="saveBat_tranTran" type="1"/>>
    <div class="xz_title"><fmt:message key="new_certificateSpecialist"/></div>
    <table width="100%" height="76" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1"><fmt:message key="new_certificateSpecialist"/></td>
            <td class="td_2"><w:lookup name="newUser"
                onReturnFunc="rtnFuncNew" id="newUser"
                lookupUrl="/CertificateTransactionAction.do?cmd=getCertificateSpecialistPage"
                messagekey="choose_certificateSpecialist" height="440" width="600"
                style="width:170px" />
            </td>
        </tr>
        <tr>
            <td colspan="4" class="td_2" colspan=4>
            <center><span class="mx_button"> <input name="button1"
                type="button" class="icon_2" value="<fmt:message key="save"/>"  onclick="changeSave()" /> <input type="reset" class="icon_1"  /></span></center>
            </td>

        </tr>
    </table>
    <br>
    <div class="mx_button"></div>
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

$id("datacell1").beforeRefreshCell = function(cell,field){
        //if(field && field.fieldId && field.fieldId.indexOf("id") >= 0)
        if(field && field.fieldName && field.fieldName.indexOf("id") >= 0 && field.fieldName.indexOf("validDate") < 0) {
            return false;
        }
        return true;
    } 
</script>
