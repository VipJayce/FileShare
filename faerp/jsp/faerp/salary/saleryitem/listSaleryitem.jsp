<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.salary.salaryitem.salaryitem_resource" prefix="rayoo.salary.salaryitem.">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function toSave_onclick() { 
        $id("dc_salaeyitemid").submit();
    }  
    function toDelete_onclick(){
        //校验是否被其他公式项引用，如果引用，则不能删除！2013-07-26陈小佩增加
        var datacell = $id("dc_salaeyitemid");
        var dataset = datacell.dataset;//取得页面的datacell
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var biaoshi = 'def'+datasettr.getProperty('item_serial_new_id');
        var ali = '0123456789';
        for(var i=0; i<dataset.getLength(); i++){
            var aproperty = dataset.get(i);
            if(aproperty.getProperty('data_source')=='1'){//如果是公式
                 var formula = aproperty.getProperty('formula');
                 if(formula.indexOf(biaoshi)>=0){//公式字符串中包含本项
                    //本项后面的字符不是数字，则确实为本项，不能删除
                    var weizhi = formula.indexOf(biaoshi)+biaoshi.length;
                    var nextchar = formula.substr(weizhi,1);
                    if(nextchar!=null && nextchar!=''){
                        if(ali.indexOf(nextchar)==-1){
                            alert("<fmt:message key='alert_delete_formula_1'/>"+aproperty.getProperty('sa_item_name')+"<fmt:message key='alert_delete_formula_2'/>");
                            return false;
                        }
                    }
                 }
            }
        }
        
    	if(confirm("<fmt:message key='alert_is_cancel'/>")){
	       	$id("dc_salaeyitemid").deleteRow();
    		$id("dc_salaeyitemid").submit();
	    }
    }
    function toUpdate_onclick() { //到修改记录页面
        var dc = $id("dc_salaeyitemid");
        var clz = dc.getActiveEntity();
        if(!clz){
            alert("<fmt:message key='alert_select_one'/>");
            return ;
        }
        var issys = clz.getProperty("is_system");
        //if(issys!=null && issys=='1'){
        //    alert("<fmt:message key='alert_systemItem_cant_update'/>");
        //    return ;
       // }
        var salaeryid = clz.getValue("id");
        var datacell_formid = $id("datacell_formid") ;
        datacell_formid.action ="<%=request.getContextPath()%>/SaleryitemAction.do?cmd=detail&salaeryid="+salaeryid+"&issys="+issys;
        datacell_formid.submit();    
    }
    function toInsert_onclick() { //到添加记录页面
        var salary_class_id = $id("salary_class_id").value ;
        if(salary_class_id == null||salary_class_id==''){
            alert("<fmt:message key='alert_select_class'/>") ;
            return false ;
        }
        var datacell_formid = $id("datacell_formid") ;
        datacell_formid.action ="<%=request.getContextPath()%>/SaleryitemAction.do?cmd=inifInsert&salary_class_id="+salary_class_id;
        datacell_formid.submit();    
    }
    
    function toDetail_onclick() { //到查看记录页面
        var dc = $id("dc_salaeyitemid");
        var clz = dc.getActiveEntity();
        if(!clz){
            alert("<fmt:message key='alert_select_one'/>");
            return ;
        }
        var salaeryid = clz.getValue("id");
        var datacell_formid = $id("datacell_formid") ;
        datacell_formid.action ="<%=request.getContextPath()%>/SaleryitemAction.do?cmd=detailSalaery&salaeryid="+salaeryid;
        datacell_formid.submit();    
    }
    function toReload_onclick() {
         $id("dc_salaeyitemid").reload();
    }
     //选择薪资类别
    function rtnFunc(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        $id("class_name").value = arg[1];
        $id("cust_id").value = arg[2];
        $id("cust_code").value = arg[3];
        $id("cust_name").value = arg[4];   
        var salary_class_id = document.getElementById("salary_class_id") ;
        salary_class_id.value = arg[0] ;
        var sc_id = document.getElementById("sc_id") ;
        sc_id.value = arg[1] ;
        $id("dc_salaeyitemid").reload();;
        return false ;
    }
    
    //弹出导出层
    function compute_pop(){
        var salary_class_id = $id("salary_class_id").value ;
        if(salary_class_id == null||salary_class_id==''){
            alert("<fmt:message key='alert_select_class'/>") ;
            return false ;
        }
        url="<%=request.getContextPath()%>/jsp/faerp/salary/saleryitem/computeorder.jsp?sa_class_id="+salary_class_id;
        showModalCenter(url, window, "", 700, 330, "<fmt:message key='setting_cal_turn'/>");  //增加子岗位
    }
    //弹出导出层
    
    function display_pop(){
        var salary_class_id = $id("salary_class_id").value ;
        if(salary_class_id == null||salary_class_id==''){
            alert("<fmt:message key='alert_select_class'/>") ;
            return false ;
        }
        url="<%=request.getContextPath()%>/jsp/faerp/salary/saleryitem/displayorder.jsp?sa_class_id="+salary_class_id;
        showModalCenter(url, window, "", 700, 330, "<fmt:message key='setting_show_turn'/>");  //增加子岗位
    }
    //定制特殊工资单
    function designSpecialPayroll(){
    	var salary_class_id = $id("salary_class_id").value ;
        if(!salary_class_id){
            alert("<fmt:message key='alert_select_class'/>") ;
            return false ;
        }
    	//var url ="<%=request.getContextPath()%>/jsp/faerp/salary/saleryitem/designSpecPayroll.jsp?sa_class_id="+salary_class_id;
    	//showModalCenter(url, window, "", 700, 500, '定制特殊工资单');
    	$id("datacell_formid").action = "<%=request.getContextPath()%>/SalaryorderreleaseAction.do";
    	$id("h_cmd").value = "findSpecPayroll";
    	$id("datacell_formid").submit();
    }
    
</script>
</head>
<body>
<form  id="datacell_formid" method="post" action="<%=request.getContextPath()%>/SaleryitemAction.do">
<input name="cmd" type="hidden" id="h_cmd" value="findSpecPayroll"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='salaryitem'/></div></div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="150" style="padding-top:0;"><div class="search_title"><fmt:message key='salaryitem_search'/></div></td>
    <td width="98"><fmt:message key='salary_type'/></td>
    <td width="235">
    <w:lookup onReturnFunc="rtnFunc" readonly="true" id="lk_clz" lookupUrl="/SalaryclassAction.do?cmd=toSalartClzLookup" displayValue="${requestScope.salary_class_name}" messagekey="select_class" height="500"  width="910"/>
                <input type="hidden" name="salary_class_id" id="salary_class_id" value="${requestScope.salary_class_id}"/>
                <input name="sc_id" type="hidden" id="sc_id" value="${requestScope.salary_class_name}"/>
                <input name="cust_id" type="hidden" id="cust_id" value=""/>
                <input name="cust_name" type="hidden" id="cust_name" value=""/>
                <input name="cust_code" type="hidden" id="cust_code" value=""/>
                <input name="class_name" type="hidden" id="class_name" value=""/>
    </td>
    <td width="71">&nbsp;</td>
    <td width="116"></td>
    <td width="432" >&nbsp;</td>
  </tr>
</table>
  </div>
        <div class="button">
            <div class="button_right">
                <!--<ul>
                    <li class="a"><a onclick="javascript:toDetail_onclick();">查看</a></li>
                    <li class="c"><a onclick="javascript:toInsert_onclick() ;">新增</a></li>
                    <li class="b"><a href="javascript:toUpdate_onclick() ;">修改</a></li>
                    <li class="d"><a onClick="javascript:toDelete_onclick()">作废</a></li>  
                     <li class="bc"><a onClick="javascript:toSave_onclick() ;">保存</a></li>   
                    <li class="a"><a onClick="javascript:toReload_onclick() ;">刷新</a></li>   
                    <li class="q_1"><a onClick="javascript:compute_pop() ;">设置计算顺序</a></li> 
                    <li class="q_1"><a onClick="javascript:display_pop() ;">设置显示顺序</a></li> 
                </ul>
                -->
                <input class="a" type="button"   value="<fmt:message key='button_view' />"  <au:authorityBtn code="xzxm_view" type="1"/>  onClick="toDetail_onclick();">
                <input class="c" type="button"   value="<fmt:message key='button_add'/>"  <au:authorityBtn code="xzxm_add" type="1"/>  onClick="toInsert_onclick();">
                 <input class="b" type="button"   value="<fmt:message key='button_modify'/>"  <au:authorityBtn code="xzxm_xg" type="1"/>  onClick="toUpdate_onclick();">
                 <input class="d" type="button"   value="<fmt:message key='button_cancel'/>"  <au:authorityBtn code="xzxm_zf" type="1"/>  onClick="toDelete_onclick();">   
                 <input class="q_1" type="button"   value="<fmt:message key='button_cal_turn'/>"  <au:authorityBtn code="xzxm_szjssx" type="1"/>  onClick="compute_pop();">
                 <input class="q_1" type="button"   value="<fmt:message key='button_show_turn'/>"  <au:authorityBtn code="xzxm_szxsxx" type="1"/>  onClick="display_pop();">
                 <input class="q_1" type="button" value="<fmt:message key='button_custom_mould'/>" <au:authorityBtn code="xzxm_dzbmgzd" type="1"/> onClick="designSpecialPayroll();">
             </div>
            <div class="clear"></div>
        </div>
     <div style="padding: 8 10 8 8;">
        <r:datacell id="dc_salaeyitemid"
            queryAction="/FAERP/SaleryitemAction.do?cmd=seachSalaery"
            submitAction="/FAERP/SaleryitemAction.do?cmd=insertseachSalaery"
            width="98%" xpath="SaleryitemVo" submitXpath="SaleryitemVo"
            pageSize="100"
            paramFormId="datacell_formid" height="340px">

            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="sa_item_name" messagekey="sa_item_name" width="160px">
                
            </r:field>
            <r:field fieldName="sa_item_ename" messagekey="sa_item_ename" width="150px">
                
            </r:field>          
            <r:field fieldName="payroll_name" messagekey="payroll_name" width="150px"></r:field>
            <r:field fieldName="is_tax" messagekey="is_tax" width="100px">
                  <h:select property="is_tax" disabled="true">
                         <h:option value="1" label="税前"/>
                         <h:option value="0" label="税后"/>
                         <h:option value="2" label="其他"/>
                  </h:select>
            </r:field>
            <r:field fieldName="data_source" messagekey="data_source" width="150px">
                <h:select property="data_source" disabled="true">
                         <h:option value="1" label="公式"/>
                         <h:option value="2" label="固定值"/>
                         <h:option value="3" label="手输"/>
                         <h:option value="4" label="上月项目"/>
                         <h:option value="5" label="合同数据"/>
                  </h:select>
            </r:field>          
            <r:field fieldName="is_display" messagekey="is_display" width="100px">
                  <h:select property="is_display" disabled="true">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
                  </h:select>
            </r:field>
            <r:field fieldName="is_valid" messagekey="is_valid" width="100px" >
                    <h:select property="is_valid" disabled="true">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
                  </h:select>
            </r:field>
            <r:field fieldName="item_cost_group" messagekey="item_cost_group" width="100px" allowModify="false">
                   <d:select id="dselect1" dictTypeId="ITEM_COST_GROUP" nullLabel=""/>
            </r:field>
            <r:field fieldName="is_system" messagekey="is_system" width="100px" allowModify="false">
                   <d:select id="dselect2" dictTypeId="TrueOrFalse" nullLabel=""/>
            </r:field>
        </r:datacell>
</div>
    </div>
</div>
</form>
</body>
</html>
<script type="text/javascript">
$id("dc_salaeyitemid").afterSubmit = function(ajax){
    var rst = ajax.getProperty("returnValue");
        if (rst == '1'){
            alert("<fmt:message key='alert_save_success' />");
        } else if (rst=='0'){
            alert("<fmt:message key='alert_long_err' />");
        }else{
            alert("<fmt:message key='alert_system_error' />") ;
        }
}
</script>
</fmt:bundle>
