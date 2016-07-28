<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.ibd.ibdcontractproductemp.util.IIbdContractProductEmpConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle basename="rayoo.ibd.ibdcontractproductemp.ibdcontractproductemp_resource" prefix="rayoo.ibd.ibdcontractproductemp.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="erpsystem"/></title>
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
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function service_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/IbdContractProductEmpAction.do?cmd=serviceEmp&contractId=" + ids;
        window.open(url,'','height=700px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工服务维护');
    }

    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio' name='checkbox_template' value='"+value+"' >";
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
	
	function insertcallBack(reg){
        if(reg=="0"){
            alert("<fmt:message key='operate_success'/>");
        }else if(reg=="-1"){
            return;
        }else{
            alert("<fmt:message key='operate_fail'/>");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" value="true">
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key='ibdcontractproductemp'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
         <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='Query_conditions'/></div> </td>
         <td/>
         <td/>
         <td>    </td>
         <td>    </td>
         <td>    </td>
     </tr>
        <tr>
             <td align="right"><fmt:message key='contract_status_bd'/></td>
            <td align="left">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_status_bd", -1,"CONTRACT_STATUS_BD",""," id=contract_status_bd",false) %> 
            </td>
            <td align="right"><fmt:message key='cust_a'/></td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=${f}" messagekey="select_cust" height="500" width="810"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='contract_code'/></td>
            <td align="left">
                <input type="text" class="text_field" name="contract_code" inputName="合同编号" maxLength="64"/>
            </td>
            <td align="right"><fmt:message key='contract_name'/></td>
            <td align="left">
                <input type="text" class="text_field" name="contract_name" inputName="合同名称" maxLength="50"/>
            </td>
              <td colspan="2">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
        <tr>
            <td/>
          
            <td/>
            <td/>
            
                <td/>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
    <input class="q_1" type="button"   value="<fmt:message key="empService"/>"  <au:authorityBtn code="cont_view" type="1"/>  onClick="service_onClick();">
 </div>
           <div class="clear"></div>            
</div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/IbdContractProductEmpAction.do?cmd=simpleQuery"
        width="98%"
        height="318px"
        xpath="SalcontractVo"
        paramFormId="datacell_formid"
    >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id" messagekey="Operation" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="contract_code" messagekey="contract_code" width="110px">
      </r:field>
      <r:field fieldName="contract_type_bd" messagekey="contract_type_bd" allowModify="false" width="100px">
      <d:select dictTypeId="CONTRACT_TYPE_BD" />
      </r:field>
      <r:field fieldName="contract_name" messagekey="contract_name" width="196px">
      </r:field>
      <r:field fieldName="cust_a_name" messagekey="cust_a" width="196px">
      </r:field>
      <r:field fieldName="contract_start_date" messagekey="contract_start_date" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="contract_stop_date" messagekey="contract_stop_date" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date" allowModify="false">
      <w:date format="YYYY-DD-MM"/>
      </r:field>
      <r:field fieldName="create_user_id" messagekey="create_user" width="80px">
      </r:field>
      <r:field fieldName="contract_status_bd" messagekey="contract_status_bd" allowModify="false" width="100px">
      <d:select dictTypeId="CONTRACT_STATUS_BD" />
      </r:field>
      <r:field fieldName="service_company" messagekey="service_company" allowModify="false" width="100px">
      <d:select dictTypeId="SERVICE_COMPANY" />
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
    if(request.getAttribute(IIbdContractProductEmpConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IIbdContractProductEmpConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
