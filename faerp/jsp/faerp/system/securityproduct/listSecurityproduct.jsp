<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.securityproduct.vo.SecurityproductVo" %>
<%@ page import="rayoo.system.securityproduct.util.ISecurityproductConstants" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<jsp:useBean id="productaction" class="rayoo.system.product.action.ProductAction" scope="page" />
<jsp:useBean id="numutils" class="rayoo.tool.NumUtils" scope="page" />
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISecurityproductConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISecurityproductConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SecurityproductVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/SecurityproductAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
		form.cmd.value = "queryAll";
	}  
	
	   function editjishuCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var tagname="cityid"+ids
        var city_id=document.getElementById(tagname).value;
        form.action="<%=request.getContextPath()%>/SecurityproductitemAction.do?cmd=queryAll&security_product_id=" + ids+"&city_id="+city_id;
        form.submit();
    } 
    
    
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_stop"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/SecurityproductAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}

  	 function reset_onClick(){  //简单的模糊查询
         $id("city_id").value="";
         $id("product_id").value="";
         $id("city_id").paramList = [];
         $id("product_id").paramList = [];
         $id("city_id").refresh();      
         $id("product_id").refresh();
    }
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/system/securityproduct/insertSecurityproduct.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/SecurityproductAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/SecurityproductAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('社保产品比例维护','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
		    <td width="175" rowspan="2" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
			<td width="202" align="right">省市</td>
			<td width="180" align="left">
			 <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
			</td>
			<td width="249" align="right">社保公积金产品</td>
			<td width="511" align="left">
			<r:comboSelect id="product_id" name="product_id"
                       queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       nullText="请选择" />
			</td>
		    </tr>
		
		<tr>
			<td/>
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:reset_onClick()">            </td>
            	<td/>
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="k">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="stop"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="q_1">     <a  onClick="javascript:editjishuCheckbox_onClick();"><fmt:message key="jishu"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onClick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"city_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"city_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"city_id")%>">
            </a>省市
            </th>
            
            <th><a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_id")%>">
           	</a>	
       
			 社保公积金产品</th>

			<th>
				
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_name")%>">
           	</a>	
       
			 社保产品比例名称</th>
			<th>
				
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_ratio")%>">
           	</a>	
       
			 公司比例(%)</th>
			<th>
				
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_ratio")%>">
           	</a>	
       
			 个人比例(%)</th>
			<th>
				
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_add_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_add_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_add_ratio")%>">
           	</a>	
       
			 公司附加金额(%)</th>
			<th>
				
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_add_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_add_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_add_ratio")%>">
           	</a>	
       
			 个人附加金额(%)</th>
			<th>
					
					<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_caculate_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_caculate_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_caculate_type_bd")%>">
           	</a>	
       
	 公司舍入原则</th>
     	<th>
					
					<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_caculate_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_caculate_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_caculate_type_bd")%>">
           	</a>	
       
	 个人舍入原则</th>
     	<th>
					
					<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_precision_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_precision_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_precision_bd")%>">
           	</a>	
       
	 公司精度</th>
     	<th>
					
					<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_precision_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_precision_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_precision_bd")%>">
           	</a>	
       
	 个人精度</th>
     	<th>
					
					<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_parity_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_parity_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_parity_bd")%>">
           	</a>	
       
	 公司奇偶限定</th>
     	<th>
					
					<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_parity_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_parity_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_parity_bd")%>">
           	</a>	
       
	 个人奇偶限定</th>
     	<th>
					
					<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"charge_frequency_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"charge_frequency_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"charge_frequency_bd")%>">
           	</a>	
       
	 收费频率</th>
     	<th>
				
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"yearly_pay_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"yearly_pay_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"yearly_pay_month")%>">
           	</a>	
       
			 年缴费月</th>
			<th>
					
					<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_outstrip_limit_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_outstrip_limit_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_outstrip_limit_bd")%>">
           	</a>	
       
	 是否超上下限</th>
     	<th>
				
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_explanation")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_explanation")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_explanation")%>">
           	</a>	
       
			 产品说明</th>
			<th>
				
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remark")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remark")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remark")%>">
           	</a>	
       
			 备注</th>
			 <!--
			<th>
			  	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_user")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_user")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_user")%>">
           	</a>	
       
			 创建人</th>
			<th>
							
				 	<a href="/FAERP/SecurityproductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_date")%>">
           	</a>	
       
			创建日期</th>
			 -->
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>
            <td>
            <faerp:cityViewTag beanname="data" attribute="city_id"/>
            <input type="hidden" id="cityid<bean:write name="data" property="id"/>" name="cityid<bean:write name="data" property="id"/>" value="<bean:write name="data" property="city_id"/>">
            </td>
            <td>&nbsp;
            <bean:define id="product_id" name="data" property="product_id"/>
            <%= (product_id!=null&&product_id!="") ? productaction.getProductNameByID(product_id.toString()) : ""%>  
            </td>
			<td>
			<bean:write name="data" property="product_name"/>  
			 </td>
			<td>
			<bean:define id="eratio" name="data" property="e_ratio"/>
			<%=numutils.valueFormatPercent(eratio.toString()) %>
			</td>
			<td>
			<bean:define id="pratio" name="data" property="p_ratio"/>
            <%=numutils.valueFormatPercent(pratio.toString()) %>
			</td>
			<td>
		    <bean:define id="eaddratio" name="data" property="e_add_ratio"/>
            <%=numutils.valueFormatPercent(eaddratio.toString()) %>
			</td>
			<td>
            <bean:define id="paddratio" name="data" property="p_add_ratio"/>
            <%=numutils.valueFormatPercent(paddratio.toString()) %>			
			</td>
			<td>&nbsp;
            <bean:define id="e_caculate_type_bd" name="data" property="e_caculate_type_bd"/>
            <%=BaseDataHelper.getNameByCode("E_CACULATE_TYPE_BD",String.valueOf(e_caculate_type_bd))%>
			</td>		
			<td>&nbsp;
            <bean:define id="p_caculate_type_bd" name="data" property="p_caculate_type_bd"/>
            <%=BaseDataHelper.getNameByCode("P_CACULATE_TYPE_BD",String.valueOf(p_caculate_type_bd))%>
            </td>		
			<td>&nbsp;
            <bean:define id="e_precision_bd" name="data" property="e_precision_bd"/>
            <%=BaseDataHelper.getNameByCode("E_PRECISION_BD",String.valueOf(e_precision_bd))%>
			</td>		
			<td>&nbsp;
            <bean:define id="p_precision_bd" name="data" property="p_precision_bd"/>
            <%=BaseDataHelper.getNameByCode("P_PRECISION_BD",String.valueOf(p_precision_bd))%>
			</td>
			<td>&nbsp;
            <bean:define id="e_parity_bd" name="data" property="e_parity_bd"/>
            <%=BaseDataHelper.getNameByCode("E_PARITY_BD",String.valueOf(e_parity_bd))%>
			</td>		
			<td>&nbsp;
            <bean:define id="p_parity_bd" name="data" property="p_parity_bd"/>
            <%=BaseDataHelper.getNameByCode("P_PARITY_BD",String.valueOf(p_parity_bd))%>
			</td>		
			<td>&nbsp;
            <bean:define id="charge_frequency_bd" name="data" property="charge_frequency_bd"/>
            <%=BaseDataHelper.getNameByCode("CHARGE_FREQUENCY_BD",String.valueOf(charge_frequency_bd))%>
			</td>		
			<td><bean:write name="data" property="yearly_pay_month"/>   </td>
			<td>&nbsp;
            <bean:define id="is_outstrip_limit_bd" name="data" property="is_outstrip_limit_bd"/>
            <%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_outstrip_limit_bd))%>
			</td>		
			<td><bean:write name="data" property="product_explanation"/>   </td>
			<td><bean:write name="data" property="remark"/>   </td>
			<!--
			<td>
			<bean:define id="create_user" name="data" property="create_user"/>
                 <%=OrgHelper.getPartyVoByID(create_user.toString()).getName()%></td>
			<td><bean:write name="data" property="create_date" format="yyyy-MM-dd"/>   </td>
			 -->
			</tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

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
<%  //表单回写
	//if(request.getAttribute(ISecurityproductConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
	//	out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISecurityproductConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	//}
%>

_$(document).ready(function() {
        $id("city_id").value="${requestScope.city_id}";
        $id("product_id").value="${requestScope.product_id}";
});
</script>	
