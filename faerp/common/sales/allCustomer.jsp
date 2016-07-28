<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@ page import="rayoo.sales.customer.util.ICustomerConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     function simpleQuery_onClick(){
        $id("datacell1").addParam("customer_code",$id("customer_code").value); 
        $id("datacell1").addParam("customer_name",$id("customer_name").value); 
        $id("datacell1").addParam("customer_type",$name("customer_type").value); 
        $id("datacell1").addParam("trade_type",$name("trade_type").value); 
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='id'   onClick=ClickRow(\"" + escape(entity.getProperty("customer_code")) + "\",\"" + escape(entity.getProperty("customer_name")) + "\");>";
    }
   function ClickRow(custcode,custname){
        document.getElementById('custcode').value=unescape(custcode);
        document.getElementById('custname').value=unescape(custname);
    }
    function choose()
    {
          var custcode=document.getElementById('custcode').value;
          var custname=document.getElementById('custname').value;
          var returnAry = new Array();
          returnAry[0]=custcode;
          returnAry[1]=custname;
          window.returnValue=returnAry;
          window.close();
        
    }
</script>
 

</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/CustomerAction.do">
 
<div id="right">
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>
                <tr>
            <td align="left">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_code"  name="customer_code" value="" inputName="客户编号"/>
            </td>
             <td align="left">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_name" name="customer_name" value="" inputName="客户名称"/>
            </td>
        </tr>
        <tr>
             <td align="left">客户类别</td>
            <td align="left">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("customer_type", -1,"CUSTOMER_TYPE","","",false) %> 
            </td>
            <td align="left">行业类别</td>
            <td align="left">
               <%=gap.rm.tools.helper.RmJspHelper.getSelectField("trade_type", -1,"TRADE_TYPE","","",false) %>
            </td>
          
        </tr>
        <tr>
                <td/>
                <td/>
                <td/>
              <td align="left">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                  <input type="reset" class="icon_1"  />
                </td>

        </tr>
</table>
</div>
 <div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                        <li class="a">   <a  onClick="javascript:choose();"><fmt:message key="choice"/> </a> </li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
<input type="hidden" id="custcode" name="custcode"/>
<input type="hidden" id="custname" name="custname"/>
 <r:datacell 
        id="datacell1"
       queryAction="/FAERP/CustomerAction.do?cmd=simpleQuery1"
        width="100%" height="319px"
        xpath="CustomerVo"
        submitXpath="CustomerVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
      <r:field fieldName="customer_code" width="150px" label="客户编号">
       </r:field>    
      <r:field fieldName="customer_name" width="250px" label="客户名称">
      </r:field>
       <r:field fieldName="customer_type" width="150px" label="客户类别">
       <d:select dictTypeId="CUSTOMER_TYPE" />
      </r:field>
       <r:field fieldName="trade_type" width="150px" label="行业类别">
       <d:select dictTypeId="TRADE_TYPE" />
      </r:field>
    </r:datacell>

                    

</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<% //表单回写
    if(request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICustomerConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>	
