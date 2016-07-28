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
	   jQuery(document).ready(function()
    {
       $id("datacell1").isQueryFirst = false;
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
	function toAdd_onClick() {  //到续办申请页面
	   var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
	      if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/jsp/faerp/certificate/certificateTransaction/insertCardContinueBat.jsp?ids="+ids;
             var x =screen.width;
         var y =screen.height;
          jQuery.ajax({
                             url:"<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataContinue&operate=0&id="+ids,
                             type: 'POST',
                             dataType: 'html',
                             async: false,
                             cache:false,
                             timeout: 10000,
                             success: function(data)
                                 {        
                                           data=eval("("+data+")");
                                             if(data.status=='true')
                                           {
                                               window.open(url,'',"width="+(x-18)+",height="+ (y-75) +",top =0,left=0,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=续办申请");         
                                           }
                                           else
                                           {
                                              alert(data.message);
                                           }
                                 }
                             });
       
	}
   function toAddBat_onClick() {  //到无需续办页面
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
      if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
         var url="<%=request.getContextPath()%>/jsp/faerp/certificate/certificateTransaction/updateCardContinue.jsp?ids="+ids;
         jQuery.ajax({
                             url:"<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataContinue&operate=1&id="+ids,
                             type: 'POST',
                             dataType: 'html',
                             async: false,
                             cache:false,
                             timeout: 10000,
                             success: function(data)
                                 {        
                                           data=eval("("+data+")");
                                             if(data.status=='true')
                                           {
                                               window.open(url,'','height=170px,width=950px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=无需续办');
                                           }
                                           else
                                           {
                                              alert(data.message);
                                           }
                                 }
                             });
    }
    
//-------------------------------
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
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
	<input type="hidden" name="cmd" value="queryAll"/>
	<input type="hidden" name="backFlag" id="backFlag" value="true">
	<input	type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">

	<div id="right"><script language="javascript">
	writeTableTopFesco("<fmt:message key='continueTran'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
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
			 <td align="right"><fmt:message key='continueState'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_vaild", -1, "CONTINUE_MARK", "", " id='tranState' ", false)%>    
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
                 <w:lookup name="certificateTranSpecialist"  onReturnFunc="rtnFunc" id="certificateSpecialistID"  lookupUrl="/CertificateTransactionAction.do?cmd=getCertificateSpecialistPage"  messagekey="choose_certificateSpecialist" height="440"  width="550" style="width:187px" />
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
           
        </tr>
        <tr>
            </td>
        </tr>
		<tr>
			<td colspan="6" style="text-align: center;">
				<input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"> 
				<input	name="button_reset" class="icon_1" type="button" 	value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
			</td>
		</tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
		<input class="c" type="button" onClick="javascript:toAdd_onClick();" value="<fmt:message	key="continue" /> "<au:authorityBtn code="continue_CredTran" type="1"/>>
		 <input class="g" style="width: 95px;background-repeat:no-repeat\9; background-image:none\9;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%=request.getContextPath()%>/images/fesco/button_f.gif', sizingMethod='scale')\9;"  type="button" onClick="javascript:toAddBat_onClick();" value="<fmt:message    key="notContinue"/>"<au:authorityBtn code="notContinue_CredTran" type="1"/>>
	</div>
	<div class="clear"></div>
	</div>



	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction="/FAERP/CertificateTransactionAction.do?cmd=simpleQueryCredContinue"
		width="98%" height="303px" xpath="CredentialsTranExcelSimpleVo"
		paramFormId="datacell_formid" readonly="true">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="ID" messagekey="Operation" width="35px" onRefreshFunc="setCheckboxStatus" align="center"></r:field>
		<r:field fieldName="employeeName"	messagekey="employeeName" width="60px"></r:field>
		<r:field fieldName="employeeNumber" messagekey="identity" width="55px"></r:field>
		<r:field fieldName="employeeCardNumber" messagekey="employeeCardNumber" width="130px"></r:field>
		<r:field fieldName="companyNumber"  messagekey="companyNumber" width="60px"></r:field>
        <r:field fieldName="companyName"  messagekey="companyName" width="290px"></r:field>
        <r:field fieldName="userName"  messagekey="customerService" width="50px"></r:field>
        <r:field fieldName="credentialsTypeBdID"  messagekey="cardTranTypeBD" width="100px">
            <d:select dictTypeId="CREDENTIALS_TYPE"/>
        </r:field>
        <r:field fieldName="employeeEntryType" messagekey="employeeEntryType" width="90px">
        </r:field>
        <r:field fieldName="cardTranTypeName"  messagekey="credentials_name" width="80px"></r:field>
        <r:field fieldName="validDate"  messagekey="validDate" width="70px">
            <w:date format="yyyy-MM-dd"/>
        </r:field>
        <r:field fieldName="state"  messagekey="state" width="60px">
            <d:select dictTypeId="EMP_STATUS"/>
        </r:field>
        <r:field fieldName="is_vaild"  messagekey="continueState" width="60px">
            <d:select dictTypeId="CONTINUE_MARK"/>
        </r:field>
        <r:field fieldName="certificateTranSpecialistName"  messagekey="certificateTranSpecialist" width="85px"></r:field>
        <r:field fieldName="explain"  messagekey="explain" width="240px">
        </r:field>
	</r:datacell></div>
	   <!--翻页 end--> 
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
