<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>choose langauge</title>
<style type="text/css">
img{border:0}
a {star : expression(onfocus=this.blur)}   /*去除图片链接边框 for IE6 */
a,area { blr:expression(this.onFocus=this.blur());   /*去除图片链接边框 for IE6/IE7/FF */
             outline:none;   /*去除图片链接边框 for IE8/FF */}
:focus { -moz-outline-style: none; }   /*去除图片链接边框 for Firefox */
</style>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/jquery.js'></script>
<script type='text/javascript'>
var languageMap = {
    'zh':'中文',
    'en':'English',
    'ja':'日本語',
    'ru':'Россию'
};
function translateBegin(newLang){
    if(!confirm("<fmt:message key='gap.authority.Translate' bundle='${applicationAuResources}' />"+languageMap[newLang]+"<fmt:message key='gap.authority.Language' bundle='${applicationAuResources}' /><fmt:message key='gap.authority.QuestionMark' bundle='${applicationAuResources}' />")){
        return;
    }
    if('en'==newLang){
        jQuery.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/VirtualHostI18N.do",
                data: "cmd=translateMenu&i18n=" + newLang,
                async: false,
                success: function(msg) {
                     alert(msg);                
                },
                error: function(xmlhttp,msg) {
                    alert("<fmt:message key='gap.authority.Failed_' bundle='${applicationAuResources}' />");
                }
            });
    }else{
        alert("<fmt:message key='gap.authority.Unsupported' bundle='${applicationAuResources}' />"+languageMap[newLang]+"<fmt:message key='gap.authority.Language' bundle='${applicationAuResources}' /><fmt:message key='gap.authority._8' bundle='${applicationAuResources}' />");
    }
    window.opener=null;
    window.close()
}
function translateShow(event,newLang){
    translateHidden();
    var openAnchor = '#'+newLang;
    jQuery('#showFlag').css('position','absolute');    
    jQuery('#showFlag').css('left','0px');  
    jQuery('#showFlag').css('top',(jQuery("#worldmap").height()-jQuery(openAnchor).height()));  
    jQuery('#showFlag').css('width',jQuery(openAnchor).width());  
    jQuery('#showFlag').css('height',jQuery(openAnchor).height());
    jQuery('#showFlag').html(jQuery(openAnchor).html());
      
}
function translateHidden(){
    jQuery('#showFlag').html('');
}
</script>
</head>
<body>
<img id="worldmap" src="../graphics/languageworld.jpg" usemap="#chooseMap" style="position: absolute; left: 0; top: 0; z-index: 0;"/>
<map name="chooseMap">
      <area shape="poly" coords="432,114,442,108,450,99,461,103,472,109,488,108,501,102,510,90,519,94,529,100,524,108,511,116,519,128,523,138,515,146,511,156,504,166,490,159,479,152,469,144,455,145,443,140,434,128" href="#" onclick="javascript:translateBegin('zh');" onmouseover="javascript:translateShow(event,'zh');" onmouseout="javascript:translateHidden();" alt="<fmt:message key='gap.authority.China' bundle='${applicationAuResources}' />"/>
      <area shape="poly" coords="523,164,531,156,541,150,545,138,544,126,532,128,521,132,515,144,513,154" href="#" onclick="javascript:translateBegin('ja');" onmouseover="javascript:translateShow(event,'ja');" onmouseout="javascript:translateHidden();" alt="<fmt:message key='gap.authority.Japan' bundle='${applicationAuResources}' />"/>
      <area shape="poly" coords="539,208,547,218,554,210,560,221,574,229,577,246,575,262,558,252,538,242,524,245,512,243,508,228,517,222,530,213" href="#" onclick="javascript:translateBegin('en');" onmouseover="javascript:translateShow(event,'en');" onmouseout="javascript:translateHidden();" alt="<fmt:message key='gap.authority.Australia' bundle='${applicationAuResources}' />"/>
      <area shape="poly" coords="440,187,445,177,455,168,466,159,470,144,455,144,441,135,428,144,423,160,427,172" href="#"  onclick="javascript:translateBegin('en');" onmouseover="javascript:translateShow(event,'en');" onmouseout="javascript:translateHidden();" alt="<fmt:message key='gap.authority.India' bundle='${applicationAuResources}' />"/>
      <area shape="poly" coords="255,41,265,41,274,45,276,94,265,98,254,91,252,53" href="#"  onclick="javascript:translateBegin('en');" onmouseover="javascript:translateShow(event,'en');" onmouseout="javascript:translateHidden();" alt="<fmt:message key='gap.authority.England' bundle='${applicationAuResources}' />"/>
      <area shape="poly" coords="2,55,18,39,28,17,49,11,74,14,96,10,106,0,127,5,152,1,178,6,194,21,201,51,209,64,216,128,196,130,177,147,164,131,148,128,132,128,120,112,98,111,110,148,96,144,84,103,69,104,51,110,26,118,5,70" href="#"  onclick="javascript:translateBegin('en');" onmouseover="javascript:translateShow(event,'en');" onmouseout="javascript:translateHidden();" alt="<fmt:message key='gap.authority.NorthAmerica' bundle='${applicationAuResources}' />"/>
      <area shape="poly" coords="363,105,363,66,378,71,391,59,411,48,414,62,440,46,468,41,483,52,509,55,529,48,536,58,571,69,602,81,595,95,568,105,557,122,549,108,536,107,513,86,496,95,481,106,461,94,440,98,410,94,397,101,380,104" href="#"  onclick="javascript:translateBegin('ru');" onmouseover="javascript:translateShow(event,'ru');" onmouseout="javascript:translateHidden();" alt="<fmt:message key='gap.authority.Russia' bundle='${applicationAuResources}' />"/>
</map>
<div id="showFlag" style="position: absolute; left: 0px; top: 0px;width:0px;height:0px"></div>
<div id="zh" style="display: none;"><img src="<venus:base/>/images/au/zh-cn.gif"/><center>中文</center></div><!-- 中文 -->
<div id="en" style="display: none;"><img src="<venus:base/>/images/au/en.gif"/><center>English</center></div><!-- 英文 -->
<div id="ja" style="display: none;"><img src="<venus:base/>/images/au/ja.gif"/><center>日本語</center></div><!-- 日文 -->
<div id="ru" style="display: none;"><img src="<venus:base/>/images/au/ru.gif"/><center>Россию</center></div><!-- 俄文 -->
</body>
</html>