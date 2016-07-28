<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_person.vo.JOB_PERSONVo" %>
<%@ page import="rayoo.job.job_person.util.IJOB_PERSONConstants" %>
<%
%>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

_jQuery(document).ready(function(){
	//alert(_jQuery("[name=sc_show_key_word]").length);
	//_jQuery("[name=sc_show_key_word]").hide();
	var conditions = _jQuery("[name=conditions]").val();
	var condition_codes = conditions.split(",");
	for(var i = 0 ; i< condition_codes.length; i++){
		var code = condition_codes[i];
		_jQuery("[name=sc_show_"+ code +"]").show();
	}
	
	
});

//设置查询条件
function condition_setup(){

/*
	var ids=choose_row_public("ids");
     var entities=new Array();
       dc=$id("datacell1").dataset;
       for(i=0;i<ids.length;i++){    
            entities.push(dc.findEntity("id",ids[i]));
       }
    var url = "<%=request.getContextPath()%>/JobcandidateAction.do?cmd=queryAll&source=relevance_position";
    //window.open(url,'','height=400px,width=750px,top=100,left=200,help=no,toolbar=no,menubar=no,resizable=yes,scrollbars=no,location=no,status=not,title=关联职位');
    showModalCenter(url,entities,rtnRelevance_position,980,660,"关联职位");
    */
    
}


</script>

<style> 
/**div{ display:inline} */

.float_left{
	float:left;
	
	padding-left: 5px;
	}
.search_title_name{
	
}
</style> 

</head>
<body>
<h:form checkType="blur" name="form" method="post" id="setForm" >
<input type="hidden"  id="selected_conditions_code" name="selected_conditions_code"  value="${selected_conditions_code }"/>
<input type="hidden"  id="all_conditions_code" name="all_conditions_code" value="${all_conditions_code }"/>
<input type="hidden"  name="cmd" value="queryAll"/>
<input type="hidden" name="backFlag" id="backFlag" value="true" />
 
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100px;" > 
			</td>
		</tr>
		<tr>
			<td width="700px" height="" rowspan="9" >
				
				
				
				
				
				
				
				
				
				<div   class="float_left"  align="center" style="width:300px;height: 400px;">
					
			        <fieldset>
<!--			                <legend>可选择查询条件:</legend>-->
			                <label for="multipleselect" style="font-weight: bold">可选择查询条件:</label>
			                <select size="23" multiple="multiple" id="all_condition" name="multipleselect">
			                
			                        
			                        <logic:iterate id="vo" name="conditionAll" >
										
										<option onclick="to_selected();" value="<bean:write  name="vo" property="code"/>"><bean:write  name="vo" property="name"/></option>
									</logic:iterate>
			                        
			                </select>
			        </fieldset>
        
				</div>
				
				
				<div   class="float_left"  align="center" style="width:60px;height: 400px; vertical-align: middle; padding-top: 150px;">
					<input class="icon_1"   type="button" value='>>>' onClick="to_selected();">
					<br>
	                <input type="button" class="icon_1"  value="<<<" onclick="to_all();"/>
					
				</div>
				<div   class="float_left"  align="center" style="width:300px;height: 400px;">
					
					
					<fieldset>
<!--			                <legend>已选择查询条件:</legend>-->
			                <label for="multipleselect" style="font-weight: bold">已选择查询条件:</label>
			                <select size="23" multiple="multiple" id="selected_condition" name="multipleselect" >
			                
			                
			                        <logic:iterate id="vo" name="conditionSelected">
										
										<option value="<bean:write  name="vo" property="code"/>"><bean:write  name="vo" property="name"/></option>
									</logic:iterate>
			                </select>
			        </fieldset>
					
				</div>
				
				
				<div     align="center" style="width: 600px;" >
				
					<input name="button_ok" class="icon_1"   type="button" value='确定' onClick="javascript:sure_onClick()">
	                <input type="button" class="icon_1"  value="取消" onclick="cancel()"/>
				</div>
				
				
			</td>
		</tr>
		
</table>

</h:form>
</fmt:bundle>
<script language="javascript">

//确定
function sure_onClick(){
   
   	var all_conditions_code = _jQuery("#all_conditions_code");
   	var all_condition = _jQuery("#all_condition");
	var selected_condition = _jQuery("#selected_condition");
	var selected_conditions_code = ",";
	selected_condition.find("option").each(function() {
		var vo = _jQuery(this);
		selected_conditions_code += vo.val() + ",";
        
    });
    
    _jQuery("#selected_conditions_code").val(selected_conditions_code);
    
	var form = jQuery("#setForm");
	    form.action="<%=request.getContextPath()%>/Job_ps_search_condition_setupAction.do?cmd=insert&date="+new Date().getTime() ;
	    
	    ajaxRequest(form,
	        function(data){
	            alert(data.message);
	            if(data.isOk==true){
					window['returnValue'] = selected_conditions_code;
	            }else{
	            }
	            window.close();
	        } , 
	        function(){
	            alert("error.");
	        }
	    )

	//alert(all_conditions_code.val());
	//alert(selected_conditions_code);
}

   
   
function cancel(){
	window['returnValue'] = 'cancel';
	window.close();
}
function to_selected(){
	
	var all_condition = _jQuery("#all_condition");
	var selected_condition = _jQuery("#selected_condition");
	
	all_condition.find("option:selected").each(function() {
		var vo = _jQuery(this);
		//alert(vo.val() + ": " + vo.text());
		
		var content = "<option value='"+vo.val()+"'>"+vo.text()+"</option>";
		selected_condition.append(content);
		
		vo.remove();
		
        
    });
    
}


function to_all(){
	
	var all_condition = _jQuery("#all_condition");
	var selected_condition = _jQuery("#selected_condition");
	
	selected_condition.find("option:selected").each(function() {
		var vo = _jQuery(this);
		//alert(vo.val() + ": " + vo.text());
		
		var content = "<option value='"+vo.val()+"'>"+vo.text()+"</option>";
		all_condition.append(content);
		
		vo.remove();
        
    });
    
	
}


</script>




</body>
</html>
