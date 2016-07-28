<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.project.IToolsConstants"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
    var vpath = "<%=request.getContextPath()%>";

    function setCheckboxStatus(value,entity,rowNo,cellNo){

       return "<input type='radio'  name='temp'  value=\"" + entity.getProperty("id") + "\">";
    }


    function findSelection(radioName) {  //从radio中找出选中的id值列表
        var elementRadio = document.getElementsByName(radioName);  //
        var ids = null;  //定义id值
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].checked) {  //如果被选中
                ids=elementRadio[i].value;
            }
        }
        return ids;
    }

	function checkradio(xlid){  //点击行，选中对应的radio
        var elementRadio = document.getElementsByName("temp");  //

        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].value==xlid) {  //如果被选中
                elementRadio[i].checked=true;
                break;
            }
        }

    }

	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("sendpost_init").loadData();
        $id("sendpost_init").refresh();
  	}

	function toAddone_onClick() {  //到生成订单记录页面
	     var entity=choose_row_public("sendpost_init");
             if(entity!=undefined){
        var temp_id=entity.getProperty("id");
        var send_id = entity.getProperty("send_id");
	   /* var ids = findSelection("temp");  //取得单选框的选择项
       if(temp_id == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }*/
        //查找empPost的is_phoenix是否为1
        jQuery.getJSON(vpath+"/EmppostAction.do?cmd=checkIsPhoenix&date="+new Date()+"",{"id":temp_id},  function(returnvalue){
            if(returnvalue=='1'){

                     alert("此员工请通知入职大厅先终止前一次的入职易化，再进行报入职！");
                     return false;

             }else{

                    //查询该员工派出对应的委派单、报价单、员工信息、商务合同是否已删除
            jQuery.getJSON(vpath+"/EmppostAction.do?cmd=checkAllByrelid&date="+new Date()+"",{"ids":temp_id},  function(text){

                 if(text=='1'){
                     alert("<fmt:message key="emp_for_send_deleted_notice"/>");

                 }
                 if(text=='2'){
                     alert("<fmt:message key="emp_for_quotation_deleted_notice"/>");

                 }
                 if(text=='3'){
                     alert("<fmt:message key="emp_for_empinfo_deleted_notice"/>");

                 }
                 if(text=='4'){
                     alert("<fmt:message key="emp_for_contract_deleted_notice"/>");

                 }
                 if(text=='5'){
                     alert("<fmt:message key="emp_for_customer_deleted_notice"/>");

                 }
                 if(text=='6'){
                     alert("此员工对应的福利办理方和客户的社保账号不存在或社保账号未配置新的工伤保险比例！");

                 }
                 if(text=='0'){

                    form.action="<%=request.getContextPath()%>/EmppostAction.do?id=" + temp_id+"&send_id="+send_id;
                    form.cmd.value = "initInsertOne";
                    form.submit();

                 }
             });

             }
        });


		 }
	}

	function toAddbat_onClick() {  //到生成订单记录页面
	var entity=choose_row_public("sendpost_init");
             if(entity!=undefined){
        var temp_id=entity.getProperty("id");
        var send_id = entity.getProperty("send_id");
	  /*  var ids = findSelection("temp");  //取得单选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }*/
        //查询该员工派出对应的委派单、报价单、员工信息、商务合同是否已删除
            jQuery.getJSON(vpath+"/EmppostAction.do?cmd=checkAllByrelid&date="+new Date()+"",{"ids":temp_id},  function(text){

                 if(text=='1'){
                     alert("<fmt:message key="emp_for_send_deleted_notice"/>");

                 }
                 if(text=='2'){
                     alert("<fmt:message key="emp_for_quotation_deleted_notice"/>");

                 }
                 if(text=='3'){
                     alert("<fmt:message key="emp_for_empinfo_deleted_notice"/>");

                 }
                 if(text=='4'){
                     alert("<fmt:message key="emp_for_contract_deleted_notice"/>");

                 }
                 if(text=='5'){
                     alert("<fmt:message key="emp_for_customer_deleted_notice"/>");

                 }
                 if(text=='6'){
                     alert("此员工对应的福利办理方和客户的社保账号不存在或社保账号未配置新的工伤保险比例！");

                 }
                 if(text=='0'){

                    form.action="<%=request.getContextPath()%>/EmppostAction.do?id=" + temp_id+"&send_id="+send_id;
			        form.cmd.value = "initInsertBat";
			        form.submit();

                 }
             });
        }
    }

    //已作废
    function getsendid(){
         var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&agent_type=3&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.cust_send_id.value=ids[0];
        document.form.cust_send_name.value=ids[1];
    }
    //已作废
    function getreceiveid(){
        var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&agent_type=3&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.cust_receive_id.value=ids[0];
        document.form.cust_receive_name.value=ids[1];
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

    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
	    lookup.value = arg[2];
	    lookup.displayValue = arg[2];
	    //jQuery("#h_customer_id").val(arg[0]);
	    return false;
    }

    function rtnFunSend(arg){
        var lookup = $id("lk_wpd");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        //jQuery("#h_send_name").val(arg[1]);
        return false;
    }
</script>
</head>
<body>


<div id="right">
<script language="javascript">
	writeTableTopFesco("<fmt:message key="entry_declare"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">


<div id="ccChild0" class="search">
<form name="form" method="post" id="simpleQuery">
<input type="hidden" name="cmd" value="queryAll">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>

			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right"><fmt:message key="cust_name"/></td>
			<td align="left">
				<w:lookup name="cust_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
			</td>
			<td align="right"><fmt:message key="cust_code"/></td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="25"/>
			</td>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="25" style="width:250"/>
            </td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="emp_name"/></td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="25"/>
			</td>
          <td align="right"><fmt:message key="credentials_type"/></td>
          <td align="left">
            <d:select name="id_card_type_bd" dictTypeId="ID_CARD_TYPE_BD" nullLabel="---请选择---"/>
          </td>
            <td align="right"><fmt:message key="emp_entry"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_card_no1" inputName="证件号码" maxLength="64" style="width:250"/></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="send_name"/></td>
			<td align="left">
				<w:lookup name="send_name" onReturnFunc="rtnFunSend" id="lk_wpd" lookupUrl="/SendAction.do?cmd=queryAllSend" messagekey="choose_send" height="440" width="800"  style="width:195px"/>

			</td>
			<td align="right"><fmt:message key="cust_send_id"/></td>
			<td>
			    <w:lookup onReturnFunc="rtnFuncSend" readonly="false" id="cust_send_id" displayValue=""   name="cust_send_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" messagekey="choose_agent" height="440" width="800" style="width:170px">
                </w:lookup>
            </td>
            <td align="right"><fmt:message key="cust_receive_id"/></td>
            <td>
                <select name="cust_receive_id" id="cust_receive_id" style="width:250">
                     <option value = "">请选择</option>
                     <option value="<%=IToolsConstants.AGENT_SH%>">北京外企德科人力资源服务上海有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_BJ%>">北京外企人力资源服务有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_WD%>">外地供应商</option>
               </select>
            </td>

        </tr>
		<tr>
			<td align="right"><fmt:message key="quotation_code"/></td>
			<td align="left">
				<input type="text" class="text_field" name="quotation_code" inputName="报价单编号" maxLength="20"/>
			</td>
			<td align="right"></td>
			<td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
                <td/>
		</tr>

</table>

</div>





<div id="ccParent1" class="button">
 <div class="button_right">
				<!--<ul>
					<li class="o">    	<a  onClick="javascript:toAddone_onClick();">报入职</a> </li>
					<li class="pl_1">  	<a onClick="javascript:toAddbat_onClick();">批量入职</a></li>

					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>

				</ul>

		 -->
		 <input class="o" type="button"   value="<fmt:message key="reporte_post"/>"  <au:authorityBtn code="declIn" type="1"/>  onClick="toAddone_onClick();">
		 <input class="pl_1" type="button"   value="<fmt:message key="batch_on_post"/>"  <au:authorityBtn code="batch_declIn" type="1"/>  onClick="toAddbat_onClick();">

		 </div>
           <div class="clear"></div>
</div>
      <div style="padding: 5 0 0 8;">
                    <r:datacell
                         id="sendpost_init"
                         queryAction="/FAERP/EmppostAction.do?cmd=simpleQuery"
                         width="99%"
                         height="320px"
                         xpath="EmppostsendVo"
                         submitXpath="EmppostsendVo"
                         paramFormId="simpleQuery"
                         >
                         <r:toolbar  tools="nav,pagesize,info"/>
                         <!--<r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
                         </r:field>   -->
                         <r:field fieldName="emp_code" messagekey="emp_code">
                         </r:field>
                         <r:field fieldName="emp_name" messagekey="emp_name">
                         </r:field>
                         <r:field fieldName="id_card_type_bd" messagekey="id_card_type" allowModify="false">
                             <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                         </r:field>
                         <r:field fieldName="id_card" messagekey="emp_card_no1">
                         </r:field>
                         <r:field fieldName="cust_code" messagekey="cust_code">
                         </r:field>
                         <r:field width="200" fieldName="cust_name" messagekey="cust_name">
                         </r:field>
                         <r:field width="300" fieldName="send_name" messagekey="send_name">
                         </r:field>
                         <r:field fieldName="quotation_code" messagekey="quotation_code">
                         </r:field>
                       </r:datacell>
                       </div>

</div>
</div>
</fmt:bundle>
</form>
</body>
</html>


