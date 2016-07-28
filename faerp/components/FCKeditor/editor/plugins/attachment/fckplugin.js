/*
 * Attachment.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'Attachment', new FCKDialogCommand( 'Attachment', FCKLang.AttachmentDlgTitle, FCKPlugins.Items['attachment'].Path + 'fck_attachment.html', 380, 280 ) ) ;

// Create the "Attachment" toolbar button.
var oAttachmentItem = new FCKToolbarButton( 'Attachment', FCKLang.AttachmentBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 101 ) ;
oAttachmentItem.IconPath = FCKPlugins.Items['attachment'].Path + 'attachment.gif' ;

FCKToolbarItems.RegisterItem( 'Attachment', oAttachmentItem ) ;


// The object used for all Attachment operations.
var FCKAttachment = new Object() ;

// Add a new attachment at the actual selection.
FCKAttachment.Add = function( sId, name )
{
	var oSpan = FCK.CreateElement( 'SPAN' ) ;
	this.SetupSpan( oSpan, sId, name ) ;
}

FCKAttachment.SetupSpan = function( span, sId, name )
{
	span.setAttribute("id", sId) ;
	span.innerHTML = '[' + name + ']' ;

	if ( FCKBrowserInfo.IsGecko )
		span.style.cursor = 'default' ;

	span._id = sId ;
	span._name = name ;
	span.contentEditable = false ;

	// To avoid it to be resized.
	span.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the SPAN when clicking on it.
FCKAttachment._SetupClickListener = function()
{
	FCKAttachment._ClickListener = function( e )
	{
		if ( e.target.tagName == 'SPAN' && e.target._id == 'Alexander.Attachment' ) {
			FCKSelection.SelectNode( e.target ) ;
		}
	}

	FCK.EditorDocument.addEventListener( 'click', FCKAttachment._ClickListener, true ) ;
}