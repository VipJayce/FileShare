<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
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
<title>登录用户邮件管理</title>
<script language="javascript">
  function findSelections(checkboxName) {  //从列表中找出选中的id值列表
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
    
    //修改按钮事件
	function findCheckbox_onClick(){
		var userCard = findSelections("checkbox_template");  //取得多选框的选择项
		if(userCard == null) {  //如果ids为空
			alert('<fmt:message key="select_one_record"/>');
			return;
		}
		if(userCard.length > 1) {  //如果ids有2条以上的纪录
			alert('<fmt:message key="only_can_a_record"/>');
			return;
		}
		$id("datacell1").isModefied = false;
        var url="<%=request.getContextPath()%>/PpsuserloginemailmanagerAction.do?cmd=find&userCard=" + userCard;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 800, 200, "修改登录用户邮件"); 
	}
   
    function importExcel_onClick(){
         var url = "<%=request.getContextPath()%>/jsp/faerp/pps/ppsuserloginemailmanager/importExcel.jsp";
         showModalCenter(url, window,simpleQuery_onClick,750,200,"导入批量修改信息");
    }
    
    function exportExcel_onClick() {
    	if(confirm('是否确定要导出数据？')) {
	    	document.form.action="<%=request.getContextPath()%>/PpsuserloginemailmanagerAction.do?cmd=exportToExcelPwd";
	        document.form.submit();
      	}
      	simpleQuery_onClick();
    }
   
    function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];      
        return false;
    }
</script>
</head>
<body>

    <form name="form" method="post" id="datacell_formid" >
        <input type="hidden" name="cmd" value="queryAll" /> 
        <input type="hidden"  name="backFlag" id="backFlag" value="true">
         <input  type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
  <div id="right"><script language="javascript">
    writeTableTopFesco('登录用户邮件管理','<%=request.getContextPath()%>/');  //显示本页的页眉
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
            <td class="td_1" >用户名称</td>
            <td class="td_2"><input type="text" class="text_field" name="userName" id="userName"/></td>
            <td class="td_1" >用户身份证</td>
            <td class="td_2"  ><input type="text" class="text_field" name="userCard" id="userCard" /></td>
            <td class="td_1">是否导出</td>
            <td class="td_2">
            <d:select dictTypeId="TrueOrFalse" name="is_export" id="is_export" nullLabel="--请选择--" value=""/>
            </td>
        </tr>
        <tr>
            <td class="td_1">是否禁用</td>
            <td class="td_2"><d:select dictTypeId="DELFLAG" name="delflag" id="delflag" nullLabel="--请选择--" value=""/></td>
            <td class="td_1">状态</td>
            <td class="td_2"><d:select dictTypeId="ISLEAVE" name="isLeave" id="isLeave" nullLabel="--请选择--" value=""/></td>
            <td class="td_1">客户名称</td>
            <td class="td_2">
            <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" name="custName" id="lk_cust" lookupUrl="/PpssasalarytempletAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="500" width="810"/>
            </td>
        </tr>
        <tr>
        <td colspan="4">&nbsp;</td>
        	<td colspan="2" align="left">
            <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"/> 
            <input type="reset" class="icon_1" />
            </td>
        </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
	    <input class="b" type="button" value="修改" onClick="findCheckbox_onClick();"> 
	    <input class="e_2" type="button" value="批量导入修改" onClick="importExcel_onClick();">
	    <input class="e_3" type="button" value="密码导出" onClick="exportExcel_onClick();">
    </div>
    <div class="clear"></div>
    </div>

    <div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
        queryAction="/FAERP/PpsuserloginemailmanagerAction.do?cmd=queryPpsuserloginemailmanager"
        width="98%" height="318px" xpath="PpsuserloginemailmanagerVo"
        paramFormId="datacell_formid">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="userCard" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center"></r:field>
        <r:field fieldName="userName" label="用户名称"></r:field>
        <r:field fieldName="userCard" label="用户身份证"></r:field>
        <r:field fieldName="userType" label="用户类型"  allowModify="false">
        <d:select dictTypeId="USERTYPE" />
        </r:field>
        <r:field fieldName="delflag" label="是否禁用" allowModify="false">
         <d:select dictTypeId="DELFLAG" />
            </r:field>
            <r:field fieldName="empName" label="员工真实姓名"></r:field>
            <r:field fieldName="corporationName" label="公司名称"></r:field>
            <r:field fieldName="userEmail" label="用户email"></r:field>
            <r:field fieldName="userSole" label="用户唯一号"></r:field>
            <r:field fieldName="userDates" label="用户入职时间">
            <w:date format="yyyy-MM-dd" />
            </r:field>
            <r:field fieldName="userHome" label="用户住址"></r:field>
             <r:field fieldName="userTel" label="用户电话"></r:field>
             <r:field fieldName="userLinkman" label="用户联系人"></r:field>
             <r:field fieldName="isLeave" label="状态">
             <d:select dictTypeId="ISLEAVE" />
             </r:field>
              <r:field fieldName="activetevalidity" label="激活有效期"></r:field>
              <r:field fieldName="userCode" label="用户编号"></r:field>
              <r:field fieldName="is_export" label="是否导出" allowModify="false">
              <d:select dictTypeId="TrueOrFalse"/>
              </r:field>
              <r:field fieldName="customer_name" label="客户名称"></r:field>
              <r:field fieldName="customer_code" label="客户编号"></r:field>
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
