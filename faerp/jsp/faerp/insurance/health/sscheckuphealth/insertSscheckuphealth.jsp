<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

//提交验证

function submit_check(){


 /*var cust_id = $id("cust_id").value;
 if(cust_id==''){
    alert("客户编号不能为空") ;
    return false ;
 }
 var cust_name = $id("cust_name").value;
 if(cust_name==''){
    alert("客户名称不能为空") ;
    return false ;
 }
 var emp_code = $id("emp_code").value;
 if(emp_code==''){
    alert("唯一号不能为空") ;
    return false ;
 }
 
 var is_marital = $id("is_marital").value;
 if(is_marital==''){
    alert("婚否不能为空") ;
    return false ;
 }
 */
 
 
 var emp_name = $id("emp_name").value;
 var emp_id_card = $id("emp_id_card").value;
	 if(emp_name==''){
	    alert("员工名称不能为空") ;
	    return false ;
	 }
	 
	 if(emp_id_card==''){
	    alert("身份证号码不能为空") ;
	    return false ;
	 }
	 var sex = $id("sex").value;
	 if(sex==''){
	    alert("性别不能为空") ;
	    return false ;
	 }
	 
	 var str_date = $id("str_date").value;
	 if(str_date==''||str_date==null){
	    alert("体检开始日期不能为空") ;
	    return false ;
	 }
	 var end_date = $id("end_date").value;
	 if(end_date==''||end_date==null){
	    alert("体检截止日期不能为空") ;
	    return false ;
	 }
	 var settlement_date = $id("settlement_date").value;
	 if(settlement_date==''||settlement_date==null){
	    alert("结算日期不能为空") ;
	    return false ;
	 }
	 //判断是否重复
		ishavedata(emp_name,emp_id_card);
		
}
function rtnFuncCustomer(arg){
    var lookup = $id("cust_name");
    var cust_id = $id("cust_id");
    cust_id.value=arg[1] ;
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    return false;
}
 
  function onclose(){
       window.close() ;
    }
    
    function rtnFuncEmployee(arg){
        var lookup = $id("emp_name");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        if(arg[2] !=null &&arg[2]!=''){
            $id("emp_code").value = arg[2] ;
        }
        
        $id("emp_id_card").value = arg[3] ;
        return false;
    }
    
   
</script>
</head>
<body>

<form name="myform" method="post"  action="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=insert" id="myform" >
<div id="right">
<div class="box_xinzeng">
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" height="90%">
  <tr>
    <td class="td_1">客户编号</td>
    <td class="td_2"><input type="text" value="" class="xText" id="cust_id" name="cust_id"/></td>
    <td class="td_1">客户名称</td>
    <td class="td_2">
        <w:lookup onReturnFunc="rtnFuncCustomer" readonly="false" id="cust_name" name="cust_name" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/> 
    </td>
  </tr>
  <tr>
    <td class="td_1">唯一号</td>
    <td class="td_2"><input type="text" value="" class="xText" id="emp_code" name="emp_code"/></td>
    <td class="td_1"><span style="color: red">*</span>员工名称</td>
    <td class="td_2">
    <w:lookup onReturnFunc="rtnFuncEmployee" readonly="false" id="emp_name" name= "emp_name" lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList"  dialogTitle="选择员工" height="450" width="800"  style="width:170px"/>
    </td>
  </tr>
  <tr>
    <td class="td_1"><span style="color: red">*</span>证件号码</td>
    <td class="td_2"><input name="emp_id_card" type="text" class="xText" id="emp_id_card" value=""/></td>
    <td class="td_1">客服</td>
    <td class="td_2"><input type="text" value="<%=LoginHelper.getLoginName(request)%>" class="xText" id="cust_serrver" readonly="readonly"  name="cust_serrver"/></td>
  </tr>
    <tr>
    <td class="td_1"><span style="color: red">*</span>性别</td>
    <td class="td_2">
    <d:select dictTypeId="EMP_SEX" name="sex"  property="sex" id="sex"   style="width:190px" />
    <!--<select name="sex" class="sSelect" id="sex">
      <option value="" selected="">请选择</option>
      <option value="1">男</option>
      <option value="2">女</option>
        </select>
        
        --></td>
    <td class="td_1">婚否</td>
    <td class="td_2"><select name="is_marital" class="sSelect" id="is_marital">
      <option value="" selected="">请选择</option>
      <option value="1">已婚</option>
      <option value="0">未婚</option>
        </select></td>
  </tr>
    <tr>
    <td class="td_1"><span style="color: red">*</span>体检开始日期</td>
    <td class="td_2">
        <w:date allowInput="false" id="str_date" name="str_date" format="yyyy-MM-dd" style="width:165px;"/>
   </td>
    <td class="td_1"><span style="color: red">*</span>体检截止日期</td>
    <td class="td_2">
        <w:date allowInput="false" id="end_date" name="end_date" format="yyyy-MM-dd" style="width:165px;"/>
    </td>
  </tr>
    <tr>
    <td class="td_1"><span style="color: red">*</span>结算日期</td>
    <td class="td_2">
    <w:date allowInput="false" id="settlement_date" name="settlement_date" format="yyyy-MM-dd" style="width:165px;"/>
    </td>
    <td class="td_1">&nbsp;</td>
    <td class="td_2">&nbsp;</td>
    </tr>
  <tr>
    <td class="td_1">备注</td>
    <td colspan="3" class="td_2"><textarea name="remark" rows="3" class="xText_d" id="remark"></textarea></td>
    </tr>
  </table>
  
<div class="xz_button">
 <input type="button" class="icon_2" value="提交" onclick="submit_check() ;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <input name="but" type="button" class="icon_2" onclick="onclose()" value="关闭"/>
</div>
</div></div>
</div></div>
</form>
</body>
</html>
<script language="javascript">
 function ishavedata(username,id_card){
        var url="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=isInsertSscheckuphealth&username="+encodeURI(username)+"&id_card="+encodeURI(id_card);
                  jQuery.ajax({
                   url: url,
                  type: 'post',
                  dataType: 'html',
                  timeout: 80000,
                  error: function(){
                      alert('Error loading XML document');
                      return  false ;
                  },
                  success: function(text){
                              if(text=="yes"){
                                 alert("你添加的用户已经在体检名单中,不能重复提交！");
                                 return false ;
                              }else if(text=="no"){
                                $id("myform").submit() ;
                                 return true ;
                              }
                  }
                  });
    }
</script>
