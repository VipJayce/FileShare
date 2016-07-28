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
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	function insert_onClick(){  //插入单条数据
	   onkeyupvalicode();
	    if(vailform()){
	    var param=jQuery("#formId").serialize();
	    var url="<%=request.getContextPath()%>/U8_customerAction.do?cmd=insert&"+param;
	    jQuery.post(url,function(data){
	     if(data!=""){
	       alert("保存成功！");
	       window.close();
	     }else{
	           alert("保存失败！");
	            window.close();
	     }
	    })
		
		}
	}
    function vailform(){
        var  code = document.getElementById("ccuscode").value;
        if(code==null || code==""){
            alert("请输入客户编号");
            jQuery("#ccuscode").focus();
            return false;
        }
          var  name = document.getElementById("ccusname").value;
        if(name==null || name==""){
            alert("请输入客户名称");
            jQuery("#ccusname").focus();
            return false;
        }
        return true;
        }
        
         function onkeyupvalicode(){
         var ccuscode = document.getElementById("ccuscode").value;
           jQuery.ajax({
           url: '<%=request.getContextPath()%>/U8_customerAction.do?cmd=vailCode&code='+ccuscode,
           type: 'POST',
           dataType: 'html',
           async: false,
           timeout: 10000,
               error: function(){
                  alert('客户编号重复!');
                  $id("ccuscode").setDisplayValue("");
                  return;
               },
                success: function(data){
                        if(data=='false'){
                           alert('客户编号重复!');
                           $id("ccuscode").setDisplayValue("");
                           $id("ccuscode").setValue("");
                           return;
                         }
               }
           });
    }
      function onkeyupvaliname() {
        var name = document.getElementById("ccusname").value;
        if(name!=null&&name!=""){
             jQuery.ajax({
               url: '<%=request.getContextPath()%>/U8_customerAction.do?cmd=vailName&name='+encodeURI(name),
               type: 'POST',
               dataType: 'html',
               async: false,
               timeout: 10000,
                   error: function(){
                      alert('客户名称重复!');
                      jQuery("#ccusname").val("");
                      return;
                   },
                    success: function(data){
                        if(data=='true'){
                           alert('客户名称重复!');
                           jQuery("#ccusname").val("");
                           return;
                       }
                   }
               });
           }
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("ccuscode");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        jQuery("#ccusname").val(arg[2]);
        jQuery("#ccusid").val(arg[0]);
        //onkeyupvalicode(arg[1]);
        return false;
    }
    
    function cancel_onClick(){  //取消后返回列表页面
       window.close();
    }
</script>
	</head>
	<body>

	<form name="form" method="post" id="formId">
<input type="hidden" name="ccusid" id="ccusid">
	<div id="right">

	<div class="ringht_s">
	<div id="ccChild1" class="box_3" >
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">

		<tr>
			<td class="td_1"><span class="style_required_red">* </span>客户编码</td>
			<td class="td_2 "><!-- <input type="text" class="text_field" id="ccuscode" name="ccuscode" inputName="客户编码" value="" maxLength="25" validate="notNull;" onblur="onkeyupvalicode();" /> -->
				<w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" name="ccuscode" id="ccuscode" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"  dialogTitle="选择客户" height="440" width="600"  style="width:190px"/></td>
			<td class="td_1"><span class="style_required_red">* </span>客户名称</td>
			<td class="td_2 "><input type="text" class="text_field" id="ccusname" name="ccusname" inputName="客户名称" readonly="readonly" />
			</td>
		</tr>

		<tr>
			<td class="td_1">客户简称</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccusabbname" inputName="客户简称" value="" maxLength="100" /></td>
			<td class="td_1">英文名称</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccusenname" inputName="英文名称" value="" maxLength="50" /></td>
		</tr>

		<tr>
			<td class="td_1">客户分类编码</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccccode" inputName="客户分类编码" value="" maxLength="10" /></td>
			<td class="td_1">地区编码</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="cdccode" inputName="地区编码" value="" maxLength="10" /></td>
		</tr>

		<tr>
			<td class="td_1">地址</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccusaddress" inputName="地址" value="" maxLength="25" /></td>
			<td class="td_1">邮政编码</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccuspostcode" inputName="邮政编码" value="" maxLength="5" /></td>
		</tr>

		<tr>
			<td class="td_1">纳税人登记号</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccusregcode" inputName="纳税人登记号" value="" maxLength="25" /></td>
			<td class="td_1">开户银行</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccusbank" inputName="开户银行" value="" maxLength="50" /></td>
		</tr>

		<tr>
			<td class="td_1">银行账号</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccusaccount" inputName="银行账号" value="" maxLength="50" /></td>
			<td class="td_1">法人</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccuslperson" inputName="法人" value="" maxLength="50" /></td>
		</tr>

		<tr>
			<td class="td_1">联系人</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccusperson" inputName="联系人" value="" maxLength="50" /></td>
			<td class="td_1">联系电话</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ccusphone" inputName="联系电话" value="" maxLength="50" /></td>
		</tr>

		<tr>
			<td class="td_1">所属行业</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="ctrade" inputName="所属行业" value="" maxLength="25" /></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
		</tr>

	</table>
	</div>
	<div class="foot_button"><input type="button" class="icon_2"
		value='<fmt:message key="save"/>'
		onClick="javascript:insert_onClick()" /> <input type="button"
		class="icon_2" value='<fmt:message key="go_back"/>'
		onClick="javascript:cancel_onClick()" /></div>
	</div>
	</div>

	</form>
</fmt:bundle>
</body>
</html>


