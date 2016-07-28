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
<fmt:bundle basename="rayoo.certificate.workTimeApply.workTimeApply_resource_zh"    prefix="rayoo.certificate.workTimeApply.">
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
    //选择框后续处理方法
    function rtnFunc(arg)
    {
      var lookup = $id("empOrResigSpecialistID");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
	//办理证件类别、办理证件小类联动
   function findType(){
        var credentials_type_id = document.getElementById('tranType');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('applyType').value;
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
		                     url:"<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=vailPartyWorkTimeApply&id="+ids,
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
		                                       var url="<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=findWorkTimeApply&id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/WorkTimeApplyAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMultiWorkTimeApply";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
	if( jQuery("#vailDate1:hidden").length!=0&&jQuery("#vailDate2:hidden").length!=0){
	    	$id("datacell1").loadData();
	        $id("datacell1").refresh();
      }
      else
      {
          alert("年月格式不正确");
      }
  	}
	function toAdd_onClick() {  //到增加记录页面
       var url="<%=request.getContextPath()%>/jsp/faerp/certificate/workTimeApply/insertWorkTimeApply.jsp";
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
		var url="<%=request.getContextPath()%>//WorkTimeApplyAction.do?cmd=detailWorkTimeApply&id=" + ids;
        window.open(url,'',"top =0,left=0,width="+(x-18)+",height="+ (y-75) +",help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");
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
    
    function vailDate(arg)
    {
       var reg=/^[12]\d{3}(0\d|1[0-2])$/;
	   var approveDateLimtedFrom= jQuery("#approveDateLimtedFrom").val();
	   var approveDateLimtedTo=jQuery("#approveDateLimtedTo").val();
	    if((approveDateLimtedFrom!=''&&!approveDateLimtedFrom.match(reg))||(approveDateLimtedTo!=''&&!approveDateLimtedTo.match(reg)))
	    {
	        jQuery("#vailDate1").show();
	    }
	    else
	    {
	        jQuery("#vailDate1").hide();
	    }
	   var acceptDateFrom= jQuery("#acceptDateFrom").val();
       var acceptDateTo=jQuery("#acceptDateTo").val();
        if((acceptDateFrom!=''&&!acceptDateFrom.match(reg))||(acceptDateTo!=''&&!acceptDateTo.match(reg)))
        {
            jQuery("#vailDate2").show();
        }
        else
        {
            jQuery("#vailDate2").hide();
        }
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
	writeTableTopFesco("<fmt:message key='workTimeApply'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
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
            <td align="right"><fmt:message key='companyNumber' /></td>
            <td align="left">
                 <input type="text" class="text_field" name="companyNumber" inputName="客户编号" maxLength="50"/>
            </td>
            </td>
            <td align="right"><fmt:message key='companyName' /></td>
            <td align="left">
                 <input type="text" class="text_field" name="companyName" inputName="客户名称" maxLength="50"/>
            </td>
             <td align="right"><fmt:message key='empOrResigSpecialist' /></td>
            <td align="left">
                 <w:lookup name="empOrResigSpecialistID"  onReturnFunc="rtnFunc" id="empOrResigSpecialistID"  lookupUrl="/WorkTimeApplyAction.do?cmd=getEmpOrResigSpecialistPage"  messagekey="choose_empOrResigSpecialist" height="440"  width="550" style="width:187px" />
            </td>
        </tr>
        <tr>
             <td align="right"><fmt:message key='applyType'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("applyType", -1, "WORK_TIME_SELECT", "", " id='applyType' onchange=\"findType()\"'", false)%>    
            </td>
             <td align="right"><fmt:message key='tranType'/></td>
            <td align="left">
               <select name="tranType" id="tranType">
                        <option value=""><fmt:message key="please_choose" /></option>
                    </select>
            </td>
            <td align="right"><fmt:message key='tranState'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("tranState", -1, "WORKTIME_STATUS", "", " id='tranState' ", false)%>    
            </td>
        </tr>
        <tr>
        <td align="right"><fmt:message key='customerService' /></td>
         <td align="left">
              <w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" name="create_user_id" lookupUrl="/CustServiceAction.do?cmd=toCustService" messagekey="choose_customerService" width="450" height="440"  style="width:187px" />
         </td>
          <td align="right"><fmt:message key='approveDateLimted' /></td>
         <td align="left" colspan="3">
              <input type="text"   name="approveDateLimtedFrom" id="approveDateLimtedFrom"  style="width=90px" onblur="vailDate(this);" maxlength="6"/>  至<input type="text" id="approveDateLimtedTo"  name="approveDateLimtedTo"  style="width=90px" onblur="vailDate(this);" maxlength="6"/><fmt:message key='bill_year_month_tip_1'/><span  style="color:red;font-size:1.1em;display: none" id="vailDate1">年月格式不正确</span>
         </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key='commitDate' /></td>
         <td align="left" colspan="5">
              <input type="text"   name="acceptDateFrom" id="acceptDateFrom"  style="width=90px" onblur="vailDate(this);" maxlength="6"/>  至<input type="text" id="acceptDateTo"  name="acceptDateTo"  style="width=90px" onblur="vailDate(this);" maxlength="6"/><fmt:message key='bill_year_month_tip_1'/><span  style="color:red;font-size:1.1em;display: none" id="vailDate2">年月格式不正确</span>
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
		<input class="a" type="button" onClick="javascript:detail_onClick();" value="<fmt:message 	key="view" />"<au:authorityBtn code="view_WorkTime" type="1"/> >
		<input class="c" type="button" onClick="javascript:toAdd_onClick();" value="<fmt:message	key="insert" /> "<au:authorityBtn code="insert_WorkTime" type="1"/>>
		<input class="b" type="button" onClick="javascript:findCheckbox_onClick();" value="<fmt:message	key="modify"/>"<au:authorityBtn code="modify_WorkTime" type="1"/>>
		<input class="d" type="button" onClick="javascript:deleteMulti_onClick();" value="<fmt:message   key="delete"/>"<au:authorityBtn code="delete_WorkTime" type="1"/>>
	</div>
	<div class="clear"></div>
	</div>



	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction="/FAERP/WorkTimeApplyAction.do?cmd=simpleQueryWorkTimeApply"
		width="98%" height="303px" xpath="WorkTimeApplyVO"
		paramFormId="datacell_formid" readonly="true">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="id" messagekey="Operation" width="35px" onRefreshFunc="setCheckboxStatus" align="center"></r:field>
		<r:field fieldName="companyNumber"  messagekey="companyNumber" width="80px"></r:field>
        <r:field fieldName="companyName"  messagekey="companyName" width="300px"></r:field>
        <r:field fieldName="companyRegArear"  messagekey="companyRegArear" width="100px">
            <d:select dictTypeId="ACCEPTANCE"/>
        </r:field>
        <r:field fieldName="create_user_name"  messagekey="customerService" width="80px"></r:field>
        <r:field fieldName="applyType"  messagekey="applyType" width="100px">
            <d:select dictTypeId="WORK_TIME_SELECT"/>
        </r:field>
        <r:field fieldName="approveDateLimted"  messagekey="approveDateLimted" width="175px">
        </r:field>
        <r:field fieldName="empOrResigSpecialistName" messagekey="empOrResigSpecialist" width="90px">
        </r:field>
        <r:field fieldName="tranState"  messagekey="tranState" width="120px">
             <d:select dictTypeId="WORKTIME_STATUS"/>
        </r:field>
	</r:datacell></div>
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
