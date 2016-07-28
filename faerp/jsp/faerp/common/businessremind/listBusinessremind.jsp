<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<%
//从首页跳转过来的标志flag
String flag=request.getParameter("flag")==null?"false":request.getParameter("flag");
String type_re=request.getParameter("type_re")==null?"":request.getParameter("type_re");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + ">";
    }
    
    function findSelections(checkboxName) {  //从列表中找出选中的id值列表
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
    
    //设置为已知道
    function toUpdate_onClick(){
        var idarray = findSelections("checkbox_template");  //取得多选框的选择项
        var ids='';
        if(idarray == null) {  //如果ids为空
            alert('请至少选择一条提醒记录！');
            return;
        }else{
            for(var i=0;i<idarray.length;i++){
                   
                if(i==0){
                    ids=idarray[0];
                }else{
                    ids = ids+','+idarray[i];
                }
            }
               
	       jQuery.ajax({
	           url: '<%=request.getContextPath()%>/BusinessRemindAction.do?cmd=updateKnowed&ids='+ids,
	           type: 'GET',
	           dataType: 'html',
	           timeout: 10000,
	           error: function(){
	               alert('Error loading XML document');
	                   return  null;
	               },
	           success: function(text){
	               if(text==1){       
	                   alert('设置成功！');
	                   simpleQuery_onClick();
	               }else{
	                   alert('没有任何更改！');
	               }
	           }
	       });
	   }
    }
    
    //导出到excel
    function toExport_onClick(){
        form.action="<%=request.getContextPath()%>/BusinessRemindAction.do?backFlag=true";
        form.cmd.value = "exportToExcel";
        form.submit();
       
    }
    
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("business_init").loadData();
        $id("business_init").refresh();
    }
</script>
</head>
<body>
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('业务提醒','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<form name="form" method="post" id="simpleQuery">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="flag" id="flag" value="<%=flag%>">
<input type="hidden" name="type_re" id="type_re" value="<%=type_re%>">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td/>
              <td>    </td>
                <td/>
        </tr>
        <tr>
          <td align="right">员工姓名</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="25"/>
          </td>
           <%if(!flag.equals("true")){ %>
          <td align="right">提醒类别</td>
          <td align="left">
            <d:select name="remind_type" dictTypeId="REMIND_TYPE" nullLabel="---请选择---"/>
          </td>
           <%} %> 
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
                    <li class="o">      <a  onClick="javascript:toUpdate_onClick();">知道了</a> </li>
                    <li class="pl_1">   <a onClick="javascript:toExport_onClick();">导出</a></li>
                    <%if(flag.equals("true")){ %>
                    <li class="m_1"><a href="##" onClick="location.href='javascript:history.go(-1);'">返回首页</a></li>
                    <%} %> 
                    <!--  
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    -->
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
                    <r:datacell 
                         id="business_init"
                         queryAction="/FAERP/BusinessRemindAction.do?cmd=simpleQuery1"
                         width="100%"
                         xpath="BusinessRemindVo"
                         submitXpath="BusinessRemindVo"
                         paramFormId="simpleQuery"
                         height="320px"
                         >
                         <r:toolbar  tools="nav,pagesize,info"/>
                         <r:field  fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus">
                         </r:field>   
                         <r:field fieldName="emp_code" label="唯一号">
                         </r:field>
                         <r:field fieldName="emp_name" label="员工姓名">
                         </r:field>
                         <r:field fieldName="cust_code" label="客户编号">
                         </r:field>
                         <r:field width="200" fieldName="cust_name" label="客户名称">
                         </r:field>
                         <r:field width="150" fieldName="remind_type" label="提醒类型" allowModify="false">
                             <d:select dictTypeId="REMIND_TYPE"/>
                         </r:field>
                         <r:field width="335" fieldName="remind_memo" label="提醒说明">
                         </r:field>
                         <r:field width="130" fieldName="insert_time" label="输入时间" allowModify="false">
                            <w:date format="yyyy-MM-dd hh:mm:ss" name="insert_time"/>
                         </r:field>
                       </r:datacell>

</div>
</div>
</fmt:bundle>
</form>
</body>
</html>

