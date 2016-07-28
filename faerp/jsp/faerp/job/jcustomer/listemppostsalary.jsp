<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工管理</title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("celllist1");
        
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("employee_id");
        returnAry[1] = entity.getProperty("salary");
        returnAry[2] = entity.getProperty("emp_name"); 
          // returnAry[3] = entity.getProperty("emp_post_id");
          var url="<%=request.getContextPath()%>/JcustomerAction.do?cmd=isValide&employee_id=" + returnAry[0];
            jQuery.post(url,function(data){
               if(data){
                   if(data!=0){
                       alert("此员工关联重复，请重新选取员工");
                       return;
                   }else{
                       window.returnValue = returnAry;
                        window.close();
                   }
               }else{
               alert("关联员工错误，请重试");
                  window.close();
               }
            
            });
          
       

    }
    

    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").loadData();
          $id("celllist1").refresh();
    }
        function reset_onClick(){  //简单的模糊查询
              document.getElementById("emp_code").value="";
              document.getElementById("emp_name").value="";  
                document.getElementById("cust_a_id").value="";
                $id("lk_cust").setDisplayValue("");
                $id("lk_cust").setValue("");
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
    //选择客户
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);      
    jQuery("#cust_a_name").val(arg[2]);       
    return false;
}

</script>
    </head>
    <body>
    
    <form name="form" method="post"  id="datacell_formid">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
<div id="right">
<div class="ringht_s">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
            <td width="270" rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            </td>
        </tr>
        <tr>
            <td  align="left" nowrap="nowrap">员工唯一号</td>
            <td  align="left">
          <input type="text" class="text_field" name="emp_code" id="emp_code" inputName="员工唯一号" maxLength="25"/>            </td>
          <td align="left">员工姓名</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" id="emp_name" inputName="员工姓名" maxLength="50"/>            </td>
        
        </tr>
         <tr>
              <td align="left">客户名称</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px"      displayValue="${bean.cust_name}" value="${bean.id}" readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" height="360" width="600"
                />
             
                <input type="hidden" name="cust_a_id" id="cust_a_id" value="${bean.id }"/>
            </td>
              <td align="left"><input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()"></td>
              
              <td align="left"><input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:reset_onClick()"></td>

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
                            queryAction="/FAERP/JcustomerAction.do?cmd=getEmppost"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="305px" 
                            xpath="JcustomerVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="emp_code" label="员工编号" width="100px">  </r:field>
                          <r:field fieldName="emp_name" label="员工名称" width="100px"></r:field>
                          <r:field fieldName="salary" label="员工薪资" width="100px"></r:field>
                          <r:field fieldName="cust_name" label="所属客户" width="300px"></r:field>
                           
                        </r:datacell>
            </div>
            </div>
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
