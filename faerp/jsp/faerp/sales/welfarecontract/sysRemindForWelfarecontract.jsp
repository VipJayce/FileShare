<%@ page contentType="text/html; charset=UTF-8" %>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.7.2.min.js"></script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%> 
<%@include file="/common/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ISalcontractConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ISalcontractConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    SalcontractVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle basename="rayoo.salse.salcontract.salcontract_resource" prefix="rayoo.salse.salcontract.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    //选择甲方
    function rtnFunc(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_a_name").val(arg[0]);        
        return false;
    } 
     //删除多条记录
	function update_onClick(label)
		{  
		   //从多选框物理删除多条记录
		    var aegnt_check = document.getElementsByName("temp1");
		    var ids = null;  //定义id值的数组
		    if(ids == null) {
		        ids = new Array(0);
		    }
		    for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
		        if(aegnt_check[i].checked){
		            ids.push(aegnt_check[i].value);  //加入选中的checkbox
		        }
		    }
		    if(ids==null||ids==""){
		        alert('<fmt:message key="select_one_record"/>');
		        return;
		    }
		    if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
		      var form=document.getElementById("form");
		      form.action="<%=request.getContextPath()%>/SalcontractAction.do?ids=" + ids+"&label="+label;
		      form.cmd.value = "updateRemindStatus";
		      form.submit();
		    }
		}
	 function setCheckbox(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp1'   value=" + entity.getProperty("id") + ">";
    }
      function checkAllList()
       {
         var element = document.getElementsByName("temp1"); 
         for(var i=0;i<element.length;i++){
             if(element[i].type=="checkbox" && element[i].name=="temp1") {
                 element[i].checked= !element[i].checked ? true : false;
             }
         } 
     } 	 
        //查询
      function qrySalarybatch(){
          $id("dc_inter").reload();
      }

</script>
</head>
<body>
 <form action="" name="form"  id="datacell_formid" method="post" >
	    <input type="hidden" name="cmd" value="queryAll">
	     <input type="hidden" name="backFlag" id="backFlag" value="true">  
	        <div id="right">
         <script language="javascript">
            writeTableTopFesco('<fmt:message key="contract_system_action"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
         </script>
        <div class="ringht_s">
            <div id="ccChild0" class="search">
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="135" rowspan="2" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div></td>
                        <td width="80"><fmt:message key="contract_type"/></td>
                        <td width="220">
                            <d:select dictTypeId="CONTRACT_TYPE_BD"  property="contract_type_bd" id="contract_type_bd" nullLabel="请选择" style="width:190px"/>
                        </td>
                        <td width="80"><fmt:message key="contract_jiafang"/></td>
                        <td width="220"><w:lookup onReturnFunc="rtnFunc" readonly="true" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=queryAllGetByID" messagekey="choose_customer" height="700" width="810"/>
                                 <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                                 <input type="hidden" name="is_sure"  value="0"/></td>
                        <td width="80"><fmt:message key="contract_code"/></td>
                        <td width="220">
                           <input type="text" class="text_field" name="contract_code" inputName="合同编号" maxLength="64"/>
                        </td>
                   </tr>
                   <tr>
                            <td><fmt:message key="contract_name"/></td>
                            <td>
                              <input type="text" class="text_field" name="contract_name" inputName="合同名称" maxLength="50"/>
                            </td>
                            <td><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="batch_query"/>' onClick="javascript:qrySalarybatch()"></td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                    </tr>              
                </table>              
            </div>
            <div id="ccParent1" class="button">
                <div class="button_right">
                    <ul>
                        <li class="b"><a onclick="javascript:update_onClick(1);"><fmt:message key="not_remind"/></a></li>    
                        <li class="b"><a onclick="javascript:update_onClick(2);"><fmt:message key="renew"/></a></li>                    
                    </ul>   
                </div>
                <div class="clear"></div>
            </div> 
            <div style="padding: 8 10 8 8;">
                <r:datacell id="dc_inter"
                    queryAction="/FAERP/SalcontractAction.do?cmd=systemRemindForSalcontract"
                    width="99%" xpath="SalcontractVo" submitXpath="SalcontractVo"
                    paramFormId="datacell_formid" height="318">
                    <r:toolbar location="bottom" tools="nav,pagesize,info" />
                     <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList();' />" width="40px" onRefreshFunc="setCheckbox" >
                     </r:field>  
                    <r:field fieldName="contract_code" messagekey="contract_code" width="300px">
                    </r:field>
                    <r:field fieldName="contract_type_bd" messagekey="contract_type" width="150px">
                         <d:select dictTypeId="CONTRACT_TYPE_BD"></d:select>
                    </r:field>
                    <r:field fieldName="contract_name" messagekey="contract_name" width="200px">
                    </r:field>
                    <r:field fieldName="customer_name" messagekey="contract_jiafang" width="200px">
                    </r:field>
                    <r:field fieldName="contract_start_date" messagekey="contract_start_date" width="300px">
                    </r:field>
                     <r:field fieldName="contract_stop_date" messagekey="contract_stop_date" width="300px">
                    </r:field>
                     <r:field fieldName="" messagekey="approval_information"  width="300px">
                    </r:field>
                     <r:field fieldName="create_date" messagekey="create_date" width="300px">
                    </r:field>                    
             </r:datacell>
           </div>
       </div>
    </div>
	</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(ISalcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISalcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
