<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<style type="text/css">
.eos-time-container div{padding-left:0px!important;}
</style>
<html>
<fmt:bundle
    basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh"
    prefix="rayoo.certificate.certificateTransaction.">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <title><fmt:message key="outworkerReg" /></title>
    <script language="javascript">
    //选择框后续处理方法
    function rtnFunc(arg){
        var lookup = $id("backUpPersonID");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#companyNumber").text(arg[1]);
        return false;
    }
    //公共校验
    function vailFormCommon()
    {
    
        var dateFrom =$id("create_date_from").value;
        var dateTo =$id("create_date_to").value;
      if(dateFrom==null || dateFrom==""){
          alert("请选择外出起始日期");
          return false;
        }
        if(dateTo==null || dateTo==""){
          alert("请选择外出截止日期");
          return false;
        }
        dateFrom = dateFrom.replace(/-/g, "/");  
        dateTo = dateTo.replace(/-/g, "/");   
        dateFrom=new Date(Date.parse(dateFrom));
        dateFrom.setSeconds(0);
        dateTo=new Date(Date.parse(dateTo));
        dateTo.setSeconds(0);
         if(dateTo<=dateFrom){
        alert("起始日期不能大于截至日期");
         return false;
        }
       return true;
    }
    
    //校验
    function vailform(){
     var  code = jQuery("#edit_id").val();
      if(!vailFormCommon())
             {
               return;
             }
            jQuery.ajax({
                           url: '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataOutReg&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize()),true),
                           type: 'POST',
                           dataType: 'html',
                           async: false,
                           timeout: 10000,
                                success: function(data){
                                 data=eval("("+data+")");
                                    if(data.status=='true')
                                   {
                                        save_onClick();
                                      }
                                   else
                                   {
                                     alert("与已知外出时间段重叠");
                                   }
                               }
                           });        
    }
    //保存
    function save_onClick(){  //保存
            var  code = jQuery("#edit_id").val();
            var url;
            if(code){
                  url= '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=updateOutReg&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true));
            }
            else
            {
                   url= '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=insertOutReg&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true));
            }
                jQuery.ajax({
                           url:url,
                           type: 'POST',
                           dataType: 'html',
                           async: false,
                           timeout: 10000,
                                success: function(data){ 
                                    data=eval("("+data+")");
                                    if(data.status=='true'){
                                            returnValue = ["0"];
                                            window.close();
                                            window.opener.insertcallBack(returnValue);
                                   }
                                   else{
                                               returnValue = ["2"];
                                               window.close();
                                               window.opener.insertcallBack(returnValue);
                                   }
                               }
                           });      
    }
    
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
   </script>
    </head>
    <body>
    <form name="form" method="post" id="datacell_formid"><input
        type="hidden" name="id" id="edit_id" value="${bean.id}"> <input
        type="hidden" name="statusCellValues" id="statusCellValues"> <input
        type="hidden" name="materiaCellValues" id="materiaCellValues">
        <input type="hidden" name="outworkerID" value="${bean.outworkerID}"/>
    <div id="right" style="height: 140px;"><script
        language="javascript">
        writeTableTopFesco("<fmt:message key='outworkerReg'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
    session = request.getSession(false);
    String name = LoginHelper.getLoginName(request);//获得用户姓名
     rayoo.certificate.certificateTransaction.vo.OutRegVo beanVo = (rayoo.certificate.certificateTransaction.vo.OutRegVo ) request.getAttribute("bean");
 %>
    <div class="ringht_x" style="height: 150px;">
    <div id="ccChild1" class="box_xinzeng" style="height: 150px;">
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="30%"><span class="style_required_red">*</span><fmt:message key='outworker' /></td>
            <td class="td_2 " colspan="70">
                <%=beanVo==null?name :beanVo.getOutworkerName()%>
            </td>
        </tr>
        <tr>
             <td class="td_1" width="30%"><span class="style_required_red">*</span><fmt:message key='outTimeRange' /></td>
          <td class="td_2 " colspan="70">
            <w:date format="yyyy-MM-dd HH:mm:ss"   name="createDateFrom" id="create_date_from" style="width: 125px;" size="6" property="bean/createDateFrom" allowInput="false" />&nbsp;&nbsp;至&nbsp;&nbsp;<w:date format="yyyy-MM-dd HH:mm:ss" name="createDateTo" id="create_date_to" width="125px" size="6" property="bean/createDateTo" allowInput="false" />
          </td>
        </tr>
        <tr>
             <td class="td_1" width="30%"></td>
           <td class="td_2 " colspan="70">
                      </td>
        </tr>
    </table>
    </div>
    <div></div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
    <input type="button" class="icon_2" value='<fmt:message key="save"/>'
        onClick="javascript:vailform()" /> <input type="button"
        class="icon_2" value='<fmt:message key="go_back"/>'
        onClick="javascript:cancel_onClick()" /></div>
    </form>
</fmt:bundle>
</body>
</html>
