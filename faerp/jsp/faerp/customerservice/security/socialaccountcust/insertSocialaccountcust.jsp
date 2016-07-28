<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@ page import="rayoo.customerservice.security.socialaccountcust.util.ISocialaccountcustConstants" %>
<%@ page import="rayoo.customerservice.security.socialaccountcust.vo.SocialaccountcustVo" %>

<%  //判断是否为修改页面
	SocialaccountcustVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ISocialaccountcustConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SocialaccountcustVo)request.getAttribute(ISocialaccountcustConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
	String group_type = request.getParameter("group_type");
    String security_type = request.getParameter("security_type");
%>
<html>
<fmt:bundle basename="rayoo.customerservice.security.socialaccountcust.socialaccountcust_resource" prefix="rayoo.customerservice.security.socialaccountcust.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

//城市社保组联动标签1099110100000000050
function citySecurityGroupchange(seletvalue){
    //alert(seletvalue);
      SecurityGroupAjax.getCitySecurityGroup(seletvalue,{callback:function(data){
                    setSelectForBean("social_group_id",data,"id","group_name","");
                    if(<%=isModify%>){
                         document.getElementById("social_group_id").value="<%=resultVo==null?"":resultVo.getSocial_group_id()%>";
                    }
                }
            });
    }
    
	function insert_onClick(){  //插入单条数据
    var frm = $id("datacell_formid");	
      //表单验证
      if( !checkForm(frm) ) {
          
          return;
      }   
      
      var cust_id=jQuery("#cust_id").val();
      var social_group_id=jQuery("#social_group_id").val();
      var pay_start_date = $id("pay_start_date");
      var pay_value = pay_start_date.value;
      if(pay_value.length != 6){
        alert("起始缴交年月格式不正确，请以YYYYMM的正确格式输入");
        return;
      }
	    if(checkAll()&&checkCust_id(cust_id,social_group_id)){
	 
		//form.action="<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=insert";
		//var action = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=inTransactionSecurity";
		var action = "<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=insert";
		var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
            var dc = $id("dcListInjuryRecord");
            var recordXml = dc.dataset.toString();
             myAjax.submitXML(recordXml, "UTF-8");
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
                  window.opener.callBack(myAjax.getProperty("returnValue"));
             }
		//form.submit();
		//window.close();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		 var cust_id=jQuery("#cust_id").val();


	    var action ="<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=update";
    	var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
            //var dc = $id("dcListInjuryRecord");
            //var recordXml = dc.dataset.toString();
            //myAjax.submitXML(recordXml, "UTF-8");
            myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
                  //window.opener.callBack(myAjax.getProperty("returnValue"));
                  window.opener.$id("datacell1").loadData();
                  window.opener.$id("datacell1").refresh();
                  window.opener.$id("dcListInjuryRecord").loadData();
                  window.opener.$id("dcListInjuryRecord").refresh();
             }

	}
	
	function checkAll(){

       return true;
	}
	
	function checkCust_id(cust_id,social_group_id){
    var flag = true;
     jQuery.ajax({
                url: "<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=custIsExist&custId="+cust_id+"&socialGroupId="+social_group_id+"&date="+new Date()+"",
                type: 'GET',
                dataType: 'html',
                async: false,
                timeout: 10000,
                error: function(){
                    alert('Error loading XML document');
                    return  null;
                },
                success: function(text){
                    if(text=="1"){
                       alert("<fmt:message key="cust_is_exise"/>");
                       flag = false;
                   }else{
                      flag = true;
                   }
                }
            });
	   return flag;
	
	}
	

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }

 function rtnFuncCustomer(arg){
    var cust_id = $id("cust_id");
    var cust_code=$id("cust_code");
    var cust_name=$id("cust_name");
    //alert(arg[0]+"----"+arg[1]+"----"+arg[2]);
    cust_id.value = arg[0];
    cust_code.displayValue= arg[1];
    cust_name.value = arg[2];
    return false;
}
</script>
</head>
<body>
<h:form  checkType="blur" name="datacell_formid" method="post"  id="datacell_formid">
<div id="right">
 <div class="ringht_x">
<div id="ccChild1" class="box_xinzeng"  style="height:200px;">
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <input type="hidden" name="group_type" value="${param.group_type}">
        <input type="hidden" name="security_type" value="${param.security_type}">
		<tr>
            <td class="td_1" ><fmt:message key="ss_fund_group"/></td>
            <td class="td_2 ">
            
                  <%
                   if(isModify){
                  %>
                     <input type="text" class="text_field" id="group_name" name="group_name"  inputName="社保/公积金组"  readonly="readonly" value=" ${bean.group_name}" />
                  
                   <input type="hidden" class="text_field" id="social_group_id" name="social_group_id"  inputName="社保/公积金组编号" value=" ${bean.social_group_id}" />
              
                  <%
                   }else{
                  %>
            
               <c:choose>
                            <c:when test="${param.group_type=='1'&&param.security_type=='1'}">
                                <select id="social_group_id" name="social_group_id" >
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key="sh_shss"/></option>
                                </select>
                            </c:when>
                            <c:when test="${param.group_type=='1'&&param.security_type=='2'}">
                                <select id="social_group_id" name="social_group_id" >
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key="sh_shti"/></option>
                                </select>
                            </c:when>
                            <c:when test="${param.group_type=='1'&&param.security_type=='3'}">
                                <select id="social_group_id" name="social_group_id" >
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key="sh_shcs"/></option>
                                </select>
                            </c:when>
                            <c:when test="${param.group_type=='2'}">
                                <select id="social_group_id" name="social_group_id" >
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message key="sh_shfund"/></option>
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message key="sh_shbcfund"/></option>
                                </select>
                            </c:when>
                        </c:choose>
                        <%
                   }
                        %>
            </td>
            <c:choose>
               <c:when test="${param.group_type=='2'}">
			<td class="td_1" ><fmt:message key="paying_bank"/></td>
			<td class="td_2" ><input type="text" class="text_field" name="paying_bank" inputName="缴纳银行" value="${bean.paying_bank }" maxLength="64" /></td>
			   </c:when>
			   <c:when test="${param.group_type!='2'}">
            <td class="td_1" ></td>
            <td class="td_2" ></td>
               </c:when>
            </c:choose>
		</tr>
		<tr>
		      <td class="td_1" ><fmt:message key="cust_code"/></td>
                <td class="td_2 ">
                  <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id }" >

                  <%
                   if(isModify){
                  %>
                   <input type="text" class="text_field" id="cust_code" name="cust_code"  inputName="客户编号"  readonly="readonly" value="${bean.customer_code}" />
                 <%
                  }else{
                 %>
                  <w:lookup  validateAttr="allowNull=false;"  onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_code" name="cust_code" displayValue="${bean.customer_code}" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_cust" height="440" width="600"  style="width:185px"/>
					<%
					                   }
					%>         
  </td>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="cust_name" name=cust_name  inputName="客户名称"  readonly="readonly" value="${bean.customer_name}" />
            </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="account"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="accounts" inputName="账号" value="${bean.accounts }" validate="isNum;" maxLength="64" />
			</td>
			<td class="td_1" ><fmt:message key="open_unit"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="open_unit" inputName="开户单位" value="${bean.open_unit }" maxLength="50" />
            </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="open_unit_account"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="open_unit_accounts" inputName="开户单位账号" value="${bean.open_unit_accounts }" validate="isNum;" maxLength="64" />
			</td>
			<td class="td_1" ><fmt:message key="is_fesco_pay"/></td>
            <td class="td_2" >
                 <d:select name="is_fesco_pay" dictTypeId="TrueOrFalse" value="${bean.is_fesco_pay }"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
		</tr>
		<tr>
            <td class="td_1" >用工单位</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="hire_unit" inputName="用工单位" value="${bean.hire_unit }"  maxLength="255" />
            </td>
            <td class="td_1" >客户密码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cust_password" inputName="客户密码" value="${bean.cust_password }"  maxLength="64" />
            </td>
         </tr>
            <td class="td_1" >客户类型</td>
            <td class="td_2" >
               <h:select id="emp_code_type" name="emp_code_type" property="bean/emp_code_type" style="width: 85px">
                            <h:option value="" label="--请选择--"/>
                            <h:option value="0" label="客户方编号"/>
                            <h:option value="1" label="唯一号"/>
                        </h:select>
            </td>
            <td class="td_1" >起始缴费年月</td>
              <td class="td_2 ">
                  <input type="text" class="text_field" id="pay_start_date" name="pay_start_date" inputName="起始缴交年月" value="${bean.pay_start_date }" style="width: 120px"
                  onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"  
                          onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'0')}else{this.value=this.value.replace(/\D/g,'')}"/>格式为:yyyyMM
              </td>
        </tr>
		<c:choose>
          <c:when test="${param.group_type=='2'}">
              <tr>
                    <td class="td_1" ><fmt:message key="operation_date"/></td>
                    <td class="td_2 ">
                        <input type="text" class="text_field" name="end_date" inputName="操作截止日" value="${bean.end_date }" validate="isValidDay;" maxLength="64" />
                    </td>
                    <td class="td_1" ><fmt:message key="get_day"/></td>
                    <td class="td_2" >
                        <d:select name="get_month" dictTypeId="GET_MONTH" value="${bean.get_month }"  nullLabel="--请选择--" style="width: 85px"/>
                        <h:select id="get_day" name="get_day" property="bean/get_day" style="width: 85px">
                            <h:option value="" label="--请选择--"/>
                            <%for(int i=1;i<31;i++){ 
                                String aa = i+"";
                                %>
                            <h:option value="<%=aa %>" label="<%=aa %>"/>
                            <%} %>
                        </h:select>
                        <fmt:message key="day"/>
                    </td>
              </tr>
              <tr>
                    <td class="td_1" ><fmt:message key="seal_party"/></td>
                    <td class="td_2 ">
                        <input type="text" class="text_field" name="seal_party" inputName="盖章方" value="${bean.seal_party }" maxLength="64" />
                    </td>
                    <td class="td_1" ><fmt:message key="remarks"/></td>
                    <td class="td_2" >
                        <input type="text" class="text_field" name="remarks" inputName="备注" value="${bean.remarks }" maxLength="64" />
                    </td>
              </tr>
          </c:when>
        </c:choose>
	</table>
</div>
<div style="margin: 10px;">
    <input type="button" class="icon_2" value="新增" onclick="javascript:addRowToDataCell();"/>
    <input type="button" class="icon_2" value="删除" onclick="javascript:delRowToDataCell();"/>
    <r:datacell
     id="dcListInjuryRecord"
     paramFormId="datacell_formid"
     queryAction="/FAERP/InjuryRatesRecordAction.do?cmd=findInjuryRecords?security_id=<%=RmStringHelper.prt(resultVo.getId())%>"
     submitAction="/FAERP/InjuryRatesRecordAction.do?cmd=submitList?security_id=<%=RmStringHelper.prt(resultVo.getId())%>"
     width="98%"
     height="200px"
     xpath="InjuryRatesRecordVo"
     pageSize="100">
    <r:field fieldName="industry_id" messagekey="industry_id" width="250px;">
        <h:text/>
    </r:field>
    <r:field fieldName="source_type" messagekey="source_type" width="250px;">
        <h:text />
    </r:field>
    <r:field fieldName="base_rates" messagekey="base_rates" width="250px;">
        <h:text onchange="javascript:isNum();" onblur="checkInjuryRates();"/>
    </r:field>
    <r:field fieldName="float_rates" messagekey="float_rates" width="250px;">
        <h:text onchange="javascript:isNum();" onblur="checkInjuryRates();"/>
    </r:field>
    <r:field fieldName="injury_rates" messagekey="injury_rates" width="250px;">
        <h:text />
    </r:field>
    <r:field fieldName="pay_rates" messagekey="pay_rates" width="250px;" allowModify="false"/>
    <r:field fieldName="valid_start_yearmonth" messagekey="valid_start_yearmonth" width="250px;">
        <h:text maxlength="6"/>
    </r:field>
    <r:field fieldName="valid_end_yrearmonth" messagekey="valid_end_yrearmonth" width="250px;">
        <h:text maxlength="6"/>
    </r:field>
    <r:toolbar location="right" tools="nav,pagesize,info"/>
    </r:datacell>
</div>
<div align="center">
    <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
    <input type="button" class="icon_2" value='<fmt:message key="close"/>'  onClick="javascript:cancel_onClick()"/>
</div>
<input type="hidden" name="acust_id" value="${bean.id }">
<input type="hidden" name="create_date" />
</h:form>
     <script type="text/javascript">
         function addRowToDataCell() {
             $id("dcListInjuryRecord").addRow();
         }

         function delRowToDataCell() {
             if (confirm("您确定要删除这行数据吗？")) {
                 $id("dcListInjuryRecord").deleteRow();
             }
         }
         function checkInjuryRates() {
             var dc = $id("dcListInjuryRecord");
             var activeRow = dc.activeRow;
             var entity = dc.getEntity(activeRow);
             var baseRates = entity.getProperty("base_rates");
             var floatRates = entity.getProperty("float_rates");

             entity.setProperty("pay_rates", parseFloat(baseRates) * parseFloat(floatRates))
         }
         function isNum(val){
            return /^[0-9.]&/.test(val);
         }
     </script>
</body>
</fmt:bundle>
</html>