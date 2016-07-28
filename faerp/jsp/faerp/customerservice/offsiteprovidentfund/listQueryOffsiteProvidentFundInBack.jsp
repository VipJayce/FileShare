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
<fmt:bundle basename="rayoo.customerservice.custservice.offsiteprovidentfund.listQueryOffsiteProvidentFundInBack_resource" prefix="auto.">
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
	       alert("<fmt:message key="listQueryOffsiteProvidentFundInBack0000"/>");
	       return;
	    }else{
	       if(fund_month.length != 6){
	           alert("<fmt:message key="listQueryOffsiteProvidentFundInBack0047"/>");
	           return;
	       }
	       var year = fund_month.substring(0,4);
	       var month = fund_month.substring(4,6);
	       if(year<2000 || year>2030 || month<1 || month>12){
	           alert("<fmt:message key="listQueryOffsiteProvidentFundInBack0078"/>");
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
        var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQueryInBack&supplyId=" + supplyId+"&securityId="+securityId+"&types=offsite_provident_fund_in_back";
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看详细');
        //$id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailQueryInBack&supplyId=" + supplyId+"&securityId="+securityId+"&types=offsite_provident_fund_in_back";
        //$id("datacell_formid").submit();
	}
	
	//导出
    function exportToExcel(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportQueryInBackToExcel&para=offsite_provident_fund_in_back";
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
<input type="hidden" id="groupid" name="groupid" value=""/>
 
<div id="right">
<script language="javascript">
writeTableTopFesco('<fmt:message key="listQueryOffsiteProvidentFundInBack0079"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
           <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="listQueryOffsiteProvidentFundInBack0080"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0046"/></td>
            <td align="left">
                 <select id="security_group_id" name="security_group_id" ></select>
            </td>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0012"/></td>
            <td align="left">
               <input type="text" class="text_field_reference_readonly" id="group_range" name="group_range" inputName="<fmt:message key="listQueryOffsiteProvidentFundInBack0012"/>" readonly="readonly"/>            </td>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0011"/></td>
            <td align="left">
               <input type="text" class="text_field" name="fund_month" id="fund_month" inputName="<fmt:message key="listQueryOffsiteProvidentFundInBack0011"/>" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/></td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0010"/></td>
            <td align="left"><faerp:SoialunitSelectTag  tagname="social_unit_id"  beanname="social_unit_id" style="width:200px"/>  </td>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0073"/></td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="<fmt:message key="listQueryOffsiteProvidentFundInBack0073"/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0041"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="<fmt:message key="listQueryOffsiteProvidentFundInBack0041"/>" maxLength="10"/>            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0072"/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="<fmt:message key="listQueryOffsiteProvidentFundInBack0072"/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0040"/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="<fmt:message key="listQueryOffsiteProvidentFundInBack0040"/>" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0071"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="<fmt:message key="listQueryOffsiteProvidentFundInBack0071"/>" maxLength="64"/>           </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0070"/></td>
            <td align="left">
                <input type="text" class="text_field" id="cust_name1" name="cust_name1"  validators="isSearch" inputName="<fmt:message key="listQueryOffsiteProvidentFundInBack0070"/>" maxLength="50"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getbyid();"/>            </td>
           <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0067"/></td>
           <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("security_status_bd1", -1,"SECURITY_STATUS_BD", "","", false)%></td>
            <td align="right"><fmt:message key="listQueryOffsiteProvidentFundInBack0009"/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="create_date_from" width="80px"/>&nbsp;<fmt:message key="listQueryOffsiteProvidentFundInBack0069"/>&nbsp;<w:date format="yyyy-MM-dd" name="create_date_to" width="80px"/>
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
				<!--<ul>
					<li class="a">      <a onClick="javascript:detail_Click();">查看</a></li>
                    <li class="e">      <a onclick="javascript:exportToExcel();">导出</a></li>
				</ul>
		 -->
		  <input class="a" type="button"   value="<fmt:message key="listQueryOffsiteProvidentFundInBack0063"/>"  <au:authorityBtn code="ydgjjbjcx_view" type="1"/>  onClick="detail_Click();">
          <input class="e" type="button"   value="<fmt:message key="listQueryOffsiteProvidentFundInBack0031"/>"  <au:authorityBtn code="ydgjjbjcx_exp" type="1"/>  onClick="exportToExcel();">
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=listQueryOffsiteProvidentFundInBack"
        width="98%"
        height="320px"
        xpath="QuerySocialSecurityVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" messagekey="listQueryOffsiteProvidentFundInBack0030" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="emp_name" messagekey="listQueryOffsiteProvidentFundInBack0041">
               <h:text/>   
           </r:field>    
          <r:field fieldName="emp_code" messagekey="listQueryOffsiteProvidentFundInBack0073">
               <h:text/>   
           </r:field>    
           <r:field fieldName="group_name" messagekey="listQueryOffsiteProvidentFundInBack0046" allowModify="false">
                <h:text/>      
          </r:field>
          <r:field fieldName="id_card" messagekey="listQueryOffsiteProvidentFundInBack0090">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" messagekey="listQueryOffsiteProvidentFundInBack0071">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey="listQueryOffsiteProvidentFundInBack0070">
            <h:text/>
          </r:field>
          <r:field fieldName="internal_code" messagekey="listQueryOffsiteProvidentFundInBack0072">
            <h:text/>
          </r:field>
          <r:field fieldName="hire_unit_short_name" messagekey="listQueryOffsiteProvidentFundInBack0010">
            <h:text/>
          </r:field>
          <r:field fieldName="start_month" messagekey="listQueryOffsiteProvidentFundInBack0035">
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" messagekey="listQueryOffsiteProvidentFundInBack0034">
            <h:text/>
          </r:field>
          <r:field fieldName="month_num" messagekey="listQueryOffsiteProvidentFundInBack0065">
            <h:text/>
          </r:field>
          <r:field fieldName="pay_base" messagekey="listQueryOffsiteProvidentFundInBack0001">
            <h:text/>
          </r:field>
          <r:field fieldName="money" messagekey="listQueryOffsiteProvidentFundInBack0033">
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" messagekey="listQueryOffsiteProvidentFundInBack0061">
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" messagekey="listQueryOffsiteProvidentFundInBack0029">
            <h:text/>
          </r:field>
          <r:field fieldName="create_date" messagekey="listQueryOffsiteProvidentFundInBack0009">
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

<script language="javascript">
citySecurityGroupchange1("1099110100000000357","2");
</script>	
