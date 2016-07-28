<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.erp_to_u8.vo.Erp_to_u8Vo" %>
<%@ page import="rayoo.u8.erp_to_u8.util.IErp_to_u8Constants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	Erp_to_u8Vo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IErp_to_u8Constants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (Erp_to_u8Vo)request.getAttribute(IErp_to_u8Constants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function vailform(){
        var  erp_partid = jQuery("#erp_partid").val();
        if(!erp_partid){
            alert("请选择ERP用户");
            return false;
        }
        var  u8_cuser_id = jQuery("#u8_cuser_id").val();
        if(!u8_cuser_id){
            alert("请选择U8用户");
            return false;
        }
        var  startdate = document.getElementById("startdate").value;
        if(!startdate){
            alert("请输入生效日期");
            return false;
        }
        var  enddate = document.getElementById("enddate").value;
        if(!enddate){
            alert("请输入失效日期");
            return false;
        }
      	var beginTimes = startdate.substring(0,10).split('-');
        var endTimes = enddate.substring(0,10).split('-');
        beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
        endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
        if(beginTime >= endTime){
             alert("失效日期小于等于生效日期！");
             return false;
       }
        return true;
    }
	
	function save_onClick(){  //保存
       
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            var erp_partid = document.getElementById("erp_partid").value;
      		var u8_cuser_id = document.getElementById("u8_cuser_id").value;
            var startdate = document.getElementById("startdate").value;
            var enddate = document.getElementById("enddate").value;
            //验证一个ERP用户在一个有效时间内，只能对应一个U8用户
            jQuery.ajax({
	           url: '<%=request.getContextPath()%>/Erp_to_u8Action.do?cmd=vailTime&erp_partid='+encodeURI(erp_partid)
	                                                                               +'&u8_cuser_id='+encodeURI(u8_cuser_id)
	                                                                               +'&startdate='+encodeURI(startdate)
	                                                                               +'&enddate='+encodeURI(enddate)
	                                                                               +'&id='+encodeURI(code),
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	           error: function(){
	                  alert('同一ERP用户在同一有效时间内，只能对应一个U8用户!');
	                  $id("startdate").setValue(null);
	                  $id("enddate").setValue(null);
	                  return;
	               },
	           success: function(data){
		                if(data=='false'){
		                   alert('同一ERP用户在同一有效时间内，只能对应一个U8用户!');
		                   $id("startdate").setValue(null);
	                       $id("enddate").setValue(null);
		                   return;
		               }
	               }
	           });
	        if(!$id("startdate").value){
	        	return;
	        }
            if (code){
                form.action="<%=request.getContextPath()%>/Erp_to_u8Action.do?cmd=update&id="+code;
            }else{
	            form.action="<%=request.getContextPath()%>/Erp_to_u8Action.do?cmd=insert&id="+code;
            }
            form.submit();
            window.close();
            window.opener.simpleQuery_onClick();
       		
       }
       
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function erpFunc(arg){
	    var lookup = $id("lk_erp");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    jQuery("#erp_partid").val(arg[1]);       
	    return false;
	}
	
    function u8Func(arg){
	    var lookup = $id("lk_u8");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    jQuery("#u8_cuser_id").val(arg[0]);       
	    return false;
	}
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng">
<div class="xz_title">基本信息</div> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>ERP用户</td>
            
            <td class="td_2 " width="28%">
                <input type="hidden" name="erp_partid" id="erp_partid" value="${bean.erp_partid}">
                <w:lookup onReturnFunc="erpFunc" lookupWidth="189px" readonly="false" displayValue="${bean.erp_name}" id="lk_erp" 
                                   lookupUrl="/Erp_userAction.do?cmd=getErpRef" dialogTitle="选择ERP用户" 
                                   height="440" width="710" allowInput="false"/>
       		</td>
       		<td class="td_1"  width="23%" ><span class="style_required_red">* </span>U8用户</td>
            <td class="td_2 " width="28%">
                <input type="hidden" name="u8_cuser_id" id="u8_cuser_id" value="${bean.u8_cuser_id}">
                <w:lookup onReturnFunc="u8Func" lookupWidth="189px" readonly="false" displayValue="${bean.u8_name}" id="lk_u8" 
                                   lookupUrl="/U8_userAction.do?cmd=getU8Ref" dialogTitle="选择U8用户" 
                                   height="440" width="710" allowInput="false"/>
       		</td>
        </tr>
		<tr>
			
            <td class="td_1" width="23%"><span class="style_required_red">* </span>生效日期</td>
            <td class="td_2"  width="28%">
            	 <w:date allowInput="true" id="startdate" name="startdate" format="YYYY-MM-DD" property="bean/startdate" width="180px"/> 
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>失效日期</td>
			<td  class="td_2" width="28%">
				 <w:date allowInput="true" id="enddate" name="enddate" format="YYYY-MM-DD" property="bean/enddate" width="180px"/> 
			</td>
		</tr>
	
    </table>
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
    </div>
</div>
		

<input type="hidden" name="id" id="edit_id" value="${bean.id}">
<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="create_date" />
</form> 
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}

%>
</script>
