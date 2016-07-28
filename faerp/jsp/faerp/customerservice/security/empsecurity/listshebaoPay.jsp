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

<%
String user_id= RmJspHelper
.getParty_idFromRequest(request);
String user_name="";
LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
if(null!=loginVo){
    user_name=new String(loginVo.getName().getBytes("iso-8859-1"),"UTF-8");
}
%>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listshebaoPay_resource' prefix='auto.'>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
    <script language="javascript">
    
    function exportEXCEL_onClick(){
        var security_group_id = document.form.security_group_id.value;
        var report_type_bd = document.form.report_type_bd.value;
        var fund_month1 = document.form.fund_month1.value;
        var social_unit_id = document.form.social_unit_id.value;
        var singleTatsudoId = document.form.singleTatsudoId.value;
        var cust_name1 = document.form.cust_name1.value;
        if(security_group_id==null || security_group_id==""){
            alert("<fmt:message key='listshebaoPay0000'/>");
            return;
        }
        if(report_type_bd==null || report_type_bd==""){
            alert("<fmt:message key='listshebaoPay0001'/>");
            return;
        }
        if(fund_month1 ==null || fund_month1 == ""){
           alert("<fmt:message key='listshebaoPay0002'/>,<fmt:message key='listshebaoPay0003'/>“201203”！");
           return;
        }else{
           if(fund_month1.length != 6){
               alert("<fmt:message key='listshebaoPay0005'/>6<fmt:message key='listshebaoPay0006'/>,<fmt:message key='listshebaoPay0003'/>“201203”！");
               return;
           }
           var year = fund_month1.substring(0,4);
           var month = fund_month1.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listshebaoPay0009'/>2000~2030<fmt:message key='listshebaoPay0010'/>01~12之间，<fmt:message key='listshebaoPay0003'/>“201203”！");
               return;
           }
        }
        if(social_unit_id==null || social_unit_id==""){
            alert("请选择<fmt:message key='listshebaoPay0030'/>！");
            return;
        }else{
            if(social_unit_id==singleTatsudoId){
                if(cust_name1==null || cust_name1==""){
                    alert("请<fmt:message key='listshebaoPay0038'/>！");
                    return;
                }
            }
        }
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do";
        form.cmd.value = "exportToEXCEL";
        form.submit();
    }
    
    
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         if(data == undefined) return;
           document.form.cust_name1.value=data[2];
          document.form.cust_id.value=data[0];
          document.form.cust_code.value=data[1];
     //      alert(data[0]);
          
                       var fund_month = document.form.fund_month1.value;
                       var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=findCountSingal&ids="+data[0]+"&fund_month="+fund_month+"&date="+new Date();
                         jQuery.getJSON(url,{"ids":data[0]},  function(json){
                                 if(null!=json){
                                                   document.form.text8.value=json.count1;
                                                    document.form.text6.value=json.count2;
                                                       document.form.fesc.value=json.fesc;
                                                    var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                   document.getElementById("text5").value=count;
                                                   document.getElementById("text7").value =count;
                                 }
                            });      
    }
function    testDate(){
      var fund_month1 = document.form.fund_month1.value;
              if(fund_month1 ==null || fund_month1 == ""){
           alert("<fmt:message key='listshebaoPay0002'/>,<fmt:message key='listshebaoPay0003'/>“201203”！");
           document.getElementById("fund_month1").focus();
           return;
        }else{
           if(fund_month1.length != 6){
               alert("<fmt:message key='listshebaoPay0005'/>6<fmt:message key='listshebaoPay0006'/>,<fmt:message key='listshebaoPay0003'/>“201203”！");
               document.getElementById("fund_month1").focus();
               return;
           }
           var year = fund_month1.substring(0,4);
           var month = fund_month1.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listshebaoPay0009'/>2000~2030<fmt:message key='listshebaoPay0010'/>01~12之间，<fmt:message key='listshebaoPay0003'/>“201203”！");
               document.getElementById("fund_month1").focus();
               return;
           }
     //         document.form.social_unit_id.value="";  //<fmt:message key='listshebaoPay0030'/>
            document.form.text8.value=0;
           document.form.text6.value=0;
                    
          document.getElementById("text5").value=0;
          document.getElementById("text7").value =0;
        }
    }
    
    
    function test1(){
    var  text8  =document.getElementById("text8").value;
     var regu = /^(\d+)(\.?)(\d{0,10})$/; 
             if(!regu.test(text8)){
                alert("<fmt:message key='listshebaoPay0026'/>");
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
                alert("<fmt:message key='listshebaoPay0027'/>");
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
                alert("<fmt:message key='listshebaoPay0028'/>");
                 document.getElementById("text7").focus();
             return;
             }
    }
    
  function test9(){
    var  text7  =document.getElementById("text9").value;
    var regu = /^(\d+)$/; 
             if(!regu.test(text7)){
                alert("<fmt:message key='listshebaoPay0029'/>");
                 document.getElementById("text9").focus();
             return;
             }
    }  
    
         function rtnFuncCustomer(arg){
            var lookup = $id("cust_name1");
            lookup.value = arg[0];
            lookup.displayValue = arg[2];
              document.form.cust_id.value=arg[0];
                       var cust_id=arg[0];
                     var fund_month = document.form.fund_month1.value;
                       var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listshebaoPay0030'/>
                       var security_group_id= document.form.security_group_id.value;
                      var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=findCountSingal&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=1"+"&date="+new Date()+"&cust_id="+cust_id;
                         jQuery.getJSON(url,{"ids1":cust_id},  function(json){
                                 if(null!=json){
                                                   document.form.text8.value=json.count1;
                                                    document.form.text6.value=json.count2;
                                                     document.form.fesc.value=json.fesc;
                                                    var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                   document.getElementById("text5").value=count;
                                                   document.getElementById("text7").value =count;
                                 }
                            });      
                            
                            return false;
        }
    

</script>
    </head>
    <body onload="init();">

    <form name="form"   id="datacell_formid"     method="post" action="<%=request.getContextPath()%>/EmpsecurityAction.do">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
       <input type="hidden" name="fesc" id="fesc"  >

    <div id="right">
    <div class="ringht_s">


    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><fmt:message key='listshebaoPay0031'/></div>
            <!--<fmt:message key='listshebaoPay0032'/>1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1"><span>*</span><fmt:message key='listshebaoPay0100'/>组</td>
                    <td class="td_2">
                       <select id="security_group_id" name="security_group_id"   onchange="doChange1();">
                          <option value="1099110700000000155"  selected="selected">上海<fmt:message key='listshebaoPay0100'/></option>
                           <option value="1099110700000000156"  >上海<fmt:message key='listshebaoPay0106'/></option>
                       </select>
                    </td>
                    
                     <td class="td_1"><span>*</span><fmt:message key='listshebaoPay0030'/></td>
                    <td class="td_2"><faerp:SoialunitSelectTag tagname="social_unit_id" beanname="social_unit_id" style="width:205px"    onchange="doDAHU();"/></td>
                    
                    <input type="hidden"  id="dahu"   name="dahu"/>
                      <input  type="hidden" id="cust_id"  name="cust_id">
                </tr>
      
                <tr  id="div1" style="display:none;">
                   <div> 
                    <td class="td_1"><fmt:message key='listshebaoPay0037'/></td>
                    <td class="td_2"  >
                     
                           <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_name1" name="cust_name1"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="listshebaoPay0038" height="440" width="600"  style="width:170px"/>
                       
                       
                    </td>
                     <td class="td_1"></td>
                      <td class="td_2"></td>
                      <div> 
                </tr>
                 <tr  id="div2" style="display:inline;">
                    <td class="td_1"><fmt:message key='listshebaoPay0037'/></td>
                    <td class="td_2"  >
                       <input type="text" class="text_field" id="cust_name2" name="cust_name2" validators="isSearch" inputName="<fmt:message key='listshebaoPay0037'/>名称" maxLength="50"  readonly="readonly"/>
                    </td>
                     <td class="td_1"></td>
                      <td class="td_2"></td>
                </tr>
              
            </table>
            </div>

 <div class="xz_title"><fmt:message key='listshebaoPay0041'/></div>


 <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                   <td class="td_1"><span>*</span> <fmt:message key='listshebaoPay0042'/></td>
                         <td class="td_2"><input  id="fund_month1"  name="fund_month1" type="text" class="sText" id="fund_month1"    onblur="testDate();"     onchange="doChange();"   /></td>
                         <td class="td_2">&nbsp;</td>
                         <td class="td_2">&nbsp;</td>
                </tr>
      
                <tr>
                    <td class="td_1"><fmt:message key='listshebaoPay0043'/></td>
                         <td class="td_2">
                                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("payment_type_bd", -1,"PAYMENT_TYPE_BD","2"," id=payment_type_bd",false) %> 
                         
                         </td>
                         <td class="td_1"><span>*</span><fmt:message key='listshebaoPay0045'/>类型</td>
                         <td class="td_2">
                           <%=gap.rm.tools.helper.RmJspHelper.getSelectField("receiver_type_bd", -1,"RECEIVER_TYPE_BD","4"," id=service_status_bd",false) %> 
                         </td>
                </tr>
                
                
                  <tr>
                    <td class="td_1"><span>*</span><fmt:message key='listshebaoPay0045'/></td>
                         <td class="td_2"><input name="text3" type="text" class="sText" id="text3" value=""/></td>
                         <td class="td_1"><span>*</span><fmt:message key='listshebaoPay0046'/></td>
                         <td class="td_2"><input name="text9" type="text" class="sText" id="text9" value="1"   onblur="test9();"/></td>
                </tr>
                
                
                
                 <tr>
                   <td class="td_1"><fmt:message key='listshebaoPay0047'/></td>
                         <td class="td_2"><input name="text5" type="text" style="background-color:#f0f0f0;" class="sText" id="text5" value="0" readonly="readonly"  /></td>
                         <td class="td_1"><fmt:message key='listshebaoPay0048'/></td>
                         <td class="td_2"><input name="text8" type="text" style="background-color:#f0f0f0;" class="sText" id="text8" value="0"    readonly="readonly" /></td>
                </tr>
              
                  <tr>
                         <td class="td_1"><fmt:message key='listshebaoPay0049'/></td>
                         <td class="td_2"><input name="text6" type="text" style="background-color:#f0f0f0;" class="sText" id="text6" value="0"    readonly="readonly" /></td>
                         <td class="td_1"><span>*</span><fmt:message key='listshebaoPay0050'/></td>
                         <td class="td_2"><input name="text7" type="text" class="sText" id="text7" value="0"    onblur="test3();"   /></td>
                </tr>
                
               <tr>
                         <td class="td_1"><span>*</span><fmt:message key='listshebaoPay0051'/></td>
                         <td colspan="3" class="td_2">
                           <label for="textarea"></label>
                           <textarea name="text11" rows="3" class="xText_d" id="text11">缴纳<fmt:message key='listshebaoPay0100'/></textarea></td>
                </tr>
                
                    <tr>
                         <td class="td_1"><fmt:message key='listshebaoPay0053'/></td>
                         <td colspan="3" class="td_2"><textarea name="text12" rows="3" class="xText_d" id="text12"></textarea></td>
                </tr>
                 <tr>
                         <td class="td_1"><fmt:message key='listshebaoPay0054'/></td>
                         <td colspan="3" class="td_2"><textarea name="text13" rows="3" class="xText_d" id="text13"></textarea></td>
                </tr>
                
                
                 <tr>
                          <td class="td_1"><fmt:message key='listshebaoPay0055'/></td>
                         <td colspan="3" class="td_2"><input name="text10" type="text" style="background-color:#f0f0f0;" class="sText" id="text10" value="<%=user_name%>"/></td>
                </tr>
                
            </table>
            </div>
            
               <div class="foot_button">
                       <input type="button" class="foot_icon_2" value="<fmt:message key='listshebaoPay0056'/>"  onclick="doPay();"/>
                       <input type="button" class="foot_icon_2" value="<fmt:message key='listshebaoPay0057'/>"  onclick="doPrint();"/>
                    <!--<fmt:message key='listshebaoPay0032'/> end--></div>
                </div>
                
     






            <!--<fmt:message key='listshebaoPay0032'/>1 end--></div>
            </td>
        </tr>
    </table>


    </form>
</fmt:bundle>
<script language="javascript">
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">
<%  //表单回写

%>


function doPay(){
   var  security_group_id=document.form.security_group_id.value;  //社保组
   var social_unit_id=document.form.social_unit_id.value;  //<fmt:message key='listshebaoPay0030'/>
   var fund_month = document.form.fund_month1.value;   //  <fmt:message key='listshebaoPay0060'/>
   var receiver_type_bd=document.form.receiver_type_bd.value;//<fmt:message key='listshebaoPay0045'/>类型
    var text3=document.form.text3.value;//<fmt:message key='listshebaoPay0045'/>
    var text5=document.form.text5.value;//<fmt:message key='listshebaoPay0047'/>
    var text8=document.form.text8.value;//<fmt:message key='listshebaoPay0048'/>
    var text6=document.form.text6.value;//<fmt:message key='listshebaoPay0049'/>
    var text7=document.form.text7.value;//<fmt:message key='listshebaoPay0050'/>
    var text11=document.form.text11.value;//<fmt:message key='listshebaoPay0051'/>
    var text12=document.form.text12.value;//<fmt:message key='listshebaoPay0053'/>
    var text13=document.form.text13.value;//<fmt:message key='listshebaoPay0054'/>
    var text9=document.form.text9.value;//<fmt:message key='listshebaoPay0046'/>
    var payment_type_bd=document.form.payment_type_bd.value;//<fmt:message key='listshebaoPay0043'/>
           
                
           if(fund_month.length != 6){
               alert("<fmt:message key='listshebaoPay0005'/>6<fmt:message key='listshebaoPay0006'/>,<fmt:message key='listshebaoPay0003'/>“201203”！");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listshebaoPay0009'/>2000~2030<fmt:message key='listshebaoPay0010'/>01~12之间，<fmt:message key='listshebaoPay0003'/>“201203”！");
               return;
           }
        var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=save&payment_month="+fund_month+"&date="+new Date()+"&flag=1";         
        
        
     
           
           if(social_unit_id==null||social_unit_id==""){
                  alert("<fmt:message key='listshebaoPay0069'/>");
               return;
           }else{
                   url+="&social_unit_id="+social_unit_id;
           }
           
           
   
                
                
                
           
           var dahu=document.form.dahu.value;//<fmt:message key='listshebaoPay0046'/>
           if(dahu=="1"){
           
            var  cust_id  =    document.form.cust_id.value;
            url+="&cust_id="+cust_id;
            
             var  cust_id  =    document.form.cust_id.value;
                   if(null==cust_id||cust_id.trim().length==0){
                       alert("单立户必须<fmt:message key='listshebaoPay0038'/>！");
                    return;
                  }
                  
            var fesc  =document.form.fesc.value;
                   if(fesc=="0"){
                    alert("<fmt:message key='listshebaoPay0071'/>FESCO<fmt:message key='listshebaoPay0072'/>!");
                 return;
                 }
           }
           
           
           
                 if(text7==0){
                  alert("<fmt:message key='listshebaoPay0050'/>为0!");
                  return;
                }
           
           
           
           
           
           
           
           
          
           if(text9==null||text9==""){
                  alert("<fmt:message key='listshebaoPay0046'/>不能为空！");
               return;
           }else{
                url+="&text9="+text9;
           }
           
           
          if(text7==null||text7==""){
                  alert("<fmt:message key='listshebaoPay0050'/>不能为空！");
               return;
           }else{
                url+="&apply_amount="+text7;
           }
           
           
           if(text11==null||text11==""){
               alert("<fmt:message key='listshebaoPay0051'/>不能为空！");
               return;
           }else{
                url+="&text11="+encodeURIComponent(text11);
           }    
           
        
           
           
                 
           if(receiver_type_bd==null||receiver_type_bd==""){
                  alert("<fmt:message key='listshebaoPay0077'/>");
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
    //   showProgressBar('page_progBarId',' <div   class="loading" ><fmt:message key='listshebaoPay0078'/></div> ');
      showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
      maskWindow();    
}

function pay(url){

                           var flags=true;
                                jQuery.ajax({
                                url: url,
                                type: 'GET',
                                dataType: 'html',
                                timeout: 80000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                            if(text=="1"){
                                               alert("<fmt:message key='listshebaoPay0079'/>");
                                                 hideProgressBar('page_progBarId');
                                              unMaskWindow();
                                            } else if(text.length>1000){
                                                 alert("<fmt:message key='listshebaoPay0080'/>");
                                            }else if(text=="2"){
                                                alert("<fmt:message key='listshebaoPay0081'/>" );
                                                  hideProgressBar('page_progBarId');
                                              unMaskWindow();
                                            }
                                    }
                                }
                                });return flags;
}





function doPrint(){
   var  security_group_id=document.form.security_group_id.value;  //社保组
   var social_unit_id=document.form.social_unit_id.value;  //<fmt:message key='listshebaoPay0030'/>
   var fund_month = document.form.fund_month1.value;   //  <fmt:message key='listshebaoPay0060'/>
   var receiver_type_bd=document.form.receiver_type_bd.value;//<fmt:message key='listshebaoPay0045'/>类型
    var text3=document.form.text3.value;//<fmt:message key='listshebaoPay0045'/>
    var text5=document.form.text5.value;//<fmt:message key='listshebaoPay0047'/>
    var text8=document.form.text8.value;//<fmt:message key='listshebaoPay0048'/>
    var text6=document.form.text6.value;//<fmt:message key='listshebaoPay0049'/>
    var text7=document.form.text7.value;//<fmt:message key='listshebaoPay0050'/>
    var text11=document.form.text11.value;//<fmt:message key='listshebaoPay0051'/>
    var text12=document.form.text12.value;//<fmt:message key='listshebaoPay0053'/>
    var text13=document.form.text13.value;//<fmt:message key='listshebaoPay0054'/>
    var text9=document.form.text9.value;//<fmt:message key='listshebaoPay0046'/>
     var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=isPay&payment_month="+fund_month+"&date="+new Date()+"&flag=2";         
    var payment_type_bd=document.form.payment_type_bd.value;//<fmt:message key='listshebaoPay0043'/>
             
                
           if(fund_month.length != 6){
               alert("<fmt:message key='listshebaoPay0005'/>6<fmt:message key='listshebaoPay0006'/>,<fmt:message key='listshebaoPay0003'/>“201203”！");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listshebaoPay0009'/>2000~2030<fmt:message key='listshebaoPay0010'/>01~12之间，<fmt:message key='listshebaoPay0003'/>“201203”！");
               return;
           }
      
        
     
           
         if(social_unit_id==null||social_unit_id==""){
                  alert("<fmt:message key='listshebaoPay0069'/>");
               return;
           }else{
                   url+="&social_unit_id="+social_unit_id;
           }
           
           
          var dahu=document.form.dahu.value;
           if(dahu=="1"){
              var  cust_id  =    document.form.cust_id.value;
                   url+="&cust_id="+cust_id;
             if(null==cust_id||cust_id.trim().length==0){
                       alert("单立户必须<fmt:message key='listshebaoPay0038'/>！");
                    return;
                  }
                 var fesc  =document.form.fesc.value;
                 if(fesc=="0"){
                   alert("<fmt:message key='listshebaoPay0093'/>FESCO<fmt:message key='listshebaoPay0094'/>!");
                 return;
                 }
           }
           
           
           
              if(text7==0){
                  alert("<fmt:message key='listshebaoPay0050'/>为0!");
                  return;
                }
                
                 
           
           
           
           
           if(text7==null||text7.trim().length==0){
                  alert("<fmt:message key='listshebaoPay0050'/>不能为空！");
               return;
           }else{
                url+="&apply_amount="+encodeURIComponent(text7);
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
                                               alert("<fmt:message key='listshebaoPay0097'/>");
                                            }else if(text=="2"){
                                               $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=reportPayg.raq&arg1="+encodeURIComponent(text7)+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4=1&arg5=10&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>";
                                                $id("datacell_formid").submit();
                                                
                                            }
                                    }
                                }
                                });return flags;
}


function init(){
    
     var security_group_id= document.form.security_group_id.value;
     var social_unit_id = document.form.social_unit_id.value;
       //根据组id<fmt:message key='listshebaoPay0098'/>(陈小佩20130205)
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
                           document.form.fund_month1.value=yearmonth;
                           document.form.text11.value="<fmt:message key='listshebaoPay0100'/> "+yearmonth+" <fmt:message key='listshebaoPay0072'/>";
                       }
                       
                   }
           });
       }
}

function doDAHU(){
   var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listshebaoPay0030'/>
    var fund_month = document.form.fund_month1.value;
    var security_group_id= document.form.security_group_id.value;
     showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
   maskWindow();
   document.form.cust_id.value="";
   $id("cust_name1").setDisplayValue("");
            
   
   
   
   var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkDAhuCount&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=1"+"&date="+new Date();
 //   alert(url);
     jQuery.getJSON(url,{"ids":social_unit_id},  function(json){
             //          alert(json.isIndieBd);
            //         alert(json.count1);
           //     alert(json.count2);
     
             document.form.dahu.value=json.isIndieBd;
             if(json.isIndieBd==1){  //单户
                       document.getElementById( "div1").style.display= "inline";  
                       document.getElementById( "div2").style.display= "none";
                       document.form.text8.value=json.count1;
                       document.form.text6.value=json.count2;
               var  count=parseFloat(json.count1)+parseFloat(json.count2);
                       document.getElementById("text5").value=count;
                       document.getElementById("text7").value =count;
                           var lookup = $id("cust_name1");
						   lookup.value ="";
						   lookup.displayValue ="";
  
  
  
                          hideProgressBar('page_progBarId');
                          unMaskWindow();
                       
             }else{   // <fmt:message key='listshebaoPay0103'/>
                    document.getElementById( "div2").style.display= "inline";
                     document.getElementById( "div1").style.display= "none";  
                     document.form.text8.value=json.count1;
                     document.form.text6.value=json.count2;
                     var  count=parseFloat(json.count1)+parseFloat(json.count2);
                    
                       document.getElementById("text5").value=count;
                       document.getElementById("text7").value =count;
                          hideProgressBar('page_progBarId');
                          unMaskWindow();
             }
        });         
}


function doChangeText11(){
                       var fund_month = document.form.fund_month1.value;
                       var security_group_id = document.form.security_group_id.value;
                          if(security_group_id=="1099110700000000155"){
                                  document.form.text11.value="<fmt:message key='listshebaoPay0100'/> "+fund_month+" <fmt:message key='listshebaoPay0072'/>";
                            } else  if(security_group_id=="1099110700000000156"){
                                  document.form.text11.value="<fmt:message key='listshebaoPay0106'/> "+fund_month+" <fmt:message key='listshebaoPay0072'/>";
                            }

}

  function doChange(){
         showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
         maskWindow();
         doChangeText11();
                   
           var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listshebaoPay0030'/>
           if(social_unit_id==null||social_unit_id==""){
                alert("请选择<fmt:message key='listshebaoPay0030'/>！");
                hideProgressBar('page_progBarId');
                unMaskWindow();
		        return;
		    }
           
           reloadAlldate();
    }
    
    //变更社保组，需要计算<fmt:message key='listshebaoPay0042'/>
    function doChange1(){
         showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
         maskWindow();
         doChangeText11();
                   
           var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listshebaoPay0030'/>
           if(social_unit_id==null||social_unit_id==""){
                alert("请选择<fmt:message key='listshebaoPay0030'/>！");
                hideProgressBar('page_progBarId');
                unMaskWindow();
                return;
            }
           
           var security_group_id= document.form.security_group_id.value;
	       //根据组id<fmt:message key='listshebaoPay0098'/>(陈小佩20130205)
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
	                           document.form.fund_month1.value=text;//回设<fmt:message key='listshebaoPay0060'/>
	                       }
	                       reloadAlldate();
	                   }
	           });
	       }
           
    }
    

    function reloadAlldate(){
           var security_group_id= document.form.security_group_id.value;
           var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listshebaoPay0030'/>
           var fund_month = document.form.fund_month1.value;       
           var cust_id = document.form.cust_id.value;
           if(null!=cust_id&&cust_id.trim().length>0){
                            var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=findCountSingal&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=2"+"&date="+new Date()+"&cust_id="+cust_id;
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
                                     }
                                });   
           
           
           }else{
           
                     var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkDAhuCount&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=2"+"&date="+new Date();
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
                                              
                                           
                                 }else{   // <fmt:message key='listshebaoPay0115'/>
                                        document.getElementById( "div2").style.display= "inline";
                                         document.getElementById( "div1").style.display= "none";  
                                         document.form.text8.value=json.count1;
                                         document.form.text6.value=json.count2;
                                         var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                        
                                           document.getElementById("text5").value=count;
                                           document.getElementById("text7").value =count;
                                            hideProgressBar('page_progBarId');
                                            unMaskWindow();
                                            
                                 }
                            });   
           }
        }
        
        
</script>
