<%@ page contentType="text/html; charset=UTF-8"  %>
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
 <%
           String companyId=rayoo.common.pub.PubHelper.getCompanyID(request);
    %>
	
	<script language="javascript">
		function applyreport_submit(){
		  if(confirm('确定生成报表')) {
		  var strs = "" ;
		  var strs2 = "" ;
		  var checkup_policy_name = $id("checkup_policy_name").value ;
		  if(checkup_policy_name != null&&checkup_policy_name != ''){
		      strs=strs+"&arg1="+checkup_policy_name ;
		  }
		  var policy_type = $id("policy_type").value ;
		  if(policy_type != null&&policy_type != ''){
              strs=strs+"&arg2="+policy_type ;
          }
		  var policy_name = $id("policy_name").value ;
		  if(policy_name!=null&&policy_name != ''){
              strs=strs+"&arg3="+policy_name ;
          }
		  var clearing_mode = $id("clearing_mode").value ;
		  if(clearing_mode!=null&&clearing_mode != ''){
              strs=strs+"&arg4="+clearing_mode ;
          }
		  var start_date = $id("start_date").value ;
		  if(start_date!=null&&start_date != ''){
              strs=strs+"&arg5="+start_date ;
          }
		  var end_date = $id("end_date").value ;
		  if(end_date!=null&&end_date != ''){
              strs=strs+"&arg6="+end_date ;
          }
		  var cust_code = $id("cust_code").value ;
		  if(cust_code!=null&&cust_code != ''){
              strs=strs+"&arg7="+cust_code ;
          }
		  var cust_name = $id("cust_name").value ;
		  if(cust_name!=null&&cust_name != ''){
              strs=strs+"&arg8="+cust_name ;
          }
		  var user_name_com = $id("user_name_com").value ;
		  if(user_name_com!=null&&user_name_com != ''){
              strs=strs+"&arg9="+user_name_com ;
          }
		  var apply_type_bd = $id("apply_type_bd").value ;
		  if(apply_type_bd!=null&&apply_type_bd != ''){
              strs=strs+"&arg10="+apply_type_bd ;
          }
          var product_type_id =  $id("productid").getValue();
          if(product_type_id!=null&&product_type_id != ''){
              strs=strs+"&arg11="+product_type_id ;
          }
          
          //公司id     
          var company_id=$id("companyId").value;
               if(company_id != null&&company_id != ''){
                       strs=strs+"&arg12="+company_id;
                  }
		  var myform = $id("myform") ;
		  var report_type = $id("report_type").value ;
		  if(report_type =='1'){
		          myform.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/insuranceReport.jsp?raq=empinsurances.raq"+strs+"&reporttype=1";
                  myform.submit();
		  }
		  else if (report_type == '2'){
		         var str3 ="" ;
		         if(apply_type_bd !=null){
		              str3=str3+"&arg1="+apply_type_bd  ;
		         }
		     //公司id     
             var company_id=$id("companyId").value;
               if(company_id != null&&company_id != ''){
                       str3=str3+"&arg2="+company_id;
                  }
		        //保单
	          if(policy_name!=null&&policy_name != ''){
	               str3=str3+"&arg3="+policy_name;
	          } 
                myform.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/insuranceReport.jsp?raq=addbackempinformation.raq"+str3+"&reporttype=2";
                
                myform.submit();
          }
		  else if (report_type == '3'){
		         var str4 ="" ;
		         if(apply_type_bd !=null){
		              str4=str4+"&arg1="+apply_type_bd  ;
		         }
		         if(start_date!=null&&start_date != ''){
                      str4=str4+"&arg2="+start_date ;
                 }
          
	             if(end_date!=null&&end_date != ''){
	                  str4=str4+"&arg3="+end_date ;
	             }
	             if(product_type_id!=null&&product_type_id != ''){
                        str4=str4+"&arg4="+product_type_id ;
                 }
                         //公司id     
                 var company_id=$id("companyId").value;
               if(company_id != null&&company_id != ''){
                       str4=str4+"&arg5="+company_id;
                  }
              //保单
	          if(policy_name!=null&&policy_name != ''){
	              str4=str4+"&arg6="+policy_name;
	          }
            
                myform.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/insuranceReport.jsp?raq=addbackempsibling.raq"+str4+"&reporttype=3";
                myform.submit();
          }
		  else if(report_type == '4'){
				  if(checkup_policy_name != null&&checkup_policy_name != ''){
		              strs2=strs2+"&arg1="+checkup_policy_name ;
		          }
		          if(policy_name!=null&&policy_name != ''){
                      strs2=strs2+"&arg2="+policy_name ;
                  }
				  if(policy_type != null&&policy_type != ''){
		              strs2=strs2+"&arg3="+policy_type ;
		          }
		             //公司id     
                 var company_id=$id("companyId").value;
                   if(company_id != null&&company_id != ''){
                     strs2=strs2+"&arg4="+company_id;
                  }
              
		              
		           myform.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/insuranceReport.jsp?raq=policydatereport.raq"+strs2+"&reporttype=4";
                   myform.submit();
		  }
		 
		  else{
		      alert("请选择报表类型！") ;
		      return false ;
		  }
		  }
		}
		
		function rtnFuncInsuranceAegntByHealth1(arg){
	        var lookup = $id("checkup_policy_name");
	        lookup.value = arg[0];
	        lookup.displayValue = arg[2];  
	        return false;
        }
        
        function rtnFunc(arg){
        var lookup = $id("policy_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];   
        return false ;
    }
    function rtnFuncCustomer(arg){
        var lookup = $id("cust_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];  
        $id("cust_code").value = arg[1] ;
        return false;
    }
    function rtnFuncCS(arg){
        var lookup = $id("user_name_com");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
 
	function getapplytype() 
		{ 
		var informationapplytype = ['--请选择--','员工信息变更','子女信息变更']; //信息类
		var productapplytype = ['--请选择--','加保','退保','变更加保','变更退保']; //产品类
		var siblingapplytype = ['--请选择--','子女加保','子女退保']; //子女类
		var informationapplytype_value = ['','0','1']; //信息类
        var productapplytype_value = ['','1','2','4','5']; //产品类
        var siblingapplytype_value = ['','1','2']; //子女类
		
		var e = $id("report_type").value; 
		var apply_type_bd = $id("apply_type_bd") ;
		//产品
		if(e == '1'){
		      apply_type_bd.options.length=0 ;
		      for (var i=0; i<productapplytype.length; i++) {
                  apply_type_bd.options.add(new Option(productapplytype[i], productapplytype_value[i])); 
              } 
		}
		//信息
		if(e=='2'){
		  apply_type_bd.options.length=0 ; 
		  for (var i=0; i<informationapplytype.length; i++) {
              apply_type_bd.options.add(new Option(informationapplytype[i], informationapplytype_value[i])); 
          } 
		}
		//子女
		if (e =='3')
		{
		  apply_type_bd.options.length=0; 
		  for (var i=0; i<siblingapplytype.length; i++) {
              apply_type_bd.options.add(new Option(siblingapplytype[i], siblingapplytype_value[i])); 
          } 
		}
		if (e =='4')
        {
              apply_type_bd.options.length=0; 
              apply_type_bd.options.add(new Option("--请选择--", "")); 
        }
  }
  
  
  
    </script>
    
   
	</head>
	<body>
	<form name="myform" id="myform" method="post"
		action="">
		<input type="hidden" id="companyId" value="<%=companyId %>">
    <div id="right">
    <div class="right_title_bg">
      <div class=" right_title">保险报表</div></div>
    <div class="ringht_s">
    <!--表格2-->
    <div class="box_3"></div>
    <!--表格2 end-->
    <!--社保公积金-->
    <div class="zbox"><!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div class="xz_title">查询条件</div>
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1">保险供应商</td>
          <td class="td_2">
                <w:lookup onReturnFunc="rtnFuncInsuranceAegntByHealth1" readonly="false" id="checkup_policy_name" name="checkup_policy_name" lookupUrl="/InsuranceAegntAction.do?cmd=getInsuranceAegntByHealthListPage" dialogTitle="选择体检供应商" height="440" width="600"  style="width:170px"/>
          </td>
          <td class="td_1">保单类型</td>
          <td class="td_2">
          <d:select dictTypeId="POLICY_TYPE_BD" id="policy_type" name="policy_type" nullLabel="请选择" style="width: 170px;"/>
            </td>
          <td class="td_1">保单名称</td>
          <td class="td_2">
            <w:lookup onReturnFunc="rtnFunc" readonly="true" id="policy_name" name="policy_name" lookupUrl="/PolicyAction.do?cmd=toPolicyLookup"  dialogTitle="选择薪资类别" height="440" width="600"  style="width:170px"/>
         </td>
          </tr>
        <tr>
          <td class="td_1">结算方式</td>
          <td class="td_2"><d:select dictTypeId="CLEARING_MODE_BD" id="clearing_mode" property="bean/clearing_mode" style="width: 170px;" nullLabel="--请选择--"/></td>
          <td class="td_1">报表开始时间</td>
          <td class="td_2"><w:date format="yyyy/MM/dd" id="start_date" name="start_date" width="170px"/></td>
          <td class="td_1">报表结束时间</td>
          <td class="td_2">
                    <w:date format="yyyy/MM/dd" id="end_date" name="end_date" width="170px"/>
          </td>
        </tr>
        <tr>
          <td class="td_1">客户编号</td>
          <td class="td_2"><input name="text3" type="text" class="sText" id="cust_code" value=""/></td>
          <td class="td_1">客户名称</td>
          <td class="td_2"><w:lookup onReturnFunc="rtnFuncCustomer" readonly="false" id="cust_name" name="cust_name" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/>
</td>
          <td class="td_1">负责客服</td>
          <td class="td_2">
             <w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="user_name_com"  name="user_name_com"
                lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" 
                height="440" width="600"  style="width:170px"/>
</td>
        </tr>
        <tr>
          <td class="td_1"><span style="color: red">*</span>报表类型</td>
          <td class="td_2">
          <select name="report_type" class="sSelect" id="report_type" onchange="return getapplytype() ;"  style="width: 170px;">
            <option value="" selected>请选择</option>
            <option value="1">员工保险统计产品类报表</option>
            <option value="2">员工保险统计信息类报表</option>
            <option value="3">员工保险统计子女类报表</option>
            <option value="4">保单期限报表</option>
          </select></td>
          <td class="td_1">办理类型</td>
          <td class="td_2">
            <select name="apply_type_bd" class="sSelect" id="apply_type_bd"  style="width: 170px;">
                <option value="" selected>请选择</option>
            </select>
            <!--<d:select dictTypeId="APPLY_TYPE_BD" name="apply_type_bd"  property="apply_type_bd" id="apply_type_bd" nullLabel="---请选择---"  style="width:170px" />-->
          </td>
          <td class="td_1">产品三级分类</td>
          <td class="td_2">
         
            <r:comboSelect
                id="productid" name="productid_name"
                queryAction="/FAERP/ProductAction.do?cmd=getAllThreetypeProduct"
                textField="product_name" valueField="three_type_id" xpath="ProductVo"
                width="170px" nullText="请选择" />
            </td>
        </tr>
        <tr>
          <td colspan="6" align="center" class="td_2"> <input name="submit3" type="button" <au:authorityBtn code="bxbb_scbb" type="1"/> onclick="applyreport_submit();" class="icon_1" value="生成报表" />
           </td>
        </tr>
      </table>
    </div>
    <!--表格 end-->
    </div>
    <!--社保公积金 end-->
    <!--福利项目--><!--福利项目 end-->
    </div>
</div>
	</form>
</fmt:bundle>
</body>
<script type="text/javascript">
 //点击选择保单前事件
$id("policy_name").beforeOpenDialog= function(lookup){

        lookup.params = [];
         var policy_type = $id("policy_type").value ;
        if(policy_type!=""||policy_type!=null){
            lookup.addParam("policy_type",policy_type);
        return true;
        }
}
</script>
</html>


