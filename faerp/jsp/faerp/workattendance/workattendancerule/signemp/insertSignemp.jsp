<%@ page contentType="text/html; charset=UTF-8"%>
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
	function insert_onClick(){  //插入单条数据
	      var cust_id=document.form.cust_id.value;
        
          var emp_name=document.form.emp_id.value;
 
            var timecardid=document.getElementById("timecardid").value;
      
       
                if(cust_id==""||cust_id==null){
                alert("客户名称不能为空");
                return;
                }
                  if(emp_name==""||emp_name==null){
                alert("员工姓名不能为空");
                return;
                }
                
                if(timecardid==""||timecardid==null){
                alert("考勤卡号不能为空");
                return;
                }
	  var param=jQuery("#datacell_formid").serialize();  
        var url="<%=request.getContextPath()%>/SignempAction.do?cmd=insert&"+param;
        jQuery.post(url,function(data){
         if(data!=""){
           alert("增加成功！");
           window.close();
         }else{
               alert("增加失败！");
                window.close();
         }
        })
	}

  	
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    function vailtimecardid(){
      var  timecardid = document.getElementById("timecardid").value;
        if(/.*[\u4e00-\u9fa5]+.*$/.test(timecardid)){ 
            alert("考勤卡号不能含有汉字！"); 
            return; 
        }
           jQuery.ajax({
           url: '<%=request.getContextPath()%>/SignempAction.do?cmd=vaile&timecardid='+timecardid,
           type: 'POST',
           dataType: 'html',
           async: false,
           timeout: 10000,
               error: function(){
                  alert('考勤卡号重复!');
                  jQuery("#timecardid").val("");
     
                  return;
               },
                success: function(data){
                        if(data=='false'){
                           alert('考勤卡号重复!');
                           jQuery("#timecardid").val("");
                    
                           return;
                          }
               }
           });
           }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
 <div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" nowrap="true" ><span class="style_required_red">* </span>客户名称</td>
			<td align="left" class="td_2"><w:lookup readonly="true" id="cust_id" validateAttr="allowNull=false;" name="cust_id"
            lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" style="width:180px"
            dialogTitle="选择客户" height="450" width="610"  /></td>
		
		</tr>
		  <tr>
		  <td class="td_1" nowrap="true"><span class="style_required_red">* </span>员工姓名</td>
          <td class="td_2" align="left" style="width: 250px">
    <w:lookup readonly="true" id="emp_id" validateAttr="allowNull=false;" name="emp_id"
            lookupUrl="/FAERP/jsp/faerp/employeepost/empinfo/employee/EmployeeByCustomerId.jsp" style="width:180px"
            dialogTitle="选择员工" height="450" width="610"   /> </td>
	
		</tr>
		<tr>
			<td class="td_1" nowrap="true" ><span class="style_required_red">* </span>考勤卡号</td>
			<td class="td_2 ">
				<input type="text" class="text_field" id="timecardid" name="timecardid" maxLength="20" onblur="vailtimecardid()" style="width: 195px"/>
			</td>
		</tr>
		
	</table>
	</div>
    <div class="foot_button">
        <input type="button" class="icon_2" value="<fmt:message key="save"/>" onClick="javascript: insert_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>
</div>         
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	   $id("cust_id").onReturnFunc = function (returnValue){
    var lookup = $id("cust_id");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
       var look=$id("emp_id");
     look.value="";
     look.displayValue="";
    look.refreshInput();
    return false;
    }
    
    $id("emp_id").beforeOpenDialog=function(reg){
   var cust_id=document.getElementById("cust_id").value; 
  
   var lookup=$id("emp_id");
   lookup.clearParam();
   lookup.addParam("cust_id",cust_id);
   return true;
}
  $id("emp_id").onReturnFunc = function (returnValue){
    var lookup = $id("emp_id");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
      var emp=returnValue[0];
  if(emp!=null&&emp!=""){
             jQuery.ajax({
               url: '<%=request.getContextPath()%>/SignempAction.do?cmd=vaile&emp_id='+emp,
               type: 'POST',
               dataType: 'html',
               async: false,
               timeout: 10000,
                   error: function(){
                      alert('此员工已存在!');
                   lookup.value=""
                    lookup.displayValue=""
                      return;
                   },
                    success: function(data){
                        if(data=='false'){
                       alert('此员工已存在!');
                          lookup.value=""
                         lookup.displayValue=""
                           return;
                       }
                   }
               });
           }
    
    return false;
    }
</script>
</body>
</html>


