<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>
<!--portlets的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.sortable.js"></script>

<style type="text/css">
	.column {width: 205px;float: left;padding-bottom: 100px;margin:10px;}
	.portlet{background-color: #ffe;border:#665555 solid 1px;cursor: move;margin: 0 0 10px;width: 200px;}
	.portlet-header {background-color: #94cbec;border:#665555 solid 1px;margin: 1px;padding-bottom: 4px;padding-left: 0.2em;}
	.portlet-content { padding: 0.4em; }
	.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
	.ui-sortable-placeholder * { visibility: hidden; }
</style>
<title>Portlets控件</title>
<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
            
		 jQuery(".column").sortable({
		    items: '.portlet',
		    connectWith: ['.column']
		});
		jQuery('.column').bind('sortstart', start); 
        jQuery('.column').bind('sortupdate', update);    
    });
        //此处是为了解决当发生交换时会两次触发update函数的bug，采用java中模板方法模式解决。(^-^)
function start(event,ui){
            if(!$(event.target).hasClass('shitSuccess'))
                $(event.target).addClass('shitSuccess');
        }
        function update(event,ui){
            if($(event.target).hasClass('shitSuccess'))
                updatePortlets(event,ui);
            $(event.target).removeClass('shitSuccess');
        }
    

    function updatePortlets(event,ui){
        var target = event.target;
        //if($(target).hasClass('portlet-header')){
            alert('head1！');
    //  }
    }
</script>


</head>
<body>
<script language="javascript">
	writeTableTop('Portlets控件','<venus:base/>/');
</script>
        <div id="container-1">
            <ul>
                <li><a href="#fragment-1"><span>示例演示</span></a></li>
                <li><a href="#fragment-2"><span>源码讲解</span></a></li>
            </ul>
            <div id="fragment-1" class="table_div_content">
				<div style=""width:700px;>
					<div class="column">
						<div class="portlet">
							<div class="portlet-header">Feeds</div>
							<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
						</div>
						<div class="portlet">
							<div class="portlet-header">News</div>
							<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
						</div>
					</div>
					<div class="column">
						<div class="portlet">
							<div class="portlet-header">Shopping</div>
							<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
						</div>
					</div>
					<div class="column">
						<div class="portlet">
							<div class="portlet-header">Links</div>
							<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
						</div>
						<div class="portlet">
							<div class="portlet-header">Images</div>
							<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
						</div>
					</div>
				</div>
            </div>
            <div id="fragment-2" class="table_div_content">
            	<div class="inner" style="padding:15px;border:1px solid #555;width:700px">
    				1.需要引入的js文件：<br>
					 /js/jquery/ui.sortable.js<br>
					 /js/jquery/ui.core.js<br>
					 <p>2.需要引入的css文件：<br>
					 	 此示例所用的css样式都在jsp文件中，需要注意的是：<br>
					 	 .ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }<br>
						.ui-sortable-placeholder * { visibility: hidden; }<br>
						两个样式是div拖拽时虚线框的样式。
					 </p>
					 <p>3.JavaScript脚本：<br>
					 	在jquer的ready方法中加入：
					 	<pre>
 $(".column").sortable({
	items: '.portlet',
	connectWith: ['.column'],
	success:updatePortlets	
});
function updatePortlets(event,ui){
		var target = event.target;
		if($(target).hasClass('portlet-header')){
			alert('head！');
		}
	}
					 	</pre>
					 	&nbsp;&nbsp;&nbsp;&nbsp;sortable()方法接收一个对象作为参数，对象中设置初始化参数，上面列出的3个初始化参数是最常用的，items表示需要加上拖拽功能的dom元素，其值一般是个css选择器(关于更多请参看jQuery帮助文档)，例中的‘.portlet’表示所有class为‘portlet’的元素；connectWith表示要与之关联的节点，如果被关联的节点中也有可拖拽的portlets，那么他们可以互换位置。success则是指定一个事件处理函数，当两个portlets成功交换时会触发，可用于后台交互。
					 </p>
    			</div>
            </div>


        </div>


<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>