<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.received.finbillimpdata.finbillimpdata_resource" prefix="rayoo.finance.received.finbillimpdata.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='hledetail'/></title>
</head>

<body>
    <form name="form" method="post" id="formDetailData">
        <input type="hidden" id="batch_id" name="batch_id" value="<%=request.getParameter("batch_id")%>"/>
        </br>
        <r:datacell 
               id="celllist1"
               queryAction="/FAERP/FinbillimpdataAction.do?cmd=queryDetailFinbillimpdataData"
               width="100%"
               height="360px"
               xpath="FinbillimpdataVo"
               paramFormId="formDetailData"
               readonly="true"
               >
               <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       
               <r:field fieldName="cust_code" messagekey="cust_code">
                   <h:text/>
               </r:field>
               <r:field fieldName="cust_name" messagekey="cust_name">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_code" messagekey="emp_code">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_name" messagekey="emp_name">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_id_card_no" messagekey="emp_id_card_no">
                   <h:text/>
               </r:field>
               <r:field fieldName="bill_year_month" messagekey="bill_year_month">
                   <h:text/>
               </r:field>
               <r:field fieldName="is_failure" messagekey="is_failure" width="70">
                   <d:select dictTypeId="IS_FOREIGNER"/>
               </r:field>
               <r:field fieldName="failure_reason" messagekey="failure_reason_" width="260">
                   <h:text/>
               </r:field>
               <r:field fieldName="a1" messagekey="a1">
                   <h:text/>
               </r:field>
               <r:field fieldName="a2" messagekey="a2">
                   <h:text/>
               </r:field>
               <r:field fieldName="a3" messagekey="a3">
                   <h:text/>
               </r:field>
               <r:field fieldName="a4" messagekey="a4">
                   <h:text/>
               </r:field>
               <r:field fieldName="a5" messagekey="a5">
                   <h:text/>
               </r:field>
               <r:field fieldName="a6" messagekey="a6">
                   <h:text/>
               </r:field>
               <r:field fieldName="a7" messagekey="a7">
                   <h:text/>
               </r:field>
               <r:field fieldName="a8" messagekey="a8">
                   <h:text/>
               </r:field>
               <r:field fieldName="a9" messagekey="a9">
                   <h:text/>
               </r:field>
               <r:field fieldName="a10" messagekey="a10">
                   <h:text/>
               </r:field>
               <r:field fieldName="a11" messagekey="a11">
                   <h:text/>
               </r:field>
               <r:field fieldName="a12" messagekey="a12">
                   <h:text/>
               </r:field>
               <r:field fieldName="a13" messagekey="a13">
                   <h:text/>
               </r:field>
               <r:field fieldName="a14" messagekey="a14">
                   <h:text/>
               </r:field>
               <r:field fieldName="a15" messagekey="a15">
                   <h:text/>
               </r:field>
               <r:field fieldName="a16" messagekey="a16">
                   <h:text/>
               </r:field>
               <r:field fieldName="a17" messagekey="a17">
                   <h:text/>
               </r:field>
               <r:field fieldName="a18" messagekey="a18">
                   <h:text/>
               </r:field>
               <r:field fieldName="a19" messagekey="a19">
                   <h:text/>
               </r:field>
               <r:field fieldName="a20" messagekey="a20">
                   <h:text/>
               </r:field>
               <r:field fieldName="a21" messagekey="a21">
                   <h:text/>
               </r:field>
               <r:field fieldName="a22" messagekey="a22">
                   <h:text/>
               </r:field>
               <r:field fieldName="a23" messagekey="a23">
                   <h:text/>
               </r:field>
               <r:field fieldName="a24" messagekey="a24">
                   <h:text/>
               </r:field>
               <r:field fieldName="a25" messagekey="a25">
                   <h:text/>
               </r:field>
               <r:field fieldName="a26" messagekey="a26">
                   <h:text/>
               </r:field>
               <r:field fieldName="a27" messagekey="a27">
                   <h:text/>
               </r:field>
               <r:field fieldName="a28" messagekey="a28">
                   <h:text/>
               </r:field>
               <r:field fieldName="a29" messagekey="a29">
                   <h:text/>
               </r:field>
               <r:field fieldName="a30" messagekey="a30">
                   <h:text/>
               </r:field>
               <r:field fieldName="a31" messagekey="a31">
                   <h:text/>
               </r:field>
               <r:field fieldName="create_user_name" messagekey="import_user">
                   <h:text/>
               </r:field>
             </r:datacell>
     </form>
              
</body>
</fmt:bundle>
</html>
