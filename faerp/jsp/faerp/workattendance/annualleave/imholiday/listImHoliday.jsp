<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.workattendance.annualleave.imholiday.util.IImHolidayConstants" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>年假管理</title>
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
    
   function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
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
		var url="<%=request.getContextPath()%>/ImHolidayAction.do?cmd=find&id="+ids;
        window.open(url,'','height=400px,width=950px,top =100,left=200,help=no,resizable=yes,scrollbars=no,location=no,status=not,title=修改页面');
	}  
	
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/ImHolidayAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
   
   
   
   
    function toAdd_onClick(){  //到增加记录页面
		var url = '<%=request.getContextPath()%>/ImHolidayAction.do?cmd=toInsert';
		window.open(url,'','height=500px,width=950px,top =100,left=200,help=no,resizable=yes,scrollbars=no,location=no,status=not,title=新增页面');
    }
    
    function callBack(){
    	$id("datacell1").loadData();  
        $id("datacell1").refresh();
    }
    
    function updateDataCell_onClick() { 
        $id("datacell1").submit();   
    }
    
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}

    //-------------------------------
    function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }
    
    function reset_onClick(){
        jQuery("#cust_id").val("");       
    }
    
    
    function calculate_onClick() {
        showProgressBar();
        jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/ImHolidayAction.do?cmd=calculateAnnualLeave",
            dataType : "html",
            data: "companyId="+jQuery("#company_id").val()+"&custId="+jQuery("#cust_id").val()
                   +"&empId="+jQuery("#emp_id").val()+"&empName="+jQuery("#emp_name").val(),
            success : function(data) {
                alert(data);
                $id("datacell1").loadData();
                $id("datacell1").refresh();
                hideProgressBar();
            }
        });
    }
    
    //数据导入
    function import_onClick(){
    	var url = "<%=request.getContextPath()%>/ImHolidayAction.do?cmd=toImport";
    	showModalCenter(url, window, callBack, 550, 330, "导入页面");
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/ImHolidayAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('年假管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="150" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td width="70" align="center">客户名称</td>
            <td width="190">
              <input type="hidden" name="cust_id" id="cust_id">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="170px" readonly="false" displayValue="" id="lk_cust" 
                          lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
                          height="440" width="710" allowInput="false"/>
            </td>
            <td width="70" align="center">员工姓名</td>
            <td width="180">
                <input type="text" class="text_field" name="emp_name" inputName="emp_name" id="emp_name"/>
            </td>
            <td width="70" align="center">员工编号</td>
            <td width="180">
                <input type="text" class="text_field" name="emp_id" inputName="emp_id" id="emp_id"/>
            </td>
            <td width="218">
             <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             <input type="reset" class="icon_1" onclick="javascript:reset_onClick()" />
             </td>
        </tr>
    </table>
</div>

<div id="ccParent1" class="button"> 
    <div class="button_right">
        <ul>
            <li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message key="insert" /> </a></li>
		    <li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify" /> </a></li>
            <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete" /> </a></li> 
            <li class="bc_1"><a  onClick="javascript:updateDataCell_onClick();"><fmt:message key="save"/> </a> </li>
            <li class="h_2"><a  onClick="javascript:calculate_onClick();">年假计算</a></li>
        	<li class="h_2"><a  onClick="javascript:import_onClick();">数据导入</a></li>
        </ul>
    </div>
    <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/ImHolidayAction.do?cmd=simpleQuery"
             submitAction="/FAERP/ImHolidayAction.do?cmd=update"
             width="98%" height="320px" xpath="ImHolidayVo" paramFormId="datacell_formid">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
  <r:field fieldName="emp_name" label="员工名称"></r:field>
  <r:field fieldName="cust_name" label="客户名称"></r:field>
   <r:field fieldName="restdayorhour" label="结余假期">
    <h:text/>
   </r:field>
     <r:field fieldName="curyear" label="年度">
     	<d:select dictTypeId="SP_CURYEAR" id="curyear" name="curyear" nullLabel="--请选择--" />
     </r:field>
  <r:field fieldName="yidayorhour" label="本年已休">
    <h:text/>
   </r:field>
   <r:field fieldName="curdayorhour" label="本年享有">
    <h:text/>
   </r:field>
   <r:field fieldName="lastdayorhour" label="上年结余">
    <h:text/>
   </r:field>
   <r:field fieldName="lastAnnualLeaveDays" label="结余法定年假天数">
    <h:text/>
   </r:field>
   <r:field fieldName="c_lastAnnualLeaveDays" label="结余公司福利年假天数">
    <h:text/>
   </r:field>
   <r:field fieldName="calculatetime" label="计算时间" allowModify="false">
    <w:date format="YYYY-MM-DD hh:mm:ss"/>
  </r:field>
   <r:field fieldName="isuse" label="是否使用">
    <d:select dictTypeId="TrueOrFalse" />
   </r:field>
   <r:field fieldName="isseal" label="是否结算">
    <d:select dictTypeId="TrueOrFalse" />
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
	if(request.getAttribute(IImHolidayConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IImHolidayConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
