<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="gap.authority.util.tree.DeepTreeSearch" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.product.vo.ProductVo" %>
<%@ page import="rayoo.system.product.util.IProductConstants" %>
<jsp:useBean id="agentaction" class="rayoo.sales.agent.action.AgentAction" scope="page" />
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
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
    String bigtypeid= (request.getAttribute("big_type_id")!=null) ? request.getAttribute("big_type_id").toString() : "";
    String smalltypeid=(request.getAttribute("small_type_id")!=null) ? request.getAttribute("small_type_id").toString() : "";
    String threetypeid=(request.getAttribute("three_type_id")!=null) ? request.getAttribute("three_type_id").toString() : "";
    String productname= (request.getAttribute("product_name")!=null) ? request.getAttribute("product_name").toString() : "";
    
%>
<html>
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
        form.action="<%=request.getContextPath()%>/ProductAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/ProductAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        var big_type_id=document.form.big_type_id.value;
        if(big_type_id=="--请选择--")big_type_id="";
        var small_type_id=document.form.small_type_id.value;
        if(small_type_id=="--请选择--")small_type_id="";
        var three_type_id=document.form.three_type_id.value;
        if(three_type_id=="--请选择--")three_type_id="";
        form.action="<%=request.getContextPath()%>/ProductAction.do?cmd=simpleQuery&big_type_id="+big_type_id+"&small_type_id="+small_type_id+"&three_type_id="+three_type_id+"&date="+new Date();
        form.submit();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/system/product/insertProduct.jsp";
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
        form.action="<%=request.getContextPath()%>/ProductAction.do?id=" + ids+"&date="+new Date();
        form.cmd.value = "detail";
        form.submit();
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
                    <%
                    if(smalltypeid!=null){
                    %>
                    getAllSmallType(document.form.big_type_id,'small_type_id','code','name','<%=smalltypeid%>');
                    <%}%> 
                }
            }
        });
    }else{
        return;
    }
}


/**
 * 功能描述：动态生成产品小类下拉菜单的内容
 * 参数：selectObject --下拉框对象;
                targetId         -- 下拉框目标对象;
 *              key -- 填充时作为option value的对象属性
 *              value -- 填充时作为option展示的对象属性
 */    
function getAllSmallType(selectObject,targetId,key,value,selectvalue){
    AjaxControl.getSmallTypeId(selectObject.value,{callback:function(data){
            if (data != null && typeof data == 'object') 
            {
                DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                DWRUtil.addOptions(targetId,{'':'--请选择--'});
                setSelectForBean(targetId,data,key,value,selectvalue);
                <%
                    if(threetypeid!=null){
                    %>
                    getAllThreeType(document.form.small_type_id,'three_type_id','code','name','<%=threetypeid%>');
               <%}%>
            }
        }
    });
}


/**
 * 功能描述：动态生成产品三级分类下拉菜单的内容
 * 参数：selectObject --下拉框对象;
                targetId         -- 下拉框目标对象;
 *              key -- 填充时作为option value的对象属性
 *              value -- 填充时作为option展示的对象属性
 */    
function getAllThreeType(selectObject,targetId,key,value,selectvalue){
    AjaxControl.getThreeTypeId(selectObject.value,{callback:function(data){
            if (data != null && typeof data == 'object') 
            {
                DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                DWRUtil.addOptions(targetId,{'':'--请选择--'});
                setSelectForBean(targetId,data,key,value,selectvalue);
            }
        }
    });
}



//设置让利价格
    function setPriceConcessions_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //form.action="<%=request.getContextPath()%>/ProductAction.do?id=" + ids;
        //form.cmd.value = "find";
        //form.submit();
        var url="<%=request.getContextPath()%>/ProductAction.do?cmd=setPriceConcessions&product_id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, "", 500, 350, "设置让利价格");  //增加子岗位
           
    }  
</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/ProductAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('服务产品管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="140" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td width="63"/>
            <td width="173"/>
              <td width="125"></td>
              <td width="221">    </td>
                <td width="143"/>
        </tr>
                
        <tr>
            <td align="right">产品大类</td>
            <td align="left"><select id="big_type_id" name="big_type_id" onchange="javascript:getAllSmallType(this,'small_type_id','code','name')" ><option value="">--请选择--</option></select></td>
            <td align="right">产品小类</td>
            <td align="left"><select id="small_type_id" onchange="javascript:getAllThreeType(this,'three_type_id','code','name')"><option value="">--请选择--</option></select> </td>
            <td align="right">产品三级分类</td>
            <td width="132" align="left"><select id="three_type_id" ><option value="">--请选择--</option></select></td>
        </tr>
        
        <tr>
	          <td align="right">产品名称</td>
	          <td align="left"><input type="text" class="text_field" name="product_name" inputName="产品名称" maxLength="20" value="<%=productname%>"/>
	          </td>
            <td align="right">是否有效</td>
            <td align="left"><d:select dictTypeId="INVALID_STATE" name="invalidstate"  value="${requestScope.invalidstate}" nullLabel="--请选择--"></d:select></td>
            <td align="right">&nbsp;</td>
            <td align="left"><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
              &nbsp;
              <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()"></td>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right"><!--
                <ul>
                    <li class="a">      <a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    <li class="q_1">      <a  onClick="javascript:setPriceConcessions_onClick();">设置让利价格</a> </li>
                </ul>
         -->
         <input class="a" type="button"   value="查看"  <au:authorityBtn code="fwcp_view" type="1"/>  onClick="detail_onClick();">
         <input class="c" type="button"   value="新增"  <au:authorityBtn code="fwcp_add" type="1"/>  onClick="toAdd_onClick();">
         <input class="d" type="button"   value="删除"  <au:authorityBtn code="fwcp_del" type="1"/>  onClick="deleteMulti_onClick();">
         <input class="b" type="button"   value="修改"  <au:authorityBtn code="fwcp_modify" type="1"/>  onClick="findCheckbox_onClick();">
         <input class="q_1" type="button"   value="设置让利价格"  <au:authorityBtn code="fwcp_settPrice" type="1"/>  onClick="setPriceConcessions_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onClick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>
                
                <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_name")%>">
            </a>    
             产品名称</th>
             <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"scheme_type")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"scheme_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"scheme_type")%>">
            </a>    
       
     方案类型</th>
            <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"big_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"big_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"big_type_id")%>">
            </a>    
       
     产品大类</th>
        <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"small_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"small_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"small_type_id")%>">
            </a>    
       
     产品小类</th>
        <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"three_type_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"three_type_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"three_type_id")%>">
            </a>    
       
     产品三级分类</th>
        <!-- 
        <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_scheme")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_scheme")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_scheme")%>">
            </a>    
       
     是否定方案产品</th>

            <th>
                
                <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_cost")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_cost")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_cost")%>">
            </a>    
       
             标准成本</th>
            <th>
                
                <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_price")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_price")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_price")%>">
            </a>    
       
             标准价格</th>
            <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_reimbursement")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_reimbursement")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_reimbursement")%>">
            </a>    
       
     是否可报销</th>
        <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_calculate_per_day")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_calculate_per_day")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_calculate_per_day")%>">
            </a>    
       
     是否按天计算</th>
        <th>
                
                <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_payall")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_payall")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_payall")%>">
            </a>    
       
             是否一次性付款</th>
            <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"onpost_input")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"onpost_input")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"onpost_input")%>">
            </a>    
       
     报岗时间是否可修改</th>
         -->
        <th>
                
                <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_supplier")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_supplier")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_supplier")%>">
            </a>    
       
             产品供应商名称</th>
             <!-- 
            <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_subpay")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_subpay")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_subpay")%>">
            </a>    
       
     是否可补收</th>
      -->
        <th>
                    
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_dept")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_dept")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_dept")%>">
            </a>    
       
     产品所属部门</th>
            <th>
                
                <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_user")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_user")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_user")%>">
            </a>    
       
             创建人</th>
            <th>
                            
                    <a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_date")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_date")%>">
            </a>    
       
            创建日期</th>
            
            <th><a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"invalidstate")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"invalidstate")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_date")%>">
            </a>是否有效</th>
              <th><a href="/FAERP/ProductAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"attachment_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"attachment_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"attachment_id")%>">
            </a> 查看附件</th>
            </tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
        <tr>
        <td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

        <td><bean:write name="data" property="product_name"/>   </td>
        
            <td>&nbsp;
            <bean:define id="scheme_type" name="data" property="scheme_type"/>
            
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
            <td>&nbsp;
             <bean:define id="big_type_id" name="data" property="big_type_id"/>
            <%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(big_type_id))%>
            </td>       
            <td>&nbsp;
            <bean:define id="small_type_id" name="data" property="small_type_id"/>
            <%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(small_type_id))%>
            </td>       
            <td>&nbsp;
            <bean:define id="three_type_id" name="data" property="three_type_id"/>
            <%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(three_type_id))%>
            </td> 
            <!--      
            <td>&nbsp;
            <bean:define id="is_scheme" name="data" property="is_scheme"/>
            <%//=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_scheme))%>
            </td>       
            <td><bean:write name="data" property="product_cost"/>   </td>
            
            <td><bean:write name="data" property="product_price"/>   </td>
            
            <td>&nbsp;
            <bean:define id="is_reimbursement" name="data" property="is_reimbursement"/>
            <%//=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_reimbursement))%>
            </td>       
            <td>&nbsp;
            <bean:define id="is_calculate_per_day" name="data" property="is_calculate_per_day"/>
            <%//=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_calculate_per_day))%>
            </td>
            <td>&nbsp;
            <bean:define id="is_payall" name="data" property="is_payall"/>
            <%//=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_payall))%>
            </td>   
             <td>&nbsp;
            <bean:define id="onpost_input" name="data" property="onpost_input"/>
            <%//=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(onpost_input))%>
            </td>  
             -->  
            <td>&nbsp;
             <bean:define id="product_supplier" name="data" property="product_supplier"/>
             <%= (product_supplier!=null&&product_supplier!="") ? product_supplier.toString() : ""%> 
            
            </td>
            <!--
            <td>&nbsp;
            <bean:define id="is_subpay" name="data" property="is_subpay"/>
            <%//=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_subpay))%>
            </td>    
             -->
             <td>&nbsp;
            <bean:define id="product_dept" name="data" property="product_dept"/>
                <%=(product_dept!=null&&product_dept!="")  ? OrgHelper.getPartyVoByID(product_dept.toString()).getName() : ""%>
            </td> 
            <td>
            <bean:define id="create_user" name="data" property="create_user"/>
                 <%=OrgHelper.getPartyVoByID(create_user.toString()).getName()%>
            </td>
            
           <td><bean:write name="data" property="create_date"  format="yyyy-MM-dd"/>     </td>
           <td>&nbsp;
           <bean:define id="invalidstate" name="data" property="invalidstate"/>
            <%=BaseDataHelper.getNameByCode("INVALID_STATE",String.valueOf(invalidstate))%>
           </td>
            <td>&nbsp;
            <bean:define id="attachment_id" name="data" property="attachment_id"/>
                <%if(attachment_id!=null&&attachment_id!=""){ %>
                 <a href="<%=request.getContextPath()%>/ProductAction.do?cmd=downLoad&attachment_id=<%=attachment_id%>">查看附件</a>
                 <%} %>
            </td>
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
getAllBigType(document.form.big_type_id,'code','name','<%=bigtypeid%>')
<%  //表单回写
    if(request.getAttribute(IProductConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        //out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IProductConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
