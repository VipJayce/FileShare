<%@ page contentType="text/html; charset=GBK"%>
<html>
<head>
<title>Ploygon Position Tool</title>
<link rel='stylesheet' type='text/css' href='../../../css/jquery/dialog/jquery-dialog.css' />
<!--[if IE]><script type="text/javascript" src="../../../js/au/html5/canvas/excanvas.js"></script><![endif]-->
<script type='text/javascript' src='../../../js/au/jquery/jquery.js'></script>
<script type='text/javascript' src='../../../js/au/jquery/dialog/jquery-impromptu.3.1.min.js'></script>
</head>
<body>
<img id="worldmap" src="languageworld.jpg" style="position: absolute; left: 0; top: 0; z-index:0;display:none"/>
<canvas id="imageLayer" style="position: absolute; left: 0; top: 0; z-index:1;"></canvas>
<canvas id="acherLayerOperate" style="position: absolute; left: 0; top: 0; z-index:2;"></canvas>
<div id='tools'  style='position: absolute; left: 0; top: 350;'>
<input type="button" value="生成代码" onclick="javascript:generateCode();"/>
<br/>
<br/>
注意，此图片有版权问题！请使用该工具设置项目组图片。
<br/>
<br/>
图片来源：
<br/>
http://www.newsweek.com/content/newsweek/2010/09/26/the-new-world-order-a-map/_jcr_content/body/image.img.jpg/1285378150946.jpg
</div>
</body>
<script type="text/javascript">
Array.prototype.remove=function(dx)
  {
    if(isNaN(dx)||dx>this.length){return false;}
    for(var i=0,n=0;i<this.length;i++)
    {
        if(this[i]!=this[dx])
        {
            this[n++]=this[i]
        }
    }
    this.length-=1
  }
var operatorLayer,imageLayer,operatorContext,imageContext;
var pointList = new Array();
var RADIUS = 4;
function acherPoint(x, y) {
    this.x = x;
    this.y = y;
    this.hit = function(p){
        return (2*RADIUS+1)>=Math.sqrt(Math.pow((p.x-x),2)+Math.pow((p.y-y),2));
    };
}
function getCursorPosition(e) { 
    var x; 
    var y; 
    if (e.pageX != undefined && e.pageY != undefined) { 
        x = e.pageX; 
        y = e.pageY; 
    } else { 
        x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft; 
        y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop; 
    }
    x -= operatorLayer.offsetLeft; 
    y -= operatorLayer.offsetTop;
    var p = new acherPoint(x,y);
    return p; 
}
function pickOnClick(e) {
    var p = getCursorPosition(e);
    var isHit = false;
    jQuery.each(pointList, function(index, value) { 
        var everyP = value;
        if(everyP.hit(p)){
            operatorContext.clearRect(everyP.x-RADIUS-1,everyP.y-RADIUS-1,2*RADIUS+2,2*RADIUS+2);
            pointList.remove(index);
            isHit = true;
            return;
        }
    });
    if(isHit)
        return;
    pointList.push(p);
    operatorContext.beginPath();
    operatorContext.arc(p.x,p.y,RADIUS,0,Math.PI*2,true); 
    operatorContext.stroke();    
}
function generateCode(){
    var statesdemo = {
        state0: {
            html:'请输入名称：<br /> <input type="text" id="alertName" name="alertName" value="" />',
            buttons: { 取消: false, 下一步: true },
            focus: 1,
            submit:function(v,m,f){ 
                if(!v) return true;
                else{
                    var alertName = m.children('#alertName').val();
                    var templateCodeL = '<area   shape="poly" coords="';
                    var templateCodeM = '" href="#" alt="';
                    var templateCodeR = '"/>';
                    var allCode = templateCodeL;
                    jQuery.each(pointList, function(index, value) { 
                        allCode=allCode+(value.x+','+value.y+',');                      
                    });
                    allCode=allCode.substring(0,allCode.length-1)+templateCodeM;
                    allCode=allCode+alertName;
                    allCode=allCode+templateCodeR;
                    jQuery.prompt.goToState('state1');
                    jQuery('#htmlCode').text(allCode);                  
                }
                return false; 
            }
        },
        state1: {
            html:'生成结果：<br/><div id="htmlCode">代码生成失败!</div>',
            buttons: { 上一步: -1 , 退出: 0},
            focus: 1,
            submit:function(v,m,f){ 
                if(v==0) jQuery.prompt.close()
                else if(v==-1)
                    jQuery.prompt.goToState('state0');
                return false;
            }
        }
    };
    jQuery.prompt(statesdemo);
}
jQuery(window).load(function(){   
   operatorLayer = document.getElementById("acherLayerOperate"); 
   imageLayer = document.getElementById("imageLayer");    
   operatorLayer.width = jQuery("#worldmap").width();
   operatorLayer.height = jQuery("#worldmap").height();   
   imageLayer.width = jQuery("#worldmap").width();
   imageLayer.height = jQuery("#worldmap").height();   
   operatorContext = operatorLayer.getContext("2d");
   imageContext = imageLayer.getContext("2d");
   var worldmap = document.getElementById("worldmap");    
   imageContext.drawImage(worldmap, 0, 0);
   jQuery("#acherLayerOperate").click(function(e){pickOnClick(e);});
});
</script>
</html>