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
	    String city_id= request.getParameter("city_id");
	    if(city_id==null || city_id.equals("")){
	        request.setAttribute("city_id","1099110100000000357");
	    }else{
	        request.setAttribute("city_id",city_id);
	    }
	    String security_group_id= request.getParameter("security_group_id");
	    if(security_group_id==null || security_group_id.equals("")){
	        request.setAttribute("security_group_id","1099110700000000203");
	    }else{
	        request.setAttribute("security_group_id",security_group_id);
	    }
        String social_unit_id= request.getParameter("social_unit_id");
        String cust_name= request.getParameter("customer_name");
        String cust_id= request.getParameter("cust_id");
        String report_month= request.getParameter("report_month");
        if(report_month==null || report_month.equals("null") || report_month.equals("undefined")){
            report_month = "";
        }
        String  isQuery = request.getParameter("isQuery")==null?"false":request.getParameter("isQuery");
    %>
    <fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
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
    
    //报表月有变化，重新查询列表
    function loadData(){
            var security_group_id = document.form.security_group_id.value;
            reloadAlldate(security_group_id);
       
       }
       
       
    
    //社保公积金组有变化，需要自动计算报表月的变更情况
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
        //     addAt(report_type_bd,"请选择","-1",1);
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
    //        addAt(report_type_bd,"请选择","-1",1);
             addAt(report_type_bd,"基本汇缴书(补缴)","1",1);
             addAt(report_type_bd,"基本汇缴书(汇缴)","3",1);
             addAt(report_type_bd,"补充转移通知书","2",1);
             
             
              addAt(report_type_bd,"补充住房公积金补缴清册","5",1);
            addAt(report_type_bd,"补充住房公积金汇缴变更清册","6",1);
       //      addAt(report_type_bd,"上海市补充住房公积金汇缴清册","6",1);
             
             
             addAt(report_type_bd,"住房公积金(补充住房公积金)集中封存清册","7",1);
             addAt(report_type_bd,"新进名单","10",1);
             addAt(report_type_bd,"停缴名单","11",1);
             addAt(report_type_bd,"公积金每月明细","12",1);
          }
     //      alert(type);
       document.getElementById("report_type_bd").value=type;
       
       //根据组id计算得到报表月(陈小佩20130205)
       loadData2();
       
    }
    
    //福利办理方有变化，需要自动计算报表月的变更情况
    function loadData2(){
       var security_group_id = document.form.security_group_id.value;
       var social_unit_id = document.form.social_unit_id.value;
       var report_month='<%=report_month%>';
       var fund_month = document.form.fund_month1.value;
       //如果报表月的值时由管理页面传递过来的，则不做联动变化
       if(report_month!=null && report_month!='' && fund_month==report_month){
          //$id("fund_month1").value= report_month;
       }else{
	       //根据组id计算得到报表月(陈小佩20130205)
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
	                           document.form.fund_month1.value=text;//回设报表月
	                       }
	                       reloadAlldate(security_group_id);
	                   }
	           });
	       }
       }
    }
    
    //根据条件重新查询列表
    function reloadAlldate(security_group_id){
          var fund_month = document.form.fund_month1.value;
          var social_unit_id = document.form.social_unit_id.value;
          var cust_id = document.form.cust_id.value;
          if(security_group_id!=null&&security_group_id!=""&&fund_month!=null&&fund_month!=""&&social_unit_id!=null&&social_unit_id!=""){
              if(fund_month.length != 6){
                  alert("报表月条件必须为6位数字,如“201203”！");
                  return;
              }
              var year = fund_month.substring(0,4);
              var month = fund_month.substring(4,6);
              if(year<2000 || year>2030 || month<1 || month>12){
                  alert("请正确输入报表月查询条件，年份在2000~2030之间，月份在01~12之间，如“201203”！");
                  return;
              }
              var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids="+social_unit_id;
               jQuery.post(url,function(data){
                   if(data){
                       if(data.isIndieBd==1){
                           if(cust_id==null || cust_id==""){
                               alert("请选择客户！");
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
        var user_namek = document.form.user_name1.value;   //  客服
        var user_namez= document.form.user_name3.value;   //  专管员
        
<!--        var selectIndex = document.getElementById("security_group_id").selectedIndex;//获得是第几个被选中了-->
<!--        var selectText = document.getElementById("security_group_id").options[selectIndex].text //获得被选中的项目的文本-->

         var selectText =$id("group_List").getDisplayValue(security_group_id);
         
  //       var transact_date_from = document.form.transact_date_from.value;
   //      var transact_date_to = document.form.transact_date_to.value;
   
        if(security_group_id==null || security_group_id==""){
            alert("请选择社保组！");
            return;
        }
        if(report_type_bd==null || report_type_bd==""){
            alert("请选择报表类型！");
            return;
        }
        
    /*     
      if(cust_id==null || cust_id==""){
            alert("客户不能为空！");
            return;
        }
   */      
        
        
        if(fund_month ==null || fund_month == ""){
           alert("请填写报表月,如“201203”！");
           return;
        }else{
           if(fund_month.length != 6){
               alert("报表月条件必须为6位数字,如“201203”！");
               return;
           }
           var year = fund_month.substring(0,4);
           var month = fund_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("请正确输入报表月查询条件，年份在2000~2030之间，月份在01~12之间，如“201203”！");
               return;
           }
        }
        var lastmonth=getlastmonth(fund_month);
        if(social_unit_id==null || social_unit_id==""){
            alert("请选择福利办理方！");
            return;
        }else{
             //针对日期格式重新设计
            //当月12日18点
            var date1 = year+'-'+month+'-'+'12 18:00:00';
            //上月12日18点
            var date2 = minmonth(fund_month);
            //当月1日
            var date3 = year+'-'+month+'-'+'01';
            
            var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBdG&ids="+social_unit_id+"&security_group_id="+security_group_id+"&fund_month="+fund_month+"&cust_id="+cust_id+"&date="+new Date();
            jQuery.post(url,function(data){
                if(data){
                var customer_name=data.customer_name;
                var accounts=data.accounts;
                var count=data.count;
                var isIndieBd=data.isIndieBd
                
                      if(data.isIndieBd==1){
                        if(cust_id==null || cust_id==""){
                            alert("请选择客户！");
                            return;
                          }
                       }
                       	 var url1 = null;
                         if(report_type_bd==1){        //浙江外企德科省公积金网上申报
							 url1 =  "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZJgongjijin.jsp?raq=cpf_new_zj_net_report.raq&s_group="+security_group_id+"&yearmonth="+fund_month+"&cust_id="+cust_id+"&s_unit="+social_unit_id+"&date1="+date1+"&date2="+date2+"&date3="+date3;
				    	 }else if(report_type_bd==2){   //职工登记批量导入-市公积金  
					     	url1 =  "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZJgongjijin.jsp?raq=cpf_new_hz_bat.raq&s_group="+security_group_id+"&yearmonth="+fund_month+"&cust_id="+cust_id+"&s_unit="+social_unit_id+"&date1="+date1+"&date2="+date2+"&date3="+date3; 
				     	 }else if(report_type_bd==3){   //职工减少批量导入-市公积金
						 	url1 =  "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZJgongjijin.jsp?raq=cpf_reduce_hz_bat.raq&s_group="+security_group_id+"&yearmonth="+fund_month+"&cust_id="+cust_id+"&s_unit="+social_unit_id+"&date1="+date1+"&date2="+date2+"&date3="+date3;
					 	 }else if(report_type_bd==4){   //漏缴补缴批量导入-市公积金
					 		url1 =  "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZJgongjijin.jsp?raq=cpf_arrears_hz_bat_report.raq&s_group="+security_group_id+"&yearmonth="+fund_month+"&cust_id="+cust_id+"&s_unit="+social_unit_id+"&date1="+date1+"&date2="+date2+"&date3="+date3;
					 	 }
                     window.open(url1,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
                }
             });
        }
    }
    
    //取上个月的12号
    function minmonth(beginMonth){
        if(beginMonth=="") return "";
        var year1=beginMonth.substring(0,4);
        var month1=beginMonth.substring(4,6);
        
        var year = parseFloat(year1);
        var month = parseFloat(month1);
        var retYear,retMonth;
        if(month>1){
            retYear = year;
            retMonth = month-1;
        }else{
            retYear = year-1;
            retMonth = 12;
        }
        
        if(retMonth<10) retMonth="0"+retMonth;
        
        return retYear+"-"+retMonth+'-'+'12 18:00:00';
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
		var month=parseInt(funmonth.substring(4,6));
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

</script>
    </head>
    <body>

<form name="form" method="post" id="datacell_formid">

    <div id="right">
    <script language="javascript">
       writeTableTopFesco('杭州公积金报表','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_s">


    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title">报表</div>
            <!--表格1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                
              <td  class="td_1">
                 <p>城 市</p>
              </td>
              <td  class="td_2">
                        <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       value="${requestScope.city_id }"
                       nullText="请选择" 
                       />
              </td>
              <td  class="td_1">社保/公积金组&nbsp;</td>
              <td  class="td_2">
                     <r:comboSelect id="group_List" name="security_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=2"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="200px"
                       linkId="city_idList_search"
                       value="${requestScope.security_group_id }"
                       nullText="请选择" />
              </td>
            </tr>
            <tr>
                        
                    <td class="td_1">报表类型</td>
                    <td class="td_2">
                  		<r:comboSelect id="report_type_list" name="report_type_bd"
                               queryAction="/FAERP/EmppostAction.do?cmd=getReportListByZJGJJGroupId"
                               valueField="emp_code"
                               textField="emp_name"
                               xpath="EmployeeVo"
                               width="200px"
                               linkId="group_List"
                               nullText="请选择" />
                    </td>
                    <td class="td_1">报表月</td>
                    <td class="td_2"><input type="text" class="text_field" id="fund_month1" name="fund_month1" inputName="报表月" maxLength="6" onblur="javascript:loadData();" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td>
                 
                </tr>
                <tr>
                   <td class="td_1">福利办理方</td>
                    <td class="td_2">
                     <r:comboSelect   name="social_unit_id"  id="social_unit_id"  
                            queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                            textField="hire_unit_short_name" 
                            valueField="id" 
                            xpath="SocialunitVo"
                            nullText="--请选择--"
                            value="<%=social_unit_id %>"
                            width="205px"  onChangeFunc="loadData2"  >
                      </r:comboSelect> 
                    
                    </td>
                    <td class="td_1">客户</td>
                    <td class="td_2">
                       <input type="hidden" name="cust_id" id="cust_id" value="">
                           <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_name1" name="cust_name1"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            dialogTitle="选择客户" height="440" width="600"  style="width:170px"/>
                            
                            
                    </td>
                    
                </tr>
                <tr>
                    <td class="td_1">专管员</td>
                    <td class="td_2">
                       <r:comboSelect id="combo_cs1" name="user_name3"
                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=2013100700000000146"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText="请选择"
                        />
                    
                    </td>
                    <td class="td_1">负责客服</td>
                    <td class="td_2">
                    <r:comboSelect id="combo_cs" name="user_name1"
                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=2013100700000000148"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText="请选择" />
                    
                    
                    </td>
                </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  <au:authorityBtn code="gjjbb_exp" type="1"/>  onClick="exportEXCEL_onClick();">导出报表</a>
                 <!--<a class="foot_icon_3"  onClick="javascript:exportPDF_onClick();">PDF报表</a>
                 <a class="foot_icon_3"  onClick="javascript:exportWORD_onClick();">Word报表</a>-->
            </div>
            <!--表格1 end--></div>
            </td>
        </tr>
    </table>
    
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><LABEL>报表锁定记录</LABEL></div>
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
               <r:field fieldName="batch" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
              </r:field>
              <r:field fieldName="cs_ss_rpt_info_id" label="系统码" width="160">
                <h:text/>
              </r:field>
              <r:field fieldName="group_name" label="社保组" width="130">
                <h:text/>
              </r:field>
              <r:field fieldName="rpt_month" label="报表月" width="120">
                <h:text/>
              </r:field>
              <r:field fieldName="hire_unit_real_name" label="福利办理方" width="150">
                <h:text/>
              </r:field>
              <r:field fieldName="customer_name" label="客户" width="200">
                <h:text/>
              </r:field>
              <r:field fieldName="input_date" label="生成时间" width="130">
                <w:date format="yyyy-MM-dd" name=""/>
              </r:field>
              <r:field fieldName="input_user_name" label="生成人" width="130">
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

<script type="text/javascript">

</script>
</html>