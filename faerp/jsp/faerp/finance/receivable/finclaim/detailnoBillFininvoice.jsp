<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<!-- 
    add by Mahone:
    注意，div_1和div_3中的参与计算的小额，汇差，核销等textbox的ID,NAME都一样
    这样做是为了只用一套js，后端java也只取一个name
 -->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>认领</title>
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
        
        function cancel_onClick(){  //取消后返回列表页面
		    form.action=venusbase+"/FinclaimAction.do?cmd=leftbar2list";
		    form.submit();
		}
    </script>
</head>
<body>
<form name="form" id="datacell_formid" method="post">
<input type="hidden" id="no_amount_flag" value="${no_amount_flag}" />
<input type="hidden" id="claim_id" value="${finclaimVo.id}" />
<div id="right">
    <div class="ringht_s">
     <div class="social_tab">
         <div class="box_3">
           <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1"><span class="style_required_red">* </span>发票抬头</td>
               <td class="td_2"><input name="text" type="text" class="text_field" id="receipt_title" value=""  style="width: 80%"/></td>
               <td class="td_1">联系人</td>
               <td class="td_2"><input name="text2" type="text" class="text_field" id="contact_person" value=""/></td>
              </tr>
             <tr>
               <td class="td_1">邮寄地址</td>
               <td class="td_2"><input name="text3" type="text" class="text_field" id="contact_address" value=""  style="width:  80%"/></td>
               <td class="td_1">联系电话</td>
               <td class="td_2"><input name="text5" type="text" class="text_field" id="contact_tel" value=""/></td>
              </tr>
              <c:if test="${no_amount_flag == 0}">
	              <tr>
	               <td class="td_1">到款编号</td>
	               <td class="td_2">${bean.inc_code }</td>
	               <td class="td_1">到款金额</td>
	               <td class="td_2">${bean.inc_amout}</td>
	              </tr>
	              <tr>
	               <td class="td_1">认领人</td>
	               <td class="td_2">
	                    <bean:define id="claim_user_id" name="finclaimVo" property="claim_user_id" />
	                    <%=OrgHelper.getPartyVoByID(claim_user_id.toString()) == null ? "" : OrgHelper.getPartyVoByID(claim_user_id.toString()).getName()%>
	               </td>
	               <td class="td_1">认领金额</td>
	               <td class="td_2">
	                    <input type="hidden" id="claim_amount" value="${finclaimVo.claim_amount}"/>
	                    ${finclaimVo.claim_amount}
	               </td>
	              </tr>
	              <tr>
	               <td class="td_1">认领备注</td>
	               <td class="td_2">${finclaimVo.claim_desc }</td>
	               <td class="td_1">认领状态</td>
	               <td class="td_2">
	                    <bean:define id="claim_status_bd" name="bean" property="claim_status_bd"/>
	                    <%=BaseDataHelper.getNameByCode("CLAIM_STATUS_BD",String.valueOf(claim_status_bd))%>
	               </td>
	             </tr>
             </c:if>
             <tr>
               <td rowspan="1" class="td_1">开票项目</td>
               <td rowspan="1" class="td_2">
                    <d:select  dictTypeId="FIN_SUBJECTS_BD" nullLabel="--请选择--"  style="width:135px;" id="select1"/>
                    <span style="color: black;">金额</span><input type="text" class="text_field" value="" style="width:80px;" id="amount1" onchange="sumAmount();" />
               </td>
               <td class="td_1">开票账期</td>
               <td class="td_2">
                    <input name="bill_year_month" type="text" class="text_field" id="bill_year_month" value="" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxLength="4"/>
                    <font style="color: red;font-weight :bold;font-size:12px">(YYMM格式)</font>
               </td>
              </tr>
             <tr>
               <td rowspan="1" class="td_1">开票项目</td>
               <td rowspan="1" class="td_2">
                    <d:select dictTypeId="FIN_SUBJECTS_BD" nullLabel="--请选择--"  style="width:135px;" id="select2"/>
                    <span style="color: black;">金额</span><input type="text" class="text_field" value="" style="width:80px;" id="amount2" onchange="sumAmount();"/>
               </td>
               <td class="td_1">开票总金额</td>
               <td class="td_2"><input name="invoice_amount" type="text" class="text_field" id="invoice_amount" value="" readonly="readonly"/></td>
             </tr>
             <tr>
               <td rowspan="1" class="td_1">开票项目</td>
               <td rowspan="1" class="td_2">
                    <d:select  dictTypeId="FIN_SUBJECTS_BD" nullLabel="--请选择--"  style="width:135px;" id="select3"/>
                    <span style="color: black;">金额</span><input type="text" class="text_field" value="" style="width:80px;" id="amount3" onchange="sumAmount();"/>
               </td>
               <td class="td_1">是否需要快递</td>
               <td class="td_2">
                    <input name="is_express" type="radio"  id="is_express0" value="0" style="width: 20px;"/>否
                    <input name="is_express" type="radio"  id="is_express1" value="1" style="width: 20px;" checked="checked"/>是
               </td>
              </tr>
              <tr>
               <td class="td_1">开票备注</td>
               <td class="td_2"  style="height: 50px;">
                   <font style="padding-bottom: 50px;color: red;font-weight :bold;">（输入的内容会打印到发票中）</font></br>
                   <input name="invoice_desc" class="sText" style="width: 80%" id="invoice_desc" type="text" value="${requestScope.invoice_desc}">
               </td>
               <td class="td_1">是否需要账期</td>
               <td class="td_2">
                    <input name="is_payment" type="radio"  id="is_payment0" value="0" style="width: 20px;"  onclick="javascript:_$('#bill_year_month').val('');"/>否
                    <input name="is_payment" type="radio"  id="is_payment1" value="1" style="width: 20px;" checked="checked"/>是
               </td>
              </tr>
              <c:if test="${no_amount_flag == 1}">
                <td class="td_1">申请原因</td>
                <td class="td_2"><textarea name="invoice_desc" rows="3" class="xText_d" id="apply_reason" style="width: 90%"></textarea>
                </td>
                <td class="td_1"><span class="style_required_red">* </span>上传附件</td>
               <td class="td_2" colspan="3">
                   <input type="text" id="attachNameInput" class="text_field_reference_readonly"  name="attachNameInput" inputName="附件地址" value="" hiddenInputId="attach_name"/>
                   <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
                   <input type="hidden" id="attackAddressInput" name="attach_address" value="">
               </td>
              </c:if>
           </table>
         </div>
     </div>
     </div>
     </div>

      <div class="foot_button">
      <input type="button" value="申请开票" class="foot_icon_3" onclick="subinvoice();">
      <input type="button" class="foot_icon_1" value="返回"  onclick="javascript:cancel_onClick();" />
      </div>
</form>
</body>
</html>
<script language="javascript">
if(${msg != null && msg != ""}) {
    alert("${msg }");
}

function cancel_onClick() {
    window.close();
}

function subinvoice(){
        //验证输入
        var receipt_title = _$("#receipt_title").val();//发票抬头
        var contact_person = _$("#contact_person").val();//联系人
        var contact_address = _$("#contact_address").val();//邮寄地址
        var contact_tel = _$("#contact_tel").val();//联系电话
        var bill_year_month = _$("#bill_year_month").val();//账期
        var invoice_desc = _$("#invoice_desc").val();//开票备注
        var claim_id = _$("#claim_id").val();//认领id
        //开票项目 以及金额  
        var select1 = _$("#select1").val();
        var select2 = _$("#select2").val();
        var select3 = _$("#select3").val();
        var amount1 = _$("#amount1").val();
        var amount2 = _$("#amount2").val();
        var amount3 = _$("#amount3").val();
        var sValueArray = new Array();//发票科目
        var sTextArray = new Array();//发票科目名称
        var amountArray = new Array();//金额
        sValueArray[0] = select1;
        sValueArray[1] = select2;
        sValueArray[2] = select3;
        //设置科目名称 防止乱码
        sTextArray[0] = encodeURI(_$("#select1").find("option:selected").text());
        sTextArray[1] = encodeURI(_$("#select2").find("option:selected").text());
        sTextArray[2] = encodeURI(_$("#select3").find("option:selected").text());
        //设置金额
        amountArray[0] = amount1;
        amountArray[1] = amount2;
        amountArray[2] = amount3;
        
        var invoice_amount = _$("#invoice_amount").val();//发票总额
        var claim_amount = _$("#claim_amount").val();//认领金额
        var is_express = _$('input[name="is_express"]:checked').val();//是否需要快递
        var is_payment = _$('input[name="is_payment"]:checked').val();//是否需要账期
        
        if(receipt_title==null || receipt_title==""){
           alert("请输入发票抬头!");
          _$("#receipt_title").focus();
           return false;
       }
       if(invoice_desc != "" && invoice_desc.length >45){
            alert("发票备注最多只能输入45个字符！");
            return false;
       }
       //需要快递则一定需要输入联系人 邮寄地址以及邮编
       if(is_express == 1){
               if(contact_person==null || contact_person==""){
		           alert("需要财务快递请输入联系人!");
		          _$("#contact_person").focus();
		           return false;
		       }
		       if(contact_address==null || contact_address==""){
		           alert("需要财务快递请输入邮寄地址!");
		          _$("#contact_address").focus();
		           return false;
		       }
		       if(contact_tel==null || contact_tel==""){
		           alert("需要财务快递请输入联系电话!");
		          _$("#contact_tel").focus();
		           return false;
		       }
       }
       //需要输入账期 账期不能为空
       if(is_payment == 1){
            if(bill_year_month==null || bill_year_month==""){
                   alert("发票需要显示账期则账期不能为空!");
                  _$("#bill_year_month").focus();
                   return false;
             }else{
                if(bill_year_month.length != 4){
                    alert("请输入正确的四位账期！");
                    return false;
                }else{
                    var regDate =  new RegExp("[0-9]{2}(0?[1-9]|1[0-2])$");
                    if(bill_year_month.substring(2) == "00"){
                        alert("请输入正确的年月账期！");
                        return false;
                    }
                    if(bill_year_month.match(regDate)[0] != bill_year_month ){
                        alert("请输入正确的年月账期！");
                        return false;
                    }
                }
             }
       }
       if( (select1 ==null || select1=="") && (select2 ==null || select2=="") && (select3 ==null || select3=="") ){
           alert("请最少选择一条开票项目!");
           return false;
       }
       if( (select1 !=null && select1!="") && (amount1 ==null || amount1=="" || parseFloat(amount1)==0) ){
          alert("请输入第一条开票项目的金额!");
          _$("#amount1").focus();
           return false;
       }
       if( (select2 !=null && select2!="") && (amount2 ==null || amount2=="" || parseFloat(amount2)==0) ){
          alert("请输入第二条开票项目的金额!");
          _$("#amount2").focus();
           return false;
       }
       if( (select3 !=null && select3!="") && (amount3 ==null || amount3=="" || parseFloat(amount3)==0) ){
          alert("请输入第三条开票项目的金额!");
          _$("#amount3").focus();
           return false;
       }
       if( (select1 ==null || select1=="") && (amount1 !=null && amount1!="" && parseFloat(amount1)>0) ){
           alert("请选择第一条开票项目!");
           return false;
       }
       if( (select2 ==null || select2=="") && (amount2 !=null && amount2!="" && parseFloat(amount2)>0) ){
           alert("请选择第二条开票项目!");
           return false;
       }
       if( (select3 ==null || select3=="") && (amount3 !=null && amount3!="" && parseFloat(amount3)>0) ){
           alert("请选择第三条开票项目!");
           return false;
       }
       
       if(_$("#no_amount_flag").val() == "0" && (parseFloat(invoice_amount) != parseFloat(claim_amount)) ){
            //如果有认领 则发票金额不允许大于
            alert("发票金额必须等于认领金额!");
            return false; 
       }
       if(parseFloat(invoice_amount) >parseFloat(10000000)){
            alert("开票金额不能大于1000W");
            return false;
       }
       //附件信息
       var  attachName = _$("#attachNameInput").val();
       var  attachAddress = _$("#attackAddressInput").val();
       //申请原因
       var apply_reason = _$("#apply_reason").val();
       if((attachName=="" || attachName== null)){
            alert("请上传附件供财务审核！");
            return false;
       }
       //检查选择开票项目是否重复
       if(isRepeat(sValueArray) && isErrSelect(sValueArray) ){
            var param = jQuery("#datacell_formid").serialize();
            var _url = "<%=request.getContextPath()%>/FinclaimAction.do?cmd=noBillFininvoice&_ts="+(new Date()).getTime()+"&sTextArray="+sTextArray+"&sValueArray="+sValueArray+"&claim_id="+claim_id+"&receipt_title="+encodeURI(receipt_title)+"&contact_person="+encodeURI(contact_person)+"&contact_address="+encodeURI(contact_address)+"&contact_tel="+encodeURI(contact_tel)+"&bill_year_month="+bill_year_month+"&invoice_amount="+invoice_amount+"&amountArray="+amountArray+"&invoice_desc="+encodeURI(invoice_desc)+"&is_express="+is_express+"&attachName="+encodeURI(attachName)+"&attachAddress="+encodeURI(attachAddress)+"&apply_reason="+encodeURI(apply_reason); 
            _$.ajax({
                type : "post",
                url : _url,
                data : param,
                dataType : "html",
                success : function(data) {
                        alert(data);
                        window.close();
                }
            });
       }
}

//监听金额
function sumAmount(){
    var amount1 = _$("#amount1").val();
    var amount2 = _$("#amount2").val();
    var amount3 = _$("#amount3").val();
    if(amount1 !=""  && amount1 != null){
        if( isNaN(amount1) || amount1<0){
            alert("请输入正确的金额!");
	        _$("#amount1").val("");
	        return false;
        }
    }else{
        amount1=0;
    }
    
    if(amount2 !=""  && amount2 != null){
        if( isNaN(amount2) || amount2<0){
            alert("请输入正确的金额!");
            _$("#amount2").val("");
            return false;
        }
    }else{
        amount2=0;
    }
    
    if(amount3 !=""  && amount3 != null){
        if( isNaN(amount3) || amount3<0){
            alert("请输入正确的金额!");
            _$("#amount3").val("");
            return false;
        }
    }else{
        amount3=0;
    }
    _$("#invoice_amount").val((parseFloat(amount1)+parseFloat(amount2)+parseFloat(amount3)).toFixed(2));
}

//判断开票项目是否重复
function isRepeat(arry){
	var s = arry.join(",")+","; //把数组ary转化为字符串
	var flag = true;
	for(var i=0;i<arry.length;i++) {
	   if(arry[i] != "" && arry[i] != null){
	       if(s.replace(arry[i]+",","").indexOf(arry[i]+",")>-1) {    //匹配字符串S中当前i的数组值，并替换为空；在当前循环里查看S中是否有重复
	            alert("开票项目选择重复！");
	            flag =  false;
	            break;
           }
	   }
	}
	return flag;
}
//判断开票项目从业务上是否有重复
function isErrSelect(arry){
    var flag = false;
    var arr1 = ["4","7","1","3"];
    var arr2 = ["5","7","1"];
    var arr3 = ["6","3","1"];
    if(varifyArr(arr1,arry) && varifyArr(arr2,arry) && varifyArr(arr3,arry)){
        flag = true;
    }else{
        alert("请选择正确的开票项目！");
    }
    return flag;
}
function varifyArr(arr1,arr2){
    var count = 0;
    for(i=0;i<arr1.length;i++){
        if(_$.inArray(arr1[i],arr2) != -1){
            count += 1;
        }
    }
    //如果出现2次则返回false
    if(count>1){
        return false;
    }else{
        return true;
    }
}

 //打开文件上传对话框
function UploadFileWindow(){
    window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp');
}
</script>