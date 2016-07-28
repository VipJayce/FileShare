<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.product.vo.ProductVo" %>
<%@ page import="rayoo.system.product.util.IProductConstants" %>
<jsp:useBean id="agentaction" class="rayoo.sales.agent.action.AgentAction" scope="page" />
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IProductConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IProductConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    ProductVo resultVo = null;  //定义一个临时的vo变量
    String bigTypeId=request.getParameter("big_type_id")==null ? "" : request.getParameter("big_type_id").toString();
%>
<html>
<script type="text/javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
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

    function returnvalue() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var returnAry = new Array();
        returnAry[0] = ids;
        returnAry[1] = document.getElementById(ids+'product_name').value;
        window.returnValue=returnAry;
        window.close();
    }
    
    /**
	 * 功能描述：动态生成产品大类下拉菜单的内容
	 * 参数：  selectId --下拉框id;
	 *              key -- 填充时作为option value的对象属性
	 *              value -- 填充时作为option展示的对象属性
	 */    
	function getAllBigType(selectObject,key,value,selectvalue){
	    if(selectObject.length==1) {
	        AjaxControl.getBigTypeId("big_type_id",{callback:function(data){
	                if (data != null && typeof data == 'object') 
	                {
	                    setSelectForBean(selectObject.id,data,key,value,selectvalue);
	                }
	            }
	        });
	    }else{
	        return;
	    }
	}
	
	//查询异地代理商名称
	function getSupplierList(){
	    var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
	    if(ids==undefined)return;
	    document.form.product_supplier.value=ids[0];
	    document.form.product_supplier_name.value=ids[1];
    }
	
    function simpleQuery_onClick(){
        form.action="<%=request.getContextPath()%>/ProductAction.do?cmd=simpleQuery1&date="+new Date();
        form.submit();
    }
    
    function resetQuery(){
        document.form.product_supplier.value="";
        document.form.product_supplier_name.value="";
    }

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/ProductAction.do">
<input type="hidden" name="cmd" value="queryAllProduct">
<input type="hidden" name="backFlag" value="false">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('选择产品','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
            <td width="140" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        </tr>
                
        <tr>
          <td align="right">产品名称</td>
          <td align="left">
            <input type="text" class="text_field" name="product_name" value=""  inputName="产品名称" maxLength="50"/>
          </td>
          <td align="right">产品大类</td>
          <td align="left"><select id="big_type_id" name="big_type_id"><option value="">--请选择--</option></select></td>  
        </tr>
        <tr>
          <td align="right">异地代理商</td>
          <td align="left">
            <input type="text" class="text_field" validators="isSearch"  hiddenInputId="product_supplier" id="product_supplier_name" name="product_supplier_name" inputName="异地代理商"  maxLength="10" value=""/>
            <input type="hidden" id="product_supplier" name="product_supplier" value=""/>
            <img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getSupplierList();"/>
          </td>
          <td align="right">&nbsp;</td>
          <td align="left">
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();resetQuery()">
           </td>
        </tr>
</table>
</div>
                    
<div id="ccParent1" class="button"> 
    <div class="button_right">
         <ul>
            <li class="g">     <a  onClick="javascript:returnvalue();"><fmt:message key="choice"/> </a> </li>
         </ul>
    </div>
</div>
 
 <div id="values_div" class="box_xinzeng_table" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onClick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>
                
                <a href="/FAERP/ProductAction.do?cmd=queryAllProduct&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_name")%>">              </a>    
       
             产品名称</th>
            <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAllProduct&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"scheme_type")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"scheme_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"scheme_type")%>">
            </a>    
       
     方案类型</th>
            <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAllProduct&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"big_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"big_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"big_type_id")%>">
            </a>    
       
     产品大类</th>
        <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAllProduct&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"small_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"small_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"small_type_id")%>">
            </a>    
       
     产品小类</th>
        <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAllProduct&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"three_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"three_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"three_type_id")%>">
            </a>    
       
     产品三级分类</th>
            <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAllProduct&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_price")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_price")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_price")%>">            </a>    
       
     标准价格</th>
        <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAllProduct&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_simple_desc")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_simple_desc")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_simple_desc")%>">            </a>    
       
     产品简单描述</th>
        </tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
        <tr>
        <td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>
        <td><bean:write name="data" property="product_name"/><input type="hidden" id="<bean:write name="data" property="id"/>product_name" value="<bean:write name="data" property="product_name"/>"></td>
        <td>&nbsp;<bean:define id="scheme_type" name="data" property="scheme_type"/>
            
            <%
            String falg="";
            if(scheme_type!=null&&scheme_type.equals("1")){
                    falg="方案-产品";
            }else if(scheme_type!=null&&scheme_type.equals("2")){
                    falg="方案-附件";
            }else{
                    falg="产品";
            }
            out.print(falg);
            %>
            </td>
            <td>&nbsp;<bean:define id="big_type_id" name="data" property="big_type_id"/>
            <%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(big_type_id))%>
            </td>       
            <td>&nbsp;<bean:define id="small_type_id" name="data" property="small_type_id"/>
            <%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(small_type_id))%>
            </td>       
            <td>&nbsp;<bean:define id="three_type_id" name="data" property="three_type_id"/>
            <%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(three_type_id))%>
            </td> 
        <td>&nbsp;<bean:write name="data" property="product_price" format="###,###,###.##"/>   </td>  
        <td>&nbsp;<bean:write name="data" property="product_simple_desc"/></td>  
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

    getAllBigType(document.form.big_type_id,'code','name','<%= bigTypeId!=null ? bigTypeId : "" %>');
    
<%  //表单回写
    if(request.getAttribute(IProductConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IProductConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
