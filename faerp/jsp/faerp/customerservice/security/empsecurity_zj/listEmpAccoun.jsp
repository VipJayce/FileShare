<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择公积金帐号</title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        if(entity == null){
            return false ;
        }
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("accountid");
        returnAry[1] = entity.getProperty("account");
        window.returnValue=returnAry;
        window.close();
    }
    //function update_onClick() {
     // entity=choose_row("celllist1");
     // var returnAry = new Array();
     // var accountid  = entity.getProperty("accountid");
     // var account = entity.getProperty("account");
     // var security_id = $id("security_id").value ;
    //}
    
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
    
    <form name="datacell_formid" method="post"  id="datacell_formid">
    <input  name="emp_id" id="emp_id" type="hidden" value="${requestScope.emp_id}"/>
    <input  name="social_group_id" id="social_group_id" type="hidden" value="${requestScope.social_group_id}"/>
    <input type="hidden" name="backFlag" id="backFlag" value="true" >

    <div id="ccChild0" class="search">
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g">
            <a onClick="javascript:select_onClick();"><fmt:message key="confirm" /></a>
        </li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
        
        
                            <r:datacell 
                            queryAction="/FAERP/EmpserviceitemAction.do?cmd=getEmpAccountList"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="255px" 
                            xpath="EmpAccountVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="account" label="公积金账号" width="150px">
                            <h:text />
                          </r:field>
                        </r:datacell>
            
    </form>
</fmt:bundle>

</body>
</html>

