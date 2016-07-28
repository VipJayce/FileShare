<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@page import="java.util.Map" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<% 
Map<String, String> map = (java.util.Map) request.getAttribute("lockItemList");
if(map != null) {  
  //out.println(map);
}
%>

<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";

function altRows(id){
    if(document.getElementsByTagName){  
        
        var table = document.getElementById(id);  
        var rows = table.getElementsByTagName("tr"); 
         
        for(i = 0; i < rows.length; i++){          
            if(i % 2 == 0){
                rows[i].className = "evenrowcolor";
            }else{
                rows[i].className = "oddrowcolor";
            }      
        }
    }
}

window.onload=function(){
    altRows('alternatecolor');
}

function selectIds() {
    var myids = new Array(0);
    var dc = $id("dcListIncoming");
    var ds = dc.dataset;
     _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
        var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
        var entity = dc.getEntity(row);
        //此id为post_id
         //myids += entity.getValue("id") + ",";
        myids.push(entity.getValue("id"));
        }
       });
    return myids;
}


</script>
<style type="text/css">
table.altrowstable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#333333;
    border-width: 1px;
    border-color: #a9c6c9;
    border-collapse: collapse;
}
table.altrowstable th {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
table.altrowstable td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
.oddrowcolor{
    background-color:#d4e3e5;
}
.evenrowcolor{
    background-color:#c3dde0;
}
</style>
<html>
<fmt:bundle basename="rayoo.finance.receivable.finclaim.finclaim_resource" prefix="rayoo.finance.receivable.finclaim.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>  
</head>
<body>

<form name="form" method="post"  id="datacell_formid">
<div id="right">
<script language="javascript">
    if (${ver != null && ver != ""}) {
        writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
    } else {
    }
    
</script>
<div id="right">
    <script language="javascript">
        //writeTableTopFesco('预收查询','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">

<div id="ccParent1" class="button"> 
          <div class="clear"></div>         
</div>
    <div style="padding: 8 0 8 8;">

    <table class="altrowstable" id="alternatecolor">
            <tr>
                <th width="200">到款编号</th>
                <th width="250">当前操作人</th>
                <th width="250">操作时间</th>
            </tr>
        <tbody>
                <% 
                for (Object obj : map.keySet()) {
                    String key = obj.toString();
                    String value = map.get(obj);
                    String[] s = value.split(";");
                    String name = s[0];
                    String time = s[1];
                %>
                <tr>
                    <td ><%=key %></td>
                    <td ><%=name%></td>
                    <td ><%=time%></td>
                </tr>
                <% 
                }
                %>
        </tbody>
    </table>
    
<!--  
    <r:datacell id="datacell1"
            queryAction="/FAERP/FinverifcationAction.do?cmd=queryAll1" 
            isCount="false"
            width="99%" 
            xpath="FinverifcationVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="320px">
            
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field allowModify="false" fieldName="chk"
                label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
                sortAt="none" width="50px">
                <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
        </r:field>
            <r:field fieldName="cust_code" width="350px" messagekey="lock_inc_code"/>
            <r:field fieldName="cust_name" width="450px" messagekey="lock_oper_name"/>
        </r:datacell>
        -->
        </div>

</div>
</div></div>
</form>

<c:if test="${ver != null && ver != '' }">
    <div class="foot_button">
        <input type="button" onclick="closewin();" value="<fmt:message key='button_close'/>" class="foot_icon_1">
    </div>
</c:if>

</body>
</fmt:bundle>
</html>

<script>

function selectEntity() {
    var dc = $id("datacell1");
    var entity = dc.getActiveEntity();
    return entity;
}

</script>
