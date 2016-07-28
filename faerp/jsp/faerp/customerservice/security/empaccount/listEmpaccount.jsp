<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.empaccount.vo.EmpaccountVo" %>
<%@ page import="rayoo.customerservice.security.empaccount.util.IEmpaccountConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IEmpaccountConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IEmpaccountConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	EmpaccountVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.customerservice.security.empaccount.listEmpaccount_resource" prefix="auto.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
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

	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}

    function temp_onClick(){
        form.action="<%=request.getContextPath()%>/EmpaccountAction.do?cmd=exportExeclTemp";
        form.submit();
    }
    
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2; 
        var t = (screen.height - h) / 2; 
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
        //window.showModalDialog('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','','dialogHeight:240px;dialogWidth:320px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        
    }
    
    function import_onClick(){
        var attachNameInput = document.getElementById('attachNameInput').value;
        if(attachNameInput == null || attachNameInput== ''){
            alert('<fmt:message key="listEmpaccount0000"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpaccountAction.do?cmd=impoerExeclTemp";
        form.submit();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/EmpaccountAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" class="text_field" id="attackAddressInput" name="attach_address" value=""/>
<input type="hidden" class="text_field" id="attachNameInput" name="attachNameInput" value=""/> 
<div id="right">
<div class="ringht_s">				
<div id="ccParent1" class="button"> 
 <div class="button_right">
<input type="button" class="icon_3" value="<fmt:message key="listEmpaccount0001"/>"  onClick="javascript:temp_onClick()">
<input type="button" class="icon_3" value="<fmt:message key="listEmpaccount0002"/>"  onclick="UploadFileWindow();">
<input name="button_ok" class="icon_4"   type="button" value='<fmt:message key="listEmpaccount0003"/>' onClick="javascript:import_onClick()">
</div>
<div class="clear"></div>			
</div>

<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/EmpaccountAction.do?cmd=queryEmpAccountData" 
  width="98%" height="318px" xpath="EmpaccountVo" paramFormId="datacell_formid">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="id" messagekey="listEmpaccount0004" width="50px" onRefreshFunc="setCheckboxStatus"></r:field>
  <r:field fieldName="employee_name" messagekey="listEmpaccount0005"></r:field>
  <r:field fieldName="id_card" messagekey="listEmpaccount0006"></r:field>
  <r:field fieldName="account" messagekey="listEmpaccount0007"></r:field>
  <r:field fieldName="imp_date" width="130" messagekey="listEmpaccount0008" allowModify="false">
    <w:date format="yyyy-MM-dd hh:mm:ss"/>    
  </r:field>
  <r:field fieldName="imp_result" messagekey="listEmpaccount0009"></r:field>
  <r:field fieldName="product_name" messagekey="listEmpaccount0010"></r:field>
 <r:field fieldName="error_info" messagekey="listEmpaccount0011" width="395px"></r:field>
  </r:datacell>
</div>  


</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	//writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IEmpaccountConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		//out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEmpaccountConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
