<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.project.IToolsConstants"%>

<html>
<fmt:bundle basename="rayoo.employeepost.emp_into_resignation_query.emp_into_resignation_query_resource" prefix="rayoo.employeepost.emp_into_resignation_query.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript"><!--
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });
    
    jQuery(document).ready(function() {
     if($id("datacell1")==null)return;
     $id("datacell1").afterRefresh = function(){
        var Me = $id("datacell1");
        var rows = Me.allTR;
        for (var i=0;i<rows.length;i++ ){
          var entity1 = Me.dataset.get(i);
          var post_status_bd = entity1.getProperty("post_status_bd");
          if(post_status_bd!=null && post_status_bd=='3'){
            rows[i].style.backgroundColor = "#cce8cf";
          }
          
        }        
    }
});
    
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=\"ClickRow('" + entity.getProperty("eid") + "','" + entity.getProperty("id") + "');\">";
     }
    
    function ClickRow(value,value1){
        $id("postid").value = value1;
    }

    function showListData(){
         $id("datacell1").loadData();
         $id("datacell1").refresh();
     }
     
     function resetQuery(){
        $id("cust_name").value="";
        $id("cost_center_id").value="";
    }
    
    //查看个人订单信息 参数为PB_EMP_POST表中的主键id
    function detail_onClick(){
        var dc = $id("datacell1");
        var entity =dc.getActiveEntity();
        var emp_post_id = entity.getProperty("id");
	    if(emp_post_id==null || emp_post_id==''){
	        alert("<fmt:message key="select_one_record"/>");
	        return ;
	    }
        //var emp_post_id = document.getElementById("postid").value;
        window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        //window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
        
    }
    
    //查看个人订单信息 参数为PB_EMP_POST表中的主键id
    function detail_update_onClick(){
    	var entity_re = getSelectedEntity();
    	if (entity_re[0]==0) {
	        alert("请先选择一条记录");
	        return false;
    	}
    	if(entity_re[0]>1){
         	alert("只能选择一条记录");
       		return false;
    	}
    	var entity=entity_re[1];
		var emp_post_id = entity.getValue("id");
		var cust_receive_id = entity.getValue("cust_receive_id");//客户接单方id,用于判断是否为全国系统的员工
		var isonline = entity.getValue("isonline");//是否线上操作员工
    
        if(cust_receive_id!="1099120100000000439" && "${send_data_to_xpress}"=="true"){
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderForQuanGuo&id='+emp_post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        }else{
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+emp_post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        }
    }
    
    function toUpdate_onClick(){
    	var entity_re = getSelectedEntity();
    	if (entity_re[0]==0) {
	        alert("请先选择一条记录");
	        return false;
    	}
    	if(entity_re[0]>1){
         	alert("只能选择一条记录");
       		return false;
    	}
    	var entity=entity_re[1];
		var emp_post_id = entity.getValue("id");   
        //form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=findEmpIntoResignation&post_id=" + emp_post_id;
        //form.submit();
        window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=findEmpIntoResignation&post_id='+emp_post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
    //员工个人订单修改
    function toUpdateOrder_onClick(){
    	var entity_re = getSelectedEntity();
    	if (entity_re[0]==0) {
	        alert("请先选择一条记录");
	        return false;
    	}
    	if(entity_re[0]>1){
         	alert("只能选择一条记录");
       		return false;
    	}
    	var entity=entity_re[1];
		var emp_post_id = entity.getValue("id");   
   
        window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id+"&isModify=1",'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    //查看员工工资 社保 公积金 福利等明细信息  先跳入的是工资信息
    function toLeaveDetailInfo(){
    	var entity_re = getSelectedEntity();
    	if (entity_re[0]==0) {
	        alert("请先选择一条记录");
	        return false;
    	}
    	if(entity_re[0]>1){
         	alert("只能选择一条记录");
       		return false;
    	}
    	var entity=entity_re[1];
		var emp_post_id = entity.getValue("id");   
   
        window.open('<%=request.getContextPath()%>/SalarydataAction.do?cmd=toDetailSalaryPage&emp_post_id='+emp_post_id,'','height=400px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    //其他查询2 查看员工工资 社保 公积金 福利等信息  先跳入的是工资信息 2014-12-24 yangyuting add
    function toLeaveDetailOthersInfo(){
    	//action里方法已经被注释（原因不明），会报错，先屏蔽此方法
    	return;
    	
    	var entity_re = getSelectedEntity();
    	if (entity_re[0]==0) {
	        alert("请先选择一条记录");
	        return false;
    	}
    	if(entity_re[0]>1){
         	alert("只能选择一条记录");
       		return false;
    	}
    	var entity=entity_re[1];
		var emp_post_id = entity.getValue("id");   
	
        window.open('<%=request.getContextPath()%>/SalarydataAction.do?cmd=toDetailSalaryOthersPage&emp_post_id='+emp_post_id,'','height=400px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
    function toUpdateCustCode_onClick() { 
        //需要取到返回值
          var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=updateEmpIntoResignationForInternalCode";
          var dc1 = $id("datacell1");
          var xmlSubmit = dc1.dataset.toString();
          var myAjax = new Ajax(action);
          myAjax.submitXML(xmlSubmit, 'UTF-8');
          var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 alert(""+myAjax.getProperty("returnValue"));
                 showListData();
             }
        //$id("datacell1").submit();
    }
    
    //派出单位选择回调函数
    function rtnFuncSend(arg){
        var lookup = $id("cust_send_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    
    //接收单位选择回调函数
    function rtnFuncRecive(arg){
        var lookup = $id("cust_receive_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    
    function rtnFunSend(arg){
        var lookup = $id("lk_wpd");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    
    function exp_onClick(){  //实现转到详细页面
        form.action="<%=request.getContextPath()%>/EmppostAction.do";
        form.cmd.value = "exportAllpost";
        form.submit();
    }
--></script>
</head>
<body>

<form name="form" method="post" id="empIntoResigQuery_formid">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="emp_post_query"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

		<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="emp_code"/></td>
			<td align="left">
			   <input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64" style="width:215"/>            </td>
			<td align="right"><fmt:message key="emp_name"/></td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="20" style="width:215"/>			</td>
            <td align="right"><fmt:message key="internal_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code1" inputName="客户方编号" maxLength="64" style="width:245"/>            </td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="身份证号" maxLength="64" style="width:215"/>            </td>
		    <td align="right"><fmt:message key="cust_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="64" style="width:215"/>           </td>
			<td align="right"><fmt:message key="cust_name"/></td>
			<td align="left">
			     <w:lookup id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"  name="cust_name1"
		            messagekey="choose_cust" height="500" width="810" style="width:230px"/>
                <!--<input id="cust_name1" name="cust_name1" type="hidden"/>-->
			</td>
		</tr>
		<tr>
		    <td align="right"><fmt:message key="cost_center"/></td>
            <td align="left">
	            <r:comboSelect id="cost_center_id" name="cost_center_id"
	                queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
	                textField="cost_center_name"
	                valueField="id"
	                xpath="CostcenterVo"
	                width="210" messagekey="please_choose">
	            </r:comboSelect>
            </td>
			<td align="right"><fmt:message key="cust_send_id"/></td>
            <td>
                <w:lookup onReturnFunc="rtnFuncSend" readonly="false" id="cust_send_id" displayValue=""   name="cust_send_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" messagekey="choose_agent" height="440" width="800" style="width:170px">
                </w:lookup>
            </td>
            <td align="right"><fmt:message key="cust_receive_id"/></td>
            <td>
                <select name="cust_receive_id" id="cust_receive_id" style="width:245">
                     <option value="">请选择</option>
                     <option value="<%=IToolsConstants.AGENT_SH%>">北京外企德科人力资源服务上海有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_BJ%>">北京外企人力资源服务有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_WD%>">外地供应商</option>
               </select>
            </td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="send_name"/></td>
			<td align="left">
			     <w:lookup onReturnFunc="rtnFunSend" readonly="true" name="send_id" id="lk_wpd" lookupUrl="/SendAction.do?cmd=queryAllSend" messagekey="choose_send" height="440" width="800"  style="width:195px"/>
			</td>
			<td align="right"><fmt:message key="emp_type"/></td>
			<td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_post_type_bd1", -1,"EMP_POST_TYPE_BD", "", "style='width:210'", false) %></td>
			<td align="right"><fmt:message key="on_post_date"/></td>
			<td align="left"><w:date format="yyyy-MM-dd" name="on_post_date_from" width="93px"/>&nbsp;<fmt:message key="to"/>&nbsp;<w:date format="yyyy-MM-dd" name="on_post_date_to" width="93px"/></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="post_status"/></td>
			<td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("post_status_bd1", -1,"POST_STATUS_BD", "", "style='width:210'", false) %></td>
			<td align="right"><fmt:message key="sort_by"/></td>
			<td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_by", -1,"SORT_BY", "", "style='width:210'", false) %>
            </td>
			<td align="right"><fmt:message key="off_post_date"/></td>
			<td align="left"><w:date format="yyyy-MM-dd" name="off_post_date_from" width="93px"/>&nbsp;<fmt:message key="to"/>&nbsp;<w:date format="yyyy-MM-dd" name="off_post_date_to" width="93px"/></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="sort_order"/></td>
			<td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("sort_order", -1,"SORT_ORDER", "", "style='width:210'", false) %>
            </td>			
			<td align="right">全国数据状态</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("data_send_status1", -1,"DATA_SEND_STATUS", "", "style='width:210'", false) %>
            </td>
            <td align="right"><fmt:message key="off_post_user_search_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="off_post_user_search_name" inputName="报离职人" maxLength="200" style="width:245"/>
            </td>
		</tr>
		<tr>
            <td align="right">重发类型</td>
            <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("data_send_type", -1,"DATA_SEND_TYPE", "", "style='width:210'", false) %>
            </td>
            <td align="right"></td>
            <td align="left"></td>
              <td>
                 <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
             </td>
             <td>   
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
        </tr>
</table>
</div>

<input type="hidden" name="postid" id="postid" value="">
<input type="hidden" name="cmd" id="cmd" value="">
<div id="ccParent1" class="button"> 
	 <div class="button_right">
		<!--<ul>
			<li class="a_2">      <a onClick="javascript:detail_onClick();">查看个人订单</a></li>
            <li class="bl">      <a  onClick="javascript:toUpdate_onClick();">修改</a> </li>
            <li class="bl_4">      <a  onClick="javascript:toUpdateCustCode_onClick();">修改客户方编号</a> </li>
		</ul>
	-->

	  <input type="button" class="a_2" value='<fmt:message key="look_person_order"/>' <au:authorityBtn code="view_orderItem6" type="1"/> onClick="detail_update_onClick();" />
	  <input type="button" class="bl" value='<fmt:message key="modify"/>' <au:authorityBtn code="rlzcx_modify" type="1"/> onClick="toUpdate_onClick();" />
	   <input type="button" class="bl_4" value='<fmt:message key="modify_internal_code"/>' <au:authorityBtn code="rlzcx_custCode" type="1"/> onClick="toUpdateCustCode_onClick();" />
	   <input type="button" class="bl_4" value='<fmt:message key="modify_person_order"/>' <au:authorityBtn code="rlzcx_grddxg" type="1"/> onClick="toUpdateOrder_onClick();" />
	   <input type="button" class="bl" value='<fmt:message key="leading_out"/>'  onClick="exp_onClick();" />
	   <input type="button" class="bl_3" value='其他查询'  <au:authorityBtn code="qtcx" type="1"/> onClick="toLeaveDetailInfo();"/>
	   <input type="button" class="bl_3" value='其他查询2'  <au:authorityBtn code="qtcx2" type="1"/> onClick="toLeaveDetailOthersInfo();"/>
	   <input type="button" class="bl_3" value='重发入职'  <au:authorityBtn code="cfrz" type="1"/> onClick="reSendPost('1');"/>
	   <input type="button" class="bl_3" value='重发离职'  <au:authorityBtn code="cflz" type="1"/> onClick="reSendPost('2');"/>
        <input type="button" class="bl_3" value="转移重发" <au:authorityBtn code="cfzy" type="1"/> onClick="reSendZhuanYi();" />
	</div>
    <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=searchEmpIntoResignationData"
        submitAction="/FAERP/EmppostAction.do?cmd=updateEmpIntoResignationForInternalCode"
        width="98%"
        height="320px"
        xpath="EmppostVo"
        submitXpath="EmppostVo"
        paramFormId="empIntoResigQuery_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field allowModify="false" fieldName="chk"
           label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
           sortAt="none" width="30px">
           <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
       </r:field>
      
      <r:field fieldName="emp_code" messagekey="emp_code">
      </r:field>
      <r:field fieldName="emp_name" messagekey="emp_name" width="70">
       </r:field>
       <r:field fieldName="id_card_type_bd" label="证件号" width="0"></r:field>
      <r:field fieldName="id_card" messagekey="emp_card_no1">
      </r:field>
        <r:field fieldName="is_phoenix" label="入职E化" width="70">
        	<select name="is_phoenix">
        		<option value="0">否</option>
        		<option value="1">是</option>
        	</select>
        </r:field>
      <r:field fieldName="internal_code" messagekey="internal_code">
           <h:text/>
       </r:field>
       <r:field fieldName="emp_post_type_bd" messagekey="emp_type" allowModify="false">
           <d:select dictTypeId="EMP_POST_TYPE_BD"/>
       </r:field>
       <r:field fieldName="cust_code" messagekey="cust_code">
      </r:field>
      <r:field fieldName="cust_name" messagekey="cust_name">
      </r:field>
      <r:field fieldName="cost_center_name" messagekey="cost_center">
      </r:field>
      <r:field fieldName="send_name" messagekey="send">
      </r:field>
      <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date" allowModify="false">
        <w:date format="yyyy-MM-dd" name=""/>
      </r:field>
      <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1" allowModify="false">
        <w:date format="yyyy-MM-dd" name=""/>
      </r:field>
      <r:field fieldName="charge_start_date" messagekey="fee_begin" allowModify="false">
        <w:date format="yyyy-MM-dd" name="" />
      </r:field>
      <r:field fieldName="charge_end_date" messagekey="fee_end" allowModify="false">
        <w:date format="yyyy-MM-dd" name=""/>
      </r:field>
      <r:field fieldName="post_status_bd" messagekey="status_name" allowModify="false">
        <d:select dictTypeId="POST_STATUS_BD"/>
      </r:field>
      <r:field fieldName="user_name" messagekey="user_name">
      </r:field>
      <r:field fieldName="big_name" messagekey="big_name1">
      </r:field>
      <r:field fieldName="small_name" messagekey="small_name1">
      </r:field>
      <r:field fieldName="off_post_user_name" messagekey="off_post_user_id">
      </r:field>
      <r:field fieldName="data_send_type" label="重发类型" width="100px;" allowModify="false">
        <d:select dictTypeId="DATA_SEND_TYPE"/>
      </r:field>
      <r:field fieldName="data_send_status" label="数据状态" width="300px;" allowModify="false">
        <d:select dictTypeId="DATA_SEND_STATUS"/>
      </r:field>
      <r:field fieldName="isonline" label="是否线上" width="100px;" allowModify="false">
        <d:select dictTypeId="TrueOrFalse"/>
      </r:field>
      <r:field fieldName="emp_email" messagekey="emp_email">
      </r:field>
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[2];
    lookup.displayValue = returnValue[2];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}

function reSendPost(type){//1:重发入职 2：重发离职
	var myids=selectIds();
	var errorinfo=check_status();
      if(myids.length==0){
        alert("请先选择数据！");
        return;
      }
      
      if(errorinfo!=""){
      	alert(errorinfo);
       	return;
      }


	/** var entitys = getSelectedEntity();
        if (entitys[0]==0) {
            alert("请先选择一条记录");
            return false;
        }
        if(entitys[0]>1){
            alert("只能选择一条记录");
            return false;
        }
        var entity = entitys[1];
        var batch_id = entity.getValue("id");
        alert(batch_id);*/
        
    var url = "<%=request.getContextPath()%>/EmppostAction.do?cmd=reSendPost&postID="+myids + "&type="+type;
    jQuery.ajax({
        url: url,
        type: 'post',
        dataType: 'html',
        async: false,
        timeout: 80000,
        error: function() {
            alert('Error loading XML document');
            return null;
        },
        success: function(text) {
            if (text != null) {
            	alert("重发请求已发送！");
            	/**批量重发后不再提示以下信息
                if(text == "9"){
                    alert("非外地员工不允许重发入离职！");
                }else{
                    if(type == "1"){
	                   if (text == "1") {
	                        alert("重新发送入职成功!");
	                        $id("datacell1").loadData();
	                        $id("datacell1").refresh();
	                    }else if(text == "2"){
	                        alert("不能重新发送入职，该员工已成功发送到全国系统！");
	                    }else{
	                        alert("重新发送入职失败!");
	                    } 
	                }else if(type == "2"){
	                    if (text == "7") {
	                        alert("重新发送离职成功!");
	                        $id("datacell1").loadData();
	                        $id("datacell1").refresh();
	                    }else if(text == "3"){
	                        alert("不能重新发送离职，xpress数据异常，请联系管理员！");
	                    }else if(text == "4"){
	                        alert("不能重新发送离职，尚未分配项目书协议书，不能报离职！");
	                    }else if(text == "5"){
	                        alert("不能重新发送离职，系统异常,数据交互失败！");
	                    }else if(text == "6"){
	                        alert("不能重新发送离职，员工信息不存在！");
	                    }else if(text == "8"){
	                        alert("重新发送离职失败!");
	                    } 
	                }
                }*/
            }else{
                alert("ajax ERROR!");
            }
        }
    });
}

function reSendZhuanYi(){
	var myids=selectIds();
      if(myids.length==0){
        alert("请先选择数据！");
        return;
      }

    var url = "<%=request.getContextPath()%>/EmppostAction.do?cmd=reSendEmpZhuanYi&emp_post_id="+myids;
    jQuery.ajax({
        url: url,
        type: 'post',
        dataType: 'html',
        async: false,
        timeout: 80000,
        error: function() {
            alert('Error loading XML document');
            return null;
        },
        success: function(text) {
            if (text != null) {
                alert("重发请求已发送！");       
            } else{
                alert("ajax ERROR!");
            }
        }
    });
}

  //增加批量功能
    function checkAll(item) {
        if (_$(item).attr("checked")) {
            changeEntityChk(true);
            _$(":checkbox").attr("checked", true);
        } else {
            changeEntityChk(false);
            _$(":checkbox").attr("checked", false);
        }
    }
        function changeEntityChk(flag) {
        var dc1 = $id("datacell1").dataset;
        var values = dc1.values;
        for(var i=0; i<values.length; i++){
            var entity = values[i];
            entity.setProperty("chk", flag);
        }
    }
    
	function getSelectedEntity(){
		//有checkbox的情况
		var entity = null;
		var count = 0;
		var datacell = $id("datacell1");
		_$("input[type='checkbox']").each(function (i){
		   if (i != 0 &&_$(this).attr("checked")) {
	         var row = datacell.table.tBodies[0].rows[i-1];
	         entity = datacell.getEntity(row);
		   	 count++;
		   	 if (count > 1) {
		   	 	return;
		   	 }
		   }
		});
		var arr = new Array();
		arr[0] = count;
		arr[1] = entity;
	    return arr;
	   
	}
    
     //获取选中的id
      function selectIds() {
        var myids = new Array(0);
        var dc = $id("datacell1");
        _$("input[type='checkbox']").each(function(i) {
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                myids.push(entity.getValue("id"));
            }
        });
        return myids;
    }
    
        //校验信息
     function  check_status() {                   
       var dc = $id("datacell1");
       var message="";
       jQuery("input[type='checkbox']").each(function (i){
         if (i != 0 && _$(this).attr("checked")) {
             var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
             var entity = dc.getEntity(row);
             var  isonline = entity.getValue('isonline');
             if(isonline == "0"){
        		message="线下人员不允许重发入离职！";
        		return ;   
 			}
         }
        });
       return message;
    }
</script>
