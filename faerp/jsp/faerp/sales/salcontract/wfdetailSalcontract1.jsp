<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo"%>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants"%>

<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo"%>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo"%>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>




<% 
String  create_type_bd=(String)request.getParameter("create_type_bd"); 
        if(null==create_type_bd||"".equals(create_type_bd)||create_type_bd=="null"){
            create_type_bd=(String)request.getAttribute("create_type_bd");
        }
System.out.print("create_type_bd="+create_type_bd);
String contract_template_id= (String)request.getParameter("contract_template_id")  ;
String ids= (String)request.getParameter("ids")  ;


System.out.print("contract_template_id="+contract_template_id);
System.out.print("ids="+ids);
String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();



%>


<%
    String detail = (String) request.getAttribute("detail");
    if (null == detail) {
        detail = (String) request.getParameter("detail");
    }
    System.out.print("detail=" + detail);
    String contract_type_bd = (String) request
            .getParameter("contract_type_bd");
    String id = (String) request.getParameter("id");
    String contract_name = (String) request
            .getParameter("contract_name");
    String contract_start_date = (String) request
            .getParameter("contract_start_date");
    String contract_stop_date = String.valueOf(request
            .getParameter("contract_stop_date"));
    String customer_name = (String) request
            .getParameter("customer_name");
    String agent_b_name = (String) request.getParameter("agent_b_name");
    String agent_b_id = (String) request.getParameter("agent_b_id");
    String cust_a_id = (String) request.getParameter("cust_a_id");
    String customer_code = (String) request
            .getParameter("customer_code");

    SalcontractVo resultVo = null; //定义一个临时的vo变量
    AttachmentfileVo avo = null;//附件VO
    boolean isModify = false; //定义变量,标识本页面是否修改(或者新增)
    if (request.getParameter("isModify") != null) { //如果从request获得参数"isModify"不为空
        isModify = true; //赋值isModify为true
        if (request.getAttribute("bean") != null) { //如果request中取出的bean不为空
            resultVo = (SalcontractVo) request
                    .getAttribute(ISalcontractConstants.REQUEST_BEAN); //从request中取出vo, 赋值给resultVo
            contract_name = resultVo.getContract_name();
            contract_start_date = String.valueOf(resultVo
                    .getContract_start_date());
            contract_stop_date = String.valueOf(resultVo
                    .getContract_stop_date());
            if (null != contract_start_date
                    && !"".equals(contract_start_date)
                    && contract_start_date != "null") {
                contract_start_date = contract_start_date.substring(0,
                        10);
            } else {
                contract_start_date = "";
            }
            if (null != contract_stop_date
                    && !"".equals(contract_stop_date)
                    && contract_stop_date != "null") {
                contract_stop_date = contract_stop_date
                        .substring(0, 10);
            } else {
                contract_stop_date = "";
            }

            ids = resultVo.getId();
            customer_name = resultVo.getCustomer_name().trim();
            System.out.print("customer_name=" + customer_name);
            agent_b_name = resultVo.getAgent_b_name();
            agent_b_id = resultVo.getAgent_b_id();
            cust_a_id = resultVo.getCust_a_id();
            customer_code = resultVo.getCustomer_code();
            contract_type_bd = resultVo.getContract_type_bd();
            create_type_bd = resultVo.getCreate_type_bd();
            contract_template_id = resultVo.getContract_template_id();

            if (request.getAttribute("AttachmentfileVo") != null) { //如果request中取出的bean不为空
                avo = (AttachmentfileVo) request
                        .getAttribute("AttachmentfileVo"); //从request中取出vo, 赋值给resultVo
            }

        }
    }

    String attachName = avo == null ? "" : avo
            .getAttachment_file_name().toString();
    String attachAddress = avo == null ? "" : avo
            .getAttachment_file_path().toString();
%>



<script src="<%=request.getContextPath()%>/dwr/interface/TreeAjax.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js"
	type="text/javascript"></script>
<script language="javascript"
	src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>


<script type="text/javascript">
<!--

function insert_onClick(){  //插入单条数据
 var contract_start_date=document.form_treebasic.contract_start_date.value.trim();;
 var contract_stop_date=document.form_treebasic.contract_stop_date.value.trim();;
     if(contract_start_date==""&&contract_start_date.length==0){
        alert("合同起始日期不能为空！");
        return;
     }
      if(contract_stop_date!=""&&contract_stop_date.length!=0){
                            var beginTime = contract_start_date;
                            var endTime = contract_stop_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("合同终止日期小于合同起始日期！");
                                return ;
                            }
                       }
        if(checkAllForms()){
                form_treebasic.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=insert";
                form_treebasic.submit();
        }
    }


    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
            if(checkAllForms()){
                    form_treebasic.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=update&backFlag=false";
                    form_treebasic.submit();
        }
    }



    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
       var str=<%=create_type_bd%>;    
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
        if(str=="1")
        {
        document.getElementById('bg').className='xixi2';
                document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            onLoadTree();
        }else{
             document.getElementById('bg').className='xixi1';
           document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
        
        }
            break;
        }
    }




//-->
</script>








<STYLE TYPE="text/css" MEDIA=screen>
.tree_node_onfocus {
	TEXT-DECORATION: none;
	background-color: highlight;
	color: white;
}

ul.rootNode {
	CURSOR: default;
	MARGIN-LEFT: 5px;
	MARGIN-RIGHT: 5px;
	MARGIN-TOP: 5px;
	padding-top: 0px;
	padding-left: 0px;
}

ul.baseNode {
	MARGIN-LEFT: 0px;
	MARGIN-RIGHT: 0px;
	MARGIN-TOP: 0px;
	MARGIN-BOTTOM: 0px;
	padding-top: 0px;
	padding-left: 0px;
}

LI {
	MARGIN-LEFT: 15px;
	LIST-STYLE: none;
	MARGIN-BOTTOM: 0px;
	MARGIN-TOP: 0px;
	VERTICAL-ALIGN: middle;
}


/* 按钮的样式表 */
.button_ellipse {
    border:1px solid #4999d8;
    font-size:12px;
    color:#082a45;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px;
    padding-bottom:0px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;

}
.btn3_mouseout { 
    border:1px solid #4999d8;
    font-size:12px;
    color:#082a45;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;
} 
.btn3_mouseover { 
    border:1px solid #d7c14a;
    font-size:12px;
    color:#a03717;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;
} 
.btn3_mousedown 
{ 
    border:1px solid #d7c14a;
    font-size:12px;
    color:#a03717;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;
} 
.btn3_mouseup { 
    border:1px solid #d7c14a;
    font-size:12px;
    color:#a03717;
    cursor: pointer; 
    padding-left: 5px; 
    padding-right: 5px; 
    height: 22px;
    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
    background-position:left bottom;
    background-repeat:repeat-x;
    background-color:#ffffff;
}
</STYLE>



<script><!--
String.prototype.trim   =   function()
{
         //   用正则表达式将前后空格
         //   用空字符串替代。
         return   this.replace(/(^\s*)|(\s*$)/g,   "");
}
    
    //用户调用的beanID
    var beanId="IContracttemitemBs";//以数据库为数据源的树
    //新增根节点和新增节点时，记住根节点信息或者父节点信息
    
    <%  
    if(null!=ids&&!ids.equals("")){%>
        beanId="ISalcontractitemBs";
    <%
    }
    %>
    
    
    var nowData;

    //显示当前节点的信息
    function displayNode(nodeId,divid){
        divExtend('treeNodeMessageDiv',"block");
        //载入修改页面
        includeEditPage(nodeId,divid);
    }
    function includeEditPage(nodeId,divid){
          var pageobj="/jsp/faerp/sales/salcontract/treeContract.jsp?flag=update";//新增页面，用户修改
        TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
             DWREngine.setErrorHandler(eh); 
            form_treebasic.id.value=nodeId;
            form_treebasic.divid.value=divid;
            TreeAjax.getNodeMessage(nodeId,beanId,function(data){
                setForms(data);
                nowData=data;
            });
        });
    }

    
    /*
     *往页面填充值
     *@param data 后台往前台传的vo
     */
    function setForms(data){
        for(var property in data){ 
           dwr.util.setValue(property, data[property], { escapeHtml:false });
             
        }
    }

    function checkFormsForName(formName){//校验名称为formName值的form 中的控件
        var checkResult = true;
        rmTempStatusIsAlert = false;
        rmTempStatusIsFocus = false;
        
        setAllVenusInputsDefault();
        for (var i=0;i<document.forms.length;i++) {
            if(formName!=document.forms[i].name){continue;}
                for (var j=0;j<document.forms[i].elements.length;j++) {
                var thisInput = document.forms[i].elements[j];
                if ( thisInput.type!="hidden" && thisInput.type!="button" && !( thisInput.id.indexOf("TF_")>=0 && thisInput.id.indexOf("_TF")>0 ) ){
                    var rtValue = check(thisInput);
                    if(checkResult && rtValue == false) {
                        checkResult = false;
                    }
                }
            }
        }
        return checkResult;
    }
function extendsParamsMap(paramsMap){//用户扩展过滤条件
            //获取用户的过滤条件
            var locations=document.getElementById("ids");
             if(locations.value!=""){
                //用户自定义的过滤条件
                paramsMap["ids"]=locations.value;
            }
}
//===========================================用户自定义方法
function simpleQuery_onClick(){
    nodeDivHide();//隐藏节点信息 
    setButtonForNoDisabled("addButton", "addButtonTd", null, true);//新增按钮失效
    setButtonForNoDisabled("deleteButton", "deleteButtonTd", null, true);//删除按钮失效
    var paramsMap={};
    initTree('root','tree',paramsMap);
}



function onLoadTree(){//用户自定义初始化树
    //获取用户的过滤条件
     var paramsMap={};
    //   var locations=document.getElementById("contract_template_id1").value;
    var locations =  "<%=contract_template_id%>";
   var ids=document.getElementById("ids").value;
     if(null!=ids&&ids!=""&&ids!="null"){
        locations=ids;
   }
       if(locations!=""){
        //用户自定义的过滤条件
        paramsMap["ids"]=locations;
     }
    initTree('root','tree',paramsMap);
}

    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){        
        var message =addAppReason("<%=request.getContextPath()%>");
      
        var con=document.getElementById("contract_name").value;
        var custaid=document.getElementById("cust_a_id").value;
        var custaname=document.getElementById("cust_a_name").value;
        var agentbid=document.getElementById("agent_b_id").value;
        var contract_start_date=document.form_treebasic.contract_start_date.value.trim();
        var contract_stop_date=document.form_treebasic.contract_stop_date.value.trim();
        var arrach_name=document.getElementById("attachNameInput").value;
        var attack_address=document.getElementById("attackAddressInput").value;
    
        if(message==null)return;

     if(contract_start_date==""&&contract_start_date.length==0){
        alert("合同起始日期不能为空！");
        return;
     }
      if(contract_stop_date!=""&&contract_stop_date.length!=0){
                            var beginTime = contract_start_date;
                            var endTime = contract_stop_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("合同终止日期小于合同起始日期！");
                                return ;
                            }
                       }
          //document.getElementById("cmd").value="appOperate1";
          form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=appOperate1&custaname="+custaname+"&custaid="+custaid+"&arrach_name="+arrach_name+"&attack_address="+attack_address+"&contract_stop_date="+contract_stop_date+"&agentbid="+agentbid+"&contract_start_date="+contract_start_date+"&con="+con+"&message="+message[0];
          //alert(document.getElementById("cmd").value);
    //   form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=appOperate1&con="+con+"&message="+message[0];
        form.submit();
        
    }
    
    //撤销操作
        function cancelOperate_onClick(){
        //撤销原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/SalcontractAction.do?message="+message[0];
        document.getElementById("cmd").value="cancelOperate";
        form.submit();
    }
    
    

--></script>
<html>
<fmt:bundle basename="rayoo.salse.salcontract.salcontract_resource" prefix="rayoo.salse.salcontract.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        form_treebasic.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=queryAll";
        form_treebasic.submit();
    }
        //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2; 
        var t = (screen.height - h) / 2; 
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    }
    
    
</script>
	</head>
	<body>
	<div id="right">
	<div class="tab">

	<form action="<%=request.getContextPath()%>/SalcontractAction.do"
		name="form" id="form" method="post"><input type="hidden"
		value="" name="cmd" id="cmd"> <input type="hidden"
		value="<%=taskuid%>" name="taskuid" id="taskuid">

	<table class="table_noFrame">
		<tr>
			<td><input name="button_back" class="button_ellipse"
				type="button" value="<fmt:message key="go_back"/>" onclick="javascript:backTask_onClick();">
			<input name="button_app" class="button_ellipse" type="button"
				value="<fmt:message key="submitted_for_approval"/>" onclick="javascript:appOperate_onClick();">
			<input name="button_back" class="button_ellipse" type="button"
				value="<fmt:message key="revoke"/>" onclick="javascript:cancelOperate_onClick();"></td>
		</tr>
	</table>
	</form>


	<form name="form_treebasic" method="post">





	<div id="bg" class="xixi1">
	<div id="font1" class="tab1"
		onmousedown="setTab03Syn(1);document.getElementById('bg').className='xixi1'"><fmt:message key="contract_basic_info"/></div>

	<div id="font2" class="tab2" onmousedown="setTab03Syn(2);"><fmt:message key="recode_info"/></div>





	</div>

	<div id="TabCon1">



	<div class="ringht_x">
	<div id="ccChild1" class="box_xinzeng">
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">



		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="contract_type"/></td>
			<td class="td_2" nowrap="nowrap"><input type="hidden"
				class="text_field" name="contract_type_bd" id="contract_type_bd"
				value="<%=contract_type_bd %>"> <%=gap.rm.tools.helper.RmJspHelper
                                    .getSelectField(
                                            "contract_type_bd",
                                            -1,
                                            "CONTRACT_TYPE_BD",
                                            contract_type_bd,
                                            " id=contract_type_bd  dis   disabled='disabled'     ",
                                            false)%>
			</td>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="contract_name"/></td>
			<td class="td_2 " nowrap="nowrap"><input type="text"
				class="text_field" id="contract_name" name="contract_name"
				inputName="合同名称"
				value="${bean.contract_name}"
				maxLength="50" validate="notNull;" /></td>
		</tr>

		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="contract_jiafang"/></td>
			<td class="td_2 " nowrap="nowrap">
			 <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false" displayValue="<%=customer_name %>" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_contract_jiafang" height="500" width="810"/>
			<input type="hidden" name="cust_a_name" id="cust_a_name" />
			 <input type="hidden" name="cust_a_id" id="cust_a_id" /></td>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="contract_yifang"/></td>
			<td class="td_2 " nowrap="nowrap"><w:lookup onReturnFunc="rtnFunc1" displayValue="<%=agent_b_name %>" lookupWidth="189px"  id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" messagekey="choose_contract_yifang" height="500" width="710" /> 
			<inputtype="hidden"  name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>" /> 
			<input type="hidden" name="agent_b_name" id="agent_b_name" /></td>
		</tr>

		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="contract_start_date"/></td>
			<td class="td_2" nowrap="nowrap">
			<w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" width="189px"  />
			</td>
			<td class="td_1"><fmt:message key="contract_stop_date"/></td>
			<td class="td_2" nowrap="nowrap">
			<w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px"  />
			</td>
		</tr>

		<input type="hidden" class="text_field" id="create_type_bd" 	name="create_type_bd" inputName="合同生成方式" value="<%= create_type_bd%>"	maxLength="64" validate="notNull;" />
		<tr>
			<td class="td_1"><fmt:message key="contract_attachments"/></td>
			<td class="td_2 " colspan="2"><!--            <input type="text" class="text_field" name="contract_attachment_id" inputName="合同附件ID" value="" maxLength="9.5" />  -->
			
			<input type="text" value="" id="attachNameInput" class="text_field_reference_readonly" name="attach_name"	inputName="附件地址" value="" hiddenInputId="attach_name" 	validate="notNull;" />
			<img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();" />
			 <input type="hidden" id="attackAddressInput" name="attach_address">
			 <%
                if (isModify && avo != null)
                    out.print("<a href='" + request.getContextPath()
                            + "/ProductAction.do?cmd=downLoad&attachment_id="
                            + avo.getId() + "'><font color=blue>"
                            + avo.getAttachment_file_name() + "</font></a>");
            %> 
			 </td>



			<td class="td_2"></td>

		</tr>
	</table>




   <!-- 
	<div class="mx_button"><input type="button" class="icon_2"
		value='<fmt:message key="go_back"/>'
		onClick="javascript:cancel_onClick()" /></div>
	</div>
	 -->
	</div>
	<!--表格1 end--></div>





	<div id="TabCon2" style="display: none;"><input type="hidden"
		id="id" name="id"
		value="<%   if(null!=id&&!"".equals(id))    out.print(id)  ;%>">
	<input type="hidden" name="create_date" /> <input id="ids" name="ids"
		type="hidden" class="text_field" inputName="节点id"
		value="<%  out.print(ids); %>" readonly="true"> <input
		id="contract_template_id1" name="contract_template_id1" type="hidden"
		class="text_field" inputName="节点id"
		value="<%  out.print(contract_template_id); %>" readonly="true">

	<input id="divid" name="divid" type="hidden" class="text_field"
		inputName="节点层id" value="" readonly="true"> <input
		id="rootFlag" name="rootFlag" type="hidden" class="text_field"
		inputName="是否有根节点" value="" readonly="true"> <input id="id"
		name="id" type="hidden" class="text_field" inputName="节点id" value=""
		readonly="true"> <input id="parentId" name="parentId"
		type="hidden" class="text_field" inputName="父节点id" value=""
		readonly="true"> <input id="webModel" name="webModel"
		type="hidden" class="text_field" inputName="发布目录"
		value="<%=request.getContextPath()%>" readonly="true"> <!--表格2-->
	<div class="ringht_x">
	<div id="ccChild1" class="box_xinzeng">
	<table class="table_div_content">
		<tr>
			<td valign="top">

			<div id="tree" style="height: 350; overflow: auto;"></div>
			</td>
			<td valign="top">
			<form name="form_treeNode" method="get">
			<div id="treeNodeMessageDiv"></div>
			</form>
			</td>
		</tr>
	</table>
	</div>
	</div>
	</div>







	</form>








	<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script></div>
	</div>
	</body>
</fmt:bundle>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
     //out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
   //选择合同甲方
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);       
    jQuery("#cust_a_name").val(arg[2]);        
    return false;
}
        //选择合同乙方
function rtnFunc1(arg){
    var lookup = $id("lk_cust1");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    jQuery("#agent_b_id").val(arg[0]);    
    jQuery("#agent_b_name").val(arg[1]);    
    return false;
}


</script>



