<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>薪资数据查询</title>
<script language="javascript">

  function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }

       function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='" + 
              value + "' erpbatchId='" + entity.getProperty("erp_batch_id") + 
              "' is_export='" + entity.getProperty("is_export") +  
              "' pay_state='" + entity.getProperty("pay_state") + 
              "' cust_id='" + entity.getProperty("cust_id") + 
              "' id='checkbox_"+value+"'>";
    }
    
    function simpleQuery_onClick(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
   
   
    function showErr_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var is_export = jQuery("#checkbox_" + ids).attr("is_export");
        if (is_export == 2){
            alert("当前批次已完全导入成功！");
            return false;
        }
        
        var url="<%=request.getContextPath()%>/PpsSaDataErrAction.do?cmd=queryAll&ids=" + ids;
        showModalCenter(url, window, "", 850, 350, "查看导入异常数据"); 
   }
   
   //跳转到查看页面
   function toDetail_onClick(){
     var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/PpssasalarybatchAction.do?cmd=list2item&batch_id="+ids+"&_ts="+(new Date()).getTime();
        form.submit();
   }
   
   
 //支付
   function play_onClick(){
     var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
          var is_export = jQuery("#checkbox_" + ids).attr("is_export");
             var pay_state = jQuery("#checkbox_" + ids).attr("pay_state");
   
       if(pay_state==1){
        alert('已经支付过,不可以再次支付');
        return false;
        }
        if (is_export != 0){
            alert("当前批次不是未导入状态,不可以在此进行支付");
            return false;
        } 
      
        
        _$.ajax({
       type: "POST",
       url: "<%=request.getContextPath()%>" + "/PpssasalarybatchAction.do?cmd=play&id="+ids,
      
       dataType: "html",
       success: function(msg){
         alert(msg);
         
       }
    });
          
         
   } 
   
   function updateAutoImpPPSEmpToErp(){
      var ids = findSelections("checkbox_template","id"); 
       if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
         _$.ajax({
       type: "POST",
       url: "<%=request.getContextPath()%>" + "/PpssasalarybatchAction.do?cmd=updateAutoImpPPSEmpToErp&batchId="+ids,
      
       dataType: "html",
       success: function(msg){
         alert(msg);
         
       }
    });
        
   
   }
   
   function import_onClick(){
       var ids = findSelections("checkbox_template","id"); 
       if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var erpBatchId = jQuery("#checkbox_" + ids).attr("erpbatchId");
        var is_export = jQuery("#checkbox_" + ids).attr("is_export");
        
        
                var pay_state = jQuery("#checkbox_" + ids).attr("pay_state");
   
       if(pay_state==1){
        alert('已经支付过,不可以导入到ERP了');
        return false;
        } 
        
        if (is_export == 2){
            alert("当前批次已完全导入成功！");
            return false;
        }
        
        if (erpBatchId && erpBatchId != 'null'){
            jQuery("#import_button").attr('disabled', 'disabled');
	        url = "<%=request.getContextPath()%>/PpssasalarybatchAction.do?cmd=importErpSalary" 
	            + "&batchId=" + ids;
	
            jQuery.post(url,function(msg){
	            alert(msg);
	            jQuery("#import_button").removeAttr('disabled');
	            simpleQuery_onClick();
            });
        }else{
	        var url="<%=request.getContextPath()%>/PpssasalarybatchAction.do?cmd=importErpSalarySubmitPage&ids=" + ids;
	        showModalCenter(url, window, simpleQuery_onClick, 450, 250, "导入PPS薪资数据"); 
        }
   }
   
   function exportSalaryDetail(){
	    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
	    $id("datacell_formid").action = "<%=request.getContextPath()%>/PpssasalarydataAction.do?cmd=expSalaryDetail&batchId="+ids ;
	    $id("datacell_formid").submit();
   }
   
//按照户和批次同步PPS数据
function syncPPSData(type){
        //type 1 按批次获取 2按客户获取
        var custId = null;     
        var ppsBatchId = null;   
	    switchBtn(true);
        
        if(type == 1){
            ppsBatchId = findSelections("checkbox_template","id");  //PPS批次id
	        custId = jQuery("#checkbox_" + ppsBatchId).attr("cust_id");//PPS客户id
	        
	        if(ppsBatchId == null || ppsBatchId == "") {  //如果ids为空
	            alert('<fmt:message key="select_one_record"/>');
	            switchBtn(false);
	            return;
	        }
	        if(ppsBatchId.length > 1) {  //如果ids有2条以上的纪录
	            alert('<fmt:message key="only_can_a_record"/>');
	            switchBtn(false);
	            return;
	        }
	        
        }else if(type == 2){
            custId =  jQuery("#cust_a_id").val();//选择的客户id
        }
        
        if(custId == null || custId == ""){
            alert("客户id为空！");
            switchBtn(false);
            return;
        }
        
        jQuery.ajax({
            type: "post",
            url: "<%=request.getContextPath()%>" + "/Pps_erp_cust_relationAction.do?cmd=syncPPSData&custId="+custId+"&ppsBatchId="+ppsBatchId+"&type="+type,
            dataType: "html",
            success: function(msg){
              alert(msg);
              simpleQuery_onClick();
              switchBtn(false);
            }
        });
}

function switchBtn(state){
        jQuery("#syncPPSBatchDataBtn").attr("disabled",state);
        jQuery("#syncPPSCustDataBtn").attr("disabled",state);
}

</script>
</head>
<body>

    <form name="form" method="post" id="datacell_formid" >
        <input type="hidden" name="cmd" value="queryAll" /> 
        <input type="hidden"  name="backFlag" id="backFlag" value="true">
         <input  type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
  <div id="right"><script language="javascript">
    writeTableTopFesco('薪资数据查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">


    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>

            <td />
            <td />
            <td></td>
            <td />
        </tr>
        <tr>
          <td class="td_1" >PPS客户</td>
            <td class="td_2"  >
           <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true"  id="lk_cust" lookupUrl="/PpssasalarytempletAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"  />
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
                <input type="hidden" name="customer_code" id="customer_code"/>
            </td>
        <td align="left">是否导入完整</td>
            <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_export", -1,"PPS_SA_DATA_FLAG","","",false) %>
            </td>
            <td align="left" colspan="2">
            <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"/> 
            <input type="reset" class="icon_1" />
            </td>
        </tr>
    </table>
    </div>


    <div id="ccParent1" class="button">
    <div class="button_right">
        <input class="a" type="button" value="<fmt:message key="view"/>"onClick="toDetail_onClick();">
        <input class="xz_1" type="button" value="导出薪资数据 " onClick="exportSalaryDetail();"> 
        <input class="e" id="import_button" type="button" value="导入" onClick="import_onClick();">
        <input class="a_2" type="button" value="查看异常数据 " onClick="showErr_onClick();"> 
        <input class="xz_1" type="button" value="同步员工信息 " onClick="updateAutoImpPPSEmpToErp();"> 
        <input class="xz_1" title="线下发放，使员工自助查询系统可以查询到薪资数据" id="pay_button" type="button" value="虚拟发放" onClick="play_onClick();">
        <input class="c_4" type="button" id="syncPPSBatchDataBtn" value="按批次同步PPS数据" <au:authorityBtn code="ppsXzdrSyncBatchData" type="1"/> onClick="javascript:syncPPSData(1);">
        <input class="c_4" type="button" id="syncPPSCustDataBtn" value="按客户同步PPS数据" <au:authorityBtn code="ppsXzdrSyncCustData" type="1"/> onClick="javascript:syncPPSData(2);"> 
        
        
    </div>
    <div class="clear"></div>
    </div>

    <div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
        queryAction="/FAERP/PpssasalarybatchAction.do?cmd=queryPpsSalaryBatch"
        width="98%" height="318px" xpath="PpssasalarybatchVo"
        paramFormId="datacell_formid" >
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center"></r:field>
        <r:field fieldName="cust_name" label="客户名称" width="250px"></r:field>
        <r:field fieldName="salary_templet_name" label="模版名称"  allowModify="false" width="110px"></r:field>
        <r:field fieldName="pay_year_month" label="月份" width="110px"></r:field>
        <r:field fieldName="total_number" label="总人数" width="50px"></r:field>
 
        <r:field fieldName="is_export" label="是否导入完整" width="90px" >
        <d:select dictTypeId="PPS_SA_DATA_FLAG" />
        </r:field>
    <r:field  fieldName="pay_state" label="发放状态" allowModify="false">
                <h:select name="list_pay_state" property="pay_state">
                   <h:option value="0" label="待发放"></h:option>
                   <h:option value="1" label="已发放"></h:option>
                </h:select>
              </r:field>
             <r:field  fieldName="real_pay_day" label="实际发放日" allowModify="false">
              	<w:date format="yyyy-mm-dd" property="real_pay_day"/>
              </r:field>  
        <r:field fieldName="erp_batch_code" label="ERP批次号" width="100px" ></r:field>
        <r:field fieldName="erp_pay_year_month" label="ERP应发年月" width="70px" ></r:field>
        <r:field fieldName="erp_cust_name" label="ERP客户名称" width="180px" ></r:field>
        <r:field fieldName="erp_cust_code" label="ERP客户编号" width="70px" ></r:field>
    </r:datacell></div>

    </div>
    </div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);       
    jQuery("#cust_a_name").val(arg[2]);     
    jQuery("#customer_code").val(arg[1]);   
    return false;
}
</script>   
