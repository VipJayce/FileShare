//config toolbar
FCKConfig.ToolbarSets["workflow"] = [
	['Preview','-','Templates'],
	['Cut','Copy','Paste','PasteText','PasteWord'],
	['Form','Table','TextField','Textarea','Select','Button'],
	['Bold','Italic','Underline','StrikeThrough','-'],
	['OrderedList','UnorderedList','-','Outdent','Indent'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['Rule','PageBreak'],
	'/',
	['Style','FontFormat','FontName','FontSize'],
	['TextColor','BGColor','-','Source','-','About'],
	'/',
	['WorkFlowForm','-','WorkFlowInput','-','WorkFlowTextarea','-','WorkFlowSelect','-','Attachment','-','Calendar','-','Organization','-','WorkFlowButton','-','WorkFlowButtonRollback']
] ;

var sPluginPath = FCKConfig.BasePath.substr(0, FCKConfig.BasePath.length - 7) + 'editor/plugins/' ;
FCKConfig.Plugins.Add( 'workFlowForm', 'en,zh-cn', sPluginPath ) ;
FCKConfig.Plugins.Add( 'attachment', 'en,zh-cn', sPluginPath ) ;
FCKConfig.Plugins.Add( 'calendar', 'en,zh-cn', sPluginPath ) ;
FCKConfig.Plugins.Add( 'organization', 'en,zh-cn', sPluginPath ) ;
FCKConfig.Plugins.Add( 'workFlowButton', 'en,zh-cn', sPluginPath ) ;
FCKConfig.Plugins.Add( 'workFlowButtonRollback', 'en,zh-cn', sPluginPath ) ;
FCKConfig.Plugins.Add( 'workFlowInput', 'en,zh-cn', sPluginPath ) ;
FCKConfig.Plugins.Add( 'workFlowSelect', 'en,zh-cn', sPluginPath ) ;
FCKConfig.Plugins.Add( 'workFlowTextarea', 'en,zh-cn', sPluginPath ) ;