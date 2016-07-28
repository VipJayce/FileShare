<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.productGrantRule.vo.ProductGrantRuleVo" %>
<%@ page import="rayoo.system.productGrantRule.util.IProductGrantRuleConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	ProductGrantRuleVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IProductGrantRuleConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (ProductGrantRuleVo)request.getAttribute(IProductGrantRuleConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
//入职时间1     一年3     自然季度2     半年6
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		    var isNum=/^-?\d+$/;
		    var grant_condition = document.getElementById("grant_condition").value;
		    if(grant_condition =="1" ){
		       if(document.form.grant_frequency.value==null || document.form.grant_frequency.value==""){
		           alert("发放频率不能为空！");
		           document.form.grant_frequency.focus();
		           return;
		        }
		        if(!isNum.test(document.form.grant_frequency.value)){
		            alert("请输入正确的发放频率！");
		            document.form.grant_frequency.focus();
		            return;
		        }
		    }
		    if(grant_condition=="6"){
		        if(document.form.grant_counts1.value==null || document.form.grant_counts1.value==""){
                       alert("下半年发放数量不能为空！");
                       document.form.grant_counts1.focus();
                       return;
                 }
                 if(!isNum.test(document.form.grant_counts1.value)){
	                alert("请输入正确的下半年发放数量！");
	                document.form.grant_counts1.focus();
	                return;
	            }
	            
	             if(grant_condition=="3"){
	                if(!isNum.test(document.form.ff_month.value)){
	                        alert("请输入正确的福利发放月份！");
	                        document.form.ff_month.focus();
	                        return;
	                    }
	                
	            }
		    }
		    
	        if(document.form.grant_counts.value==null || document.form.grant_counts.value==""){
	           alert("发放数量不能为空！");
	           document.form.grant_counts.focus();
	           return;
	        }
	        if(!isNum.test(document.form.grant_counts.value)){
	            alert("请输入正确的发放数量！");
	            document.form.grant_counts.focus();
	            return;
	        }
	          if(!isNum.test(document.form.grant_month.value)){
                alert("请输入正确的最少缴费月数！");
                document.form.grant_month.focus();
                return;
            }
            
           
			var action="<%=request.getContextPath()%>/ProductGrantRuleAction.do?cmd=insert";
	        var myAjax = new Ajax(action);
            myAjax.addParam('grant_condition', grant_condition);
            
            if(grant_condition=="1"){
                myAjax.addParam('grant_frequency', document.form.grant_frequency.value);
            }
            if(grant_condition=="6"){
              
                myAjax.addParam('grant_counts1', document.form.grant_counts1.value);
            }
              if(grant_condition=="3"){
                  myAjax.addParam('ff_month', document.form.ff_month.value);            
            }
            
            
            myAjax.addParam('grant_counts', document.form.grant_counts.value);            
            myAjax.addParam('grant_month', document.form.grant_month.value);            
            
	        myAjax.submit();
	        
	         var returnNode = myAjax.getResponseXMLDom();
	         if( returnNode ) {
	              alert(""+myAjax.getProperty("returnValue"));
	              window['returnValue'] = ""+myAjax.getProperty("returnValue");
	              window.close();
	         }
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    if(checkAllForms()){
	       var isNum=/^-?\d+$/;
	       var grant_condition = document.getElementById("grant_condition").value;
	        if(grant_condition =="1" ){
               if(document.form.grant_frequency.value==null || document.form.grant_frequency.value==""){
                   alert("发放频率不能为空！");
                   document.form.grant_frequency.focus();
                   return;
                }
                if(!isNum.test(document.form.grant_frequency.value)){
                    alert("请输入正确的发放频率！");
                    document.form.grant_frequency.focus();
                    return;
                }
            }
	          if(grant_condition=="6"){
	                if(document.form.grant_counts1.value==null || document.form.grant_counts1.value==""){
	                       alert("下半年发放数量不能为空！");
	                       document.form.grant_counts1.focus();
	                       return;
	                 }
	                 if(!isNum.test(document.form.grant_counts1.value)){
	                    alert("请输入正确的下半年发放数量！");
	                    document.form.grant_counts1.focus();
	                    return;
	                }
                }
                 if(grant_condition=="3"){
                    if(!isNum.test(document.form.ff_month.value)){
                            alert("请输入正确的福利发放月份！");
                            document.form.ff_month.focus();
                            return;
                        }
                }
                
	        if(document.form.grant_counts.value==null || document.form.grant_counts.value==""){
	           alert("发放数量不能为空！");
	           document.form.grant_counts.focus();
	           return;
	        }
	        if(!isNum.test(document.form.grant_counts.value)){
	            alert("请输入正确的发放数量！");
	            document.form.grant_counts.focus();
	            return;
	        }
	           if(!isNum.test(document.form.grant_month.value)){
                alert("请输入正确的最少缴费月数！");
                document.form.grant_month.focus();
                return;
            }
            
    	    var action="<%=request.getContextPath()%>/ProductGrantRuleAction.do?cmd=update";
            var myAjax = new Ajax(action);
            
            myAjax.addParam('grant_condition', grant_condition);
            
             if(grant_condition=="1"){
                myAjax.addParam('grant_frequency', document.form.grant_frequency.value);
            }
            if(grant_condition=="6"){
                myAjax.addParam('grant_counts1', document.form.grant_counts1.value);
            }
              if(grant_condition=="3"){
                  myAjax.addParam('ff_month', document.form.ff_month.value);            
            }
            myAjax.addParam('grant_counts', document.form.grant_counts.value);
            myAjax.addParam('grant_month', document.form.grant_month.value);      
            
            myAjax.addParam('id', document.form.id.value);            
            
            myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
             }
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/ProductGrantRuleAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }
        
    function  change_type(obj){
	    if(obj.value=="2")  {
	        document.getElementById("frequency").style.display="none";
	        document.getElementById("grant_freq").style.display="none";
	        document.getElementById("counts1").style.display="none";
            document.getElementById("grant_c1").style.display="none";
             document.getElementById("ffmonth").style.display="none";
            document.getElementById("ff_month1").style.display="none";
	    }else if(obj.value=="6")  {
	        document.getElementById("frequency").style.display="none";
            document.getElementById("grant_freq").style.display="none";
	        document.getElementById("counts").innerHTML = '上半年发放数量';
            document.getElementById("counts1").style.display="block";
            document.getElementById("grant_c1").style.display="block";
            document.getElementById("ffmonth").style.display="none";
            document.getElementById("ff_month1").style.display="none";
	    }   else if(obj.value=="3"){
            document.getElementById("frequency").style.display="none";
            document.getElementById("grant_freq").style.display="none";
            document.getElementById("counts1").style.display="none";
            document.getElementById("grant_c1").style.display="none";
            document.getElementById("counts").innerHTML = '发放数量';
            document.getElementById("ffmonth").style.display="block";
            document.getElementById("ff_month1").style.display="block";
        }else{
	       document.getElementById("frequency").style.display="block";
            document.getElementById("grant_freq").style.display="block";
            document.getElementById("counts1").style.display="none";
            document.getElementById("grant_c1").style.display="none";
            document.getElementById("counts").innerHTML = '发放数量';
             document.getElementById("ffmonth").style.display="none";
            document.getElementById("ff_month1").style.display="none";
	    }
	}
    
</script>
</head>
<body>

<form name="form" id="datacell_formid" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('修改产品发放规则','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('新增产品发放规则','<%=request.getContextPath()%>/');
</script>


<!-- 1"入职时间 3"一年  2"自然季度   6"半年   
  -->
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
		    <td class="td_1" >发放条件</td>
            <td class="td_2 ">
                <d:select dictTypeId="GRANT_CONDITION" name="grant_condition" id="grant_condition" property="grant_condition" onchange="javascript:change_type(this)"  />
            </td>
                <td class="td_1" id="grantmonth">最少缴费</td>
            <td class="td_2 " id="grantmonth">
                <input type="text" class="text_field" name="grant_month" id="grant_month" inputName="时间" value="" maxLength="64" style="width:100px;" /> 个月   &nbsp;</td>
           <tr/>
           <tr>
          
			<td class="td_1" id="frequency">发放频率</td>
			<td class="td_2 " id="grant_freq">
				每隔<input type="text" class="text_field" name="grant_frequency" id="grant_frequency" inputName="频率" value="" maxLength="64" style="width:100px;" />个月			&nbsp;</td>
		 <td  class="td_1" id="ffmonth" style="display: none;">发放月份</td>
            <td  class="td_2" id="ff_month1" style="display: none;">
                <input type="text" class="text_field" name="ff_month" inputName="月份" id="ff_month" maxLength="19" integerDigits="18" style="width:100px;" decimalDigits="0" /> 月
            </td>
			<td  class="td_1"><span id="counts">发放数量</span></td>
            <td  class="td_2" >
        发放<input type="text" class="text_field" name="grant_counts" inputName="数量" id="grant_counts" maxLength="19" integerDigits="18" style="width:100px;" decimalDigits="0" />张
            </td>      
            <td  class="td_1" id="counts1" style="display: none;">下半年发放数量</td>
            <td  class="td_2" id="grant_c1" style="display: none;">发放<input type="text" class="text_field" name="grant_counts1" inputName="数量" id="grant_counts1" maxLength="19" integerDigits="18" style="width:100px;" decimalDigits="0" />张</td>
		</tr>
	</table>

    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>

var obj = document.getElementById("grant_condition");
if(obj.value=="2")
        {
            document.getElementById("frequency").style.display="none";
            document.getElementById("grant_freq").style.display="none";
            document.getElementById("counts1").style.display="none";
            document.getElementById("grant_c1").style.display="none";
        }
        else if(obj.value=="6")
        {
            document.getElementById("frequency").style.display="none";
            document.getElementById("grant_freq").style.display="none";
            document.getElementById("counts").innerHTML = '上半年发放数量';
            document.getElementById("counts1").style.display="block";
            document.getElementById("grant_c1").style.display="block";
        }  else if(obj.value=="3"){
        
            document.getElementById("frequency").style.display="none";
            document.getElementById("grant_freq").style.display="none";
            document.getElementById("counts1").style.display="none";
            document.getElementById("grant_c1").style.display="none";
            document.getElementById("counts").innerHTML = '发放数量';
            document.getElementById("ffmonth").style.display="block";
            document.getElementById("ff_month1").style.display="block";
            
        }
        else{
           document.getElementById("frequency").style.display="block";
            document.getElementById("grant_freq").style.display="block";
            document.getElementById("counts1").style.display="none";
            document.getElementById("grant_c1").style.display="none";
            document.getElementById("counts").innerHTML = '发放数量';
             document.getElementById("ffmonth").style.display="none";
            document.getElementById("ff_month1").style.display="none";
        }


</script>
