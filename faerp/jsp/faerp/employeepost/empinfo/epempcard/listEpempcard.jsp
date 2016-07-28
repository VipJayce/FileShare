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
<%String companyID = request.getAttribute("companyID")==null?"":request.getAttribute("companyID").toString(); %>
<fmt:bundle basename="rayoo.employeepost.empinfo.epempcard.epempcard_resource" prefix="rayoo.employeepost.empinfo.epempcard.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("eid")+"\",\""+entity.getProperty("emp_post_id")+"\");>";
    }
    
    function ClickRow(value,value1,value2){
        $id("card_id").value = value;
        $id("emp_id").value = value1;
        $id("emp_post_id").value = value2;
    }

    //修改
    function findCheckbox_onClick() {
        var card_id = $id("card_id").value;
        var emp_post_id = $id("emp_post_id").value;
        var emp_id = $id("emp_id").value;
        if((emp_post_id!=null && emp_post_id!="") || (emp_id!=null && emp_id!="")){
	        jQuery.ajax({
	            type : "post",
	            url : "<%=request.getContextPath()%>/EpempcardAction.do?cmd=checkIsValid&id="+emp_post_id+"&card_id="+card_id+"&eid="+emp_id,
	            dataType : "html",
	            success : function(data) {
	                if(data == null || data == "" || data == "0") {
	                    alert("<fmt:message key="card_has_expired_can_not_modify"/>");
	                    return;
	                }else{
	                   window.open('<%=request.getContextPath()%>/EpempcardAction.do?cmd=find&card_id='+card_id+'&id='+emp_post_id+'&eid='+emp_id,'','height=400px,width=950px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改银行卡信息');
	                    //showModalCenter('<%=request.getContextPath()%>/EpempcardAction.do?cmd=find&id='+card_id,window,refesh,950,400,"修改银行卡信息");
	                }
	            }
	        });
        }else{
            alert("<fmt:message key="select_one_record"/>");
            return;
        }
    }
    
    //撤销
    function deleteMulti_onClick(){
        var card_id = $id("card_id").value;
        var emp_post_id = $id("emp_post_id").value;
        var emp_id = $id("emp_id").value;
        if(card_id!=null && card_id!=""){
	        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	            jQuery.ajax({
		            type : "post",
		            url : "<%=request.getContextPath()%>/EpempcardAction.do?cmd=deleteMulti&card_id="+card_id+"&id="+emp_post_id+"&eid="+emp_id,
		            dataType : "html",
		            success : function(data) {
		                if(data != null && data != "") {
                            if(data == "0"){
                                alert("<fmt:message key="card_has_expired_can_not_undone"/>");
                                return;
                            }else if(data == "1"){
                                alert("<fmt:message key="undone_succese"/>");
                                simpleQuery_onClick();
                            }
		                }
		            }
		        });
	        }
        }else{
            alert("<fmt:message key="select_one_record"/>");
            return;
        }
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function toAdd_onClick() {  //到增加记录页面
        window.open('<%=request.getContextPath()%>/jsp/faerp/employeepost/empinfo/epempcard/insertEpempcard.jsp?companyID=<%=companyID%>','','height=400px,width=950px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增银行卡信息');
        //showModalCenter('<%=request.getContextPath()%>/jsp/faerp/employeepost/empinfo/epempcard/insertEpempcard.jsp',window,refesh,950,400,"新增银行卡信息");
    }
    
    function refesh(ref){
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    //跳转导入错误信息
    function showError_onClick(){
       $id("datacell_formid").action="<%=request.getContextPath()%>/EpempcarderrAction.do?cmd=queryAll";
       $id("datacell_formid").submit();
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        //jQuery("#h_customer_name").val(arg[2]);
        return false;
    }

    //模板下载
    function toDownLoad_onclick(){
      window.location="<%=request.getContextPath()%>/EpempcarderrAction.do?cmd=downLoad" ;
    }
    
    //魏佳新增，导出员工银行卡信息excel
    function exportCardInfo() {
        var bank_type_bd = document.getElementById("bank_type_bd1").value;
        var form = $id("datacell_formid");
        form.action=" <%=request.getContextPath() %>/EpempcardAction.do";
        document.getElementById("bank_type_bd_export").value=bank_type_bd;
        document.getElementById("cmd").value="exportAllCardInfo";
        form.submit();
    }
</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" name="cmd" id="cmd" value="">
<input type="hidden" name="cmd" id="bank_type_bd_export" value="">
<input type="hidden" name="card_id" id="card_id">
<input type="hidden" name="emp_id" id="emp_id">
<input type="hidden" name="emp_post_id" id="emp_post_id">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="epempcard_protect"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="10"/>            </td>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="证件号码" maxLength="64"/>            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="cust_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="64"/>           </td>
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer" name="cust_name1"  id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
                <!-- <input type="hidden" name="cust_name1" id="h_customer_name" value=""/>  -->
            </td>
            <td align="right"><fmt:message key="internal_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="客户方编号" maxLength="64"/>            </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key="bank_type"/></td>
          <td align="left"><%if("1099100700000000005".equals(companyID)){ %>
          <d:select name="bank_type_bd1" id="bank_type_bd1" dictTypeId="BANK_TYPE_BD" filterOp="in" filterStr="0,1,2" nullLabel="--请选择--" style="width: 205px" /> 
          <%}else{ %>
          <d:select name="bank_type_bd1" id="bank_type_bd1"  dictTypeId="BANK_TYPE_BD" nullLabel="--请选择--" style="width: 205px" />
          <%} %></td>
            <td align="right"><fmt:message key="bank_card_status"/></td>
            <td align="left">
                <select id="is_valid1" name="is_valid1" >
                    <option value="1"><fmt:message key="valid"/></option>
                    <option value="0"><fmt:message key="no_valid"/></option>
                 </select>
            </td>
            <td align="right"><fmt:message key="account"/></td>
            <td align="left">
                <input type="text" class="text_field" name="account_num1" inputName="账号" maxLength="64"/>            </td>
        </tr>
        <tr>
	        <td align="right">输入开始时间</td>
	        <td align="left">
	               <w:date format="yyyy-MM-dd" id="inputBeginTime" name="inputBeginTime" width="189px"/>
	        </td>
            <td align="right">输入结束时间</td>
            <td align="left">
                    <w:date format="yyyy-MM-dd" id="inputEndTime" name="inputEndTime" width="189px"/>
            </td>
            <td align="right">&nbsp;</td>
            <td align="left">&nbsp;</td>
        </tr>
        <tr>
              <td colspan="4"><p style="color: red;">&nbsp;&nbsp;<fmt:message key="notices"/></p></td>
              <td>
                <input name="button_ok" id="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             </td>
             <td>   
               &nbsp;&nbsp;&nbsp; <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
        </tr>
    </table>
</div>
                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();">撤销</a> </li>
                    <li class="p_1">    <a id="importCard"  href="###">导入</a> </li>
                    <li class="p_1">    <a onClick="javascript:showError_onClick();">查看导入错误信息</a> </li>
                </ul>
         -->
				<input type="button" class="c" value='<fmt:message key="insert"/>' <au:authorityBtn code="ygyhk_add" type="1"/> onClick="toAdd_onClick();" />
				<input type="button" class="b" value='<fmt:message key="update"/>' <au:authorityBtn code="ygyhk_modify" type="1"/> onClick="findCheckbox_onClick();" />
				<input type="button" class="d" value='<fmt:message key="revocation"/>' <au:authorityBtn code="ygyhk_cx" type="1"/> onClick="deleteMulti_onClick();" />
				<input type="button"  class="p_1" value='<fmt:message key="downlord_templete"/>'   <au:authorityBtn code="ygyhk_dall" type="1"/>  onClick="toDownLoad_onclick();"   />
				<input type="button" class="e_1" id="importCard"  value='<fmt:message key="imp"/>' <au:authorityBtn code="ygyhk_dall" type="1"/>  />
				<input type="button" class="p_1" value='<fmt:message key="look_imp_error_info"/>'  <au:authorityBtn code="ygyhk_dall" type="1"/>  onClick="showError_onClick();" />
				<input type="button" class="e_1" id="exportCard" value="导出"  onClick="exportCardInfo();" />
         </div>
           <div class="clear"></div>            
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EpempcardAction.do?cmd=searchEpempcardData"
        width="98%"
        height="320px"
        xpath="EpempcardVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="emp_name" messagekey="emp_name">
            <h:text/>
          </r:field>
          <r:field fieldName="emp_code" messagekey="emp_code">
               <h:text/>   
           </r:field>    
          <r:field fieldName="id_card" messagekey="emp_card_no1" width="180px">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey="cust_name" width="180px">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" messagekey="cust_code">
            <h:text/>
          </r:field>
          <r:field fieldName="bank_name" messagekey="bank_name">
               <h:text/>
           </r:field>
          <r:field fieldName="account_num" messagekey="account" width="180px">
               <h:text/>
           </r:field>
          <r:field fieldName="account_name" messagekey="account_name">
               <h:text/>
           </r:field>
          <r:field fieldName="province_name" messagekey="province_name">
               <h:text/>
           </r:field>
          <r:field fieldName="city_area_name" messagekey="city_area_name">
               <h:text/>
           </r:field>
          <r:field fieldName="bank_type_bd" messagekey="bank_type">
            <d:select dictTypeId="BANK_TYPE_BD" />
          </r:field>
          <r:field fieldName="city_code" messagekey="city_code">
            <h:text/>
          </r:field>
          <r:field fieldName="is_valid" messagekey="bank_card_status">
            <d:select dictTypeId="BANK_STATUS" />
          </r:field>
          <r:field fieldName="create_user_id" messagekey="check_in_user">
	      </r:field>
	      <r:field fieldName="create_date" messagekey="check_in_date" allowModify="false">
	        <w:date format="YYYY-DD-MM"/>
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
jQuery(document).ready(function(){
    jQuery("#importCard").bind("click", function(){
       vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/employeepost/empinfo/epempcard/importExcel.jsp", "", "dialogWidth=600px; dialogHeight=250px");
       if (vReturnValue == '1') {
            jQuery("#button_ok").click();
       }
      }
    );
});


//初始化不加载页面信息<siqp添加>
_$(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>   
