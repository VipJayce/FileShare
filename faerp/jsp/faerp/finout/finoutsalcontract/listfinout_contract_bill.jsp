<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>
<%@include file="/common/common.jsp"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<% String name = LoginHelper.getLoginId(request); %>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
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
    function findCheckbox_onClick() {  //从多选框到修改页面
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var contract_id=ids[0].split(",")[0];//单据主键
        
        var  constatus;
        var type;
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
                 type=entity.getProperty("create_type_bd");
            }
        }
    if(constatus==0 ){
		            var url="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=find_finoutcontract&id=" + ids+"&detail=modify";
		            url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
		            window.open(url,'','height=500px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改合同');
    } else{
         alert("创建中-临时状态的合同才可以修改！");
         return;
    }
    
        
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
             var mid=new Array();
        //获取单据主键集合
        for (i = 0; i <ids.length; i++)
        {
            mid[i]=ids[i].split(",")[0];//单据主键
        }
          var wfname="Finout_contract_productAction";//此业务对应合同审批名称     
          //检查此单据是否正在走流程
        WfCommonAjax.checkDelete(wfname,mid,function(reData){
                if(reData==''){//删除操作                    
             if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
                        jQuery.ajax({
                                url: "<%=request.getContextPath()%>/SalcontractAction.do?cmd=deleteMulti&ids="+ids+"&date="+new Date(),
                                type: 'GET',
                                dataType: 'html',
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){ 
                                   if(text==1){
                                       alert("该合同已被引用不可以删除！");  
                                       return;
                                   }else if(text==2){
                                     alert("删除成功！");  
                                     form.cmd.value = "simpleQuery";
                                      form.submit();
                                   }
                                }
                                });
                                return true;
                  }
                }else{
                    //要删除的数据中有不能被删除的
                    alert(reData);
                    return;
                }
            }
         );        
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "simpleQuery";
        form.submit();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=add_finoutsalcontract&_ts="+(new Date()).getTime();
        form.submit();
    }
    function callBack(reg){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
    }
    
    function detail_onClick(){  //实现转到详细页面
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=detail_finoutcontract&id=" + ids+"&detail=detail";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看详细信息');
    }
    

    function workflow_onClick(){  //发起工作流
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var contract_id=ids[0].split(",")[0];//单据主键
        var wfname="FinoutContractWorkFlow";//此业务对应合同审批名称     
      //合同生成类型  1模板 2 定制
      var create_type_bd=  document.getElementById(contract_id);
       var  constatus;
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
                }
        }
     if("<%=name%>" == 'admin'){
      alert("系统管理员 不可以提交审批流程！");
        return;
     }
      
      if(constatus=="1"){
        alert("已经在走审批流程,不能进行此操作!");
        return;
     }
     if(constatus=="3"){
        alert("合同已经审批中止,不能进行此操作!");
        return;
     }
     if(constatus=="4"){
        alert("合同已生效不可提交审批流程！");
        return;
     }
     if(constatus=="5"){
        alert("合同已分配完成不可提交审批流程！");
        return;
     }
     if(constatus!="0"&&constatus!="2"){
        alert("只有创建中临时状态或驳回的合同才可提交审批流程！");
        return;
     }
        //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
               form.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=submitAPProval&contract_id="+ids+"&detail=detail";
                form.submit();
                }   
                else{
                  alert("已经在走审批流程,不能进行此操作!");
                    return;
                }   
            }
         );        
    }
    
    //知道了，不需提醒按钮事件
    function tonotNeedRemind_onClick(){
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        document.form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=tonotNeedRemind&id=" + ids+"&_ts='+(new Date()).getTime()";
        document.form.submit();
    }

    
     //杜辉阳添加
    //审批详细操作
    function spinto_onClick(){
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var contract_id=ids[0].split(",")[0];//单据主键
        var wfname="FinoutContractWorkFlow<%=   rayoo.common.filter.UserInfoFilter.geCompanyId()%>";//此业务对应合同审批名称     
        var wfname1="FinoutContractWorkFlow<%=   rayoo.common.filter.UserInfoFilter.getCompanyId()%>";//此业务对应分配经办人
        //检查此单据是否正在走流程
          
         //alert('spinto_onClick审批详细');
        WfCommonAjax.checkCurrentWf_Info(wfname,wfname1,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    alert("没有发起过审批流程,不能进行此操作!");
                    return;
                }   
                else{
                //alert('测试审批详细');
                var url = "/FAERP/jsp/faerp/sales/salcontract/processdetailpage.jsp?contract_id=" + contract_id+"&wfname="+wfname+"&wfname1="+wfname1+"&_ts="+(new Date()).getTime();
                showModalCenter(url, window, callBack,740, 360, "审批详细"); 
                }   
            }
         );        
    
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  >";
    }

    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //选择客户
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);      
    jQuery("#cust_a_name").val(arg[2]);       
    return false;
}
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" value="true">
<div id="right">
<script language="javascript">
    writeTableTopFesco('合同账单信息','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 


<table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
         <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
         <td/>
         <td/>
         <td>    </td>
         <td>    </td>
         <td>    </td>
     </tr>
        <tr>
            <td align="right">合同业务类型</td>
            <td align="left">
                    <d:select dictTypeId="FINOUT_TYPE_BD" name="business_type_bd" id="business_type_bd" nullLabel="--请选择--"/>
            </td>
             <td align="right">合同状态</td>
            <td align="left">
            <!--<d:select dictTypeId="CONTRACT_STATUS_BD" name="contract_status_bd" />-->
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_status_bd", -1,"CONTRACT_STATUS_BD",""," id=contract_status_bd",false) %> 
            </td>
            <td align="right">合同甲方</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=${f}" dialogTitle="选择客户" height="500" width="810"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
            </td>
        </tr>
        <tr>
            <td align="right">合同编号</td>
            <td align="left">
                <input type="text" class="text_field" name="contract_code" inputName="合同编号" maxLength="64"/>
            </td>
            <td align="right">合同名称</td>
            <td align="left">
                <input type="text" class="text_field" name="contract_name" inputName="合同名称" maxLength="50"/>
            </td>
              <td colspan="2">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
        <tr>
            <td/>
          
            <td/>
            <td/>
            
                <td/>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
<!--                 <input class="a" type="button"   value="<fmt:message key="view"/>"    onClick="detail_onClick();">-->
<!--				 <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAdd_onClick();">-->
<!--				 <input class="b" type="button"   value="<fmt:message key="modify"/>"   onClick="findCheckbox_onClick();">-->
<!--				 <input class="approdetial" type="button"   value="合同审批"    onClick="workflow_onClick();">              -->
<!--				 <input class="approdetial" type="button"   value="审批详细"    onClick="spinto_onClick();">-->
         </div>
           <div class="clear"></div>            
</div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/Finout_contract_productAction.do?cmd=searchFinout_contract_bill"
        width="98%"
        height="318px"
        xpath="SalcontractVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="contract_code" label="合同编号" width="110px">
      </r:field>
      <r:field fieldName="contract_type_bd" label="合同类型" allowModify="false" width="100px">
      <d:select dictTypeId="CONTRACT_TYPE_BD" />
      </r:field>
        <r:field fieldName="business_type_bd" label="业务类型" allowModify="false" width="100px">
      <d:select dictTypeId="FINOUT_TYPE_BD" />
      </r:field>
      <r:field fieldName="contract_name" label="合同名称" width="196px">
      </r:field>
      <r:field fieldName="customer_name" label="合同甲方" width="196px">
      </r:field>
      <r:field fieldName="contract_start_date" label="合同起始日期" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="contract_stop_date" label="合同终止日期" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="contract_status_bd" label="合同状态" allowModify="false" width="100px">
      <d:select dictTypeId="CONTRACT_STATUS_BD" />
      </r:field>
      <r:field fieldName="create_date" label="创建日期" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="create_user_name" label="创建人" width="80px">
      </r:field>
       <r:field fieldName="billing_user_name" label="开具账单人" width="80px">
      </r:field>
       <r:field fieldName="check_user_name" label="复核人员" width="80px">
      </r:field>
      
       <r:field fieldName="bill_year_month" label="账单月" width="80px">
      </r:field>
       <r:field fieldName="bill_amount" label="账单金额" width="80px">
      </r:field>
    </r:datacell>
    </div>
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
<%  //表单回写
    if(request.getAttribute(ISalcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISalcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
//初始化不加载页面信息<siqp添加>
 //jQuery(function(){
  //  $id("datacell1").isQueryFirst = false;
//});
</script>   
