/* CSS Document */

.flexigrid
	{
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	position: relative;
	border: 0px solid #eee;
	overflow: hidden;
	color: #000;
	}

	.flexigrid.hideBody
		{
		height: 26px !important;
		border-bottom: 1px solid #ccc;
		}

	.ie6fullwidthbug
		{
		border-right: 0px solid #ccc;
		padding-right: 2px;	
		}

.flexigrid div.nDiv
	{
	background: #daeaf6 url( <%=request.getContextPath()%>/images/ajaxList/grid/line.gif) repeat-y -1px top;
	border: 1px solid #ccc;
	border-top: 0px;
	overflow: auto;
	left: 0px;
	position: absolute;
	z-index: 999;
	float: left;
	}

	.flexigrid div.nDiv table
		{
		margin: 2px;
		}

.flexigrid div.hDivBox
	{
	float: left; 
	padding-right: 40px;
	}

.flexigrid div.bDiv table/*表体的表格样式*/
	{
	margin-bottom: 10px;
	}
	
	.flexigrid div.bDiv table.autoht
		{
		border-bottom: 0px;
		margin-bottom: 0px;
		}
	
.flexigrid div.nDiv td/*选择隐藏列表格中单元格样式*/
	{
	padding: 2px 3px;
	border: 1px solid #eee;
	cursor: default;
	}

.flexigrid div.nDiv tr:hover td, .flexigrid div.nDiv tr.ndcolover td
	{
	background: #d5effc url( <%=request.getContextPath()%>/images/ajaxList/grid/hl.png) repeat-x top;
	border: 1px solid #a8d8eb;
	}
	
	.flexigrid div.nDiv td.ndcol1/*选择隐藏列表格中第一个单元格样式*/
		{
		border-right: 1px solid #ccc;
		}
		
	.flexigrid div.nDiv td.ndcol2/*选择隐藏列表格中第二个单元格样式*/
		{
		border-left: 1px solid #fff;
		padding-right: 10px;
		}

	.flexigrid div.nDiv tr:hover td.ndcol1, .flexigrid div.nDiv tr.ndcolover td.ndcol1
		{
		border-right: 1px solid #d2e3ec;
		}
		
	.flexigrid div.nDiv tr:hover td.ndcol2, .flexigrid div.nDiv tr.ndcolover td.ndcol2
		{
		border-left: 1px solid #eef8ff;
		}
	
	.flexigrid div.nBtn /*隐藏列按钮样式*/
		{
		position: absolute;
		height: 24px;
		width: 14px;
		z-index: 900;
		background: #b9def7 url( <%=request.getContextPath()%>/images/ajaxList/grid/fhbg.gif) repeat-x bottom;
		border: 0px solid #ccc;
		border-left: 1px solid #ccc;
		top: 0px;
		left: 0px;
		margin-top: 1px;
		cursor: pointer;
		display: none;
		}
		
		.flexigrid div.nBtn div
			{
			height: 24px;
			width: 12px;
			border-left: 1px solid #fff;
			float: left;
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/ddn.png) no-repeat center;
			}		
		
		.flexigrid div.nBtn.srtd
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/wbg.gif) repeat-x 0px -1px;
			}
		

.flexigrid div.mDiv/*表名样式*/
	{
	background: url( <%=request.getContextPath()%>/images/ajaxList/grid/mdiv.gif) repeat-x top;
	border-top:2px solid green;
	border: 1px solid #ccc;
	border-bottom: 0px;
	font-weight: bold;
	display: block;
	height:30px;
	overflow: hidden;
	white-space: nowrap;
	position: relative;   
	z-index:1;
	}

.flexigrid div.mDiv div/*表名内嵌div样式*/
	{
	padding: 6px;
	white-space: nowrap;
	}
	
		.flexigrid div.mDiv div.ptogtitle/*隐藏表格按钮样式*/
			{
			position: absolute;
			top: 4px;
			right: 3px;
			padding: 0px;
			height: 16px;
			width: 16px;
			overflow: hidden;
			border: 1px solid #ccc;
			cursor: pointer;
			}
.flexigrid div.mDiv div.fbutton
		{
			float: left;
			border:1px solid #4999d8;
			color:#082a45;
			padding-left: 5px; 
			padding-right: 5px;
			padding-bottom:0px; 
			height: 18px;
			display: block;
			cursor: pointer;
			padding: 1px;
			position: absolute;
			top: 4px;
			font-weight:normal;
			background: #fafafa url( <%=request.getContextPath()%>/images/templatestyle/btnbg.jpg) repeat-x top;
		}
.flexigrid div.btnseparator
		{
		float: left;
		height: 16px;
		border-left: 1px solid #ffffff;
		border-right: 1px solid #ffffff;
		margin: 1px;
		position: absolute;
		}
			.flexigrid div.mDiv div.ptogtitle:hover
			{
			background-position: left -2px;
			border-color: #bbb;
			}
			
			.flexigrid div.mDiv div.ptogtitle span
			{
			display: block;
			border-left: 1px solid #eee;
			border-top: 1px solid #fff;
			border-bottom: 1px solid #ddd;
			width: 14px;
			height: 14px;
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/uup.png) no-repeat center;
			}
			
			.flexigrid div.mDiv div.ptogtitle.vsble span
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/ddn.png) no-repeat center;			
			}			

.flexigrid div.tDiv /*toolbar*/
	{
	background: #fafafa url( <%=request.getContextPath()%>/images/ajaxList/grid/bg.gif) repeat-x top;
	position: relative;			
	border: 1px solid #ccc;
	border-bottom: 0px;
	overflow: hidden;
	}

	.flexigrid div.tDiv2
		{
		float: left;
		clear: both;
		padding: 1px;
		}

.flexigrid div.sDiv /*toolbar*/
	{
	background: #fafafa url( <%=request.getContextPath()%>/images/ajaxList/grid/bg.gif) repeat-x top;
	position: relative;
	border: 1px solid #ccc;
	border-top: 0px;
	overflow: hidden;
	display: none;
	}

	.flexigrid div.sDiv2
		{
		float: left;
		clear: both;
		padding: 5px;
		padding-left: 5px;
		width: 1024px;
		}

		.flexigrid div.sDiv2 input, .flexigrid div.sDiv2 select
		{
		vertical-align: middle;
		}
			
	
	
	

	.flexigrid div.fbutton div
		{
			float: left;
			padding: 1px 3px;
		}		
		
	.flexigrid div.fbutton span
		{
		float: left;
		display: block;
		padding: 3px;
		}

	.flexigrid div.fbutton:hover, .flexigrid div.fbutton.fbOver
		{
			padding: 0px;
			border: 1px solid #ccc;
		}

	.flexigrid div.fbutton:hover div, .flexigrid div.fbutton.fbOver div
		{
			padding: 0px 2px;
			border-left: 1px solid #fff;
			border-top: 1px solid #fff;
			border-right: 1px solid #eee;
			border-bottom: 1px solid #eee;
		}		
		
	
/* end toolbar*/
/*表头部分样式*/
.flexigrid div.hDiv
	{

	background-color:#b9def7;
	/*background: #fafafa url( images/fhbg.gif) repeat-x bottom;*/
	border: 1px solid #ccc;
	border-bottom: 0px;
	overflow: hidden;
	}	

.flexigrid div.hDiv table
	{
	border-right: 1px solid #fff;
	}

	.flexigrid div.cDrag
		{
		float: left;
		position: absolute;
		z-index: 2;
		overflow: visible;
		}

		.flexigrid div.cDrag div
			{
			float: left;
			background: none;
			display: block;
			position: absolute;
			height: 24px;
			width: 5px;
			cursor: col-resize;
			}
			
		.flexigrid div.cDrag div:hover, .flexigrid div.cDrag div.dragging
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/line.gif) repeat-y 2px center;
			}

.flexigrid div.iDiv
	{
		border: 1px solid #316ac5;
		position: absolute;
		overflow: visible;
		background: none;
	}
	
	.flexigrid div.iDiv input, .flexigrid div.iDiv select, .flexigrid div.iDiv textarea
		{
		font-family: Arial, Helvetica, sans-serif;
		font-size: 11px;
		}
		
	.flexigrid div.iDiv input.tb
		{
		border: 0px;
		padding: 0px;
		width: 100%;
		height: 100%;
		padding: 0px;
		background: none;
		}			
/*表体样式*/					
.flexigrid div.bDiv
	{
	border: 1px solid #ccc;
	border-top: 0px;
	background: #fff;
	overflow: auto;
	}
	
.flexigrid div.bDiv table
	{
	border-bottom: 1px solid #ccc;
	}
	
	.flexigrid div.hGrip
	{
	position: absolute;
	top: 0px;
	right: 0px;
	height: 5px;
	width: 5px;
	background: url( <%=request.getContextPath()%>/images/ajaxList/grid/line.gif) repeat-x center;
	margin-right: 1px;
	cursor: col-resize;
	}
	
		.flexigrid div.hGrip:hover, .flexigrid div.hGrip.hgOver
			{
				border-right: 1px solid #999;				
				margin-right: 0px;
			}
	
	.flexigrid div.vGrip
		{
		height: 5px;
		overflow: hidden;
		position: relative;
		background: #fafafa url( <%=request.getContextPath()%>/images/ajaxList/grid/wbg.gif) repeat-x 0px -1px;
		border: 1px solid #ccc;
		border-top: 0px;
		text-align: center;
		cursor: row-resize;
		}
			
			.flexigrid div.vGrip span
					{
					display: block;
					margin: 1px auto;
					width: 20px;
					height: 1px;
					overflow: hidden;
					border-top: 1px solid #aaa;
					border-bottom: 1px solid #aaa;	
					background: none;
					}

.flexigrid div.hDiv th, .flexigrid  div.bDiv td  /* common cell properties*/
	{
	text-align: left;
	border-right: 1px solid #ddd;
	border-left: 1px solid #fff;
	overflow: hidden;
	vertical-align: top !important;
	}

		.flexigrid div.hDiv th div, .flexigrid  div.bDiv td  div, div.colCopy div/* common inner cell properties*/
			{
			padding: 3px;
			border-left: 0px solid #fff;
			}

.flexigrid div.hDiv th, div.colCopy
	{
	font-weight: normal;
	height: 24px;
	cursor: default;
	white-space: nowrap;
	overflow: hidden;
	 border-bottom: 1px solid #698ec3;
	}	

div.colCopy {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	background: #fafafa url( <%=request.getContextPath()%>/images/ajaxList/grid/fhbg.gif) repeat-x bottom;
	border: 1px solid #ccc;
	border-bottom: 0px;
	overflow: hidden;
	}

.flexigrid div.hDiv th.sorted
	{
	background: url( <%=request.getContextPath()%>/images/ajaxList/grid/wbg.gif) repeat-x 0px -1px;
	border-bottom: 0px solid #ccc;
	}
	
	.flexigrid div.hDiv th.thOver
	{
	}

	.flexigrid div.hDiv th.thOver div, .flexigrid div.hDiv th.sorted.thOver div
	{
	border-bottom: 1px solid orange;
	padding-bottom: 3px;
	}
	
	.flexigrid div.hDiv th.sorted div
	{
	border-bottom: 0px solid #ccc;
	padding-bottom: 5px;
	}

	.flexigrid div.hDiv th.thMove
	{
	background: #fff;
	color: #fff;
	}
	
	.flexigrid div.hDiv th.sorted.thMove div
		{
		border-bottom: 1px solid #fff;
		padding-bottom: 3px
		}
	
	.flexigrid div.hDiv th.thMove div
	{
		background: #fff !important;
	}	
	
	.flexigrid div.hDiv th div.sdesc
		{
		background: url( <%=request.getContextPath()%>/images/ajaxList/grid/dn.png) no-repeat center top;
		}	

	.flexigrid div.hDiv th div.sasc
		{
		background: url( <%=request.getContextPath()%>/images/ajaxList/grid/up.png) no-repeat center top;
		}	
		
.flexigrid div.bDiv td
	{
	border-bottom: 1px solid #fff;
	background-color: #ffffff;
	vertical-align: top;
	white-space: nowrap;
	padding:0px;
	}

		.flexigrid div.hDiv th div
			{
	background-color: #b9def7;
	height:23px;
			}
			
			.flexigrid span.cdropleft
			{
			display: block;
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/prev.gif) no-repeat -4px center;
			width: 24px;
			height: 24px;
			position: relative;
			top: -24px;
			margin-bottom: -24px;
			z-index: 3;
			}

			.flexigrid div.hDiv span.cdropright
			{
			display: block;
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/next.gif) no-repeat 12px center;
			width: 24px;
			height: 24px;
			float: right;
			position: relative;
			top: -24px;
			margin-bottom: -24px;
			}


		.flexigrid div.bDiv td div
			{
			border-top: 0px solid #fff;
			padding-bottom: 1px;
			}
	
				
		.flexigrid tr td.sorted
				{
			
				border-right: 1px solid #ddd;
				border-bottom: 1px solid #f3f3f3;
				}		

				.flexigrid tr td.sorted div
					{
					}


		.flexigrid tr.erow td
				{
				background: #daeaf6;
				border-bottom: 1px solid #f7f7f7;
				}
				
		.flexigrid tr.erow td.sorted
				{
				
				border-bottom: 1px solid #e3e3e3;
				}						

				.flexigrid tr.erow td.sorted div
					{
					}

		/*.flexigrid div.bDiv tr:hover td, 此css与列固定有冲突
		.flexigrid div.bDiv tr:hover td.sorted,*/
		.flexigrid div.bDiv tr.trOver td.sorted, 
		.flexigrid div.bDiv tr.trOver td
			{
			background: #d9ebf5;
			border-left: 1px solid #eef8ff;
			border-bottom: 1px dotted #a8d8eb;
			}
		.fixupCol 
			{
			background: #d9ebf5;
			border-left: 1px solid #eef8ff;
			border-bottom: 1px dotted #a8d8eb;
			}			
		.flexigrid div.bDiv tr.trSelected:hover td, 
		.flexigrid div.bDiv tr.trSelected:hover td.sorted,
		.flexigrid div.bDiv tr.trOver.trSelected td.sorted, 
		.flexigrid div.bDiv tr.trOver.trSelected td,
		.flexigrid tr.trSelected td.sorted, 
		.flexigrid tr.trSelected td
			{
			background: #d5effc url( <%=request.getContextPath()%>/images/ajaxList/grid/hl.png) repeat-x top;
			border-right: 1px solid #d2e3ec;
			border-left: 1px solid #eef8ff;
			border-bottom: 1px solid #a8d8eb;
			}

	/* novstripe adjustments */

	.flexigrid.novstripe .bDiv table
	{
		border-bottom: 1px solid #ccc;
		border-right: 1px solid #ccc;
	}

	.flexigrid.novstripe  div.bDiv td  
		{
		border-right-color: #fff;
		}
		
	.flexigrid.novstripe div.bDiv tr.erow td.sorted
		{
		border-right-color: #e3e3e3;
		}

	.flexigrid.novstripe div.bDiv tr td.sorted
		{
		border-right-color: #f3f3f3;
		}

	.flexigrid.novstripe  div.bDiv tr.erow td  
		{
		border-right-color: #f7f7f7;
		border-left-color: #f7f7f7;
		}
		
		.flexigrid.novstripe div.bDiv tr.trSelected:hover td, 
		.flexigrid.novstripe div.bDiv tr.trSelected:hover td.sorted,
		.flexigrid.novstripe div.bDiv tr.trOver.trSelected td.sorted, 
		.flexigrid.novstripe div.bDiv tr.trOver.trSelected td,
		.flexigrid.novstripe tr.trSelected td.sorted, 
		.flexigrid.novstripe tr.trSelected td
			{
			border-right: 1px solid #0066FF;
			border-left: 1px solid #0066FF;
			}		

	.flexigrid.novstripe div.bDiv tr.trOver td, .flexigrid.novstripe div.bDiv tr:hover td
		{
		border-left-color: #d9ebf5;
		border-right-color: #d9ebf5;
		}

	/* end novstripe */

.flexigrid div.pDiv
	{
	background: url( <%=request.getContextPath()%>/images/ajaxList/grid/wbg.gif) repeat-x 0 -1px;
	border: 1px solid #ccc;
	border-top: 0px;
	overflow: hidden;
	white-space: nowrap;
	position: relative;
	}

.flexigrid div.pDiv div.pDiv2
	{
	margin: 3px;
	margin-left: -2px;
	float: left;
	width: 1024px;
	}	
	
	div.pGroup
		{
		float: left;
		background: none;
		height: 24px;
		margin: 0px 5px;
		}
	
	.flexigrid div.pDiv .pPageStat, .flexigrid div.pDiv .pcontrol
		{
		position: relative;

		top: 5px;
		overflow: visible;
		}
		
	.flexigrid div.pDiv input
		{
		vertical-align: text-top;
		position: relative;
		top: -5px;
		}
	
	.flexigrid div.pDiv  div.pButton
		{
		float: left;
		width: 22px;
		height: 22px;
		border: 0px;
		cursor: pointer;
		overflow: hidden;
		}

		.flexigrid div.pDiv  div.pButton:hover, .flexigrid div.pDiv  div.pButton.pBtnOver
			{
			width: 20px;
			height: 20px;
			border: 1px solid #ccc;
			cursor: pointer;
			}
		
	.flexigrid div.pDiv  div.pButton span
		{
		width: 20px;
		height: 20px;
		display: block;
		float: left;
		}		
	
		.flexigrid div.pDiv  div.pButton:hover span, .flexigrid div.pDiv  div.pButton.pBtnOver span
			{
			width: 19px;
			height: 19px;
			border-top: 1px solid #fff;
			border-left: 1px solid #fff;
			}		
		

		.flexigrid .pSearch
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/magnifier.png) no-repeat center;
			}
	
		.flexigrid .pFirst
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/first.gif) no-repeat center;
			}
			
		.flexigrid .pPrev
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/prev.gif) no-repeat center;
			}

		.flexigrid .pNext
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/next.gif) no-repeat center;
			}

		.flexigrid .pLast
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/last.gif) no-repeat center;
			}
			
		.flexigrid .pReload
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/load.png) no-repeat center;
			}
			
		.flexigrid .pReload.loading
			{
			background: url( <%=request.getContextPath()%>/images/ajaxList/grid/load.gif) no-repeat center;
			}		
			/*为单元格编辑新加的样式 */													
			.edit-cell {
				background-color: #FFDEAD;
			}
			.flexigrid tr td.dirty-cell{
				background: transparent url( <%=request.getContextPath()%>/images/ajaxList/grid/dirty.gif) no-repeat 0 0;	
			}
/* ie adjustments */
			
		.flexigrid.ie div.hDiv th div, .flexigrid.ie  div.bDiv td  div, div.colCopy.ie div/* common inner cell properties*/
			{
			overflow: hidden;
			}			
		td.listCssgdtitle {
			POSITION: relative; 
			LEFT: 0px; 
			top:0px; 
			WHITE-SPACE: nowrap; 
		}
		th.listCssgdtitle {
			POSITION: relative; 
			LEFT: 0px;
			top:0px; 
			WHITE-SPACE: nowrap; 
			z-index:1;
		}
		tr.listCssgdtitle {
			POSITION: relative; 
			LEFT: 0px;  
			top:0px; 
			WHITE-SPACE: nowrap; 
		}
		span.redDigit{
			color:red;
		}
		.pGroup input{
			border:1px;
			solid #90b3cf; 
			margin-right:4px;
			height:15px;
			text-align:center;
		}