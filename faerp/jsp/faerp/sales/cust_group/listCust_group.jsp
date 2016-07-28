<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script language="javascript">
jQuery.noConflict();
</script>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>cust_group</title>

<script type="text/javascript">

 function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").addParam("cust_group",$id("cust_group").value);
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function toAdd_onClick(){
        var url = "<%=request.getContextPath()%>/jsp/faerp/sales/cust_group/insertCust_group.jsp?_ts="+(new Date()).getTime();
        window.open(url,'','height=230px,width=550px,top =200,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增客户组');
    }
    
    function findCheckbox_onClick(){
        var ids = findSelections("checkbox1","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('请选择一条记录!');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('只能选择一条记录!');
            return;
        }
        var url = "<%=request.getContextPath()%>/Cust_groupAction.do?cmd=find&id=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=230px,width=550px,top =200,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改客户组名称');
    }
    
    
    
     function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox1","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('请选择一条记录');
            return;
        }
        if(confirm('确认要删除？')) {  //如果用户在确认对话框按"确定"、
                var url = "<%=request.getContextPath()%>/Cust_groupAction.do?cmd=deleteMulti&ids=" + ids;
                jQuery.ajax({
                    url: url,
                    type: 'post',
                    dataType: 'html',
                    async: false,
                    timeout: 80000,
                    error: function() {
                        alert('Error loading XML document');
                        return null;
                    },
                    success: function(text) {
                        if(text == 0){
                            alert("删除失败！");
                        }else{
                            alert("删除成功！");
                        }
                        simpleQuery_onClick();
                    }
                });
            }
    }
    
    
    
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
    
    
      function setCheckboxStatus(value,entity,rowNo,cellNo){
       var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck(" + rowNo + ",this);'  name='checkbox1' id='checkboxId' value='" + entity.getProperty("id") + "' />";
       return returnStr;
    }
    
    
     function checkAllList(all){// 全选
        if(all.checked){
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
                    element[i].checked= true;
                }
            } 
        }else{
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
                    element[i].checked= false;
                }
            } 
        }
    }
    

</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid"  action="<%=request.getContextPath()%>/Cust_groupAction.do?">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('客户组','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
           </tr>
            <tr>
            <td align="right">客户组名称&nbsp;&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" id="cust_group" name="cust_group" value="" inputName="客户组名称" maxLength="100"  />
            </td>
            <td align="left">
            <input name="button_ok" class="icon_1"   type="button" value="查询"  onClick="javascript:simpleQuery_onClick()">         
            <input type="reset" class="icon_1"  />
            </td>          
        </tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();">新增 </a></li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();">修改 </a> </li>
					<li class="d">     <a  onClick="javascript:deleteMulti_onClick();">删除</a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell id="datacell1"
		queryAction="/FAERP/Cust_groupAction.do?cmd=simpleQuery" width="98%"
		height="303px" xpath="Cust_groupVo"
		paramFormId="datacell_formid" readonly="true" pageSize="50" >
		<r:toolbar location="bottom" tools="nav,pagesize,info"/>
		 <r:field allowModify="false" fieldName="id" sortAt="none"
		 label="操作" width="45px" onRefreshFunc="setCheckboxStatus">
       </r:field>
		<r:field  label="客户组名称" fieldName="cust_group_name" width="200px" ></r:field>
		<r:field  label="客户组code" fieldName="cust_group_code"></r:field>
		<r:field  label="创建人"         fieldName="create_user"></r:field>
		<r:field  label="创建时间"       fieldName="create_date" width="170px"></r:field>
		<r:field  label="最后修改人"         fieldName="last_update_user"></r:field>
		<r:field  label="最后修改时间"         fieldName="last_update_date" width="170px"></r:field>
	</r:datacell>
</div>  
 
 

</div>
</div>
</form>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	//初始化不加载页面信息


jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>

</body>
</html>
