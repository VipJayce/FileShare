<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
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
		var ids = findSelections("temp","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		var url="<%=request.getContextPath()%>/U8SubjectAction.do?cmd=find&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime(); 
        showModalCenter(url, window, simpleQuery_onClick, 600, 200, "修改页面");
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("temp","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	var url="<%=request.getContextPath()%>/U8SubjectAction.do?cmd=deleteMulti&ids=" +ids;
	        jQuery.post(url,function(data){
	         if(data!=0){
	         	alert("删除成功！");
                $id("datacell").loadData();
                $id("datacell").refresh();
	       
	         }else{
                alert("删除失败！");
	                
	         }
	        })
		}
	}
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell").loadData();
        $id("datacell").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		var url="<%=request.getContextPath()%>/jsp/faerp/u8/u8subject/insertU8Subject.jsp";
        url=url+'?_ts='+(new Date()).getTime(); 
        showModalCenter(url, window, simpleQuery_onClick, 600, 200, "增加页面");
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("temp","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		var url="<%=request.getContextPath()%>/U8SubjectAction.do?cmd=detail&id="+ids; 
        url=url+'&_ts='+(new Date()).getTime(); 
        showModalCenter(url, window, "", 600, 200, "查看详细");
	}

	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    
    function checkAll(obj){
        if(obj.checked){
            var elements = document.getElementsByName("temp");
	        for(var i=0;i<elements.length;i++){
	            elements[i].checked = true;
	        }
        }else{
            var elements = document.getElementsByName("temp");
            for(var i=0;i<elements.length;i++){
                elements[i].checked = false;
            }
        }
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
	writeTableTopFesco('U8会计科目管理','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="right">科目编码</td>
			<td align="left">
				<input type="text" class="text_field" name="ccode" inputName="科目编码"/>
			</td>
		    <td align="right">科目名称</td>
			<td align="left">
				<input type="text" class="text_field" name="ccode_name" inputName="科目名称"/>
			</td>
            <td align="right">编码级次</td>
			<td align="left">
				<input type="text" class="text_field" name="igrade_from" inputName="编码级次"/>
			</td>            
		</tr>
        <tr>
            <td align="right">科目性质</td>
			<td align="left">
				<h:select name="bproperty_from">
					<h:option value="" label="--请选择--"></h:option>
			        <h:option value="0" label="借方"></h:option>
			        <h:option value="1" label="贷方"></h:option>
		        </h:select>
			</td>
            <td align="right">&nbsp;</td>
            <td align="left">&nbsp;</td>
            <td align="right"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
            <td align="left">&nbsp;&nbsp;<input name="button_ok" class="icon_1"   type="reset" value='<fmt:message key="reset"/>'></td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
	<div class="button_right">
		 <input class="a" type="button"   value="<fmt:message key="view"/>"  onClick="detail_onClick();">
		 <input class="c" type="button"   value="<fmt:message key="insert"/>" onClick="toAdd_onClick();">
		 <input class="b" type="button"   value="<fmt:message key="modify"/>" onClick="findCheckbox_onClick();">
		 <input class="d" type="button"   value="<fmt:message key="delete"/>" onClick="deleteMulti_onClick();">		
	</div>
    <div class="clear"></div>			
</div>
<div style="padding: 8 10 8 8;">
<r:datacell 
        id="datacell"
        queryAction="/FAERP/U8SubjectAction.do?cmd=simpleQuery"       
        isCount="false"
        width="95%"
        xpath="U8SubjectVo"
        height="320"        
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="操作<input type='checkbox' name='checkall' onclick='checkAll(this);' />" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>
       <r:field fieldName="ccode" width="200px" label="科目编码">
       </r:field> 
       <r:field fieldName="ccode_name" width="400px;" label="科目名称">
       </r:field> 
       <r:field fieldName="igrade" label="编码级次" width="150px;">
       </r:field> 
       <r:field fieldName="bproperty" label="科目性质" width="200px;" allowModify="false">
       	<h:select name="bproperty" property="bproperty">
	        <h:option value="0" label="借方"></h:option>
	        <h:option value="1" label="贷方"></h:option>
        </h:select>
       </r:field> 
    </r:datacell>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
