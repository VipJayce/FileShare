<link rel="stylesheet" type="text/css" href="<venus:base/>/css/dd/gap-ext-css.jsp"/>
<link rel="stylesheet" type="text/css" href="<venus:base/>/js/ext/resources/css/ext-all.css"/>
<script type="text/javascript" src="<venus:base/>/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="<venus:base/>/js/ext/js/ext-all.js"></script>
<script type="text/javascript" src="<venus:base/>/js/ext/js/dwrproxy.js"></script>
<style>
	.add {
	    background-image:url(<%=request.getContextPath()%>/images/icon/add.gif) !important;
	}
	.modify {
	    background-image:url(<%=request.getContextPath()%>/images/icon/modify.gif) !important;
	}
	.view {
	    background-image:url(<%=request.getContextPath()%>/images/icon/view.gif) !important;
	}
	.delete {
	    background-image:url(<%=request.getContextPath()%>/images/icon/delete.gif) !important;
	}
	.layout {
	    background-image:url(<%=request.getContextPath()%>/images/dd/layout.gif) !important;
	}
		/*显示竖线*/
    .x-grid3-cell-inner{
        border-right: 1px solid #eceff6;
    }
    /*与表头对齐*/
    .x-grid3-row td, .x-grid3-summary-row td{
        padding-right: 0px;
    }
    /*去掉行间空白*/
    .x-grid3-row {
        border-top-width: 0px;

    }
</style>
