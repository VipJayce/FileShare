<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><body>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择员工</title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("emp_post_id");
        returnAry[1] = entity.getProperty("emp_code");
        returnAry[2] = entity.getProperty("agent_id");
       returnAry[3] = entity.getProperty("emp_name");
        window.returnValue = returnAry;
        window.close();

    }
    

    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").addParam("emp_name",$id("emp_name1").value);
          $id("celllist1").addParam("emp_code",$id("emp_code1").value);
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
    
  

    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td rowspan="3" >
          <div class="search_title">查询条件</div> </td>
          
        </tr>
        <tr>
            <td  align="left" nowrap="nowrap">员工唯一号</td>
            <td  align="left" >
          <input type="text" class="text_field" name="emp_code1" id="emp_code1" maxLength="25" /> </td>
         
           <td align="left" nowrap="nowrap">员工姓名</td>
            <td align="left" >
                <input type="text" class="text_field" name="emp_name1" id="emp_name1" maxLength="25" /></td>
        </tr>
         <tr>
         <td></td>
         <td></td>
         <td></td>
          <td  align="left"><input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()">
             <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();" ></td>
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
                            queryAction="/FAERP/AgentempaccountAction.do?cmd=getListAgentemp"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="305px" 
                            xpath="AgentEmpSendPostVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="emp_code" label="员工唯一号" width="80px"></r:field>                       
                          <r:field fieldName="emp_name" label="员工姓名" width="80px"></r:field>
                          <r:field fieldName="cust_code" label="客户编号" width="80px"></r:field>                       
                          <r:field fieldName="cust_name" label="客户名称" width="200px"></r:field>
                          <r:field fieldName="emp_status" label="状态" width="60px">
                          <d:select dictTypeId="EMP_STATUS"  ></d:select>
                          </r:field>
                             <r:field fieldName="agent_name" label="供应商名称" width="200px"></r:field>
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
