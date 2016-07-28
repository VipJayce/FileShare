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
	      var dc=$id("datacell1");
	      var clz=dc.getActiveEntity();

	      if(!clz){
	      alert("请选择一条记录");
	      return;
	      }
	  var url="<%=request.getContextPath()%>/ChangeclassAction.do?cmd=UpdateChangeclassPage&id="+clz.getValue("id");
             showModalCenter(url, window, callBack, 750, 230, "修改页面");    
	}  

 	  function deleteMulti_onClick(){  //从多选框物理删除多条记录
         dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            var url="<%=request.getContextPath()%>/ChangeclassAction.do?cmd=deleteMulti&ids=" +clz.getValue("id");
              jQuery.post(url,function(data){
         if(data!=0){
                alert("删除成功！");
               $id("datacell1").loadData();
              $id("datacell1").refresh();
       
         }else{
               alert("删除失败！");
                
         }
        })
	}
	}
	
	function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell1").loadData();
    $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面

	  var url="<%=request.getContextPath()%>/jsp/faerp/workattendance/changeclass/insertChangeclass.jsp";
             showModalCenter(url, window, callBack, 750, 230, "增加页面");       
	}
	function callBack(reg){ 
            $id("datacell1").loadData();  
            $id("datacell1").refresh();
    }
	

</script>
</head>
<body>

<form name="form" method="post" action="" id="form1">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="" >
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('调班管理','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="right">客户名称</td>
			<td align="left">
				    <w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust"
            lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" style="width:180px"
            dialogTitle="选择客户" height="450" width="610"  /> 
           <input id="cust_id"  name="cust_id" type="hidden" />
			</td>
		  <td align="right">员工姓名</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" id="emp_name" inputName="emp_name" maxLength="100"/>
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
		

        <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="changeclass_add" type="1"/>  onClick="toAdd_onClick();">
        <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="changeclass_xg" type="1"/>  onClick="findCheckbox_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="changeclass_del" type="1"/>  onClick="deleteMulti_onClick();">
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/ChangeclassAction.do?cmd=searchChangeclass"
        width="98%"                                                                     
        height="320px"
        xpath="ChangeclassVo"
        paramFormId="form1"  
        readonly="true" 
       >
         <r:toolbar location="bottom" tools="nav,pagesize,info"/>

        <r:field fieldName="cust_name" label="客户名称" width="250px" ></r:field>     
        <r:field fieldName="emp_name" label="员工姓名" width="110px" ></r:field>
             <r:field fieldName="emp_code" label="员工编号" width="110px" ></r:field>
        <r:field fieldName="changeclassdate" label="调班日期" width="110px"  ><w:date format="yyyy/MM/dd"/> </r:field>
        <r:field fieldName="changeclassenddate" label="调班后日期" width="110px" ><w:date format="yyyy/MM/dd"/></r:field>
        <r:field fieldName="changeclassnote" label="调班说明" width="220px" ></r:field>
        <r:field fieldName="remark" label="备注" width="220px" ></r:field>
 </r:datacell>

 

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
     _$("#cust_id").val(returnValue[0]);
    return false;
}
</script>
</body>
</html>
<script type="text/javascript">
//初始化不加载页面信息<siqp添加>
_$(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
