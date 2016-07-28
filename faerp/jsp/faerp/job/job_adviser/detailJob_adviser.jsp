<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@page import="rayoo.job.job_adviser.vo.JobPositionVo"%>
<%@page import="gap.authority.helper.LoginHelper"%>


<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<%
JobPositionVo vo = (JobPositionVo)request.getAttribute("bean");
String position_id = vo.getId();
String state = request.getAttribute("state")==null?"":request.getAttribute("state").toString();
String user_id =  LoginHelper.getPartyId(request);
%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看招聘顾问</title>
<script language="javascript">

//每行数据第一列生成复选框
function generetCheckbox(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  >";
}

function add_click(){
 var url = "<%=request.getContextPath()%>/Job_adviserAction.do?cmd=addAdviser&user_id=<%=user_id%>&position_id=<%=position_id%>";
 url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
var dc1 = $id("datacell1");
showModalCenter(url,dc1,null,750,450,"增加顾问");
}

//删除顾问
function delete_adviser(){  
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null || ids==""){
            alert("请选择要删除的行！");
            return;
        }
        
        var confirm = window.confirm("确定要删除选中行吗？");
        if(confirm){
            _jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/Job_adviserAction.do?cmd=deleteAdviser&ids=" + ids,
            dataType : "html",
            success : function(data) {
                   if(!data){
                        //alert("撤户成功！");
                        $id("datacell1").reload();
                        $id("datacell1").refresh();
                   }else{
                        alert("删除失败！");
                   }
              }
            });
        }
    }
   
   
   //删除当前行
   function del_row(){
        //if(window.confirm("确定删除当前行吗？")){
            $id("datacell1").deleteRow();
        //}
   }
   
   //datacell提交
   function toSave_onClick() {
           if($id("datacell1").isModefied){
                $id("datacell1").addParam("cust_id","<%=vo.getCust_id()%>");
                $id("datacell1").addParam("contract_id","<%=vo.getContract_id()%>");
	            $id("datacell1").submit();
	            alert("保存成功！");
            }else{
                alert("数据未修改！");
            }
    }  
   
   //取消保存
   function cancel(){
    var isModefied = $id("datacell1").isModefied;
        if(isModefied){
            if(!window.confirm("还有尚未保存的数据，是否确认放弃？"))
                return ;
        }
    $id("datacell1").reload();
    $id("datacell1").refresh();
   }
   
    //变更顾问状态(暂停/启用)
    function changeStatus(status){  
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert("请选择要修改的行！");
            return;
        }
            _jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/Job_adviserAction.do?cmd=updateAdviserStatus&ids=" + ids+"&status="+status,
            dataType : "html",
            success : function(data) {
                   if(!data){
                        //alert("撤户成功！");
                        $id("datacell1").reload();
                        $id("datacell1").refresh();
                   }else{
                        alert("更新失败！");
                   }
              }
            });
    }
   
    function winclose(){
        var isModefied = $id("datacell1").isModefied;
        if(isModefied){
            if(!window.confirm("还有尚未保存的数据，是否确认放弃？"))
                return ;
        }
        window.close();
    }
    
</script>
</head>
<body>
 
<form name="form" method="post">
       <div id="right">
		<div class="right_title_bg">
	   <div class=" right_title">	<fmt:message key="detail_page"/>
	   </div>
	 </div>
    <div class="ringht_s">

<div id="ccChild0" class="box_3"> 
<div class="xz_title">招聘订单信息</div>
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >订单编号</td>
			<td class="td_2" >
			<input type="hidden" id="id" value="<%=vo.getId() %>"/>
			<input type="hidden" id="order_id" value="<%=vo.getOrder_id() %>"/>
			<input type="text" value="<%=vo.getOrder_code() %>" class="text_field" id="order_code" readonly="readonly"/>
			</td>
			<td class="td_1" >订单名称</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getOrder_name() %>" class="text_field" id="order_name" readonly="readonly" />
            </td>
		</tr>
		<tr>
			<td class="td_1" >关联合同</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getContract_name() %>" class="text_field" id="contract_name" readonly="readonly"/>
            </td>
            <td class="td_1" >客户名称</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getCustomer_name() %>" class="text_field" id="customer_name" readonly="readonly" />
            </td>
		</tr>
		<tr>
			<td class="td_1" >担保期</td>
			<td class="td_2" >
			<input type="text" value="<%=vo.getWarranty()==null?"":vo.getWarranty() %>" class="text_field" id="warranty" readonly="readonly"/>
			</td>
			<td class="td_1" >订单状态</td>
            <td class="td_2" >
           <%=RmJspHelper.getSelectField("order_status",-1,"ORDER_STATUS_BD",vo.getOrder_status()," disabled='disabled' ",false) %>
            </td>
		</tr>
		<tr>
			<td class="td_1" >招聘职位</td>
			<td class="td_2" >
			<input type="text" value="<%=vo.getPosition()  == null ? "" : vo.getPosition()%>" class="text_field" id="position" readonly="readonly"/>
			</td>
			<td class="td_1" >招聘地区</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getArea() == null ? "" : vo.getArea() %>" class="text_field" id="area" readonly="readonly"/>
            </td>
		</tr>
	</table>
</div>

 <div class="xz_title">招聘顾问信息</div>
<%if("modify".equals(state)){ %>
 <div class="button_right">
        <ul>
            <li class="c"><a onClick="javascript:add_click();">增行</a></li>
            <!-- <li class="d"><a onClick="javascript:del_row();">删行</a></li> -->
            <!-- <li class="b"><a onClick="javascript:changeStatus('1');">启用</a></li>
            <li class="b"><a onClick="javascript:changeStatus('2');">暂停</a></li> -->
             <li class="bc"><a onClick="javascript:toSave_onClick();">保存</a></li>
             <li class="m"><a onClick="javascript:cancel();">取消</a></li> 
        </ul>
</div>
<%} %>
 <div class="clear"></div>
<div class="box_bjd" id="values_div">
<%if("modify".equals(state)){ %>
 <r:datacell id="datacell1" 
 queryAction="/FAERP/Job_adviserAction.do?cmd=getAdviserByPositionID&position_id=${param.id} "
 submitAction="/FAERP/Job_adviserAction.do?cmd=insertAndUpdateAndDel&position_id=${param.id} "
 submitXpath="Job_adviserVo" xpath="Job_adviserVo"
 width="98%" height="318px" >
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <!--<r:field fieldName="id" label="操作" width="50px" onRefreshFunc="generetCheckbox"  align="center" ></r:field>-->
 <r:field fieldName="user_name" label="顾问姓名" width="150px">
    <h:hidden id="adviser_id" name="adviser_id" property="adviser_id"/>
    <h:hidden id="position_id" name="position_id" property="position_id"/>
 </r:field>
 <r:field fieldName="dept_name" label="所属部门" width="150px"></r:field>
 <r:field fieldName="email" label="顾问Email" allowModify="false" width="240px"></r:field>
 <r:field fieldName="status" label="顾问状态" allowModify="true"  width="100px" >
    <d:select dictTypeId="ADVISER_STATUS_BD"></d:select>
 </r:field>
 </r:datacell>  
 <%} else{%>
 <r:datacell id="datacell1" 
 queryAction="/FAERP/Job_adviserAction.do?cmd=getAdviserByPositionID&position_id=${param.id} "
 submitAction="/FAERP/Job_adviserAction.do?cmd=insertAndUpdateAndDel&position_id=${param.id} "
 submitXpath="Job_adviserVo" xpath="Job_adviserVo"
 width="98%" height="318px" >
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <!--<r:field fieldName="id" label="操作" width="50px" onRefreshFunc="generetCheckbox"  align="center" ></r:field>-->
 <r:field fieldName="user_name" label="顾问姓名" width="150px">
    <h:hidden id="adviser_id" name="adviser_id" property="adviser_id"/>
    <h:hidden id="position_id" name="position_id" property="position_id"/>
 </r:field>
 <r:field fieldName="dept_name" label="所属部门" width="150px"></r:field>
 <r:field fieldName="email" label="顾问Email" allowModify="false" width="240px"></r:field>
 <r:field fieldName="status" label="顾问状态"  allowModify="false" width="100px" >
    <d:select dictTypeId="ADVISER_STATUS_BD"></d:select>
 </r:field>
 </r:datacell>  
 <% }%>
 </div>


  	
<div class="foot_button">
<%if("modify".equals(state)){ %>
<!--  <input type="button" class="icon_2" value='保存' onClick="javascript:window.close()"/>-->
<%} %>
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:winclose();" />
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
