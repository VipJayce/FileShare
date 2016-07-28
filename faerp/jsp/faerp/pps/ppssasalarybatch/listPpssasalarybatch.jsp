<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>薪资数据查询</title>
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

       function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    function simpleQuery_onClick(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
   
   //跳转到查看页面
      function toDetail_onClick(){
     var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/PpssasalarybatchAction.do?cmd=list2item&batch_id="+ids+"&_ts="+(new Date()).getTime();
        form.submit();
   }
   
   
</script>
</head>
<body>

    <form name="form" method="post" id="datacell_formid" >
        <input type="hidden" name="cmd" value="queryAll" /> 
        <input type="hidden"  name="backFlag" id="backFlag" value="true">
         <input  type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
  <div id="right"><script language="javascript">
    writeTableTopFesco('薪资数据查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">


    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>

            <td />
            <td />
            <td></td>
            <td />
        </tr>
        <tr>
          <td class="td_1" >客户名称</td>
            <td class="td_2"  >
           <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true"  id="lk_cust" lookupUrl="/PpssasalarytempletAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"  />
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
                <input type="hidden" name="customer_code" id="customer_code"/>
            </td>
        <td align="left">薪资模版</td>
            <td align="left">
            <input type="text" class="text_field" id="salary_templet_name" name="salary_templet_name" value="" inputName="薪资模版"  maxLength="25" />
            </td>
            <td align="left" colspan="2">
            <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"/> 
            <input type="reset" class="icon_1" />
            </td>
        </tr>
    </table>
    </div>


    <div id="ccParent1" class="button">
    <div class="button_right"><input class="a" type="button" value="<fmt:message key="view"/>"onClick="toDetail_onClick();"> 
    </div>
    <div class="clear"></div>
    </div>

    <div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
        queryAction="/FAERP/PpssasalarybatchAction.do?cmd=queryPpsSalaryBatch"
        width="98%" height="318px" xpath="PpssasalarybatchVo"
        paramFormId="datacell_formid" >
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center"></r:field>
        <r:field fieldName="cust_name" label="客户名称" width="250px"></r:field>
        <r:field fieldName="salary_templet_name" label="模版名称"  allowModify="false" width="110px"></r:field>
        <r:field fieldName="pay_year_month" label="月份" width="110px"></r:field>
        <r:field fieldName="total_number" label="总人数" width="110px"></r:field>
        <r:field fieldName="total_amount" label="总金额" width="110px" ></r:field>
    </r:datacell></div>

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
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);       
    jQuery("#cust_a_name").val(arg[2]);     
    jQuery("#customer_code").val(arg[1]);   
    return false;
}
</script>	
