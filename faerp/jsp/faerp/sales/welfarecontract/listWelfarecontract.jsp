<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo"%>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants"%>
<%@include file="/common/common.jsp"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
    //System.out.println("jsp-----------"+request.getRequestURI());
%>
<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(ISalcontractConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request.getAttribute(ISalcontractConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    SalcontractVo resultVo = null; //定义一个临时的vo变量
    String name = LoginHelper.getLoginName(request);
    //从首页跳转过来的标志flag
    String flag = request.getParameter("flag") == null ? "false" : request.getParameter("flag");
    rayoo.common.filter.UserInfoFilter.setServletRequest(request);

    //合同界面有招聘模块和销售模块同时使用，所以在招聘模块的链接中添加了f=zp的参数标记
    String f = request.getParameter("f");
    System.out.println("f:" + f);
%>

<html>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle
	basename="rayoo.salse.welfarecontract.welfarecontract_resource"
	prefix="rayoo.salse.welfarecontract.">
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
        var wfname="SalcontracWorkFlow";//此业务对应合同审批名称     
        //检查此单据是否正在走流程
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
           var url="<%=request.getContextPath()%>/WelfarecontractAction.do?cmd=find&id=" + ids+"&detail=modify";
           url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
           window.open(url,'','height=500px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增合同');
        
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
          var wfname="SalcontracWorkFlow";//此业务对应合同审批名称     
          //检查此单据是否正在走流程
        WfCommonAjax.checkDelete(wfname,mid,function(reData){
                if(reData==''){//删除操作                    
                  
             if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
          //     form.action="<%=request.getContextPath()%>/SalcontractAction.do?ids=" + ids;
          //      form.cmd.value = "deleteMulti";
          //     form.submit();
          
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
                                       alert("<fmt:message key="contract_not_delete"/>");  
                                       return;
                                   }else if(text==2){
                                     alert("<fmt:message key="delete_success"/>");  
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
        var url="<%=request.getContextPath()%>/WelfarecontractAction.do?cmd=add&detail=add&f=<%=f%>";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=500px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key="add_contract"/>');
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
        var url="<%=request.getContextPath()%>/SalcontractAction.do?cmd=detail&id=" + ids+"&detail=detail&f=<%=f%>";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key="query_info"/>');
    }
    
        function toApprovk_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/SalcontractAction.do?contract_id=" + ids+"&detail=detail";
        form.cmd.value = "submitTaskDetail";
        form.submit();
    }
    
    

    function workflow_onClick(){  //发起工作流
        var com_id = "${com_id}";
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
        var wfname="SalcontracWorkFlow";//此业务对应合同审批名称     
      //合同生成类型  1模板 2 定制
      var create_type_bd=  document.getElementById(contract_id);
      if(create_type_bd=="1"){
      alert("<fmt:message key="create_contract_examine_operation"/>");
        return ;
     }
       var  constatus;
       var service_company;
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
                service_company=entity.getProperty("service_company");
                if(service_company==null){
                service_company="no_company";
                }
            }
        }
     if("<%=name%>" == '<fmt:message key="admin"/>'){
      alert("<fmt:message key="admin_not_examine"/>");
        return;
     }
      
      if(constatus=="1"){
        alert("<fmt:message key="examine_not_operation"/>");
        return;
     }
     if(constatus=="3"){
        alert("<fmt:message key="contract_examine_not_operation"/>");
        return;
     }
     if(constatus=="4"){
        alert("<fmt:message key="contract_valid_not_examine"/>");
        return;
     }
     if(constatus=="5"){
        alert("<fmt:message key="contract_success_not_examine"/>");
        return;
     }
     if(constatus!="0"&&constatus!="2"){
        alert("<fmt:message key="create_create_submit_examine"/>");
        return;
     }
        //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    form.action="<%=request.getContextPath()%>/SalcontractAction.do?contract_id=" + ids+"&detail=detail&service_company="+service_company;
                    if(com_id == "7779100700000000083"){//如果是杭州的人员登录
                        form.cmd.value = "submitAPProvalHZ";
                    }else{
                        form.cmd.value = "submitAPProval";
                    }
					form.submit();
                }   
                else{
                  alert("<fmt:message key="examine_not_operation"/>");
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

  function workflowaa_onClick(){  //分配经办人
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
        var wfname="SalcontratcAttn";//此业务对分配经办人审批流程名称  
        var  constatus;
        for(var i =0 ;i<id_check.length;i++)
        {
            if(id_check[i].checked)
            {
                var entity =$id("datacell1").dataset.get(i);   
                constatus=entity.getProperty("contract_status_bd");
            }
        }
 	 if("<%=name%>" == '<fmt:message key="admin"/>'){
 	  alert("<fmt:message key="admin_not_create_salse"/>");
  		return;
  	 }
     if(constatus=="4"){
       //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                
             form.action="<%=request.getContextPath()%>/salcontratcAttnAction.do?contract_id=" + ids+"&detail=detail";
               form.cmd.value = "submitAPProval";
                form.submit();
                }   
                else{
                  alert("<fmt:message key="examine_not_operation"/>");
                    return;
                }   
            }
         );      
  }else{
     if(constatus=="5"){
       alert("<fmt:message key="contract_success_not_operation"/>");
     }else{
       alert("<fmt:message key="valid_contract_salse"/>");
     }
  }
  
        
    }

    
      function workflowplay_onClick(){  //支付审批
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
          var contract_id=ids[0].split(",")[0];//单据主键
          var wfname="PayWorkFlow";//此业务对应支付审批名称     

      
       
          //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                
               form.action="<%=request.getContextPath()%>/payWorkFlowAction.do?contract_id=" + ids+"&detail=detail";
               form.cmd.value = "submitAPProval";
                form.submit();
                }   
                else{
                  alert("<fmt:message key="examine_not_operation"/>");
                    return;
                }   
            }
         );        
    }
    
         function workflowbill_onClick(){  //修改账单
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
          var contract_id=ids[0].split(",")[0];//单据主键
        var wfname="BillWorkFlow";//此业务对应修改账单审批名称     
         
        
          //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
               form.action="<%=request.getContextPath()%>/billWorkFlowAction.do?contract_id=" + ids+"&detail=detail";
               form.cmd.value = "submitAPProval";
                form.submit();
       
                }   
                else{
                  alert("<fmt:message key="examine_not_operation"/>");
                    return;
                }   
            }
         );         
    }
    
        function workflowkaipaio_onClick(){  //开票审核
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
          var contract_id=ids[0].split(",")[0];//单据主键
        var wfname="KaiPiaolWorkFlow";//此业务对应开票审核名称     
         //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                 form.action="<%=request.getContextPath()%>/kaiPiaolWorkFlowAction.do?contract_id=" + ids+"&detail=detail";
               form.cmd.value = "submitAPProval";
                form.submit();
                }   
                else{
                  alert("<fmt:message key="examine_not_operation"/>");
                    return;
                }   
            }
         );         
    }
    
             function workflowadjust_onClick(){  //欠款调整
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
          var contract_id=ids[0].split(",")[0];//单据主键
        var wfname="DueAdjustWorkFlow";//此业务对应欠款调整审批名称     
        
          //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    form.action="<%=request.getContextPath()%>/dueAdjustWorkFlowAction.do?contract_id=" + ids+"&detail=detail";
               form.cmd.value = "submitAPProval";
                form.submit();
                }   
                else{
                  alert("<fmt:message key="examine_not_operation"/>");
                    return;
                }   
            }
         );         
    }
    
             function workflowreportTaxation_onClick(){  //分配报税专员
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
          var contract_id=ids[0].split(",")[0];//单据主键
        var wfname="ReportTaxationlWorkFlow";//此业务对分配报税专员审批名称     
          
          //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                   form.action="<%=request.getContextPath()%>/reportTaxationlWorkFlowAction.do?contract_id=" + ids+"&detail=detail";
               form.cmd.value = "submitAPProval";
                form.submit();
                }   
                else{
                  alert("<fmt:message key="examine_not_operation"/>");
                    return;
                }   
            }
         );         
    }
    
        //审批详细操作
    function monitor_onClick(){
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
        var wfname="SalcontracWorkFlow";//此业务对应合同审批名称     
        //var wfname1="SalcontratcAttn";//此业务对应合同审批名称  
        //检查此单据是否正在走流程
       
        WfCommonAjax.checkCurrentWf(wfname,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    alert("没有发起过审批流程,不能进行此操作!");
                    return;
                }   
                else{
                     //跳转到流程详细信息页面
                     monitor(reData);
                }   
            }
         );        
    
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
        var wfname="SalcontracWorkFlow<%=   rayoo.common.filter.UserInfoFilter.geCompanyId()%>";//此业务对应合同审批名称     
        var wfname1="SalcontratcAttnNew<%=   rayoo.common.filter.UserInfoFilter.getCompanyId()%>";//此业务对应分配经办人
        //检查此单据是否正在走流程
          
         //alert('spinto_onClick审批详细');
        WfCommonAjax.checkCurrentWf_Info(wfname,wfname1,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    alert("<fmt:message key="not_contract_not_operation"/>");
                    return;
                }   
                else{
                     //跳转到流程详细信息页面
                //to_monitor(contract_id);
                //alert('测试审批详细');
                var url = "/FAERP/jsp/faerp/sales/salcontract/processdetailpage.jsp?contract_id=" + contract_id+"&wfname="+wfname+"&wfname1="+wfname1+"&_ts='+(new Date()).getTime()";
                showModalCenter(url, window, callBack,740, 360, "<fmt:message key="examine_info"/>"); 
                }   
            }
         );        
    }
    
        //流程详细信息
    function to_monitor(wfid){  //实现转到详细页面
        window.location.href= '/FAERP/taskList4FormAction.do?processInsId='+wfid;
    }
    //流程详细信息
    function monitor(wfid){  //实现转到详细页面
        window.location.href= '/FAERP/taskList4FormAction.do?processInsId='+wfid;
    }
    
   function getSupplierList(){
     var ids = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         if(ids==undefined)return;
    document.form.cust_a_id.value=ids[0];
    document.form.cust_a_name.value=ids[2];
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  >";
    }

    function showListData(){
        var datacellid = $id("datacell1") ;
       datacellid.queryAction = "<%=request.getContextPath()%>/WelfarecontractAction.do?cmd=searchWelfarecontractData";
       datacellid.loadData();
        datacellid.refresh();
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

//返回首页
    function back_to(){
        document.form.action="<venus:base/>/TabannounceinfoAction.do?cmd=queryAll1";
        document.form.submit();
    }
//查询到期合同
function queryExpired(){
        var datacellid = $id("datacell1") ;
       datacellid.queryAction = "<%=request.getContextPath()%>/WelfarecontractAction.do?cmd=queryExpired";
       datacellid.loadData();
        datacellid.refresh();
}

    //导出
    function exportToExcel(){
        if(!$id("datacell1").dataset.get(0)){
            alert("没有需要导出的数据");
            return false;
        }
        $id("datacell_formid").action="<%=request.getContextPath()%>/WelfarecontractAction.do?cmd=export";
        $id("datacell_formid").submit();
    }

</script>
	</head>
	<body>
	<form name="form" method="post" id="datacell_formid"><input
		type="hidden" name="cmd" value="queryAll"> <input
		type="hidden" name="backFlag" value="true"> <input
		type="hidden" name="flag" id="flag" value="<%=flag%>">
	<div id="right"><script language="javascript">
    writeTableTopFesco('<fmt:message key="contract_manage"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">
	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key="query_conditions" /></div>
			</td>
			<td />
			<td />
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="contract_type" /></td>
			<td align="left"><!--<d:select dictTypeId="CONTRACT_TYPE_BD" name="contract_type_bd" value="" />-->
			<d:select dictTypeId="CONTRACT_TYPE_BD" name="contract_type_bd"
				id="contract_type_bd" nullLabel="请选择" value="5" disabled="true" /></td>
			<td align="right"><fmt:message key="contract_status" /></td>
			<td align="left"><!--<d:select dictTypeId="CONTRACT_STATUS_BD" name="contract_status_bd" />-->
			<%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_status_bd", -1, "CONTRACT_STATUS_BD", "", " id=contract_status_bd", false)%>
			</td>
			<td align="right"><fmt:message key="contract_jiafang" /></td>
			<td align="left"><w:lookup onReturnFunc="rtnFunc"
				lookupWidth="189px" readonly="true" id="lk_cust"
				lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=${f}"
				messagekey="choose_customer" height="500" width="810" /> <input
				type="hidden" name="cust_a_name" id="cust_a_name" /> <input
				type="hidden" name="cust_a_id" id="cust_a_id" /></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="contract_code" /></td>
			<td align="left"><input type="text" class="text_field"
				name="contract_code" inputName="合同编号" maxLength="64" /></td>
			<td align="right"><fmt:message key="contract_name" /></td>
			<td align="left"><input type="text" class="text_field"
				name="contract_name" inputName="合同名称" maxLength="50" /></td>
			<td align="right"><fmt:message key="pay_rate" /></td>
			<td align="left"><d:select dictTypeId="PAY_RATE_BD"
				name="pay_rate_bd" id="pay_rate_bd" nullLabel="请选择" /></td>

		</tr>
		<tr>
			<td align="right"><fmt:message key="welfare_type" /></td>
			<td align="left"><d:select dictTypeId="WELFARE_TYPE_BD"
				name="welfare_type_bd" id="welfare_type_bd" nullLabel="请选择" /></td>
			<td align="right"><fmt:message key="contract_start_date" /></td>
			<td align="left"><w:date format="yyyy/MM/dd"
				id="contract_start_date" name="contract_start_date" width="189px" />
			</td>
			<td align="right"><fmt:message key="contract_stop_date" /></td>
			<td align="left"><w:date format="yyyy/MM/dd"
				id="contract_stop_date" name="contract_stop_date" width="189px" /></td>
		</tr>
		<td></td>
		<td></td>
		<td></td>
		<td colspan="2" align="right"><input name="button_ok"
			class="icon_1" type="button" value='<fmt:message key="query"/>'
			onClick="javascript:showListData()"> <input
			name="button_reset" class="icon_1" type="button"
			value='<fmt:message key="reset"/>'
			onClick="javascript:this.form.reset()"></td>
		<tr>
		</tr>
	</table>
	</div>
	<div id="ccParent1" class="button">
	<div class="button_right"><input class="a" type="button"
		value="<fmt:message key="view"/>"
		<au:authorityBtn code="cont_view" type="1"/>
		onClick="detail_onClick();"> <input class="c" type="button"
		value="<fmt:message key="insert"/>"
		<au:authorityBtn code="cont_add" type="1"/> onClick="toAdd_onClick();">
	<input class="b" type="button" value="<fmt:message key="modify"/>"
		<au:authorityBtn code="cont_modify" type="1"/>
		onClick="findCheckbox_onClick();"> <input class="approdetial"
		type="button" value="<fmt:message key="contract_examine"/>"
		<au:authorityBtn code="cont_appr" type="1"/>
		onClick="workflow_onClick();"> <input class="approdetial"
		type="button" value="<fmt:message key="examine_info"/>"
		<au:authorityBtn code="cont_apprInfo" type="1"/>
		onClick="spinto_onClick();"> 
		<input name="button_expire"
            class="approdetial" type="button" value='<fmt:message key="expire"/>'
            onClick="queryExpired()">
        <input class="e" type="button" width="100px"  value="<fmt:message key="export"/>"  onClick="exportToExcel();">
            <%
     if (flag.equals("true")) {
 %> <input
		class="m_1" type="button" value="<fmt:message key="goback_first"/>"
		onClick="back_to();"> <input class="approdetial" type="button"
		value="<fmt:message key="yes"/>" onClick="tonotNeedRemind_onClick();">
	<%
	    }
	%>
	</div>
	<div class="clear"></div>
	</div>
	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction=""
		width="98%" height="318px" xpath="WelfarecontractVo"
		paramFormId="datacell_formid">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="emp" messagekey="operation" width="50px"
			sortAt="none" onRefreshFunc="setCheckboxStatus" align="center">
		</r:field>
		<r:field fieldName="contract_code" messagekey="contract_code"
			width="110px">
		</r:field>
		<r:field fieldName="contract_type_bd" messagekey="contract_type"
			allowModify="false" width="100px">
			<d:select dictTypeId="CONTRACT_TYPE_BD" />
		</r:field>
		<r:field fieldName="contract_name" messagekey="contract_name"
			width="196px">
		</r:field>
		<r:field fieldName="main_part_bd" messagekey="contract_s"
			allowModify="false" width="100px">
		</r:field>
		<r:field fieldName="customer_name" messagekey="contract_jiafang"
			width="196px">
		</r:field>
		<r:field fieldName="contract_start_date"
			messagekey="contract_start_date" allowModify="false">
			<w:date format="YYYY-DD-MM" />
		</r:field>
		<r:field fieldName="contract_stop_date"
			messagekey="contract_stop_date" allowModify="false">
			<w:date format="YYYY-DD-MM" />
		</r:field>
		<!-- 
      <r:field label="审批信息" fieldName="str" width="200px">        
      </r:field>
       -->
		<r:field fieldName="create_date" messagekey="create_date"
			allowModify="false">
			<w:date format="YYYY-DD-MM" />
		</r:field>
		<r:field fieldName="create_user_id" messagekey="create_user_name"
			width="80px">
		</r:field>
		<r:field fieldName="contract_status_bd" messagekey="contract_status"
			allowModify="false" width="100px">
			<d:select dictTypeId="CONTRACT_STATUS_BD" />
		</r:field>
		<r:field fieldName="service_company" messagekey="service_company"
			allowModify="false" width="100px">
			<d:select dictTypeId="SERVICE_COMPANY" />
		</r:field>
		<r:field fieldName="welfare_type_bd" messagekey="welfare_type"
			allowModify="false" width="100px">
			<d:select dictTypeId="WELFARE_TYPE_BD" />
		</r:field>
		<r:field fieldName="pay_rate_bd" messagekey="pay_rate"
			allowModify="false" width="100px">
			<d:select dictTypeId="PAY_RATE_BD" />
		</r:field>
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
<%  //表单回写
    if(request.getAttribute(ISalcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISalcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
//初始化不加载页面信息<siqp添加>
var temp=<%=flag%>;//首页跳转
jQuery(function(){
if(!temp){
    $id("datacell1").isQueryFirst = false;
    }
});
</script>
