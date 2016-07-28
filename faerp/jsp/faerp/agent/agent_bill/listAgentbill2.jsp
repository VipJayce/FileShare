<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>

<head>

<title>生成账单</title>

<script language="javascript">

function findChecks(dcObject, checkBoxId, retProperty){
    var retStr = '';
    var dataset1 = dcObject.dataset;
    for(var i=0; i < dataset1.getLength(); i++){
        var checked = dataset1.get(i).getProperty(checkBoxId);
        if (checked){
            if(retStr == ''){
                retStr = retStr + dataset1.get(i).getProperty(retProperty);
             }else{
                retStr = retStr + "," + dataset1.get(i).getProperty(retProperty);
             }
         }
    }
    return retStr;
}
function generateBill(){
    var frm = $id("datacell_formid");
  
      //表单验证
      if( !checkForm(frm) ) {
          return;
      }    
      var agent_id=document.getElementById("agent_id").value;
     var currentbillym_pvalue=${requestScope.currentbillym_pvalue};
     var bill_year_month=_$("#bill_year_month").val();
     
     /*
     if(bill_year_month<currentbillym_pvalue){
            alert("账单生成年月:"+bill_year_month+"不能小于当前账单年月:"+currentbillym_pvalue);
            return;
     }
     */
     
      var bill_type_bd=_$("#bill_type_bd").val();
      if(bill_type_bd==""){
            alert("请选择账单类型！");
            return;
      }
      
      if (!$id("cost_center_id").getValue() || $id("cost_center_id").getValue().length <= 0){
        alert("请选择成本中心！");
        
        return;
      }
      
      //
   var ids = ''; //ids=findChecks($id("datacell1") , "sa_check", "id");  //取得复选框的选择项
   ids = findSelections("checkbox_template","id");  //取得多选框的选择项
   if(ids=="null"){
   ids = "";
   }
   
   if(bill_type_bd=="1"&&(ids==""||ids==null)){
        alert("请选择薪资发放记录！");
        return;
   }
   //alert("ids="+ids);
   //设置button不能点击
   $id("button_ok").disabled="disabled" ;
    var ajax = new Ajax($id("datacell1").submitAction);
    ajax.addParam("ids", ids);
    ajax.addParam("batch_ids","");
       //添加参数agent_id
    ajax.addParam("agent_id",agent_id);
    ajax.submitForm(frm);
    showProgressBar();
     var returnNode = ajax.getResponseXMLDom();
    var retstr=ajax.getValue("root/data/returnValue");
     var retsinfo=retstr.split(",");
     if(returnNode) {
         if(retsinfo[0]=="1") {
             hideProgressBar();
             //alert( '调用成功!');
             alert(retsinfo[1]);
            
             $id("datacell1").reload();
             $id("datacell1").refresh();
             setTab03Syn(2);
             document.getElementById('bg').className='xixi2';
             $id("datacell2").reload();
             $id("datacell2").refresh();
             
             //location.href="/FAERP/jsp/faerp/finance/receivable/finbill/queryBill.jsp";
         } else if (retsinfo[0]=="0"){
             hideProgressBar();
             alert( '调用失败!');
             alert(retsinfo[1]);
         }else{
             hideProgressBar();
             alert(retsinfo[1]);
         }
     } else {
          hideProgressBar();
          alert( '保存失败!');
     }
     //设置button能点击
   $id("button_ok").disabled="" ;
      return;
}

function generateThreadBill(){
    var frm = $id("datacell_formid");
  
      //表单验证
      if( !checkForm(frm) ) {
          
          return;
      }    
      
           var agent_id=document.getElementById("agent_id").value;
           var currentbillym_pvalue=${requestScope.currentbillym_pvalue};
     var bill_year_month=_$("#bill_year_month").val();
     
     /*
     if(bill_year_month<currentbillym_pvalue){
            alert("账单生成年月:"+bill_year_month+"不能小于当前账单年月:"+currentbillym_pvalue);
            return;
     }
     */
     
      var bill_type_bd=_$("#bill_type_bd").val();
      if(bill_type_bd==""){
            alert("请选择账单类型！");
            return;
      }
      
      if (!$id("cost_center_id").getValue() || $id("cost_center_id").getValue().length <= 0){
        alert("请选择成本中心！");
        return;
      }
      
      //
   var ids = ''; //ids=findChecks($id("datacell1") , "sa_check", "id");  //取得复选框的选择项
   ids = findSelections("checkbox_template","id");  //取得多选框的选择项
   if(ids=="null"){
   ids = "";
   }
   
   if(bill_type_bd=="1"&&(ids==""||ids==null)){
        alert("请选择薪资发放记录！");
        return;
   }
   //alert("ids="+ids);
   //设置button不能点击
   $id("button_ok").disabled="disabled" ;
    var ajax = new Ajax('/FAERP/Agent_billAction.do?cmd=generateBillThread2');
    ajax.addParam("ids", ids);
    ajax.addParam("batch_ids","");
     //添加参数agent_id
    ajax.addParam("agent_id",agent_id);
    ajax.submitForm(frm);
    showProgressBar();
     var returnNode = ajax.getResponseXMLDom();
    var retstr=ajax.getValue("root/data/returnValue");
     var retsinfo=retstr.split(",");
     if(returnNode) {
         if(retsinfo[0]=="1") {
             hideProgressBar();
             //alert( '调用成功!');
             alert(retsinfo[1]);
            
             $id("datacell1").reload();
             $id("datacell1").refresh();
             setTab03Syn(2);
             document.getElementById('bg').className='xixi2';
             $id("datacell2").reload();
             $id("datacell2").refresh();
             
             //location.href="/FAERP/jsp/faerp/finance/receivable/finbill/queryBill.jsp";
         } else if (retsinfo[0]=="0"){
             hideProgressBar();
             alert( '调用失败!');
             alert(retsinfo[1]);
         }else{
             hideProgressBar();
             alert(retsinfo[1]);
         }
     } else {
          hideProgressBar();
          alert( '保存失败!');
     }
     //设置button能点击
   $id("button_ok").disabled="" ;
      return;
}



//tab切换
    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("tab1inner").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("tab2inner").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("tab1inner").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("tab2inner").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }


    function openNewWin(){
              var cust_id=$id("cust_id").value;
              if(cust_id==""){
                    alert("请选择客户！");
                    return;
              }
              if (!$id("cost_center_id").getValue() || $id("cost_center_id").getValue().length <= 0){
                alert("请选择成本中心！");
                return;
              }
        
            var url="/FAERP/BillPrecisionAction.do?cmd=toListPageBillPrecision&cust_id="+cust_id+"&cost_center_id="+$id("cost_center_id").getValue();
            url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, "", 780, 450, "精度设置");  //增加子岗位
       }
       
       
       
       //    
   function onchange_billtypedb(){
           var  bill_type_bd = $id("bill_type_bd").value ;
           if(bill_type_bd =='1'){
               document.getElementById("scopetypetr").style.display=''
           }
           else {
               document.getElementById("scopetypetr").style.display='none'
           }
    }
</script>
</head>
<body>



        <div id="bg" class="xixi1" >
            <div id="font1" class="tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'">重算账单</div>
            
            
            
            <div id="font2" class="tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'">生成日志</div>
        </div>

<div id="TabCon1">        
        
<div id="right" style="height: 120px; overflow-y: hidden;">
                <h:form  checkType="blur" name="form" method="post"  id="datacell_formid">

<table width="100%" border="0">

     <tr>
        <td width="174" />
        <td width="360" />
        <td width="169"></td>
        <td width="381" />
        <td width="169"></td>
        <td width="381" />
    </tr>
    <tr>
        <td align="right"><span class="style_required_red">* </span>账单生成年月</td>
        <td align="left" colspan="3"><h:text id="bill_year_month" property="currentbillym/pValue" name="bill_year_month"  style="width=180px" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/> (格式YYYYMM)<span  style="color:red;font-size:1.1em">当前账单年月为<b:write property="currentbillym/pValue" /></span></td>
        <td align="right"><span class="style_required_red">* </span>账单类型</td>
        <td align="left"><d:select dictTypeId="FB_BILL_TYPE_BD" id="bill_type_bd"
                name="bill_type_bd" style="width:183px" nullLabel="--请选择--" 
                filterOp="in" filterStr="1,2" onchange="onchange_billtypedb();"/></td>
                
    </tr>
    <tr>
        <td align="right">选择客户</td>
        <td align="left"><w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust"
            lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition3" style="width:165px"
            dialogTitle="选择客户" height="450" width="610" /> <input id="cust_id"
            name="cust_id" type="hidden" /></td>
          <td align="right">全国供应商</td>
          <td align="left">
             <w:lookup onReturnFunc="rtnFuncAgent"   readonly="true" id="agent_id" name="agent_id" lookupUrl="/jsp/faerp/agent/agent_bill/listAgentCustomerGetByID.jsp" dialogTitle="选择供应商" height="500" width="700" style="width:170px">
                </w:lookup> 
         </td>
        <td align="right">客户成本中心</td>
        <td align="left"><r:comboSelect id="cost_center_id"
            name="cost_center_id"  
            queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
            width="180" >
        </r:comboSelect></td>
    </tr>
    <tr style="display: none;" id="scopetypetr">
        <td align="right">工资计算范围</td>
        <td align="left">
            <select name="billscopetype" id="billscopetype" style="width: 183px">
                <option value="1">当前成本中心</option>
                <option value="2">所有成本中心</option>
            </select>
        </td>
        <td align="right">&nbsp;</td>
        <td align="left">&nbsp;</td>
       </tr> 
    <tr>
        <td align="right">自动重算原因</td>
        <td align="left"><input type="checkbox" value="1" name="recreate_reason">账单生成后申报入职或变更
        <!--  <input type="checkbox" value="2" name="recreate_reason">账单生成后报离职<input type="checkbox" value="3" name="recreate_reason">报价单金额发生变化-->
        
        </td>

        <td >&nbsp;</td>
        <td colspan="2"> <input name="button_ok22" class="icon_1"      type="button" value='查询薪资' onClick="javascript:searchSalary()">
            <input name="button_ok" id="button_ok" class="icon_1"      type="button" value='重算账单' onClick="javascript:generateBill()">
           
                <input name="button_ok" id="button_ok" class="icon_3"      type="button" value='后台重算账单' onClick="javascript:generateThreadBill()">
           
            <input name="button_reset" class="icon_1"   type="button" value='精度设置'
            onClick="javascript:openNewWin();"></td>
        
        
        
    
<!--        <td align="right">&nbsp;</td>-->
<!--        <td align="left">&nbsp;</td>-->
<!--        <td align="right"></td>-->
    </tr>



</table>

    </h:form>
</div>
</div>
<div id="tab1inner" style="padding: 8 10 8 8;" >
<r:datacell id="datacell1"  queryAction="/FAERP/Agent_billAction.do?cmd=searchSalary4again"
     width="98%" height="304px" xpath="SalarybatchVo" submitAction="/FAERP/Agent_billAction.do?cmd=generateBill2"
    submitXpath="SalarybatchVo" paramFormId="datacell_formid">
    <!-- 
    <r:field  sortAt="none" fieldName="sa_check" label="<input type='checkbox' name='checkall' id='checkall' onclick='checkall();'>" width="32px" align="center">
        <h:switchCheckbox id="sa_check" checkedValue="1" uncheckedValue="0"/>
    </r:field>
     -->
      <r:field allowModify="false"  fieldName="sa_check" sortAt="none" label="<input type='checkbox' name='sa_check2' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      </r:field>       
      
    <r:field fieldName="pay_name" label="薪资发放名称" width="250px" >
    </r:field>
    <r:field fieldName="pay_year_month" label="薪资所属月" allowModify="false"
        width="150px">
        <h:text />
    </r:field>
    <r:field fieldName="tax_month" label="薪资计税年月" width="190px"
        allowModify="false">
        <h:text />
    </r:field>
    <r:field fieldName="bill_year_month" label="薪资账单年月" width="205px"
        allowModify="false">
        <h:text />
    </r:field>
    <!--<r:field fieldName="cost_center_name" label="成本中心" width="205px"
        allowModify="false">
    </r:field>

--></r:datacell>


</div>





<div id="TabCon2"  style="display:none">        
        
<div id="right" style="height: 90px; overflow-y: hidden;">
        
<h:form  checkType="blur" name="form2" method="post"  id="datacell_formid2">

<table width="100%" border="0">
    <tr>
        <td width="174" />
        <td width="360" />
        <td width="169"></td>
        <td width="381" />
    </tr>
    <tr>
        <td align="right">账单生成方式</td>
        <td align="left"><d:select dictTypeId="BILL_CREATE_TYPE_BD" value="3" nullLabel="--请选择--" id="create_type" name="create_type"></d:select></td>
        <td align="right">账单生成描述</td>
        <td align="left"><input type="text"  name="create_desc" id="create_desc" inputName="账单生成描述" maxLength="1000" style="width: 190px"/></td>
        <td align="right"></td>
    </tr>
    <tr>
        <td align="right">创建日期</td>
         <td align="left">
                <w:date allowInput="false" id="w_from"
                    name="date_from" format="yyyy-MM-dd" style="width:75px;"  />到
                <w:date allowInput="false" id="w_to" name="date_to"
                    format="yyyy-MM-dd" style="width:75px;" />
            </td>
        <td colspan="2" align="right">
        <div align="center">
        <input name="button_ok2" class="icon_1"      type="button" value='查询日志' onClick="javascript:searchCreateLog()">
        <input name="button_ok2" class="icon_1"      type="button" value='账单详细' onClick="javascript:viewBillDetail()">
        </div>
        </td>
        <td align="right"></td>
    </tr>


    <tr>
        <td />
        <td />
        <td />
        <td>&nbsp;</td>
        <td />
    </tr>
</table>

<!-- 
<table width="100%" border="0">
    <tr>
        <td width="274" />
        <td width="360" />
        <td width="169"></td>
        <td width="181" />
    </tr>
        </tr>
                <tr>
            <td align="right">账单生成方式</td>
            <td align="left">
               <d:select dictTypeId="BILL_CREATE_TYPE_BD" value="3" nullLabel="请选择..." id="create_type" name="create_type"></d:select>
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
        </tr>
        <tr>
            <td align="right">账单生成描述</td>
            <td align="left">
                <input type="text" class="text_field" name="create_desc" id="create_desc" inputName="账单生成描述" maxLength="1000"/>
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
        </tr>
        <tr>
            <td align="right">创建日期</td>
            <td align="left">
                <w:date allowInput="false" id="w_from"
                    name="date_from" format="yyyy-MM-dd" style="width:90px;"  />到
                <w:date allowInput="false" id="w_to" name="date_to"
                    format="yyyy-MM-dd" style="width:90px;" />
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
        </tr>


    <tr>
        <td />
        <td> <input name="button_ok2" class="icon_1"      type="button" value='查询日志' onClick="javascript:searchCreateLog()">
        <input name="button_ok2" class="icon_1"      type="button" value='账单详细' onClick="javascript:viewBillDetail()"></td>
        <td />
        <td></td>
        <td />
    </tr>
</table>
 -->
    </h:form>
</div>
</div>
<div id="tab2inner" style="padding: 8 10 8 8;" >
<r:datacell id="datacell2"  queryAction="/FAERP/BillCreateLogAction.do?cmd=queryLog1" readonly="true"
     width="98%" height="304px" xpath="BillCreateLogVo" submitAction="/FAERP/Agent_billAction.do?cmd=generateBill"
    submitXpath="BillCreateLogVo" paramFormId="datacell_formid2">

    <r:field fieldName="bill_create_type_bd" label=" 账单生成方式" width="250px">
        <d:select dictTypeId="BILL_CREATE_TYPE_BD"></d:select>
    </r:field>
    <r:field fieldName="bill_create_desc" label="账单生成描述" allowModify="false"
        width="350px">
        <h:text />
    </r:field>
    <r:field fieldName="last_update_date" label="创建日期" width="190px"
        allowModify="false">
        <w:date format="yyyy-MM-dd HH:mm:ss"/>
    </r:field>

</r:datacell>

</div>



</body>
</html>

<script language="javascript">
//$id("datacell1").headTextAlign="center";

//选择供应商页面返回值
function rtnFuncAgent(arg){
        var lookup = $id("agent_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        document.getElementById("agent_id_hidden1").value=arg[0];//把返回的id存到隐藏域
        return false;
    }

//在选择客户打开之前
//先选择客户，然后再选择客户所属的供应商
$id("agent_id").beforeOpenDialog= function(lookup){
        lookup.params = [];
        var cust_id=_$("#lk_cust_hidden").val();
        if(cust_id==""||cust_id==null){
        alert("请先选择客户!");
        return false;
        }else{
        lookup.addParam("cust_id",cust_id);
        return true;
        }
}


$id("lk_cust").onReturnFunc = function (returnValue){

    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
    _$("#cust_id").val(returnValue[0]);
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    var dc1 =   $id("datacell1");
    dc1.loadData();
    dc1.refresh();
    return false;
}


function searchSalary(){
    var frm = $id("datacell_formid");
  
      //表单验证
      if( !checkForm(frm) ) {
          return;
      }
   
       var dc1 =   $id("datacell1");
       dc1.loadData();
     dc1.refresh();
      return;
}


    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
        $id("datacell2").isQueryFirst = false;
    });

function searchCreateLog( ){
      if (!$id("cost_center_id").getValue() || $id("cost_center_id").getValue().length <= 0){
        alert("请选择成本中心！");
        
        return;
      }   
       var dc1 =   $id("datacell2");
       dc1.addParam("cost_center_id", $id("cost_center_id").getValue());
       dc1.loadData();
     dc1.refresh();
      return false;
}

function viewBillDetail() {
var dc = $id("datacell2");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("请先选择一条记录");
        return ;
    }
    var bill_id = entity.getValue("bill_id");
    _$.ajax({
        type : "post",
        url : "/FAERP/Agent_billAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
            if (data!=""&&data=="此账单无明细，数据可能异常。") {
                alert(data);
            } else {
                if (bill_id) {
                    //w为窗口宽度，h为高度
                    var w = 1250;
                    var h = 600;
                    var l = 70;//(screen.width - w) / 2;
                    var t = 70;//(screen.height - h) / 2;
                    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
                    var url = "/FAERP/Agent_billAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
                    window.open(url, 'newwindow', s);
                    //window.location.href = "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
                }
            }
        }
    });

}

function checkall(){
    if (jQuery("#checkall").checked){
        jQuery("#sa_check").checked = true;;
    }else{
         jQuery("#sa_check").checked = false;
    }
}

jQuery(document).ready(function() {
    var isFirstLoad = true;
    $id("datacell2").afterRefresh = function(){
        if (isFirstLoad) {
            setTab03Syn(1);
            isFirstLoad = false;
        }       
    }
        
});

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value="+ entity.getProperty("id")+ ">";
    }
</script>
