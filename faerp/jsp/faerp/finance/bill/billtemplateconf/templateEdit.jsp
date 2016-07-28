<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>

<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
jQuery(function(){
	jQuery("#rowIndex").val('${param.rowIndex }');
	jQuery("#appName").val('${param.appName }');
	jQuery("#titleRows").val('${param.titleRows }');
});


    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/BillTemplateConfigAction.do?cmd=queryAll";
        form.submit();
    }
    
    function removeAll() {
    	var datacell = $id("grdCityEnsureTbody");
        var dataset = datacell.dataset;
        for (var i = dataset.getLength() - 1; i >= 0; i--) { // 循环checkbox组
        	var  entity=dataset.get(i);
             if(entity!=null){
	             dataset.removeEntity(entity, true);
             }
        }
        datacell.refresh();
    }
    
    function resolveModel(){//调接口解析用户上传模板
    	 var filePath = jQuery("#file").val();
    	 var rowIndex = jQuery("#rowIndex").val();
    	 var templateId = '${param.templateId }';
		if (rowIndex == null || rowIndex == '') {
		alert("标题起始行不能为空");
		return false;
 		}

        <%--  $id("grdCityEnsureTbody").queryAction = "<%=request.getContextPath()%>/BillTemplateConfigAction.do?cmd=uploadTemplate&filePath="
        		 +encodeURIComponent(filePath)+"&rowIndex="+rowIndex+"&templateId="+templateId;
         $id("grdCityEnsureTbody").loadData();
         $id("grdCityEnsureTbody").refresh(); --%>
         
         jQuery.getJSON("<%=request.getContextPath()%>/BillTemplateConfigAction.do?cmd=uploadTemplate&filePath="
        		 +encodeURIComponent(filePath)+"&rowIndex="+rowIndex+"&templateId="+templateId,   function(json){
             
             if(json.error!=null&&json.error!="")
             {
                   alert(json.error);
             }
             if(json.beans!=null&&json.beans!="")
             {
            	 jQuery("#uploadUrl").val(json.uploadUrl);
            	 //alert(jQuery("#uploadUrl").val());
            	 removeAll();
                for(var i = 0 ;i<json.beans.length;i++)
               {
                      var newEntity =  $id("grdCityEnsureTbody").styleEntity.clone(true);//只克隆行样式，不带值
                      newEntity.setProperty("excelColTag", json.beans[i].excelColTag);
                      newEntity.setProperty("excelColName", json.beans[i].excelColName);
                      newEntity.setProperty("billColId", json.beans[i].billColId);
                      newEntity.setProperty("templateFormula", json.beans[i].templateFormula);
                      newEntity.setProperty("isDisplay", json.beans[i].isDisplay);
                      newEntity.setProperty("isZero", json.beans[i].isZero);
                      newEntity.setProperty("isTotal", json.beans[i].isTotal);
                      $id("grdCityEnsureTbody").addRow(newEntity);
               } 
             }
             });

    }

    function submit_onClick(){//表单提交\
      var frm = $id("datacell_formid");

      //表单验证
      if( !checkForm(frm) ) {
			
          return;
      }
        if(checkAllCont()){
            var dc1 = $id("grdCityEnsureTbody");
    		var beginTime = jQuery("#beginTime").val();
    		var titleRows = jQuery("#titleRows").val();
    		var rowIndex = jQuery("#rowIndex").val();
    		var appName = jQuery("#appName").val();
    		var uploadUrl = jQuery("#uploadUrl").val();
    		var updateParam = beginTime+","+titleRows+","+rowIndex+","+appName+","+uploadUrl;
    		
    		var templateId = '${param.templateId }';
   			var customerId = '${param.customerId }';
   			var customerCode= '${param.customerCode }';
   			var customerName= '${param.customerName }';
   			var costCenterId= '${param.costCenterId }';
   			var costCenterName= '${param.costCenterName }';
    		var insertParam = customerId+","+customerCode+","+customerName+","+costCenterId+","+costCenterName;
            var action = "<%=request.getContextPath()%>/BillTemplateConfigAction.do?cmd=saveTemplate&templateId="
            		+templateId+"&updateParam="+updateParam+"&insertParam="+encodeURIComponent(insertParam);
            var xmlSubmit = dc1.dataset.toString();
            var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
                      alert("保存成功！");
                 }else if( myAjax.getValue("root/data/returnValue").split(",")[0] == -1 ) {
                      alert( myAjax.getValue("root/data/returnValue").split(",")[1] ); 
                 }else {
                      alert("保存失败！"); 
                 }
                  
                  jQuery("input[name='button_reset1']").removeAttr("disabled");
             }
        }

    }

	function checkAllCont() {//页面提交验证
		var ali = true;
		var applydate = jQuery("#beginTime").val();
		if (applydate == null || applydate == '') {
			alert("生效年月不能为空");
			ali = false;
			return ali;
		}else{
			var r = applydate.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
			if(r==null){
				alert("日期格式不正确");
				return false;
			}
		}
		var rowIndex = jQuery("#rowIndex").val();
		if (rowIndex == null || rowIndex == '') {
			alert("标题起始行不能为空");
			ali = false;
			return ali;
		}
		var titleRows = jQuery("#titleRows").val();
		if (titleRows == null || titleRows == '') {
			alert("标题行数不能为空");
			ali = false;
			return ali;
		}

		var appName = jQuery("#appName").val();
		if (appName == null || appName == '') {
			alert("系统类型不能为空");
			ali = false;
			return ali;
		}

		return true;

	}

	
</script>
<script language="javascript">
//打开文件上传对话框
function UploadFileWindow(){
    //w为窗口宽度，h为高度
    var w = 400;
    var h = 150;
    var l = (screen.width - w) / 2;
    var t = (screen.height - h) / 2;
    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l;
    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no';
    window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
}
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input name="isLimitUpperAndLower" type="hidden" value="${isLimitUpperAndLower }"/>
<div id="right">
    <div class="right_title_bg">
        <div class=" right_title">模板配置</div>
    </div>

  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" >
        <tr>
            <td width="55" rowspan="10" style="padding-top:0;" nowrap="nowrap"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
        	<input type="hidden" id="templateId" name="templateId" value="${param.templateId} }">
            <td align="right">客户名称</td>
             <td align="left" width="210">
                 <input type="text" class="text_field" name="customerName" id="customerName" disabled="true" inputName="客户名称" value="${param.customerName}" maxLength="50"/>
             </td>
            <td align="right">明细显示</td>
            <td align="left">
            <select id="history-date-type" name="historyDateType">
													<option value="0" <c:if test="${0 == param.historyDateType }">selected="selected"</c:if>>正常显示</option>
													<option value="1" <c:if test="${1 == param.historyDateType }">selected="selected"</c:if>>合并显示</option>
													<option value="2" <c:if test="${2 == param.historyDateType }">selected="selected"</c:if>>列明细显示</option>
												</select>
                  </td>
             <td align="right">生效年月</td>
            <td align="left"><input type="text" class="text_field" name="beginTime" id="beginTime" value="${param.beginTime }" inputName="生效日期" maxLength="50"/><font color="red">(1990-01-01)</font></td>
        </tr>
        <tr>   </tr>
        <tr>   </tr>
        <tr>   </tr>
        <tr>
    <td align="right">模板上传</td>
    <td align="left">
               <!--  <input type="text" id="attachNameInput" class="text_field_reference_readonly" id="attachNameInput" name="attachNameInput" inputName="附件地址" value="" hiddenInputId="attach_name"/>
               <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
               <input type="hidden" id="attackAddressInput" name="attach_address" value="">-->
               <input type="file" id="file" name="file"  validate="notNull;"  inputName="选择文件"  >
               <input type="hidden" id="uploadUrl" name="uploadUrl" value="">
    </td>
     <td align="right">标题起始行</td>
    <td align="left">
               <select id="rowIndex" name="rowIndex" >
													<option value="">请选择</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
													<option value="13">13</option>
													<option value="14">14</option>
													<option value="15">15</option>
													<option value="16">16</option>
													<option value="17">17</option>
												</select>
    </td>
     <td align="right">标题行数</td>
    <td align="left">
               <select id="titleRows" name="titleRows">
													<option value="">请选择</option>
													<option value="1">1</option>
													<option value="2">2</option>
												</select>
    </td>
  </tr>
  <tr>
  	<td align="right">所属系统</td>
    <td align="left">
              <select id="appName" name="appName">
													<option value="">请选择</option>
													<option value="ERP">ERP</option>
													<option value="BPO">BPO</option>
												</select>
    </td>
    <td align="right">    </td>
    <td align="left">
                  <input type="button" class="icon_2" value='上传解析' onClick="javascript:resolveModel();"  />
    </td>
  </tr>
	</table>

    <!--社保公积金产品列表 -->
    <div id="values_div">
                    <r:datacell
                         id="grdCityEnsureTbody"
                         queryAction="/FAERP/BillTemplateConfigAction.do?cmd=getEditTemplateData&templateId=${param.templateId }"
                         submitAction="/FAERP/BillTemplateConfigAction.do?cmd=saveTemplateCol"
                         width="100%"
                         xpath="BillTemplateColDTO"
                         submitXpath="BillTemplateColDTO"
                         paramFormId="datacell_formid"
                         pageSize="-1" readonly="false"
                         >
                         <!--<r:field  fieldName="id_index" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus" sortAt="none">
                         </r:field>-->
                         <r:field  fieldName="excelColTag"  label="Excel列标" width="100">
                         </r:field>
                         <r:field fieldName="excelColName" label="Excel列名" width="200">
                         </r:field>
                         <r:field fieldName="billColId" label="系统项目名称" 
							width="200px">
							<r:comboSelect id="billColName" name="billColName"
								queryAction="/FAERP/BillTemplateConfigAction.do?cmd=queryTemplateBaseData&flag=queryAll"
								textField="colName" valueField="billColId" nullText="请选择"
								xpath="BillCol" width="200px" />
						</r:field>
                         <r:field fieldName="templateFormula" label="公式" allowModify="true" width="200">
                          <h:text  onchange=""/>
                         </r:field>
                         <r:field fieldName="isDisplay" label="列显示" width="100">
                         <h:switchCheckbox id="status" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field fieldName="isZero" width="100" label="空值是否显示0">
                         <h:switchCheckbox id="status" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field fieldName="isTotal" width="100" label="列合计">
                         <h:switchCheckbox id="status" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                       </r:datacell>

    </div>

    <!--社保公积金产品列表 end-->
    </div>


<div id="ccParent1" class="button">
    <div class="button_right">
    <center>
    <input class="e" type="button"   value="保存"   onClick="submit_onClick();">
      <input class="e" type="button"   value="返回"  onClick="back_onClick();">
      </center>
    </div>
    <div class="clear"></div>
</div>




</form>
</fmt:bundle>

</body>
</html>