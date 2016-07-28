<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.search.search_resource" prefix="rayoo.salary.search.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        var _now = new Date();
        var y =  _now.getFullYear();
        jQuery("#"+y).attr("selected",true);
        $id("dc_searchtwelveid").isQueryFirst = false;
    });
    function customer_change(){
       var cust_id = $id("customer_id") ;
       var cust_name = $id("lk_clz") ;
        if(cust_id.value == "" || cust_id.value == null || cust_name.value == "" || cust_name.value == null){
            alert("请通过弹出窗口选择客户名称");
            return false;
        }
    }
    function toselect_onclick() { 
        if(customer_change() == false){
            return false;
        }
        $id("dc_searchtwelveid").reload() ;
    }
    
    function exportWord(){
         if(customer_change() == false){
            return false;
        }
        var cust_id = $id("customer_id").value;
        var cust_name = $id("lk_clz").value ;
        var year = $id("year").value;
        var flag = false;
        _$.ajax({
             type: "POST",
             url:  "<%=request.getContextPath()%>/SalarySearchAction.do?cmd=SearchSalaryByTwelveStatus",
             data: {customer_id:cust_id,year:year},
             dataType: "html",
             async: false,
             success: function(data){
                if(data == '1'){
                    flag= true;
                }else{
                    alert("没有符合数据的文件生成,请核对后再操作");
                }
             }
         });
         if(flag){
            window.location.href="<%=request.getContextPath()%>/SalarySearchAction.do?cmd=exportWord2&customer_id="+cust_id+"&customer_name="+cust_name+"&year="+year;
         }
    }
        
    function exportWord2(){
         if(customer_change() == false){
            return false;
        }
        var cust_id = $id("customer_id").value;
        var cust_name = $id("lk_clz").value ;
        var year = $id("year").value;
        window.location.href="<%=request.getContextPath()%>/SalarySearchAction.do?cmd=exportWord2&customer_id="+cust_id+"&customer_name="+cust_name+"&year="+year;
    }
    
    function exportExcel(){
         if(customer_change() == false){
            return false;
        }
        var formid = $id("datacell_formid") ;
        formid.action = "<%=request.getContextPath()%>/SalarySearchAction.do?cmd=exportSalarySearchTwelve";
        formid.submit() ;
    }
     function rtnFuncsalarysearch(arg){
        var lookup = $id("sa_calss_name");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];  
        return false;
    }
    //选择客户
    function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    jQuery("#customer_id").val(arg[0]);
    return false;
}
</script>
</head>
<body>
<form name="datacell_formid" id="datacell_formid"  action="" method="post"> 
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='120thousand'/></div></div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td rowspan="2" width="135" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div></td>
           <td width="60"><span class="style_required_red">*</span><fmt:message key='customer_name'/></td>
            <td width="220">
                <w:lookup name="customer_name" style="width:170" onReturnFunc="rtnFunc" readonly="true" 
                id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="600"/>
                <input type="hidden" name="customer_id" id="customer_id"/>
            </td>
        <td width="60"><span style="color: red">*</span><fmt:message key='year_'/></td>
        <td width="220"><span class="td_2">
          <select name="year" class="sSelect" id="year">
           <option value=""><fmt:message key='please_select'/></option>
            <%
            for(int y=2000;y<=2030;y++){
                %>
                <option id="<%=y %>" value="<%=y %>"><%=y %></option>
                <%} %>
          </select>
        </span></td>
        </tr>
      <tr>
        <!--<td width="60"><span style="color: red">*</span><fmt:message key='salary_item'/></td>
        <td width="220">
        <select name="field" class="sSelect" id="field">
           <option value="3" selected><fmt:message key='salary_item_3'/></option>
           <option value="4"><fmt:message key='salary_item_4'/></option>
        </select>
        <span class="td_2">
         <w:lookup onReturnFunc="rtnFuncsalarysearch" readonly="false" id="sa_calss_name" name="sa_calss_name" 
         lookupUrl="/SaleryitemAction.do?cmd=toSalartClzLookup" dialogTitle="选择薪资项目" height="440" width="600"  style="width:170px"/>
        </span>
         </td>-->
        <td width="60"></td>
       <td width="220"></td>
        <td width="60"><input type="button" onclick="toselect_onclick()" class="icon_1" value="<fmt:message key='button_search'/>" /></td>
        <td width="220">
        <input type="button" onclick="exportWord()" <au:authorityBtn code="nsr12w_exp" type="1"/>  class="icon_2" style="width:95" value="下载12万申报文件" />&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" class="icon_2" onclick="exportExcel()" <au:authorityBtn code="nsr12w_exp" type="1"/> value="<fmt:message key='button_export_exl'/>" /></td>
      </tr>
      </table>
  </div>
    <!--查询 end-->
    <!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div  id="values_div" >
      <div style="padding: 8 10 8 8;">
        <r:datacell id="dc_searchtwelveid"
            queryAction="/FAERP/SalarySearchAction.do?cmd=SearchSalaryByTwelve"
            submitAction="/FAERP/SalarySearchAction.do?cmd=insertSeachSalaryByTwelve"
            width="98%" xpath="SalarySearchTwelveVo" submitXpath="SalarySearchTwelveVo"
            pageSize="100"
            paramFormId="datacell_formid" height="320px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="emp_name" messagekey="emp_name" width="100px">
            </r:field>
            <r:field fieldName="id_card_type_bd" messagekey="id_card_type_bd" width="100px" allowModify="false">
                <!--<d:select dictTypeId="ID_CARD_TYPE_BD"/>-->
            </r:field>          
            <r:field fieldName="id_card" messagekey="id_card" width="150px">
            </r:field>          
            <r:field fieldName="mobile" messagekey="mobile" width="100px">
            </r:field>          
            <r:field fieldName="customer_name" messagekey="customer_name" width="150px">
            </r:field>          
            <r:field fieldName="def4" messagekey="def4" width="100px">
            </r:field>          
            <r:field fieldName="def6" messagekey="def6" width="100px">
            </r:field>          
            <r:field fieldName="def3" messagekey="def3" width="100px">
            </r:field> 
            <r:field fieldName="back_wage" label="倒算工资收入" width="100px">
            </r:field>      
             <r:field fieldName="def41" label="工资收入扣税" width="100px">
            </r:field> 
            <r:field fieldName="def24" label="年终奖" width="100px">
            </r:field>  
            <r:field fieldName="def48" label="年终奖扣税" width="100px">
            </r:field>  
            <r:field fieldName="def38" label="离职补偿金" width="100px">
            </r:field>  
            <r:field fieldName="def46" label="离职补偿金扣税" width="100px">
            </r:field>  
            <r:field fieldName="def40" label="劳务费" width="100px">
            </r:field> 
            <r:field fieldName="def39" label="劳务报酬税" width="100px">
            </r:field>  
            <r:field fieldName="back_tax_able" label="倒算应税总额" width="100px">
            </r:field>
            <r:field fieldName="count_mouth" label="月份总数统计" width="100px">
            </r:field>     
        </r:datacell>
</div>    
  </div>
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>