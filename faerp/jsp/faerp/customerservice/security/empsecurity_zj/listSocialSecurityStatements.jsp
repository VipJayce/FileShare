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
	String user_id = RmJspHelper.getParty_idFromRequest(request);
	String user_name = "";
	LoginSessionVo loginVo = (LoginSessionVo) request.getSession()
			.getAttribute("LOGIN_SESSION_VO");
	if (null != loginVo) {
		user_name = loginVo.getName();
	}
	String security_type = request.getParameter("security_type");
	String group_type = request.getParameter("group_type");
%>
    <fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
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
        
       // var user_namek = document.form.user_name1.value;   //  客服
       // var user_namez= document.form.user_name3.value;   //  专管员

<!--        var selectIndex = document.getElementById("security_group_id").selectedIndex;//获得是第几个被选中了-->

<!--        var selectText = document.getElementById("security_group_id").options[selectIndex].text //获得被选中的项目的文本-->

            var selectText =$id("group_List").getDisplayValue(security_group_id);
          
   //      var transact_date_from = document.form.transact_date_from.value;
 //        var transact_date_to = document.form.transact_date_to.value;
        if(security_group_id==null || security_group_id==""){
            alert("请选择社保组！");
            return;
        }
        if(report_type_bd==null || report_type_bd==""){
            alert("请选择报表类型！");
            return;
        }
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
            
            var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=checkIsIndieBd&ids="+social_unit_id+"&security_group_id="+security_group_id+"&fund_month="+fund_month+"&cust_id="+cust_id;
            jQuery.post(url,function(data){
                if(data){
                    if(data.isIndieBd==1){
                        if(cust_id==null || cust_id==""){
                            alert("请选择客户！");
                            return;
                          }
                       }
		             var  isIndieBd =data.isIndieBd  ;
		             var group_type= document.getElementById('group_type').value;
		             var security_type= document.getElementById('security_type').value;
		             var url1=null;
		             if(report_type_bd==1){     //杭州市社会保险新增参保职工申报表（柜台）
						 url1 =  "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZJSocialSecurityReport.jsp?raq=social_new_hz_report.raq&s_group="+security_group_id+"&yearmonth="+fund_month+"&cust_id="+cust_id+"&s_unit="+social_unit_id+"&date1="+date1+"&date2="+date2+"&date3="+date3;
				     }else if(report_type_bd==2){   //社保网上申报新增表格
					     url1 =  "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZJSocialSecurityReport.jsp?raq=social_new_hz_net_report.raq&s_group="+security_group_id+"&yearmonth="+fund_month+"&cust_id="+cust_id+"&s_unit="+social_unit_id+"&date1="+date1+"&date2="+date2+"&date3="+date3; 
				     }else if(report_type_bd==3){   //社保网上申报减少表格
						 url1 =  "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZJSocialSecurityReport.jsp?raq=social_reduce_hz_net_report.raq&s_group="+security_group_id+"&yearmonth="+fund_month+"&cust_id="+cust_id+"&s_unit="+social_unit_id+"&date1="+date1+"&date2="+date2+"&date3="+date3;
					 }
						window.open(url1,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
		             }
             });
        }
        
        //$id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportToEXCEL";
        //$id("datacell_formid").submit();
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
            loadData();
            return false;
        }

</script>
	</head>
	<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="group_type" id="group_type" value="${param.group_type}">
<input type="hidden" name="security_type" id="security_type" value="${param.security_type}">
	<div id="right">

	<script language="javascript">
	   writeTableTopFesco('杭州社保报表','<%=request.getContextPath()%>/');  //显示本页的页眉-->             
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
				
				 <td align="right"  class="td_1">
                        <p>城市</p>
                    </td>
                    <td align="left" class="td_2">
                        <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       value="1099110100000000357"
                       nullText="请选择" 
                       />
		            </td>
		            <td align="right" class="td_2">社保/公积金组</td>
		            <td align="left" class="td_2">
		                     <r:comboSelect id="group_List" name="security_group_id"
		                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=1"
		                       valueField="id"
		                       textField="group_name"
		                       xpath="SecuritygroupVo"
		                       width="200px"
		                       linkId="city_idList_search"
		                       nullText="请选择" />
		            </td>

					<td class="td_1">报表类型</td>
					<td class="td_2">
					  <%=gap.rm.tools.helper.RmJspHelper
									.getSelectField(
											"report_type_bd",
											-1,
											"ZJ_SOCIAL_RAQ_TYPE",
											"",
											" onchange='javascript:loadData();'  id=create_type_bd",
											false)%>
					</td>
				</tr>
				<tr>
					<td class="td_1">报表月</td>
					<td class="td_2"><input type="text" class="text_field" name="fund_month1" inputName="报表月" maxLength="6" onblur="javascript:loadData();" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td>
					<td class="td_1">福利办理方</td>
					<td class="td_2">
						 <r:comboSelect   name="social_unit_id"  id="social_unit_id"
			                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
			                textField="hire_unit_short_name" 
			                valueField="id" 
			                xpath="SocialunitVo"
			                nullText="--请选择--"
			                width="205px"  onChangeFunc="loadData"  >
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
				<!-- 
				    <input type="text" class="text_field" name="user" inputName="专管员" maxLength="10" />
				
				 -->
					
                       <r:comboSelect id="combo_cs1" name="user_name3"
                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=2013100700000000143"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText="请选择"
                        />
					
					</td>
					
					   <td class="td_1">负责客服</td>
                    <td class="td_2">
                
                <!-- 
                
                    <td class="td_1">办理日期</td>
                    <td class="td_2">
                       <w:date format="yyyy-MM-dd" name="transact_date_from" width="80px" property="writeBackFormValues/transact_date_from" onchange="javascript:loadData();"/>&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" name="transact_date_to" width="80px" property="writeBackFormValues/transact_date_to" onchange="javascript:loadData();"/>
                    </td>
                
                    <input type="text" class="text_field" name="user_name1" inputName="客服" maxLength="64" />
                 -->
                
                    <r:comboSelect id="combo_cs" name="user_name1"
                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=2013100700000000148"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText="请选择" />
                    
                    
                    </td>
                    
                      <td class="td_1"></td>
                    <td class="td_2">
                    
                    </td>
				</tr>
				
			</table>
			</div>
			<div class="foot_button">
			     <a class="foot_icon_3"  <au:authorityBtn code="sbbb_exp" type="1" /> onClick="exportEXCEL_onClick();">导出报表</a>
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
</html>
<script type="text/javascript">
var security_type="<%=security_type%>";
if(security_type=="4"){
   citySecurityGroupchange("0571','0520"); 
}

</script>
