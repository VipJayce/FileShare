<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
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
        var policy_id = $id("policy_name").value;
        var eff_start_date = $id("eff_start_date").value;
        var eff_end_date = $id("eff_end_date").value
        if(policy_id==null || policy_id==""){
            alert("请选择保单！");
            return;
        }
        if(eff_start_date==null || eff_start_date==""){
            alert("请输入有效开始日期！");
            return;
        }
        if(eff_end_date==null || eff_end_date==""){
            alert("请输入有效结束日期！");
            return;
        }
        if(eff_end_date!=null&&eff_end_date.trim().length!=0){
           if(eff_start_date!=null){
		       var beginTime = eff_start_date.trim();
		       var endTime = eff_end_date.trim();
	           var beginTimes=beginTime.substring(0,10).split('-');
	           var endTimes=endTime.substring(0,10).split('-');
	           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
	           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
	           if(beginTime>endTime){
	               alert("有效结束日期小于有效开始日期！");
	               return;
	           }
           }
       }
        var is_set_up = $id("is_set_up").value;
        var action="<%=request.getContextPath()%>/PolicyAction.do?cmd=saveCustPolicyRelated&_ts="+(new Date()).getTime();  
        var myAjax = new Ajax(action);
        myAjax.addParam('ids', ids);
        myAjax.addParam('policy_id', policy_id);
        myAjax.addParam('eff_start_date', eff_start_date);
        myAjax.addParam('eff_end_date', eff_end_date);
        myAjax.addParam('is_set_up',is_set_up);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
             alert(""+myAjax.getProperty("returnValue"));
             window['returnValue'] = ""+myAjax.getProperty("returnValue");
             window.close();
             if(myAjax.getProperty("returnValue")=='操作成功！'){
             	showListData();
             }
        }
    }  
    
    function exportExcel_onClick()
    {
      if(confirm('是否确定要导出数据？')) {
          document.form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=exportToExcelNOrYRelateProductByPolicy";
          document.form.submit();
      }
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp' id='temp_"+rowNo+"'  value=" + entity.getProperty("id") +'@@' + entity.getProperty("customer_id") + ">";
    }
    
    //产品列表，点击全选按钮
    function product_onClick(obj){
        var datacell = $id("datacell1");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            //针对第一行有问题，其他行可行
            if(obj.checked){//勾选上
                $id("temp_"+i).checked=true;
            }else{//勾选去掉
                $id("temp_"+i).checked=false;
            }
        }
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

    function rtnFunc(arg){
        var lookup = $id("policy_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];   
        return false ;
    }
    
    function rtnFunc1(arg){
        var lookup = $id("policy_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];   
        return false ;
    }
    
    /**
     * 功能描述：动态生成产品大类下拉菜单的内容
     * 参数：  selectId --下拉框id;
     *              key -- 填充时作为option value的对象属性
     *              value -- 填充时作为option展示的对象属性
     */    
    function getAllBigType(selectObject,key,value,selectvalue){
        AjaxControl.getBigTypeId("big_type_id",{callback:function(data){
                if (data != null && typeof data == 'object') 
                {
                    setSelectForBean(selectObject.id,data,key,value,selectvalue);
                    getAllSmallType(document.form.big_type_id,'small_type_id','code','name','');
                }
            }
        });
    }
    
    /**
     * 功能描述：动态生成产品小类下拉菜单的内容
     * 参数：selectObject --下拉框对象;
                    targetId         -- 下拉框目标对象;
     *              key -- 填充时作为option value的对象属性
     *              value -- 填充时作为option展示的对象属性
     */    
    function getAllSmallType(selectObject,targetId,key,value,selectvalue){
        AjaxControl.getSmallTypeId(selectObject.value,{callback:function(data){
                if (data != null && typeof data == 'object') 
                {
                    DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                    DWRUtil.addOptions(targetId,{'':'--请选择--'});
                    setSelectForBean(targetId,data,key,value,selectvalue);
                    getAllThreeType(document.form.small_type_id,'three_type_id','code','name','');
                }
            }
        });
    }
    
    /**
     * 功能描述：动态生成产品三级分类下拉菜单的内容
     * 参数：selectObject --下拉框对象;
                    targetId         -- 下拉框目标对象;
     *              key -- 填充时作为option value的对象属性
     *              value -- 填充时作为option展示的对象属性
     */    
    function getAllThreeType(selectObject,targetId,key,value,selectvalue){
        AjaxControl.getThreeTypeId(selectObject.value,{callback:function(data){
                if (data != null && typeof data == 'object') 
                {
                    DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                    DWRUtil.addOptions(targetId,{'':'--请选择--'});
                    setSelectForBean(targetId,data,key,value,selectvalue);
                }
            }
        });
    }
    
    function is_set_select(){
    	var obj = document.getElementById('is_set_up');
    	if(obj.value=='0'){
    		document.getElementById('td1').style.display='none';
    		document.getElementById('td2').style.display='none';
    		document.getElementById('td3').style.display='none';
    		document.getElementById('td4').style.display='none';
    		document.getElementById('tda').style.display='inline';
    		document.getElementById('tdb').style.display='inline';
    		document.getElementById('tdc').style.display='inline';
    		document.getElementById('tdd').style.display='inline';
    	}else{
    		document.getElementById('td1').style.display='inline';
    		document.getElementById('td2').style.display='inline';
    		document.getElementById('td3').style.display='inline';
    		document.getElementById('td4').style.display='inline';
    		document.getElementById('tda').style.display='none';
    		document.getElementById('tdb').style.display='none';
    		document.getElementById('tdc').style.display='none';
    		document.getElementById('tdd').style.display='none';
    	}
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
    writeTableTopFesco('客户保单关联','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s"> 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="140" rowspan="6" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
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
          <td align="left">产品名称</td>
          <td align="left">
              <input type="text" class="text_field" name="product_name" inputName="产品名称" maxLength="50"/>
          </td>
        </tr>
        <tr>
            <td align="left">产品大类</td>
            <td align="left"><select id="big_type_id" name="big_type_id" onchange="javascript:getAllSmallType(this,'small_type_id','code','name')" disabled="disabled"></select></td>
            <td align="left">产品小类</td>
            <td align="left"><select id="small_type_id" name="small_type_id" onchange="javascript:getAllThreeType(this,'three_type_id','code','name')"><option value="">--请选择--</option></select> </td>
            <td align="left">产品三级分类</td>
            <td align="left"><select id="three_type_id" name="three_type_id"><option value="">--请选择--</option></select></td>
        </tr>
        <tr>
        <td align="left">保单名称</td>
        <td align="left"><w:lookup onReturnFunc="rtnFunc1" readonly="true" id="policy_id" name="policy_id" lookupUrl="/PolicyAction.do?cmd=toPolicyLookup"  dialogTitle="选择保单" style="width:187px;" height="480"  width="770"/></td>
        <td align="left" id="td1" style="display: none;">有效开始日期</td>
        <td align="left" id="td2" style="display: none;"><w:date format="yyyy-MM-dd" name="eff_start_date_from" id="eff_start_date_from" width="80px"/> 到 <w:date format="yyyy-MM-dd" name="eff_start_date_to" id="eff_start_date_to" width="80px"/></td>
        <td align="left" id="td3" style="display: none;">有效结束日期</td>
        <td align="left" id="td4" style="display: none;"><w:date format="yyyy-MM-dd" name="eff_end_date_from" id="eff_end_date_from" width="80px"/> 到 <w:date format="yyyy-MM-dd" name="eff_end_date_to" id="eff_end_date_to" width="80px"/></td>
        <td align="left" id="tda">&nbsp;</td>
        <td align="left" id="tdb">&nbsp;</td>
        <td align="left" id="tdc">&nbsp;</td>
        <td align="left" id="tdd">&nbsp;</td>
        </tr>
        <tr>
        <td align="left">是否已设置</td>
        <td align="left"><d:select id="is_set_up" name="is_set_up" dictTypeId="TrueOrFalse" value='0' onchange="is_set_select()"/></td>
        <td align="left">&nbsp;</td>
        <td align="left">&nbsp;</td>
        <td align="left" colspan="2"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();">&nbsp;&nbsp;<input type="reset" class="icon_1"  /></td>
        </tr>
</table>
</div>
 <table width="70%" height="40" border="0" cellpadding="0" cellspacing="1">
   <tr>
     <td class="td_1">&nbsp;</td>
     <td class="td_1">选择保单</td>
     <td class="td_1">
         <w:lookup onReturnFunc="rtnFunc" readonly="true" id="policy_name" name="policy_name" lookupUrl="/PolicyAction.do?cmd=toPolicyLookup" style="width:87px"  dialogTitle="选择保单" height="480"  width="770"/>
     </td>
     <td class="td_1">有效开始日期</td>
     <td class="td_1"><w:date format="yyyy-MM-dd" name="eff_start_date" id="eff_start_date" width="87px"/></td>
     <td class="td_1">有效结束日期</td>
     <td class="td_1"><w:date format="yyyy-MM-dd" name="eff_end_date" id="eff_end_date" width="87px"/></td>
     <td class="td_1"><div class="button_right"><input class="g" type="button" id="rules" name="rules"  value="保存" onClick="setRules_onClick();"></div></td>
     <td class="td_1"><div class="button_right"><input class="e_1" type="button"  value="导出" onClick="exportExcel_onClick();"></div></td>
   </tr>
 </table>
</div>
<div id="ccParent1" class="button"> 
<div class="clear"></div>           
</div> 
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/PolicyAction.do?cmd=searchCustPolicyRelated"
        submitAction="/FAERP/PolicyAction.do?cmd=saveCustPolicyRelated"
        width="98%"
        height="318px"
        xpath="WelfareProductVo"
        paramFormId="datacell_formid"
        pageSize="50"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作<input type='checkbox' name='productselect' onclick='product_onClick(this);' />" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center" >
       </r:field>
      <r:field fieldName="customer_name" label="客户名称" width="180px">
      </r:field>
      <r:field fieldName="customer_code" label="客户编号" width="70px">
      </r:field>
      <r:field fieldName="customer_property" label="客户性质" width="70px">
      </r:field>
      <r:field fieldName="product_name" label="产品名称" width="180px">
      </r:field>
      <r:field fieldName="small_type_id" label="产品小类" width="120px">
      </r:field>
      <r:field fieldName="three_type_id" label="产品三级分类" width="100px">
      </r:field>
      <r:field fieldName="policy_name" label="保单名称" width="100px">
      </r:field>
      <r:field fieldName="is_set_up" label="是否设置" width="60px" allowModify="false">
      <d:select dictTypeId="TrueOrFalse"/>
      </r:field>
      <r:field fieldName="eff_start_date" label="有效开始日期" width="90px" allowModify="false">
      <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="eff_end_date" label="有效结束日期" width="90px" allowModify="false">
      <w:date format="yyyy-MM-dd"/>
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
getAllBigType(document.form.big_type_id,'code','name','104')
//初始化不加载页面信息
jQuery(function(){
   // $id("datacell1").isQueryFirst = false;
});
</script>   
