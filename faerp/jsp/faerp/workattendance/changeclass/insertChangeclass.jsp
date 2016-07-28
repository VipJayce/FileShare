<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面

    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <title>codegen</title>
    <script language="javascript">
 function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    function update_onClick(){
     if(checkAllForms()){
          var lk_cust=document.form.lk_cust.value;
        
          var emp_code=document.form.emp_code.value;
 
            var changeclassdate=document.getElementById("changeclassdate").value;
              var changeclassenddate=document.getElementById("changeclassenddate").value;
                var changeclassnote=document.getElementById("changeclassnote").value;
    
                if(lk_cust==""||lk_cust==null){
                alert("客户名称不能为空");
                return;
                }
                  if(emp_code==""||emp_code==null){
                alert("员工姓名不能为空");
                return;
                }
                  if(changeclassdate==""||changeclassdate==null||changeclassenddate==""||changeclassenddate==null){
                alert("员工调班日期不能为空");
                return;
                }
              if(trim(changeclassnote)==""||changeclassnote==null){
              alert("调班说明不能为空")
              return;
              }
              }
      var param=jQuery("#datacell_formid").serialize();      
        var url="<%=request.getContextPath()%>/ChangeclassAction.do?cmd=updateChangeclass&"+param;
        jQuery.post(url,function(data){

         if(data!=0){
           alert("修改成功！");
           window.close();
         }else{
               alert("修改失败！");
                window.close();
         }
        })
    }   
    function  insert_onClick(){
       var lk_cust=document.form.lk_cust.value;
        
          var emp_code=document.form.emp_code.value;
            var changeclassdate=document.getElementById("changeclassdate").value;
              var changeclassenddate=document.getElementById("changeclassenddate").value;
                var changeclassnote=document.getElementById("changeclassnote").value;
                if(lk_cust==""||lk_cust==null){
                alert("客户名称不能为空");
                return;
                }
                  if(emp_code==""||emp_code==null){
                alert("员工姓名不能为空");
                return;
                }
                  if(changeclassdate==""||changeclassdate==null||changeclassenddate==""||changeclassenddate==null){
                alert("员工调班日期不能为空");
                return;
                }
              if(trim(changeclassnote)==""||changeclassnote==null){
              alert("调班说明不能为空")
              return;
              }
     var param=jQuery("#datacell_formid").serialize();  
        var url="<%=request.getContextPath()%>/ChangeclassAction.do?cmd=insertChangeclass&"+param;
        jQuery.post(url,function(data){
         if(data!=""){
           alert("保存成功！");
           window.close();
         }else{
               alert("保存失败！");
                window.close();
         }
        })
    }
</script>
    </head>
    <body>

    <form name="form" method="post" id="datacell_formid">
 <input type="hidden" name="id" value="${bean.id }">
    <input type="hidden" name="peopleorder" value="${bean.peopleorder }">
     <input id="cust_id"  name="cust_id" type="hidden" value="${bean.cust_id }" />
     <div id="right">
    <div class="ringht_s">
    <div id="ccChild1" class="box_3">
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
   <tr>
    <td class="td_1"><span class="style_required_red">* </span>客户名称</td>
        <td align="left" class="td_2"><w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust"
            lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" style="width:180px"
            dialogTitle="选择客户" height="450" width="610" displayValue="${bean.cust_name}" value="${bean.cust_id }" /></td>
      
    <td class="td_1"><span class="style_required_red">* </span>员工姓名</td>
    <td class="td_2" align="left">
    <w:lookup readonly="true" id="emp_code" validateAttr="allowNull=false;" name="emp_code"
            lookupUrl="/FAERP/jsp/faerp/employeepost/empinfo/employee/EmployeeByCustomerId.jsp" style="width:180px"
            dialogTitle="选择员工" height="450" width="610" value="${bean.emp_code }" displayValue="${bean.emp_name}"  /> </td>
   </tr>
   <tr><td class="td_1"><span class="style_required_red">* </span>调班日期</td>
            <td class="td_2">
             <w:date allowInput="true" id="changeclassdate" name="changeclassdate" format="yyyy/MM/dd" width="180px" property="bean/changeclassdate"/>  
            </td>
            <td class="td_1"><span class="style_required_red">* </span>调班后日期</td>
            <td class="td_2">
            <w:date allowInput="true" id="changeclassenddate" name="changeclassenddate" format="yyyy/MM/dd" width="180px" property="bean/changeclassenddate"/>  
             </td>
   </tr>
   <tr>
            <td class="td_1"><span class="style_required_red">* </span>调班说明</td>
            <td colspan="3" class="td_2"><textarea style="width: 500px" rows="2" name="changeclassnote" inputName="调班说明">${bean.changeclassnote }</textarea></td>
        </tr>
        <tr>
            <td class="td_1">备注</td>
            <td colspan="3" class="td_2"><textarea style="width: 500px" rows="2" name="remark" inputName="备注">${bean.remark }</textarea></td>
        </tr>
    </table>
    </div>
    <div class="foot_button"><input type="button" class="foot_icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>"  >
    <input type="button" class="foot_icon_2"  value='关闭'  onClick="javascript:cancel_onClick()" /></div>
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
     var look=$id("emp_code");
     look.value="";
     look.displayValue="";
    look.refreshInput();
    return false;
}
$id("emp_code").beforeOpenDialog=function(reg){
   var cust_id=document.getElementById("cust_id").value; 
   //alert(cust_id);
   var lookup=$id("emp_code");
   lookup.clearParam();
   lookup.addParam("cust_id",cust_id);
   
   return true;
}

$id("emp_code").onReturnFunc=function(returnValue){
   var lookup=$id("emp_code");
    lookup.value=returnValue[1];
    lookup.displayValue = returnValue[2];
    return false;
}
</script>
</body>
</html>

