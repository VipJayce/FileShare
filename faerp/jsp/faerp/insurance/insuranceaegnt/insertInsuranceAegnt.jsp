<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="rayoo.insurance.insuranceaegnt.vo.InsuranceAegntVo" %>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>
<%@ page import="rayoo.insurance.insuranceaegnt.util.IInsuranceAegntConstants" %>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<%@ page import="gap.rm.tools.helper.RmUploadHelper" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	InsuranceAegntVo resultVo = null;  //定义一个临时的vo变量
    AttachmentfileVo avo=null;//附件VO    
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IInsuranceAegntConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (InsuranceAegntVo)request.getAttribute(IInsuranceAegntConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
		if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
            avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
        }
	}
	String attachName = avo==null?"":avo.getAttachment_file_name().toString();
    String attachAddress = avo==null?"":avo.getAttachment_file_path().toString();
    String attachId = avo==null?"":avo.getId().toString();
    String agentcode = request.getAttribute("agentcode")==null?"":request.getAttribute("agentcode").toString();
%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据	
	    if(checkAllForms()){	    
		    var sales_tel=document.form.sales_tel.value;
	        var sales_mobile=document.form.sales_mobile.value;
	        var sales_email=document.form.sales_email.value;
	        var validity_str = document.form.validity_str.value;
            var validity_end = document.form.validity_end.value;
	        var isTelephone=/^((0\d{2,3})-)(\d{7,8})+(-(\d{3,}))?$/;
	        var isMobile=/^1[358]\d{9}$/;
	        var isEmail=/^[a-z]([a-z0-9]*[-_]?[a-z0-9]+)*@([a-z0-9]*[-_]?[a-z0-9]+)+[\.][a-z]{2,3}([\.][a-z]{2})?$/i;
	        if(!isTelephone.test(sales_tel)&&sales_tel!=""&&sales_tel!=null){
	           alert("请输入正确的电话号码！");
	           document.form.sales_tel.focus();
	           return;
	        }
	        if(!isMobile.test(sales_mobile)&&sales_mobile!=""&&sales_mobile!=null){
	           alert("请输入正确的手机号码！");
	           document.form.sales_mobile.focus();
	           return;
	        }
	        if(!isEmail.test(sales_email)&&sales_email!=""&&sales_email!=null){
	           alert("请输入正确的邮箱地址！");
	           document.form.sales_email.focus();
	           return;
	        }
	        if(validity_str!=null&&validity_str.trim().length!=0){
		        if(validity_end!=null&&validity_end.trim().length!=0){
		           var beginTime =validity_str.trim();
		           var endTime = validity_end.trim();
		           var beginTimes=beginTime.substring(0,10).split('-');
		           var endTimes=endTime.substring(0,10).split('-');
		           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
		           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
		           if(beginTime>endTime){
		               alert("有效期限截止日期小于有效期限开始日期！");
		               return;
		           }
		       }
	       }
			var action="<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=insert";
            var myAjax = new Ajax(action);
            myAjax.addParam('agent_code', document.form.agent_code.value);
            myAjax.addParam('agent_name', document.form.agent_name.value);
            myAjax.addParam('agent_address', document.form.agent_address.value);
            myAjax.addParam('sales_man', document.form.sales_man.value);
            myAjax.addParam('sales_tel', sales_tel);
            myAjax.addParam('sales_mobile', sales_mobile);
            myAjax.addParam('sales_email', sales_email);
            myAjax.addParam('opening_bank', document.form.opening_bank.value);
            myAjax.addParam('account', document.form.account.value);
            myAjax.addParam('bq_validity', document.form.bq_validity.value);
            myAjax.addParam('lp_validity', document.form.lp_validity.value);
            myAjax.addParam('td_validity', document.form.td_validity.value);
            if(document.getElementById('insurance_agent_type').value!='2'){
                myAjax.addParam('security_agent_type', document.getElementById('security_agent_type').value);
            }
            myAjax.addParam('channel_type_bd', document.getElementById('channel_type_bd').value);
            myAjax.addParam('insurance_agent_type', document.getElementById('insurance_agent_type').value);
            myAjax.addParam('economic_cust', document.form.economic_cust.value);
            if(document.getElementsByName('is_valid').length>0){
		       for(var i = 0;i<document.getElementsByName('is_valid').length;i++){
		          if(document.getElementsByName('is_valid')[i].checked){
		              myAjax.addParam('is_valid', document.getElementsByName('is_valid')[i].value);
		          }
		       }
		    }            
            myAjax.addParam('validity_str', validity_str);
            myAjax.addParam('validity_end', validity_end);
            myAjax.addParam('attach_name', document.form.attach_name.value);
            myAjax.addParam('attach_address', document.form.attach_address.value);
            myAjax.addParam('remark', document.form.remark.value);
            myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
             }
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		if(checkAllForms()){
	        var sales_tel=document.form.sales_tel.value;
	        var sales_mobile=document.form.sales_mobile.value;
	        var sales_email=document.form.sales_email.value;
	        var validity_str = document.form.validity_str.value;
            var validity_end = document.form.validity_end.value;
	        var isTelephone=/^((0\d{2,3})-)(\d{7,8})+(-(\d{3,}))?$/;
	        var isMobile=/^1[358]\d{9}$/;
	        var isEmail=/^[a-z]([a-z0-9]*[-_]?[a-z0-9]+)*@([a-z0-9]*[-_]?[a-z0-9]+)+[\.][a-z]{2,3}([\.][a-z]{2})?$/i;
	        if(!isTelephone.test(sales_tel)&&sales_tel!=""&&sales_tel!=null){
	           alert("请输入正确的电话号码！");
	           document.form.sales_tel.focus();
	           return;
	        }
	        if(!isMobile.test(sales_mobile)&&sales_mobile!=""&&sales_mobile!=null){
	           alert("请输入正确的手机号码！");
	           document.form.sales_mobile.focus();
	           return;
	        }
	        if(!isEmail.test(sales_email)&&sales_email!=""&&sales_email!=null){
	           alert("请输入正确的邮箱地址！");
	           document.form.sales_email.focus();
	           return;
	        }
	        if(validity_str!=null&&validity_str.trim().length!=0&&validity_end!=null&&validity_end.trim().length!=0){
	           var beginTime =validity_str.trim();
	           var endTime = validity_end.trim();
	           var beginTimes=beginTime.substring(0,10).split('-');
	           var endTimes=endTime.substring(0,10).split('-');
	           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
	           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
	           if(beginTime>endTime){
	               alert("有效期限截止日期小于有效期限开始日期！");
	               return;
	           }
           }
	    	var action="<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=update";
            var myAjax = new Ajax(action);
            myAjax.addParam('agent_code', document.form.agent_code.value);
            myAjax.addParam('agent_name', document.form.agent_name.value);
            myAjax.addParam('agent_address', document.form.agent_address.value);
            myAjax.addParam('sales_man', document.form.sales_man.value);
            myAjax.addParam('sales_tel', sales_tel);
            myAjax.addParam('sales_mobile', sales_mobile);
            myAjax.addParam('sales_email', sales_email);
            myAjax.addParam('opening_bank', document.form.opening_bank.value);
            myAjax.addParam('account', document.form.account.value);
            myAjax.addParam('bq_validity', document.form.bq_validity.value);
            myAjax.addParam('lp_validity', document.form.lp_validity.value);
            myAjax.addParam('td_validity', document.form.td_validity.value);
            if(document.getElementById('insurance_agent_type').value!='2'){
                myAjax.addParam('security_agent_type', document.getElementById('security_agent_type').value);
            }
            myAjax.addParam('channel_type_bd', document.getElementById('channel_type_bd').value);
            myAjax.addParam('insurance_agent_type', document.getElementById('insurance_agent_type').value);
            myAjax.addParam('economic_cust', document.form.economic_cust.value);
            if(document.getElementsByName('is_valid').length>0){
               for(var i = 0;i<document.getElementsByName('is_valid').length;i++){
                  if(document.getElementsByName('is_valid')[i].checked){
                      myAjax.addParam('is_valid', document.getElementsByName('is_valid')[i].value);
                  }
               }
            }                
            myAjax.addParam('validity_str', document.form.validity_str.value);
            myAjax.addParam('validity_end', document.form.validity_end.value);
            myAjax.addParam('attach_name', document.form.attach_name.value);
            myAjax.addParam('attach_address', document.form.attach_address.value);
            myAjax.addParam('attach_id', document.form.attach_id.value);
            myAjax.addParam('remark', document.form.remark.value);
            myAjax.addParam('company_id',document.form.company_id.value);
            myAjax.addParam('create_date',document.form.create_date.value);
            myAjax.addParam('create_user',document.form.create_user.value);
            myAjax.addParam('id', document.form.id.value);
            myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
             }
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function change_type(obj){    
        if(obj.value=="2")
        {
            document.getElementById("sat_name").innerHTML = ' ';
            document.getElementById("sat_value").innerHTML = ' ';
        }
        else
        {
            document.getElementById("sat_name").innerHTML = '社保供应商类型';
            document.getElementById("sat_value").innerHTML = '<d:select dictTypeId="SECURITY_AGENT_TYPE" id="security_agent_type" property="bean/security_agent_type" />';
        }
    }
    
    //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2; 
        var t = (screen.height - h) / 2; 
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<!--<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('修改保险供应商','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('新增保险供应商','<%=request.getContextPath()%>/');
</script> 
 --><div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="25%"><span class="style_required_red">* </span>供应商编号</td>
			<td class="td_2" width="25%">
				<input type="text" class="text_field" name="agent_code" inputName="供应商编号" value="<%=agentcode %>" maxLength="64" validate="notNull;" disabled="disabled"/>
			</td>
			<td class="td_1" width="25%"><span class="style_required_red">* </span>供应商名称</td>
			<td class="td_2" width="25%">
				<input type="text" class="text_field" name="agent_name" inputName="供应商名称" value="" maxLength="50" validate="notNull;"/>
			</td>
		</tr>
		<tr>
            <td class="td_1" >供应商地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="agent_address" inputName="供应商地址" value="" maxLength="75" />
            </td>
            <td class="td_1" >保险公司业务员</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="sales_man" inputName="保险公司业务员" value="" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >保险公司业务员电话</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="sales_tel" inputName="保险公司业务员电话" value="" maxLength="20" />
            </td>
            <td class="td_1" >保险公司业务员手机号码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="sales_mobile" inputName="保险公司业务员手机号码" value="" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >保险公司业务员邮箱地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="sales_email" inputName="保险公司业务员邮箱地址" value="" maxLength="64" />
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>供应商开户行</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="opening_bank" inputName="供应商开户行" value="" maxLength="64" validate="notNull;"/>
            </td>            
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>银行账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="account" inputName="银行账号" value="" maxLength="64" validate="notNull;"/>
            </td>
            <td class="td_1" >保全时效</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="bq_validity" inputName="保全时效" value="" maxLength="64" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >理赔时效</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="lp_validity" inputName="理赔时效" value="" maxLength="64" />
            </td>
            <td class="td_1" >退单时效</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="td_validity" inputName="退单时效" value="" maxLength="64" />
            </td> 
        </tr>
        <tr>
            <td class="td_1" >供应商类型</td>
            <td class="td_2 "><!-- 1保险供应商  2体检供应商 -->
                <d:select dictTypeId="INSURANCE_AGENT_TYPE" id="insurance_agent_type" property="bean/insurance_agent_type" onchange="javascrpt:change_type(this)" />
            </td>
            <td class="td_1"  id="sat_name">保险供应商类型</td>
            <td class="td_2 " id="sat_value">
                <d:select dictTypeId="SECURITY_AGENT_TYPE" id="security_agent_type" property="bean/security_agent_type" />
            </td>
        </tr>
		<tr>			
			<td class="td_1" >渠道类型</td>
            <td class="td_2 ">
                <d:select dictTypeId="CHANNEL_TYPE_BD" id="channel_type_bd" property="bean/channel_type_bd" />
            </td>
            <td class="td_1" >&nbsp;</td>
            <td class="td_2 ">&nbsp;</td>
		</tr>		
		<tr>			
			<td class="td_1" >经纪公司</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="economic_cust" inputName="经纪公司" value="" maxLength="50" />
            </td>
            <td class="td_1" >是否有效</td>
            <td class="td_2 ">
                <d:radio dictTypeId="TrueOrFalse"  property="bean/is_valid" id="is_valid" name="is_valid" value="1"/>
            </td>
		</tr>		
		<tr>
		    <td class="td_1">有效期限开始日期</td>
            <td class="td_2"><w:date format="yyyy-MM-dd" id="validity_str" name="validity_str" property="bean/validity_str" width="189px"/> </td>
            <td class="td_1">有效期限截止日期</td>
            <td class="td_2"><w:date format="yyyy-MM-dd" id="validity_end" name="validity_end" property="bean/validity_end" width="189px"/></td>
		</tr>
		<tr>
			<td class="td_1" >上传附件</td>
			<td class="td_2" colspan="3">
                <input type="text" id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachName)%>" hiddenInputId="attach_name"/><img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
                <input type="hidden" id="attackAddressInput" name="attach_address" value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachAddress)%>">
                <span><% if(isModify&&avo!=null)out.print("<a href='"+request.getContextPath()+"/InsuranceAegntAction.do?cmd=downLoad&annex="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");%>&nbsp;</span>
			</td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" rows="2" name="remark" inputName="备注" maxLength="1000" style="width:80%"></textarea>
			</td>
		</tr>
	</table>
</div>
    <div class="mx_button" align="center">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div></div> 
            
<input type="hidden" name="id">
<input type="hidden" name="attach_id" value="<%=attachId %>">
<input type="hidden" name="company_id">
<input type="hidden" name="create_date">
<input type="hidden" name="create_user">

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
var insurance_agent_type = document.getElementById("insurance_agent_type").value;
        if(insurance_agent_type == "2"){
            document.getElementById("sat_name").innerHTML = ' ';
            document.getElementById("sat_value").innerHTML = ' ';
        }
</script>
