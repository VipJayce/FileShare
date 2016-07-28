/*
 * Organization.
 */

// Register the related command.
FCKCommands.RegisterCommand( 'Organization', new FCKDialogCommand( 'Organization', FCKLang.OrganizationDlgTitle, FCKPlugins.Items['organization'].Path + 'fck_organization.html', 380, 280 ) ) ;

// Create the "Organization" toolbar button.
var oOrganizationItem = new FCKToolbarButton( 'Organization', FCKLang.OrganizationBtn, null, FCK_TOOLBARITEM_ICONTEXT, null, null, 103 ) ;
oOrganizationItem.IconPath = FCKPlugins.Items['organization'].Path + 'organization.gif' ;

FCKToolbarItems.RegisterItem( 'Organization', oOrganizationItem ) ;


// The object used for all Organization operations.
var FCKOrganization = new Object() ;

// Add a new organization at the actual selection.
FCKOrganization.Add = function( sDesc, sId, sName, value )
{
	var oSpan = FCK.CreateElement( 'SPAN' ) ;
	this.SetupSpan( oSpan, sDesc, sId, sName, value ) ;
}

FCKOrganization.SetupSpan = function( span, sDesc, id, name, value )
{
	span.innerHTML = sDesc + '  <input name="' + name + '" type="hidden" id="' + name + '"><input name="' + value + '" type="text" id="' + value + '" class="text_field_reference" readOnly><span id="' + id + '">[' + name + ',' + value + ']</span>' ;

	if ( FCKBrowserInfo.IsGecko )
		span.style.cursor = 'default' ;

	span._desc = sDesc ;
	span._id    = id ;
	span._name  = name ;
	span._value  = value ;
	span.contentEditable = false ;

	// To avoid it to be resized.
	span.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the SPAN when clicking on it.
FCKOrganization._SetupClickListener = function()
{
	FCKOrganization._ClickListener = function( e )
	{
		if ( e.target.tagName == 'SPAN' && e.target._id == 'Alexander.Organization' )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKOrganization._ClickListener, true ) ;
}