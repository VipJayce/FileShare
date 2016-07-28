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
            //选择客户
	  function rtnFunc(arg)
	  {
	      var lookup = $id("lk_clz");
	      lookup.value = arg[0];
	      lookup.displayValue = arg[2];
	      jQuery("#h_customer_id").val(arg[0]);        
	      return false;
	  }
	  //选择客服
	   function rtnFuncCS(arg){
	       var lookup = $id("lk_cs");
	       lookup.value = arg[0];
	       lookup.displayValue = arg[1];
	       jQuery("#h_user_id").val(arg[0]);        
	       return false;
	   }
    </script>
    </head>
    <body >

    <form name="form" method="post" action="<%=request.getContextPath()%>/EmpsecurityAction.do">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
    <input type="hidden" name="ids" id="ids" value="${ids}">
    <div id="right">
         <div class="ringht_s"></div>
         <div class="xz_title">新增员工体检</div>
         <div class="box_3">
               <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">                
                    <tr>
                        <td class="td_1"><span>*</span>客户编号</td>
                        <td class="td_2">
                            <input type="text" class="text_field" id="cus_no" name="cus_no" inputName="客户编号" value="" />
                        <td class="td_2">客户名称</td>
                        <td class="td_2">
                             <w:lookup onReturnFunc="rtnFunc" readonly="true" id="lk_clz"
                            lookupUrl="/CustomersimpleAction.do?cmd=queryAllGetByID"
                            dialogTitle="选择客户" height="500" width="400" style="width:195px"/> <input type="hidden"
                            name="cust_name" id="h_customer_id" />
                        </td>
                    </tr>      
                    <tr>
                       <td class="td_1">唯一号</td>
                       <td class="td_2">
                           <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="25" />                     
                       </td>
                       <td class="td_1">员工名称</td>
                       <td class="td_2">
                          <input type="text" class="text_field" id="emp_name" name="emp_name" inputName="姓名" value="" />  
                       </td>
                    </tr>         
                    <tr>
                       <td class="td_1"><span>*</span>身份证</td>
                       <td class="td_2">
                        <input type="text" class="text_field" name="id_card" inputName="证件号码" maxLength="64" /></td>
                       <td class="td_1"><span>*</span>所属客服</td>
                       <td class="td_2">
                         <w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" 
                        lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" 
                        height="500" width="400" style="width:195px"/>
                        <input type="hidden" name="user_id" id="h_user_id"/>
                      </td>
                    </tr>
                    <tr>
	                    <td class="td_1" >性别</td>
	                    <td class="td_2 ">
	                      <select name='sex'>
	                        <option value="1">男</option>
	                        <option value="2">女</option>
	                      </select>
	                    </td>
	                    <td class="td_1" >婚否</td>
	                    <td class="td_2" >
	                      <select name='marry'>
	                        <option value="1">未婚</option>
	                        <option value="2">已婚</option>
	                      </select>
	                    </td>
                    </tr>    
                    <tr>
	                    <td class="td_1" >体检开始日期</td>
	                    <td class="td_2 ">
	                      <input type="text" class="text_field" name="id_card" inputName="体检开始日期" maxLength="64" />
	                    </td>
	                    <td class="td_1" >体检截止日期</td>
	                    <td class="td_2" >
	                        <input type="text" class="text_field" name="id_card" inputName="体检截止日期" maxLength="64" />
	                    </td>
                    </tr>     
                    <tr>
	                    <td class="td_1" >结算日期</td>
	                    <td class="td_2 ">
	                      <input type="text" class="text_field" name="id_card" inputName="体检开始日期" maxLength="64" />
	                    </td>
	                    <td class="td_1" ></td>
	                    <td class="td_2" >
	                    </td>
                    </tr> 
                    <tr>
                       <td class="td_1">备注</td>
                       <td colspan="3" class="td_2"><textarea name="payment_desc" id="payment_desc" rows="3" class="xText_d" id="text13"></textarea></td>
                    </tr>                   
               </table>                     
               <div class="foot_button">
                       <input type="button" class="foot_icon_2" value="提交"  onclick="toPay('xxx')"/>
                       <input type="button" class="foot_icon_2" value="返回"  onclick="toPay1('xxx')"/>
                    <!--表格 end--></div>             
        </div>
    </div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
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
           var ids= jQuery("#ids").val();
           var url="<%=request.getContextPath()%>/EpwelfareAction.do?cmd=toPay&payment_month="+payment_month+"&pay_type_id="+pay_type_id+"&receiver_type_id="+receiver_type_id
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
                                  alert("你提交的记录包含了已经支付过的记录，不能重新支付！" );
                              }
                      }
                  }
                  });
                  return flags;
                }
          }
  
    function toPay1(){
         window.close();
    }
</script>
