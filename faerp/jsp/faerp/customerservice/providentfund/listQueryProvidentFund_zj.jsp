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
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("securityId")+"\");>";
    }
    
    function ClickRow(value,value1){
        $id("postId").value = value;
        $id("securityId").value = value1;
    }
    
	function simpleQuery_onClick(){  //简单的模糊查询
	    var security_group_id=$id("security_group_id").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
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
        var security_group_id=$id("security_group_id").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
        }
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportQuerySocialSecurityToExcel&para=provident_fund";
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
 
<div id="right">
<script language="javascript">
writeTableTopFesco('公积金查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		
        <tr>
               <td align="right" >
                 <p>城市</p>
            </td>
            <td align="left">
                 <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="205px"
                       value="1099110100000000357"
                       nullText="请选择" 
                       />
            </td>
          
              <td align="right">公积金组</td>
              <td align="left">
                     <r:comboSelect id="security_group_id" name="security_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=2"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="205px"
                       linkId="city_idList_search"
                       nullText="请选择" />
              </td>
                    
            
            <td align="right">唯一号</td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>            </td>
            <td align="right">员工姓名</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="10"/>            </td>
        </tr>
        <tr>
            <td align="right">客户方编号</td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="客户方编号" maxLength="64"/>            </td>
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
         
          <td align="right">账号</td>
          <td align="left"><input type="text" class="text_field" name="account1" inputName="账号" maxLength="64"/> </td>
            <td align="right">福利办理方</td>
            <td align="left"><faerp:SoialunitSelectTag  tagname="social_unit_id"  beanname="social_unit_id" style="width:200px"/>  </td>
              <td align="right">办理日期</td>
          <td align="left">
            <w:date format="yyyy-MM-dd" name="transact_date_from" width="80px" />&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" name="transact_date_to" width="80px" />
          </td>
          <td align="right">状态</td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("security_status_bd1", -1,"SECURITY_STATUS_BD", "","", false)%></td>
        </tr>
        <tr>
        
            <td align="right">停办日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="stop_date_from" width="80px" />&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" name="stop_date_to" width="80px" />
            </td>
              <td align="right">申请日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_date_from" width="80px"/>&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" name="apply_date_to" width="80px" />
            </td>
          <td align="right">排序方式</td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_by1", -1,"SORT_BY1", "","", false)%></td>
            <td align="right">排序顺序</td>
            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_order", -1,"SORT_ORDER", "","", false)%></td>
        </tr>
  
        <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
               <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td >
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
		 <input class="a_2" type="button"   value=" 查看个人订单"  <au:authorityBtn code="view_orderItem24" type="1"/>  onClick="detail_onClick();">
         <input class="a" type="button"   value=" 查看"  <au:authorityBtn code="gjjcx_view" type="1"/>  onClick="detail_Click();">
         <input class="e" type="button"   value=" 导出"  <au:authorityBtn code="gjjcx_exp" type="1"/>  onClick="exportToExcel();">
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
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="emp_code" label="唯一号">
               <h:text/>   
           </r:field>    
          <r:field fieldName="emp_name" label="姓名">
               <h:text/>   
           </r:field>
           <r:field fieldName="group_name" label="公积金组" allowModify="false">
	            <h:text/>      
	      </r:field>
          <r:field fieldName="id_card_type_bd" label="证件类型">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="id_card" label="证件号码">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" label="客户编号">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" label="客户名称">
            <h:text/>
          </r:field>
          <r:field fieldName="account" label="公积金账号">
            <h:text/>
          </r:field><!--siqp注
          <r:field fieldName="big_name" label="大分类">
            <h:text/>
          </r:field>
          <r:field fieldName="small_name" label="小分类">
            <h:text/>
          </r:field>
          --><r:field fieldName="hire_unit_short_name" label="福利办理方">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_man" label="办理人">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_date" label="办理日期">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="type_name_new" label="办理类型">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_remarks" label="办理备注">
            <h:text/>
          </r:field>
          <r:field fieldName="start_month" label="缴费起始月">
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" label="缴费截止月">
            <h:text/>
          </r:field>
          <r:field fieldName="fund_month" label="报表月">
            <h:text/>
          </r:field>
          <r:field fieldName="pay_base" label="基数">
            <h:text/>
          </r:field>
          <r:field fieldName="security_status_bd" label="状态">
            <d:select dictTypeId="SECURITY_STATUS_BD" />
          </r:field>
          <r:field fieldName="stop_date" label="停办日期">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="stop_man" label="停办人">
            <h:text/>
          </r:field>
          <r:field fieldName="type_name_stop" label="停办类型">
            <h:text/>
          </r:field>
          <r:field fieldName="stop_remarks" label="停办备注">
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
