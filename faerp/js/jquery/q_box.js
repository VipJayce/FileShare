/**
 * @author Administrator
 */
;jQuery(window).bind("scroll",function(){
    if (jQuery("#gbox_contain").length > 0) {

        var topValue = jQuery(window).scrollTop();
        jQuery("#gbox_contain").css('bottom',-topValue);
    }    
});

;jQuery.gBox={
    TimeSpan:undefined,
    Time:1500,
    message:function(option,TimeSpan){
        var defaultOption={
            Title:undefined,
            Content:undefined,
            Width:350,
            Height:100,
            Time:1500
        };
        defaultOption=jQuery.extend(defaultOption,option);
        jQuery.gBox.TimeSpan=TimeSpan;
        jQuery.gBox.Time=defaultOption.Time;
        if(jQuery("#gbox_contain").length>0){
            jQuery("#gbox_contain").remove();
        }
        
        var html="";
        html+="<div id=\"gbox_contain\" class=\"gbox_contain\">";
        
        html+="<div class=\"gbox_title\">";
        html+="<div class=\"gbox_head\">"+defaultOption.Title+"</div>";
        html+="<a title=\"关闭\" id=\"gbox_close\" class=\"gbox_close\">&nbsp;&nbsp;</a>";
        html+="</div>";
        
        html+="<div class=\"gbox_content\">";
        html+=defaultOption.Content;
        html+="</div>";
        
        html+="</div>";

        jQuery("body").append(html);
        jQuery("#gbox_contain").css("width",defaultOption.Width+"px");
        jQuery("#gbox_contain").css("height","auto");
       // alert(defaultOption.Time);
        if(jQuery.browser.safari || jQuery.browser.opera || jQuery.browser.mozilla){
        	
            jQuery("#gbox_contain").animate({opacity:1.0},{duration:defaultOption.Time});
        }else{
            jQuery("#gbox_contain").animate({filter:"Alpha(Opacity=100)"},{duration:defaultOption.Time});
        }
        jQuery("#gbox_close").click(function(){
            jQuery.gBox.Close();
        });
        
        var gbox_timeout=undefined;
        if(jQuery.gBox.TimeSpan!=undefined && jQuery.gBox.TimeSpan>0){
            gbox_timeout=setTimeout("jQuery.gBox.Close()",jQuery.gBox.TimeSpan);
        }
        jQuery("#gbox_contain").mouseover(function(){
            if(gbox_timeout!=undefined){
                clearTimeout(gbox_timeout);
            }
        });
        jQuery("#gbox_contain").mouseout(function(){
            if(jQuery.gBox.TimeSpan!=undefined && jQuery.gBox.TimeSpan>0){
                gbox_timeout=setTimeout("jQuery.gBox.Close()",jQuery.gBox.TimeSpan);
            }
        });
    },
    Close:function(){
        if(jQuery("#gbox_contain").length>0){
            var height=jQuery("#gbox_contain").height();
            jQuery("#gbox_contain").animate({height:0},{duration:jQuery.gBox.Time,complete:function(){
                jQuery("#gbox_contain").remove();
            }});
        }
    }
};
