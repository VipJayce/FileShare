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
    var temp = "";
    var filesString = "";
    var certificateItemId = "";
    var certificateTypeID="";
    var flag = true;
    function setRadioStatus(value,entity,rowNo,cellNo){
        certificateTypeID = entity.getValue("credentials_type_id");
        return "<input type='radio' id='r_"+rowNo+"'  name='radio_template' value='"+value+"' onclick='refreshDataCell3(\""+ value +"\");'>";
    }
    
    function setCheckBoxStatus(value,entity,rowNo,cellNo){
        var checkbox = "<input type='checkbox'  id='sc_"+rowNo+"' name='checkbox_template' value='"+value+"' onclick='fileDefaultDate(\"" +rowNo+"\");' />";
        return checkbox;
    }
    
    function addDataCellRow(){
        if($id("datacell3").isModefied){
            if(confirm("是否以修改的员工证件信息,以及相关证件材料?")){
                submitDataCell();
            }
        }
        $id("datacell2").addRow();
        var datacell2Entity= $id("datacell2").getActiveEntity();
        datacell2Entity.setProperty("id","isnull");
        $id("credentials_name_list").selectOptionByIndex(0);
        //$id("credentials_name_list").selectOptionByIndex(0);
    }
    
    function delDataCellRow(){
        var delFlag = false;
        var obj = $id("datacell2");
        _$("input[type='radio']").each(function(i) {
            if (_$(this).attr("checked")) {
                if (_$(this).attr("checked")) {
                    delFlag = true;
                }
            }
        });
        if(delFlag){
            
            
            if(confirm("是否删除当前选中数据,以及相关证件材料?")){
	                $id("datacell2").deleteRow();
	                $id("datacell3").loadData();
	                $id("datacell3").refresh();
	        }else{
	              return false;
	        }
	        $id("datacell3").clear()
	        //$id("datacell3").queryAction = "<%=request.getContextPath()%>/CertificateItemAction.do?cmd=getCredentialsMateria";
	        //$id("datacell3").loadData();
	        //$id("datacell3").refresh();
	        
        }else{
            alert("请选择要删除的数据!");            
        }
    }
    
    //选中证件后刷新该证件所需资料列表
    function refreshDataCell3(value){
        if(certificateItemId == "" || certificateItemId == null || certificateItemId == "null"){
            certificateItemId = value;
            changeRadio(certificateItemId);
        }else{
            if($id("datacell3").isModefied == true){
	             if(confirm("证件材料信息已变更，是否保存?")){
	               if(certificateItemId == "isnull"){
	                   certificateItemId = "";
	                   submitDataCell();
	               }else{
	                   if($id("datacell2").isModefied == true){
                            $id("datacell2").submit();
                        }
                        $id("datacell3").submitAction = "/FAERP/CertificateMaterialAction.do?cmd=updateCertificateMaterial&empId=${empId}&certificateItemId="+certificateItemId;
                        $id("datacell3").submit();
				        $id("datacell3").loadData();
				        $id("datacell3").refresh();
	               }
	             }
	         }
	         certificateItemId = value;
	         changeRadio(certificateItemId);
        }
    }
    
    function changeRadio(itemId){
        var certificateTypeID = "";
        var dc = $id("datacell2");
        var ds = dc.dataset;
        var flag = true;
        _$("input[type='radio']").each(function(i) {
            if (_$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];
                var entity = dc.getEntity(row);
                certificateTypeID = entity.getValue("credentials_type_id");
                if (!certificateTypeID || certificateTypeID == ""){
                    alert("未选择证件，无法读取材料信息！") ;
                    flag = false;
                }
            }
        });
        
        if(flag){
	        document.getElementById("certificateTypeID").value=certificateTypeID;
	        $id("datacell3").queryAction = "<%=request.getContextPath()%>/CertificateItemAction.do?cmd=getCredentialsMateria&certificateTypeID="+certificateTypeID+"&itemId="+itemId;
	        $id("datacell3").loadData();
	        $id("datacell3").refresh();
        }
        flag = true;
    }
    
    //修改办理状态时，如果状态改为了已办理，则默认给定办理日期为当前日期
    function statusDefaultDate(val){
	    var datacell = $id("datacell2");
	    var activeRow = datacell.activeRow;
	    var datasettr = datacell.getEntity(activeRow);
	    var fullDate = getDate(); 
	    if(val == "1001"){
	       _$("input[type='radio']").each(function(i) {
	           var row = datacell.table.tBodies[0].rows[i];
               var entity = datacell.getEntity(row);
	            if (_$(this).attr("checked")) {
	                var selectedId = "r_"+i;
	                datacell.selectRow(row);
	                entity.setProperty("processing_time",fullDate);
	                _jQuery("#"+selectedId).attr("checked", true);
	            }else{
	               //entity.setProperty("processing_time","");
                   //_jQuery("#"+selectedId).attr("checked", false);
	            }
	        });
	    }
    }
    
    //当选中某条材料时，同时给定收取日期为当前日期
    function fileDefaultDate(rowNo){
        var datacell = $id("datacell3");
        var fullDate = getDate();
        var dataset = datacell.dataset;
        var aa ="sc_"+rowNo;
        var row = datacell.table.tBodies[0].rows[rowNo];
        var entity = datacell.getEntity(row);
        datacell.selectRow(row);
        var materialId = entity.getValue("id");
        var materialName = entity.getValue("material_name");
          if($id(aa).checked){//勾选上
	           entity.setProperty("receive_time",fullDate);
	           _jQuery("#"+aa).attr("checked", true);
	       }else{
	            dataset.get(rowNo).setProperty("receive_time","");
	            _jQuery("#"+aa).attr("checked", false);
	       }
       var receiveTime = entity.getValue("receive_time");
    }


    //获取系统当前日期
    function getDate(){
        var fullDate = "";
        var myDate = new Date();
        var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
        var month = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
        var day = myDate.getDate();        //获取当前日(1-31)
        if(month<10){
          month = "0"+month; 
        }
        if(day<10){
          day = "0"+day; 
        }
        fullDate = year+"-"+month+"-"+day;
        return fullDate;
    }
    
    function submitDataCell(){
        flag = true;
        var jsonStr = "";
         if($id("datacell3").isModefied == true){
            var datacell3Obj = $id("datacell3");
            _$("input[type='checkbox']").each(function(i) {
                 var row = datacell3Obj.table.tBodies[0].rows[i];
                 var entity = datacell3Obj.getEntity(row);
                 if (_$(this).attr("checked")) {
                     var creMateriaID = entity.getValue("credentials_materia_id");
                     var receiveTime = entity.getValue("receive_time");
                     var materialName = entity.getValue("material_name");
                     jsonStr += creMateriaID+","+receiveTime+";";
                 }
              });
        }
        if($id("datacell2").isModefied == true){
            $id("datacell2").submitAction = "/FAERP/CertificateMaterialAction.do?cmd=updateCertificateMaterial&empId=${empId}&jsonStr="+jsonStr+"&certificateTypeID="+certificateTypeID;
            $id("datacell2").submit();
        }
         if($id("datacell3").isModefied == true){
            $id("datacell3").submitAction = "/FAERP/CertificateMaterialAction.do?cmd=updateCertificateMaterial&empId=${empId}&certificateItemId="+certificateItemId;
	         $id("datacell3").submit();
         }
         $id("datacell3").loadData();
         $id("datacell3").refresh();
         $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    jQuery(document).ready(function() {
        var datacell3Obj = $id("datacell3");
	    $id("datacell3").afterRefresh = function(){
	       _$("input[type='checkbox']").each(function(i) {
               var row = datacell3Obj.table.tBodies[0].rows[i];
               var entity = datacell3Obj.getEntity(row);
               var id = entity.getValue("id");
                if (id != "" && id != "null" && id != null) {
                    datacell3Obj.selectRow(row);
                    _$(this).attr("checked","checked");
                    _$(this).attr("disabled","disabled");
                }
            });
	    }
	});
	
	//判断所选择的证件类型是否可以进行添加
	function checkMaterialType(){
	    var comSelect = "";
        comSelect = this;
        var typeValueChoose = comSelect.getValue();
        var empId = jQuery("#empId").val();
        
	    var url = "<%=request.getContextPath()%>/CertificateAction.do?cmd=checkMaterialType&mid="+typeValueChoose+"&emp_id="+empId;
        
        jQuery.post(url,function(msg){
            if(msg=="-1"){
                alert("有前置证件未办理！");
                $id("datacell2").deleteRow();
            }else{
                return;
            }
        });
	   /**
	   if(flag == true){
	       var comSelect = "";
	       comSelect = this;
	       var typeValueChoose = comSelect.getValue();
	       var datacell2Obj = $id("datacell2");
	       var radios = _$("input[type='radio']");
	       for (var i = 0;i < radios.length-1;i++){
	            var row = datacell2Obj.table.tBodies[0].rows[i];
	            var entity = datacell2Obj.getEntity(row);
	            var typeVal = entity.getValue("credentials_type_id");
	            if(typeVal == typeValueChoose){
	                alert("证件已存在! ");
	                $id("credentials_name_list").selectOptionByIndex(0);
	                break;
	            }
	       }
	       
	       var datacell1Obj = $id("datacell1");
	       var rows = datacell1Obj.getCurrentRowCount();
	       for (var i = 0;i < rows;i++){
                var row = datacell1Obj.table.tBodies[0].rows[i];
                var entity = datacell1Obj.getEntity(row);
                var typeVal = entity.getValue("credentials_type_id");
                if(typeVal == typeValueChoose){
                    alert("证件已存在! ");
                    $id("credentials_name_list").selectOptionByIndex(0);
                    break;
                }
           }
	   }
	   **/
	}
	
    function submitPage(){
	   submitDataCell();
	   location.href='<%=request.getContextPath()%>/CertificateAction.do?cmd=queryAll';
	}
    
</script>
    </head>
    <body>
	    <div id="right">
		    <div class="right_title_bg">
		        <div class=" right_title">员工证件管理</div>
		    </div>
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
                                  <a href="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=detail&id=${employee.id}&backType=check"> 
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
			    <form name="form" method="post" id="datacell_formid" action="/FAERP/CertificateMaterialAction.do">
			        <input type="hidden" name="cmd" value="updateCertificateMaterial">
			        <input type="hidden" id="certificateTypeID" name="certificateTypeID" value="" />
			        <input type="hidden" id="certificateItemId" name="certificateItemId" value="" />
			        <input type="hidden" id="empId" name="empId" value="${empId}" />
			        <!--表格 -->
			        <div class="box_3">
				          <div class="xz_title">证件办理</div>
				          <div class="button">
				            <div class="button_right">
				              <ul>
				                <li class="c"><a onclick="addDataCellRow();">新增</a></li>
				                <li class="d"><a onclick="delDataCellRow();">删除</a></li>
				                <li class="bc"><a onclick="submitDataCell();">保存</a></li>
				              </ul>
				            </div>
				            <div class="clear"></div>
				          </div>
			        </div>
			            <div style="float: left;width:60%;margin-left: 20px;margin-right: 20px;">
			              <r:datacell id="datacell2" width="100%" height="150px" xpath="CertificateItemVo" submitXpath="CertificateItemVo" paramFormId="datacell_formid"
			                      queryAction="/FAERP/CertificateItemAction.do?cmd=detailForEmp&empId=${empId}&isChecked=false&showAll=c" 
			                      submitAction="/FAERP/CertificateMaterialAction.do?cmd=updateCertificateMaterial&empId=${empId}">
			                      <!-- submitAction="/FAERP/CertificateMaterialAction.do?cmd=updateCertificateMaterial&empId=${empId}"> -->
			                    <r:field fieldName="id" label="" width="30px" sortAt="none" onRefreshFunc="setRadioStatus"  align="center"></r:field>
			                    <r:field fieldName="credentials_type_id" label="证件" width="200" allowModify="false">
	                                  <r:comboSelect id="credentials_name_list" name="credentialsId" onChangeFunc="checkMaterialType;"
                                                       queryAction="/FAERP/CertificateItemAction.do?cmd=getCredentialsTypes"
                                                       valueField="id"
                                                       textField="credentials_name"
                                                       xpath="CredentialsTypeVo"
                                                       width="100px"
                                                       nullText="--请选择--"
                                                       validateAttr="message=证件类型;allowNull=false"
                                                />
	                            </r:field>
			                    <r:field fieldName="status" label="状态" width="100" defaultValue="1000">
			                        <d:select name="status" id="status" dictTypeId="CERTIFICATE_STATUS" onchange="statusDefaultDate(this.value);" ></d:select>
			                    </r:field>
			                    <r:field fieldName="processing_time" label="办理日期" width="150">
		                              <w:date allowInput="true" id="processing_time2" name="processing_time2" format="YYYY-MM-DD" property="bean/processing_time" width="150px" />
		                        </r:field>
		                        <r:field fieldName="time_limit" label="有效期限(月)" width="100">
		                               <h:text validateAttr="type=naturalNumber;message=有效期必须为数组;allowNull=true"/>
		                        </r:field>
		                        <r:field fieldName="start_time" label="签发日期" width="150">
		                              <w:date allowInput="true" id="start_time2" name="start_time2" format="YYYY-MM-DD" property="bean/start_time" width="150px" />
		                        </r:field>
		                        <r:field fieldName="end_time" label="到期日期" width="150">
		                              <w:date allowInput="true" id="end_time2" name="end_time2" format="YYYY-MM-DD" property="bean/end_time" width="150px" />
		                        </r:field>
			                    <r:field fieldName="remark" label="备注" width="200">
			                          <h:text validateAttr="maxLength=100;allowNull=true"/>
			                    </r:field>
			                    <r:field fieldName="materials" label="" width="0"></r:field>
			                </r:datacell>
			          </div>
			          <div style="width:90%;">
			              <r:datacell id="datacell3" width="100%" height="150px" xpath="CertificateMaterialVo" submitXpath="CertificateMaterialVo" paramFormId="datacell_formid"
			                      queryAction="" submitAction="" >
			                    <r:field fieldName="id" label="" width="30" sortAt="none" onRefreshFunc="setCheckBoxStatus"  align="center"></r:field>
			                    <r:field fieldName="material_name" label="材料" width="170"></r:field>
			                    <r:field fieldName="receive_time" label="收取日期" width="170">
			                        <w:date allowInput="true" id="receive_time1" name="receive_time1" format="YYYY-MM-DD" property="bean/receive_time" width="170px" />
			                    </r:field>
			                </r:datacell>
			          </div>
			     </form>
		        <div class="box_3" style="margin-bottom: -2px;">
                   <div class="xz_title">已办理证件</div>
                </div>
                <div style="margin-left: 20px;">
                    <r:datacell id="datacell1" queryAction="/FAERP/CertificateItemAction.do?cmd=detailForEmp&empId=${empId}&isChecked=true&showAll=a"
                        width="96%" height="150px" xpath="CertificateItemVo" submitXpath="CertificateItemVo" paramFormId="datacell_formid">
                        <r:field fieldName="credentials_name" label="证件" width="200" ></r:field>
                        <!--<r:field fieldName="status" label="状态" width="100" allowModify="false">
                            <d:select name="status" id="status" dictTypeId="CERTIFICATE_STATUS" ></d:select>
                        </r:field>-->
                        <r:field fieldName="processing_time" label="办理日期" width="150" allowModify="false">
                              <w:date allowInput="true" id="processing_time" name="processing_time" format="YYYY-MM-DD" property="bean/processing_time" width="150px" />
                        </r:field>
                        <r:field fieldName="time_limit" label="有效期限(月)" width="100"></r:field>
                        <r:field fieldName="start_time" label="签发日期" width="150" allowModify="false">
                              <w:date allowInput="true" id="start_time" name="start_time" format="YYYY-MM-DD" property="bean/start_time" width="150px" />
                        </r:field>
                        <r:field fieldName="end_time" label="到期日期" width="150" allowModify="false">
                              <w:date allowInput="true" id="end_time" name="end_time" format="YYYY-MM-DD" property="bean/end_time" width="150px" />
                        </r:field>
                        <r:field fieldName="remark" label="备注" width="370"></r:field>
                    </r:datacell>
                </div>
		        <!--表格 end-->
			    <div class="xz_button" style="padding-left: 400px;">
			         <input type="button" class="icon_2" value="提交" onClick="javascript:submitPage();"/>
			          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			          <input name="button" type="button" class="icon_2" value="返回" onClick="location.href='<%=request.getContextPath()%>/CertificateAction.do?cmd=queryAll'"/>
			    </div>
		    </div>
	    </div>
</fmt:bundle>
</body>
</html>