var moduleStore;
var pageSize = 200;// 页显示数据个数,默认为15

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

	moduleStore = new Ext.data.Store({
	   url:webdir+ "/grid.do?cmd=queryAll4Demo2",
	   reader:new Ext.data.XmlReader({
               record: 'row',
               id: 'id',
               totalRecords: '@total'
           }, ['name', 'sex', 'city', 'cardType','cardNo','note'])
	});
	
	
	var sm = new Ext.grid.CheckboxSelectionModel();
	var cm = new Ext.grid.ColumnModel([sm, 
            	{
            		header : "姓名",
            		width : 130,
            		sortable : true,
            		dataIndex : 'name'
            	}, {
            		header : '性别',
            		width : 80,
            		sortable : true,
            		dataIndex : 'sex'
            	}, {
            		header : "城市",
            		width : 80,
            		sortable : true,
            		dataIndex : 'city'	
            	}, {
            		header : "证件类型",
            		width : 170,
            		sortable : false,
            		dataIndex : 'cardType'
            	}, {
            		header : "证件号",
            		width : 170,
            		sortable : false,
            		dataIndex : 'cardNo'
            	}, {
            		header : "备注",
            		width : 170,
            		sortable : false,
            		dataIndex : 'note'
            	}
     ]);
	var demo2 = new Ext.grid.GridPanel({
		id : 'demo2',
		border : true,
		title : 'Ext列表控件实现',
		region : 'center',
		layout : 'fit',
		applyTo : 'ext_demo2',
		width : 800,
		height : 350,
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
			displayMsg : '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
			emptyMsg : "没有记录"
		}),
		viewConfig : {
			sortAscText : '升序',
			sortDescText : '降序',
			columnsText : '显示列',
			forceFit : true
		}
	})
	demo2.getTopToolbar().add('->', {
		pressed : true,
		text : '新增',
		tooltip : '增加演示',
		iconCls : 'add',
		handler : function() {
			Ext.MessageBox.alert('提示', "示例代码1！");
		}
	}, {
		pressed : true,
		text : '删除',
		tooltip : '删除演示',
		iconCls : 'delete',
		handler : function() {
			var selects =  demo2.getSelectionModel().getSelections();
			var len = selects.length;
			Ext.MessageBox.confirm('选择框', '您是否确认删除'+len+'条数据？', function(btn) {
				if (btn == 'yes') {
					Ext.MessageBox.alert('提示', '此代码为前台示例代码，没有写后台实际删除功能！');
				};
			});
			
		}
	}, {
		pressed : true,
		text : '提交',
		tooltip : '提交演示',
		iconCls : 'view',
		handler : function() {
			Ext.MessageBox.alert('提示', '没有记录被修改！');
		}
	});

	query_onClick();
});
