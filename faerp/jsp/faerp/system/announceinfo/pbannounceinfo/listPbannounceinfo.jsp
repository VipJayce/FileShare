<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<script language="javascript">
 function setCheckbox(value,entity,rowNo,cellNo){
        return "<input type='checkbox'  name='temp'  value=" + entity.getProperty("id") + " />";
     }
     
function simpleQuery_onClick(){  //简单的模糊查询
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
       }
function checkselectitem()
{
           var aegnt_check = document.getElementsByName("temp");
           
           var ids = null;  //定义id值的数组
           if(ids == null) {
               ids = new Array(0);
           }
           for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
               if(aegnt_check[i].checked){
                   ids.push(aegnt_check[i].value);  //加入选中的checkbox
               }
           }
           return ids;
}
function modify_onClick(){
         var  id = checkselectitem();  //定义id值的数组
            if(id.length<=0)
           {
                alert('不能为空，请选择一条记录！');
                return;
           }
           if(id.length>1)
           {
                alert('只能选择一条记录！');
                return;
           }
          var url="<%=request.getContextPath()%>/jsp/faerp/system/announceinfo/pbannounceinfo/modifyPbannounceinfo.jsp?cid="+id;
          showModalCenter(url, window, refresh,980,400,"修改信息");
}
function refresh(){
        $id("datacell1").loadData();
          $id("datacell1").refresh();}

 function checkAllList() {
        var element = document.getElementsByName("temp"); 
        for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="temp") {
             element[i].checked= !element[i].checked ? true : false;
            }
         } 
      }

//删除多条记录
function deleteMulti_onClick()
    {  
       //从多选框物理删除多条记录
           var aegnt_check = document.getElementsByName("temp");
           var ids = null;  //定义id值的数组
           if(ids == null) {
               ids = new Array(0);
           }
           for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
               if(aegnt_check[i].checked){
                   ids.push(aegnt_check[i].value);  //加入选中的checkbox
               }
           }
           if(ids==null||ids==""){
               alert('<fmt:message key="select_one_record"/>');
               return;
           }
           if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
           var  form=document.getElementById("datacell_formid");
              form.action="<%=request.getContextPath()%>/PbannounceinfoAction.do?ids="+ ids;
               form.cmd.value = "deleteMulti";
               form.submit();
           }
}          

function toAdd_onClick(){
 form.action="<%=request.getContextPath()%>/jsp/faerp/system/announceinfo/pbannounceinfo/announceinfo.jsp";
 form.submit();
}

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="">
<div id="right">
<script language="javascript">
	writeTableTopFesco('信息发布管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<input type="hidden" id="cid" name="cid"/>
			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
		<tr>
		 <td align="right">标题&nbsp</td>
            <td align="left"><input  type="text" name="announce_title1" id="announce_title1"  />
		<td align="right">发布日期&nbsp</td>
       <td align="left"><w:date allowInput="false" id="send_date1"
                    name="send_date1" format="yyyy-MM-dd" style="width:142px;" /> </td>
			<td/>
			<td/>
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	<td/>
		</tr>
</table>
</div>

 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
				    <li class="g_1">      <a onClick="javascript:toAdd_onClick();">发布信息 </a></li>  
					<li class="b">    	<a  onClick="javascript:modify_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 <r:datacell id="datacell1"
            queryAction="/FAERP/PbannounceinfoAction.do?cmd=queryAll1" 
            isCount="false"
            width="100%" 
            xpath="PbannounceinfoVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="320px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList();' />" width="50px" onRefreshFunc="setCheckbox" >
                           </r:field>  
            <r:field fieldName="announce_title" width="700px" label="发布题目" >
            </r:field>
            <r:field fieldName="announce_type" width="170px" label="发布类型">
            <d:select  dictTypeId="ANNOUNCE_TYPE" id="announce_type" name="announce_type" />
            </r:field>
            <r:field fieldName="send_date" width="250px" label="发布日期" allowModify="false" >
                   <w:date format="yyyy-MM-dd" />
            </r:field>
        </r:datacell>

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
