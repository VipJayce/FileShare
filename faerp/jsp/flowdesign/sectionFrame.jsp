<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.apache.commons.lang.StringUtils"%>
<html>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<head>
<%
     boolean is4Query = false,is4Edit = false;
     if(!StringUtils.isEmpty(request.getParameter("is4Query")))
         is4Query = true;
     if(!StringUtils.isEmpty(request.getParameter("is4Edit")))
         is4Edit = true;
     
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="flow_section_tree" /></title>
    <!--提示框，选择框，确认框控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-simple.tree.js"></script>

	<style>
	   
	   .button_ellipse4this {
		    border:1px solid #4999d8;
		    font-size:12px;
		    color:#082a45;
		    cursor: hand; 
		    padding-left: 5px; 
		    padding-right: 5px;
		    padding-bottom:0px; 
		    height: 22px;
		    background-image:url("<%=request.getContextPath()%>/images/templatestyle/btnbg.jpg");
		    background-position:left bottom;
		    background-repeat:repeat-x;
		    background-color:#ffffff;
        }
	       
		body
		{
		    font: normal 12px arial, tahoma, helvetica, sans-serif;
		    margin:0;
		}
		.simpleTree
		{
		    
		    margin:0;
		    padding:0;
		    /*
		    overflow:auto;
		    width: 250px;
		    height:350px;
		    overflow:auto;
		    border: 1px solid #444444;
		    */
		}
		.simpleTree li
		{
		    list-style: none;
		    margin:0;
		    padding:0 0 0 34px;
		    line-height: 14px;
		}
		.simpleTree li span
		{
		    display:inline;
		    clear: left;
		    white-space: nowrap;
		}
		.simpleTree ul
		{
		    margin:0; 
		    padding:0;
		}
		.simpleTree .root
		{
		    margin-left:-16px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/root.gif) no-repeat 16px 0 #ffffff;
		}
		.simpleTree .line
		{
		    margin:0 0 0 -16px;
		    padding:0;
		    line-height: 3px;
		    height:3px;
		    font-size:3px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/line_bg.gif) 0 0 no-repeat transparent;
		}
		.simpleTree .line-last
		{
		    margin:0 0 0 -16px;
		    padding:0;
		    line-height: 3px;
		    height:3px;
		    font-size:3px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/spacer.gif) 0 0 no-repeat transparent;
		}
		.simpleTree .line-over
		{
		    margin:0 0 0 -16px;
		    padding:0;
		    line-height: 3px;
		    height:3px;
		    font-size:3px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/line_bg_over.gif) 0 0 no-repeat transparent;
		}
		.simpleTree .line-over-last
		{
		    margin:0 0 0 -16px;
		    padding:0;
		    line-height: 3px;
		    height:3px;
		    font-size:3px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/line_bg_over_last.gif) 0 0 no-repeat transparent;
		}
		.simpleTree .folder-open
		{
		    margin-left:-16px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/collapsable.gif) 0 -2px no-repeat #fff;
		}
		.simpleTree .folder-open-last
		{
		    margin-left:-16px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/collapsable-last.gif) 0 -2px no-repeat #fff;
		}
		.simpleTree .folder-close
		{
		    margin-left:-16px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/expandable.gif) 0 -2px no-repeat #fff;
		}
		.simpleTree .folder-close-last
		{
		    margin-left:-16px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/expandable-last.gif) 0 -2px no-repeat #fff;
		}
		.simpleTree .doc
		{
		    margin-left:-16px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/leaf.gif) 0 -1px no-repeat #fff;
		}
		.simpleTree .doc-last
		{
		    margin-left:-16px;
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/leaf-last.gif) 0 -1px no-repeat #fff;
		}
		.simpleTree .ajax
		{
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/spinner.gif) no-repeat 0 0 #ffffff;
		    height: 16px;
		    display:none;
		}
		.simpleTree .ajax li
		{
		    display:none;
		    margin:0; 
		    padding:0;
		}
		.simpleTree .trigger
		{
		    display:inline;
		    margin-left:-32px;
		    width: 28px;
		    height: 11px;
		    cursor:pointer;
		}
		.simpleTree .text
		{
		    cursor: default;
		}
		.simpleTree .active
		{
		    cursor: default;
		    background-color:#F7BE77;
		    padding:0px 2px;
		    border: 1px dashed #444;
		}
		#drag_container
		{
		    background:#ffffff;
		    color:#000;
		    font: normal 11px arial, tahoma, helvetica, sans-serif;
		    border: 1px dashed #767676;
		}
		#drag_container ul
		{
		    list-style: none;
		    padding:0;
		    margin:0;
		}
		
		#drag_container li
		{
		    list-style: none;
		    background-color:#ffffff;
		    line-height:18px;
		    white-space: nowrap;
		    padding:1px 1px 0px 16px;
		    margin:0;
		}
		#drag_container li span
		{
		    padding:0;
		}
		
		#drag_container li.doc, #drag_container li.doc-last
		{
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/leaf.gif) no-repeat -17px 0 #ffffff;
		}
		#drag_container .folder-close, #drag_container .folder-close-last
		{
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/expandable.gif) no-repeat -17px 0 #ffffff;
		}
		
		#drag_container .folder-open, #drag_container .folder-open-last
		{
		    background: url(<%=request.getContextPath()%>/images/ajaxList/tree/collapsable.gif) no-repeat -17px 0 #ffffff;
		}
		
		.righclickdiv{
			  border-left: '1px dotted black';
			  border-right: '1px dotted black';
			  border-top: '1px dotted black';
			  width: 50px;
		}
		.righclickdiv td{
		  border-bottom: 1px dotted black;
		  height: 20px;
		  text-align: center;
		  cursor: pointer;
		}
	</style>
	<script type="text/javascript">
	       var currentNode;
	       var simpleTree;
	       var is4Edit = <%=is4Edit%>;
	       var is4Query = <%=is4Query%>;
	       function returnSection(node){
	           if("root"==node.attr("id") || is4Edit) return false;
	           if(jQuery(node).find(".text_field").size()>0){
                   alert('<fmt:message key="pls_save_change" />');
                   return false;
               }
	           var span = node.children("span");
	           var returnArray = new Array();
	           if("0"==node.attr("available")&&(!is4Query)){
	               alert(span.html()+'<fmt:message key="cannot_be_section" />');
	               return false;
	           }
		        returnArray["id"] = node.attr("id");
		        returnArray["name"] = span.html();
		        returnArray["cascade_code"] = node.attr("cascade_code");
		        window.returnValue = returnArray;
		        window.close();
	       }
	       
	       function afterClick(node){
	           if(!is4Edit) return false;//如果不允许修改....
	           currentNode = node;
	           var id = jQuery(currentNode).attr("id");
	           if("root"==id){
	               jQuery(".text_field",jQuery("#edittable")).attr({id:"",parent_id:"root",cascade_code:""}).val("");
	               jQuery(".availableSelect",jQuery("#edittable")).val("1");
	               return false;
               }
               var parent_id= jQuery(currentNode).parent().parent().attr("id");
               var inputValue = jQuery(">span",currentNode).html();
               var cascade_code= jQuery(currentNode).attr("cascade_code");
               var available = jQuery(currentNode).attr("available");
                jQuery(".text_field",jQuery("#edittable")).attr({id:id,parent_id:parent_id,cascade_code:cascade_code}).val(inputValue).focus();
                jQuery(".availableSelect",jQuery("#edittable")).val(available);
                jQuery(".button_ellipse4this").removeAttr("disabled");
	       }
	   
	       function saveSection(){
	           var sectionInput = jQuery(".text_field",jQuery("#edittable"));
	           var id = sectionInput.attr("id");
	           var parent_id = sectionInput.attr("parent_id");
	           var name = sectionInput.val();
	           if(!name||jQuery.trim(name)==""){
	               alert('<fmt:message key="pls_enter_section_name" />');
	               return false;
	           }
	           var available = jQuery(".availableSelect",jQuery("#edittable")).val();
	           var cascade_code = sectionInput.attr("cascade_code");
	           var cmd = "insert";
	           if(id&&id!="") cmd = "update";
	           var queryStr = "?cmd=" +cmd;
	           var data = {cascade_code:cascade_code,id:id,name:name,parent_id:parent_id,available:available};
	           jQuery.post("<venus:base/>/FlowSectionAction.do"+queryStr,data,function(data){
	               alert('<fmt:message key="submit_success" />');
	               if(cmd=="update"){
	                   jQuery(">span",currentNode).html(name);
	                   jQuery(currentNode).attr("available",available);
	                }else{
	                 //  if("folder-open"==currentNode.attr("class")){
	                 
	                       simpleTree.delCache(currentNode.get(0));
	                       currentNode.find(">ul").attr("class","ajax").empty().append("<li>{url:<venus:base/>/FlowSectionAction.do?cmd=findChild&parent_id="+ currentNode.attr("id") +"}</li>");
	                       reloadNode(currentNode.get(0));
	                       jQuery(".text_field",jQuery("#edittable")).val(""); 
	                   //}
	                }
	           });
	       }
	       reloadNode = function(obj,callback){
                var childUl = $('>ul',obj);
                
                if(simpleTree.option.animate)
                {
                    childUl.animate({height:"toggle"},simpleTree.option.speed, function(){
                        if(simpleTree.option.autoclose)simpleTree.closeNearby(obj);
                        if(childUl.is('.ajax'))     getChildNode(childUl);
                    });
                }else{
                    childUl.show();
                    if(simpleTree.option.autoclose)simpleTree.closeNearby(obj);
                    if(childUl.is('.ajax'))     getChildNode(childUl);
                }
            }
	    
	    function getChildNode(node){
	           var url = jQuery.trim(jQuery('>li', node).text());
	           if(url && url.indexOf('url:'))
                {
                    url=jQuery.trim(url.replace(/.*\{url:(.*)\}/i ,'$1'));
                    jQuery.ajax({
                        type: "GET",
                        url: url,
                        contentType:'html',
                        cache:false,
                        success: function(responce){
                            node.removeAttr('class');
                            node.html(responce);
                            jQuery.extend(node,{url:url});
                            simpleTree.setTreeNodes(node, true);
                            if(typeof simpleTree.option.afterAjax == 'function')
                            {
                                simpleTree.option.afterAjax(node);
                            }
                            if(typeof callback == 'function')
                            {
                                callback(node);
                            }
                        }
                    });
                }
	    }
	    
	       function resetEditTable(){
	               var parent_id =  jQuery(".text_field",jQuery("#edittable")).attr("id");
	               if("root"==jQuery(".text_field",jQuery("#edittable")).attr("id"))
	                       parent_id = "root";
	               jQuery(".text_field",jQuery("#edittable")).attr({id:"",parent_id:parent_id,cascade_code:""}).val("").focus();
                    jQuery(".availableSelect",jQuery("#edittable")).val("1");
                    document.getElementById("add").disabled="disabled";
	       }
	       jQuery(function(){
	               jQuery("#rootUl").load("<venus:base/>/FlowSectionAction.do?cmd=findChild&parent_id=root",function(){
			                   simpleTree = jQuery('.simpleTree').simpleTree({
			                         drag:false,
			                        autoclose: false,
			                        afterDblClick:returnSection,
			                        afterClick:afterClick
		                  });
		                  
		                  
	               });
	               if(!is4Edit){
	                   jQuery(".button_ellipse4this").css("visibility","hidden");
	                   jQuery("#edittable").css("visibility","hidden");
	                   jQuery(".simpleTree").attr("width","100%")
	               }
	       });
	         
	writeTableTop('<fmt:message key="pls_select_flow_section"/>','<venus:base/>/');
	</script>
</head>
<body >
    <table class="table_div_content" >
        <tr valign="top">
            <td class="simpleTree" width="60%">
                 <ul >
                    <li id="root" class="open" style="background: url(<%=request.getContextPath()%>/images/ajaxList/tree/root.gif) no-repeat 16px 0 #ffffff;"><span><fmt:message key="flow_section"/></span>
                        <ul id="rootUl">
                        </ul>
                    </li>
                </ul>
            </td>
            <td align="right"><br>
                    <input value='<fmt:message key="add" bundle="${applicationResources}"/>'  id="add" type="button" class="button_ellipse4this" onclick="resetEditTable()" disabled="disabled">
                    <input value='<fmt:message key="save" bundle="${applicationResources}"/>' type="button" class="button_ellipse4this" onclick="saveSection(event)" ><br><br>
                    <table id="edittable" class="viewlistCss" width="80%">
	                   <tr>
	                       <th colspan="2" align="center"><fmt:message key="section_detail"/></th>
	                  </tr>
	                  <tr>
	                       <th align="right"><fmt:message key="section_name"/>:</th>
	                       <td><input class='text_field' type='text' parent_id='' id='' cascade_code=''/> </td>
	                  </tr>
	                  <tr>
	                       <th align="right"><fmt:message key="use_available"/>:</th>
	                       <td>
	                           <select class='availableSelect' name='available' >
	                               <option value='1'><fmt:message key='available'/></option>
	                               <option value='0'><fmt:message key='unavailable'/></option>
	                           </select>
	                       </td>
	                  </tr>
	                </table>
            </td>
        </tr>
      </table>

</body>
</fmt:bundle>
</html>