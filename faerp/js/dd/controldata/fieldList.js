//TODO:增加布局按钮功能
var moduleStore;
var pageSize = 15;// 页显示数据个数,默认为15

function getBooleanDisplayValue(value){
	if (value == '1') {
		return i18n.yes;
	} 
	return i18n.no;
}

Ext.onReady(function() {
	
	// 组装查询条件，重新装载列表数据
	function query_onClick() {
		moduleStore.load({
			params : {
				start : 0,
				limit : pageSize
			}
		});
		refresh();
	}

	var view;
	function renderData(data){
		view = data;
		jQuery("#code").val(data.code);
		jQuery("#name").val(data.name);
		jQuery("#viewType").val(data.viewType);
		jQuery("#condition").val(data.condition);
		refreshToolbar();
	}
    function refresh(){
		ControlDataService.findView(viewId,renderData);
	}
	var data = null;	
	Ext.QuickTips.init();
	var viewdetailPanel = new Ext.Panel({
		region : 'north',
		title : i18n_dd.view_info,
		collapsible : true,
		titleCollapse : false,
		height : 190,
		layout : "fit",
		contentEl : 'viewDetail'
	});

	var record = [{
		name : 'name',
		mapping : 'name'
	}, {
		name : 'displayName',
		mapping : 'displayName'
	}, {
		name : 'status',
		mapping : 'status'
	}, {
		name : 'description',
		mapping : 'description'
	}, {
		name : 'displayType',
		mapping : 'displayType'
	}, {
		name : 'refModel',
		mapping : 'refModel'
				}, {
		name : 'refSource',
		mapping : 'refSource'
				}, {
		name : 'refSourceClass',
		mapping : 'refSourceClass'
				}, {
		name : 'condition',
		mapping : 'condition'
				}, {
		name : 'callBack',
		mapping : 'callBack'
				}, {
		name : 'tableName',
		mapping : 'tableName'
				}, {
		name : 'columnName',
		mapping : 'columnName'
				}, {
		name : 'readOnly',
		mapping : 'readOnly'
				}, {
		name : 'display',
		mapping : 'display'
				}, {
		name : 'sort',
		mapping : 'sort'
				}, {
		name : 'seqNo',
		mapping : 'seqNo'
				}, {
		name : 'category',
		mapping : 'category'
				}, {
		name : 'busKey',
		mapping : 'busKey'
						}, {
		name : 'wfFlag',
		mapping : 'wfFlag'
	}];
	var grid_row = new Ext.data.Record.create(record);
	moduleStore = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(ControlDataService.findViewAjax, true),
		reader: new Ext.data.ListRangeReader({
		totalProperty: 'totalSize',
		id: 'id'
		}, grid_row),
		remoteSort: true
});
	
	moduleStore.on('beforeload',function(obj,arg){
		var condition = viewId;		
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
		header : i18n_dd.display_name,
		width : 80,
		dataIndex : 'displayName'
	}, {
		header : i18n_dd.is_enabled,
		width : 80,
		dataIndex : 'status',
		renderer : function(value) {
			return getBooleanDisplayValue(value);
		}
	}, {
		header : i18n_dd.description,
		width : 120,
		sortable : false,
		dataIndex : 'description'
	}, {
		header : i18n_dd.display_type,
		width : 120,
		sortable : false,
		dataIndex : 'displayType',
		renderer : function(value){
			var displayType = '';
			if(value=='0')
		    	displayType=i18n_dd.label;
			else if(value=='1')
		    	displayType=i18n_dd.text;
		    else if(value=='2')
		    	displayType=i18n_dd.integer;	
		    else if(value=='3')
		    	displayType=i18n_dd.float;
		    else if(value=='4')
		    	displayType=i18n_dd.textarea;
		    else if(value=='5')
		    	displayType=i18n_dd.money;
		    else if(value=='6')
		    	displayType=i18n_dd.date;
		    else if(value=='7')
		    	displayType=i18n_dd.assist_tree;
		    else if(value=='8')
		    	displayType=i18n_dd.combobox;
		    else if(value=='9')
		    	displayType=i18n_dd.yesorno;
		    else if(value=='10')
		    	displayType=i18n_dd.button;
		    else if(value=='11')
		    	displayType=i18n_dd.toolbar_button;
		    else if(value=='12')
		    	displayType=i18n_dd.range_date;
		    else if(value=='13')
		    	displayType=i18n_dd.range_number;
		    else if(value=='14')
		    	displayType=i18n_dd.multi_select;
		    else if(value=='15')
		    	displayType=i18n_dd.upload;
		    else if(value=='16')
		    	displayType=i18n_dd.link;
		    else if(value=='17')
		    	displayType=i18n_dd.customcontrol1;
			else if(value=='18')
		    	displayType=i18n_dd.customcontrol2;
		   else if(value=='19')
		    	displayType=i18n_dd.customcontrol3; 	
		    return displayType;
		}
	}, {
		header : i18n_dd.reference_model,
		width : 120,
		sortable : false,
		dataIndex : 'refModel'
	}, {
		header : i18n_dd.basedata,
		width : 120,
		sortable : false,
		dataIndex : 'refSource'
	}, {
				header :i18n_dd.refsource,
		width : 120,
		sortable : false,
		dataIndex : 'refSourceClass'
	}, {
				header : i18n_dd.filter,
		width : 120,
		sortable : false,
		dataIndex : 'condtion'
	}, {
				header : i18n_dd.callback,
		width : 120,
		sortable : false,
		dataIndex : 'callBack'
	}, {
				header : i18n_dd.corresponding_table,
		width : 120,
		sortable : false,
		dataIndex : 'tableName'
	}, {
				header : i18n_dd.corresponding_column,
		width : 120,
		sortable : false,
		dataIndex : 'columnName'
	}, {
		header : i18n_dd.readonly,
		width : 120,
		sortable : false,
		dataIndex : 'readOnly',
		renderer : function(value){
			var readOnly = '';
			if(value=='0')
		    	readOnly=i18n_dd.no_readonly;
			else if(value=='1')
		    	readOnly=i18n_dd.readonly_when_modify;
			else if(value=='2')
		    	readOnly=i18n_dd.readonly_when_add;
			else if(value=='3')
		    	readOnly=i18n_dd.yes_readonly;
			return readOnly;		    	
		}
	}, {
		header : i18n_dd.display,
		width : 120,
		sortable : false,
		dataIndex : 'display',
		renderer : function(value) {
			return getBooleanDisplayValue(value);
		}
	}, {
		header : i18n.sort,
		width : 120,
		sortable : false,
		dataIndex : 'sort',
		renderer : function(value) {
			return getBooleanDisplayValue(value);
		}
	}, {
		header : i18n_dd.seqno,
		width : 120,
		sortable : false,
		dataIndex : 'seqNo'
	}, {
		header : i18n_dd.category,
		width : 120,
		sortable : false,
		dataIndex : 'category'
	}, {
		header :i18n_dd.buskey,
		width : 120,
		sortable : false,
		dataIndex : 'busKey'
			}, {
		header : i18n_dd.wfflag,
		width : 120,
		sortable : false,
		dataIndex : 'wfFlag'
	}]);
	var selectNode;// 当前选择的叶子节点
	var grid = new Ext.grid.GridPanel({// 定义表格
		id : 'grid',// id为grid
		border : true,// 出现边框
		title : i18n_dd.detail_table,// 标题内容为
		region : 'center',// 设定显示区域为中心,停靠在容器中心
		layout : 'fit',// 表格内列内容填充满,按列头比例填充
		stripeRows : true,
		buttonAlign : 'center',
		collapsible : true,
		frame : true,	
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
			forceFit : false
		}
	})
	var viewport = new Ext.Viewport({
		layout : 'border',
		items : [viewdetailPanel,grid]
	});// end viewport
	grid.getTopToolbar().add('->', {
		id:'btn_templateBTN',
		pressed : true,
		text : i18n_dd.template_btn,
		iconCls : 'layout',
		handler : function() {
			templateBTN_onClick();
		}
	},{
		id:'btn_layout',
		pressed : true,
		text : i18n_dd.layout,
		iconCls : 'layout',
		handler : function() {
			layout_onClick();
		}
	}, {
		id:'btn_add',
		pressed : true,
		text : i18n.add,
		iconCls : 'add',
		handler : function() {
			add_onClick();
		}
	}, {
		id:'btn_delete',
		pressed : true,
		text : i18n.to_delete,
		iconCls : 'delete',
		handler : function() {
			if(!isSelected())return;
			Ext.MessageBox.confirm(i18n_dd.select_box, i18n_dd.confirm_delete, function(btn) {
				if (btn == 'yes') {
					delete_onClick();
				};
			});
		}
	}, {
		id:'btn_modify',
		pressed : true,
		text : i18n.modify,
		iconCls : 'modify',
		handler : function() {
			if(!isSelected())return;
			modify_onClick();
		}
	}, {
		pressed : true,
		text : i18n.refresh,
		iconCls : 'add',
		handler : function() {
			query_onClick();
		}
	},{
		pressed : true,
		text : i18n.to_return,
		iconCls : 'view',
		handler : function() {
			history.go(-1);
		}
	});
	query_onClick();
	
	function refreshToolbar()
	{
		var viewTypeVal = jQuery("#viewType").val();
		if(viewTypeVal==1 || viewTypeVal==4)
		{
			Ext.getCmp('btn_layout').setDisabled(true);
		}
		else if(viewTypeVal==2 )
		{
			//Ext.getCmp('btn_delete').setDisabled(true);
		}
		else if(viewTypeVal==3 )
		{
			//Ext.getCmp('btn_add').setDisabled(true);
			//Ext.getCmp('btn_delete').setDisabled(true);
		}
	}
	function modify_onClick(){
		var field;
		var selects =  grid.getSelectionModel().getSelections();
		for(var i=0;i<view.fields.length;i++){
			if(view.fields[i].id==selects[0].id){
					field=view.fields[i];
					break;
			}
		}
		var obj = window.showModalDialog(webPath + '/jsp/dd/controldata/fieldEdit.jsp',[field,'update',view.viewType],'dialogHeight:400px;dialogWidth:510px;center=yes;help:no;resizable:no;scroll:yes;status:0;');
		if(obj == null || obj == undefined){
			grid.getSelectionModel().clearSelections();
			return;
		}
		grid.getSelectionModel().clearSelections();
		query_onClick();
	}
	
	function templateBTN_onClick(tdObj,tableId){
		var viewType = jQuery("#viewType").val();
		if("4" != viewType){
			alert(i18n_dd.template_btn_warn);
			return;
		}
		var obj = window.showModalDialog(webPath+'/jsp/dd/controldata/templateBTN.jsp',[viewId,jQuery("#code").val()],'dialogHeight:400px;dialogWidth:510px;center=yes;help:no;resizable:no;scroll:yes;status:0;');
		if(obj == null || obj == undefined ){
			return;
		}
		query_onClick();
		Ext.MessageBox.alert(i18n.hint, i18n_dd.success_update(1));
		
	}
	
	function add_onClick(tdObj,tableId){ 
		var obj = window.showModalDialog(webPath+'/jsp/dd/controldata/fieldEdit.jsp',[null,'insert',jQuery("#viewType").val(),viewId,jQuery("#code").val()],'dialogHeight:400px;dialogWidth:510px;center=yes;help:no;resizable:no;scroll:yes;status:0;');
		if(obj == null || obj == undefined ){
			return;
		}
		query_onClick();
		Ext.MessageBox.alert(i18n.hint, i18n_dd.success_update(1));
		
	}
	function delete_onClick(){  
		var field;
		var selects =  grid.getSelectionModel().getSelections();
		for(var i=0;i<view.fields.length;i++){
			if(view.fields[i].id==selects[0].id){
				field=view.fields[i];
				break;
			}
		}
		if (field.tableName!=""){
			Ext.MessageBox.alert(i18n.hint, i18n_dd.no_delete_default_field);
			return;
		}
		ControlDataService.deleteField(selects[0].id,function(data){
			query_onClick();
			Ext.MessageBox.alert(i18n.hint, data);
		});
	}
		/**
	* 功能描述：对字段进行布局
	*/
	function layout_onClick()
	{
		var obj = window.showModalDialog(webPath+'/jsp/dd/controldata/fieldLayout.jsp',[jQuery("#viewType").val(),viewId,jQuery("#code").val(),jQuery("#name").val()],'dialogHeight:425px;dialogWidth:640px;center=yes;help:no;resizable:no;scroll:yes;status:0;');
		if(obj == null || obj == undefined ){
			return;
		}
		query_onClick();	
		Ext.MessageBox.alert(i18n.hint,obj);
	}
	function isSelected(){
		var selects =  grid.getSelectionModel().getSelections();
		var len = selects.length;
		if (len == 0) {
			Ext.MessageBox.alert(i18n.hint, i18n_dd.select_data);
			return false;
		}
		if (len > 1) {
			Ext.MessageBox.alert(i18n.hint, i18n_dd.only_select_one_record);
			return false;
		}
		return true;
	}
	grid.addListener('rowdblclick',function(){
		modify_onClick();
	});

});
