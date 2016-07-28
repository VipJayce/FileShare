<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.elfhand.util.IElfhandConstants" %>
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
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
	    var url="<%=request.getContextPath()%>/ElfhandAction.do?cmd=find1&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 650, 260, "修改单立户、大库");  
    }  
    
    function callBack(reg){
        if(reg!=""&&reg!=null){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
    }
    
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
		    form.action="<%=request.getContextPath()%>/ElfhandAction.do?cmd=batchDeleteMulti1&ids=" + ids;
            form.submit();
		}
	}
	
	function toAdd_onClick() {  //到增加记录页面
		var url="<%=request.getContextPath()%>/jsp/faerp/elfhand/singletatsudo/insertSingletatsudo.jsp";
        showModalCenter(url, window, callBack, 650, 260, "新增单立户、大库"); 
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
        var url="<%=request.getContextPath()%>/ElfhandAction.do?cmd=detail1&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 650, 260, "查看单立户、大库");  
	}
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    
    function showListData(){
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
    <div id="right">
		<!-- <script language="javascript">
			writeTableTopFesco('单立户、大库','<%=request.getContextPath()%>/');  //显示本页的页眉
		</script> -->
    	<div class="ringht_s"> 
			<div id="ccChild0" class="search"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
					  <td width="140" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
					</tr>				
					<tr>
					  <td align="right">客户名称&nbsp;&nbsp;&nbsp;</td>
					  <td align="left">
				       <input type="text" class="text_field" name="name" inputName="客户名称" maxLength="64"/>
					  </td>
					  <td align="right">客户编号&nbsp;&nbsp;&nbsp;</td>
			          <td align="left">
			              <input type="text" class="text_field" name="customerCode" inputName="客户编号" maxLength="50"/>
			          </td>
			          <td align="right"></td>
						<td align="left"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();">&nbsp;&nbsp;<input name="button_ok" class="icon_1"   type="reset" value='<fmt:message key="reset"/>'></td>
					</tr>		
				</table>
			</div>		
			<div id="ccParent1" class="button"> 
			    <div class="button_right">
					<input class="a" type="button" value="<fmt:message key="view"/>" onClick="detail_onClick();">
				    <input class="c" type="button" value="<fmt:message key="insert"/>" onClick="toAdd_onClick();">
				    <input class="b" type="button" value="<fmt:message key="modify"/>" onClick="findCheckbox_onClick();">
				    <input class="d" type="button" value="<fmt:message key="delete"/>" onClick="deleteMulti_onClick();">
			    </div>
			    <div class="clear"></div>			
			</div>
		 	<div style="padding: 8 10 8 8;">
		    	<r:datacell 
		        id="datacell1"
		        queryAction="/FAERP/ElfhandAction.do?cmd=getAll1"
		        width="98%"
		        height="318px"
		        xpath="SingletatsudoVo"
		        paramFormId="datacell_formid"
		        >
		      	<r:toolbar location="bottom" tools="nav,pagesize,info"/>
		      	<r:field allowModify="false" fieldName="chk"
		            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
		            sortAt="none" width="30px">
		            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
		                uncheckedValue="0" />
		        </r:field>
		      	<r:field fieldName="name" label="客户名称" width="350px"></r:field>
		      	<r:field fieldName="customerCode" label="客户编号" width="150px"></r:field>
		      	<r:field fieldName="organization" label="档案代保管地" width="200px"></r:field>
		      	<r:field fieldName="employment" label="外地人用工地"></r:field>
		      	<r:field fieldName="jName" label="组织机构代码" width="130px"></r:field>
		      	<r:field fieldName="jCode" label="网上办事密码" width="130px"></r:field>
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
	if(request.getAttribute(IElfhandConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IElfhandConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
