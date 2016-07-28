<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<title><fmt:message key='gap.authority.i18nconvert' bundle='${applicationAuResources}' /></title>
<style type="text/css">
            .fileSystem {
                width: 400px;
                height: 600px;
                border-top: solid 1px #BBB;
                border-left: solid 1px #BBB;
                border-bottom: solid 1px #FFF;
                border-right: solid 1px #FFF;
                background: #FFF;
                overflow: scroll;
                padding: 5px;
            }            
</style>
<link href="<venus:base/>/js/au/jquery/filepicker/jqueryFileTree.css" rel="stylesheet" type="text/css" media="screen" />
<script type='text/javascript' src='<venus:base/>/js/au/jquery/jquery.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/effect/jquery.easing.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/filepicker/jqueryFileTree.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/i18nconvert/interface/i18nConvertor.js'></script>  
<script type='text/javascript' src='<%=request.getContextPath()%>/i18nconvert/engine.js'></script> 
<script type='text/javascript' src='<%=request.getContextPath()%>/i18nconvert/util.js'></script>

<script type="text/javascript">
	jQuery(document).ready( function() {
	   i18nConvertor.isRunning(function(isRunning) {
	       if(isRunning){
	           progressUI();
	       }else{
	           jQuery('#projectPicker').fileTree({ root: 'E:/support', script: '<venus:base/>/jsp/authority/i18n/filefeed.jsp', folderEvent: 'click', expandSpeed: 750, collapseSpeed: 750, multiFolder: false, expandEasing: 'easeOutBounce', collapseEasing: 'easeOutBounce', loadMessage: 'Un momento...' }, function(file,isDir) { 
	                        if(!isDir){
	                           alert(file+"<fmt:message key='gap.authority.notdirection' bundle='${applicationAuResources}' />");
	                           jQuery('#chooseDirection').html('');
	                         }else
	                           jQuery('#chooseDirection').html(file);
	                    });
	        }
       });
	});
	
	function progressUI(){
	   jQuery('#chooseProject').hide();
       jQuery('#operateButton').hide();
	   if (!window.WebSocket) {
            alert("<fmt:message key='gap.authority.notsupportwebsocket' bundle='${applicationAuResources}' />");
            return false;
       }
       var ws = new WebSocket("ws://localhost:6789");
       if(!ws)
            return false;
       ws.onmessage = function(evt) {
           var answer = evt.data;
           var phase = answer.substring(0,answer.indexOf(":"));
           answer = answer.substring(answer.indexOf(":")+1);      
           if("MainPhase"==phase)
               jQuery("#mainProgressDisplay").html(answer);
           else if("SubPhase"==phase)
               jQuery("#subProgressDisplay").html(answer);
	   };
	
	   ws.onclose = function() {
	   };
	
	   ws.onopen = function() {
	   }; 
	   return true;
	}
	
	DWREngine.setErrorHandler(function(msg){
            alert(i18n.error_message+msg);
    }); 
    
    function convert(){
	   if(confirm("<fmt:message key='gap.authority.convertproject' bundle='${applicationAuResources}' />"+jQuery('#chooseDirection').html())){
	       i18nConvertor.convert(jQuery('#chooseDirection').html());
	       progressUI();
	   }
	}
</script>
</head>
<body>
<div id="chooseProject"><fmt:message key='gap.authority.canonlyusedir' bundle='${applicationAuResources}' />(E:/support)<br/><div id="projectPicker" class="fileSystem"></div> </div>
<div id="chooseDirection"></div>
<div id="operateButton"><input type="button" onclick="javascript:convert();" value="<fmt:message key='gap.authority.i18nconvert' bundle='${applicationAuResources}' />"></div>
<div id="mainProgressDisplay"></div>
<div id="subProgressDisplay"></div>
</body>
</html>