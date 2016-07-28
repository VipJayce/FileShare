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
<title><fmt:message key="credentialsType_maintenance"/></title>
<script language="javascript">
    jQuery(document).ready(function()
    {
       $id("datacell1").isQueryFirst = false;
    });
//办理证件类别、办理证件小类联动
   function findType(){
        var credentials_type_id = document.getElementById('credentials_type_id');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById("credentialsTypeBdID").value;
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
	function findCheckbox_onClick(i) {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="";
           var height=0;
           if(i==0){
           url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=findTranDef&id=" + ids;
           height=275;
           jQuery.ajax({
                             url:"<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataTranDef1&id="+ids,
                             type: 'POST',
                             dataType: 'html',
                             async: false,
                             cache:false,
                             timeout: 10000,
                             success: function(data)
                                 {        
                                          data=eval("("+data+")");
                                          var x =screen.width;
                                          var y =screen.height;
                                           if(data.status=='true')
                                           {
                                                
                                                window.open(url,'',"height="+height+"px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");
                                           }
                                           else
                                           {
                                              alert("很抱歉，该单据无效，您无法操作此单据");
                                           }
                                 }
                             });
           }
           else if(i==1)
           {
              url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=detailTranDefHIS&id=" + ids;
              height=480;
               window.open(url,'',"height="+height+"px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");
           }
          
      	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_restore"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMultiTranDef";
	    	form.submit();
		}
	}
	   function restoreMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do?ids=" + ids;
            form.cmd.value = "restoreMultiTranDef";
            form.submit();
        }
    }
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
        var url="<%=request.getContextPath()%>/jsp/faerp/certificate/certificateTransaction/insertCredentialsTranDef.jsp";
        window.open(url,'','height=475px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=证件办理材料新增');
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
		var url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=detailTranDef&id=" + ids;
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
	writeTableTopFesco("<fmt:message key='credentialsType_maintenance'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="right"><fmt:message key='companyName'/></td>
			<td align="left">
				<input type="text" class="text_field" name="companyName" inputName="公司名称" maxLength="50"/>	 
			</td>
			<td align="right"><fmt:message key='companyNumber'/></td>
			<td align="left">
				<input type="text" class="text_field" name="companyNumber" inputName="公司编号" maxLength="50"/>
			</td>
			<td align="right"><fmt:message key='credentials_type_bd'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("credentialsTypeBdID", -1, "CREDENTIALS_TYPE", "", " id=\"credentialsTypeBdID\" onchange=\"findType()\"", false)%>    
            </td>
		</tr>
		<tr>
            <td align="right"><fmt:message key='credentials_name'/></td>
            <td align="left">
               <select name="credentialsTypeId" id="credentials_type_id">
                        <option value=""><fmt:message key="please_choose" /></option>
                    </select>
            </td>
            <td align="right"><fmt:message key='companyAccount'/></td>
          <td align="left">
            <input type="text" class="text_field" name="companyAccount" maxLength="50"  id="companyAccount" value="" />
          </td>
          <td  align="right"><fmt:message key='companyAccountPassword'/></td>
          <td  align="left">
            <input type="text" class="text_field" name="companyAccountPassword" maxLength="50"  id="companyAccountPassword" value="" />
           </td>
		</tr>
		<tr>           
           <td align="right"><fmt:message key='acceptance'/></td>
          <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("acceptance", -1, "ACCEPTANCE", "", " id='acceptance'", false)%>
           </td>
            <td  align="right"><fmt:message key='companyLinkman'/></td>
          <td  align="left">
            <input type="text"     class="text_field" name="companyLinkman" maxLength="50"  id="companyLinkman" value="" />
           </td>
           <td > <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
             <td >   <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()"></td>
            </tr>
</table>
</div>
					
<div id="ccParent1" class="button"> 
 <div class="button_right">
					<input class="a"  type="button"   onClick="javascript:detail_onClick();"  value="<fmt:message key='view'/>" <au:authorityBtn code="view_credTranDef" type="1"/>>
					<input class="c"  type="button" onClick="javascript:toAdd_onClick();"  value="<fmt:message key="insert"/>" <au:authorityBtn code="insert_credTranDef" type="1"/>>
					<input class="a"  type="button" onClick="javascript:findCheckbox_onClick(1);"  value="<fmt:message key="history"/>" <au:authorityBtn code="history_credTranDef" type="1"/>>
					<input class="b" type="button"   onClick="javascript:findCheckbox_onClick(0);"  value="<fmt:message key="modify"/>" <au:authorityBtn code="modify_credTranDef" type="1"/>>
				    <input class="d" type="button"  onClick="javascript:deleteMulti_onClick();"  value="<fmt:message key="delete"/>" <au:authorityBtn code="delete_credTranDef" type="1"/>>
				    <input class="g" type="button"  onClick="javascript:restoreMulti_onClick();"  value="<fmt:message key="restore"/>" <au:authorityBtn code="restore_credTranDef" type="1"/>>
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
<div style="padding: 8 10 8 8;">
    <r:datacell id="datacell1" queryAction="/FAERP/CertificateTransactionAction.do?cmd=simpleQueryTranDef"  width="98%" height="303px" xpath="CertifiCateTranInfoDef" paramFormId="datacell_formid" readonly="true">
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field fieldName="id" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
        <r:field fieldName="companyName" messagekey="companyName" width="200px"></r:field>
        <r:field fieldName="companyNumber" messagekey="companyNumber" width="200px"></r:field>
        <r:field fieldName="credentialsTypeBdID" messagekey="credentials_type_bd" width="100px">
            <d:select dictTypeId="CREDENTIALS_TYPE" />
        </r:field>
        <r:field fieldName="credentialsTypeName" messagekey="credentials_name" width="100px"></r:field>
        <r:field fieldName="companyAccount" messagekey="companyAccount" width="200px"></r:field>
        <r:field fieldName="companyAccountPassword" messagekey="companyAccountPassword" width="200px"></r:field>
        <r:field fieldName="acceptance" messagekey="acceptance" width="100px">
            <d:select dictTypeId="ACCEPTANCE"/>
        </r:field>
        <r:field fieldName="companyLinkman" messagekey="companyLinkman" width="150px"></r:field>
        <r:field fieldName="is_del" messagekey="is_del" width="200px">
             <h:select name="is_del" property="is_del">
               <h:option value="0" label="有效"></h:option>
                <h:option value="1" label="无效"></h:option>
       </h:select>
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
