<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/controldata.js"></script>
<script type='text/javascript' src="<venus:base/>/js/dd/common.js"></script>
<script type='text/javascript' src='<venus:base/>/dwrdd/interface/ControlDataService.js'></script>
<%@ include file="/jsp/dd/include/jquery.jsp" %>
<%@ include file="/jsp/dd/include/jquery-ui.jsp" %>	
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script type='text/javascript' src="<venus:base/>/js/dd/change.js"></script>
<style>
		.column {width: 380px;height:280px;float: left;padding-bottom: 100px;margin:2px;background-color:#F1F5FA}
		.widget{background-color: #ffe;border:#665555 solid 1px;cursor: move;margin: 0 0 2px;width: 128px;}
		.widget-header {background-color: #94cbec;position:relative;border:#665555 solid 1px;margin: 1px;padding-bottom: 4px;padding-left: 0.2em;}
		.widget-content { padding: 0.4em; }
		.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important;}
		.ui-sortable-placeholder * { visibility: hidden; }
		.widget-zoomlink {position:absolute;right:14px}	
		.widget-closelink {position:absolute;right:1px}	
		.rightPanel {width:430px;background-color:#d9e8fb;float:left}	
		.leftPanel {width:160px;background-color:#d9e8fb;float:left}	
</style>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="controldata.fieldlayout_config"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<script language="javascript">
</script>
<form name="form" method="post" >	
	<input id='id' name='id' type='hidden'></input>
	<input id='columnName' name='columnName' type='hidden'></input>
	<input id='tableName' name='tableName' type='hidden'></input>
	<input id='columnName' name='columnName' type='hidden'></input>
	<input id='viewId' name='viewId' type='hidden'></input>
	<input id='viewCode' name='viewCode' type='hidden'></input>
	<div id="controlPanel" style="padding:5px">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:save_onClick();">
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

		<div id="ccChild1"  class="table_div_content"> 
		</div>
	</div>
</form>
</body>
<script>
	var params = dialogArguments;
	function save_onClick(){
		var result=[];
		jQuery(".column").each(function(n){
			var xx = jQuery("#"+this.id).sortable("serialize");
			if(xx!="")
				result=result.concat(xx);
		})
		var queryFieldsConf="";
		if(result.length>0)
		{
			queryFieldsConf=result.join(',');
			queryFieldsConf=queryFieldsConf.replace(/field\[\]=/g,"");
		}
		ControlDataService.updateFieldLayout(params[1],queryFieldsConf,function(data){
					window.returnValue=data;
					window.close();
		});
	}
	function cancel_onClick()
	{
		window.returnValue=null;
		window.close();
	}
		jQuery(document).ready(function(){
			jQuery("#ccChild1").append("<div id='leftPanel' class='leftPanel' ></div>").append("<div id='rightPanel' class='rightPanel' ></div>")	;	
			jQuery("#ccChild1 #leftPanel").append("<input type='text'  id='leftTitle'   class='text_field_readonly' style='width:158px;'></input>").append("<select id='leftSelect' style='width:158px' size=19 ></select>");
		    jQuery("#ccChild1 #rightPanel").append("<input type='radio' name='columnnumber'  value=1 checked onClick='changeCol(1,\"ccChild1\")'>"+i18n_dd.one_column+"</input>");
		    jQuery("#ccChild1 #rightPanel").append("<input type='radio' name='columnnumber'  value=2 onClick='changeCol(2,\"ccChild1\")'>"+i18n_dd.two_column+"</input>");
		     jQuery("#ccChild1 #rightPanel").append("<input type='radio' name='columnnumber'  value=3 onClick='changeCol(3,\"ccChild1\")'>"+i18n_dd.three_column+"</input>");
		    jQuery("#leftTitle").val(params[3]);
			ControlDataService.findView(params[1],
				function fillList(data) {
					var fields=data.fields;
					//add a blank element for a blank position
					var blankElement = {};
                    blankElement.name="BLANK_ELEMENT";
                    blankElement.category="EMPTY";
                    blankElement.displayName="BLANK_ELEMENT";
					blankElement.id="BLANK_ID";
					blankElement.viewCode="BLANK_CODE";
					fields[fields.length]=blankElement;
					jQuery("#leftSelect").unbind('dblclick');
					//alert(dwr.util.toDescriptiveString(fields,2));
					setComboxData(jQuery("#leftSelect").get(0),fields, 'displayName+category', 'id+viewCode','',true);
					jQuery("#leftSelect").bind('dblclick',function(event){
							var field = jQuery(this).find(':selected');
							addWidget("field="+field.attr('value'),field.attr('text'),params[2]+"#"+field.attr('text'));
					});
					if (data.fieldLayout && data.fieldLayout!="") {
								var cols = data.layoutFields;
								for(var i=0;i<cols.length;i++){
									var htmlstr="";
									var colName='col'+"-"+(i+1);
									var colFields=cols[i];
									//处理列容器-begin
									htmlstr =htmlstr+"<div id="+colName+" class='column'>";
									for(var j=0;j<colFields.length;j++)
									{
											var field=colFields[j];
											//处理列中元素-begin
											if(field.id == "BLANK_ID"){
												htmlstr = htmlstr + "<div id='field=BLANK_ID#BLANK_CODE' class='widget'>"
												htmlstr =htmlstr+"<div class='widget-header'>BLANK_ELEMENT</div>";
												htmlstr =htmlstr+"<div class='widget-content'>BLANK_CODE#BLANK_ID</div>";
												htmlstr =htmlstr+"</div>";
											}else{
												htmlstr =htmlstr+"<div id='field="+field.id+"#"+field.viewCode+"' class='widget'>";
                                                htmlstr =htmlstr+"<div class='widget-header'>"+field.displayName+"#"+field.category+"</div>";
                                                htmlstr =htmlstr+"<div class='widget-content'>"+field.viewCode+"#"+field.displayName+"#"+field.category+"</div>";
												htmlstr =htmlstr+"</div>";
											}
											//处理列中元素-end
									}
									htmlstr =htmlstr+"</div>";
									//处理列容器-end
									jQuery("#ccChild1 #rightPanel").append(htmlstr);
								}		
								addZoomLink(jQuery(".widget"));
								addCloseLink(jQuery(".widget"));
								jQuery(".widget").find(".widget-content").hide();
								jQuery(":option[name='columnnumber'][value="+cols.length+"]").attr('checked',true);
								changeCol(cols.length,'ccChild1');
					}else
					{
				  		changeCol(1,'ccChild1');
				  	}
			});
		});
	
</script>
</fmt:bundle>
</html>