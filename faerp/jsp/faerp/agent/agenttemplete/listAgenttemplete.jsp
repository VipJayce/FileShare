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
   
	function findCheckbox_onClick() {  //从多选框到修改页面
	      var ids = document.form.templeteid.value;
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
		var url="<%=request.getContextPath()%>/AgenttempleteAction.do?cmd=find&id=" + ids;
		         window.open(url,'','height=430px,width=700px,top =100,left=300,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=项目书模板修改');
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
  var ids = document.form.templeteid.value;
	   if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
		var url="<%=request.getContextPath()%>/AgenttempleteAction.do?cmd=deleteMulti&ids="+ ids;
	   jQuery.post(url,function(data){
	     if(data){
	     if(data==-1){
	     alert("该模板被项目书引用，不能删除");
	     }else{
	         if(data==0){
	             alert("删除失败");
	               
	         }else{
	             alert("删除成功");
	               simpleQuery_onClick();
	         }
	         }
	     
	     }else{
	                alert("删除失败");            
	     }
	   
	   })
	  
		}
	}
    function simpleQuery_onClick(){  //查询所有记录
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
	function toAdd_onClick() {  //到增加记录页面
		var url="<%=request.getContextPath()%>/jsp/faerp/agent/agenttemplete/insertAgenttemplete.jsp";      
         window.open(url,'','height=430px,width=700px,top =100,left=300,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=项目书模板增加');
	}
	function detail_onClick(){  //实现转到详细页面
	  var ids = document.form.templeteid.value;
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
        var url="<%=request.getContextPath()%>/AgenttempleteAction.do?&cmd=detail&id=" + ids;
		    window.open(url,'','height=430px,width=900px,top =100,left=300,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=项目书模板查看');
	}
        function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
     function ClickRow(value){
            $id("templeteid").value = value;    
        }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="templeteid" id="templeteid" value="">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('项目书模板维护','<%=request.getContextPath()%>/');  //显示本页的页眉
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
				  <td align="left">城市</td>
            <td align="left">
                 <r:comboSelect id="city_id1" name="city_id1"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择"  />
            </td>
			<td align="left">模板名称</td>
			<td align="left">
				<input type="text" class="templete_name1" name="templete_name1" inputName="模板名称" maxLength="100"/>
			</td>
		
         <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
			
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
			<!--  	<ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					   <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
				
				</ul>-->
				       <input class="a" type="button"   value="查看"    onClick="detail_onClick();">
            <input class="c" type="button"   value="新增"   onClick="toAdd_onClick();">
             <input class="b" type="button"   value="修改"    onClick="findCheckbox_onClick();">
            <input class="d" type="button"   value="删除"   onClick="deleteMulti_onClick();">
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/AgenttempleteAction.do?cmd=queryTempleteData" width="98%" height="318px" xpath="AgenttempleteVo" paramFormId="datacell_formid" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="emp" label="操作" width="35px"
            onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>
        <r:field fieldName="city_id" label="城市">
      <r:comboSelect id="countryList"  name="countryList"
                     queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px" nullText=""/>
 </r:field>
 <r:field fieldName="templete_name" label="服务条款模板名称" width="150px"></r:field>
 
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
<script language="javascript">
   
        $id("datacell1").afterRefresh=function(){
        if($id("templeteid").value!=null||$id("templeteid").value!=""){
         $id("templeteid").value="";
         }
        }
</script>
