<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.alexander.flowdesign.vo.FlowSectionVo"%>
<logic:equal value="findChild" parameter="cmd">
	   <logic:iterate id="section" name="result">
	        <li id="${section.id}" available="${section.available }" cascade_code="<%=((FlowSectionVo)section).getCascade_code() %>"><span>${section.name}</span>
	            <ul class="ajax">
	                <li >{url:<venus:base/>/FlowSectionAction.do?cmd=findChild&parent_id=${section.id}}</li>
	                
	            </ul>
	        </li>
	   </logic:iterate>
</logic:equal>

<logic:equal value="update" parameter="cmd">
        <li id="${result.id}" available="${result.available }" cascade_code="<%=((FlowSectionVo)request.getAttribute("result")).getCascade_code() %>"><span>${result.name}</span>
            <ul class="ajax">
                <li >{url:<venus:base/>/FlowSectionAction.do?cmd=findChild&parent_id=${result.id}}</li>
            </ul>
        </li>
</logic:equal>

<logic:equal value="insert" parameter="cmd">
        <li id="${result.id}" available="${result.available }" cascade_code="<%=((FlowSectionVo)request.getAttribute("result")).getCascade_code() %>"><span>${result.name}</span>
            <ul class="ajax">
                <li >{url:<venus:base/>/FlowSectionAction.do?cmd=findChild&parent_id=${result.id}}</li>
            </ul>
        </li>
</logic:equal>