/*
 * WorkFlow Submit Button.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'WorkFlowButton', new FCKDialogCommand( 'WorkFlowButton', FCKLang.WorkFlowButtonDlgTitle, FCKPlugins.Items['workFlowButton'].Path + 'fck_workFlowButton.html', 380, 280 ) ) ;

// Create the "WorkFlowButton" toolbar button.
var oWorkFlowButtonItem = new FCKToolbarButton( 'WorkFlowButton', FCKLang.WorkFlowButtonBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 104 ) ;
oWorkFlowButtonItem.IconPath = FCKPlugins.Items['workFlowButton'].Path + 'workFlowButton.gif' ;

FCKToolbarItems.RegisterItem( 'WorkFlowButton', oWorkFlowButtonItem ) ;


// The object used for all WorkFlowButton operations.
var FCKWorkFlowButton = new Object() ;

// Add a new workFlowButton at the actual selection.
FCKWorkFlowButton.Add = function( sId, sValue )
{
	var oButton = FCK.CreateElement( '<INPUT type="button">' ) ;
	this.SetupButton( oButton, sId, sValue ) ;
}

FCKWorkFlowButton.SetupButton = function( button, sId, sValue )
{
	button.id = sId;
	button.value = sValue;
    button.onclick = "committask()";

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
FCKWorkFlowButton._SetupClickListener = function()
{
	FCKWorkFlowButton._ClickListener = function( e )
	{
		if ( e.target.type == 'button' && e.target.id == 'commitAlexander' )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKWorkFlowButton._ClickListener, true ) ;
}

// Open the WorkFlowButton dialog on double click.
FCKWorkFlowButton.OnDoubleClick = function( button )
{
	if ( button.type == 'button' && button.id == 'rollbackAlexander' )
		FCKCommands.GetCommand( 'WorkFlowButtonRollback' ).Execute() ;
	else if ( button.type == 'button' && button.id == 'commitAlexander' )
		FCKCommands.GetCommand( 'WorkFlowButton' ).Execute() ;
}

FCK.RegisterDoubleClickHandler( FCKWorkFlowButton.OnDoubleClick, 'INPUT' ) ;