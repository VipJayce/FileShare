<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.u8_customer.util.IU8_customerConstants" %>
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
   function detail_onClick(){  //实现转到详细页面
            dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }

             var url="<%=request.getContextPath()%>/U8_customerAction.do?cmd=detail&id="+clz.getValue("id"); 
             url=url+'&_ts='+(new Date()).getTime(); 
             showModalCenter(url, window, "", 800, 360, "查看详细");  
}
 function toAdd_onClick() {  //到增加记录页面
     var url="<%=request.getContextPath()%>/U8_customerAction.do?cmd=toInsert";
             url=url+'&_ts='+(new Date()).getTime(); 
             showModalCenter(url, window,callBack, 800, 340, "增加页面");       
    }
    
     function callBack(reg){ 
            $id("datacell1").loadData();  
            $id("datacell1").refresh();
    }
    function findCheckbox_onClick() {  //到修改页面
      dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }
        var url="<%=request.getContextPath()%>/U8_customerAction.do?cmd=find&id=" + clz.getValue("id");
             url=url+'&_ts='+(new Date()).getTime(); 
             showModalCenter(url, window, callBack, 800, 340, "修改页面");  
}
   
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
         dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("请先选择一条记录");
                return ;
            }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/U8_customerAction.do?ids=" +clz.getValue("id");
            form.cmd.value = "deleteMulti";
             
            form.submit();
           
        }
    }

    function simpleQuery_onClick(){
    $id("datacell1").loadData();
    $id("datacell1").refresh();
    }
</script>
</head>
<body>

<form name="form" method="post"  id="U8_customerFormId">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">

<div id="right">
<script language="javascript">
	writeTableTopFesco('U8客户管理','<%=request.getContextPath()%>/');  //显示本页的页眉
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
			<td align="right">客户编码</td>
			<td align="left">
				<input type="text" class="text_field" name="ccuscode" inputName="客户编码" maxLength="25"/>
			</td>
		<td align="right">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" name="ccusname" inputName="客户名称" maxLength="100"/>
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
				<ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="b">     <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
			
					
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/U8_customerAction.do?cmd=getU8CustomerList"  width="98%"                                                                     
        height="320px"
        xpath="U8_customerVo"
        paramFormId="U8_customerFormId"
        readonly="true" >
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>

 <r:field fieldName="ccusname" label="客户名称" width="250px" ></r:field>    
 <r:field fieldName="ccuscode" label="客户编码" width="110px"></r:field>

<r:field fieldName="cdccode" label="地区编码" width="110px"></r:field>
 <r:field fieldName="ccccode" label="客户类别"  width="110px">
    <d:select dictTypeId="CUSTOMER_TYPE"></d:select>
 </r:field>
 <r:field fieldName="ctrade" label="行业类别"  width="110px">
 </r:field>
 <r:field fieldName="ccusperson" label="联系人" width="110px"></r:field>
 <r:field fieldName="ccusphone" label="联系电话" width="110px"></r:field>
 <r:field fieldName="ccusaddress" label="地址" width="250px"></r:field>
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


