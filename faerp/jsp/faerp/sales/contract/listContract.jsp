<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.contract.vo.ContractVo" %>
<%@ page import="rayoo.sales.contract.util.IContractConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IContractConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IContractConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	ContractVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.salse.contract.contract_resource" prefix="rayoo.salse.contract.">
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
		var url="<%=request.getContextPath()%>/ContractAction.do?cmd=find&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=yes,title=修改合同模板');
        //showModalCenter(url, window, showListData, 1000, 800, "修改合同模板"); 
		//form_treebasic.action="<%=request.getContextPath()%>/ContractAction.do?id=" + ids;
		//form_treebasic.cmd.value = "find";
		//form_treebasic.submit();
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
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    jQuery.ajax({
        url: "<%=request.getContextPath()%>/ContractAction.do?cmd=deleteMulti&ids="+ids+"&date="+new Date(),
        type: 'GET',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(text){ 
           if(text==1){
               alert("<fmt:message key='contract_template_not_delete'/>");  
               return;
           }else{
           form_treebasic.cmd.value = "simpleQuery";
           form_treebasic.submit();
           }
        }
        });
        return true;    
		}
	}
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	form_treebasic.cmd.value = "simpleQuery";
    	form_treebasic.submit();
  	}
  	
	function toAdd_onClick() {  //到增加记录页面
	    var url="<%=request.getContextPath()%>/jsp/faerp/sales/contract/insertContract.jsp";
        url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增合同模板');
        //showModalCenter(url, window, showListData, 1000, 800, "新增合同模板");  
	
		//form_treebasic.action="<%=request.getContextPath()%>/jsp/faerp/sales/contract/insertContract.jsp";
		//form_treebasic.submit();
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
		var url="<%=request.getContextPath()%>/ContractAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=yes,title=查看详细信息');
        //showModalCenter(url, window, "", 1000, 800, "查看详细信息");  
		//form_treebasic.action="<%=request.getContextPath()%>/ContractAction.do?id=" + ids;
		//form_treebasic.cmd.value = "detail";
		//form_treebasic.submit();
	}
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
	
	function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
</script>
</head>
<body>
<form name="form_treebasic" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="">
 <input id="webModel" name="webModel" type="hidden" class="text_field" inputName="发布目录" value="<%=request.getContextPath()%>" readonly="true">
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key='contract_template'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='query_conditions'/></div> </td>
		<td/>
		<td/>
	    <td>    </td>
       	<td/>
	</tr>		
	<tr>
		<td align="right"><fmt:message key='contract_template_name'/></td>
		<td align="left">
			<input type="text" class="text_field" name="contract_template_name" inputName="合同模板名称" maxLength="50"/>
		</td>
		<td align="right"><fmt:message key='contract_template_type'/></td>
            <td align="left">
                    <d:select dictTypeId="CONTRACT_TYPE_BD" name="contract_type_bd" id="contract_type_bd"  nullLabel="--请选择--"/>
            </td>
		 <td>
               <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();">
           </td>
	</tr>	
</table>
</div>	
<div id="ccParent1" class="button"> 
 <div class="button_right">
		<!--<ul>
			<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
			<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
			<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
			<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
		</ul>				
 -->
 <input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="contTem_view" type="1"/>  onClick="detail_onClick();">
 <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="contTem_add" type="1"/>  onClick="toAdd_onClick();">
 <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="contTem_del" type="1"/>  onClick="deleteMulti_onClick();">
 <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="contTem_modify" type="1"/>  onClick="findCheckbox_onClick();">
 </div>
 <div class="clear"></div>			
</div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/ContractAction.do?cmd=searchContractData"
        width="98%"
        height="318px"
        xpath="ContractVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="operation" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="contract_template_name" messagekey="contract_template_name" width="230px">
      </r:field>
      <r:field fieldName="contract_template_version" messagekey="contract_template_version" width="170px">
      </r:field>
      <r:field fieldName="effect_date" messagekey="contract_effect_date" width="170px" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="lapse_date" messagekey="contract_lapse_date" width="170px" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date" width="170px" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="contract_type_bd" messagekey="contract_type" width="170px" allowModify="false">
            <d:select dictTypeId="CONTRACT_TYPE_BD"></d:select>
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
	if(request.getAttribute(IContractConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IContractConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>	
