<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.system.securityproduct.vo.SecurityproductVo" %>
<%@ page import="rayoo.system.securityproduct.util.ISecurityproductConstants" %>
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
    function findSelection(radioName, idName) {  //从radio中找出选中的id值列表
        var elementRadio = document.getElementsByName(radioName);  //
        var ids = null;  //定义id值
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].checked) {  //如果被选中
                ids=elementRadio[i].value;  
            }
        }
        return ids;
    }

    function simpleQuery_onClick(){  //简单的模糊查询
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }

    function editjishuCheckbox_onClick() {
        var ids = $id("ids_1").value;  //siqp修改,获取选中的id
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var frame = document.getElementById("listFrame");
        frame.src="<%=request.getContextPath()%>/jsp/faerp/system/securityproduct/securityproductview/viewList1.jsp?security_product_id=" + ids;
        
        //form.action="<%//=request.getContextPath()%>/SecurityproductitemAction.do?cmd=simpleQuery1&security_product_id=" + ids;
        //form.target="listFrame";
        //form.submit();
    } 
    
    function checkradio(id){  //简单的模糊查询
        var elementRadio = document.getElementsByName("radio_template");  
       
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].value==id) {  //如果被选中
                elementRadio[i].checked=true;  
                break;
            }
        }
        var frame = document.getElementById("listFrame"); 
        frame.src="<%=request.getContextPath()%>/SecurityproductitemAction.do?cmd=simpleQuery1&security_product_id=" + id;
        
        //form.action="<%=request.getContextPath()%>/SecurityproductitemAction.do?cmd=simpleQuery1&security_product_id=" + id;
        //form.target="listFrame";
        //form.submit();
    }
   
  //siqp添加↓
 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='radio_template'   onClick=click_row(\"" + entity.getProperty("id") + "\");>";
    }
    
    function click_row(value){
        $id("ids_1").value=value;
        editjishuCheckbox_onClick();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="ids_1" id="ids_1" value="">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-size: 14px">

            <tr>
            <td width="175" rowspan="2" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
             <td width="202" align="right">省市&nbsp;&nbsp;</td>
            <td width="180" align="left">
             <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
            </td>
            <!--<td width="202" align="right">省市&nbsp;</td>
            <td width="180" align="left">
            <faerp:cityTag  hasSearchTag="true"  tagname="city_id"/>
            </td>
           <td width="249" align="right">社保公积金产品&nbsp;</td>
            <td width="511" align="left"><faerp:securityGroupSelectTag beanname="product_id" attribute="product_id"/></td> -->
            <td width="249" align="right">社保公积金产品&nbsp;&nbsp;</td>
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
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">            </td>
                <td/>
        </tr>
</table>
</div>

<div style="padding: 8 10 8 8;">
<r:datacell id="datacell1"
        queryAction="/FAERP/SecurityproductAction.do?cmd=queryAll1"
        width="98%" height="320px" xpath="SecurityproductVo"
         paramFormId="datacell_formid">
         <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="id" label="" width="30px" 
            onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>
        <r:field fieldName="city_id" label="城市" width="80px"  allowModify="false">
            <r:comboSelect id="countryList" name="city_id1"
                queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name"
                valueField="id" xpath="PB_CITYVo" width="150px" nullText="请选择" />
        </r:field>
        <r:field fieldName="product_id" width="100px" label="社保公积金产品" allowModify="false">
        <r:comboSelect id="product_id1" name="product_id1"
                       queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       nullText="请选择" 
                       />
        </r:field>
        <r:field fieldName="product_name" label="社保产品比例名称" width="150px">
        </r:field>
        <r:field fieldName="e_ratio" label="公司比例" >
        </r:field>
        <r:field fieldName="p_ratio" label="个人比例" >
        </r:field>
        <r:field fieldName="e_add_ratio" label="公司附加金额" width="120px">
        </r:field>
        <r:field fieldName="p_add_ratio" label="个人附加金额" width="120px" >
        </r:field>
        <r:field fieldName="e_caculate_type_bd" label="公司舍入原则" allowModify="false">
            <d:select dictTypeId="E_CACULATE_TYPE_BD" extAttr="validateAttr='allowNull=false'" />
        </r:field>
        <r:field fieldName="p_caculate_type_bd" label="个人舍入原则" allowModify="false">
            <d:select dictTypeId="P_CACULATE_TYPE_BD" extAttr="validateAttr='allowNull=false'" />
        </r:field>
        <r:field fieldName="e_precision_bd" label="公司精度" allowModify="false">
            <d:select dictTypeId="E_PRECISION_BD" extAttr="validateAttr='allowNull=false'" />
        </r:field>
        <r:field fieldName="p_precision_bd" label="个人精度" allowModify="false">
            <d:select dictTypeId="P_PRECISION_BD" extAttr="validateAttr='allowNull=false'" />
        </r:field>
        <r:field fieldName="e_parity_bd" label="公司奇偶限定" allowModify="false">
            <d:select dictTypeId="E_PARITY_BD" extAttr="validateAttr='allowNull=false'"  />
        </r:field>
        <r:field fieldName="p_parity_bd" label="个人奇偶限定" allowModify="false">
            <d:select dictTypeId="P_PARITY_BD"
                extAttr="validateAttr='allowNull=false'"  />
        </r:field>
        <r:field fieldName="charge_frequency_bd" label="收费频率" allowModify="false">
            <d:select dictTypeId="CHARGE_FREQUENCY_BD" extAttr="validateAttr='allowNull=false'" />
        </r:field>
        <r:field fieldName="is_outstrip_limit_bd" label="是否超上下限" allowModify="false">
            <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'" />
        </r:field>
        <r:field fieldName="yearly_pay_month" label="年缴费月" >
        </r:field>
        <r:field fieldName="product_explanation" label="产品说明"> 
        </r:field>
        <r:field fieldName="remark" label="备注">
        </r:field>
    </r:datacell>
    </div>
</form>
<iframe  name="listFrame" id="listFrame"   frameborder="0" scrolling="yes" width="100%" align="top" height="100%">
</iframe>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
