<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<html>
<fmt:bundle basename="rayoo.customerservice.custservice.providentfund.listQueryProvidentFund_resource" prefix="auto.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("securityId")+"\");>";
    }
    
    function ClickRow(value,value1){
        $id("postId").value = value;
        $id("securityId").value = value1;
    }
    
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
  	
	function detail_onClick(){  //实现转到详细页面
        var postId = document.getElementById("postId").value;
        if(postId == null || postId == ""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+postId,'个人订单信息','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        //window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+postId,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
	}
	
	function detail_Click(){
	   var securityId = document.getElementById("securityId").value;
        if(securityId == null || securityId == ""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.open('<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQuerySocialSecurity&securityId=' + securityId+'&types=provident_fund','详细信息','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        //$id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQuerySocialSecurity&securityId=" + securityId+"&types=provident_fund";
        //$id("datacell_formid").submit();
	}
	
	//导出
    function exportToExcel(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportQuerySocialSecurityToExcel&para=provident_fund";
        $id("datacell_formid").submit();
    }
	
	//选择客户
    function rtnFuncCustomer(arg){
        //var lookup = $id("cust_name1");
        //lookup.value = arg[2];
        //lookup.displayValue = arg[2];
        
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
    }

</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" name="postId" id="postId" value="">
<input type="hidden" name="securityId" id="securityId" value="">
 
<div id="right">
<script language="javascript">
writeTableTopFesco('<fmt:message key="listQueryProvidentFund0103"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
           <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="listQueryProvidentFund0101"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryProvidentFund0100"/></td>
            <td align="left">
                 <select id="security_group_id" name="security_group_id" >
                    <option value=""><fmt:message key="listQueryProvidentFund0009"/></option>
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message key="listQueryProvidentFund0008"/></option>
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message key="listQueryProvidentFund0039"/></option>
                 </select>
            </td>
            <td align="right"><fmt:message key="listQueryProvidentFund0006"/></td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="<fmt:message key="listQueryProvidentFund0006"/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="listQueryProvidentFund0038"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="<fmt:message key="listQueryProvidentFund0038"/>" maxLength="10"/>            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryProvidentFund0069"/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="<fmt:message key="listQueryProvidentFund0069"/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="listQueryProvidentFund0036"/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="<fmt:message key="listQueryProvidentFund0036"/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="listQueryProvidentFund0099"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="<fmt:message key="listQueryProvidentFund0099"/>" maxLength="64"/>           </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key="listQueryProvidentFund0065"/></td>
          <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer"  id="lk_clz" name="cust_name1" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="listQueryProvidentFund0000" height="440" width="600"  style="width:195px"/>
          </td>
          <td align="right"><fmt:message key="listQueryProvidentFund0095"/></td>
          <td align="left"><input type="text" class="text_field" name="account1" inputName="<fmt:message key="listQueryProvidentFund0095"/>" maxLength="64"/> </td>
            <td align="right"><fmt:message key="listQueryProvidentFund0063"/></td>
            <td align="left"><faerp:SoialunitSelectTag  tagname="social_unit_id"  beanname="social_unit_id" style="width:200px"/>  </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key="listQueryProvidentFund0094"/></td>
          <td align="left">
            <w:date format="yyyy-MM-dd" name="transact_date_from" width="80px" />&nbsp;<fmt:message key="listQueryProvidentFund0062"/>&nbsp;<w:date format="yyyy-MM-dd" name="transact_date_to" width="80px" />
          </td>
          <td align="right"><fmt:message key="listQueryProvidentFund0093"/></td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("security_status_bd1", -1,"SECURITY_STATUS_BD", "","", false)%></td>
            <td align="right"><fmt:message key="listQueryProvidentFund0061"/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="stop_date_from" width="80px" />&nbsp;<fmt:message key="listQueryProvidentFund0062"/>&nbsp;<w:date format="yyyy-MM-dd" name="stop_date_to" width="80px" />
            </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key="listQueryProvidentFund0092"/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_date_from" width="80px"/>&nbsp;<fmt:message key="listQueryProvidentFund0062"/>&nbsp;<w:date format="yyyy-MM-dd" name="apply_date_to" width="80px" />
            </td>
          <td align="right"><fmt:message key="listQueryProvidentFund0091"/></td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_by1", -1,"SORT_BY1", "","", false)%></td>
            <td align="right"><fmt:message key="listQueryProvidentFund0029"/></td>
            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_order", -1,"SORT_ORDER", "","", false)%></td>
        </tr>
        <tr>
              <td align="right">客服</td>
	          <td align="left">
	            <r:comboSelect id="combo_cs" name="user_id"
	                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
	                       textField="name"
	                       valueField="partyId"
	                       xpath="CustServiceVo"
	                       width="200px"
	                       nullText="请选择" />
	          </td>
              <td align="right">同步状态</td>
            <td align="left">
                <d:select name="sync_status" id="sync_status" dictTypeId="SYNC_STATUS" nullLabel="--请选择--" style="width:200px;"/>
            </td>
              <td>
                 <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             </td>
             <td>   
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
        </tr>
</table>
</div>

<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
					<li class="a_2">      <a  onClick="javascript:detail_onClick();">查看个人订单</a> </li>
					<li class="a">      <a onClick="javascript:detail_Click();">查看</a></li>
                    <li class="e">      <a onclick="javascript:exportToExcel();">导出</a></li>
				</ul>
		 -->
		 <input class="a_2" type="button"   value="<fmt:message key="listQueryProvidentFund0089"/>"  <au:authorityBtn code="view_orderItem24" type="1"/>  onClick="detail_onClick();">
         <input class="a" type="button"   value="<fmt:message key="listQueryProvidentFund0025"/>"  <au:authorityBtn code="gjjcx_view" type="1"/>  onClick="detail_Click();">
         <input class="e" type="button"   value="<fmt:message key="listQueryProvidentFund0057"/>"  <au:authorityBtn code="gjjcx_exp" type="1"/>  onClick="exportToExcel();">
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=listQueryProvidentFund"
        width="98%"
        height="320px"
        xpath="QuerySocialSecurityVo"
        paramFormId="datacell_formid"
        freezeNumber="3"
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" messagekey="listQueryProvidentFund0087" width="50px" onRefreshFunc="setCheckboxStatus" align="center" sortAt="none">
          </r:field>
          <r:field fieldName="emp_code" messagekey="listQueryProvidentFund0006" sortAt="none">
               <h:text/>   
           </r:field>    
          <r:field fieldName="emp_name" messagekey="listQueryProvidentFund0038" sortAt="none">
               <h:text/>   
           </r:field>
           <r:field fieldName="group_name" messagekey="listQueryProvidentFund0100" sortAt="none" allowModify="false">
	            <h:text/>      
	      </r:field>
          <r:field fieldName="id_card_type_bd" messagekey="listQueryProvidentFund0023" sortAt="none">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="id_card" messagekey="listQueryProvidentFund0055" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" messagekey="listQueryProvidentFund0099" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey="listQueryProvidentFund0065" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="account" messagekey="listQueryProvidentFund0086" sortAt="none">
            <h:text/>
          </r:field><!--siqp注
          <r:field fieldName="big_name" label="大分类">
            <h:text/>
          </r:field>
          <r:field fieldName="small_name" label="小分类">
            <h:text/>
          </r:field>
          --><r:field fieldName="hire_unit_short_name" messagekey="listQueryProvidentFund0063" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="user_name" label="客服" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_man" messagekey="listQueryProvidentFund0022" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_date" messagekey="listQueryProvidentFund0094" sortAt="none">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="type_name_new" messagekey="listQueryProvidentFund0085" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_remarks" messagekey="listQueryProvidentFund0053" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="start_month" messagekey="listQueryProvidentFund0051" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" messagekey="listQueryProvidentFund0081" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="fund_month" messagekey="listQueryProvidentFund0080" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="pay_base" messagekey="listQueryProvidentFund0018" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="security_status_bd" messagekey="listQueryProvidentFund0093" sortAt="none">
            <d:select dictTypeId="SECURITY_STATUS_BD" />
          </r:field>
          <r:field fieldName="stop_date" messagekey="listQueryProvidentFund0061" sortAt="none">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="stop_man" messagekey="listQueryProvidentFund0049" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="type_name_stop" messagekey="listQueryProvidentFund0047" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="stop_remarks" messagekey="listQueryProvidentFund0014" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="money" messagekey="listQueryProvidentFund0015" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="sync_status" label="同步状态" width="150px" allowModify="false">
	            <d:select dictTypeId="SYNC_STATUS" disabled="true"/>
	      </r:field>
	      
	      <r:field fieldName="sync_remark" label="同步备注" width="150px" allowModify="false">
	           <d:select dictTypeId="SYNC_REMARK" disabled="true"/>  
	      </r:field>
      	  <r:field fieldName="sync_date" label="同步时间" width="130px" allowModify="false">
                                <w:date format="yyyy-MM-dd HH:mm:ss" />
         </r:field>
         
         <r:field fieldName="remark" label="同步历史" width="350px" allowModify="false">
	           <h:text/>
	      </r:field>
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
