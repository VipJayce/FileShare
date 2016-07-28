<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key="post_notice_or_exam"/></title>
<%
String city_id = (String)request.getAttribute("city_id");
if(city_id==null || "".equals(city_id)){
    city_id = "1099110100000000050";
}
request.setAttribute("city_id",city_id);
%>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=\"ClickRow('" + entity.getProperty("id") + "','" + entity.getProperty("pid") + "');\">";
     }
    
    function ClickRow(value,value1){
        $id("emp_id").value = value;
        $id("emp_post_id").value = value1;
    }

    function showListData(){
         $id("datacell1").loadData();
         $id("datacell1").refresh();
     }
    
    function detail_onClick(){  //实现转到详细页面
        var emp_post_id = document.getElementById("emp_post_id").value;
        if(emp_post_id!=null&&emp_post_id!=""){
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
            //window.showModalDialog('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
            //showModalCenter('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,window,'',950,450,"个人订单信息");
        }else{
            alert("<fmt:message key="select_records"/>");
            return;
        }
    }
    
    //导出
    function expNoticExam(){
	    $id("noticeExamForm").action = "<%=request.getContextPath()%>/FaerpEmployeeAction.do";
	    $id("h_cmd").value = "exportToExcel";
	    $id("noticeExamForm").submit();
	}
    
    //保存
    function saveNoticExam() { 
        $id("datacell1").submit();
    }
    
    //选择客户
	function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#h_customer_name").val(arg[2]);
        return false;
    }
    //选择客服
	function rtnFuncCS(arg){
	    var lookup = $id("lk_cs");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    jQuery("#h_user_id").val(arg[0]);        
	    return false;
	}
</script>
</head>

<body>

<form name="form" id="noticeExamForm" method="post">
<input type="hidden" name="emp_post_id" id="emp_post_id"/>
<input type="hidden" name="emp_id" id="emp_id"/>
<input type="hidden" id="h_cmd" name="cmd"/>
<div id="right">
<div class="ringht_s">
 
	<div id="ccChild0" class="search"> 
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	            <td rowspan="6" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
	        </tr>
	        <tr>
	            <td align="right"><fmt:message key="city"/></td>
	            <td align="left" width="210">
	                <r:comboSelect id="city_idList_search" name="province_bd"
                           queryAction="PB_CITYAction.do?cmd=getListData"
                           textField="city_name"
                           valueField="id"
                           xpath="PB_CITYVo"
                           width="200px"
                           value="${requestScope.city_id }"
                           />
	            </td>
	            <td align="right"><fmt:message key="cust_code"/></td>
	            <td align="left"><input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="25"/>            </td>
	            <td align="right"><fmt:message key="cust_name"/></td>
	            <td align="left">
	                <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
                    <input type="hidden" name="cust_name1" id="h_customer_name" value=""/>
	            </td>
	        </tr>
	        <tr>
	            <td align="right"><fmt:message key="notice_process"/></td>
	            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("notice_status1", -1,"NOTICE_STATUS", "0", "", false) %></td>
	            <td align="right"><fmt:message key="emp_code"/></td>
	            <td align="left"><input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="25"/>          </td>
	            <td align="right"><fmt:message key="emp_name"/></td>
	            <td align="left"><input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="50"/>            </td>
	        </tr>
	        <tr>
	            <td align="right"><fmt:message key="user_name"/></td>
	            <td align="left">
	               <r:comboSelect id="combo_cs" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_choose" />
                </td>
                <td align="right"><fmt:message key="sort_status"/></td>
            	<td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("service_status_bd ", -1,"SERVICE_STATUS_BD", "", "", false) %></td>
	            <td align="right"><fmt:message key="dept_name"/></td>
	            <td align="left">
	                <r:comboSelect id="cs_name" name="cs_name" queryAction="/FAERP/FinbillAction.do?cmd=getCustDeptListData"
	                     textField="name" valueField="id" xpath="AupartyVO" width="189px" nullText="--请选择--" />
	                </td>
	            </td>
	        </tr>
	        <tr>
	            <td align="right">一次通知时间开始</td>
	            <td align="left">
	               <w:date format="yyyy/MM/dd" id="one_start_date" name="one_start_date" width="100px"/>
                </td>
                <td align="right">一次通知时间结束</td>
            	<td align="left"><w:date format="yyyy/MM/dd" id="one_end_date" name="one_end_date" width="100px"/></td>
	            <td align="right">二次通知时间开始</td>
	            <td align="left">
	                <w:date format="yyyy/MM/dd" id="two_strat_date" name="two_strat_date" width="100px"/>
	                </td>
	            </td>
	        </tr>
	        <tr>
	            <td align="right">二次通知时间结束</td>
	            <td align="left">
	               <w:date format="yyyy/MM/dd" id="two_end_date" name="two_end_date" width="100px"/>
                </td>
                <td align="right">三次通知时间开始</td>
            	<td align="left"><w:date format="yyyy/MM/dd" id="three_start_date" name="three_start_date" width="100px"/></td>
	            <td align="right">三次通知时间结束</td>
	            <td align="left">
	                <w:date format="yyyy/MM/dd" id="three_end_date" name="three_end_date" width="100px"/>
	                </td>
	            </td>
	        </tr>

			<tr>
				<td colspan="6" align="right">
				    <input name="button_ok2" class="icon_1" type="button" value="<fmt:message key="query"/>" onClick="javascript:showListData()">
				    <input name="button_reset2" class="icon_1"  style="margin-right: 100px;"  type="button" value="<fmt:message key="reset"/>" onClick="javascript:this.form.reset()">
				</td>
			</tr>
	</table>
	</div>
                    
	<div id="ccParent1" class="button"> 
	    <div class="button_right">
	        <!--<ul>
	            <li class="a_2">      <a  onClick="javascript:detail_onClick();">查看个人订单</a> </li>
	            <li class="bc">    <a onclick="saveNoticExam()" href="javascript:void(0);">保存</a></li>
	            <li class="e">      <a onclick="expNoticExam()" href="javascript:void(0);">导出</a></li>
	        </ul>
	    -->
	    <input class="a_2" type="button"   value="<fmt:message key="look_person_order"/>"  <au:authorityBtn code="view_orderItem1" type="1"/>  onClick="detail_onClick();">
	    <input class="bc" type="button"   value="<fmt:message key="save"/>"  <au:authorityBtn code="tztj_save" type="1"/>  onClick="saveNoticExam();">
	    <input class="e" type="button"   value="<fmt:message key="leading_out"/>"  <au:authorityBtn code="tztj_exp" type="1"/>  onClick="expNoticExam();">
	    </div>
	    <div class="clear"></div>           
	</div>
 
    <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/FaerpEmployeeAction.do?cmd=simpleQueryNoticeExam"
        submitAction="/FAERP/FaerpEmployeeAction.do?cmd=saveNoticeExam"
        width="97%"
        height="320px"
        xpath="EmployeeVo"
        submitXpath="EmployeeVo"
        paramFormId="noticeExamForm"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
      </r:field>
      <r:field fieldName="cust_name" messagekey="cust_name">
      </r:field>
      <r:field fieldName="user_name" messagekey="user_name">
      </r:field>
      <r:field fieldName="dept_name" messagekey="dept_name">
      </r:field>
      <r:field fieldName="emp_code" messagekey="emp_code">
      </r:field>
      <r:field fieldName="emp_name" messagekey="emp_name1">
       </r:field>
       <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date">
            <w:date format="yyyy-MM-dd" disabled="true"/>
       </r:field>
       <r:field fieldName="small_name" messagekey="emp_type">
       </r:field>
       <r:field fieldName="notice_status" messagekey="notice_status">
            <d:select dictTypeId="NOTICE_STATUS"/>
       </r:field>
       <r:field fieldName="service_status_bd" messagekey="sort_status" allowModify="false">
            <d:select dictTypeId="SERVICE_STATUS_BD"/>
       </r:field>
       <r:field fieldName="labor_status_bd" messagekey="contract_status">
            <d:select dictTypeId="LABOR_STATUS_BD"/>
       </r:field>
       <r:field fieldName="mobile" messagekey="mobile">
            <h:text/>
       </r:field>
       <r:field fieldName="email" messagekey="email">
            <h:text/>
       </r:field>
       <r:field fieldName="first_notice_date" messagekey="first_notice_date">
            <w:date format="yyyy-MM-dd" name=""/>
       </r:field>
       <r:field fieldName="first_notice_result" messagekey="first_notice_result">
            <h:text/>
       </r:field>
       <r:field fieldName="second_notice_date" messagekey="second_notice_date">
            <w:date format="yyyy-MM-dd" name=""/>
       </r:field>
       <r:field fieldName="second_notice_result" messagekey="second_notice_result">
            <h:text/>
       </r:field>
       <r:field fieldName="third_notice_date" messagekey="third_notice_date">
            <w:date format="yyyy-MM-dd" name=""/>
       </r:field>
       <r:field fieldName="third_notice_result" messagekey="hird_notice_result">
            <h:text/>
       </r:field>
       <r:field fieldName="notice_desc" messagekey="on_post_desc1">
            <h:textarea/>
       </r:field>
       <r:field fieldName="post_status_bd" messagekey="post_status1">
            <d:select dictTypeId="POST_STATUS_BD" disabled="true"/>
       </r:field>
       <r:field fieldName="is_physical_examination" messagekey="is_physical_examination">
            <d:select dictTypeId="IS_PHYSICAL_EXAM"/>
       </r:field>
       <r:field fieldName="exam_process" messagekey="exam_process">
            <d:select dictTypeId="EXAM_PROCESS"/>
       </r:field>
       <r:field fieldName="exam_date" messagekey="exam_date">
            <w:date format="yyyy-MM-dd" name=""/>
       </r:field>
       <r:field fieldName="exam_result" messagekey="exam_result">
            <d:select dictTypeId="EXAM_RESULT"/>
       </r:field>
    </r:datacell>
    </div>
 
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
<script type="text/javascript">
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
