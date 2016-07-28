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
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
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
		var url="<%=request.getContextPath()%>/Finout_contract_serviceAction.do?cmd=find_tempcontract&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=yes,title=修改财务外包合同模板');
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
        url: "<%=request.getContextPath()%>/Finout_contract_serviceAction.do?cmd=deleteFinoutTempMulti&ids="+ids+"&date="+new Date(),
        type: 'GET',
        dataType: 'html',
        success: function(text){ 
           if(text==1){
               alert("合同模板被引用后不允许删除，只有未被引用的合同模板才允许删除!");  
               return;
           }else{
                    alert("删除成功!");
                    showListData();
           }
        }
        });
        return true;    
		}
	}
	function toAdd_onClick() {  //到增加记录页面
	    var url="<%=request.getContextPath()%>/jsp/faerp/finout/finoutsalcontracttemp/insertFinoutTempContract.jsp";
        url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增财务外包合同模板');
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
		var url="<%=request.getContextPath()%>/Finout_contract_serviceAction.do?cmd=detail_tempcontract&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看详细信息');
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
<div id="right">
<script language="javascript">
	writeTableTopFesco('财务外包合同模板','<%=request.getContextPath()%>/');  //显示本页的页眉
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
		<td align="right">合同模板名称</td>
		<td align="left">
			<input type="text" class="text_field" name="contract_template_name" inputName="合同模板名称" maxLength="50"/>
		</td>
		<td align="right">合同业务类型</td>
            <td align="left">
                    <d:select dictTypeId="FINOUT_TYPE_BD" name="business_type_bd" id="business_type_bd" nullLabel="--请选择--"/>
            </td>
		 <td>
               <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();">
              <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">         
 </td>
	</tr>	
</table>
</div>	
<div id="ccParent1" class="button"> 
 <div class="button_right">
 <input class="a" type="button"   value="<fmt:message key="view"/>"    onClick="detail_onClick();">
 <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAdd_onClick();">
 <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMulti_onClick();">
 <input class="b" type="button"   value="<fmt:message key="modify"/>"    onClick="findCheckbox_onClick();">
 </div>
 <div class="clear"></div>			
</div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/Finout_contract_serviceAction.do?cmd=searchContractTempData"
        width="98%"
        height="318px"
        xpath="ContractVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="contract_template_name" label="合同模板名称" width="230px">
      </r:field>
      <r:field fieldName="contract_template_version" label="合同模板版本号" width="170px">
      </r:field>
      <r:field fieldName="effect_date" label="合同生效日期" width="170px" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="lapse_date" label="合同失效日期" width="170px" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="create_date" label="创建日期" width="170px" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="business_type_bd" label="合同业务类型" width="170px" allowModify="false">
            <d:select dictTypeId="FINOUT_TYPE_BD"></d:select>
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
