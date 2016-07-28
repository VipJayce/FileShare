var moduleStore;
Ext.onReady(function(){

    Ext.QuickTips.init();
	// 组装查询条件，重新装载列表数据
	function query_onClick() {
		if(moduleStore!=undefined)
		{
			moduleStore.load({
			});
		}
	}

	function generate_onClick() {
		var selected =grid1.getSelectionModel().getSelected();//获取一行
		if (!selected) {
			Ext.MessageBox.alert(i18n.hint, i18n_dd.select_data);
			return;
		}
		var created=selected.get("created");
		if(created=="true")
		{
			Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_function_created_cannot_create_again);
			return;
		}
		DWREngine.setAsync(false);
		CodegenService.genCode(selected.id,function(data) {
			if (data.indexOf(i18n_dd.success) == 0) {
				for (var g = 0; g < selects.len; g++) {
					moduleStore.remove(selects[g]);
				}
			}
			Ext.MessageBox.alert(i18n.hint, data);
			query_onClick();			
		});
		DWREngine.setAsync(true);				
	}

	function revoke_onClick() {
		var selected =grid1.getSelectionModel().getSelected();//获取一行
		if (!selected) {
			Ext.MessageBox.alert(i18n.hint, i18n_dd.select_data);
			return;
		}
		var created=selected.get("created");
		if(created=="false")
		{
			Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_function_uncreated_cannot_cancel);
			return;
		}
		DWREngine.setAsync(false);
		CodegenService.revokeGen(selected.id,function(data) {
			if (data.indexOf(i18n_dd.success) == 0) {
				for (var g = 0; g < selects.len; g++) {
					moduleStore.remove(selects[g]);
				}
			}
			Ext.MessageBox.alert(i18n.hint, data);
			query_onClick();			
		});
		DWREngine.setAsync(true);				
	}
	
	function delete_onClick() {
		var selected =grid1.getSelectionModel().getSelected();//获取一行
		if (!selected) {
			Ext.MessageBox.alert(i18n.hint, i18n_dd.select_data);
			return;
		}
		var created=selected.get("created");
		if(created=="true")
		{
			Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_function_created_cannot_delete);
			return;
		}
		DWREngine.setAsync(false);
		CodegenService.deleteConfig(selected.id,function(data) {
			Ext.MessageBox.alert(i18n.hint, data);
			query_onClick();			
		});
		DWREngine.setAsync(true);				
	}

	function clear_onClick(){
		Ext.getCmp('moduleName').reset();
		Ext.getCmp('xmlName').reset();
		Ext.getCmp('created').reset();
	}

	var createStore = new Ext.data.SimpleStore({
		fields:['text','value'],
		data:[[i18n_dd.not_created,'false'],[i18n_dd.created,'true']]
	});
	
    var xmlreader=new Ext.data.DWRXmlReader({
	 id:'@text',
	 totalRecords:'results',
	 record:'moduleFile'
	},[{name:'moduleName',mapping:'@moduleName'},{name:'xmlName',mapping:'@text'},{name:'created',mapping:'@created'},{name:'templateFile',mapping:'@templateFile'}]);
               
	moduleStore = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(CodegenService.getModules),
		reader: xmlreader
	});

	moduleStore.on('beforeload',function(obj,arg){
		var argParas = new Array();
		argParas.push(jQuery("#moduleName").val());
		argParas.push(jQuery("#xmlName").val());
		argParas.push(Ext.getCmp('created').value);
		argParas.push("");
		Ext.apply(
			arg,
			{
				arg:argParas
			});
	});	
	
	var sm1 = new Ext.grid.CheckboxSelectionModel();// 表格复选列
	var index= new Ext.grid.RowNumberer({header:i18n.sequence});//行号 	
	var cm1 = new Ext.grid.ColumnModel([sm1,index, {
		header : i18n_dd.module_name,
		width : 80,
		sortable : true,
		dataIndex : 'moduleName'
	}, {
		header : i18n_dd.file_name,
		width : 80,
		dataIndex : 'xmlName'
	}, {
		header : i18n_dd.is_create,
		width : 80,
		dataIndex : 'created',
		renderer : function(value) {
			if (value=='true') {
				return i18n_dd.created;
			} else if(value=='false'){
				return i18n_dd.notecreated;
			} 
		}
	}, {
		header : i18n_dd.template_file,
		width : 80,
		dataIndex : 'templateFile'
	}]);
	var selectNode;// 当前选择的叶子节点
	var grid1 = new Ext.grid.GridPanel({// 定义表格
		id : 'grid',// id为grid
		border : true,// 出现边框
		title : i18n_dd.dynamic_module_list,// 标题内容为
		region : 'center',// 设定显示区域为中心,停靠在容器中心
		layout : 'fit',// 表格内列内容填充满,按列头比例填充
		buttonAlign : 'center',
		stripeRows:true,
		frame:true,
		collapsible : true,
		ds : moduleStore,// 数据源为store 上边定义
		cm : cm1,
		sm : sm1,// 复选方式按sm定义方式
		tbar : [{}],
		viewConfig : {
			sortAscText : i18n.ascending,
			sortDescText : i18n.descending,
			columnsText : i18n_dd.display_column,
			forceFit : true
		}
	})
	var queryPanel = new Ext.FormPanel({
		region : 'north',
		title : i18n_dd.query_by_condition,
		collapsible : true,
		height : 70,
        frame:true,
        bodyStyle:'padding:5px 5px 0',
		labelWidth : 60,                
		items: [{
            layout:'column',
            items:[{
                columnWidth:.2,
                layout: 'form',
                items: [{
                    xtype:'textfield',
                    fieldLabel: i18n_dd.module_name,
                    id: 'moduleName',
                    name: 'moduleName',
                    anchor:'95%'
                }]
            },{
                columnWidth:.2,
                layout: 'form',
                items: [{
                    xtype:'textfield',
                    fieldLabel: i18n_dd.file_name,
                    id: 'xmlName',
                    name: 'xmlName',
                    anchor:'95%'
                }]
            },{
                columnWidth:.2,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    store:createStore,
                    fieldLabel: i18n_dd.is_create,
                    displayField:'text',
                    valueField:'value',
                    triggerAction:'all',
                    mode:'local',
					allowBlank:true, 
					forceSelection:false,                    
                    id: 'created',
                    name: 'created',
                    anchor:'95%'
                }]
            },{
                width:50,
                layout: 'form',
                items: [{
                    xtype:'button',
                    text:i18n_dd.query_btn,
                    name: 'query',
					handler : function() {
						query_onClick();
					}                    
                }]
            },{
                width:50,
                layout: 'form',
                items: [{
                    xtype:'button',
                    text:i18n_dd.clear_btn,
                    name: 'clear',
					handler : function() {
						clear_onClick();
					}                     
                }]
            }]
        }]
        });

var viewport = new Ext.Viewport({
		layout : 'border',
		items : [queryPanel,grid1]
	});// end viewport
	
	grid1.getTopToolbar().add('->', {
		pressed : true,
		text : i18n_dd.create_btn,
		tooltip : i18n_dd.codegen_create_code,
		iconCls : 'add',
		handler : function() {
			generate_onClick();
		}
	}, {
		pressed : true,
		text : i18n_dd.cancel_btn,
		tooltip : i18n_dd.codegen_undo_code,
		iconCls : 'delete',
		handler : function() {
			Ext.MessageBox.confirm(i18n_dd.confirm_msg, i18n_dd.codegen_cancel_create_code_confirm_msg, function(btn) {
				if (btn == 'yes') {
					revoke_onClick();
				};
			});
		}
	},{
		pressed : true,
		text : i18n.to_delete,
		tooltip : i18n_dd.codegen_delete_config_file,
		iconCls : 'delete',
		handler : function() {
			Ext.MessageBox.confirm(i18n_dd.confirm_msg, i18n_dd.codegen_delete_config_file_confirm_msg, function(btn) {
				if (btn == 'yes') {
					delete_onClick();
				};
			});
		}
	},{
		pressed : true,
		text : i18n.refresh,
		tooltip : i18n_dd.codegen_refresh_page_data,
		iconCls : 'add',
		handler : function() {
			query_onClick();
		}
	}); 
	query_onClick();	
});