<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>

<%
String user_id= RmJspHelper
.getParty_idFromRequest(request);
String user_name="";
LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
if(null!=loginVo){
    user_name=loginVo.getName();
}
%>


    <%
        String security_group_id= request.getParameter("security_group_id");
        String social_unit_id= request.getParameter("social_unit_id");
        String cust_name= request.getParameter("customer_name")==null?"":request.getParameter("customer_name");
        String cust_code= request.getParameter("customer_code")==null?"":request.getParameter("customer_code");
        String report_month= request.getParameter("report_month");
        if(report_month==null || report_month.equals("null") || report_month.equals("undefined")){
            report_month = "";
        }
        String cust_id= request.getParameter("cust_id")==null?"":request.getParameter("cust_id");
       
        String security_type= request.getParameter("security_type");
        String  payment_type_bd  ="";
        if(security_type.equals("1")){//1<fmt:message key='listOtherSecurityPay0000'/>2<fmt:message key='listOtherSecurityPay0001'/>
            payment_type_bd="1";
        }else{
            payment_type_bd="2";
        }
    %>

<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listOtherSecurityPay_resource' prefix='auto.'>
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
    <script language="javascript">
    
   
    function citySecurityGroupchange(seletvalue){

      var group_type = $id("group_type").value;
      SecurityGroupAjax.getSecurityGroupbyCitys(seletvalue,group_type,{callback:function(data){
                    setSelectForBean("security_group_id",data,"id","group_name","");
                }
            });
    }
    
  
function    testDate(){
      var fund_month1 = document.form.fund_month1.value;
              if(fund_month1 ==null || fund_month1 == ""){
           alert("<fmt:message key='listOtherSecurityPay0002'/>");
           document.getElementById("fund_month1").focus();
           return;
        }else{
           if(fund_month1.length != 6){
               alert("<fmt:message key='listOtherSecurityPay0005'/>");
               document.getElementById("fund_month1").focus();
               return;
           }
           var year = fund_month1.substring(0,4);
           var month = fund_month1.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listOtherSecurityPay0009'/>");
               document.getElementById("fund_month1").focus();
               return;
           }
        }
         doChangeText11();
    }
    
    
    function test1(){
    var  text8  =document.getElementById("text8").value;
     var regu = /^(\d+)(\.?)(\d{0,10})$/; 
             if(!regu.test(text8)){
                alert("<fmt:message key='listOtherSecurityPay0013'/>");
                 document.getElementById("text8").focus();
             return;
             }else{
              var  text6  =document.getElementById("text6").value;
             document.getElementById("text5").value=text8+text6;
              document.getElementById("text7").value =text8+text6;  
             }
    
    
    }
    
  function test2(){
    var  text6  =document.getElementById("text6").value;
    var regu = /^(\d+)(\.?)(\d{0,10})$/; 
             if(!regu.test(text6)){
                alert("<fmt:message key='listOtherSecurityPay0014'/>");
                 document.getElementById("text6").focus();
             return;
             }else{
             
                  var  text8  =document.getElementById("text8").value;
                    document.getElementById("text5").value=text8+text6;
                    document.getElementById("text7").value =text8+text6;  
             }
    }
    
function test3(){
    var  text7  =document.getElementById("text7").value;
    var regu = /^(\d+)(\.?)(\d{0,10})$/; 
             if(!regu.test(text7)){
                alert("<fmt:message key='listOtherSecurityPay0015'/>");
                 document.getElementById("text7").focus();
             return;
             }
    }
    
  function test9(){
    var  text7  =document.getElementById("text9").value;
    var regu = /^(\d+)$/; 
             if(!regu.test(text7)){
                alert("<fmt:message key='listOtherSecurityPay0016'/>");
                 document.getElementById("text9").focus();
             return;
             }
    }  
    

        
   function getbyid(){
          var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         if(data == undefined) return;
          document.form.cust_name1.value=data[2];
          document.form.cust_id.value=data[0];
          document.form.cust_code.value=data[1];
   //         alert(data[0]);
          
                       var fund_month = document.form.fund_month1.value;
                       var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listOtherSecurityPay0017'/>
                       var security_group_id= document.form.security_group_id.value;
                       var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkDAhuCount&ids="+social_unit_id+"&fund_month="+fund_month+"&cust_id="+data[0]+"&security_group_id="+security_group_id+"&date="+new Date();
                         $.getJSON(url,{"ids":data[0]},  function(json){
                                 if(null!=json){
                                             //       alert(json.fesc);
                                                   document.form.text8.value=json.count1;
                                                    document.form.text6.value=json.count2;
                                                     document.form.fesc.value=json.fesc;
                                                    var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                   document.getElementById("text5").value=count;
                                                   document.getElementById("text7").value =count;
                                 }
                            });      
    }

</script>
    </head>
    <body onload="init();">

    <form name="form" id="datacell_formid"  method="post" action="<%=request.getContextPath()%>/EmpsecurityAction.do">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
     <input type="hidden" name="fesc" id="fesc"  >
    <input type="hidden" id="group_type" value="${param.security_type }">
    <div id="right">
    <div class="ringht_s">


    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><fmt:message key='listOtherSecurityPay0018'/></div>
            <!--<fmt:message key='listOtherSecurityPay0019'/>1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1"><span>*</span><fmt:message key='listOtherSecurityPay0020'/></td>
                    <td class="td_2">
                       <select id="security_group_id" name="security_group_id"  onchange="doChange1();">
                            
                       </select>
                    </td>
                    
                     <td class="td_1"><span>*</span><fmt:message key='listOtherSecurityPay0017'/></td>
                    <td class="td_2"><faerp:SoialunitSelectTag tagname="social_unit_id" beanname="social_unit_id" style="width:205px"    onchange="doDAHU();  "/></td>
                    
                    <input type="hidden"  id="dahu"   name="dahu"/>
                    
                </tr>
      
                <tr  id="div1" style="display:none;">
                   <div> 
                    <td class="td_1"><fmt:message key='listOtherSecurityPay0021'/></td>
                    <td class="td_2"  >
                     
                       
                       
                           <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_name1" name="cust_name1"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="listOtherSecurityPay0022" height="440" width="600"  style="width:170px"/>
                       
                       
                       
                    </td>
                     <td class="td_1"><fmt:message key='listOtherSecurityPay0023'/></td>
                   
                      <td class="td_2">  <input  type="text" class="text_field"    id="cust_code"  name="cust_code" readonly="readonly"  />
                       <input  type="hidden" class="text_field"    id="cust_id"  name="cust_id" readonly="readonly"  />
                      
                      </td>
                      <div> 
                </tr>
                 <tr  id="div2" style="display:inline;">
                    <td class="td_1"><fmt:message key='listOtherSecurityPay0021'/></td>
                    <td class="td_2"  >
                       <input type="text" class="text_field" id="cust_name2" name="cust_name2" validators="isSearch" inputName="<fmt:message key='listOtherSecurityPay0021'/>" maxLength="50"  readonly="readonly" value=""/>
                    </td>
                       <td class="td_1"><fmt:message key='listOtherSecurityPay0023'/></td>
                     <td class="td_2">  <input  type="text" class="text_field"    id="cust_id1"  name="cust_id1" readonly="readonly"  value="" /></td>
                </tr>
              
            </table>
            </div>

 <div class="xz_title"><fmt:message key='listOtherSecurityPay0027'/></div>


 <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                   <td class="td_1"><span>*</span> <fmt:message key='listOtherSecurityPay0028'/></td>
                         <td class="td_2"><input  id="fund_month1"  name="fund_month1" type="text" class="sText" id="fund_month1"    onblur="testDate();"    onchange="doChange();"  /></td>
                         <td class="td_2">&nbsp;</td>
                         <td class="td_2">&nbsp;</td>
                </tr>
      
                <tr>
                    <td class="td_1"><fmt:message key='listOtherSecurityPay0029'/></td>
                         <td class="td_2">
                                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("payment_type_bd", -1,"PAYMENT_TYPE_BD",payment_type_bd," id=payment_type_bd",false) %> 
                         
                         </td>
                         <td class="td_1"><span>*</span><fmt:message key='listOtherSecurityPay0030'/></td>
                         <td class="td_2">
                           <%=gap.rm.tools.helper.RmJspHelper.getSelectField("receiver_type_bd", -1,"RECEIVER_TYPE_BD","4"," id=service_status_bd",false) %> 
                         </td>
                </tr>
                
                
                  <tr>
                    <td class="td_1"><span>*</span><fmt:message key='listOtherSecurityPay0031'/></td>
                         <td class="td_2"><input name="text3" type="text" class="sText" id="text3" value=""/></td>
                         <td class="td_1"><span>*</span><fmt:message key='listOtherSecurityPay0032'/></td>
                         <td class="td_2"><input name="text9" type="text" class="sText" id="text9" value="1"   onblur="test9();"/></td>
                </tr>
                
                
                
                 <tr>
                   <td class="td_1"><fmt:message key='listOtherSecurityPay0033'/></td>
                         <td class="td_2"><input name="text5" type="text" style="background-color:#f0f0f0;" class="sText" id="text5" value="0" readonly="readonly"  /></td>
                         <td class="td_1"><fmt:message key='listOtherSecurityPay0034'/></td>
                         <td class="td_2"><input name="text8" type="text" style="background-color:#f0f0f0;" class="sText" id="text8" value="0"    readonly="readonly" /></td>
                </tr>
              
                  <tr>
                         <td class="td_1"><fmt:message key='listOtherSecurityPay0035'/></td>
                         <td class="td_2"><input name="text6" type="text" style="background-color:#f0f0f0;" class="sText" id="text6" value="0"    readonly="readonly" /></td>
                         <td class="td_1"><span>*</span><fmt:message key='listOtherSecurityPay0036'/></td>
                         <td class="td_2"><input name="text7" type="text" class="sText" id="text7" value="0"    onblur="test3();"   /></td>
                </tr>
                
               <tr>
                         <td class="td_1"><span>*</span><fmt:message key='listOtherSecurityPay0037'/></td>
                         <td colspan="3" class="td_2">
                           <label for="textarea"></label>
                           <textarea name="text11"  class="xText_d"  rows="3" id="text11"><fmt:message key='listOtherSecurityPay0038'/></textarea></td>
                </tr>
                
                    <tr>
                         <td class="td_1"><fmt:message key='listOtherSecurityPay0039'/></td>
                         <td colspan="3" class="td_2"><textarea name="text12" rows="3" class="xText_d" id="text12"></textarea></td>
                </tr>
                 <tr>
                         <td class="td_1"><fmt:message key='listOtherSecurityPay0040'/></td>
                         <td colspan="3" class="td_2"><textarea name="text13" rows="3" class="xText_d" id="text13"></textarea></td>
                </tr>
                
                
                 <tr>
                          <td class="td_1"><fmt:message key='listOtherSecurityPay0041'/></td>
                         <td colspan="3" class="td_2"><input name="text10" type="text" style="background-color:#f0f0f0;" class="sText" id="text10" value="<%= user_name %>"/></td>
                </tr>
                
            </table>
            </div>
            
               <div class="foot_button">
                       <input type="button" class="foot_icon_2" value="<fmt:message key='listOtherSecurityPay0042'/>" <au:authorityBtn code="sbzf_sczfsh" type="1"/>  onclick="doPay();"/>
                       <input type="button" class="foot_icon_2" value="<fmt:message key='listOtherSecurityPay0043'/>" <au:authorityBtn code="sbzf_print" type="1"/> onclick="doPrint();"/>
                    <!--<fmt:message key='listOtherSecurityPay0019'/> end--></div>
                </div>
            <!--<fmt:message key='listOtherSecurityPay0019'/>1 end--></div>
            </td>
        </tr>
    </table>


    </form>
<script language="javascript">
</script>
</body>
</html>

<script language="javascript">



function doPay(){
   var  security_group_id=document.form.security_group_id.value;  //<fmt:message key='listOtherSecurityPay0000'/>组
   var social_unit_id=document.form.social_unit_id.value;  //<fmt:message key='listOtherSecurityPay0017'/>
   var fund_month = document.form.fund_month1.value;   //  <fmt:message key='listOtherSecurityPay0046'/>
   var receiver_type_bd=document.form.receiver_type_bd.value;//<fmt:message key='listOtherSecurityPay0031'/>类型
    var text3=document.form.text3.value;//<fmt:message key='listOtherSecurityPay0031'/>
    var text5=document.form.text5.value;//<fmt:message key='listOtherSecurityPay0033'/>
    var text8=document.form.text8.value;//<fmt:message key='listOtherSecurityPay0034'/>
    var text6=document.form.text6.value;//<fmt:message key='listOtherSecurityPay0035'/>
    var text7=document.form.text7.value;//<fmt:message key='listOtherSecurityPay0036'/>
    var text11=document.form.text11.value;//<fmt:message key='listOtherSecurityPay0037'/>
    var text12=document.form.text12.value;//<fmt:message key='listOtherSecurityPay0039'/>
    var text13=document.form.text13.value;//<fmt:message key='listOtherSecurityPay0040'/>
    var text9=document.form.text9.value;//<fmt:message key='listOtherSecurityPay0032'/>
   
    var payment_type_bd=document.form.payment_type_bd.value;//<fmt:message key='listOtherSecurityPay0029'/>
            
                
           if(fund_month.length != 6){
               alert("<fmt:message key='listOtherSecurityPay0005'/>");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listOtherSecurityPay0009'/>");
               return;
           }
        var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=save&payment_month="+fund_month+"&date="+new Date()+"&flag=<%=security_type%>";         
        
        if(social_unit_id==null||social_unit_id==""){
                  alert("<fmt:message key='listOtherSecurityPay0055'/>");
               return;
           }else{
                   url+="&social_unit_id="+social_unit_id;
           }
           
           
           
        
          var dahu=document.form.dahu.value; 
           if(dahu=="1"){
              var  cust_id  =    document.form.cust_id.value;
                   if(null==cust_id||cust_id.trim().length==0){
                       alert("<fmt:message key='listOtherSecurityPay0056'/>");
                    return;
                  }
               url+="&cust_id="+cust_id;
                 var fesc  =document.form.fesc.value;
                   if(fesc=="0"){
                   alert("<fmt:message key='listOtherSecurityPay0057'/>");
                 return;
                 }
           }
           
           
                 if(text5==0){
                    alert("<fmt:message key='listOtherSecurityPay0100'/>");
                    return;
                }
           
           
           
     
           

          
           if(text9==null||text9==""){
                  alert("<fmt:message key='listOtherSecurityPay0061'/>");
               return;
           }else{
                url+="&text9="+text9;
           }
           
           
            if(text3==null||text3.trim().length==0){
                  alert("<fmt:message key='listOtherSecurityPay0062'/>");
               return;
           }
           
           
          if(text7==null||text7.trim().length==0){
                  alert("<fmt:message key='listOtherSecurityPay0063'/>");
               return;
           }else{
                url+="&apply_amount="+encodeURIComponent(text7);
           }
           
           
           if(text11==null||text11.trim().length==0){
               alert("<fmt:message key='listOtherSecurityPay0064'/>");
               return;
           }else{
                url+="&text11="+encodeURIComponent(text11);
           }    
           
            if(receiver_type_bd==null||receiver_type_bd==""){
                  alert("<fmt:message key='listOtherSecurityPay0065'/>");
               return;
           }
           
           
 
          url+="&dahu="+dahu; 
         url+="&payment_type_bd="+payment_type_bd;        
        url+="&receiver_type_bd="+receiver_type_bd;      
        url+="&text3="+encodeURIComponent(text3);      
        url+="&text5="+text5;      
        url+="&text8="+text8;  
        url+="&text6="+text6;  
        url+="&text12="+encodeURIComponent(text12);  
        url+="&text13="+encodeURIComponent(text13);    
        url+="&security_group_id="+security_group_id;    
    
           
         pay(url);             
 
}

function pay(url){
 showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
      maskWindow();
                           var flags=true;
                                jQuery.ajax({
                                url: url,
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
                                         if(text.length>1000){
                                              alert("<fmt:message key='listOtherSecurityPay0066'/>");
                                               hideProgressBar('page_progBarId');
                                              unMaskWindow();
                                            }else{
                                                alert(text);
                                               hideProgressBar('page_progBarId');
                                              unMaskWindow();
                                            }
                                    }
                                }
                                });return flags;
}



function doPrint(){
   var  security_group_id=document.form.security_group_id.value;  //<fmt:message key='listOtherSecurityPay0000'/>组
   var social_unit_id=document.form.social_unit_id.value;  //<fmt:message key='listOtherSecurityPay0017'/>
   var fund_month = document.form.fund_month1.value;   //  <fmt:message key='listOtherSecurityPay0046'/>
   var receiver_type_bd=document.form.receiver_type_bd.value;//<fmt:message key='listOtherSecurityPay0031'/>类型
    var text3=document.form.text3.value;//<fmt:message key='listOtherSecurityPay0031'/>
    var text5=document.form.text5.value;//<fmt:message key='listOtherSecurityPay0033'/>
    var text8=document.form.text8.value;//<fmt:message key='listOtherSecurityPay0034'/>
    var text6=document.form.text6.value;//<fmt:message key='listOtherSecurityPay0035'/>
    var text7=document.form.text7.value;//<fmt:message key='listOtherSecurityPay0036'/>
    var text11=document.form.text11.value;//<fmt:message key='listOtherSecurityPay0037'/>
    var text12=document.form.text12.value;//<fmt:message key='listOtherSecurityPay0039'/>
    var text13=document.form.text13.value;//<fmt:message key='listOtherSecurityPay0040'/>
    var text9=document.form.text9.value;//<fmt:message key='listOtherSecurityPay0032'/>
     var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=isPay&payment_month="+fund_month+"&date="+new Date()+"&flag=<%=security_type%>";         
    var payment_type_bd=document.form.payment_type_bd.value;//<fmt:message key='listOtherSecurityPay0029'/>
                if(text5==0){
                  alert("<fmt:message key='listOtherSecurityPay0101'/>");
                  return;
                }
                
           if(fund_month.length != 6){
               alert("<fmt:message key='listOtherSecurityPay0005'/>");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listOtherSecurityPay0009'/>");
               return;
           }
      
        
     
           
  if(social_unit_id==null||social_unit_id==""){
                  alert("<fmt:message key='listOtherSecurityPay0055'/>");
               return;
           }else{
                   url+="&social_unit_id="+social_unit_id;
           }
           
   if(text7==null||text7.trim().length==0){
                  alert("<fmt:message key='listOtherSecurityPay0063'/>");
               return;
           }else{
                url+="&apply_amount="+encodeURIComponent(text7);
           }
         var dahu=document.form.dahu.value;
           if(dahu=="1"){
              var  cust_id  =    document.form.cust_id.value;
                   url+="&cust_id="+cust_id;
                 var fesc  =document.form.fesc.value;
                   if(fesc=="0"){
                   alert("<fmt:message key='listOtherSecurityPay0102'/>");
                 return;
                 }
           }
         url+="&dahu="+dahu; 
         url+="&payment_type_bd="+payment_type_bd;        
        url+="&receiver_type_bd="+receiver_type_bd;      
        url+="&text3="+encodeURIComponent(text3);      
        url+="&text5="+text5;      
        url+="&text8="+text8;  
        url+="&text6="+text6;  
        url+="&text12="+encodeURIComponent(text12);  
        url+="&text13="+encodeURIComponent(text13);    
        url+="&security_group_id="+security_group_id;    
        
        
            var flags=true;
                                jQuery.ajax({
                                url: url,
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
                                            if(text=="1"){
                                               alert("<fmt:message key='listOtherSecurityPay0082'/>");
                                            }else if(text=="2"){
                                               $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=reportPayg.raq&arg1="+text7+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4=1&arg5=10&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+text11;
                                                $id("datacell_formid").submit();
                                                
                                            }
                                    }
                                }
                                });return flags;
}




function init(){
    var fund_month = document.form.fund_month1.value;
    if(fund_month==null || fund_month==''){
        var day = new Date(); 
        var year=day.getFullYear();
        var month=day.getMonth()+1; 
        if(month<=9){
            month="0"+month;
        }
        var yearmonth=year+""+month;
        document.form.fund_month1.value=yearmonth;
      //   document.form.text11.value="<fmt:message key='listOtherSecurityPay0000'/> "+yearmonth+" <fmt:message key='listOtherSecurityPay0058'/>";
    }
  doChangeText11();
}
function doDAHU(){
    var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listOtherSecurityPay0017'/>
    var fund_month = document.form.fund_month1.value;
    var security_group_id= document.form.security_group_id.value;
     showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
      maskWindow();
    $id("cust_name1").setDisplayValue("");
    document.form.cust_id.value="";
    document.form.cust_code.value="";
    document.form.text3.value="";
    doChangeText11();
 //   var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkDAhuCount&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag="+flag+"&date="+new Date();
   var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkDAhuCount&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=<%=security_type%>"+"&date="+new Date();
     jQuery.getJSON(url,{"ids":social_unit_id},  function(json){
                   //     alert(json.isIndieBd);
                 //     alert(json.count1);
                //   alert(json.count2);
        
             document.form.dahu.value=json.isIndieBd;
             if(json.isIndieBd==1){  //单户
                       document.getElementById( "div1").style.display= "inline";  
                       document.getElementById( "div2").style.display= "none";
                    
                          hideProgressBar('page_progBarId');
                          unMaskWindow();
                          
                       
             }else{   // <fmt:message key='listOtherSecurityPay0086'/>
                    document.getElementById( "div2").style.display= "inline";
                     document.getElementById( "div1").style.display= "none";  
                     document.form.text8.value=json.count1;
                     document.form.text6.value=json.count2;
                     var  count=parseFloat(json.count1)+parseFloat(json.count2);
                    
                       document.getElementById("text5").value=count;
                       document.getElementById("text7").value =count;
                        hideProgressBar('page_progBarId');
                        unMaskWindow();
                               if(count==0){
                                 alert("<fmt:message key='listOtherSecurityPay0103'/>");
                              }
                        
             }
        });         
}

     function rtnFuncCustomer(arg){
            var lookup = $id("cust_name1");
            lookup.value = arg[0];
            lookup.displayValue = arg[2];
            document.form.cust_id.value=arg[0];  
              document.form.cust_code.value=arg[1];  
              document.form.text3.value=arg[2]; //<fmt:message key='listOtherSecurityPay0031'/>默认为<fmt:message key='listOtherSecurityPay0024'/>名称 <sqp<fmt:message key='listOtherSecurityPay0089'/>>
            
            var cust_id=arg[0];
                       var fund_month = document.form.fund_month1.value;
                       var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listOtherSecurityPay0017'/>
                       var security_group_id= document.form.security_group_id.value;
                      
                      var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=findCountSingal&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=<%=security_type%>"+"&date="+new Date()+"&cust_id="+cust_id;
                         jQuery.getJSON(url,{"ids1":cust_id},  function(json){
                                 if(null!=json){
                                                   document.form.text8.value=json.count1;
                                                    document.form.text6.value=json.count2;
                                                     document.form.fesc.value=json.fesc;
                                                    var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                   document.getElementById("text5").value=count;
                                                   document.getElementById("text7").value =count;
                                                    doChangeText11();
                                                     if(count==0){
                                                         alert("<fmt:message key='listOtherSecurityPay0103'/>");
                                                      }
                                 }
                            });      
         return false;
        }
        
        function doChangeText11(){
                       var fund_month = document.form.fund_month1.value;
                       var security_group_id = document.form.security_group_id.value;
                         var social_unit_id = document.form.social_unit_id.value;
                               var selectIndex = document.getElementById("social_unit_id").selectedIndex;//获得是第几个被选中了
                               var selectText = document.getElementById("social_unit_id").options[selectIndex].text //获得被选中的项目的文本
                               if(social_unit_id==null||social_unit_id==''){
                               selectText='';
                               }
                               var text11='';
                               var cust_name=document.form.cust_name1_input.value;
                       //         alert(selectText);
                         //     alert(cust_name);
                              if(cust_name==null||cust_name==''){
                              cust_name =  selectText  ;
                              }
                              
                              //text11= jQuery("#security_group_id option[value='"+security_group_id+"']").text);
                              text11= jQuery("#security_group_id").find("option:selected").text();  
                              document.form.text11.value=cust_name+text11+fund_month+" 支付";
              
}

function doChange(){
            doChangeText11();
             showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
             maskWindow();
             var fund_month = document.form.fund_month1.value;
             var security_group_id = document.form.security_group_id.value;
             var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listOtherSecurityPay0017'/>
                 if(social_unit_id==null||social_unit_id==""){
                    alert("<fmt:message key='listOtherSecurityPay0095'/>");
                        hideProgressBar('page_progBarId');
                                                           unMaskWindow();
                 return;
               }
               
                     
              reloadAlldate();
                   
           
    }
    
        function doChange1(){
            doChangeText11();
             showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
             maskWindow();
             var fund_month = document.form.fund_month1.value;
             var security_group_id = document.form.security_group_id.value;
             var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listOtherSecurityPay0017'/>
                 if(social_unit_id==null||social_unit_id==""){
                    alert("<fmt:message key='listOtherSecurityPay0095'/>");
                        hideProgressBar('page_progBarId');
                                                           unMaskWindow();
                 return;
               }
               
               var report_month='<%=report_month%>';
               //<fmt:message key='listOtherSecurityPay0003'/>果<fmt:message key='listOtherSecurityPay0046'/>的值时由管理页面传递过来的，则不做联动变化
               if(report_month!=null && report_month!='' && fund_month==report_month){
                  //$id("fund_month1").value= report_month;
               }else{              
                   //根据组id<fmt:message key='listOtherSecurityPay0098'/>(<fmt:message key='listOtherSecurityPay0099'/>20130205)
                   if(security_group_id!=null && security_group_id!=''){
                       jQuery.ajax({
                               url: '<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getFoundMonth&group_id='+security_group_id+'&social_unit_id='+social_unit_id+'&apply_date='+new Date()+'',
                               type: 'GET',
                               dataType: 'html',
                               async: false,
                               timeout: 10000,
                               error: function(){
                                   alert('Error loading XML document');
                                       return  null;
                                   },
                               success: function(text){
                                   if(text!=null && text!=''){
                                       document.form.fund_month1.value=text;//回设<fmt:message key='listOtherSecurityPay0046'/>
                                   }
                                   reloadAlldate();
                               }
                       });
                   }
               }
           
    }
    

    function reloadAlldate(){
            var security_group_id= document.form.security_group_id.value;
           var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listOtherSecurityPay0017'/>
           var fund_month = document.form.fund_month1.value;      
           var cust_id = document.form.cust_id.value;
                //        alert(cust_id);
                       if(null!=cust_id&&cust_id.trim().length>0&&"null"!=cust_id){
                                        var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=findCountSingal&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=<%=security_type%>"+"&date="+new Date()+"&cust_id="+cust_id;
                                         jQuery.getJSON(url,{"ids1":cust_id},  function(json){
                                                 if(null!=json){
                                                                   document.form.text8.value=json.count1;
                                                                    document.form.text6.value=json.count2;
                                                                     document.form.fesc.value=json.fesc;
                                                                    var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                                   document.getElementById("text5").value=count;
                                                                   document.getElementById("text7").value =count;
                                                                     hideProgressBar('page_progBarId');
                                                                     unMaskWindow();
                                                                       if(count==0){
                                                                             alert("<fmt:message key='listOtherSecurityPay0103'/>");
                                                                          }
                                                 }
                                            });   
                       
                       
                       }else{
                               var cust_name='<%=cust_name%>';
                               var cust_id='<%=cust_id%>';
                                 var cust_code='<%=cust_code%>';
                                $id("cust_name1_input").value=cust_name;
                                $id("cust_id").value=cust_id;
                              $id("cust_code").value=cust_code;
                              $id("text3").value=cust_name;
                                 var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkDAhuCount&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=<%=security_type%>"+"&date="+new Date();
                                     jQuery.getJSON(url,{"ids":social_unit_id},  function(json){
                                                   //     alert(json.isIndieBd);
                                                 //     alert(json.count1);
                                                //   alert(json.count2);
                                        
                                             document.form.dahu.value=json.isIndieBd;
                                             if(json.isIndieBd==1){  //单户
                                                       document.getElementById( "div1").style.display= "inline";  
                                                       document.getElementById( "div2").style.display= "none";
                                                       document.form.text8.value=json.count1;
                                                       document.form.text6.value=json.count2;
                                               var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                       document.getElementById("text5").value=count;
                                                       document.getElementById("text7").value =count;
                                                          hideProgressBar('page_progBarId');
                                                          unMaskWindow();
                                                          
                                                            if(count==0){
                                                                 alert("<fmt:message key='listOtherSecurityPay0103'/>");
                                                              }
                                                          
                                                       
                                             }else{   // <fmt:message key='listOtherSecurityPay0086'/>
                                                    document.getElementById( "div2").style.display= "inline";
                                                     document.getElementById( "div1").style.display= "none";  
                                                     document.form.text8.value=json.count1;
                                                     document.form.text6.value=json.count2;
                                                     var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                    
                                                       document.getElementById("text5").value=count;
                                                       document.getElementById("text7").value =count;
                                                        hideProgressBar('page_progBarId');
                                                        unMaskWindow();
                                                          if(count==0){
                                                             alert("<fmt:message key='listOtherSecurityPay0103'/>");
                                                          }
                                                        
                                             }
                                        });   
                       }
        }

    
    citySecurityGroupchange("0571','0520"); 
</script>
</fmt:bundle>