<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.ibd.ibdcredentialstep.ibdcredentialstep_resource" prefix="rayoo.ibd.ibdcredentialstep.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>codegen</title>
  <script language="javascript">
    function insert_onClick(){  //插入单条数据
        var param = jQuery("#datacell_formid").serialize();
        var id = jQuery("#id").val();
        var credentials_id = jQuery("#credentials_id").val();
        var previous_step = jQuery("#previous_step").val();
        if (!credentials_id){
            alert("请选择当前证件名称！");
            return false;
        }
        
        if (!previous_step){
            alert("请选择前置证件名称！");
            return false;
        }
        
        if(credentials_id == previous_step){
            alert("不能选择两个同样的证件名称！");
            return false;
        }
        
        var url = "";
        if (id){
            url="<%=request.getContextPath()%>/IbdCredentialStepAction.do?cmd=update&"+param;
        }else{
	        url="<%=request.getContextPath()%>/IbdCredentialStepAction.do?cmd=insert&"+param;
        }
        jQuery.post(url,function(msg){
            if(msg==""){
                alert("保存成功！");
                window.close();
            }else{
                alert(msg);
                return;
            }
        });
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
</script>
  </head>
  <body>
  <form name="form" method="post" id="datacell_formid">
    <input type="hidden" id="id" name="id" value="${bean.id }">
    <div id="right">
      <div class="ringht">
        <div id="ccChild1"     class="box_xinzeng"  style="height: 120px">
          <table  width="100%" height="50" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
            <tr>
              <td class="td_1"><span class="style_required_red">* </span>前置证件</td>
              <td align="left" class="td_2"><w:lookup id="p_credentials"  name="previous_name" readonly="true"
                 lookupUrl="/FAERP/IbdCredentialStepAction.do?cmd=getSelectCredentialPage&flag" style="width:250px" dialogTitle="选择证件"
                 height="450" width="610" displayValue="${bean.previous_name }"  value="${bean.previous_name }" 
                > </w:lookup>
                <input type="hidden" id="previous_step" name="previous_step" value="${bean.previous_step }">
              </td>
            </tr>
            <tr>
              <td class="td_1" ><span class="style_required_red">* </span>当前证件</td>
              <td align="left" class="td_2"><w:lookup id="n_credentials"  name="credentials_name" readonly="true"
            lookupUrl="/FAERP/IbdCredentialStepAction.do?cmd=getSelectCredentialPage&flag" style="width:250px"
            dialogTitle="选择证件" height="450" width="610" displayValue="${bean.credentials_name }" value="${bean.credentials_name }"/>
            <input type="hidden" id="credentials_id" name="credentials_id" value="${bean.credentials_id }">
              </td>
            </tr>
            <tr>
              <td class="td_1">备注</td>
              <td class="td_2"><textarea class="xText_d" onkeydown="checklength(this);" rows="2" name="remark" inputName="备注" style="width: 96%">${bean.remark }</textarea></td>
            </tr>
          </table>
        </div>
        <div class="foot_button" >
          <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()" />
          <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
      </div>
    </div>
  </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<script language="javascript">
$id("n_credentials").onReturnFunc = function (returnValue){
    var lookup = $id("n_credentials");
    lookup.value = returnValue[1];
    lookup.displayValue = returnValue[1];
    jQuery("#credentials_id").val(returnValue[0]);
    return false;
}

$id("p_credentials").onReturnFunc = function (returnValue){
    var lookup = $id("p_credentials");
    lookup.value = returnValue[1];
    lookup.displayValue = returnValue[1];
    jQuery("#previous_step").val(returnValue[0]);
    return false;
}
</script>
