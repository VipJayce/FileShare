var queryModuleStore;
var pageSize = 25;// 页显示数据个数,默认为25
var changeObj1;
var simple1;
var changeObj2;
var changeObj3;
var simple2;
var simple3;
var simple4;
var condition;

// 功能管理工具类,下面的方法都是类方法
function ModuleUtil() {
}
ModuleUtil.getModule = function() {
	var module = {
		id : "",
		name : "",
		templateId : "",
		isSystem : "0",
		condition : "",
		tables : null,
		fields : null
	};
	return module;
}

ModuleUtil.getField = function(type) {
	var field = {
		id : "",
		name : "",
		moduleid : "",
		seqNo : "0",
		viewCode : "",
		fieldId : "",
		type : type
	};
	return field;
}
// 在文本域当前光标内插入内容
function   insertAtCursor(myField,myValue)   {   
  if   (document.selection)   {   
  myField.focus();   
  sel   =   document.selection.createRange();   
  sel.text   =   myValue;
  }   
  else   if   (myField.selectionStart||   myField.selectionStart   ==   "0")   {   
  var   startPos   =   myField.selectionStart;   
  var   endPos   =   myField.selectionEnd;  
  myField.value   =   myField.value.substring(0,   startPos)   
  +   myValue   
  +   myField.value.substring(endPos,   myField.value.length);   
  }   else   {   
  myField.value   +=   myValue;   
  }   
}  

function onTableChange(select) {
	if (select.id == 'leftTitleSelect2') {
		ModuleManageService.getViewFields(select.value,
				function fillList(data) {
					changeObj2.setLeftData(data.data, 'name', 'id+viewCode');
				});
	} else if (select.id == 'leftTitleSelect3') {
		ModuleManageService.getViewFields(select.value,
				function fillList(data) {
					jQuery("#leftSelect3").unbind('dblclick');
					setComboxData(jQuery("#leftSelect3").get(0),data.data, 'name', 'id+viewCode');
					jQuery("#leftSelect3").bind('dblclick',function(event){
							var field = jQuery(this).find(':selected');
							addWidget("field="+field.attr('value'),field.attr('text'),select.value+"#"+field.attr('text'));
						});
				});
	} else if (select.id == 'leftTitleSelect4') {
		ModuleManageService.getViewFields(select.value,
				function fillList(data) {
					var leftSelect = document.getElementById('leftSelect4');
					leftSelect.options.length = 0;
					for (var i = 0; i < data.data.length; i++) {
						var no = new Option();
						no.value = data.data[i].id + "#"
								+ data.data[i].viewCode;
						no.text = data.data[i].name;
						leftSelect.options[leftSelect.options.length] = no;
					}
					if (leftSelect.options.length > 0) {
						onFieldChange(leftSelect);
					}
				});
	};
}

function onFieldChange(select) {
	if (select.id == 'leftSelect4') {
		var leftSelect = Ext.get('leftSelect4');
		if (leftSelect.getValue() == '')
			return;
		var arr = leftSelect.getValue().split('#');
		ModuleManageService.getFieldUI(arr[1], arr[0], function(data) {
			if (data && data != '') {
				var fieldContent = document.getElementById('fieldContent')
				fieldContent.innerHTML = '';
				fieldContent.innerHTML = data;
			}

		});

	}
}

function query_onClick() {
	queryModuleStore.load({
		params : {
			start : 0,
			limit : pageSize
		}
	});
}

Ext.onReady(function() {
	var data = null;
	Ext.QuickTips.init();
	var queryPanel = new Ext.Panel({
		region : 'north',
		title : i18n_dd.query_by_condition,
		collapsible : true,
		titleCollapse : false,
		height : 60,
		layout : "form",
		contentEl : 'queryRegion'
	});

	var record = [{
		name : 'id',
		mapping : 'id'
	}, {
		name : 'name',
		mapping : 'name'
	}, {
		name : 'templateId',
		mapping : 'templateId'
	}, {
		name : 'tableName',
		mapping : 'tableName'
	}, {
		name : 'param',
		mapping : 'param'
	}, {
		name : 'url',
		mapping : 'url'
	}];
	var grid_row = new Ext.data.Record.create(record);
	queryModuleStore = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ModuleManageService.getModuleList, true,
				new Object()),
		reader : new Ext.data.ListRangeReader({
			id : 'id',
			totalProperty : 'totalSize'
		}, grid_row),
		remoteSort : true
	});

	queryModuleStore.on('beforeload', function(obj, arg) {
		var conditionStr = '';
		if (document.getElementById('query_moduleName').value != '')
			conditionStr = conditionStr + " and name like'%"
					+ document.getElementById('query_moduleName').value + "%'";
		conditionStr = conditionStr + " and templateId='003'"
		var obj = new Object();
		var argParas = new Array();
		argParas.push(obj);
		argParas.push(true);
		argParas.push(conditionStr);
		Ext.apply(arg, {
			arg : argParas
		});
	});

	var sm = new Ext.grid.CheckboxSelectionModel();// 表格复选列
	var cm = new Ext.grid.ColumnModel([sm, {
		header : i18n_dd.name,
		width : 80,
		sortable : true,
		dataIndex : 'name'
	}, {
		header : i18n_dd.module_template,
		width : 80,
		dataIndex : 'templateId',
		renderer : function(value) {
			if (value == '003') {
				return i18n_dd.query_template;
			} else {
				return i18n_dd.unrecognized_templates;
			}
		}
	}, {
		header : i18n_dd.table_name,
		width : 80,
		dataIndex : 'tableName'
	}, {
		header : i18n_dd.parameter,
		width : 120,
		sortable : false,
		dataIndex : 'param'
	}, {
		header : i18n_dd.link,
		width : 120,
		sortable : false,
		dataIndex : 'url'
	}]);
	var selectNode;// 当前选择的叶子节点
	var grid = new Ext.grid.GridPanel({// 定义表格
		id : 'grid',// id为grid
		border : true,// 出现边框
		title : i18n_dd.query_list,// 标题内容为
		region : 'center',// 设定显示区域为中心,停靠在容器中心
		layout : 'fit',// 表格内列内容填充满,按列头比例填充
		collapsible : true,
		ds : queryModuleStore,// 数据源为store 上边定义
		cm : cm,
		sm : sm,// 复选方式按sm定义方式
		tbar : [{}],
		bbar : new Ext.PagingToolbar({
			pageSize : pageSize,
			store : queryModuleStore,
			displayInfo : true,
			displayMsg : i18n_dd.page_message,
			emptyMsg : i18n.no_record
		}),
		viewConfig : {
			sortAscText : i18n.ascending,
			sortDescText : i18n.descending,
			columnsText : i18n_dd.display_column,
			forceFit : true
		}
	})

	// wizard-step1:基本信息和选择表
	function step1(id) {
		if(simple1)
		{
			simple1.show();
			return;
		}
		var content1 = new Ext.Panel({
			region : "center",
			html : "<div id='change1' style='background-color:#d9e8fb'>sss</div>"
		})
		var topPanel1 = new Ext.FormPanel({
			region : "north",
			labelWidth : 55,
			height : 40,
			frame : true,
			defaultType : 'textfield',
			items : [{
				fieldLabel : i18n_dd.module_name,
				id : 'moduleName',
				allowBlank : false
			}]

		})
		var panel1 = new Ext.Panel({
			layout : "border",
			width : 480,
			height : 350,
			items : [content1, topPanel1],
			buttons : [{
				text : i18n.cancel,
				handler : function() {
					clearData();
				}
			}, {
				text : i18n_dd.next,
				handler : function() {
					if (Ext.get('moduleName').getValue() == '') {
						Ext.MessageBox.alert(i18n.hint, i18n_dd.query_input_module_name);
					} else {
						var tables = changeObj1.getRightData(getTable,
								'tableId', 'tableName');
						if (tables.length > 0) {
							step2(id);
							simple1.hide();
						} else
							Ext.MessageBox.alert(i18n.hint, i18n_dd.query_select_table);
					}
				}

			}]
		});
		simple1 = new Ext.Window({
			title : i18n_dd.query_guide_1_selecttable,
			width : 475,
			height : 350,
			minWidth : 300,
			minHeight : 200,
			layout : 'fit',
			plain : true,
			resizable : true,
			closable : true,
			closeAction : 'close',
			modal : true,
			animCollapse : false,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			items : panel1,
			listeners:{"beforeclose":function(obj){
				clearData();
				return true;}
			} 			
		});
		simple1.show(Ext.get(id));
		changeObj1 = new changeObject("change1", "changeObj1");
		changeObj1.setMultiSelect(true);
		ModuleManageService.getTableList(0, " and 1=1 ", function(data) {
			// alert(dwr.util.toDescriptiveString(data.data, 2));
			changeObj1.setLeftData(data.data, 'tableName', 'id');
		});
		changeObj1.setLeftTitle(i18n.to_be_chosen);
		changeObj1.setRightTitle(i18n.have_chosen);
		if (data) {
			Ext.getCmp('moduleName').setValue(data.name);
			changeObj1.setRightData(data.tables);
		}

	}

	// wizard-step2:配置显示项
	function step2(id) {
		var leftTitle;
		if (simple2) {
			// step1中的选择的表可能有了变化，需要重新更新leftTitle列表
			leftTitle = document.getElementById("leftTitleSelect2");
			leftTitle.options.length = 0;
			var tables = changeObj1.getRightData(getTable, 'tableId',
					'tableName');
			fillTitle(tables,leftTitle,'and viewtype=1');
				onTableChange(leftTitle);
				simple2.show();
				return;
		}
		var content2 = new Ext.Panel({
			region : "center",
			html : "<div id='change2' style='background-color:#d9e8fb'>sss</div>"
		})
		var topPanel2 = new Ext.Panel({
			region : "north",
			height : 40,
			frame : true,
			html : i18n_dd.query_guide_displayitem_description
		})
		var panel2 = new Ext.Panel({
			layout : "border",
			width : 480,
			height : 350,
			items : [content2, topPanel2],
			buttons : [{
				text : i18n_dd.prev,
				handler : function() {
					simple2.hide();
					simple1.show();
				}
			}, {
				text : i18n_dd.next,
				handler : function() {
					var tables = changeObj1.getRightData(getTable, 'tableId',
							'tableName');
					if (tables.length > 0) {
						step3(id);
						simple2.hide();
					} else
						Ext.MessageBox.alert(i18n.hint, i18n_dd.query_select_table);
				}

			}]
		});
		simple2 = new Ext.Window({
			title : i18n_dd.query_guide_2_displayitem,
			width : 475,
			height : 350,
			minWidth : 300,
			minHeight : 200,
			layout : 'fit',
			plain : true,
			resizable : false,
			closable : true,
			closeAction : 'close',
			modal : true,
			animCollapse : false,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			items : panel2,
			listeners:{"beforeclose":function(obj){
				clearData();
				return true;}
			} 
		});
		simple2.show(Ext.get(id));
		changeObj2 = new changeObject("change2", "changeObj2");
		changeObj2.fullName=true;
		changeObj2.setMultiSelect(true);
		changeObj2
				.setLeftTitle("<select id='leftTitleSelect2' onchange='onTableChange(this)'></select>");
		leftTitle = document.getElementById("leftTitleSelect2");
		changeObj2.setRightTitle(i18n_dd.have_chosen);
		if (data) {
			changeObj2.setRightData(data.fields,'viewCode+fieldName','fieldId+viewCode','type==LIST');
		}
		var tables = changeObj1.getRightData(getTable, 'tableId', 'tableName');
		fillTitle(tables,leftTitle,'and viewtype=1');
		onTableChange(leftTitle);
		return;
	}
	// wizard-step3:配置查询项
	function step3(id) {
		if (simple3) {
			// step1中的选择的表可能有了变化，需要重新更新leftTitle列表
			leftTitle = document.getElementById("leftTitleSelect3");
			leftTitle.options.length = 0;
			var tables = changeObj1.getRightData(getTable, 'tableId',
					'tableName');
			fillTitle(tables,leftTitle,'and viewtype=3');
			onTableChange(leftTitle);
			simple3.show();
			return;
		}
		var content3 = new Ext.Panel({
			region : "center",
			frame : true,			
			html : "<div id='change3' style='background-color:#d9e8fb'></div>"
		})
		var topPanel3 = new Ext.Panel({
			region : "north",
			height : 40,
			frame : true,
			//html : "左边列表框显示已选择的表对应的查询视图字段，右边列表框显示已选择的字段，选中的字段最终会显示在查询输入页面中。可以通过上下按钮调整显示顺序。"
			html : i18n_dd.query_guide_queryitem_description
		})
		var panel3 = new Ext.Panel({
			layout : "border",
			width : 480,
			height : 350,
			items : [content3, topPanel3],
			buttons : [{
				text : i18n_dd.prev,
				handler : function() {
					simple3.hide();
					simple2.show();
				}
			}, {
				text : i18n_dd.next,
				handler : function() {
					var tables = changeObj1.getRightData(getTable, 'tableId',
							'tableName');
					if (tables.length > 0) {
						step4(id);
						simple3.hide();
					} else
						Ext.MessageBox.alert(i18n.hint, i18n_dd.query_select_table);
				}

			}]
		});
		simple3 = new Ext.Window({
			title : i18n_dd.query_guide_3_queryitem,
			width : 600,
			height : 440,
			minWidth : 300,
			minHeight : 200,
			layout : 'fit',
			plain : true,
			resizable : true,
			closable : true,
			closeAction : 'close',
			modal : true,
			animCollapse : false,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			items : panel3,
			listeners:{"beforeclose":function(obj){
				clearData();
				return true;}
			} 			
 						
		});
		simple3.show(Ext.get(id));
		/** 数据字典2.0版本内容
		changeObj3 = new changeObject("change3", "changeObj3");
		changeObj3.setMultiSelect(true);
		changeObj3.fullName=true;
		changeObj3
				.setLeftTitle("<select id='leftTitleSelect3' onchange='onTableChange(this)'></select>");
		leftTitle = document.getElementById("leftTitleSelect3");
		changeObj3.setRightTitle("已选择");
		if (data) {
			changeObj3.setRightData(data.fields,'viewCode+fieldName','fieldId+viewCode','type==QUERY');
		}
		var tables = changeObj1.getRightData(getTable, 'tableId', 'tableName');
		fillTitle(tables,leftTitle,'and viewtype=3');
		onTableChange(leftTitle);*/
		//以下是数据字典2.1版本内容
		jQuery("#change3").append("<div id='leftPanel' class='leftPanel' ></div>").append("<div id='rightPanel' class='rightPanel' ></div>")	;	
		jQuery("#change3 #leftPanel").append("<select id='leftTitleSelect3'  onchange='onTableChange(this)' style='width:158px'></select>").append("<select id='leftSelect3' style='width:158px' size=19 ></select>");
	    jQuery("#change3 #rightPanel").append("<input type='radio' name='columnnumber'  value=1 checked onClick='changeCol(1,\"change3\")'>"+i18n_dd.one_column+"</input>");
	    jQuery("#change3 #rightPanel").append("<input type='radio' name='columnnumber'  value=2 onClick='changeCol(2,\"change3\")'>"+i18n_dd.two_column+"</input>");
		var tables = changeObj1.getRightData(getTable, 'tableId', 'tableName');
		var leftTitle = document.getElementById("leftTitleSelect3");
		fillTitle(tables,leftTitle,'and viewtype=3');
		onTableChange(leftTitle);
		if (data && data.queryFieldsConf!="") {
					var cols = data.queryFields;
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
								htmlstr =htmlstr+"<div id='field="+field.id+"#"+field.viewCode+"' class='widget'>";
								htmlstr =htmlstr+"<div class='widget-header'>"+field.name+"</div>";
								htmlstr =htmlstr+"<div class='widget-content'>"+field.viewCode+"#"+field.name+"</div>";
								htmlstr =htmlstr+"</div>";
									//处理列中元素-end
						}
						htmlstr =htmlstr+"</div>";
						//处理列容器-end
						jQuery("#change3 #rightPanel").append(htmlstr);
					}		
					addZoomLink(jQuery(".widget"));
					addCloseLink(jQuery(".widget"));
					jQuery(".widget").find(".widget-content").hide();
					jQuery(":option[name='columnnumber'][value="+cols.length+"]").attr('checked',true);
					changeCol(cols.length,'change3');
		}else
		{
	  		changeCol(1,'change3');
	  	}
		return;
	}
	// wizard-step4:配置查询项
	function step4(id) {
		if (simple4) {
			// step1中的选择的表可能有了变化，需要重新更新leftTitle列表
			leftTitle = document.getElementById("leftTitleSelect4");
			leftTitle.options.length = 0;
			var tables = changeObj1.getRightData(getTable, 'tableId',
					'tableName');
			fillTitle(tables,leftTitle,'and viewtype=1');
			onTableChange(leftTitle);
					simple4.show();
					return;
		}
		condition = new Ext.form.TextArea({
			id:'condition',
			hideLabel : true,
			height : 110,
			width : 480,
			name : 'msg'
		})
		var topPanel = new Ext.FormPanel({
			region : "north",
			height : 120,
			frame : true,
			defaultType : 'textfield',
			items : [condition]

		})
		var westPanel = new Ext.Panel({
			region : "west",
			height : 120,
			width : 150,
			frame : true,
			defaultType : 'textfield',
			html : "<select id='leftTitleSelect4' style='width:138px' onchange='onTableChange(this)'></select><select id='leftSelect4' size=11 style='width:138px' onchange='onFieldChange(this)'></select>"

		})
		var centerPanel = new Ext.Panel({
			region : "center",
			width : 270,
			height : 270,
			frame : true,
			// items : new Ext.form.TextField({
			// id : 'fieldContent',
			// hideLabel : true,
			// emptyText : 'hello'
			// })
			html : "<div id='fieldContent'></div>"
		})
		var eastPanel = new Ext.Panel({
			region : "east",
			width : 70,
			height : 60,
			frame : true,
			items : [{
				xtype : 'button',
				text : i18n_dd.additional,
				minWidth : 55,
				allowBlank : false,
				handler : function() {
					if(document.getElementById('leftSelect4').selectedIndex<0)
					  Ext.MessageBox.alert(i18n.hint, i18n_dd.query_select_query_field);
					else
					{  
						value=jQuery("[name="+document.getElementById('leftSelect4').options[document.getElementById('leftSelect4').selectedIndex].text+"]").val();
						insertAtCursor(Ext.get('condition')," "
									+ document.getElementById('leftSelect4').options[document
											.getElementById('leftSelect4').selectedIndex].text
									+ "=" + "'" + value + "'")       							
					}
				}
			}, {
				xtype : 'button',
				text : 'AND',
				minWidth : 55,
				allowBlank : false,
				handler : function() {
					insertAtCursor(Ext.get('condition'), " "
							+ this.getText());
				}
			}, {
				xtype : 'button',
				text : 'OR',
				minWidth : 55,
				allowBlank : false,
				handler : function() {
					insertAtCursor(Ext.get('condition'), " "
							+ this.getText());
				}
			}, {
				xtype : 'button',
				text : 'NOT',
				minWidth : 55,
				allowBlank : false,
				handler : function() {
					insertAtCursor(Ext.get('condition'), " "
							+ this.getText());
				}
			}, {
				xtype : 'button',
				text : 'LIKE',
				minWidth : 55,
				allowBlank : false,
				handler : function() {
					insertAtCursor(Ext.get('condition')," "
							+ this.getText());
				}
			}, {
				xtype : 'button',
				text : '(',
				minWidth : 55,
				allowBlank : false,
				handler : function() {
					insertAtCursor(Ext.get('condition')," "
							+ this.getText());
				}
			}, {
				xtype : 'button',
				text : ')',
				minWidth : 55,
				allowBlank : false,
				handler : function() {
					insertAtCursor(Ext.get('condition'),this.getText());
				}
			}]
		})

		var panel4 = new Ext.Panel({
			layout : "border",
			width : 520,
			height : 380,
			items : [centerPanel, topPanel, westPanel, eastPanel],
			buttons : [{
				text : i18n_dd.prev,
				handler : function() {
					simple4.hide();
					simple3.show();
				}
			}, {
				text : i18n_dd.save,
				handler : function() {
					if (saveData()) {
						simple4.hide();
						clearData();
						query_onClick();
					}
				}
			}]

		});
		simple4 = new Ext.Window({
			title : i18n_dd.query_guide_4_querycondition,
			width : 520,
			height : 380,
			minWidth : 300,
			minHeight : 200,
			layout : 'fit',
			plain : true,
			resizable : false,
			closable : true,
			closeAction : 'close',
			modal : true,
			animCollapse : false,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			items : panel4,
			listeners:{"beforeclose":function(obj){
				clearData();
				return true;}
			} 			
 						
		});
		simple4.show(Ext.get(id));
		leftTitle = document.getElementById("leftTitleSelect4");
		if (data) {
			condition.setValue(data.condition);
		}
		var tables = changeObj1.getRightData(getTable, 'tableId', 'tableName');
		fillTitle(tables,leftTitle,'and viewtype=3');
		onTableChange(leftTitle);
		return;
	}
	// 主窗口页面
	var viewport = new Ext.Viewport({
		layout : 'border',
		items : [queryPanel, grid]
	});// end viewport

	grid.getTopToolbar().add('->', {
		pressed : true,
		text : i18n.add,
		tooltip : i18n.add,
		iconCls : 'add',
		handler : function() {
			step1('center');
		}
	}, {
		pressed : true,
		text : i18n.modify,
		tooltip : i18n.modify,
		iconCls : 'modify',
		handler : function() {
			var selects = grid.getSelectionModel().getSelections();
			var len = selects.length;
			if (len == 0) {
				Ext.MessageBox.alert(i18n.hint, i18n.please_choose_a_records_to_modify);
				return;
			}
			if (len > 1) {
				Ext.MessageBox.alert(i18n.hint, i18n.can_only_choose_a_record_to_modify);
				return;
			}
			ModuleManageService.findQueryModule(selects[0].id, selects[0]
					.get("templateId"), function(data) {
				modifyModule('center', data);
					//alert(dwr.util.toDescriptiveString(data, 2));
				});
			grid.getSelectionModel().clearSelections();
		}
	}
/*	, {
		pressed : true,
		text : '查看',
		tooltip : '查看选中功能',
		iconCls : 'view',
		handler : function() {
			var selects = grid.getSelectionModel().getSelections();
			var len = selects.length;
			if (len == 0) {
				Ext.MessageBox.alert(i18n.hint, '请选择要查看的数据！');
				return;
			}
			if (len > 1) {
				Ext.MessageBox.alert(i18n.hint, '只能选择一条数据！');
				return;
			}
			// alert(dwr.util.toDescriptiveString(selects[0].id, 3));
			ModuleManageService.findModule(selects[0].id, function(data) {
				lookModule('center', data);
					// alert(dwr.util.toDescriptiveString(data, 2));
				});
		}

	}*/
	, {
		pressed : true,
		text : i18n.to_delete,
		tooltip : i18n.to_delete,
		iconCls : 'delete',
		handler : function() {
			var selects = grid.getSelectionModel().getSelections();
			var len = selects.length;
			if (len == 0) {
				Ext.MessageBox.alert(i18n.hint, i18n.please_choose_record_to_delete);
				return;
			}
			if (len > 1) {
				Ext.MessageBox.alert(i18n.hint, i18n.can_only_select_a_record);
				return;
			}
			Ext.MessageBox.confirm(i18n_dd.select_box, i18n_dd.confirm_delete, function(btn) {
				if (btn == 'yes') {
					delSelectRow();
				};
			});
		}
	});

	query_onClick();
	function delSelectRow() {
		DWREngine.setAsync(false);
		var selects = grid.getSelectionModel().getSelections();
		ModuleManageService.deleteModule(selects[0].id, selects[0]
				.get("templateId"), function(data) {
			if (data.indexOf(i18n_dd.success) == 0) {
				for (var g = 0; g < len; g++) {
					moduleStore.remove(selects[g]);
				}
			}
			Ext.MessageBox.alert(i18n.hint, data);
			query_onClick();
		});
		DWREngine.setAsync(true);
	}

	function saveData() {
		if (changeObj2.getRightData(ModuleUtil.getField, 'fieldId',
				'tableName', 'seqNo', 'LIST').length == 0) {
			Ext.MessageBox.alert(i18n.hint, i18n_dd.select_list_field);
			return
		}
		/**if (changeObj3.getRightData(ModuleUtil.getField, 'fieldId',
				'tableName', 'seqNo', 'QUERY').length == 0) {
			Ext.MessageBox.alert(i18n.hint, '请选择查询字段！');
			return;
		}*/
		var listFields = changeObj2.getRightData(ModuleUtil.getField,
				'fieldId', 'tableName', 'seqNo', 'LIST');
		/**var queryFields = changeObj3.getRightData(ModuleUtil.getField,
				'fieldId', 'tableName', 'seqNo', 'QUERY');*/
		if(data)
			var module=data;
		else	
			var module = ModuleUtil.getModule();
		module.name = Ext.get('moduleName').getValue();
		module.templateId = '003';
		module.condition = condition.getValue();
		if(jQuery(".column:not(:parent)").length>0)
		{
			Ext.MessageBox.alert(i18n.hint, i18n_dd.queryitem_layout_cannotbenull);
			return;
		}
		var result=[];
		jQuery(".column").each(function(n){
			var xx = jQuery("#"+this.id).sortable("serialize");
			result=result.concat(xx);
		})
		module.queryFieldsConf=result.join(',');
		module.queryFieldsConf=module.queryFieldsConf.replace(/field\[\]=/g,"");
		DWREngine.setAsync(false);
		if(data)
			ModuleManageService.updateQueryModule(module, listFields, function(data) {
				result = data;
			})
		else
			ModuleManageService.addQueryModule(module, listFields, function(data) {
				result = data;
			});
		DWREngine.setAsync(true);
		Ext.MessageBox.alert(i18n.hint, result);
		if (i18n_dd.success_save_data != result) {
			return false;
		}else
		{
			return true;
		}
	}
	// 修改功能信息
	function modifyModule(id, curdata) {
		data = curdata;
		step1('center');
	}
	function clearData() {
		if (simple2)
			simple2.destroy();
		if (simple3)
			simple3.destroy();
		if (simple4)
			simple4.destroy();
		if (simple1)
			simple1.destroy();
		simple1 = null;
		simple2 = null;
		simple3 = null;
		simple4 = null;
		data = null;
	}
	// 根据tables取出满足条件的视图，加载到leftTitle中
	function fillTitle(tables,leftTitle,condition)
	{
			var tableName='';	
			for (var i = 0; i < tables.length; i++) {
				if(i==tables.length-1)
					tableName=tableName+ tables[i].tableName;
				else	
					tableName=tableName+ tables[i].tableName+",";
					
			}	
			DWREngine.setAsync(false);
			ModuleManageService.getViewsByTable(tableName,
				condition, function fillList(data) {
					for (var i = 0; i < data.data.length; i++) {
						var no = new Option();
						no.value = data.data[i].code;
						no.text = data.data[i].code;
						leftTitle.options[leftTitle.options.length] = no;
					}
			});	
				DWREngine.setAsync(true);
		
	}
});
