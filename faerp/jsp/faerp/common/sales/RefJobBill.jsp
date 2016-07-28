<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.customer.util.ICustomerConstants"%>
<%@ page import="rayoo.sales.customer.vo.CustomerVo"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
<%  
    //客户
    CustomerVo custvo = null;  //定义一个临时的vo变量
    custvo = (CustomerVo)request.getAttribute(ICustomerConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    if(custvo==null)
        custvo= new CustomerVo();
    
%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <script language="javascript">
    
    function simpleQuery1_onClick(){
       $id("datacell1").addParam("bill_year_month",$name("bill_year_month").value); 
       $id("datacell1").addParam("bill_code",$name("bill_code").value); 
       $id("datacell1").addParam("cust_code",$name("cust_code").value); 
       $id("datacell1").addParam("cust_name",$name("cust_name").value);
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
     function choose()
    {
        entity=choose_row_public("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("bill_code");
        returnAry[2] = entity.getProperty("bill_amount");
        returnAry[3] = entity.getProperty("bill_year_month");
        returnAry[4] = entity.getProperty("cust_id");
        returnAry[5] = entity.getProperty("cust_name");
        window.returnValue=returnAry;
        window.close();        
    }
    
    function choose_row_public(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }
    
    
</script>
    </head>
    <body>

    <form name="form" id=”datacell_formid“ method="post" action="<%=request.getContextPath()%>/SalcontractAction.do">

    <div id="right">
    <div class="ringht_s">


    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">


        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>
            <td />
            <td />
            <td/>
            <td />
        </tr>



        <tr>
            <td align="right">账单编号</td>
            <td align="left"><input type="text" class="text_field"
                id="bill_code" name="bill_code" inputName="账单编号" maxLength="64" /></td>
            <td align="right">账单年月</td>
            <td align="left"><input type="text" class="text_field"
                id="bill_year_month" name="bill_year_month" inputName="账单年月" maxLength="50" /></td>
            <td align="right"></td>
        </tr>
        <tr>
           <td align="right">客户编号</td>
            <td align="left">
            <input type="text" class="text_field" value="${bean.customer_code }"
                id="cust_code" name="cust_code" inputName="客户编号" maxLength="64" /></td>
              <td align="right">客户名称</td>
            <td align="left"><input type="text" class="text_field" value="${bean.customer_name }"
                id="cust_name" name="cust_name" inputName="客户名称" maxLength="50" /></td>
            <td align="right"></td>
        </tr>
        <tr>
            <td />
            <td />
            <td />
            <td><input name="button_ok" class="icon_1" type="button"
                value='<fmt:message key="query"/>'
                onClick="javascript:simpleQuery1_onClick()"> <input
                name="button_reset" class="icon_1" type="button"
                value='<fmt:message key="reset"/>'
                onClick="javascript:this.form.reset()"></td>
            <td />
        </tr>
    </table>
    </div>





    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript: choose();"><fmt:message
            key="choice" /> </a></li>

    </ul>

    </div>
    <div class="clear"></div>
    </div>
<r:datacell 
        id="datacell1"
       queryAction="/FAERP/FinbillAction.do?cmd=searchOneTimeBills&cust_code=${bean.customer_code }"
        width="100%" height="319px"
        xpath="FinbillVo"
        submitXpath="FinbillVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="bill_code" width="110px" label="账单编号">
       </r:field>    
       <r:field fieldName="bill_year_month" width="80px" label="账单年月">
       </r:field>  
       <r:field fieldName="bill_amount" width="90px" label="账单金额">
       </r:field>  
       <r:field fieldName="version" width="90px" label="账单版本号">
       </r:field>  
       <r:field fieldName="cust_code" width="70px" label="客户编号">
       </r:field>
       <r:field fieldName="cust_id" width="0px" label="客户ID">
       </r:field>
       <r:field fieldName="cust_name" width="150px" label="客户名称">
       </r:field>  
       <r:field fieldName="cost_center_name" width="150px" label="成本中心">
       </r:field> 
    </r:datacell>
    </div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
    
    $id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    choose();
}
</script>
</body>
</html>
