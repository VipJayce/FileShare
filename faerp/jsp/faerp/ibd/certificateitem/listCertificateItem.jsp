<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%@ page import="rayoo.employeepost.empinfo.employee.util.IEmployeeConstants" %>
<%
EmployeeVo resultVo = null;  //定义一个临时的vo变量
resultVo = (EmployeeVo)request.getAttribute(IEmployeeConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
RmVoHelper.null2Nothing(resultVo);//把vo中的每个值过滤
%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>IBD证件管理List页面</title>
    <script language="javascript">
    function simpleQuery_onClick(){  //简单的模糊查询'
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function setRadioStatus(value,entity,rowNo,cellNo){
        return "<input type='radio' name='checkbox_template' value='"+value+"' >";
    }
    
    function addDataCellRow(){
        var datacell = $id("datacell1");
        datacell.addRow();
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);
        datasettr.setProperty("status","${certificateStatus}");
        $id("credentials_name_list").selectOptionByIndex(0);
    }
    
    function delDataCellRow(){
        if(confirm("是否删除当前选中数据?")){
                $id("datacell1").deleteRow();
		        //$id("datacell1").submit();
		        //$id("datacell1").loadData();
		        //$id("datacell1").refresh();
        }else{
              return false;
        } 
    }
    
    function submitDataCell(){
        $id("datacell1").submit();
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //判断所选择的证件类型是否已经存在
    function checkMaterialType(){
        var comSelect = "";
        comSelect = this;
        var typeValueChoose = comSelect.getValue();
        var empId = jQuery("#empId").val();
        
        var url = "<%=request.getContextPath()%>/CertificateAction.do?cmd=checkMaterialType&mid="+typeValueChoose+"&emp_id="+empId;
        
        jQuery.post(url,function(msg){
            if(msg=="-1"){
                alert("有前置证件未办理！");
                $id("datacell1").deleteRow();
            }else{
                return;
            }
        });
       /**
       var typeValueChoose = this.getValue();
       if(typeValueChoose != ""){
            var datacell1Obj = $id("datacell1");
	        var radios = _$("input[type='radio']");
	        for (var i = 0;i < radios.length-1;i++){
	             var row = datacell1Obj.table.tBodies[0].rows[i];
	             var entity = datacell1Obj.getEntity(row);
	             var typeVal = entity.getValue("credentials_type_id");
	             if(typeVal == typeValueChoose){
	                  alert("证件已存在! ");
	                  $id("credentials_name_list").selectOptionByIndex(0);
	                  break;
	              }else{
	                   var typeArray = "${hasTypeId}".split(";");
	                   for(var i = 0 ; i < typeArray.length ; i++){
	                       var detailsArray = typeArray[i].split(",");
	                       if(detailsArray[0] == typeValueChoose){
	                           var alertString = "";
	                           if(detailsArray[1] == "1000"){
	                               alertString = "该证件正在办理中！";
	                           }else if(detailsArray[1] == "1001"){
	                               alertString = "该证件已办理!";
	                           }else{
	                               alertString = "该证件处于办理受阻状态!";
	                           }
                             alert("证件已存在! "+alertString);
                             $id("credentials_name_list").selectOptionByIndex(0);
                             break;
                         }
	                   }
	              }
	        }
       }
       **/
    }
</script>
    </head>
    <body>

    <form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="cmd" value="">
    <input type="hidden" id="empId" name="empId" value="${empId}" />
	    <div id="right">
		      <div class="ringht_s">
				        <div class="box_3">
						    <div class="xz_title">员工基本信息</div>
						    <table width="100%" height="40" border="0" cellpadding="0"
						        cellspacing="1" bgcolor="#c5dbe2">
						        <tr valign="middle">
						            <td class="td_1">客户</td>
						            <td class="td_2">${employee.cust_name }</td>
						            <td class="td_1">唯一号</td>
						            <td class="td_2">${employee.emp_code }</td>
						        </tr>
						        <tr valign="middle">
						            <td class="td_1">姓名</td>
						            <td class="td_2">
						                  ${employee.emp_name }  
						                  <a href="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=detail&id=${employee.id}&backType=has"> 
						              <font color="blue">&nbsp;&nbsp;详细&nbsp;>></font>
                                          </a>
                                    </td>
						            <td class="td_1">国籍</td>
						            <td class="td_2">${employee.country_name}</td>
						        </tr>
						        <tr valign="middle">
                                    <td class="td_1">证件号码</td>
                                    <td class="td_2">${employee.id_card }</td>
                                    <td class="td_1">E-mail</td>
                                    <td class="td_2">${employee.email }</td>
                                </tr>
						        <tr valign="middle">
						            <td class="td_1">联系地址</td>
						            <td class="td_2">${employee.address }</td>
						            <td class="td_1">联系电话</td>
						            <td class="td_2">${employee.tel }</td>
						        </tr>
						    </table>
				        </div>
				        <!--表格 -->
					        <div class="box_3">
					           <div class="xz_title">已有证件</div>
					           <div class="button">
                                      <div class="button_right">
                                        <ul>
                                          <li class="c"><a onclick="addDataCellRow();">新增</a></li>
                                          <li class="d"><a onclick="delDataCellRow();">删除</a></li>
                                        </ul>
                                      </div>
                                </div>
					        </div>
					        <div class="clear"></div>
					        <div>
					            <div style="margin-left: 20px;">
					              <r:datacell id="datacell1" width="96%" height="150px" xpath="CertificateItemVo" submitXpath="CertificateItemVo" paramFormId="datacell_formid"
					                       queryAction="/FAERP/CertificateItemAction.do?cmd=detailForEmp&empId=${empId}&isChecked=true&showAll=b" 
                                           submitAction="/FAERP/CertificateItemAction.do?cmd=updateCertificateItem&empId=${empId}">
					                       <!-- 
                                           submitAction="/FAERP/CertificateItemAction.do?cmd=detailForEmp&empId=${empId}" -->
					                     <r:field fieldName="id" label="" width="100px" sortAt="none" onRefreshFunc="setRadioStatus"  align="center"></r:field>
					                     <r:field fieldName="credentials_type_id" label="证件" width="200" allowModify="false">
					                           <r:comboSelect id="credentials_name_list" name="credentialsId" onChangeFunc="checkMaterialType;"
						                               queryAction="/FAERP/CertificateItemAction.do?cmd=getCredentialsTypes&empId=${empId}"
						                               valueField="id"
						                               textField="credentials_name"
						                               xpath="CredentialsTypeVo"
						                               width="100px"
						                               nullText="--请选择--"
						                               validateAttr="message=证件类型;allowNull=false"
						                        />
					                     </r:field>
					                     <!--<r:field fieldName="status" label="状态" width="100" allowModify="false">
					                         <d:select name="status" id="status" dictTypeId="CERTIFICATE_STATUS" nullLabel="请选择"></d:select>
					                     </r:field>-->
					                     <r:field fieldName="time_limit" label="有效期限(月)" width="120">
                                                   <h:text validateAttr="type=naturalNumber;message=有效期必须为数组;allowNull=true"/>
                                            </r:field>
					                     <r:field fieldName="start_time" label="签发日期" width="200">
					                           <w:date allowInput="true" id="start_time" name="start_time" format="YYYY-MM-DD" property="bean/start_time" width="190px" />
					                      </r:field>
					                     <r:field fieldName="end_time" label="到期日期" width="200">
					                          <w:date allowInput="true" id="end_time" name="end_time" format="YYYY-MM-DD" property="bean/end_time" width="190px" />
					                     </r:field>
					                     <r:field fieldName="remark" label="备注" width="300">
					                           <h:text validateAttr="maxLength=100;allowNull=true"/>
					                     </r:field>
					                 </r:datacell>
					            </div>
					·             <div class="xz_button" style=" padding-left: 400px;">
					              <input type="button" class="icon_2" value="提交" onClick="submitDataCell();"/>
					                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					              <input name="button" type="button" class="icon_2" value="返回" onClick="location.href='<%=request.getContextPath()%>/CertificateAction.do?cmd=queryAll'"/>
					        </div>
				      </div>
		           </div>
		    </div>
	  </div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>