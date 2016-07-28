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
           var ids=document.getElementById("projectbookid").value;
         if(ids == null||ids=="") {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
		form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}
	function biangengCheckbox_onClick(){
	           var ids=document.getElementById("projectbookid").value;
         if(ids == null||ids=="") {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?id=" + ids;
        form.cmd.value = "findbiangeng";
        form.submit();
	}
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids =document.getElementById("projectbookid").value; //取得多选框的选择项
		if(ids == null||ids=="")	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
		var url="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=deleteProjectbook&id=" + ids;
	       jQuery.post(url,function(data){
	
	       if(data){
	       if(data==-1){
	           alert("该项目书下有委派单，不能删除");
	       }else{
	          if(data!=0){
	            alert("删除成功");
                $id("datacell1").loadData();
                $id("datacell1").refresh();
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
	function simpleQuery_onClick(){  //简单的模糊查询
	$id("datacell1").loadData();
    $id("datacell1").refresh();
  
  	}
	function toAdd_onClick() {  //到增加记录页面
	
		form.action="<%=request.getContextPath()%>/jsp/faerp/agent/agentprojectbook/insertAgentprojectbook1.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids =document.getElementById("projectbookid").value;
		if(ids == null||ids=="") {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
	
		form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
	        function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
 

         function ClickRow(value){
            $id("projectbookid").value = value;  
            
        }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="projectbookid" name="projectbookid" value="">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('项目书管理','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="left">项目书名称</td>
			<td align="left">
				<input type="text" class="text_field" name="projectbook_name" inputName="projectbook_name" maxLength="50"/>
			</td>
		      <td align="left">项目书编号</td>
            <td align="left">
                <input type="text" class="text_field" name="projectbook_code" inputName="projectbook_code" maxLength="50"/>
            </td>
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
                     
		</tr>
		
	
		<tr>
			<td align="left">受托单位</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_receive_customer" inputName="受托单位" maxLength="25"/>
			</td>
			 <td align="left">委派单</td>
            <td align="left">
                <input type="text" class="text_field" name="send_name" inputName="委派单" maxLength="25"/>
            </td>
			     <td align="left">客户</td>
            <td align="left">
                <input type="text" class="text_field" name="customer_name" inputName="客户" maxLength="20"/>
            </td>
		
		<tr>
	
			<td align="left">服务开始时间</td>
			 <td align="left">
                    <w:date allowInput="true" id="start_date" name="start_date" format="yyyy-MM-dd"  width="180px"/>  
            </td>
		  <td colspan="4" align="center">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
		</tr>	
</table>
</div>			
<div id="ccParent1" class="button"> 
 <div class="button_right">
			<!--  <ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="b">     <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					
				</ul>-->    
			 <input class="a" type="button"   value="查看"   onClick="detail_onClick();">
               <input class="c" type="button"   value="新增"   onClick="toAdd_onClick();">
             <input class="b" type="button"   value="修改"    onClick="findCheckbox_onClick();">
                 <input class="b" type="button"   value="变更"   onClick="biangengCheckbox_onClick();">
            <input class="d" type="button"   value="删除"  onClick="deleteMulti_onClick();">
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/AgentprojectbookAction.do?cmd=queryProjectbookData" width="98%" height="318px" xpath="AgentprojectbookVo" paramFormId="datacell_formid" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="emp" label="操作" width="50px"
            onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>
 <r:field fieldName="city_id" label="城市" width="80px"> <r:comboSelect id="cityList"  name="cityList"
                     queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px" nullText=""/></r:field>
  <r:field fieldName="projectbook_name" label="项目书名称" width="250px"> </r:field>
 <r:field fieldName="projectbook_code" label="项目书编号" width="120px"></r:field>
   <r:field fieldName="start_date" label="服务开始时间" width="110px"  ><w:date format="yyyy-MM-dd"/> </r:field>
   <r:field fieldName="end_date" label="服务结束时间" width="110px"  ><w:date format="yyyy-MM-dd"/> </r:field>
 <r:field fieldName="cust_send_customer" label="委托单位" width="250px"></r:field>
  <r:field fieldName="cust_receive_customer" label="受托单位" width="250px"></r:field>
<r:field fieldName="cust_name" label="客户名称" width="250px"></r:field>
<r:field fieldName="send_name" label="委派单名称" width="250px"></r:field>
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
   
        $id("datacell1").afterRefresh=function(){
        if($id("projectbookid").value!=null||$id("projectbookid").value!=""){
         $id("projectbookid").value="";
         }
        }
</script>
