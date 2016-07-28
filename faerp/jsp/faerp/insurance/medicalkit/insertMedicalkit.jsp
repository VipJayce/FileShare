<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.medicalkit.vo.MedicalkitVo" %>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>
<%@ page import="rayoo.insurance.medicalkit.util.IMedicalkitConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	MedicalkitVo resultVo = null;  //定义一个临时的vo变量
	AttachmentfileVo avo=null;//附件VO    
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	String cust_name = "";
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IMedicalkitConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (MedicalkitVo)request.getAttribute(IMedicalkitConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		    cust_name = request.getAttribute("custName").toString();
  		}
		if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
            avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
        }
	}
	String attachName = avo==null?"":avo.getAttachment_file_name().toString();
    String attachAddress = avo==null?"":avo.getAttachment_file_path().toString();
    String attachId = avo==null?"":avo.getId().toString();
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
	        var isMonery=/^[0-9]+\.{0,1}[0-9]{0,2}$/;
            var medicine_value = document.form.medicine_value.value;     //药品价值
            var medicine_cost = document.form.medicine_cost.value;   //药品成本
            if(!isMonery.test(medicine_value)){
               alert("请输入正确的药品价值，不能为空！");
               document.form.medicine_value.focus();
               return;
            }
            if(!isMonery.test(medicine_cost)){
               alert("请输入正确的药品成本，不能为空！");
               document.form.medicine_cost.focus();
               return;
            }
			//form.action="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=insert";
			//form.submit();
			
            var action="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=insert";
            var myAjax = new Ajax(action);
            myAjax.addParam('cust_id', document.form.cust_id.value);
            myAjax.addParam('medicine_attributes', document.form.medicine_attributes.value);
            myAjax.addParam('medicine_value', medicine_value);
            myAjax.addParam('medicine_cost', medicine_cost);
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
		    var isMonery=/^[0-9]+\.{0,1}[0-9]{0,2}$/;
            var medicine_value = document.form.medicine_value.value;     //药品价值
            var medicine_cost = document.form.medicine_cost.value;   //药品成本
            if(!isMonery.test(medicine_value)){
               alert("请输入正确的药品价值，不能为空！");
               document.form.medicine_value.focus();
               return;
            }
            if(!isMonery.test(medicine_cost)){
               alert("请输入正确的药品成本，不能为空！");
               document.form.medicine_cost.focus();
               return;
            }
		    //form.action="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=update";
	    	//form.submit();
	    	var action="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=update";
            var myAjax = new Ajax(action);
            myAjax.addParam('cust_id', document.form.cust_id.value);
            myAjax.addParam('medicine_attributes', document.form.medicine_attributes.value);
            myAjax.addParam('medicine_value', medicine_value);
            myAjax.addParam('medicine_cost', medicine_cost);
            myAjax.addParam('attach_name', document.form.attach_name.value);
            myAjax.addParam('attach_address', document.form.attach_address.value);
            myAjax.addParam('remark', document.form.remark.value);
            myAjax.addParam('attachment_id', document.form.attachment_id.value);
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
        //form.action="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=queryAll&backFlag=false";
        //form.submit();
        window.close();
    }
    
    function getcustomerList(){
        var ids = window.showModalDialog('<venus:base/>/CustomerAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.cust_id.value=ids[0];
        document.form.customer_name.value=ids[1];
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
    
    function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        jQuery("#customer_name").val(arg[2]);
        return false;
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right" style="height: 195px;">
<div id="ccChild1"   style="height: 185px;"   class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" ><span style="color: red;">*</span>客户名称</td>
			<td class="td_2 ">
                 <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" displayValue="<%=cust_name %>" readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition&Medicalkit=true" dialogTitle="选择客户" height="500" width="810"/>
                <input type="hidden" name="customer_name" id="customer_name"/>
                <input type="hidden" name="cust_id" id="cust_id"/>
			</td>
			<td class="td_1" >药箱属性</td>
			<td class="td_2" ><d:select dictTypeId="MEDICINE_ATTRIBUTES" id="medicine_attributes" name="medicine_attributes" property="medicine_attributes" /></td>
		</tr>
		<tr>
			<td  class="td_1" ><span style="color: red;">*</span>药品价值</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="medicine_value" inputName="药品价值" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td  class="td_1" ><span style="color: red;">*</span>药品成本</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="medicine_cost" inputName="药品成本" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
		</tr>
		<tr>
	        <td class="td_1">添加附件</td>
	        <td class="td_2" colspan="3">	        
	        <input type="text" id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachName)%>" hiddenInputId="attach_name"/><img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
                <input type="hidden" id="attackAddressInput" name="attach_address" value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachAddress)%>">
                <span><% if(isModify&&avo!=null)out.print("<a href='"+request.getContextPath()+"/MedicalkitAction.do?cmd=downLoad&attachment_id="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");%>&nbsp;</span>
	        </td>  
        </tr>
		<tr>
			<td class="td_1">备注</td>			
			<td colspan="3" class="td_2"><textarea class="textarea_limit_words" cols="60" rows="3" name="remark" inputName="备注" maxLength="1000" ></textarea></td>
		</tr>
	</table>
    <div class="mx_button" style="margin: 10px 0px 0px 10px;" align="center">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div></div>
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />
<input type="hidden" name="create_user"/>
<input type="hidden" name="company_id" />
<input type="hidden" name="attachment_id" value="<%=attachId %>">

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
