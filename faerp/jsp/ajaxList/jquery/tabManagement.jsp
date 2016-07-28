<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 

<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>

<title>提示框</title>
<script type="text/javascript">
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
        
        jQuery('#container11>ul').tabs( {selected: 1} );//tab控件初始化时，自定义显示tab
        jQuery('#container11_2 #a1').click(function(){ jQuery('#container11>ul').tabs('disable', 2); });
        jQuery('#container11_2 #a2').click(function(){ jQuery('#container11>ul').tabs('enable', 2); });
        jQuery('#container11_2 #a3').click(function(){ jQuery('#container11>ul').tabs('select', 2); });
        jQuery('#container11_2 #a4').click(function(){ alert( jQuery('#container11 > ul').tabs().data('selected.tabs') ) });
        
        if ((navigator.userAgent.indexOf('MSIE') >= 0) && (navigator.userAgent.indexOf('Opera') < 0)){//IE浏览器运行下面代码
                jQuery('#container11_2 #a5').click(function(){ jQuery('#container11 > ul').tabs('add', 'test.jsp?name=<%=java.net.URLEncoder.encode("插入测试","UTF-8")%>', '插入测试', 1); });
                jQuery('#container11_2 #a6').click(function(){ jQuery('#container11 > ul').tabs('add', 'test.jsp?name=<%=java.net.URLEncoder.encode("增加测试","UTF-8") %>', '增加测试'); });
        }else{//FireFox、Chrome浏览器运行下面代码
                jQuery('#container11_2 #a5').click(function(){ jQuery('#container11 > ul').tabs('add', 'test.jsp?name=插入测试', '插入测试', 1); });
                jQuery('#container11_2 #a6').click(function(){ jQuery('#container11 > ul').tabs('add', 'test.jsp?name=增加测试', '增加测试'); });
        }

        jQuery('#container11_2 #a7').click(function(){ jQuery('#container11 > ul').tabs('remove', 3); });
        jQuery('#container11_3 #a8').click(function(){ alert( jQuery('#container11 > ul').tabs().data('selected.tabs') ) });

    });

</script>


</head>
<body>
<script language="javascript">
    writeTableTop('提示框','<venus:base/>/');
</script>
        <div id="container-1">
            <ul>
                <li><a href="#fragment-1"><span>示例演示</span></a></li>
                <li><a href="#fragment-2"><span>源码讲解</span></a></li>
            </ul>
            <div id="fragment-1" class="table_div_content">
                <div id="container11" class="table_div_content">
                    <ul>
                        <li><a href="#container11_1"><span>测试一</span></a></li>
                        <li><a href="#container11_2"><span>测试二测试二</span></a></li>
                        <li><a href="#container11_3"><span>测试三</span></a></li>
                        <li><a href="#container11_4"><span>测试四</span></a></li>
                    </ul>
                    <div id="container11_1">
                        测试二
                    </div>
                    <div id="container11_2">                        
                        测试二<br />
                        <a id="a1" href="#this">禁用第三个tab</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a id="a2" href="#this">启用第三个tab</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                        <a id="a3" href="#this">选择（切换到）第三个tab</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a id="a4" href="#this">得到选择的tab</a>
                        &nbsp;&nbsp;|&nbsp;&nbsp;<a id="a5" href="#this">插入tab</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a id="a6" href="#this">在后面增加tab</a>
                        &nbsp;&nbsp;|&nbsp;&nbsp;<a id="a7" href="#this">删除第四个tab</a></div>
                    <div id="container11_3">测试三&nbsp;&nbsp;|&nbsp;&nbsp;<a id="a8" href="#this">得到选择的tab</a></div>
                    <div id="container11_4">测试四</div>
                </div>

             </div>
            <div id="fragment-2" class="table_div_content">
                <table class="table_div_content">
                    <tbody>
                        <tr>
                            <td style="font-size:12px">
                                <p >1.需要引入的js文件:<br>
                                /js/jquery/ui.core.js<br>
                                /js/jquery/ui.tabs.js<br>
                                </p>
                                <p>2.需要填写的HTML语句样例<br>
                                &lt;div id="container11" class="table_div_content"&gt;<br>
                                &nbsp;&nbsp;&lt;ul&gt;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;&lt;a href="#container11_1"&gt;&lt;span&gt;测试一&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;&lt;a href="#container11_2"&gt;&lt;span&gt;测试二测试二&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;&lt;a href="#container11_3"&gt;&lt;span&gt;测试三&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;&lt;a href="#container11_4"&gt;&lt;span&gt;测试四&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;<br>
                                &nbsp;&nbsp;&lt;/ul&gt;<br>
                                &nbsp;&nbsp;&lt;div id="container11_1"&gt;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;测试一&lt;br /&gt;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&lt;a id="a1" href="#this"&gt;禁用第三个tab&lt;/a&gt;&nbsp;&nbsp;|&nbsp;&nbsp;&lt;a id="a2" href="#this"&gt;启用第三个tab&lt;/a&gt;&nbsp;&nbsp;|&nbsp;&nbsp;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&lt;a id="a3" href="#this"&gt;选择（切换到）第三个tab&lt;/a&gt;&nbsp;&nbsp;|&nbsp;&nbsp;&lt;a id="a4" href="#this"&gt;得到选择的tab&lt;/a&gt;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&lt;a id="a5" href="#this"&gt;插入tab&lt;/a&gt;&nbsp;&nbsp;|&nbsp;&nbsp;&lt;a id="a6" href="#this"&gt;在后面增加tab&lt;/a&gt;<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&lt;a id="a7" href="#this"&gt;删除第三个tab&lt;/a&gt;<br>
                                &nbsp;&nbsp;&lt;/div&gt;<br>
                                &nbsp;&nbsp;&lt;div id="container11_2"&gt;测试二测试二&lt;/div&gt;<br>
                                &nbsp;&nbsp;&lt;div id="container11_3"&gt;测试三&nbsp;&nbsp;|&nbsp;&nbsp;&lt;a id="a8" href="#this"&gt;得到选择的tab&lt;/a&gt;&lt;/div&gt;<br>
                                &nbsp;&nbsp;&lt;div id="container11_4"&gt;测试四&lt;/div&gt;<br>
                                &lt;/div&gt;<br>
                                </p>
                                <p >3.需要填写的js方法:<br>
                                jQuery(function() {<br>
                                &nbsp;&nbsp;jQuery('#container11>ul').tabs( {selected: 1, fx: { opacity: 'toggle' , height: 'toggle'  } } );//tab控件初始化时，自定义显示tab<br>
                                &nbsp;&nbsp;jQuery('#container11_1 #a1').click(function(){ jQuery('#container11>ul').tabs('disable', 2); });<br>
                                &nbsp;&nbsp;jQuery('#container11_1 #a2').click(function(){ jQuery('#container11>ul').tabs('enable', 2); });<br>
                                &nbsp;&nbsp;jQuery('#container11_1 #a3').click(function(){ jQuery('#container11>ul').tabs('select', 2); });<br>
                                &nbsp;&nbsp;jQuery('#container11_1 #a4').click(function(){ alert( jQuery('#container11 > ul').tabs().data('selected.tabs') ) });<br>
                                &nbsp;&nbsp;jQuery('#container11_1 #a5').click(function(){ jQuery('#container11 > ul').tabs('add', 'test.jsp?name=插入测试', '插入测试', 1); });<br>
                                &nbsp;&nbsp;jQuery('#container11_1 #a6').click(function(){ jQuery('#container11 > ul').tabs('add', 'test.jsp?name=增加测试', '增加测试'); });<br>
                                &nbsp;&nbsp;jQuery('#container11_1 #a7').click(function(){ jQuery('#container11 > ul').tabs('remove', 2); });<br>
                                &nbsp;&nbsp;jQuery('#container11_3 #a8').click(function(){ alert( jQuery('#container11 > ul').tabs().data('selected.tabs') ) });<br>
                                });<br>
                                <font color="red">
                                语句解释：<br>
                                1.jQuery('#container11>ul').tabs( {selected: 1, fx: { opacity: 'toggle' , height: 'toggle'  } } ):定义一个tab控件，该控件初始化的时候显示第二个tab的内容，tab之间切换具有动画效果。<br>
                                    &nbsp;&nbsp;container11:是显示tab控件的层的id。<br>
                                    &nbsp;&nbsp;selected:页面初始化时显示哪个tab。<br>
                                    &nbsp;&nbsp;fx: { opacity: 'toggle' , height: 'toggle'  }:该语句声明tab之间切换具有动画效果,注意多次快速切换的时候会出现Tab内容显示不完整的Bug，建议去除。<br>
                                2.jQuery('#container11_1 #a1').click(function(){ jQuery('#container11>ul').tabs('disable', 2); }):当id为"a1"的控件响应click事件时调用，禁用第三个tab控件。<br>
                                    &nbsp;&nbsp#container11_1 #a1:container11_1是div的id,a1为该div中的控件的id。<br>
                                3.jQuery('#container11>ul').tabs('disable', 2):禁用第三个tab控件。<br>
                                4.jQuery('#container11>ul').tabs('enable', 2):解禁第三个tab控件。<br>
                                5.jQuery('#container11>ul').tabs('select', 2):显示第三个tab控件。<br>
                                6.jQuery('#container11 > ul').tabs().data('selected.tabs'):获取当前tab控件的位置数，位置数从0开始。<br>
                                7.jQuery('#container11 > ul').tabs('add', 'test.jsp?name=maxiao', '插入测试', 1):在第二个tab前面增加一个tab控件。参数1表示要插入tab的序号<br>
                                8.jQuery('#container11 > ul').tabs('add', 'test.jsp?name=增加测试', '增加测试'):在最后增加一个tab控件。<br>
                                9.jQuery('#container11 > ul').tabs('remove', 2):删除第三个tab控件。<br>
                                </font>
                                </p>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
</html>