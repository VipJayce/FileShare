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
<fmt:bundle basename="rayoo.employeepost.eppartyfee.eppartyfee_resource" prefix="rayoo.employeepost.eppartyfee.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function simpleQuery_onClick(){  //简单的模糊查询
        var reg = new RegExp("^[1-9]{1}[0-9]{3}((0[1-9]{1})|(1[0-2]{1}))$");
        var start_date = $id("start_date").value;
        var end_date = $id("end_date").value;
        if(start_date!=null&&start_date!="")
        {
            if(!reg.test(start_date))
            {
                alert("<fmt:message key="date_format_false"/>");
                return;
            }
        }
        if(end_date!=null&&end_date!="")
        {
            if(!reg.test(end_date))
            {
                alert("<fmt:message key="date_format_false"/>");
                return;
            }
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
     function save(){
        $id("datacell1").submit();
        alert("<fmt:message key="save_ok"/>");
        $id("datacell1").refresh();
    }
    
    function exportToExcel() {  
       if(confirm('<fmt:message key="is_export_date"/>')) {
           form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?cmd=PaypartyfeeexportToExcel";
           form.submit();
        }
     }
    
     function importToExcel() {
	       var url="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/importExcel.jsp";
	       showModalCenter(url, window,modifyfee,600,250,"导入");
	  }
	  
      function modifyfee(){
          $id("datacell1").loadData();
          $id("datacell1").refresh();
	  }
	  
	  function queryerror() {  
	      var url="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/showerror.jsp";
	      showModalCenter(url, window,'',750,345,"导入错误查看");
	  }
	  
	   //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        //document.getElementById('query_cust_name').value = arg[2];
        //jQuery("#customer_id").val(arg[0]);        
        return false;
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/EppartyfeeAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">

   <div class="ringht_x">
   <div class="box_tab">
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><fmt:message key="emp_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="emp_name" name="emp_name" inputName="姓名" value="" style="width:240px"/>
            </td>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
            <td class="td_2" >
                <w:lookup name="cust_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_cust" height="440" width="600"  style="width:195px"/>
             </td>

        </tr>
          <tr>
            <td class="td_1" ><fmt:message key="view_branch"/></td>
            <td class="td_2 ">
                    <r:comboSelect id="partyCode" name="partyCode"  queryAction="/FAERP/EppartycomponentAction.do?cmd=getPartyCode"
                       textField="party_name" valueField="id" xpath="EppartycomponentVo" width="240px" messagekey="please_choose" />
            </td>
            <td class="td_1" ><fmt:message key="is_secretary"/></td>
            <td class="td_2" >
                    <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_secretary", -1,"IS_SECRETARY", "", " style='width:240px' ", false) %>
            </td>
        </tr>
          <tr>
            <td class="td_1" ><fmt:message key="start_month"/></td>
            <td class="td_2 ">
                  <input type="text" class="text_field" id="start_date" name="start_date" inputName="姓名" value=""  style="width:240px"/>
            </td>
            <td class="td_1" ><fmt:message key="end_month"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" id="end_date" name="end_date" inputName="姓名" value=""  style="width:240px"/>
            </td>
        </tr>
	</table>
	 <div class="dc_button">
	   <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
       <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
	 </div>
</div>
 
<div id="ccParent1" class="button"> 
<div class="button_right">
                <!--<ul>
                    <li class="bc">    <a  onClick="javascript:save();">保存</a> </li>
                    <li class="e">    <a  onClick="javascript:exportToExcel();">导出</a> </li>
                    <li class="e_1">    <a  onClick="javascript:importToExcel();">导入</a> </li>
                    <li class="a_2">    <a  onClick="javascript:queryerror();">查看导入错误</a> </li>
                </ul>
         -->
          <input type="button" class="bc" value='<fmt:message key="save"/>'   <au:authorityBtn code="dfxxwh_save" type="1"/>  onClick="save();" />
           <input type="button" class="e" value='<fmt:message key="export"/>'     onClick="exportToExcel();"/>
            <input type="button" class="e_1" value='<fmt:message key="import"/>'   <au:authorityBtn code="dfxxwh_exp" type="1"/>  onClick="importToExcel();"/>
             <input type="button" class="a_2" value='<fmt:message key="look_import_error"/>'     onClick="queryerror();" />
         </div>
           <div class="clear"></div>            
</div>					
<div>
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EppartyfeeAction.do?cmd=queryPayPartyFee"
        submitAction="/FAERP/EppartyfeeAction.do?cmd=update"
        width="100%"
        height="318px"
        xpath="EppartyfeeVo"
        submitXpath="EppartyfeeVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <!--        <r:field fieldName="id" label="操作" width="50px"  align="center">
       </r:field>    -->        
      <r:field fieldName="emp_name" messagekey="emp_name" width="100px" allowModify="false">
          <h:text />       
       </r:field>    
      <r:field fieldName="cust_name" width="320px" messagekey="cust_name"  allowModify="false">
        <h:text />
      </r:field>
      <r:field fieldName="is_secretary" width="120px" messagekey="is_secretary"  allowModify="false">
        <h:text />
      </r:field>
      <r:field fieldName="party_name" width="197px" messagekey="party_name"  allowModify="false">
        <h:text />
      </r:field>
      <r:field fieldName="start_date" messagekey="begin_month1">
         <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
      </r:field>
      <r:field fieldName="end_date" messagekey="end_month1">
         <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
      </r:field>
      <r:field fieldName="in_money" messagekey="payment_fee">
       <h:text validateAttr="type=float;message=不是数字或精度有误！;"/>
      </r:field>
      <r:field fieldName="don_money" messagekey="don_money1" >
       <h:text validateAttr="type=float;message=不是数字或精度有误！;"/>
      </r:field>
    </r:datacell>
    </div>
    </div>
</form>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">
//初始化不加载页面信息<siqp添加>
_jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
