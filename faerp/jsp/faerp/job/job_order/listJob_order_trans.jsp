<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_order.vo.Job_orderVo" %>
<%@ page import="rayoo.job.job_order.util.IJob_orderConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IJob_orderConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IJob_orderConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	Job_orderVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
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
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		//form.action="<%=request.getContextPath()%>/Job_orderAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
		if(valiUser(ids)){
			var url="<%=request.getContextPath()%>/Job_orderAction.do?cmd=find&id=" + ids;
        	window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘订单修改');
		}else{
			alert("只能由创建用户修改！");
		}
	}  
	
	function valiUser(ids){
		var dc1 = $id("datacell1");
		var ds1 = dc1.dataset;
		for(var i=0; i<ds1.getLength(); i++){
             	var datarow =  ds1.get(i);
             	for(var j=0; j<ids.length; j++){
	             	if(datarow.getProperty("id") == ids[j]){
	             		if(datarow.getProperty("create_user_id") == document.getElementById("user_id").value ){
	             			return true;
	             		}
	             	}
             	}
        }
        return false;
	}
	
	//检验单据状态，为生效时不可删除
	function valiStatus(ids){
		var dc1 = $id("datacell1");
		var ds1 = dc1.dataset;
		for(var i=0; i<ds1.getLength(); i++){
             	var datarow =  ds1.get(i);
             	for(var j=0; j<ids.length; j++){
	             	if(datarow.getProperty("id") == ids[j]){
	             		if(datarow.getProperty("order_status") == 1 ){
	             			return true;
	             		}
	             	}
	             }
        }
        return false;
	}
	
	
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(!valiUser(ids)){
			alert("只能由创建用户删除！");
			return;
		}
		if(valiStatus(ids)){
			alert("单据已经生效，不可删除！");
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Job_orderAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
	    var url="<%=request.getContextPath()%>/Job_orderAction.do?cmd=toInsert";
        window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘订单新增');
        //form.action= url;
        //rm.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		var url="<%=request.getContextPath()%>/Job_orderAction.do?cmd=detail&id=" + ids;
        window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘订单查看');
		
	}
	
	//合同参照
	function toFindContract(arg){
		var lookup = $id("lk_contract");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#contract_id").val(arg[0]);       
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
	
	//保存成功后回调
	function insertcallBack(reg){
        if(reg=="0"){
            alert("保存成功！");
        }else{
            alert("保存失败！");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    //生成费用划转单
    function transGen(yearMonth){
        var datacell1 = $id("datacell1");
    	var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    	if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		var action = "<%=request.getContextPath()%>/Job_orderAction.do?cmd=transSet";
        var xmlSubmit = datacell1.dataset.toString();
        var myAjax = new Ajax(action);
        myAjax.addParam("ids", ids);
        myAjax.addParam("yearMonth", yearMonth);
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
    
    //生成费用划转单,弹出年月设置
    function transet_onClick(){
    	var datacell1 = $id("datacell1");
       	var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    	if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(!valiEmp(ids,datacell1)){
			return ;
		}
    	var url="<%=request.getContextPath()%>/Job_orderAction.do?cmd=toSetYearMonth";
        showModalCenter(url, ids , callBack, 400, 185, "划转单生成年月");
    }
    
    //检查员工关联
    function valiEmp(ids,datacell){
    	var action = "<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?cmd=valiEmp";
        var xmlSubmit = datacell.dataset.toString();
        var myAjax = new Ajax(action);
        myAjax.addParam("ids", ids);
        myAjax.submitXML(xmlSubmit, 'UTF-8');
        var returnNode = myAjax.getResponseXMLDom();
        if(returnNode){
             var rtnMsg = myAjax.getValue("root/data/returnMessage");
        	 if( myAjax.getValue("root/data/returnValue") == "1" ) {
                 return true;
             }else{
             	 alert('操作失败!'+rtnMsg);
             	 return false;
             } 
        }
        return false;
    }
    
    function callBack(yearMonth){
    	if(yearMonth != null){
    		transGen(yearMonth);
    	}
    }
    
    

</script>
</head>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/Job_orderAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
<input type="hidden"  name="isTrans" value="true"/>
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="user_id" id="user_id" value="<%=rayoo.common.filter.UserInfoFilter.getLoginUserId() %>">
<div id="right">
<script language="javascript">
	writeTableTopFesco('订单管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
            <td align="left">关联合同</td>
            <td align="left">
                <input type="hidden" name="contract_id" id="contract_id" />
				<w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract" 
					lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="444" width="764" style="width:188px"/> 
            </td>
             <td align="left">订单状态</td>
            <td align="left">
                 <d:select dictTypeId="ORDER_STATUS_BD" id="order_status" name="order_status" nullLabel="--请选择--"></d:select>
            </td>
            <td align="left">客户名称</td>
            <td align="left">
            	<w:lookup onReturnFunc="rtnFunc" readonly="false" displayValue="" id="lk_cust" 
                                   lookupUrl="/JcustomerAction.do?cmd=getJCustRef" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
                <input type="hidden" name="cust_id" id="cust_id">
            </td>
        </tr>
        <tr>
            <td align="left">订单编号</td>
            <td align="left">
            	<input type="text" class="text_field" id="order_code" name="order_code" inputName="订单编号" maxLength="100"/>
            </td>
            <td align="left" colspan="2">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
                </td>
            <td align="left"></td>
        </tr>
</table>
</div>
 

 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
		<ul>
		    <li class="p_1"><a onClick="javascript:transet_onClick();">生成划转单</a></li>                     
        </ul>
</div>
           <div class="clear"></div>			
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/Job_orderAction.do?cmd=simpleQuery&order_type=2" width="98%" height="318px" xpath="Job_orderVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="order_code" label="订单编号" width="250px" ></r:field>    
 <r:field fieldName="order_name" label="订单名称" width="110px"></r:field>
 <r:field fieldName="contract_name" label="关联合同" allowModify="false" width="110px"></r:field>
 <r:field fieldName="customer_name" label="客户" allowModify="false" width="110px"></r:field>
 <r:field fieldName="warranty" label="担保期" allowModify="false" width="110px"></r:field>
 <r:field fieldName="order_status" label="订单状态" allowModify="false" width="110px">
    <d:select dictTypeId="ORDER_STATUS_BD"></d:select>
 </r:field>
 <r:field fieldName="create_user_name" label="录入人" width="110px"></r:field>
 <r:field fieldName="create_date" label="录入时间" allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
 </r:datacell>
</div>

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IJob_orderConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IJob_orderConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
