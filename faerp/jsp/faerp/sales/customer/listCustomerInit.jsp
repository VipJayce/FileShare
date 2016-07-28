<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@ page import="rayoo.sales.customer.util.ICustomerConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ICustomerConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ICustomerConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	CustomerVo resultVo = null;  //定义一个临时的vo变量
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
    
     function setRules_onClick() {  //从多选框到设置规则页面
        var custId_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<custId_check.length;i++){  //循环checkbox组
            if(custId_check[i].checked){
                ids.push(custId_check[i].value);  //加入选中的checkbox
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
        var url="<%=request.getContextPath()%>/CustomerAction.do?cmd=detailCustInit&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=设置规则');
        //showModalCenter(url, window, callBack, 1024, 500, "设置规则"); 
    }  
    
    function callBack(reg){
	    if(reg!=""&&reg!=null){
	        $id("datacell1").loadData();
	        $id("datacell1").refresh();
	    }
	}
    
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "simpleQueryCustInit";
        form.submit();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    
    function setCustLevel_onClick() {  //设置客户级别
        var custId_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<custId_check.length;i++){  //循环checkbox组
            if(custId_check[i].checked){
                ids.push(custId_check[i].value);  //加入选中的checkbox
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
        var url="<%=request.getContextPath()%>/PbcustlevelsetAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=550px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=设置客户级别');
        //showModalCenter(url, window, "", 500, 300, "设置客户级别"); 
    }  
</script>
 

</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden"  name="cmd" value="queryCustomerInitAll"/>
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('客户初始化','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s"> 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="140" rowspan="2" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        </tr>               
        <tr>
          <td align="left">客户编号</td>
          <td align="left">
           <input type="text" class="text_field" name="customer_code" inputName="客户编号" maxLength="64"/>
          </td>
          <td align="left">客户名称</td>
          <td align="left">
              <input type="text" class="text_field" name="customer_name" inputName="客户名称" maxLength="50"/>
          </td>
            <td align="left" colspan="2"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();"><input type="reset" class="icon_1"  /></td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
		<!--<ul>
		    <li class="q">   <a  onClick="javascript:setRules_onClick();">设置 </a> </li>
		</ul>				
 -->
 <input class="q" type="button"   value="设置"  <au:authorityBtn code="custInit_set" type="1"/>  onClick="setRules_onClick();">
  <input class="q" type="button"   value="修改"  <au:authorityBtn code="custInit_modify" type="1"/>  onClick="setRules_onClick();">
  <input class="bl_1" type="button"   value="级别设置"  <au:authorityBtn code="custInit_modify" type="1"/>  onClick="setCustLevel_onClick();">
 </div>
<div class="clear"></div>			
</div> 
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/CustomerAction.do?cmd=searchCustomerInitAll"
        width="98%"
        height="318px"
        xpath="CustomerVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="customer_name" label="客户名称" width="200px">
      </r:field>
      <r:field fieldName="customer_code" label="客户编号" width="100px">
      </r:field>
      <r:field fieldName="customer_property" label="客户性质" allowModify="false" width="100px">
      <d:select dictTypeId="CUSTOMER_PROPERTY" />
      </r:field>
      <r:field fieldName="country_area" label="国家地区" allowModify="false" width="200px">
          <r:comboSelect id="country_area" name="country_area" queryAction="/FAERP/CustomerAction.do?cmd=queryCountryData" 
    textField="name" valueField="id" xpath="CustomerSelectVo"  nullText=""/> 
      </r:field>
      <r:field fieldName="customer_type" label="客户类别" allowModify="false" width="150px">
      <d:select dictTypeId="CUSTOMER_TYPE" />
      </r:field>
      <r:field fieldName="add_trade_type" label="行业类别" allowModify="false" width="150px">
     <!--  <d:select dictTypeId="TRADE_TYPE" /> -->
      </r:field>
           <r:field fieldName="product_grant_rule_id" label="是否已设置电影票规则" allowModify="false"   onRefreshFunc="showValue" width="150px">
      </r:field>
      <r:field fieldName="cust_level_bd"  allowModify="false" label="是否E化" width="150px">
      <d:select dictTypeId="CUST_LEVEL_BD" />
      </r:field>
    </r:datacell>
    </div>
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
   function showValue(value){
            if (value == '' || value == null){
                return "否";
            }else {
                return "是";
            }
        }

<% //表单回写
    if(request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>	
