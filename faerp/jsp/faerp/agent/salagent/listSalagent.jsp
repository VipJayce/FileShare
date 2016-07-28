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
<title>显示供应商</title>
<script language="javascript">

	function findCheckbox_onClick() {  //从多选框到修改页面
		      var ids = document.form.agentId.value;
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }     
		var url="<%=request.getContextPath()%>/SalagentAction.do?cmd=find&id=" +ids;		
		 window.open(url,'','height=425px,width=1140px,top =100,left=180,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=供应商增加');
	}  
	
	function deleteMulti_onClick(){  //删除单条记录
  var ids=document.form.agentId.value;
          if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	var url="<%=request.getContextPath()%>/SalagentAction.do?cmd=deleteMulti&ids=" + ids;
	    	jQuery.post(url,function(data){
	    	   if(data){
	 
	    	   if(data==-1){
	    	    alert("此供应商有委派单不能删除");
	    	 
	    	   }else{
	    	      if(data!=0){
	    	          alert("删除成功");
	    	          simpleQuery_onClick();
	    	      }else{
	    	       alert("删除失败");     
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
	   var url="<%=request.getContextPath()%>/SalagentAction.do?cmd=getAgentCode";
         window.open(url,'','height=425px,width=1140px,top =100,left=180,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=供应商增加');
	}
	function detail_onClick(){  //实现转到详细页面
	  var ids=document.form.agentId.value;   
	      if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
     
	
		 var url="<%=request.getContextPath()%>/SalagentAction.do?cmd=detail&id="+ids;
         window.open(url,'','height=460px,width=1140px,top =100,left=180,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=供应商详细');
	}
	
    function add_service(){
        var ids = document.form.agentId.value;
      var agenttype=document.form.agenttype.value;
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
          var url = "<%=request.getContextPath()%>/SalagentAction.do?cmd=showAddServiceByID&id=" + ids;
          url=url+"&_ts="+(new Date()).getTime();
 window.open(url,'','height=580px,width=1140px,top =50,left=180,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=添加服务产品');
    }
    function add_securityservice(){
           var ids = document.form.agentId.value;
  
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
           var url = "<%=request.getContextPath()%>/SalagentAction.do?cmd=showAddSecurityByID&id=" + ids;
          url=url+"&_ts="+(new Date()).getTime();
    window.open(url,'','height=580px,width=1140px,top =50,left=180,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=添加社保公积金产品');
    }
    function toQiyong_onClick(){
     var ids=document.form.agentId.value;
          if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
        if(confirm('确定要启用此供应商！')) {  //如果用户在确认对话框按"确定"
            var url="<%=request.getContextPath()%>/SalagentAction.do?cmd=isQiyong&id=" + ids;
            jQuery.post(url,function(data){
               if(data){
               if(data==1){
                alert("此供应商已经停用或者不是供应商，不能启用！");      
               }
                 else  if(data==2){
                      alert("此供应商已经启用！");
                     
                  }
                  else if(data==3){
                       alert("此供应商启用成功！");
               }else{
                     alert("启用失败");     
               }
            }else{
               alert("启用失败");     
            }
            })
        }
    
}
    
        function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("agent_type")+"\");>";
    }
     function ClickRow(value,value1){
            $id("agentId").value = value;  
            $id("agenttype").value = $id("agent_type").getDisplayValue(value1);
        }
</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="agentId" name="agentId" value="">
<input type="hidden" id="agenttype" name="agenttype" value="">
<div id="right">
<script language="javascript">
	writeTableTopFesco('供应商的维护','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="left">供应商编号</td>
			<td align="left">	
				<input type="text" class="text_field" name="agent_code" id="agent_code"  inputName="供应商编号" value="" maxlength="50"  >
			</td>
			<td align="left">供应商名称</td>
			<td align="left"><input type="text" class="text_field" name="agent_name" id="agent_name"  inputName="供应商名称" value="" maxlength="100" ></td>	


		</tr>
		<tr>
		  <td align="left">供应商所在地</td>
            <td align="left">   
               <r:comboSelect id="city_id1" name="city_id1"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="205px"
                       nullText="请选择"  />
            </td>
            <td align="left">是否停用</td>
            <td align="left">
            <d:select dictTypeId="TrueOrFalse"  value="0" id="is_del" name="is_del"></d:select>
            </td>
            <td align="left" rowspan="2">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
               
            </td>
            <td> <input type="reset" class="icon_1"  /></td>
		</tr>	
</table>
</div>				
<div id="ccParent1" class="button"> 
 <div class="button_right">
         
		<!--  <ul> 
					<li class="a" style="padding-top: 5px">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c" style="padding-top: 5px">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					
					 <li class="b" style="padding-top: 5px">   <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>     
					<li class="d" style="padding-top: 5px">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					 <li class="q_1" style="padding-top: 5px"><a onClick="javascript:add_service();">添加服务产品 </a></li>
					  <li class="q_1" style="padding-top: 5px"><a onClick="javascript:add_securityservice();">添加社保产品 </a></li>
				</ul>	 -->
				   <input class="a" type="button"   value="查看"   onClick="detail_onClick();">
            <input class="c" type="button"   value="新增"    onClick="toAdd_onClick();">
             <input class="b" type="button"   value="修改"    onClick="findCheckbox_onClick();">
            <input class="d" type="button"   value="删除"    onClick="deleteMulti_onClick();">
               <input class="q_1" type="button"   value="添加服务产品"    onClick="add_service();">
            <input class="q_1" type="button"   value="添加社保产品"    onClick="add_securityservice();">
            <input class="c" type="button"   value="启用"    onClick="toQiyong_onClick();">
           <div class="clear"></div>			
</div>
</div>
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/SalagentAction.do?cmd=queryAgentData" width="99%" height="305px" xpath="SalagentVo" paramFormId="datacell_formid" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="emp" label="操作" width="35px"
            onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>
 <r:field fieldName="agent_code" label="供应商编号" width="75px"></r:field>
  <r:field fieldName="agent_type" label="供应商类别" width="75px"> <d:select dictTypeId="AGENT_TYPE"  id="agent_type" ></d:select></r:field>
 <r:field fieldName="agent_name" label="供应商名称" width="300px"></r:field>
 <r:field fieldName="city_id" label="所在地" width="100px" >
      <r:comboSelect id="countryList"  name="countryList"
                     queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="100px" nullText=""/>
 </r:field>
 <r:field fieldName="contact_address" label="公司地址" width="300px"></r:field>
 <r:field fieldName="cooperation_start_date" label="合作起始年月" width="90px"></r:field>
  <r:field fieldName="is_del" label="是否停用" width="60px" align="center"><d:select dictTypeId="TrueOrFalse" ></d:select>  </r:field>
   <r:field fieldName="create_user_name" label="录入人" width="100px"></r:field>
 </r:datacell>

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
        if($id("agentId").value!=null||$id("agentId").value!=""){
         $id("agentId").value="";
         }
        }
</script>
