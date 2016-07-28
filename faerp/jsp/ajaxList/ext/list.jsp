<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<html>
	<title>Ext表格控件</title>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
	<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
	<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>
	<script type="text/javascript" src="../../../js/ext/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="../../../js/ext/js/ext-all.js"></script>
    <script type="text/javascript" src="../../../js/ext/js/dwrproxy.js"></script>
	<script type="text/javascript" src="../../../js/ajax/ext/list.js"></script>
    <script type="text/javascript" src="../../../js/ajax/ext/demo2.js"></script>
    <i18n:javascript src="/js/ext/js/ext-lang.js"/>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/GridSampleAction.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
	<link rel="stylesheet" type="text/css" href="../../../js/ext/resources/css/ext-all.css"/>
	<style>
		.add {
		    background-image:url(<%=request.getContextPath()%>/images/icon/add.gif) !important;
		}
		.view {
		    background-image:url(<%=request.getContextPath()%>/images/icon/view.gif) !important;
		}
		.delete {
		    background-image:url(<%=request.getContextPath()%>/images/icon/delete.gif) !important;
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
</head>
<body >
<script language="javascript">
	writeTableTop('Ext表格控件示例','<venus:base/>/');
	var webdir = "<venus:base/>/";
	jQuery(function(){
		jQuery('#container-1 > ul').tabs();
		jQuery('#fragment-1 > ul').tabs();
		jQuery('#fragment-2 > ul').tabs();
	})
	
</script>
<div id="container-1">
        <ul>
            <li><a href="#fragment-1"><span>示例一</span></a></li>
            <li><a href="#fragment-2"><span>示例二</span></a></li>
        </ul>
        <div id="fragment-1">
            <ul>
                <li><a href="#fragment-11"><span>效果图</span></a></li>
                <li><a href="#fragment-12"><span>源码讲解</span></a></li>
            </ul>
            <div id="fragment-11">
                <div>此示例是此采用DWR方式实现的Ext Table控件。支持排序、分页、调整列宽、列隐藏、列拖拽。</div><br>
                <div id="div_list"></div>
            </div>
            <div id="fragment-12" >
                <div class="inner" style="padding:15px;border:1px solid #555;">
                     1.需要引入的js文件：<br>
                     /js/ext/adapter/ext/ext-base.js<br>
                     /js/ext/adapter/ext/ext-all.js<br>
                    &lt;i18n:javascript src="/js/ext/js/ext-lang.js"/&gt;<br>
                     /js/ext/adapter/ext/dwrproxy.js<br>
                     /js/ext/adapter/ext/list.js<br>
                     <%=request.getContextPath()%>/dwrsample/interface/GridSampleAction.js<br>
                     <%=request.getContextPath()%>/dwr/engine.js<br>
                     <%=request.getContextPath()%>/dwr/util.js<br>
                     <p>为了让ext支持国际化,需要在jsp内写入&lt;i18n:javascript src="/js/ext/js/ext-lang.js"/&gt;</p>
            <br>    
                     <p>2.需要引入的css文件：<br>
                     /js/ext/resources/css/ext-all.css<br></p><br>
                     <p>3.HTML代码：<br>
                            &lt;div id="div_list"&gt;&lt;/div&gt;<br>
                            只需要一个空DIV。
                     </p><br>
                     <p>4.JavaScript脚本：<br>
                     参考引入的list.js文件内容。<pre>
示例使用了Ext的页面展现技术与DWR结合实现数据的访问（Ext.data.DWRProxy(GridSampleAction.findUsersAjax, true)），然后通过Ext.grid.GridPanel类和其他对象配合展现出来的。<pre>
详细内容请参考Ext相关手册。<br>
            <p>5.服务器端代码<br>
表格ajax请求对应的Java方法为findUsersAjax()(GridSampleAction.java)，此方法返回一个ListRange对象，包含数据的总记录数和表格显示的数据。
            <pre>
        public ListRange findUsersAjax(HttpServletRequest request,OrderVo para, boolean flag, String condition, int start,int count, String orderBy){
            condition = null;
            int countValue = getBS().queryUsersCount(condition);
            List users = getBS().query(null,((start + count) / count),count,orderBy);
            if(users == null)users = new ArrayList();
            ListRange rtn = new ListRange();
            rtn.setData(users.toArray());
            rtn.setTotalSize(countValue);
            return rtn;
        }<br>
其中request为默认参数，para，flag，condition在list.js里设置：
        moduleStore.on('beforeload',function(obj,arg){
            var condition = '';     
            var obj = new Object();
            var argParas = new Array();
            argParas.push(obj);
            argParas.push(true);
            argParas.push(condition);
            Ext.apply(
                arg,
                {
                arg:argParas
            });
        }); 
start,count,orderBy由Ext组件自动赋值，用来进行排序。
            </pre>
            
            </p>
                </div>
        </div>
        </div>
        <div id="fragment-2">
            <ul>
                <li><a href="#fragment-21"><span>效果图</span></a></li>
                <li><a href="#fragment-22"><span>源码讲解</span></a></li>
            </ul>
            <div id="fragment-21">
                <div>此示例是与Struts Action交互实现的Ext Table控件。支持排序、分页、调整列宽、列隐藏、列拖拽。</div><br>
                <div id="ext_demo2"></div>
            </div>
            <div id="fragment-22">
            <div class="inner" style="padding:15px;border:1px solid #555;">
                     1.需要引入的js文件：<br>
                     /js/ext/adapter/ext/ext-base.js<br>
                     /js/ext/adapter/ext/ext-all.js<br>
                     /js/ext/adapter/ext/demo2js<br>
            <br>    
                     <p>2.需要引入的css文件：<br>
                     /js/ext/resources/css/ext-all.css<br></p><br>
                     <p>3.HTML代码：<br>
                            &lt;div id="ext_demo2"&gt;&lt;/div&gt;<br>
                            只需要一个空DIV。
                     </p><br>
                     <p>4.JavaScript脚本：<br>
                     参考引入的demo2.js文件内容。<pre>
示例使用了Ext的页面展现技术直接与action交互，然后通过Ext.grid.GridPanel类和其他对象配合展现出来的。<pre>
详细内容请参考Ext相关手册。<br>
            <p>5.服务器端代码<br>
表格ajax请求对应的Java方法为queryAll4Demo2()(GridSampleAction.java)，此方法返回一个xml文件，包含当前页的记录和总记录数。
            <pre>
     public IForward queryAll4Demo2(DefaultForm formBean, IRequest request,IResponse response) {
        int countValue = getBS().queryUsersCount(null);//获得记录数，此方法可以接受页面提交的参数。
        int startSize = Integer.valueOf(request.getParameter("start"));//起始记录数,此参数由ext提交。
        int sizePerPage =  Integer.valueOf(request.getParameter("limit"));//获取记录条数，此参数由ext提交，等于pageSize(每页显示记录数)。
        int currentPage = startSize/sizePerPage;
        System.out.println("currentPage:"+currentPage+"---sizePerPage:"+sizePerPage);
        if(currentPage<1)
            currentPage = 1;
        //获取记录
        List users = getBS().query(null,currentPage,sizePerPage,null);
        request.setAttribute("users",users);
        request.setAttribute("recordsCount", countValue);//将总记录数写到xml文件中，提供给ext，ext根据此参数和已知的每页显示条数生成分页信息。
        return request.findForward("demo2Xml");//跳转到jsp文件，jsp最后转译得到的结果是一个xml文件返回的客户端。
    }<br>
            </pre>
            
            </p>
                </div>
            </div>
        </div>
    </div>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>	
</body>

</html>