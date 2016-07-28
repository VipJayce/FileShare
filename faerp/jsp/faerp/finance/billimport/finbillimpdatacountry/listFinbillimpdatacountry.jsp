<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.billimport.finbillimpdatacountry.finbillimpdatacountry_resource" prefix="rayoo.finance.billimport.finbillimpdatacountry.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
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
        var batch_name = document.getElementById("batch_name").value
        if(file_name == null || file_name == ""){
            alert("<fmt:message key='alert_tip_1'/>");
            return;
        }
        if(batch_name == null || batch_name == ""){
            alert("<fmt:message key='alert_tip_2'/>");
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
        var attach_address = document.form1.attach_address.value;
        var bill_year_month = document.form1.bill_year_month.value;
        
        var url="<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=importBillForNationalSystem&attach_address="+attach_address+"&bill_year_month="+bill_year_month +"&batch_name="+batch_name+"&bill_imp_type_db="+bill_imp_type_db ;
        url=encodeURI(url); 
         showProgressBar();
        jQuery.post(url,function(data){
         	hideProgressBar();
            document.getElementById("submitid").disabled="";
            document.getElementById("displaydiv").style.display='block';
            if(data){
            	var arr = data.split(",");
				//var obj1 = eval('(' + data + ')');
            	//alert(data);
            	//alert(data);
            	//data =(new Function("","return "+data))();
            	//if   (typeOf(data)   !=   "object"){
            	//	alert(11);
            	//	data = JSON.parse(data);
            	//}
            	
            	
                if(!!arr[0]){
	                alert("<fmt:message key='alert_tip_6'/> \n " + arr[0]);
	                return;
                }
	            jQuery("#bill_imp_batch_id").val(arr[3]);
	            jQuery("#success_num").val(arr[1]);
	            jQuery("#error_num").val(arr[2]);
	            jQuery("#create_date").val(arr[5]);
	            jQuery("#create_user_name").val(arr[4]);
	            $id("celllist1").addParam("bill_imp_batch_id",arr[3]);
	            $id("celllist2").addParam("bill_imp_batch_id",arr[3]);
	            $id("celllist1").loadData();
	            $id("celllist1").refresh();
	            $id("celllist2").loadData();
	            $id("celllist2").refresh();
                }
         });
    }
    
    //导出异常数据excel
    function exportExcelForErrorNationalSystemBill_onClick(){
        var bill_imp_batch_id = $name("bill_imp_batch_id").value;
        if(bill_imp_batch_id!=null&&bill_imp_batch_id!=""){
            $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=exportExcelForErrorNationalSystemBill&bill_imp_batch_id="+bill_imp_batch_id;
            $id("datacell_formid").submit();
        }else{
           alert("<fmt:message key='alert_sys_err'/>");
           return;
        }
    }
    
    function downLoad_onClick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=downLoadExcel";
        $id("datacell_formid").submit();
    }

</script>
</head>
<body>
<div id="right">
 <div class="xz_title" style="margin-top:10px;"></div>
    <div class="box_tab">
        <form name="form1" method="post" method="post">
        <table width="99%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" >
        <tr >
         <td class="td_1"><span style="color:red">*</span><fmt:message key='batch_name'/></td>
           <td class="td_2" colspan="3">
             <input type="text" class="text_field" name="batch_name"
				id="batch_name" inputName="导入批次名称" style="width:400px"/></td>
           </td>
           <td class="td_2" colspan="2">
           <input  type="radio"  id="bill_imp_type_db1" name="bill_imp_type_db" value="1" />预收&nbsp;&nbsp;&nbsp;
           <input  type="radio"  id="bill_imp_type_db2" name="bill_imp_type_db" checked="checked"  value="2"/>实收
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
               <input type="button" id='submitid' class="icon_2" value="<fmt:message key='button_upload'/>" <au:authorityBtn code="qgxtzd_sc" type="1"/> onClick="javascript:upload_onClick()" />
               <input type="button" class="icon_2" value="<fmt:message key='button_cancel'/>"  onClick="javascript:this.form.reset();"/>
               <input type="button" class="icon_2"  value="<fmt:message key='button_xzqgxtzd'/>"   <au:authorityBtn code="qgxtzd_xzqgxtzd" type="1"/>  onClick="downLoad_onClick();">
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
            <td class="td_2"><input type="text" value="" class="sText" id="create_date" name="create_date"/></td>
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
               queryAction="/FAERP/FinbillimpdatacountryAction.do?cmd=querySucceedNationalSystemBill"
               width="99%"
               height="280px" 
               xpath="FinbillimpdatacountryVo"
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
               <r:field fieldName="a11" messagekey="a">
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
                <r:field fieldName="a32" messagekey="a32">
                   <h:text/>
               </r:field>
                <r:field fieldName="a33" messagekey="a33">
                   <h:text/>
               </r:field>
                <r:field fieldName="a34" messagekey="a34">
                   <h:text/>
               </r:field>
                <r:field fieldName="a35" messagekey="a35">
                   <h:text/>
               </r:field>
                <r:field fieldName="a36" messagekey="a36">
                   <h:text/>
               </r:field>
                <r:field fieldName="a37" messagekey="a37">
                   <h:text/>
               </r:field>
                <r:field fieldName="a38" messagekey="a38">
                   <h:text/>
               </r:field>
                <r:field fieldName="a39" messagekey="a39">
                   <h:text/>
               </r:field>
                <r:field fieldName="a40" messagekey="a40">
                   <h:text/>
               </r:field>
                <r:field fieldName="a41" messagekey="a41">
                   <h:text/>
               </r:field>
                <r:field fieldName="a42" messagekey= "a42">
                   <h:text/>
               </r:field>
                <r:field fieldName="a43" messagekey="a43">
                   <h:text/>
               </r:field>
                <r:field fieldName="a44" messagekey="a44">
                   <h:text/>
               </r:field>
                <r:field fieldName="a45" messagekey="a45">
                   <h:text/>
               </r:field>
                <r:field fieldName="a46" messagekey="a46">
                   <h:text/>
               </r:field>
                <r:field fieldName="a47" messagekey="a47">
                   <h:text/>
               </r:field>
                <r:field fieldName="a48" messagekey="a48">
                   <h:text/>
               </r:field>
                <r:field fieldName="a49" messagekey="a49">
                   <h:text/>
               </r:field>
                <r:field fieldName="a50" messagekey="a50">
                   <h:text/>
               </r:field>
                <r:field fieldName="a51" messagekey="a51">
                   <h:text/>
               </r:field>
                <r:field fieldName="a52" messagekey="a52">
                   <h:text/>
               </r:field>
                <r:field fieldName="a53" messagekey="a53">
                   <h:text/>
               </r:field>
                <r:field fieldName="a54" messagekey="a54">
                   <h:text/>
               </r:field>
                <r:field fieldName="a55" messagekey="a55">
                   <h:text/>
               </r:field>
                <r:field fieldName="a56" messagekey="a56">
                   <h:text/>
               </r:field>
                <r:field fieldName="a57" messagekey="a57">
                   <h:text/>
               </r:field>
                <r:field fieldName="a58" messagekey="a58">
                   <h:text/>
               </r:field>
                <r:field fieldName="a59" messagekey="a59">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a60" messagekey="a60">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a61" messagekey="a61">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a62" messagekey="a62">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a63" messagekey="a63">
                   <h:text/>
               </r:field>
         
                 <r:field fieldName="a64" messagekey="a64">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a65" messagekey="a65">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a66" messagekey="a66">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a67" messagekey="a67">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a68" messagekey="a68">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a69" messagekey="a69">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a70" messagekey="a70">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a71" messagekey="a71">
                   <h:text/>
               </r:field> 
             
                <r:field fieldName="a72" messagekey="a72">
                   <h:text/>
               </r:field>
            
                    <r:field fieldName="a73" messagekey="a73">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a74" messagekey="a74">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a75" messagekey="a75">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a76" messagekey="a76">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a77" messagekey="a77">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a78" messagekey="a78">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a79" messagekey="a79">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a80" messagekey="a80">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a81" messagekey="a81">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a82" messagekey="a82">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a83" messagekey="a83">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a84" messagekey="a84">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a85" messagekey="a85">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a86" messagekey="a86">
                   <h:text/>
               </r:field>
             
   <r:field fieldName="a87" messagekey="a87">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a88" messagekey="a88">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a89" messagekey="a89">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a90" messagekey="a90">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a91" messagekey="a91">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a92" messagekey="a92">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a93" messagekey="a93">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a94" messagekey="a94">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a95" messagekey="a95">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a96" messagekey="a96">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a97" messagekey="a97">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a139" messagekey="a139">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a98" messagekey="a98">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a99" messagekey="a99">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a100" messagekey="a100">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a101" messagekey="a101">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a102" messagekey="a102">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a103" messagekey="a103">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a104" messagekey="a104">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a105" messagekey="a105">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a106" messagekey="a106">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a107" messagekey="a107">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a108" messagekey="a108">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a109" messagekey="a109">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a110" messagekey="a110">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a111" messagekey="a111">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a112" messagekey="a112">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a113" messagekey="a113">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a114" messagekey="a114">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a115" messagekey="a115">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a116" messagekey="a116">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a117" messagekey="a117">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a118" messagekey="a118">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a119" messagekey="a119">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a120" messagekey="a120">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a121" messagekey="a121">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a122" messagekey="a122">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a123" messagekey="a123">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a124" messagekey="a124">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a125" messagekey="a125">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a126" messagekey="a126">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a127" messagekey="a127">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a128" messagekey="a128">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a129" messagekey="a129">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a130" messagekey="a130">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a131" messagekey="a131">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a132" messagekey="a132">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a133" messagekey="a133">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a134" messagekey="a134">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a135" messagekey="a135">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a136" messagekey="a136">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a137" messagekey="a137">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a138" messagekey="a138">
                   <h:text/>
               </r:field>
             </r:datacell>
           </div> 
           <div id="TabCon2" style="display:none;">
           <div class="button_salary">
            <div class="button_right">
              <ul>
                <input type="button" class="e_3" value="<fmt:message key='button_exp'/>" <au:authorityBtn code="qgxtzdsc_exp" type="1"/> onClick="javascript:exportExcelForErrorNationalSystemBill_onClick()" />
                <!--<li class="e_3"><a onclick="javascript:exportExcelForErrorNationalSystemBill_onClick();">导出Excel</a>--></li>
              </ul>
            </div>
            <div class="clear"></div>
          </div>
           <r:datacell 
               id="celllist2"
               queryAction="/FAERP/FinbillimpdatacountryAction.do?cmd=queryErrorNationalSystemBill"
               width="99%"
               height="280px" 
               xpath="FinbillimpdatacountryVo"
               paramFormId="datacell_formid"
               readonly="true"
               >
               <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       
               <r:field fieldName="failure_reason" messagekey="failure_reason">
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
               <r:field fieldName="a11" messagekey="a">
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
                <r:field fieldName="a32" messagekey="a32">
                   <h:text/>
               </r:field>
                <r:field fieldName="a33" messagekey="a33">
                   <h:text/>
               </r:field>
                <r:field fieldName="a34" messagekey="a34">
                   <h:text/>
               </r:field>
                <r:field fieldName="a35" messagekey="a35">
                   <h:text/>
               </r:field>
                <r:field fieldName="a36" messagekey="a36">
                   <h:text/>
               </r:field>
                <r:field fieldName="a37" messagekey="a37">
                   <h:text/>
               </r:field>
                <r:field fieldName="a38" messagekey="a38">
                   <h:text/>
               </r:field>
                <r:field fieldName="a39" messagekey="a39">
                   <h:text/>
               </r:field>
                <r:field fieldName="a40" messagekey="a40">
                   <h:text/>
               </r:field>
                <r:field fieldName="a41" messagekey="a41">
                   <h:text/>
               </r:field>
                <r:field fieldName="a42" messagekey= "a42">
                   <h:text/>
               </r:field>
                <r:field fieldName="a43" messagekey="a43">
                   <h:text/>
               </r:field>
                <r:field fieldName="a44" messagekey="a44">
                   <h:text/>
               </r:field>
                <r:field fieldName="a45" messagekey="a45">
                   <h:text/>
               </r:field>
                <r:field fieldName="a46" messagekey="a46">
                   <h:text/>
               </r:field>
                <r:field fieldName="a47" messagekey="a47">
                   <h:text/>
               </r:field>
                <r:field fieldName="a48" messagekey="a48">
                   <h:text/>
               </r:field>
                <r:field fieldName="a49" messagekey="a49">
                   <h:text/>
               </r:field>
                <r:field fieldName="a50" messagekey="a50">
                   <h:text/>
               </r:field>
                <r:field fieldName="a51" messagekey="a51">
                   <h:text/>
               </r:field>
                <r:field fieldName="a52" messagekey="a52">
                   <h:text/>
               </r:field>
                <r:field fieldName="a53" messagekey="a53">
                   <h:text/>
               </r:field>
                <r:field fieldName="a54" messagekey="a54">
                   <h:text/>
               </r:field>
                <r:field fieldName="a55" messagekey="a55">
                   <h:text/>
               </r:field>
                <r:field fieldName="a56" messagekey="a56">
                   <h:text/>
               </r:field>
                <r:field fieldName="a57" messagekey="a57">
                   <h:text/>
               </r:field>
                <r:field fieldName="a58" messagekey="a58">
                   <h:text/>
               </r:field>
                <r:field fieldName="a59" messagekey="a59">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a60" messagekey="a60">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a61" messagekey="a61">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a62" messagekey="a62">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a63" messagekey="a63">
                   <h:text/>
               </r:field>
         
                 <r:field fieldName="a64" messagekey="a64">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a65" messagekey="a65">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a66" messagekey="a66">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a67" messagekey="a67">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a68" messagekey="a68">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a69" messagekey="a69">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a70" messagekey="a70">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a71" messagekey="a71">
                   <h:text/>
               </r:field> 
             
                <r:field fieldName="a72" messagekey="a72">
                   <h:text/>
               </r:field>
            
                    <r:field fieldName="a73" messagekey="a73">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a74" messagekey="a74">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a75" messagekey="a75">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a76" messagekey="a76">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a77" messagekey="a77">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a78" messagekey="a78">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a79" messagekey="a79">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a80" messagekey="a80">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a81" messagekey="a81">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a82" messagekey="a82">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a83" messagekey="a83">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a84" messagekey="a84">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a85" messagekey="a85">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a86" messagekey="a86">
                   <h:text/>
               </r:field>
             
   <r:field fieldName="a87" messagekey="a87">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a88" messagekey="a88">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a89" messagekey="a89">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a90" messagekey="a90">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a91" messagekey="a91">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a92" messagekey="a92">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a93" messagekey="a93">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a94" messagekey="a94">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a95" messagekey="a95">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a96" messagekey="a96">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a97" messagekey="a97">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a139" messagekey="a139">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a98" messagekey="a98">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a99" messagekey="a99">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a100" messagekey="a100">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a101" messagekey="a101">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a102" messagekey="a102">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a103" messagekey="a103">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a104" messagekey="a104">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a105" messagekey="a105">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a106" messagekey="a106">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a107" messagekey="a107">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a108" messagekey="a108">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a109" messagekey="a109">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a110" messagekey="a110">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a111" messagekey="a111">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a112" messagekey="a112">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a113" messagekey="a113">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a114" messagekey="a114">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a115" messagekey="a115">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a116" messagekey="a116">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a117" messagekey="a117">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a118" messagekey="a118">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a119" messagekey="a119">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a120" messagekey="a120">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a121" messagekey="a121">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a122" messagekey="a122">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a123" messagekey="a123">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a124" messagekey="a124">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a125" messagekey="a125">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a126" messagekey="a126">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a127" messagekey="a127">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a128" messagekey="a128">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a129" messagekey="a129">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a130" messagekey="a130">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a131" messagekey="a131">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a132" messagekey="a132">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a133" messagekey="a133">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a134" messagekey="a134">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a135" messagekey="a135">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a136" messagekey="a136">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a137" messagekey="a137">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a138" messagekey="a138">
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
