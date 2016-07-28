<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.finance.receivable.finincoming.finincoming_resource" prefix="rayoo.finance.receivable.finincoming.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

	function insert_onClick(){  //插入单条数据
		var inc_date = $id("inc_date").value;
		var inc_cust_name = $id("inc_cust_name").value.replace(/\s+/g,"");//去空格
		var inc_amout = $id("inc_amout").value;
        var inc_bank = $id("inc_bank").value;

        if(inc_date==""||inc_date==null){
          alert("<fmt:message key='alert_select_inc_date'/>");
          return;
        }
        
        
        if(inc_cust_name==""||inc_cust_name==null){
          alert("<fmt:message key='alert_inc_cust_name_notnull'/>");
          return;
        }
        
        if(inc_amout==""||inc_amout==null){
          alert("<fmt:message key='alert_inc_amout_notnull'/>");
          return;
        }else{
	            if (isNaN(inc_amout)) {
	                   alert("<fmt:message key='alert_inc_amout_isnumber'/>");
	                   $id("inc_amout").value="";
                       return;
	            }
        }
        
        if(inc_bank==""||inc_bank==null){
          alert("<fmt:message key='alert_inc_bank'/>");
          return;
        }
		
          var param = jQuery("#datacell_formid").serialize();
          var url="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=insertData&"+param;
	        jQuery.post(url,function(data){
	            if(data){
		                if(data!=""){
		                alert("<fmt:message key='alert_save_success'/>");
                        window.close();
		                }else{
		                alert("<fmt:message key='alert_save_fail'/>");
		                window.close();
		                }
	             }else{
                        alert("<fmt:message key='alert_save_fail'/>");
                        window.close();
                        }
             });
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    
    function onKey_Up(v_str) {
            if (!isNaN(v_str)) {
                ////是数字，可以通过
            } else if (v_str == '-') {
                //负数，可以通过
                return;
            } else {
                alert("<fmt:message key='alert_not_number'/>");
                $id("inc_amout").value="";
                return ;
            }  
}
          
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height: 1000x">
<div class="xz_title" style="padding-top: 5px"><fmt:message key='title_manual_add_info'/></div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key='inc_date'/></td>
			<td class="td_2">	
				<w:date  format="yyyy-MM-dd" id="inc_date" name="inc_date" width="188px"  />				</td>
			<td class="td_1" ><fmt:message key='inc_cust_name'/></td>
			<td class="td_2"> <input type="text" class="text_field"  id="inc_cust_name" name="inc_cust_name"  maxLength="50"/></td>
		</tr>
		<tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='inc_amout'/></td>
            <td class="td_2"><input type="text" class="text_field" id="inc_amout" name="inc_amout"  onkeyup="onKey_Up(this.value)"  maxLength="14"/></td>
            <td class="td_1" ><fmt:message key='inc_bank_'/></td>
            <td class="td_2">
            <d:select name="inc_bank" id="inc_bank" dictTypeId="BANK" nullLabel="-请选择-"></d:select>
            </td>
        </tr>

	</table>
	<div  align="center" style="padding-top: 10px;">
            <input type="button" id="bc" class="icon_2" value='<fmt:message key="button_save"/>' onClick="javascript:insert_onClick()" />
            <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>  
 
</div>         

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>