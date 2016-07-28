<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listOtherStopEmpsecurity_resource' prefix='auto.'>
<head>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listOtherStopEmpsecurity0000'/></title>
<script language="javascript">
function citySecurityGroupchange(seletvalue){
      var group_type = $id("group_type").value;
      SecurityGroupAjax.getSecurityGroupbyCitys(seletvalue,group_type,{callback:function(data){
                    setSelectForBean("security_group_id",data,"id","group_name","");
                }
            });
    }

    function findSelections(checkboxName, idName) {  //从列表中找出选中的id<fmt:message key='listOtherStopEmpsecurity0001'/>
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listOtherStopEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数<fmt:message key='listOtherStopEmpsecurity0004'/>
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listOtherStopEmpsecurity0004'/>
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
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listOtherStopEmpsecurity0056'/><fmt:message key='listOtherStopEmpsecurity0010'/>页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids<fmt:message key='listOtherStopEmpsecurity0005'/>
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listOtherStopEmpsecurity0006'/>2<fmt:message key='listOtherStopEmpsecurity0007'/>
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  

    //检查<fmt:message key='listOtherStopEmpsecurity0006'/>没<fmt:message key='listOtherStopEmpsecurity0006'/>选择行,<fmt:message key='listOtherStopEmpsecurity0008'/>,并且把选择行对象<fmt:message key='listOtherStopEmpsecurity0011'/>改成“<fmt:message key='listOtherStopEmpsecurity0010'/>”<fmt:message key='listOtherStopEmpsecurity0011'/>
    function checkSelections(checkboxName) {
        var elementCheckbox = document.getElementsByName(checkboxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listOtherStopEmpsecurity0004'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                if(enCur.getProperty("end_month")==null||enCur.getProperty("end_month")==""){
                    alert(enCur.getProperty("emp_name")+" <fmt:message key='listOtherStopEmpsecurity0013'/>");
                    return false;
                }
                if(enCur.getProperty("stop_reason_bd")==null||enCur.getProperty("stop_reason_bd")==""){
                    alert(enCur.getProperty("emp_name")+" <fmt:message key='listOtherStopEmpsecurity0014'/>");
                    return false;
                }
            }
        }
        if(ids==null){
            alert("<fmt:message key='listOtherStopEmpsecurity0015'/>");
            return false;
        }
        return true;
    }
    //简单的模糊查询
    function simpleQuery_onClick(){  
        var security_group_id= $name('security_group_id').value;
        if(security_group_id==''){
            alert("<fmt:message key='listOtherStopEmpsecurity0016'/>");
            return;
        }
    
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
//<fmt:message key='listOtherStopEmpsecurity0065'/>
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids<fmt:message key='listOtherStopEmpsecurity0005'/>
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listOtherStopEmpsecurity0006'/>2<fmt:message key='listOtherStopEmpsecurity0007'/>
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

 //<fmt:message key='listOtherStopEmpsecurity0066'/>页面
function show_detail_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids<fmt:message key='listOtherStopEmpsecurity0005'/>
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listOtherStopEmpsecurity0006'/>2<fmt:message key='listOtherStopEmpsecurity0007'/>
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0]+"&isModify=2";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE<fmt:message key='listOtherStopEmpsecurity0023'/>
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listOtherStopEmpsecurity0024'/>');
    //showModalCenter(url, window, callBack, 1024, 500, "<fmt:message key='listOtherStopEmpsecurity0025'/>");
}

//<fmt:message key='listOtherStopEmpsecurity0067'/>
function stop_onClick(){
     if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('<fmt:message key='listOtherStopEmpsecurity0026'/>')) {
                //$id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}

//<fmt:message key='listOtherStopEmpsecurity0068'/>excel
    function exportExcel_onClick(){  //<fmt:message key='listOtherStopEmpsecurity0068'/>Excel
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do";
        form.cmd.value = "exportExcel";
        form.submit();
    } 
    
         //查看<fmt:message key='listOtherStopEmpsecurity0027'/>
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        setTimeout(simpleQuery_onClick,4000);
    }
}
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '<fmt:message key='listOtherStopEmpsecurity0027'/>');  //查看<fmt:message key='listOtherStopEmpsecurity0027'/>
        window.open('<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id='+id+'&flag=true','','height=830px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_3 %>">
<input type="hidden" id="Method" name="Method" value=""/>
<input type="hidden" id="queryType" name="queryType" value="stop"/>
<input type="hidden" id="group_type" value="${param.group_type }">
<div id="right">
<script language="javascript">
    <c:choose>
                            <c:when test="${param.group_type=='1'}">
                               writeTableTopFesco('<fmt:message key='listOtherStopEmpsecurity0000'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                            <c:when test="${param.group_type=='2'}">
                                 writeTableTopFesco('<fmt:message key='listOtherStopEmpsecurity0029'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
                            </c:when>
                           
                             
          </c:choose>
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
              <td align="right"><fmt:message key='listOtherStopEmpsecurity0028'/></td>
              <td align="left">
                    <select id="security_group_id" name="security_group_id" style="width: 205px" >
                       <c:choose>
                            <c:when test="${param.security_type=='1'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listOtherStopEmpsecurity0030'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='2'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key='listOtherStopEmpsecurity0031'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='3'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key='listOtherStopEmpsecurity0032'/></option>
                            </c:when>
                        </c:choose>
                    </select>
              </td>
              <td align="right"><fmt:message key='listOtherStopEmpsecurity0033'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listOtherStopEmpsecurity0033'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listOtherStopEmpsecurity0035'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listOtherStopEmpsecurity0035'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listOtherStopEmpsecurity0037'/></td>
              <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listOtherStopEmpsecurity0035'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
              <td align="right"><fmt:message key='listOtherStopEmpsecurity0039'/></td>
              <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="<fmt:message key='listOtherStopEmpsecurity0035'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listOtherStopEmpsecurity0041'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listOtherStopEmpsecurity0041'/>" maxLength="64" size="25"/>
            </td>
            <td align="right"><fmt:message key='listOtherStopEmpsecurity0043'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listOtherStopEmpsecurity0043'/>" maxLength="50" size="25"/>
            </td>
              <td align="right"><fmt:message key='listOtherStopEmpsecurity0045'/></td>
              <td align="left">
                <input type="text" class="text_field" name="receive_cs_name" inputName="<fmt:message key='listOtherStopEmpsecurity0035'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listOtherStopEmpsecurity0047'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_account" inputName="<fmt:message key='listOtherStopEmpsecurity0035'/>" maxLength="20" size="25"/>
            </td>
            <td align="right"><fmt:message key='listOtherStopEmpsecurity0049'/></td>
            <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                        queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                        textField="hire_unit_short_name" 
                        valueField="id" 
                        xpath="SocialunitVo"
                        messagekey='listOtherStopEmpsecurity0050'
                        width="205px">
                    </r:comboSelect> 
            </td>
            <td align="right"><fmt:message key='listOtherStopEmpsecurity0051'/></td>
            <td align="left">
                    <d:select name="hire_fire_status" dictTypeId="HIRE_FIRE_STATUS_BD"  nullLabel="--请选择--" style="width: 205px"/>
              </td>
              <td align="right"><fmt:message key='listOtherStopEmpsecurity0053'/></td>
            <td align="left">
                    <d:select name="stopType" dictTypeId="STOP_TYPE" nullLabel="--请选择--" style="width: 205px"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listOtherStopEmpsecurity0055'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="transact_date_from" size="8"/><fmt:message key='listOtherStopEmpsecurity0056'/><w:date format="yyyy-MM-dd" name="transact_date_to" size="8" />
            </td>
            <td align="right"><fmt:message key='listOtherStopEmpsecurity0057'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="the_end_date_from" size="8"/><fmt:message key='listOtherStopEmpsecurity0056'/><w:date format="yyyy-MM-dd" name="the_end_date_to" size="8" />
            </td>
            <td align="right"><fmt:message key='listOtherStopEmpsecurity0059'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="off_post_date_from" size="8"/><fmt:message key='listOtherStopEmpsecurity0056'/><w:date format="yyyy-MM-dd" name="off_post_date_to" size="8" />
            </td>
             <td align="right"><fmt:message key='listOtherStopEmpsecurity0061'/></td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER" name="order_type"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
        </tr>
        
        <tr>
            <td align="right"><fmt:message key='listOtherStopEmpsecurity0063'/></td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td colspan="4" align="right">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
                    <div class="button_right">
                        <!--<ul>
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listOtherStopEmpsecurity0065'/> </a> </li>
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listOtherStopEmpsecurity0066'/> </a> </li>
                            <li class="bl_1">      <a onClick="javascript:stop_onClick();"><fmt:message key='listOtherStopEmpsecurity0067'/> </a></li>
                            <li class="e">         <a  onClick="javascript:exportExcel_onClick();"><fmt:message key='listOtherStopEmpsecurity0068'/> </a> </li>
                        </ul>
                    -->
                    <input class="a_2" type="button"   value=" <fmt:message key='listOtherStopEmpsecurity0065'/>"  <au:authorityBtn code="view_orderItem16" type="1"/>  onClick="detail_onClick();">
                     <input class="a_2" type="button"   value=" <fmt:message key='listOtherStopEmpsecurity0066'/>"  <au:authorityBtn code="ydsbtb_item" type="1"/>  onClick="show_detail_onClick();">
                     <input class="bl_1" type="button"   value=" <fmt:message key='listOtherStopEmpsecurity0067'/>"  <au:authorityBtn code="ydsbtb_tb" type="1"/>  onClick="stop_onClick();">
                     <input class="e" type="button"   value=" <fmt:message key='listOtherStopEmpsecurity0068'/>"  <au:authorityBtn code="ydsbtb_exp" type="1"/>  onClick="exportExcel_onClick();">
                    </div>
                </div>                    
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=simpleQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=stopSecurity" width="99%"
        xpath="EmpsecurityVo"
        submitXpath="EmpsecurityVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" messagekey='listOtherStopEmpsecurity0035' width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" messagekey='listOtherStopEmpsecurity0033' width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      
      <r:field fieldName="id_card_type_bd" messagekey='listOtherStopEmpsecurity0075' width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" messagekey='listOtherStopEmpsecurity0076' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_code" messagekey='listOtherStopEmpsecurity0041' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" messagekey='listOtherStopEmpsecurity0043' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" messagekey='listOtherStopEmpsecurity0045' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="social_unit_name" messagekey='listOtherStopEmpsecurity0049' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="hire_fire_status" messagekey='listOtherStopEmpsecurity0081' width="100px" allowModify="false">
            <d:select dictTypeId="HIRE_FIRE_STATUS_BD" />
      </r:field>
      
      <r:field fieldName="service_big_type_name" messagekey='listOtherStopEmpsecurity0082' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="the_end_date" messagekey="listOtherStopEmpsecurity0083" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="end_month" messagekey='listOtherStopEmpsecurity0084' width="100px" >
            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;"/>      
      </r:field>
      
      <r:field fieldName="stop_reason_bd" messagekey='listOtherStopEmpsecurity0086' width="100px">
            <d:select dictTypeId="STOP_REASON_BD" nullLabel="--请选择--"/>  
      </r:field>
      
      <r:field fieldName="stop_type_id" messagekey='listOtherStopEmpsecurity0088' width="100px">
            <r:comboSelect id="com1" 
                queryAction="/FAERP/SecuritygroupstopAction.do?cmd=getListStopType"
                textField="type_name" 
                valueField="id" 
                xpath="SecuritygroupstopVo"
                messagekey='listOtherStopEmpsecurity0050'>
            </r:comboSelect>  
      </r:field>
      
      <r:field fieldName="off_post_desc" messagekey='listOtherStopEmpsecurity0090' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_date" messagekey='listOtherStopEmpsecurity0055' width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="transact_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="apply_off_post_date" messagekey='listOtherStopEmpsecurity0092' width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="apply_off_post_date" size="6"/>  
      </r:field>
      
      <r:field fieldName="start_month" messagekey='listOtherStopEmpsecurity0093' width="100px" allowModify="false">
            <h:text/>      
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

    //解决<fmt:message key='listOtherStopEmpsecurity0010'/>行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell<fmt:message key='listOtherStopEmpsecurity0094'/>
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

    //实现beforeEdit<fmt:message key='listOtherStopEmpsecurity0095'/>
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
    //忽略datacell的<fmt:message key='listOtherStopEmpsecurity0010'/>
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
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listOtherStopEmpsecurity0004'/>
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
   //初始化社保<fmt:message key='listOtherStopEmpsecurity0004'/>
    citySecurityGroupchange("0571','0520"); 
</script>   
