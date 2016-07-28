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
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datacell</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "@" + entity.getProperty("bill_type_bd") + "\");>";
    }

   function ClickRow(value){
        var ts = value.split("@");
        $id("bill_type_bd").value = ts[1];
        $id("bill_id").value = ts[0];
        jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/AgentfinbillothersAction.do?cmd=retrieveAgentBillStatus&bill_id=" + ts[0],
            dataType : "html",
            success : function(data) {
                if(data == '0'){
                    document.getElementById("changeButton").style.display = "none";
                    $id("datacell2").loadData();
                    $id("datacell2").refresh();
                }else{
                    document.getElementById("changeButton").style.display = "block";
                    $id("datacell2").loadData();
                    $id("datacell2").refresh();
                }
               
            }
        });
        
      
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        $id("bill_id").value="";
    }
    
    function resetQuery(){
        $id("cust_id").value="";
        $id("cost_center_id").value="";
    }
    
    function setCheckbox(value,entity,rowNo,cellNo){
       
       return "<input type='radio'  name='temp1'   onClick=ClickRow1(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow1(value){
        $id("bill_others_id").value = value;
    }
    
    function toAdd_onClick() {
        
        var bill_id = $id("bill_id").value;
        var bill_type_bd = $id("bill_type_bd").value;
        if(bill_type_bd == null || bill_type_bd == 3){
            alert("仅工资的账单不允许增加一次性收费项目！");
            return;
        }
        if(bill_id!=null&&bill_id!=""){
            $id("datacell2").addRow();
        }else{
            alert("请先选择操作的账单记录！");
            return;
        }
    }
    
     function deleteMulti_onClick(){
        var bill_id = $id("bill_others_id").value;
        if(bill_id!=null&&bill_id!=""){
           $id("datacell2").deleteRow();
            toSave_onClick();
        }else{
            alert("请先选择操作的账单记录！");
            return;
        }
    }
    
    function toSave_onClick() { 
        var bill_id = $id("bill_id").value;
        if(bill_id!=null&&bill_id!=""){
            $id("datacell2").isModefied = true;
            if($id("datacell2").submit()){
                alert("保存成功！");
                $id("datacell1").loadData();
                $id("datacell1").refresh();
                $id("bill_id").value="";
                $id("datacell2").loadData();
                $id("datacell2").refresh();
            }
        }else{
            alert("请先选择操作的账单记录！");
            return;
        }
    }
    
        function choose_row(tagid) {
             if($id(tagid).value==""){
                    alert("请选择一条记录！");
                    return false;
             }
             return true;
        }
    function addOneTimeChargeBill(){
        var customer = $id("lk_cust").value;
        var cost_center = $id("cost_center_id").getValue();
        var agent_id = $id("agent_id").value;
        var bill_year = $id("billyearmonth").value;
        
        if(!agent_id){
            alert("供应商不能为空！");
            return;
        }
        if(!customer){
            alert("客户不能为空！");
            return;
        }
        if(!cost_center){
            alert("成本中心不能为空！");
            return;
        }
        if(!bill_year){
            alert("账单年月不能为空！");
            return;
        }
        var obj = new Array();
        obj.push(customer);
        obj.push(cost_center);
        obj.push(bill_year);
        obj.push(agent_id);
        showModalCenter("<%=request.getContextPath()%>/jsp/faerp/agent/agentfinbillothers/addOneTimeChargeBill.jsp",obj,'','900','390',"添加");   
    }
</script>
</head>
<body>
<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" id="bill_id" name="bill_id" value=""/>
<input type="hidden" id="bill_others_id" name="bill_others_id" value=""/>
<input type="hidden" id='bill_type_bd' name="bill_type_bd" value =""/>
<div id="right">
    <script language="javascript">
        writeTableTopFesco('一次性收费','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
        <tr>
            <td align="right"><span class="style_required_red">* </span>供应商</td>
            <td align="left">
                <w:lookup readonly="true"
                    id="lk_agent"
                    lookupUrl="/FAERP/AgentAction.do?cmd=getAllAgentByConditionnew"
                    dialogTitle="选择供应商"  height="450" width="610" style="width:180px" />
                <input id="agent_id" name="agent_id" type="hidden"/>
            </td>
            <td align="right"><span class="style_required_red">* </span>客户名称</td>
            <td align="left">
                <w:lookup readonly="true"
                    id="lk_cust"
                    lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                    dialogTitle="选择客户"  height="450" width="610" style="width:180px" />
                <input id="cust_id" name="cust_id" type="hidden"/>
            </td>
            <td align="right"><span class="style_required_red">* </span>成本中心</td>
            <td align="left">
            <r:comboSelect id="cost_center_id" name="cost_center_id"
                queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                textField="cost_center_name"
                valueField="id"
                xpath="CostcenterVo"
                width="190" nullText="--请选择--">
            </r:comboSelect>
            </td>
        </tr>
        <tr>
         <td align="right"><span class="style_required_red">* </span>账单年月</td>
            <td  align="left">
            <input type="text" class="text_field" id="billyearmonth" name="billyearmonth" inputName="账单年月" maxLength="50" value=""/>
            </td>
            <td align="right"></td>
            <td align="left">
            </td>
            <td align="right"></td>
            <td align="left">
            </td>
        </tr>
        <tr>
            <td colspan='6' align='center'>
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                    <input name="button_reset2" class="icon_4" type="button" value='添加一次性收费账单' onClick="javascript:addOneTimeChargeBill()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();resetQuery()">
                  </td>
        </tr>
        
</table>
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/AgentfinbillothersAction.do?cmd=searchAgentOneTimeChargesData"
        width="99%"
        height="304px"
        xpath="AgentfinbillVo"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center" >
       </r:field>   
       <r:field fieldName="agent_code" label="供应商名称" allowModify="false">
      </r:field>
      <r:field fieldName="agent_name" label="供应商编号" allowModify="false">
      </r:field>
      <r:field fieldName="cust_code" label="客户编号" allowModify="false">
      </r:field>
      <r:field fieldName="cust_name" label="客户名称" width="190px" allowModify="false">
      </r:field>
      <r:field fieldName="cost_center_name" label="成本中心名称" width="205px" allowModify="false">
      </r:field>
      <r:field fieldName="bill_year_month" label="账单年月" allowModify="false">
      </r:field>
      <r:field fieldName="version" label="版本号" allowModify="false">
      </r:field>
      <r:field fieldName="bill_amount" label="账单金额" allowModify="false">
      </r:field>
      <r:field fieldName="bill_type_bd" label="账单类型" allowModify="false">
       <d:select dictTypeId="BILL_TYPE_BD" />
      </r:field>
      <r:field fieldName="create_date" label="生成时间" allowModify="false">
       <w:date format="yyyy-MM-dd" />
      </r:field>
      <r:field fieldName="create_user_name" label="生成人" allowModify="false">
      </r:field>
    </r:datacell>
</div>
    
<div class="button_right" id="changeButton" style="display:block">
       <!--<ul>
            <li class="c">      <a onClick="javascript:toAdd_onClick();">新增</a></li>
           <li class="d">      <a  onClick="javascript:deleteMulti_onClick();">删除</a> </li>
           <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
       </ul>
       -->
       <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAdd_onClick();">
       <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMulti_onClick();">
 </div>
 <div class="clear"></div>
     
<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell2"
        paramFormId="datacell_formid"
        queryAction="/FAERP/AgentfinbillothersAction.do?cmd=searchAgentOneTimeChargesDataByBillId"
        submitAction="/FAERP/AgentfinbillothersAction.do?cmd=updateAgentOneTimeChargesDataByBillId"
        width="99%"
        height="304px"
        xpath="AgentfinbillothersVo"
        submitXpath="AgentfinbillothersVo"
        pageSize="-1"
        >
       <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckbox" align="center" >
       </r:field> 
      <r:field fieldName="charge_item_bd" label="项目名称" width="200px">
        <d:select dictTypeId="CHARGE_ITEM_BD" extAttr="validateAttr='allowNull=false'" />
      </r:field>
      <r:field fieldName="amount" label="金额" width="180px" allowModify="false">
        <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
      </r:field>
      <r:field fieldName="charge_desc" label="备注" width="300px">
        <h:text/>
      </r:field>
      <r:field fieldName="last_update_date" label="修改日期" allowModify="false" width="180px">
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
<script>
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    _$("#cust_id").val(returnValue[0]);
    lookup.displayValue = returnValue[2];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}
//供应商
$id("lk_agent").onReturnFunc = function (returnValue){
    var lookup = $id("lk_agent");
    lookup.value = returnValue[0];
    _$("#agent_id").val(returnValue[0]);
    lookup.displayValue = returnValue[2];
    return false;
}

_$(document).ready(function() {
        $id("datacell1").isQueryFirst = false;
});
</script>
