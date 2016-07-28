/*
 * WorkFlow Select Component.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'WorkFlowSelect', new FCKDialogCommand( 'WorkFlowSelect', FCKLang.WorkFlowSelectDlgTitle, FCKPlugins.Items['workFlowSelect'].Path + 'fck_workFlowSelect.html', 480, 380 ) ) ;

// Create the "WorkFlowSelect" toolbar button.
var oWorkFlowSelectItem = new FCKToolbarButton( 'WorkFlowSelect', FCKLang.WorkFlowSelectBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 104 ) ;
oWorkFlowSelectItem.IconPath = FCKPlugins.Items['workFlowSelect'].Path + 'workFlowSelect.gif' ;

FCKToolbarItems.RegisterItem( 'WorkFlowSelect', oWorkFlowSelectItem ) ;


// The object used for all WorkFlowSelect operations.
var FCKWorkFlowSelect = new Object() ;

// Add a new WorkFlowSelect at the actual selection.
FCKWorkFlowSelect.Add = function( sDesc, select, sName, sValue, sSize, sMultiple, str ) {
	var oSpan = FCK.CreateElement( 'SPAN' ) ;
	this.SetupSpan( oSpan, sDesc, select, sName, sValue, sSize, sMultiple, str ) ;
}

FCKWorkFlowSelect.SetupSpan = function( span, sDesc, select, sName, sValue, sSize, sMultiple, str ) {
	span.innerHTML = sDesc + '  ' + select.outerHTML ;

	if ( FCKBrowserInfo.IsGecko )
		button.style.cursor = 'default' ;

	span._selectdesc = sDesc ;
	span._name       = sName ;
	span._value      = sValue ;
	span._size       = sSize ;
	span._multiple   = sMultiple ;
	span._selectstr  = str ;
	span.contentEditable = false ;

	// To avoid it to be resized.
	span.onresizestart = function() {
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the INPUT when clicking on it.
FCKWorkFlowSelect._SetupClickListener = function() {
	FCKWorkFlowSelect._ClickListener = function( e ) {
		if ( e.target.tagName == 'SPAN' && e.target._selectdesc ) {
			FCKSelection.SelectNode( e.target ) ;
		}
	}

	FCK.EditorDocument.addEventListener( 'click', FCKWorkFlowSelect._ClickListener, true ) ;
}