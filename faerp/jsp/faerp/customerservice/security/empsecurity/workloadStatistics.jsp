<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
        <fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listApplyHousingEmpsecurity_resource' prefix='auto.'>
				<head>
				
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				<title>员工工作量统计</title>
				<script language="javascript">
				</script>
				</head>
				<body>
					<form name="form" method="post" id="datacell_formid" >
						<input type="hidden" name="cmd">
						<input type="hidden" id="isClickQuery" value="false" />
						<input type="hidden" id="Method" name="Method" value=""/>
						<div id="right">
							<div class="ringht_s">
								<div id="ccChild0" class="search"> 
								    <table width="100%" border="0" cellspacing="0" cellpadding="0">
								            <tr>
								            <td width="174" rowspan="6" valign="middle" align="center" ><div class="search_title"><fmt:message key='listApplyHousingEmpsecurity0031'/></div> </td>
								        </tr>
								        </tr>
								              <td align="right">社保/公积金</td>
								              <td align="left">
								                    <d:select name="groupType" id="groupType" dictTypeId="GROUP_TYPE_BD" nullLabel="--请选择--" ></d:select>
								              </td>
								              <td align="right">统计年月</td>
								              <td align="left">
								                   <input name="startMonth" id = "startMonth" value="" style="width: 80px;">
								                   <fmt:message key='listApplyHousingEmpsecurity0047'/>
								                   <input name="endMonth" id = "endMonth" value="" style="width: 80px;">
								              </td>
								              <td align="right">操作人</td>
								              <td align="left">
								                    <select id="operatorID" name="operatorID" >
								                        <option value="">--请选择--</option>
								                        <logic:iterate name="aupartyVoList" id="volist" scope="request" indexId="indexs">
								                            <option value="${volist.id }">${volist.name }</option>
                                                        </logic:iterate>
								                    </select>
								              </td>
								              <td>
								                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
								                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
								              </td>
								        </tr>
								   </table>
								</div>
								<div id="ccParent1" class="button" style="width: 100%"> 
										<div style="float: left; width:33%;margin-right: 15px;">
										      <div class="button_right" style="width: 100%;">
		                                            <input class="e" type="button" value="导出" onClick="javascript:exportExcel('workload');">
		                                      </div>
										    <r:datacell 
										        id="datacell1"
										        queryAction="/FAERP/EmpsecurityAction.do?cmd=workloadStatistics" 
										        submitAction="/FAERP/EmpsecurityAction.do?cmd=workloadStatistics"
										        xpath="EmpsecurityVo"
										        submitXpath="EmpsecurityVo"
										        paramFormId="datacell_formid" height="470px" width="100%"
										        freezeNumber="1"
										        pageSize="15"
										        >
										      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
										      <r:field fieldName="transact_man" sortAt="none" label="办理人" width="0px" allowModify="false">
                                              </r:field>
                                              <r:field fieldName="stop_man" sortAt="none" label="停办人" width="0px" allowModify="false">
                                              </r:field>
										      <r:field allowModify="false"  fieldName="transact_man" sortAt="none" label="操作" width="40px" onRefreshFunc="setRadioStatus"  align="center">
										      </r:field>
										      <r:field fieldName="tran_name" sortAt="none" label="操作人" width="80px" allowModify="false">
										            <h:text/>      
										      </r:field>
										      <r:field fieldName="transact_date_str" sortAt="none" label="操作年月" width="80px" allowModify="false">
                                                    <h:text/>      
                                              </r:field>
										      <r:field fieldName="transact_man_emp_count" sortAt="none" label="办理人数" width="80px" allowModify="false">
										            <h:text/>      
										      </r:field>
										      <r:field fieldName="stop_man_emp_count" sortAt="none" label="停办人数" width="80px" allowModify="false">
										            <h:text/>      
										      </r:field>
										    </r:datacell>
										</div>
										<div>
										    <div class="xz_title button_right" style="width: 100%;">办理明细&nbsp;&nbsp;
										          <input class="e" type="button" value="导出" onClick="javascript:exportExcel('tran');">
										     </div>
											<div style="width: 100%;margin-bottom: 20px;">
	                                            <r:datacell 
	                                                id="datacell2"
	                                                queryAction=""
	                                                xpath="EmppostVo"
	                                                submitXpath="EmppostVo"
	                                                paramFormId="datacell_formid" height="200px" width="100%"
	                                                pageSize="5"
	                                                >
	                                             <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	                                             <r:field fieldName="emp_code" sortAt="none" label="唯一号" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="emp_name" sortAt="none" label="员工姓名" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="group_name" sortAt="none" label="公积金组" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="id_card_type_bd" sortAt="none" label="证件类型" allowModify="false">
                                                    <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                                                 </r:field>
	                                             <r:field fieldName="id_card" sortAt="none" label="证件号码" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="cust_code" sortAt="none" label="客户编号" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="cust_name" sortAt="none" label="客户名称" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="account" sortAt="none" label="公积金帐号" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="hire_unit_short_name" sortAt="none" label="福利办理方" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="tran_name" sortAt="none" label="办理人" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="tran_date" sortAt="none" label="办理时间" allowModify="false">
                                                 </r:field>
	                                            </r:datacell>
	                                        </div>
	                                        
	                                        <div class="xz_title button_right" style="width: 100%;">停办明细&nbsp;&nbsp;
	                                               <input class="e" type="button" value="导出" onClick="javascript:exportExcel('stop');">
	                                        </div>
	                                        <div style="width: 100%;">
	                                            <r:datacell 
	                                                id="datacell3"
	                                                queryAction=""
	                                                xpath="EmppostVo"
	                                                submitXpath="EmppostVo"
	                                                paramFormId="datacell_formid" height="200px" width="100%"
	                                                freezeNumber="4"
	                                                pageSize="5"
	                                                >
                                                 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                                                 <r:field fieldName="emp_code" sortAt="none" label="唯一号" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="emp_name" sortAt="none" label="员工姓名" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="group_name" sortAt="none" label="公积金组" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="id_card_type_bd" sortAt="none" label="证件类型" allowModify="false">
                                                    <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                                                 </r:field>
                                                 <r:field fieldName="id_card" sortAt="none" label="证件号码" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="cust_code" sortAt="none" label="客户编号" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="cust_name" sortAt="none" label="客户名称" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="account" sortAt="none" label="公积金帐号" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="hire_unit_short_name" sortAt="none" label="福利办理方" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="tran_name" sortAt="none" label="办理人" allowModify="false">
                                                 </r:field>
                                                 <r:field fieldName="tran_date" sortAt="none" label="办理时间" allowModify="false">
                                                 </r:field>
	                                            </r:datacell>
	                                        </div>
                                        </div>
								</div>
							</div>
						</div>
					</form>
					<script language="javascript">
					   $id("datacell1").isQueryFirst=false;
					    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
					    function simpleQuery_onClick(){  //简单的模糊查询'
					        var searchFlag = true;
					        var startMonth = document.getElementById("startMonth").value;
					        var endMonth = document.getElementById("endMonth").value;
					        if(startMonth == "" && endMonth == ""){
					           alert("请填写统计月份区间，至少填写一项！");
					        }else{
					           //校验查询条件日期是否符合要求
					           searchFlag = checkMonth(startMonth,endMonth);
					           if(searchFlag){
	                                $id("datacell1").loadData();
	                                $id("datacell1").refresh();
	                            }else{
	                               return;
	                            }
					        }
					    }
					    
					    //校验查询条件日期是否符合要求
                        function checkMonth(startMonth,endMonth){
                            var flag = true;
                            var reg = new RegExp("^[0-9]*$");
                            if(startMonth != ""){
                                if(!reg.test(startMonth)){
                                    flag = false;
                                    alert("开始日期格式不正确，请输入6位连续数字!");
                                }
                            }
                            
                            if(endMonth != ""){
                                if(!reg.test(endMonth)){
                                     flag = false;
                                    alert("结束日期格式不正确，请输入6位连续数字!");
                                }
                            }
                            return flag;
                        }
					    
					    //设置单选按钮已经事件
					    function setRadioStatus(value,entity,rowNo,cellNo){
					        var transactManID =  entity.getValue("transact_man");
                            var stopManID =  entity.getValue("stop_man");
                            var month = entity.getValue("transact_date_str");
					        return "<input type='radio'  id='r_"+rowNo+"'  name='radio_template' onclick='getDetail(\""+transactManID+"\",\""+stopManID+"\",\""+month+"\");'>";
					    }
					    
					    var overAllMonth = "";
					    var overTransactMan = "";
					    var overStopMan = "";
					    
					    //获取明细list
					    function getDetail(transactMan,stopMan,month){
					       overAllMonth = month;
					       overTransactMan = stopMan;
					       overStopMan = stopMan;
					       
					       var groupType = document.getElementById("groupType").value;
                           var operatorID = document.getElementById("operatorID").value;
                           var conditionStr = "&transactMan="+transactMan+"&stopMan="+stopMan+"&groupType="+groupType+"&month="+month+"&operatorID="+operatorID;
                           //if(transactMan != "" && transactMan != null && transactMan != "null"){
                                $id("datacell2").queryAction="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailForWorkloadStatistics&detailType=tran"+conditionStr;
                                $id("datacell2").loadData();
                                $id("datacell2").refresh();
                           //}
                           //if(stopMan != "" && stopMan != null && stopMan != "null"){
                                $id("datacell3").queryAction="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=detailForWorkloadStatistics&detailType=stop"+conditionStr;
                                $id("datacell3").loadData();
                                $id("datacell3").refresh();
                           //}
                        }
                        
                        //导出明细
                        function exportExcel(type){
                           //groupType    startMonth      endMonth    operatorID
                           var startMonth = document.getElementById("startMonth").value;
                           var endMonth = document.getElementById("endMonth").value;
                           var groupType = document.getElementById("groupType").value;
                           var operatorID = document.getElementById("operatorID").value;
                           //拼装查询条件
                           var conditionStr = "&detailType="+type+"&transactMan="+overTransactMan+"&stopMan="+overStopMan+"&groupType="+groupType+"&month="+overAllMonth+"&operatorID="+operatorID+"&startMonth="+startMonth+"&endMonth="+endMonth;
						   conditionStr = encodeURI(conditionStr);//编码json
						   var form = document.getElementById("datacell_formid");
						   form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcelForWorkLoad"+conditionStr;
						   form.submit();
                        }
					</script>
				</body>
		</fmt:bundle>
</html>
