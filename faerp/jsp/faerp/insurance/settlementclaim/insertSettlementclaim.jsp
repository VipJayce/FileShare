<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.settlementclaim.vo.SettlementclaimVo" %>
<%@ page import="rayoo.insurance.settlementclaim.util.ISettlementclaimConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
    SettlementclaimVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    String id = "";
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ISettlementclaimConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (SettlementclaimVo)request.getAttribute(ISettlementclaimConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
            id = resultVo.getId();
        }
    }
   // String settlementclaimid = request.getAttribute("settlementclaimid")==null?"":request.getAttribute("settlementclaimid").toString();
   // String sid = request.getParameter("id")==null?"":request.getParameter("id").toString();
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm."><script language="JavaScript" src="../../scripts/common.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
        var batch_code = document.getElementById("batch_code").value;
        var policy_code = document.form.policy_code.value;        
        var emp_name = document.form.emp_name.value;
        var id_card = document.form.id_card.value;
        var emp_code = document.form.emp_code.value;
        var additional_name = document.form.additional_name.value;
        var invoice_code = document.form.invoice_code.value;
        var visiting_hospital = document.form.visiting_hospital.value;
        var disease_name = document.form.disease_name.value;
        var face_amount=document.form.face_amount.value;        
        var issuing_date = document.getElementById("issuing_date").value;
        var visting_date = document.form.visting_date.value;        
        var reg=/^[0-9]+\.{0,1}[0-9]{0,2}$/;        
        var flag = true;
        if(batch_code==null||batch_code==""){
            alert("批次号不能为空！");
            return;
        }
        if(policy_code==null||policy_code==""){
            alert("保单编号不能为空！");
            return;
        }else{
            jQuery.ajax({
	            url: "<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=checkCode&policy_code="+policy_code+"&date="+new Date()+"",
	            type: 'GET',
	            dataType: 'html',
	            async: false,
	            timeout: 10000,
	            error: function(){
	                alert('Error loading XML document');
	                return  null;
	            },
	            success: function(text){
	                if(text=="0"){
	                   alert("请输入正确的保单编号！");
	                   flag = false;
	               }else{
	                   flag = true;
	               }
	            }
            });
        }
        if(flag==false){
            return;
        }
        if(emp_name==null||emp_name==""){
          alert("申请人名称不能为空！");
          return;
        }
        if(id_card==null||id_card==""){
            alert("证件号不能为空！");
            return;
        }
        if(emp_code==null||emp_code==""){
            alert("申请人唯一号不能为空！");
            return;
        }
        if(invoice_code==null||invoice_code==""){
          alert("发票编号不能为空！");
          return;
        }else{
            jQuery.ajax({
                url: "<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=checkInvoice&batch_code="+batch_code+"&invoice_code="+invoice_code+"&date="+new Date()+"",
                type: 'GET',
                dataType: 'html',
                async: false,
                timeout: 10000,
                error: function(){
                    alert('Error loading XML document');
                    return  null;
                },
                success: function(text){
                    if(text!="0"){
	                     alert("不能添加重复的发票编号！");
	                     flag = false;
	                 }else{
	                      flag = true;
	                 }
                }
            });
        }
        if(flag==false){
            return;
        }
        if(face_amount==null||face_amount==""||face_amount=="0"){
            alert("票面金额不能为空或为0！");
            return;
        }else{
            if(!reg.test(face_amount)){
                alert("票面金额格式不正确！");
                return;
            }
        }
        if(issuing_date==null||issuing_date==""){
            alert("出险日期不能为空！");
            return;
        }else{
            jQuery.ajax({
                url: "<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=getCustByCodeAndIssuingDate&batch_code="+batch_code+"&invoice_code="+invoice_code+"&date="+new Date()+"",
                type: 'POST',
                dataType: 'json',
                data: jQuery("form").serialize(),
                async: false,
                timeout: 10000,
                error: function(){
                    alert('Error loading XML document');
                    return  null;
                },
                success: function(json){
	               if(json!=null&&json!="null"&&json!=""){	                    
	                    flag = true;
	                }else{
	                    alert("系统中不存在该客户！");
	                    flag = false;
	                }
	           }
            });
        }
        if(flag==false){
            return;
        }
        var action="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=insert";
        var myAjax = new Ajax(action);
        myAjax.addParam('batch_code', batch_code);
        myAjax.addParam('policy_code', policy_code);        
        myAjax.addParam('emp_name', emp_name);
        myAjax.addParam('id_card', id_card);
        myAjax.addParam('emp_code', emp_code);
        myAjax.addParam('additional_name', additional_name);
        myAjax.addParam('invoice_code', invoice_code);
        myAjax.addParam('visiting_hospital', visiting_hospital);
        myAjax.addParam('disease_name', disease_name);
        myAjax.addParam('face_amount', face_amount);        
        myAjax.addParam('issuing_date', issuing_date);
        myAjax.addParam('visting_date', visting_date);        
        myAjax.submit();
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
              alert(""+myAjax.getProperty("returnValue"));
              window['returnValue'] = ""+myAjax.getProperty("returnValue");
              window.close();
         }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        var additional_name = document.form.additional_name.value;
        var visiting_hospital = document.form.visiting_hospital.value;
        var disease_name = document.form.disease_name.value;
        var face_amount=document.form.face_amount.value;        
        var visting_date = document.form.visting_date.value;  
        var claim_no = document.form.claim_no.value;
        var takingover_date = document.getElementById("takingover_date").value;
        var item_name_bd = document.form.item_name_bd.value;
        var real_applied_amount = document.form.real_applied_amount.value;
        var payAmount = document.form.payAmount.value;
        var wholly_payment = document.form.wholly_payment.value;
        var attached_payment = document.form.attached_payment.value;
        var conceitedAmount = document.form.conceitedAmount.value;
        var deductible_amount = document.form.deductible_amount.value;
        var percentage_claims = document.form.percentage_claims.value;
        var real_claims_amount = document.form.real_claims_amount.value;
        var total_real_claims = document.form.total_real_claims.value;
        var reason_refuse = document.form.reason_refuse.value;
        var absent_docs = document.form.absent_docs.value;
        var contents_absent_docs = document.form.contents_absent_docs.value;
        var claims_rejected_bd = document.form.claims_rejected_bd.value;
        var rejected_amount = document.form.rejected_amount.value;
        var id = document.form.settlement_id.value;
        var reg=/^[0-9]+\.{0,1}[0-9]{0,2}$/;
        var reg1=/^\d+%$/;
        if(claim_no==null||claim_no==""){
            alert("理赔号不能为空！");
            return;
        }
        if(takingover_date==null||takingover_date==""){
            alert("交接日期不能为空！");
            return;
        }
        if(face_amount==null||face_amount==""||face_amount=="0"){
            alert("票面金额不能为空或为0！");
            return;
        }else{
            if(!reg.test(face_amount)){
                alert("票面金额格式不正确！");
                return;
            }
        }
        if(real_applied_amount==null||real_applied_amount==""){
            alert("实际申请金额不能为空！");
            return;
        }else{
            if(!reg.test(real_applied_amount)){
                alert("实际申请金额格式不正确！");
                return;
            }
        }
        if(payAmount==null||payAmount==""){
            alert("自费不能为空！");
            return;
        }else{
            if(!reg.test(payAmount)){
                alert("自费格式不正确！");
                return;
            }
        }
        if(wholly_payment==null||wholly_payment==""){
            alert("统筹支付不能为空！");
            return;
        }else{
            if(!reg.test(wholly_payment)){
                alert("统筹支付格式不正确！");
                return;
            }
        }
        if(attached_payment==null||attached_payment==""){
            alert("附加支付不能为空！");
            return;
        }else{
            if(!reg.test(attached_payment)){
                alert("附加支付格式不正确！");
                return;
            }
        }
        if(conceitedAmount==null||conceitedAmount==""){
            alert("分类自负不能为空！");
            return;
        }else{
            if(!reg.test(conceitedAmount)){
                alert("分类自负格式不正确！");
                return;
            }
        }
        if(deductible_amount==null||deductible_amount==""){
            alert("免赔额不能为空！");
            return;
        }else{
            if(!reg.test(deductible_amount)){
                alert("免赔额格式不正确！");
                return;
            }
        }
        if(percentage_claims==null||percentage_claims==""){
            alert("赔付比例不能为空！");
            return;
        }else{
            if(!reg1.test(percentage_claims)){
                alert("赔付比例格式不正确！");
                return;
            }
        }
        if(real_claims_amount==null||real_claims_amount==""){
            alert("实际赔付金额不能为空！");
            return;
        }else{
            if(!reg.test(real_claims_amount)){
                alert("实际赔付金额格式不正确！");
                return;
            }
        }
        if(total_real_claims!=null&&total_real_claims!=""){
            if(!reg.test(total_real_claims)){
                alert("总实际赔付格式不正确!");
                return;
            }
        }
        if(rejected_amount!=null&&rejected_amount!=""){
            if(!reg.test(rejected_amount)){
                alert("拒赔金额格式不正确！");
                return;
            }
        }
        var action="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=update";
        var myAjax = new Ajax(action);
        myAjax.addParam('additional_name', additional_name);
        myAjax.addParam('visiting_hospital', visiting_hospital);
        myAjax.addParam('disease_name', disease_name);
        myAjax.addParam('face_amount', face_amount);      
        myAjax.addParam('visting_date', visting_date);
        myAjax.addParam('claim_no', claim_no);
        myAjax.addParam('takingover_date', takingover_date);         
        myAjax.addParam('item_name_bd', item_name_bd);
        myAjax.addParam('real_applied_amount', real_applied_amount);
        myAjax.addParam('payAmount', payAmount);
        myAjax.addParam('wholly_payment', wholly_payment);
        myAjax.addParam('attached_payment', attached_payment);
        myAjax.addParam('conceitedAmount', conceitedAmount);   
        myAjax.addParam('deductible_amount', deductible_amount);
        myAjax.addParam('percentage_claims', percentage_claims);         
        myAjax.addParam('real_claims_amount', real_claims_amount);
        myAjax.addParam('total_real_claims', total_real_claims);
        myAjax.addParam('reason_refuse', reason_refuse);
        myAjax.addParam('absent_docs', absent_docs);
        myAjax.addParam('contents_absent_docs', contents_absent_docs);
        myAjax.addParam('claims_rejected_bd', claims_rejected_bd);
        myAjax.addParam('rejected_amount', rejected_amount);
        myAjax.addParam('id', id);        
        myAjax.submit();
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
              alert(""+myAjax.getProperty("returnValue"));
              window['returnValue'] = ""+myAjax.getProperty("returnValue");
              window.close();
         }
    }

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    //tab切换
    function setTabSyn ( i )
    {
        selectTabSyn(i);
    }
    
    function selectTabSyn ( i )
    {    
        switch(i){
            case 1:
            document.getElementById('bg').className='social_xixi1';
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
             document.getElementById('bg').className='social_xixi2';
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }
</script>
</head>
<body>

<form name="form" method="post"><div id="right">
    <div class="ringht_s">
    <!--表格2-->
    <!--表格2 end-->
    <!--社保公积金-->
    <!--表格 -->
     <div class="social_tab">
       <div id="bg" class="social_xixi1">
         <div id="font1" class="social_tab1" onMouseDown="setTabSyn(1);"> 保险公司初给的理赔申请 </div>
         <div id="font2" class="social_tab2" <%if(isModify){ %>onMouseDown="setTabSyn(2);"<%} %>> 保险公司理赔结果 </div>
       </div>
       <div id="TabCon1" style="display:block;">
         <!--表格1-->
         <div class="xz_title" style="margin-top:10px;">保险公司初给的理赔申请</div>
         <div class="box_3">
           <table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2"> 
        <tr>
            <td class="td_1" ><span>*</span>批次号</td>
            <td class="td_2 ">
            <%if(isModify) { %>
                 <w:date format="yyyy-MM-dd" id="batch_code" name="batch_code" width="85" value="" property="bean/batch_code" readOnly="true"/>
                 <%}else{ %>
                 <w:date format="yyyy-MM-dd" id="batch_code" name="batch_code" width="85" value="" property="bean/batch_code" />
                 <%} %> 
            </td>
             <td class="td_1" ><span>*</span>保单编号</td>
            <td class="td_2 "><input type="text" class="text_field" style="width: 100px;" name="policy_code" id="policy_code" inputName="保单编号"<%if(isModify){ %> readonly="readonly"<%} %> value="" maxLength="64"/>
            </td>
            <td class="td_1" ><span>*</span>申请人名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="emp_name" style="width: 100px;" name="emp_name"  onblur="getempByEmpName(this);" <%if(isModify){ %> readonly="readonly"<%} %> inputName="申请人名称" value="" maxLength="50"/>
            </td>            
        </tr>
        <tr>            
            <td class="td_1" ><span>*</span>证件号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="id_card" style="width: 100px;" onblur="getempByIdCard(this);" name="id_card" inputName="证件号" <%if(isModify){ %> readonly="readonly"<%} %> value="" maxLength="18"/>
            </td>
            <td class="td_1" >申请人唯一号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="emp_code"  readonly="readonly" inputName="申请人唯一号" value="" maxLength="64" />
            </td>
              <td class="td_1" >附险人姓名</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="additional_name" inputName="附险人姓名" value="" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span>*</span>发票编号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="invoice_code" inputName="发票编号"<%if(isModify){ %> readonly="readonly"<%} %> value="" maxLength="64" />
            </td>
            <td class="td_1" >就诊医院</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="visiting_hospital" inputName="就诊医院" value="" maxLength="50" />
            </td>
            <td class="td_1" >疾病名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="disease_name" inputName="疾病名称" value="" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td  class="td_1" ><span>*</span>票面金额</td>
            <td  class="td_2" >
                <input type="text" class="text_field" style="width: 100px;" name="face_amount" inputName="票面金额" maxLength="23" integerDigits="18" decimalDigits="4" />
            </td>
            <td class="td_1" ><span>*</span>出险日期</td>
            <td class="td_2">
                <%if(isModify) { %>
                 <w:date format="yyyy-MM-dd" id="issuing_date" name="issuing_date" width="85" property="bean/issuing_date" value="" readOnly="true"/>
                 <%}else{ %>
                 <w:date format="yyyy-MM-dd" id="issuing_date" name="issuing_date" width="85" property="bean/issuing_date" value=""/>
                 <%} %>  
            </td>
             <td class="td_1" >就诊日期</td>
            <td class="td_2">
                 <w:date format="yyyy-MM-dd" id="visting_date" name="visting_date" width="85" property="bean/visting_date" value=""/>
            </td>
        </tr>
    </table>
 
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
    </div>
    
    </div>
   </div>
       <div id="TabCon2" style="display:none;">
         <div class="xz_title" style="margin-top:10px;">保险公司理赔结果 </div>
         <div class="box_3">
      <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <input type="hidden" id="id" name="id" />
  <tr>
            <td class="td_1" ><span>*</span>理赔号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="claim_no" style="width: 100px;" name="claim_no" inputName="理赔号" value="" maxLength="64" />
            </td>
            <td class="td_1" ><span>*</span>交接日期</td>
            <td class="td_2">                
                   <w:date format="yyyy-MM-dd" id="takingover_date" name="takingover_date" width="85" property="bean/takingover_date" value=""/> 
            </td>
            <td class="td_1" >项目名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="item_name_bd" inputName="项目名称" value="" maxLength="64" />
            </td>
        </tr>
        <tr>
            <td  class="td_1" ><span>*</span>实际申请金额</td>
            <td  class="td_2" >
                <input type="text" class="text_field" style="width: 100px;" name="real_applied_amount" inputName="实际申请金额" maxLength="23" integerDigits="18" decimalDigits="4" />
            </td>
            <td class="td_1" ><span>*</span>自费</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="payAmount" id="payAmount" inputName="自费" maxLength="23"  integerDigits="18" decimalDigits="4" />
            </td>
            <td class="td_1" ><span>*</span>统筹支付</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="wholly_payment" inputName="统筹支付" value="" maxLength="64"  integerDigits="18" decimalDigits="4" />
            </td>            
        </tr>
        </tr>
            <td class="td_1" ><span>*</span>附加支付</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="attached_payment" inputName="附加支付" value="" maxLength="64"  integerDigits="18" decimalDigits="4" />
            </td>
            <td class="td_1"><span>*</span>分类自负</td>
            <td class="td_2" >
                <input type="text" class="text_field" style="width: 100px;"  name="conceitedAmount" inputName="分类自负" maxLength="64" value=""  integerDigits="18" decimalDigits="4" />
            </td>
            <td  class="td_1" ><span>*</span>免赔额</td>
            <td  class="td_2" >
                <input type="text" class="text_field" style="width: 100px;" name="deductible_amount" inputName="免赔额" maxLength="23" integerDigits="18" decimalDigits="4" />
            </td>
        </tr>
        <tr>            
            <td  class="td_1" ><span>*</span>赔付比例</td>
            <td  class="td_2" >
                <input type="text" class="text_field" style="width: 100px;" name="percentage_claims" inputName="赔付比例" maxLength="24"  />
            </td>
            <td class="td_1"><span>*</span>实际赔付金额</td>
            <td class="td_2" >
                <input type="text" class="text_field" style="width: 100px;" name="real_claims_amount" inputName="实际赔付金额" maxLength="23" integerDigits="4" />
            </td>
            <td  class="td_1" >总实际赔付</td>
            <td  class="td_2" >
                <input type="text" class="text_field" style="width: 100px;" name="total_real_claims" inputName="总实际赔付" maxLength="23" integerDigits="18" decimalDigits="4" />
            </td>
        </tr>
        <tr>            
            <td class="td_1">拒赔原因</td>
            <td class="td_2" >
                <textarea class="text_field" style="width: 100px;"  name="reason_refuse" inputName="拒赔原因" maxLength="1000" ></textarea>
            </td>
            <td class="td_1">缺少材料</td>
            <td class="td_2" >
                <textarea class="text_field" style="width: 100px;" name="absent_docs" inputName="缺少材料" maxLength="1000" ></textarea>
            </td>
            <td class="td_1">拒赔内容</td>
            <td class="td_2" >
                <textarea class="text_field"  name="contents_absent_docs" style="width: 100px;" inputName="缺少材料内容" maxLength="1000" ></textarea>
            </td>
        </tr>
        <tr>            
            <td class="td_1" >拒赔张数</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width: 100px;" name="claims_rejected_bd" inputName="拒赔张数" value="" maxLength="64" />
            </td>
            <td  class="td_1" >拒赔金额</td>
            <td  class="td_2" >
                <input type="text" class="text_field" style="width: 100px;" name="rejected_amount" inputName="拒赔金额" maxLength="23" integerDigits="18" decimalDigits="4" />
            </td>
            <td class="td_1" >&nbsp;</td>
            <td class="td_2 ">&nbsp;</td>
        </tr>
    </table>
 
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
    </div>
     </div>
    </div></div>
    <input type="hidden" name="settlement_id" value="<%=id %>">
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
        out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
function getempByIdCard(obj){
    if(document.form.emp_name.value==null||document.form.emp_name.value==""){
        //alert("申请人名称不能为空！");
        return;
    }
	if(obj.value!=null&&obj.value!=""){
	    jQuery.ajax({
           url: "<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=getEmployeeByNameAndIdCard",
           type: "POST",
           dataType: "json",
           data: jQuery("form").serialize(),
           async: false,
           timeout: 10000,
           error: function(XMLHttpRequest, textStatus, errorThrown) {
                   alert(XMLHttpRequest.status);
                   alert(XMLHttpRequest.readyState);
                   alert(textStatus);
            },
           success: function(json){
               if(json!=null&&json!="null"&&json!=""){
                    document.getElementById("emp_code").value=json.emp_code;
                }else{
                    alert("没有该员工！");
                    return;
                }
           }
       });
	}else{
	   alert("证件号不能为空！");
       return;
	}
}

function getempByEmpName(obj){
    if(document.form.id_card.value==null||document.form.id_card.value==""){
        //alert("证件号不能为空！");
        return;
    }
    if(obj.value!=null&&obj.value!=""){
        jQuery.ajax({
           url: "<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=getEmployeeByNameAndIdCard",
           type: "POST",
           dataType: "json",
           data: jQuery("form").serialize(),
           async: false,
           timeout: 10000,
           error: function(XMLHttpRequest, textStatus, errorThrown) {
                   alert(XMLHttpRequest.status);
                   alert(XMLHttpRequest.readyState);
                   alert(textStatus);
            },
           success: function(json){
               if(json!=null&&json!="null"&&json!=""){
                    document.getElementById("emp_code").value=json.emp_code;
                }else{
                    alert("没有该员工！");
                    return;
                }
           }
       });
    }else{
       alert("申请人名称不能为空！");
       return;
    }
}
</script>
