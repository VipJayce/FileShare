function arrowRotate(pointX, pointY, centerX,centerY,angle){
	newX = Math.cos(angle) * (pointX-centerX) - Math.sin(angle) * (pointY-centerY);
    newY = Math.sin(angle) * (pointX-centerX) + Math.cos(angle) * (pointY-centerY);
    return {x:(newX+centerX),y:(newY+centerY)};	
}
Raphael.fn.arrowStr = function (x1, y1, x2, y2) {
	     x2 = Number(x2);
	     y2 = Number(y2);
	    var angle = Math.atan2(y2-y1,x2-x1);
        var points = [{x:x2-30, y:y2},{x:(x2-30),y:(y2  - 10)},{x:(x2-30),y:(y2  + 10)},{x:x2 ,y:y2}];
        var newPoints = [];
        var center = {x:x2,y:y2};
        for(var i=0;i<points.length;i++)
        	newPoints.push(arrowRotate(points[i].x,points[i].y,center.x,center.y,angle));
        var arrowStr="M" + x1 + " " + y1 + " L" + newPoints[0].x + " " + newPoints[0].y+ " M" + newPoints[3].x + " " + newPoints[3].y + " L" + newPoints[1].x + " " + newPoints[1].y + " L" + newPoints[0].x + " " + newPoints[0].y + " M" + newPoints[3].x + " " + newPoints[3].y  + " L" + newPoints[2].x  + " " + newPoints[2].y + " L" + newPoints[0].x + " " + newPoints[0].y ;
        return arrowStr;
    };
    
Raphael.fn.arrowCurveStr = function (x1, y1, x2, y2, x3, y3, x4, y4) {
	var path = ["M", x1.toFixed(3), y1.toFixed(3), "C", x2, y2, x3, y3, x4.toFixed(3), y4.toFixed(3)].join(",");
	var tracePath = this.path(path);
	tracePath.hide();
	var lineEnd = tracePath.getPointAtLength(tracePath.getTotalLength()-30);
	tracePath.remove();
	this.safari();
	var x0 = lineEnd.x;
	var y0 = lineEnd.y;
	var angle = Math.atan2(y4-y0,x4-x0);
	var points = [{x:(x4-30),y:(y4  - 10)},{x:(x4-30),y:(y4  + 10)},{x:x4 ,y:y4}];
	var newPoints = [];
    var center = {x:x4,y:y4};
	for(var i=0;i<points.length;i++)
        newPoints.push(arrowRotate(points[i].x,points[i].y,center.x,center.y,angle));
    var arrowStr="M" + x1 + " " + y1 + " C" + x2+ " " + y2 + " " + x3 + " " + y3 + " " + x0 + " " + y0 + " M" + newPoints[2].x + " " + newPoints[2].y + " L" + newPoints[0].x + " " + newPoints[0].y + " L" + newPoints[1].x + " " + newPoints[1].y + " L" + newPoints[2].x  + " " + newPoints[2].y ;
    return arrowStr;	
    };

Raphael.connections = [];
    
Raphael.fn.connection = function (obj1, obj2, line, bg) {
    if (obj1.line && obj1.from && obj1.to) {
        line = obj1;
        obj1 = line.from;
        obj2 = line.to;
    }
    
    var bb1 = obj1.getBBox(),
        bb2 = obj2.getBBox(),
        p = [{x: bb1.x + bb1.width / 2, y: bb1.y - 1},
        {x: bb1.x + bb1.width / 2, y: bb1.y + bb1.height + 1},
        {x: bb1.x - 1, y: bb1.y + bb1.height / 2},
        {x: bb1.x + bb1.width + 1, y: bb1.y + bb1.height / 2},
        {x: bb2.x + bb2.width / 2, y: bb2.y - 1},
        {x: bb2.x + bb2.width / 2, y: bb2.y + bb2.height + 1},
        {x: bb2.x - 1, y: bb2.y + bb2.height / 2},
        {x: bb2.x + bb2.width + 1, y: bb2.y + bb2.height / 2}],
        d = {}, dis = [];
    for (var i = 0; i < 4; i++) {
        for (var j = 4; j < 8; j++) {
            var dx = Math.abs(p[i].x - p[j].x),
                dy = Math.abs(p[i].y - p[j].y);
            if ((i == j - 4) || (((i != 3 && j != 6) || p[i].x < p[j].x) && ((i != 2 && j != 7) || p[i].x > p[j].x) && ((i != 0 && j != 5) || p[i].y > p[j].y) && ((i != 1 && j != 4) || p[i].y < p[j].y))) {
                dis.push(dx + dy);
                d[dis[dis.length - 1]] = [i, j];
            }
        }
    }
    if (dis.length == 0) {
        var res = [0, 4];
    } else {
        res = d[Math.min.apply(Math, dis)];
    }
    var x1 = p[res[0]].x,
        y1 = p[res[0]].y,
        x4 = p[res[1]].x,
        y4 = p[res[1]].y;
    dx = Math.max(Math.abs(x1 - x4) / 2, 10);
    dy = Math.max(Math.abs(y1 - y4) / 2, 10);
    var x2 = [x1, x1, x1 - dx, x1 + dx][res[0]].toFixed(3),
        y2 = [y1 - dy, y1 + dy, y1, y1][res[0]].toFixed(3),
        x3 = [0, 0, 0, 0, x4, x4, x4 - dx, x4 + dx][res[1]].toFixed(3),
        y3 = [0, 0, 0, 0, y1 + dy, y1 - dy, y4, y4][res[1]].toFixed(3);
    if (line && line.line) {
        line.bg && line.bg.attr({path: path});
        line.line.attr({path: this.arrowCurveStr(x1, y1, x2, y2, x3, y3, x4, y4)}).attr({fill: "#fff", stroke: "#000", "stroke-width": 5,  cursor: "move"});
    } else {
        var color = typeof line == "string" ? line : "#000";
        var arrow = this.path(this.arrowCurveStr(x1, y1, x2, y2, x3, y3, x4, y4)).attr({fill: "#fff", stroke: "#000", "stroke-width": 5,  cursor: "move"});
        var start = function (x,y) {
            this.ox = x;
            this.oy = y;
            this.animate({"fill-opacity": .2}, 500);
            this.toolx = this.ox;
            this.tooly = this.oy;
        },
        move = function (dx, dy, x, y) {
            var deltaX = x - this.ox;  
            var deltaY = y - this.oy;  
            this.translate(deltaX, deltaY);  
            this.ox = x;  
            this.oy = y;
        },
        up = function () {
            var upy = this.oy;
            if(upy<150){
            	var connections = Raphael.connections;
            	for (var i = connections.length; i--;) {
            		var c = connections[i];
                    if(this.id===c.line.id){
                        c.line.remove();
                        connections.splice(i,1);                        
                    }
                }
            }else{
            	this.translate(this.toolx - this.ox, this.tooly-this.oy);   
            }
        };
        arrow.drag(move, start, up);
        return {
            bg: bg && bg.split && this.path(path).attr({stroke: bg.split("|")[0], fill: "none", "stroke-width": bg.split("|")[1] || 3}),
            line: arrow,
            from: obj1,
            to: obj2
        };
    }
};

var el;
jQuery(document).ready(function () {
        var dragger = function (x,y) {
            this.ox = this.type == "circle" ? this.attr("cx") : this.type == "path" ? x : this.attr("x");
            this.oy = this.type == "circle" ? this.attr("cy") : this.type == "path" ? y : this.attr("y");
            
            this.toolx = this.ox;
            this.tooly = this.oy;
            
            if(this.pair){
                this.pair.ox = this.pair.type == "circle" ? this.pair.attr("cx") : this.pair.type == "path" ? x : this.pair.attr("x");
                this.pair.oy = this.pair.type == "circle" ? this.pair.attr("cy") : this.pair.type == "path" ? y : this.pair.attr("y");
                this.pair.toolx = this.pair.ox;
                this.pair.tooly = this.pair.oy;
            }              
        },
        pathdragger = function (x,y) {
            this.ox = x;
            this.oy = y;
            this.toolx = this.ox;
            this.tooly = this.oy;
        },
        move = function (dx, dy) {
            var att = this.type == "circle" ? {cx: this.ox + dx, cy: this.oy + dy} : {x: this.ox + dx, y: this.oy + dy};
            this.attr(att);
            
            if(this.pair){
            	att = this.pair.type == "circle" ? {cx: this.pair.ox + dx, cy: this.pair.oy + dy} : {x: this.pair.ox + dx, y: this.pair.oy + dy};
            	this.pair.attr(att);
            }
            
            for (var i = connections.length; i--;) {
                t.connection(connections[i]);
            }
            r.safari();
        },
        toolmove = function (dx, dy, x, y) {
            if(this.type == "path"){
                var deltaX = x - this.ox;  
                var deltaY = y - this.oy;  
                this.translate(deltaX, deltaY);  
                this.ox = x;  
                this.oy = y;
            }else{
                var att = this.type == "circle" ? {cx: this.ox + dx, cy: this.oy + dy} : {x: this.ox + dx, y: this.oy + dy};
                this.attr(att);
                t.safari();
            }
        },
        toolup = function () {
            var upy = this.type == "circle" ? this.attr("cy") : this.type == "path" ? this.oy : this.attr("y");
            if(upy>170){
                var that = this.clone();//id is different
                if(this.type == "path"){
                	reusePathOperator(that);
                    that.drag(toolmove, pathdragger, pathup);
                    
                    var totalLength = that.getTotalLength();
                    var startPoint =that.getPointAtLength(0);
                    var endPoint =that.getPointAtLength(totalLength);
                    reuseConnectionOperator(startPoint.x,startPoint.y,that,"from","to");
                    reuseConnectionOperator(endPoint.x,endPoint.y,that,"to","from");
                    
                }else{
                    that.drag(move, dragger, up);
                    shapes.push(that);
                }
            }
            var att;
            if(this.type == "path"){
                this.translate(this.toolx - this.ox, this.tooly-this.oy);  
            }else{
                att = this.type == "circle" ? {cx: this.toolx, cy: this.tooly} :  {x: this.toolx, y: this.tooly}; 
                this.attr(att);
            }
        },
        pathup = function () {
            var upy = this.oy;
            if(upy<150){
            	this.remove();
            	jQuery("#topMost").animate({ top: "104px", left: "162px", cursor: "move" }, 500);
                jQuery("#bottomMost").animate({ top: "104px", left: "245px", cursor: "move" },500);
            }else
                reusePathOperator(this);
        },
        up = function () {
            var upy = this.type == "circle" ?this.attr("cy") : this.type == "path" ? this.oy : this.attr("y"); 
            if(upy<150){
            	//first unconnect this from connections[]
            	for (var i = connections.length; i--;) {
                    var c = connections[i];
                    if(c.from.id===this.id||c.to.id===this.id){
                        c.line.remove();
                        connections.splice(i,1);                        
                    }
                    if(this.pair){
                    	if(c.from.id===this.pair.id||c.to.id===this.pair.id){
                            c.line.remove();
                            connections.splice(i,1);                        
                        }
                    }
                }
            	//second  remove this from shapes
                for (var i = shapes.length; i--;) {
                	if(shapes[i].id==this.id){
                	   shapes.splice(i,1);
                	   break;
                	}
                }
            	//third this.remove from Paphael
                if(this.pair){
                	this.pair.remove();	
                }
                this.remove();
            }
        },
        t = Raphael("toolbar", 600, 800),
        connections = Raphael.connections,
        toolshapes = [  t.circle(90, 100, 20).attr({fill: "#fff", stroke: "#000", "stroke-width": 5,  cursor: "move"}),
                    t.path("M160 100 h50 v-10 l 30 10 M160 100 h50 v 10 l 30 -10").attr({fill: "#fff", stroke: "#000", "stroke-width": 5,  cursor: "move"}),
                    t.rect(290, 80, 70, 40, 5).attr({fill: "#fff", stroke: "#000", "stroke-width": 5,  cursor: "move"}),
                    t.circle(450, 100, 20).attr({fill: "r#000-#000:60-#fff:60-#fff", stroke: "#000", "stroke-width": 5, cursor: "move"})
                ],
        shapes = [],
        reusePathOperator = function(that){
                    var totalLength = that.getTotalLength();
                    var startPoint =that.getPointAtLength(0);
                    var endPoint =that.getPointAtLength(totalLength);
                    jQuery("#topMost").css("top",startPoint.y+4).css("left",startPoint.x+2);
                    jQuery("#bottomMost").css("top",endPoint.y+4).css("left",endPoint.x+5);                    
                    jQuery("#topMost").draggable({
                        drag: function(event,ui) {
                            var middleX = ui.position.left + (ui.helper.width())/2;
                            var middleY = ui.position.top + (ui.helper.height())/2;
                            var arrowStr = t.arrowStr(middleX,middleY,jQuery("#bottomMost").css("left").replace("px",""),jQuery("#bottomMost").css("top").replace("px",""));
                            that.attr({path:arrowStr});
                            that.attr({fill: "#fff", stroke: "#000", "stroke-width": 5,  cursor: "move"});
                            reuseConnectionOperator(middleX,middleY,that,"from","to");                            
                        }
                    });
                    jQuery("#bottomMost").draggable({
                        drag: function(event,ui) {
                            var middleX = ui.position.left + (ui.helper.width())/2;
                            var middleY = ui.position.top + (ui.helper.height())/2;
                            var arrowStr = t.arrowStr(jQuery("#topMost").css("left").replace("px",""),jQuery("#topMost").css("top").replace("px",""),middleX,middleY);
                            that.attr({path: arrowStr});
                            that.attr({fill: "#fff", stroke: "#000", "stroke-width": 5,  cursor: "move"});
                            reuseConnectionOperator(middleX,middleY,that,"to","from");
                        }
                    });
                },
        reuseConnectionOperator = function(middleX,middleY,that,first,last){
                    for (var i = shapes.length; i--;) {
                        var dimensions = shapes[i].getBBox();
                        var shapeX = shapes[i].type == "rect" ? shapes[i].attr("x") : shapes[i].attr("cx");
                        var shapeY = shapes[i].type == "rect" ? shapes[i].attr("y") : shapes[i].attr("cy");
                        if(middleX>shapeX&&middleY>shapeY&&middleX<(shapeX+dimensions.width)&&middleY<(shapeY+dimensions.height)){
                            that[first] = shapes[i];
                            if(that[last]){
                            	connections.push(t.connection(that.from, that.to, "#000"));
                                that.remove();
                                jQuery("#topMost").animate({ top: "104px", left: "162px", cursor: "move" }, 500);
                                jQuery("#bottomMost").animate({ top: "104px", left: "245px", cursor: "move" },500);
                            }
                            break;
                        }
                    }
                };
        
        for (var i = 0, ii = toolshapes.length; i < ii; i++) {
            toolshapes[i].drag(toolmove, dragger, toolup);
        }
        
        t.path("M 50 150 L 500 150").attr({fill: "#fff", stroke: "#000", "stroke-width": 2});
        
        el = toolshapes[2];
        
        el.deepClone = function (x,y,id,name,anologs) {
            var group = t.set();
            var state = this.clone();
            var text = t.text(this.attr("x")+this.attr("width")/2,this.attr("y")+20, id.replace("_COMMAND","")+"\n"+name).attr({ cursor: "move" });
            state.pair = text;
            text.pair = state;
            group.push(state,text);
            
            shapes.push(state);
            group.translate( x - this.attr("x"),y - this.attr("y"));
            
            state.drag(move, dragger, up);
            text.drag(move, dragger, up);
            
            group.click(function (event) {
                eval('echoCommand("'+id+'","'+name+'","'+anologs+'")');                
            });
        };        
        
});
 