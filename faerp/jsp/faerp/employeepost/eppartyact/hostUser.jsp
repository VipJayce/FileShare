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
	function simpleQuery(){  //简单的模糊查询
	    $id("datacell1").addParam("emp_name1",$id("emp_name1").value);
        $id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
  	
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='id'   onClick=ClickRow(\"" + entity.getProperty("emp_id") + "\",\"" + entity.getProperty("emp_name") + "\",\"" + entity.getProperty("mobile") + "\");>";
    }
    
  	 function ClickRow(emp_id,emp_name,mobile){
  	     $id("empId").value = emp_id;
  	     $id("empname").value = emp_name;
  	     $id("empmobile").value = mobile;
    }
    
    function choose() {
          var emp_id=document.getElementById('empId').value;
          var emp_name=document.getElementById('empname').value;
          var mobile=document.getElementById('empmobile').value;
          
          var returnAry = new Array();
          returnAry[0]=emp_id;
          returnAry[1]=emp_name;
          returnAry[2]=mobile;
          window.returnValue=returnAry;
          window.close();
        
    }
</script>
</head>
<body>
<div id="right">
<form name="form"  id="datacell_formid" method="post" action="<%=request.getContextPath()%>/EppartyactAction.do">
<input type="hidden" id="empname" name="empname"/>
<input type="hidden" id="empId" name="empId"/>
<input type="hidden" id="empmobile" name="empmobile"/>
 

<div class="ring2ht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title">查询条件</div>
			</td>

			<td />
			<td />
		</tr>
		<tr>
			<td align="right">员工姓名</td>
			<td align="left">
				<input type="text" class="text_field" id="emp_name1"  name="emp_name1" inputName="员工姓名" maxLength="50"/>
				<input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery()">
			</td>
			<td align="right"></td>

		</tr>
</table>
</div>
					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:choose();"><fmt:message key="view"/> </a> </li>
				</ul>
				
		 </div>
		 
           <div class="clear"></div>			
           
</div>
     
      <r:datacell 
        id="datacell1"
       queryAction="/FAERP/EppartyrelationAction.do?cmd=getListData"
        width="100%" height="302px"
        xpath="EppartyrelationVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="eid"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
      <r:field fieldName="emp_name" width="220px" label="员工姓名">
       </r:field>    
      <r:field fieldName="mobile" width="245px" label="联系方式">
      </r:field>
    </r:datacell>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">

</script>	
