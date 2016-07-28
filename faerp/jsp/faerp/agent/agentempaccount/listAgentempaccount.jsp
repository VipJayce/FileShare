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
          var ids = document.form.accountid.value;
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
        var url="<%=request.getContextPath()%>/AgentempaccountAction.do?cmd=find&id=" + ids;
              window.open(url,'','height=550px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工账号修改');
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
  var ids = document.form.accountid.value;
       if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
        var url="<%=request.getContextPath()%>/AgentempaccountAction.do?cmd=deleteMulti&id="+ ids;
       jQuery.post(url,function(data){
         if(data){
      
             if(data>0){
                
                 alert("删除成功");
                   simpleQuery_onClick();  
             }else{
                  alert("删除失败");
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

      
       var url="<%=request.getContextPath()%>/jsp/faerp/agent/agentempaccount/insertAgentempaccount.jsp";      
        window.open(url,'','height=550px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工账号增加');
    }
    function detail_onClick(){  //实现转到详细页面
      var ids = document.form.accountid.value;
        if(ids == null || ids == ""){
          alert("请选择一条记录！");
          return;
        }
        var url="<%=request.getContextPath()%>/AgentempaccountAction.do?&cmd=detail&id=" + ids;
            window.open(url,'','height=430px,width=900px,top =100,left=300,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=项目书模板查看');
    }
        function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
     function ClickRow(value){
            $id("accountid").value = value;    
        }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="accountid" id="accountid" value="">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('员工账号维护','<%=request.getContextPath()%>/');  //显示本页的页眉
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
                  <td align="left">员工唯一号</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_code1" id="emp_code1" inputName="员工唯一号" maxLength="100"/>
            </td>
            <td align="left">员工名称</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" id="emp_name1" inputName="员工名称" maxLength="100"/>
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

             <!-- <input class="a" type="button"   value="查看"    onClick="detail_onClick();"> -->  
            <input class="c" type="button"   value="新增"   onClick="toAdd_onClick();">
             <input class="b" type="button"   value="修改"    onClick="findCheckbox_onClick();">
            <input class="d" type="button"   value="删除"   onClick="deleteMulti_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 

 
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/AgentempaccountAction.do?cmd=queryAccountData" width="98%" height="318px" xpath="AgentempaccountVo" paramFormId="datacell_formid" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="emp" label="操作" width="35px"
            onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>
        <r:field fieldName="cust_code" label="客户唯一号" width="100px"></r:field>
          <r:field fieldName="cust_name" label="客户名称" width="200px"></r:field>
        <r:field fieldName="emp_code" label="员工唯一号" width="100px"></r:field>
      <r:field fieldName="emp_name" label="员工姓名" width="100px"></r:field>
    
 <r:field fieldName="social_security_account" label="社保账号" width="150px"   ></r:field>
 <r:field fieldName="housing_fund_account" label="公积金账号" width="150px" ></r:field>
 <r:field fieldName="medical_insurance_account" label="医保账号" width="150px" ></r:field>
   <r:field fieldName="emp_status" label="员工状态" width="100px">
    <d:select dictTypeId="EMP_STATUS"  ></d:select>
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
<script language="javascript">
   
        $id("datacell1").afterRefresh=function(){
        if($id("accountid").value!=null||$id("accountid").value!=""){
         $id("accountid").value="";
         }
        }
</script>
