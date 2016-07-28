<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/CommonCheck.js"/>
<h:script src="/js/caculateMoney.js"/>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.security.empsecurity.vo.QuerySocialSecurityVo" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%  //取出本条记录
    QuerySocialSecurityVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (QuerySocialSecurityVo)request.getAttribute(IEmpsecurityConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    String types = request.getAttribute("types")==null ? "" : request.getAttribute("types").toString();
%>
<html>
<fmt:bundle basename="rayoo.customerservice.security.empsecurity.empsecurity_resource" prefix="rayoo.customerservice.security.empsecurity.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="view"/></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        window.close();
        /*siqiaopeng<fmt:message key='detailQuerySocialSecurity0004'/>
<!--        var types = document.getElementById("types").value;-->
<!--        if(types == "social_security"){-->
<!--	        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQuerySocialSecurityFirst";-->
<!--	        form.submit();-->
<!--        }else if(types == "provident_fund"){-->
<!--            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryProvidentFundFirst";-->
<!--            form.submit();-->
<!--        }else if(types == "town_insurance"){-->
<!--            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryTownInsuranceFirst";-->
<!--            form.submit();-->
<!--        }else if(types == "complex_insurance"){-->
<!--            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryComplexInsuranceFirst";-->
<!--            form.submit();-->
<!--        }else if(types == "offsite_social_security"){-->
<!--            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryOffsiteSocialSecurityFirst";-->
<!--            form.submit();-->
<!--        }else if(types == "offsite_provident_fund"){-->
<!--            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryOffsiteProvidentFundFirst";-->
<!--            form.submit();-->
<!--        }else if(types == "social_security_and_provident_fund"){-->
<!--            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQuerySocialSecurityAndProvidentFundFirst";-->
<!--            form.submit();-->
<!--        }-->
*/
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 <input type="hidden" id="types" name="types" value="${types }"/>
 <input type="hidden" name="emp_post_id" value="<%=RmStringHelper.prt(resultVo.getEmp_post_id())%>">
 <input type="hidden" name="security_group_id" value="<%=RmStringHelper.prt(resultVo.getSecurity_group_id())%>">
<div id="right">
   <div class="right_title_bg">
   <%if(types.equals("social_security")){ %>
    <div class=" right_title"><fmt:message key="view_ss"/></div>
    <%}else if(types.equals("provident_fund")){ %>
    <div class=" right_title"><fmt:message key="view_fund"/></div>
    <%}else if(types.equals("town_insurance")){ %>
    <div class=" right_title"><fmt:message key="view_ti"/></div>
    <%}else if(types.equals("complex_insurance")){ %>
    <div class=" right_title"><fmt:message key="view_cs"/></div>
    <%}else if(types.equals("offsite_social_security")){ %>
    <div class=" right_title"><fmt:message key="view_offsite_ss"/></div>
    <%}else if(types.equals("offsite_provident_fund")){ %>
    <div class=" right_title"><fmt:message key="view_offsite_fund"/></div>
    <%}else if(types.equals("social_security_and_provident_fund")){ %>
    <div class=" right_title"><fmt:message key="view_ss_fund_joint"/></div>
    <%} %>
</div>
<div class="ringht_s">

<p></p>
<div class="xz_title"><fmt:message key="base_info"/></div>
<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><fmt:message key="emp_name"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='emp_name'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key="emp_code"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='emp_code'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="cust_code"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='cust_code'/>" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='cust_name'/>" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="card_type"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='card_type'/>" value="<%=resultVo.getId_card_type_bd()==null?"":BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key="card_num"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='card_num'/>" value="<%=RmStringHelper.prt(resultVo.getId_card())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="on_post_date"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='on_post_date'/>" value="<%=RmStringHelper.prt(resultVo.getApply_on_post_date(), 10)%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key="apply_on_post_date"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='apply_on_post_date'/>" value="<%=RmStringHelper.prt(resultVo.getOn_post_date(), 10)%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="charge_begin_date"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='charge_begin_date'/>" value="<%=RmStringHelper.prt(resultVo.getCharge_start_date(), 10)%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key="ss_fund_group"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key="ss_fund_group"/>" value="<%=RmStringHelper.prt(resultVo.getGroup_name())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="apply_user"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='apply_user'/>" value="<%=RmStringHelper.prt(resultVo.getApply_man())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key="apply_date"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='apply_date'/>" value="<%=RmStringHelper.prt(resultVo.getApply_date(),10)%>" readonly="readonly" />
            </td>
        </tr>
        <c:choose>
            <c:when test="${requestScope.types=='social_security_and_provident_fund'}">
                <tr>
                    <td class="td_1" ><fmt:message key="account"/></td>
                    <td class="td_2" >
                        <input type="text" class="text_field" name="account" inputName="<fmt:message key='account'/>" value="<%=RmStringHelper.prt(resultVo.getAccount())%>" readonly="readonly" />
                    </td>
                    <td class="td_1" ><fmt:message key="serial_no"/></td>
                    <td class="td_2" >
                        <input type="text" class="text_field" name="serial_no" inputName="<fmt:message key='serial_no'/>" value="<%=RmStringHelper.prt(resultVo.getSerial_no())%>" readonly="readonly" />
                    </td>
                </tr>
                <tr>
                    <td class="td_1" ><fmt:message key="security_unit_id"/></td>
                    <td class="td_2" >
                        <input type="text" class="text_field" inputName="<fmt:message key='security_unit_id'/>" value="${bean.hire_unit_short_name }" readonly="readonly" />
                    </td>
                    <td class="td_1" ><fmt:message key="transact_type"/></td>
                    <td class="td_2" >
                        <input type="text" class="text_field" inputName="<fmt:message key='transact_type'/>" value="<%=RmStringHelper.prt(resultVo.getType_name_new())%>" readonly="readonly" />
                    </td>
                </tr>
                <tr>
                    <td class="td_1" ><fmt:message key="start_month"/></td>
                    <td class="td_2" >
                        <input type="text" class="text_field" inputName="<fmt:message key='start_month'/>" value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" readonly="readonly" />
                    </td>
                    <td class="td_1" ><fmt:message key="fund_month"/></td>
                    <td class="td_2" >
                        <input type="text" class="text_field" inputName="<fmt:message key='fund_month'/>" value="<%=RmStringHelper.prt(resultVo.getFund_month())%>" readonly="readonly" />
                    </td>
                </tr>
            </c:when>
            <c:otherwise>
		        <tr>
		            <c:choose>
		            <c:when test="${requestScope.types=='provident_fund' || requestScope.types=='offsite_provident_fund'}">
		                <td class="td_1" ><fmt:message key="account"/></td>
		                <td class="td_2" >
		                    <input type="text" class="text_field" name="account" inputName="<fmt:message key='account'/>" value="<%=RmStringHelper.prt(resultVo.getAccount())%>" readonly="readonly" />
		                </td>
		            </c:when>
		            <c:otherwise>
		                <td class="td_1" ><fmt:message key="serial_no"/></td>
			            <td class="td_2" >
			                <input type="text" class="text_field" name="serial_no" inputName="<fmt:message key='serial_no'/>" value="<%=RmStringHelper.prt(resultVo.getSerial_no())%>" readonly="readonly" />
			            </td>
		            </c:otherwise>
		        </c:choose>
		            <td class="td_1" ><fmt:message key="security_unit_id"/></td>
		            <td class="td_2" >
		                <input type="text" class="text_field" inputName="<fmt:message key='security_unit_id'/>" value="<%=RmStringHelper.prt(resultVo.getHire_unit_short_name())%>" readonly="readonly" />
		            </td>
		        </tr>
		        <tr>
		            <td class="td_1" ><fmt:message key="transact_type"/></td>
		            <td class="td_2" >
		                <input type="text" class="text_field" inputName="<fmt:message key='transact_type'/>" value="<%=RmStringHelper.prt(resultVo.getType_name_new())%>" readonly="readonly" />
		            </td>
		            <td class="td_1" ><fmt:message key="start_month"/></td>
		            <td class="td_2" >
		                <input type="text" class="text_field" inputName="<fmt:message key='start_month'/>" value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" readonly="readonly" />
		            </td>
		        </tr>
		        <tr>
		            <td class="td_1" ><fmt:message key="fund_month"/></td>
		            <td class="td_2" >
		                <input type="text" class="text_field" inputName="<fmt:message key='fund_month'/>" value="<%=RmStringHelper.prt(resultVo.getFund_month())%>" readonly="readonly" />
		            </td>
		            <td class="td_2"  ></td>
		            <td class="td_2"  ></td>
		        </tr>
            </c:otherwise>
        </c:choose>
        <tr>
            <td class="td_1"><fmt:message key="back_reason"/></td>
            <td colspan="3" class="td_2">
                 <textarea rows="3" name="back_reason" style="width:350px" readonly="readonly" inputName="<fmt:message key='back_reason'/>"><%=RmStringHelper.prt(resultVo.getBack_reason())%></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="transact_remark"/></td>
            <td colspan="3" class="td_2">
                 <textarea rows="3" name="transact_remarks" style="width:350px" readonly="readonly" inputName="<fmt:message key='transact_remark'/>"><%=RmStringHelper.prt(resultVo.getTransact_remarks())%></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="feedback_info"/></td>
            <td colspan="3" class="td_2">
                 <textarea rows="3" name="feedback_info" style="width:350px" readonly="readonly" inputName="<fmt:message key='feedback_info'/>"><%=RmStringHelper.prt(resultVo.getFeedback_info())%></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="old_cust_name"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='old_cust_name'/>" value="<%=RmStringHelper.prt(resultVo.getOld_cust_name())%>" readonly="readonly" />
            </td>
            <!--<td class="td_1" ><fmt:message key='detailQuerySocialSecurity0065'/></td>陈旭修改-->
            <td class="td_1" ><fmt:message key="average_wage"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='average_wage'/>" value="<fmt:formatNumber value='<%=RmStringHelper.prt(resultVo.getAverage_wage())%>' pattern='###,###,###,###.##'  minFractionDigits='2'/>" readonly="readonly" />
            </td>
        </tr>
        <!--<tr>
            <td class="td_1" ><fmt:message key='detailQuerySocialSecurity0069'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQuerySocialSecurity0069'/>" value="<fmt:formatNumber value='<%=RmStringHelper.prt(resultVo.getOld_average_wage())%>' pattern='###,###,###,###.##'  minFractionDigits='2'/>" readonly="readonly" />
            </td>
            <td class="td_2"  ></td>
            <td class="td_2"  ></td>
        </tr>陈旭修改-->
        <tr>
            <td class="td_1"><fmt:message key="stop_man"/></td>
             <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='stop_man'/>" value="<%=RmStringHelper.prt(resultVo.getStop_man_name())%>" readonly="readonly" />
            </td>
               <td class="td_1"><fmt:message key="stop_date"/></td>
             <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='stop_date'/>" value="<%=RmStringHelper.prt(resultVo.getStop_date(),10)%>" readonly="readonly" />
            </td>
            
        </tr>
         <tr>
            <td class="td_1"><fmt:message key="stop_remark"/></td>
             <td colspan="3" class="td_2">
                 <textarea rows="3"  style="width:350px" readonly="readonly" inputName="<fmt:message key='stop_remark'/>"><%=RmStringHelper.prt(resultVo.getStop_remarks())%></textarea>
            </td>
           
            
        </tr>
        <c:choose>
            <c:when test="${requestScope.types=='provident_fund' || requestScope.types=='offsite_provident_fund'}">
                    <tr>
                        <td class="td_1" ><fmt:message key="next_cust_name"/></td>
                        <td class="td_2" >
                            <input type="text" class="text_field" name="next_cust_name"  value="<%=RmStringHelper.prt(resultVo.getNext_cust_name())%>" />
                        </td>
                        <td class="td_1" ><fmt:message key="next_cust_account"/></td>
                        <td class="td_2" >
                            <input type="text" class="text_field" name="nextcust_account"  value="<%=RmStringHelper.prt(resultVo.getNextcust_account())%>" />
                        </td>
                    </tr>
             </c:when>
                
        </c:choose>
        
    </table>
   </div> 
    <p></p>
    <div class="xz_title"><fmt:message key="remitted"/></div>
    <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=searchUnremittedData&securityId=${securityId}"
        width="98%"
        height="200px"
        xpath="EmpsecurityitemVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="product_name" messagekey="product">
            <h:text/>
          </r:field>
          <r:field fieldName="product_ratio_name" messagekey="product_ratio_name">
               <h:text/>   
           </r:field>    
          <r:field fieldName="base" messagekey="pay_base">
               <h:text/>
           </r:field>
          <r:field fieldName="e_ratio" messagekey="e_ratio">
            <h:text/>
          </r:field>
          <r:field fieldName="p_ratio" messagekey="p_ratio">
            <h:text/>
          </r:field>
          <r:field fieldName="money" messagekey="money">
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" messagekey="e_money">
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" messagekey="p_money">
            <h:text/>
          </r:field>
          <r:field fieldName="e_add_money" messagekey="e_add_money">
            <h:text/>
          </r:field>
        
    </r:datacell>
    </div>
    
    <p></p>
    <div class="xz_title"><fmt:message key="repay"/></div>
    <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=searchInBackData&securityId=${securityId}"
        width="98%"
        height="180px"
        xpath="EmpsecuritysupplyVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="start_month" messagekey="repay_start_month">
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" messagekey="repay_end_month">
               <h:text/>   
           </r:field>    
          <r:field fieldName="fund_month" messagekey="fund_month">
               <h:text/>   
           </r:field>    
          <r:field fieldName="base" messagekey="pay_base">
               <h:text/>
           </r:field>
          <r:field fieldName="month_inback" messagekey="month_inback">
            <h:text/>
          </r:field>
          <r:field fieldName="money" messagekey="money">
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" messagekey="e_money">
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" messagekey="p_money">
            <h:text/>
          </r:field>
          <r:field fieldName="remarks" messagekey="remark" width="300px">
            <h:text/>
          </r:field>
    </r:datacell>
    </div>
    

<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="close"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

     </div>

</form>

<script language="javascript">
    var datasetList = [];
    var dlIndex = 0;
    $id("datacell2").isHeadEvent = false;
    //<fmt:message key='detailQuerySocialSecurity0090'/>加载完后初始化<fmt:message key='detailQuerySocialSecurity0103'/>
    $id("datacell2").afterLoadData = function(){
        var security_group_id = $name("security_group_id").value;
        var emp_post_id =$name("emp_post_id").value;
        var ds = $id("datacell2").dataset;
            //alert(ds.getLength());
        for(var i=0;i<ds.getLength();i++){
            var enCur = ds.get(i);
            //var emp_order_id =enCur.getProperty("emp_order_id");
            //var start_month = enCur.getProperty("start_month");
            //var end_month = enCur.getProperty("end_month");
            var security_supply_id =enCur.getProperty("id");
            var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=queryEmpsecuritySupplyItem");
            myAjax.addParam("security_supply_id", security_supply_id);
            myAjax.addParam("security_group_id", security_group_id);
            myAjax.submit();
            var xmlDom = myAjax.retDom;
            var dataset1 = Dataset.create(xmlDom,"root/data/EmpsecuritysupplyitemVo","EmpsecuritysupplyitemVo");
            datasetList.push(dataset1);
            dlIndex ++;
        }
        
    }
    
    //实现beforeEdit<fmt:message key='detailQuerySocialSecurity0101'/>cell,colInde,rowIndex,entity,field,datacell
    $id("datacell2").onClickCell=function(cell,colIndex,rowIndex){
        if (colIndex == 4||colIndex==5||colIndex==6||colIndex==7){
            var security_group_id = $name("security_group_id").value;
            //alert(security_group_id);
            var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listSecuritySupplyItem.jsp?security_group_id="+security_group_id;
            //var curRowNum = $id("datacell2").activeRow.rowIndex;
            var entCur=this.getEntityByCell(cell);
            var start_month = entCur.getProperty("start_month");
            var end_month = entCur.getProperty("end_month");
            var countMonth=month6Subtration(start_month,end_month);
            var base = entCur.getProperty("base");
            var dcNew = datasetList[rowIndex].clone(true);
            var argument=[];
            argument.push(dcNew);
            argument.push(countMonth);
            argument.push(base);
            url += '&_ts='+(new Date()).getTime(); 
            if(start_month==''||end_month==''){
                alert('<fmt:message key="please_check_in_repay_begin_month_and_end_month"/>');
                return;
            }
            showModalCenter(url, [argument], null, 700, 320, "补缴明细");  //显示<fmt:message key='detailQuerySocialSecurity0103'/>记录
            }
        return true;
    } 
</script>
</body>
</fmt:bundle>
</html>
