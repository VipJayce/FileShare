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
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("securityId")+"\",\""+entity.getProperty("supplyId")+"\");>";
    }
    
    function ClickRow(value,value1,value2){
        $id("postId").value = value;
        $id("securityId").value = value1;
        $id("supplyId").value = value2;
    }
    
	function simpleQuery_onClick(){  //简单的模糊查询
	    var fund_month = document.getElementById("fund_month").value;
	    if(fund_month ==null || fund_month == ""){
	       alert("必须填写补缴报表月查询条件才能查询,如“201203”！");
	       return;
	    }else{
	       if(fund_month.length != 6){
	           alert("补缴报表月查询条件必须为6位数字,如“201203”！");
	           return;
	       }
	       var year = fund_month.substring(0,4);
	       var month = fund_month.substring(4,6);
	       if(year<2000 || year>2030 || month<1 || month>12){
	           alert("请正确输入补缴报表月查询条件，年份在2000~2030之间，月份在01~12之间，如“201203”！");
	           return;
	       }
	    }
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
  	
	function detail_onClick(){  //实现转到详细页面
        var postId = document.getElementById("postId").value;
        if(postId == null || postId == ""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+postId,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
	}
	
	function detail_Click(){
	   var supplyId = document.getElementById("supplyId").value;
	   var securityId = document.getElementById("securityId").value;
        if(supplyId == null || supplyId == ""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQueryInBack&supplyId=" + supplyId+"&securityId="+securityId+"&types=town_insurance_in_back";
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看详细');
       // $id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQueryInBack&supplyId=" + supplyId+"&securityId="+securityId+"&types=town_insurance_in_back";
       /// $id("datacell_formid").submit();
	}
	
	//导出
    function exportToExcel(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportQueryInBackToExcel&para=town_insurance_in_back";
        $id("datacell_formid").submit();
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#h_customer_name").val(arg[2]);
        return false;
    }

</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" name="postId" id="postId" value="">
<input type="hidden" name="securityId" id="securityId" value="">
<input type="hidden" name="supplyId" id="supplyId" value="">

 
<div id="right">
<script language="javascript">
writeTableTopFesco('镇保补缴查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
           <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        </tr>
        <tr>
            <td align="right">社保组</td>
            <td align="left">
                 <select id="security_group_id" name="security_group_id" >
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>">上海小城镇</option>
                 </select>
            </td>
            <td align="right">补缴报表月</td>
            <td align="left">
               <input type="text" class="text_field" name="fund_month" id="fund_month" inputName="补缴报表月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td>
            <td align="right">福利办理方</td>
            <td align="left"><faerp:SoialunitSelectTag  tagname="social_unit_id"  beanname="social_unit_id" style="width:200px"/>  </td>
        </tr>
        <tr>
            <td align="right">唯一号</td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>            </td>
            <td align="right">员工姓名</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="10"/>            </td>
            <td align="right">客户方编号</td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="客户方编号" maxLength="64"/>            </td>
        </tr>
        <tr>
            <td align="right">身份证</td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="身份证" maxLength="64"/>            </td>
            <td align="right">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="64"/>           </td>
            <td align="right">客户名称</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:195px"/>
                 <input type="hidden" name="cust_name1" id="h_customer_name" value=""/>
            </td>
        </tr>
        <tr>
           <td align="right">状态</td>
           <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("security_status_bd1", -1,"SECURITY_STATUS_BD", "","", false)%></td>
            <td align="right">补缴办理日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="create_date_from" width="80px"/>&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" name="create_date_to" width="80px"/>
            </td>
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
       </tr>
       <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
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
				<ul>
					<li class="a">      <a onClick="javascript:detail_Click();">查看</a></li>
                    <li class="e">      <a onclick="javascript:exportToExcel();">导出</a></li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=listQueryTownInsuranceInBack"
        width="98%"
        height="320px"
        xpath="QuerySocialSecurityVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="emp_name" label="姓名">
               <h:text/>   
           </r:field>    
          <r:field fieldName="emp_code" label="唯一号">
               <h:text/>   
           </r:field>    
           <r:field fieldName="group_name" label="社保组" allowModify="false">
                <h:text/>      
          </r:field>  
          <r:field fieldName="id_card" label="18位证件号码">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" label="客户编号">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" label="客户名称">
            <h:text/>
          </r:field>
          <r:field fieldName="internal_code" label="客户方编号">
            <h:text/>
          </r:field>
          <r:field fieldName="hire_unit_short_name" label="福利办理方">
            <h:text/>
          </r:field>
          <r:field fieldName="user_name" label="客服" sortAt="none">
            <h:text/>
          </r:field>
          <r:field fieldName="start_month" label="补缴起始">
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" label="补缴截止">
            <h:text/>
          </r:field>
          <r:field fieldName="month_num" label="月数">
            <h:text/>
          </r:field>
          <r:field fieldName="pay_base" label="基数">
            <h:text/>
          </r:field>
          <r:field fieldName="money" label="金额">
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" label="单位金额">
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" label="个人金额">
            <h:text/>
          </r:field>
          <r:field fieldName="create_date" label="补缴办理日期">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
    </r:datacell>
    </div>
 
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
