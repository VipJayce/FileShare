(function($) {

	$.fn.sortable.defaults = {
	    selectors : {
	      container : 'column',
	      widget : '.widget',
	      header : '.widget-header',
	      content : '.widget-content',
	      closeEdit : '.widget-close-editbox',
	      zoomLink : '.widget-zoomlink'
	    }
	}

})(jQuery);
  
  
  
function MenuLink(text, title, aClass){
	var l = '<a href="#" title="TITLE" class="CLASS">TEXT</a>';
	l = l.replace(/TEXT/g, text);
	l = l.replace(/TITLE/g, title);
	l = l.replace(/CLASS/g, aClass.replace(/\./, ''));
	return l;
}

//-------------增加为widget增加行为-begin----------------------------------------------------
function addZoomLink(widget)
{
 	var  link = MenuLink(
       '',
       '缩放',
       '.widget-zoomlink'
      );
    if(!widget)
    	widget=jQuery(".widget");
	widget.find(".widget-header").append(link);
	widget.find(".widget-zoomlink").append("<img src='" + dir_base + "/images/dd/ico_min_max.gif' border=none alt='缩放' />").click(function(){     	
		 var link = jQuery(this);
         var widget = link.parents(".widget");
         widget.find(".widget-content").toggle();
     });
}

function addCloseLink(widget)
{
  	var  link = MenuLink(
       '',
       '关闭',
       '.widget-closelink'
    );
    if(!widget)
    	widget=jQuery(".widget");
	widget.find(".widget-header").append(link);
	widget.find(".widget-closelink").append("<img src='" + dir_base + "/images/dd/ico_close.gif' border=none alt='关闭' />").click(function(){
	     var link = jQuery(this);
         var widget = link.parents(".widget");
         widget.remove();
     });
     
}
//--------------增加为widget增加行为-end------------------------------------------------------  

//修改列数
function changeCol(colnum,container,length)
{
 	var curnum=jQuery(".column").length;
  	if(jQuery(".column").length<colnum){
	  	for(var i=curnum+1;i<=colnum;i++)
	  	{
	  		var colName="col-"+i;
	  		var htmlstr ="<div id="+colName+" class='column'></div>";
	  		jQuery("#"+container+ "  #rightPanel").append(htmlstr);
	  	}
  	}else
  	{	
	  	jQuery(".widget").each(function(n){
			var column =jQuery(this).parent(".column");
			if(column.attr('id').replace('col-','')>colnum)
			{
			//var lastcolumn = jQuery(".column:nth-child("+colnum+")");
				 jQuery("#col-1").append(this);
			}
	  	});
	  	jQuery(".column:gt("+(colnum-1)+")").remove();
	}
	jQuery(".column").sortable({
			connectWith: ['.column'],
			items: '.widget'
	});	  		
	jQuery(".column").width(parseInt((430-4*jQuery(".column").length)/jQuery(".column").length));
	jQuery(".widget").width(parseInt((430-6*jQuery(".column").length)/jQuery(".column").length));
}

//增加widget
function addWidget(id,header,content)
{
	var htmlstr="";
	//处理列中元素-begin
	htmlstr =htmlstr+"<div id="+id+" class='widget'>";
	htmlstr =htmlstr+"<div class='widget-header'>"+header+"</div>";
	htmlstr =htmlstr+"<div class='widget-content'>"+content+"</div>";
	htmlstr =htmlstr+"</div>";
	//处理列中元素-end
	jQuery(".column:first").append(htmlstr);
	jQuery(".widget").width(parseInt((430-6*jQuery(".column").length)/jQuery(".column").length));
	addZoomLink(jQuery(".column:first .widget:last"));
	addCloseLink(jQuery(".column:first .widget:last"));
	jQuery(".column:first .widget:last").find(".widget-content").hide();
}

//---------------------
function CookieClass(){
	this.expires = 0 ; //有效时间,以分钟为单位
	this.path = ""; //设置访问路径
	this.domain = ""; //设置访问主机
	this.secure = false; //设置安全性
	
	this.setCookie = function(name,value){
		var str = name+"="+escape(value);
		if (this.expires>0){ //如果设置了过期时间
		var date=new Date();
		var ms=this.expires * 60 * 1000; //每分钟有60秒，每秒1000毫秒
		date.setTime(date.getTime()+ms);
		str+="; expires="+date.toGMTString();
	}
	if(this.path!="")str+="; path="+this.path; //设置访问路径
	if(this.domain!="")str+="; domain="+this.domain; //设置访问主机
	if(this.secure!="")str+="; true"; //设置安全性
	
	document.cookie=str;
}

this.getCookie=function(name){
	var cookieArray=document.cookie.split("; "); //得到分割的cookie名值对
	var cookie=new Object();
	for(var i=0;i<cookieArray.length;i++){
		var arr=cookieArray[i].split("="); //将名和值分开
		if(arr[0]==name)return unescape(arr[1]); //如果是指定的cookie，则返回它的值
	}
	return "";
}

this.deleteCookie=function(name){
	var date=new Date();
	var ms= 1 * 1000;
	date.setTime(date.getTime() - ms);
	var str = name+"=no; expires=" + date.toGMTString(); //将过期时间设置为过去来删除一个cookie
	document.cookie=str;
}

this.showCookie=function(){
	alert(unescape(document.cookie));
}
} 
//-------------------------



