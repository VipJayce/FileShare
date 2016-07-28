<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Command Generator Tool</title>
<link rel='stylesheet' type='text/css' href='<venus:base/>/css/cmdgenerator.css' />
<link rel='stylesheet' type='text/css' href='<venus:base/>/css/jquery/accordion/menu.css' />
<script type='text/javascript' src='<venus:base/>/js/au/jquery/jquery.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/ui/jquery-ui-1.8.10.min.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/json/jquery.json-2.2.min.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/diagram/raphael-min.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/diagram/cmdgenerator.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/accordion/menu.js'></script>
<!-- deleteme begin -->
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrmodel/interface/menuModelEcho.js'></script>  
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrmodel/engine.js'></script> 
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrmodel/util.js'></script>
<!-- deleteme end -->
<script>
    
    function combineCommand(position,cmdid,cmdname,anologs){
        eval('el.deepClone('+position.x+','+position.y+',"'+cmdid+'","'+cmdname+'","'+anologs+'")');
    }
    
    function echoCommand(cmdid,cmdname,anologs){
        var anolog = anologs.split(',');
        var jsonObj = {};
        var now = new Date();
        var dateData = now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
        for(var a in anolog){
            jsonObj[anolog[a]] = dateData;            
        }
        menuModelEcho.echoBsHandle(cmdid,cmdname,jQuery.toJSON(jsonObj),function(data){
            jQuery("#echo").text(data);
            //jQuery("#echopara").text(anologs);
        });
    }
    
	function operateJSON(p){
	   var a = '<ul id="menu">';
	    for(var i in p){
	      a+='<li><a href="#">' + i  + '</a><ul>';
	      for(var j in p[i]){
		      a+='<li><a href="javascript:echoCommand(\''+i+'\',\''+j+'\',\''+p[i][j]+'\')">' + j +'</a></li>';
		  }
		  a+='</ul></li>';
	    }
	    a+='</ul>';
	    return a;
	}
    DWREngine.setErrorHandler(function(msg){
            alert(msg);
    }); 
    menuModelEcho.commandHandle(function(data){
            //jQuery("#debug").text(operateJSON(jQuery.parseJSON(data)));
            jQuery("#command").html(operateJSON(jQuery.parseJSON(data)));
            initMenu();            
    });
    
</script>
<!-- deleteme end -->
</head>
<body>
<div id="toolbar"></div>
<div id="command"></div>
<div id="echo"></div>
<div id="echopara"></div>
<div id="topMost">&nbsp;</div>
<div id="bottomMost">&nbsp;</div>
<div id="debug"></div>
</body>
</html>