<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.ajax.util.GridUtil,gap.ajax.jquery.table.util.Constant"%>
<%@ include file="/jsp/include/global.jsp" %>
<!--jquery的js文件-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>
<script language="javascript" src="<venus:base/>/js/ajax/grid/jquery-grid.js"></script>
<script language="javascript" src="<venus:base/>/js/ajax/grid/grid.celledit.js"></script>
<script language="javascript" src="<venus:base/>/js/ajax/grid/grid.common.js"></script>
<script language="javascript" src="<venus:base/>/js/ajax/grid/json2.js"></script>
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/grid/jquery-grid.css.jsp" type="text/css">
<title>表格示例</title>
<script type="text/javascript">
	$(document).ready(function(e){ 
		$('#container-1 > ul').tabs();
		//示例一
 		g = jQuery("#demo1").flexigrid({
		    url:'<venus:base/>/grid.do?cmd=queryAll',
		    datatype:'xml',
		    colModel :[ 
		      {display:"<input type='checkbox'onclick='javascript:g.toggleSelectAll(this)'>",name:'checkbox', width:40,align:'center'},
		      {display:'序',name:'gridIndex', width:40,align:'center'}, 
		      {display:'姓名(可修改)',name:'name', width:100,sortable : true,editable:true,align:'center'}, 
		      {display:'性别',name:'sex',  width:100,sortable : true,align:'center'}, 
		      {display:'城市(可修改)',name:'city',  width:200,sortable : true ,editable:true,edittype:'select',editoptions:{ value:'<%=GridUtil.getOptions(Constant.CITY)%>'},align:'center'}, 
		      {display:'证件类型',name:'cardType', width:100,sortable : true, align:'center'}, 
		      {display:'证件号',name:'cardNo', width:100,sortable : true, align:'center'}, 
		      {display:'备注',name:'note',  width:100, sortable:false} ],
		    buttons : [
				{name:'提 交',imgsrc:'<venus:base/>/images/icon/save.gif',onpress : test},
				{name:'删 除',imgsrc:'<venus:base/>/images/icon/delete.gif',onpress : test},
				{name:'增 加',imgsrc:'<venus:base/>/images/icon/add.gif',onpress : test}
				],
		   	width:780, 
		   	height:330,
		    cellurl:'<venus:base/>/grid.do?cmd=update',
			title: '用户信息',
			sortname: "id",
			sortorder: "asc",
			 //rp: 20,
			//singleSelect:true,
			batchSubmit:true
		});
	});
	function test(com,grid)
			{
				
				if (com=='增 加'){
						alert('示例代码1！');
				}else if (com=='删 除'){
					if(confirm('Delete ' + $('tr[isSelect]',grid).length + ' items?')){
						var ids = g.getSelectedRow();
						$.post('<venus:base/>/grid.do?cmd=delete',{ids:ids},function(){alert('此代码为前台示例代码，没有写后台实际删除功能');g.flexReload();});
					}
				}else{
					g.batchSubmit();
				}			
			}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('Table控件示例','<venus:base/>/');
</script>
        <div id="container-1">
            <ul>
            <%-- --%>
<!-- -->
                <li><a href="#fragment-11"><span>示例一</span></a></li>
                <li><a href="#fragment-12"><span>源码讲解</span></a></li>
            </ul>
            <div id="fragment-11" class="table_div_content">
            	<div>此示例是对Table控件的综合应用，支持排序、分页、调整列宽、列隐藏、表格编辑、列拖拽和ajax方式访问。</div><br>
				<table id="demo1" style="display:none"></table>
				
            </div>
            <div id="fragment-12" >
				<div class="inner" style="padding:15px;border:1px solid #555;">
					 1.需要引入的js文件：<br>
					 /js/ajax/grid/jquery-grid.js<br>
					 /js/ajax/grid/grid.celledit.js<br>
					/js/ajax/grid/grid.common.js<br>
					/js/ajax/grid/json2.js<br>
					 <p>2.需要引入的css文件：<br>
					 /css/ajax/jquery/grid/jquery-grid.css.jsp<br></p>
					 <p>3.HTML代码：<br>
					 		&lt;table id="demo1" style="display:none" &gt;&lt;/table&gt;<br>
							只需要一个空表格， 初始设置为不显示。
					 </p>
					 <p>4.JavaScript脚本：<br>
					 在jsp中加入如下代码：<pre>
&lt;script type="text/javascript"&gt; 
	$(document).ready(function(){ 
	g = jQuery("#demo1").flexigrid({
		    url:'&lt;venus:base/&gt;/grid.do?cmd=queryAll',
		    datatype:'xml',
		    colModel :[ 
		      {display:'序',name:'gridIndex', width:40,align:'center'}, 
		      {display:'姓名(可修改)',name:'name', width:100,sortable : true,editable:true,align:'center'}, 
		      {display:'性别',name:'sex',  width:100,sortable : true,align:'center'}, 
		      {display:'城市(可修改)',name:'city',  width:500,sortable : true ,editable:true,edittype:'select',editoptions:{ value:'&lt;%=GridUtil.getOptions(Constant.CITY)%&gt;'},align:'center'}, 
		      {display:'证件类型',name:'cardType', width:100,sortable : true, align:'center'}, 
		      {display:'证件号',name:'cardNo', width:150,sortable : true, align:'center'}, 
		      {display:'备注',name:'note',  width:150, sortable:false} ],
		    buttons : [
				{name: '提 交 ',  imgsrc:'<venus:base/>/images/icon/save.gif',onpress : test},
				{name: '删 除 ', imgsrc:'<venus:base/>/images/icon/delete.gif',onpress : test},
				{name: '增 加 ',  imgsrc:'<venus:base/>/images/icon/add.gif',onpress : test}
				],
		   	width:830,
		   	height:275,
		    cellurl:'&lt;venus:base/&gt;/grid.do?cmd=update',
			title: '用户信息',
			sortname: "id",
			sortorder: "asc", 
			fixupAble:true,
			batchSubmit:true
		});
	function test(com,grid)
	{
		if (com=='删 除 ')
			{
				if(confirm('Delete ' + $('tr[isSelect]',grid).length + ' items?')){
				var ids = g.getSelectedRow();
				$.post('<venus:base/>/grid.do?cmd=delete',{ids:ids},function(){alert('此代码为前台示例代码，没有写后台实际删除功能');g.flexReload();});
				
				}
			} 
		else if (com=='增 加 ')
			{
				alert('示例代码！');
			}
		else{
			g.batchSubmit();
			}			
	}
	}); 
	
&lt;/script&gt;</pre>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flexigrid()函数接收一个JSON格式的对象参数，对象中可以有许多预定义的参数，上面列出的是示例中需要用到的参数，也是常用的。<br>url是表格的请求路径，该请求路径必须返回一个预定义格式的xml文件或json串(此处为xml)，grid通过解析xml文件获得
数据并填充表格；<br>colModel是一个数组，数组中每个元素定义表格对应列的详细信息，display指显示表头内容，name用于后台交互，width定义每列的宽度，<br>
sortable指定该列是否支持排序。editable、edittype和editoptions组合在一起定义单元格编辑信息。editable设置此列是否可编辑，默认为false，<br>
edittype定义编辑方式，可以是text，select，checkbox和textarea，默认为text，editoptions可以用来给select设置初始值等。<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	buttons定义了一组交互按钮，buttons中，name是按钮显示的名字，imgsrc是按钮所用到的图标，onpress是单击事件的函数。<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	cellurl是单元格编辑时候的提交路径。单元格编辑分两种方式：实时编辑和批量编辑。实时编辑是指单元格失去焦点<br>
或按下回车键时立即把请求提交服务器；批量编辑是指用户对表格内容的修改不会立即提交到服务器上，而由用户手动提交，一次提交会<br>
提交所有被修改的内容。仅当batchSubmit设置为true时才支持批量编辑。<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>注意：	sortname和sortorder必须设置，sortname设置初始的排序字段，sortorder则设置排序方式。<br>
	更过关于参数的信息请查看  Ajax控件使用手册
	</font>

					 </p>
			<p>5.服务器端代码<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;表格ajax请求路径对应的action方法为queryAll()(GridSampleAction.java)，此方法与其他列表控件的demo相似，它会返回一个xml文件(见grid_xml.jsp)，xml文件的格式为：
			<pre>
		&lt;rows&gt;
  			&lt;page&gt;&lt;/page&gt;
  			&lt;total&gt; &lt;/total&gt;
		    &lt;row id =''&gt; 
		      &lt;cell&gt;&lt;/cell&gt;
		      &lt;cell&gt;&lt;/cell&gt;
		      &lt;cell&gt;&lt;/cell&gt;
		      &lt;cell&gt;&lt;/cell&gt;
		      &lt;cell&gt;&lt;/cell&gt;
		      &lt;cell&gt;&lt;/cell&gt;
		      &lt;cell&gt;&lt;/cell&gt;
		    &lt;/row&gt;
			&lt;row&gt;...
		&lt;/rows&gt;<br>
其中row节点代表一条记录，多条记录则有多个row节点，row节点有个id属性，此属性对应表格中每个tr的id属性，可用于后台交互(增、删、改、查等)。<br>
下面是更新的代码。更新是指允许单元格编辑时在表格内直接更新数据，更新请求路径由cellurl参数指定。<br>
		String changeValues = request.getParameter(JqGridUtil.BACTH_UPDATE_PARAMETER);
		//通过changes参数判断更新方式，如为空，则不是批量更新。
		if(changeValues==null||StringUtils.isEmpty(changeValues)){//立即更新
			UserInfo user = new UserInfo();
			//通过GridUtil.getParameterMap(request)获得转码后的请求参数map，为的是防止乱码
			Helper.copyProperties(GridUtil.getParameterMap(request),user);
			getBS().update(user);
			return null;
		}
		//批量更新
		List users = GridUtil.getListFromRequest(null,UserInfo.class,request);//从request中获得待更新的对象集合，
		getBS().updateUsers(users);
		return null;
GridUtil.BACTH_UPDATE_PARAMETER的值为"changes"，与js库中ajax提交时候的字段对应，所以注意不要用changes作为colModel中的name属性。
			
			</pre>
		 	
		 	</p>
	            </div>
            </div>
        </div>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>