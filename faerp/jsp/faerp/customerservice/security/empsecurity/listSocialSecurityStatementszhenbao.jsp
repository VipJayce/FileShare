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
    <fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listSocialSecurityStatementszhenbao_resource' prefix='auto.'>
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
    
    function loadData(){
       var security_group_id = document.form.security_group_id.value;
       var fund_month = document.form.fund_month1.value;
       var social_unit_id = document.form.social_unit_id.value;
       var cust_id = document.form.cust_id.value;
       if(security_group_id!=null&&security_group_id!=""&&fund_month!=null&&fund_month!=""&&social_unit_id!=null&&social_unit_id!=""){
           if(fund_month.length != 6){
               alert("<fmt:message key='listSocialSecurityStatementszhenbao0028'/>月条件必须为6<fmt:message key='listSocialSecurityStatementszhenbao0001'/>,<fmt:message key='listSocialSecurityStatementszhenbao0002'/>“201203”<fmt:message key='listSocialSecurityStatementszhenbao0003'/>");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("请正确输入<fmt:message key='listSocialSecurityStatementszhenbao0028'/>月查询条件，年份在2000~2030<fmt:message key='listSocialSecurityStatementszhenbao0005'/>01~12<fmt:message key='listSocialSecurityStatementszhenbao0006'/>“201203”<fmt:message key='listSocialSecurityStatementszhenbao0003'/>");
               return;
           }
           var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids="+social_unit_id;
            jQuery.post(url,function(data){
                if(data){
                    if(data.isIndieBd==1){
                        if(cust_id==null || cust_id==""){
                            alert("<fmt:message key='listSocialSecurityStatementszhenbao0008'/>");
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
             });
           
       }
    }
    
    function exportEXCEL_onClick(){
        var security_group_id = document.form.security_group_id.value;
        var report_type_bd = document.form.report_type_bd.value;
        var fund_month = document.form.fund_month1.value;
        var social_unit_id = document.form.social_unit_id.value;
        var cust_id = document.form.cust_id.value;
        
        var user_namek = document.form.user_name1.value;   //  <fmt:message key='listSocialSecurityStatementszhenbao0009'/>
        var user_namez= document.form.user_name3.value;   //  <fmt:message key='listSocialSecurityStatementszhenbao0010'/>
        
   //      var transact_date_from = document.form.transact_date_from.value;
 //        var transact_date_to = document.form.transact_date_to.value;
        if(security_group_id==null || security_group_id==""){
            alert("<fmt:message key='listSocialSecurityStatementszhenbao0031'/><fmt:message key='listSocialSecurityStatementszhenbao0030'/><fmt:message key='listSocialSecurityStatementszhenbao0003'/>");
            return;
        }
        if(report_type_bd==null || report_type_bd==""){
            alert("<fmt:message key='listSocialSecurityStatementszhenbao0031'/><fmt:message key='listSocialSecurityStatementszhenbao0028'/>类型<fmt:message key='listSocialSecurityStatementszhenbao0003'/>");
            return;
        }
        if(fund_month ==null || fund_month == ""){
           alert("请填写<fmt:message key='listSocialSecurityStatementszhenbao0028'/>月,<fmt:message key='listSocialSecurityStatementszhenbao0002'/>“201203”<fmt:message key='listSocialSecurityStatementszhenbao0003'/>");
           return;
        }else{
           if(fund_month.length != 6){
               alert("<fmt:message key='listSocialSecurityStatementszhenbao0028'/>月条件必须为6<fmt:message key='listSocialSecurityStatementszhenbao0001'/>,<fmt:message key='listSocialSecurityStatementszhenbao0002'/>“201203”<fmt:message key='listSocialSecurityStatementszhenbao0003'/>");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("请正确输入<fmt:message key='listSocialSecurityStatementszhenbao0028'/>月查询条件，年份在2000~2030<fmt:message key='listSocialSecurityStatementszhenbao0005'/>01~12<fmt:message key='listSocialSecurityStatementszhenbao0006'/>“201203”<fmt:message key='listSocialSecurityStatementszhenbao0003'/>");
               return;
           }
        }
        if(social_unit_id==null || social_unit_id==""){
            alert("<fmt:message key='listSocialSecurityStatementszhenbao0024'/>");
            return;
        }else{
            var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids="+social_unit_id+"&security_group_id="+security_group_id+"&fund_month="+fund_month+"&cust_id="+cust_id;
            jQuery.post(url,function(data){
                if(data){
                    if(data.isIndieBd==1){
                        if(cust_id==null || cust_id==""){
                            alert("<fmt:message key='listSocialSecurityStatementszhenbao0008'/>");
                            return;
                        }else{
                          //社保数据
                            var url1=null;
                                            if(report_type_bd==1){  //新进名单
                                               url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_newlist.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                                //$id("datacell_formid").submit();
                                            }else if(report_type_bd==3){   //正常缴费
                                                url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_unremittedlist.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                                //$id("datacell_formid").submit();
                                            }else if(report_type_bd==4){  //  <fmt:message key='listSocialSecurityStatementszhenbao0026'/>
                                                url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_universal_details.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                               // $id("datacell_formid").submit();
                                            }else if(report_type_bd==6){  //社保每月明细
                                                url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_moth_detail.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                               // $id("datacell_formid").submit();
                                            }else if(report_type_bd==2){  //停缴名单
                                                url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_stop.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                               // $id("datacell_formid").submit();
                                            }
                                            window.open(url1,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
                        }
                    }else{
                              //社保数据
                              var url1=null;
                                                if(report_type_bd==1){
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_newlist.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                                    //$id("datacell_formid").submit();
                                                }else if(report_type_bd==3){
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_unremittedlist.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                                    //$id("datacell_formid").submit();
                                                }else if(report_type_bd==4){
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_universal_details.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                                    //$id("datacell_formid").submit();
                                                }else if(report_type_bd==6){
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_moth_detail.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                                    //$id("datacell_formid").submit();
                                                 }else if(report_type_bd==2){  //停缴名单
                                                    url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_stop.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek;
                                                    //$id("datacell_formid").submit();
                                                }
                                                window.open(url1,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
                    }
                }
             });
        }
        
        //$id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportToEXCEL";
        //$id("datacell_formid").submit();
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
            return false;
        }

</script>
    </head>
    <body>

<form name="form" method="post" id="datacell_formid">

    <div id="right">
    <script language="javascript">
       writeTableTopFesco('镇保<fmt:message key='listSocialSecurityStatementszhenbao0028'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_s">


    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><fmt:message key='listSocialSecurityStatementszhenbao0028'/></div>
            <!--<fmt:message key='listSocialSecurityStatementszhenbao0029'/>1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementszhenbao0030'/></td>
                    <td class="td_2">
                       <select id="security_group_id" name="security_group_id" onchange="javascript:loadData();">
                          <option value="">--<fmt:message key='listSocialSecurityStatementszhenbao0031'/>--</option>
                          <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key='listSocialSecurityStatementszhenbao0032'/></option>
                       </select>
                    </td>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementszhenbao0028'/>类型</td>
                    <td class="td_2"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("report_type_bd", -1,"REPORT_TYPE_BD", "","", false)%></td>
                </tr>
                <tr>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementszhenbao0028'/>月</td>
                    <td class="td_2"><input type="text" class="text_field" name="fund_month1" inputName="<fmt:message key='listSocialSecurityStatementszhenbao0028'/>月" maxLength="6" onblur="javascript:loadData();" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementszhenbao0036'/></td>
                    <td class="td_2"><faerp:SoialunitSelectTag tagname="social_unit_id" beanname="social_unit_id" style="width:205px" onchange="javascript:loadData();"/></td>
                </tr>
                <tr>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementszhenbao0037'/></td>
                    <td class="td_2">
                       <input type="hidden" name="cust_id" id="cust_id" value="">
                           <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_name1" name="cust_name1"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="listSocialSecurityStatementszhenbao0038" height="440" width="600"  style="width:170px"/>
                            
                            
                    </td>
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementszhenbao0010'/></td>
                    <td class="td_2">
                <!-- 
                    <input type="text" class="text_field" name="user" inputName="<fmt:message key='listSocialSecurityStatementszhenbao0010'/>" maxLength="10" />
                
                 -->
                    
                       <r:comboSelect id="combo_cs1" name="user_name3"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000102"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText=''
                        />
                    
                    </td>
                </tr>
                <tr>
                
                    <td class="td_1">负责<fmt:message key='listSocialSecurityStatementszhenbao0009'/></td>
                    <td class="td_2">
                
                <!-- 
                
                    <td class="td_1"><fmt:message key='listSocialSecurityStatementszhenbao0043'/></td>
                    <td class="td_2">
                       <w:date format="yyyy-MM-dd" name="transact_date_from" width="80px" property="writeBackFormValues/transact_date_from" onchange="javascript:loadData();"/>&nbsp;<fmt:message key='listSocialSecurityStatementszhenbao0044'/>&nbsp;<w:date format="yyyy-MM-dd" name="transact_date_to" width="80px" property="writeBackFormValues/transact_date_to" onchange="javascript:loadData();"/>
                    </td>
                
                    <input type="text" class="text_field" name="user_name1" inputName="<fmt:message key='listSocialSecurityStatementszhenbao0009'/>" maxLength="64" />
                 -->
                
                    <r:comboSelect id="combo_cs" name="user_name1"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText='' />
                    
                    
                    </td>
                    <td class="td_1"></td>
                    <td class="td_2">
                    </td>
                </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();">导出<fmt:message key='listSocialSecurityStatementszhenbao0028'/></a>
                 <!--<a class="foot_icon_3"  onClick="javascript:exportPDF_onClick();">PDF<fmt:message key='listSocialSecurityStatementszhenbao0028'/></a>
                 <a class="foot_icon_3"  onClick="javascript:exportWORD_onClick();">Word<fmt:message key='listSocialSecurityStatementszhenbao0028'/></a>-->
            </div>
            <!--<fmt:message key='listSocialSecurityStatementszhenbao0029'/>1 end--></div>
            </td>
        </tr>
    </table>
    
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><LABEL><fmt:message key='listSocialSecurityStatementszhenbao0028'/>锁定记录</LABEL></div>
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
               <r:field fieldName="batch" messagekey='listSocialSecurityStatementszhenbao0052' width="50px" onRefreshFunc="setCheckboxStatus" align="center">
              </r:field>
              <r:field fieldName="cs_ss_rpt_info_id" messagekey='listSocialSecurityStatementszhenbao0053' width="160">
                <h:text/>
              </r:field>
              <r:field fieldName="group_name" messagekey='listSocialSecurityStatementszhenbao0030' width="130">
                <h:text/>
              </r:field>
              <r:field fieldName="rpt_month" label="<fmt:message key='listSocialSecurityStatementszhenbao0028'/>月" width="120">
                <h:text/>
              </r:field>
              <r:field fieldName="hire_unit_real_name" messagekey='listSocialSecurityStatementszhenbao0036' width="150">
                <h:text/>
              </r:field>
              <r:field fieldName="customer_name" messagekey='listSocialSecurityStatementszhenbao0037' width="200">
                <h:text/>
              </r:field>
              <r:field fieldName="input_date" messagekey='listSocialSecurityStatementszhenbao0058' width="130">
                <w:date format="yyyy-MM-dd" name=""/>
              </r:field>
              <r:field fieldName="input_user_name" messagekey='listSocialSecurityStatementszhenbao0059' width="130">
                <h:text/>
              </r:field>
            </r:datacell>
            </div>
            </div>
            </td>
        </tr>
    </table>
    </form>
</fmt:bundle>
</body>
</fmt:bundle>
</html>
