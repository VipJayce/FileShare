<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.policy.util.IPolicyConstants" %>
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
		//var id_check = document.getElementsByName("temp");
       // var ids = null;  //定义id值的数组
       // if(ids == null) {
       //     ids = new Array(0);
       // }
       // for(var i=0;i<id_check.length;i++){  //循环checkbox组
       //     if(id_check[i].checked){
       //         ids.push(id_check[i].value);  //加入选中的checkbox
        //    }
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
		//form.action="<%=request.getContextPath()%>/PolicyAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
		
		var url="<%=request.getContextPath()%>/PolicyAction.do?cmd=find&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 1000, 400, "修改保单");  
	}  
	 
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
	    //var id_check = document.getElementsByName("temp");
       // var ids = null;  //定义id值的数组
        //if(ids == null) {
          //  ids = new Array(0);
        //}
       // for(var i=0;i<id_check.length;i++){  //循环checkbox组
        //    if(id_check[i].checked){
         //       ids.push(id_check[i].value);  //加入选中的checkbox
          //  }
       // }
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            jQuery.ajax({
	            url: '<%=request.getContextPath()%>/PolicyAction.do?cmd=vailPolicyByABI&ids='+ids,
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
	                    form.action="<%=request.getContextPath()%>/PolicyAction.do?ids=" + ids;
			            form.cmd.value = "deleteMulti";
			            form.submit();
	                }else{
	                    $id("datacell1").isModefied = false;
	                    alert('保单下有员工，不能删除！');
	                    return null;
	                }
	            }
	        });
        }
		
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
	    //form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=queryCode";
		//form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/policy/insertPolicy.jsp";
		//form.submit();
		
		var url="<%=request.getContextPath()%>/PolicyAction.do?cmd=queryCode";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 1000, 400, "新增保单");  
	}
	
	 function callBack(reg){
        //if(reg!=""&&reg!=null){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        //}
    }
	/*
	function detail_onClick(){  //实现转到详细页面
	    //var id_check = document.getElementsByName("temp");
        //var ids = null;  //定义id值的数组
        //if(ids == null) {
        //    ids = new Array(0);
        //}
        //for(var i=0;i<id_check.length;i++){  //循环checkbox组
        //    if(id_check[i].checked){
        //        ids.push(id_check[i].value);  //加入选中的checkbox
        //    }
       // }
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
		//form.action="<%=request.getContextPath()%>/PolicyAction.do?id=" + ids;
		//form.cmd.value = "detail";
		//form.submit();
		
		var url="<%=request.getContextPath()%>/PolicyAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 1200, 400, "保单产品-分配客户");  
	}
	*/
	function show_onClick(){  //实现转到详细页面
        //var id_check = document.getElementsByName("temp");
        //var ids = null;  //定义id值的数组
       //if(ids == null) {
         //   ids = new Array(0);
       // }
       // for(var i=0;i<id_check.length;i++){  //循环checkbox组
      //      if(id_check[i].checked){
     //           ids.push(id_check[i].value);  //加入选中的checkbox
      //      }
      //  }
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //form.action="<%=request.getContextPath()%>/PolicyAction.do?id=" + ids;
        //form.cmd.value = "detail";
        //form.submit();
        
        var url="<%=request.getContextPath()%>/PolicyAction.do?cmd=show&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 800, 300, "查看保单");  
    }
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }

    //保險供應商名稱查询条件
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/InsuranceAegntAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         document.form.insurance_agent_name.value=data[2];
         document.form.insurance_agent_id.value=data[0];
    }
    
    function rtnFunc(arg){
	    var lookup = $id("lk_cust");
	    lookup.value = arg[2];
	    lookup.displayValue = arg[2];
	   // jQuery("#insurance_agent_id").val(arg[0]);      
	    //jQuery("#insurance_agent_name").val(arg[2]);       
	    return false;
	}
    
     function showListData(){
        var start_date =document.form.policy_str_date.value;
        var end_date = document.form.policy_end_date.value;
	     if(end_date!=null&&end_date.trim().length!=0){
           var beginTime =start_date.trim();
           var endTime = end_date.trim();
           var beginTimes=beginTime.substring(0,10).split('-');
           var endTimes=endTime.substring(0,10).split('-');
           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
           if(beginTime>endTime){
               alert("保险结束日期小于保险开始日期！");
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
	writeTableTopFesco('保单管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="140" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        </tr>               
        <tr>
          <td align="left">保险公司名称</td>
          <td align="left">
           <!-- <input type="text" class="text_field_reference_readonly" id="insurance_agent_name" name="insurance_agent_name"  validators="isSearch" inputName="保险公司名称" maxLength="64" readonly="readonly" /><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getbyid();"/></td>
           <input type="hidden" name="insurance_agent_id" id="insurance_agent_id"> -->
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" name="insurance_agent_name" id="lk_cust" lookupUrl="/InsuranceAegntAction.do?cmd=queryAllGetByID" dialogTitle="选择保险公司" height="500" width="800"/>
                <!--<input type="hidden" name="insurance_agent_name" id="insurance_agent_name"/>
                <input type="hidden" name="insurance_agent_id" id="insurance_agent_id"/>
          --></td>
          <td align="left">保单编号</td>
          <td align="left">
              <input type="text" class="text_field" name="policy_code" inputName="保单编号" maxLength="64"/>
          </td>
          <td align="left">保单名称</td>
          <td align="left">
              <input type="text" class="text_field" name="policy_name" inputName="保单名称" maxLength="64"/>
          </td>
        </tr>       
        <tr>
            <td align="left">保单类型</td>
            <td align="left">
                <d:select dictTypeId="POLICY_TYPE_BD" id="policy_type" name="policy_type" nullLabel="请选择" />
            </td>
            <td align="left">保险开始日期</td>
            <td align="left">
            <w:date format="yyyy-MM-dd" id="policy_str_date" name="policy_str_date" width="189px"/>
            </td>
            <td align="left">保险结束日期</td>
            <td align="left">
            <w:date format="yyyy-MM-dd" id="policy_end_date" name="policy_end_date" width="189px"/>
            </td>
        </tr>
        <tr>
            <td align="left"></td>
            <td align="left"></td>
            <td align="left"></td>
            <td align="left"></td>
            <td align="right"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();"></td>
            <td align="left">&nbsp;&nbsp;<input name="button_ok" class="icon_1"   type="reset" value='<fmt:message key="reset"/>'></td>
        </tr>
</table>
</div>			
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
				    <li class="a">   <a  onClick="javascript:show_onClick();"><fmt:message key="view" /> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="p_1">      <a  onClick="javascript:detail_onClick();">产品-客户关系管理 </a> </li>
				</ul>
				--><input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="bd_view" type="1"/>  onClick="show_onClick();">
		        <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="bd_add" type="1"/>  onClick="toAdd_onClick();">
		        <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="bd_xg" type="1"/>  onClick="findCheckbox_onClick();">
		        <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="bd_del" type="1"/>  onClick="deleteMulti_onClick();">
		        <!-- <input class="p_1" type="button"   value="产品-客户关系管理"  <au:authorityBtn code="bd_cpCustRel" type="1"/>  onClick="detail_onClick();"> -->
		 </div>
           <div class="clear"></div>			
</div>
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/PolicyAction.do?cmd=searchPolicyAegntData"
        width="98%"
        height="318px"
        xpath="PolicyVo"
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
      <r:field fieldName="insurance_agent_name" label="保险公司名称">
      </r:field>
      <r:field fieldName="policy_code" label="保单编号">
      </r:field>
      <r:field fieldName="policy_name" label="保单名称">
      </r:field>
      <r:field fieldName="policy_type" label="保单类型" allowModify="false">
      <d:select dictTypeId="POLICY_TYPE_BD" />
      </r:field>
      <r:field fieldName="policy_str_date" label="保险开始日期" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="policy_end_date" label="保险结束日期" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="clearing_mode" label="结算方式" allowModify="false" >
      <d:select dictTypeId="CLEARING_MODE_BD" />
      </r:field>
      <r:field fieldName="pay_mode" label="支付方式" allowModify="false">
      <d:select dictTypeId="PAY_MODE_BD" />
      </r:field>
      <r:field fieldName="back_stage" label="追溯期">
      </r:field>
      <r:field fieldName="create_user" label="添加人">
      </r:field>
      <r:field fieldName="create_date" label="添加日期" allowModify="false">
        <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="last_update_user" label="修改人">
      </r:field>
      <r:field fieldName="last_update_date" label="修改日期" allowModify="false">
        <w:date format="YYYY-DD-MM"/>
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
	if(request.getAttribute(IPolicyConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPolicyConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
