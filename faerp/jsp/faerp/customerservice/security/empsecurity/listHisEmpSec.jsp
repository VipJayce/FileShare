<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
        <fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listApplyHousingEmpsecurity_resource' prefix='auto.'>
				<head>
				
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				<title>员工公积金缴费状态变更历史记录</title>
				<script language="javascript">
				</script>
				</head>
				<body>
					<form name="form" method="post" id="datacell_formid" >
						<div id="right">
							<div class="ringht_s">
								<div id="ccChild0" class="search"> 
								    <table width="100%" border="0" cellspacing="0" cellpadding="0">
								            <tr>
								            <td width="174" rowspan="6" valign="middle" align="center" ><div class="search_title"><fmt:message key='listApplyHousingEmpsecurity0031'/></div> </td>
								        </tr>
								        </tr>
								              <td align="right">员工姓名</td>
								              <td align="left">
                                                   <input name="emp_name_con" id = "emp_name_con" value="${emp_name_con }">
                                              </td>
								              <td align="right">唯一号</td>
								              <td align="left">
								                    <input name="emp_code_con" id = "emp_code_con" value="${emp_code_con }">
								              </td>
								              <td align="right">客户编号</td>
								              <td align="left">
								                    <input name="cust_code_con" id = "cust_code_con" value="${cust_code_con }">
								              </td>
                                          </tr>
                                          <tr>
                                              <td align="right">客户名称</td>
                                              <td align="left">
                                                    <input name="cust_name_con" id = "cust_name_con" value="${cust_name_con }">
                                              </td>
								              <td align="right">修改日期</td>
                                              <td align="left">
                                                    <w:date allowInput="true" id="update_date_con" name="update_date_con" format="YYYY-MM-DD" property="bean/update_date" width="150px" value="${update_date_con }" />
                                              </td>
								              <td align="center" colspan="2">
								                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
								                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
								              </td>
								        </tr>
								   </table>
								</div>
								<div id="ccParent1" class="button" style="width: 100%"> 
								      <div class="button_right" style="width: 100%;">
                                            <input class="e" type="button" value="导出" onClick="javascript:exportExcel();">
                                      </div>
								    <r:datacell 
								        id="datacell1"
								        queryAction="/FAERP/EmpsecurityAction.do?cmd=queryHisEmpSec" 
								        submitAction="/FAERP/EmpsecurityAction.do?cmd=queryHisEmpSec"
								        xpath="HisEmpsecurityVo"
								        submitXpath="HisEmpsecurityVo"
								        paramFormId="datacell_formid" height="350px" width="100%"
								        pageSize="10"
								        >
								      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
								      <r:field allowModify="false"  fieldName="name" sortAt="none" label="修改人" width="100px" align="center">
								      </r:field>
								      <r:field fieldName="update_date" sortAt="none" label="修改时间" width="150px" allowModify="false">
								            <h:text/>      
								      </r:field>
								      <r:field fieldName="emp_name" sortAt="none" label="员工姓名" width="100px" allowModify="false">
                                                  <h:text/>      
                                            </r:field>
								      <r:field fieldName="emp_code" sortAt="none" label="唯一号" width="100px" allowModify="false">
								            <h:text/>      
								      </r:field>
								      <r:field fieldName="cust_name" sortAt="none" label="客户名称" width="200px" allowModify="false">
								            <h:text/>      
								      </r:field>
								      <r:field fieldName="cust_code" sortAt="none" label="客户编码" width="150px" allowModify="false">
                                                  <h:text/>      
                                            </r:field>
                                            <r:field fieldName="security_status_bd_old" sortAt="none" label="原状态" width="180px" allowModify="false">
                                                  <d:select name="security_status_bd" dictTypeId="SECU_MODIFY_STA" style="width: 180px"/>
                                            </r:field>
                                            <r:field fieldName="security_status_bd_new" sortAt="none" label="现状态" width="180px" allowModify="false">
                                                  <d:select name="security_status_bd" dictTypeId="SECU_MODIFY_STA" style="width: 180px"/>
                                            </r:field>
								    </r:datacell>
								</div>
							</div>
						</div>
					</form>
					<script language="javascript">
					   $id("datacell1").isQueryFirst=false;
					    function simpleQuery_onClick(){  //简单的模糊查询'
	                        $id("datacell1").loadData();
	                        $id("datacell1").refresh();
					    }
                        
                        //导出明细
                        function exportExcel(type){
                           var emp_name_con = document.getElementById("emp_name_con").value;
                           var emp_code_con = document.getElementById("emp_code_con").value;
                           var cust_code_con = document.getElementById("cust_code_con").value;
                           var cust_name_con = document.getElementById("cust_name_con").value;
                           var update_date_con = document.getElementById("update_date_con").value;
                           //拼装查询条件
                           var conditionStr = "&emp_name_con="+emp_name_con+"&emp_code_con="+emp_code_con+"&cust_code_con="+cust_code_con+"&cust_name_con="+cust_name_con+"&update_date_con="+update_date_con;
						   conditionStr = encodeURI(conditionStr);//编码json
						   var form = document.getElementById("datacell_formid");
						   form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcelForHisEmpSec"+conditionStr;
						   form.submit();
                        }
					</script>
				</body>
		</fmt:bundle>
</html>
