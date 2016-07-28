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
    <title>选择员工</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
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
        form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?id=" + ids;
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
            form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }

    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/customersimple/insertCustomersimple.jsp";
        form.submit();
    }
    
    
    
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("emp_name");
        window.returnValue=returnAry;
        window.close();

    }
    

    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").addParam("emp_code",$id("emp_code").value);
          $id("celllist1").addParam("emp_name",$id("emp_name").value);
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

    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="237" rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            </td>
        </tr>
        <tr>
            <td width="166" align="left">员工编号</td>
            <td width="328" align="left">
          <input type="text" class="text_field" name="emp_code" id="emp_code" inputName="员工编号" maxLength="25"/>            </td>
          <td width="378" rowspan="2" align="left"><input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()"></td>
        </tr>
         <tr>
            <td align="left">员工姓名</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" id="emp_name" inputName="员工姓名" maxLength="50"/>            </td>
            
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
                            queryAction="/FAERP/FinpaymentAction.do?cmd=getEmployeeList&cust_id=${requestScope.cust_id}"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="305px" 
                            xpath="PB_EMPLOYEEVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="emp_code" label="员工编号" width="220px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="emp_name" label="员工姓名" width="220px">
                          <h:text />
                          </r:field>
                        </r:datacell>
            </div>
    </form>
</fmt:bundle>

</body>
</html>

