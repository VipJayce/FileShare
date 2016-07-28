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
<html>
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
        String cust_name= request.getParameter("customer_name");
        String cust_id= request.getParameter("cust_id");
        String report_month= request.getParameter("report_month");
        if(report_month==null || report_month.equals("null") || report_month.equals("undefined")){
            report_month = "";
        }
        String  isQuery = request.getParameter("isQuery")==null?"false":request.getParameter("isQuery");
    %>
    <fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listSocialSecurityStatementsGongJin_resource' prefix='auto.'>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <script language="javascript">
    

    
    
    jQuery(function(){
        $id("celllist1").isQueryFirst = false;
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=\"ClickRow('" + entity.getProperty("id") + "');\">";
     }
    
    function ClickRow(value){
        
    }
    
    //<fmt:message key='listSocialSecurityStatementsGongJin0084'/>有变化，重新查询列表
    function loadData(){
            var security_group_id = document.form.security_group_id.value;
            reloadAlldate(security_group_id);
       
       }
       
       
    
    //<fmt:message key='listSocialSecurityStatementsGongJin0044'/><fmt:message key='listSocialSecurityStatementsGongJin0045'/>组有变化，需要自动计算<fmt:message key='listSocialSecurityStatementsGongJin0084'/>的变更情况
    function loadData1(){
       var security_group_id = document.form.security_group_id.value;
       var type=document.getElementById("report_type_bd").value;
         var report_type_bd = document.getElementById("report_type_bd");
         var   j=report_type_bd.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             report_type_bd.remove(i);
          }  
           if(security_group_id=="1099110700000000155"){
        //     addAt(report_type_bd,"<fmt:message key='listSocialSecurityStatementsGongJin0000'/>","-1",1);
             addAt(report_type_bd,"基本汇缴书(汇缴)","3",1);
             addAt(report_type_bd,"基本汇缴书(补缴)","1",1);
             addAt(report_type_bd,"住房公积金(补充住房公积金)集中封存清册","7",1);
             addAt(report_type_bd,"基本转移通知书","4",1);
             
             
             addAt(report_type_bd,"住房公积金补缴清册","8",1);
             addAt(report_type_bd,"住房公积金汇缴变更清册","9",1);
             
             
             addAt(report_type_bd,"新进名单","10",1);
             addAt(report_type_bd,"停缴名单","11",1);
             addAt(report_type_bd,"公积金每月明细","12",1);
          
          } else  if(security_group_id=="1099110700000000156"){
    //        addAt(report_type_bd,"<fmt:message key='listSocialSecurityStatementsGongJin0000'/>","-1",1);
             addAt(report_type_bd,"基本汇缴书(补缴)","1",1);
             addAt(report_type_bd,"基本汇缴书(汇缴)","3",1);
             addAt(report_type_bd,"补充转移通知书","2",1);
             
             
              addAt(report_type_bd,"补充住房公积金补缴清册","5",1);
            addAt(report_type_bd,"补充住房公积金汇缴变更清册","6",1);
       //      addAt(report_type_bd,"<fmt:message key='listSocialSecurityStatementsGongJin0022'/>","6",1);
             
             
             addAt(report_type_bd,"住房公积金(补充住房公积金)集中封存清册","7",1);
             addAt(report_type_bd,"新进名单","10",1);
             addAt(report_type_bd,"停缴名单","11",1);
             addAt(report_type_bd,"公积金每月明细","12",1);
          }
     //      alert(type);
       document.getElementById("report_type_bd").value=type;
       
       //根据组id计算得到<fmt:message key='listSocialSecurityStatementsGongJin0084'/>(陈小佩20130205)
       loadData2();
       
    }
    
    //<fmt:message key='listSocialSecurityStatementsGongJin0086'/>有变化，需要自动计算<fmt:message key='listSocialSecurityStatementsGongJin0084'/>的变更情况
    function loadData2(){
       var security_group_id = document.form.security_group_id.value;
       var social_unit_id = document.form.social_unit_id.value;
       var cust_id  = $id('cust_id').value;
       var report_month='<%=report_month%>';
       var fund_month = document.form.fund_month1.value;
       //var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids="+social_unit_id;
       jQuery.ajax({
                       url: '<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids='+social_unit_id+'&apply_date='+new Date()+'',
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
                               $name('is_oneoff').value=text.isIndieBd;//<fmt:message key='listSocialSecurityStatementsGongJin0097'/><fmt:message key='listSocialSecurityStatementsGongJin0098'/>一次性<fmt:message key='listSocialSecurityStatementsGongJin0004'/>
                           }
                           getfundmonth();
                       }
               });
       
    }
    function getfundmonth(){
      var cust_id  = $id('cust_id').value;
      var security_group_id = document.form.security_group_id.value;
        //<fmt:message key='listSocialSecurityStatementsGongJin0035'/>果<fmt:message key='listSocialSecurityStatementsGongJin0084'/>的值时由管理页面传递过来的，则不做联动变化
       if(report_month!=null && report_month!='' && fund_month==report_month){
          //$id("fund_month1").value= report_month;
       }else{
           //根据组id计算得到<fmt:message key='listSocialSecurityStatementsGongJin0084'/>(陈小佩20130205)
          // if(security_group_id!=null && security_group_id!=''){
               jQuery.ajax({
                       url: '<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getFoundMonth&group_id='+security_group_id+'&social_unit_id='+social_unit_id+'&cust_id='+cust_id+'&apply_date='+new Date()+'',
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
                                    if(text == "000000"){
                                        alert("该客户的公积金/补充公积金账号信息未初始化!");
                                        document.form.fund_month1.value="";//回设<fmt:message key='listSocialSecurityStatementsGongJin0084'/>
                                        document.form.pay_end_month.value="";
                                        $id("celllist1").loadData();
                                        $id("celllist1").refresh();
                                        return;
                                    }
                                    if(text == "000001"){
                                        document.form.fund_month1.value="";//回设<fmt:message key='listSocialSecurityStatementsGongJin0084'/>
                                        document.form.pay_end_month.value="";
                                        $id("celllist1").loadData();
                                        $id("celllist1").refresh();
                                        return;
                                    }
	                               document.form.fund_month1.value=text;//回设<fmt:message key='listSocialSecurityStatementsGongJin0084'/>
	                               document.form.pay_end_month.value=text;
                           }
                           reloadAlldate(security_group_id);
                       }
               });
         //  }
       }

    }
    
    //根据条件重新查询列表
    function reloadAlldate(security_group_id){
          var fund_month = document.form.fund_month1.value;
          var social_unit_id = document.form.social_unit_id.value;
          var cust_id = document.form.cust_id.value;
           if(fund_month!=null&&fund_month!=""&&fund_month == "000000"){
                    document.form.fund_month1.value = "";
                    document.form.pay_end_month.value = "";
                    alert("此户的公积金账号尚未填写完整!");
                    return;
          }
          if(security_group_id!=null&&security_group_id!=""&&fund_month!=null&&fund_month!=""&&social_unit_id!=null&&social_unit_id!=""){
              if(fund_month.length != 6){
                  alert("<fmt:message key='listSocialSecurityStatementsGongJin0030'/>");
                  return;
              }
              var year = fund_month.substring(0,4);
              var month = fund_month.substring(4,6);
              if(year<2000 || year>2030 || month<1 || month>12){
                  alert("<fmt:message key='listSocialSecurityStatementsGongJin0031'/>");
                  return;
              }
              $id("celllist1").loadData();
              $id("celllist1").refresh();
              /*var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids="+social_unit_id;
               jQuery.post(url,function(data){
                   if(data){
                       if(data.isIndieBd==1){
                           if(cust_id==null || cust_id==""){
                               //alert("请<fmt:message key='listSocialSecurityStatementsGongJin0089'/><fmt:message key='listSocialSecurityStatementsGongJin0036'/>");
                               return;
                           }else{
                               $id("celllist1").loadData();
                               $id("celllist1").refresh();
                           }
                       }else{
                           $id("celllist1").loadData();
                           $id("celllist1").refresh();
                       }
                   }
                });*/
              
          }
               
       
    }
    
    
    function exportEXCEL_onClick(exportAll){
        var security_group_id = document.form.security_group_id.value;
        var report_type_bd = document.form.report_type_bd.value;
        var fund_month = document.form.fund_month1.value;
        var social_unit_id = document.form.social_unit_id.value;
        var cust_id = document.form.cust_id.value;
        var user_namek = document.form.user_name1.value;   //  <fmt:message key='listSocialSecurityStatementsGongJin0042'/>
        var user_namez= document.form.user_name3.value;   //  <fmt:message key='listSocialSecurityStatementsGongJin0043'/>
        var role_type = "";;////<fmt:message key='listSocialSecurityStatementsGongJin0044'/><fmt:message key='listSocialSecurityStatementsGongJin0045'/>类型：1<fmt:message key='listSocialSecurityStatementsGongJin0044'/>2<fmt:message key='listSocialSecurityStatementsGongJin0045'/>  
        //获取<fmt:message key='listSocialSecurityStatementsGongJin0043'/>为<fmt:message key='listSocialSecurityStatementsGongJin0045'/><fmt:message key='listSocialSecurityStatementsGongJin0043'/>or<fmt:message key='listSocialSecurityStatementsGongJin0046'/>
        var provident_fund_account = document.form.provident_fund_account.value;//公积金帐号
        var rpt_month = document.form.fund_month1.value;//报表月
        var pay_end_month = document.form.pay_end_month.value;//末次缴交月
        if(rpt_month > pay_end_month){
            if(!confirm("您目前此客户的报表月大于末次缴交月，请问是否继续导出报表？"))
	            //alert("请您再次确认,谢谢");
	           return false;
	        //else{
	            //alert("您已取消导出!");
	            //return false;
	         //}
        }
        var myAjax = new Ajax("<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=queryGroupType");
        myAjax.addParam("security_group_id", security_group_id);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
            role_type=myAjax.getProperty("returnValue");//1<fmt:message key='listSocialSecurityStatementsGongJin0044'/>2<fmt:message key='listSocialSecurityStatementsGongJin0045'/>         
         }
        
        var selectIndex = document.getElementById("security_group_id").selectedIndex;//获得<fmt:message key='listSocialSecurityStatementsGongJin0097'/>第几个被选中了
        var selectText = document.getElementById("security_group_id").options[selectIndex].text //获得被选中的项目的文本
  //       var transact_date_from = document.form.transact_date_from.value;
   //      var transact_date_to = document.form.transact_date_to.value;
        var rpt_create_id="";
        var row=$id("celllist1").activeRow;
        if(row !=null){
            var entCur=$id("celllist1").getEntity(row);
            rpt_create_id = entCur.getProperty("rpt_create_id");//已经支付过的<fmt:message key='listSocialSecurityStatementsGongJin0077'/>批次号        
        }
   
        if(security_group_id==null || security_group_id==""){
            alert("<fmt:message key='listSocialSecurityStatementsGongJin0049'/>");
            return;
        }
        if(report_type_bd==null || report_type_bd==""){
            alert("<fmt:message key='listSocialSecurityStatementsGongJin0050'/>");
            return;
        }
        
    /*     
      if(cust_id==null || cust_id==""){
            alert("<fmt:message key='listSocialSecurityStatementsGongJin0088'/>不能为空<fmt:message key='listSocialSecurityStatementsGongJin0036'/>");
            return;
        }
   */      
        
        
        if(fund_month ==null || fund_month == ""){
           alert("<fmt:message key='listSocialSecurityStatementsGongJin0032'/>");
           return;
        }else{
           if(fund_month.length != 6){
               alert("<fmt:message key='listSocialSecurityStatementsGongJin0030'/>");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listSocialSecurityStatementsGongJin0031'/>");
               return;
           }
        }
        var lastmonth=getlastmonth(fund_month);
        if(social_unit_id==null || social_unit_id==""){
            alert("<fmt:message key='listSocialSecurityStatementsGongJin0000'/><fmt:message key='listSocialSecurityStatementsGongJin0086'/><fmt:message key='listSocialSecurityStatementsGongJin0036'/>");
            return;
        }else{
        
        //魏佳新增，限制目前只能每月明细，变更清册，补缴清册可以使用客户公积金帐号导出报表其他类型报表暂时不能使用
        //待后续开发后去掉此限制
        if((report_type_bd!="12" && report_type_bd != "9" && report_type_bd != "8") && (provident_fund_account != null && provident_fund_account != "")){
            alert("目前仅每月明细，变更清册，补缴清册可以使用客户公积金帐号导出报表，其他报表暂不能使用此功能！");
            return;
        }
        
        var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBdG&ids="+social_unit_id+"&security_group_id="+security_group_id+"&fund_month="+fund_month+"&cust_id="+cust_id+"&date="+new Date();
      
            jQuery.post(url,function(data){
                if(data){
                var customer_name=data.customer_name;
                var accounts=data.accounts;
                var count=data.count;
                var isIndieBd=data.isIndieBd
                
                      if(data.isIndieBd==1){
                        if((cust_id==null || cust_id=="") && !exportAll){
                            if(provident_fund_account == null || provident_fund_account == ""){
                                alert("<fmt:message key='listSocialSecurityStatementsGongJin0041'/>");
                                return;
                            }
                          }else{
                            if(provident_fund_account != null && provident_fund_account != ""){
                                var checkFlag = checkGjjAccount(security_group_id,social_unit_id,provident_fund_account,cust_id);
                                if(!checkFlag){
                                    return;
                                }
                            }
                            rpt_create_id="";
                          }
                       }
                        var url1=null;
                        /***add by lvj***/
                         var title="";
                         if(security_group_id=="1099110700000000155"){
                            title="0";
                         }else if(security_group_id=="1099110700000000156"){
                            title="1";
                         }
                         /*****end*****/
                        var ispage = jQuery("input[name='ispage']:checked").val();
                                            if(report_type_bd==1){  //基本汇缴书补缴  REPORTBUCHONGHUJIAOBU
                                               url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=buchonghujiaobu.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&title="+title+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                            //    $id("datacell_formid").submit();
                                            }else if(report_type_bd==2){   //补充转移通知书 REPORTBUZHUAN
                                             url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=buzhuan.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&title=1&customer_name="+customer_name+"&accounts="+accounts+"&isIndieBd="+isIndieBd+"&rpt_create_id="+rpt_create_id;
                                           //     $id("datacell_formid").submit();
                                            }else if(report_type_bd==3){  //  基本汇缴书汇缴 REPORTBUCHONGHUJIAO
                                                url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=buchonghujiao.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&title="+title+"&customer_name="+customer_name+"&accounts="+accounts+"&ispay="+data.count+"&rpt_create_id="+rpt_create_id;
                                           //     $id("datacell_formid").submit();
                                            }else if(report_type_bd==4){  //基本转移通知书 REPORTBUZHUAN
                                               url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=buzhuan.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&title="+encodeURIComponent("上海市<fmt:message key='listSocialSecurityStatementsGongJin0045'/>转移通知书")+"&customer_name="+customer_name+"&accounts="+accounts+"&isIndieBd="+isIndieBd+"&rpt_create_id="+rpt_create_id;
                                             //   $id("datacell_formid").submit();
                                            }else if(report_type_bd==5){  //上海市补充住房公积金补缴清册 REPORTZHUFANGBUCE
                                                if(ispage=='1'){//导出excel分页
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=buzhufanggbuce.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+"&arg10="+provident_fund_account+user_namek+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                                }else{
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=buzhufanggbuce-8588.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                                
                                                }
                                             //   $id("datacell_formid").submit();
                                            }else if(report_type_bd==6){  //上海市补充住房公积金汇缴变更清册RPT_BIANGENGQINGCE
                                                if(ispage=='1'){//导出excel分页
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=buzhufanggbc.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                                }else{
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=buzhufanggbc-8588.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                                
                                                }
                                               // $id("datacell_formid").submit();
                                            }else if(report_type_bd==7){  //上海市住房公积金(补充住房公积金)集中封存清册  RPT_FENGCUN
                                               if(ispage=='1'){//导出excel分页
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=zhufangfengc.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&lastmonth="+lastmonth+"&rpt_create_id="+rpt_create_id;
                                               }else{
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=zhufangfengc-8588.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&lastmonth="+lastmonth+"&rpt_create_id="+rpt_create_id;
                                               
                                               }
                                             //   $id("datacell_formid").submit();
                                            }else if(report_type_bd==8){  //上海市住房公积金补缴清册 REPORTZHUFANGBUCE
                                                if(ispage=='1'){//导出excel分页
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=zhufanggbuce.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                                }else{
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=zhufanggbuce-8588.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                                
                                                }
                                            //    $id("datacell_formid").submit();
                                            }else if(report_type_bd==9){  //上海市住房公积金汇缴变更清册 RPT_BIANGENGQINGCE
                                               if(ispage=='1'){//<fmt:message key='listSocialSecurityStatementsGongJin0095'/>excel<fmt:message key='listSocialSecurityStatementsGongJin0069'/>
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=report_ghbq1.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                               }else{
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReportGongJin.jsp?raq=report_ghbq1-8588.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&customer_name="+customer_name+"&accounts="+accounts+"&rpt_create_id="+rpt_create_id;
                                               
                                               }
                                              //  $id("datacell_formid").submit();
                                            }else if(report_type_bd==10){   //新进名单
                                               url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showgongjijin.jsp?raq=report_social_security_newlist.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&title="+selectText+"&role_type="+role_type+"&rpt_create_id="+rpt_create_id;
                                            //    $id("datacell_formid").submit();
                                            }else if(report_type_bd==11){   //停缴名单
                                                url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showgongjijin.jsp?raq=report_stop.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&rpt_create_id="+rpt_create_id+"&role_type="+role_type+"&title="+encodeURIComponent(selectText);
                                               //  $id("datacell_formid").submit();
                                            }else if(report_type_bd==12){ //公积金每月明细
                                               url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showgongjijin.jsp?raq=report_social_security_moth_detailg.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&arg10="+provident_fund_account+"&rpt_create_id="+rpt_create_id+"&role_type="+role_type+"&title="+encodeURIComponent(selectText);
                                               //url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_moth_detail.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&rpt_create_id="+rpt_create_id+"&role_type="+role_type+"&title="+encodeURIComponent(selectText);
                                             
                                            }
                                                window.open(url1,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
                }
             });
        }
    }
    
    
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         if(data == undefined) return;
         document.form.cust_id.value=data[0];
         document.form.cust_name1.value=data[2];
         loadData();
    }
    
     function rtnFuncCustomer(arg){
            var lookup = $id("cust_name1");
            lookup.value = arg[0];
            lookup.displayValue = arg[2];
            document.form.cust_id.value=arg[0];
            var security_group_id = document.form.security_group_id.value;
            getfundmonth();
            //reloadAlldate(security_group_id);
            return false;
        }
        
     function clearId(){
        var lookup = $id("cust_name1");
        lookup.value = '';
        lookup.setDisplayValue('');
        document.form.cust_id.value='';
        var security_group_id = document.form.security_group_id.value;
        reloadAlldate(security_group_id);
     }
        
 function addAt(selectCtl,optionValue,optionText,position)
{
    var userAgent = window.navigator.userAgent;
    if (userAgent.indexOf("MSIE") > 0) {
        var option = document.createElement("option");
        option.innerText = optionValue;
        option.value = optionText;
        selectCtl.insertBefore(option, selectCtl.options[position]);
    }else{
        selectCtl.insertBefore(new Option(optionValue, optionText), selectCtl.options[position]);
    }
}

function getlastmonth(funmonth){
		var year=funmonth.substring(0,4);
		var month=parseFloat(funmonth.substring(4,6));
		if(month==1){
		    year=year-1;
		    month=12;
		}else{
		 month=month-1;
		 if(month<10){
		 month="0"+month;
		 }
		}
		return ''+year+month;
}

//只有几个清册的<fmt:message key='listSocialSecurityStatementsGongJin0077'/>才需要选择<fmt:message key='listSocialSecurityStatementsGongJin0069'/>和不<fmt:message key='listSocialSecurityStatementsGongJin0069'/>
function ispagecheck(){
    var report_type_bd = jQuery("#report_type_bd").val();
    if(report_type_bd=='5'||report_type_bd=='6'||report_type_bd=='7'||report_type_bd=='8'||report_type_bd=='9' ){
        jQuery("input[name='ispage']").removeAttr("disabled");
    }else{
        jQuery("input[name='ispage'][value='0']").attr("checked",true); 
        jQuery("input[name='ispage']").attr("disabled","disabled");
    }

}
</script>
    </head>
    <body>

<form name="form" method="post" id="datacell_formid">

    <div id="right">
    <script language="javascript">
       writeTableTopFesco('<fmt:message key='listSocialSecurityStatementsGongJin0045'/><fmt:message key='listSocialSecurityStatementsGongJin0077'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_s">


    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><fmt:message key='listSocialSecurityStatementsGongJin0077'/></div>
            <!--<fmt:message key='listSocialSecurityStatementsGongJin0078'/>1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementsGongJin0044'/>/<fmt:message key='listSocialSecurityStatementsGongJin0045'/>组</td>
                    <td class="td_2">
                       <select id="security_group_id" name="security_group_id" onchange="javascript:loadData1();">
                          <option value=""><fmt:message key='listSocialSecurityStatementsGongJin0000'/></option>
                          <option value="1099110700000000155"><fmt:message key='listSocialSecurityStatementsGongJin0080'/></option>
                          <option value="1099110700000000156"><fmt:message key='listSocialSecurityStatementsGongJin0081'/></option>
                       </select>
                    </td>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementsGongJin0082'/></td>
                    <td class="td_2">
                  
                    <select  id="report_type_bd"  name="report_type_bd" onchange="ispagecheck();">
                     <option value=""><fmt:message key='listSocialSecurityStatementsGongJin0000'/></option>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementsGongJin0084'/></td>
                    <td class="td_2"><input type="text" class="text_field" id="fund_month1" name="fund_month1" inputName="<fmt:message key='listSocialSecurityStatementsGongJin0084'/>" maxLength="6" onblur="javascript:loadData();" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" val/></td>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementsGongJin0086'/></td>
                    <td class="td_2">
                     <r:comboSelect   name="social_unit_id"  id="com1"  
			                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
			                textField="hire_unit_short_name" 
			                valueField="id" 
			                xpath="SocialunitVo"
			                messagekey='listSocialSecurityStatementsGongJin0000'
			                value="<%=social_unit_id %>"
			                width="205px"  onChangeFunc="loadData2"  >
			          </r:comboSelect> 
                    <input type="hidden" name="is_oneoff" id="is_oneoff" value="">
                    </td>
                </tr>
                <tr>
                     <td class="td_1"><font style="color: red">末次缴交月</font></td>
                    <td class="td_2">
                         <input type="text" class="text_field" id="pay_end_month" name="pay_end_month" readonly="false"/>
                    </td>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementsGongJin0043'/></td>
                    <td class="td_2">
                       <r:comboSelect id="combo_cs1" name="user_name3"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000103"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey='listSocialSecurityStatementsGongJin0000'
                        />
                    </td>
                </tr>
                <tr>
                   <td class="td_1"><fmt:message key='listSocialSecurityStatementsGongJin0088'/></td>
                    <td class="td_2">
                       <input type="hidden" name="cust_id" id="cust_id" value="">
                           <w:lookup onReturnFunc="rtnFuncCustomer" id="cust_name1" name="cust_name1"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="listSocialSecurityStatementsGongJin0089" height="440" width="600" ondblclick="clearId();"  style="width:170px"/><font color="red"><fmt:message key='listSocialSecurityStatementsGongJin0090'/></font>
                    </td>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementsGongJin0095'/>excel<fmt:message key='listSocialSecurityStatementsGongJin0097'/><fmt:message key='listSocialSecurityStatementsGongJin0098'/><fmt:message key='listSocialSecurityStatementsGongJin0069'/><fmt:message key='listSocialSecurityStatementsGongJin0100'/></td>
                    <td class="td_2">
                        <input type="radio" name="ispage" value="1"/><fmt:message key='listSocialSecurityStatementsGongJin0097'/>
                        <input type="radio" name="ispage" value="0" checked/><fmt:message key='listSocialSecurityStatementsGongJin0098'/>
                    </td>
                </tr>
                <tr>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementsGongJin0093'/></td>
                    <td class="td_2">
                    <r:comboSelect id="combo_cs" name="user_name1"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey='listSocialSecurityStatementsGongJin0000' />
                    
                    
                    </td>
                   <td class="td_1"><!--  公积金帐号--> </td>
					<td class="td_2">
					   <input type="hidden" class="text_field" id="provident_fund_account" name="provident_fund_account" inputName="公积金帐号"/>     
					</td>
                </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  <au:authorityBtn code="gjjbb_exp" type="1"/>  onClick="exportEXCEL_onClick(false);"><fmt:message key='listSocialSecurityStatementsGongJin0095'/><fmt:message key='listSocialSecurityStatementsGongJin0077'/></a>
                 <a class="foot_icon_3"  <au:authorityBtn code="gjjbb_expall" type="1"/>  onClick="exportEXCEL_onClick(true);"><fmt:message key='listSocialSecurityStatementsGongJin0095'/><fmt:message key='listSocialSecurityStatementsGongJin0101'/></a>
                 <!--<a class="foot_icon_3"  onClick="javascript:exportPDF_onClick();">PDF<fmt:message key='listSocialSecurityStatementsGongJin0077'/></a>
                 <a class="foot_icon_3"  onClick="javascript:exportWORD_onClick();">Word<fmt:message key='listSocialSecurityStatementsGongJin0077'/></a>-->
            </div>
            <!--<fmt:message key='listSocialSecurityStatementsGongJin0078'/>1 end--></div>
            </td>
        </tr>
    </table>
    
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><LABEL><fmt:message key='listSocialSecurityStatementsGongJin0103'/></LABEL></div>
            <div style="padding: 8 10 8 8;">
            <r:datacell 
                id="celllist1"
                queryAction="/FAERP/CsssrptinfoAction.do?cmd=queryStatementsLockData"
                width="99%"
                height="305px" 
                xpath="CsssrptinfoVo"
                paramFormId="datacell_formid"
                readonly="true"
                >
        
              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
               <r:field fieldName="batch" messagekey='listSocialSecurityStatementsGongJin0104' width="50px" onRefreshFunc="setCheckboxStatus" align="center">
              </r:field>
              <r:field fieldName="rpt_create_id" messagekey="listSocialSecurityStatementsGongJin0105" width="160">
                <h:text/>
              </r:field>
              <r:field fieldName="group_name" messagekey="listSocialSecurityStatementsGongJin0106" width="130">
                <h:text/>
              </r:field>
              <r:field fieldName="rpt_month" messagekey='listSocialSecurityStatementsGongJin0084' width="120">
                <h:text/>
              </r:field>
              <r:field fieldName="hire_unit_real_name" messagekey='listSocialSecurityStatementsGongJin0086' width="150">
                <h:text/>
              </r:field>
              <r:field fieldName="customer_name" messagekey='listSocialSecurityStatementsGongJin0088' width="200">
                <h:text/>
              </r:field>
              <r:field fieldName="input_date" messagekey='listSocialSecurityStatementsGongJin0110' width="130">
                <w:date format="yyyy-MM-dd" name=""/>
              </r:field>
              <r:field fieldName="input_user_name" messagekey='listSocialSecurityStatementsGongJin0111' width="130">
                <h:text/>
              </r:field>
            </r:datacell>
            </div>
            </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</fmt:bundle>

<script type="text/javascript">
        //邓鹏添加
     var isQuery= <%=isQuery%>;
    var security_group_id='<%=security_group_id%>';
    var social_unit_id='<%=social_unit_id%>';
    var cust_name='<%=cust_name%>';
    var cust_id='<%=cust_id%>';
    var report_month='<%=report_month%>';
    if(isQuery)
    {
         if(security_group_id=='1099110700000000155')
        {
                document.getElementById("security_group_id").options[1].selected=true;
                loadData1();
        }
        else if(security_group_id=='1099110700000000156')
        {
                  document.getElementById("security_group_id").options[2].selected=true; 
                  loadData1();
        }
      $id("cust_name1_input").value= cust_name;
      $id("cust_id").value=cust_id;
      if(report_month!=null && report_month!=''){
        $id("fund_month1").value= report_month;
      }
    }
    
    //魏佳新增---根据输入的社保组id，福利办理方id，客户id，客户公积金帐号，验证输入的客户公积金帐号是否与选择的客户是否相符
    function checkGjjAccount(security_group_id,social_unit_id,com_accounts,cust_id){
        var flag = true;
        jQuery.ajax({
            url: "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkGjjAccount&security_group_id="+security_group_id+"&social_unit_id="+social_unit_id+"&com_accounts="+com_accounts+"&cust_id="+cust_id,
            type: 'post',
            dataType: 'html',
            async: false,
            timeout: 10000,
            error: function(){
            alert('Error loading XML document');
                return  null;
            },
            success: function(text){
               if(text == "0"){
                  alert("输入的客户公积金帐号与选择的客户不相符！");
                  flag = false;
               }
            }
        });
        return flag;
    }
    
</script>
</html>