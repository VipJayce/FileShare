<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.quotation.vo.QuotationVo" %>
<%@ page import="rayoo.sales.quotation.util.IQuotationConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%
    //判断是否为修改页面
    QuotationVo resultVo = null; //定义一个临时的vo变量
    boolean isModify = false; //定义变量,标识本页面是否修改(或者新增)
    if (request.getParameter("isModify") != null) { //如果从request获得参数"isModify"不为空
        isModify = true; //赋值isModify为true
    }
    
    //列表页面查询条件回显----魏佳修改
    String quotation_status_request = request.getParameter("quotation_status");
    int quotation_status_int = -1;
    if(!"".equals(quotation_status_request) && !"null".equals(quotation_status_request) && quotation_status_request != null){
        quotation_status_int = Integer.parseInt(quotation_status_request);
    }
%>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle basename="rayoo.salse.quotation.quotation_resource" prefix="rayoo.salse.quotation.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
      function findSelections2(checkboxName, idName) {  //从列表中找出选中的id值列表
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
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        var nodeleteentity="";
        var ids1=null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
               number += 1;  //游标加1
               var entity=$id("datacell1").dataset.get(i);   

              if(entity.getProperty("quotation_status")=="<fmt:message key="examineing"/>"){
                    nodeleteentity+=("<fmt:message key="now_code"/>"+entity.getProperty("quotation_code")+"<fmt:message key="quotation_not_delete"/>\n"); 
              }
              else{     
                    ids.push(elementCheckbox[i].value);  //加入选中的checkbox
              }
            }
        }
        var returnAry = new Array();
         returnAry[0] = ids;
         returnAry[1] = nodeleteentity;
         returnAry[2] = number;
         return returnAry;
    }
    
       function findSelections1(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        var nodeleteentity="";
        var ids1=null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
               number += 1;  //游标加1
               var entity=$id("datacell1").dataset.get(i);   
              if(entity.getProperty("quotation_status")=="生效")
              {
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
              }
              else
              {     
                    nodeleteentity+=("<fmt:message key="now_code"/>"+entity.getProperty("quotation_code")+"<fmt:message key="quotation_not_delete"/>\n"); 
              }
            }
        }
        var returnAry = new Array();
         returnAry[0] = ids;
         returnAry[1] = nodeleteentity;
         returnAry[2] = number;
         return returnAry;
    }
    
    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections2("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
         //校验该报价单是否已提交审批或是否已审批完成
        var quotation_id=ids[0].split(",")[0];//单据主键
        var wfname="QuotationApproval";//此业务对应报价单审批名称
        //检查此单据是否正在走流程
        
        WfCommonAjax.checkQuotationState(quotation_id,function(reData){
        //alert('reData='+reData);
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        activeRow_sc = activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("add_type_bd")== "5" && reData=='3'){//3 生效的    专项外包报价单也不能修改 
            alert('审批生效的专项外包报价单不能修改！');
            return;
        }
         if(reData=='5'|| reData=='0' || reData=='3' || reData=='4'){
                //0  可以修改   1 不允许修改  2驳回的只能是发起人在工作流中修改 3 生效的  可以修改   4撤销的 可以修改   5  已经挂了员工  只能修改名称
                //2015-3-12 yangyuting add datasettr.getProperty("add_type_bd")== "3" 
                //(datasettr.getProperty("add_type_bd")== "5"||datasettr.getProperty("add_type_bd")== "3")  &&
                if( reData=='5'){//5  已经挂了员工 的  专项外包报价单也不能修改 
                    //alert('<fmt:message key="quotation_emp_not_modify"/>');
                    alert("已经挂了员工的报价单不允许修改！");
                    return;
                }      
                 //form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=find&id=" + ids + "&reData="+reData+"&quotation_code="+quotation_code+"&quotation_name="+quotation_name+"&customer_name1="+customer_name+"&quotation_status="+quotation_status ;
                 //form.submit();
                 var url = "<%=request.getContextPath()%>/QuotationAction.do?cmd=find&id=" + ids;
                 window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改报价单');
                 //$id("datacell1").refresh();
            }else if(reData=='1'){
                 alert("<fmt:message key="quotation_examine_not_modify"/>");
                  return;
            }else if(reData=='2'){
                  alert("<fmt:message key="quotation_goback_modify"/>");
                  return;
            }else{
                  alert("<fmt:message key="quotation_error_not_modify"/>");
                  return;
            }
        });  
        
    }
      
    function deleteMulti_onClick(){  //从多选框逻辑删除多条记录
        var url = "";
        var dataCount = $id("datacell1").getTotalRowCount();
        
        var quotation_code = $id("quotation_code").value; 
        var quotation_name = $id("quotation_name").value; 
        var customer_name = $id("customer_name1").value==null?"":$id("customer_name1").value; 
        var quotation_status = $name("quotation_status").value;  
        
        //quotation_name = encodeURI(encodeURI(quotation_name));
        //customer_name = encodeURI(encodeURI(customer_name));
        
        var arrayStr = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(arrayStr[2] <=0) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
    
        //2016-05-27   by zhouxiaolong  删除报价单记录时验证该报价单下是否挂了员工   begin
        //校验该报价单是否已提交审批或是否已审批完成
        var ids = findSelections2("checkbox_template","id");  //取得多选框的选择项
        var quotation_id=ids[0].split(",")[0];//单据主键
        var wfname="QuotationApproval";//此业务对应报价单审批名称
        WfCommonAjax.checkQuotationState(quotation_id,function(reData){
        //alert('reData='+reData);
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        activeRow_sc = activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if( reData=='5'){//5  已经挂了员工 的  专项外包报价单也不能修改 
            alert("已经挂了员工的报价单不允许删除！");
            return;
        }else{
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
        
            if(arrayStr[1].length>0)
            {
                 w=confirm(arrayStr[1]);
                 if(w)
                 {
                      if(arrayStr[0].length>0)
                      {
                            if(dataCount > 1){
                               url = "<%=request.getContextPath()%>/QuotationAction.do?cmd=deleteMulti&ids=" + arrayStr[0]+"&quotation_code="+quotation_code+"&quotation_name="+quotation_name+"&customer_name1="+customer_name+"&quotation_status="+quotation_status;
                            }else{
                               url = "<%=request.getContextPath()%>/QuotationAction.do?cmd=deleteMulti&ids=" + arrayStr[0];
                            }
                            form.action=url;
                            form.submit();
                      }
                 }
            }
            else
            {
                    if(arrayStr[0].length>0)
                      {
                            url = "<%=request.getContextPath()%>/QuotationAction.do?cmd=deleteMulti&ids=" + arrayStr[0]+"&quotation_code="+quotation_code+"&quotation_name="+quotation_name+"&customer_name1="+customer_name+"&quotation_status="+quotation_status;
                            form.action=url;
                            form.submit();
                      }
            }
        }
    }
        }); 
      //2016-05-27   by zhouxiaolong  删除报价单记录时验证该报价单下是否挂了员工   end
      
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
       $id("datacell1").addParam("quotation_code",$id("quotation_code").value); 
       $id("datacell1").addParam("quotation_name",$id("quotation_name").value); 
       $id("datacell1").addParam("customer_name1",$id("customer_name1").value==null?"":$id("customer_name1").value); 
       $id("datacell1").addParam("quotation_status",$name("quotation_status").value);
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function toAdd_onClick() {  //到增加记录页面
        //form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=QuotationCode";
        //form.submit();
        var url = "<%=request.getContextPath()%>/QuotationAction.do?cmd=QuotationCode";
        window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
        //window.showModalDialog (url,"","location:No;status:No;help:No;dialogWidth:850px;dialogHeight:500px;scroll:yes;resizable:yes;"); 
    }
    
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections2("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url = "<%=request.getContextPath()%>/QuotationAction.do?cmd=detail&id=" + ids;
        window.showModalDialog (url,"","location:No;status:No;help:No;dialogWidth:850px;dialogHeight:500px;scroll:yes;resizable:yes;");
    }

   function getcustomerList(){   
         var url="<%=request.getContextPath()%>/jsp/faerp/common/sales/allCustomer.jsp";
         showModalCenter(url, window,toFindCustomer,750,434,"<fmt:message key="choose_customer"/>");
    }
    function toFindCustomer(obj)
    {
        var lookup = $id("customer_name1");
        lookup.value = obj[2];
        //alert(obj[2]);
        lookup.displayValue = obj[2];
        return false;
        //document.form.customer_name1.value=obj[2];
        //document.form.customer_name.value=obj[2];
           
    }
   function toSubmitApproval_onClick(){  //从多选框到修改页面
        var ids = findSelections2("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //校验该报价单是否已提交审批或是否已审批完成
        var quotation_id=ids[0].split(",")[0];//单据主键
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        activeRow_sc = activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("add_type_bd")== "5" && datasettr.getProperty("check_status")=='0'){
            alert('<fmt:message key="quotation_not_success"/>');
            return;
        }
        var wfname="QuotationApproval";//此业务对应报价单审批名称
        
        //判断报价单明细里是否有产品 add by yiwenbin
        WfCommonAjax.checkQuotationItem(quotation_id,function(reData){
        	if(reData=='0'){
        		alert('报价单产品不能为空，请至少添加一个产品！');
        		return;
        	}else{
        		//检查此单据是否正在走流程
		        WfCommonAjax.checkQuotationState(quotation_id,function(reData){
		        //alert('reData='+reData);
		                if(reData=='0'){
		                    //未审批，可走审批流程
		                    if("${com_id}" == "7779100700000000083"){
		                       var url = "<%=request.getContextPath()%>/QuotationAction.do?cmd=createQuoWFHZ&quotation_id=" + ids;
		                       window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
		                       //form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=createQuoWFHZ&quotation_id=" + ids;
		                    }else{
		                       var url = "<%=request.getContextPath()%>/QuotationAction.do?cmd=createQuoWF&quotation_id=" + ids;
		                       window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
		                       //form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=createQuoWF&quotation_id=" + ids;
		                    }
		                    //form.submit();
		                    //$id("datacell1").refresh();
		                }else if(reData=='1' || reData=='2'){
		                     alert("<fmt:message key="quotation_examine_not_submit"/>");
		                      return;
		                }else if(reData=='3'){
		                      alert("<fmt:message key="quotation_success_not_submit"/>");
		                      return;
		                }
		            }
		         );  
        	}
        });
    }
    
            //审批详细操作
    function monitor_onClick(){
        var ids = findSelections2("checkbox_template","id");  //取得多选框的选择项
        //alert(ids);
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }

        //校验该报价单是否已提交审批或是否已审批完成
        var quotation_id=ids[0].split(",")[0];//单据主键
        //var wfname="QuotationApproval";//此业务对应合同审批名称     
        var wfname="";
        //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,quotation_id,function(reData){
        //alert("reData="+reData);
                if(reData=='0'){
                    //没有发起过审批
                    alert("<fmt:message key="not_examine_not_operation"/>");
                    return;
                }   
                else{
                     //跳转到流程详细信息页面
                     monitor(reData);
                }   
            }
         );        
    
    }
    
        //流程详细信息
    function monitor(wfid){  //实现转到详细页面
        var url = '/FAERP/taskList4FormAction.do?processInsId='+wfid+"&close=true";
        window.showModalDialog (url,"","location:No;status:No;help:No;dialogWidth:1200px;dialogHeight:500px;scroll:yes;resizable:yes;");
        //window.open(url,'','height=500px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改报价单');
        //window.location.href= '/FAERP/taskList4FormAction.do?processInsId='+wfid;
    }
    
    //作废报价单
    function toDiscard_onClick()
    {
         var arrayStr = findSelections1("checkbox_template","id");  //取得多选框的选择项
        if(arrayStr[2] <=0) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="cofirm_zuofei"/>')) {  //如果用户在确认对话框按"确定"
        
            if(arrayStr[1].length>0)
            {
                 w=confirm(arrayStr[1]);
                 if(w)
                 {
                      if(arrayStr[0].length>0)
                      {
                            form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=discardMulti&ids=" + arrayStr[0];
                            form.submit();
                      }
                 }
            }
            else
            {
                    if(arrayStr[0].length>0)
                      {
                            form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=discardMulti&ids=" + arrayStr[0];
                            form.submit();
                      }
            }
        }
    }
    function printQuotation_onClick()
    {
        var ids = findSelections2("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showQuotationReport.jsp?raq=quotation.raq&arg1="+ids;
        form.submit();
    }
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value=" + entity.getProperty("id") + "  onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
    function ClickRow()
    {}
</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/QuotationAction.do">
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="quotation_manage"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title"><fmt:message key="query_conditions"/></div>
            </td>

            <td><fmt:message key="bianhao"/></td><!--           ${customer_name }       --> 
            <td><input type="text" class="text_field"  id = "quotation_code" name="quotation_code" inputName="报价单编号" maxLength="64" value="${quotation_code }" /></td>

            <td><fmt:message key="quotation_name"/></td>
            <td><input type="text" class="text_field"  id = "quotation_name" name="quotation_name" inputName="报价单名称" maxLength="50"   value="${quotation_name }" /></td>
        </tr>
    
        <tr>
            <td><fmt:message key="customer_name"/></td>
            
            <td>
                  <!-- <input type="hidden" id = "customer_name1" name="customer_name1"/> -->
                  <w:lookup onReturnFunc="toFindCustomer" id="customer_name1"   name="customer_name1" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"  messagekey="choose_customer" height="434" width="750" style="width:188px"/> 
                </td>  
            <td><fmt:message key="status"/></td>
            <td><!-- ("${quotation_status }" == "" ? -1 : Integer.parseInt("${quotation_status }")) -->
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("quotation_status",quotation_status_int,"SAL_QUO_STATUS", "", "id='quotation_status1'", false) %>
                </td>
                <td><input name="button_ok" class="icon_1" type="button"
                value='<fmt:message key="query"/>'
                onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
                </td>
            <td />
        </tr>
    </table>
</div>
                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
        <!--<ul>
        <li class="a"><a onClick="javascript:detail_onClick();"><fmt:message
            key="view" /> </a></li>
        <li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message
            key="insert" /> </a></li>
        <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message
            key="delete" /> </a></li>
        <li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message
            key="modify" /> </a></li>
         li class="j_1"><a onClick="javascript:printQuotation_onClick();"><fmt:message
            key="Print" /></a></li> 
         li class="k"><a onClick="javascript:toDiscard_onClick();"><fmt:message
            key="Discard" /></a></li> 
        <li class="g"><a onClick="javascript:toSubmitApproval_onClick();">提交审批</a></li>
        <li class="approdetial"><a  onClick="javascript:monitor_onClick();">审批详细 </a> </li>
        </ul>
                -->
                <input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="quot_view" type="1"/>  onClick="detail_onClick();">
                 <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="quot_add" type="1"/>  onClick="toAdd_onClick();">
                 <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="quot_del" type="1"/>  onClick="deleteMulti_onClick();">
                 <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="quot_modify" type="1"/>  onClick="findCheckbox_onClick();">
                 <input class="g" type="button"   value="<fmt:message key="quot_appr"/>"  <au:authorityBtn code="quot_appr" type="1"/>  onClick="toSubmitApproval_onClick();">              
                 <input class="approdetial" type="button"   value="<fmt:message key="quot_apprInfo"/>"  <au:authorityBtn code="quot_apprInfo" type="1"/>  onClick="monitor_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
 <div style="padding: 8 5 8 8;">
  <r:datacell 
        id="datacell1"
       queryAction="/FAERP/QuotationAction.do?cmd=simpleQuery"
       submitAction="/FAERP/QuotationAction.do?cmd=insert"
        width="98%"
        height="320"
        xpath="QuotationVo"
        submitXpath="QuotationVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       <r:field fieldName="quotation_code" width="200px" messagekey="bianhao" >
       </r:field>    
      <r:field fieldName="quotation_name" width="200px" messagekey="quotation_name" >
       </r:field>    
       <r:field fieldName="customer_name" width="200px" messagekey="customer_name" >
       </r:field>    
       <r:field fieldName="quotation_status" width="90px" messagekey="status" >
       </r:field>   
       <r:field fieldName="info" width="200px"  messagekey="examine_info">
       </r:field>           
       <r:field fieldName="create_date" width="105px" messagekey="create_date" allowModify="false">
        <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>    
       <r:field fieldName="create_user" width="100px" label="" messagekey="create_user">
       </r:field>      
     
    </r:datacell>
 
</div>

</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚

</script>
</body>
</html>
<script language="javascript">
    jQuery(function(){
         //页面查询条件回显----魏佳修改
         if("${quotation_code}" == "" && "${quotation_name}" == "" && "${customer_name}" == "" && "${quotation_status}" == ""){
               $id("datacell1").isQueryFirst = false;
         }else{
               var obj = document.getElementById("quotation_status1");
                 for (var i = 0; i < obj.options.length; i++) {
                   if(obj.options[i].value == <%=quotation_status_int%>) {  
                        obj.options[i].selected = true;  
                        break;  
                    }    
                 }
               document.getElementById("quotation_name").value="${quotation_name}".replace('~','+');
               document.getElementById("customer_name1_input").value="${customer_name}";
               $id("customer_name1").value = "${customer_name}";
               $id("datacell1").addParam("quotation_code","${quotation_code}"); 
               $id("datacell1").addParam("quotation_name","${quotation_name}"); 
               $id("datacell1").addParam("customer_name1","${customer_name}"); 
               $id("datacell1").addParam("quotation_status","${quotation_status}");
               simpleQuery_onClick();
         }
    });
    
</script>
