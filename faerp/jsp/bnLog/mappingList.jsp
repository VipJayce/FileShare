<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Map.Entry" %>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<html>
<fmt:bundle basename="gap.bnLog.bnLog_resource" prefix="gap.bnLog.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT language=Javascript> 
    function addType(){
        window.location = "<venus:base/>/jsp/bnLog/mappingEdit.jsp";
    }
    
	function modType() {  //从多选框到修改页面
        var elementCheckbox = document.getElementsByName("checkbox_template");
        var number = 0;
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {
                number += 1;
                ids = elementCheckbox[i].value;
            }
        }
        if(number == 0) {
            alert(i18n.please_choose_a_records_to_modify)
            return;
        }
        if(number > 1) {
            alert(i18n.can_only_choose_a_record_to_modify)
            return;
        }
      form.action = "<venus:base/>/MappingAction.do?cmd=find&key=" + ids;
      form.submit();
  }
  
    function delType(){  //从多选框物理删除多条记录
        var elementCheckbox = document.getElementsByName("checkbox_template");
        var number = 0;
        var ids = "";
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {
                number += 1;
                ids += elementCheckbox[i].value + ",";
            }
        }
        if(ids.length>0) {
            ids = ids.substr(0,ids.length-1);   
        }
        if(number == 0) {
            alert(i18n.please_choose_record_to_delete)
            return;
        }
        if(confirm(i18n.confirm_to_delete_record)) {
            form.action="<venus:base/>/MappingAction.do?cmd=delete&key=" + ids;
            form.submit();
        }
    }
</SCRIPT>
<!--</head>  -->
<body>

<script language="javascript">
	writeTableTop('<fmt:message key="method_mapping_list"/>','<venus:base/>/');
</script>

<form name="form" method="post" id="form" action="<%=request.getContextPath()%>/MappingAction.do?cmd=queryAll">

<div id="ccParent1">
<table class="table_div_control">
<tr>
	<td>
		<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
		<fmt:message key="detail_table"/>
	</td>
	<td> 
		<table align="right">
			<tr> 
				<td nowrap class="button_ellipse" onClick = "javascript:addType();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key="add" bundle="${applicationResources}" /></td>
				<td nowrap class="button_ellipse" onClick = "javascript:delType();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete" bundle="${applicationResources}" /></td>	
				<td nowrap class="button_ellipse" onClick = "javascript:modType();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify" bundle="${applicationResources}" /></td>
			</tr>
		</table>
	</td>
</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content">
    <tr>
        <td>
            <div style="width=100%;overflow-x:visible;overflow-y:visible;">
                <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" class="listCss">
                    <tr>
                    <td valign="top">
                        <table cellspacing="1" cellpadding="1" border="0" width="100%">                      
			                           <tr valign="top">
			                                    <th class="listCss" width="10%"><input type='checkbox' pdType='control' control='checkbox_template'/></th>
                                                <th class="listCss" width="10%"><fmt:message key="sequence" bundle="${applicationResources}" /></th>
			                                    <th class="listCss" width="40%">
						                                    <table border="0" width="100%">
						                                      <tr>
						                                        <th class="listCss" >
						                                            &nbsp;<fmt:message key="full_path_method_name"/>
						                                        </th>
						                                      </tr>
						                                    </table>
			                                    </th>
			                                    <th class="listCss" width="40%">
						                                    <table border="0" width="100%">
						                                      <tr>
						                                        <th class="listCss" >
						                                            &nbsp;<fmt:message key="mapping_name"/>
						                                        </th>
						                                      </tr>
						                                    </table>
			                                    </th>
			                           </tr>
								<%
							    //翻页
							    PageVo pageVo = new PageVo();
							    if(request.getAttribute("VENUS_PAGEVO_KEY") != null) {
							        pageVo = (PageVo) request.getAttribute("VENUS_PAGEVO_KEY");
							    }
							    int currentPage = pageVo.getCurrentPage();
							    int pageSize = pageVo.getPageSize();
							    
								Properties properties = (Properties)request.getAttribute("properties");
								//封装成list 
						        Set<Entry<Object, Object>> set = properties.entrySet();
						        List<Entry<Object, Object>> list = new ArrayList<Entry<Object, Object>>();
						        list.addAll(set);
						        //按照pageSize截取子List
						        if(list.size() != 0 ) {
							        if(currentPage*pageSize <= list.size()) {
							            list = list.subList((currentPage-1)*pageSize,currentPage*pageSize);
							        }else {
							            list = list.subList((currentPage-1)*pageSize,list.size());
							        }
						        } 
						        //定义记录数，即第几个数据。
						        int record =0;
								for(int i=0;i<list.size();i++ ){
								    Map.Entry e = (Map.Entry)list.get(i);
								    record = pageSize*(currentPage-1) + (i+1);
								%>
						           <tr>
						                  <td class="listCss" style="text-align:center;">
						                      <input title="<%=record %>" type="checkbox" name="checkbox_template" value="<%=e.getKey() %>"/>
                                         </td>
                                          <td class="listCss" style="text-align:center;">
                                                <%=record %>
                                                <input type="hidden" signName="hiddenId" value="<%=record %>"/>
                                         </td>
					                     <td class="listCss" style="text-align:center;">
								             <%=e.getKey() %>
							             </td>
							             <td class="listCss" style="text-align:center;">
					                         <%=e.getValue() %>
					                    </td>
						           </tr>
						<%} %>
	                   </table>
                    </td>
                </tr>
                <jsp:include page="/jsp/include/page.jsp" />
            </table>
        </div>
</table>
</div>

<input type="hidden" name="id" value="">
</form>

<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>

</body>
</fmt:bundle>
</html>