<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.finishformalities.util.IFinishFormalitiesConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
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
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = selectIds();
        var flag = true;
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        $id("datacell1").isModefied = false;
		document.form.action="<%=request.getContextPath()%>/FinishFormalitiesAction.do?cmd=find&id=" + ids;
		document.form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = selectIds();
 		if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	document.form.action="<%=request.getContextPath()%>/FinishFormalitiesAction.do?cmd=deleteMulti&ids=" + ids;
	    	document.form.submit();
		}
	}
	
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/finishformalities/insertFinishFormalities.jsp";
		form.submit();
		//var url="<%=request.getContextPath()%>/jsp/faerp/insurance/finishformalities/insertFinishFormalities.jsp";
        //url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        //showModalCenter(url, window, showListData, 1000, 400, "新增已办完");  
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
		document.form.action="<%=request.getContextPath()%>/FinishFormalitiesAction.do?cmd=detail&id=" + ids;
		document.form.submit();
	}

    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function importExcel_onClick()
    {
         var url = "<%=request.getContextPath()%>/jsp/faerp/insurance/finishformalities/importExcel.jsp";
         var l = (screen.width - 550) / 2;
         var t = (screen.height - 200) / 2;
         var s = 'width=550, height=200, top=' + t + ', left=' + l; 
         s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
         window.open('<%=request.getContextPath() %>/jsp/faerp/insurance/finishformalities/importExcel.jsp','', s);
         //showModalCenter(url, window,toFindMemer,550,200,"导入已办完情况信息");
    }
    
    function exportExcel_onClick(){
        window.location="<%=request.getContextPath()%>/FinishFormalitiesAction.do?cmd=downLoad" ;    
    }    
    
    function toFindMemer()
    {
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    /**
     * 点击全选按钮
     * @param {} item
     */
    function checkAll(item) {
        if (_$(item).attr("checked")) {
            changeEntityChk(true);
            _$(":checkbox").attr("checked", true);
        } else {
            changeEntityChk(false);
            _$(":checkbox").attr("checked", false);
        }
    }
    
    /**
     * 改变datacell中的chk的值
     * @param {} flag
     */
    function changeEntityChk(flag) {
        var dc1 = $id("datacell1").dataset;
        var values = dc1.values;
        for(var i=0; i<values.length; i++){
            var entity = values[i];
            entity.setProperty("chk", flag);
        }
    }
    
    /**
     * 选择行后返回ids
     */
    function selectIds() {
        var myids = new Array(0);
        var dc = $id("datacell1");
        var ds = dc.dataset;
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                myids.push(entity.getValue("id"));
            }
        });
        return myids;
    }
</script>
</head>
<body>

<form name="form" method="post" id="formId">
<div id="right">
<script language="javascript">
	writeTableTopFesco('已办完情况列表','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
		</tr>
		<tr>
			<td align="right">唯一号</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>
			</td>
			<td align="right">姓名</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="姓名" maxLength="50"/>
            </td>
		</tr>
		<tr>
			<td align="right">商编</td>
			<td align="left">
				<input type="text" class="text_field" name="agent_code1" inputName="商编" maxLength="64"/>
			</td>
			<td align="right">公司名称</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name1" inputName="公司名称" maxLength="50"/>
            </td>
		</tr>
		<tr>
		<td colspan="3" align="right" style="padding-right: 20px;"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();"></td>
		<td align="left"><input type="reset" class="icon_1" name="reset" value="重置"/>
            </td>
		</tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<input class="a" type="button" value="查看" onclick="detail_onClick();">
					<input class="c"  type="button" value="新增" onclick="toAdd_onClick();">
					<input class="e_2" type="button"  value="下载模板"   onClick="exportExcel_onClick();">
					<input class="e_1" type="button"   value="导入"   onClick="importExcel_onClick();">
					<input class="b" type="button" value="修改" onclick="findCheckbox_onClick();">
					<input class="d"  type="button"   value="删除"  onClick="deleteMulti_onClick();">
				</ul>
				
		 </div>
           <div class="clear"></div>
</div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/FinishFormalitiesAction.do?cmd=simpleQuery"
        width="98%"
        height="318px"
        xpath="FinishFormalitiesVo"
        paramFormId="formId"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field allowModify="false" fieldName="chk"
            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            sortAt="none" width="30px">
            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
                uncheckedValue="0" />
        </r:field>
      <r:field fieldName="emp_code" label="唯一号">
      </r:field>
      <r:field fieldName="emp_name" label="姓名">
      </r:field>
      <r:field fieldName="emp_status" label="员工状态">
      </r:field>
      <r:field fieldName="agent_code" label="商编">
      </r:field>
      <r:field fieldName="auxiliary_code" label="辅编">
      </r:field>
      <r:field fieldName="cust_name" label="公司名称">
      </r:field>
      <r:field fieldName="sentoregional" label="派往地区">
      </r:field>
      <r:field fieldName="agent_name" label="供应商">
      </r:field>
      <r:field fieldName="sales_man" label="业务员">
      </r:field>
      <r:field fieldName="is_outbound" label="是否外呼">
      </r:field>
      <r:field fieldName="on_post_date" label="入职日期">
      </r:field>
      <r:field fieldName="do_send_formalities" label="办派手续">
      </r:field>
      <r:field fieldName="create_date" label="操作日期">
      </r:field>
      <r:field fieldName="ssecurity_standard" label="社保标准">
      </r:field>
      <r:field fieldName="publish_formalite_date" label="手续发布时间">
      </r:field>
      <r:field fieldName="procedure_category" label="手续类别">
      </r:field>
      <r:field fieldName="notify_emp_date" label="通知员工时间">
      </r:field>
      <r:field fieldName="person_formalite_date" label="人事手续办理时间">
      </r:field>
      <r:field fieldName="pension_formalite_date" label="养老手续办理时间">
      </r:field>
      <r:field fieldName="medical_formalite_date" label="医疗手续办理时间">
      </r:field>
      <r:field fieldName="fund_formalite_date" label="公积金手续办理时间">
      </r:field>
      <r:field fieldName="resident_addresss" label="户口所在地">
      </r:field>
      <r:field fieldName="archive_card" label="存档单位">
      </r:field>
      <r:field fieldName="contact_with_emp_remark" label="与员工联系备注">
      </r:field>
      <r:field fieldName="contact_with_emp_date" label="与员工联系办理时间">
      </r:field>
      <r:field fieldName="check_progress" label="办理进度">
      </r:field>
      <r:field fieldName="check_progress_date" label="办理进度办理时间">
      </r:field>
      <r:field fieldName="special_entrust" label="特殊委托">
      </r:field>
      <r:field fieldName="special_entrust_date" label="特殊委托办理时间">
      </r:field>
      <r:field fieldName="is_archive" label="只存档">
      </r:field>
      <r:field fieldName="is_archive_date" label="只存档办理时间">
      </r:field>
      <r:field fieldName="on_post_checkup" label="入职体检">
      </r:field>
      <r:field fieldName="on_post_checkup_date" label="入职体检办理时间">
      </r:field>
      <r:field fieldName="labor_contract" label="劳动合同">
      </r:field>
      <r:field fieldName="labor_contract_date" label="劳动合同办理时间">
      </r:field>
      <r:field fieldName="bg_investigation" label="背景调查">
      </r:field>
      <r:field fieldName="bg_investigation_date" label="背景调查办理时间">
      </r:field>
      <r:field fieldName="tiaodang_remarks" label="调档备注">
      </r:field>
      <r:field fieldName="tiaodang_date" label="调档办理时间">
      </r:field>
      <r:field fieldName="archive_unit_remarks" label="存档单位备注">
      </r:field>
      <r:field fieldName="archive_unit_date" label="存档单位办理时间">
      </r:field>
      <r:field fieldName="separat_prod_date" label="离职手续发布时间">
      </r:field>
      <r:field fieldName="sp_send_emp_date" label="离职手续通知员工时间">
      </r:field>
      <r:field fieldName="sp_person_handle_date" label="离职手续人事手续办理时间">
      </r:field>
      <r:field fieldName="sp_pension_handle_date" label="离职手续养老手续办理时间">
      </r:field>
      <r:field fieldName="sp_medical_handle_date" label="离职手续医疗手续办理时间">
      </r:field>
      <r:field fieldName="sp_fund_handle_date" label="离职手续公积金手续办理时间">
      </r:field>
      <r:field fieldName="sp_resident_addresss" label="离职手续户口所在地">
      </r:field>
      <r:field fieldName="sp_archive_card" label="离职手续存档单位">
      </r:field>
      <r:field fieldName="sp_cwith_emp_remark" label="离职手续与员工联系备注">
      </r:field>
      <r:field fieldName="sp_pension_account" label="离职手续养老个人账户">
      </r:field>
      <r:field fieldName="sp_medical_account" label="离职手续医疗个人账户">
      </r:field>
      <r:field fieldName="sp_fund_account" label="离职手续公积金个人账户">
      </r:field>
      <r:field fieldName="sp_check_progress" label="离职手续办理进度">
      </r:field>
      <r:field fieldName="sp_special_entrust" label="离职手续特殊委托">
      </r:field>
      <r:field fieldName="sp_is_archive" label="离职手续只存档">
      </r:field>
      <r:field fieldName="sp_on_post_checkup" label="离职手续入职体检">
      </r:field>
      <r:field fieldName="sp_labor_contract" label="离职手续劳动合同">
      </r:field>
      <r:field fieldName="sp_archive_unit_remarks" label="离职手续存档单位备注">
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
    if(request.getAttribute(IFinishFormalitiesConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IFinishFormalitiesConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
_$(function(){
    $id("datacell1").isQueryFirst = true;
});
</script>   
