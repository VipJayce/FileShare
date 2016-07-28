/*
 * WorkFlow Input Component.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'WorkFlowInput', new FCKDialogCommand( 'WorkFlowInput', FCKLang.WorkFlowInputDlgTitle, FCKPlugins.Items['workFlowInput'].Path + 'fck_workFlowInput.html', 380, 280 ) ) ;

// Create the "WorkFlowInput" toolbar button.
var oWorkFlowInputItem = new FCKToolbarButton( 'WorkFlowInput', FCKLang.WorkFlowInputBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 104 ) ;
oWorkFlowInputItem.IconPath = FCKPlugins.Items['workFlowInput'].Path + 'workFlowInput.gif' ;

FCKToolbarItems.RegisterItem( 'WorkFlowInput', oWorkFlowInputItem ) ;


// The object used for all WorkFlowInput operations.
var FCKWorkFlowInput = new Object() ;

// Add a new workFlowInput at the actual selection.
FCKWorkFlowInput.Add = function( sDesc, sId )
{
	var oSpan = FCK.CreateElement( 'SPAN' ) ;
	this.SetupSpan( oSpan, sDesc, sId ) ;
}

FCKWorkFlowInput.SetupSpan = function( span, sDesc, sId )
{
	span.innerHTML = sDesc + '  <input name="' + sId + '" type="text" id="' + sId + '" class="text_field">' ;

	if ( FCKBrowserInfo.IsGecko )
		span.style.cursor = 'default' ;

	span._id = sId;
	span._inputdesc = sDesc ;
	span.contentEditable = false ;

	// To avoid it to be resized.
	span.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the SPAN when clicking on it.
FCKWorkFlowInput._SetupClickListener = function()
{
	FCKWorkFlowInput._ClickListener = function( e )
	{
		if ( e.target.tagName == 'SPAN' && e.target._inputdesc )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKWorkFlowInput._ClickListener, true ) ;
}