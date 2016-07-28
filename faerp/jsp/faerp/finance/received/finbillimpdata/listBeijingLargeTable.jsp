<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.received.finbillimpdata.finbillimpdata_resource" prefix="rayoo.finance.received.finbillimpdata.">
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
        var batch_name =  document.getElementById("batch_name").value;
        if(!batch_name){
        	alert("<fmt:message key='alert_tip_2'/>");
            return;
        }
        if(file_name == null || file_name == ""){
            alert("<fmt:message key='alert_tip_1'/>");
            return;
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
         //导入数据类型
       var bill_imp_type_db_name =document.getElementsByName("bill_imp_type_db");
        var bill_imp_type_db ='1' ;
        for(var i=0;i<bill_imp_type_db_name.length;i++)
          {
             if(bill_imp_type_db_name[i].checked)
                   bill_imp_type_db = bill_imp_type_db_name[i].value;
          }
        if(bill_imp_type_db==null||bill_imp_type_db==''){
            alert("导入类型不能为空，请选择！");
            return;
        }
        document.getElementById("submitid").disabled="disabled";
        var attach_address = document.form1.attach_address.value;
        var bill_year_month = document.form1.bill_year_month.value;
        var url="<%=request.getContextPath()%>/FinbillimpdataAction.do?cmd=importExcelForBeijingLargeTable&attach_address="+attach_address+"&bill_year_month="+bill_year_month + "&batch_name=" + batch_name+"&bill_imp_type_db="+bill_imp_type_db ;
        url=url+"&_ts="+(new Date()).getTime(); 
         url=encodeURI(url); 
        showProgressBar();
        jQuery.getJSON(url,function(data){
        	///alert(data);
            hideProgressBar();
            document.getElementById("submitid").disabled="";
            document.getElementById("displaydiv").style.display='block';
            if(data){
                if(data.msg){
                    alert("<fmt:message key='alert_tip_6'/> \n " + data.msg);
                    return;
                }
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
         });
        
    }
    
    //导出异常数据excel
    function exportExcelForErrorBeijingLargeTableData_onClick(){
        var bill_imp_batch_id = $id("bill_imp_batch_id").value;
        if(bill_imp_batch_id!=null&&bill_imp_batch_id!=""){
	        $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpdataAction.do?cmd=exportExcelForErrorBeijingLargeTableData&bill_imp_batch_id="+bill_imp_batch_id;
	        $id("datacell_formid").submit();
	    }else{
	       alert("<fmt:message key='alert_sys_err'/>");
	       return;
	    }
    }
    
    function downLoad_onClick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpdataAction.do?cmd=downLoadExcel";
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
        <tr >
         <td class="td_1"><span style="color:red">*</span><fmt:message key='batch_name'/></td>
           <td class="td_2" colspan="3">
             <input type="text" class="text_field" name="batch_name"
				id="batch_name" inputName="导入批次名称" style="width:400px"/></td>
           </td>
            <td class="td_2" colspan="2">
         <input  type="radio"  id="bill_imp_type_db1" name="bill_imp_type_db" value="1" />预收
         &nbsp;&nbsp;&nbsp;<input  type="radio"  id="bill_imp_type_db2" name="bill_imp_type_db" checked="checked"  value="2"/>实收
           </td>
        </tr>
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
               <input type="button" id="submitid" class="icon_2" value="<fmt:message key='button_upload'/>" <au:authorityBtn code="hlr_sc" type="1"/> onClick="javascript:upload_onClick();" />
               <input type="button" class="icon_2" value="<fmt:message key='button_cancel'/>"  onClick="javascript:this.form.reset();"/>
               <input type="button" class="icon_3"  value="<fmt:message key='button_download'/>"  onClick="downLoad_onClick();">
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
               queryAction="/FAERP/FinbillimpdataAction.do?cmd=querySucceedBeijingLargeTableData"
               width="97%"
               height="280px" 
               xpath="FinbillimpdataVo"
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
             </r:datacell>
           </div> 
           <div id="TabCon2" style="display:none;">
           <div class="button_salary">
            <div class="button_right">
              <ul>
                <!--<li class="e_3"><a onclick="javascript:exportExcelForErrorBeijingLargeTableData_onClick();">导出Excel</a></li>-->
                <input type="button" class="e_3" value='导出Excel <au:authorityBtn code="hlr_exp" type="1"/>' onClick="javascript:exportExcelForErrorBeijingLargeTableData_onClick()" />
              </ul>
            </div>
            <div class="clear"></div>
          </div>
           <r:datacell 
               id="celllist2"
               queryAction="/FAERP/FinbillimpdataAction.do?cmd=queryErrorBeijingLargeTableData"
               width="97%"
               height="280px" 
               xpath="FinbillimpdataVo"
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
             </r:datacell>
           </div>
	 </div>
	</form>
</div>
</body>
</fmt:bundle>
</html>