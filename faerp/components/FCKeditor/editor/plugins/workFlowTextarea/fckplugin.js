/*
 * WorkFlow Textarea Component.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'WorkFlowTextarea', new FCKDialogCommand( 'WorkFlowTextarea', FCKLang.WorkFlowTextareaDlgTitle, FCKPlugins.Items['workFlowTextarea'].Path + 'fck_workFlowTextarea.html', 380, 280 ) ) ;

// Create the "WorkFlowTextarea" toolbar button.
var oWorkFlowTextareaItem = new FCKToolbarButton( 'WorkFlowTextarea', FCKLang.WorkFlowTextareaBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 104 ) ;
oWorkFlowTextareaItem.IconPath = FCKPlugins.Items['workFlowTextarea'].Path + 'workFlowTextarea.gif' ;

FCKToolbarItems.RegisterItem( 'WorkFlowTextarea', oWorkFlowTextareaItem ) ;

// The object used for all WorkFlowTextarea operations.
var FCKWorkFlowTextarea = new Object() ;

// Add a new WorkFlowTextarea at the actual selection.
FCKWorkFlowTextarea.Add = function( sDesc, sId, sCols, sRows ) {
	var oButton = FCK.CreateElement( 'SPAN' ) ;
	this.SetupSpan( oButton, sDesc, sId, sCols, sRows ) ;
}

FCKWorkFlowTextarea.SetupSpan = function( span, sDesc, sId, sCols, sRows ) {
	span.innerHTML = sDesc + '  <textarea name="' + sId + '" id="' + sId + '" cols="' + sCols + '" rows="'+ sRows +'"></textarea>' ;

	if ( FCKBrowserInfo.IsGecko )
		span.style.cursor = 'default' ;

	span._texdesc = sDesc ;
	span._id      = sId;
	span._cols    = sCols ;
	span._rows    = sRows ;
	span.contentEditable = false ;

	// To avoid it to be resized.
	span.onresizestart = function() {
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the SPAN when clicking on it.
FCKWorkFlowTextarea._SetupClickListener = function() {
	FCKWorkFlowTextarea._ClickListener = function( e )	{
		if ( e.target.tagName == 'SPAN' && e.target._texdesc )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKWorkFlowTextarea._ClickListener, true ) ;
}

// Open the WorkFlowTextarea dialog on double click.
FCKWorkFlowTextarea.OnDoubleClick = function( span )
{
	if ( span.tagName == 'SPAN' && span._id == 'Alexander.Attachment' )
		FCKCommands.GetCommand( 'Attachment' ).Execute() ;

	if ( span.tagName == 'SPAN' && span._id == 'Alexander.Calendar' )
		FCKCommands.GetCommand( 'Calendar' ).Execute() ;

	if ( span.tagName == 'SPAN' && span._id == 'Alexander.Organization' )
		FCKCommands.GetCommand( 'Organization' ).Execute() ;

	if ( span.tagName == 'SPAN' && span._id == 'commitAlexander' )
		FCKCommands.GetCommand( 'WorkFlowButton' ).Execute() ;
		
	if ( span.tagName == 'SPAN' && span._id == 'rollbackAlexander' )
		FCKCommands.GetCommand( 'WorkFlowButtonRollback' ).Execute() ;

	if ( span.tagName == 'SPAN' && span._texdesc )
		FCKCommands.GetCommand( 'WorkFlowTextarea' ).Execute() ;

	if ( span.tagName == 'SPAN' && span._inputdesc )
		FCKCommands.GetCommand( 'WorkFlowInput' ).Execute() ;

	if ( span.tagName == 'SPAN' && span._selectdesc )
		FCKCommands.GetCommand( 'WorkFlowSelect' ).Execute() ;
}

FCK.RegisterDoubleClickHandler( FCKWorkFlowTextarea.OnDoubleClick, 'SPAN' ) ;