jQuery(function(){
       jQuery("#query_viewCode,#query_viewName").keyup(function(){
	      query_onClick();
	   }).keyup();
	   //清空按钮的行为
	   jQuery("#clear_btn").click(function(){
	   			clear_onClick();
	   			query_onClick();
	   });
	   jQuery("#query_viewType").bind("change",function(){
	   			query_onClick();
	   });
	var moduleStore;
	var pageSize = 15;// 页显示数据个数,默认为15
	
	// 组装查询条件，重新装载列表数据
	function query_onClick() {
		if(moduleStore!=undefined)
		{
			moduleStore.load({
				params : {
					start : 0,
					limit : pageSize
				}
			});
		}
	}
	function clear_onClick(){
		Ext.get('query_viewCode').dom.value = '';
		Ext.get('query_viewName').dom.value = '';
		Ext.get('query_viewType').dom.value = '';
	}
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
		name : 'code',
		mapping : 'code'
	}, {
		name : 'name',
		mapping : 'name'
	}, {
		name : 'viewType',
		mapping : 'viewType'
	}, {
		name : 'conditionstr',
		mapping : 'conditionstr'
	}, {
		name : 'businessClass',
		mapping : 'businessClass'
	}];
	var grid_row = new Ext.data.Record.create(record);
	moduleStore = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ControlDataService.getViewsAjax, true),
		reader: new Ext.data.ListRangeReader({
		totalProperty: 'totalSize',
		id: 'id'
		}, grid_row),
		remoteSort: true
	});
	
	moduleStore.on('beforeload',function(obj,arg){
		var condition = '';
		if (document.getElementById('query_viewCode').value != '')
			condition = condition + " and code like'%"
					+ document.getElementById('query_viewCode').value + "%'";
		if (document.getElementById('query_viewName').value != '')
			condition = condition + " and name like'%"
					+ DWRUtil.getValue('query_viewName') + "%'";
		if(Ext.get('query_viewType').dom.value !='')
			condition = condition + " and viewtype ="
					+ Ext.get('query_viewType').dom.value;			
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
		header : i18n_dd.code,
		width : 80,
		sortable : true,
		dataIndex : 'code'
	}, {
		header : i18n_dd.name,
		width : 80,
		dataIndex : 'name'
	}, {
		header : i18n_dd.view_type,
		width : 80,
		dataIndex : 'viewType',
		renderer : function(value) {
			if (value == '1') {
				return i18n_dd.list_view;
			} else if(value == "2"){
				return i18n_dd.edit_view;
			} else if(value == "3"){
				return i18n_dd.query_view;
			} else if(value == "4"){
				return i18n_dd.toolbar_view;
			}
		}
	}, {
		header : i18n_dd.condition,
		width : 120,
		sortable : false,
		dataIndex : 'conditionstr'
	}, {
		header : i18n_dd.business_class,
		width : 120,
		sortable : false,
		dataIndex : 'businessClass'
	}]);
	var selectNode;// 当前选择的叶子节点
	var grid = new Ext.grid.GridPanel({// 定义表格
		id : 'grid',// id为grid
		border : true,// 出现边框
		title : i18n_dd.view_list,// 标题内容为
		region : 'center',// 设定显示区域为中心,停靠在容器中心
		layout : 'fit',// 表格内列内容填充满,按列头比例填充
		buttonAlign : 'center',
		stripeRows:true,
		frame:true,
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
			var obj = window.showModalDialog(webPath+'/jsp/dd/controldata/viewEdit.jsp',[null,'insert'],'dialogHeight:370px;dialogWidth:470px;center=yes;help:no;resizable:no;scroll:no;status:0;');	
			if(obj == null || obj == undefined ){
				return;
			}
			query_onClick();
			Ext.MessageBox.alert(i18n.hint, obj);
		}
	}, {
		pressed : true,
		text : i18n.to_delete,
		iconCls : 'delete',
		handler : function() {
			if(!isSelected(i18n_dd.select_data))return;
			Ext.MessageBox.confirm(i18n_dd.select_box, i18n_dd.confirm_delete, function(btn) {
				if (btn == 'yes') {
					delSelectRow();
				};
			});
		}
	}, {
		pressed : true,
		text : i18n.modify,
		iconCls : 'modify',
		handler : function() {
			if(!isSelected(i18n_dd.select_data))return;
			modify_onClick();
			grid.getSelectionModel().clearSelections();
		}
	}, {
		pressed : true,
		text : i18n_dd.editfield,
		iconCls : 'view',
		handler : function() {
			if(!isSelected(i18n_dd.select_data))return;
			zoom_onClick();
		}
	},{
		pressed : true,
		text : i18n.refresh,
		iconCls : 'add',
		handler : function() {
			query_onClick();
		}
	},{
		pressed : true,
		text : i18n_dd.exportview,
		iconCls : 'add',
		handler : function() {
			export_onClick();
		}
	},{
		pressed : true,
		text : i18n_dd.cloneview,
		iconCls : 'add',
        handler : function() {
            clone_onClick();
        }
	});

	grid.addListener('rowdblclick',function(){
		zoom_onClick();
	});
	query_onClick();
	function isSelected(message){
		var selects =  grid.getSelectionModel().getSelections();
		var len = selects.length;
		if (len == 0) {
			Ext.MessageBox.alert(i18n.hint, message);
			return false;
		}
		if (len > 1) {
			Ext.MessageBox.alert(i18n.hint, i18n_dd.only_select_one_record);
			return false;
		}
		return true;
	}
	function delSelectRow() {
		DWREngine.setAsync(false);
		var selects =  grid.getSelectionModel().getSelections();
		ControlDataService.deleteView(selects[0].id,function(data) {
			//alert(dwr.util.toDescriptiveString(selects[0], 3));
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
	
	function modify_onClick(){
		var view;
		DWREngine.setAsync(false);
		var selects =  grid.getSelectionModel().getSelections();
		ControlDataService.findViewWithoutVirtualField(selects[0].id,function(data){
			view=data;
		});
		DWREngine.setAsync(true); 
		var obj = window.showModalDialog(webPath+'/jsp/dd/controldata/viewEdit.jsp',[view,'update'],'dialogHeight:400px;dialogWidth:550px;center=yes;help:no;resizable:no;scroll:no;status:0;');
		if(obj == null || obj == undefined){
			return;
		}
		query_onClick();
		Ext.MessageBox.alert(i18n.hint, i18n_dd.success_update(1));
	}
	function zoom_onClick(){
		var selects =  grid.getSelectionModel().getSelections();
		form.action = webPath+"/jsp/dd/controldata/fieldList.jsp?viewId="+selects[0].id;
		form.submit();
	}
	
	function export_onClick(){
		var selects =  grid.getSelectionModel().getSelections();
        if (selects.length == 0) {
            Ext.MessageBox.alert(i18n.hint, i18n_dd.select_data);
            return false;
        }
		var ids;
		for(var i=0;i<selects.length;i++){
			if(i==0){
				ids = selects[i].id;
			}else{
				ids = ids + "," + selects[i].id;
			}
		};
		showBlockPage();
		DataTransService.exportViewSQL(ids,function(data){
			Ext.MessageBox.alert(i18n.hint, data);
			hideBlockPage();
		});
	}
	function clone_onClick(){
		var selects =  grid.getSelectionModel().getSelections();
        if (selects.length != 1) {
            Ext.MessageBox.alert(i18n.hint, i18n.can_only_select_a_record);
            return false;
        }
        var obj = window.showModalDialog(webPath+'/jsp/dd/controldata/viewClone.jsp',[selects[0].data.code],'dialogHeight:300px;dialogWidth:510px;center=yes;help:no;resizable:no;scroll:no;status:0;');
        if(obj == null || obj == undefined){
            return;
        }
        query_onClick();
	}
});
