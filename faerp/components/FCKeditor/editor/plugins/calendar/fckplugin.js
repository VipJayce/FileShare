/*
 * Calendar.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'Calendar', new FCKDialogCommand( 'Calendar', FCKLang.CalendarDlgTitle, FCKPlugins.Items['calendar'].Path + 'fck_calendar.html', 380, 280 ) ) ;

// Create the "Calendar" toolbar button.
var oCalendarItem = new FCKToolbarButton( 'Calendar', FCKLang.CalendarBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 102 ) ;
oCalendarItem.IconPath = FCKPlugins.Items['calendar'].Path + 'calendar.gif' ;

FCKToolbarItems.RegisterItem( 'Calendar', oCalendarItem ) ;


// The object used for all Calendar operations.
var FCKCalendar = new Object() ;

// Add a new calendar at the actual selection.
FCKCalendar.Add = function( sId, sName, sDesc )
{
	var oSpan = FCK.CreateElement( 'SPAN' ) ;
	this.SetupSpan( oSpan, sId, sName, sDesc ) ;
}

FCKCalendar.SetupSpan = function( span, sId, sName, sDesc )
{
	span.innerHTML = sDesc + '  <input name="' + sName + '" type="text" id="' + sName + '" class="text_field_reference" readOnly><span id="' + sId + '">[' + sName + ']</span>' ;

	if ( FCKBrowserInfo.IsGecko )
		span.style.cursor = 'default' ;

	span._id = sId ;
	span._name = sName ;
	span._desc = sDesc ;
	span.contentEditable = false ;

	// To avoid it to be resized.
	span.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the SPAN when clicking on it.
FCKCalendar._SetupClickListener = function()
{
	FCKCalendar._ClickListener = function( e )
	{
		if ( e.target.tagName == 'SPAN' && e.target._id == 'Alexander.Calendar' )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKCalendar._ClickListener, true ) ;
}