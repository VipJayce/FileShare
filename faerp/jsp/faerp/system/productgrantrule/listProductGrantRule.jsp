<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.productGrantRule.vo.ProductGrantRuleVo" %>
<%@ page import="rayoo.system.productGrantRule.util.IProductGrantRuleConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IProductGrantRuleConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IProductGrantRuleConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	ProductGrantRuleVo resultVo = null;  //定义一个临时的vo变量
%>
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
		//form.action="<%=request.getContextPath()%>/ProductGrantRuleAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
		var url="<%=request.getContextPath()%>/ProductGrantRuleAction.do?cmd=find&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 1200, 200, "修改产品发放规则");  
	}  
	function deleteMulti_onClick()  {
	  //从多选框物理删除多条记录
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
	    	form.action="<%=request.getContextPath()%>/ProductGrantRuleAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		var url="<%=request.getContextPath()%>/jsp/faerp/system/productgrantrule/insertProductGrantRule.jsp";
        url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 1200, 200, "新增产品发放规则");  
	}
	
	function callBack(reg){
        if(reg!=""&&reg!=null){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
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
		form.action="<%=request.getContextPath()%>/ProductGrantRuleAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('产品发放规则','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
</div>	
<div id="ccParent1" class="button"> 
 <div class="button_right">
		<ul>
			<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
			<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
			<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
		</ul>				
 </div>
 <div class="clear"></div>			
</div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/ProductGrantRuleAction.do?cmd=searchProductGrantRuleAll"
        width="98%"
        height="318px"
        xpath="ProductGrantRuleVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
       <r:field fieldName="emp" label="操作" width="100px" sortAt="none" onRefreshFunc="setCheckboxStatus"  >
       </r:field>
       <r:field fieldName="grant_condition" label="发放条件" width="150px" allowModify="false">
      <d:select dictTypeId="GRANT_CONDITION" />
      </r:field>
      <r:field fieldName="ff_month" label="发放月份" width="100px" onRefreshFunc="showValue4">
      </r:field>
       <r:field fieldName="grant_month" label="最少缴费月数" width="100px" onRefreshFunc="showValue3">
      </r:field>
       <r:field fieldName="grant_frequency" label="发放频率" width="100px" onRefreshFunc="showValue">
      </r:field>
      <r:field fieldName="grant_counts" label="发放数量" width="250px" onRefreshFunc="showValue2">
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
	if(request.getAttribute(IProductGrantRuleConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IProductGrantRuleConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>

function showValue(value,entity,rowNo,cellNo){
            if (value == '' || value == null){
                return '';
            }else {
                return "每隔" + value + "个月";
            }
        }
        
        function showValue3(value,entity,rowNo,cellNo){
            if (value == '' || value == null){
                return '';
            }else {
                return "" + value +  "个月";
            }
        }
         function showValue4(value,entity,rowNo,cellNo){
            if (value == '' || value == null){
                return '';
            }else {
                return "" + value +  "月";
            }
        }
        function showValue2(value,entity,rowNo,cellNo){
            var a = entity.getProperty("grant_condition");          
            if (a == '6' || a == 6){
                return "上半年发放" + entity.getProperty("grant_counts") + "张，下半年发放" + entity.getProperty("grant_counts1") + "张";
            }else {
                return "发放" + value + "张";
            }
        }    
</script>	
