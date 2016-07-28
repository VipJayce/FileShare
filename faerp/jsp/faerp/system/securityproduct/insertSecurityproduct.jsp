<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.securityproduct.vo.SecurityproductVo" %>
<%@ page import="rayoo.system.securityproduct.util.ISecurityproductConstants" %>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<%  //判断是否为修改页面
	SecurityproductVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ISecurityproductConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SecurityproductVo)request.getAttribute(ISecurityproductConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<%@page import="rayoo.system.product.vo.ProductVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/SecurityproductAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/SecurityproductAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/SecurityproductAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
		    <td class="td_1" >省市</td>
            <td class="td_2 ">
            <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
            </td>
			<td class="td_1" >社保公积金产品</td>
			<td class="td_2 ">
			<faerp:securityGroupSelectTag beanname="product_id" attribute="product_id" className="text_field"/>
            </td>
			<td class="td_1" >社保产品比例名称</td>
			<td class="td_2 "><input type="text" class="text_field" name="product_name" inputName="社保产品比例名称" value="" maxLength="50" />            </td>
		</tr>
		
		
		<tr>
			<td  class="td_1" >公司比例</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="e_ratio" inputName="公司比例" maxLength="10" onKeyUp="if(isNaN(value))execCommand('undo')" />			</td>
			<td  class="td_1" >个人比例</td>
			<td  class="td_2" ><input type="text" class="text_field" name="p_ratio" inputName="个人比例" maxLength="10" onKeyUp="if(isNaN(value))execCommand('undo')" />            </td>
			<td  class="td_1" >公司附加金额</td>
			<td  class="td_2" ><input type="text" class="text_field" name="e_add_ratio" inputName="公司附加金额" maxLength="10" onKeyUp="if(isNaN(value))execCommand('undo')" />            </td>
		</tr>
		<tr>
		  <td  class="td_1" >个人附加金额</td>
		  <td  class="td_2" ><input type="text" class="text_field" name="p_add_ratio" inputName="个人附加金额"  maxLength="10" onKeyUp="if(isNaN(value))execCommand('undo')"  />          </td>
			<td class="td_1" >公司舍入原则</td>
			<td class="td_2" > 
			<%=RmJspHelper.getSelectField("e_caculate_type_bd", -1,"E_CACULATE_TYPE_BD",isModify ? resultVo.getE_caculate_type_bd() : "1","",false) %> 
			</td>
			<td class="td_1" >个人舍入原则</td>
			<td class="td_2" > 
			<%=RmJspHelper.getSelectField("p_caculate_type_bd", -1,"P_CACULATE_TYPE_BD",isModify ? resultVo.getP_caculate_type_bd() : "1","",false) %> 
			</td>
		</tr>
		
		<tr>
			<td class="td_1" >公司精度</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("e_precision_bd", -1,"E_PRECISION_BD",isModify ? resultVo.getE_precision_bd() : "1","",false) %>
			</td>
			<td class="td_1" >个人精度</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("p_precision_bd", -1,"P_PRECISION_BD",isModify ? resultVo.getP_precision_bd() : "1","",false) %>
			</td>
			<td class="td_1" >公司奇偶限限定</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("e_parity_bd", -1,"E_PARITY_BD",isModify ? resultVo.getE_parity_bd() : "1","",false) %>
			</td>
		</tr>
		<tr>
			<td class="td_1" >个人奇偶限限定</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("p_parity_bd", -1,"P_PARITY_BD",isModify ? resultVo.getP_parity_bd() : "1","",false) %>
			</td>
			<td class="td_1" >收费频率</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("charge_frequency_bd", -1,"CHARGE_FREQUENCY_BD",isModify ? resultVo.getCharge_frequency_bd() : "1","",false) %>
			</td>
			<td class="td_1" >是否超上下限</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("is_outstrip_limit_bd", -1,"TrueOrFalse",isModify ? resultVo.getIs_outstrip_limit_bd() : "1","",false) %>
		</tr>
		
		<tr>
			<td class="td_1" >年缴费月</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="yearly_pay_month" inputName="年缴费月" value="" maxLength="50" />			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		
		<tr>
			<td class="td_1">产品说明</td>
			<td colspan="5" class="td_2" >
			<textarea class="textarea_limit_words" name="product_explanation" rows="3" inputName="产品说明"  style="width:99%"  maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="5" class="td_2" >	
				<textarea class="textarea_limit_words" name="remark" rows="3" inputName="备注"  style="width:99%"  maxLength="1000" ></textarea>
				</td>
		</tr>
	</table>

    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="cancel"/>'  onClick="javascript:cancel_onClick()"/>
      </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

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
</script>
