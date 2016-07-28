<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<%  
String mid= (String)request.getAttribute("mid");
String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();
   
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){
      var message =addAppReason("<%=request.getContextPath()%>");
      //alert('message='+message);
      if(message==null)return;
        //alert('操作成功！');
        form.action="<venus:base/>/Job_chargetransbillAction.do?message="+message[0];
        document.getElementById("cmd").value="appOperate";
        form.submit();
         
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/Job_chargetransbillAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
    }
    
</script>
</head>
<body>
 
<form name="form" method="post">
<div id="right">
<input type="hidden" id="cmd" name="cmd" value=""/>
<input  type="hidden"  value="" name="info_msg" id="info_msg"  >
 <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >
  <input  type="hidden"  value="<%=mid%>" name="mid" id="mid"  >
<script language="javascript">
writeTableTopFesco('<fmt:message key="detail_page"/>','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_s">
<div id="ccChild1"     class="box_3"> 

<div class="xz_title">基本信息</div>
<table  width="100%" height="50" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >划转单编号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="transcode" inputName="划转单编号" value="${bean.transcode }" maxLength="50" readonly="readonly" />
            </td>
            <td class="td_1" >划转单类型</td>
            <td class="td_2 ">
                <d:select id="transtype" dictTypeId="JOB_TRANSTYPE_BD" value="${bean.transtype }" nullLabel="请选择" disabled="true"></d:select>
            </td>
        </tr>
        
        <tr>
            <td class="td_1" >划出部门</td>
            <td class="td_2 ">
                <r:comboSelect id="outdept_id" name="outdept_id" readOnly="true"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       readonly="false"
                       property="bean/outdept_id"
                       xpath="DepartmentVo"
                       nullText="请选择" width="205" value="${bean.outdept_id }" ></r:comboSelect>
            </td>
            <td class="td_1" >划转年月</td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" name="transyearmonth" inputName="划转年月" value="${bean.transyearmonth }" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >备注</td>
            <td class="td_2 " colspan="3">
                <textarea rows="5" cols="50" readonly="readonly" id="description">${bean.description }</textarea>
            </td>
        </tr>
    </table>
    </div>
    
        <div class="clear"></div>
        <div style="padding: 8 8 8 8;">
         <r:datacell id="datacell1"
        queryAction="/FAERP/Job_chargetransbillAction.do?cmd=queryChargeDetailData&chargetransferbill_id=${bean.id }"
        xpath="Job_chargetransdetailVo" readonly="true" width="98%"
        height="320px" >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <!-- 
        <r:field fieldName="id" label="操作" width="50px"
            onRefreshFunc="setCheckboxStatus" align="center"></r:field> -->
       <r:field fieldName="cutindept_id" label="划入部门" width="150px">
                         <r:comboSelect id="cutindept_id" name="cutindept_id"
                           queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                           textField="dept_name"
                           valueField="id"
                           readonly="false"
                          property="bean/outdept_id"
                         xpath="DepartmentVo"
                        nullText="请选择" width="205" validateAttr="allowNull=false;" >
                     </r:comboSelect>
                    </r:field>
                    <r:field fieldName="expenseitem" label="费用项目" width="180px">
                        <h:text validateAttr="allowNull=false;" />
                    </r:field>
                    <r:field fieldName="expenseamount" label="划转金额" width="150px">
                        <h:text validateAttr="type=number;allowNull=false;"/>
                    </r:field>  
                    <!-- 
                    <r:field fieldName="showed" label="是否显示" width="100px">
                        <d:select dictTypeId="TrueOrFalse" />
                    </r:field>
                    <r:field fieldName="serialno" label="显示序号" width="100px">
                        <h:text />
                    </r:field> -->
                    <r:field fieldName="position_name" label="职位" width="100px"></r:field>
                    <r:field fieldName="pmteam" label="团队" width="100px">
                     <r:comboSelect id="cutindept_id" name="cutindept_id"
                           queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                           textField="dept_name"
                           valueField="id"
                           readonly="false"
                          property="bean/outdept_id"
                         xpath="DepartmentVo"
                        nullText="" width="205" validateAttr="allowNull=false;" >
                        </r:comboSelect>
                    </r:field>
                    <r:field fieldName="pm_name" label="项目经理" width="100px"></r:field>
                    <r:field fieldName="counselor_name" label="顾问" width="100px"> </r:field>
                    <r:field fieldName="emp_name" label="员工" width="100px"></r:field>
                    <r:field fieldName="sendstartdate" label="外派起始日期" width="100px">
                      <w:date format="yyyy-MM-dd"/>
                    </r:field>
                    <r:field fieldName="sendenddate" label="外派截止日期" width="100px">
                      <w:date format="yyyy-MM-dd"/>
                    </r:field>
                    <r:field fieldName="sendperiod" label="外派期限" width="100px"> </r:field>
                    <r:field fieldName="description" label="备注" width="200px" >
                        <h:textarea rows="5" cols="35"/>
                    </r:field>  
    </r:datacell>
        </div>
        
        <div class="clear"></div>
        <div style="padding: 8 8 8 8;">
           <div id="values_div1" style="width:43%; float:left;">
               <r:datacell id="datacell2" 
                queryAction="/FAERP/Job_chargetransbillAction.do?cmd=queryChargeContractForUpdate&chargetransferbill_id=${bean.id }"
                xpath="Job_chargecontractVo" 
                submitAction="/FAERP/Job_chargetransbillAction.do?cmd=insertAll"
                submitXpath="Job_chargecontractVo"
                width="98%" height="200px" pageSize="-1">
                    
                    <r:field fieldName="contract_name" label="合同" width="180px">
                    </r:field>
                    <r:field fieldName="contract_id" label="合同ID" width="0px">
                    </r:field>
                    <r:field fieldName="cust_id" label="客户ID" width="0px">
                    </r:field>
                    <r:field fieldName="cust_name" label="客户名称" width="200px">
                    </r:field>
         </r:datacell>
        </div>
        <div id="values_div2" style="width:55%; float:left;">
               <r:datacell id="datacell3" 
                queryAction="/FAERP/Job_chargetransbillAction.do?cmd=queryChargeFinbillForUpdate&chargetransferbill_id=${bean.id }"
                xpath="Job_chargefinbillVo" 
                submitAction="/FAERP/Job_chargetransbillAction.do?cmd=insertAll"
                submitXpath="Job_chargefinbillVo"
                width="98%" height="200px" pageSize="-1">
                   
                    <r:field fieldName="bill_code" label="账单编号" width="150px">
                    </r:field>
                    <r:field fieldName="bill_id" label="账单ID" width="0px">
                    </r:field>
                    <r:field fieldName="bill_year_month" label="账单年月" width="80px">
                    </r:field>
                    <r:field fieldName="bill_amount" label="账单金额" width="80px">
                    </r:field>
                    <r:field fieldName="cust_id" label="客户ID" width="0px">
                    </r:field>
                    <r:field fieldName="cust_name" label="客户名称" width="200px">
                    </r:field>
         </r:datacell>
        </div>
    </div>
           
    <div class="foot_button">
        <input name="button_back" class="foot_icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <%
        if(request.getAttribute("isLook")==null||(request.getAttribute("isLook")!=null&&request.getAttribute("isLook").equals("false"))){
        %>
        <input name="button_app" class="foot_icon_2" type="button" value="审批"  onclick="javascript:appOperate_onClick();" >
        <input name="button_back" class="foot_icon_2" type="button" value="驳回"  onclick="javascript:backOperate_onClick();" >
        <%} %>
      </div>

    
</div>

</div>
</form>
</fmt:bundle>
</body>
</html>
