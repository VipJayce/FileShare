<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.received.finbillimpdata2.finbillimpdata2_resource" prefix="rayoo.finance.received.finbillimpdata2.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title>

<script type="text/javascript">
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2;
        var t = (screen.height - h) / 2;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    }

    function upload_onClick(){  //上传
        var file_name = document.getElementById("attachNameInput").value;
        var bill_year_month = document.getElementById("bill_year_month").value;
        if(file_name == null || file_name == ""){
            alert("<fmt:message key='alert_tip_1'/>");
            return；
        }
        if(bill_year_month == null || bill_year_month == ""){
            alert("<fmt:message key='alert_tip_3'/>");
            return;
        }else{
            if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_tip_4'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_tip_5'/>");
               return;
           }
        }
        
        var attach_address = document.form1.attach_address.value;
        var bill_year_month = document.form1.bill_year_month.value;
        var url="<%=request.getContextPath()%>/Finbillimpdata2Action.do?cmd=importExcelForBeijingLargeTable1&attach_address="+attach_address+"&bill_year_month="+bill_year_month;
        jQuery.post(url,function(data){
            if(data){
                if(data.msg!=null&&data.msg!=""){
                    alert("<fmt:message key='alert_tip_1'/>");
                    return;
                }else{
                    document.getElementById("displaydiv").style.display='';
                    jQuery("#bill_imp_batch_id").val(data.bill_imp_batch_id);
                    jQuery("#success_num").val(data.succeed_num);
                    jQuery("#error_num").val(data.error_num);
                    jQuery("#create_date").val(data.create_date);
                    jQuery("#create_user_name").val(data.create_user_name);
                    
                    $id("celllist1").addParam("bill_imp_batch_id",data.bill_imp_batch_id);
                    $id("celllist2").addParam("bill_imp_batch_id",data.bill_imp_batch_id);
                    
                    $id("celllist1").loadData();
                    $id("celllist1").refresh();
        
			        $id("celllist2").loadData();
			        $id("celllist2").refresh();
                }
            }
         });
    }
    
    //导出异常数据excel
    function exportExcelForErrorBeijingLargeTableData_onClick(){
        var bill_imp_batch_id = $id("bill_imp_batch_id").value;
        if(bill_imp_batch_id!=null&&bill_imp_batch_id!=""){
	        $id("datacell_formid").action="<%=request.getContextPath()%>/Finbillimpdata2Action.do?cmd=exportExcelForErrorBeijingLargeTableData1&bill_imp_batch_id="+bill_imp_batch_id;
	        $id("datacell_formid").submit();
	    }else{
	       alert("<fmt:message key='alert_sys_err'/>");
	       return;
	    }
    }
    
    function downLoad_onClick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/Finbillimpdata2Action.do?cmd=downLoadExcel";
        $id("datacell_formid").submit();
    }
</script>
</head>
<body>
<div class="ringht_s">
    <div class="xz_title" style="margin-top:10px;"></div>
    <div class="box_tab">
        <form name="form1" method="post">
        <table width="99%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" >
        <tr>
           <td class="td_1"><span style="color:red">*</span><fmt:message key='select'/></td>
           <td class="td_2">
              <input type="text" id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="" hiddenInputId="attach_name"/>
              <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
              <input type="hidden" id="attackAddressInput" name="attach_address" value="">
           </td>
           <td class="td_1"><span style="color:red">*</span><fmt:message key='bill_year_month'/></td>
           <td class="td_2">
             <input type="text" class="text_field" name="bill_year_month" id="bill_year_month" inputName="账单年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td>
           </td>
           <td class="td_2">
               <input type="button" class="icon_2" value="<fmt:message key='button_upload'/>" <au:authorityBtn code="bjdb_sc" type="1"/> onClick="upload_onClick()" />
               <input type="button" class="icon_2" value="<fmt:message key='button_cancel'/>"  onClick="javascript:this.form.reset();"/>
               <input type="button" class="icon_2"  value="<fmt:message key='button_download'/>"   <au:authorityBtn code="bjdb_xzbjdb" type="1"/>  onClick="downLoad_onClick();">
           </td>
          </tr>
        </table>
        </form>
    </div>
    
    <form name="form2" method="post" id="datacell_formid">
    <input type="hidden" id="cmd" name="cmd"/>
    <div id="displaydiv" style="display:none">
        <div class="xz_title" style="margin-top:10px;"></div>
        <div class="box_tab">
         <table width="99%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='batch_id'/></td>
            <td class="td_2"><input type="text" value="" class="sText" id="bill_imp_batch_id" name="bill_imp_batch_id"/></td>
            <td class="td_1"><fmt:message key='success_num'/></td>
            <td class="td_2"><input type="text" value="" class="sText" id="success_num" name="success_num"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='error_num'/></td>
            <td class="td_2"><input type="text" value="" class="sText" id="error_num" name="error_num"/></td>
            <td class="td_1"><fmt:message key='create_date'/></td>
            <td class="td_2"><input type="text" value="" class="sText" id="create_date" name=""create_date""/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='create_user'/></td>
            <td class="td_2"><input type="text" value="" class="sText" id="create_user_name" name="create_user_name"/></td>
            <td class="td_2">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
          </tr>
        </table>
       </div>
       
       <div class="social_tab">
            <div id="bg" class="social_xixi1">
          <div id="font1" class="social_tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='social_xixi1'"><fmt:message key='social_xixi1'/></div>
          <div id="font2" class="social_tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='social_xixi2'"><fmt:message key='social_xixi2'/></div>
      </div>
       <div id="TabCon1">
       <div class="social_tab"></div>
       <r:datacell 
               id="celllist1"
               queryAction="/FAERP/Finbillimpdata2Action.do?cmd=querySucceedBeijingLargeTableData1"
               width="97%"
               height="280px" 
               xpath="Finbillimpdata2Vo"
               paramFormId="datacell_formid"
               readonly="true"
               >
               <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       
               <r:field fieldName="bill_year_month" messagekey="bill_year_month">
                   <h:text/>
               </r:field>
               <r:field fieldName="cust_name" messagekey="cust_name">
                   <h:text/>
               </r:field>
               <r:field fieldName="cust_code" messagekey="cust_code">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_name" messagekey="emp_name">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_code" messagekey="emp_code">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_id_card_no" messagekey="emp_id_card_no">
                   <h:text/>
               </r:field>
               <r:field fieldName="d" messagekey="d">
                   <h:text/>
               </r:field>
               <r:field fieldName="e" messagekey="e">
                   <h:text/>
               </r:field>
               <r:field fieldName="f" messagekey="f">
                   <h:text/>
               </r:field>
               <r:field fieldName="g" messagekey="g">
                   <h:text/>
               </r:field>
               <r:field fieldName="h" messagekey="h">
                   <h:text/>
               </r:field>
               <r:field fieldName="i" messagekey="i">
                   <h:text/>
               </r:field>
               <r:field fieldName="j" messagekey="j">
                   <h:text/>
               </r:field>
               <r:field fieldName="k" messagekey="k">
                   <h:text/>
               </r:field>
               <r:field fieldName="l" messagekey="l">
                   <h:text/>
               </r:field>
               <r:field fieldName="m" messagekey="m">
                   <h:text/>
               </r:field>
               <r:field fieldName="n" messagekey="n">
                   <h:text/>
               </r:field>
               <r:field fieldName="o" messagekey="o">
                   <h:text/>
               </r:field>
               <r:field fieldName="p" messagekey="p">
                   <h:text/>
               </r:field>
               <r:field fieldName="q" messagekey="q">
                   <h:text/>
               </r:field>
               <r:field fieldName="r" messagekey="r">
                   <h:text/>
               </r:field>
               <r:field fieldName="s" messagekey="s">
                   <h:text/>
               </r:field>
               <r:field fieldName="t" messagekey="t">
                   <h:text/>
               </r:field>
               <r:field fieldName="u" messagekey="u">
                   <h:text/>
               </r:field>
               <r:field fieldName="v" messagekey="v">
                   <h:text/>
               </r:field>
               <r:field fieldName="w" messagekey="w">
                   <h:text/>
               </r:field>
               <r:field fieldName="x" messagekey="x">
                   <h:text/>
               </r:field>
               <r:field fieldName="y" messagekey="y">
                   <h:text/>
               </r:field>
               <r:field fieldName="z" messagekey="z">
                   <h:text/>
               </r:field>
               <r:field fieldName="aa" messagekey="aa">
                   <h:text/>
               </r:field>
               <r:field fieldName="ab" messagekey="ab">
                   <h:text/>
               </r:field>
               <r:field fieldName="ac" messagekey="ac">
                   <h:text/>
               </r:field>
               <r:field fieldName="ad" messagekey="ad">
                   <h:text/>
               </r:field>
               <r:field fieldName="ae" messagekey="ae">
                   <h:text/>
               </r:field>
               <r:field fieldName="af" messagekey="af">
                   <h:text/>
               </r:field>
               <r:field fieldName="ag" messagekey="ag">
                   <h:text/>
               </r:field>
               <r:field fieldName="ah" messagekey="ah">
                   <h:text/>
               </r:field>
               <r:field fieldName="ai" messagekey="ai">
                   <h:text/>
               </r:field>
               <r:field fieldName="aj" messagekey="aj">
                   <h:text/>
               </r:field>
               <r:field fieldName="ak" messagekey="ak">
                   <h:text/>
               </r:field>
               <r:field fieldName="al" messagekey="al">
                   <h:text/>
               </r:field>
               <r:field fieldName="am" messagekey="am">
                   <h:text/>
               </r:field>
               <r:field fieldName="an" messagekey="an">
                   <h:text/>
               </r:field>
               <r:field fieldName="ao" messagekey="ao">
                   <h:text/>
               </r:field>
               <r:field fieldName="ap" messagekey="ap">
                   <h:text/>
               </r:field>
               <r:field fieldName="aq" messagekey="aq">
                   <h:text/>
               </r:field>
               <r:field fieldName="ar" messagekey="ar">
                   <h:text/>
               </r:field>
               <r:field fieldName="as1" messagekey="as1">
                   <h:text/>
               </r:field>
               <r:field fieldName="at" messagekey="at">
                   <h:text/>
               </r:field>
               <r:field fieldName="au" messagekey="au">
                   <h:text/>
               </r:field>
               <r:field fieldName="av" messagekey="av">
                   <h:text/>
               </r:field>
               <r:field fieldName="aw" messagekey="aw">
                   <h:text/>
               </r:field>
               <r:field fieldName="ax" messagekey="ax">
                   <h:text/>
               </r:field>
               <r:field fieldName="ay" messagekey="ay">
                   <h:text/>
               </r:field>
               <r:field fieldName="az" messagekey="az">
                   <h:text/>
               </r:field>
               <r:field fieldName="ba" messagekey="ba">
                   <h:text/>
               </r:field>
               <r:field fieldName="bb" messagekey="bb">
                   <h:text/>
               </r:field>
               <r:field fieldName="bc" messagekey="bc">
                   <h:text/>
               </r:field>
               <r:field fieldName="bd" messagekey="bd">
                   <h:text/>
               </r:field>
               <r:field fieldName="be" messagekey="be">
                   <h:text/>
               </r:field>
               <r:field fieldName="bf" messagekey="bf">
                   <h:text/>
               </r:field>
               <r:field fieldName="bg" messagekey="bg">
                   <h:text/>
               </r:field>
               <r:field fieldName="bh" messagekey="bh">
                   <h:text/>
               </r:field>
               <r:field fieldName="bi" messagekey="bi">
                   <h:text/>
               </r:field>
               <r:field fieldName="bj" messagekey="bj">
                   <h:text/>
               </r:field>
               <r:field fieldName="bk" messagekey="bk">
                   <h:text/>
               </r:field>
               <r:field fieldName="bl" messagekey="bl">
                   <h:text/>
               </r:field>
               <r:field fieldName="bm" messagekey="bm">
                   <h:text/>
               </r:field>
               <r:field fieldName="bn" messagekey="bn">
                   <h:text/>
               </r:field>
               <r:field fieldName="bo" messagekey="bo">
                   <h:text/>
               </r:field>
               <r:field fieldName="bp" messagekey="bp">
                   <h:text/>
               </r:field>
               <r:field fieldName="bq" messagekey="bq">
                   <h:text/>
               </r:field>
               <r:field fieldName="br" messagekey="br">
                   <h:text/>
               </r:field>
               <r:field fieldName="bs" messagekey="bs">
                   <h:text/>
               </r:field>
               <r:field fieldName="bt" messagekey="bt">
                   <h:text/>
               </r:field>
               <r:field fieldName="bu" messagekey="bu">
                   <h:text/>
               </r:field>
               <r:field fieldName="bv" messagekey="bv">
                   <h:text/>
               </r:field>
               <r:field fieldName="bw" messagekey="bw">
                   <h:text/>
               </r:field>
               <r:field fieldName="bx" messagekey="bx">
                   <h:text/>
               </r:field>
               <r:field fieldName="by1" messagekey="by1">
                   <h:text/>
               </r:field>
               <r:field fieldName="bz" messagekey="bz">
                   <h:text/>
               </r:field>
               <r:field fieldName="ca" messagekey="ca">
                   <h:text/>
               </r:field>
               <r:field fieldName="cb" messagekey="cb">
                   <h:text/>
               </r:field>
               <r:field fieldName="cc" messagekey="cc">
                   <h:text/>
               </r:field>
               <r:field fieldName="cd" messagekey="cd">
                   <h:text/>
               </r:field>
               <r:field fieldName="ce" messagekey="ce">
                   <h:text/>
               </r:field>
               <r:field fieldName="cf" messagekey="cf">
                   <h:text/>
               </r:field>
               <r:field fieldName="cg" messagekey="cg">
                   <h:text/>
               </r:field>
               <r:field fieldName="ch" messagekey="ch">
                   <h:text/>
               </r:field>
               <r:field fieldName="ci" messagekey="ci">
                   <h:text/>
               </r:field>
               <r:field fieldName="cj" messagekey="cj">
                   <h:text/>
               </r:field>
               <r:field fieldName="ck" messagekey="ck">
                   <h:text/>
               </r:field>
               <r:field fieldName="cl" messagekey="cl">
                   <h:text/>
               </r:field>
               <r:field fieldName="cm" messagekey="cm">
                   <h:text/>
               </r:field>
               <r:field fieldName="cn" messagekey="cn">
                   <h:text/>
               </r:field>
               <r:field fieldName="co" messagekey="co">
                   <h:text/>
               </r:field>
               <r:field fieldName="cp" messagekey="cp">
                   <h:text/>
               </r:field>
               <r:field fieldName="cq" messagekey="cq">
                   <h:text/>
               </r:field>
               <r:field fieldName="cr" messagekey="cr">
                   <h:text/>
               </r:field>
               <r:field fieldName="cs" messagekey="cs">
                   <h:text/>
               </r:field>
               <r:field fieldName="ct" messagekey="ct">
                   <h:text/>
               </r:field>
               <r:field fieldName="cu" messagekey="cu">
                   <h:text/>
               </r:field>
               <r:field fieldName="cv" messagekey="cv">
                   <h:text/>
               </r:field>
               <r:field fieldName="cw" messagekey="cw">
                   <h:text/>
               </r:field>
               <r:field fieldName="cx" messagekey="cx">
                   <h:text/>
               </r:field>
               <r:field fieldName="cy" messagekey="cy">
                   <h:text/>
               </r:field>
               <r:field fieldName="cz" messagekey="cz">
                   <h:text/>
               </r:field>
               <r:field fieldName="da" messagekey="da">
                   <h:text/>
               </r:field>
               <r:field fieldName="db" messagekey="db">
                   <h:text/>
               </r:field>
               <r:field fieldName="dc" messagekey="dc">
                   <h:text/>
               </r:field>
               <r:field fieldName="dd" messagekey="dd">
                   <h:text/>
               </r:field>
               <r:field fieldName="de" messagekey="de">
                   <h:text/>
               </r:field>
               <r:field fieldName="df" messagekey="df">
                   <h:text/>
               </r:field>
               <r:field fieldName="dg" messagekey="dg">
                   <h:text/>
               </r:field>
               <r:field fieldName="dh" messagekey="dh">
                   <h:text/>
               </r:field>
               <r:field fieldName="di" messagekey="di">
                   <h:text/>
               </r:field>
               <r:field fieldName="dj" messagekey="dj">
                   <h:text/>
               </r:field>
               <r:field fieldName="dk" messagekey="dk">
                   <h:text/>
               </r:field>
               <r:field fieldName="dl" messagekey="dl">
                   <h:text/>
               </r:field>
               <r:field fieldName="dm" messagekey="dm">
                   <h:text/>
               </r:field>
               <r:field fieldName="dn" messagekey="dn">
                   <h:text/>
               </r:field>
               <r:field fieldName="do1" messagekey="do1">
                   <h:text/>
               </r:field>
               <r:field fieldName="dp" messagekey="dp">
                   <h:text/>
               </r:field>
               <r:field fieldName="dq" messagekey="dq">
                   <h:text/>
               </r:field>
               <r:field fieldName="dr" messagekey="dr">
                   <h:text/>
               </r:field>
               <r:field fieldName="ds" messagekey="ds">
                   <h:text/>
               </r:field>
               <r:field fieldName="dt" messagekey="dt">
                   <h:text/>
               </r:field>
               <r:field fieldName="du" messagekey="du">
                   <h:text/>
               </r:field>
             </r:datacell>
           </div> 
           <div id="TabCon2" style="display:none;">
           <div class="button_salary">
            <div class="button_right">
              <ul>
                <input type="button" class="e_3" value="<fmt:message key='expor_excel'/>" <au:authorityBtn code="bjdbsc_exp" type="1"/> onClick="javascript:exportExcelForErrorBeijingLargeTableData_onClick()" />
                <!--<li class="e_3"><a onclick="javascript:exportExcelForErrorBeijingLargeTableData_onClick();">导出Excel</a></li>-->
              </ul>
            </div>
            <div class="clear"></div>
          </div>
           <r:datacell 
               id="celllist2"
               queryAction="/FAERP/Finbillimpdata2Action.do?cmd=queryErrorBeijingLargeTableData1"
               width="97%"
               height="280px" 
               xpath="Finbillimpdata2Vo"
               paramFormId="datacell_formid"
               readonly="true"
               >
               <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       
               <r:field fieldName="failure_reason" messagekey="failure_reason" width="260">
                   <h:text/>
               </r:field>
               <r:field fieldName="cust_name" messagekey="cust_name">
                   <h:text/>
               </r:field>
               <r:field fieldName="cust_code" messagekey="cust_code">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_name" messagekey="emp_name">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_code" messagekey="emp_code">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_id_card_no" messagekey="emp_id_card_no">
                   <h:text/>
               </r:field>
               <r:field fieldName="d" messagekey="d">
                   <h:text/>
               </r:field>
               <r:field fieldName="e" messagekey="e">
                   <h:text/>
               </r:field>
               <r:field fieldName="f" messagekey="f">
                   <h:text/>
               </r:field>
               <r:field fieldName="g" messagekey="g">
                   <h:text/>
               </r:field>
               <r:field fieldName="h" messagekey="h">
                   <h:text/>
               </r:field>
               <r:field fieldName="i" messagekey="i">
                   <h:text/>
               </r:field>
               <r:field fieldName="j" messagekey="j">
                   <h:text/>
               </r:field>
               <r:field fieldName="k" messagekey="k">
                   <h:text/>
               </r:field>
               <r:field fieldName="l" messagekey="l">
                   <h:text/>
               </r:field>
               <r:field fieldName="m" messagekey="m">
                   <h:text/>
               </r:field>
               <r:field fieldName="n" messagekey="n">
                   <h:text/>
               </r:field>
               <r:field fieldName="o" messagekey="o">
                   <h:text/>
               </r:field>
               <r:field fieldName="p" messagekey="p">
                   <h:text/>
               </r:field>
               <r:field fieldName="q" messagekey="q">
                   <h:text/>
               </r:field>
               <r:field fieldName="r" messagekey="r">
                   <h:text/>
               </r:field>
               <r:field fieldName="s" messagekey="s">
                   <h:text/>
               </r:field>
               <r:field fieldName="t" messagekey="t">
                   <h:text/>
               </r:field>
               <r:field fieldName="u" messagekey="u">
                   <h:text/>
               </r:field>
               <r:field fieldName="v" messagekey="v">
                   <h:text/>
               </r:field>
               <r:field fieldName="w" messagekey="w">
                   <h:text/>
               </r:field>
               <r:field fieldName="x" messagekey="x">
                   <h:text/>
               </r:field>
               <r:field fieldName="y" messagekey="y">
                   <h:text/>
               </r:field>
               <r:field fieldName="z" messagekey="z">
                   <h:text/>
               </r:field>
               <r:field fieldName="aa" messagekey="aa">
                   <h:text/>
               </r:field>
               <r:field fieldName="ab" messagekey="ab">
                   <h:text/>
               </r:field>
               <r:field fieldName="ac" messagekey="ac">
                   <h:text/>
               </r:field>
               <r:field fieldName="ad" messagekey="ad">
                   <h:text/>
               </r:field>
               <r:field fieldName="ae" messagekey="ae">
                   <h:text/>
               </r:field>
               <r:field fieldName="af" messagekey="af">
                   <h:text/>
               </r:field>
               <r:field fieldName="ag" messagekey="ag">
                   <h:text/>
               </r:field>
               <r:field fieldName="ah" messagekey="ah">
                   <h:text/>
               </r:field>
               <r:field fieldName="ai" messagekey="ai">
                   <h:text/>
               </r:field>
               <r:field fieldName="aj" messagekey="aj">
                   <h:text/>
               </r:field>
               <r:field fieldName="ak" messagekey="ak">
                   <h:text/>
               </r:field>
               <r:field fieldName="al" messagekey="al">
                   <h:text/>
               </r:field>
               <r:field fieldName="am" messagekey="am">
                   <h:text/>
               </r:field>
               <r:field fieldName="an" messagekey="an">
                   <h:text/>
               </r:field>
               <r:field fieldName="ao" messagekey="ao">
                   <h:text/>
               </r:field>
               <r:field fieldName="ap" messagekey="ap">
                   <h:text/>
               </r:field>
               <r:field fieldName="aq" messagekey="aq">
                   <h:text/>
               </r:field>
               <r:field fieldName="ar" messagekey="ar">
                   <h:text/>
               </r:field>
               <r:field fieldName="as1" messagekey="as1">
                   <h:text/>
               </r:field>
               <r:field fieldName="at" messagekey="at">
                   <h:text/>
               </r:field>
               <r:field fieldName="au" messagekey="au">
                   <h:text/>
               </r:field>
               <r:field fieldName="av" messagekey="av">
                   <h:text/>
               </r:field>
               <r:field fieldName="aw" messagekey="aw">
                   <h:text/>
               </r:field>
               <r:field fieldName="ax" messagekey="ax">
                   <h:text/>
               </r:field>
               <r:field fieldName="ay" messagekey="ay">
                   <h:text/>
               </r:field>
               <r:field fieldName="az" messagekey="az">
                   <h:text/>
               </r:field>
               <r:field fieldName="ba" messagekey="ba">
                   <h:text/>
               </r:field>
               <r:field fieldName="bb" messagekey="bb">
                   <h:text/>
               </r:field>
               <r:field fieldName="bc" messagekey="bc">
                   <h:text/>
               </r:field>
               <r:field fieldName="bd" messagekey="bd">
                   <h:text/>
               </r:field>
               <r:field fieldName="be" messagekey="be">
                   <h:text/>
               </r:field>
               <r:field fieldName="bf" messagekey="bf">
                   <h:text/>
               </r:field>
               <r:field fieldName="bg" messagekey="bg">
                   <h:text/>
               </r:field>
               <r:field fieldName="bh" messagekey="bh">
                   <h:text/>
               </r:field>
               <r:field fieldName="bi" messagekey="bi">
                   <h:text/>
               </r:field>
               <r:field fieldName="bj" messagekey="bj">
                   <h:text/>
               </r:field>
               <r:field fieldName="bk" messagekey="bk">
                   <h:text/>
               </r:field>
               <r:field fieldName="bl" messagekey="bl">
                   <h:text/>
               </r:field>
               <r:field fieldName="bm" messagekey="bm">
                   <h:text/>
               </r:field>
               <r:field fieldName="bn" messagekey="bn">
                   <h:text/>
               </r:field>
               <r:field fieldName="bo" messagekey="bo">
                   <h:text/>
               </r:field>
               <r:field fieldName="bp" messagekey="bp">
                   <h:text/>
               </r:field>
               <r:field fieldName="bq" messagekey="bq">
                   <h:text/>
               </r:field>
               <r:field fieldName="br" messagekey="br">
                   <h:text/>
               </r:field>
               <r:field fieldName="bs" messagekey="bs">
                   <h:text/>
               </r:field>
               <r:field fieldName="bt" messagekey="bt">
                   <h:text/>
               </r:field>
               <r:field fieldName="bu" messagekey="bu">
                   <h:text/>
               </r:field>
               <r:field fieldName="bv" messagekey="bv">
                   <h:text/>
               </r:field>
               <r:field fieldName="bw" messagekey="bw">
                   <h:text/>
               </r:field>
               <r:field fieldName="bx" messagekey="bx">
                   <h:text/>
               </r:field>
               <r:field fieldName="by1" messagekey="by1">
                   <h:text/>
               </r:field>
               <r:field fieldName="bz" messagekey="bz">
                   <h:text/>
               </r:field>
               <r:field fieldName="ca" messagekey="ca">
                   <h:text/>
               </r:field>
               <r:field fieldName="cb" messagekey="cb">
                   <h:text/>
               </r:field>
               <r:field fieldName="cc" messagekey="cc">
                   <h:text/>
               </r:field>
               <r:field fieldName="cd" messagekey="cd">
                   <h:text/>
               </r:field>
               <r:field fieldName="ce" messagekey="ce">
                   <h:text/>
               </r:field>
               <r:field fieldName="cf" messagekey="cf">
                   <h:text/>
               </r:field>
               <r:field fieldName="cg" messagekey="cg">
                   <h:text/>
               </r:field>
               <r:field fieldName="ch" messagekey="ch">
                   <h:text/>
               </r:field>
               <r:field fieldName="ci" messagekey="ci">
                   <h:text/>
               </r:field>
               <r:field fieldName="cj" messagekey="cj">
                   <h:text/>
               </r:field>
               <r:field fieldName="ck" messagekey="ck">
                   <h:text/>
               </r:field>
               <r:field fieldName="cl" messagekey="cl">
                   <h:text/>
               </r:field>
               <r:field fieldName="cm" messagekey="cm">
                   <h:text/>
               </r:field>
               <r:field fieldName="cn" messagekey="cn">
                   <h:text/>
               </r:field>
               <r:field fieldName="co" messagekey="co">
                   <h:text/>
               </r:field>
               <r:field fieldName="cp" messagekey="cp">
                   <h:text/>
               </r:field>
               <r:field fieldName="cq" messagekey="cq">
                   <h:text/>
               </r:field>
               <r:field fieldName="cr" messagekey="cr">
                   <h:text/>
               </r:field>
               <r:field fieldName="cs" messagekey="cs">
                   <h:text/>
               </r:field>
               <r:field fieldName="ct" messagekey="ct">
                   <h:text/>
               </r:field>
               <r:field fieldName="cu" messagekey="cu">
                   <h:text/>
               </r:field>
               <r:field fieldName="cv" messagekey="cv">
                   <h:text/>
               </r:field>
               <r:field fieldName="cw" messagekey="cw">
                   <h:text/>
               </r:field>
               <r:field fieldName="cx" messagekey="cx">
                   <h:text/>
               </r:field>
               <r:field fieldName="cy" messagekey="cy">
                   <h:text/>
               </r:field>
               <r:field fieldName="cz" messagekey="cz">
                   <h:text/>
               </r:field>
               <r:field fieldName="da" messagekey="da">
                   <h:text/>
               </r:field>
               <r:field fieldName="db" messagekey="db">
                   <h:text/>
               </r:field>
               <r:field fieldName="dc" messagekey="dc">
                   <h:text/>
               </r:field>
               <r:field fieldName="dd" messagekey="dd">
                   <h:text/>
               </r:field>
               <r:field fieldName="de" messagekey="de">
                   <h:text/>
               </r:field>
               <r:field fieldName="df" messagekey="df">
                   <h:text/>
               </r:field>
               <r:field fieldName="dg" messagekey="dg">
                   <h:text/>
               </r:field>
               <r:field fieldName="dh" messagekey="dh">
                   <h:text/>
               </r:field>
               <r:field fieldName="di" messagekey="di">
                   <h:text/>
               </r:field>
               <r:field fieldName="dj" messagekey="dj">
                   <h:text/>
               </r:field>
               <r:field fieldName="dk" messagekey="dk">
                   <h:text/>
               </r:field>
               <r:field fieldName="dl" messagekey="dl">
                   <h:text/>
               </r:field>
               <r:field fieldName="dm" messagekey="dm">
                   <h:text/>
               </r:field>
               <r:field fieldName="dn" messagekey="dn">
                   <h:text/>
               </r:field>
               <r:field fieldName="do1" messagekey="do1">
                   <h:text/>
               </r:field>
               <r:field fieldName="dp" messagekey="dp">
                   <h:text/>
               </r:field>
               <r:field fieldName="dq" messagekey="dq">
                   <h:text/>
               </r:field>
               <r:field fieldName="dr" messagekey="dr">
                   <h:text/>
               </r:field>
               <r:field fieldName="ds" messagekey="ds">
                   <h:text/>
               </r:field>
               <r:field fieldName="dt" messagekey="dt">
                   <h:text/>
               </r:field>
               <r:field fieldName="du" messagekey="du">
                   <h:text/>
               </r:field>
             </r:datacell>
           </div>
	 </div>
	</form>
</div>
</body>
</fmt:bundle>
</html>