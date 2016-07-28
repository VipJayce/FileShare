<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + escape(entity.getProperty("id")) + "\",\"" +escape(entity.getProperty("on_post_date")).substring(0,10)+ "\",\""  + "\");>";
    }
    
    function ClickRow(pid,on_post_date){
        $id("post_id").value = pid;
        $id("on_post_date").value = on_post_date;
    }
    
    function select_onClick(){
        var post_id = document.getElementById("post_id").value;
        var on_post_date = document.getElementById("on_post_date").value;
        var emp_id = document.getElementById("emp_id").value;
        var in_date = document.getElementById("in_date").value;
        var become_date = document.getElementById("become_date").value;
        var relation_area = document.getElementById("relation_area").value;
        var inside_position = document.getElementById("inside_position").value;
        var is_secretary = document.getElementById("is_secretary").value;
        var is_over_sea_in = document.getElementById("is_over_sea_in").value;
        var is_prepare = document.getElementById("is_prepare").value;
        var remarks = document.getElementById("remarks").value;
        if(post_id==null || post_id==""){
            alert("请选择一条记录！");
            return;
        }
        
        jQuery.getJSON("<venus:base/>/EppartymemerAction.do?cmd=save&date="+new Date()+"",{"post_id":post_id,"on_post_date":on_post_date,"emp_id":emp_id,"in_date":in_date,"become_date":become_date,"relation_area":relation_area,"inside_position":inside_position,"is_secretary":is_secretary,"is_over_sea_in":is_over_sea_in,"is_prepare":is_prepare,"remarks":remarks},function(json){
            alert(json.saia);
            var url = "<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartymemer/insertEppartymemer.jsp";
            window['returnValue'] = [url];
            window.close();
        });
    }

</script>
</head>
<body onunload="dsfsadf()">

<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="emp_id" name="emp_id" value="${emp_id }"/>
<input type="hidden" id="in_date" name="in_date" value="${in_date }"/>
<input type="hidden" id="become_date" name="become_date" value="${become_date }"/>
<input type="hidden" id="relation_area" name="relation_area" value="${relation_area }"/>
<input type="hidden" id="inside_position" name="inside_position" value="${inside_position }"/>
<input type="hidden" id="is_secretary" name="is_secretary" value="${is_secretary }"/>
<input type="hidden" id="is_over_sea_in" name="is_over_sea_in" value="${is_over_sea_in }"/>
<input type="hidden" id="is_prepare" name="is_prepare" value="${is_prepare }"/>
<input type="hidden" id="remarks" name="remarks" value="${remarks }"/>
<input type="hidden" id="post_id" name="post_id" value=""/>
<input type="hidden" id="on_post_date" name="on_post_date" value=""/>

	<div id="right">
	<div id="ccParent1" class="button">
		 <div class="button_right">
		    <ul>
		        <li class="g_1"><a onClick="javascript:select_onClick();">选择并保存</a></li>
		    </ul>
	    </div>
        <div class="clear"></div>
    </div>
    
    <div  id="div1" style="margin:5 0 0 10px;">
	<r:datacell
	    id="datacell1"
		queryAction="/FAERP/EppartymemerAction.do?cmd=searchEmppostData"
		width="98%"
		height="305px"
		xpath="EmployeeVo"
		paramFormId="datacell_formid">
		
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>
		<r:field fieldName="emp_code" label="唯一号">
		</r:field>
		<r:field fieldName="emp_name" label="员工姓名">
		</r:field>
		<r:field fieldName="id_card_type_bd" label="证件类型" allowModify="false">
		  <d:select dictTypeId="ID_CARD_TYPE_BD"/>
		</r:field>
		<r:field fieldName="id_card" width="130px" label="证件号码">
		</r:field>
		<r:field fieldName="cust_name" width="150px" label="客户名称">
		</r:field>
		<r:field fieldName="cust_code" label="客户编号">
		</r:field>
		<r:field fieldName="post_status_bd" label="状态" allowModify="false">
            <d:select dictTypeId="POST_STATUS_BD" />
        </r:field>
	</r:datacell> 
	</div>
	</form>
</fmt:bundle>
</body>
</html>
