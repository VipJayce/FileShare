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
        String  isQuery = request.getParameter("isQuery")==null?"false":request.getParameter("isQuery");
        String security_type= request.getParameter("security_type");
        String  payment_type_bd  ="";
        if(security_type.equals("2")){//<fmt:message key='listSecurityPay0002'/>果是2<fmt:message key='listSecurityPay0087'/>则显示<fmt:message key='listSecurityPay0087'/>，其它显示<fmt:message key='listSecurityPay0086'/>
            payment_type_bd="2";
        }else{
            payment_type_bd="1";
        }
    %>


<html>
 <fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listSecurityPay_resource' prefix='auto.'>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
    <script language="javascript">
    
   
    
    
  
function    testDate(){
      var fund_month1 = document.form.fund_month1.value;
              if(fund_month1 ==null || fund_month1 == ""){
           alert("<fmt:message key='listSecurityPay0100'/><fmt:message key='listSecurityPay0050'/>,<fmt:message key='listSecurityPay0002'/>");
           document.getElementById("fund_month1").focus();
           return;
        }else{
           if(fund_month1.length != 6){
               alert("<fmt:message key='listSecurityPay0050'/><fmt:message key='listSecurityPay0005'/>,<fmt:message key='listSecurityPay0002'/>");
               document.getElementById("fund_month1").focus();
               return;
           }
           var year = fund_month1.substring(0,4);
           var month = fund_month1.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listSecurityPay0102'/><fmt:message key='listSecurityPay0050'/><fmt:message key='listSecurityPay0009'/><fmt:message key='listSecurityPay0010'/>");
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
                alert("<fmt:message key='listSecurityPay0012'/>");
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
                alert("<fmt:message key='listSecurityPay0013'/>");
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
                alert("<fmt:message key='listSecurityPay0014'/>");
                 document.getElementById("text7").focus();
             return;
             }
    }
    
  function test9(){
    var  text7  =document.getElementById("text9").value;
    var regu = /^(\d+)$/; 
             if(!regu.test(text7)){
                alert("<fmt:message key='listSecurityPay0015'/>");
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
                       var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listSecurityPay0016'/>
                       var security_group_id= document.form.security_group_id.value;
                       var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkDAhuCount&ids="+social_unit_id+"&fund_month="+fund_month+"&cust_id="+data[0]+"&security_group_id="+security_group_id+"&date="+new Date();
                         $.getJSON(url,{"ids":data[0]},  function(json){
                                 if(null!=json){
                                             //      alert(json.fesc);
                                                     document.form.text8.value=json.count1;
                                                     document.form.text6.value=json.count2;
                                                     document.form.fesc.value=json.fesc;
                                                     var count=parseFloat(json.count1)+parseFloat(json.count2);
                                                     document.getElementById("text5").value=count.toFixed(2);
                                                     document.getElementById("text7").value =count.toFixed(2);
                                 }
                            });      
    }

</script>
    </head>
    <body onload="init();">

    <form name="form" id="datacell_formid"  method="post" action="<%=request.getContextPath()%>/EmpsecurityAction.do">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
     <input type="hidden" name="fesc" id="fesc"  >

    <div id="right">
    <div class="ringht_s">


    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><fmt:message key='listSecurityPay0017'/></div>
            <!--<fmt:message key='listSecurityPay0018'/>1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1"><span>*</span><fmt:message key='listSecurityPay0086'/><fmt:message key='listSecurityPay0103'/>/<fmt:message key='listSecurityPay0087'/><fmt:message key='listSecurityPay0103'/></td>
                    <td class="td_2">
                       <select id="security_group_id" name="security_group_id"  onchange="doChange1();">
                            <c:choose>
                            <c:when test="${param.security_type=='1'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listSecurityPay0104'/><fmt:message key='listSecurityPay0086'/><fmt:message key='listSecurityPay0103'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='3'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key='listSecurityPay0020'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='4'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key='listSecurityPay0021'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='2'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>" selected><fmt:message key='listSecurityPay0104'/><fmt:message key='listSecurityPay0087'/></option>
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message key='listSecurityPay0023'/></option>
                               
                            </c:when>
                            
                        </c:choose>
                          
                       </select>
                    </td>
                    
                     <td class="td_1"><span>*</span><fmt:message key='listSecurityPay0016'/></td>
                    <td class="td_2"><faerp:SoialunitSelectTag tagname="social_unit_id" beanname="social_unit_id" style="width:205px"    onchange="doDAHU();  "/></td>
                    
                    <input type="hidden"  id="dahu"   name="dahu"/>
                    
                </tr>
      
                <tr  id="div1" style="display:none;">
                   <div> 
                    <td class="td_1"><fmt:message key='listSecurityPay0025'/></td>
                    <td class="td_2"  >
                     
                       
                       
                           <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_name1" name="cust_name1"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="listSecurityPay0026" height="440" width="600"  style="width:170px"/>
                       
                       
                       
                    </td>
                     <td class="td_1"><fmt:message key='listSecurityPay0027'/></td>
                   
                      <td class="td_2">  <input  type="text" class="text_field"    id="cust_code"  name="cust_code" readonly="readonly"  />
                       <input  type="hidden" class="text_field"    id="cust_id"  name="cust_id" readonly="readonly"  />
                      
                      </td>
                      <div> 
                </tr>
                 <tr  id="div2" style="display:inline;">
                    <td class="td_1"><fmt:message key='listSecurityPay0028'/></td>
                    <td class="td_2"  >
                       <input type="text" class="text_field" id="cust_name2" name="cust_name2" validators="isSearch" maxLength="50"  readonly="readonly" value=""/>
                    </td>
                       <td class="td_1"><fmt:message key='listSecurityPay0027'/></td>
                     <td class="td_2">  <input  type="text" class="text_field"    id="cust_id1"  name="cust_id1" readonly="readonly"  value="" /></td>
                </tr>
              
            </table>
            </div>

 <div class="xz_title"><fmt:message key='listSecurityPay0031'/></div>


 <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                   <td class="td_1"><span>*</span> <fmt:message key='listSecurityPay0032'/></td>
                         <td class="td_2"><input  id="fund_month1"  name="fund_month1" type="text" class="sText" id="fund_month1"    onblur="testDate();"    onchange="doChange();"  /></td>
                         <td class="td_2">&nbsp;</td>
                         <td class="td_2">&nbsp;</td>
                </tr>
      
                <tr>
                    <td class="td_1"><fmt:message key='listSecurityPay0033'/></td>
                         <td class="td_2">
                                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("payment_type_bd", -1,"PAYMENT_TYPE_BD",payment_type_bd," id=payment_type_bd",false) %> 
                         
                         </td>
                         <td class="td_1"><span>*</span><fmt:message key='listSecurityPay0035'/><fmt:message key='listSecurityPay0090'/></td>
                         <td class="td_2">
                           <%=gap.rm.tools.helper.RmJspHelper.getSelectField("receiver_type_bd", -1,"RECEIVER_TYPE_BD","4"," id=service_status_bd",false) %> 
                         </td>
                </tr>
                
                
                  <tr>
                    <td class="td_1"><span>*</span><fmt:message key='listSecurityPay0035'/></td>
                         <td class="td_2"><input name="text3" type="text" class="sText" id="text3" value=""/></td>
                         <td class="td_1"><span>*</span><fmt:message key='listSecurityPay0036'/></td>
                         <td class="td_2"><input name="text9" type="text" class="sText" id="text9" value="1"   onblur="test9();"/></td>
                </tr>
                
                
                
                 <tr>
                   <td class="td_1"><fmt:message key='listSecurityPay0037'/></td>
                         <td class="td_2"><input name="text5" type="text" style="background-color:#f0f0f0;" class="sText" id="text5" value="0" readonly="readonly"  /></td>
                         <td class="td_1"><fmt:message key='listSecurityPay0038'/></td>
                         <td class="td_2"><input name="text8" type="text" style="background-color:#f0f0f0;" class="sText" id="text8" value="0"    readonly="readonly" /></td>
                </tr>
              
                  <tr>
                         <td class="td_1"><fmt:message key='listSecurityPay0039'/></td>
                         <td class="td_2"><input name="text6" type="text" style="background-color:#f0f0f0;" class="sText" id="text6" value="0"    readonly="readonly" /></td>
                         <td class="td_1"><span>*</span><fmt:message key='listSecurityPay0040'/></td>
                         <td class="td_2"><input name="text7" type="text" class="sText" id="text7" value="0"    onblur="test3();"   /></td>
                </tr>
                
               <tr>
                         <td class="td_1"><span>*</span><fmt:message key='listSecurityPay0041'/></td>
                         <td colspan="3" class="td_2">
                           <label for="textarea"></label>
                           <textarea name="text11"  class="xText_d"  rows="3" id="text11"><fmt:message key='listSecurityPay0091'/><fmt:message key='listSecurityPay0086'/></textarea></td>
                </tr>
                
                    <tr>
                         <td class="td_1"><fmt:message key='listSecurityPay0043'/></td>
                         <td colspan="3" class="td_2"><textarea name="text12" rows="3" class="xText_d" id="text12"></textarea></td>
                </tr>
                 <tr>
                         <td class="td_1"><fmt:message key='listSecurityPay0044'/></td>
                         <td colspan="3" class="td_2"><textarea name="text13" rows="3" class="xText_d" id="text13"></textarea></td>
                </tr>
                
                
                 <tr>
                          <td class="td_1"><fmt:message key='listSecurityPay0045'/></td>
                         <td colspan="3" class="td_2"><input name="text10" type="text" style="background-color:#f0f0f0;" class="sText" id="text10" value="<%= user_name %>"/></td>
                </tr>
                
            </table>
            </div>
            
               <div class="foot_button">
                       <input type="button" class="foot_icon_2" value="<fmt:message key='listSecurityPay0046'/>" <au:authorityBtn code="sbzf_sczfsh" type="1"/>  onclick="doPay();"/>
                       <input type="button" class="foot_icon_2" value="<fmt:message key='listSecurityPay0047'/>" <au:authorityBtn code="sbzf_print" type="1"/> onclick="doPrint();"/>
                    <!--<fmt:message key='listSecurityPay0018'/> end--></div>
                </div>

            <!--<fmt:message key='listSecurityPay0018'/>1 end--></div>
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
    var  security_group_id=document.form.security_group_id.value;  //<fmt:message key='listSecurityPay0086'/>组
    var social_unit_id=document.form.social_unit_id.value;  //<fmt:message key='listSecurityPay0016'/>
    var fund_month = document.form.fund_month1.value;   //  <fmt:message key='listSecurityPay0050'/>
    var  custID  =    document.form.cust_id.value;
    var receiver_type_bd=document.form.receiver_type_bd.value;//<fmt:message key='listSecurityPay0035'/>类型
            var text3=document.form.text3.value;//<fmt:message key='listSecurityPay0035'/>
            var text5=document.form.text5.value;//<fmt:message key='listSecurityPay0037'/>
            var text8=document.form.text8.value;//<fmt:message key='listSecurityPay0038'/>
            var text6=document.form.text6.value;//<fmt:message key='listSecurityPay0039'/>
            var text7=document.form.text7.value;//<fmt:message key='listSecurityPay0040'/>
            var text11=document.form.text11.value;//<fmt:message key='listSecurityPay0041'/>
            var text12=document.form.text12.value;//<fmt:message key='listSecurityPay0043'/>
            var text13=document.form.text13.value;//<fmt:message key='listSecurityPay0044'/>
            var text9=document.form.text9.value;//<fmt:message key='listSecurityPay0036'/>
            var payment_type_bd=document.form.payment_type_bd.value;//<fmt:message key='listSecurityPay0033'/>
                   if(fund_month.length != 6){
                       alert("<fmt:message key='listSecurityPay0050'/><fmt:message key='listSecurityPay0098'/><fmt:message key='listSecurityPay0005'/>,<fmt:message key='listSecurityPay0002'/>");
                       return;
                   }
                   var year = fund_month.substring(0,4);
                   var month = fund_month.substring(4,6);
                   if(year<2000 || year>2030 || month<1 || month>12){
                       alert("<fmt:message key='listSecurityPay0102'/><fmt:message key='listSecurityPay0050'/><fmt:message key='listSecurityPay0009'/><fmt:message key='listSecurityPay0010'/>“201203”！");
                       return;
                   }
                   
                   
                var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=save&payment_month="+fund_month+"&date="+new Date()+"&flag=<%=security_type%>";     
                //var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getSecurityStopCount&payment_month="+fund_month+"&date="+new Date()+"&flag=<%=security_type%>";    
                if(social_unit_id==null||social_unit_id==""){
                          alert("<fmt:message key='listSecurityPay0059'/>");
                       return;
                   }else{
                           url+="&social_unit_id="+social_unit_id;
                   }
                   
                     
                
                  var dahu=document.form.dahu.value; 
                   if(dahu=="1"){
                      var  cust_id  =    document.form.cust_id.value;
                           if(null==cust_id||cust_id.trim().length==0){
                               alert("<fmt:message key='listSecurityPay0060'/>");
                            return;
                          }
                       url+="&cust_id="+cust_id;
                         var fesc  =document.form.fesc.value;
                           if(fesc=="0"){
                           alert("<fmt:message key='listSecurityPay0061'/>FESCO<fmt:message key='listSecurityPay0062'/>!");
                         return;
                         }
                   }

if(text5==0){
                    alert("<fmt:message key='listSecurityPay0037'/><fmt:message key='listSecurityPay0064'/>!");
                    return;
                }
                  
                   if(text9==null||text9==""){
                          alert("<fmt:message key='listSecurityPay0065'/>");
                       return;
                   }else{
                        url+="&text9="+text9;
                   }
                   
                    if(text3==null||text3.trim().length==0){
                          alert("<fmt:message key='listSecurityPay0066'/>");
                       return;
                   }
                   
                  if(text7==null||text7.trim().length==0){
                          alert("<fmt:message key='listSecurityPay0067'/>");
                       return;
                   }else{
                        url+="&apply_amount="+encodeURIComponent(text7);
                   }
                   
                   if(text11==null||text11.trim().length==0){
                       alert("<fmt:message key='listSecurityPay0068'/>");
                       return;
                   }else{
                        url+="&text11="+encodeURIComponent(text11);
                   }    
                   
                    if(receiver_type_bd==null||receiver_type_bd==""){
                          alert("<fmt:message key='listSecurityPay0069'/>");
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
 
                //检查是否有未停办的公积金
                var getSecurityCountUrl="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getSecurityStopCount&security_group_id="+security_group_id+"&social_unit_id="+social_unit_id+"&fund_month="+fund_month+"&custID="+custID;
                var countResult = checkSecurityCount(getSecurityCountUrl);
                if(countResult != "" && countResult != "null" && countResult != null){
                    if(confirm("有"+countResult+"个用户公积金尚未停办，是否继续?")){
	                        pay(url);   
	                }else{
	                   return false;
	                }
                }else{
                    pay(url);
                }
}

//获取未停办的公积金数量
function checkSecurityCount(url){
    var count="";
    jQuery.ajax({
        url: url,
        type: 'post',
        dataType: 'html',
        async: false,
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return;
        },
        success: function(text){
           count=text;
        }
    });
    return count;
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
           error: function(){
               alert('Error loading XML document');
               return  null;
           },
           success: function(text){
               if(text!=null){
                    //if(text.length>1000){
                    //     alert("<fmt:message key='listSecurityPay0070'/>");
                    //      hideProgressBar('page_progBarId');
                    //     unMaskWindow();
                    //   }else{
                           alert(text);
                          hideProgressBar('page_progBarId');
                         unMaskWindow();
                    //  }
               }
           }
           });return flags;
}



function doPrint(){
    var  security_group_id=document.form.security_group_id.value;  //<fmt:message key='listSecurityPay0086'/>组
    var social_unit_id=document.form.social_unit_id.value;  //<fmt:message key='listSecurityPay0016'/>
    var fund_month = document.form.fund_month1.value;   //  <fmt:message key='listSecurityPay0050'/>
    var receiver_type_bd=document.form.receiver_type_bd.value;//<fmt:message key='listSecurityPay0035'/>类型
    var text3=document.form.text3.value;//<fmt:message key='listSecurityPay0035'/>
    var text5=document.form.text5.value;//<fmt:message key='listSecurityPay0037'/>
    var text8=document.form.text8.value;//<fmt:message key='listSecurityPay0038'/>
    var text6=document.form.text6.value;//<fmt:message key='listSecurityPay0039'/>
    var text7=document.form.text7.value;//<fmt:message key='listSecurityPay0040'/>
    var text11=document.form.text11.value;//<fmt:message key='listSecurityPay0041'/>
    var text12=document.form.text12.value;//<fmt:message key='listSecurityPay0043'/>
    var text13=document.form.text13.value;//<fmt:message key='listSecurityPay0044'/>
    var text9=document.form.text9.value;//<fmt:message key='listSecurityPay0036'/>
     var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=isPay&payment_month="+fund_month+"&date="+new Date()+"&flag=<%=security_type%>";         
    var payment_type_bd=document.form.payment_type_bd.value;//<fmt:message key='listSecurityPay0033'/>
                if(text5==0){
                  alert("<fmt:message key='listSecurityPay0037'/><fmt:message key='listSecurityPay0099'/><fmt:message key='listSecurityPay0073'/>!");
                  return;
                }
                
           if(fund_month.length != 6){
               alert("<fmt:message key='listSecurityPay0050'/><fmt:message key='listSecurityPay0098'/><fmt:message key='listSecurityPay0005'/>,<fmt:message key='listSecurityPay0002'/>");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listSecurityPay0102'/><fmt:message key='listSecurityPay0050'/><fmt:message key='listSecurityPay0009'/><fmt:message key='listSecurityPay0010'/>");
               return;
           }
      
        
     
           
  if(social_unit_id==null||social_unit_id==""){
                  alert("<fmt:message key='listSecurityPay0059'/>");
               return;
           }else{
                   url+="&social_unit_id="+social_unit_id;
           }
           
   if(text7==null||text7.trim().length==0){
                  alert("<fmt:message key='listSecurityPay0067'/>");
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
                   alert("<fmt:message key='listSecurityPay0084'/>FESCO<fmt:message key='listSecurityPay0085'/>!");
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
        //获取<fmt:message key='listSecurityPay0016'/>的开户银行单位
        var myAjax = new Ajax("<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=getOpen_unit");
        myAjax.addParam("security_group_id", security_group_id);
        myAjax.addParam("social_unit_id", social_unit_id);
        myAjax.addParam("cust_id", cust_id);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
            open_unit=myAjax.getProperty("returnValue");//1<fmt:message key='listSecurityPay0086'/>2<fmt:message key='listSecurityPay0087'/>         
         }
        
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
                                               alert("未<fmt:message key='listSecurityPay0046'/><fmt:message key='listSecurityPay0073'/>！");
                                            }else if(text=="2"){
                                               $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=reportPayg.raq&arg1="+text7+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4=1&arg5=10&arg6="+"<%=user_id%>"+"&arg7="+encodeURIComponent("<%=user_name%>")+"&arg8="+encodeURIComponent(text11)+"&open_unit="+encodeURIComponent(open_unit);
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
      //   document.form.text11.value="<fmt:message key='listSecurityPay0086'/> "+yearmonth+" <fmt:message key='listSecurityPay0062'/>";
    }
  doChangeText11();
}
function doDAHU(){
    var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listSecurityPay0016'/>
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
                          
                       
             }else{   // <fmt:message key='listSecurityPay0092'/>
                    document.getElementById( "div2").style.display= "inline";
                     document.getElementById( "div1").style.display= "none";  
                     document.form.text8.value=json.count1;
                     document.form.text6.value=json.count2;
                     var  count=parseFloat(json.count1)+parseFloat(json.count2);
                    
                       document.getElementById("text5").value=count.toFixed(2);
                       document.getElementById("text7").value =count.toFixed(2);
                        hideProgressBar('page_progBarId');
                        unMaskWindow();
                               if(count==0){
                                 alert("<fmt:message key='listSecurityPay0040'/><fmt:message key='listSecurityPay0064'/>！");
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
              document.form.text3.value=arg[2]; //<fmt:message key='listSecurityPay0035'/>默认为<fmt:message key='listSecurityPay0028'/>名称 <sqp<fmt:message key='listSecurityPay0095'/>>
            
            var cust_id=arg[0];
                       var fund_month = document.form.fund_month1.value;
                       var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listSecurityPay0016'/>
                       var security_group_id= document.form.security_group_id.value;
                      
                      var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=findCountSingal&ids="+social_unit_id+"&fund_month="+fund_month+"&security_group_id="+security_group_id+"&flag=<%=security_type%>"+"&date="+new Date()+"&cust_id="+cust_id;
                         jQuery.getJSON(url,{"ids1":cust_id},  function(json){
                                 if(null!=json){
                                                   document.form.text8.value=json.count1;
                                                    document.form.text6.value=json.count2;
                                                     document.form.fesc.value=json.fesc;
                                                    var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                   document.getElementById("text5").value=count.toFixed(2);
                                                   document.getElementById("text7").value =count.toFixed(2);
                                                    doChangeText11();
                                                     if(count==0){
                                                         alert("<fmt:message key='listSecurityPay0040'/><fmt:message key='listSecurityPay0064'/>！");
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
                          if(security_group_id=="1099110700000000155"){
                                  document.form.text11.value=cust_name+" 公积金 "+fund_month+" 支付";
                            } else  if(security_group_id=="1099110700000000156"){
                                  document.form.text11.value=cust_name+" 补充公积金 "+fund_month+" 支付";
                            }else if(security_group_id=='1099110700000000152'){
                              document.form.text11.value=cust_name+" 社保 "+fund_month+" 支付";
                            }else if(security_group_id=='1099110700000000153'){
                              document.form.text11.value=cust_name+" 镇保 "+fund_month+" 支付";
                         }else if(security_group_id=='1099110700000000641'){
                              document.form.text11.value=cust_name+" 综保 "+fund_month+" 支付";
                         }else{
                                document.form.text11.value=cust_name+" 综保 "+fund_month+" 支付";
                         }
                         

}

function doChange(){
            doChangeText11();
             showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
             maskWindow();
             var fund_month = document.form.fund_month1.value;
             var security_group_id = document.form.security_group_id.value;
             var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listSecurityPay0016'/>
                 if(social_unit_id==null||social_unit_id==""){
                    alert("<fmt:message key='listSecurityPay0112'/>");
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
             var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listSecurityPay0016'/>
                 if(social_unit_id==null||social_unit_id==""){
                    alert("<fmt:message key='listSecurityPay0112'/>");
                        hideProgressBar('page_progBarId');
                                                           unMaskWindow();
                 return;
               }
               
               var report_month='<%=report_month%>';
               //<fmt:message key='listSecurityPay0002'/>果<fmt:message key='listSecurityPay0050'/>的值时由管理页面传递过来的，则不做联动变化
               if(report_month!=null && report_month!='' && fund_month==report_month){
                  //$id("fund_month1").value= report_month;
               }else{              
                   //根据组id计算得到<fmt:message key='listSecurityPay0050'/>(陈小佩20130205)
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
                                       document.form.fund_month1.value=text;//回设<fmt:message key='listSecurityPay0050'/>
                                   }
                                   reloadAlldate();
                               }
                       });
                   }
               }
           
    }
    

    function reloadAlldate(){
            var security_group_id= document.form.security_group_id.value;
           var social_unit_id = document.form.social_unit_id.value;  // <fmt:message key='listSecurityPay0016'/>
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
                                                                   document.getElementById("text5").value=count.toFixed(2);
                                                                   document.getElementById("text7").value =count.toFixed(2);
                                                                   hideProgressBar('page_progBarId');
                                                                   unMaskWindow();
                                                                       if(count==0){
                                                                             alert("<fmt:message key='listSecurityPay0040'/><fmt:message key='listSecurityPay0064'/>！");
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
                                                       document.getElementById("text5").value=count.toFixed(2);
                                                       document.getElementById("text7").value =count.toFixed(2);
                                                          hideProgressBar('page_progBarId');
                                                          unMaskWindow();
                                                          
                                                            if(count==0){
                                                                 alert("<fmt:message key='listSecurityPay0040'/><fmt:message key='listSecurityPay0064'/>！");
                                                              }
                                                          
                                                       
                                             }else{   // <fmt:message key='listSecurityPay0092'/>
                                                    document.getElementById( "div2").style.display= "inline";
                                                     document.getElementById( "div1").style.display= "none";  
                                                     document.form.text8.value=json.count1;
                                                     document.form.text6.value=json.count2;
                                                     var  count=parseFloat(json.count1)+parseFloat(json.count2);
                                                    
                                                       document.getElementById("text5").value=count.toFixed(2);
                                                       document.getElementById("text7").value =count.toFixed(2);
                                                        hideProgressBar('page_progBarId');
                                                        unMaskWindow();
                                                          if(count==0){
                                                             alert("<fmt:message key='listSecurityPay0040'/><fmt:message key='listSecurityPay0064'/>！");
                                                          }
                                                        
                                             }
                                        });   
                       }
        }
        //邓鹏<fmt:message key='listSecurityPay0095'/>
     var isQuery= <%=isQuery%>;
    var security_group_id='<%=security_group_id%>';
    var social_unit_id='<%=social_unit_id%>';
    var cust_name='<%=cust_name%>';
    var cust_code='<%=cust_code%>';
    var cust_id='<%=cust_id%>';
    var report_month='<%=report_month%>';
    if(isQuery)
    {
     document.getElementById("social_unit_id").value=social_unit_id;
         if(security_group_id=='1099110700000000155')
        {
                document.getElementById("security_group_id").options[0].selected=true;
                doChange();
        }
        else if(security_group_id=='1099110700000000156')
        {
                  document.getElementById("security_group_id").options[1].selected=true;
                  doChange();
        }
        if(report_month!=null && report_month!=''){
            $id("fund_month1").value= report_month;
          }
    }
</script>
</fmt:bundle>
