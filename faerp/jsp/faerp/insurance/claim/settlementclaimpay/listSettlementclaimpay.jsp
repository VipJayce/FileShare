<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.claim.settlementclaimpay.util.ISettlementclaimpayConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
String name = LoginHelper.getLoginName(request);
%>
<%@page import="gap.authority.helper.LoginHelper"%>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //校验该报价单是否已提交审批或是否已审批完成
        var settlement_id=ids[0].split(",")[0];//单据主键
        var wfname="SettlementClaimPayApproval";//此业务对应合同审批名称
        //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,settlement_id,function(reData){
            if(reData=='0'){
                $id("datacell1").isModefied = false;
                var url="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=find&id=" + ids;
                url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
                showModalCenter(url, window, showListData, 800, 400, "修改付款申请单"); 
            }else{
                $id("datacell1").isModefied = false;
                alert("已经在走审批流程,不能进行此操作!");
                return;
            }   
        }); 
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var mid=new Array();
        //获取单据主键集合
        for (i = 0; i <ids.length; i++) {
            mid[i]=ids[i].split(",")[0];//单据主键
        }
        var wfname="SettlementClaimPayApproval";//此业务对应合同审批名称
        //检查此单据是否正在走流程
        WfCommonAjax.checkDelete(wfname,mid,function(reData){
            if(reData==''){                             //删除操作
	            if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	                $id("datacell1").isModefied = false;
		            form.action="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=deleteMulti&ids=" + ids;
		            form.submit();
		        }
		    }else{
		        $id("datacell1").isModefied = false;
                //要删除的数据中有不能被删除的
                alert(reData);
                return;
            }
        });
	}
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		var url="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=queryCode";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, showListData, 800, 400, "新增付款申请单"); 
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
		var url="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, showListData, 800, 400, "查看付款申请单"); 
	}
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //审批操作
    function toSubmitApproval_onClick(){  //从多选框到修改页面
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //校验该报价单是否已提交审批或是否已审批完成
        var settlement_id=ids[0].split(",")[0];//单据主键
        var wfname="SettlementClaimPayApproval";//此业务对应合同审批名称
        if("<%=name%>" == '系统管理员'){
	        alert("系统管理员 不可以提交审批流程！");
	        return;
	     }
        //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,settlement_id,function(reData){
            if(reData=='0'){
                //没有进行发起过审批
                $id("datacell1").isModefied = false;
                form.action="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=submitApproval1&settlementClaimPayID=" + settlement_id;
                form.submit();
            }else{
                $id("datacell1").isModefied = false;
                alert("已经在走审批流程,不能进行此操作!");
                return;
            }   
        });        
    }
    
    //审批详细操作
    function monitor_onClick(){
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var settlement_id=ids[0].split(",")[0];//单据主键
        var wfname="SettlementClaimPayApproval";//此业务对应合同审批名称     
        //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,settlement_id,function(reData){
            if(reData=='0'){
                //没有进行发起过审批
                $id("datacell1").isModefied = false;
                alert("没有发起过审批流程,不能进行此操作!");
                return;
            }else{
                //跳转到流程详细信息页面
                monitor(reData);
            }   
        });    
    }
    
    //流程详细信息
    function monitor(wfid){  //实现转到详细页面
        window.location.href= '/FAERP/taskList4FormAction.do?processInsId='+wfid;
    }
    
    /**
	 * 点击全选按钮
	 * @param {} item
	 */
	function checkAll(item) {//alert(item.value);注释时间 2014年7月29日
	    if (_$(item).attr("checked")) {
	        changeEntityChk(true);
	        _$(":checkbox").attr("checked", true);
	        procEbankdownBtn();
	    } else {
	        changeEntityChk(false);
	        _$(":checkbox").attr("checked", false);
	        procEbankdownBtn();
	    }
	}
	
	//显示一列chkbox
	function showchkbox(value,entity,rowNo,cellNo){
	    return "<input type='checkbox' onclick='procEbankdownBtn();' name='chk_id' value='" + entity.getProperty("id") + "' />";
	}
	
	/**
	*根据付款申请单明细的银行类别灰掉网银下载按钮
	*/
	function procEbankdownBtn(){
	    getChkedRecord2();
	}
	
	//获得选中的记录
	function getChkedRecord2(){
	    var total_icbc = 0;
	    var total_cmb = 0;
	    var ds = $id("datacell1").dataset;
	    jQuery("input[name='chk_id']").each(function(){
	        if(jQuery(this).attr("checked")){
	            var entity = ds.findEntity("id",this.value);
	            var icbc = entity.getValue("total_number");     //工行
	            var cmb = entity.getValue("total_amount");       //招行
	            total_icbc =total_icbc+ icbc;
	            total_cmb =total_cmb+ cmb;
	        }
	    });
	    if(total_icbc <= 0){
	         jQuery("#btn_down_icbc").attr("disabled","disabled");
	    }else{
	         jQuery("#btn_down_icbc").removeAttr("disabled");
	    }
	    if(total_cmb <= 0){
	         jQuery("#btn_down_cmb").attr("disabled","disabled");
	    }else{
	         jQuery("#btn_down_cmb").removeAttr("disabled");
	    }
	}
	
	/**
	 * 改变datacell中的chk的值
	 * @param {} flag
	 */
	function changeEntityChk(flag) {
	    var dc1 = $id("datacell1").dataset;
	    var values = dc1.values;
	    for(var i=0; i<values.length; i++){
	        var entity = values[i];
	        entity.setProperty("chk", flag);
	    }
	}
	
	/**
	 * 选择行后返回ids
	 */
	function selectIds() {
	    var myids = new Array(0);
	    var dc = $id("datacell1");
	    var ds = dc.dataset;
	    _$("input[type='checkbox']").each(function(i) {
	        //第0个为全选按钮
	        if (i != 0 && _$(this).attr("checked")) {
	            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	            var entity = dc.getEntity(row);
	            //此id为post_id
	            //myids += entity.getValue("id") + ",";
	            myids.push(entity.getValue("id"));
	        }
	    });
	    return myids;
	}
	
	//导出短信数据
	function exportSMS_onClick()
	{
	  var ids = selectIds();
	  if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
      }
		var url="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=exportSMSsettlementclaimpay&ids=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
	  if(confirm('是否确定要导出短信？')) {
	      window.location.href=url;
      }
	}
	
	//导出付款申请单	
	function exportSettPay_onClick()
    {
      if(confirm('是否确定要导出数据？')) {
          document.form.action="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=exportToExcelSettlementclaimPay";
          document.form.submit();
      }
    }
	
	function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid"> 
<input type="hidden" name="batchId" id="h_batchId_ebank"/>
<input type="hidden" name="bankType" id="h_bankType_ebank"/>
<input type="hidden" name="cmd" id="h_cmd_ebank"/>
<div id="right">
<script language="javascript">
	writeTableTopFesco('付款申请单管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="5" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
		</tr>
				<tr>
			<td align="left">付款单编号</td>
			<td align="left">
				<input type="text" class="text_field" name="sett_claim_pay_code" inputName="付款单编号" maxLength="64"/>
			</td>
			<td align="left">批次号 </td>
			<td align="left">
				<w:date format="yyyy-MM-dd" id="batch_num" name="batch_num" width="190px"/>
			</td>			
            <td align="left">保险公司</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" name="insurance_agent_name" id="lk_cust" lookupUrl="/InsuranceAegntAction.do?cmd=queryAllGetByID" dialogTitle="选择保险公司" height="500" width="800"/>
            </td>
		</tr>
		<tr>
			<td align="left">申请人</td>
			<td align="left">
				<input type="text" class="text_field" name="create_user" inputName="申请人" maxLength="50"/>
			</td>
			<td align="left">申请日期</td>
			<td align="left">
				<w:date format="yyyy-MM-dd" id="create_date_search" name="create_date_search" width="189px"/>
			</td>
			<td align="left">审批状态</td>
			<td align="left">
			    <d:select dictTypeId="APPROVAL_STATE_BD" name="approval_state" id="approval_state" nullLabel="请选择"/>
			</td>
		</tr>
		<tr>
		    <td align="left">&nbsp;</td>
            <td align="left">
                &nbsp;
            </td>
            <td align="left">&nbsp;</td>
            <td align="left">
                &nbsp;
            </td>
		    <td align="right">&nbsp;</td>
            <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();">&nbsp;&nbsp;<input name="button_ok" class="icon_1"   type="reset" value='<fmt:message key="reset"/>'>
            </td>
		</tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
				    <li class="a">     <a  onClick="javascript:detail_onClick();"><fmt:message key="view" /> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>	
					<li class="b">     <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>				
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>					
					<li class="h">    <a  onClick="javascript:toSubmitApproval_onClick();">审批 </a> </li>
					<li class="approdetial"><a  onClick="javascript:monitor_onClick();">审批详细 </a> </li>					
				</ul>
				-->
				<input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="lpfksqd_view" type="1"/>  onClick="detail_onClick();">
                 <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="lpfksqd_add" type="1"/>  onClick="toAdd_onClick();">
                 <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="lpfksqd_xg" type="1"/>  onClick="findCheckbox_onClick();"> 
                 <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="lpfksqd_del" type="1"/>  onClick="deleteMulti_onClick();">      
                 <input class="h" type="button"   value="审批"  <au:authorityBtn code="lpfksqd_appr" type="1"/>  onClick="toSubmitApproval_onClick();">
                 <input class="approdetial" type="button"   value="审批详细"  <au:authorityBtn code="lpfksqd_apprInfo" type="1"/>  onClick="monitor_onClick();">    
                 <input class="e_3" type="button"   value="导出短信"  <au:authorityBtn code="lpfksqd_view" type="1"/>  onClick="exportSMS_onClick();">
                 <input id="btn_down_icbc" onclick="downEbankfile(1)" type="button" class="dj_3" value="下载工行网银" />
                <input id="btn_down_cmb" onclick="downEbankfile(2)" type="button" class="dj_3" value="下载招行网银" />
                <input class="e" type="button"   value="导出"  onClick="exportSettPay_onClick();">
		 </div>
           <div class="clear"></div>			
</div>
 <div id="values_div"> 
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SettlementclaimpayAction.do?cmd=searchMSettlementclaimpayData"
        width="98%"
        height="318px"
        xpath="SettlementclaimpayVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <!--<r:field fieldName="emp" label="操作" sortAt="none" width="50px" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      -->
      <r:field allowModify="false" fieldName="chk"
            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            sortAt="none" width="30px" onRefreshFunc="showchkbox">
        </r:field>
      <r:field fieldName="insurance_agent_name" width="150px" label="保险公司">
      </r:field>
      <r:field fieldName="sett_claim_pay_code" width="100px" label="付款申请单编号">
      </r:field>
      <r:field fieldName="total_number" width="0px" label="工商">
      </r:field>
      <r:field fieldName="total_amount" width="0px" label="招商">
      </r:field>
      <r:field fieldName="pay_type" width="80px" label="付款类型" allowModify="false">
      <d:select dictTypeId="PAY_TYPE" />
      </r:field>
      <r:field fieldName="create_user" width="80px" label="申请人">
      </r:field>
      <r:field fieldName="create_date" width="100px" label="申请日期" allowModify="false">
      <w:date format="yyyy-MM-dd" id="create_date" name="create_date" width="189px"/>
      </r:field>      
      <r:field fieldName="str" label="审批信息" width="195px">
      </r:field>
      <r:field fieldName="approval_state" label="审批状态" width="80px" allowModify="false">
      <d:select dictTypeId="APPROVAL_STATE_BD" />
      </r:field>
      <r:field fieldName="batch_num" label="批次号" width="100px">
      </r:field>
      <r:field fieldName="total_count" label="合计金额" width="100px">
      </r:field>
       <r:field fieldName="appropriation_date" width="100px" label="划款日期" allowModify="false">
      <w:date format="yyyy-MM-dd" id="appropriation_date" name="appropriation_date" width="189px"/>
      </r:field> 
      <r:field fieldName="remark" width="200px" label="备注">
      </r:field>
    </r:datacell>
</div>
</div>
</div>
</form>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(ISettlementclaimpayConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISettlementclaimpayConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>


//下载网银
function downEbankfile(bankType){
    var ids = selectIds();
    if(ids.length<=0){
        alert('<fmt:message key="select_one_record"/>');
        return;
    }
    if(ids.length > 1) {  //如果ids有2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
        return;
    }
    $id("h_batchId_ebank").value = ids;
    $id("h_bankType_ebank").value = bankType;
    $id("h_cmd_ebank").value = "downEbankfile";
    $id("datacell_formid").action = "<%=request.getContextPath()%>/SettlementclaimpayAction.do" ;
    $id("datacell_formid").submit();
}
</script>	
</fmt:bundle>