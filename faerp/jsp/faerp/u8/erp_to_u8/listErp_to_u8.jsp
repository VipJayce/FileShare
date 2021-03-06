<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/common.jsp" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.erp_to_u8.vo.Erp_to_u8Vo" %>
<%@ page import="rayoo.u8.erp_to_u8.util.IErp_to_u8Constants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IErp_to_u8Constants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IErp_to_u8Constants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	Erp_to_u8Vo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ERP与U8用户对照</title>
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
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		var url="<%=request.getContextPath()%>/Erp_to_u8Action.do?cmd=find&id="+ids;
        window.open(url,'','height=400px,width=950px,top =100,left=200,help=no,resizable=yes,scrollbars=no,location=no,status=not,title=修改页面');
	}  
	
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Erp_to_u8Action.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		var url = '<%=request.getContextPath()%>/Erp_to_u8Action.do?cmd=toInsert';
		window.open(url,'','height=400px,width=950px,top =100,left=200,help=no,resizable=yes,scrollbars=no,location=no,status=not,title=新增页面');
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
		form.action="<%=request.getContextPath()%>/Erp_to_u8Action.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
   //-------------------------------
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
	
	
	function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_code").val(arg[0]);       
        return false;
    }
    
    function reset_onClick(){
        jQuery("#cust_code").val("");       
    }
    	
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/Erp_to_u8Action.do">
     <input type="hidden" name="cmd" value="simpleQuery"> 
	 <input type="hidden" name="backFlag" id="backFlag" value="true">
	 <input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<div id="right">
<script language="javascript">
	writeTableTopFesco('ERP与U8用户对照','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s"> 
<div id="ccChild0" class="search"> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div></td>
			<td align="left">ERP用户名称</td>
            <td width="200">
               <input type="text"  class="text_field" name="erp_name" id="erp_name" maxLength="64" >
			</td>
			<td align="left">U8用户名称</td>
			<td width="200">
				<input type="text" class="text_field" name="u8_name" id="u8_name" maxLength="64" >
			</td>
	    </tr>
		<tr>
			<td align="left">生效日期</td>
			<td width="200">
				<w:date  allowInput="true" name="startdate"  id="startdate" format="YYYY-MM-DD"/>
			</td>
			<td align="left">失效日期</td>
			<td width="200">
				<w:date  allowInput="true" name="enddate"  id="enddate" format="YYYY-MM-DD"/>
			</td>	
            <td align="left">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
             </td>
            <td align="left"></td>
		</tr>
	</table>
</div>
					

<div class="button">
            <div class="button_right">
                <ul>
                  <li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message key="insert" /> </a></li>
		          <li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify" /> </a></li>
		          <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete" /> </a></li>                     
                </ul>
            </div>
            <div class="clear"></div>
</div>

<div style="padding: 5 0 8 8;">
       <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/Erp_to_u8Action.do?cmd=simpleQuery"
        width="95%"
        height="318px"
        xpath="Erp_to_u8Vo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>      
            <r:field fieldName="erp_name" label="ERP用户名" width="200px">
            </r:field>
            <r:field fieldName="u8_name" label="U8用户名" width="200px">
            </r:field>              
            <r:field fieldName="startdate" label="生效日期" width="130px">
            	<w:date format="yyyy-MM-dd"/>
            </r:field>        
            <r:field fieldName="enddate" label="失效日期" width="130px">
            	<w:date format="yyyy-MM-dd"/>
            </r:field>      
    </r:datacell>
</div>
</div>
</div>
</form>

</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>

</body>

</html>


<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IErp_to_u8Constants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IErp_to_u8Constants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
