<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.util.List"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<%@ include file="/jsp/include/global.jsp" %>

<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="fck"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
    <fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
    <head>
        <title><fmt:message key="form_design"/></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Expires" CONTENT="0">
        <meta http-equiv="Cache-Control" CONTENT="no-cache">
        <meta http-equiv="Pragma" CONTENT="no-cache">
        <link href="<%=request.getContextPath()%>/css/formDesigner.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/components/FCKeditor/fckeditor.js"></script>
        <script language="javascript">
        <!--
        //导出表单对话框
        function exportFile() {
            window.open('jsp/formdesign/exportFile.jsp', 'exportWindow', 'height=180, width=340, top=0, left=0, toolbar=no, menubar=no, scrollbars=no,resizable=no,location=no, status=no');
        }

        //导入表单对话框
        function importFile() {
            window.open('jsp/formdesign/importFile.jsp', 'importWindow', 'height=180, width=340, top=0, left=0, toolbar=no, menubar=no, scrollbars=no,resizable=no,location=no, status=no');
        }

        //不能为空、中文或者特殊字符
        function isValidateName(param) {
            var reg = /^\w+$/;
            if (reg.test(param.value)) {
                return true;
            } else {
                return false;
            }
        }

        //不能包含<html><head><body></html></head></body>
        function isErrorHTML(param) {
            var reg = /.*(\<html\>+|\<head\>+|\<body\>+|\<\/html\>+|\<\/head\>+|\<\/body\>+).*/g;

            if (reg.test(param)) {
                return true;
            } else {
                return false;
            }
        }

        //检查是否包含按钮
        function isContainedButton(param) {
            var reg = /input id="commitAlexander"/i;
            if (param.search(reg) != -1) {
                return true;
            } else {
                return false;
            }
        }

        //检查表单名称是否合法
        function isValidateForm(param) {
            var reg = /\<form\s+method="post"\s+name="formAlexander"\>/i;
            if (param.search(reg) != -1) {
                return true;
            } else {
                return false;
            }
        }

        //提交表单
        function submitForm(form) {
            var txtName = form.name;
            var oEditor = FCKeditorAPI.GetInstance('content');
            var texContent = oEditor.GetXHTML( true );

            if (!isValidateName(txtName)) {
                alert(i18n_wf.form_name_error);
                txtName.focus();
            } else if (isErrorHTML(texContent)) {
                alert(i18n_wf.form_label_error);
            } else if (!isContainedButton(texContent)) {
                alert(i18n_wf.form_must_contain_submit);
            } else if (!isValidateForm(texContent)) {
                alert(i18n_wf.process_form_error);
            } else if (confirm(i18n_wf.confirm_to_save_the_form)) {
                //修正bug: 导出表单的时候修改了该控件值，提交时候需要修正回来
                if (form.cmd.value == "exportFile") {
                    form.cmd.value = "update";
                }
                form.submit();
            }
        }
        //-->
        </script>
    </head>
    <body>
        <h3><fmt:message key="form_design"/></h3>
        <form name="frmDesigner" action="formDesign.do" method="post">
            <input type="hidden" name="txtFileName" />
            <logic:present name="typeId">
                <input type="hidden" name="typeId" value='<%=request.getParameter("typeId")%>'>
            </logic:present>
            <logic:notPresent name="typeId">
                <input type="hidden" name="typeId"/>    
            </logic:notPresent>

            <logic:present name="formDesignVo" property="id">
                <input type="hidden" name="cmd" value="update"/>
                <input type="hidden" name="id" value='<bean:write name="formDesignVo" property="id"/>'/>
            </logic:present>
            <logic:notPresent name="formDesignVo" property="id">
                <input type="hidden" name="cmd" value="insert"/>
                <input type="hidden" name="id"/>
            </logic:notPresent>

            <fck:editor id="content" basePath="components/FCKeditor/" customConfigurationsPath="../../../js/gap-formDesigner.js" toolbarSet="workflow" height="468px">
                <logic:present name="formDesignVo">
                    <bean:write name="formDesignVo" property="content" filter="false"/>
                </logic:present>
                <logic:notPresent name="formDesignVo">
<script language="javascript">
<!--
function wfFormOnLoad() {
    //TODO 表单载入时执行的脚本
}

function wfFormOnSubmit() {
    //TODO 表单提交前执行的脚本
}
//-->
</script>
<font color="red"><fmt:message key="form_design_note"/></font>
                </logic:notPresent>
            </fck:editor>
            <br />
            <table width="100%" border="0" cellspacing="0" bordercolor="#CCCCCC">
                <tr>
                    <td valign="bottom"><fmt:message key="form_type"/>：
                        <%
                        String param = request.getParameter("style");
                        if (param == null || request.getAttribute("error.input.name.existed") != null) {
                        %>
                        <select name="style" id="style">
                            <%
                                EnumRepository er = EnumRepository.getInstance();
                                er.loadFromDir();
                                EnumValueMap styleMap = er.getEnumValueMap("Style");
                                List al = styleMap.getEnumList();
                                for(int i=0;i<al.size();i++){%>
                            <option value="<%=styleMap.getValue(al.get(i).toString())%>"><%=al.get(i)%></option>
                             <%}%>
                        </select>
                        <%
                        } else {
                            String str =java.net.URLDecoder.decode(param,"GBK");
                            out.println(str);
                            out.println("<input type='hidden' name='style' value='"+ str + "'/>");
                        }
                        %>                </td>
                    <td valign="bottom"><fmt:message key="form_name"/>：
                        <logic:present name="formDesignVo">
                            <input type="text" name="name" value='<bean:write name="formDesignVo" property="name"/>' style="ime-mode:disabled" class="text_field"/>
                        </logic:present>
                        <logic:notPresent name="formDesignVo">
                            <input type="text" name="name" style="ime-mode:disabled" class="text_field"/>
                        </logic:notPresent>
                    </td>
                    <td valign="bottom"><fmt:message key="form_describe"/>：
                        <logic:present name="formDesignVo">
                            <input type="text" name="remark" value='<bean:write name="formDesignVo" property="remark"/>' class="text_field"/>
                        </logic:present>
                        <logic:notPresent name="formDesignVo">
                            <input type="text" name="remark" class="text_field"/>
                        </logic:notPresent>
                    </td>
                    <td valign="bottom">
                        <input type="button" value='<fmt:message key="save" bundle="${applicationResources}"/>' onclick="javascript:submitForm(this.form);" class="button_ellipse"/>
                    </td>
                    <td align="right" valign="bottom">
                        <input type="button" value='<fmt:message key="import_form"/>' title='<fmt:message key="import_form"/>' onclick="javascript:importFile();" class="button_ellipse" />
                        <input type="button" value='<fmt:message key="export_form"/>' title='<fmt:message key="export_form"/>' onclick="javascript:exportFile();" class="button_ellipse"/>
                    </td>
                </tr>
          </table>
        </form>
    </body>
    </fmt:bundle>
</html>

<%if (request.getAttribute("error.input.name.existed") != null) {%>
<script language="javascript">

//see extendFormFoot.jsp
function committask(){
    return;
}

//see extendFormFoot.jsp
function rollback(){
    return;
}

<!--
alert('<%=request.getAttribute("error.input.name.existed")%>');
//-->
</script>
<%}%>

<script language="javascript">
function assignSelected(sel,val) {
    for (i = 0; i < sel.options.length; i++) {
        if (sel.options[i].text == val) {
            sel.options[i].selected = "true";
        }
    }
}
<logic:present name="formDesignVo" property="style">
    assignSelected(document.getElementById("style"), "<bean:write name="formDesignVo" property="style"/>");
</logic:present>
</script>