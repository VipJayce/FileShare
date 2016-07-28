<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.credentialstype.util.ICredentialsTypeConstants" %>
<html>
<fmt:bundle basename="rayoo.customerservice.credentialstype.credentialstype_resource" prefix="rayoo.customerservice.credentialstype.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="credentialsType"/></title>
<script language="javascript">
    //办理证件类别、办理证件小类联动
   function findType(){
        var credentials_type_id = document.getElementById('credentials_type');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('credentials_type_bd').value;
        if(type_bd == null || type_bd==''){
            return;
        }
         jQuery.getJSON("<venus:base/>/CredentialsTypeAction.do?cmd=findCredentialsType&flg=1&date="+new Date()+"",{"type_bd":type_bd},  function(json){
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
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;vailData
        }
        var url="<%=request.getContextPath()%>/CredentialsTypeAction.do?cmd=find&id=" + ids;
        jQuery.ajax({
                             url:"<%=request.getContextPath()%>/CredentialsTypeAction.do?cmd=vailData&id="+ids,
                             type: 'POST',
                             dataType: 'html',
                             async: false,
                             cache:false,
                             timeout: 10000,
                             success: function(data)
                                 {        
                                          var x =screen.width;
                                          var y =screen.height;
                                           if(data=='true')
                                           {
                                               window.open(url,'',"height=530px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");         
                                           }
                                           else
                                           {
                                              alert("很抱歉，此单据无效，您无法操作此单据");
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
	    	form.action="<%=request.getContextPath()%>/CredentialsTypeAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
        var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/credentialstype/insertCredentialsType.jsp";
        window.open(url,'','height=530px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=派工单新增');
	}
	function restoreMulti_onClick(){  //从多选框物理恢复多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_restore"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/CredentialsTypeAction.do?ids=" + ids;
            form.cmd.value = "restoreMulti";
            form.submit();
        }
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
		var url="<%=request.getContextPath()%>/CredentialsTypeAction.do?cmd=detail&id=" + ids;
        window.open(url,'',"height=530px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='credentialsType_maintenance'/>");
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
	writeTableTopFesco("<fmt:message key='credentialsType'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="right"><fmt:message key='credentials_type_bd'/></td>
			<td align="left">
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("credentials_type_bd", -1, "MATERIALS_DEFINE", "", "id='credentials_type_bd' onchange='findType();'", false) %>	 
			</td>
			<td align="right"><fmt:message key='credentials_name'/></td>
			<td align="left">
				 <select name="credentials_type" id="credentials_type">
                        <option value=""><fmt:message key="please_choose" /></option>
                    </select>
			</td>
		</tr>
		<tr>
		<tr>
           <td align="right"><fmt:message key='emp_bd'/></td>
          <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_bd",-1,"EMP_POST_TYPE_BD",""," id='emp_bd'",false)%> </td>
            <td  align="right"><fmt:message key='acceptance'/></td>
          <td  align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("acceptance",-1,"ACCEPTANCE",""," id='acceptance'",false)%> </td>
            </tr>
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
				<ul>
					<input class="a" type="button"  onClick="javascript:detail_onClick();" value="<fmt:message key="view"/>" <au:authorityBtn code="view_CTypeN" type="1"/> >
					<input class="c" type="button"  onClick="javascript:toAdd_onClick();" value="<fmt:message key="insert"/>" <au:authorityBtn code="insert_ CTypeN" type="1"/> >
					<input class="d" type="button"  onClick="javascript:deleteMulti_onClick();" value="<fmt:message key="delete"/>" <au:authorityBtn code="delete_ CTypeN" type="1"/> >
					<input class="b" type="button"  onClick="javascript:findCheckbox_onClick();" value="<fmt:message key="modify"/>" <au:authorityBtn code="modify_CTypeN" type="1"/> >
					<input class="g" type="button"  onClick="javascript:restoreMulti_onClick();"  value="<fmt:message   key="restore"/>"<au:authorityBtn code="restore_ CTypeN" type="1"/> >
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
<div style="padding: 8 10 8 8;">
    <r:datacell id="datacell1" queryAction="/FAERP/CredentialsTypeAction.do?cmd=simpleQuery"  width="98%" height="303px" xpath="CredentialsTypeVo" paramFormId="datacell_formid" readonly="true">
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field fieldName="id" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
        <r:field fieldName="credentials_type_bd" messagekey="credentials_type_bd" width="100px">
            <d:select dictTypeId="MATERIALS_DEFINE" />
        </r:field>
        <r:field fieldName="credentials_name" messagekey="credentials_name" width="200px"></r:field>
        <r:field fieldName="emp_bd" messagekey="emp_bd" width="200px">
             <d:select dictTypeId="EMP_POST_TYPE_BD"  />
         </r:field>
        <r:field fieldName="acceptance" messagekey="acceptance" width="200px">
             <d:select dictTypeId="ACCEPTANCE" />
        </r:field>
        <r:field fieldName="remark" messagekey="remark" width="200px"></r:field>
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
	if(request.getAttribute(ICredentialsTypeConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICredentialsTypeConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
