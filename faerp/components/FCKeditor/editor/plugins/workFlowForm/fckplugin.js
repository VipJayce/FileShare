/*
 * WorkFlow Form.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'WorkFlowForm', new FCKDialogCommand( 'WorkFlowForm', FCKLang.WorkFlowFormDlgTitle, FCKPlugins.Items['workFlowForm'].Path + 'fck_workFlowForm.html', 380, 280 ) ) ;

// Create the "WorkFlowForm" toolbar button.
var oWorkFlowFormItem = new FCKToolbarButton( 'WorkFlowForm', FCKLang.WorkFlowFormBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 104 ) ;
oWorkFlowFormItem.IconPath = FCKPlugins.Items['workFlowForm'].Path + 'workFlowForm.gif' ;

FCKToolbarItems.RegisterItem( 'WorkFlowForm', oWorkFlowFormItem ) ;