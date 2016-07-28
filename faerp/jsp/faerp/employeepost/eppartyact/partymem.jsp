<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
String act_id = request.getParameter("act_id")==null  ? "" :request.getParameter("act_id").toString();
%>

<html>
<fmt:bundle basename="rayoo.employeepost.eppartyact.eppartyact_resource" prefix="rayoo.employeepost.eppartyact.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function simpleQuery(){  //简单的模糊查询
       $id("datacell1").loadData();
       $id("datacell1").refresh();
  	}
  	
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' value='"+ entity.getProperty("id")+"' name='checkbox_template' ;>";
    }
    
   function checkAll(){
	   var element = document.getElementsByTagName("input");
	   for(var i=0;i<element.length;i++){
	       if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
	           element[i].checked= !element[i].checked ? true : false;
	       }
       } 
   }
   
   function findSelections() {  //从列表中找出选中的id值列表
        var ids="";
        var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
                    if(element[i].checked){
                         ids+=element[i].value+",";
                    //      break;
                    }
                }
            } 
            return ids;
    }
    
    function choose() {
        var act_id = document.getElementById("act_id").value;
	    var ids = findSelections();  //取得多选框的选择项
	    if(ids == null||ids=="") {  //如果ids为空
	        alert('<fmt:message key="select_one_record"/>');
	        return;
	    }
	     jQuery.getJSON("<%=request.getContextPath()%>/EppartyactitemAction.do?cmd=insert&date="+new Date()+"",{"ids":ids,"act_id":act_id},function(json){
		     if(json.saia!=""){
	                alert(json.saia);
				    window['returnValue'] = [act_id];
			        window.close(); //关闭
			         window.opener.toFindMemer(act_id);
		     }else{
		            alert("<fmt:message key="save_succese"/>");
		            window['returnValue'] = [act_id];
                    window.close(); //关闭
                    window.opener.toFindMemer(act_id);
		     }
	     });
	}  

</script>
</head>
<body>
<div id="right">
<form id="datacell_formid" name="form" method="post" action="<%=request.getContextPath()%>/EppartyactAction.do">
 <input type="hidden" name="act_id" id="act_id" value="<%=act_id %>">
 

<div class="ring2ht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key="query_condition"/></div>
		</tr>
		<tr>
			<td align="right"><fmt:message key="emp_code"/>&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" class="text_field" id="emp_code1"  name="emp_code1" inputName="唯一号" maxLength="50"/>
			</td>
            <td align="right"><fmt:message key="emp_name"/>&nbsp;&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" id="emp_name1"  name="emp_name1" inputName="员工姓名" maxLength="50"/>
            </td>
		</tr>
		  <tr>
            <td align="right" ><fmt:message key="party_comp_name"/>&nbsp;</td>
            <td align="left ">
                    <r:comboSelect id="partyCode" name="partyCode"  queryAction="/FAERP/EppartycomponentAction.do?cmd=getPartyCode"
                       textField="party_name" valueField="id" xpath="EppartycomponentVo" width="205px" messagekey="please_choose" />
            </td>
            <td align="right" ></td>
            <td align="left">
                  <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery()">
                  <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
             </td>
        </tr>
</table>
</div>
					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:choose();"><fmt:message key="choice"/></a> </li>
				</ul>
				
		 </div>
		 
           <div class="clear"></div>			
           
</div>
      <r:datacell 
        id="datacell1"
       queryAction="/FAERP/EppartycomponentAction.do?cmd=getPartyMember"
        width="100%" height="319px"
        xpath="EppartyEmployeeVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="<input type='checkbox' name='checkall' value='' onclick='checkAll(this);' />" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
        <r:field fieldName="emp_code" width="100px" messagekey="emp_code">
       </r:field>   
       <r:field fieldName="emp_name" width="100px" messagekey="emp_name">
       </r:field>   
       <r:field fieldName="emp_sex" width="40px" messagekey="sex" allowModify="false">
        <d:select dictTypeId="EMP_SEX" />
       </r:field>   
       <r:field fieldName="nationality" width="40px" messagekey="nationality">
       </r:field>   
       <r:field fieldName="birth_date" width="100px" messagekey="birth_day" allowModify="false">
         <w:date format="yyyy-MM-dd" />
       </r:field>   
      <r:field fieldName="party_name" width="200px" messagekey="party_name2">
       </r:field> 
      <r:field fieldName="party_comp_name" width="200px" messagekey="party_comp_name2">
       </r:field> 
       <r:field fieldName="education_bd" width="70px" messagekey="education_bd" allowModify="false">
        <d:select dictTypeId="EDUCATION_BD" />
       </r:field>   
       <r:field fieldName="in_date" width="100px" messagekey="in_date" allowModify="false">
        <w:date format="yyyy-MM-dd" />
       </r:field>   
       <r:field fieldName="address" width="300px" messagekey="address">
       </r:field>   
       <r:field fieldName="email" width="100px" messagekey="email">
       </r:field>   
       <r:field fieldName="tel" width="100px" messagekey="tel">
       </r:field>    
    </r:datacell>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
