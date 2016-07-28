<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<html>
<fmt:bundle basename="rayoo.common.system.system_resource" prefix="rayoo.common.system.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key="choose_ss_fund_group"/></title>
    <script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + ">";
    }
    
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
    
    function simpleQuery_onClick(){
        $id("citypro_init").loadData();
        $id("citypro_init").refresh();
    }
    
    function confirm_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var id= '';
        var name = '';
        var month = '';
        var datacell = $id("citypro_init");
        var dataset = datacell.dataset;
        for(var i=0;i<ids.length;i++){
            var datasettr = dataset.findEntity("id",ids[i]);
            if(i == 0){
                id += ids[i];
                name += datasettr.getProperty("group_name");
                month = datasettr.getProperty("adjust_month");
            }else{
                id += ','+ids[i];
                name += ','+datasettr.getProperty("group_name");
                if(month!=datasettr.getProperty("adjust_month")){
                    alert('<fmt:message key="selected_ss_fund_must_one_adjust_month"/>');
                    return;
                }
            }
        }
        var returnAry = new Array();
        returnAry[0] = ids;
        returnAry[1] = name;
        window.returnValue=returnAry;
        window.close();
    }
</script>
    </head>
    <body>
    
    <form name="form" method="post" id="simpleQuery">

    <div id="right"><script language="javascript">
    writeTableTopFesco('<fmt:message key="choose_ss_fund_group"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">


    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title"><fmt:message key="query_condition"/></div>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key="city"/></td>
            <td align="left">
                <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       messagekey="please_choose" />
            </td>
            <td rowspan="2"><input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"> </td>
       </tr>
       <tr>
            <td align="left"><fmt:message key="ss_fund_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="group_name" inputName="客户名称" maxLength="50"/>
            </td>
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="bc"><a onClick="javascript:confirm_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
    
    <div>
        <r:datacell 
            id="citypro_init"
            queryAction="/FAERP/SecuritygroupAction.do?cmd=findSecuritygroup"
            width="100%"
            xpath="SecuritygroupVo"
            submitXpath="SecuritygroupVo"
            paramFormId="simpleQuery" 
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field  fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus">
            </r:field>     
            <r:field width="150" fieldName="id" messagekey="ss_fund_group_code">
            </r:field>
            <r:field width="250" fieldName="group_name" messagekey="ss_fund_group">
            </r:field>
            <r:field fieldName="city_name" messagekey="city">
            </r:field>
            <r:field fieldName="group_type_bd" messagekey="group_type" allowModify="false">
                <d:select dictTypeId="GROUP_TYPE_BD"/>
            </r:field>
            <r:field fieldName="adjust_month" messagekey="adjust_month">
            </r:field>
            <r:field fieldName="transact_day" messagekey="transact_day" >
            </r:field>
            <r:field fieldName="stop_day" messagekey="stop_day">
            </r:field>
            <r:field fieldName="ss_collection_type_bd" messagekey="ss_collection_type" allowModify="false">
                 <d:select dictTypeId="SS_COLLECTION_TYPE"/>
            </r:field>
            <r:field fieldName="collection_type_bd" messagekey="collection_type" allowModify="false">
                <d:select dictTypeId="COLLECTION_TYPE_BD"/>
            </r:field>
            <r:field fieldName="stop_month_type_bd" messagekey="stop_month_type" allowModify="false">
                <d:select dictTypeId="STOP_MONTH_TYPE_BD"/>
            </r:field>
        </r:datacell>
    </div>
  </div>
</div>
  
</form>
</fmt:bundle>

</body>
</html>
