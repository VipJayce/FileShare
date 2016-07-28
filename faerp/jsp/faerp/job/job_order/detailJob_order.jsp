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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>招聘订单管理</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">

    function cancel_onClick(){  //取消后返回列表页面
      //  form.action="<%=request.getContextPath()%>/Job_orderAction.do?cmd=queryAll&backFlag=true";
       // form.submit();
          window.close();
       //     window.opener.simpleQuery_onClick();
        
    }
    //合同参照
	function toFindContract(arg){
		var lookup = $id("lk_contract");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#contract_id").val(arg[0]);   
        return false;
	}
	//客户参照
	function rtnFunc(arg){
	var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);
        return false;
	}
	
	function toView_onClick(){
		var dc1 = $id("datacell1");
		var url="<%=request.getContextPath()%>/Job_positionAction.do?cmd=detail";
      
		showModalCenter("<%=request.getContextPath()%>/Job_positionAction.do?cmd=detail",dc1,null,650,280,"新增职位信息");
	}
	
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<div class="xz_title">基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1"  width="23%" >订单编号</td>
            <td class="td_2 " width="28%">
                <input type="text" readonly="true"  class="text_field" name="order_code" id="order_code" inputName="订单编号" maxLength="23"   value="${bean.order_code}"/>
            </td>
            <td class="td_1" width="23%">订单名称</td>
            <td class="td_2"  width="28%">
            	 <input type="text" readonly="true" class="text_field" name="order_name" id="order_name" inputName="订单名称" maxLength="23"   value="${bean.order_name}"/>
            </td>
        </tr>
		<tr>
			<td  class="td_1" width="23%" >招聘合同</td>
			<td  class="td_2" width="28%">
				<input type="hidden" name="contract_id" id="contract_id" value="${bean.contract_id}"/>
				<w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract" displayValue="${bean.contract_name}"
					lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="444" width="764" style="width:188px" readOnly="true"/> 
            
			</td>
			<td  class="td_1"  width="23%" >客户名称</td>
            <td  class="td_2 " width="28%" >
            	<w:lookup onReturnFunc="rtnFunc" readonly="false" displayValue="${bean.customer_name}" id="lk_cust" 
                                   lookupUrl="/JcustomerAction.do?cmd=getJCustRef" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false" readOnly="true"/>
                <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}" >
            </td>
		</tr>
		<tr>
			<td  class="td_1" width="23%" >担保期</td>
			<td  class="td_2" width="28%" >
				<input type="text" class="text_field" readonly="true" name="warranty" id="gzsj" inputName="担保期" maxLength="2"  value="${bean.warranty}"/>
			</td>
			<td  class="td_1" width="23%" >订单类型</td>
            <td  class="td_2" width="28%" >
               <d:select dictTypeId="RECURITTYPE" name="recruittype" id="recurittype"  value="${bean.recruittype}" nullLabel="--请选择--" disabled="true"></d:select>       
            </td>
		</tr>
    </table>
	<p></p>
</div>
    	<div id="ccParent1"  class="button">
            <div class="button_right">
                <ul>
                  <li class="a"><a onClick="javascript:toView_onClick();"><fmt:message key="view" /> </a></li>
                </ul>
            
            <div class="clear"></div>
            </div>
		</div>
		<div style="padding: 15 8 8 8;">
		       <r:datacell 
		        id="datacell1"
		        paramFormId="datacell_formid"
		        queryAction="/FAERP/Job_orderAction.do?cmd=querySubData&pk_job_order=${bean.id}"
		        submitAction="/FAERP/Job_orderAction.do?cmd=insertSubData&pk_job_order=${bean.id}"
		        width="97%"
		        height="200px"
		        xpath="Job_positionVo"
		        submitXpath="Job_positionVo"
		        pageSize="-1"
		        >
		            <r:field fieldName="position" label="招聘职位" width="150px" allowModify="false">
		            </r:field>
		            <r:field fieldName="area" label="招聘地区" width="100px" allowModify="false">
		            </r:field>
		            <r:field fieldName="job_number" label="招聘数量" width="150px" allowModify="false">
		            </r:field>  
		            <r:field fieldName="salary_range" label="薪资范围" width="100px" allowModify="false">
		             	<d:select dictTypeId="SALARY_RANGE_BD" disabled="true"/>
		            </r:field>              
		            <r:field fieldName="position_status" label="职位状态" width="150px" allowModify="false">
		            	<d:select dictTypeId="ORDER_STATUS_BD" disabled="true"/>
		            </r:field> 
		            <r:field fieldName="is_invoiced" label="是否允许预开票" width="100px">
                       <d:select dictTypeId="TrueOrFalse" disabled="true"/>
                    </r:field>       
		    </r:datacell>
		</div>
		<p></p>
		<div class="foot_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
		</div>

<input type="hidden" name="id" id="edit_id" value="${bean.id}">
<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="create_date" />
</div>
</div>

</form>   
</body>
</fmt:bundle>
</html>

