/*
 * WorkFlow Submit Button.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'WorkFlowButtonRollback', new FCKDialogCommand( 'WorkFlowButtonRollback', FCKLang.WorkFlowButtonRollbackDlgTitle, FCKPlugins.Items['workFlowButtonRollback'].Path + 'fck_workFlowButtonRollback.html', 380, 280 ) ) ;

// Create the "WorkFlowButtonRollback" toolbar button.
var oWorkFlowButtonRollbackItem = new FCKToolbarButton( 'WorkFlowButtonRollback', FCKLang.WorkFlowButtonRollbackBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 104 ) ;
oWorkFlowButtonRollbackItem.IconPath = FCKPlugins.Items['workFlowButtonRollback'].Path + 'workFlowButtonRollback.gif' ;

FCKToolbarItems.RegisterItem( 'WorkFlowButtonRollback', oWorkFlowButtonRollbackItem ) ;


// The object used for all WorkFlowButtonRollback operations.
var FCKWorkFlowButtonRollback = new Object() ;

// Add a new workFlowButtonRollback at the actual selection.
FCKWorkFlowButtonRollback.Add = function( sId, sValue )
{
	var oButton = FCK.CreateElement( '<INPUT type="button">' ) ;
	this.SetupButton( oButton, sId, sValue ) ;
}

FCKWorkFlowButtonRollback.SetupButton = function( button, sId, sValue )
{
	button.id = sId;
	button.value = sValue;
    button.onclick = "rollback()";

	if ( FCKBrowserInfo.IsGecko )
		button.style.cursor = 'default' ;

	button.contentEditable = false ;

	// To avoid it to be resized.
	button.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the BUTTON when clicking on it.
FCKWorkFlowButtonRollback._SetupClickListener = function()
{
	FCKWorkFlowButtonRollback._ClickListener = function( e )
	{
		if ( e.target.type == 'button' && e.target.id == 'rollbackAlexander' )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKWorkFlowButtonRollback._ClickListener, true ) ;
}

// Open the WorkFlowButtonRollback dialog on double click.
FCKWorkFlowButtonRollback.OnDoubleClick = function( button )
{
	if ( button.type == 'button' && button.id == 'rollbackAlexander' )
		FCKCommands.GetCommand( 'WorkFlowButtonRollback' ).Execute() ;
	else if ( button.type == 'button' && button.id == 'commitAlexander' )
		FCKCommands.GetCommand( 'WorkFlowButton' ).Execute() ;
}

FCK.RegisterDoubleClickHandler( FCKWorkFlowButtonRollback.OnDoubleClick, 'INPUT' ) ;