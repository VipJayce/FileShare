<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>招聘订单管理</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/Job_orderAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/Job_orderAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
       window.close();
    }
    //合同参照
	function toFindContract(arg){
		var lookup = $id("lk_contract");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#contract_id").val(arg[0]);   
        jQuery("#customer_name").val(arg[3]);
        jQuery("#cust_id").val(arg[2]);
        jQuery("#warranty").val(arg[7]);//担保期
        return false;
	}
	//客户参照
	function rtnFunc(arg){
		var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);
        return false;
	}
	
	//增加子表信息
	function toAddSub_onClick(){
		var dc1 = $id("datacell1");
		var url="<%=request.getContextPath()%>/Job_positionAction.do?cmd=toInsert";
        //window.open(url,'','height=400px,width=750px,top=100,left=200,help=no,toolbar=no,menubar=no,resizable=yes,scrollbars=no,location=no,status=not,title=招聘职位新增');
		showModalCenter("<%=request.getContextPath()%>/Job_positionAction.do?cmd=toInsert",dc1,null,680,380,"新增职位信息");
	}
	
	//修改子表信息
	function toModifySub_onClick(){
		var dc1 = $id("datacell1");
	    var entity = dc1.getActiveEntity();
	    var industry1 = entity.getProperty("industry1")
	    var industry2 = entity.getProperty("industry2")
	    var industry3 = entity.getProperty("industry3")
		showModalCenter("<%=request.getContextPath()%>/Job_positionAction.do?cmd=toUpdate&industry1="+industry1+"&industry2="+industry2+"&industry3="+industry3,dc1,null,680,380,"修改职位信息");
	}
	
	//删除子表信息
	function deleteMulti_onClick(){
		var dc1 = $id("datacell1");
		dc1.deleteRow(); 
	}
	
	
	//保存数据
	function save_onClick(){
			if(!valiData()){
				return;
			}
			var datacell1 = $id("datacell1");
    	   	var action = "<%=request.getContextPath()%>/Job_orderAction.do?cmd=updateAll";
            var dataset1 = datacell1.dataset;//取得页面的dataset
            if(dataset1 == null || dataset1.getLength() == 0){
            	alert("请增加一条职位记录!");
            	return ;
            }
            for(var i=0; i<dataset1.getLength(); i++){
             	var datarow =  dataset1.get(i);
             	datarow.setProperty("status",datarow.status);
            }
       		var xmlSubmit = datacell1.dataset.toString();
            var myAjax = new Ajax(action);
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
            myAjax.submitXML(xmlSubmit, 'UTF-8');
            var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == "ok" ) {
                      window.close();
                      window.opener.insertcallBack("0");
                  } 
                  else {
                      alert( '保存失败！' ); 
                  }
             }
	}
	
	//效验数据
	function valiData(){
		var order_code = jQuery("#order_code").val();
		if(!order_code){
			alert("订单编号不能为空！")
			return false;
		}
		
		var order_name = jQuery("#order_name").val();
		if(!order_name){
			alert("订单名称不能为空！")
			return false;
		}
		
		var contract_id = jQuery("#contract_id").val();
		if(!contract_id){
			alert("请选择招聘合同！")
			return false;
		}
		
		var cust_id = jQuery("#cust_id").val();
		if(!cust_id){
			alert("请选择合同客户！")
			return false;
		}
		  var recruittype = jQuery("#recruittype").val();
        if(!recruittype){
            alert("请选择订单类型！")
            return false;
        }
		
		return true;
	}
	
	//职位完成
    function updateStatus_onClick(){
    	var datacell1 = $id("datacell1");
    	var ps = datacell1.getActiveEntity().getProperty("position_status");//当前状态
    	if(ps == "5"){
    	   alert("该职位已是成功状态！");
    	   return ;
    	}
    	var ids = datacell1.getActiveEntity().getProperty("id");  //取得多选框的选择项
    	if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
    	var position_status = "5";                              //目标状态
    	var action = "<%=request.getContextPath()%>/Job_orderAction.do?cmd=updatePositionStatus";
        var xmlSubmit = datacell1.dataset.toString();
        var myAjax = new Ajax(action);
        myAjax.addParam("ids", ids);
        myAjax.addParam("position_status",position_status);
        myAjax.submitXML(xmlSubmit, 'UTF-8');
        var returnNode = myAjax.getResponseXMLDom();
        if(returnNode){
             var rtnMsg = myAjax.getValue("root/data/returnMessage");
        	 if( myAjax.getValue("root/data/returnValue") == "1" ) {
                 alert(rtnMsg);
                 $id("datacell1").loadData();
        		 $id("datacell1").refresh();
             }else{
             	 alert('操作失败!'+rtnMsg);
             } 
        }
    }
	
//获取招聘订单编号
function genjobcode(){
var flags=true;
        jQuery.ajax({
        url: '<%=request.getContextPath()%>/Job_orderAction.do?cmd=getJob_OrderCode',
        type: 'POST',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(code){
            document.getElementById("order_code").value=code;
            document.getElementById("gencodebtn").disabled="disabled";
        }
        });
        return flags;
}	

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" checkType="blur">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<div class="xz_title">基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>订单编号</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" readonly="readonly" name="order_code" id="order_code" inputName="订单编号" maxLength="23"   value="${bean.order_code}" validateAttr="allowNull=false;"/>
                <%if(!isModify){ %>
                <span class="mx_button" style="margin-left:5px;"><input type="button" id="gencodebtn" class="icon_2" value="获取编号" onClick="javascript:genjobcode();" /></span>
                <%} %>
            </td>
            <td class="td_1" width="23%"><span class="style_required_red">* </span>订单名称</td>
            <td class="td_2"  width="28%">
            	 <input type="text" class="text_field" name="order_name" id="order_name" inputName="订单名称" maxLength="23"   value="${bean.order_name}"/>
            </td>
        </tr>
		<tr>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>招聘合同</td>
			<td  class="td_2" width="28%">
				<input type="hidden" name="contract_id" id="contract_id" value="${bean.contract_id}"/>
				<w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract" displayValue="${bean.contract_name}"
					lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="444" width="764" style="width:188px"/> 
            
			</td>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>客户名称</td>
            <td  class="td_2 " width="28%" >
            	<input type="text" class="text_field" name="customer_name" id="customer_name" inputName="客户名称" maxLength="23"   value="${bean.customer_name}" readonly="true"/>
                <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}" >
            </td>
		</tr>
		<tr>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>担保期</td>
			<td  class="td_2" width="28%" >
				<input type="text" readonly="readonly" class="text_field" name="warranty" id="warranty" inputName="担保期" maxLength="2"  value="${bean.warranty}"/>
			</td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>订单类型</td>
            <td  class="td_2" width="28%" >
               <d:select dictTypeId="RECURITTYPE" name="recruittype" id="recruittype"  value="${bean.recruittype}" nullLabel="--请选择--"></d:select>
               
            </td>
		</tr>
    </table>
	<p></p>
</div>
    	<div class="button">
            <div class="button_right">
                <ul>
                  <li class="c"><a onClick="javascript:toAddSub_onClick();"><fmt:message key="insert" /> </a></li>
		          <li class="b"><a onClick="javascript:toModifySub_onClick();"><fmt:message key="modify" /> </a></li>
		          <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete" /> </a></li> 
		          <%if(isModify){ %>
		          <li class="p_1"><a onClick="javascript:updateStatus_onClick();">职位完成</a></li>                     
                  <% } %>
                </ul>
            </div>
            <div class="clear"></div>
		</div>
		<div style="padding: 15 8 8 8;">
		       <r:datacell 
		        id="datacell1"
		        paramFormId="datacell_formid"
		        queryAction="/FAERP/Job_orderAction.do?cmd=querySubData&pk_job_order=${bean.id}"
		        submitAction="/FAERP/Job_orderAction.do?cmd=insertSubData&pk_job_order=${bean.id}"
		        width="99%"
		        height="200px"
		        xpath="Job_positionVo"
		        submitXpath="Job_positionVo"
		        pageSize="-1"
		        >
		            <r:field fieldName="position" label="招聘职位" width="150px" allowModify="false">
		            </r:field>
		            <r:field fieldName="area" label="招聘地区" width="100px">
		            </r:field>
		            <r:field fieldName="job_number" label="招聘数量" width="150px">
		            </r:field>  
		            <r:field fieldName="salary_range" label="薪资范围" width="100px">
		             	<d:select dictTypeId="SALARY_RANGE_BD" disabled="true"/>
		            </r:field>              
		            <r:field fieldName="position_status" label="职位状态" width="150px" >
		            	<d:select dictTypeId="ORDER_STATUS_BD" disabled="true"/>
		            </r:field>  
		            <r:field fieldName="industry1" label="一级行业" width="150px" >
		            	<d:select dictTypeId="YINGRUI_INDUSTRY" disabled="true"/>
		            </r:field>
		            <r:field fieldName="industry2" label="二级行业" width="150px" >
		            	<d:select dictTypeId="YINGRUI_INDUSTRY" disabled="true"/>
		            </r:field>
		            <r:field fieldName="industry3" label="三级行业" width="150px" >
		            	<d:select dictTypeId="YINGRUI_INDUSTRY" disabled="true"/>
		            </r:field>
		            <r:field fieldName="is_invoiced" label="是否允许预开票" width="100px">
		               <d:select dictTypeId="TrueOrFalse" disabled="true"/>
		            </r:field>      
		    </r:datacell>
		</div>
		<p></p>
		<div class="foot_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
		</div>

<input type="hidden" name="id" id="edit_id" value="${bean.id}">
<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="create_date" />


</form>   
</body>
</fmt:bundle>
</html>

