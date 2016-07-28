<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.authority.util.GlobalConstants" %>

<html>
    <head>
        <%@ include file="/jsp/include/global.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title><fmt:message key='gap.authority.Error_data_list' bundle='${applicationAuResources}' /></title>
    </head>         
    <%!
        //获得团体类型名称
        public String getPartyName(String partyType) {
            if (GlobalConstants.getPartyType_comp().equals(partyType))
                return venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Company0");
            if (GlobalConstants.getPartyType_dept().equals(partyType))
                return venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Department0");
            if (GlobalConstants.getPartyType_posi().equals(partyType))
                return venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Post");
            if (GlobalConstants.getPartyType_empl().equals(partyType))
                return venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Staff");  
            return venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Other0");
        }
    %>
    <body>
	<script language="javascript">
	    writeTableTop("<fmt:message key='gap.authority.Error_data_list' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	<form name="form" method="post"> 
	<div id="auDivParent0"> 
	<table class="table_div_control">
	    <tr> 
	        <td>
	            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key='gap.authority.Error_data_list' bundle='${applicationAuResources}' />
	        </td>
	    </tr>
	</table>
	</div>	
	<div id="auDivChild0"> 
	<table class="table_div_content2" width="100%" >
	    <tr>
	        <td>
	        <layout:collection name="sysErrorList" id="sysErrorList" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0">
	            <layout:collectionItem width="30" title="" style="text-align:center;">
	               <bean:define id="rmValue" name="sysErrorList" property="id"/>
	                <input type="radio" name="checkbox_template" value="<%=rmValue%>" sequenceValue="<venus:sequence/>"/>
	            </layout:collectionItem>	        
	            <layout:collectionItem width="30"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
	                <venus:sequence/>
	                <bean:define id="id" name="sysErrorList" property="id"/>
	            </layout:collectionItem>
	            <layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Resource_Name") %>' property="source_name" sortable="false"/>
	            <layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Resource_Type") %>' property="source_typeid" sortable="false">
	                <bean:define id="rmValue" name="sysErrorList" property="source_typeid"/>
	               <%=getPartyName((String)rmValue) %>
	            </layout:collectionItem>
	            <layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Operating_time") %>' property="operate_date" sortable="false">
	                <bean:define id="rmValue" name="sysErrorList" property="operate_date"/>
	                <%=StringHelperTools.prt(rmValue, 19)%>	            
	            </layout:collectionItem>
	            <layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Error_reason") %>' property="remark" sortable="false"/>
	        </layout:collection>
	        <!-- 下边这句是翻页, 如果去掉就不带翻页了,同时注意Action中也要调整方法 -->
	        <jsp:include page="/jsp/include/page.jsp" />
	        </td>
	    </tr>
	</table>
	</div>	
	</form>
	<script language="javascript">
	    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	</script>	
    </body>
</html>

