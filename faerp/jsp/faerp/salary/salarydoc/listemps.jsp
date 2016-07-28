<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择员工</title>
    <script type="text/javascript">
    function select_onClick(){
        var emp = choose_row("dc_emp");
        var rst = new Array();
        window.returnValue=rst;
        if(emp){
        	rst.push(emp.getProperty("emp_post_id"));
			rst.push(emp.getProperty("emp_id"));
			rst.push(emp.getProperty("emp_code"));
			rst.push(emp.getProperty("emp_name"));
			rst.push(emp.getProperty("bank_name"));
			rst.push(emp.getProperty("account_num"));
			rst.push(emp.getProperty("account_name"));
			rst.push(emp.getProperty("post_status_bd"));
			rst.push(emp.getProperty("province_name"));
			rst.push(emp.getProperty("city_area_name"));
			rst.push(emp.getProperty("bank_type_bd"));
			rst.push(emp.getProperty("send_name"));
			
        	window.close();
        
        }
       

    }
    //简单的模糊查询
    function simpleQuery_onClick(){  
          $id("dc_emp").reload();
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
    
    <form name="form" method="post"  id="empform">
    <input type="hidden" name="clzId" value="${param.clzId }"/>
    <div id="right">
    <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100" rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            
          </td>
        </tr>
         <tr>
          	<td align="left">唯一号</td>
            <td align="left">
                <input class="text_field" name="emp_code" id="t_code" maxLength="50"/>
            </td>
            <td align="left">姓名</td>
            <td align="left">
                <input class="text_field" name="emp_name" id="t_name" maxLength="50"/>
            </td>
         </tr>
         <tr>
         	<td>&nbsp;</td>
         	<td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="center"><input onclick="simpleQuery_onClick()" type="button" class="icon_1" value="查询" /></td>
          </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onclick="select_onClick();">选择</a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
         <div  id="div1" style="margin:5 0 0 10px;">
               <r:datacell 
                   queryAction="/FAERP/SalarydocAction.do?cmd=queryEmps"
                   id="dc_emp"
                   paramFormId="empform" 
                   width="97%" height="305px" 
                   xpath="SalarydocVo"
                   readonly="true"
                   >
                 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                 <r:field fieldName="emp_code" label="唯一号" width="100px">
                 </r:field>
                 <r:field fieldName="emp_name" label="姓名" width="200px">
                 </r:field>
               </r:datacell>
         </div>
	</div>         
    </form>
</body>
</html>

