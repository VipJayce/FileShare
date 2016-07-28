<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="gap.authority.util.GlobalConstants" %>
<%@ page import="gap.authority.service.sys.vo.SysParamVo" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<%@ taglib uri="/WEB-INF/gap-i18n.tld" prefix="i18n" %>
<%
//工作日历布局样式配置
SysParamVo workCalendarStyle = GlobalConstants.getSysParam("WORKCALENDARSTYLE");
String aStyle = null==workCalendarStyle?"hidden":workCalendarStyle.getValue();
%>
<html>
<head>
<link rel='stylesheet' type='text/css' href='<venus:base/>/css/calendarTheme.css' />
<link rel='stylesheet' type='text/css' href='<venus:base/>/css/fullcalendar.css' />
<link rel='stylesheet' type='text/css' href='<venus:base/>/css/jquery/dialog/jquery-dialog.css' />
<link rel='stylesheet' type='text/css' href='<venus:base/>/js/au/jquery/loadmask//jquery.loadmask.css' />
<link rel='stylesheet' type='text/css' href='<venus:base/>/css/workcalendar-tools-<%=aStyle%>.css' />
<i18n:javascript src="/js/common/variable-i18n.js"/>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/jquery.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/ui/jquery-ui-custom.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/effect/jquery.effects.core.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/effect/jquery.effects.blind.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/calendar/fullcalendar.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/dialog/jquery-impromptu.1.8.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/DOMWindow/jquery.DOMWindow.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/loadmask/jquery.loadmask.js'></script>
<script type='text/javascript' src='<venus:base/>/js/au/jquery/timeout/jquery.ba-dotimeout.min.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/workcalendar/interface/WorkCalendar.js'></script>  
<script type='text/javascript' src='<%=request.getContextPath()%>/workcalendar/engine.js'></script> 
<script type='text/javascript' src='<%=request.getContextPath()%>/workcalendar/util.js'></script>
<script type='text/javascript'>
    DWREngine.setErrorHandler(function(msg){
            alert(i18n.error_message+msg);
    }); 
    /*get oid
    */
    function getWorkItemId(){
        var tableName = 'AU_WORKCALENDAR';
        DWREngine.setAsync(false);
		var _data = false;
		WorkCalendar.getOid(tableName,function(data){
		    _data = data;
		});
		DWREngine.setAsync(true);
		return _data;
    }
    /*add work item
    */
    function addWorkCalendarItem(item){
        item.source = undefined;
        WorkCalendar.addWorkCalendarItem(item);
    }
    /*delete work item
    */
    function deleteWorkCalendarItem(item){
        item.source = undefined;
        WorkCalendar.deleteWorkCalendarItem(item);
    }
    /*delete work item
    */
    function updateWorkCalendarItem(item){
        item.source = undefined;
        WorkCalendar.updateWorkCalendarItem(item);
    }
    
    jQuery(document).ready(function() {
        jQuery.datepicker.setDefaults( jQuery.datepicker.regional[ gap.authority.Regional ] );
        jQuery( "#datepicker" ).bind('mouseover click',function(){
            jQuery( "#datepicker" ).attr('disabled','true');
            jQuery( "#datepicker" ).datepicker({
	            changeMonth: true,
	            changeYear: true,
	            showWeek: true,
	            firstDay: 0,
	            dateFormat:'yy-mm-dd',
                showAnim: "blind",
                onSelect: function(dateText, inst) {
                    var newchooseDate = jQuery.fullCalendar.parseDate( dateText );
                    jQuery('#calendar').fullCalendar( 'gotoDate', newchooseDate.getFullYear() ,newchooseDate.getMonth() ,newchooseDate.getDate() );
                },
                onClose: function(dateText, inst) {
                    jQuery( "#datepicker" ).removeAttr('disabled');
                }
	        });
	        jQuery( "#datepicker" ).datepicker("show");
        });
        
        if('absolute'==jQuery("#external-events").css('position')){
            jQuery("#controlarea").html('<img src="../../../images/au/folder_open.png" alt="open" />');
            jQuery("#external-events").bind('click', function(event) {
                if (jQuery("#openCloseIdentifier").is(":hidden")) {
                    jQuery("#external-events").animate({ 
		                    marginLeft: "0px"
		                    }, 500 );
		            jQuery("#controlarea").html('<img src="../../../images/au/folder_open.png" alt="open" />');
		            jQuery("#openCloseIdentifier").show();	                
	            } else{
	                jQuery("#external-events").animate({ 
	                    marginLeft: "120px"
	                    }, 500 );
	                jQuery("#controlarea").html('<img src="../../../images/au/folder_locked.png" alt="close" />');
	                jQuery("#openCloseIdentifier").hide();
	            }
	        }); 
        }
        /* initialize the external events
        -----------------------------------------------------------------*/
    
        jQuery('#external-events div').each(function() {
        
            // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
            // it doesn't need to have a start or end
            var eventObject = {
                title: jQuery.trim(jQuery(this).text()), // use the element's text as the event title,
                cssStyle:jQuery.trim(jQuery(this).attr('id'))
            };
            
            // store the Event Object in the DOM element so we can get to it later
            jQuery(this).data('eventObject', eventObject);
            
            // make the event draggable using jQuery UI
            jQuery(this).draggable({
                zIndex: 999,
                revert: true,      // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            });
            
        });
    
    
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        
        /* initialize the calendar
        -----------------------------------------------------------------*/
        jQuery('#calendar').fullCalendar({
            theme: true,
            aspectRatio: 1.4,
            header: {
                left: 'prevYear,prev,next,nextYear today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
			columnFormat:{
			    month: 'ddd',    // Mon
			    week: ('ddd M'+gap.authority.Month+'d'+gap.authority.Day), // Mon 9/7
			    day: ('dddd M'+gap.authority.Month+'d'+gap.authority.Day)  // Monday 9/7
			},
			buttonIcons: {
		        prev: 'circle-triangle-w',
		        next: 'circle-triangle-e',
		        prevYear: 'circle-arrow-w', 
                nextYear: 'circle-arrow-e' 
		    },
			buttonText:{
			    prev:     '&nbsp;&#9668;&nbsp;',  // left triangle
			    next:     '&nbsp;&#9658;&nbsp;',  // right triangle
			    prevYear: '&nbsp;&lt;&lt;&nbsp;', // <<
			    nextYear: '&nbsp;&gt;&gt;&nbsp;', // >>
			    today:    gap.authority.Today,
			    month:    gap.authority.MonthCalendar,
			    week:     gap.authority.WeekCalendar,
			    day:      gap.authority.DayCalendar
			},
			titleFormat:{
			    month: ('yyyy'+gap.authority.Year+' MMMM'),                             // September 2009
			    week: ("yyyy"+gap.authority.Year+" MMM d[ yyyy]"+gap.authority.Day+"{ '"+gap.authority.FromTo+"'[ MMM] d"+gap.authority.Day+" }"), // Sep 7 - 13 2009
			    day: ('yyyy'+gap.authority.Year+'MMMd'+gap.authority.Day+' dddd')                  // Tuesday, Sep 8, 2009
			},           
            monthNames:gap.authority.MonthNames,
            monthNamesShort:gap.authority.monthNamesShort,
            dayNames:gap.authority.dayNames,
            dayNamesShort:gap.authority.dayNamesShort,
            editable: true,
            events: 'workfeed.jsp',
            eventRender: function(event, element, view) {
                if(event.percent&&''!=event.percent&&'%'!=event.percent&&'0%'!=event.percent)
                    if('month'==view.name)
                        element.append('<div id="'+event.id+'percent" title="'+gap.authority.process+event.percent+'" style="background-color:white;background-repeat:repeat-x;width:'+event.percent+';height:3px;"><div heigth=3px/></div>');
            }, 
            loading: function(bool) {
                if (bool){
                    jQuery('#wrap').height(713);//解决ie6的bug
                    jQuery('#wrap').mask('&nbsp;&nbsp;&nbsp;&nbsp;'+gap.authority.Loading);
                }else jQuery('#wrap').unmask();
            },
            droppable: true, // this allows things to be dropped onto the calendar !!!
            drop: function(date, allDay) { // this function is called when something is dropped
            
                // retrieve the dropped element's stored Event Object
                var originalEventObject = jQuery(this).data('eventObject');
                
                // we need to copy it, so that multiple events don't have a reference to the same object
                var copiedEventObject = jQuery.extend({}, originalEventObject);
                
                // assign it the date that was reported
                copiedEventObject.start = date;
                copiedEventObject.allDay = allDay;
                copiedEventObject.className = copiedEventObject.cssStyle;
                copiedEventObject.id = getWorkItemId();
                
                // render the event on the calendar
                // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                jQuery('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
                addWorkCalendarItem(copiedEventObject);
                
                // is the "remove after drop" checkbox checked?
                if (jQuery('#drop-remove').is(':checked')) {
                    // if so, remove the element from the "Draggable Events" list
                    jQuery(this).remove();
                }
            },
            selectable: true,
            selectHelper: true,
            select: function(startDate, endDate, allDay, jsEvent, view) {
                var txt = gap.authority.Content+' <input type="text" id="eventItem" name="eventItem"/><input type="hidden" id="sliderValue" /><input type="hidden" id="colorValue" />';
                var jQueryHtml = jQuery('<div>'+txt+'</div>');
                jQueryHtml.append('<div style="clear:both"></div><div style="width:80%;margin-right: auto;margin-left: auto;"><div style="float:left;margin:10px auto auto auto\9;">'+gap.authority.process+' </div><div id="tempDisplay" style="display:none;"/><div id="slider" style="margin:10px auto auto 52px" ondblclick="jQuery(\'#slider\').slider({range: \'min\',slide: function(event, ui) {var mouseX = event.clientX-jQuery(this).offset().left+110;var mouseY = jQuery(this).offset().top-100;jQuery(\'#tempDisplay\').html(ui.value).show().css({position: \'absolute\', zIndex:10000,top: mouseY, left: mouseX});},stop:function(event, ui){jQuery(\'#sliderValue\').attr(\'value\',ui.value);}})"><font style="font-size:xx-small;">&nbsp;</font></div></div>');
                jQueryHtml.append('<div style="clear:both"></div><div style="width:80%;margin-right: auto;margin-left: auto;"><div style="float:left;margin:10px auto auto auto\9;">'+gap.authority.Display+' &nbsp;&nbsp;</div><div id="colorchanger" style="margin:10px auto auto auto\9;" ondblclick="jQuery(\'div>ul>li\').bind(\'click\',function(){jQuery(\'#colorValue\').val(jQuery(this).attr(\'class\'));jQuery(this).css(\'border-color\',\'#666699\').siblings().css(\'border-color\',\'#EEE\');});"><ul class="colors"><li class="color-important-urgency"/><li class="color-important"/><li class="color-urgency"/><li class="color-normal"/><li class="color-attention"/></ul></div></div>');
                jQueryHtml.append('<div style="clear:both"></div>'); 
                jQuery.prompt(jQueryHtml.html(),{show:'slideDown',buttons: gap.authority.Buttons,callback:function(v,m){
                    if('submit'==v&&''!=jQuery('#eventItem').val()){
                        var newClassName = m.children('#colorValue').val().substring(6);// "color-"
                        var newItem = {
                            id:getWorkItemId(),
                            title: m.children('#eventItem').val(),
                            start: startDate,
                            end: endDate,
                            allDay: allDay,
                            percent:m.children('#sliderValue').val()+'%',
                            className: newClassName
                        };
                        jQuery('#calendar').fullCalendar('renderEvent',newItem,false); // Note: Don't make the event "stick"
	                    addWorkCalendarItem(newItem);
                    }
                }});
                jQuery('#slider').trigger('ondblclick');
                jQuery('#colorchanger').trigger('ondblclick');
                jQuery('#calendar').fullCalendar('unselect');
            },
            eventClick: function(calEvent, jsEvent, view) {
		        //alert('Event: ' + calEvent.title);
		        //alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
		        //alert('View: ' + view.name);
		        var sliderValue = (calEvent.percent&&('%'!=calEvent.percent))?calEvent.percent.split('%')[0]:0;
		        var txt = gap.authority.Content+' <input type="text" id="eventItem" name="eventItem" value="'+calEvent.title+'"/><input type="hidden" id="sliderValue" value="'+sliderValue+'"/><input type="hidden" id="colorValue" />';
                var jQueryHtml = jQuery('<div>'+txt+'</div>');                
                jQueryHtml.append('<div style="clear:both"></div><div style="width:80%;margin-right: auto;margin-left: auto;"><div style="float:left;margin:10px auto auto auto\9;">'+gap.authority.process+' </div><div id="tempDisplay" style="display:none"/><div id="slider" style="margin:10px auto auto 52px" ondblclick="jQuery(\'#slider\').slider({value:'+sliderValue+',range: \'min\',slide: function(event, ui) {var mouseX = event.clientX-jQuery(this).offset().left+110;var mouseY = jQuery(this).offset().top-100;jQuery(\'#tempDisplay\').html(ui.value).show().css({position: \'absolute\', zIndex:10000,top: mouseY, left: mouseX});},stop:function(event, ui){jQuery(\'#sliderValue\').val(ui.value);}})"><font style="font-size:xx-small;">&nbsp;</font></div></div>');
                jQueryHtml.append('<div style="clear:both"></div><div style="width:80%;margin-right: auto;margin-left: auto;"><div style="float:left;margin:10px auto auto auto\9;">'+gap.authority.Display+' &nbsp;&nbsp;</div><div id="colorchanger" style="margin:10px auto auto auto\9;" ondblclick="jQuery(\'div>ul>li\').bind(\'click\',function(){jQuery(\'#colorValue\').val(jQuery(this).attr(\'class\'));jQuery(this).css(\'border-color\',\'#666699\').siblings().css(\'border-color\',\'#EEE\');});"><ul class="colors"><li class="color-important-urgency"/><li class="color-important"/><li class="color-urgency"/><li class="color-normal"/><li class="color-attention"/></ul></div></div>');
                jQueryHtml.append('<div style="clear:both"></div>');                
                jQuery.prompt(jQueryHtml.html(),{show:'slideDown',buttons: gap.authority.ButtonsThree,callback:function(v,m){
                    if('submit'==v){
                        //jQuery.prompt(v +' ' + m.children('#eventItem').val());
                        calEvent.title = m.children('#eventItem').val();
                        var newClassName = m.children('#colorValue').val().substring(6);// "color-"
                        if(newClassName&&''!=newClassName)
                            calEvent.className = newClassName;
                        calEvent.percent = m.children('#sliderValue').val()+'%';
                    }else if('close'==v){
                        jQuery('#calendar').fullCalendar('removeEvents', calEvent.id);
                        deleteWorkCalendarItem(calEvent);
                    }
                    jQuery('#calendar').fullCalendar('updateEvent', calEvent);                    
                    if('cancel'!=v)
                        updateWorkCalendarItem(calEvent);
                }});
                jQuery('#slider').trigger('ondblclick');
                jQuery('#colorchanger').trigger('ondblclick');
                jQuery(this).css('border', '1px dashed #FF0000');
		    },
		    eventMouseover:function( event, jsEvent, view ) {
		        if('month'==view.name){
			        var openAnchor = this;
			        var customPositionLeft = jQuery('#deleteItem').css('left');
			        var custompositionTop = jQuery('#deleteItem').css('top');
			        jQuery('#deleteItemImage').attr('deleteId',event.id);
			        jQuery.openDOMWindow({ 
				        windowSourceID:'#deleteItem', 
				        height:20,  
				        width:20, 
				        overlay:0, 
				        positionType:'anchoredSingleWindow',  
				        windowPadding:0,  
				        windowBGColor:'#CCFFFF',  
				        borderSize:'0', 
				        anchoredSelector:openAnchor, 
				        positionLeft:parseInt(customPositionLeft), 
				        positionTop:parseInt(custompositionTop)
				    });
			    }
            },
            eventMouseout:function( event, jsEvent, view ) {
                jQuery.doTimeout( 'closeDeleteItem', 2000, function(){
				  jQuery.closeDOMWindow({anchoredClassName:''});
				});
            },
            viewDisplay: function(view) {
		        if('month'!=view.name){
		          jQuery.closeDOMWindow({anchoredClassName:''});
		        }
		    },
		    eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc) {
		        updateWorkCalendarItem(event);
		    },
		    eventResize: function(event,dayDelta,minuteDelta,revertFunc) {
		        updateWorkCalendarItem(event);
		    }
        });
        
    });
    
    function removeItem(){
        var deleteItem = {id:jQuery('#deleteItemImage').attr('deleteId')};
        jQuery('#calendar').fullCalendar('removeEvents', deleteItem.id);        
        deleteWorkCalendarItem(deleteItem);
    }   
    
</script>
</head>
<body>
<div id='wrap'>
<Input id="datepicker" type="image" style='position:relative;z-index: 999;width: 25px;height: 24px;float: left;cursor:hand;' src="<venus:base/>/images/au/chooseCalendar.gif">
<div id='external-events'>
<div id='important-urgency'  class='important-urgency-event'>&nbsp;&nbsp;&nbsp;&nbsp;重要紧急&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div id='important' class='important-event'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;重要&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div id='urgency' class='urgency-event'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;紧急&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div id='normal' class='normal-event'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;普通&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div id='attention' class='attention-event'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;关注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div id='overtime' class='overtime-event'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;超时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<p id='controlarea'>
<input type='checkbox' id='drop-remove'/> <label for='drop-remove' style='color:#336699;font-weight:bold;'>拖拽后移除</label>
<div id='openCloseIdentifier' sytle='display:none'></div>
</p>
</div>
<div id='calendar'></div>
<div style='clear:both'></div>
</div>
<div id='deleteItem' class='closeWorkItem'> 
<img id='deleteItemImage' class='closeDOMWindow' src='<venus:base/>/images/icon/disable.bmp' onclick='javascript:removeItem();'/> 
</div>
</body>
</html>
