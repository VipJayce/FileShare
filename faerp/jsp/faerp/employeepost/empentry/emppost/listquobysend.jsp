<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key="choose_quotation"/></title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
    <script language="javascript">
    
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("quotation_name");
        window.returnValue=returnAry;
        window.close();

    }
    

    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").addParam("quotation_code",$id("quotation_code").value);
          $id("celllist1").addParam("quotation_name",$id("quotation_name").value);
          //$id("celllist1").addParam("quotation_status",$id("quotation_status").value);
          $id("celllist1").loadData();
          $id("celllist1").refresh();
    }
    
    function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("<fmt:message key="select_records"/>");
           return;
        }
     return obj;
    }

</script>
    </head>
    <body>
    
    <form name="form" method="post"  id="datacell_formid">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
    <input type="hidden" name="send_id" id="send_id" value="${requestScope.send_id}"/>

    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="137" rowspan="3" style="padding-top: 0;">
          <div class="search_title"><fmt:message key="query_condition"/></div>            </td>
        </tr>
        <tr>
            <td width="86" align="left"><fmt:message key="quotation_code"/></td>
            <td width="188" align="left">
                <input type="text" class="text_field" name="quotation_code" id="quotation_code" inputName="报价单编号" maxLength="15"/>
            </td>
            <td align="left"><fmt:message key="quotation_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="quotation_name" id="quotation_name" inputName="报价单姓名" maxLength="50"/>
            </td>
          </tr>
          <!-- 
         <tr>
            <td align="left">报价单状态</td>
            <td align="left">
                <select name="quotation_status" class="sSelect" id="quotation_status">
                    <option value="">请选择</option>
                    <option value="1">审批中</option>
                    <option value="2">驳回</option>
                    <option value="3">生效</option>
                </select>
            </td>
             -->
            <td width="378" colspan="4" align="center"><input name="button_ok" class="icon_1" type="button" value="<fmt:message key="query"/>" onClick="javascript:simpleQuery_onClick()"></td>
        
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
                            queryAction="/FAERP/EmppostAction.do?cmd=getQuotationBySend&send_id=${requestScope.send_id}"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="305px" 
                            xpath="QuotationVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="quotation_code" messagekey="quotation_code" width="180px">
                          </r:field>
                          <r:field fieldName="quotation_name" messagekey="quotation_name" width="300px">
                          </r:field>
                          <r:field fieldName="customer_name" messagekey="cust_name" width="280px">
                          </r:field>
                        </r:datacell>
            </div>
    </form>
</fmt:bundle>

</body>
</html>
<script type="text/javascript">
$id("celllist1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>
