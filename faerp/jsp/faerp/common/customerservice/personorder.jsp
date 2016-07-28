<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%  //取出本条记录
	EmppostVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (EmppostVo)request.getAttribute(IEmppostConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	String str=(String)request.getAttribute("str"); 
	String str1=(String)request.getAttribute("str1"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.common.customer.customerservice.customerservice_resource" prefix="rayoo.common.customer.customerservice.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="peson_order_info"/></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        window.close();
    }
    
    function toinfo(){
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=toInfo";
        form.submit();
    }
    
    function show_onClick(){
        if(document.getElementById("displayTab").style.display==''){
            document.getElementById("displayTab").style.display='none';
        }else{
            document.getElementById("displayTab").style.display='';
        }
    }
    
    function update_onClick(){  //保存修改
        var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=updateInfo";
        var myAjax = new Ajax(action);
        var postId = document.getElementById("id").value;
        var job_num = document.getElementById("job_num").value;
        var hro = document.getElementById("hro").value;
        var business = document.getElementById("business").value;
        var emp_status = document.getElementById("emp_status").value;
        myAjax.addParam('postId', postId);
        myAjax.addParam("job_num",job_num);
        myAjax.addParam("hro",hro);
        myAjax.addParam("business",business);
        myAjax.addParam("emp_status",emp_status);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
            alert(myAjax.getValue("root/data/returnValue"));
            window.close();
            window.opener.showListData();
        }
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 <div id="right">
    <div class="ringht_s">

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
            <td class="td_1" ><fmt:message key="emp_code"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>"></td>
            <td class="td_1" ><fmt:message key="emp_name"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>"></td>
            <td class="td_1" ><fmt:message key="internal_code"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getInternal_code())%>"></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="cust_code"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>"></td>
            <td class="td_1" ><fmt:message key="cust_name"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>"></td>
            <td class="td_1" ><fmt:message key="simple_cust_name"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCustomer_simple_name())%>"></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="id_card_type"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getId_card_type_bd()==null?"":BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>"></td>
            <td class="td_1" ><fmt:message key="emp_card_no1"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getId_card())%>"></td>
            <td class="td_1" ><fmt:message key="tel1"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getContact_tel1())%>"></td>
        </tr>        
        <tr>
            <td class="td_1" ><fmt:message key="mobile1"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMobile())%>"></td>
            <td class="td_1" ><fmt:message key="charge_start_date"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCharge_start_date(),10)%>"></td>
            <td class="td_1" ><fmt:message key="charge_end_date"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCharge_end_date(),10)%>"></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="apply_on_post_date"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getApply_on_post_date(),10)%>"></td>
            <td class="td_1" ><fmt:message key="on_post_date"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOn_post_date(),19)%>"></td>
            <td class="td_1" ><fmt:message key="on_post_user_id"/>：</td>
            <td class="td_2" >
            <%if(resultVo.getOn_post_user_id()!=null&&resultVo.getOn_post_user_id()!=""){ %>
                <input type="text" class="text_field" readonly="readonly" value="<%=OrgHelper.getPartyVoByID(resultVo.getOn_post_user_id().toString()).getName()%>">
            <%}else{ %>
                <input type="text" class="text_field" readonly="readonly" value="">
            <%} %>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="is_employ_notice"/>：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_physical_examination()==null?"":BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_employ_notice()))%>"></td>
            <td class="td_1"><fmt:message key="is_physical_examination"/>：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_physical_examination()==null?"":BaseDataHelper.getNameByCode("IS_PHYSICAL_EXAM",RmStringHelper.prt(resultVo.getIs_physical_examination()))%>"></td>
            <td class="td_1"><fmt:message key="emp_entry"/>：</td>
            <td class="td_2">
            <input type="text" class="text_field" inputName="员工入职属性" value="<%=BaseDataHelper.getNameByCode("EMP_ENTRY_BD",RmStringHelper.prt(resultVo.getEmp_entry_bd()))%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1">社保福利办理方：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getSecurity_unit_real_name())%>"></td>
            <td class="td_1">公积金福利办理方：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getFund_unit_real_name())%>"></td>
            <td class="td_1">用退工福利办理方：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getHire_unit_real_name())%>"></td>
        
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="on_post_desc"/>：</td>
            <td colspan="5" class="td_2" >
                <textarea class="xText_d" readonly="readonly" cols="400" rows="3" name="remark" inputName="备注" maxLength="1000" ><%=RmStringHelper.prt(resultVo.getOn_post_desc()) %></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="apply_off_post_date"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getApply_off_post_date(),10)%>"></td>
            <td class="td_1" ><fmt:message key="off_post_date"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOff_post_date(),19)%>"></td>
             <td class="td_1" ><fmt:message key="off_post_user_id"/>：</td>
            <td class="td_2" >
            <%if(resultVo.getOff_post_user_id()!=null&&resultVo.getOff_post_user_id()!=""){ %>
                <input type="text" class="text_field" readonly="readonly" value="<%=OrgHelper.getPartyVoByID(resultVo.getOff_post_user_id().toString()).getName()%>">
            <%}else{ %>
                <input type="text" class="text_field" readonly="readonly" value="">
            <%} %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="off_post_reason"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getOff_post_reason()==null?"":BaseDataHelper.getNameByCode("OFF_POST_REASON",RmStringHelper.prt(resultVo.getOff_post_reason()))%>"></td>
            <td class="td_1" ><fmt:message key="ge_off_post_reason"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getGe_off_post_reason()==null?"":BaseDataHelper.getNameByCode("GE_OFF_POST_REASON",RmStringHelper.prt(resultVo.getGe_off_post_reason()))%>"></td>
            <td class="td_1" ><fmt:message key="off_post_desc"/>：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOff_post_desc())%>"></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="cust_send_id"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_send_name())%>"></td>
            <td class="td_1" ><fmt:message key="move_desc"/>：</td>
            <td class="td_2" colspan="3"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMove_desc())%>"></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="cust_receive_id"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_receive_name())%>"></td>
            <td class="td_1" ><fmt:message key="send"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getSend_name())%>"></td>
            <td class="td_1" ><fmt:message key="emp_type"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getEmp_post_type_bd()==null?"":BaseDataHelper.getNameByCode("EMP_POST_TYPE_BD",RmStringHelper.prt(resultVo.getEmp_post_type_bd()))%>"></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="post_status1"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getPost_status_bd()==null?"":BaseDataHelper.getNameByCode("POST_STATUS_BD",RmStringHelper.prt(resultVo.getPost_status_bd()))%>"></td>
            <td class="td_1" ><fmt:message key="is_import_client"/>：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_import_client()==null?"":BaseDataHelper.getNameByCode("IS_PHYSICAL_EXAM",RmStringHelper.prt(resultVo.getIs_import_client()))%>"></td>
            <c:if test="${isModify!=null&&isModify!='1'}">
            <td class="td_1" >工号：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getJob_num())%>"></td>
            </c:if>
            <c:if test="${isModify=='1'}">
            <td class="td_1" >工号：</td>
            <td class="td_2" ><input type="text" class="text_field" id="job_num" name="job_num" value="<%=RmStringHelper.prt(resultVo.getJob_num())%>"></td>
            </c:if>
        </tr>
        <c:if test="${isModify!=null&&isModify!='1'}">
        <tr>
            <td class="td_1" >HRO：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getHro())%>"></td>
            <td class="td_1" >业务部门：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getBusiness())%>"></td>
            <td class="td_1" >员工状态</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("EMP_POSITION",RmStringHelper.prt(resultVo.getEmp_status()))%>"></td>
        </tr>
        </c:if>
        <c:if test="${isModify=='1'}">
        <tr>
            <td class="td_1" >HRO：</td>
            <td class="td_2" ><input type="text" class="text_field" name="hro" id="hro" value="<%=RmStringHelper.prt(resultVo.getHro())%>"></td>
            <td class="td_1" >业务部门：</td>
            <td class="td_2" ><input type="text" class="text_field" name="business" id="business" value="<%=RmStringHelper.prt(resultVo.getBusiness())%>"></td>
            <td class="td_1" >员工状态</td>
            <td class="td_2" ><d:select id="emp_status" name="emp_status" value="<%=RmStringHelper.prt(resultVo.getEmp_status())%>" dictTypeId="EMP_POSITION"  nullLabel="--请选择--"></d:select></td>
        </tr>
        </c:if>
          <tr>
            <td class="td_1" >是否入职E化：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_phoenix()==null?"":BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_phoenix()))%>"></td>
            <td class="td_1" >是否离职E化：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_Offpost_phoenix()==null?"":BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_Offpost_phoenix()))%>"></td>
            <td class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
	</table>
</div>


<table width="99%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"> <fmt:message key="fees_section_info"/></div>
        <span style="padding-left:15px;color:red;"><fmt:message key="current_only_show_active_fees_section"/><a href="###" id="show1" onclick="javascript:show_onClick();"><u><fmt:message key="click"/></u></a> <fmt:message key="show_all_fees_section"/></span> 
        <!--表格 -->
        <div class="box_3">
     
          <table width="99%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
            <%if(str!=null&&!"".equals(str)){ %> 
              <% out.print(str);%>
            <%} %>
           </table>

          <table width="99%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="display:none" id="displayTab">
            <%if(str1!=null&&!"".equals(str1)){ %> 
              <% out.print(str1);%>
            <%} %>
           </table>
             
    </div>
        <!--表格 end-->
        </div>
    </td>
    </tr>
</table>

 
<div class="foot_button">
     <c:if test="${isModify=='1'}">
            <input type="button" class="foot_icon_1" value="<fmt:message key="modify"/>" onclick="javascript:update_onClick();"/>
    </c:if>
    <input type="button" class="foot_icon_1" value="<fmt:message key="close"/>" onclick="javascript:back_onClick();" />
</div>

</div>
<input type="hidden" name="id" id="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
