<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
   String costid = request.getAttribute("costid")==null?"":request.getAttribute("costid").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择员工</title>
    <script>
    function select_onClick(entity){
        //var entity = choose_row("celllist1");
        var returnAry = new Array(14);
        returnAry[0] = entity.getProperty("receipt_title");
        returnAry[1] = entity.getProperty("customer_code");
        returnAry[2] = entity.getProperty("customer_name");
        returnAry[3] =entity.getProperty("contact_person");
        returnAry[4] =entity.getProperty("contact_address"); 
        returnAry[5] =entity.getProperty("zip_code");
        returnAry[6] =entity.getProperty("contact_tel1");
        returnAry[7] =entity.getProperty("id");
        returnAry[8] =entity.getProperty("taxpayer_identity_type");
        returnAry[9] =entity.getProperty("taxpayer_identification_number"); 
        returnAry[10] =entity.getProperty("tax_registration_bank");
        returnAry[11] =entity.getProperty("tax_registration_bank_account");
        returnAry[12] =entity.getProperty("tax_registration_address");
        returnAry[13] =entity.getProperty("tax_registration_telnum");
        window.returnValue = returnAry;
        window.close();

    }


    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").addParam("customer_code",$id("customer_code").value);
          $id("celllist1").addParam("customer_name",$id("customer_name").value);
          $id("celllist1").loadData();
          $id("celllist1").refresh();
    }

    function choose_row(dcId){
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
    
    <form name="form" method="post"  id="datacell_formid">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
    <input type="hidden" name="costid" id="costid" value="${costid}">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="270" rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            </td>
        </tr>
        <tr>
            <td width="166" align="left">客户编号</td>
            <td width="328" align="left">
          <input type="text" class="text_field" name="customer_code" id="customer_code" inputName="员工编号" maxLength="25"/>            </td>
          <td width="378" rowspan="2" align="left"><input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()"></td>
        </tr>
         <tr>
            <td align="left">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" name="customer_name" id="customer_name" inputName="员工姓名" maxLength="50"/>            </td>
            
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
         <div  id="div1" style="margin:5 0 0 10px;">
                            <r:datacell 
                            queryAction="/FAERP/CustomersimpleAction.do?cmd=getreceiptWithgroup"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="305px" 
                            xpath="CostcenterVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="id" label="成本中心id" width="0px">
                          </r:field>
                          <r:field fieldName="customer_code" label="客户编号" width="150px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="customer_name" label="客户名称" width="300px">
                          <h:text />
                          </r:field>
                             <r:field fieldName="cost_center_name" label="成本中心名称" width="300px">
                          <h:text />
                          </r:field>
                             <r:field fieldName="receipt_title" label="发票抬头" width="300px">
                          <h:text />
                          </r:field>
                           <r:field fieldName="contact_person" label="联系人" width="100px">
                          <h:text />
                          </r:field>
                           <r:field fieldName="contact_address" label="邮寄地址" width="100px">
                          <h:text />
                          </r:field>
                           <r:field fieldName="zip_code" label="邮编" width="100px">
                          <h:text />
                          </r:field>
                           <r:field fieldName="contact_tel1" label="联系电话" width="100px">
                          <h:text />
                          </r:field>
                        </r:datacell>
            </div>
    </form>
</fmt:bundle>

</body>
</html>
<script type="text/javascript">
$id("celllist1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
	select_onClick(entity);
}
</script>
