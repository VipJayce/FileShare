<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
    String Medicalkit = request.getAttribute("Medicalkit")==null?"":request.getAttribute("Medicalkit").toString();
Medicalkit = "Medicalkit";
    String f = request.getAttribute("f") == null ? "" : request.getAttribute("f").toString();
    System.out.println("Medicalkit:"+Medicalkit);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh" prefix="rayoo.certificate.certificateTransaction.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择员工</title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("employeeName");
        returnAry[2] = entity.getProperty("employeeCode");
        returnAry[3] = entity.getProperty("employeeCardNumber");
        window.returnValue = returnAry;
        window.close();

    }
    

    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").addParam("employeeCode",$id("employeeCode").value);
          $id("celllist1").addParam("employeeName",$id("employeeName").value);
          $id("celllist1").addParam("employeeCardNumber",$id("employeeCardNumber").value);
          $id("celllist1").addParam("internalCode",$id("internalCode").value);
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
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        var employeeCode = entity.getProperty("employeeCode");
        var employeeName = entity.getProperty("employeeName");
        var returnVal = "{\"id\":\"" + value + "\",\"employeeCode\":\"" 
                                     + employeeCode + "\",\"employeeName\":\""
                                     + employeeName + "\"}";
        return "<input type='checkbox' name='checkbox_template' value='"+value+"' returnVal='"+returnVal+"'>";
    }
    function toOK_onClick() {
        var dc_checkBox = jQuery('input[name="checkbox_template"]:checked');
        if(dc_checkBox.length == 0){
            alert("<fmt:message key='select_records'/>");
            return false;
        }
        var ids = findSelections("checkbox_template","value");  //取得多选框的选择项
        //     var ids = "";
       //     dc_checkBox.each(function(){    
      //         if (ids.length > 0){
     //           ids+=",";
     //        }
      //      ids += jQuery(this).attr("returnVal");
      //  });    
      jQuery.ajax({
                           url: '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=getEmployeeDetail1',
                           type: 'POST',
                           dataType: 'html',
                           data:{ids:"'"+ids+"'"},
                           async: false,
                           timeout: 10000,
                                success: function(data){
                                    window.returnValue=data;
                                    window.close();
                              }
                           });     
    
    }
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
   jQuery(document).ready(function()
   {
        $id("celllist1").isQueryFirst = false;
   }
   );
</script>
    </head>
    <body>
    
    <form name="form" method="post"  id="datacell_formid">
    <input type="hidden" name="backFlag" id="backFlag" value="true">

    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="180" rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            </td>
        </tr>
         <tr>
            <td width="50" align="left"><fmt:message key='identity' /></td>
            <td width="200" align="left">
          <input type="text" class="text_field" name="employeeCode" style="width: 180px;" id="employeeCode" inputName="员工编号" maxLength="25"/>            </td>
          <td width="85" align="left"><fmt:message key='employeeCardNumber' /></td>
            <td width="200" align="left">
          <input type="text" class="text_field" name="employeeCardNumber" style="width: 185px;" id="employeeCardNumber" inputName="员工身份证号码" maxLength="25"/>            </td>
        <td width="85" align="left"><fmt:message key='companyName' /></td>
           <td width="200" align="left">
          <input type="text" class="text_field" name="companyName" style="width: 185px;" id="companyName" inputName="公司名称" maxLength="25"/>            </td>
        </tr>
         <tr>
            <td align="left"><fmt:message key='employeeName' /></td>
            <td align="left">
                <input type="text" class="text_field" name="employeeName" style="width: 180px;"  id="employeeName" inputName="员工姓名" maxLength="50"/>
           </td>
            <td align="left"><fmt:message key='internalCode' /></td>
            <td align="left">
                <input type="text" class="text_field" name="internalCode" style="width: 180px;"  id="internalCode" inputName="客户方编号" maxLength="50"/>
           </td>
           <td></td><td></td>
         </tr>
         <tr>
         <td></td>
         <td></td>
         <td></td><td></td>
         <td rowspan="2" align="left"><input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()"></td>
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:toOK_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
         <div  id="div1" style="margin:5 0 0 10px;">
                            <r:datacell 
                            queryAction="/FAERP/CertificateTransactionAction.do?cmd=getEmployee"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="320px" 
                            xpath="EmployeeSimpleVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="id"  messagekey="Operation"  width="50px" align="center" onRefreshFunc="setCheckboxStatus" ></r:field>
                          <r:field fieldName="employeeCode" messagekey="identity" width="150px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="employeeName"  messagekey="employeeName" width="180px">
                          <h:text />
                          </r:field>
                          <r:field fieldName="employeeCardNumber"  messagekey="employeeCardNumber" width="200px">
                          <h:text />
                          </r:field>
                           <r:field fieldName="internalCode" messagekey="internalCode" width="200px">
                          <h:text />
                          </r:field>
                           <r:field fieldName="companyName" messagekey="companyName" width="200px">
                          <h:text />
                          </r:field>
                        </r:datacell>
            </div>
    </form>
</fmt:bundle>

</body>
</html>
