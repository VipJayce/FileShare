<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@ page import="rayoo.customerservice.security.empsecurity.vo.EmpsecurityVo" %>
<%@ page import="rayoo.customerservice.laborcontract.vo.LaborcontractVo" %>
<%@ page import="rayoo.employeepost.empentry.epemporderitem.vo.EpemporderitemVo" %>
<%@ page import="rayoo.customerservice.hirefire.hirefire.vo.HirefireVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%  //取出本条记录
    EmppostVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (EmppostVo)request.getAttribute("empPVo");  //从request中取出vo, 赋值给resultVo
    LaborcontractVo resultlaborcontractVo = null;  //定义一个临时的vo变量
    resultlaborcontractVo = (LaborcontractVo)request.getAttribute("laborcontractVo");  //从request中取出vo, 赋值给resultVo
    EmpsecurityVo empsecurityGJJvo = null;  //定义一个临时的vo变量
    empsecurityGJJvo = (EmpsecurityVo)request.getAttribute("empsecurityGJJ");  //从request中取出vo, 赋值给resultVo
    EmpsecurityVo empsecurityBCGJJvo = null;  //定义一个临时的vo变量
    empsecurityBCGJJvo = (EmpsecurityVo)request.getAttribute("empsecurityBCGJJ");  //从request中取出vo, 赋值给resultVo
    EmpsecurityVo empsecuritySBvo = null;  //定义一个临时的vo变量
    empsecuritySBvo = (EmpsecurityVo)request.getAttribute("empsecuritySB");  //从request中取出vo, 赋值给resultVo
    HirefireVo hirefirevo = null;  //定义一个临时的vo变量
    hirefirevo = (HirefireVo)request.getAttribute("hirehandleVo");  //从request中取出vo, 赋值给resultVo
    List orderList  = null;  //定义一个临时的vo变量
    orderList = (List)request.getAttribute("chanpingbeans");  //从request中取出vo, 赋值给resultVo
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>其他信息查询2</title>
</head>
<body>
 <form id="datacell_formid" name="form" method="post" action="">
 </form>
<div id="right">
  <div class="ringht_s">
        <!-- ---------------------------------基本信息start--------------------------------------------------------------------------- -->
        <div class="xz_title">基本信息</div>
        <div id="ccChild0" class="box_3"> 
		    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		        <tr>
		            <td class="td_1" >唯一号：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>"></td>
		            <td class="td_1" >员工姓名：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>"></td>
		            <td class="td_1" >客户编号：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>"></td>
		        </tr>
		        <tr>
		            <td class="td_1" >客户名称：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>"></td>
		            <td class="td_1" >证件类别：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>"></td>
                    <td class="td_1" >证件号码：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getId_card())%>"></td>
		        </tr>
		        <tr>
		            <td class="td_1" >手机：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMobile())%>"></td>
                    <td class="td_1" >email：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmail())%>"></td>
                    <td class="td_1" >户口地址：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getResident_addresss())%>"></td>
                    
		        </tr>        
		        <tr>
		            <td class="td_1" >联系地址：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getAddress())%>"></td>
		            <td class="td_1" >人员分类：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("EMP_POST_TYPE_BD",RmStringHelper.prt(resultVo.getEmp_post_type_bd()))%>"></td>
                    <td class="td_1" >用工类别：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getHire_unit_real_name())%>"></td>
		        </tr>
		        <tr>
		            <td class="td_1" >合同起始日期：</td>
                    <td class="td_2" >
                    <%if(resultlaborcontractVo!=null&&resultlaborcontractVo.getStart_date()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultlaborcontractVo.getStart_date(),10)%>"></td>
                    <%}else{%>
                        <input type="text" class="text_field" readonly="readonly" value="">
                    <%} %>
		            <td class="td_1" >合同终止日期：</td>
                    <td class="td_2" >
	                    <%if(resultlaborcontractVo!=null&&resultlaborcontractVo.getEnd_date()!=null){ %>
	                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultlaborcontractVo.getEnd_date(),10)%>">
	                    <%}else{%>
	                        <input type="text" class="text_field" readonly="readonly" value="">
	                    <%} %>
                    </td>
                    <td class="td_1" >社保起始日期：</td>
                    <td class="td_2" >
	                   <%if(empsecuritySBvo!=null&&empsecuritySBvo.getStart_month()!=null){ %>
	                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecuritySBvo.getStart_month(),10)%>">
	                    <%}else{%>
	                        <input type="text" class="text_field" readonly="readonly" value="">
	                    <%} %>
                    </td>
		        </tr>
		        <tr>
		            <td class="td_1" >社保结束日期：</td>
                    <td class="td_2" >
	                     <%if(empsecuritySBvo!=null&&empsecuritySBvo.getEnd_month()!=null){ %>
	                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecuritySBvo.getEnd_month(),10)%>">
	                    <%}else{%>
	                        <input type="text" class="text_field" readonly="readonly" value="">
	                    <%} %>
                    </td>
		            <td class="td_1" >公积金起始日期：</td>
                    <td class="td_2" >
                        <%if(empsecurityGJJvo!=null&&empsecurityGJJvo.getStart_month()!=null){ %>
                            <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecurityGJJvo.getStart_month())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    <td class="td_1" >公积金结束日期：</td>
                    <td class="td_2" >
                     <%if(empsecurityGJJvo!=null&&empsecurityGJJvo.getEnd_month()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecurityGJJvo.getEnd_month())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
		        </tr>
		      </table>
	    </div>
	     <!-- ---------------------------------基本信息end--------------------------------------------------------------------------- -->
	    
	     <!-- ---------------------------------社保，公积金信息start--------------------------------------------------------------------------- -->
	    <div class="xz_title">社保,公积金信息</div>
              <div id="ccChild0" class="box_3"> 
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1" >缴纳地：</td>
                    <td class="td_2" >
                     <%if(empsecuritySBvo!=null&&empsecuritySBvo.getGroup_name()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecuritySBvo.getGroup_name())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    <td class="td_1" >社保方式：</td>
                    <td class="td_2" >
                     <%if(empsecuritySBvo!=null&&empsecuritySBvo.getHire_unit_short_name()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecuritySBvo.getHire_unit_short_name())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    <td class="td_1" >社保金额：</td>
                    <td class="td_2" >
                       <%if(empsecuritySBvo!=null&&empsecuritySBvo.getMoney()!=null){ %>
                            <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecuritySBvo.getMoney())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    
                    </td>
                </tr>
                <tr>
                    <td class="td_1" >公积金方式：</td>
                    <td class="td_2" >
                    <%if(empsecurityGJJvo!=null&&empsecurityGJJvo.getHire_unit_short_name()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecurityGJJvo.getHire_unit_short_name())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    <td class="td_1" >公积金账号：</td>
                    <td class="td_2" >
                     <%if(empsecurityGJJvo!=null&&empsecurityGJJvo.getAccounts()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecurityGJJvo.getAccounts())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    <td class="td_1" >公积金基数：</td>
                    <td class="td_2" >
                       <%if(empsecurityGJJvo!=null&&empsecurityGJJvo.getPay_base()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecurityGJJvo.getPay_base())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    
                    </td>
                </tr>
                <tr>
                    <td class="td_1" >公积金比例：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="个人还是单位？？"></td>
                    <td class="td_1" >补充公积金账号：</td>
                    <td class="td_2" >
                     <%if(empsecurityBCGJJvo!=null&&empsecurityBCGJJvo.getAccounts()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecurityBCGJJvo.getAccounts())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    <td class="td_1" >补充公积金基数：</td>
                    <td class="td_2" >
                    <%if(empsecurityBCGJJvo!=null&&empsecurityBCGJJvo.getPay_base()!=null){ %>
                    <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecurityBCGJJvo.getPay_base())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    
                    </td>
                    
                </tr>        
                <tr>
                    <td class="td_1" >补充公积金比例：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="？"></td>
                    <td class="td_1" >补充公积金金额：</td>
                    <td class="td_2" >
                      <%if(empsecurityBCGJJvo!=null&&empsecurityBCGJJvo.getMoney()!=null){ %>
                            <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(empsecurityBCGJJvo.getMoney())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    <td class="td_1" ></td>
                    <td class="td_2" ></td>
                </tr>
              </table>
        </div>
                
         <!-- ---------------------------------社保，公积金信息end--------------------------------------------------------------------------- -->
         

           <!-- ---------------------------------汇缴start---------------------------------------------------------------------------------- -->
         
          <div class="xz_title">产品信息</div>
              <div id="ccChild0" class="box_3"> 
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr >
                    <td class="td_1" rowspan=2 style="text-align:center">产品名称</td>
                    <td class="td_1" colspan="2" style="text-align:center">单位部分</td>
                    <td class="td_1" colspan="2" style="text-align:center">个人部分</td>
                    <td class="td_1" colspan="2" style="text-align:center">合计</td>
                </tr>
                <tr>
                    <td class="td_1" >比例</td>
                    <td class="td_1" >金额</td>
                    <td class="td_1" >比例</td>
                    <td class="td_1" >金额</td>
                    <td class="td_1" >比例</td>
                    <td class="td_1" >金额</td>
                </tr>
                    <%Iterator it = orderList.iterator();
                    EpemporderitemVo ci = null;
                        while(it.hasNext()) {
                        ci = (EpemporderitemVo)it.next();
                         if(ci.getProduct_name().equals("养老保险")||ci.getProduct_name().equals("医疗保险")||ci.getProduct_name().equals("失业保险")||ci.getProduct_name().equals("工伤保险")||ci.getProduct_name().equals("生育保险")||ci.getProduct_name().equals("残疾保障金")||ci.getProduct_name().equals("住房公积金")||ci.getProduct_name().equals("补充住房公积金")){
                             BigDecimal allmoney = new BigDecimal("0");
                             BigDecimal allratio = new BigDecimal("0");
                             Boolean eratioConf=false;
                             Boolean emoneyConf=false;
                             %>
			                  <tr>
			                     <td class="td_1" ><%=ci.getProduct_name() %>：</td>
			                     <td class="td_2" >
			                     <%if(ci.getE_ratio()!=null){ %>
			                     <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=ci.getE_ratio() %>">
			                     <%}else{
			                         eratioConf=true;
			                         %>
			                           <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="0">
			                         <% 
			                       }
			                     %>
			                     </td>
			                     <td class="td_2" >
			                    <%if(ci.getE_money()!=null){ %>
                                 <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=ci.getE_money() %>">
                                 <%}else{
                                     emoneyConf=true;
                                     %>
                                       <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="0">
                                     <% 
                                   }
                                 %>
			                     </td>
			                     <td class="td_2" >
			                      <%if(ci.getP_ratio()!=null){ 
			                          if(eratioConf){
			                              allratio.add(ci.getP_ratio());
			                          }else{
			                              allratio=ci.getE_ratio().add(ci.getP_ratio());
			                          }
			                      %>
                                 <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=ci.getP_ratio() %>">
                                 <%}else{
                                     if(!eratioConf){
                                         allratio=allratio.add(ci.getE_ratio());
                                     }
                                     %>
                                       <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="0">
                                     <% 
                                   }
                                 %>
			                     </td>
			                     <td class="td_2" >
			                      <%if(ci.getP_money()!=null){ 
			                          if(emoneyConf){
                                          allmoney.add(ci.getP_money());
                                      }else{
                                          allmoney=ci.getP_money().add(ci.getE_money()) ;
                                      }
			                      %>
                                 <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=ci.getP_money() %>">
                                 <%}else{
                                     if(!emoneyConf){
                                         allmoney= allmoney.add(ci.getE_money());
                                     }
                                     %>
                                       <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="0">
                                     <% 
                                   }
                                 %>
			                     </td>
			                     <td class="td_2" >
			                     <input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=allratio%>">
			                     
			                     </td>      
			                     <td class="td_2" ><input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=allmoney %>"></td>      
			                   </tr>
			                  <%
                           }
                        }
                    %>
                  </table>
        </div>
                
               <!-- ---------------------------------汇缴end--------------------------------------------------------------------------- -->
              
               <!-- ---------------------------------用退工信息start--------------------------------------------------------------------------- -->
        <div class="xz_title">用退工信息</div>
        <div id="ccChild0" class="box_3"> 
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1" >用工日期：</td>
                    <td class="td_2" >
                        <%if(hirefirevo!=null&&hirefirevo.getHire_handle_date()!=null){ %>
                        <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(hirefirevo.getHire_handle_date(),10)%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    
                    </td>
                    <td class="td_1" >是否用工完成：</td>
                    <td class="td_2" >
                        <%if(hirefirevo!=null&&hirefirevo.getHire_fire_status_bd()!=null){ 
	                            if(!hirefirevo.getHire_fire_status_bd().equals("0"))  {
	                                %>
	                                <input type="text" class="text_field" readonly="readonly" value="是">
	                               <%
	                            }else{                   
                        %>
                         <input type="text" class="text_field" readonly="readonly" value="否">
                        <%}
                           }else{%>
                            <input type="text" class="text_field" readonly="readonly" value="否">
                        <%} %>
                    </td>
                    <td class="td_1" >用工失败原因：</td>
                    <td class="td_2" >
                        <%if(hirefirevo!=null&&hirefirevo.getBack_reason()!=null){ %>
                        <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(hirefirevo.getBack_reason())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                </tr>
                <tr>
                    <td class="td_1" >操作日期：</td>
                    <td class="td_2" >
                       <%if(hirefirevo!=null&&hirefirevo.getHire_handle_date()!=null){ %>
                        <input type="text" class="text_field" readonly="readonly" value="？">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="？">
                        <%} %>
                    </td>
                    <td class="td_1" >操作人：</td>
                    <td class="td_2" >
                        <%if(hirefirevo!=null&&hirefirevo.getHire_handle_date()!=null){ %>
                        <input type="text" class="text_field" readonly="readonly" value="?">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="?">
                        <%} %>
                    </td>
                    <td class="td_1" >档案在何处：</td>
                    <td class="td_2" >
                      <%if(hirefirevo!=null&&hirefirevo.getArchives_address()!=null){ %>
                        <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(hirefirevo.getArchives_address())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                </tr>
                <tr>
                    <td class="td_1" >退工日期：</td>
                    <td class="td_2" >
                      <%if(hirefirevo!=null&&hirefirevo.getFire_handle_date()!=null){ %>
                        <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(hirefirevo.getFire_handle_date(),10)%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    
                    </td>
                    <td class="td_1" >退工办理方式：</td>
                    <td class="td_2" >
                          <%if(hirefirevo!=null&&hirefirevo.getFire_mode_bd()!=null){ 
                                if(!hirefirevo.getHire_fire_status_bd().equals("1"))  {
                                    %>
                                    <input type="text" class="text_field" readonly="readonly" value="网上退工">
                                   <%
                                }else{                   
                        %>
                         <input type="text" class="text_field" readonly="readonly" value="职介所退工">
                        <%}
                           }else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    <td class="td_1" >退工材料邮寄地址：</td>
                    <td class="td_2" >
                       <%if(hirefirevo!=null&&hirefirevo.getFire_resident_address()!=null){ %>
                        <input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(hirefirevo.getFire_resident_address())%>">
                        <%}else{%>
                            <input type="text" class="text_field" readonly="readonly" value="">
                        <%} %>
                    </td>
                    
                </tr>        
                <tr>
                    <td class="td_1" >退工材料自取/邮寄日期：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="?"></td>
                    <td class="td_1" >操作日期：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="?"></td>
                    <td class="td_1" >操作人：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="?"></td>
                </tr>
              </table>
        </div>
        <!-- ---------------------------------用退工信息end--------------------------------------------------------------------------- -->
       
        <!-- ---------------------------------工资信息start--------------------------------------------------------------------------- -->
          <!-- salary start->>>>>>>>>>> -->
        <div class="xz_title">工资信息</div>
        <div id="ccChild0" class="box_3"> 
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1" >代发工资：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value=""></td>
                    <td class="td_1" >报税信息：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value=""></td>
                    <td class="td_1" ></td>
                    <td class="td_2" ></td>
                </tr>
              </table>
        </div>
         <!-- ---------------------------------工资信息end--------------------------------------------------------------------------- -->
         
        <!-- ---------------------------------补充福利start--------------------------------------------------------------------------- -->
        <div class="xz_title">补充福利信息</div>
        <div id="ccChild0" class="box_3"> 
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
               <%Iterator it2 = orderList.iterator();
                    EpemporderitemVo ci2 = null;
                    
                    int i=1;
                        while(it2.hasNext()) {
                        ci2 = (EpemporderitemVo)it2.next();
                         if(!ci2.getProduct_name().equals("养老保险")&&!ci2.getProduct_name().equals("医疗保险")&&!ci2.getProduct_name().equals("失业保险")&&!ci2.getProduct_name().equals("工伤保险")&&!ci2.getProduct_name().equals("生育保险")&&!ci2.getProduct_name().equals("残疾保障金")&&!ci2.getProduct_name().equals("住房公积金")&&!ci2.getProduct_name().equals("补充住房公积金")){
                              if(i==1){
	                              %>
	                              <tr>
	                                 <td class="td_1" ><%=ci2.getProduct_name() %>：</td>
	                                 <td class="td_2" ><input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=ci2.getMoney()%>"></td>
	                              <%
                              }
                              else if(i%3==0&&it2.hasNext()==false){
                                  %>
                                  
                                  <td class="td_1" ><%=ci2.getProduct_name() %>：</td>
                                  <td class="td_2" ><input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=ci2.getMoney()%>"></td>
                                  </tr><tr>
                               <%
                              }
                              else if(i%3==0&&it2.hasNext()==true){
                                  %>
                                  
                                  <td class="td_1" ><%=ci2.getProduct_name() %>：</td>
                                  <td class="td_2" ><input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=ci2.getMoney()%>"></td>
                                  </tr>
                               <%
                              }
                              else{
                                  %>
                                     <td class="td_1" ><%=ci2.getProduct_name() %>：</td>
                                     <td class="td_2" ><input type="text" class="text_field"  style="width:150px;" readonly="readonly" value="<%=ci2.getMoney()%>"></td>
                                  <%
                              } i++;
                           }
                        
                        }
                    %>
            </table>
        </div>
        <!-- ---------------------------------补充福利end--------------------------------------------------------------------------- -->
  </div>
</div>
</body>
</html>

