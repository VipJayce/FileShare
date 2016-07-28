<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	
    function rtnFunc(arg){
        var lookup = $id("policy_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];   
        return false ;
    }
   
   
   function apply_onClick(){
   if(confirm('确定生成数据')) {
        var policy_name =  $id("policy_name").value ;
        if(policy_name == ''||policy_name==null){
            alert("请选择保单进行操作！") ;
            return false ;
        }
        var product_type_id =  $id("productid").getValue();
        var emp_id=document.getElementById("emp_id").value;
        //var apply_type_bd =  $id("apply_type_bd").value ;
        //if(apply_type_bd == ''||apply_type_bd==null){
        //    alert("请选择办理类型进行操作！") ;
        //    return false ;
        //}
        var start_date =  $id("start_date").value ;
        if(start_date == ''||start_date==null){
            alert("请选择开始日期进行操作！") ;
            return false ;
        }
        var end_date =  $id("end_date").value ;
        if(end_date == ''||end_date == null){
            alert("请选择结束日期进行操作！") ;
            return false ;
        }
        var month_start=start_date.substring(0,7);
        var month_end=end_date.substring(0,7);
        if(month_start!=month_end){
            alert("请选择同一个月的时间进行操作！");
            return false;
         }
        $id("submit2").disabled="disabled" 
            var url ="<%=request.getContextPath()%>/ApplyinsuranceAction.do?cmd=ApplyinsuranceData" ;
            url = url+"&policy_name="+encodeURI(policy_name)+"&product_type_id="+product_type_id+"&start_date="+start_date+"&end_date="+end_date+"&emp_id="+emp_id;
            jQuery.ajax({
                   url: url,
                  type: 'post',
                  dataType: 'html',
                  error: function(){
                      alert('系统编译错误！');
                      $id("submit2").disabled="" 
                      return  null;
                  },
                  success: function(text){
                      if(text!=null){       
                        alert(text);
                        $id("submit2").disabled="" 
                      }
                  }
                  });
     }
   }
   function selectProductList() {
        var url="<%=request.getContextPath()%>/ProductAction.do?cmd=queryAllProduct&bigtypeid=104";
        showModalCenter(url, window,toaddProductlistrollback,810,510,"查询产品");
    }
   function toaddProductlistrollback(arg){
        $id("product_type_id").value = arg[0] ;
   }
   
   
   //员工按钮返回值 2014年9月3日
   function rtnFuncEmployee(arg){
        var lookup = $id("emp_name");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        jQuery("#emp_id").val(arg[0]);
        return false;
    }
   
   
    </script>
	</head>
	<body>
	<form name="form" method="post"
		action="<%=request.getContextPath()%>/ApplyinsuranceAction.do">
    <!--查询 -->
    <div id="right">
     <div class="right_title_bg">
      <div class=" right_title">加退保生成</div>
    </div>
  <div class="search">  
    <br/>
	<div id="TabCon1"><!--表格1-->
	<div class="xz_title" style="margin-top: 10px;"></div>
	<div class="box_3">
	<table width="80%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2" align="center"> 
		<tr>
			<td class="td_1"><span style="color: red">*</span>保单名称</td>
			<td class="td_2">
			         <w:lookup onReturnFunc="rtnFunc" readonly="true" id="policy_name" name="policy_name" lookupUrl="/PolicyAction.do?cmd=toPolicyLookup"  dialogTitle="选择保单" height="480"  width="770"/>
			</td>
			<td class="td_1">
            <span style="color: red">*</span>开始日期</td>
            <td class="td_2">
            <w:date format="yyyy/MM/dd" id="start_date" name="start_date" width="153px"/>
                </td>
            <td class="td_1"><span style="color: red">*</span>结束日期</td>
            <td class="td_2">
            <w:date format="yyyy/MM/dd" id="end_date" name="end_date" width="153px"/>
            </td>
			<!--
			
			<td class="td_1"><span style="color: red">*</span>办理类型</td>
			<td class="td_2">
			<d:select dictTypeId="APPLY_TYPE_BD" name="apply_type_bd"  property="apply_type_bd" id="apply_type_bd" nullLabel="---请选择---"  style="width:190px" />
			</td>
		--></tr>
		<tr>
		      <td class="td_1">产品三级类别</td>
            <!--仅指大类为商业保险的三级类别-->
            <td class="td_2">
            <span class="td_2">
            <r:comboSelect
                id="productid" name="productid_name"
                queryAction="/FAERP/ProductAction.do?cmd=getAllThreetypeProduct"
                textField="product_name" valueField="three_type_id" xpath="ProductVo"
                width="170px" nullText="请选择" />
            </span>
            <input name="product_type_id" type="hidden" class="sText" id="product_type_id"  />
            </td>
			<td class="td_1">员工</td>
			<td class="td_2">
			<input type="hidden" class="text_field" name="emp_id" id="emp_id" inputName="员工唯一号" maxLength="64" />
             <w:lookup onReturnFunc="rtnFuncEmployee" readonly="true" id="emp_name" name= "emp_name" lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList" messagekey="choose_emp" height="450" width="800" /></td>
			<td class="td_1">&nbsp;</td>
            <td class="td_2">
            <span class="td_2"><input name="submit2"  id="submit2"  type="button" class="icon_1" value="生成" <au:authorityBtn code="jtbsc_scmd" type="1"/> onClick="apply_onClick()" /> </span>
            <input type="reset" class="icon_1"   type="button" value="重置" >
            </td>
		</tr>
		<!--<tr>
			<td class="td_1">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
			<td class="td_1"></td>
			<td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
		</tr>
	--></table>
	<p></p>
	<p></p>
	</div></div>
	</form>
</fmt:bundle>
</body>
</html>

