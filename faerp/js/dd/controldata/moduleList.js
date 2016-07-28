var moduleStore;
var pageSize = 25;// 页显示数据个数,默认为25
// alert(dwr.util.toDescriptiveString(Ext.get('subTable1-checkbox').dom, 2));

// 组装查询条件，重新装载列表数据
function query_onClick() {
	moduleStore.load({
		params : {
			start : 0,
			limit : pageSize
		}
	});
}

// 功能管理工具类,下面的方法都是类方法
function ModuleUtil() {
}
ModuleUtil.getModule = function() {
	var module = {
		id : "",
		name : "",
		tableName : "",
		templateId : "",
		param : "",
		tranFlag : "1",
		isSystem : "",
		url : "",
		tabName:"",
		detailVos : null
	};
	return module;
}

ModuleUtil.getCombo = function(store, name, filedLabel, width, emptyText,
		allowBlank, editable) {
	if(store==null)
	{
		store = new Ext.data.SimpleStore({
  		fields: ["id", "text"],
  		data: []
		})
	}
	var combo = new Ext.form.ComboBox({
		xtype : 'combo',
		id : name,
		name : name,
		store : store,
		valueField : "retrunValue",
		displayField : "displayText",
		mode : 'local',
		forceSelection : true,
		blankText : emptyText,
		emptyText : emptyText,
		editable : editable,
		triggerAction : 'all',
		allowBlank : allowBlank,
		fieldLabel : filedLabel,
		valueNotFoundText:'', 
		width : width
	});
	return combo;
}

ModuleUtil.getFieldSet = function(store, name) {
	var fieldSet = new Ext.form.FieldSet({
		xtype : 'fieldset',
		checkboxToggle : true,
		checkboxName : name + '-checkbox',
		id : name,
		name : name,
		title : i18n_dd.sub_table + name,
		autoHeight : true,
		defaults : {
			width : 200
		},
		defaultType : 'textfield',
		collapsed : true,
		items : [
				{
						fieldLabel : i18n_dd.tabname,
						id : name+'-subTab',
						allowBlank : false
				},
				ModuleUtil.getCombo(new Ext.data.Store({
						proxy : new Ext.data.DWRProxy(ModuleManageService.getViewsByTable, false),
						reader : new Ext.data.ListRangeReader({
							id : 'id',
							totalProperty : 'totalSize'
						}, Ext.data.Record.create([{
							name : 'retrunValue',
							mapping : 'code',
							type : 'string'
						}, {
							name : 'displayText',
							mapping : 'name',
							type : 'string'
						}])),
						remoteSort : false
					}), name + '-listView', i18n_dd.list_view, 190,
						i18n_dd.select, false, false),
				ModuleUtil.getCombo(new Ext.data.Store({
						proxy : new Ext.data.DWRProxy(ModuleManageService.getViewsByTable, false),
						reader : new Ext.data.ListRangeReader({
							id : 'id',
							totalProperty : 'totalSize'
						}, Ext.data.Record.create([{
							name : 'retrunValue',
							mapping : 'code',
							type : 'string'
						}, {
							name : 'displayText',
							mapping : 'name',
							type : 'string'
						}])),
						remoteSort : false
					}), name + '-editView', i18n_dd.edit_view, 190,
						i18n_dd.select, false, false),
				ModuleUtil.getCombo(new Ext.data.Store({
						proxy : new Ext.data.DWRProxy(ModuleManageService.getViewsByTable, false),
						reader : new Ext.data.ListRangeReader({
							id : 'id',
							totalProperty : 'totalSize'
						}, Ext.data.Record.create([{
							name : 'retrunValue',
							mapping : 'code',
							type : 'string'
						}, {
							name : 'displayText',
							mapping : 'name',
							type : 'string'
						}])),
						remoteSort : false
					}), name + '-queryView', i18n_dd.query_view, 190,
						i18n_dd.select, true, true),
				ModuleUtil.getCombo(new Ext.data.Store({
						proxy : new Ext.data.DWRProxy(ModuleManageService.getViewsByTable, false),
						reader : new Ext.data.ListRangeReader({
							id : 'id',
							totalProperty : 'totalSize'
						}, Ext.data.Record.create([{
							name : 'retrunValue',
							mapping : 'code',
							type : 'string'
						}, {
							name : 'displayText',
							mapping : 'name',
							type : 'string'
						}])),
						remoteSort : false
					}), name + '-toolView', i18n_dd.toolbar_view, 190,
						i18n_dd.select, false, false)]
	});
	var argParas = new Array();
	argParas.push(name);
	argParas.push(' and viewtype=1 ');
	Ext.getCmp(name + '-listView').store.load({
		arg : argParas
	});
	argParas.pop();
	argParas.push(' and viewtype=2 ');
	Ext.getCmp(name + '-editView').store.load({
		arg : argParas
	});
	argParas.pop();
	argParas.push(' and viewtype=3 ');
	Ext.getCmp(name + '-queryView').store.load({
		arg : argParas
	});
	argParas.pop();
	argParas.push(' and viewtype=4 ');
	Ext.getCmp(name + '-toolView').store.load({
		arg : argParas
	});
	return fieldSet;
}
// 功能管理工具类结束

Ext.onReady(function() {
	var data = null;
	simple1 = null;
	simple2= null;
	simple3 = null;
	tabWindow=null;
	form1 = null;
	form2 = null;
	form3 = null;
	templateType = '';
	masterTable = '';
	var oldTemplate;
	var oldMasterTable;
	
	// 模板类型下拉框
	function templateType_onChange(box, newvar, oldvar) {
		var argParas2 = new Array();
		if(newvar=='001')
			argParas2.push(0);
		else if(newvar=='002')	
			argParas2.push(1);
		argParas2.push(' and 1=1 ');
		tableStore.load({
			arg : argParas2
		});
	}
	// 数据表
	var tableStore = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ModuleManageService.getTableList, false),
		reader : new Ext.data.ListRangeReader({
			id : 'id',
			totalProperty : 'totalSize'
		}, Ext.data.Record.create([{
			name : 'retrunValue',
			mapping : 'tableName',
			type : 'string'
		}, {
			name : 'displayText',
			mapping : 'tableName',
			type : 'string'
		}])),
		remoteSort : false
	});
	var argParas2 = new Array();
	argParas2.push(0);
	argParas2.push(' and 1=1 ');
	tableStore.load({
		arg : argParas2
	});

	var viewStore1 = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ModuleManageService.getViewsByTable, false),
		reader : new Ext.data.ListRangeReader({
			id : 'id',
			totalProperty : 'totalSize'
		}, Ext.data.Record.create([{
			name : 'retrunValue',
			mapping : 'code',
			type : 'string'
		}, {
			name : 'displayText',
			mapping : 'name',
			type : 'string'
		}])),
		remoteSort : false
	});
	var viewStore2 = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ModuleManageService.getViewsByTable, false),
		reader : new Ext.data.ListRangeReader({
			id : 'id',
			totalProperty : 'totalSize'
		}, Ext.data.Record.create([{
			name : 'retrunValue',
			mapping : 'code',
			type : 'string'
		}, {
			name : 'displayText',
			mapping : 'name',
			type : 'string'
		}])),
		remoteSort : false
	});
	var viewStore3 = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ModuleManageService.getViewsByTable, false),
		reader : new Ext.data.ListRangeReader({
			id : 'id',
			totalProperty : 'totalSize'
		}, Ext.data.Record.create([{
			name : 'retrunValue',
			mapping : 'code',
			type : 'string'
		}, {
			name : 'displayText',
			mapping : 'name',
			type : 'string'
		}])),
		remoteSort : false
	});
	var viewStore4 = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ModuleManageService.getViewsByTable, false),
		reader : new Ext.data.ListRangeReader({
			id : 'id',
			totalProperty : 'totalSize'
		}, Ext.data.Record.create([{
			name : 'retrunValue',
			mapping : 'code',
			type : 'string'
		}, {
			name : 'displayText',
			mapping : 'name',
			type : 'string'
		}])),
		remoteSort : false
	});
	var statusStore = new Ext.data.SimpleStore({
		fields : ["retrunValue", "displayText"],
		data : [[1, i18n.yes], [0, i18n.no]]
	});
	function step1(id) {
		if (simple1) {
			// 第二次进入页面
			if (!data) {
				Ext.getCmp('moduleName').setDisabled(false);
				templateType.setDisabled(false);
				templateType.focus();
				Ext.getCmp('moduleName').focus();
				simple1.show(Ext.get(id));
				return;
			} else {
				Ext.getCmp('moduleName').setValue(data.name);
				templateType.setValue(data.templateId);
				Ext.getCmp('moduleName').setDisabled(true);
				templateType.setDisabled(true);
				simple1.show(Ext.get(id));
				return;
			}
		}
		templateType = new Ext.form.ComboBox({
			fieldLabel : i18n_dd.template_type,
			id : 'templateId',
			store : gap.enumerate.templateTypes,
			typeAhead : true,
			forceSelection : true,
			allowBlank : false,
			triggerAction : 'all',
			emptyText : i18n_dd.select,
			selectOnFocus : true
	
		});
		// 模板类型改变事件
		templateType.on('change',templateType_onChange);		
		form1 = new Ext.FormPanel({
			closeAction : 'hide',
			baseCls : 'x-plain',
			id : 'form1',
			labelAlign : 'right',
			labelWidth : 75,
			width : 350,
			defaults : {
				width : 200
			},
			defaultType : 'textfield',
			items : [{
				fieldLabel : i18n_dd.module_name,
				id : 'moduleName',
				allowBlank : false
			}, templateType],

			buttons : [{
				text : i18n.cancel,
				handler : function() {
					clearData();
				}
			}, {
				text : i18n_dd.next,
				handler : function() {
				
					var module = ModuleUtil.getModule();
					module.name = Ext.get('moduleName').getValue();
					if (module.name == '') {
						Ext.MessageBox.alert(i18n.hint, i18n_dd.template_name+i18n_dd.cannot_be_null);
						return false;
					}

					if (templateType.getValue() == "002") {
						step2(id);
						simple1.hide();
					} else if (templateType.getValue() == "001") {
						step2(id);
						simple1.hide();
					} else
						Ext.MessageBox.alert(i18n.hint, i18n_dd.select_template);

				}

			}]
		});
		
		simple1 = new Ext.Window({
			title : i18n_dd.page_select_template,
			width : 500,
			height : 300,
			minWidth : 300,
			minHeight : 200,
			layout : 'fit',
			plain : true,
			closable : true,
			closeAction : 'close',
			modal : true,
			animCollapse : false,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			items : form1,
			listeners:{"beforeclose":function(obj){
				clearData();
				return true;}
			}			
		});
		if (data) {
			Ext.getCmp('moduleName').setValue(data.name);
			Ext.getCmp('moduleName').setDisabled(true);
			templateType.setValue(data.templateId);
			templateType.setDisabled(true);

		}
		simple1.show(Ext.get(id));
	}

	function step2(id) {
		if (oldTemplate == templateType.getValue()) {
			if (simple2 != null) {
				if (!data) {
					Ext.getCmp('masterTable').setDisabled(false);
					simple2.show(Ext.get(id));
					return;
				} else {
				Ext.getCmp('masterTable').fireEvent('change',Ext.getCmp('masterTable'),data.tableName,'');
					Ext.getCmp('masterTable').setValue(data.tableName);
					Ext.getCmp('masterTable').setDisabled(true);
					arr = data.param.split('+');
					Ext.getCmp('masterListView').setValue(arr[0].split('#')[1]);
					Ext.getCmp('masterEditView').setValue(arr[1].split('#')[1]);
					Ext.getCmp('masterQueryView').setValue(arr[2].split('#')[1]);
					Ext.getCmp('masterToolView').setValue(arr[3].split('#')[1]);
					Ext.getCmp('isSameTrans').setValue(data.tranFlag);					
					simple2.show(Ext.get(id));
					return;
				}
			}
		} else {
			oldTemplate = templateType.getValue();
			if (simple2 != null) {
				if (!data) {
					Ext.getCmp('masterTable').setValue('');
					Ext.getCmp('masterTable').setDisabled(false);
					Ext.getCmp('masterListView').setValue('');
					Ext.getCmp('masterEditView').setValue('');
					Ext.getCmp('masterQueryView').setValue('');
					Ext.getCmp('masterToolView').setValue('');
				} else {
					Ext.getCmp('masterTable').setValue(data.tableName);
					Ext.getCmp('masterTable').setDisabled(true);
					Ext.getCmp('masterTable').setValue(data.tableName);
					Ext.getCmp('masterTable').setDisabled(true);
					arr = data.param.split('+');
					Ext.getCmp('masterListView').setValue(arr[0].split('#')[1]);
					Ext.getCmp('masterEditView').setValue(arr[1].split('#')[1]);
					Ext.getCmp('masterQueryView').setValue(arr[2].split('#')[1]);
					Ext.getCmp('masterToolView').setValue(arr[3].split('#')[1]);
					Ext.getCmp('isSameTrans').setValue(data.tranFlag);
				}
				var frm = Ext.getCmp("form2").getForm();
				if (templateType.getValue() == "002") {
					Ext.getCmp('btnNext').show();
					Ext.getCmp('isSameTrans').setDisabled(false);
					Ext.getCmp('isSameTrans').setValue(1);
					Ext.getCmp('btnFinish').hide();
				} else if (templateType.getValue() == "001") {
					Ext.getCmp('btnNext').hide();
					Ext.getCmp('isSameTrans').setDisabled(true);
					Ext.getCmp('isSameTrans').setValue(123);					
					Ext.getCmp('btnFinish').show();
				}
				simple2.show(Ext.get(id));
				return;
			}
		}
		form2 = new Ext.FormPanel({
			id : 'form2',
			baseCls : 'x-plain',
			autoWidth : true,
			labelWidth : 75, // label settings here cascade unless
			width : 350,
			labelAlign : 'right',
			defaults : {
				width : 200
			},
			defaultType : 'textfield',

			items : [
					{
						fieldLabel : i18n_dd.tabname,
						id : 'mainTab',
						name:'mainTab',
						allowBlank : false
					},
					// masterTable1,
					ModuleUtil.getCombo(tableStore, 'masterTable', i18n_dd.master_table, 190,
							i18n_dd.select, false, false),
					ModuleUtil.getCombo(viewStore1, 'masterListView', i18n_dd.list_view,
							190, i18n_dd.select, false, false),
					ModuleUtil.getCombo(viewStore2, 'masterEditView', i18n_dd.edit_view,
							190, i18n_dd.select, false, false),
					ModuleUtil.getCombo(viewStore3, 'masterQueryView', i18n_dd.query_view,
							190, i18n_dd.select, false, false),
					ModuleUtil.getCombo(viewStore4, 'masterToolView', i18n_dd.toolbar_view,
							190, i18n_dd.select, false, false),
					ModuleUtil.getCombo(statusStore, 'isSameTrans', i18n_dd.is_same_trans,
							190, i18n_dd.select, false, false)],
			buttons : [{
				text : i18n_dd.prev,
				handler : function() {
					simple2.hide();
					simple1.show();
				}
			}, {
				id:'btnFinish',
				text : i18n_dd.finish,
				handler : function() {
					if (saveData()) {
					simple2.hide();
					query_onClick();
				}
			}
			}, {
				id : 'btnNext',
				text : i18n_dd.next,
				handler : function() {
					if (!Ext.getCmp('mainTab').getValue()
							|| Ext.getCmp('mainTab').getValue() == '') {
						Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.tabname+i18n_dd.cannot_be_null);
						return false;
					}
					if (!Ext.getCmp('masterTable').value
							|| Ext.getCmp('masterTable').value == '') {
						Ext.MessageBox.alert(i18n.hint, i18n_dd.select_master_table);
						return false;
					}
					if (!Ext.getCmp('masterListView').value
						|| Ext.getCmp('masterListView').value == '') {
						Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.list_view+i18n_dd.cannot_be_null);
						return false;
					}
					if (!Ext.getCmp('masterEditView').value
							|| Ext.getCmp('masterEditView').value == '') {
						Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.edit_view+i18n_dd.cannot_be_null);
						return false;
					}
					if (!Ext.getCmp('masterQueryView').value
							|| Ext.getCmp('masterQueryView').value == '') {
						Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.query_view+i18n_dd.cannot_be_null);
						return false;
					}
					if (!Ext.getCmp('masterToolView').value
							|| Ext.getCmp('masterToolView').value == '') {
						Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.toolbar_view+i18n_dd.cannot_be_null);
						return false;
					}
					simple2.hide();
					step3(id);
				}
			}]
		});
				
	Ext.getCmp('masterTable').on('change',masterTable_onChange);
	function masterTable_onChange(box, newvar, oldvar) {
		//Ext.getCmp('masterListView').setValue('');
		//Ext.getCmp('masterEditView').setValue('');
		//Ext.getCmp('masterQueryView').setValue('');
		var argParas = new Array();
		argParas.push(newvar);
		argParas.push(' and viewtype=1 ');
		viewStore1.load({
			arg : argParas
		});
		argParas.pop();
		argParas.push(' and viewtype=2 ');
		viewStore2.load({
			arg : argParas
		});		
		argParas.pop();
		argParas.push(' and viewtype=3 ');
		viewStore3.load({
			arg : argParas
		});		
		argParas.pop();
		argParas.push(' and viewtype=4 ');
		viewStore4.load({
			arg : argParas
		});		
		
	}	
		if (templateType.getValue() == "002") {
			Ext.getCmp('isSameTrans').setDisabled(false);
			Ext.getCmp('isSameTrans').setValue(1);			
			Ext.getCmp('masterTable').store = tableStore;
			Ext.getCmp('btnFinish').hide();
		} else if (templateType.getValue() == "001") {
			Ext.getCmp('masterTable').store = tableStore;
			Ext.getCmp('isSameTrans').setDisabled(true);
			Ext.getCmp('isSameTrans').setValue(123);	
			Ext.getCmp('btnNext').hide();
			Ext.getCmp('mainTab').setDisabled(true);
		}
		simple2 = new Ext.Window({
			title : i18n_dd.master_table+i18n_dd.parameter_config,
			width : 500,
			height : 300,
			minWidth : 300,
			minHeight : 200,
			layout : 'fit',
			closable : true,
			closeAction : 'close',
			plain : true,
			modal : true,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			items : form2,
			listeners:{"beforeclose":function(obj){
				clearData();
				return true;}
			}			
		});
		// 通过修改按钮第一次该页面，为页面元素赋值
		if (data) {
			Ext.getCmp('masterTable').fireEvent('change',Ext.getCmp('masterTable'),data.tableName,'');
			Ext.getCmp('masterTable').setValue(data.tableName);
			Ext.getCmp('mainTab').setValue(data.tabName);
			Ext.getCmp('masterTable').setDisabled(true);
			arr = data.param.split('+');
			Ext.getCmp('masterListView').setValue(arr[0].split('#')[1]);
			Ext.getCmp('masterEditView').setValue(arr[1].split('#')[1]);
			Ext.getCmp('masterQueryView').setValue(arr[2].split('#')[1]);
			Ext.getCmp('masterToolView').setValue(arr[3].split('#')[1]);
			Ext.getCmp('isSameTrans').setValue(data.tranFlag);	
		}
		setTimeout(function sleep(){simple2.show(Ext.get(id));},1000);
	}

	function step3(id) {
		if (!data) {
			if (oldMasterTable == Ext.getCmp('masterTable').value) {
				if (simple3 != null) {
					simple3.show(Ext.get(id));
					return;
				}
			} else {
				oldMasterTable = Ext.getCmp('masterTable').value;
				if (simple3 != null) {
					var frm = Ext.getCmp("form3").getForm();
					frm.reset();
					simple3.remove(frm);
				}

			}
		} else {
			if (simple3 != null) {
					var frm = Ext.getCmp("form3").getForm();
					frm.reset();
					simple3.remove(frm);
			}
		}
		form3 = new Ext.FormPanel({
			id : 'form3',
			labelWidth : 75, // label settings here cascade unless
			// overridden
			baseCls : 'x-plain',
			labelAlign : 'right',
			width : 550,
			autoScroll : true,
			defaultType : 'textfield',
			buttons : [{
				text : i18n_dd.prev,
				handler : function() {
					simple3.hide();
					step2(id);
				}

			}, {
				text : i18n_dd.finish,
				handler : function() {
					if (saveData()) {
						simple3.hide();
						query_onClick();
					}
				}
			}]
		});
		DWREngine.setAsync(false);
		ModuleManageService.getDetailTableList(Ext.getCmp('masterTable').value,
				function(data) {
					var subs = data;
					for (var i = 0; i < subs.length; i++) {
						form3.add(ModuleUtil.getFieldSet(null,
								subs[i].tableName));
					}

				});
		DWREngine.setAsync(true);
		simple3 = new Ext.Window({
			title : i18n_dd.sub_table+i18n_dd.parameter_config,
			width : 500,
			height : 300,
			minWidth : 300,
			minHeight : 200,
			layout : 'fit',
			plain : true,
			closable : true,
			closeAction : 'hide',
			modal : true,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			autoScroll : true,
			items : form3
		});
		if (data) {
			for (i = 0; i < data.detailVos.length; i++) {
				detailVo = data.detailVos[i];
				Ext.getCmp(detailVo.tableName).collapsed = false;
				Ext.getCmp(detailVo.tableName+"-subTab").setValue(detailVo.tabName);
				
				arr = detailVo.param.split('+');
				Ext.getCmp(detailVo.tableName + '-editView').setValue(arr[0]
						.split('#')[1]);
				Ext.getCmp(detailVo.tableName + '-listView').setValue(arr[1]
						.split('#')[1]);
				Ext.getCmp(detailVo.tableName + '-queryView').setValue(arr[3]
						.split('#')[1]);
				Ext.getCmp(detailVo.tableName + '-toolView').setValue(arr[2]
						.split('#')[1]);
			}
		}
		setTimeout(function sleep(){simple3.show(Ext.get(id));},1000);
	}
	// 修改功能信息
	function modifyModule(id, curdata) {
		data = curdata;
		step1('center1');
	}

	// 查看功能信息
	function lookModule(id, data) {
		if(tabWindow) return;
		var tabPanel = new Ext.TabPanel({
			// xtype : 'tabpanel',
			plain : true,
			activeTab : 0,
			height : 435,
			defaults : {
				bodyStyle : 'padding:10px'
			}
		});
		var details = data.detailVos;
		if(details){
		for (var i = 0; i < details.length; i++) {
			tabPanel.add({
				title : details[i].tableName,
				layout : 'form',
				defaults : {
					width : 430
				},
				defaultType : 'textfield',

				items : [{
					fieldLabel : i18n_dd.parameter,
					readOnly : true,
					value : details[i].param
				}]
			});
		}}

		var tab = new Ext.FormPanel({
			labelAlign : 'top',
			bodyStyle : 'padding:5px',
			width : 300,
			height : 500,
			items : [{
				layout : 'column',
				border : false,
				items : [{
					columnWidth : .5,
					layout : 'form',
					border : false,
					items : [{
						xtype : 'textfield',
						fieldLabel : i18n_dd.module_name,
						readOnly : true,
						value : data.name,
						anchor : '95%'
					}, {
						xtype : 'textfield',
						fieldLabel : i18n_dd.master_table,
						readOnly : true,
						value : data.tableName,
						anchor : '95%'
					}, {
						xtype : 'textfield',
						fieldLabel : i18n_dd.link,
						readOnly : true,
						value : data.url,
						width : 430,
						anchor : '95%'
					}]
				}, {
					columnWidth : .5,
					layout : 'form',
					border : false,
					items : [{
						xtype : 'textfield',
						fieldLabel : i18n_dd.template_type,
						readOnly : true,
						value : data.templateId,
						anchor : '95%'
					}, {
						xtype : 'textfield',
						fieldLabel : i18n_dd.parameter,
						readOnly : true,
						value : data.param,
						anchor : '95%'
					}]
				}]
			}, tabPanel],

			buttons : [{
				text : i18n.to_return ,
				handler : function() {
					tabWindow.close();
				}

			}]
		});
		tabWindow = new Ext.Window({
			title : i18n_dd.view_template_config,
			width : 500,
			height : 350,
			minWidth : 300,
			minHeight : 200,
			layout : 'fit',
			plain : true,
			closable : true,
			closeAction : 'close',
			modal : true,
			bodyStyle : 'padding:5px;',
			buttonAlign : 'center',
			autoScroll : true,
			items : tab
		});
		tabWindow.show(Ext.get(id));
	}

	Ext.QuickTips.init();
	var queryPanel = new Ext.Panel({
		region : 'north',
		title : i18n_dd.query_by_condition,
		collapsible : false,
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
	moduleStore = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ModuleManageService.getModuleList, true,
				new Object()),
		reader : new Ext.data.ListRangeReader({
			id : 'id',
			totalProperty : 'totalSize'
		}, grid_row),
		remoteSort : true
	});
	
	moduleStore.on('beforeload',function(obj,arg){
		var condition = '';
		if (document.getElementById('query_moduleName').value != '')
			condition = condition + " and name like'%"
					+ document.getElementById('query_moduleName').value + "%'";
		if (document.getElementById('query_templateType').value != '')
			condition = condition + " and templateId='"
					+ DWRUtil.getValue('query_templateType') + "'";
		condition = condition + " and templateId in ('001','002')"					
		var obj = new Object();
		var argParas = new Array();
		argParas.push(obj);
		argParas.push(true);
		argParas.push(condition);
		Ext.apply(
			arg,
			{
				arg:argParas
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
			if (value == '001') {
				return i18n_dd.common_template;
			} else {
				return i18n_dd.md_template;
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
		title : i18n_dd.dynamic_module_list,// 标题内容为
		region : 'center',// 设定显示区域为中心,停靠在容器中心
		layout : 'fit',// 表格内列内容填充满,按列头比例填充
		buttonAlign : 'center',
		stripeRows:true,		
		collapsible : true,
		ds : moduleStore,// 数据源为store 上边定义
		cm : cm,
		sm : sm,// 复选方式按sm定义方式
		tbar : [{}],
		bbar : new Ext.PagingToolbar({
			pageSize : pageSize,
			store : moduleStore,
			displayInfo : true,
			displayMsg : i18n_dd.page_message,
			emptyMsg : i18n_dd.no_record
		}),
		viewConfig : {
			sortAscText : i18n.ascending,
			sortDescText : i18n.descending,
			columnsText : i18n_dd.display_column,
			forceFit : true
		}
	})

	var viewport = new Ext.Viewport({
		layout : 'border',
		items : [queryPanel,grid]
	});// end viewport
	grid.getTopToolbar().add('->', {
		pressed : true,
		text : i18n.add,
		iconCls : 'add',
		handler : function() {
			clearData();
			step1('center1');
		}
	}, {
		pressed : true,
		text : i18n.modify,
		iconCls : 'modify',
		handler : function() {
			var selects = grid.getSelectionModel().getSelections();
			var len = selects.length;
			if (len == 0) {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.select_data);
				return;
			}
			if (len > 1) {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.only_select_one_record);
				return;
			}
		    // alert(dwr.util.toDescriptiveString(selects[0], 3));
			ModuleManageService.findModule(selects[0].id,selects[0].get("templateId"), function(data) {
				modifyModule('center1', data);
					// alert(dwr.util.toDescriptiveString(data, 2));
				});
			grid.getSelectionModel().clearSelections();
		}
	}, {
		pressed : true,
		text : i18n.view,
		iconCls : 'view',
		handler : function() {
			var selects =  grid.getSelectionModel().getSelections();
			var len = selects.length;
			if (len == 0) {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.select_data);
				return;
			}
			if (len > 1) {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.only_select_one_record);
				return;
			}
			// alert(dwr.util.toDescriptiveString(selects[0].id, 3));
			ModuleManageService.findModule(selects[0].id,selects[0].get("templateId"), function(data) {
 				clearData();
				lookModule('center1', data);
					// alert(dwr.util.toDescriptiveString(data, 2));
				});
		}

	}, {
		pressed : true,
		text : i18n.to_delete,
		iconCls : 'delete',
		handler : function() {
			var selects = grid.getSelectionModel().getSelections();
			var len = selects.length;
			if (len == 0) {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.select_data);
				return;
			}
			if (len > 1) {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.only_select_one_record);
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
		ModuleManageService.deleteModule(selects[0].id,selects[0].get("templateId"),function(data) {
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
		if(data)
			var module = data;
		else
		{
			var module = ModuleUtil.getModule();
			module.name = Ext.get('moduleName').getValue();
			if (module.name == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.template_name+i18n.cannot_be_null);
				return false;
			}
			module.templateId = templateType.getValue();
			module.tableName = Ext.getCmp('masterTable').value;
			if (module.tableName == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table_name+i18n.cannot_be_null);
				return false;
			}
		}
		module.tabName=Ext.getCmp('mainTab').getValue();
		module.param='';
		module.param = module.param + "tableView#"
				+ Ext.getCmp('masterListView').value;
		module.param = module.param + "+detailView#"
				+ Ext.getCmp('masterEditView').value;
		module.param = module.param + "+queryView#"
				+ Ext.getCmp('masterQueryView').value;
		module.param = module.param + "+toolView#"
				+ Ext.getCmp('masterToolView').value;
		var subList = new Array();
		if (oldTemplate == '002') {
			hasSub=false;
			for (i = 0; i < form3.items.length; i++) {
				if (!form3.items.get(i).collapsed) {
					hasSub=true;
					var subTable = {
						id : "",
						moduleId : "",
						tableName : "",
						tabName:"",
						param : ""
					};
					subTable.tableName = form3.items.get(i).name;
					module.tranFlag=Ext.getCmp('isSameTrans').value;
					var tabName = Ext
							.getCmp(subTable.tableName + '-subTab').getValue();
					if (!tabName || tabName == '') {
						Ext.MessageBox.alert(i18n.hint, subTable.tableName
								+ i18n_dd.tabname+i18n.cannot_be_null);
						return;
					}
					subTable.tabName=tabName;
					var tableView = Ext
							.getCmp(subTable.tableName + '-listView').value;
					if (!tableView || tableView == '') {
						Ext.MessageBox.alert(i18n.hint, subTable.tableName
								+ i18n_dd.list_view+i18n.cannot_be_null);
						return;
					}
					var detailView = Ext.getCmp(subTable.tableName
							+ '-editView').value;
					if (!detailView || detailView == '') {
						Ext.MessageBox.alert(i18n.hint, subTable.tableName
								+ i18n_dd.edit_view+i18n.cannot_be_null);
						return;
					}
					subTable.param = subTable.param + "detailView#"
							+ detailView;
					subTable.param = subTable.param + "+tableView#" + tableView;

					var toolView = Ext.getCmp(subTable.tableName
							+ '-toolView').value;
					if (!toolView || toolView == '') {
						Ext.MessageBox.alert(i18n.hint, subTable.tableName
								+ i18n_dd.toolbar_view+i18n.cannot_be_null);
						return;
					}
					subTable.param = subTable.param + "+toolView#" + toolView;

					var queryView = Ext.getCmp(subTable.tableName
							+ '-queryView').value;
					if(!queryView||queryView=='')
						queryView='undefined';
					subTable.param = subTable.param + "+queryView#" + queryView;

					subList[subList.length] = subTable;
				}
			}
			if(!hasSub)
			{
					Ext.MessageBox.alert(i18n.hint, i18n_dd.at_least_select_one_table);
					return;
			}
		}else if(oldTemplate == '001'){
				if (!Ext.getCmp('masterTable').value
						|| Ext.getCmp('masterTable').value == '') {
					Ext.MessageBox.alert(i18n.hint, i18n_dd.select_master_table);
					return false;
				}
				if (!Ext.getCmp('masterListView').value
					|| Ext.getCmp('masterListView').value == '') {
					Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.list_view+i18n_dd.cannot_be_null);
					return false;
				}
				if (!Ext.getCmp('masterEditView').value
						|| Ext.getCmp('masterEditView').value == '') {
					Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.edit_view+i18n_dd.cannot_be_null);
					return false;
				}
				if (!Ext.getCmp('masterQueryView').value
						|| Ext.getCmp('masterQueryView').value == '') {
					Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.query_view+i18n_dd.cannot_be_null);
					return false;
				}
				if (!Ext.getCmp('masterToolView').value
						|| Ext.getCmp('masterToolView').value == '') {
					Ext.MessageBox.alert(i18n.hint, i18n_dd.master_table+i18n_dd.toolbar_view+i18n_dd.cannot_be_null);
					return false;
				}
		}
		DWREngine.setAsync(false);
		if (!data) {
			ModuleManageService.addModule(module, subList, function(data) {
				result = data;
			});
		} else {
			ModuleManageService.updateModule(module, subList, function(data) {
				result = data;
			});
		}
		DWREngine.setAsync(true);
		Ext.MessageBox.alert(i18n.hint, result);
		if (i18n_dd.success_save_data != result) {
			return false;
		}else
		{
			return true;
		}

	}
	function clearData() {
		if (simple1)
			simple1.destroy();
		if (simple2)
			simple2.destroy();
		if (simple3)
			simple3.destroy();
		if (tabWindow)
			tabWindow.destroy();
		simple1 = null;
		simple2 = null;
		simple3 = null;
		tabWindow = null;
		data = null;
	}
});
