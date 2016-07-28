// 功能管理工具类,下面的方法都是类方法
function CodegenUtil() {
}
CodegenUtil.getModule = function() {
	var moduleInfo = {
		projectName : "",
		projectPath : "",
		srcName : "",
		webAppName : "",
		name : "",
		keyName : "",
		author : "",
		jspSourcePath : "jsp",
		javaPackage:"",
		moduleId : null,
		moduleType: "",
		WFListModuleId : null,
		WFHistoryListModuleId : null
	};
	return moduleInfo;
}
// 功能管理工具类结束

Ext.onReady(function() {
    var toolbarPanel = new Ext.Panel({
        title: i18n_dd.toolbar,
        region:"south",
        collapsible:true,
        width:400,
        html:i18n_dd.toolbar_button
    });
    var contentPanel = new Ext.FormPanel({
        title: i18n_dd.codegen_info_area,
        region:"center",
        id:"form",
        width:400,
        items: [{
            xtype:'fieldset',
            title: i18n_dd.codegen_info_project,
            autoHeight:true,
            defaults: {width: 210},
            defaultType: 'textfield',
            collapsible: false,
            items :[{
                    fieldLabel: i18n_dd.codegen_path_project,
                    id: 'projectPath',
                    name: 'projectPath',
                    allowBlank:false
                },{
                    fieldLabel: i18n_dd.codegen_name_project,
                    id: 'projectName',
                    name: 'projectName',
                    allowBlank:false
                },{
                    fieldLabel: i18n_dd.codegen_name_sourcecode,
                    id: 'srcName',
                    name: 'srcName',
                    allowBlank:false
                }, {
                    fieldLabel: i18n_dd.codegen_name_web,
                    id: 'webAppName',
                    name: 'webAppName',
                    allowBlank:false
                }
            ]
        },{
            xtype:'fieldset',
            title: i18n_dd.codegen_baseinfo_function,
            collapsible: false,
            autoHeight:true,
            defaults: {width: 210},
            defaultType: 'textfield',
            items :[{
                    fieldLabel: i18n_dd.module_name,
                    id: 'name',
                    name: 'name',
                    allowBlank:false
                },{
                    fieldLabel: i18n_dd.codegen_key_function,
                    id: 'keyName',
                    name: 'keyName',
                    allowBlank:false,
					listeners : { 
					        "change" : function() { 
					        		if(Ext.getCmp('jspSourcePath').getValue()=="")
					                	Ext.getCmp('jspSourcePath').setValue("jsp/"+Ext.getCmp('keyName').getValue()); 
							} 
					}   
                },{
                    fieldLabel: i18n_dd.codegen_author,
                    id: 'author',
                    name: 'author'
                },{
                    fieldLabel: i18n_dd.codegen_path_jspfile,
                    id: 'jspSourcePath',
                    name: 'jspSourcePath',
                    allowBlank:false
                },{
                    fieldLabel: i18n_dd.codegen_name_package_code,
                    id: 'javaPackage',
                    name: 'javaPackage',
                    allowBlank:false
                }
            ]
        },{
            xtype:'fieldset',
            title: i18n_dd.codegen_info_extendfunction,
            id:'commonFieldSet',
            checkboxToggle : true,//提供选择并收缩功能
			checkboxName : 'Commoncheckbox',
            collapsible: false,//不提供收缩按钮
            collapsed : false,//默认展开
            autoHeight:true,
            defaults: {width: 210},
            defaultType: 'textfield',
            listeners:{
            		beforecollapse:function(){
						if(!jQuery("[name='Commoncheckbox']").attr("checked") && !jQuery("[name='WFcheckbox']").attr("checked")){
							jQuery("[name='Commoncheckbox']").attr("checked",true);
							return false;
						}
            		},
            		beforeexpand:function(){
            			if(jQuery("[name='Commoncheckbox']").attr("checked") && jQuery("[name='WFcheckbox']").attr("checked")){
							Ext.getCmp("WFFieldSet").collapse(false);
						}
            		}	
            },
            items :[new Ext.form.ComboBox({
                    fieldLabel: i18n_dd.codegen_dynamic_module,
                    id:'moduleId',
                    name: 'module',
                    lazyRender:true,
                    triggerAction:'all',
					forceSelection : true,                    
                    transform:'idmodule'
                }),new Ext.form.ComboBox({
                	fieldLabel: '模板类型',
                	id:'templateTypeId',
                    name: 'templateType',
                    lazyRender:true,
                    triggerAction:'all',
					forceSelection : false,
					transform:'idtemplateType'         
                })
            ]
        },{
        	xtype:'fieldset',
        	title: i18n_dd.codegen_template_wf,
        	id:'WFFieldSet',
        	checkboxToggle : true,
			checkboxName : 'WFcheckbox',
        	collapsible: false,
        	collapsed : true,
            autoHeight:true,
            defaults: {width: 210},
            defaultType: 'textfield',
            listeners:{
            		beforecollapse:function(){
						if(!jQuery("[name='Commoncheckbox']").attr("checked") && !jQuery("[name='WFcheckbox']").attr("checked")){
							jQuery("[name='WFcheckbox']").attr("checked",true);
							return false;
						}
            		},
            		beforeexpand:function(){
            			if(jQuery("[name='Commoncheckbox']").attr("checked") && jQuery("[name='WFcheckbox']").attr("checked")){
							Ext.getCmp("commonFieldSet").collapse(false);
						}
            		}	
            },
            items :[new Ext.form.ComboBox({
                    fieldLabel: i18n_dd.codegen_startWF_function,
                    id:'WFListModuleId',
                    name:'WFListModule',
                    lazyRender:true,
                    triggerAction:'all',
					forceSelection : true,                    
                    transform:'idWFListModule'
                	}),
                	new Ext.form.ComboBox({
                    fieldLabel: i18n_dd.codegen_query_history_function,
                    id:'WFHistoryListModuleId',
                    name:'WFHistoryListModule',
                    lazyRender:true,
                    triggerAction:'all',
					forceSelection : true,                    
                    transform:'idWFHistoryListModule'})
                	
            ]
        }
        ],
        buttons: [{
            text: i18n_dd.codegen_create_config_file,
			handler : function() {
					generateCode('0')
				}            
        },{
            text: i18n_dd.codegen_create_code,
			handler : function() {
					generateCode('1')
			}              
        },{
            text: i18n_dd.codegen_clear_info,
			handler : function() {
					clear_onClick()
			}              
        }]        
    });
    /**
    	生成中间文件或静态代码，flag=='0'时生成中间文件 flag=='1'时生成静态代码
    */
	function generateCode(flag) {
		var module =CodegenUtil.getModule();
		module.projectPath=Ext.get('projectPath').getValue();
		if (module.projectPath == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_path_project_cannot_null);
				return false;
		}		
		module.projectName=Ext.get('projectName').getValue();
		if (module.projectName == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_name_project_cannot_null);
				return false;
		}		
		module.srcName=Ext.get('srcName').getValue();
		if (module.srcName == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_name_sourcecode_cannot_null);
				return false;
		}	
		module.webAppName=Ext.get('webAppName').getValue();
		if (module.webAppName == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_name_web_cannot_null);
				return false;
		}			
		module.name=Ext.get('name').getValue();
		if (module.name == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_name_function_cannot_null);
				return false;
		}			
		module.keyName=Ext.get('keyName').getValue();
		if (module.keyName == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_key_function_cannot_null);
				return false;
		}			
		module.author=Ext.get('author').getValue();
		module.jspSourcePath=Ext.get('jspSourcePath').getValue();
		if (module.jspSourcePath == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_path_jspfile_cannot_null);
				return false;
		}				
		module.javaPackage=Ext.get('javaPackage').getValue();
		if (module.jspSourcePath == '') {
				Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_name_package_code_cannnot_null);
				return false;
		}				
		module.moduleId=Ext.getCmp('moduleId').value;
		module.WFListModuleId=Ext.getCmp('WFListModuleId').value;
		module.WFHistoryListModuleId=Ext.getCmp('WFHistoryListModuleId').value;
		//模板类型设置
		if(jQuery("[name='Commoncheckbox']").attr("checked")){//动态功能
			var templateType = Ext.getCmp('templateTypeId').value;
			module.moduleType=templateType;
		}else{//工作流模板...
			module.moduleType = "WFTemplate";
		}
		if((!module.moduleId || module.moduleId == '')&&(!module.WFListModuleId || module.WFListModuleId == '')&&(!module.WFHistoryListModuleId || module.WFHistoryListModuleId == '')) {
			Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_pls_select_templateinfo);
			return false;
		}
		//if (!module.moduleId || module.moduleId == '') {
		//		Ext.MessageBox.alert(i18n.hint, i18n_dd.codegen_need_select_dynamic_module);
		//		return false;
		//}
		showBlockPage();
		CodegenService.generateCode(flag,module,function(data){
			alert(data);
			hideBlockPage();
		})
	}
	
	function clear_onClick(){
		jQuery("#form").clearForm();
	}
	
	new Ext.Viewport(
			{
				 layout:"border",		
				 items:[
				 	//{title:"友情提示",region:"north",height:100,html:"<h1>本功能简单介绍，使用场景等</h1>"},
				 	//hintPanel,
				 	//toolbarPanel,
				 	contentPanel
				 		//{title:"工具栏",region:"south",height:50,width:200,collapsible:true,html:"工具栏按钮"},
				 		//{title:"信息区域",region:"center",height:100,html:"<h1>项目信息，基本信息，扩展信息</h1>"}
				 		]
			}
	);
	CodegenService.getDefaultModuleInfo(function(data){
		Ext.getCmp('projectPath').setValue(data.projectPath);
		Ext.getCmp('srcName').setValue(data.srcName);
		Ext.getCmp('webAppName').setValue(data.webAppName);
	})
	//复选按钮功能变为单选
	/**jQuery("[name='Commoncheckbox']").click(function(){
		if(jQuery("[name='Commoncheckbox']").attr("checked") && jQuery("[name='WFcheckbox']").attr("checked")){
			Ext.getCmp("WFFieldSet").collapse(false);
		}
		if(!jQuery("[name='Commoncheckbox']").attr("checked") && !jQuery("[name='WFcheckbox']").attr("checked")){
			//Ext.getCmp("commonFieldSet").expand(false);
			//return false;
		}
	});
	jQuery("[name='WFcheckbox']").click(function(){
		if(jQuery("[name='WFcheckbox']").attr("checked") && jQuery("[name='Commoncheckbox']").attr("checked")){
			Ext.getCmp("commonFieldSet").collapse(false);
		}
	});*/
});
