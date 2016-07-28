<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
    <script type="text/javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
    <script language="javascript">

    </script>
    </head>
    <body onload="init();">

    <form name="form" method="post" action="<%=request.getContextPath()%>/EmpsecurityAction.do">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
    <input type="hidden" name="ids" id="ids" value="${ids}">
    <div id="right">
		 <div class="ringht_s"></div>
		 <div class="xz_title">支付申请</div>
		 <div class="box_3">
		       <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">                
	                <tr>
	                    <td class="td_1"><span>*</span> 支付年月</td>
	                    <td class="td_2">
	                    <input inputName="支付年月" type="text" class="sText" name="payment_month" id="payment_month" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" validate="notNull;isNum;" maxLength="8" />
	                   <!--  
	                   <input  id="fund_month1"  name="fund_month1" type="text" class="sText" id="fund_month1" onblur="testDate();"/></td>
	                     -->
	                    <td class="td_2">&nbsp;</td>
	                    <td class="td_2">&nbsp;</td>
	                </tr>      
	                <tr>
	                   <td class="td_1">付费类型</td>
	                   <td class="td_2">
	                    <d:select dictTypeId="PAYMENT_TYPE_BD" name="payment_type_bd" value="10"  onchange="is_change() ;"   property="payment_type_bd" id="payment_type_bd"  style="width:190px" />
                       </td>
	                   <td class="td_1">受款方类型</td>
	                   <td class="td_2">
	                   <d:select dictTypeId="RECEIVER_TYPE_BD" name="receiver_type_bd" disabled="false" value="3"  property="receiver_type_bd" id="receiver_type_bd"   style="width:190px" /><!--
	                   
	                       <input inputName="受款方类型" style="background-color:#f0f0f0;" type="text" class="sText" name="receiver_type" id="receiver_type" value="员工" readonly="readonly" />                      
	                        <input  type="hidden" value="2"  id="receiver_type_id"/> 
	                   --></td>
	                </tr>         
	                <tr>
	                   <td class="td_1"><span>*</span>受款方</td>
	                   <td class="td_2">
	                    <input inputName="受款方" type="text" class="sText" name="receiver_name" id="receiver_name"  value="${emp_name}" validate="notNull;" maxLength="8" />
                      
	                   <!-- <input name="text3" type="text" class="sText" id="text3" value="建设银行"/> --></td>
	                   <td class="td_1"><span>*</span>单据数量</td>
	                   <td class="td_2">
	                     <input inputName="单据数量" type="text" class="sText" name="invoice_num" id="invoice_num" value="1" style="color:red;" validate="notNull;isNum;" maxLength="8" />
                      
	                  <!--  <input name="text9" type="text" class="sText" id="text9" value="${count}"   onblur="test9();"/> --></td>
	                </tr>
	                <tr>
	                   <td class="td_1">付款金额</td>
	                   <td class="td_2"><input type="text" style="background-color:#f0f0f0;" class="sText" id="audit_amount" name="audit_amount" value="${sum}" readonly="readonly"  /></td>
	                   <td class="td_1"><span>*</span>申请支付金额</td>
                       <td class="td_2"><input  type="text" class="sText" id="apply_amount" name="apply_amount"  value="${sum}" validate="notNull;isNum;" readonly="readonly"/></td>
                   </tr>
	                <tr>
	                   <td class="td_1"><span>*</span>付款用途</td>
	                   <td colspan="3" class="td_2">
	                   <label for="textarea"></label>
	                   <textarea name="text11" rows="3" class="xText_d" name="payment_purpose" id="payment_purpose">体检支付</textarea></td>
	                </tr>
	                <tr>
	                   <td class="td_1">付款原因</td>
	                   <td colspan="3" class="td_2"><textarea name="payment_reason" id="payment_reason" rows="3" class="xText_d" id="text12"></textarea></td>
	                </tr>
	                <tr>
	                   <td class="td_1">备注</td>
	                   <td colspan="3" class="td_2"><textarea name="payment_desc" id="payment_desc" rows="3" class="xText_d" id="text13"></textarea></td>
	                </tr>
	                <tr>
		                <td class="td_1">申请人</td>
		               <td colspan="3" class="td_2">
		                  <input type="text" style="background-color:#f0f0f0;" class="sText" id="text10" value="<%  LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO");   out.print(loginVo.getName());  %>"/>                          
		               </td>
	                </tr>
               </table>                     
               <div class="foot_button">
                       <input type="button" class="foot_icon_2" value="生成支付审核"  onclick="toPay('xxx')"/>
                    <!--表格 end--></div>             
	    </div>
	</div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
	function toPay(url){
		 if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
	            return false;
	        }
	        
         if(checkAllForms()){
            var apply_amount= jQuery("#apply_amount").val();      
	         if(0>=apply_amount){
	            alert("申请支付金额不能小于0！");
	             return false;
	         }        
           var payment_month= jQuery("#payment_month").val();
           
           //var pay_type_id= jQuery("#pay_type_id").val();
           var payment_type_bd= jQuery("#payment_type_bd").val();
           
           var receiver_type_bd= jQuery("#receiver_type_bd").val();
           var receiver_name= jQuery("#receiver_name").val();
           var invoice_num= jQuery("#invoice_num").val();
           var audit_amount= jQuery("#audit_amount").val();
                
           var payment_purpose= jQuery("#payment_purpose").val();
           var payment_reason= jQuery("#payment_reason").val();
           var payment_desc= jQuery("#payment_desc").val();
           var ids= jQuery("#ids").val();
           var url="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=toPay&payment_month="+payment_month+"&payment_type_bd="+payment_type_bd+"&receiver_type_bd="+receiver_type_bd
                   +"&receiver_name="+encodeURI(receiver_name)+"&invoice_num="+invoice_num+"&audit_amount="+audit_amount+"&apply_amount="+apply_amount+"&payment_purpose="+encodeURI(payment_purpose)
                   +"&payment_reason="+encodeURI(payment_reason)+"&payment_desc="+encodeURI(payment_desc)+"&ids="+ids;
	           var flags=true;
		          jQuery.ajax({
		           url: url,
		          type: 'post',
		          dataType: 'html',
		          timeout: 80000,
		          error: function(){
		              alert('Error loading XML document');
		              return  null;
		          },
		          success: function(text){
		              if(text!=null){       
		                      if(text=="1"){
		                         alert("支付成功！");
		                         window.close();
		                      }else if(text=="2"){
		                          alert("你提交的记录包含了已经支付过的记录(或数据出现了问题)，不能重新支付！" );
		                      }
		              }
		          }
		          });
		          return flags;
		        }
	      }
	function init(){
	    var day = new Date(); 
	    var year=day.getFullYear();
	    var month=day.getMonth()+1; 
	    if(month<=9){
	        month="0"+month;
	    }
	    var yearmonth=year+""+month;
	    document.form.payment_month.value=yearmonth;
	}
	
	function is_change(){
	  var  payment_type_bd = $id("payment_type_bd").value ;
	   if(payment_type_bd != '10'){
	       alert("付费类型只能为体检支付") ;
	       $id("payment_type_bd").value = '10' ;
	   }
	}
</script>
