<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<script>
function validateSQL(){
	if(document.form.sql_name.value.replace(/(^\s*)|(\s*$)/g, "")==""){
		alert("<fmt:message key='gap.authority.Enter' bundle='${applicationAuResources}' />SQL<fmt:message key='gap.authority.Statement_' bundle='${applicationAuResources}' />");
		return;	
	}
	form.action="<%=request.getContextPath()%>/XmportAction.do?cmd=SQLRowName";
	form.submit();
}

function nextStep(){
	for(var i=0;i<document.form.rightSel.length;i++){
		document.form.rightSel.options[i].selected=true;
	}
	for(var i=0;i<document.form.sortList.length;i++){
		document.form.sortList.options[i].selected=true;
	}
	if(document.form.rightSelRL!=undefined){
		for(var i=0;i<document.form.rightSelRL.length;i++){
			document.form.rightSelRL.options[i].selected=true;
		}
		for(var i=0;i<document.form.sortListRL.length;i++){
			document.form.sortListRL.options[i].selected=true;
		}
	}
	parent.showBlockPage();
	form.action="<%=request.getContextPath()%>/XmportAction.do?cmd=step_three4SQL";
	form.target="_parent";
	form.submit();
}
function movebox(box,value,text,pos0,direction)
{
	if(pos0 == box.options.length-1){
		SetButtonEnabledState('bt_move_down',false);	
	}else{
		SetButtonEnabledState('bt_move_down',true);
	}
	if(pos0 == 0){
		SetButtonEnabledState('bt_move_up',false);	
	}else{
		SetButtonEnabledState('bt_move_up',true);	
	}
	for(var i=0; i<box.options.length; i++){
		if(i==pos0){
			value0 = box.options[i].value;
			text0 = box.options[i].text;
			box.options[i].value=value;
	        box.options[i].text=text;
			if(direction == "up"){
		        box.options[i+1].value=value0;
		        box.options[i+1].text=text0;
		    }
			if(direction == "down"){
				box.options[i-1].value=value0;
		        box.options[i-1].text=text0;
		    }
		}else{
			box.options[i].value=box.options[i].value;
        	box.options[i].text=box.options[i].text;
        }
	}
}
function move_up(box){
	var pos = 0;
	var direction = "up";
	for(var i=0; i<box.options.length; i++){
		if(box.options[i].selected && box.options[i].value!=""){
			if(i-1>=0){
				pos = i-1;
				movebox(box,box.options[i].value,box.options[i].text,pos,direction);
				break;
			}
		}
	}
	for(var i=0; i<box.options.length; i++){
		if(i==pos){
			box.options[i].selected = true;
		}else{
			box.options[i].selected = false;
		}
	}

}
function move_down(box){
	var direction = "down";
	var pos = box.options.length-1;
	for(var i=0; i<box.options.length; i++){
		if(box.options[i].selected && box.options[i].value!=""){
			if(i+1<box.options.length){
				pos = i+1;
				movebox(box,box.options[i].value,box.options[i].text,pos,direction);
				break;
			}
		}
	}
	for(var i=0; i<box.options.length; i++){
		if(i==pos){
			box.options[i].selected = true;
		}else{
			box.options[i].selected = false;
		}
	}

}
function setEnabledState_onClick(){
	SetButtonEnabledState('bt_move_down',true);
	SetButtonEnabledState('bt_move_up',true);
}
function SetButtonEnabledState(sButtonID, bEnabledState){
	var e = new Error();
	try {
		var oBtn = eval("document.all." + sButtonID);
		oBtn.disabled = !bEnabledState;
		oBtn.style.cursor = ((bEnabledState) ? "hand" : "default");
	}catch (e) {
		return;
	}
	
	try {
		var oBtnImage = eval("document.all." + sButtonID + "_Image");
		oBtnImage.filters.Gray.enabled   = !bEnabledState;
		oBtnImage.filters.alpha.enabled  = !bEnabledState;
	}catch (e) {
	}
}
function moveboxRL(box,value,text,pos0,direction)
{
	if(pos0 == box.options.length-1){
		SetButtonEnabledState('bt_move_downRL',false);	
	}else{
		SetButtonEnabledState('bt_move_downRL',true);
	}
	if(pos0 == 0){
		SetButtonEnabledState('bt_move_upRL',false);	
	}else{
		SetButtonEnabledState('bt_move_upRL',true);	
	}
	for(var i=0; i<box.options.length; i++){
		if(i==pos0){
			value0 = box.options[i].value;
			text0 = box.options[i].text;
			box.options[i].value=value;
	        box.options[i].text=text;
			if(direction == "up"){
		        box.options[i+1].value=value0;
		        box.options[i+1].text=text0;
		    }
			if(direction == "down"){
				box.options[i-1].value=value0;
		        box.options[i-1].text=text0;
		    }
		}else{
			box.options[i].value=box.options[i].value;
        	box.options[i].text=box.options[i].text;
        }
	}
}
function move_upRL(box){
	var pos = 0;
	var direction = "up";
	for(var i=0; i<box.options.length; i++){
		if(box.options[i].selected && box.options[i].value!=""){
			if(i-1>=0){
				pos = i-1;
				moveboxRL(box,box.options[i].value,box.options[i].text,pos,direction);
				break;
			}
		}
	}
	for(var i=0; i<box.options.length; i++){
		if(i==pos){
			box.options[i].selected = true;
		}else{
			box.options[i].selected = false;
		}
	}

}
function move_downRL(box){
	var direction = "down";
	var pos = box.options.length-1;
	for(var i=0; i<box.options.length; i++){
		if(box.options[i].selected && box.options[i].value!=""){
			if(i+1<box.options.length){
				pos = i+1;
				moveboxRL(box,box.options[i].value,box.options[i].text,pos,direction);
				break;
			}
		}
	}
	for(var i=0; i<box.options.length; i++){
		if(i==pos){
			box.options[i].selected = true;
		}else{
			box.options[i].selected = false;
		}
	}

}
function setEnabledState_onClickRL(){
	SetButtonEnabledState('bt_move_downRL',true);
	SetButtonEnabledState('bt_move_upRL',true);
}

var currentSel = null;
function move(){
      moveRight(arguments[0],arguments[1]);
  }
  
function moveRight(src,des){
    if(src.selectedIndex==-1){
        alert("<fmt:message key='gap.authority.Please_select_agency_entry' bundle='${applicationAuResources}' />!");
        return;
    }
    for(var i=0;i<src.length;i++){
        if(src[i].selected){
            var op = document.createElement("option");
            op.value = src.options[src.selectedIndex].value;
            op.text = src.options[src.selectedIndex].text;
            des.options.add(op);
                src.remove(i);
                i--;
        }
    }   
}
function setButton(obj){        
        if(obj.length==0) return;
        currentSel = obj;
    if(obj.id=="leftSel"){
        document.getElementById("btnLeft").disabled = true;
            document.getElementById("btnRight").disabled = false;
            
            reSelect(document.getElementById("rightSel"));            
    }else{
        document.getElementById("btnLeft").disabled = false;
        document.getElementById("btnRight").disabled = true;    
        
        reSelect(document.getElementById("leftSel"));                
    }       
}

function reSelect(obj){
    for(var i=0; i<obj.length; i++){
        if(obj[i].selected) obj[i].selected = false;
    }
}
var currentSelRL = null;
function moveRL(){
      moveRightRL(arguments[0],arguments[1]);
  }
  
function moveRightRL(src,des){
    if(src.selectedIndex==-1){
        alert("<fmt:message key='gap.authority.Please_select_optional_entry_relationship' bundle='${applicationAuResources}' />!");
        return;
    }
    for(var i=0;i<src.length;i++){
        if(src[i].selected){
            var op = document.createElement("option");
            op.value = src.options[src.selectedIndex].value;
            op.text = src.options[src.selectedIndex].text;
            des.options.add(op);
                src.remove(i);
                i--;
        }
    }   
}
function setButtonRL(obj){        
        if(obj.length==0) return;
        currentSelRL = obj;
    if(obj.id=="leftSelRL"){
        document.getElementById("btnLeftRL").disabled = true;
            document.getElementById("btnRightRL").disabled = false;
            
            reSelectRL(document.getElementById("rightSelRL"));            
    }else{
        document.getElementById("btnLeftRL").disabled = false;
        document.getElementById("btnRightRL").disabled = true;    
        
        reSelectRL(document.getElementById("leftSelrL"));                
    }       
}

function reSelectRL(obj){
    for(var i=0; i<obj.length; i++){
        if(obj[i].selected) obj[i].selected = false;
    }
}
</script>
<table class="table_noFrame" width="100%">
<bean:parameter id = "operate" name = "operate" />
<bean:parameter id = "organize" name = "organize" />
<bean:parameter id = "relation" name = "relation" />
<form name="form" method="post">
<input type="hidden" name="operate" value="<bean:write name = "operate" />">
<input type="hidden" name="organize" value="<bean:write name = "organize" />">
<input type="hidden" name="relation" value="<bean:write name = "relation" />">
<tr>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td align="right">SQL<fmt:message key='gap.authority.Statement' bundle='${applicationAuResources}' /></td>
	<td align="left">
		<textarea class="textarea_limit_words" cols="130" rows="7" name="sql_name" maxLength="4000" id="sql_id"><logic:notEmpty name="queryCondition"><bean:write name = "queryCondition" /></logic:notEmpty></textarea>
	</td>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
	<td align="right" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td align="left">
		<input type="button" class="button_ellipse" name="validateSql" value="<fmt:message key='gap.authority.Back_to_listing' bundle='${applicationAuResources}' />" onclick="JavaScript:validateSQL();">
	</td>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr><td colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td align="left" colspan=2>
		<fieldset name="operate_type">
			<legend  style="font-size:13px; color:#163752;"><fmt:message key='gap.authority.Configuration_agency_properties' bundle='${applicationAuResources}' /></legend>
			<br/>
			<table class="table_noFrame" width="100%">
				<tr>
					<td>
						<fieldset name="operate_type">
							<legend  style="font-size:13px; color:#163752;"><fmt:message key='gap.authority.Select_the_column_name' bundle='${applicationAuResources}' /></legend>
							<br/>
								<table class="table_noFrame" width="100%">
									<tr>
										<td align="right">
											<select multiple id="leftSel" size="8" onclick="setButton(this)" ondblclick="document.getElementById('btnRight').click()"  style="width:200px;">
							                    <logic:notEmpty name="sqlcolumname">
													<logic:iterate id="column" name="sqlcolumname"> 
														<option value="<bean:write name="column"/>"><bean:write name="column"/></option>
													</logic:iterate>
												</logic:notEmpty>
							                </select> 
										</td>
										<td align="center">
											<input type="button" value=" <fmt:message key='gap.authority.Shifted_to_the_right' bundle='${applicationAuResources}' /> " class="button_ellipse" id="btnRight" onClick="move(document.getElementById('leftSel'),document.getElementById('rightSel'));"/>
							                <br/><br/>
							                <input type="button" value=" <fmt:message key='gap.authority.Left' bundle='${applicationAuResources}' /> " class="button_ellipse" id="btnLeft" onClick="move(document.getElementById('rightSel'),document.getElementById('leftSel'));"/>  
							            </td>
										<td align="left">
											<select multiple id="rightSel" name="rightSel" size="8" onclick="setButton(this)"  ondblclick="document.getElementById('btnLeft').click()"  style="width:200px;" ></select>  
										</td>
									</tr>
								</table>
							<br/>
						</fieldset>
					</td>
					<td>
						<fieldset name="operate_type">
							<legend  style="font-size:13px; color:#163752;"><fmt:message key='gap.authority.Alignment_property' bundle='${applicationAuResources}' /></legend>
							<br/>
								<table class="table_noFrame" width="100%">
									<tr>
										<td align="right">			
											<select name="sortList" size="8" multiple style="width:200px;" onClick="setEnabledState_onClick();">
												<logic:notEmpty name="organizefields">
													<logic:iterate id="item" name="organizefields"> 
														<option value="<bean:write name="item"/>"><bean:write name="item"/></option>
													</logic:iterate>
												</logic:notEmpty>												 
											</select>
										</td>
									    <td  align="left">
											<p>
									            <input name="bt_move_up" type="button" id="bt_move_up" class="button_ellipse" value=" <fmt:message key='gap.authority.Move' bundle='${applicationAuResources}' /> " onClick="javascript:move_up(document.form.sortList)">
									        </p>
									        <p>
									            <input name="bt_move_down" type="button" id="bt_move_down" class="button_ellipse" value=" <fmt:message key='gap.authority.Down' bundle='${applicationAuResources}' /> " onClick="javascript:move_down(document.form.sortList)">
								            </p>
										</td>
									</tr>
								</table>
							<br/>
						</fieldset>
					</td>
				</tr>
			</table>
		</fieldset>
	</td>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<logic:equal name="operate" value="add">
<tr>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td align="left" colspan=2>
	<div id="divRL" ><!-- style="display:none" -->
		<fieldset name="operate_type">
			<legend style="font-size:13px; color:#163752;"><fmt:message key='gap.authority.Configuration_property_relations' bundle='${applicationAuResources}' /></legend>
			<br/>
			<table class="table_noFrame" width="100%">
				<tr>
					<td>
						<fieldset name="operate_type">
							<legend style="font-size:13px; color:#163752;"><fmt:message key='gap.authority.Select_the_column_name' bundle='${applicationAuResources}' /></legend>
							<br/>
								<table class="table_noFrame" width="100%">
									<tr>
										<td align="right">
											<select multiple id="leftSelRL" size="5" onclick="setButtonRL(this)" ondblclick="document.getElementById('btnRightRL').click()"  style="width:200px;">
							                    <logic:notEmpty name="sqlcolumname">
													<logic:iterate id="column" name="sqlcolumname"> 
														<option value="<bean:write name="column"/>"><bean:write name="column"/></option>
													</logic:iterate>
												</logic:notEmpty>
							                </select> 
										</td>
										<td align="center">
											<input type="button" value=" <fmt:message key='gap.authority.Shifted_to_the_right' bundle='${applicationAuResources}' /> " class="button_ellipse" id="btnRightRL" onClick="moveRL(document.getElementById('leftSelRL'),document.getElementById('rightSelRL'));"/>
							                <br/><br/>
							                <input type="button" value=" <fmt:message key='gap.authority.Left' bundle='${applicationAuResources}' /> " class="button_ellipse" id="btnLeftRL" onClick="moveRL(document.getElementById('rightSelRL'),document.getElementById('leftSelRL'));"/>  
							            </td>
										<td align="left">
											<select multiple id="rightSelRL" name="rightSelRL" size="5" onclick="setButtonRL(this)"  ondblclick="document.getElementById('btnLeftRL').click()"  style="width:200px;" ></select>  
										</td>
									</tr>
								</table>
							<br/>
						</fieldset>
					</td>
					<td>
						<fieldset name="operate_type">
							<legend style="font-size:13px; color:#163752;"><fmt:message key='gap.authority.Alignment_property' bundle='${applicationAuResources}' /></legend>
							<br/>
								<table class="table_noFrame" width="100%">
									<tr>
										<td align="right">			
											<select name="sortListRL" size="5" multiple style="width:200px;" onClick="setEnabledState_onClickRL();">
												<logic:notEmpty name="organizeRLfields">
													<logic:iterate id="rlitem" name="organizeRLfields"> 
														<option value="<bean:write name="rlitem"/>"><bean:write name="rlitem"/></option>
													</logic:iterate>
												</logic:notEmpty>
										    </select>
										</td>
									    <td  align="left">
											<p>
									            <input name="bt_move_upRL" type="button" id="bt_move_upRL" class="button_ellipse" value=" <fmt:message key='gap.authority.Move' bundle='${applicationAuResources}' /> " onClick="javascript:move_upRL(document.form.sortListRL)">
									        </p>
									        <p>
									            <input name="bt_move_downRL" type="button" id="bt_move_downRL" class="button_ellipse" value=" <fmt:message key='gap.authority.Down' bundle='${applicationAuResources}' /> " onClick="javascript:move_downRL(document.form.sortListRL)">
								            </p>
										</td>
									</tr>
								</table>
							<br/>
						</fieldset>
					</td>
				</tr>
			</table>
		</fieldset>
	</div>
	</td>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
</logic:equal>
<tr><td colspan=4 align=center><input type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Next' bundle='${applicationAuResources}' />" onclick="JavaScript:nextStep();"></td></tr>
</form>
</table>

