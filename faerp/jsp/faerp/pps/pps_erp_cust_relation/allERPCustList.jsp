<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
function setCheckbox(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'  value=" + entity.getProperty("id") + " />";
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

    function returnvalue() {  //从多选框到修改页面
       var ids=checkselectitem();
      
        if(ids.length == 0){
        	alert("请至少选择一条记录!");
        	return;
        }
        window.returnValue=ids;
        window.close();
    }
    function simpleQuery_onClick(){
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
 function checkAllList() {
        var element = document.getElementsByName("temp"); 
        for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="temp") {
             element[i].checked= !element[i].checked ? true : false;
            }
         } 
      }
</script>
</head>
<body>
<form name="form" method="post"  id="datacell_formid">
<div id="right">
<div class="ringht_s">
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
            <td width="140" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        </tr>
        <tr>
          <td align="right">客户名称</td>
          <td align="left">
            <input type="text" name="customer_name"  inputName="产品名称" maxLength="50" width="100px"/>
          </td>
          <td align="right">客户编号</td>
          <td align="left">
            <input type="text" name="customer_code"  inputName="产品名称" maxLength="50" width="100px"/>
          </td>
        </tr>
        <tr>
          <td align="right">&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td align="right">&nbsp;</td>
          <td align="left">
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset2" class="icon_1" type="reset" value='<fmt:message key="reset"/>'>
           </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
    <div class="button_right">
         <ul>
            <li class="g">     <a  onClick="javascript:returnvalue();"><fmt:message key="choice"/> </a> </li>
         </ul>
    </div>
</div>

<r:datacell id="datacell1"
            queryAction="/FAERP/Pps_erp_cust_relationAction.do?cmd=queryAllERPCust&pps_cust_mapping_id=${param.pps_cust_mapping_id }" 
            isCount="false"
            width="100%" 
            xpath="CustomerVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="305px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field allowModify="false" fieldName="id" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList();' />" width="50px" onRefreshFunc="setCheckbox" >
                           </r:field>  
            <r:field fieldName="customer_name" width="280px" label="客户名称" >
            </r:field>
              <r:field fieldName="customer_code" width="230px" label="客户编号" >
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
