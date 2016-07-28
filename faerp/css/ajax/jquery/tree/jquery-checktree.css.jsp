html {
	background-color: #f7f7f7;
}
body {
	//width: 800px;
	//margin: 10px auto;
	//padding: 10px 30px;
	background-color: #fff;
	//border: 1px dashed #888;
}
ul.tree, ul.tree * {
	list-style-type: none;
	margin: 0;
	padding: 0 0 5px 0;
}
ul.tree img.arrow {
	padding: 2px 0 0 0;
	border: 0;
	width: 20px;
}
ul.tree li {
	padding: 4px 0 0 0;
	float:left;
	width:100%;
}
ul.tree li ul {
	padding: 0 0 0 20px;
	margin: 0;
}
ul.tree label {
	cursor: pointer;
	font-weight: bold;
	padding: 2px 0;
}
ul.tree label.hover {
	color: red;
}
p {
	margin: 5px 15px;
}
ul {
	margin-top: 5px;
	margin-bottom: 5px;
}
ul.tree li .arrow {
	width: 14px;
	height: 20px;
	padding: 0;
	margin: 0;
	cursor: pointer;
	float: left;
	background: transparent no-repeat 0 4px;
	background-image: url(<%=request.getContextPath()%>/images/tree/leaf.gif);
}
ul.tree li .collapsed {
	background-image: url(<%=request.getContextPath()%>/images/tree/parent.gif);
}
ul.tree li .expanded {
	background-image: url(<%=request.getContextPath()%>/images/tree/parentopen.gif);
}

ul.tree li .checkbox {
	width: 14px;
	height: 18px;
	padding: 0;
	margin: 0;
	cursor: pointer;
	float: left;
	background: url(<%=request.getContextPath()%>/images/tree/check0.gif) no-repeat 0 0px;
}
ul.tree li .checked {
	background-image: url(<%=request.getContextPath()%>/images/tree/check2.gif);
}
ul.tree li .half_checked {
	background-image: url(<%=request.getContextPath()%>/images/tree/check1.gif);
}