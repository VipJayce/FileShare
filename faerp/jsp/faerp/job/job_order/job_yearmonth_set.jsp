<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.taodacanshu_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% 
   String join_date = "";
   String file_now = "";
  
%>
<title>codegen</title>
<script language="javascript">

  	function ok_onClick(){  
  	    if(!valiData()){
  	     	return;
  	    }
  	    //取得主页面传过来的参数
        var ids = window["dialogArguments"];
        if(!valiExsit(ids)){
        	return;
        }
        window.returnValue = jQuery("#yearmonth").val();
    	window.close();
    }
    
    //判断订单在该月是否已经生成划转单
    function valiExsit(ids){
    	var action = "<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?cmd=valiExsit";
        var myAjax = new Ajax(action);
        var yearMonth = jQuery("#yearmonth").val();
        myAjax.addParam("ids", ids);
        myAjax.addParam("yearmonth" , yearMonth);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if(returnNode){
             var rtnMsg = myAjax.getValue("root/data/returnMessage");
        	 if( myAjax.getValue("root/data/returnValue") == "1" ) {
                 return true;
             }else{
             	 alert('操作失败!'+rtnMsg);
             	 return false;
             } 
        }
        return false;
    }
    
    //验证年月输入
    function valiData(){
    	var yearMonth = jQuery("#yearmonth").val();
    	if(!yearMonth){
    		alert('生成年月不能为空！');
    		return false;
    	}
    	var reg = /^\b[1-3]\d{3}(0[1-9]|1[0-2])$/;
    	var flg = yearMonth.match( reg );
    	if(!flg){
    		alert('输入错误，请输入“yyyyMM”六位数字格式\n');
    		return false;
    	}
    	return true;
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<p></p>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
		  <td class="td_1" nowrap="true">年月</td>
          <td class="td_2" align="left" style="width: 250px">
          	<input id="yearmonth" name="yearmonth" value=""/>
          </td>
		</tr>
		
	</table>
	</div>
	<p></p>
    <div class="foot_button">
        <input type="button" class="icon_2" value="<fmt:message key='taodacanshu0003'/>" onClick="javascript: ok_onClick()" />
        <input type="button" class="icon_2" value="返回"  onClick="javascript:cancel_onClick()"/>
        </div>
</div>
</div>         
</form>
</fmt:bundle>
</body>
</fmt:bundle>
</html>

<script language="javascript">
init();
</script>


