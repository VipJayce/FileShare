<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/controldata.js"></script>
<script type='text/javascript' src="<venus:base/>/js/dd/common.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/gap-ajaxList.js"></script>
<script type='text/javascript' src='<venus:base/>/dwrdd/interface/ControlDataService.js'></script>
<script type='text/javascript' src='<venus:base/>/dwr/engine.js'></script>
<script type='text/javascript' src='<venus:base/>/dwr/util.js'></script>
</head>
<body onload="init()" >
<script language="javascript">
	writeTableTop('<fmt:message key="controldata.page_field_edit"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<script language="javascript">
	var params = dialogArguments;
	var field = params[0];
	if(field==null)
	{
		field=getField();
		field.viewId=params[3];
		field.viewCode=params[4];
	}
	//alert(dwr.util.toDescriptiveString(field,2));
	var viewType = params[2];
	function init()
	{
		if(field.columnName!="")
		{
			jQuery("#name").attr("readOnly","true");
			jQuery("#columnSql").parent().parent().css("display","none");
		}
		if(viewType=="1")
		{
			<!--列表视图：名称,是否启用,说明,计算公式,是否显示,显示序号,排序编号-->	
			//document.getElementById("displayType").parentNode.parentNode.style.display="none";
			//document.getElementById("refModel").parentNode.parentNode.style.display="none";
			//document.getElementById("refSource").parentNode.parentNode.style.display="none";
			//document.getElementById("refSourceClass").parentNode.parentNode.style.display="none";
			//document.getElementById("condition").parentNode.parentNode.style.display="none";
			//document.getElementById("callBack").parentNode.parentNode.style.display="none";
			//document.getElementById("readOnly").parentNode.parentNode.style.display="none";
			DWREngine.setAsync(false); 
			loadRefSource(jQuery("#refSource"),'code','name');
			DWREngine.setAsync(true); 
		}else 
		{
			<!--编辑、查询视图：名称,是否启用,说明,显示类型,参照模型,数据来源,过滤条件,回调脚本,对应表,对应列,是否只读,是否显示,显示序号-->	
			jQuery("#columnSql").parent().parent().hide();
			jQuery("#sortNo").parent().parent().hide();
			jQuery("[name='sort']:first").parent().parent().hide();
			if(viewType=="3")
				jQuery("[name='readOnly']:first").parent().parent().hide();
			DWREngine.setAsync(false); 
			loadRefSource(jQuery("#refSource"),'code','name');
			DWREngine.setAsync(true); 
		}
		if(field.columnName=='')
		{
			jQuery("[name='sort']:first").parent().parent().hide();
		}
		setForms(field);
	}
	function loadRefSource(selectObject,key,value){
		if(selectObject.size()==1) {
			ControlDataService.findBaseDataTypes({callback:function(data){
					if (data != null && typeof data == 'object') 
					{
						setSelectForBean(selectObject.attr("id"),data,key,value);
					}
				}
			});
		}else{
			return;
		}
	}
</script>
<form id="form" name="form" method="post" >	
	<input id='id' name='id' type='hidden'></input>
	<input id='columnName' name='columnName' type='hidden'></input>
	<input id='tableName' name='tableName' type='hidden'></input>
	<input id='columnName' name='columnName' type='hidden'></input>
	<input id='viewId' name='viewId' type='hidden'></input>
	<input id='viewCode' name='viewCode' type='hidden'></input>
	<div id="controlPanel" style="padding:5px">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:save_onClick(params[0]);">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:cancel_onClick();">
	</div>	
    <div id="listView" >
	  	<div id="ccParent1"> 
			<table class="table_div_control">
				<tr> 
					<td>
						<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key="edit"  bundle="${applicationResources}"></fmt:message>
					</td>
				</tr>
			</table>
		</div>

		<div id="ccChild1" > 
			<table class="table_div_content" >
				<tr>
					<td align="right" ><fmt:message key="name"  bundle="${applicationResources}"></fmt:message></td>
					<td align="left" width="360px">
						<input id="name" name="name" type="text" class="text_field" inputName='<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>'  validate="notNull;notChinese" value="">			
					</td>
				</tr>
				<tr>
					<td align="right" ><fmt:message key="common.displayname" ></fmt:message></td>
					<td align="left" >
						<input id="displayName" name="displayName" type="text" class="text_field" inputName='<fmt:message key="common.displayname"  ></fmt:message>'   validate="" value="">			
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="common.status"/></td>
					<td align="left"><input type="radio"  name="status" value="1"
						checked/><fmt:message key="common.enable"/><input type="radio"  name="status" value="0"/><fmt:message key="common.disable"/></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_displaytype"/></td>
					<td colspan="3" align="left">
						<select id="displayType" name="displayType">
							<option value="0"><fmt:message key="controldata.label" /></option>
							<option value="1"><fmt:message key="controldata.text" /></option>
							<option value="2"><fmt:message key="controldata.integer" /></option>
							<option value="3"><fmt:message key="controldata.float" /></option>
							<option value="4"><fmt:message key="controldata.textarea" /></option>
							<option value="5"><fmt:message key="controldata.money" /></option>
							<option value="6"><fmt:message key="controldata.date" /></option>
							<option value="7"><fmt:message key="controldata.assist_tree" /></option>
							<option value="8"><fmt:message key="controldata.combobox" /></option>
							<option value="9"><fmt:message key="controldata.yesorno" /></option>
							<option value="10"><fmt:message key="controldata.button" /></option>
							<option value="11"><fmt:message key="controldata.toolbar_button" /></option>
							<option value="12"><fmt:message key="controldata.range_date" /></option>
							<option value="13"><fmt:message key="controldata.range_number" /></option>
							<option value="14"><fmt:message key="controldata.multi_select" /></option>
							<option value="15"><fmt:message key="controldata.upload" /></option>
							<option value="16"><fmt:message key="controldata.link" /></option>
							<option value="31"><fmt:message key="controldata.customcontrol1" /></option>
							<option value="32"><fmt:message key="controldata.customcontrol2" /></option>
							<option value="33"><fmt:message key="controldata.customcontrol3" /></option>
							<option value="34"><fmt:message key="controldata.customcontrol3" /></option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_initvalue"/></td>
					<td colspan="3" align="left">
						<input id="initValue" name="initValue" type="text" class="text_field" inputName="<fmt:message key="controldata.field_initvalue"/>"   validate="" value="">			
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_refmodel"/></td>
					<td colspan="3" align="left">
						<textarea class="textarea_limit_words" cols="36" rows="5" id="refModel" name="refModel" inputName='<fmt:message key="controldata.field_refmodel"/>' maxLength="512" ></textarea>
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_refsource"/></td>
					<td colspan="3" align="left">
						<select id="refSource" name="refSource" >
							<option value="">--<fmt:message key="common.select"/>--</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_condition"/></td>
					<td colspan="3" align="left">
						<textarea class="textarea_limit_words" cols="36" rows="5" id="condition" name="conditionStr" inputName='<fmt:message key="controldata.field_condition"/>' maxLength="512" ></textarea>
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_refsourceclass"/></td>
					<td colspan="3" align="left">
						<input id="refSourceClass" name="refSourceClass" type="text" class="text_field" inputName="<fmt:message key="controldata.field_refsourceclass"/>"   validate="" value="">			
					</td>
				</tr>				
				<tr>
					<td align="right"><fmt:message key="controldata.field_displayoriginvalue"/></td>
					<td align="left"><input type="radio"  name="displayOriginValue" value="1" checked
						/><fmt:message key="common.yes"/><input type="radio"  name="displayOriginValue" value="0" /><fmt:message key="common.no"/></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_keysource"/></td>
					<td align="left"><input type="radio"  name="keySource" value="1" checked
						/>id<input type="radio"  name="keySource" value="0" />code</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_callback"/></td>
					<td colspan="3" align="left">
						<textarea class="textarea_limit_words" cols="36" rows="5" id="callBack" name="callBack" inputName='<fmt:message key="controldata.field_callback"/>' maxLength="512" ></textarea>
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_columnsql"/></td>
					<td colspan="3" align="left">
						<textarea class="textarea_limit_words" cols="36" rows="5" id="columnSql" name="columnSql" inputName='<fmt:message key="controldata.field_columnsql"/>' maxLength="512" ></textarea>
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_readonly"/></td>
					<td align="left">
						<select id="readOnly" name="readOnly">
							<option value="0"><fmt:message key="controldata.no_readonly"/></option>
							<option value="1"><fmt:message key="controldata.readonly_when_modify"/></option>
							<option value="2"><fmt:message key="controldata.readonly_when_add"/></option>
							<option value="3"><fmt:message key="controldata.yes_readonly"/></option>
						</select>	
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_display"/></td>
					<td align="left"><input type="radio" name="display" value="1"
						checked/><fmt:message key="common.yes"/><input type="radio"  name="display" value="0"/><fmt:message key="common.no"/></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_sort"/></td>
					<td align="left"><input type="radio" name="sort" value="1" checked/>
					<fmt:message key="common.yes"/><input type="radio"  name="sort" value="0"/><fmt:message key="common.no"/></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_seqno"/></td>
					<td align="left">
						<input id="seqNo" name="seqNo" type="text" class="text_field" inputName='<fmt:message key="controldata.field_seqno"/>'   validate="notNull;isInteger" value="0">			
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_sortno"/></td>
					<td align="left">
						<input id="sortNo" name="sortNo" type="text" class="text_field" inputName='<fmt:message key="controldata.field_sortno"/>'   validate="notNull;isInteger" value="0">			
					</td>
				</tr>
				<tr>
					<td align="right" ><fmt:message key="controldata.field_width"/></td>
					<td align="left" >
						<input id="width" name="width" type="text" class="text_field" inputName='<fmt:message key="controldata.field_width"/>'   validate="" value="">			
					</td>
				</tr>	
				<tr>
					<td align="right"><fmt:message key="controldata.field_align"/></td>
					<td colspan="3" align="left">
						<select id="align" name="align">
							<option value=""><fmt:message key="common.select"/></option>
							<option value="left"><fmt:message key="common.left_align"/></option>
							<option value="center"><fmt:message key="common.center"/></option>
							<option value="right"><fmt:message key="common.right_align"/></option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right" ><fmt:message key="controldata.field_category"/></td>
					<td align="left" >
						<input id="category" name="category" type="text" class="text_field" inputName='<fmt:message key="controldata.field_category"/>'   validate="" value="">			
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.field_wfflag"/></td>
					<td align="left"><input type="radio" name="wfFlag" value="1"
						checked/><fmt:message key="common.yes"/><input type="radio"  name="wfFlag" value="0"/><fmt:message key="common.no"/></td>
				</tr>
				<tr>
					<td align="right" ><fmt:message key="controldata.field_buskey"/></td>
					<td align="left" >
						<input id="buskey" name="busKey" type="text" class="text_field" inputName='<fmt:message key="controldata.field_buskey"/>'   validate="" value="">			
					</td>
				</tr>
				<tr>
					<td align="right" ><fmt:message key="controldata.field_extparam"/></td>
					<td align="left" >
						<input id="extparam" name="extParam" type="text" class="text_field" inputName='<fmt:message key="controldata.field_extparam"/>'   validate="" value="">			
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="common.description"/></td>
					<td colspan="3" align="left">
						<textarea class="textarea_limit_words" cols="36" rows="5" id="description" name="description" inputName='<fmt:message key="common.description"/>' maxLength="512" ></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
<script>
	function save_onClick(){
		if(checkForm(form)==true)
		{	
			getForms(field);
			field.status=getRadioValue(form.status);
			field.display=getRadioValue(form.display);
			field.wfFlag=getRadioValue(form.wfFlag);
			field.created=null;
			field.updated=null;
			if(params[1]=="insert")
			{
				ControlDataService.insertField(field,function(){
					window.returnValue = field;
					window.close();
				});
			}
			else
			{
				ControlDataService.updateField(field,function(){
					window.returnValue = field;
					window.close();
				});
			}
		}
	}
	function cancel_onClick()
	{
		window.returnValue=null;
		window.close();
	}
	/**
	 * 功能描述：删除数据
	 * 参数描述：
	 */    
	function delete_onClick(){  
		if(mygrid.getSelectedRowId()==null) {
	  		alert(i18n.please_choose_record_to_delete)
	  		return;
		}
		if(confirm(i18n.confirm_to_delete_record)) {
			ControlDataService.deleteField(mygrid.getSelectedRowId(),function(data){
				refresh();
				alert(data);
			});
		}
	}  	
	function getRadioValue(obj)
   {
    var len=obj.length;   
    for (var i=0;i<len ;i++ )
    { if( obj[i].checked==true )
     {
      return obj[i].value;
     }
    }
   }
</script>
</fmt:bundle>	
</html>