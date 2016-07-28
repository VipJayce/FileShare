<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/CommonCheck.js"/>
<h:script src="/js/caculateMoney.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@ page import="rayoo.customerservice.security.empsecurity.vo.EmpsecurityVo" %>
<%  //取出本条记录
    EmpsecurityVo resultVo = null;  //定义<fmt:message key='modifyEmpsecurity0106'/>临时<fmt:message key='modifyEmpsecurity0006'/>vo<fmt:message key='modifyEmpsecurity0000'/>
    resultVo = (EmpsecurityVo)request.getAttribute(IEmpsecurityConstants.REQUEST_BEAN);  //从request<fmt:message key='modifyEmpsecurity0001'/>vo, <fmt:message key='modifyEmpsecurity0002'/>resultVo
    //RmVoHelper.replaceToHtml(resultVo);  //把vo中<fmt:message key='modifyEmpsecurity0006'/>每个值过滤
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.modifyEmpsecurity_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
    <c:choose>
         <c:when test="${isModify==1}">
                <fmt:message key='modifyEmpsecurity0004'/>
         </c:when>
         <c:otherwise><fmt:message key='modifyEmpsecurity0005'/></c:otherwise>     
     </c:choose>           
</title>
<script language="javascript">
    // new dataset list
    var dataset_list = new Array();
    
    function back_onClick(){  //返回列表页面
        window.close();
    }
    
    //<fmt:message key='modifyEmpsecurity0004'/>
    function save_onClick(){
        if(checkAllCont()){
            var ds1 = $id("datacell1").dataset;//<fmt:message key='modifyEmpsecurity0077'/>
            //changeDSStatus($id("datacell1"));
            var ds2 = $id("datacell2").dataset;//<fmt:message key='modifyEmpsecurity0086'/>
            var ds3 = new Dataset();//<fmt:message key='modifyEmpsecurity0104'/>
            //<fmt:message key='modifyEmpsecurity0077'/>
            for(var f=0;f<ds1.getLength();f++){
                var enItem = ds1.get(f);
                enItem.setProperty("status",enItem.status);
            }
            //<fmt:message key='modifyEmpsecurity0086'/>与<fmt:message key='modifyEmpsecurity0104'/>绑定
            var index=0;
            for(var i=0;i<ds2.getLength();i++){
                var enCur = ds2.get(i);
                if(enCur.status==3||enCur.status==4){
                    enCur.setProperty("status",enCur.status);
                    continue;
                }
                enCur.setProperty("status",enCur.status);
                enCur.setProperty("dsIndex",i);
                var chdataset=datasetList[index];
                for(var j=0;j<chdataset.getLength();j++){
                    var enCurItem = chdataset.get(j);
                    enCurItem.setProperty("parentIndex",i);
                }
                ds3.appendDataset(chdataset);
                index++;
            }
            var action = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=modifySecurity";
            //将两个datacell<fmt:message key='modifyEmpsecurity0006'/>xml<fmt:message key='modifyEmpsecurity0007'/>
            var xmlSubmit = ds1.toString();
            xmlSubmit +=  ds2.toString();
            xmlSubmit +=  ds3.toString();
            //alert(xmlSubmit);
            //return ;
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
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
                  window.opener.callBack(myAjax.getProperty("returnValue"));
             }
        }
    }
    function checkAllCont(){
        var frm=$id("datacell_formid");
        if( !checkForm(frm) ) {
          return false;
        }
        if(!$id("datacell2").validateAll()){
            return false;
        }
        
        //开始月不能往前修改；开始月不能比结束月大（2014-03-19陈小佩增加）
        var start_month = $id("start_month").value;
        var start_month_bak = $id("start_month_bak").value;
        var end_month = $id("end_month").value;
        var end_month_bak = $id("end_month_bak").value;
        var emp_account = $id("emp_account").value;
        //var ordernum = $name("ordernum").value;
        if(start_month!='' && start_month<start_month_bak){
            alert('起始月不能往前修改，请先申报变更；如已经变更好订单，请直接添加补缴！');
            return false;
        }
        //开始月往后改时，如果已有多个订单，不允许（暂时不执行该项限制）
        //if(start_month!=start_month_bak && ordernum>1){
        //    alert('订单已经有多个，起始月不能修改，请先申报变更！');
        //    return false;
        //}
        if(start_month!='' && end_month!='' && start_month>end_month){
            alert('起始月不能比结束月大！');
            return false;
        }
        if(emp_account.length>9){
        	alert('公积金帐号的长度不可以大于9位');
        	return false;
        }
        return true;
    }
    
    function changeDSStatus(datacell){
        var ds=datacell.dataset;
        //datacell.isModefied = true;
        for(var i=0;i<ds.getLength();i++){
            var enCur=ds.get(i);
            enCur.name="EmpsecurityitemVo";
        }
    }
    
    function checkEmpAccount(input){
    	var emp_account = $id("emp_account").value;
    	if(emp_account.length>9){
    		alert('公积金帐号长度不可以大于9位');
    		return false;
    	}
    }
</script>
</head>
<body>
<h:form  checkType="blur" name="form" method="post"  id="datacell_formid"> 
	<input type="hidden" name="social_unit_id_value" value="<%=RmStringHelper.prt(resultVo.getSocial_unit_id())%>">
    <input type="hidden" name="cust_id" value="<%=RmStringHelper.prt(resultVo.getCust_id())%>">
    <input type="hidden" name="emp_security_id" value="<%=RmStringHelper.prt(resultVo.getId())%>">
    <input type="hidden" name="security_group_id" value="<%=RmStringHelper.prt(resultVo.getSecurity_group_id())%>">
    <input type="hidden" name="emp_post_id" value="<%=RmStringHelper.prt(resultVo.getEmp_post_id())%>">
    <input type="hidden" name="isModify" value="${isModify}">
   <!--  <input type="hidden" name="ordernum" value="${ordernum}"> -->
<div id="right">
<div class="ringht_s">

<p></p>
<div class="xz_title"><fmt:message key='modifyEmpsecurity0008'/></div>
<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0009'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0009'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0011'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0011'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0013'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0013'/>" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0015'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0015'/>" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0017'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0017'/>" value="<%=resultVo.getId_card_type_bd()==null?"":BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0019'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0019'/>" value="<%=RmStringHelper.prt(resultVo.getId_card())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0021'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0021'/>" value="<%=RmStringHelper.prt(resultVo.getApply_on_post_date(),10)%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0023'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0023'/>" value="<%=RmStringHelper.prt(resultVo.getOn_post_date(),10)%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0025'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;"  inputName="<fmt:message key='modifyEmpsecurity0025'/>" value="<%=RmStringHelper.prt(resultVo.getCharge_start_date(),10)%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0090'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;"  inputName="社保/公积金组" value="<%=RmStringHelper.prt(resultVo.getGroup_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0027'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;"  inputName="<fmt:message key='modifyEmpsecurity0027'/>" value="<%=RmStringHelper.prt(resultVo.getApply_man_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0029'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;"  inputName="<fmt:message key='modifyEmpsecurity0029'/>" value="<%=RmStringHelper.prt(resultVo.getApply_date(),10)%>" readonly="readonly" />
            </td>
        </tr>
        <!-- 补充公积金<fmt:message key='modifyEmpsecurity0006'/>情况 -->
        <%if(resultVo.getSecurity_group_id().equals("1099110700000000156")){ %>
            <tr>
             
                <td class="td_1" ><fmt:message key='modifyEmpsecurity0032'/></td>
                <td class="td_2" >
                       <input type="text" class="text_field" name="emp_base_account" style="background:#f0f0f0;" value="<%=RmStringHelper.prt(resultVo.getEmp_base_account())%>" readonly="readonly"/>
                </td>
                
                <td class="td_1" ><fmt:message key='modifyEmpsecurity0033'/></td>
                <td class="td_2" >
                    <input type="text" class="text_field" name="emp_account" id="emp_account" value="<%=RmStringHelper.prt(resultVo.getEmp_account())%>" onblur="checkEmpAccount(this)" />
                </td>
                <td class="td_1" ><span>*</span><fmt:message key='modifyEmpsecurity0034'/></td>
                <td class="td_2" >
                    <input type="text" class="text_field" name="social_unit_id" style="background:#f0f0f0;"  inputName="<fmt:message key='modifyEmpsecurity0034'/>" value="<%=RmStringHelper.prt(resultVo.getSocial_unit_name())%>" readonly="readonly" />
                </td>
            </tr>
            <tr>
	            <td class="td_1" ><fmt:message key='modifyEmpsecurity0036'/></td>
	            <td class="td_2" >
	                <r:comboSelect id="com1" name="transact_type_id" 
	                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
	                    textField="type_name" 
	                    valueField="id" 
	                    xpath="SecuritygroupnewVo"                   
	                    messagekey='modifyEmpsecurity0037'
	                    value="<%=RmStringHelper.prt(resultVo.getTransact_type_id())%>"
	                    width="155px">
	                    <h:param name="security_group_id" value="<%=RmStringHelper.prt(resultVo.getSecurity_group_id())%>"/>
	                </r:comboSelect>
	                <input type="hidden" name="transact_type_id_bak" id="transact_type_id_bak" value="<%=RmStringHelper.prt(resultVo.getTransact_type_id()) %>">
	            </td>
	            <td class="td_1" ><span>*</span><fmt:message key='modifyEmpsecurity0038'/></td>
	            <td class="td_2" >
	                <h:text id="start_month" name="start_month"  value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
	                <input type="hidden" name="start_month_bak" id="start_month_bak" value="<%=RmStringHelper.prt(resultVo.getStart_month())%>">
	            </td>
	            <td class="td_1" ><fmt:message key='modifyEmpsecurity0040'/></td>
	            <td class="td_2" >
	                <h:text id="end_month" name="end_month"  value="<%=RmStringHelper.prt(resultVo.getEnd_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;"/>
	                <input type="hidden" name="end_month_bak" id="end_month_bak" value="<%=RmStringHelper.prt(resultVo.getEnd_month())%>">
	            </td>
	        <tr>
	            <td class="td_1" ><span>*</span><fmt:message key='modifyEmpsecurity0042'/></td>
	            <td class="td_2" >
	                <h:text id="fund_month" name="fund_month"  value="<%=RmStringHelper.prt(resultVo.getFund_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
	                <input type="hidden" name="fund_month_bak" id="fund_month_bak" value="<%=RmStringHelper.prt(resultVo.getFund_month())%>">
	            </td>
	            <td colspan="4" class="td_2" >
            </tr>
          <%}else{ %>
        <tr>
                <c:choose>
                    <c:when test="${requestScope.applytype==1}">
                        <td class="td_1" ><fmt:message key='modifyEmpsecurity0044'/></td>
                        <td class="td_2" >
                            <input type="text" class="text_field" name="emp_account" id="emp_account" value="<%=RmStringHelper.prt(resultVo.getEmp_account())%>" onblur="checkEmpAccount(this)" />
                        </td>
                    </c:when>
                <c:otherwise>
                    <td class="td_1" ><fmt:message key='modifyEmpsecurity0045'/></td>
                    <td class="td_2" >
                        <input type="text" class="text_field" name="serial_no" inputName="<fmt:message key='modifyEmpsecurity0045'/>" value="<%=RmStringHelper.prt(resultVo.getSerial_no())%>" readonly="readonly" />
                    	<input type="text" type="hidden" name="emp_account" id="emp_account" value="" />
                    </td>
                </c:otherwise>
            </c:choose>
            <td class="td_1" ><span>*</span><fmt:message key='modifyEmpsecurity0034'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="social_unit_id" style="background:#f0f0f0;"  inputName="<fmt:message key='modifyEmpsecurity0034'/>" value="<%=RmStringHelper.prt(resultVo.getSocial_unit_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0036'/></td>
            <td class="td_2" >
                <r:comboSelect id="com1" name="transact_type_id" 
                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
                    textField="type_name" 
                    valueField="id" 
                    xpath="SecuritygroupnewVo"                   
                    messagekey='modifyEmpsecurity0037'
                    value="<%=RmStringHelper.prt(resultVo.getTransact_type_id())%>"
                    width="155px">
                    <h:param name="security_group_id" value="<%=RmStringHelper.prt(resultVo.getSecurity_group_id())%>"/>
                </r:comboSelect>
                <input type="hidden" name="transact_type_id_bak" id="transact_type_id_bak" value="<%=RmStringHelper.prt(resultVo.getTransact_type_id()) %>">
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span>*</span><fmt:message key='modifyEmpsecurity0038'/></td>
            <td class="td_2" >
                <h:text id="start_month" name="start_month"  value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
                <input type="hidden" name="start_month_bak" id="start_month_bak" value="<%=RmStringHelper.prt(resultVo.getStart_month())%>">
            </td>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0040'/></td>
            <td class="td_2" >
                <h:text id="end_month" name="end_month"  value="<%=RmStringHelper.prt(resultVo.getEnd_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;"/>
                <input type="hidden" name="end_month_bak" id="end_month_bak" value="<%=RmStringHelper.prt(resultVo.getEnd_month())%>">
            </td>
            <td class="td_1" ><span>*</span><fmt:message key='modifyEmpsecurity0042'/></td>
            <td class="td_2" >
                <h:text id="fund_month" name="fund_month"  value="<%=RmStringHelper.prt(resultVo.getFund_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
                <input type="hidden" name="fund_month_bak" id="fund_month_bak" value="<%=RmStringHelper.prt(resultVo.getFund_month())%>">
            </td>
        </tr>
        <%} %>
        <tr>
            <td class="td_1"><fmt:message key='modifyEmpsecurity0057'/></td>
            <td colspan="6" class="td_2">
                 <textarea rows="2" name="back_reason" style="background:#f0f0f0;"  style="width:600px" readonly="readonly" inputName="<fmt:message key='modifyEmpsecurity0057'/>"></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='modifyEmpsecurity0059'/></td>
            <td colspan="6" class="td_2">
                 <textarea rows="2" name="transact_remarks" style="width:600px" inputName="<fmt:message key='modifyEmpsecurity0059'/>"><%=RmStringHelper.prt(resultVo.getTransact_remarks())%></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='modifyEmpsecurity0061'/></td>
            <td colspan="6" class="td_2">
                 <d:select name="security_status_bd" dictTypeId="SECU_MODIFY_STA" value="<%=RmStringHelper.prt(resultVo.getSecurity_status_bd())%>" style="width: 205px"/>
                 <input type="hidden" name="security_status_bd_bak" id="security_status_bd_bak" value="<%=RmStringHelper.prt(resultVo.getSecurity_status_bd())%>">
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0062'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="old_cust_name" inputName="<fmt:message key='modifyEmpsecurity0062'/>" value="<%=RmStringHelper.prt(resultVo.getOld_cust_name())%>" readonly="readonly" />
            </td>
            <!--<td class="td_1" ><fmt:message key='modifyEmpsecurity0064'/></td>陈旭<fmt:message key='modifyEmpsecurity0004'/>-->
            <td class="td_1" ><fmt:message key='modifyEmpsecurity0066'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="average_wage" inputName="<fmt:message key='modifyEmpsecurity0066'/>" value="<%=RmStringHelper.prt(resultVo.getAverage_wage())%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='modifyEmpsecurity0068'/></td>
            <td class="td_2">
                     <r:comboSelect id="com2" name="stop_type_id" 
                    queryAction="/FAERP/EmpsecurityAction.do?cmd=getStopType"
                    textField="stop_type_name" 
                    valueField="stop_type_id" 
                    xpath="EmpsecurityVo"                   
                    messagekey='modifyEmpsecurity0037'
                    value="<%=RmStringHelper.prt(resultVo.getStop_type_id())%>"
                    width="155px">
                      <h:param name="security_group_id" value="<%=RmStringHelper.prt(resultVo.getSecurity_group_id())%>"/>
                </r:comboSelect>
            </td>
            <!--<td class="td_1" ><fmt:message key='modifyEmpsecurity0070'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="old_average_wage" inputName="<fmt:message key='modifyEmpsecurity0070'/>" value="<%=RmStringHelper.prt(resultVo.getOld_average_wage())%>" onkeyup="if(isNaN(value))execCommand('undo')" />
            </td>陈旭<fmt:message key='modifyEmpsecurity0004'/>-->
        </tr>
        <c:choose>
            <c:when test="${requestScope.applytype==1}">
                    <tr>
                        <td class="td_1" ><fmt:message key='modifyEmpsecurity0073'/></td>
                        <td class="td_2" >
                            <input type="text" class="text_field" name="next_cust_name"  value="<%=RmStringHelper.prt(resultVo.getNext_cust_name())%>" />
                        </td>
                        <td class="td_1" ><fmt:message key='modifyEmpsecurity0074'/></td>
                        <td class="td_2" >
                            <input type="text" class="text_field" name="nextcust_account"  value="<%=RmStringHelper.prt(resultVo.getNextcust_account())%>" />
                        </td>
                        <td class="td_1"><fmt:message key='modifyEmpsecurity0075'/></td>
                        <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='modifyEmpsecurity0075'/>" value="<%=RmStringHelper.prt(resultVo.getTransact_date(),10)%>" readonly="readonly" /></td>
                    </tr>
             </c:when>
                
        </c:choose>
    </table>
</div>

<div style="padding: 8 10 8 8;">
<div class="xz_title"><LABEL><fmt:message key='modifyEmpsecurity0077'/></LABEL></div>
    <div id="ccParent1" class="button"> 
    <div class="button_right">
                <ul>
                    <c:if test="${isModify=='1'}"><li class="d"><a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li></c:if>
                </ul>
         </div>
         <div class="clear"></div>            
    </div>
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=queryEmpsecurityItem" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=applySecurity" width="90%"
        xpath="EmpsecurityitemVo"
        submitXpath="EmpsecurityitemVo"
        paramFormId="datacell_formid" height="200px"
        pageSize="-1"
        >
      <r:field fieldName="product_name" messagekey='modifyEmpsecurity0078' width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="security_product_name" messagekey='modifyEmpsecurity0079' width="100px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="base" messagekey='modifyEmpsecurity0080' width="100px" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        <h:text/>
      </r:field>
      <r:field fieldName="e_ratio" messagekey='modifyEmpsecurity0081' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="p_ratio" messagekey='modifyEmpsecurity0082' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="money" messagekey='modifyEmpsecurity0083' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        <h:text/>
      </r:field>
      
      <r:field fieldName="e_money" messagekey='modifyEmpsecurity0084' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
            <h:text />      
      </r:field>
      
      <r:field fieldName="p_money" messagekey='modifyEmpsecurity0085' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
      </r:field>

    </r:datacell>
    </div>
    
    <div style="padding: 8 10 8 8;">
        <div class="xz_title"><LABEL><fmt:message key='modifyEmpsecurity0086'/></LABEL></div>
        <div id="ccParent1" class="button"> 
        <div class="button_right">
                <ul>
                <c:if test="${isModify=='1'}">
                    <li class="c"><a onClick="javascript:toAdd_onClick2();"><fmt:message key="insert"/> </a></li>
                    <li class="d"><a onClick="javascript:deleteMulti_onClick2();"><fmt:message key="delete"/> </a> </li>
                    </c:if>
                </ul>
         </div>
         <div class="clear"></div>            
    </div>
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=queryEmpsecuritysupply" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=applySecurity" width="90%"
        xpath="EmpsecuritysupplyVo"
        submitXpath="EmpsecuritysupplyVo"
        paramFormId="datacell_formid" height="200px"
        pageSize="-1"
        >
      <r:field fieldName="start_month" messagekey='modifyEmpsecurity0087' width="100px" >
            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" />  
      </r:field>
      
      <r:field fieldName="end_month" messagekey='modifyEmpsecurity0089' width="100px" >
        <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" />
      </r:field>
      
      <r:field fieldName="fund_month" messagekey='modifyEmpsecurity0042' width="100px" >
            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" />      
      </r:field>
      
      <r:field fieldName="base" messagekey='modifyEmpsecurity0080' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
            <h:text validateAttr="type=double;allowNull=true;totalDigit=18;fracDigit=2"/>      
      </r:field>
      
      <r:field fieldName="month_inback" messagekey='modifyEmpsecurity0094' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        
      </r:field>
      <r:field fieldName="money" messagekey='modifyEmpsecurity0083' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        
      </r:field>
      <r:field fieldName="e_money" messagekey='modifyEmpsecurity0084' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
          
      </r:field>
      
      <r:field fieldName="p_money" messagekey='modifyEmpsecurity0085' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
       
      </r:field>
      
      <r:field fieldName="remarks" messagekey='modifyEmpsecurity0098' width="100px" >
        <h:text />      
      </r:field>
      
    </r:datacell>
    </div>

<div class="foot_button">
<c:if test="${isModify=='1'}">
    <input type="button" class="foot_icon_1" value='<fmt:message key='modifyEmpsecurity0099'/>'  onclick="javascript:save_onClick();" />
</c:if>
<input type="button" class="foot_icon_1" value='<fmt:message key='modifyEmpsecurity0100'/>'  onclick="javascript:back_onClick();" />
</div>
</div>
</div>
</h:form>
<script language="javascript">
    var datasetList = [];
    var dlIndex = 0;
    $id("datacell2").isHeadEvent = false;
    //<fmt:message key='modifyEmpsecurity0086'/>加载完后初始化<fmt:message key='modifyEmpsecurity0104'/>
    $id("datacell2").afterLoadData = function(){
        var security_group_id = $name("security_group_id").value;
        var emp_post_id =$name("emp_post_id").value;
        var ds = $id("datacell2").dataset;
            //alert(ds.getLength());
        for(var i=0;i<ds.getLength();i++){
            var enCur = ds.get(i);
            //var emp_order_id =enCur.getProperty("emp_order_id");
            //var start_month = enCur.getProperty("start_month");
            //var end_month = enCur.getProperty("end_month");
            var security_supply_id =enCur.getProperty("id");
            var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=queryEmpsecuritySupplyItem");
            myAjax.addParam("security_supply_id", security_supply_id);
            myAjax.addParam("security_group_id", security_group_id);
            myAjax.submit();
            var xmlDom = myAjax.retDom;
            var dataset1 = Dataset.create(xmlDom,"root/data/EmpsecuritysupplyitemVo","EmpsecuritysupplyitemVo");
            datasetList.push(dataset1);
            dlIndex ++;
        }
        
    }
    
    //实现afterEdit<fmt:message key='modifyEmpsecurity0102'/>，重新计算<fmt:message key='modifyEmpsecurity0083'/>
    $id("datacell2").afterEdit=function(newValue,oldValue){
        var curCell=$id("datacell2").activeCell;
        var curRowNum = $id("datacell2").activeRow.rowIndex;
        var curCellNum = $id("datacell2").activeCell.cellIndex;
        var entCur=this.getEntityByCell(curCell);
        var start_month = entCur.getProperty("start_month");
        var end_month = entCur.getProperty("end_month");
        var base = entCur.getProperty("base");
        var money = entCur.getProperty("money");
        var e_money = entCur.getProperty("e_money");
        var p_money = entCur.getProperty("p_money");
        var social_unit_id = $name("social_unit_id_value").value;
        var social_unit_id_name = $name("social_unit_id").value;
        var cust_id = $name("cust_id").value;
        //alert(start_month+"--"+end_month+"--"+base);
        var security_group_id = $name("security_group_id").value;
        var emp_post_id =$name("emp_post_id").value;
        if (curCellNum == 0||curCellNum == 1||curCellNum== 3){
        if(start_month!=''&&end_month!=''){
            var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=queryAddSupplyItemByStartAndEndMonth");
            myAjax.addParam("security_group_id", security_group_id);
            myAjax.addParam("start_month", start_month);
            myAjax.addParam("end_month", end_month);
            myAjax.addParam("post_id", emp_post_id);
            myAjax.addParam("social_unit_id_value", social_unit_id);
            myAjax.addParam("social_unit_id", social_unit_id_name);
            myAjax.addParam("cust_id", cust_id);
            myAjax.submit();
            var xmlDom = myAjax.retDom;
            var dataset2 = Dataset.create(xmlDom,"root/data/EmpsecuritysupplyitemVo","EmpsecuritysupplyitemVo");
            if(dataset2!=""){
                datasetList.splice(curRowNum,1,dataset2);
            }
        }
            if(start_month==''||end_month==''||base==''){
                return;
            }
            calculatSupply(entCur,curRowNum,start_month,end_month,base);
        }
    }
    
    //实现beforeEdit<fmt:message key='modifyEmpsecurity0102'/>cell,colInde,rowIndex,entity,field,datacell
    $id("datacell2").onClickCell=function(cell,colIndex,rowIndex){
        if (colIndex == 4||colIndex==5||colIndex==6||colIndex==7){
            var security_group_id = $name("security_group_id").value;
            var isModify = $name("isModify").value;
            //alert(security_group_id);
            var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listSecuritySupplyItem.jsp?security_group_id="+security_group_id+"&isModify="+isModify;
            //var curRowNum = $id("datacell2").activeRow.rowIndex;
            var entCur=this.getEntityByCell(cell);
            var start_month = entCur.getProperty("start_month");
            var end_month = entCur.getProperty("end_month");
            var countMonth=month6Subtration(start_month,end_month);
            var base = entCur.getProperty("base");
            var dcNew = datasetList[rowIndex].clone(true);
            var argument=[];
            argument.push(dcNew);
            argument.push(countMonth);
            argument.push(base);
            url += '&_ts='+(new Date()).getTime(); 
            if(start_month==''||end_month==''){
                alert('<fmt:message key='modifyEmpsecurity0103'/>');
                return;
            }
            showModalCenter(url, [argument], callBack, 700, 320, "补缴明细");  //显示<fmt:message key='modifyEmpsecurity0104'/>记录
            }
        return true;
    } 
    
    //弹出<fmt:message key='modifyEmpsecurity0104'/>记录
    function showsupplyitem(){
        
    }
      //回调函数--<fmt:message key='modifyEmpsecurity0105'/>
      function callBack(reg) {
        var sum=0;
        var sum_e=0;
        var sum_p=0;
        var curCell=$id("datacell2").activeCell;
        var entCur=$id("datacell2").getEntityByCell(curCell);
        var curRowNum = $id("datacell2").activeRow.rowIndex;
        var start_month = entCur.getProperty("start_month");
        var end_month = entCur.getProperty("end_month");
        var countMonth=month6Subtration(start_month,end_month);
        datasetList[curRowNum]=reg.clone(true);
        var ds=datasetList[curRowNum];
        //alert(ds.getLength());
        var j=0;
        for(var i=0;i<reg.getLength();i++){
            var enCur=reg.get(i)
            var enCur1=ds.get(j);
            if(enCur.status==3||enCur.status==4){
               ds.removeEntity(enCur1, true);
               continue;
             }
             j++;
        }
        //alert(ds.getLength());
        for(var i=0;i<ds.getLength();i++){
           var enCurItem = ds.get(i);
           //if(enCurItem.status==3||enCurItem.status==4){
           //     continue;
           //}
           var item_money=enCurItem.getProperty("money");
           var item_e_money=enCurItem.getProperty("e_money");
           var item_p_money=enCurItem.getProperty("p_money");
           sum+=getNumber(item_money);
           sum_e+=getNumber(item_e_money);
           sum_p+=getNumber(item_p_money);
        }
        entCur.setProperty("month_inback",floatRound(sum/countMonth,2));
        entCur.setProperty("money",floatRound(sum,2));
        entCur.setProperty("e_money",floatRound(sum_e,2));
        entCur.setProperty("p_money",floatRound(sum_p,2));
        //$id("datacell2").refresh();
      }
    
    function reOrg(lists){
        var j = 0;
        for (var i=0; i < lists.length; i++){
            if (lists[i] != null && lists[i] != ''){
               lists[j] = lists[i];
               j++;
            }
       }
   }
    //新增时new<fmt:message key='modifyEmpsecurity0106'/>dataset
    function newDataset(){
        var security_group_id = $name("security_group_id").value;
        var social_unit_id = $name("social_unit_id_value").value;
        var social_unit_id_name = $name("social_unit_id").value;
        var cust_id = $name("cust_id").value;
        var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=queryAddSupplyItem");
        myAjax.addParam("security_group_id", security_group_id);
        myAjax.addParam("social_unit_id_value", social_unit_id);
        myAjax.addParam("social_unit_id", social_unit_id_name);
        myAjax.addParam("cust_id", cust_id);
        myAjax.submit();
        var xmlDom = myAjax.retDom;
        var dataset1 = Dataset.create(xmlDom,"root/data/EmpsecuritysupplyitemVo","EmpsecuritysupplyitemVo");
        datasetList.push(dataset1);
        dlIndex ++;
    }
    function deleteMulti_onClick(){ 
            $id("datacell1").deleteRow();
        }

    //添加一行
    function toAdd_onClick2() { 
            $id("datacell2").addRow();
            newDataset();
    }
        //添加一行
    function deleteMulti_onClick2() { 
            $id("datacell2").deleteRow();
    }
    //删除一行
    $id("datacell2").beforeDel = function(row){ 
            datasetList.splice(row.rowIndex,1);
            //delete datasetList[row.rowIndex];
            //reOrg(datasetList);
            dlIndex--;
                   
    }   
    //检验年月格式（yyyyMM）
     function f_check_yearMonth(obj){
        var yearMonth = obj.value;
        //var msg="<fmt:message key='modifyEmpsecurity0107'/>";
        //alert(msg);
          if(yearMonth=="") return true;
          var rtn=true;
          var s=yearMonth+"";
          //alert(s.length);
          if(s.length!=6) rtn=false;
          if(!checkNumber1(yearMonth))rtn=false; //必须全是数字
          var year=s.substring(0,4);
          var month=s.substring(4,6);
          if(parseFloat(year)<1990 || parseFloat(year)>2050) rtn=false;
          if(parseFloat(month)<1 || parseFloat(month)>12) rtn=false;
          
          if(!rtn){
             f_alert(obj,"输入格式不正确!");     
          }  
          return rtn;        
        return true;
    }
    
    // 1.<fmt:message key='modifyEmpsecurity0109'/>
    function checkNumber1(str){
    var rc=true;
    if (str+"" == "undefined" || str == null){
        rc=false;
    } else if(str.length==0){
    rc=false;
    } else {
    for(i=0;i<str.length;i++){
        if(str.charAt(i)<'0' || str.charAt(i)>'9'){
            rc=false;
            break;
        }
    }
    }
    return rc;
}

    //改变<fmt:message key='modifyEmpsecurity0087'/>、<fmt:message key='modifyEmpsecurity0110'/>、<fmt:message key='modifyEmpsecurity0111'/>--
    function calculatSupply(entCur,curRowNum,start_month,end_month,base){
        var sum_money=0;
        var sum_e_money=0;
        var sum_p_money=0;
        var sum_month_money=0;
        var countMonth=month6Subtration(start_month,end_month);
        var dataset1=datasetList[curRowNum];
        for(var j=0;j<dataset1.getLength();j++){
            var enCurItem = dataset1.get(j);
            var item_money = getNumber(enCurItem.getProperty("money"));//<fmt:message key='modifyEmpsecurity0083'/>
            var item_e_money = getNumber(enCurItem.getProperty("e_money"));//<fmt:message key='modifyEmpsecurity0084'/>
            var item_p_money = getNumber(enCurItem.getProperty("p_money"));//<fmt:message key='modifyEmpsecurity0085'/>
            var item_e_ratio = getNumber(enCurItem.getProperty("e_ratio"));//企业比列
            var item_p_ratio = getNumber(enCurItem.getProperty("p_ratio"));//个人比列
            var e_caculate_type = enCurItem.getProperty("e_caculate_type_bd");//企业舍入
            var p_caculate_type = enCurItem.getProperty("p_caculate_type_bd");//个人舍入
            var e_precision = enCurItem.getProperty("e_precision_bd");//企业精度
            var p_precision = enCurItem.getProperty("p_precision_bd");//个人精度
            if(item_e_ratio==null||item_p_ratio==null){
                return ;
            }
            item_e_money = calInsurance(getNumber(base),item_e_ratio,0,e_precision,e_caculate_type);
            item_p_money = calInsurance(getNumber(base),item_p_ratio,0,p_precision,p_caculate_type);
            item_money = item_e_money+item_p_money
            var sum_item_money=floatRound(item_money*countMonth,2).toFixed(2);
            var sum_item_e_money=floatRound(item_e_money*countMonth,2).toFixed(2);
            var sum_item_p_money=floatRound(item_p_money*countMonth,2).toFixed(2);
            sum_money+=getNumber(sum_item_money);
            sum_e_money+=getNumber(sum_item_e_money);
            sum_p_money+=getNumber(sum_item_p_money);
            sum_month_money+=item_money;
            enCurItem.setProperty("base",base);
            enCurItem.setProperty("money",sum_item_money);
            enCurItem.setProperty("e_money",sum_item_e_money);
            enCurItem.setProperty("p_money",sum_item_p_money);         
        }
        entCur.setProperty("month_inback",floatRound(sum_month_money,2));
        entCur.setProperty("money",floatRound(sum_money,2));
        entCur.setProperty("e_money",floatRound(sum_e_money,2));
        entCur.setProperty("p_money",floatRound(sum_p_money,2));
    }
</script>
</body>
</fmt:bundle>
</html>
