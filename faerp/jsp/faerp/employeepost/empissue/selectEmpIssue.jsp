<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择员工</title>
    <script language="javascript">
    
       //选择一条记录
        function select_onClick(){
            var entity=choose_row("celllist1");
         
            var returnAry = new Array();
           
                //返回员工信息
            //    returnAry[0] = entity.getProperty("emp_id");
                returnAry[0] = entity.getProperty("emp_code");
                returnAry[1] = entity.getProperty("emp_name");
                returnAry[2] = entity.getProperty("emp_id_card");
              //  returnAry[4] = entity.getProperty("emp_post_id");
                returnAry[3] = entity.getProperty("cust_code");
               returnAry[4] = entity.getProperty("cust_name");
             //   returnAry[4] = entity.getProperty("user_name");  //客服名称
            
            window['returnValue'] =  returnAry;
            window.close();
        }
        
        //查询
        function simpleQuery_onClick(){  //简单的模糊查询
              $id("celllist1").loadData();
              $id("celllist1").refresh();
        }
        
        //返回选择的记录
        function choose_row(dcId){
            var dc = $id(dcId);
            var obj = dc.getActiveEntity();
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
                <td width="270" rowspan="3" style="padding-top: 0;">
                    <div class="search_title">查询条件</div> 
                </td>
            </tr>
            
          
                <tr>
                    <td width="166" align="left">员工姓名</td>
                    <td width="328" align="left">
                        <input type="text" class="text_field" name="emp_name" id="emp_name" inputName="员工姓名"  />         
                    </td>
                    <td width="166" align="left">客户名称</td>
                    <td width="328" align="left">
                        <input type="text" class="text_field" name="cust_name" id="cust_name" inputName="客户名称" />        
                    </td>
                </tr>
                 <tr>
                    <td align="left">员工编号</td>
                    <td align="left">
                        <input type="text" class="text_field" name="emp_code" id="emp_code" inputName="员工编号"  />      
                    </td>
                    <td align="left">身份证号</td>
                    <td align="left">
                        <input type="text" class="text_field" name="id_card" id="id_card" inputName="员工身份证" />          
                    </td>
                    
                    <td width="378" rowspan="8" align="left" >
                          <input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()">
                     </td>
                 </tr>
            
             
             
             
        </table>
    </div>
    
    <div id="ccParent1" class="button">
        <div class="button_right">
            <ul>
                <li class="g"><a onClick="javascript:select_onClick();">确定</a></li>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    <input type="hidden" id="type" value="${type}">
    <div  id="div1" style="margin:5 0 0 10px;">
        <c:if test="${type ==1}">
              <r:datacell 
              queryAction="/FAERP/EmpIssueAction.do?cmd=searchEmpPostData"
              id="celllist1"
              paramFormId="datacell_formid" 
              width="97%" height="305px" 
              xpath="EmpMaterialVo"
              readonly="true"
              >
                <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                <r:field fieldName="emp_post_id" label="员工入离职id" width="0px">
                </r:field>
                <r:field fieldName="emp_id" label="员工id" width="0px">
                </r:field>
                <r:field fieldName="cust_code" label="客户编号" width="100px">
                </r:field>
                <r:field fieldName="cust_name" label="客户名称" width="150px">
                </r:field>
                <r:field fieldName="emp_code" label="员工编号" width="100px">
                </r:field>
                <r:field fieldName="emp_name" label="姓名" width="100px">
                </r:field>
                <r:field fieldName="post_status_bd" label="状态" width="50px"  allowModify="false">
                      <d:select dictTypeId="POST_STATUS_BD" />
                </r:field>
                <r:field fieldName="emp_id_card" label="证件号码" width="150px">
                </r:field>
                 <r:field fieldName="user_name" label="客服" width="100px">
                </r:field>
            </r:datacell>
        </c:if>
        
      
        
   </div>
</form>
</body>
</html>
<script type="text/javascript">
$id("celllist1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>
