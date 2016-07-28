<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%
String user_id = RmJspHelper.getParty_idFromRequest(request);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.nonnativemedical.nonnativemedical_resource" prefix="nonnativemedical.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title'/></title>
</head>

<body>
<form id="medicalForm" method="post">
<input type="hidden" name="cmd" id="h_cmd"/>
<input type="hidden" name="ids" id="h_ids"/>
<input type="hidden" id="attackAddressInput" name="attach_address"/>
<input type="hidden" id="attachNameInput" name="attachNameInput"/> 
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='title'/></div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
      <div class="search">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="135" rowspan="2" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div></td>
            <td width="80"><fmt:message key='emp_name'/></td>
            <td width="220">
                <input name="emp_name" class="sText" id="emp_name"/>
            </td>
            <td width="80"><fmt:message key='id_card'/></td>
            <td width="220"><input name="id_card" class="sText" id="id_card"/></td>
            <td width="80"><fmt:message key='audit_state'/></td>
            <td width="220"><select class="sSelect" name="audit_state">
                    <option value="" selected><fmt:message key='select_null'/></option> 
                   <option value="0"><fmt:message key='audit_state_0'/></option>
                   <option value="1"><fmt:message key='audit_state_1'/></option>
                   <option value="2"><fmt:message key='audit_state_2'/></option>
                   <option value="3"><fmt:message key='audit_state_3'/></option>
                   <option value="4"><fmt:message key='audit_state_4'/></option>
               </select></td>
            
          </tr>
          <tr>
            

            <td width="80"><fmt:message key='is_revoke'/></td>
            <td width="220">
            <select class="sSelect" name="is_revoke">
                    <option value="" selected><fmt:message key='select_null'/></option> 
                   <option value="0"><fmt:message key='is_0'/></option>
                   <option value="1"><fmt:message key='is_1'/></option>
                  
               </select>
            </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><input onclick="doQuery()" type="button" class="icon_1" value="<fmt:message key='button_search'/>" /></td>
          </tr>
        </table>
      </div>
        <!--查询 end-->
        <!--按钮-->
        <div class="button">
            <div class="button_right">
                <input class="xz" type="button"   value="<fmt:message key='button_downImpTemp'/>"  onClick="downImpTemp();">
                <input class="xz_2" type="button"   value="<fmt:message key='button_downImpTemp2'/>"  onClick="downImpTemp2();">
                <input class="i" type="button"   value="<fmt:message key='imp_title'/>"  <au:authorityBtn code="sqff_viewItem" type="1"/>  onClick="showImportWin(1)">
                <input class="c_3" type="button"   value="<fmt:message key='edit'/>"  <au:authorityBtn code="sqff_sqff_edit_" type="1"/>  onClick="insertMedical()">
                <input class="i" type="button"   value="<fmt:message key='imp_batch'/>"  <au:authorityBtn code="sqff_sqff_imp_batch" type="1"/>  onClick="showImportWin(2)">
                <input class="bl_3" type="button"   value="<fmt:message key='update_win_title'/>"  <au:authorityBtn code="update_win_title" type="1"/>  onClick="updateMedical()">
                <input class="bl_3" type="button"   value="<fmt:message key='reimburse_apply'/>"  <au:authorityBtn code="reimburse_apply" type="1"/>  onClick="updateReimburse()">
                <input class="e_2" type="button"   value="<fmt:message key='reimburse_exp'/>"  <au:authorityBtn code="reimburse_exp" type="1"/>  onClick="reimburseExp()">
                <input class="g_1" type="button"   value="<fmt:message key='audit'/>"  <au:authorityBtn code="sqff_vaudit" type="1"/>  onClick="updateAuditState()">
                <input class="tb_1" type="button"   value="<fmt:message key='reject'/>"  <au:authorityBtn code="sqff_reject" type="1"/>  onClick="reject()">
                <input class="g_1" type="button"   value="<fmt:message key='make_sure'/>"  <au:authorityBtn code="make_sure" type="1"/>  onClick="responseBack()">
                <input class="bl_3" type="button"   value="<fmt:message key='save'/>"  <au:authorityBtn code="sqff_save" type="1"/>  onClick="updateFeedback()">
                <input class="e_2" type="button"   value="<fmt:message key='exp_shenbao'/>"  <au:authorityBtn code="exp_shenbao" type="1"/>  onClick="expReport()">
                <input class="e_2" type="button"   value="<fmt:message key='exp_chexiao'/>"  <au:authorityBtn code="exp_chexiao" type="1"/>  onClick="expCancel()">
                <input class="bl_3" type="button"   value="<fmt:message key='revoke'/>"  <au:authorityBtn code="sqff_revoke" type="1"/>  onClick="revoke()">
            </div>
            <div class="clear"></div>
        </div>
        <!--按钮 end-->
        <!--表格 -->
        <div style="padding: 8 0 8 8;">
        <r:datacell 
              id="dc_medical"
              queryAction="/FAERP/NONNativeMedicalAction.do?cmd=simpleQuery"
              submitAction="/FAERP/NONNativeMedicalAction.do?cmd=updateFeedback"
              width="99%"
              height="304px"
              pageSize="100"
              xpath="NONNativeMedicalVo"
              submitXpath="NONNativeMedicalVo"
              paramFormId="medicalForm"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
                <r:field fieldName="id" 
              label="<input type='checkbox' id='chkbox_all' onclick='chk_all(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox">
              </r:field>
              <r:field fieldName="send_date" messagekey="send_date" >
              </r:field>
               <r:field fieldName="send_cs_name" messagekey="cs" >
              </r:field>
               <r:field fieldName="cust_name" messagekey="cust_name" >
              </r:field>
              <r:field fieldName="emp_code" messagekey="emp_code">
              </r:field>
              <r:field fieldName="emp_name" messagekey="emp_name">
              </r:field>
               <r:field fieldName="id_card" messagekey="id_card" >
              </r:field>
              <r:field fieldName="city" messagekey="city" >
              </r:field>
              <r:field fieldName="audit_state_s" messagekey="audit_state" >
              </r:field>
              <r:field fieldName="reject_cause" messagekey="reject_cause" >
              <h:text property="reject_cause" validateAttr="maxLength:50;"/>
              </r:field>
              <r:field fieldName="is_revoke" messagekey="is_revoke" >
                <h:select name="list_is_revoke" property="list_is_revoke">
                         <h:option value="0" label="否"/>
                         <h:option value="1" label="是"/>
                 </h:select>
              </r:field>
              <r:field fieldName="begin_date_s" messagekey="begin_date" >
              </r:field>
              <r:field fieldName="reimburse" messagekey="reimburse" >
                <h:select name="reimburse" property="reimburse">
                         <h:option value="0" label="住院报销"/>
                         <h:option value="1" label="门诊报销"/>
                 </h:select>
              </r:field>
              <r:field fieldName="tel" messagekey="tel" >
              </r:field>
              <r:field fieldName="zip_code" messagekey="zip_code" >
              </r:field>
              <r:field fieldName="address" messagekey="address" >
              </r:field>
              <r:field fieldName="is_big_hz_area" messagekey="is_big_hz_area" >
              </r:field>
              <r:field fieldName="is_in_province" messagekey="is_in_province"  >
              </r:field>
              <r:field fieldName="feedback" messagekey="feedback" width="150px">
                <h:text property="feedback" validateAttr="maxLength:50;"/>
              </r:field>
              <r:field fieldName="feedback_cause" messagekey="feedback_cause" width="150px">
                <h:text property="feedback_cause" validateAttr="maxLength:50;"/>
              </r:field>
              
        </r:datacell>
        </div>
        <!--表格 end-->
    </div>
</div>
</form>
</body>
<script type="text/javascript">
jQuery(function(){
    $id("dc_medical").isQueryFirst = false;
});
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
    //初始化checkbox时设置是否选中
    return "<input type='checkbox' name='chk_id' value='" + entity.getProperty("id") + "' />";
}
//全选
function chk_all(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox").attr("checked", true);
    } else {
        jQuery(":checkbox").attr("checked", false);
    }
}
//材料审核
function updateAuditState(){
    var ds = $id("dc_medical").dataset;
    var ids = new Array();
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("audit_state");
            
            if(state ==1||state==3 ){
                alert("<fmt:message key='alert_select_status_1'/>");
                ids = "-1";
                return false;
            }
        }
    });
    
    if(ids == "-1"){
        return;
    }
    var len = ids.join();
    if(len == 0){
        alert("<fmt:message key='alert_select_record'/>");
        return;
    }
    if(!confirm("<fmt:message key='alert_is_ff'/>")){
        return;
    }
    
    //alert(ids.join());
    jQuery.post("<%=request.getContextPath()%>/NONNativeMedicalAction.do?cmd=updateAuditState&ids="+ids.join(),function(data){
           if(data > 0){
            alert("<fmt:message key='alert_ff_success'/>");
            $id("dc_medical").reload();
           }
    });
}
//反馈确认
function responseBack(){

    var ds = $id("dc_medical").dataset;
    var ids = new Array();
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("audit_state");
            
            if(!(state ==1||state==4) ){
                alert("<fmt:message key='alert_select_status_2'/>");
                ids = "-1";
                return false;
            }
        }
    });
    
    if(ids == "-1"){
        return;
    }
    var len = ids.join();
    if(len == 0){
        alert("<fmt:message key='alert_select_record'/>");
        return;
    }
    if(!confirm("<fmt:message key='alert_is_ff3'/>")){
        return;
    }
    $id("dc_medical").isModefied=true;
        $id("dc_medical").submitAction="/FAERP/NONNativeMedicalAction.do?cmd=responseBack";
        $id("h_ids").value=len;
        var rst = $id("dc_medical").submit();
        if(rst){
            alert("<fmt:message key='alert_save_success'/>");
        }
    
}
//报销结果
function updateFeedback(){
        $id("dc_medical").submitAction="/FAERP/NONNativeMedicalAction.do?cmd=updateFeedback";
        var rst = $id("dc_medical").submit();
        if(rst){
            alert("<fmt:message key='alert_save_success'/>");
        }
    
}
//撤销
function revoke(){
        $id("dc_medical").submitAction="/FAERP/NONNativeMedicalAction.do?cmd=revoke";
        var rst = $id("dc_medical").submit();
        if(rst){
            alert("<fmt:message key='alert_save_success'/>");
        }
    
}
function updateReimburse(){
        $id("dc_medical").submitAction="/FAERP/NONNativeMedicalAction.do?cmd=updateReimburse";
        var rst = $id("dc_medical").submit();
        if(rst){
            alert("<fmt:message key='alert_save_success'/>");
        }
}
/**
*申报导出
*/
function expReport(){
        $id("medicalForm").action = "<%=request.getContextPath()%>/NONNativeMedicalAction.do";
        $id("h_cmd").value = "expReport";
        $id("medicalForm").submit();
}
/**
*报销表导出
*/
function reimburseExp(){
        $id("medicalForm").action = "<%=request.getContextPath()%>/NONNativeMedicalAction.do";
        $id("h_cmd").value = "reimburseExp";
        $id("medicalForm").submit();
}
/**
*撤销导出
*/
function expCancel(){
        $id("medicalForm").action = "<%=request.getContextPath()%>/NONNativeMedicalAction.do?is_revoke=1";
        $id("h_cmd").value = "expCancel";
        $id("medicalForm").submit();
}
//选择客户
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    //jQuery("#h_customer_id").val(arg[0]);        
    return false;
}
//修改
function updateMedical(){
    var dc = $id("dc_medical");
    var clz = dc.getActiveEntity();
    if(!clz){
        alert("<fmt:message key='alert_select_record'/>");
        return ;
    }
    var batchId = clz.getValue("id");
    var state = clz.getValue("audit_state");
    if(state==1||state==3||state==4){
        alert("<fmt:message key='alert_unupdate'/>");
        return;
    }
    var win_title = "<fmt:message key='update_win_title'/>";
    showModalCenter("<%=request.getContextPath()%>/NONNativeMedicalAction.do?cmd=detail&id=" + batchId,null,doQuery,
                                                                                        800,500,win_title);
}
//查询
function doQuery(){
    $id("dc_medical").reload();
}

var _t = null;
//打开文件上传对话框
function showImportWin(flag){
    //清空路径
    $id("attackAddressInput").value = "";
    //清除Interval
    window.clearInterval(_t);
    
    //w为窗口宽度，h为高度
    var w = 400;
    var h = 150;
    var l = (screen.width - w) / 2;
    var t = (screen.height - h) / 2;
    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
    window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp',"test",s);
    
    if(flag==1){
    //每隔1秒执行函数impRefund
    _t = window.setInterval(impMedical,1000);    
    }else{
    //每隔1秒执行函数impRefund
    _t = window.setInterval(impMedical2,1000);
    }
    
}
//导入回调函数
function impMedical(){
    _path = $id("attackAddressInput").value;
    if(_path){
        showProgressBar();
        jQuery.post("<%=request.getContextPath()%>/NONNativeMedicalAction.do?cmd=importMedicalinfo&attach_address="+_path,function(data){
            hideProgressBar();
            //清除Interval
            window.clearInterval(_t);
            $id("attackAddressInput").value = "";
            alert(data);
            $id("dc_medical").reload();
           //清除Interval
           window.clearInterval(_t);
        });
        //清除Interval
        window.clearInterval(_t);
    }
    
}
//批量导入
function impMedical2(){
    _path = $id("attackAddressInput").value;
    if(_path){
        showProgressBar();
        jQuery.post("<%=request.getContextPath()%>/NONNativeMedicalAction.do?cmd=insertBatch&attach_address="+_path,function(data){
            hideProgressBar();
            //清除Interval
            window.clearInterval(_t);
            $id("attackAddressInput").value = "";
            alert(data);
            $id("dc_medical").reload();
           //清除Interval
           window.clearInterval(_t);
        });
        //清除Interval
        window.clearInterval(_t);
    }
    
}
//申报资料填写
function insertMedical(){
    var n_title = "<fmt:message key='edit'/>";
    showModalCenter("<%=request.getContextPath()%>/jsp/faerp/insurance/nonnativemedical/insertNONNativeMedical.jsp"
                                                        ,null,refresh_datacell,800,350,n_title);                                                                                   
}

function refresh_datacell(){
    $id("dc_medical").reload();
}
//下载退票导入模板
function downImpTemp(){
    $id("h_cmd").value = "downImpTemp";
    $id("medicalForm").action = "<%=request.getContextPath()%>/NONNativeMedicalAction.do" ;
    $id("medicalForm").submit();
}
//下载退票导入模板
function downImpTemp2(){
    $id("h_cmd").value = "downImpTemp2";
    $id("medicalForm").action = "<%=request.getContextPath()%>/NONNativeMedicalAction.do" ;
    $id("medicalForm").submit();
}
//材料驳回
function reject(){
    var ds = $id("dc_medical").dataset;
    ids = new Array();
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
            var entity = ds.findEntity("id",this.value);
            var reject_cause = entity.getValue("reject_cause");
             var state = entity.getValue("audit_state");
            if(state != 0 ){
                alert("<fmt:message key='alert_select_status_0'/>");
                ids = "-1";
                return false;
            }
            if(!reject_cause ){
                alert("<fmt:message key='alert_reject_cause'/>");
                ids = "-1";
                return false;
            }
        }
    });
    
    if(ids == "-1"){
        return;
    }
    len = ids.join();
    if(len == 0){
        alert("<fmt:message key='alert_select_record'/>");
        return;
    }
    if(!confirm("<fmt:message key='alert_is_ff2'/>")){
        return;
    }
    $id("dc_medical").submitAction="/FAERP/NONNativeMedicalAction.do?cmd=reject";
        var rst = $id("dc_medical").submit();
        if(rst){
            alert("<fmt:message key='alert_save_success'/>");
        }
}

</script>
</fmt:bundle>
</html>
