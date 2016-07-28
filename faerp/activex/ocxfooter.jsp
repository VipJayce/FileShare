<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<script language="javascript">

    function toSaveAndPublish(whatdo){
        if (form.WF_NAME.value != "" ){
            GraphNFlow.SetProcessProperty("P_name",form.WF_NAME.value);
            GraphNFlow.SetProcessProperty("P_id",form.WF_ID.value);
        }
        else{
            alert(i18n_wf.enter_the_process_name);
            form.WF_NAME.focus();
            return false;
        }
        if ( form.WF_VERSION.value == "" ){
            alert(i18n_wf.enter_the_process_version);
            form.WF_VERSION.focus();
            return false;
        }
        if ( form.WF_DESC.value == "" ){
            alert(i18n_wf.enter_the_process_description);
            form.WF_DESC.focus();
            return false;
        }
        if ( GraphNFlow.CheckFlow() == 'false' ){
            alert(i18n_wf.process_setting_is_error);
            return false;
        }
        if(!window.confirm(i18n_wf.whether_to_save_the_process_definition)){
            return false;
        }
        form.xpdl.value=GraphNFlow.GetFlowXPDL(true,true);
        form.tbl.value=GraphNFlow.GetFlowTBL(true,true);
        form.WF_STATE.value=WF_STATE_NORMAL;
        form.formconfig.value = getChineseXml(GraphNFlow.GetFormConfig(true,true));//formxx.formconfig.value;
        //alert(form.formconfig.value);
        form.action = "<%=request.getContextPath()%>/"+whatdo;
        form.submit();
        return true;
    }
    
    function toSaveFlow(whatdo){
        if (form.WF_NAME.value != "" ){
            GraphNFlow.SetProcessProperty("P_name",form.WF_NAME.value);
            GraphNFlow.SetProcessProperty("P_id",form.WF_ID.value);
        }
        else{
            alert(i18n_wf.enter_the_process_name);
            form.WF_NAME.focus();
            return false;
        }
        if ( form.WF_VERSION.value == "" ){
            alert(i18n_wf.enter_the_process_version);
            form.WF_VERSION.focus();
            return false;
        }
        if ( form.WF_SECTION.value == "" ){
            alert(i18n_wf.enter_the_process_section);
            return false;
        }
        if(!window.confirm(i18n_wf.whether_to_save_the_process_definition_as_a_draft)){
            return false;
        }
        form.xpdl.value=GraphNFlow.GetFlowXPDL(true,true);
        form.tbl.value=GraphNFlow.GetFlowTBL(true,true);
        form.WF_STATE.value=WF_STATE_NEW;
        form.formconfig.value = getChineseXml(GraphNFlow.GetFormConfig(true,true));//formxx.formconfig.value;
        //alert(form.formconfig.value);
        form.action = "<%=request.getContextPath()%>/"+whatdo;
        form.submit();
        return true;
    }
    
    function getChineseXml(xmlStr){
        var signal = "xml version=\"1.0\"";
        var signaln = "encoding=\"gb2312\"";
        var pos = xmlStr.indexOf(signal);
        var posn = xmlStr.indexOf(signaln);
        
        if(pos!=-1 && posn==-1){
            return xmlStr.replace(signal,signal + " " + signaln);
        }
        else{
            return xmlStr;
        }
    }
    
    function alexanderHideshow(div1,div2){
        hideshow(div1,this,"<%=request.getContextPath()%>");
        hideshow(div2,this,"<%=request.getContextPath()%>");
    }

    function BrowseFormEvent(){
        //alert("BrowseFormEvent");
        var appname = "<%=request.getContextPath()%>";
        var xrefo = GraphNFlow.getXRef();
        var xref = xrefo;

        if (xref!=null && xref!="" && xref.length>0)
        {
            if(xref.toLowerCase().indexOf("sdtp://")==0){
                xref="<%=request.getContextPath()%>/viewDocumentAction.do";
            }
            else if(xref.indexOf("workflowForm")==-1 && xref.toLowerCase().indexOf("http://")!=0)
            {
                xref=null;
            }
            else if(xref.toLowerCase().indexOf("http://")==0){
                xref=xref;
            }
            else if(xref.substr(0,1)!="/"){
                xref="/"+xref;
            }
        }
        else{
            xref=null;
        }
    
        if(xref==null){
            alert(i18n_wf.form_address_is_non_self_definition);
        }
        else{
            if (xref.indexOf("?") == -1){
                xref = xref + "?browse=yes&xref="+xrefo;
            } else{
                xref = xref + "&browse=yes&xref="+xrefo;
            }
            if (xref.indexOf(appname + "/") != 0 && xref.toLowerCase().indexOf("http://")!=0){
                xref = appname + xref;
            }
            var obj =
                window.showModalDialog(xref,window,"dialogHeight:500px; dialogWidth:600px;"
                    +"center:yes; help:no; resizable:no; scroll:yes; status:no;");
        }
    }
</script>

<script for="GraphNFlow" event="KeyPress()">
    //alert("KeyPress");
    var sosfile="C:/testfilesos.xml";
    try{
        window.open(sosfile);
    }
    catch(e){
        alert(i18n_wf.browser_security_settings_too_high(sosfile));
    }
</script>

<script>
function VBMonitorSubFlowEvent(){
    //alert(GraphNFlow.GetMonitorSubFlowID());
    toMonitorInst(GraphNFlow.GetMonitorSubFlowID());
}
</script>

<script>
function VBSelectForm4FlowFormEvent(){
    //Public Function SetFlowWebFormText(xref As String)
    var obj = window.showModalDialog("<%=request.getContextPath()%>/formDesignList.do?subwindow=true&isflow=true",GraphNFlow,"dialogHeight:500px; dialogWidth:600px;"
                +"center:yes; help:no; resizable:no; scroll:yes; status:no;");
}
</script>

<script>
function VBSelectFormEvent(){
    //Public Function SetActionWebFormText(xref As String)
    var obj = window.showModalDialog("<%=request.getContextPath()%>/formDesignList.do?subwindow=true",GraphNFlow,"dialogHeight:500px; dialogWidth:600px;"
                +"center:yes; help:no; resizable:no; scroll:yes; status:no;");
}
</script>
<SCRIPT LANGUAGE="VBScript">
<!--
Public Sub GraphNFlow_SelectFormEvent ( )
    VBSelectFormEvent()
End Sub
-->
</SCRIPT>
<SCRIPT LANGUAGE="VBScript">
<!--
Public Sub GraphNFlow_SelectForm4FlowFormEvent ( )
    VBSelectForm4FlowFormEvent()
End Sub
-->
</SCRIPT>
<SCRIPT LANGUAGE="VBScript">
<!--
Public Sub GraphNFlow_MonitorSubFlowEvent ( )
    VBMonitorSubFlowEvent()
End Sub
-->
</SCRIPT>
<SCRIPT LANGUAGE="VBScript">
<!--
Public Sub GraphNFlow_BrowseFormEvent ( )
    BrowseFormEvent()
End Sub
-->
</SCRIPT>
<SCRIPT LANGUAGE="VBScript">
<!--
Public Sub GraphNFlow_Click ( )
    BrowseFormEvent()
End Sub
-->
</SCRIPT>
