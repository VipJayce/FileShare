<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listModifyHousingEmpsecurity_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listModifyHousingEmpsecurity0000'/></title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listModifyHousingEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                //alert(elementCheckbox[i].value);
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                number += 1;  //游标加1
               if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listModifyHousingEmpsecurity0062'/><fmt:message key='listModifyHousingEmpsecurity0010'/>页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listModifyHousingEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  

    //检查<fmt:message key='listModifyHousingEmpsecurity0006'/>没<fmt:message key='listModifyHousingEmpsecurity0006'/>选择行,<fmt:message key='listModifyHousingEmpsecurity0008'/>,<fmt:message key='listModifyHousingEmpsecurity0009'/>“<fmt:message key='listModifyHousingEmpsecurity0010'/>”<fmt:message key='listModifyHousingEmpsecurity0011'/>
    function checkSelections(checkboxName) {
        var elementCheckbox = document.getElementsByName(checkboxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                if(enCur.getProperty("security_status_bd")!='3'){
                    alert("<fmt:message key='listModifyHousingEmpsecurity0013'/>");
                    return false;
                }
                if(enCur.getProperty("insert_back_reason")==null||enCur.getProperty("insert_back_reason")==""){
                    alert("<fmt:message key='listModifyHousingEmpsecurity0014'/>");
                    return false;
                }
            }
        }
        return true;
    }
    //简单的模糊查询
    function simpleQuery_onClick(){  
        //$id("com2").refresh();
    
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + " />";
    }
    
    function changeCheck(rowNo,checkB){
        //alert(checkB.value + "" + rowNo);
        //alert(rowNo);
        var enCur = $id("datacell1").dataset.get(rowNo);
        $id("datacell1").isModefied = true;
        enCur.status = Entity.STATUS_MODIFIED;
    }
    
//操作
//<fmt:message key='listModifyHousingEmpsecurity0069'/>
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listModifyHousingEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
//<fmt:message key='listModifyHousingEmpsecurity0070'/>    <fmt:message key='listModifyHousingEmpsecurity0018'/>
function show_detail_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listModifyHousingEmpsecurity0006'/>2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    var curId = '' + ids[0];
    var entity1 = $id("datacell1").dataset.findEntity("id", curId);
    var report_month = entity1.getProperty("fund_month");
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&applytype=1&id="+ids[0]+"&report_month="+report_month+"&isModify=2";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE<fmt:message key='listModifyHousingEmpsecurity0022'/>
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金查看');
    //showModalCenter(url, window, callBack, 1024, 450, "<fmt:message key='listModifyHousingEmpsecurity0023'/>");
}

//停办
function stop_onClick(){
     if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('<fmt:message key='listModifyHousingEmpsecurity0025'/>')) {
                $id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}

//<fmt:message key='listModifyHousingEmpsecurity0072'/>openFailed_onClick(
function openFailed_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    /*if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listModifyHousingEmpsecurity0006'/>2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }*/
    if(!checkSelections('checkbox_template')){
        return;        
    }
    if(confirm('<fmt:message key='listModifyHousingEmpsecurity0029'/>')) {
            //$id('Method').value="batchback";
            $id("datacell1").submit();//提交       
    }
      /* 
      var action = "<%=request.getContextPath()%>/ReporttaxAction.do?cmd=updateReportTaxInfo";
      var xmlSubmit = datacell.dataset.toString();
      var myAjax = new Ajax(action);
      myAjax.addParam('os_id', osArray[1]);
      myAjax.submitXML(xmlSubmit, 'UTF-8');
      var returnNode = myAjax.getResponseXMLDom();
      if( returnNode ) {
          if(myAjax.getValue("root/data/returnValue") == "0") {
          }else{
          }
      }
    */
}
//进入<fmt:message key='listModifyHousingEmpsecurity0010'/>页面
function modify_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listModifyHousingEmpsecurity0006'/>2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0]+"&isModify=1&applytype=1";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE<fmt:message key='listModifyHousingEmpsecurity0022'/>
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金修改');
    //showModalCenter(url, window, callBack, 1024, 450, "<fmt:message key='listModifyHousingEmpsecurity0000'/>");
}

function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        setTimeout(simpleQuery_onClick,4000);
    }
}
 //<fmt:message key='listModifyHousingEmpsecurity0077'/>
 function exportExcel_onClick(){  //<fmt:message key='listModifyHousingEmpsecurity0077'/>Excel
       var queryType=document.getElementById("queryType").value;
       // var stopType=document.getElementById("stopType").value;
       var group_id=document.getElementById("security_group_id").value;
       form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcel7&queryType="+queryType+"&stopType="+""+"&group_id="+group_id;
       form.submit();
}
    
     //查看<fmt:message key='listModifyHousingEmpsecurity0036'/>
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '<fmt:message key='listModifyHousingEmpsecurity0036'/>');  //查看<fmt:message key='listModifyHousingEmpsecurity0036'/>
        window.open('<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id='+id+'&flag=true','','height=830px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" id="Method" name="Method" value=""/>
<!--<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_2 %>">-->
<input type="hidden" id="queryType" name="queryType" value="modify"/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key='listModifyHousingEmpsecurity0000'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
              <td align="right"><fmt:message key='listModifyHousingEmpsecurity0071'/></td>
              <td align="left">
                     <select id="security_group_id" name="security_group_id" style="width: 200px" >
                        <option value="0" selected="selected"><fmt:message key='listModifyHousingEmpsecurity0038'/></option>
                        <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message key='listModifyHousingEmpsecurity0039'/></option>
                        <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message key='listModifyHousingEmpsecurity0040'/></option>
                    </select>
              </td>
              <td align="right"><fmt:message key='listModifyHousingEmpsecurity0041'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listModifyHousingEmpsecurity0041'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listModifyHousingEmpsecurity0043'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listModifyHousingEmpsecurity0043'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listModifyHousingEmpsecurity0045'/></td>
              <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listModifyHousingEmpsecurity0043'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
              <td align="right"><fmt:message key='listModifyHousingEmpsecurity0047'/></td>
              <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="<fmt:message key='listModifyHousingEmpsecurity0047'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listModifyHousingEmpsecurity0049'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listModifyHousingEmpsecurity0049'/>" maxLength="64" size="25"/>
            </td>
            <td align="right"><fmt:message key='listModifyHousingEmpsecurity0051'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listModifyHousingEmpsecurity0051'/>" maxLength="50" size="25"/>
            </td>
              <td align="right"><fmt:message key='listModifyHousingEmpsecurity0053'/></td>
              <td align="left">
                <input type="text" class="text_field" name="receive_cs_name" inputName="<fmt:message key='listModifyHousingEmpsecurity0053'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
        <!--  
            <td align="right"><fmt:message key='listModifyHousingEmpsecurity0055'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_account" inputName="<fmt:message key='listModifyHousingEmpsecurity0043'/>" maxLength="20" size="25"/>
            </td>
            -->
            <td align="right"><fmt:message key='listModifyHousingEmpsecurity0057'/></td>
            <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                        queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                        textField="hire_unit_short_name" 
                        valueField="id" 
                        xpath="SocialunitVo"
                        messagekey='listModifyHousingEmpsecurity0038'
                        width="205px">
                    </r:comboSelect> 
            </td>
            <td align="right"><fmt:message key='listModifyHousingEmpsecurity0011'/></td>
            <td align="left">
                    <d:select name="security_status_bd" dictTypeId="SECU_MODIFY_STA" nullLabel="--请选择--" style="width: 205px"/>
              </td>
              <td align="right"><fmt:message key='listModifyHousingEmpsecurity0061'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="transact_date_from" size="8"/><fmt:message key='listModifyHousingEmpsecurity0062'/><w:date format="yyyy-MM-dd" name="transact_date_to" size="8" />
            </td>
             <td align="right"><fmt:message key='listModifyHousingEmpsecurity0063'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="stop_date_from" size="8"/><fmt:message key='listModifyHousingEmpsecurity0062'/><w:date format="yyyy-MM-dd" name="stop_date_to" size="8" />
            </td>
        </tr>
        <tr>
             <td align="right"><fmt:message key='listModifyHousingEmpsecurity0065'/></td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER" name="order_type"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="right"><fmt:message key='listModifyHousingEmpsecurity0073'/></td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="left" colspan="2">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
                    <div class="button_right">
                        <!--<ul>
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listModifyHousingEmpsecurity0069'/> </a> </li>
                            <li class="a_2">       <a  onClick="javascript:show_detail_onClick();"><fmt:message key='listModifyHousingEmpsecurity0070'/> </a> </li>
                            <li class="bl_1">      <a  onClick="javascript:modify_onClick();"><fmt:message key='listModifyHousingEmpsecurity0010'/></a></li>
                            <li class="f_1">       <a  onClick="javascript:openFailed_onClick();"><fmt:message key='listModifyHousingEmpsecurity0072'/></a></li>
                        </ul>
                    -->
                    <input class="a_2" type="button"   value=" <fmt:message key='listModifyHousingEmpsecurity0069'/>"  <au:authorityBtn code="view_orderItem23" type="1"/>  onClick="detail_onClick();">
                    <input class="a_2" type="button"   value=" <fmt:message key='listModifyHousingEmpsecurity0070'/>"  <au:authorityBtn code="gjjxg_item" type="1"/>  onClick="show_detail_onClick();">
                    <input class="bl_1" type="button"   value=" <fmt:message key='listModifyHousingEmpsecurity0010'/>"  <au:authorityBtn code="gjjxg_xg" type="1"/>  onClick="modify_onClick();">
                    <input class="f_1" type="button"   value=" <fmt:message key='listModifyHousingEmpsecurity0072'/>"  <au:authorityBtn code="gjjxg_khsb" type="1"/>  onClick="openFailed_onClick();">
                    <input class="e" type="button"   value=" <fmt:message key='listModifyHousingEmpsecurity0077'/>"   onClick="exportExcel_onClick();">
                    </div>
                </div>                    
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=modifySimpleQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=openFailed" width="98%"
        xpath="EmpsecurityVo"
        submitXpath="EmpsecurityVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" sortAt="none" messagekey='listModifyHousingEmpsecurity0043' width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" sortAt="none" messagekey='listModifyHousingEmpsecurity0041' width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      
      <r:field fieldName="group_name" sortAt="none" messagekey="listModifyHousingEmpsecurity0071" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" sortAt="none" messagekey='listModifyHousingEmpsecurity0080' width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" messagekey='listModifyHousingEmpsecurity0081' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_code" sortAt="none" messagekey='listModifyHousingEmpsecurity0049' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" sortAt="none" messagekey='listModifyHousingEmpsecurity0051' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" sortAt="none" messagekey='listModifyHousingEmpsecurity0053' width="100px" allowModify="false">
            <h:text />      
      </r:field><!--siqp<fmt:message key='listModifyHousingEmpsecurity0085'/>
      
      <r:field fieldName="service_big_type_name" sortAt="none" messagekey='listModifyHousingEmpsecurity0086' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_small_type_name" sortAt="none" messagekey='listModifyHousingEmpsecurity0087' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      --><r:field fieldName="social_unit_name" sortAt="none" messagekey='listModifyHousingEmpsecurity0057' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_man" sortAt="none" messagekey='listModifyHousingEmpsecurity0089' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_date" sortAt="none" messagekey='listModifyHousingEmpsecurity0061' width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="transact_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="transact_type_name" sortAt="none" messagekey='listModifyHousingEmpsecurity0091' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="start_month" sortAt="none" messagekey='listModifyHousingEmpsecurity0092' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="end_month" sortAt="none" messagekey='listModifyHousingEmpsecurity0093' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="fund_month" sortAt="none" messagekey='listModifyHousingEmpsecurity0094' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="pay_base" sortAt="none" messagekey='listModifyHousingEmpsecurity0095' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="security_status_bd" sortAt="none" messagekey='listModifyHousingEmpsecurity0011' width="100px" allowModify="false">
            <d:select dictTypeId="SECURITY_STATUS_BD" nullLabel="--请选择--"/>      
      </r:field>
      
      <r:field fieldName="stop_date" sortAt="none" messagekey='listModifyHousingEmpsecurity0063' width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="stop_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="stop_man" sortAt="none" messagekey='listModifyHousingEmpsecurity0099' width="100px" allowModify="false">
            
      </r:field>
      
      <r:field fieldName="stop_type_name" sortAt="none" messagekey='listModifyHousingEmpsecurity0100' width="100px" allowModify="false">
      </r:field>
      
      <r:field fieldName="insert_back_reason" sortAt="none" messagekey='listModifyHousingEmpsecurity0101' width="100px" >
            <h:text />      
      </r:field>
      
    </r:datacell>
    </div>

</div>
</div>
</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">

    //解决<fmt:message key='listModifyHousingEmpsecurity0010'/>行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell不进行查询
    $id("datacell1").beforeLoadData = function(){
        if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
           //alert("run hear");
           return false;
        }
        return true;
    }
    //后台返回的信息
    $id("datacell1").afterSubmit= function(ajax){
           alert(""+ajax.getProperty("returnValue"));
    }

    //实现beforeEdit<fmt:message key='listModifyHousingEmpsecurity0103'/>
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        //alert(city_id);
        if (colIndex == 14){
            var combo1 = $id("com1");
            combo1.addParam("security_group_id",security_group_id);
            combo1.loadData();
            combo1.refresh();
        }
        return true;
    }
    
    //批量开户失败
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        var datacell = $id("datacell1"); //获取datecell对象
        var dataset1 = datacell.dataset;//取得页面的datacell
        var elementCheckbox = document.getElementsByName("checkbox_template");
        var activeRow = datacell.getRowByCell(activeCell).rowIndex;
        if(elementCheckbox[activeRow].checked){
            if(activeFieldName == "insert_back_reason"){
	            for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
	                if(elementCheckbox[i].checked) {  //如果被选中
	                    var entity = dataset1.get(i);
	                    var curCell = this.getCell(i,activeCell.cellIndex);
	                    this.setCellValue(curCell,newValue); 
	                }
	            }
	        }
        }
    }
    
       /*  
   //实现on updateCell
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        //alert(activeCell.getAttribute("fieldId").indexOf("service_name2"));
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("transact_type_name") >= 0){
            var activeEditor = $id("datacell1").activeEditor;
            activeEntity.setProperty("transact_type_name", activeEditor.getDisplayValue(newValue));
            activeEntity.setProperty("transact_type_id", newValue);
        }
        return true;
    }    
    //忽略datacell的<fmt:message key='listModifyHousingEmpsecurity0010'/>
    $id("datacell1").afterEdit = function( newValue, oldValue , datacell1 ){
        $id("datacell1").isModefied = false;
    }    
   $id("datacell1").beforeRefresh = function(){
        $id("com2").refresh();
   }*/
   
   
   //解决翻页不提示数据变化
   function is_datacell_change(checkBoxName){
        var is_change = false;        
        var elementCheckbox = document.getElementsByName(checkBoxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                //alert(enCur.getProperty("social_unit_id")+"--"+enCur.getProperty("is_social_not_stop")+"--"+enCur.getProperty("social_copy_month"));
            }
        }
        //alert(ids);
        if(ids==null){
            is_change = false;
        }else{
            is_change = true;     
        }   
        return is_change;
   }
    /*
    function reload(){
        $id("datacell1").endEdit();
        var pilot = $id("datacell1_toolbar")
        //alert(datacell.dataset.get(0).getProperty("deptcode"));
        //是否变化
        var is_change = is_datacell_change("checkbox_template");
        if (is_change && confirm(DATACELL_MODIFY_CONFIRM)) {
            pilot.datacell.submit();
        } else {
            pilot.datacell.reload();
        }
        eventManager.stopBubble();
    }  
    */  
   
</script>   
