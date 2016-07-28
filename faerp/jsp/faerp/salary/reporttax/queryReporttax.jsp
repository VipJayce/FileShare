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
<fmt:bundle basename="rayoo.salary.reporttax.reporttax_resource" prefix="rayoo.salary.reporttax.">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
</head>

<!-- liangyixiong add 20160108  -->
<style type="text/css">
@media screen and (-webkit-min-device-pixel-ratio:0) {
    #right{
        width: 100%;
        margin: 0 auto;
        height: 40%;
    }
}
</style>


<body>
    <form method="post" action="<%=request.getContextPath()%>/ReporttaxAction.do?cmd=exportEmpTaxData" name="taxformid" id="taxformid">
        <input type="hidden" name="cmd" value="">
        <div id="right">
            <script language="javascript">
                writeTableTopFesco('本次报税查询', '<%=request.getContextPath()%>/'); //显示本页的页眉
            </script>
            <div class="ringht_s">
                <div id="ccChild0" class="search">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="174" rowspan="10" style="padding-top: 0;">
                                <div class="search_title"><fmt:message key='searchTitle' /></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_1"><fmt:message key='customer_name' /></td>
                            <td class="td_2">
                                <w:lookup id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"  name="cust_id"
                                messagekey="choose_cust" height="500" width="810" style="width:195px"/>
                            </td>
                            <td class="td_1"><fmt:message key='cost_center' /></td>
                            <td class="td_2">
                               <r:comboSelect id="cost_center_id" name="cost_center_id"
                                    queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                                    textField="cost_center_name"
                                    valueField="id"
                                    xpath="CostcenterVo"
                                    width="210" messagekey="please_choose">
                                </r:comboSelect>
                            </td>
                            <td class="td_1"><fmt:message key='emp_code' /></td>
                            <td class="td_2">
                                <input type="text" class="text_field" name="emp_code" id="emp_code" style="width: 200px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="td_1"><fmt:message key='emp_name' /></td>
                            <td class="td_2">
                                <input type="text" class="text_field" name="emp_name" id="emp_name" style="width: 200px" />
                            </td>
                            <td class="td_1">
                                <fmt:message key='tax_flag' />
                            </td>
                            <td class="td_2">
                                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("tax_flag", -1, "TAX_FLAG", "", "", false)%>
                            </td>
                            <td class="td_1"><fmt:message key='tax_status' /></td>
                            <td class="td_2">
                                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("tax_status_bd", -1, "tax_status_bd", "", "", false)%>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_1"><fmt:message key='modify_status' /></td>
                            <td class="td_2">
                                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("modify_status_bd", -1, "MODIFY_STATUS_BD", "", "", false)%>
                            </td>
                            <td class="td_1">
                                <fmt:message key='tax_month1' />
                            </td>
                            <td class="td_2">
                                <input type="text" class="text_field" name="tax_month" id="tax_month" maxLength="6" style="width: 200px" />(201201)</td>
                            <td class="td_1"><fmt:message key='pay_year_month' /></td>
                            <td class="td_2">
                              <input type="text" class="text_field" name="pay_year_month" id="pay_year_month" maxLength="6" style="width: 200px" />(201201)</td>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_1"><fmt:message key='sa_batch_code' /></td>
                            <td class="td_2">
                                <input type="text" class="text_field" name="sa_batch_code" id="sa_batch_code" style="width: 200px" /></td>
                            </td>
                            <td class="td_1"><fmt:message key='rpt_month' /></td>
                            <td class="td_2">
                                <input type="text" class="text_field" name="rpt_month" id="rpt_month" maxLength="6" style="width: 200px" />(201201)</td>
                            </td>
                            <td class="td_1">发放状态</td>
                            <td class="td_2">
                                <select class="text_field" name="pay_state" id="pay_state">
                                     <option value=''>--请选择--</option>
                                     <option value='0'>待发放</option>
                                     <option value='1' selected = "selected">已发放</option>
                                </select>
                            </td>
                            <td>
                                <input name="button_ok2" class="icon_1" type="button" value="<fmt:message key='button_search'/>" onClick="javascript:showListData()">
                            </td>
                            <td>
                                <input name="button_reset2" class="icon_1" type="button" value="<fmt:message key='reset'/>" onClick="javascript:this.form.reset()">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>

    <input type="hidden" name="postid" id="postid" value="">
    <input type="hidden" name="cmd" id="cmd" value="">
    <div id="ccParent1" class="button">
        <div class="button_right">
            <input class="bc" type="button" value="<fmt:message key='save'/>" <au:authorityBtn code="qtibc" type="1"/>  onClick="update_onClick();">
            <input type="button" class="r" value="<fmt:message key='apprstate'/>"  <au:authorityBtn code="qtish" type="1"/> onclick="toSure_onClick('1');" />
            <input type="button" class="r" value="<fmt:message key='qtibh'/>"  <au:authorityBtn code="qtibh" type="1"/> onclick="toSure_onClick('2');" />
            <input class="e" type="button"   value="<fmt:message key='export'/>"  <au:authorityBtn code="qti_exp" type="1"/>  onClick="execl_onClick();">
        </div>
        <div class="clear"></div>
    </div>
        <r:datacell id="datacell1"
            queryAction="/FAERP/ReporttaxAction.do?cmd=queryReportTaxInfo"
            submitAction="/FAERP/ReporttaxAction.do?cmd=updateReportTaxInfo" width="99%"
            xpath="QueryReportTaxVo"
            submitXpath="QueryReportTaxVo"
            pageSize="50"
            paramFormId="taxformid" height="340px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="sa_salary_data_id" label="<input type='checkbox' id='chkbox_all' name='checkAll' onclick='checkAll(this);'/>"
            width="35px" sortAt="none" onRefreshFunc="setCheckBoxStatus"  align="center"></r:field>
            <r:field fieldName="emp_code" messagekey="emp_code" width="100px">
            </r:field>
            <r:field fieldName="emp_name" messagekey="emp_name" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="customer_code" messagekey="customer_code" width="100px">
            </r:field>
            <r:field fieldName="customer_name" messagekey="customer_name" width="200px">
            </r:field>
            <r:field fieldName="tax_region_bd" messagekey="tax_region_bd" width="100px" allowModify="false">
                <d:select dictTypeId="TAX_REGION_BD"/>
            </r:field>
            <r:field fieldName="tax_flag" messagekey="tax_flag" width="100px">
               <d:select dictTypeId="TAX_FLAG"/>
            </r:field>
            <r:field fieldName="tax_status_bd" messagekey="tax_status" width="100px" allowModify="false">
                <d:select dictTypeId="tax_status_bd"/>
            </r:field>
            <r:field fieldName="pay_state" messagekey="pay_state" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="is_generate" messagekey="is_generate" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="modify_status_bd" messagekey="modify_status_bd" width="150px" allowModify="false">
                <d:select dictTypeId="MODIFY_STATUS_BD"/>
            </r:field>
            <r:field fieldName="rpt_month" messagekey="rpt_month" width="150px" allowModify="false">
            </r:field>
            <r:field fieldName="pay_year_month" messagekey="pay_year_month1" width="100px">
            </r:field>
            <r:field fieldName="tax_month" messagekey="tax_month1" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="sa_batch_code" messagekey="sa_batch_code" width="100px">
            </r:field>
            <r:field fieldName="def4" messagekey="def4" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="def5" messagekey="def5" width="100px">
            </r:field>
            <r:field fieldName="def39" messagekey="def39" width="100px">
            </r:field>
            <r:field fieldName="def41" messagekey="def41" width="100px">
            </r:field>
            <r:field fieldName="def46" messagekey="def46" width="100px">
            </r:field>
            <r:field fieldName="def48" messagekey="def48" width="100px">
            </r:field>
            <r:field fieldName="user_name" messagekey="user_name" width="100px">
            </r:field>
            <r:field fieldName="user_dept_name" messagekey="user_dept_name" width="100px">
            </r:field>
            <r:field fieldName="modify_status" messagekey="def48" width="0px"></r:field>
            <!--<r:field fieldName="sa_salary_batch_id" label="sa_salary_batch_id" width="150px"></r:field>-->
            <!--<r:field fieldName="sa_salary_data_id" label="sa_salary_data_id" width="150px"></r:field>-->
        </r:datacell>
</body>
<script type="text/javascript">
    var dateList = [];
    //初始化页面
    jQuery(document).ready(function() {
        $id("datacell1").isQueryFirst = false;//默认初始化不加载datacell
        
        $id("datacell1").afterRefresh = function() {//初始化checkbox
            chkAllEntity(0);//初始化checkbox
            jQuery(":checkbox").attr("checked", false);
            $id("datacell1").isModefied = false;
        }
        
        //在编辑报税属性前，判断是否可以编辑
        $id("datacell1").beforeEdit = function(cell, colIndex, rowIndex) {
            var datacell = $id("datacell1"); //获取datecell对象
            var activeRow = datacell.activeRow; //获取当前活动行
            var entity1 = datacell.getEntity(activeRow); //得到当前操作的行dataset
            var field = datacell.getField(cell); //获取当前操作的cell
            var modify_status_bd = entity1.getProperty("modify_status_bd");
            var tax_status_bd = entity1.getProperty("tax_status_bd");
            var fieldName = field.fieldName;
            if(fieldName=="tax_flag"){
               if(modify_status_bd == "2"){
                    return false;
                }else{
                    if(tax_status_bd == "1"){//已报税不能修改
                        return false;
                    }else{
                        return true;
                    }
                }
            }else{
                return false;
            }
        };
        $id("datacell1").isModefied = false;
    });
    
    
    
    $id("lk_cust").onReturnFunc = function (returnValue){
        var lookup = $id("lk_cust");
        lookup.value = returnValue[0];
        lookup.displayValue = returnValue[2];
        $id("cost_center_id").addParam("cust_id", returnValue[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
    }
    
    /*
    //选择成本中心
    $id("lk_cost_center").onReturnFunc = function (returnValue) {
        var lookup = $id("lk_cost_center");
        lookup.value = returnValue[0];//客户id
        lookup.displayValue = returnValue[1];//客户名称
    }*/

    //验证所属期及应发年月
    function doQryTaxInfo(type) {
        var flag = true;
        var labelname = "";
        if(type == "tax"){
            labelname = "tax_month";
        }else if(type == "pay"){
            labelname = "pay_year_month";
        }else if(type == "rpt"){
            labelname = "rpt_month";
        }
        var p = /^[12]\d{3}(0\d|1[0-2])$/;
        if (!p.test($id(labelname).value) && $id(labelname).value != "" && $id(labelname).value != null) {
            if(type == "tax"){
                alert("<fmt:message key='alert_tax_month_err'/>");
            }else if(type = "rpt"){
                alert("<fmt:message key='alert_pay_year_month_err'/>");
            }else if(type = "pay"){
                alert("<fmt:message key='alert_rpt_year_month_err'/>");
            }
            $id(labelname).value = "";
            flag=false;
        }
        return flag;
    }

    //加载datacell数据
    function showListData(){
        var flag = true;
        if($id("tax_month").value!="" && $id("tax_month").value!=null){
            if(!doQryTaxInfo("tax")){
                flag = false;
            }
        }
        
        if($id("rpt_month").value!="" && $id("rpt_month").value!=null){
            if(!doQryTaxInfo("rpt")){
                flag = false;
            }
        }
        
        if($id("pay_year_month").value!="" && $id("pay_year_month").value!=null){
            if(!doQryTaxInfo("pay")){
                flag = false;
            }
        }
        if(flag){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
    }
    
    //保存修改
    function update_onClick(){  //保存修改
      var datacell = $id("datacell1"); //获取datecell对象
      var rc = datacell.dataset.getLength();
      var dataset = datacell.dataset.values;
      var modifyFlay = false;
      for(var i=0; i<rc; i++){
          var entity = dataset[i];
          var modify_status = entity.getProperty("modify_status");
          if(modify_status == "1"){
            modifyFlay = true;
          }
       }
       
       if(!modifyFlay){
          alert("没有修改任何数据！");
          return;
       }else{
           for(var i=0; i<rc; i++){
               var entity = dataset[i];
               var modify_status = entity.getProperty("modify_status");
               var user_name = entity.getProperty("user_name");
               if(modify_status == "1"){
           var action = "<%=request.getContextPath()%>/ReporttaxAction.do?cmd=updateReportTaxInfo";
           var xmlSubmit = datacell.dataset.toString();
           var myAjax = new Ajax(action);
           myAjax.addParam('os_id', user_name);
           myAjax.submitXML(xmlSubmit, 'UTF-8');
           var returnNode = myAjax.getResponseXMLDom();
           if( returnNode ) {
               if(myAjax.getValue("root/data/returnValue") == "0") {
                   alert("保存失败！");
               }else if(myAjax.getValue("root/data/returnValue") == "1"){
                   alert("保存成功！");
               }else{
                   alert("保存成功！"+myAjax.getValue("root/data/returnValue")+"需审核通过后才能生效！");
               }
               showListData();
           }
               }
           }
       }
    }
    
    
    //全选
    function checkAll(item){
        if (jQuery(item).attr("checked")) {
            chkAllEntity(1);
            jQuery(":checkbox").attr("checked", true);
        } else {
            chkAllEntity(0);
            jQuery(":checkbox").attr("checked", false);
        }
    }
    
    //显示一列chkbox
    function setCheckBoxStatus(value,entity,rowNo,cellNo){
       var flag = entity.getProperty("chk")=="1"? "checked" : "";
       return "<input "+flag+" onclick='chkEntity("+rowNo+");' type='checkbox' name='checkbox_template' value='" + value + "' />";
    }
    
    //设置ENTITY的chk属性
    function chkEntity(rowNo){
        var emps = $id("datacell1").dataset.values;
        var entity = emps[rowNo];
        var chk = entity.getProperty("chk");
        entity.setProperty("chk",1-chk);
        $id("datacell1").isModefied = false;
    }
    
    //设置选中ENTITY的chk属性
    function chkAllEntity(flag){
        var ds = $id("datacell1").dataset;
        var values = ds.values;
        for(var i=0; i<values.length; i++){
            var entity = values[i];
            entity.setProperty("chk", flag);
        }
        $id("datacell1").isModefied = false;
    }
    
    //修改cell值以后操作
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
       var datacell = $id("datacell1"); //获取datecell对象
       var rc = this.dataset.getLength();
       var dataset = this.dataset.values;
       //var curCell = this.getCell(i,activeCell.cellIndex);
       //this.setCellValue(curCell,newValue);
       if(newValue != dateList[datacell.getActiveRow().rowIndex]){
         activeEntity.setProperty("modify_status","1");
       }else{
         activeEntity.setProperty("modify_status","0");
       }
       
       for(var i=0; i<rc; i++){
          var entity = dataset[i];
          var chk = entity.getProperty("chk");
          var tax_flag_oldVal = dateList[i];
          var tax_status_bd = entity.getProperty("tax_status_bd");
          var modify_status_bd = entity.getProperty("modify_status_bd");
          if(chk == "1" && (tax_status_bd == "0" && modify_status_bd != "2")){
               if(newValue != tax_flag_oldVal){
                 entity.setProperty("modify_status","1");
               }else{
                 entity.setProperty("modify_status","0");
               }
               var curCell = this.getCell(i,activeCell.cellIndex);
               this.setCellValue(curCell,newValue);
          }
       }

    }
    
    $id("datacell1").afterEdit = function(newValue,oldValue) {
        $id("datacell1").isModefied = false;
    }
    
    //审核
    function toSure_onClick(type){
       var appFlag = true;
       var ids = [];
       var datacell = $id("datacell1"); //获取datecell对象
       var dataset = datacell.dataset;//取得页面的datacell
       var rc = dataset.getLength();
       for(var i=0; i<rc; i++){
          var entity = dataset.get(i);
          var chk = entity.getProperty("chk");
          var sa_salary_data_id = entity.getProperty("sa_salary_data_id");
          var modify_status_bd = entity.getProperty("modify_status_bd");
          if(chk == "1"){
             if(modify_status_bd == "2"){
               ids.push(sa_salary_data_id);
             }else{
               alert("选择数据中有不再审核中的数据！请重新选择！");
               chkAllEntity(0);
               appFlag = false;
               break;
             }
          }
       }
       if(appFlag){
           if(ids == "" || ids == null){
              alert("请选择一条数据！");
              return;
           }
           var url = "";
           if(type == "1"){
              url = "<%=request.getContextPath()%>/ReporttaxAction.do?cmd=ApprovalReportTaxInfo&ids="+ids;
           }else if(type == "2"){
              url = "<%=request.getContextPath()%>/ReporttaxAction.do?cmd=rejectReportTaxInfo&ids="+ids
           }
           
           jQuery.ajax({
               url: url,
               type: 'GET',
               dataType: 'html',
               timeout: 9999999,
               error: function(){
                   alert('Error loading XML document');
                   return  null;
               },
               success: function(text){
                   if(text=="1"){
                      if(type == "1"){
                        alert("审核成功！");
                      }else{
                        alert("驳回成功！");
                      }
                      $id("datacell1").loadData();
                      $id("datacell1").refresh();
                   }else{
                      if(type == "1"){
                        alert("审核失败！");
                      }else{
                        alert("驳回失败！");
                      }
                   }
               }
           });
       }
    }
    
    //导出excel
    function execl_onClick(){  //<fmt:message key='listLaborcontract0038'/>Excel
        var form = $id("taxformid");
        form.action="<%=request.getContextPath()%>/ReporttaxAction.do";
        form.cmd.value = "exportExcelForQuery";
        form.submit();
    }
</script>
</fmt:bundle>
</html>
