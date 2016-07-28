<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.customerservice.security.empsecurity.vo.QuerySocialSecurityVo"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>

<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute("beans") != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute("beans");  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    QuerySocialSecurityVo resultVo = null;  //定义一个临时的vo变量
  
%>
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
    <input type="hidden"  name="cust_id" id="cust_id"  value="${selcust_id}"/>
    <div id="right">
		 <div class="ringht_s"></div>
		 <div class="xz_title">福利报销审核</div>
		 <div class="box_3">
		       <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">                
	                <tr>
	                    <td class="td_1"><span>*</span> 支付年月</td>
	                    <td class="td_2">
	                    <input inputName="支付年月" type="text" class="sText" name="payment_month" id="payment_month" validate="notNull;isNum;" maxLength="8" readonly="readonly"  />
	                   <!--  
	                   <input  id="fund_month1"  name="fund_month1" type="text" class="sText" id="fund_month1" onblur="testDate();"/></td>
	                     -->
	                    <td class="td_2">&nbsp;</td>
	                    <td class="td_2">&nbsp;</td>
	                </tr>      
	                <tr>
	                   <td class="td_1">付费类型</td>
	                   <td class="td_2">
	                       <!-- <input inputName="付费类型" style="background-color:#f0f0f0;" type="text" class="sText" name="pay_type" id="pay_type"  value="福利报销" readonly="readonly"/>-->                      
	                       <!-- <input type="hidden" value="9"  id="pay_type_id"/> -->
	                       <d:select dictTypeId="PAYMENT_TYPE_BD" property="pay_type_id"  value="9" id="pay_type_id" name="pay_type_id" style="width:190px" nullLabel="--请选择--" disabled="true"/>               
                       </td>
	                   <td class="td_1">受款方类型</td>
	                   <td class="td_2">
	                       <input inputName="受款方类型" style="background-color:#f0f0f0;" type="text" class="sText" name="receiver_type" id="receiver_type" value="员工" readonly="readonly" />                      
	                        <input  type="hidden" value="2"  id="receiver_type_id"/> 
	                   </td>
	                </tr>         
	                <tr>
	                   <td class="td_1"><span>*</span>受款方</td>
	                   <td class="td_2">
	                    <input inputName="受款方" type="text" class="sText" name="receiver_name" id="receiver_name"  validate="notNull;" maxLength="8"  value="${emp_name}"  readonly="readonly"/>
                      
	                   <!-- <input name="text3" type="text" class="sText" id="text3" value="建设银行"/> --></td>
	                   <td class="td_1"><span>*</span>单据数量</td><!-- modify by sqp 给了默认值 1 -->
	                   <td class="td_2">
	                     <input inputName="单据数量" type="text" class="sText" name="invoice_num" id="invoice_num" style="color:red;" validate="notNull;isNum;" maxLength="8"  value="1"  onblur="test9();" />
                      
	                  <!--  <input name="text9" type="text" class="sText" id="text9" value="${count}"   onblur="test9();"/> --></td>
	                </tr>
	                <tr>
	                   <td class="td_1">付款金额</td>
	                   <td class="td_2"><input type="text" style="background-color:#f0f0f0;" class="sText" id="audit_amount" name="audit_amount" value="${sum}" readonly="readonly"  /></td>
	                   <td class="td_1"><span>*</span>申请支付金额</td>
                       <td class="td_2"><input  type="text" class="sText" id="apply_amount" name="apply_amount"  value="${sum}"  readonly="readonly"  /></td><!-- 2014年5月6日 改为只读 -->
                   </tr>
	                <tr>
	                   <td class="td_1"><span>*</span>付款用途</td>
	                   <td colspan="3" class="td_2">
	                   <label for="textarea"></label>
	                   <textarea name="text11" rows="3" class="xText_d" name="payment_purpose" id="payment_purpose" readonly="readonly">${manyorsingle}福利报销  客户名称：${selcust_name}   客户编号：${selcust_code}    受款方：${emp_name}   </textarea></td><!-- （${selproduct_name}） 报销费用段：${selstart_date } — ${selend_date } -->
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
		                  <input type="text" style="background-color:#f0f0f0;" class="sText" id="text10" readonly="readonly"  value="<%  LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO");   out.print(loginVo.getName());  %>"/>                          
		               </td>
	                </tr>
               </table>                     
               <div class="foot_button">
                       <input type="button" class="foot_icon_2" value="生成支付审核"  onclick="toPay('xxx')"/>
                        <input type="button" class="foot_icon_2" value="关闭"  onclick="window.close();"/>
                    <!--表格 end--></div>             
	    </div>
	</div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">

  function test9(){
    var  invoice_num  =document.getElementById("invoice_num").value;
    var regu = /^(\d+)$/; 
             if(!regu.test(invoice_num)){
                alert("单据数量无效！");
                document.getElementById("invoice_num").value="";
                 document.getElementById("invoice_num").focus();
             return;
             }
    } 

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
     if(checkAllForms()){
        form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=update";
        form.submit();
        }
    }
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
           var pay_type_id= jQuery("#pay_type_id").val();
           var receiver_type_id= jQuery("#receiver_type_id").val();
           var receiver_name= jQuery("#receiver_name").val();
           var invoice_num= jQuery("#invoice_num").val();
           var audit_amount= jQuery("#audit_amount").val();
                
           var payment_purpose= jQuery("#payment_purpose").val();
           var payment_reason= jQuery("#payment_reason").val();
           var payment_desc= jQuery("#payment_desc").val();
           var cust_id= jQuery("#cust_id").val();
         showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
         maskWindow(); 
           var ids= jQuery("#ids").val();
           var url="<%=request.getContextPath()%>/EpwelfareAction.do?cmd=toPay&payment_month="+payment_month+"&pay_type_id="+pay_type_id+"&receiver_type_id="+receiver_type_id
                   +"&receiver_name="+encodeURI(receiver_name)+"&invoice_num="+invoice_num+"&audit_amount="+audit_amount+"&apply_amount="+apply_amount+"&payment_purpose="+encodeURI(payment_purpose)
                   +"&payment_reason="+encodeURI(payment_reason)+"&payment_desc="+encodeURI(payment_desc)+"&ids="+ids+"&cust_id="+cust_id;
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
		              if(text.length>1000){
		                alert("支付失败！");
		                 window.close();
		              } else{
		                alert(text);
		                window.close();
		              }
		         hideProgressBar('page_progBarId');
                                              unMaskWindow();
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
</script>
