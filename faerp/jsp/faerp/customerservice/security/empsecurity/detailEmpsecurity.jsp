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
    EmpsecurityVo resultVo = null;  //定义<fmt:message key='detailEmpsecurity0113'/>临时的vo变量
    resultVo = (EmpsecurityVo)request.getAttribute(IEmpsecurityConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    //RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.detailEmpsecurity_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='detailEmpsecurity0051'/></title>
<script language="javascript">
    // new dataset list
    var dataset_list = new Array();
    function back_onClick(){  //返回列表页面
        window.close();
    }
    
    //<fmt:message key='detailEmpsecurity0106'/>
    function transaction_onClick(){
        if(checkAllCont()){
            var ds1 = $id("datacell1").dataset;//<fmt:message key='detailEmpsecurity0084'/>
            changeDSStatus($id("datacell1"));
            var ds2 = $id("datacell2").dataset;//<fmt:message key='detailEmpsecurity0095'/>
            var ds3 = new Dataset();//<fmt:message key='detailEmpsecurity0095'/>明细
            //<fmt:message key='detailEmpsecurity0095'/>与<fmt:message key='detailEmpsecurity0095'/>明细绑定
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
                    enCurItem.name="EpemporderitemVo";
                    enCurItem.setProperty("parentIndex",i);
                }
                ds3.appendDataset(chdataset);
                index++;
            }
            var action = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=inTransactionSecurity";
            //将两个datacell的xml<fmt:message key='detailEmpsecurity0005'/>
            var xmlSubmit = ds1.toString();
            xmlSubmit +=  ds2.toString();
            xmlSubmit +=  ds3.toString();
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
    
    //保存<fmt:message key='detailEmpsecurity0019'/>
    function save_onClick(){
        var action = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=simpleSaveSecurity";
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
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            if( returnNode ) {
                alert(""+myAjax.getProperty("returnValue"));
                window['returnValue'] = ""+myAjax.getProperty("returnValue");
                window.close();
                window.opener.callBack(myAjax.getProperty("returnValue"));
            }
    }
    
    function checkAllCont(){
        var frm=$id("datacell_formid");
        if( !checkForm(frm) ) {
          alert("<fmt:message key='detailEmpsecurity0006'/>,<fmt:message key='detailEmpsecurity0007'/>");
          return false;
        }
        var start_month=$id("start_month").value;//<fmt:message key='detailEmpsecurity0050'/>
        var end_month=$id("end_month").value;//缴费截止月
        var fund_month=$id("fund_month").value;//<fmt:message key='detailEmpsecurity0054'/>
        var transact_type_id=$name("transact_type_id").value;//<fmt:message key='detailEmpsecurity0048'/>
        //如果为一次性<fmt:message key='detailEmpsecurity0095'/>，只补 <fmt:message key='detailEmpsecurity0008'/>
        var selectedEnt = $id("com1").getSelectEntity();
        if(selectedEnt.getProperty("is_oneoff")=='1'){//是否一次性<fmt:message key='detailEmpsecurity0095'/>
        $name('is_oneoff').value=selectedEnt.getProperty("is_oneoff");
            if(end_month==""){
                alert("<fmt:message key='detailEmpsecurity0009'/>");
                return false;
            }
            var flag=month6Subtration(end_month,fund_month);
            //alert(flag);
            if(flag<=1){
                alert("<fmt:message key='detailEmpsecurity0010'/>");
                return false;
            }
            
        }
        var flag2=month6Subtration(start_month,fund_month);
        if(end_month!=''&& end_month!=null){
            var flag1=month6Subtration(start_month,end_month);
            if(flag1<1){
                alert("<fmt:message key='detailEmpsecurity0011'/>");
            return false;
            }
        }
        if(flag2<1){
            alert("<fmt:message key='detailEmpsecurity0012'/>");
            return false;
        }
        if(transact_type_id==''){
            alert("<fmt:message key='detailEmpsecurity0013'/>");
            return false;
        }
        
        //检验<fmt:message key='detailEmpsecurity0095'/>信息（）
        var ds = $id("datacell2").dataset;
        for(var i=0;i<ds.getLength();i++){
            var enCur = ds.get(i);
            if(enCur.status==3||enCur.status==4){
                continue;
            }
            var s_start_month = enCur.getProperty("start_month");
            var s_end_month = enCur.getProperty("end_month");
            var s_fund_month = enCur.getProperty("end_month");
            if(s_start_month==""){
                alert("<fmt:message key='detailEmpsecurity0014'/>");
                return false;
            }
            if(s_end_month==""){
                alert("<fmt:message key='detailEmpsecurity0015'/>");
                return false;
            }
            if(s_fund_month==""){
                alert("<fmt:message key='detailEmpsecurity0016'/>");
                return false;
            }
            var s_flag1=month6Subtration(s_start_month,s_end_month);
            var s_flag2=month6Subtration(s_start_month,s_fund_month);
            if(s_flag1<1){
                alert("<fmt:message key='detailEmpsecurity0017'/>");
                return false;
            }
            if(s_flag2<1){
                alert("<fmt:message key='detailEmpsecurity0018'/>");
                return false;
            }
        }
        //return false;
        return true;
    }
    
    function changeDSStatus(datacell){
        var ds=datacell.dataset;
        datacell.isModefied = true;
        for(var i=0;i<ds.getLength();i++){
            var enCur=ds.get(i);
            enCur.name="EmpsecurityitemVo";
        }
    }
    
     //公积金选择框回调函数
    function rtnFuncEmpAccount(arg) {
     var lookup = $id("emp_account");
            lookup.value = arg[1];
            lookup.displayValue = arg[1];
            return false;
    }
    
    function changeIt(){
        var displayValue = $id("emp_account_input").value;
        $id("emp_account").value =displayValue ;
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
    <input type="hidden" name="is_oneoff" value=""/>
    <input type="hidden" name="emp_id" value="<%=RmStringHelper.prt(resultVo.getEmp_id())%>"/>
<div id="right">
<div class="ringht_s">

<p></p>
<div class="xz_title"><fmt:message key='detailEmpsecurity0019'/></div>
<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0020'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0020'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0022'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0022'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0024'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0024'/>" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0026'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0026'/>" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0028'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0028'/>" value="<%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0030'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0030'/>" value="<%=RmStringHelper.prt(resultVo.getId_card())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0032'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0032'/>" value="<%=RmStringHelper.prt(resultVo.getApply_on_post_date(),10)%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0034'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0034'/>" value="<%=RmStringHelper.prt(resultVo.getOn_post_date(),10)%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0036'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;"  inputName="<fmt:message key='detailEmpsecurity0036'/>" value="<%=RmStringHelper.prt(resultVo.getCharge_start_date(),10)%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0053'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;"  inputName="<fmt:message key='detailEmpsecurity0053'/>" value="<%=RmStringHelper.prt(resultVo.getGroup_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0038'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;"  inputName="<fmt:message key='detailEmpsecurity0038'/>" value="<%=RmStringHelper.prt(resultVo.getApply_man_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0040'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" style="background:#f0f0f0;"  inputName="<fmt:message key='detailEmpsecurity0040'/>" value="<%=RmStringHelper.prt(resultVo.getApply_date(),10)%>" readonly="readonly" />
            </td>
        </tr>
        <!-- <fmt:message key='detailEmpsecurity0042'/> -->
        <%if(resultVo.getSecurity_group_id().equals("1099110700000000156")){ %>
            <tr>
             
	            <td class="td_1" ><fmt:message key='detailEmpsecurity0043'/></td>
	            <td class="td_2" >
	               <input type="text" class="text_field" name="emp_base_account" style="background:#f0f0f0;" inputName="<fmt:message key='detailEmpsecurity0043'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_base_account())%>" readonly="readonly" />
<!--	                   <input type="text" style="background:#f0f0f0;" name="emp_base_account" value="<%=RmStringHelper.prt(resultVo.getEmp_base_account())%>" readonly="true"/>-->
	            </td>
	            
	            <td class="td_1" ><fmt:message key='detailEmpsecurity0045'/></td>
                <td class="td_2" >
                    <input type="text" class="text_field" name="emp_account" id="emp_account" value="<%=RmStringHelper.prt(resultVo.getEmp_account())%>"/>
                </td>
	            <td class="td_1" ><span>*</span><fmt:message key='detailEmpsecurity0046'/></td>
	            <td class="td_2" >
	                <input type="text" class="text_field" name="social_unit_id" style="background:#f0f0f0;"  inputName="<fmt:message key='detailEmpsecurity0046'/>" value="<%=RmStringHelper.prt(resultVo.getSocial_unit_name())%>" readonly="readonly" />
	            </td>
	        </tr>
	        <tr>
	            <td class="td_1" ><fmt:message key='detailEmpsecurity0048'/></td>
	            <td class="td_2" >
	                <r:comboSelect id="com1" name="transact_type_id" 
	                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
	                    textField="type_name" 
	                    valueField="id" 
	                    xpath="SecuritygroupnewVo"                   
	                    messagekey='detailEmpsecurity0049'
	                    value="<%=RmStringHelper.prt(resultVo.getTransact_type_id())%>"
	                    width="200px">
	                    <h:param name="security_group_id" value="<%=RmStringHelper.prt(resultVo.getSecurity_group_id())%>"/>
	                </r:comboSelect>
	            </td>
	            <td class="td_1" ><span>*</span><fmt:message key='detailEmpsecurity0050'/></td>
	            <td class="td_2" >
	                <h:text id="start_month"  name="start_month"  value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" size="28"/>
	            </td>
	            <td class="td_1" ><fmt:message key='detailEmpsecurity0052'/></td>
	            <td class="td_2" >
	                <h:text id="end_month"  name="end_month"  value="<%=RmStringHelper.prt(resultVo.getEnd_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;" size="28"/>
	            </td>
	      </tr>
	      <tr>
            <td class="td_1" ><span>*</span><fmt:message key='detailEmpsecurity0054'/></td>
            <td class="td_2" >
                <% if(Integer.parseInt(resultVo.getFund_month())<Integer.parseInt(resultVo.getStart_month())){
                    %>
                    <h:text id="fund_month"  name="fund_month"  value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" size="28"/>
                    <%
                  }else{
                      %>
                      <h:text id="fund_month"  name="fund_month"  value="<%=RmStringHelper.prt(resultVo.getFund_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" size="28"/>
                      <%
                  }
                %>
            </td>
            <td colspan="4" class="td_2" >
        </tr>
        <%}else{ %>
        <tr>
             <c:choose>
            <c:when test="${requestScope.applytype==1}">
                  <td class="td_1" ><fmt:message key='detailEmpsecurity0057'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="emp_account" id="emp_account" value="<%=RmStringHelper.prt(resultVo.getEmp_account())%>"/>
            </c:when>
            <c:otherwise>
                  <td class="td_1" ><fmt:message key='detailEmpsecurity0058'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" class="text_field" name="serial_no" inputName="<fmt:message key='detailEmpsecurity0058'/>" value="<%=RmStringHelper.prt(resultVo.getSerial_no())%>" readonly="readonly" />
            </td>
            </c:otherwise>
        </c:choose>
            
            <td class="td_1" ><span>*</span><fmt:message key='detailEmpsecurity0046'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="social_unit_id" style="background:#f0f0f0;"  inputName="<fmt:message key='detailEmpsecurity0046'/>" value="<%=RmStringHelper.prt(resultVo.getSocial_unit_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0048'/></td>
            <td class="td_2" >
                <r:comboSelect id="com1" name="transact_type_id" 
                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
                    textField="type_name" 
                    valueField="id" 
                    xpath="SecuritygroupnewVo"                   
                    messagekey='detailEmpsecurity0049'
                    value="<%=RmStringHelper.prt(resultVo.getTransact_type_id())%>"
                    width="200px">
                    <h:param name="security_group_id" value="<%=RmStringHelper.prt(resultVo.getSecurity_group_id())%>"/>
                </r:comboSelect>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span>*</span><fmt:message key='detailEmpsecurity0050'/></td>
            <td class="td_2" >
                <h:text id="start_month"  name="start_month"  value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" size="28"/>
            </td>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0052'/></td>
            <td class="td_2" >
                <h:text id="end_month"  name="end_month"  value="<%=RmStringHelper.prt(resultVo.getEnd_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;" size="28"/>
            </td>
            <td class="td_1" ><span>*</span><fmt:message key='detailEmpsecurity0054'/></td>
            <td class="td_2" >
                <% if(Integer.parseInt(resultVo.getFund_month())<Integer.parseInt(resultVo.getStart_month())){
                    %>
                    <h:text id="fund_month"  name="fund_month"  value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" size="28"/>
                    <%
                  }else{
                      %>
                      <h:text id="fund_month"  name="fund_month"  value="<%=RmStringHelper.prt(resultVo.getFund_month())%>" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" size="28"/>
                      <%
                  }
                %>
            </td>
        </tr>
        <%} %>
        
        <tr>
            <td class="td_1"><fmt:message key='detailEmpsecurity0071'/></td>
            <td colspan="6" class="td_2">
                 <textarea rows="2" name="back_reason" style="background:#f0f0f0;"  style="width:600px" readonly="readonly" inputName="<fmt:message key='detailEmpsecurity0071'/>"><%=RmStringHelper.prt(resultVo.getBack_reason())%></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='detailEmpsecurity0073'/></td>
            <td colspan="6" class="td_2">
                 <textarea rows="2" name="transact_remarks" style="width:600px" inputName="<fmt:message key='detailEmpsecurity0073'/>"><%=RmStringHelper.prt(resultVo.getTransact_remarks())%></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1">精灵之手备注</td>
            <td colspan="6" class="td_2">
                 <textarea rows="2" name=feedback_info style="width:600px" inputName="精灵之手备注"><%=RmStringHelper.prt(resultVo.getFeedback_info())%></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailEmpsecurity0075'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="old_cust_name" inputName="<fmt:message key='detailEmpsecurity0075'/>" value="<%=RmStringHelper.prt(resultVo.getOld_cust_name())%>"  />
            </td>
            <!--<td class="td_1" ><fmt:message key='detailEmpsecurity0077'/></td><fmt:message key='detailEmpsecurity0078'/>-->
            <td class="td_1" ><fmt:message key='detailEmpsecurity0079'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="average_wage" inputName="<fmt:message key='detailEmpsecurity0079'/>" value="<%=RmStringHelper.prt(resultVo.getAverage_wage())%>"  onkeyup="if(isNaN(value))execCommand('undo')" />
            </td>
            <td class="td_1"></td>
            <td class="td_2"></td>
            <!--<td class="td_1" ><fmt:message key='detailEmpsecurity0081'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="old_average_wage" inputName="<fmt:message key='detailEmpsecurity0081'/>" value="<%=RmStringHelper.prt(resultVo.getOld_average_wage())%>" onkeyup="if(isNaN(value))execCommand('undo')" />
            </td><fmt:message key='detailEmpsecurity0078'/>-->
        </tr>
    </table>
</div>

<div style="padding: 8 10 8 8;">
<div class="xz_title"><LABEL><fmt:message key='detailEmpsecurity0084'/></LABEL></div>
    <div id="ccParent1" class="button"> 
    <div class="button_right">
                <ul>
                    <li class="d"><a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                </ul>
         </div>
         <div class="clear"></div>            
    </div>
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EpemporderitemAction.do?cmd=queryOrderItem" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=applySecurity" width="90%"
        xpath="EpemporderitemVo"
        submitXpath="EmpsecurityitemVo"
        paramFormId="datacell_formid" height="200px"
        pageSize="-1"
        >
      <r:field fieldName="product_name" messagekey='detailEmpsecurity0085' width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="security_product_name" messagekey='detailEmpsecurity0086' width="100px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="base" messagekey='detailEmpsecurity0087' width="100px" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        <h:text/>
      </r:field>
      <r:field fieldName="e_ratio" messagekey='detailEmpsecurity0088' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="p_ratio" messagekey='detailEmpsecurity0089' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="money" messagekey='detailEmpsecurity0090' width="100px"  onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        <h:text/>
      </r:field>
      
      <r:field fieldName="e_money" messagekey='detailEmpsecurity0091' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
            <h:text />      
      </r:field>
      
      <r:field fieldName="p_money" messagekey='detailEmpsecurity0092' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
      </r:field>
      
      <r:field fieldName="e_add_money" messagekey='detailEmpsecurity0093' width="100px" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
            <h:text />      
      </r:field>
      
      <r:field fieldName="p_add_money" messagekey='detailEmpsecurity0094' width="100px" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
            <h:text />      
      </r:field>
    </r:datacell>
    </div>
    
    <div style="padding: 8 10 8 8;">
        <div class="xz_title"><LABEL><fmt:message key='detailEmpsecurity0095'/></LABEL></div>
        <div id="ccParent1" class="button"> 
        <div class="button_right">
                <ul>
                    <li class="c"><a onClick="javascript:toAdd_onClick2();"><fmt:message key="insert"/> </a></li>
                    <li class="d"><a onClick="javascript:deleteMulti_onClick2();"><fmt:message key="delete"/> </a> </li>
                </ul>
         </div>
         <div class="clear"></div>            
    </div>
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=simpleEmpsecuritysupply" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=applySecurity" width="90%"
        xpath="EmpsecuritysupplyVo"
        submitXpath="EmpsecuritysupplyVo"
        paramFormId="datacell_formid" height="200px"
        >
      <r:field fieldName="start_month" messagekey='detailEmpsecurity0096' width="100px" >
            <h:text validateAttr="type=yearMonth;allowNull=false" />  
      </r:field>
      
      <r:field fieldName="end_month" messagekey='detailEmpsecurity0097' width="100px" >
        <h:text validateAttr="type=yearMonth;allowNull=false" />
      </r:field>
      
      <r:field fieldName="fund_month" messagekey='detailEmpsecurity0054' width="100px" >
            <h:text validateAttr="type=yearMonth;allowNull=false"/>      
      </r:field>
      
      <r:field fieldName="base" messagekey='detailEmpsecurity0087' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
            <h:text validateAttr="type=double;allowNull=true;totalDigit=18;fracDigit=2"/>      
      </r:field>
      
      <r:field fieldName="month_inback" messagekey="detailEmpsecurity0100" width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        
      </r:field>
      <r:field fieldName="money" messagekey='detailEmpsecurity0090' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
       
      </r:field>
      <r:field fieldName="e_money" messagekey='detailEmpsecurity0091' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
         
      </r:field>
      
      <r:field fieldName="p_money" messagekey='detailEmpsecurity0092' width="100px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
     
      </r:field>
      
      <r:field fieldName="remarks" messagekey='detailEmpsecurity0104' width="100px" >
        <h:text />      
      </r:field>
      
    </r:datacell>
    </div>

<div class="foot_button">
<input type="button" class="foot_icon_2" value='<fmt:message key='detailEmpsecurity0105'/>'  onclick="javascript:save_onClick();" />
<input type="button" class="foot_icon_1" value='<fmt:message key='detailEmpsecurity0106'/>'  onclick="javascript:transaction_onClick();" />
<input type="button" class="foot_icon_1" value='<fmt:message key='detailEmpsecurity0107'/>'  onclick="javascript:back_onClick();" />
</div>
</div>
</div>
</h:form>
<script language="javascript">
    var datasetList = [];
    var dlIndex = 0;
    $id("datacell2").isHeadEvent = false;
    //<fmt:message key='detailEmpsecurity0095'/>加载完后初始化<fmt:message key='detailEmpsecurity0095'/>明细
    $id("datacell2").afterLoadData = function(){
        var security_group_id = $name("security_group_id").value;
        var emp_post_id =$name("emp_post_id").value;
        var social_unit_id_value =$name("social_unit_id_value").value;
        var social_unit_id =$name("social_unit_id").value;
        var cust_id =$name("cust_id").value;
        var ds = $id("datacell2").dataset;
            //alert(ds.getLength());
        for(var i=0;i<ds.getLength();i++){
            var enCur = ds.get(i);
            var emp_order_id =enCur.getProperty("emp_order_id");
            var start_month = enCur.getProperty("start_month");
            var end_month = enCur.getProperty("end_month");
            var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=simpleSupplyItem");
            myAjax.addParam("security_group_id", security_group_id);
            myAjax.addParam("emp_post_id", emp_post_id);
            myAjax.addParam("emp_order_id", emp_order_id);
            myAjax.addParam("social_unit_id_value", social_unit_id_value);
            myAjax.addParam("social_unit_id", social_unit_id);
            myAjax.addParam("cust_id", cust_id);
            myAjax.addParam("start_month", start_month);
            myAjax.addParam("end_month", end_month);
            myAjax.submit();
            var xmlDom = myAjax.retDom;
            var dataset1 = Dataset.create(xmlDom,"root/data/EpemporderitemVo","EpemporderitemVo");
            var countMonth=month6Subtration(start_month,end_month);
            for(var j=0;j<dataset1.getLength();j++){
                 var enCur1 = dataset1.get(j);
                 var money=getNumber(enCur1.getProperty("money"));
                 var e_money=getNumber(enCur1.getProperty("e_money"));
                 var p_money=getNumber(enCur1.getProperty("p_money"));
                 var sum_money=floatRound(money*countMonth,2).toFixed(2);
                 var sum_e_money=floatRound(e_money*countMonth,2).toFixed(2);
                 var sum_p_money=floatRound(p_money*countMonth,2).toFixed(2);
                 enCur1.setProperty("money",sum_money);
                 enCur1.setProperty("e_money",sum_e_money);
                 enCur1.setProperty("p_money",sum_p_money)
            }
            datasetList.push(dataset1);
            dlIndex ++;
        }
        
    }
    
    //实现afterEdit<fmt:message key='detailEmpsecurity0109'/>，重新计算<fmt:message key='detailEmpsecurity0090'/>
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
        var security_group_id = $name("security_group_id").value;
        var emp_post_id =$name("emp_post_id").value;
        //newDatasetByStartAndEndMonth(start_month,end_month);
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
    
    //实现beforeEdit<fmt:message key='detailEmpsecurity0109'/>cell,colInde,rowIndex,entity,field,datacell
    $id("datacell2").onClickCell=function(cell,colIndex,rowIndex){
        if (colIndex == 4||colIndex==5||colIndex==6||colIndex==7){
            var security_group_id = $name("security_group_id").value;
            var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listSecuritySupplyItem.jsp?security_group_id="+security_group_id;
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
                alert('<fmt:message key='detailEmpsecurity0110'/>');
                return;
            }
            //$id("datacell2").endEdit();
            //alert("dd");
            showModalCenter(url, [argument], callBack, 700, 300, "补缴明细");  //显示<fmt:message key='detailEmpsecurity0095'/>明细记录
        }
        return false;
    } 
    
    //弹出<fmt:message key='detailEmpsecurity0095'/>明细记录
    function showsupplyitem(){
        
    }
    //回调函数--重新计算<fmt:message key='detailEmpsecurity0095'/><fmt:message key='detailEmpsecurity0090'/>
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
    //新增时new<fmt:message key='detailEmpsecurity0113'/>dataset
    function newDataset(){
        var security_group_id = $name("security_group_id").value;
        var social_unit_id = $name("social_unit_id_value").value;
        var social_unit_id_name = $name("social_unit_id").value;
        var cust_id = $name("cust_id").value;
        //alert(start_month+","+end_month+","+emp_post_id+","+security_group_id);return;
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
    
    //输入起始日期和结束日期触发事件重新计算
    function newDatasetByStartAndEndMonth(start_month,end_month){
        
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
        //var msg="<fmt:message key='detailEmpsecurity0097'/>份";
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
    
    // 1.<fmt:message key='detailEmpsecurity0116'/>
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

    //改变<fmt:message key='detailEmpsecurity0096'/>、<fmt:message key='detailEmpsecurity0117'/>、<fmt:message key='detailEmpsecurity0087'/>后重新计算<fmt:message key='detailEmpsecurity0095'/><fmt:message key='detailEmpsecurity0090'/>，<fmt:message key='detailEmpsecurity0095'/>明细<fmt:message key='detailEmpsecurity0090'/>--
    function calculatSupply(entCur,curRowNum,start_month,end_month,base){
        var sum_money=0;
        var sum_e_money=0;
        var sum_p_money=0;
        var sum_month_money=0;
        var countMonth=month6Subtration(start_month,end_month);
        var dataset1=datasetList[curRowNum];
        for(var j=0;j<dataset1.getLength();j++){
            var enCurItem = dataset1.get(j);
            var item_money = getNumber(enCurItem.getProperty("money"));//<fmt:message key='detailEmpsecurity0090'/>
            var item_e_money = getNumber(enCurItem.getProperty("e_money"));//<fmt:message key='detailEmpsecurity0091'/>
            var item_p_money = getNumber(enCurItem.getProperty("p_money"));//<fmt:message key='detailEmpsecurity0092'/>
            var item_e_ratio = getNumber(enCurItem.getProperty("e_ratio"));//企业比列
            var item_p_ratio = getNumber(enCurItem.getProperty("p_ratio"));//个人比列
            var e_caculate_type = enCurItem.getProperty("e_caculate_type_bd");//企业舍入
            var p_caculate_type = enCurItem.getProperty("p_caculate_type_bd");//个人舍入
            var e_precision = enCurItem.getProperty("e_precision_bd");//企业精度
            var p_precision = enCurItem.getProperty("p_precision_bd");//个人精度
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
