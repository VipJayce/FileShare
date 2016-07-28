<%  //判断是否为修改页面
 //zhouxiaolong  更改实体类
    CostcenterVo resultVo = null;  //定义一个临时的vo变量
    CostcenterVo resultVo1 = null;  //定义一个临时的vo变量
    CostcenterVo resultVo2 = null;  //定义一个临时的vo变量
	String kefuid="";
    CostcenterVo vo =null;
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ICostcenterConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        	resultVo = (CostcenterVo)request.getAttribute(ICostcenterConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        	resultVo1 = (CostcenterVo)request.getAttribute(ICostcenterConstants.REQUEST_BEAN1);  //从request中取出vo, 赋值给resultVo
        	resultVo2 = (CostcenterVo)request.getAttribute(ICostcenterConstants.REQUEST_BEAN2);  //从request中取出vo, 赋值给resultVo
        	RmVoHelper.null2Nothing(resultVo); 
        	RmVoHelper.null2Nothing(resultVo1); 
        	RmVoHelper.null2Nothing(resultVo2); 
        	kefuid=resultVo.getId();
        	
        }
    }else{
            vo = (CostcenterVo)request.getAttribute("vo");
            kefuid=vo.getId();
    }
%>
<html>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<%@ page import="java.util.List" %>
<%@ page import="rayoo.sales.costcenter.util.ICostcenterConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/common/skins/skin0/component.jsp"%>
<%@ include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<fmt:bundle basename="rayoo.salse.costcenter.costcenter_resource" prefix="rayoo.salse.costcenter.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<style type="text/css">
.datecellCss span{color:#075587;text-align: center;}
</style>
<script type="text/javascript">
jQuery.noConflict();
</script>
<script language="javascript">
<%
if(isModify){%>
     window.onload=function(){
		 var kefuid=document.getElementById('id_bak').value;
    	 $id("datacell1").queryAction="/FAERP/CostcenterAction.do?cmd=simpleQueryVatPayToUpdate"; 
    	 $id("datacell1").addParam("pb_costcenter_id",kefuid);
    	 $id("datacell1").reload();
    	 $id("datacell1").refresh();
	    }
     <%}%>
    function insert_onClick(){  //插入单条数据
       if(vailform()){
    	   if(document.getElementById('taxpayer_identity_type').value==""){
    		   alert("请选择纳税人身份类型！");
    		   return false;
    	   }
    	   if(document.getElementById('taxpayer_identity_type').value=="1"){
    	   if(document.getElementById('taxpayer_identification_number_add').value==""){
    		   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
               alert("纳税人识别号不能为空！");
               //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
               return false;
           }
    	 //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
    	   else{
        	   var reg =/^[0-9a-zA-Z]*$/g;     
               var taxpayer_identification_number = document.getElementById('taxpayer_identification_number_add').value;
               var result="";
    		    for (i=0 ; i<taxpayer_identification_number.length; i++)
    		   {
    		    code = taxpayer_identification_number.charCodeAt(i);             
    		    //获取当前字符的unicode编码
    		    if (code >= 65281 && code <= 65373)   
    		    //unicode编码范围是所有的英文字母以及各种字符
    		    {
    		    result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 65248);    
    		    //把全角字符的unicode编码转换为对应半角字符的unicode码
    		    }
    		    else if (code == 12288)                                      
    		    //空格
    		    {
    		    if(String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32)==" "){
		    		 result +="";
 		    	}else{
 		           result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32);
 		    	}
    		    //半角空格
    		    }else
    		    {
    		     if(taxpayer_identification_number.charAt(i)==" "){
    		    	result +="";
    		     }
    		     else{
    		    	result +=taxpayer_identification_number.charAt(i);
    		     }	
    			 
    		     //原字符返回
    		    }
    		    }
    		   taxpayer_identification_number=result;
               document.getElementById('taxpayer_identification_number_add').value=taxpayer_identification_number;
               var str=taxpayer_identification_number.match(reg);
        	   if(str==null){
        		   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
        		   return false;
        	   }else{
        		   if(taxpayer_identification_number.length!=15&&taxpayer_identification_number.length!=17&&taxpayer_identification_number.length!=18&&taxpayer_identification_number.length!=20){
        			   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
               return false;
           }
        	   }
           }
    	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
           if(document.getElementById('tax_registration_address_add').value==""){
               alert("税务登记地址不能为空！");
               return false;
           }
           //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
      	   else{
   		    var tax_registration_address=document.getElementById('tax_registration_address_add').value;
   		    var result="";
		    for (i=0 ; i<tax_registration_address.length; i++)
		   {
		    code = tax_registration_address.charCodeAt(i);             
		    //获取当前字符的unicode编码
		    if (code >= 65281 && code <= 65373)   
		    //unicode编码范围是所有的英文字母以及各种字符
		    {
		    result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 65248);    
		    //把全角字符的unicode编码转换为对应半角字符的unicode码
		    }
		    else if (code == 12288)                                      
		    //空格
		    {
		    	 if(String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32)==" "){
		    		 result +="";
 		    	}else{
 		           result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32);
 		    	}
		    //半角空格
		    }else
		    {
		     if(tax_registration_address.charAt(i)==" "){
		    	result +="";
		     }
		    else{
		    	result +=tax_registration_address.charAt(i);
		     }	
			 
		     //原字符返回
		    }
		    }
		    tax_registration_address=result;
			document.getElementById('tax_registration_address_add').value=tax_registration_address;
             }
      	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
           if(document.getElementById('tax_registration_telnum_add').value==""){
               alert("税务登记电话号码不能为空！");
               return false;
           }
         //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
    	   else{
                var tax_registration_telnum = document.getElementById('tax_registration_telnum_add').value;
                var result="";
    		    for (i=0 ; i<tax_registration_telnum.length; i++)
    		   {
    		    code = tax_registration_telnum.charCodeAt(i);             
    		    //获取当前字符的unicode编码
    		    if (code >= 65281 && code <= 65373)   
    		    //unicode编码范围是所有的英文字母以及各种字符
    		    {
    		    result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 65248);    
    		    //把全角字符的unicode编码转换为对应半角字符的unicode码
    		    }
    		    else if (code == 12288)                                      
    		    //空格
    		    {
    		    	 if(String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32)==" "){
    		    		 result +="";
     		    	}else{
     		           result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32);
     		    	}
    		    //半角空格
    		    }else
    		    {
    		     if(tax_registration_telnum.charAt(i)==" "){
    		    	result +="";
    		     }
    		     else{
    		    	result +=tax_registration_telnum.charAt(i);
    		     }	
    			 
    		     //原字符返回
    		    }
    		    }
    		   tax_registration_telnum=result;
    		   var reg = /^\d[\d\-]*$/;
     	       if(!reg.test(tax_registration_telnum)){
     	       alert("纳税人电话格式错误！");	   
    	       return;
    	      }
    		   document.getElementById('tax_registration_telnum_add').value=tax_registration_telnum;
           }
    	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
           if(document.getElementById('tax_registration_bank_add').value==""){
               alert("税务登记开户银行不能为空！");
               return false;
           }
           //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
       	   else{
		       var tax_registration_bank=document.getElementById('tax_registration_bank_add').value;
		       var result="";
   		    for (i=0 ; i<tax_registration_bank.length; i++)
   		   {
   		    code = tax_registration_bank.charCodeAt(i);             
   		    //获取当前字符的unicode编码
   		    if (code >= 65281 && code <= 65373)   
   		    //unicode编码范围是所有的英文字母以及各种字符
   		    {
   		    result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 65248);    
   		    //把全角字符的unicode编码转换为对应半角字符的unicode码
   		    }
   		    else if (code == 12288)                                      
   		    //空格
   		    {
   		    	if(String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32)==" "){
		    		 result +="";
		    	}else{
		           result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32);
		    	}
   		    //半角空格
   		    }else
   		    {
   		     if(tax_registration_bank.charAt(i)==" "){
   		    	result +="";
   		     }
   		 　　　else{
   		    	result +=tax_registration_bank.charAt(i);
   		     }	
   			 
   		     //原字符返回
   		    }
   		    }
   		    tax_registration_bank=result;
   		    var reg = new RegExp("^[0-9]*$");
   		    if(reg.test(tax_registration_bank)){
   			   alert("纳税人开户行不能由纯数字组成！");
   			   return;
   		    }
   			document.getElementById('tax_registration_bank_add').value=tax_registration_bank;
              }
       	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
           if(document.getElementById('tax_registration_bank_account_add').value==""){
               alert("税务登记银行账号不能为空！");
               return false;
           }
      	 //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
    	   else{
    		   var reg = new RegExp("^[0-9]*$");  
               var tax_registration_bank_account = document.getElementById('tax_registration_bank_account_add').value;
               var result="";
   		    for (i=0 ; i<tax_registration_bank_account.length; i++)
   		   {
   		    code = tax_registration_bank_account.charCodeAt(i);             
   		    //获取当前字符的unicode编码
   		    if (code >= 65281 && code <= 65373)   
   		    //unicode编码范围是所有的英文字母以及各种字符
   		    {
   		    result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 65248);    
   		    //把全角字符的unicode编码转换为对应半角字符的unicode码
   		    }
   		    else if (code == 12288)                                      
   		    //空格
   		    {
   		    	if(String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32)==" "){
		    		 result +="";
		    	}else{
		           result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32);
    	   }
   		    //半角空格
   		    }else
   		    {
   		     if(tax_registration_bank_account.charAt(i)==" "){
   		    	result +="";
   		     }
   		     
   		     else{
   		    	result +=tax_registration_bank_account.charAt(i);
   		     }	
   			 
   		     //原字符返回
   		    }
   		    }
   		       tax_registration_bank_account=result;
   			   document.getElementById('tax_registration_bank_account_add').value=tax_registration_bank_account;
        	   if(!reg.test(tax_registration_bank_account)){
        		   alert("纳税人银行账号只能由数字组成！");
        		   return false;
        	   }
           }
    	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
    	   }
    	   //2016-07-14  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
    	   else{
    		   if(document.getElementById('taxpayer_identification_number_add').value==""){
               }
        	 //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
        	   else{
            	   var reg =/^[0-9a-zA-Z]*$/g;     
                   var taxpayer_identification_number = document.getElementById('taxpayer_identification_number_add').value;
                   var result="";
        		    for (i=0 ; i<taxpayer_identification_number.length; i++)
        		   {
        		    code = taxpayer_identification_number.charCodeAt(i);             
        		    //获取当前字符的unicode编码
        		    if (code >= 65281 && code <= 65373)   
        		    //unicode编码范围是所有的英文字母以及各种字符
        		    {
        		    result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 65248);    
        		    //把全角字符的unicode编码转换为对应半角字符的unicode码
        		    }
        		    else if (code == 12288)                                      
        		    //空格
        		    {
        		    if(String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32)==" "){
    		    		 result +="";
     		    	}else{
     		           result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32);
     		    	}
        		    //半角空格
        		    }else
        		    {
        		     if(taxpayer_identification_number.charAt(i)==" "){
        		    	result +="";
        		     }
        		     else{
        		    	result +=taxpayer_identification_number.charAt(i);
        		     }	
        			 
        		     //原字符返回
        		    }
        		    }
        		   taxpayer_identification_number=result;
                   document.getElementById('taxpayer_identification_number_add').value=taxpayer_identification_number;
                   var str=taxpayer_identification_number.match(reg);
            	   if(str==null){
            		   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
            		   return false;
            	   }else{
            		   if(taxpayer_identification_number.length!=15&&taxpayer_identification_number.length!=17&&taxpayer_identification_number.length!=18&&taxpayer_identification_number.length!=20){
            			   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
                   return false;
               }
            	   }
               }
        	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
               if(document.getElementById('tax_registration_address_add').value==""){
               }
               //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
          	   else{
       		    var tax_registration_address=document.getElementById('tax_registration_address_add').value;
       		    var result="";
    		    for (i=0 ; i<tax_registration_address.length; i++)
    		   {
    		    code = tax_registration_address.charCodeAt(i);             
    		    //获取当前字符的unicode编码
    		    if (code >= 65281 && code <= 65373)   
    		    //unicode编码范围是所有的英文字母以及各种字符
    		    {
    		    result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 65248);    
    		    //把全角字符的unicode编码转换为对应半角字符的unicode码
    		    }
    		    else if (code == 12288)                                      
    		    //空格
    		    {
    		    	 if(String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32)==" "){
    		    		 result +="";
     		    	}else{
     		           result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32);
     		    	}
    		    //半角空格
    		    }else
    		    {
    		     if(tax_registration_address.charAt(i)==" "){
    		    	result +="";
    		     }
    		    else{
    		    	result +=tax_registration_address.charAt(i);
    		     }	
    			 
    		     //原字符返回
    		    }
    		    }
    		    tax_registration_address=result;
    			document.getElementById('tax_registration_address_add').value=tax_registration_address;
                 }
          	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
               if(document.getElementById('tax_registration_telnum_add').value==""){
               }
             //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
        	   else{
                    var tax_registration_telnum = document.getElementById('tax_registration_telnum_add').value;
                    var result="";
        		    for (i=0 ; i<tax_registration_telnum.length; i++)
        		   {
        		    code = tax_registration_telnum.charCodeAt(i);             
        		    //获取当前字符的unicode编码
        		    if (code >= 65281 && code <= 65373)   
        		    //unicode编码范围是所有的英文字母以及各种字符
        		    {
        		    result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 65248);    
        		    //把全角字符的unicode编码转换为对应半角字符的unicode码
        		    }
        		    else if (code == 12288)                                      
        		    //空格
        		    {
        		    	 if(String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32)==" "){
        		    		 result +="";
         		    	}else{
         		           result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32);
         		    	}
        		    //半角空格
        		    }else
        		    {
        		     if(tax_registration_telnum.charAt(i)==" "){
        		    	result +="";
        		     }
        		     else{
        		    	result +=tax_registration_telnum.charAt(i);
        		     }	
        			 
        		     //原字符返回
        		    }
        		    }
        		   tax_registration_telnum=result;
        		   var reg =/^\d[\d\-]*$/;
         	       if(!reg.test(tax_registration_telnum)){
         	       alert("纳税人电话格式错误！");	   
        	       return;
        	      }
        		   document.getElementById('tax_registration_telnum_add').value=tax_registration_telnum;
               }
        	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
               if(document.getElementById('tax_registration_bank_add').value==""){
               }
               //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
           	   else{
    		       var tax_registration_bank=document.getElementById('tax_registration_bank_add').value;
    		       var result="";
       		    for (i=0 ; i<tax_registration_bank.length; i++)
       		   {
       		    code = tax_registration_bank.charCodeAt(i);             
       		    //获取当前字符的unicode编码
       		    if (code >= 65281 && code <= 65373)   
       		    //unicode编码范围是所有的英文字母以及各种字符
       		    {
       		    result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 65248);    
       		    //把全角字符的unicode编码转换为对应半角字符的unicode码
       		    }
       		    else if (code == 12288)                                      
       		    //空格
       		    {
       		    	if(String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32)==" "){
    		    		 result +="";
    		    	}else{
    		           result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32);
    		    	}
       		    //半角空格
       		    }else
       		    {
       		     if(tax_registration_bank.charAt(i)==" "){
       		    	result +="";
       		     }
       		 　　　else{
       		    	result +=tax_registration_bank.charAt(i);
       		     }	
       			 
       		     //原字符返回
       		    }
       		    }
       		    tax_registration_bank=result;
       		    var reg = new RegExp("^[0-9]*$");
    		    if(reg.test(tax_registration_bank)){
    			   alert("纳税人开户行不能由纯数字组成！");
    			   return;
    		    }
       			document.getElementById('tax_registration_bank_add').value=tax_registration_bank;
                  }
           	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
               if(document.getElementById('tax_registration_bank_account_add').value==""){
               }
          	 //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
        	   else{
        		   var reg = new RegExp("^[0-9]*$");  
                   var tax_registration_bank_account = document.getElementById('tax_registration_bank_account_add').value;
                   var result="";
       		    for (i=0 ; i<tax_registration_bank_account.length; i++)
       		   {
       		    code = tax_registration_bank_account.charCodeAt(i);             
       		    //获取当前字符的unicode编码
       		    if (code >= 65281 && code <= 65373)   
       		    //unicode编码范围是所有的英文字母以及各种字符
       		    {
       		    result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 65248);    
       		    //把全角字符的unicode编码转换为对应半角字符的unicode码
       		    }
       		    else if (code == 12288)                                      
       		    //空格
       		    {
       		    	if(String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32)==" "){
    		    		 result +="";
    		    	}else{
    		           result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32);
        	   }
       		    //半角空格
       		    }else
       		    {
       		     if(tax_registration_bank_account.charAt(i)==" "){
       		    	result +="";
       		     }
       		     
       		     else{
       		    	result +=tax_registration_bank_account.charAt(i);
       		     }	
       			 
       		     //原字符返回
       		    }
       		    }
       		       tax_registration_bank_account=result;
       			   document.getElementById('tax_registration_bank_account_add').value=tax_registration_bank_account;
            	   if(!reg.test(tax_registration_bank_account)){
            		   alert("纳税人银行账号只能由数字组成！");
            		   return false;
            	   }
               }
    	   }
    	   //2016-07-14  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
    	       if(jQuery("#bill_day").val()!=""){
    	    	   var params = jQuery("#page_form").serialize();
                   jQuery.post("<%=request.getContextPath()%>/CostcenterAction.do?cmd=insertNew", params, function(data){
                	   if (!!data) {
    	            	   returnValue = ["1"];
    	                   var oid = data;
    	                   var xmlSubmit=$id("datacell1").dataset.toString();
    	                   var action="<%=request.getContextPath()%>/CostcenterAction.do?cmd=save";
    	                   var myAjax = new Ajax(action);
    	                   myAjax.addParam('oid',oid);
    	                   myAjax.submitXML(xmlSubmit);
    	                   window.close();
    	                   window.opener.callBack(returnValue);
                	   }
                   });
    	       }else{
    	    	   alert("账单日不能为空！");
    	       }
       }
        
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        if(vailform()){
        	if(document.getElementById('taxpayer_identity_type_bak').value==""){
        		alert("请选择纳税人身份类型！");
        		return false;
        	}
        	if(document.getElementById('taxpayer_identity_type_bak').value=="1"){
         	   if(document.getElementById('taxpayer_identification_number').value==""){
         		    //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                    alert("纳税人识别号不能为空！");
                    //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                    return false;
                }
         	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
        	   else{
            	   var reg =/^[0-9a-zA-Z]*$/g;     
                   var taxpayer_identification_number = document.getElementById('taxpayer_identification_number').value;
                   var result="";
         		    for (i=0 ; i<taxpayer_identification_number.length; i++)
         		   {
         		    code = taxpayer_identification_number.charCodeAt(i);             
         		    //获取当前字符的unicode编码
         		    if (code >= 65281 && code <= 65373)   
         		    //unicode编码范围是所有的英文字母以及各种字符
         		    {
         		    result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 65248);    
         		    //把全角字符的unicode编码转换为对应半角字符的unicode码
         		    }
         		    else if (code == 12288)                                      
         		    //空格
         		    {
         		    	if(String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32)==" "){
         		    		 result +="";
         		    	}else{
         		           result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32);
         		    	}
         		    //半角空格
         		    }else
         		    {
         		     if(taxpayer_identification_number.charAt(i)==" "){
         		    	result +="";
         		     }else{
         		    	result +=taxpayer_identification_number.charAt(i);
         		     }	
         			 
         		     //原字符返回
         		    }
         		    }
         		   taxpayer_identification_number=result;
        		   document.getElementById('taxpayer_identification_number').value=taxpayer_identification_number;
                   var str=taxpayer_identification_number.match(reg);
            	   if(str==null){
            		   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
            		   return false;
            	   }else{
            		   if(taxpayer_identification_number.length!=15&&taxpayer_identification_number.length!=17&&taxpayer_identification_number.length!=18&&taxpayer_identification_number.length!=20){
            			   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
                    return false;
                }
            	   }
               }
        	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                if(document.getElementById('tax_registration_address').value==""){
                    alert("税务登记地址不能为空！");
                    return false;
                }
                //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
          	   else{
          		    var tax_registration_address=document.getElementById('tax_registration_address').value;
          		    var result="";
          		    for (i=0 ; i<tax_registration_address.length; i++)
          		   {
          		    code = tax_registration_address.charCodeAt(i);             
          		    //获取当前字符的unicode编码
          		    if (code >= 65281 && code <= 65373)   
          		    //unicode编码范围是所有的英文字母以及各种字符
          		    {
          		    result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 65248);    
          		    //把全角字符的unicode编码转换为对应半角字符的unicode码
          		    }
          		    else if (code == 12288)                                      
          		    //空格
          		    {
          		    	if(String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32)==" "){
        		    		result += "";
        		    	}else{
        		    		result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32);
        		    	}
          		    //半角空格
          		    }else
          		    {
          		     if(tax_registration_address.charAt(i)==" "){
          		    	result +="";
          		     }else{
          		    	result +=tax_registration_address.charAt(i);
          		     }	
          			 
          		     //原字符返回
          		    }
          		    }
          		    tax_registration_address=result;
          			document.getElementById('tax_registration_address').value=tax_registration_address;
                 }
          	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                if(document.getElementById('tax_registration_telnum').value==""){
                    alert("税务登记电话号码不能为空！");
                    return false;
                }
                //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
         	   else{
                   var tax_registration_telnum = document.getElementById('tax_registration_telnum').value;
                   var result="";
         		    for (i=0 ; i<tax_registration_telnum.length; i++)
         		   {
         		    code = tax_registration_telnum.charCodeAt(i);             
         		    //获取当前字符的unicode编码
         		    if (code >= 65281 && code <= 65373)   
         		    //unicode编码范围是所有的英文字母以及各种字符
         		    {
         		    result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 65248);    
         		    //把全角字符的unicode编码转换为对应半角字符的unicode码
         		    }
         		    else if (code == 12288)                                      
         		    //空格
         		    {
         		    	if( String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32)==" "){
        		    		result += "";
        		    	}else{
        		    		result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32);
        		    	}
         		    //半角空格
         		    }else
         		    {
         		     if(tax_registration_telnum.charAt(i)==" "){
         		    	result +="";
         		     }else{
         		    	result +=tax_registration_telnum.charAt(i);
         		     }	
         			 
         		     //原字符返回
         		    }
         		    }
         		   tax_registration_telnum=result;
         		   var reg = /^\d[\d\-]*$/;
         	       if(!reg.test(tax_registration_telnum)){
         	       alert("纳税人电话格式错误！");	   
         	       return;
         	      }
         		   document.getElementById('tax_registration_telnum').value=tax_registration_telnum;
                }
         	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                if(document.getElementById('tax_registration_bank').value==""){
                    alert("税务登记开户银行不能为空！");
                    return false;
                }
              //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
           	   else{
      		     var tax_registration_bank=document.getElementById('tax_registration_bank').value;
      		   var result="";
    		    for (i=0 ; i<tax_registration_bank.length; i++)
    		   {
    		    code = tax_registration_bank.charCodeAt(i);             
    		    //获取当前字符的unicode编码
    		    if (code >= 65281 && code <= 65373)   
    		    //unicode编码范围是所有的英文字母以及各种字符
    		    {
    		    result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 65248);    
    		    //把全角字符的unicode编码转换为对应半角字符的unicode码
    		    }
    		    else if (code == 12288)                                      
    		    //空格
    		    {
    		    	if(String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32) - 12288 + 32==" "){
    		    		result += "";
    		    	}else{
    		    		result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32);
    		    	}
    		   
    		    //半角空格
    		    }else
    		    {
    		     if(tax_registration_bank.charAt(i)==" "){
    		    	result +="";
    		     }else{
    		    	result +=tax_registration_bank.charAt(i);
    		     }	
    			 
    		     //原字符返回
    		    }
    		    }
    		    tax_registration_bank=result;
    		    var reg = new RegExp("^[0-9]*$");
    		    if(reg.test(tax_registration_bank)){
    			   alert("纳税人开户行不能由纯数字组成！");
    			   return;
    		    }
    			document.getElementById('tax_registration_bank').value=tax_registration_bank;
                  }
           	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                if(document.getElementById('tax_registration_bank_account').value==""){
                    alert("税务登记银行账号不能为空！");
                    return false;
                }
              //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
         	   else{
         		   var reg = new RegExp("^[0-9]*$");  
                   var tax_registration_bank_account = document.getElementById('tax_registration_bank_account').value;
                   var result="";
       		    for (i=0 ; i<tax_registration_bank_account.length; i++)
       		   {
       		    code = tax_registration_bank_account.charCodeAt(i);             
       		    //获取当前字符的unicode编码
       		    if (code >= 65281 && code <= 65373)   
       		    //unicode编码范围是所有的英文字母以及各种字符
       		    {
       		     result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 65248);
       		    //把全角字符的unicode编码转换为对应半角字符的unicode码
       		    }
       		    else if (code == 12288)                                      
       		    //空格
       		    {
       		    	if(String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32)==" "){
       		    		result +="";
       		    	}else{
       		    		result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32);
       		    	}
       		    //半角空格
       		    }else
       		    {
       		     if(tax_registration_bank_account.charAt(i)==" "){
       		    	result +="";
       		     }else{
       		    	result +=tax_registration_bank_account.charAt(i);
       		     }	
       			 
       		     //原字符返回
       		    }
       		    }
       		       tax_registration_bank_account=result;
       			   document.getElementById('tax_registration_bank_account').value=tax_registration_bank_account;
            	   if(!reg.test(tax_registration_bank_account)){
            		   alert("纳税人银行账号只能由数字组成！");
            		   return false;
            	   }
                }
         	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
         	   }
        	//2016-07-14  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
        	else{
        		 if(document.getElementById('taxpayer_identification_number').value==""){
                 }
          	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
         	   else{
             	   var reg =/^[0-9a-zA-Z]*$/g;     
                    var taxpayer_identification_number = document.getElementById('taxpayer_identification_number').value;
                    var result="";
          		    for (i=0 ; i<taxpayer_identification_number.length; i++)
          		   {
          		    code = taxpayer_identification_number.charCodeAt(i);             
          		    //获取当前字符的unicode编码
          		    if (code >= 65281 && code <= 65373)   
          		    //unicode编码范围是所有的英文字母以及各种字符
          		    {
          		    result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 65248);    
          		    //把全角字符的unicode编码转换为对应半角字符的unicode码
          		    }
          		    else if (code == 12288)                                      
          		    //空格
          		    {
          		    	if(String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32)==" "){
          		    		 result +="";
          		    	}else{
          		           result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32);
          		    	}
          		    //半角空格
          		    }else
          		    {
          		     if(taxpayer_identification_number.charAt(i)==" "){
          		    	result +="";
          		     }else{
          		    	result +=taxpayer_identification_number.charAt(i);
          		     }	
          			 
          		     //原字符返回
          		    }
          		    }
          		   taxpayer_identification_number=result;
         		   document.getElementById('taxpayer_identification_number').value=taxpayer_identification_number;
                    var str=taxpayer_identification_number.match(reg);
             	   if(str==null){
             		   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
             		   return false;
             	   }else{
             		   if(taxpayer_identification_number.length!=15&&taxpayer_identification_number.length!=17&&taxpayer_identification_number.length!=18&&taxpayer_identification_number.length!=20){
             			   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
                     return false;
                 }
             	   }
                }
         	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                 if(document.getElementById('tax_registration_address').value==""){
                 }
                 //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
           	   else{
           		    var tax_registration_address=document.getElementById('tax_registration_address').value;
           		    var result="";
           		    for (i=0 ; i<tax_registration_address.length; i++)
           		   {
           		    code = tax_registration_address.charCodeAt(i);             
           		    //获取当前字符的unicode编码
           		    if (code >= 65281 && code <= 65373)   
           		    //unicode编码范围是所有的英文字母以及各种字符
           		    {
           		    result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 65248);    
           		    //把全角字符的unicode编码转换为对应半角字符的unicode码
           		    }
           		    else if (code == 12288)                                      
           		    //空格
           		    {
           		    	if(String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32)==" "){
         		    		result += "";
         		    	}else{
         		    		result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32);
         		    	}
           		    //半角空格
           		    }else
           		    {
           		     if(tax_registration_address.charAt(i)==" "){
           		    	result +="";
           		     }else{
           		    	result +=tax_registration_address.charAt(i);
           		     }	
           			 
           		     //原字符返回
           		    }
           		    }
           		    tax_registration_address=result;
           			document.getElementById('tax_registration_address').value=tax_registration_address;
                  }
           	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                 if(document.getElementById('tax_registration_telnum').value==""){
                 }
                 //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
          	   else{
                    var tax_registration_telnum = document.getElementById('tax_registration_telnum').value;
                    var result="";
          		    for (i=0 ; i<tax_registration_telnum.length; i++)
          		   {
          		    code = tax_registration_telnum.charCodeAt(i);             
          		    //获取当前字符的unicode编码
          		    if (code >= 65281 && code <= 65373)   
          		    //unicode编码范围是所有的英文字母以及各种字符
          		    {
          		    result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 65248);    
          		    //把全角字符的unicode编码转换为对应半角字符的unicode码
          		    }
          		    else if (code == 12288)                                      
          		    //空格
          		    {
          		    	if( String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32)==" "){
         		    		result += "";
         		    	}else{
         		    		result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32);
         		    	}
          		    //半角空格
          		    }else
          		    {
          		     if(tax_registration_telnum.charAt(i)==" "){
          		    	result +="";
          		     }else{
          		    	result +=tax_registration_telnum.charAt(i);
          		     }	
          			 
          		     //原字符返回
          		    }
          		    }
          		   tax_registration_telnum=result;
          		   var reg = /^\d[\d\-]*$/;
          	       if(!reg.test(tax_registration_telnum)){
          	       alert("纳税人电话格式错误！");	   
          	       return;
          	      }
          		   document.getElementById('tax_registration_telnum').value=tax_registration_telnum;
                 }
          	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                 if(document.getElementById('tax_registration_bank').value==""){
                 }
               //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
            	   else{
       		     var tax_registration_bank=document.getElementById('tax_registration_bank').value;
       		   var result="";
     		    for (i=0 ; i<tax_registration_bank.length; i++)
     		   {
     		    code = tax_registration_bank.charCodeAt(i);             
     		    //获取当前字符的unicode编码
     		    if (code >= 65281 && code <= 65373)   
     		    //unicode编码范围是所有的英文字母以及各种字符
     		    {
     		    result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 65248);    
     		    //把全角字符的unicode编码转换为对应半角字符的unicode码
     		    }
     		    else if (code == 12288)                                      
     		    //空格
     		    {
     		    	if(String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32) - 12288 + 32==" "){
     		    		result += "";
     		    	}else{
     		    		result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32);
     		    	}
     		   
     		    //半角空格
     		    }else
     		    {
     		     if(tax_registration_bank.charAt(i)==" "){
     		    	result +="";
     		     }else{
     		    	result +=tax_registration_bank.charAt(i);
     		     }	
     			 
     		     //原字符返回
     		    }
     		    }
     		    tax_registration_bank=result;
     		    var reg = new RegExp("^[0-9]*$");
   		        if(reg.test(tax_registration_bank)){
   			      alert("纳税人开户行不能由纯数字组成！");
   			      return;
   		        }
     			document.getElementById('tax_registration_bank').value=tax_registration_bank;
                   }
            	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                 if(document.getElementById('tax_registration_bank_account').value==""){
                 }
               //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
          	   else{
          		   var reg = new RegExp("^[0-9]*$");  
                    var tax_registration_bank_account = document.getElementById('tax_registration_bank_account').value;
                    var result="";
        		    for (i=0 ; i<tax_registration_bank_account.length; i++)
        		   {
        		    code = tax_registration_bank_account.charCodeAt(i);             
        		    //获取当前字符的unicode编码
        		    if (code >= 65281 && code <= 65373)   
        		    //unicode编码范围是所有的英文字母以及各种字符
        		    {
        		     result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 65248);
        		    //把全角字符的unicode编码转换为对应半角字符的unicode码
        		    }
        		    else if (code == 12288)                                      
        		    //空格
        		    {
        		    	if(String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32)==" "){
        		    		result +="";
        		    	}else{
        		    		result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32);
        		    	}
        		    //半角空格
        		    }else
        		    {
        		     if(tax_registration_bank_account.charAt(i)==" "){
        		    	result +="";
        		     }else{
        		    	result +=tax_registration_bank_account.charAt(i);
        		     }	
        			 
        		     //原字符返回
        		    }
        		    }
        		       tax_registration_bank_account=result;
        			   document.getElementById('tax_registration_bank_account').value=tax_registration_bank_account;
             	   if(!reg.test(tax_registration_bank_account)){
             		   alert("纳税人银行账号只能由数字组成！");
             		   return false;
             	   }
                 }
          	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
        	}
        	//2016-07-14  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
        	 if(jQuery("#bill_day_bak").val()!=""){
        	  var id_bak=jQuery("#id_bak").val();
              form.action="<%=request.getContextPath()%>/CostcenterAction.do?cmd=update";
              form.submit();
              returnValue = ["1"];
              $id("datacell1").submitAction="/FAERP/CostcenterAction.do?cmd=updateVat&id_bak="+id_bak;
              $id("datacell1").isModefied = true;
              $id("datacell1").submit();
              window.close();
              window.opener.callBack(returnValue);
        	 }else{
        		 alert("账单日不能为空！");
        	 }
        }
        
    }
     function isPayticketforDelegate2(){
         if(jQuery("#is_payticket_for_delegate").val()=='1'){
             batch_date("0.0078","add_tax_rate_for_delegate");
             jQuery("#add_tax_rate_for_delegate").attr("readOnly",false);

         }else{
             batch_date("","add_tax_rate_for_delegate");
             jQuery("#add_tax_rate_for_delegate").attr("readOnly",true);
         }
     }
     function batch_date(obj,name){  
         var enCurEntity1 = $id("datacell1").activeEntity;
         var entity = enCurEntity1.getProperty(name);
         enCurEntity1.setProperty(name,obj);
         return true;            
     }
   //20160425  by zhouxiaolong   批量修改日期      end
    
    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/CostcenterAction.do?cmd=queryAll&backFlag=false";
        //form.submit();
        window.close();
    }
    function vailform(){
         var cost_center_name = document.getElementById('cost_center_name').value;
         if(cost_center_name==null || cost_center_name==""){
            alert("<fmt:message key='input_cost_center_name'/>");
            return false;
         }
         var receipt_title = document.getElementById('receipt_title').value;
         if(receipt_title==null || receipt_title==""){
            alert("<fmt:message key='input_receipt_title'/>");
            return false;
         }
         var pattern = new RegExp("^[A-Z0-9a-z\u4e00-\u9fa5()（）.\\-— ——&•·,']+$");
         if(pattern.test(receipt_title) == false){
               alert("成本中心发票抬头不能包含特殊字符！");
               return false;
         }
         
         
         var is_account_limit = document.getElementById('is_account_limit').value;
         if(is_account_limit==null || is_account_limit==""){
            alert("<fmt:message key='choose_is_account_limit'/>");
            return false;
         }
         
         
         var is_finance_send = document.getElementById('is_finance_send').value;
           if(is_finance_send==null || is_finance_send==""){
            alert("<fmt:message key='choose_is_finance_send'/>");
            return false;
           }       
         var agree_receive_money_date = document.getElementById('agree_receive_money_date').value;
         if(agree_receive_money_date==null || agree_receive_money_date==""){
            alert("<fmt:message key='input_agree_receive_money_date'/>");
            return false;
         }
         if(agree_receive_money_date>31 || agree_receive_money_date<0){
             alert("<fmt:message key='agree_receive_money_date_number'/>");
            return false;
         }       
         
         var receive_money_month = "";
         if(is_account_limit == '0'){
            receive_money_month=  document.getElementById('receive_money_month1').value;
         }else{
            receive_money_month=  document.getElementById('receive_money_month2').value;
         }
         if(receive_money_month==null || receive_money_month==""){
            alert("<fmt:message key='choose_receive_money_month'/>");
            return false;
         }
         else{
            document.getElementById('receive_money_month').value=receive_money_month;
         }
     
         if(is_account_limit == '0'){
            if(receive_money_month != '13'){//没有账期，选择下个月到款则不能超过下月5号
                if(agree_receive_money_date>5){
                    alert("<fmt:message key='receive_money_date_less_number'/>");
                    return false;
                 }
            }
            else if(agree_receive_money_date>31 || agree_receive_money_date<0)
            {
                 alert("<fmt:message key='agree_receive_money_date_number'/>");
              return false;
            }
        }
        //如果有账期则验证到款日
        else if(agree_receive_money_date>31 || agree_receive_money_date<0)
        {
              alert("<fmt:message key='agree_receive_money_date_number'/>");
              return false;
        }
        
        
         
    
        
        
        var contract_receive_money_date = document.getElementById('contract_receive_money_date').value;
         if(contract_receive_money_date==null || contract_receive_money_date==""){
          //  alert("请输入合同约定到款日");
          //  return false;
         }
         if(contract_receive_money_date>31 || contract_receive_money_date<0){
           //  alert("合同约定到款日只能是1-31之间数字");
           // return false;
         }       
         
         var contract_receive_money_month = null;
         if(is_account_limit == '0'){
            contract_receive_money_month=  document.getElementById('contract_receive_money_month1').value;
         }else{
            contract_receive_money_month=  document.getElementById('contract_receive_money_month2').value;
         }
         if(contract_receive_money_month==null || contract_receive_money_month==""){
           // alert("请选择到合同约定到款所属月");
           // return false;
         }else{
            document.getElementById('contract_receive_money_month').value=contract_receive_money_month;
         }
     
         if(is_account_limit == '0'){
            if(contract_receive_money_month != '13'){
                if(contract_receive_money_date>5){
                //    alert("合同约定到款日不能超过5号");
                 //   return false;
                 }
            }
            else if(contract_receive_money_date>31 || contract_receive_money_date<0)
            {
              //   alert("合同约定到款日只能是1-31之间数字");
              //return false;
            }
        }
        else if(contract_receive_money_date>31 || contract_receive_money_date<0)
        {
             // alert("合同约定到款日只能是1-31之间数字");
            //  return false;
        }
        
       //  alert('tessss'+document.getElementById('contract_receive_money_month').value);
      
          var is_beforehand_voucher =document.getElementById('is_beforehand_voucher').value;
          if(is_beforehand_voucher==null || is_beforehand_voucher==""){
            alert("<fmt:message key='choose_is_beforehand_voucher'/>");
            return false;
          }
          
           
           var is_remittance_error =document.getElementById('is_remittance_error').value;
           if(is_remittance_error==null || is_remittance_error==""){
            alert("<fmt:message key='choose_is_remittance_error'/>");
            return false;
           }
           
           var is_fixed_pay_later =document.getElementById('is_fixed_pay_later').value;
           if(is_fixed_pay_later==null || is_fixed_pay_later==""){
            alert("<fmt:message key='choose_is_fixed_pay_later'/>");
            return false;
           }
           return true;
    }
    
    
     function account(obj){
     _dofilter(obj.value);
        }
   function _dofilter(obj){
                if(obj==0){
                jQuery("#receive_money_month1").removeAttr("disabled");
                jQuery("#receive_money_month1").show();
                jQuery("#receive_money_month2").hide();
                jQuery("#receive_money_month2").attr("disabled", "disabled");
                
                jQuery("#contract_receive_money_month1").removeAttr("disabled");
                jQuery("#contract_receive_money_month1").show();
                jQuery("#contract_receive_money_month2").hide(); 
                jQuery("#contract_receive_money_month2").attr("disabled", "disabled"); 
        }else{
                jQuery("#receive_money_month2").removeAttr("disabled");
                jQuery("#receive_money_month2").show();
                jQuery("#receive_money_month1").hide();
                jQuery("#receive_money_month1").attr("disabled", "disabled");
                
                jQuery("#contract_receive_money_month2").removeAttr("disabled");
                jQuery("#contract_receive_money_month2").show();
                jQuery("#contract_receive_money_month1").hide();
                jQuery("#contract_receive_money_month1").attr("disabled", "disabled");
        }
               }
</script>
</head>
<body>

<form name="form" method="post" id="page_form">
	<input type="hidden" name="create_date" />
<div id="right">
   <div id="ccParent0" class="box_3"> 
<%
if(!isModify){
	String taxpayer_identification_number=vo.getTaxpayer_identification_number();
	String tax_registration_address=vo.getTax_registration_address();
	String tax_registration_telnum=vo.getTax_registration_telnum();
	String tax_registration_bank=vo.getTax_registration_bank();
	String tax_registration_bank_account=vo.getTax_registration_bank_account();
	if(taxpayer_identification_number==null){
		taxpayer_identification_number="";
	}
	if(tax_registration_address==null){
		tax_registration_address="";
	}
	if(tax_registration_telnum==null){
		tax_registration_telnum="";
	}
	if(tax_registration_bank==null){
		tax_registration_bank="";
	}
	if(tax_registration_bank_account==null){
		tax_registration_bank_account="";
	}
    %>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='customer_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" name="customer_code" inputName="客户编号" value="<%=vo.getCustomer_code() %>" maxLength="9.5" validate="notNull;"/>
                <input type="hidden" name="customer_id" value="<%=vo.getCustomer_id() %>">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='customer_name'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" id="customer_name" name="customer_name" inputName="客户名称" value="<%=vo.getCustomer_name() %>" maxLength="50" validate="notNull;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='cost_center_name'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="cost_center_name_add" name="cost_center_name" inputName="成本中心名称" value="" maxLength="50" validate="notNull;"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='receipt_title'/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field" id="receipt_title_add" name="receipt_title" inputName="发票抬头" value="<%=vo.getReceipt_title() %>" maxLength="66" validate="notNull;"/>
            </td>
                <!--2016-04-12  by zhouxiaolong 新增合同增加自动带入字段 begin-->
        <tr>
            <td class="td_1" >纳税人身份类型</td>
            <td class="td_2 ">
                <select id="taxpayer_identity_type" name="taxpayer_identity_type" onchange="taxpayeridentitytypeChange1()">
                    <option value="">请选择</option>
                    <option value="1">增值税一般纳税人</option>
                    <option value="2">非增值税一般纳税人</option>
                </select>
                <input type="hidden" class="text_field" id="taxpayer_identity_type_b" value="<%=vo.getTaxpayer_identity_type() %>"  inputName="纳税人身份类型"  maxLength="50" validate="notNull;"/>
            </td>
            <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
            <td class="td_1" >纳税人识别号</td>
            <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
            <td class="td_2 ">
             <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
                <input type="text" class="text_field" id="taxpayer_identification_number_add" value="<%=taxpayer_identification_number %>" name="taxpayer_identification_number" inputName="纳税人识别号"  maxLength="20" validate="notNull;"/>
             <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
           </td>
        </tr>
        <tr>
            <td class="td_1" >税务登记地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tax_registration_address_add" value="<%=tax_registration_address %> " name="tax_registration_address" inputName="税务登记地址"  maxLength="100" validate="notNull;"/>
            </td>
            <td class="td_1" >税务登记电话号码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tax_registration_telnum_add" value="<%=tax_registration_telnum %>" name="tax_registration_telnum" inputName="税务登记电话号码" maxLength="200"  validate="isNum;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >税务登记开户银行</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tax_registration_bank_add" value="<%=tax_registration_bank %>" name="tax_registration_bank" inputName="税务登记开户银行"  maxLength="50" validate="notNull;" />
            </td>
            <td class="td_1" >税务登记银行账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tax_registration_bank_account_add" value="<%=tax_registration_bank_account %>" name="tax_registration_bank_account" inputName="税务登记银行账号"  maxLength="100" validate="isNum;"/>
            </td>
        </tr>
                
                <!--2016-04-12  by zhouxiaolong 新增合同增加自动带入字段 end-->

        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_account_limit'/></td>
            <td class="td_2 ">
                     <%//=gap.rm.tools.helper.RmJspHelper.getSelectField("is_account_limit", -1,"TrueOrFalse","${vo.is_account_limit}","id=is_account_limit  onchange='account(this);' ",true) %>
                     <d:select dictTypeId="TrueOrFalse" property="is_account_limit"  id="is_account_limit"  value="${vo.is_account_limit}"  style="width:207px;"  nullLabel="--请选择--" onchange="account(this);"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_finance_send'/></td>
            <td class="td_2 ">
                <%//=gap.rm.tools.helper.RmJspHelper.getSelectField("is_finance_send", -1,"TrueOrFalse","1","id=is_finance_send ",true) %>
                <d:select name="is_finance_send" id="is_finance_send" property="vo/is_finance_send" dictTypeId="TrueOrFalse"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='agree_receive_money_date'/></td>
            <td class="td_2">
                <input type="text" class="text_field" name="agree_receive_money_date" id="agree_receive_money_date" value="<%=vo.getAgree_receive_money_date()==null?"":vo.getAgree_receive_money_date()%>" inputName="约定到款日" validate="notNull;isNum"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='receive_money_month'/></td>
            <td class="td_2 ">
               <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month1"  id="receive_money_month1"    value="${vo.receive_money_month}"     filterOp="in" filterStr="1,13" style="width:207px"  nullLabel="--请选择--"/>
               <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month2"  id="receive_money_month2"  value="${vo.receive_money_month}"     style="width:207px;display:none;"  />
                <input type="hidden" name="receive_money_month" id="receive_money_month" value=""/>
            </td>
        </tr>
        
        
<!--   yangxu      -->
		<tr>
            <td class="td_1" ><fmt:message key='contract_receive_money_date'/></td>
            <td class="td_2">
                <input type="text" class="text_field" name="contract_receive_money_date" id="contract_receive_money_date" value="<%=vo.getContract_receive_money_date()==null?"":vo.getContract_receive_money_date()%>" inputName="约定到款日"/>
            </td>
            <td class="td_1" ><fmt:message key='contract_receive_money_month'/></td>
            <td class="td_2 ">
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month1"  id="contract_receive_money_month1"    value="${vo.contract_receive_money_month}"     filterOp="in" filterStr="1,13" style="width:207px"  nullLabel="--请选择--"/>
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month2"  id="contract_receive_money_month2"  value="${vo.contract_receive_money_month}"     style="width:207px;display:none;"  />
                <input type="hidden" name="contract_receive_money_month" id="contract_receive_money_month" value="${vo.contract_receive_money_month}"/>
            </td>
        </tr>
<!--   yangxu      -->
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_beforehand_voucher'/></td>
            <td class="td_2 ">
            <d:select dictTypeId="TrueOrFalse" property="is_beforehand_voucher"  id="is_beforehand_voucher"  value="${vo.is_beforehand_voucher}"  style="width:207px;"  nullLabel="--请选择--"/>
                
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_remittance_error'/></td>
            <td class="td_2 ">
               <d:select dictTypeId="TrueOrFalse" property="is_remittance_error"  id="is_remittance_error"  value="${vo.is_remittance_error}"  style="width:207px;"  nullLabel="--请选择--"/>
                
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_fixed_pay_later'/></td>
            <td class="td_2 ">
                 <d:select dictTypeId="TrueOrFalse" property="is_fixed_pay_later"  id="is_fixed_pay_later"  value="${vo.is_fixed_pay_later}"  style="width:207px;"  nullLabel="--请选择--"/>
                
            </td>
            <td class="td_1" ><fmt:message key='contact_person'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_person" inputName="联系人" value="" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_address'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_address" inputName="联系人地址" value="" maxLength="75" />
            </td>
            <td class="td_1" ><fmt:message key='zip_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="zip_code" inputName="邮编" value="" maxLength="6" validate="isNum "/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_tel1'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_tel1" inputName="联系电话1" value="" maxLength="18" validate="notChinese  "/>
            </td>
            <td class="td_1" ><fmt:message key='contact_tel2'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_tel2" inputName="联系电话2" value="" maxLength="18" validate="notChinese  "/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='fax'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  name="fax" inputName="传真" value="" maxLength="13" validate="notChinese  "/>
            </td>
            <td class="td_1" ><fmt:message key='email'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="email" name="email" inputName="电子邮件" value="" maxLength="64" validate="isEmail"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='voucher_rule'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="voucher_rule" inputName="开票规则" value="" maxLength="64" />
            </td>
            <td class="td_1" >发票服务年月</td>
            <td class="td_2 ">
                <d:select name="is_display_year_month" id="is_display_year_month " property="vo/is_display_year_month" dictTypeId="IS_DISPLAY_YM"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='remark'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="remarks" inputName="备注" value="" maxLength="1000" />              
            </td>
            <td class="td_1"><span class="style_required_red">* </span>账单日</td>
            <td class="td_2" >
                <input type="text" class="text_field" name="bill_day" id="bill_day" maxLength="2" inputName="账单日"  validate="notNull;isNum;isValidDay"/>
            </td>
         </tr>
        <!--2016-06-30 by zhouxiaolong  成本中心新增字段   begin-->
        <% if("1".equals(request.getAttribute("flag"))){ %>
         <tr>
          <td class="td_1">代收付开票税率</td>
            <td class="td_2" >
                <select id="payment_invoice_rate"  name="payment_invoice_rate">
                    <!-- 2016-07-25   by zhouxiaolong  增加0%的税率选项   Begin -->
                    <option value="0">--请选择--</option>
                    <!-- 2016-07-25   by zhouxiaolong  增加0%的税率选项   End -->
                    <option value="0.05">5%</option>
                    <option value="0.06">6%</option>
                </select>         
            </td>
             <td class="td_1"></td>
             <td class="td_2" >
             </td>
        </tr>
        <%} %>
        <!--2016-06-30 by zhouxiaolong  成本中心新增字段   end-->
</table>
    <%
}else{
    %>
        <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='customer_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" name="customer_code" inputName="客户编号" value="<%=resultVo.getCustomer_code() %>" maxLength="9.5" validate="notNull;"/>
                <input type="hidden" name="customer_id" value="<%=resultVo.getCustomer_id() %>">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='customer_name'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" id="customer_name" name="customer_name" inputName="客户名称" value="<%=resultVo.getCustomer_name()%>" maxLength="50" validate="notNull;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='cost_center_name'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="cost_center_name" name="cost_center_name"  inputName="成本中心名称" value="<%=resultVo.getCost_center_name() %>" maxLength="50" validate="notNull;"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='receipt_title'/></td>
            <!--2016-04-13 by zhouxiaolong  修改成本中心增加税务字段的显示  begin-->
            <td class="td_2 ">
                <input type="text" class="text_field" id="receipt_title" name="receipt_title" inputName="发票抬头" value="<%=resultVo.getReceipt_title() %>" maxLength="66" validate="notNull;"/>
                <input type="hidden" id="receipt_title_bak" name="receipt_title_bak" value="<%=resultVo.getReceipt_title() %>" />
            </td>
        </tr>
            <tr>
                <td class="td_1" >纳税人身份类型</td>
                <td class="td_2 ">
                    <select id="taxpayer_identity_type_bak" name="taxpayer_identity_type" onchange="taxpayeridentitytypeChange()">
                        <option value="">请选择</option>
                        <option value="1">增值税一般纳税人</option>
                        <option value="2">非增值税一般纳税人</option>
                    </select>
                    <input type="hidden" class="text_field" id="taxpayer_identity_type_bk" inputName="纳税人身份类型" value="<%=resultVo.getTaxpayer_identity_type() %>" maxLength="50" validate="notNull;"/>
                </td>
                <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
                <td class="td_1" >纳税人识别号</td>
                <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
                <td class="td_2 ">
                <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
                    <input type="text" class="text_field" id="taxpayer_identification_number" name="taxpayer_identification_number" inputName="纳税人识别号" value="<%=resultVo.getTaxpayer_identification_number() %>" maxLength="20" validate="notNull;"/>
                <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
                 </td>
            </tr>
            <tr>
                <td class="td_1" >税务登记地址</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="tax_registration_address" name="tax_registration_address" inputName="税务登记地址" value="<%=resultVo.getTax_registration_address() %>" maxLength="100" validate="notNull;"/>
                </td>
                <td class="td_1" >税务登记电话号码</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="tax_registration_telnum" name="tax_registration_telnum" inputName="税务登记电话号码" value="<%=resultVo.getTax_registration_telnum() %>" maxLength="100"  validate="isNum;"/>
                </td>
            </tr>
            <tr>
                <td class="td_1" >税务登记开户银行</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="tax_registration_bank" name="tax_registration_bank" inputName="税务登记开户银行" value="<%=resultVo.getTax_registration_bank() %>" maxLength="50" validate="notNull;" />
                </td>
                <td class="td_1" >税务登记银行账号</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="tax_registration_bank_account" name="tax_registration_bank_account" inputName="税务登记银行账号" value="<%=resultVo.getTax_registration_bank_account() %>" maxLength="100" validate="isNum;"/>
                </td>
            </tr>
            <!--2016-04-13 by zhouxiaolong  修改成本中心增加税务字段的显示  end-->
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_account_limit'/></td>
            <td class="td_2 ">
               <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_account_limit", -1,"TrueOrFalse",resultVo.getIs_account_limit(),"style='width:207px' id='is_account_limit' onchange='account(this);' readonly='true' ",false) %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_finance_send'/></td>
            <td class="td_2 ">
                <%//=gap.rm.tools.helper.RmJspHelper.getSelectField("is_finance_send", -1,"TrueOrFalse",""," style='width:207px' id=is_finance_send ",true) %>
                <d:select name="is_finance_send" id="is_finance_send" property="bean/is_finance_send" dictTypeId="TrueOrFalse"/>
                <input type="hidden" id="is_finance_send_bak" name="is_finance_send_bak" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='agree_receive_money_date'/></td>
            <td class="td_2">
                <input type="text" class="text_field" name="agree_receive_money_date" id="agree_receive_money_date" value="${bean.agree_receive_money_date }" inputName="约定到款日" validate="notNull;isNum"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='receive_money_month'/></td>
            <td class="td_2 ">
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month1"  filterOp="in" filterStr="1,13" value="${bean.receive_money_month }" style="width:207px"   nullLabel="--请选择--"/>
                <d:select   dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month2"   value="${bean.receive_money_month }" style="width:207px;display:none;"  />
                <input type="hidden" name="receive_money_month" id="receive_money_month" value=""/>
            </td>
        </tr>
        
        
                
        <!--   yangxu      -->
		<tr>
            <td class="td_1" >合同约定到款日</td>
            <td class="td_2">
                <input type="text" class="text_field" name="contract_receive_money_date" id="contract_receive_money_date" value="${bean.contract_receive_money_date }" inputName="约定到款日" />
            </td>
            <td class="td_1" >合同到款日所属月</td>
            <td class="td_2 ">
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month1"  id="contract_receive_money_month1"  filterOp="in" filterStr="1,13" value="${bean.contract_receive_money_month }" style="width:207px"  nullLabel="--请选择--" />
                <d:select   dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month2"  id="contract_receive_money_month2"   value="${bean.contract_receive_money_month }" style="width:207px;display:none;"  />
                <input type="hidden" name="contract_receive_money_month" id="contract_receive_money_month" value=""/>
            </td>
        </tr>
<!--   yangxu      -->



         <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_beforehand_voucher'/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_beforehand_voucher", -1,"TrueOrFalse",resultVo.getIs_beforehand_voucher(),"style='width:207px' id=is_beforehand_voucher ",false) %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_remittance_error'/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_remittance_error", -1,"TrueOrFalse",resultVo.getIs_remittance_error(),"style='width:207px' id=is_remittance_error ",false) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_fixed_pay_later'/></td>
            <td class="td_2 ">
            
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_fixed_pay_later", -1,"TrueOrFalse",resultVo.getIs_fixed_pay_later(),"style='width:207px' id=is_fixed_pay_later ",false) %>
            </td>
            <td class="td_1" ><fmt:message key='contact_person'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_person" inputName="联系人" value="<%=resultVo.getContact_person() %>" maxLength="50" />
                <input type="hidden" name="contact_person_bak" id="contact_person_bak" value="<%=resultVo.getContact_person() %>" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_address'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_address" inputName="联系人地址" value="<%=resultVo.getContact_address() %>" maxLength="75" />
                <input type="hidden" name="contact_address_bak" id="contact_address_bak" value="<%=resultVo.getContact_address() %>" />
            </td>
            <td class="td_1" ><fmt:message key='zip_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="zip_code" inputName="邮编" value="<%=resultVo.getZip_code() %>" maxLength="6" validate="isNum"/>
                <input type="hidden" name="zip_code_bak" id="zip_code_bak" value="<%=resultVo.getZip_code() %>" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_tel1'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_tel1" inputName="联系电话1" value="<%=resultVo.getContact_tel1() %>" maxLength="18" validate="notChinese"/>
                <input type="hidden" name="contact_tel1_bak" id="contact_tel1_bak" value="<%=resultVo.getContact_tel1() %>" />
            </td>
            <td class="td_1" ><fmt:message key='contact_tel2'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_tel2" inputName="联系电话2" value="<%=resultVo.getContact_tel2() %>" maxLength="18" validate="notChinese"/>
                <input type="hidden" name="contact_tel2_bak" id="contact_tel2_bak" value="<%=resultVo.getContact_tel2() %>" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='fax'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="fax" inputName="传真" value="<%=resultVo.getFax() %>" maxLength="13" validate="notChinese  "/>
            </td>
            <td class="td_1" ><fmt:message key='email'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="email" inputName="电子邮件" value="<%=resultVo.getEmail() %>" maxLength="64" validate="isEmail"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='voucher_rule'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="voucher_rule" inputName="开票规则" value="<%=resultVo.getVoucher_rule() %>" maxLength="64" />
            </td>
            <td class="td_1" >发票服务年月</td>
            <td class="td_2 ">
                <d:select name="is_display_year_month" id="is_display_year_month " property="bean/is_display_year_month" dictTypeId="IS_DISPLAY_YM" onchange="checkInvoiceStatus2(this)" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='remark'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" name="remarks" inputName="备注" value="<%=resultVo.getRemarks() %>" maxLength="1000" />           
                <input type="hidden" id="id_bak" name="id" value="<%=resultVo.getId() %>">   
            </td>
            <td class="td_1"><span class="style_required_red">* </span>账单日</td>
            <td class="td_2" >
                <input type="text" class="text_field" name="bill_day" id="bill_day_bak" maxLength="2" value="<%=resultVo.getBill_day() %>" validate="notNull;isNum;isValidDay"/>
                <input type="hidden" class="text_field" name="fin_invoice_template_id" inputName="发票模板" value="<%=resultVo.getFin_invoice_template_id() %>"  />
            </td>
         </tr>
         <tr>
            <td class="td_1" ><fmt:message key='cost_center_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" name="cost_center_code" inputName="成本中心编号" value="<%=resultVo.getCost_center_code() %>" />
            </td>
        <!--2016-06-30 by zhouxiaolong  成本中心新增字段   begin-->
        <% if("1".equals(request.getAttribute("flag"))){ %>
          <td class="td_1">代收付开票税率</td>
            <td class="td_2" >
                <select id="payment_invoice_rate_bak"  name="payment_invoice_rate">
                    <!-- 2016-07-25   by zhouxiaolong  增加0%的税率选项   Begin -->
                    <option value="0">--请选择--</option>
                    <!-- 2016-07-25   by zhouxiaolong  增加0%的税率选项   End -->
                    <option value="0.05">5%</option>
                    <option value="0.06">6%</option>
                </select>
                <script type="text/javascript">
                 //2016-06-30 by zhouxiaolong  成本中心新增字段   Begin
                  var payment_invoice_rate=<%=resultVo.getPayment_invoice_rate()%>
                  jQuery("#payment_invoice_rate_bak").val(payment_invoice_rate);
                 //2016-06-30 by zhouxiaolong  成本中心新增字段   End
                </script>
            </td>
        <%}else{ %>
         <td class="td_1" ></td>
            <td class="td_2 ">
            </td>
        <%} %>
        <!--2016-06-30 by zhouxiaolong  成本中心新增字段   end-->
        </tr>
</table>
    <%
}
%>
</div> 
 <div class="datecellCss" id="centerNew7">
 <r:datacell id="datacell1" queryAction="/FAERP/CostcenterAction.do?cmd=simpleQueryVatPay" 
    submitAction="/FAERP/CostcenterAction.do?cmd=insert" width="730px" height="230px" xpath="CostcenterVo" 
    paramFormId="datacell_formid" pageSize="10">
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <r:field fieldName="social_unit_name"   label="福利办理方" allowModify="false"  width="80px">
    </r:field>
    <r:field fieldName="service_type_name"  label="业务类型名称" allowModify="false" width="90px">
    </r:field>
    <r:field fieldName="product_type_name" label="代收付产品小类名称"  width="140px">
    </r:field>
    <r:field fieldName="is_payticket_for_delegate" label="开票类型" allowModify="true"  width="80px">
        <d:select dictTypeId="IS_PAY_FOR_DELEGATE" id="is_pay_for_delegate" onchange="isPayticketforDelegate2()"></d:select>
    </r:field>
    <r:field fieldName="add_tax_rate_for_delegate" label="附加税率" allowModify="true"  width="80px">
	          <select>
	           <option value="0">0</option>
	           <option value="0.0078613183">0.0078613183</option>
	           <option value="0.0065425264">0.0065425264</option>
	        </select>
	    </r:field>
	      <r:field fieldName="start_date" width="110px" label="起始日期"  allowModify="true">
	       <w:date format="yyyy-MM-dd" allowNull="true;"/>
	       </r:field>  
	       <r:field fieldName="end_date" width="110px" label="终止日期"  allowModify="true">
	       <w:date format="yyyy-MM-dd" allowNull="true"/>
       </r:field>
 </r:datacell>
</div> 
</div>
<div class="mx_button" style="text-align: center;padding-top:10px;">
	<input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
	<input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
</div>    
</form>    
</fmt:bundle>
</body>
</html>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
    _dofilter(${bean.is_account_limit});
    
    //判断此成本中心的账单的开票状态是否有属于部分开票的，有则不允许更换账期属性；
function checkInvoiceStatus2(obj){
        var bill_invoice_status_bd="0";
        var is_display_year_month=obj.value;
        var customer_code="${bean.customer_code}";
        var cost_center_id = "${bean.id}";
        if(!is_display_year_month){
            return ;
        }
        //alert("customer_code="+customer_code+"______"+fin_invoice_template_id);
        
             jQuery.ajax({
                    url : "/FAERP/Fin_invoice_template_itemAction.do?cmd=checkInvoiceStatus&cust_code="+customer_code+"&cost_center_id="+cost_center_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){
                        if(text!=null){       
                               if(text == '1'){
                                       bill_invoice_status_bd="1";
                                        return false;
                                   }
                            }
                        }
            });
            
        var old_is_display_year_month="${bean.is_display_year_month}";
        if(bill_invoice_status_bd!="0"){
            document.getElementById("is_display_year_month").value = old_is_display_year_month;
            if(old_is_display_year_month!=is_display_year_month){
                alert("此成本中心下账单的开票状态有部分开票或者待开票，不可更改账期！");
            }
        }

}
  var isModify = <%=isModify%>
  if(isModify)
  {
    document.getElementById('is_finance_send_bak').value = document.getElementById('is_finance_send').value;
    _dofilter(${bean.is_account_limit});
  }
else
{//刚进入页面时加载后台参数
  _dofilter(${vo.is_account_limit});
}

  //2016-04-18  by zhouxiaolong 当用户选择‘代收付进入增票时’时，填写附加税比率  begin
  //进入修改页面时的加载事件
  jQuery("#centerNew7").hide();
  
  //修改页面控制下拉框


  jQuery("#taxpayer_identity_type").val(jQuery("#taxpayer_identity_type_b").val());

  jQuery("#taxpayer_identity_type_bak").val(jQuery("#taxpayer_identity_type_bk").val());


    function batch_blue(obj){
        var enCurEntity1 = $id("datacell1").activeEntity;
        var entity = enCurEntity1.getProperty(obj);
        var ischecked=false;
       var ids = selectIds();
        if(ids == null) {  //如果ids为空
   //         alert('<fmt:message key="select_one_record"/>');
        //    return;
        }
        for(var i=0;i<ids.length;i++)
        {
            var enCurEntity = $id("datacell1").dataset.get(i);
              if(ids[i].checked){
                if(enCurEntity.getProperty("id")==enCurEntity1.getProperty("id"))
                {
                    ischecked=true;
                }
              }
          
        }
        if(ischecked)
        {
            for(var i=0;i<ids.length;i++){           
            var enCurEntity = $id("datacell1").dataset.get(i);
            if(ids[i].checked){
                enCurEntity.setProperty(obj,entity);
            }          
        }
        }
        return true;            
    }
  
  //2016-04-18  by zhouxiaolong 当用户选择‘代收付进入增票时’时，填写附加税比率  end

</script>
