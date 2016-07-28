<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.insurance.policy.vo.PolicyVo" %>
<%@ page import="rayoo.insurance.policy.util.IPolicyConstants" %>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="rayoo.sales.customersimple.vo.CustomersimpleVo"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
	PolicyVo resultVo = null;  //定义一个临时的vo变量
	if(request.getAttribute(IPolicyConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (PolicyVo)request.getAttribute(IPolicyConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
    String policy_id = null;
    String itemId = "";
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        //form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }
    var array[]
    function checkpagecontemer(obj)
    {
        var addids="";
        var deleteids="";        
        var custId = document.getElementsByName("trid");
        var custName = document.getElementsByName("customer_name")
        var ids = obj;
        for(var i = 0;i<ids.length;i++)
        {
            var istrue='false';
            for(var j=0;j<custId.length;j++)
            {
                if(custId[j].value==ids[i])
                {
                   istrue="true";
                   deleteids+=custName[j].value+"已经在列表，不能再添加，请删除后再添加！\n";
                   break;
                }
                else
                {
                     istrue="false";                       
                }
             }
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        returnAry[1]=deleteids;
        return returnAry;
    }
   
   //分配客户
    function allocatContemer(){
        var pitem_check = document.getElementsByName("checkbox_template");
        var pitem_ids = null;  //定义id值的数组
        if(pitem_ids == null) {
            pitem_ids = new Array(0);
        }
        for(var i=0;i<pitem_check.length;i++){  //循环checkbox组
            if(pitem_check[i].checked){
                pitem_ids.push(pitem_check[i].value);  //加入选中的checkbox
            }
        }
        if(pitem_ids==null||pitem_ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var ids = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllCustomer&pitem_ids='+pitem_ids+'&date='+new Date(),'','dialogHeight:510px;dialogWidth:810px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        var custIds=checkpagecontemer(ids);
        if(custIds[1]!=null&&custIds[1]!="")
        {
            alert(custIds[1]);
        }
        if(custIds[0]!=null&&custIds[0]!="")
        {
            var customerId = null;
	        if(customerId == null) {
	            customerId = new Array(0);
	        }
	        custId = custIds[0].split(",")
	        for(var i=0;i<custId.length;i++){  //循环checkbox组
	            if(custId[i]==null || custId[i]==""){
	                continue;
	            }
	            customerId.push(custId[i]);
	        }
            ids = customerId;
            if(findSelections("checkbox_template_cust","id")!=null){
                //得到当前有多少行数据
                var trids = ids+findSelections("checkbox_template_cust","id");
            }else{
                var trids = ids;
            }
            var table1=document.getElementById('tab');
            var rows=table1.rows;
            var row=rows.length;
            jQuery.ajax({
            url: '<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=vailCustomerId&trids='+trids+'',
            type: 'POST',
            dataType: 'html',
            timeout: 10000,
            error: function(){
                alert('Error loading XML document');
                return null;
            },
            success: function(data){
                if(data=='true'){
                    //后台取到数据
                    jQuery.getJSON("<venus:base/>/CustomersimpleAction.do?cmd=getChooseDataCustomer&pitem_ids="+pitem_ids+"&ids="+ids+"&date="+new Date()+"",{},   function(json){
                    for(var i = 0; i < json.saia.length; i++){
                        jQuery("#tab").append("<tr id=tr"+json.saia[i].pitem_ids+"><td ><input type=\"hidden\" name=\"pitemid\" value="+json.saia[i].pitem_ids+"><input type=\"hidden\" name=\"customer_name\" value="+json.saia[i].customer_name+"><input type=\"hidden\" name=\"trid\" value="+json.saia[i].customer_id+"><input type=\"checkbox\" class=\"fex_row\" name=\"checkbox_template_cust\" value="+json.saia[i].customer_id+"></td><td class=\"fex_row\" >"+json.saia[i].customer_code+"</td><td class=\"fex_row\">"+json.saia[i].customer_name+"</td><td class=\"fex_row\">"+json.saia[i].contact_person+"</td><td class=\"fex_row\">"+json.saia[i].bank_account+"</td></tr>");
                    }
                    }); 
                }else{
                    alert('添加客户不能有重复，请删除重复客户！');
                    return null;
                }
            }
        });
            document.getElementById("div").style.display='';
        }
     }
     
     function add_CustomerForPitme(){  //插入分配客户数据
     var custids = '';
        jQuery("#div input[type='checkbox']:visible").each(function(index){
            if(index>0){
                  //0 是最上面的复选框
                 //this为当前复选框
                 custids += this.value+',';
            }
         });
        form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=add_CustomerForPitme&policyiid="+objs+"&cid="+custids;
        form.submit();
    }
   function showdata(obj)
    {
        objs = jQuery(obj).val();
        jQuery("#div tr").hide();
        jQuery("#div tr:eq(0)").show();
        jQuery("#div tr[id='tr"+jQuery(obj).val()+"']").show();
        var custids = '';
        jQuery("#div input[type='checkbox']:visible").each(function(index){
		    if(index>0){
				  //0 是最上面的复选框
				 //this为当前复选框
				 custids += this.value+',';
		    }
		 });
    }
    
    //移除一行子记录
     function remove(){
        var arrayObj = new Array(); 
        var custids = '';
        function selectIdCount(){
            selecCount=0;            
            var idTag=  document.getElementsByName("checkbox_template_cust");
            for(i=0;i<idTag.length;i++){
                if(idTag[i].checked==true){
                    selecCount++;
                    arrayObj.push(idTag[i].value);
                }
            }
         }       
         selectIdCount();
         if(selecCount<1){
           alert('请选择一条以上的记录');
           return;
         }
         jQuery("#div input[type='checkbox']:visible:checked").each(function(){
		  jQuery(this).parents("tr").remove() 
		});
    }
    
</script>
</head>
<body> 
<form name="form" method="post">
<input type="hidden" name="policy_str_date">
<input type="hidden" name="policy_end_date">
<input type="hidden" name="is_open_pb_hospital">
<input type="hidden" name="is_open_private_hospital">
<input type="hidden" name="clearing_mode">
<input type="hidden" name="pay_mode">
       <div id="right">
		<!--<div class="right_title_bg"><div class=" right_title">保单产品-分配客户</div></div>-->
    	<div class="ringht_s">
<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >保单编号</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="policy_code" inputName="保单编号" value="" readonly /></td>
			<td class="td_1" >保单名称</td>
            <td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="policy_name" inputName="保单名称" value="" readonly /></td>
			<td class="td_1" >保险开始日期</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="保险开始日期" value="<%=RmStringHelper.prt(resultVo.getPolicy_str_date(), 10)%>" readonly /></td>
		</tr>
		<tr>
			<td class="td_1" >保险结束日期</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="保险结束日期" value="<%=RmStringHelper.prt(resultVo.getPolicy_str_date(), 10)%>" readonly /></td>
			<td class="td_1" >公共保额</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="public_insurance" inputName="公共保额" value="" readonly /></td>
			<td class="td_1">保险公司名称</td>
            <td class="td_2"><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="insurance_agent_name" inputName="保险公司名称" value="" readonly />
            <input type="hidden" name="insurance_agent_id" id="insurance_agent_id">
		</tr>
		<tr>
			<td class="td_1" >结算方式</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="结算方式" value="<%=BaseDataHelper.getNameByCode("CLEARING_MODE_BD",String.valueOf(resultVo.getClearing_mode())) %>" readonly /></td>
			<td class="td_1" >支付方式</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="支付方式" value="<%=BaseDataHelper.getNameByCode("PAY_MODE_BD",String.valueOf(resultVo.getPay_mode())) %>" readonly /></td>
			<td class="td_1" >追溯期</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="back_stage" inputName="追溯期" value="" readonly /></td>
		</tr>
		<tr>
			<td class="td_1" >是否开放公立一级医院</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="是否开放公立一级医院" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getIs_open_pb_hospital())) %>" readonly /></td>
			<td class="td_1" >是否开放定点私立医院</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="是否开放定点私立医院" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getIs_open_private_hospital())) %>" readonly /></td>
			<td class="td_1" ></td>
            <td class="td_2" ></td>
		</tr>
	</table>
</div>
<div class="button">
      <div class="button_right">
        <ul>
          <li class="p"><a onClick="javascript:allocatContemer();">分配客户</a></li>
        </ul>
        <div class="clear"></div>
      </div>
    </div>
    <div class="box" id="values_div" style="width:48%;float:left;">
      <table  width="100%" cellspacing="0"  class="datagrid1" id="tid">
        <tr>
          <th width="4%" height="30"  class="fex_row"></th>
          <th  class="fex_row">名称</th>
          <th class="fex_row">产品大类</th>
          <th>产品小类</th>
          <th>投保价</th>
        </tr>
        <%
                if(request.getAttribute("itemId")!=null && !request.getAttribute("itemId").equals("")){
                    itemId = request.getAttribute("itemId").toString();
                }
                if (request.getAttribute("list") != null) { //如果request中取出的bean不为空
                    List list = (List) request.getAttribute("list"); //从request中取出vo, 赋值给resultVo
                    for (int i = 0; i < list.size(); i++) {
                        PolicyVo pvo = (PolicyVo) list.get(i);     
                        if(pvo.getProduct_id() != null && !pvo.getProduct_id().equals("")) {
                        String insure_price = new DecimalFormat("#,##0.00").format(pvo.getInsure_price());
        %>
            <tr id="tr<%=pvo.getProduct_id()%>">
                <td ><input type="hidden" name="prodid" value="<%= pvo.getProduct_id() %>"><input type="hidden" name="policy_item_id" value="<%= pvo.getPolicy_item_id() %>">
                <%
                if(itemId =="null" || itemId.equals("null")){
                    if(i==0){    
                        policy_id = pvo.getPolicy_item_id();
                    %>
                    <input type="radio" class="fex_row" onclick="showdata(this)"  name="checkbox_template" value="<%= pvo.getPolicy_item_id() %>" checked='checked'>
                    <%
                    }else{
                        %>
                         <input type="radio" class="fex_row" onclick="showdata(this)"  name="checkbox_template" value="<%= pvo.getPolicy_item_id() %>">
                        <%
                    }
                }else{
                    %>
                    <input type="radio" class="fex_row" onclick="showdata(this)"  name="checkbox_template" value="<%= pvo.getPolicy_item_id() %>"  <%= itemId==pvo.getPolicy_item_id() || itemId.equals(pvo.getPolicy_item_id())?"checked=checked":"" %> >
                    <%
                }
                %>
                </td>
                
                <td class="fex_row" ><%= pvo.getProduct_name() %></td>
                <td class="fex_row"><%= BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getBig_type_id()))==null||BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getBig_type_id()))==""?"无":BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getBig_type_id())) %></td>
                <td class="fex_row"><%= BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getSmall_type_id())) %></td>
                <td class="fex_row"><%= insure_price %></td>
           </tr>
<%}} } %>
      </table>
    </div>
    <div class="box" id="div" style="width:48%;float:right;">
      <table  width="100%" cellspacing="0"  class="datagrid1" id="tab">
        <tr>
          <th width="4%" height="30"  class="fex_row"> <input type="checkbox" name="checkbox3" value="checkbox" onClick="CheckAll(this)">          </th>
          <th  class="fex_row">客户编号</th>
          <th class="fex_row">客户名称</th>
          <th>客户联系人</th>
          <th>银行账号</th>
        </tr>
        <%
                if (request.getAttribute("list_Customer") != null) { //如果request中取出的bean不为空
                    List list = (List) request.getAttribute("list_Customer"); //从request中取出vo, 赋值给resultVo
                    for (int i = 0; i < list.size(); i++) {
                        CustomersimpleVo cvo = (CustomersimpleVo) list.get(i); 
                        
        %>
            <tr id="tr<%=cvo.getPolicy_item_id()%>">
                <td ><input type="hidden" name="policyitemid" value="<%= cvo.getPolicy_item_id() %>"><input type="hidden" name="custid" value="<%= cvo.getId() %>"><input type="checkbox" class="fex_row" name="checkbox_template_cust" value="<%= cvo.getId() %>"></td>
                <td class="fex_row" ><%= cvo.getCustomer_code() %></td>
                <td class="fex_row"><%= cvo.getCustomer_name() %></td>
                <td class="fex_row"><%= cvo.getContact_person() %></td>
                <td class="fex_row"><%= cvo.getBank_account() %></td>
           </tr>
<%}} %>
      </table>  
      <div class="button_right">
      <ul>
          <li class="g_1"><a onClick="javascript:add_CustomerForPitme()"><fmt:message key="save"/></a></li>
          <li class="d" id="del"><a onClick="javascript:remove();"><fmt:message key="delete"/></a></li>
        </ul></div>
    </div>
<div class="foot_button">
<input type="button" class="foot_icon_1" value='关闭'  onclick="javascript:back_onClick();" />
</div>
</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	<%
	out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo))); 	
	%>	
</script>

<script language="javascript">
<%
if(policy_id !=null){
    %>
       firstdata('<%=policy_id%>');
    <%
}
if(itemId !="null" || !itemId.equals("null")){
    %>
    firstdata('<%=itemId%>');
    <%
}
%>
function firstdata(val)
    {  
        objs = val;
        jQuery("#div tr").hide();
        jQuery("#div tr:eq(0)").show();
        jQuery("#div tr[id='tr"+val+"']").show();
        var custids = '';
        jQuery("#div input[type='checkbox']:visible").each(function(index){
            if(index>0){
                  //0 是最上面的复选框
                 //this为当前复选框
                 custids += this.value+',';
            }
         });
    }
    
    function CheckAll(item) {
	    if (_$(item).attr("checked")) {
	        _$(":checkbox").attr("checked", true);
	    } else {	
	        _$(":checkbox").attr("checked", false);
	    }
	}
</script>

</body>
</html>
