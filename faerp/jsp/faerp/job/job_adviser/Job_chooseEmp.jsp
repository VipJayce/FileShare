<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>

<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<%
String position_id = request.getParameter("position_id");
String user_id  =  request.getParameter("user_id");
String dept_id = PubHelper.getDepartmentIdByUserPartyId(user_id);
%>

<%@page import="rayoo.common.pub.PubHelper"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择顾问</title>
<script language="javascript">

//每行数据第一列生成复选框
function generetCheckbox(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  >";
}

function simpleQuery1_onClick(){
       $id("datacell1").addParam("user_name",$name("user_name").value); 
       $id("datacell1").addParam("dept_id",$name("dept_id").value); 
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
     function choose()
    {
        entity=choose_row_public("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("user_id");
        returnAry[1] = entity.getProperty("user_name");
        returnAry[2] = entity.getProperty("dept_id");
        returnAry[3]=entity.getProperty("dept_name");
        returnAry[4]=entity.getProperty("email");
        returnAry[5]="<%=position_id%>";
        //window.returnValue=returnAry;
        //window.close();       
        
        _jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/Job_adviserAction.do?cmd=checkAdviser&position_id=<%=position_id%>&status=1&is_valid=1&adviser_id=" +  returnAry[0],
            dataType : "html",
            success : function(data) {
                   if(data==""){
                         //获传入的datacell对象
			            var datacell=window["dialogArguments"];
			            //增加空行
			            datacell.insertEmptyRow();
			            //获得新增的记录
			            var entity=datacell.getActiveEntity();
			            entity.setProperty("adviser_id",returnAry[0]);
			            entity.setProperty("user_name",returnAry[1]);
			            entity.setProperty("dept_name",returnAry[3]);
			            entity.setProperty("email",returnAry[4]);
			             entity.setProperty("position_id",returnAry[5]);
			            entity.setProperty("status","1");
			            datacell.endEdit();  
			            //datacell.reload();
			            //datacell.refresh();
			            window.close(); 
                   }else{
                        alert(data);
                        return ;
                   }
              }
            });
        
    }
    
    function choose_row_public(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }
    
    function ClickRow(user_id,user_name,dept_id,dept_name,email){
        document.getElementById('user_id').value=unescape(user_id);
        document.getElementById('user_name').value=unescape(user_name);
        document.getElementById('dept_id').value=unescape(dept_id);
        document.getElementById('dept_name').value=unescape(dept_name);
        document.getElementById('email').value=unescape(email);
    }
</script>
</head>
<body>
 
<form name="form" method="post" >

    <div id="right">
    <div class="ringht_s">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>
            <td />
            <td />
            <td/>
            <td />
        </tr>
        <tr>
            <td align="right">用户姓名</td>
            <td align="left">
                <input type="text" class="text_field" id="user_name" name="user_name" inputName="用户姓名" maxLength="50" /></td>
            <td align="right">所属部门</td>
            <td align="left">
                <!--  <input type="text" class="text_field" id="dept_id" name="dept_id" inputName="所属部门" maxLength="64" />-->
                <r:comboSelect id="dept_id" name="dept_id"
		            queryAction="/FAERP/Job_adviserAction.do?cmd=getAllDept"
		            textField="dept_name" valueField="id" xpath="DepartmentVo" value="<%=dept_id %>"  width="180" nullText="请选择部门"/>                
            </td>
            <td align="right"></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td />
            <td />
            <td />
            <td><input name="button_ok" class="icon_1" type="button"
                value='<fmt:message key="query"/>'
                onClick="javascript:simpleQuery1_onClick()"> <input
                name="button_reset" class="icon_1" type="button"
                value='<fmt:message key="reset"/>'
                onClick="javascript:this.form.reset()"></td>
            <td />
        </tr>
    </table>
    </div>


    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript: choose();"><fmt:message
            key="choice" /> </a></li>
    </ul>

    </div>
    <div class="clear"></div>
    </div>
<input type="hidden" id="user_id" name="party_id" value="<%=rayoo.common.filter.UserInfoFilter.getLoginUserId() %>"/>
<input type="hidden" id="user_name" name="user_name"/>
<input type="hidden" id="dept_id" name="dept_id"/>
<input type="hidden" id="dept_code" name="dept_code"/>
<input type="hidden" id="dept_name" name="dept_name""/>
<input type="hidden" id="email" name="email"/>
<input type="hidden" id="company_id" name="company_id" value="<%=rayoo.common.filter.UserInfoFilter.getCompanyId() %>"/>
<r:datacell 
        id="datacell1"
       queryAction="/FAERP/Job_adviserAction.do?cmd=getAdviserList&user_id=${param.user_id}"
        width="100%" height="319px"
        xpath="Au_UserVo"
        submitXpath="Au_UserVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <!--<r:field fieldName="party_id"  label="" width="50px" onRefreshFunc="generetCheckbox" align="center">
       </r:field>-->
       <h:hidden /> 
       <r:field fieldName="user_name" width="150px" label="员工姓名">
       </r:field>  
       <r:field fieldName="dept_name" width="200px" label="所属部门">
       </r:field>  
       <r:field fieldName="email" width="250px" label="电子邮件">
       </r:field>  
    </r:datacell>
    </div>
    </form>
</fmt:bundle>
</body>
</html>
<script language="javascript">
    $id("datacell1").onDblClickRow=function(rowTR, rowNo ,entity,datacell){
        choose();
    }
</script>
