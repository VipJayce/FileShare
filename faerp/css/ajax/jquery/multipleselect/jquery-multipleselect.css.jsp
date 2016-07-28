.multiSelect {
	width: 182px;
	border: solid 1px #BBB;
	background: #FFF url(<%=request.getContextPath()%>/images/ajaxList/dropdown.gif) right center no-repeat;
	padding: 2px 4px;
	padding-right: 20px;
	display: inline;
}

.multiSelect.hover {
	background: url(<%=request.getContextPath()%>/images/ajaxList/dropdown_hover.gif) right center no-repeat;
}

.multiSelect.active, 
.multiSelect.focus {
	border: inset 1px #000;
}

.multiSelect.active {
	background: url(<%=request.getContextPath()%>/images/ajaxList/dropdown_active.gif) right center no-repeat;
}

.multiSelectOptions {
	width: 206px;
	max-height: 150px;
	margin-top: -1px;
	overflow: auto;
	border: solid 1px #B2B2B2;
	background: #FFF;
}

.multiSelectOptions LABEL {
	padding: 2px 5px;
	display: block;
}

.multiSelectOptions LABEL.checked {
	background: #E6E6E6;
}

.multiSelectOptions LABEL.selectAll {
	border-bottom: dotted 1px #CCC;
}

.multiSelectOptions LABEL.hover {
	background: #CFCFCF;
}