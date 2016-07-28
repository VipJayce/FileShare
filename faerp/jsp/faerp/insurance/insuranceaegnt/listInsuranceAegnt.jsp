<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.insuranceaegnt.util.IInsuranceAegntConstants" %>
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
		//var aegnt_check = document.getElementsByName("temp");
        //var ids = null;  //定义id值的数组
        //if(ids == null) {
        //    ids = new Array(0);
        //}
        //for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
        //    if(aegnt_check[i].checked){
        //        ids.push(aegnt_check[i].value);  //加入选中的checkbox
         //   }
        //}
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		//form.action="<%=request.getContextPath()%>/InsuranceAegntAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
	    var url="<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=find&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 900, 450, "修改保险供应商");  
    }  
    
    function callBack(reg){
        if(reg!=""&&reg!=null){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
    }
    
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		//var aegnt_check = document.getElementsByName("temp");
        //var ids = null;  //定义id值的数组
        //if(ids == null) {
         //   ids = new Array(0);
        //}
        //for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
         //   if(aegnt_check[i].checked){
          //      ids.push(aegnt_check[i].value);  //加入选中的checkbox
           // }
        //}
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
		    jQuery.ajax({
            url: '<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=vailAegntByPolicy&ids='+ids,
            type: 'POST',
            dataType: 'html',
            timeout: 10000,
            error: function(){
                alert('Error loading XML document');
                return null;
            },
            success: function(Count){
                if(Count=="0"){
                    //后台取到数据
                    form.action="<%=request.getContextPath()%>/InsuranceAegntAction.do?ids=" + ids;
		            form.cmd.value = "deleteMulti";
		            form.submit();
                }else{
                    $id("datacell1").isModefied = false;
                    alert('供应商下有保单，不能删除！');
                    return null;
                }
            }
        });
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
	    var agent_code=document.form.agent_code.value;   //供应商编号
	    var agent_name=document.form.agent_name.value;   //供应商名称
	    var validity_str=document.form.validity_str.value;   //有效期开始
	    var validity_end=document.form.validity_end.value;   //有效期结束
	    var is_valids=document.form.is_valid;   //是否有效

        form.action="<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=simpleQuery&agent_code="+agent_code+"&agent_name="+agent_name+"&validity_str="+validity_str+"&validity_end="+validity_end+"&is_valid="+is_valid;
        form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
	    //form.action="<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=queryCode";
		//form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/insuranceaegnt/insertInsuranceAegnt.jsp";
		//form.submit();
		var url="<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=queryCode";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 900, 450, "新增保险供应商"); 
	}
	function detail_onClick(){  //实现转到详细页面
		//var aegnt_check = document.getElementsByName("temp");
        //var ids = null;  //定义id值的数组
        //if(ids == null) {
         //   ids = new Array(0);
        //}
        //for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
         //   if(aegnt_check[i].checked){
          //      ids.push(aegnt_check[i].value);  //加入选中的checkbox
           // }
        //}
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 900, 450, "查看保险供应商");  
		//form.action="<%=request.getContextPath()%>/InsuranceAegntAction.do?id=" + ids;
		//form.cmd.value = "detail";
		//form.submit();
	}
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    
    function tolistannex(value,entity,rowNo,cellNo){
        var annex = entity.getProperty("annex");
        if(annex!=null&&annex!=""){
       var url="<venus:base/>/InsuranceAegntAction.do?cmd=downLoad&annex="+annex;
            return "<a href="+url+">查看附件</a>";
        }
    }

    function showListData(){
        var start_date =document.form.validity_str.value;
        var end_date = document.form.validity_end.value;
         if(end_date!=null&&end_date.trim().length!=0){
           var beginTime =start_date.trim();
           var endTime = end_date.trim();
           var beginTimes=beginTime.substring(0,10).split('-');
           var endTimes=endTime.substring(0,10).split('-');
           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
           if(beginTime>endTime){
               alert("有效终止日期小于有效开始日期！");
               return;
           }
       }
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
	            //此id为post_id
	            //myids += entity.getValue("id") + ",";
	            myids.push(entity.getValue("id"));
	        }
	    });
	    return myids;
	}
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="cmd" value="queryAll">
    <input type="hidden" name="backFlag" id="backFlag" value="true"> 
    <div id="right">
		<script language="javascript">
			writeTableTopFesco('保险供应商管理','<%=request.getContextPath()%>/');  //显示本页的页眉
		</script>
    <div class="ringht_s"> 
	<div id="ccChild0" class="search"> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td width="140" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
		</tr>				
		<tr>
		  <td align="right">供应商编号&nbsp;&nbsp;&nbsp;</td>
		  <td align="left">
	       <input type="text" class="text_field" name="agent_code" inputName="供应商编号" maxLength="64"/>
		  </td>
		  <td align="right">供应商名称&nbsp;&nbsp;&nbsp;</td>
          <td align="left">
              <input type="text" class="text_field" name="agent_name" inputName="供应商名称" maxLength="50"/>
          </td>
          <td align="right">有效期&nbsp;&nbsp;&nbsp;</td>
          <td align="left">
              <w:date format="yyyy-MM-dd" id="validity_str" name="validity_str" width="150px"/>&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" id="validity_end" name="validity_end" width="150px"/></td>
              <!-- <input type="text" class="text_field_half_reference_readonly" name="validity_str" id="validity_str" inputName="有效期限开始日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('validity_str','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="validity_end" id="validity_end" inputName="有效期限截止日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('validity_end','<venus:base/>/');"/> -->
          </td>
		</tr>		
		<tr>
			<td align="right">是否有效&nbsp;&nbsp;&nbsp;</td>
			<td align="left">
				<!--<d:radio dictTypeId="TrueOrFalse"  property="is_valid" id="is_valid" value="1"/>
			--><d:select dictTypeId="TrueOrFalse" id="is_valid" property="is_valid" nullLabel="请选择" />
			</td>			
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
			<td align="left"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();">&nbsp;&nbsp;<input name="button_ok" class="icon_1"   type="reset" value='<fmt:message key="reset"/>'></td>
		</tr>
</table>
</div>		
<div id="ccParent1" class="button"> 
    <div class="button_right">
		<!--<ul>
		    <li class="a">   <a  onClick="javascript:detail_onClick();"><fmt:message key="view" /> </a> </li>
			<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
			<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
			<li class="d">   <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
		</ul>
		--><input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="bxgys_view" type="1"/>  onClick="detail_onClick();">
	    <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="bxgys_add" type="1"/>  onClick="toAdd_onClick();">
	    <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="bxgys_xg" type="1"/>  onClick="findCheckbox_onClick();">
	    <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="bxgys_del" type="1"/>  onClick="deleteMulti_onClick();">
    </div>
    <div class="clear"></div>			
</div>
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/InsuranceAegntAction.do?cmd=searchInsuranceAegntData"
        width="98%"
        height="318px"
        xpath="InsuranceAegntVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <!--<r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      -->
      <r:field allowModify="false" fieldName="chk"
            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            sortAt="none" width="30px">
            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
                uncheckedValue="0" />
        </r:field>
      <r:field fieldName="agent_code" label="供应商编号">
      </r:field>
      <r:field fieldName="agent_name" label="供应商名称">
      </r:field>
      <r:field fieldName="agent_address" label="供应商地址">
      </r:field>
      <r:field fieldName="insurance_agent_type" label="供应商类型">
        <d:select dictTypeId="INSURANCE_AGENT_TYPE" name="insurance_agent_type"  property="insurance_agent_type" id="insurance_agent_type"  disabled="true"/>
      </r:field>
      <r:field fieldName="sales_man" label="保险公司业务员">
      </r:field>
      <r:field fieldName="sales_tel" label="业务员电话">
      </r:field>
      <r:field fieldName="opening_bank" label="供应商开户行">
      </r:field>
      <r:field fieldName="account" label="银行账号" >
      </r:field>
      <r:field fieldName="create_user" label="填写人">
      </r:field>
      <r:field fieldName="create_date" label="填写日期" allowModify="false">
        <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="last_update_user" label="最后修改人">
      </r:field>
      <r:field fieldName="last_update_date" label="最后修改日期" allowModify="false">
        <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="annex" label="查看附件" onRefreshFunc="tolistannex">
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
	if(request.getAttribute(IInsuranceAegntConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IInsuranceAegntConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
