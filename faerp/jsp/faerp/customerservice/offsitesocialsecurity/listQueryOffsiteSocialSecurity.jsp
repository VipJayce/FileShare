<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.customerservice.custservice.offsitesocialsecurity.listQueryOffsiteSocialSecurity_resource" prefix="auto.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    function citySecurityGroupchange1(seletvalue,type){
      SecurityGroupAjax.getCitySecurityGroup1(seletvalue,type,{callback:function(data){
               setSelectForBean("security_group_id",data,"id","group_name","");
               var str="";
               var strid="";
               for(var i=0;i<data.length;i++){
                        str+=data[i].group_name+"  ";
                        strid+=data[i].id+",";
               }
               jQuery("#groupid").val(strid);
               jQuery("#group_range").val(str);
           }
       });
    }
    
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
        window.open("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQuerySocialSecurity&securityId=" + securityId+"&types=offsite_social_security",'详细信息','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        //$id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQuerySocialSecurity&securityId=" + securityId+"&types=offsite_social_security";
        //$id("datacell_formid").submit();
	}
	
	//导出
    function exportToExcel(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportQuerySocialSecurityToExcel&para=offsite_social_security";
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
<input type="hidden" id="groupid" name="groupid" value=""/>
 
<div id="right">
<script language="javascript">
writeTableTopFesco('<fmt:message key="listQueryOffsiteSocialSecurity0000"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
           <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="listQueryOffsiteSocialSecurity0047"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0046"/></td>
            <td align="left">
                 <select id="security_group_id" name="security_group_id" ></select>
            </td>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0078"/></td>
            <td align="left">
               <input type="text" class="text_field_reference_readonly" id="group_range" name="group_range" inputName="<fmt:message key="listQueryOffsiteSocialSecurity0078"/>" readonly="readonly" style="width:205px"/>            </td>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0012"/></td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="<fmt:message key="listQueryOffsiteSocialSecurity0012"/>" maxLength="64"/>            </td>   
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0011"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="<fmt:message key="listQueryOffsiteSocialSecurity0011"/>" maxLength="10"/>            </td>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0010"/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="<fmt:message key="listQueryOffsiteSocialSecurity0010"/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0073"/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="<fmt:message key="listQueryOffsiteSocialSecurity0073"/>" maxLength="64"/>            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0041"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="<fmt:message key="listQueryOffsiteSocialSecurity0041"/>" maxLength="64"/>           </td>
          <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0072"/></td>
           <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="listQueryOffsiteSocialSecurity0040" height="440" width="600"  style="width:195px"/>
                 <input type="hidden" name="cust_name1" id="h_customer_name" value=""/>            
           </td>
          <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0071"/></td>
          <td align="left"><input type="text" class="text_field" name="account1" inputName="<fmt:message key="listQueryOffsiteSocialSecurity0071"/>" maxLength="64"/> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0070"/></td>
            <td align="left"><faerp:SoialunitSelectTag  tagname="social_unit_id"  beanname="social_unit_id" style="width:200px"/>  </td>
          <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0009"/></td>
          <td align="left">
            <w:date format="yyyy-MM-dd" id="transact_date_from" name="transact_date_from" width="80px"/>&nbsp;<fmt:message key="listQueryOffsiteSocialSecurity0069"/>&nbsp;<w:date format="yyyy-MM-dd" id="transact_date_to" name="transact_date_to" width="80px"/>
          </td>
          <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0067"/></td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("security_status_bd1", -1,"SECURITY_STATUS_BD", "","", false)%></td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0035"/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="stop_date_from" width="80px"/>&nbsp;<fmt:message key="listQueryOffsiteSocialSecurity0069"/>&nbsp;<w:date format="yyyy-MM-dd" name="stop_date_to" width="80px"/>
            </td>
          <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0034"/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_date_from" width="80px"/>&nbsp;<fmt:message key="listQueryOffsiteSocialSecurity0069"/>&nbsp;<w:date format="yyyy-MM-dd" name="apply_date_to" width="80px"/>
            </td>
          <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0065"/></td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_by1", -1,"SORT_BY1", "","", false)%></td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteSocialSecurity0001"/></td>
            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_order", -1,"SORT_ORDER", "","", false)%></td>
              <td>
                 <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             </td>
             <td>   
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
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
		             <input class="a_2" type="button"   value="<fmt:message key="listQueryOffsiteSocialSecurity0033"/>"  <au:authorityBtn code="view_orderItem19" type="1"/>  onClick="detail_onClick();">
                     <input class="a" type="button"   value="<fmt:message key="listQueryOffsiteSocialSecurity0063"/>"  <au:authorityBtn code="ydsbcx_view" type="1"/>  onClick="detail_Click();">
                     <input class="e" type="button"   value="<fmt:message key="listQueryOffsiteSocialSecurity0031"/>"  <au:authorityBtn code="ydsbcx_exp" type="1"/>  onClick="exportToExcel();">
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=listQueryOffsiteSocialSecurity"
        width="98%"
        height="320px"
        xpath="QuerySocialSecurityVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" messagekey="listQueryOffsiteSocialSecurity0030" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="emp_code" messagekey="listQueryOffsiteSocialSecurity0012">
               <h:text/>   
           </r:field>    
          <r:field fieldName="emp_name" messagekey="listQueryOffsiteSocialSecurity0011">
               <h:text/>   
           </r:field>    
           <r:field fieldName="group_name" messagekey="listQueryOffsiteSocialSecurity0046" allowModify="false">
                <h:text/>      
          </r:field>
          <r:field fieldName="id_card_type_bd" messagekey="listQueryOffsiteSocialSecurity0061">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="id_card" messagekey="listQueryOffsiteSocialSecurity0090">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" messagekey="listQueryOffsiteSocialSecurity0041">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey="listQueryOffsiteSocialSecurity0072">
            <h:text/>
          </r:field>
          <r:field fieldName="big_name" messagekey="listQueryOffsiteSocialSecurity0029">
            <h:text/>
          </r:field>
          <r:field fieldName="small_name" messagekey="listQueryOffsiteSocialSecurity0028">
            <h:text/>
          </r:field>
          <r:field fieldName="hire_unit_short_name" messagekey="listQueryOffsiteSocialSecurity0070">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_man" messagekey="listQueryOffsiteSocialSecurity0059">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_date" messagekey="listQueryOffsiteSocialSecurity0009">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="type_name_new" messagekey="listQueryOffsiteSocialSecurity0089">
            <h:text/>
          </r:field>
          <r:field fieldName="transact_remarks" messagekey="listQueryOffsiteSocialSecurity0057">
            <h:text/>
          </r:field>
          <r:field fieldName="start_month" messagekey="listQueryOffsiteSocialSecurity0025">
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" messagekey="listQueryOffsiteSocialSecurity0056">
            <h:text/>
          </r:field>
          <r:field fieldName="fund_month" messagekey="listQueryOffsiteSocialSecurity0024">
            <h:text/>
          </r:field>
          <r:field fieldName="pay_base" messagekey="listQueryOffsiteSocialSecurity0023">
            <h:text/>
          </r:field>
          <r:field fieldName="security_status_bd" messagekey="listQueryOffsiteSocialSecurity0067">
            <d:select dictTypeId="SECURITY_STATUS_BD" />
          </r:field>
          <r:field fieldName="stop_date" messagekey="listQueryOffsiteSocialSecurity0035">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="stop_man" messagekey="listQueryOffsiteSocialSecurity0055">
            <h:text/>
          </r:field>
          <r:field fieldName="type_name_stop" messagekey="listQueryOffsiteSocialSecurity0086">
            <h:text/>
          </r:field>
          <r:field fieldName="stop_remarks" messagekey="listQueryOffsiteSocialSecurity0022">
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

<script language="javascript">
citySecurityGroupchange1("1099110100000000357","1");
</script>	
