<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.employeepost.epwelfare.vo.EpwelfareVo"%>
<%@ page import="rayoo.employeepost.epwelfare.util.IEpwelfareConstants"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(IEpwelfareConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(IEpwelfareConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    EpwelfareVo resultVo = null; //定义一个临时的vo变量
    String flag=request.getParameter("flag")==null?"false":request.getParameter("flag");
%>
<html>
	<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title>codegen</title>
			<script>  
		      //查询
		    function qryData(){ 
		     if(""!=(jQuery("#p_type").val())){
		       jQuery("#pId").val(jQuery("#p_type").val()); 
		       }
		       $id("dc_inter").reload();
		    } 
		    </script>
		</head>
		<body>
		  <form method="post" id="datacell_formid" name="datacell_formid" action=""><input type="hidden" name="cmd" value="">
              <div id="right">
			     <script language="javascript"> writeTableTopFesco('生日查询','<%=request.getContextPath()%>/');  //显示本页的页眉
			     </script>
				    <div class="ringht_s">
					    <div id="ccChild0" class="search">
						    <table width="100%" border="0" cellspacing="0" cellpadding="0">
						        <tr>
						            <td width="135" rowspan="3" style="padding-top: 0;">
						            <div class="search_title">查询条件</div>
						            </td>
						            <td>&nbsp;</td>
						            <td>&nbsp;</td>
						            <td>福利产品</td>
						            <td>
						            <select class="sSelect" name="p_type" id="p_type">
						                <option <c:if test="${pId=='1099110200000000188'}">selected</c:if>
						                    value="1099110200000000188">弹性福利</option>
						                <option <c:if test="${pId=='1099110200000000103'}">selected</c:if>
						                    value="1099110200000000103">员工活动</option>
						            </select>
						            </td>
						            <td>&nbsp;</td>
						            <td>&nbsp;</td>
						            <td>&nbsp;</td>
						            <td><input type="hidden" name="pId" id="pId"
						                value="${requestScope.pId}" /> <input onclick="qryData()"
						                type="button" class="icon_1" value="查询" /></td>
						        </tr>
						    </table>
					    </div>
					    
					    <div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <%if(flag.equals("true")){ %>
                    <li class="m_1"><a href="##" onClick="location.href='javascript:history.go(-1);'">返回首页</a></li>
                    <%} %> 
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
				
					    <div style="padding: 8 10 8 8;">
						    <r:datacell id="dc_inter"
						        queryAction="/FAERP/EpwelfareAction.do?cmd=showBirthdayRecord"
						        width="99%" xpath="EmployeeVo" submitXpath="EmployeeVo"
						        paramFormId="datacell_formid" height="304">
						        <r:toolbar location="bottom" tools="nav,pagesize,info" />
						        <r:field fieldName="cust_name" label="客户名称" width="300px">
						        </r:field>
						        <r:field fieldName="emp_name" label="员工姓名" width="150px">
						        </r:field>
						        <r:field fieldName="email" label="员工email" width="200px">
						        </r:field>
						        <r:field fieldName="mobile" label="员工手机号码" width="200px">
						        </r:field>
						        <r:field fieldName="address" label="员工地址" width="300px">
						        </r:field>
						    </r:datacell>
					    </div>
				    </div>
			    </div>
          </form>
	</fmt:bundle>
    </body>
</html>
<script>
 function changeSmallType(){
    var curValue = $id("small_product_code").getValue();     
        $id("product_id").disabled = false;   
         $id("product_id").addParam("code", curValue);
         $id("product_id").loadData();
         $id("product_id").refresh();
         }  
         
    $id("dc_inter").beforeRefreshCell = function(cell,field1){
        //alert(field1);alert(field1.fieldName);
        if (field1 && field1.fieldName && field1.fieldName=="emp"){
            return false;
        }
    }           
</script>
