var moduleStore;
var pageSize = 15;// 页显示数据个数,默认为15

function query_onClick() {
	moduleStore.load({
		params : {
			start : 0,
			limit : pageSize
		}
	});
}

Ext.onReady(function() {
	var data = null;	
	Ext.QuickTips.init();

	var record = [{
		name : 'accountId',
		mapping : 'accountId'
	}, {
		name : 'name',
		mapping : 'name'
	}, {
		name : 'sex',
		mapping : 'sex'
	}, {
		name : 'city',
		mapping : 'city'
	}, {
		name : 'cardType',
		mapping : 'cardType'
	}, {
		name : 'cardNo',
		mapping : 'cardNo'
	}, {
		name : 'note',
		mapping : 'note'
	}];
	var grid_row = new Ext.data.Record.create(record);
	moduleStore = new Ext.data.Store({
		proxy : new Ext.data.DWRProxy(GridSampleAction.findUsersAjax, true),
		reader: new Ext.data.ListRangeReader({
		totalProperty: 'totalSize',
		id: 'id'
		}, grid_row),
		remoteSort: true
});
	
	moduleStore.on('beforeload',function(obj,arg){
		var condition = '';		
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
	
	var sm = new Ext.grid.CheckboxSelectionModel();
	var cm = new Ext.grid.ColumnModel([sm, {
		header : i18n4ajaxList.name,
		width : 80,
		sortable : true,
		dataIndex : 'name'
	}, {
		header : i18n4ajaxList.sex,
		width : 80,
		dataIndex : 'sex',
		renderer : function(value) {
			if(value == '1')return i18n4ajaxList.male;
			return i18n4ajaxList.female;
		}
	}, {
		header : i18n.city,
		width : 80,
		dataIndex : 'city',
		renderer : function(value) {
			if (value == '1') {
				return i18n.beijing;
			} else if(value == "2"){
				return i18n.shanghai;
			} else if(value == "3"){
				return i18n.hangzhou;
			} else if(value == "4"){
				return i18n.nanjing;
			}
		}	
	}, {
		header : i18n.document_type,
		width : 120,
		sortable : false,
		dataIndex : 'cardType',
		renderer : function(value) {
			if(value == '1')return i18n4ajaxList.ID;
			return i18n4ajaxList.student_card;
		}
	}, {
		header : i18n.document_number,
		width : 120,
		sortable : false,
		dataIndex : 'cardNo'
	}, {
		header : i18n.notes,
		width : 120,
		sortable : false,
		dataIndex : 'note'
	}]);
	var grid = new Ext.grid.GridPanel({
		id : 'grid',
		border : true,
		title : 'Ext列表控件实现',
		region : 'center',
		layout : 'fit',
		applyTo : 'div_list',
		width : 800,
		height : 400,
		loadMask : true,
		buttonAlign : 'center',
		stripeRows:true,
		frame:true,
		collapsible : true,
		ds : moduleStore,
		cm : cm,
		sm : sm,
		tbar : [{}],
		bbar : new Ext.PagingToolbar({
			pageSize : pageSize,
			store : moduleStore,
			displayInfo : true,
			displayMsg : i18n4ajaxList.displayMsg,
			emptyMsg : i18n.no_record
		}),
		viewConfig : {
			sortAscText : i18n.ascending,
			sortDescText : i18n.descending,
			columnsText : i18n4ajaxList.show_columns,
			forceFit : true
		}
	})
	grid.getTopToolbar().add('->', {
		pressed : true,
		text : i18n.added,
		tooltip : '增加演示',
		iconCls : 'add',
		handler : function() {
			Ext.MessageBox.alert('提示', "示例代码1！");
		}
	}, {
		pressed : true,
		text : i18n.delete_it,
		tooltip : '删除演示',
		iconCls : 'delete',
		handler : function() {
			var selects =  grid.getSelectionModel().getSelections();
			var len = selects.length;
			Ext.MessageBox.confirm('选择框', '您是否确认删除'+len+'条数据？', function(btn) {
				if (btn == 'yes') {
					Ext.MessageBox.alert('提示', '此代码为前台示例代码，没有写后台实际删除功能！');
				};
			});
			
		}
	}, {
		pressed : true,
		text : i18n4ajaxList.modify,
		tooltip : '提交演示',
		iconCls : 'view',
		handler : function() {
			Ext.MessageBox.alert('提示', '没有记录被修改！');
		}
	});

	query_onClick();
});
