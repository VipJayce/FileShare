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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<html>
<%
String user_id= RmJspHelper
.getParty_idFromRequest(request);
String user_name="";
LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
if(null!=loginVo){
    user_name=loginVo.getName();
}
String security_type =request.getParameter("security_type");
String group_type =request.getParameter("group_type");
//System.out.println("+++++++++++++++++++++++++++"+group_type);
%>
    <fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listSocialSecurityStatements_resource' prefix='auto.'>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
    
	function citySecurityGroupchange(seletvalue){

      var group_type = '<%=group_type%>';
      if(group_type=='1'){
      
            SecurityGroupAjax.getSecurityGroupbyCitys(seletvalue,'1',{callback:function(data){
                    setSelectForBean("security_group_id",data,"id","group_name","");
                }
            });
      }else if(group_type=='2'){
             SecurityGroupAjax.getSecurityGroupbyCitys(seletvalue,'2',{callback:function(data){
                    setSelectForBean("security_group_id",data,"id","group_name","");
                }
            });
      }
    }
    
    
	
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
               alert("<fmt:message key='listSocialSecurityStatements0000'/>,<fmt:message key='listSocialSecurityStatements0002'/><fmt:message key='listSocialSecurityStatements0003'/>");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listSocialSecurityStatements0040'/>");
               return;
           }
           $id("celllist1").loadData();
           $id("celllist1").refresh();
           /*
           var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids="+social_unit_id;
	        jQuery.post(url,function(data){
	            if(data){
	                if(data.isIndieBd==1){
	                    if(cust_id==null || cust_id==""){
                            alert("<fmt:message key='listSocialSecurityStatements0008'/>");
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
           */
	   }
	}
  	
    function exportEXCEL_onClick(exportAll){
        var security_group_id = document.form.security_group_id.value;//<fmt:message key='listSocialSecurityStatements0011'/>/<fmt:message key='listSocialSecurityStatements0012'/>组
        var report_type_bd = document.form.report_type_bd.value;//<fmt:message key='listSocialSecurityStatements0042'/>
        var fund_month = document.form.fund_month1.value;//<fmt:message key='listSocialSecurityStatements0043'/>
        var social_unit_id = document.form.social_unit_id.value;//<fmt:message key='listSocialSecurityStatements0045'/>
        var cust_id = document.form.cust_id.value;//<fmt:message key='listSocialSecurityStatements0047'/>ID
        var user_namek = document.form.user_name1.value;   //  <fmt:message key='listSocialSecurityStatements0009'/>
        var user_namez= document.form.user_name3.value;   //  <fmt:message key='listSocialSecurityStatements0010'/>
        var role_type = "";;////<fmt:message key='listSocialSecurityStatements0011'/><fmt:message key='listSocialSecurityStatements0012'/>类型：1<fmt:message key='listSocialSecurityStatements0011'/>2<fmt:message key='listSocialSecurityStatements0012'/>  
        //获取<fmt:message key='listSocialSecurityStatements0010'/>为<fmt:message key='listSocialSecurityStatements0012'/><fmt:message key='listSocialSecurityStatements0010'/>or<fmt:message key='listSocialSecurityStatements0013'/>
        var myAjax = new Ajax("<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=queryGroupType");
        myAjax.addParam("security_group_id", security_group_id);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
            role_type=myAjax.getProperty("returnValue");//1<fmt:message key='listSocialSecurityStatements0011'/>2<fmt:message key='listSocialSecurityStatements0012'/>         
         }
        var selectIndex = document.getElementById("security_group_id").selectedIndex;//获得是第几个被选中了
        var selectText = document.getElementById("security_group_id").options[selectIndex].text //获得被选中的项目的文本
        //选取活动行的批次号
        var rpt_create_id="";
        var row=$id("celllist1").activeRow;
        if(row !=null){
            var entCur=$id("celllist1").getEntity(row);
            rpt_create_id = entCur.getProperty("rpt_create_id");//已经支付过的<fmt:message key='listSocialSecurityStatements0063'/>        
        }
        if(security_group_id==null || security_group_id==""){
            alert("<fmt:message key='listSocialSecurityStatements0046'/><fmt:message key='listSocialSecurityStatements0064'/><fmt:message key='listSocialSecurityStatements0003'/>");
            return;
        }
        if(report_type_bd==null || report_type_bd==""){
            alert("<fmt:message key='listSocialSecurityStatements0017'/>");
            return;
        }
        if(fund_month ==null || fund_month == ""){
           alert("<fmt:message key='listSocialSecurityStatements0018'/>,<fmt:message key='listSocialSecurityStatements0002'/><fmt:message key='listSocialSecurityStatements0003'/>");
           return;
        }else{
           if(fund_month.length != 6){
               alert("<fmt:message key='listSocialSecurityStatements0000'/>,<fmt:message key='listSocialSecurityStatements0002'/><fmt:message key='listSocialSecurityStatements0003'/>");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='listSocialSecurityStatements0040'/>");
               return;
           }
        }
        if(social_unit_id==null || social_unit_id==""){
            alert("<fmt:message key='listSocialSecurityStatements0029'/>");
            return;
        }else{
            var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids="+social_unit_id+"&security_group_id="+security_group_id+"&fund_month="+fund_month+"&cust_id="+cust_id;
            jQuery.post(url,function(data){
                if(data){
                    if(data.isIndieBd==1){
                        if((cust_id==null || cust_id=="") && !exportAll){
                            alert("<fmt:message key='listSocialSecurityStatements0008'/>");
                            return;
                          }else{
                            rpt_create_id = "";
                          }
                       }
		                                        var  isIndieBd =data.isIndieBd  ;
		                                        var security_type =<%=security_type%> ;
		                                         var group_type =<%=group_type%> ;
		                                       var url1=null;
				                            if(report_type_bd==1){     //新进名单
				                            
							                          //       $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_newlist.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
							                          //       $id("datacell_formid").submit();
							                          
							                          if(security_type=='1'){ //<fmt:message key='listSocialSecurityStatements0032'/>
							                            url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_newlisted2.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
							                          }
							                            if(security_type=='2'){//<fmt:message key='listSocialSecurityStatements0033'/>
			                                             url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_newlisted2.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
			                                             
			                                          }
							                           if(security_type=='3'){ //<fmt:message key='listSocialSecurityStatements0034'/>
			                                             url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_newlisted2.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
			                                          }
			                                           if(group_type=='1'){   //异地<fmt:message key='listSocialSecurityStatements0011'/>
						                                      url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_newlisted.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+
						                                                            "&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText)+"&isIndieBd="+isIndieBd;
			                                          }
			                                           if(group_type=='2'){  //异地<fmt:message key='listSocialSecurityStatements0012'/>
			                                               url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_newlist.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
			                                          }
				                          
				                            }else if(report_type_bd==3){   //正常缴费
				                                
				                                   if(security_type=='1'){    //<fmt:message key='listSocialSecurityStatements0032'/>
                                                      url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_unremittedlisted.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                                     
                                                      }
                                                        if(security_type=='2'){   //<fmt:message key='listSocialSecurityStatements0033'/>
                                                        url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_unremittedlisted.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                                    
                                                      }
                                                       if(security_type=='3'){    //<fmt:message key='listSocialSecurityStatements0034'/>
                                                         url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_unremittedlisted.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                                    
                                                      }
                                                       if(group_type=='1'){    //异地<fmt:message key='listSocialSecurityStatements0011'/>
                                                            url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_unremittedlisted.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                                    
                                                      }
                                                       if(group_type=='2'){    //异地<fmt:message key='listSocialSecurityStatements0012'/>
                                                           url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_unremittedlist.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                                    
                                                      }
                                                      
				                            
				                                
				                            }else if(report_type_bd==4){  //  <fmt:message key='listSocialSecurityStatements0031'/>
				                            
				                                      if(security_type=='1'){    //<fmt:message key='listSocialSecurityStatements0032'/>
                                                       url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_universal_detailsed.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                             //    $id("datacell_formid").submit();
                                             
                                                      }
                                                        if(security_type=='2'){   //<fmt:message key='listSocialSecurityStatements0033'/>
                                                       url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_universal_detailsed.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                             //    $id("datacell_formid").submit();
                                                      }
                                                       if(security_type=='3'){    //<fmt:message key='listSocialSecurityStatements0034'/>
                                                           url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_universal_detailsed.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                             //    $id("datacell_formid").submit();
                                                      }
                                                       if(group_type=='1'){    //异地<fmt:message key='listSocialSecurityStatements0011'/>
                                                             url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_universal_detailsed.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                             //    $id("datacell_formid").submit();
                                                      }
                                                       if(group_type=='2'){    //异地<fmt:message key='listSocialSecurityStatements0012'/>
                                                             url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_universal_details.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                                              //    $id("datacell_formid").submit();
                                                      }
				                                    
				                             
				                            }
				                            
				                            else if(report_type_bd==6){  //<fmt:message key='listSocialSecurityStatements0011'/>每月明细
					                           url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_social_security_moth_detail.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&rpt_create_id="+rpt_create_id+"&role_type="+role_type+"&title="+encodeURIComponent(selectText);
					                         //   $id("datacell_formid").submit();
					                         ///alert(url1);
				                            }
				                            
				                            else if(report_type_bd==2){  //停缴名单
				                            
				                                         if(security_type=='1'){    //<fmt:message key='listSocialSecurityStatements0032'/>
                                                            url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_stoped.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                            //     $id("datacell_formid").submit();
                                             
                                                      }
                                                        if(security_type=='2'){   //<fmt:message key='listSocialSecurityStatements0033'/>
                                                           url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_stoped.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                            //     $id("datacell_formid").submit();
                                                      }
                                                       if(security_type=='3'){    //<fmt:message key='listSocialSecurityStatements0034'/>
                                                                url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_stoped.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                            //     $id("datacell_formid").submit();
                                                      }
                                                       if(group_type=='1'){    //异地<fmt:message key='listSocialSecurityStatements0011'/>
                                                                 url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_stoped.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                            //     $id("datacell_formid").submit();
                                                      }
                                                       if(group_type=='2'){    //异地<fmt:message key='listSocialSecurityStatements0012'/>
                                                                url1="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSocialSecurityReport.jsp?raq=report_stop.raq&arg1="+security_group_id+"&arg2="+fund_month+"&arg3="+social_unit_id+"&arg4="+cust_id+"&arg5="+report_type_bd+"&arg6="+"<%=user_id%>"+"&arg7=<%=user_name%>"+"&arg8="+user_namez+"&arg9="+user_namek+"&title="+encodeURIComponent(selectText);
                                            //     $id("datacell_formid").submit();
                                                      }
				                           
				                            }
				                               window.open(url1,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
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
            loadData();
            return false;
        }

</script>
	</head>
	<body>

<form name="form" method="post" id="datacell_formid">

	<div id="right">
	<script language="javascript">
	   
	       <c:choose>
                            <c:when test="${param.security_type=='1'}">
                               writeTableTopFesco('<fmt:message key='listSocialSecurityStatements0032'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                            <c:when test="${param.security_type=='2'}">
                                 writeTableTopFesco('<fmt:message key='listSocialSecurityStatements0033'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                            <c:when test="${param.security_type=='3'}">
                                 writeTableTopFesco('<fmt:message key='listSocialSecurityStatements0034'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                            <c:when test="${param.group_type=='1'}">
                                 writeTableTopFesco('<fmt:message key='listSocialSecurityStatements0035'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                             <c:when test="${param.group_type=='2'}">
                                 writeTableTopFesco('<fmt:message key='listSocialSecurityStatements0036'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                             
          </c:choose>
	</script>
	<div class="ringht_s">


	<table width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<div class="zbox">
			<div class="xz_title"><fmt:message key='listSocialSecurityStatements0037'/></div>
			<!--<fmt:message key='listSocialSecurityStatements0038'/>1-->
			<div class="box_3">
			<table width="100%" height="40" border="0" cellpadding="0"
				cellspacing="1" bgcolor="#c5dbe2">
				<tr>
					<td class="td_1"><fmt:message key='listSocialSecurityStatements0064'/>/<fmt:message key='listSocialSecurityStatements0012'/><fmt:message key='listSocialSecurityStatements0049'/></td>
					<td class="td_2">
					   <select id="security_group_id" name="security_group_id" onchange="javascript:loadData();">
						    <c:choose>
                            <c:when test="${param.security_type=='1'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listSocialSecurityStatements0039'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='2'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key='listSocialSecurityStatements0033'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='3'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key='listSocialSecurityStatements0034'/></option>
                            </c:when>
                        </c:choose>
					   </select>
					</td>
					<td class="td_1"><fmt:message key='listSocialSecurityStatements0042'/></td>
					<td class="td_2">
					  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("report_type_bd", -1,"REPORT_TYPE_BD",""," onchange='javascript:loadData();'  id=create_type_bd",false) %>
					</td>
				</tr>
				<tr>
					<td class="td_1"><fmt:message key='listSocialSecurityStatements0043'/></td>
					<td class="td_2"><input type="text" class="text_field" name="fund_month1" inputName="<fmt:message key='listSocialSecurityStatements0043'/>" maxLength="6" onblur="javascript:loadData();" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td>
					<td class="td_1"><fmt:message key='listSocialSecurityStatements0045'/></td>
					<td class="td_2">
						 <r:comboSelect   name="social_unit_id"  id="social_unit_id"
			                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
			                textField="hire_unit_short_name" 
			                valueField="id" 
			                xpath="SocialunitVo"
			                messagekey='listSocialSecurityStatements0046'
			                width="205px"  onChangeFunc="loadData"  >
			            </r:comboSelect> 
            
            
					
					</td>
				</tr>
				<tr>
					<td class="td_1"><fmt:message key='listSocialSecurityStatements0047'/></td>
					<td class="td_2">
					   <input type="hidden" name="cust_id" id="cust_id" value="">
					       <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_name1" name="cust_name1"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="listSocialSecurityStatements0048" height="440" width="600"  style="width:170px"/>
                            
                            
					</td>
					<td class="td_1"><fmt:message key='listSocialSecurityStatements0010'/></td>
					<td class="td_2">
				<!-- 
				    <input type="text" class="text_field" name="user" inputName="<fmt:message key='listSocialSecurityStatements0010'/>" maxLength="10" />
				
				 -->
					
                       <r:comboSelect id="combo_cs1" name="user_name3"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000102"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey='listSocialSecurityStatements0046'
                        />
					
					</td>
				</tr>
				<tr>
				
					<td class="td_1"><fmt:message key='listSocialSecurityStatements0052'/></td>
					<td class="td_2">
				
				<!-- 
				
				    <td class="td_1"><fmt:message key='listSocialSecurityStatements0053'/></td>
                    <td class="td_2">
                       <w:date format="yyyy-MM-dd" name="transact_date_from" width="80px" property="writeBackFormValues/transact_date_from" onchange="javascript:loadData();"/>&nbsp;<fmt:message key='listSocialSecurityStatements0054'/>&nbsp;<w:date format="yyyy-MM-dd" name="transact_date_to" width="80px" property="writeBackFormValues/transact_date_to" onchange="javascript:loadData();"/>
                    </td>
				
				    <input type="text" class="text_field" name="user_name1" inputName="<fmt:message key='listSocialSecurityStatements0009'/>" maxLength="64" />
				 -->
				
					<r:comboSelect id="combo_cs" name="user_name1"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey='listSocialSecurityStatements0046' />
					
					
					</td>
					<td class="td_1"></td>
                    <td class="td_2">
                    </td>
				</tr>
			</table>
			</div>
			<div class="foot_button">
			     <a class="foot_icon_3"  <au:authorityBtn code="sbbb_exp" type="1"/> onClick="exportEXCEL_onClick(false);"><fmt:message key='listSocialSecurityStatements0057'/></a>
			     <a class="foot_icon_3"  <au:authorityBtn code="sbbb_expall" type="1"/> onClick="exportEXCEL_onClick(true);"><fmt:message key='listSocialSecurityStatements0050'/></a>
			     <!--<a class="foot_icon_3"  onClick="javascript:exportPDF_onClick();">PDF<fmt:message key='listSocialSecurityStatements0037'/></a>
			     <a class="foot_icon_3"  onClick="javascript:exportWORD_onClick();">Word<fmt:message key='listSocialSecurityStatements0037'/></a>-->
			</div>
			<!--<fmt:message key='listSocialSecurityStatements0038'/>1 end--></div>
			</td>
		</tr>
	</table>
	
	<table width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<div class="zbox">
			<div class="xz_title"><LABEL><fmt:message key='listSocialSecurityStatements0061'/></LABEL></div>
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
		       <r:field fieldName="batch" messagekey='listSocialSecurityStatements0062' width="50px" onRefreshFunc="setCheckboxStatus" align="center">
		      </r:field>
		      <r:field fieldName="rpt_create_id" messagekey='listSocialSecurityStatements0063' width="160">
		        <h:text/>
		      </r:field>
		      <r:field fieldName="group_name" messagekey='listSocialSecurityStatements0064' width="130">
		        <h:text/>
		      </r:field>
		      <r:field fieldName="rpt_month" messagekey='listSocialSecurityStatements0043' width="120">
		        <h:text/>
		      </r:field>
		      <r:field fieldName="hire_unit_real_name" messagekey='listSocialSecurityStatements0045' width="150">
		        <h:text/>
		      </r:field>
		      <r:field fieldName="customer_name" messagekey='listSocialSecurityStatements0047' width="200">
		        <h:text/>
		      </r:field>
		      <r:field fieldName="input_date" messagekey='listSocialSecurityStatements0068' width="130">
		        <w:date format="yyyy-MM-dd" name=""/>
		      </r:field>
		      <r:field fieldName="input_user_name" messagekey='listSocialSecurityStatements0069' width="130">
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
<script type="text/javascript">
var security_type="<%=security_type%>";
if(security_type=="4"){
   citySecurityGroupchange("0571','0520"); 
}

</script>
