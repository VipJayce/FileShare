<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

	<%
		String security_group_id= request.getParameter("security_group_id");
		String social_unit_id= request.getParameter("social_unit_id");
		String cust_name= request.getParameter("customer_name");
		String cust_code= request.getParameter("customer_code");
		String report_month = request.getParameter("report_month")==null || request.getParameter("report_month").equals("undefined")?"":request.getParameter("report_month");
		String the_end_date_to = "";
		if(report_month!=null && !report_month.equals("")){
	        String year = report_month.substring(0,4);
	        String month = report_month.substring(4);
	        Calendar cal = Calendar.getInstance();
	        cal.set(Calendar.YEAR,Integer.parseInt(year));
	        cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
	        cal.set(Calendar.DAY_OF_MONTH, 1);
	        cal.add(Calendar.DAY_OF_MONTH, -1);
	        Date lastDate = cal.getTime();
	        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	        the_end_date_to = format.format(lastDate);
		}
		String  isQuery = request.getParameter("isQuery")==null?"false":request.getParameter("isQuery");
	%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listStopHousingEmpsecurity_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listStopHousingEmpsecurity0000'/></title>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script language="javascript">
	var _jQuery = window.jQuery, _$ = window.$;
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listStopHousingEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数<fmt:message key='listStopHousingEmpsecurity0004'/>
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listStopHousingEmpsecurity0004'/>
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
    
   /************add by zhuyj Start 20160603**************/

    function selectedEntitiesXML() {
        var entitiesXML;
        var dc = $id("datacell1");
        var ds = dc.dataset;
        _$("input[name='checkbox_template']").each(function(i) {
            if ( _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];
                var entity = dc.getEntity(row);
                entitiesXML += entity.toString();
            }
        });
        return entitiesXML;
    }

     function getEmpId2(){
    	 var action = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=updateforline&TSflag=3";
         var xmlSubmit = selectedEntitiesXML();
         if (typeof(xmlSubmit)=="undefined" || xmlSubmit=="" || xmlSubmit=="null")
      	  {
      	     alert("请选择要操作的数据") ;
      	     return false;
      	 }
         //alert(xmlSubmit);
         var myAjax = new Ajax(action);
         myAjax.loadData(xmlSubmit);
         var returnNode = myAjax.getResponseXMLDom();
         if(returnNode) 
         {
             if(myAjax.getValue("root/data/returnValue")) 
             {
                 alert(myAjax.getValue("root/data/returnValue"));
                 $id("gjjbl_line").disabled = true;
                 simpleQuery_onClick();
                 $id("gjjbl_line").disabled = false;
                 // window.close();
             } 
             else
             {
                 alert('提交失败');
             }
         } 
         else 
         {
             alert('提交失败');
         }
      }
     
     function getEmpId3(){
    	 var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
         if(ids == null) {  //如果ids为空
             alert('<fmt:message key="select_one_record"/>');
             return;
         }
         var idSelected="";
    	 for(var i=0;i<ids.length;i++){
             var curId = '' + ids[i];
             var entity1 = $id("datacell1").dataset.findEntity("id", curId);
             if(idSelected!=""){
            	 idSelected+=",";
             }
             idSelected+=entity1.getProperty("emp_post_id");
    	 }
     	 alert(idSelected); 
     }
    /*add by zhuyj end 20160603 */
    
    function findPostIds(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listStopHousingEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var postIds = null;  //定义id值的数<fmt:message key='listStopHousingEmpsecurity0004'/>
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listStopHousingEmpsecurity0004'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                var enCur = $id("datacell1").dataset.get(i);
                number += 1;  //游标加1
               if(postIds == null) {
                    postIds = new Array(0);
                }
                postIds.push(enCur.getProperty("emp_post_id"));  //加入选中的checkbox
            }
        }
        return postIds;
    }
    
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listStopHousingEmpsecurity0050'/><fmt:message key='listStopHousingEmpsecurity0010'/>页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listStopHousingEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  

    //检查<fmt:message key='listStopHousingEmpsecurity0006'/>没<fmt:message key='listStopHousingEmpsecurity0006'/>选择行,<fmt:message key='listStopHousingEmpsecurity0008'/>,<fmt:message key='listStopHousingEmpsecurity0009'/>“<fmt:message key='listStopHousingEmpsecurity0010'/>”<fmt:message key='listStopHousingEmpsecurity0011'/>
    function checkSelections(checkboxName) {
        var elementCheckbox = document.getElementsByName(checkboxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listStopHousingEmpsecurity0004'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                if(enCur.getProperty("end_month")==null||enCur.getProperty("end_month")==""){
                    alert(enCur.getProperty("emp_name")+" <fmt:message key='listStopHousingEmpsecurity0013'/>");
                    return false;
                }
                //if(enCur.getProperty("stop_reason_bd")==null||enCur.getProperty("stop_reason_bd")==""){
                //    alert(enCur.getProperty("emp_name")+" <fmt:message key='listStopHousingEmpsecurity0067'/>原因不能为空！");
                //    return false;
                //}
            }
        }
        if(ids==null){
            alert("<fmt:message key='listStopHousingEmpsecurity0015'/>");
            return false;
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
//<fmt:message key='listStopHousingEmpsecurity0065'/>
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listStopHousingEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

//<fmt:message key='listStopHousingEmpsecurity0067'/>
function stop_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        
        var postIds = findPostIds("checkbox_template","id");  //取得多选框的选择项
	    if(postIds == null) {  //如果ids为空
	        alert('<fmt:message key="select_one_record"/>');
            return;
	    }
	    var security_group_id=document.getElementById("security_group_id").value;
	    var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkRepeatEmp");
	        myAjax.addParam("postIds", postIds);
	        myAjax.addParam("security_group_id",security_group_id);
	        myAjax.submit();
	        var returnNode = myAjax.getResponseXMLDom();
	        if( returnNode ) {
	              if(myAjax.getProperty("returnValue")=="modifyerror"){
	                   alert('存在修改订单审批中的数据！');
	                   isali = false;
	                   return;
                  }else{
                    if(confirm('<fmt:message key='listStopHousingEmpsecurity0019'/>')) {
			                //$id('Method').value="batchback";
			                $id("datacell1").submit();//提交       
			        }
	              }
	         }
}

	function save_onClick(){
	        if(!checkSelections('checkbox_template')){
	            return;        
	        }
	        
	        var postIds = findPostIds("checkbox_template","id");  //取得多选框的选择项
		    if(postIds == null) {  //如果ids为空
		        alert('<fmt:message key="select_one_record"/>');
	            return;
		    }
             //$id('Method').value="batchback";
             $id("datacell1").addParam("type", "save");
             $id("datacell1").submit();
             
	}
	
//<fmt:message key='listStopHousingEmpsecurity0068'/>excel
    function exportExcel_onClick(){  //<fmt:message key='listStopHousingEmpsecurity0068'/>Excel
       var queryType=document.getElementById("queryType").value;
       var stopType=document.getElementById("stopType").value;
       var group_id=document.getElementById("security_group_id").value;
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcel4&queryType="+queryType+"&stopType="+stopType+"&group_id="+group_id;
        //form.cmd.value="exportExcel;
        form.submit();
    } 
    
     //查看<fmt:message key='listStopHousingEmpsecurity0026'/>
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
 //<fmt:message key='listStopHousingEmpsecurity0066'/>页面
function show_detail_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listStopHousingEmpsecurity0006'/>2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    var url="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getEmpSecurityById&id="+ids[0]+"&isModify=2&applytype=1&viewtype=1";
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listStopHousingEmpsecurity0024'/>');
    //showModalCenter(url, window, callBack, 1024, 500, "<fmt:message key='listStopHousingEmpsecurity0025'/>");
}

function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        setTimeout(simpleQuery_onClick,4000);
    }
}
    
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '<fmt:message key='listStopHousingEmpsecurity0026'/>');  //查看<fmt:message key='listStopHousingEmpsecurity0026'/>
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
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key='listStopHousingEmpsecurity0000'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
              <td align="right"><fmt:message key='listStopHousingEmpsecurity0110'/></td>
              <td align="left">
                     <select id="security_group_id" name="security_group_id" style="width: 200px" >
                        <option value="0" selected="selected"><fmt:message key='listStopHousingEmpsecurity0028'/></option>
                        <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message key='listStopHousingEmpsecurity0029'/></option>
                        <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message key='listStopHousingEmpsecurity0109'/><fmt:message key='listStopHousingEmpsecurity0004'/></option>
                    </select>
              </td>
              <td align="right"><fmt:message key='listStopHousingEmpsecurity0031'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listStopHousingEmpsecurity0031'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listStopHousingEmpsecurity0033'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listStopHousingEmpsecurity0033'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listStopHousingEmpsecurity0035'/></td>
              <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listStopHousingEmpsecurity0033'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
              <td align="right"><fmt:message key='listStopHousingEmpsecurity0037'/></td>
              <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="<fmt:message key='listStopHousingEmpsecurity0033'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listStopHousingEmpsecurity0039'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listStopHousingEmpsecurity0039'/>" maxLength="64" size="25"/>
            </td>
            <td align="right"><fmt:message key='listStopHousingEmpsecurity0041'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listStopHousingEmpsecurity0041'/>" maxLength="50" size="25"/>
            </td>
              <td align="right"><fmt:message key='listStopHousingEmpsecurity0043'/></td>
              <td align="left">
                <input type="text" class="text_field" name="receive_cs_name" inputName="<fmt:message key='listStopHousingEmpsecurity0033'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listStopHousingEmpsecurity0045'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_account" inputName="<fmt:message key='listStopHousingEmpsecurity0033'/>" maxLength="20" size="25"/>
            </td>
            <td align="right"><fmt:message key='listStopHousingEmpsecurity0047'/></td>
            <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                        queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                        textField="hire_unit_short_name" 
                        valueField="id" 
                        xpath="SocialunitVo"
                        messagekey='listStopHousingEmpsecurity0028'
                          value="${param.social_unit_id }"
                        width="205px">
                    </r:comboSelect> 
            </td>
            <td align="right"><fmt:message key='listStopHousingEmpsecurity0049'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="the_end_date_from" size="8"/><fmt:message key='listStopHousingEmpsecurity0050'/><w:date format="yyyy-MM-dd" name="the_end_date_to" value="<%=the_end_date_to %>" size="8" />
            </td>
            <!--
            <td align="right"><fmt:message key='listStopHousingEmpsecurity0051'/></td>
            <td align="left">
                <select name="post_status_bd" style="width: 205px">
                    <option value=""><fmt:message key='listStopHousingEmpsecurity0028'/></option>
                    <option value="2"><fmt:message key='listStopHousingEmpsecurity0053'/></option>
                </select>
                    <d:select name="hire_fire_status" dictTypeId="HIRE_FIRE_STATUS_BD"  nullLabel="<fmt:message key='listStopHousingEmpsecurity0028'/>" style="width: 205px"/>
              </td>
              --><td align="right"><fmt:message key='listStopHousingEmpsecurity0055'/></td>
            <td align="left">
                    <d:select name="stopType" dictTypeId="STOP_TYPE" nullLabel="--请选择--" style="width: 205px"/>
            </td>
        </tr>
        <tr><!--
            <td align="right"><fmt:message key='listStopHousingEmpsecurity0057'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="transact_date_from" size="8"/><fmt:message key='listStopHousingEmpsecurity0050'/><w:date format="yyyy-MM-dd" name="transact_date_to" size="8" />
            </td>
            -->
            <td align="right"><fmt:message key='listStopHousingEmpsecurity0059'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="off_post_date_from" size="8"/><fmt:message key='listStopHousingEmpsecurity0050'/><w:date format="yyyy-MM-dd" name="off_post_date_to" size="8" />
            </td>
             <td align="right"><fmt:message key='listStopHousingEmpsecurity0061'/></td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER1" name="order_type"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="right"><fmt:message key='listStopHousingEmpsecurity0111'/></td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
            <td align="right">同步状态</td>
            <td align="left">
                <d:select name="sync_status" id="sync_status" dictTypeId="SYNC_STATUS" nullLabel="--请选择--" style="width:200px;"/>
            </td>
        </tr>
        <tr>
         <!-- add by zhuyj 20160607 Start -->
            <td align="right">专员</td>
            <td align="left">
	            <r:comboSelect id="com3" name="commissioner" 
	                    queryAction="/FAERP/EmpsecurityAction.do?cmd=GetCommissioner&Role_Type_BD=6"
	                    textField="emp_name" 
	                    valueField="emp_id" 
	                    xpath="EmpsecurityVo"                   
	                    messagekey='listTransactionHousingEmpsecurity0043' 
	                    width="205px"
	                    nullText="--请选择--">
	                </r:comboSelect>
             </td>
             <!-- add by zhuyj 20160607 End -->
             <!-- add by zhuyj 20160617 Start -->
            <td align="right">办理阶段</td>
            <td align="left">
                <select name="sel_uav_line_str" style="width: 205px">
                	<option value="">--请选择--</option>
                    <option value="IA">IA</option>
                    <option value="MW">MW</option>
                </select>
             </td>
             <!-- add by zhuyj 20160617 End -->
            <td colspan="3" align="right"></td>
            <td  align="left">
               <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
                    <div class="button_right"><!--
                        <ul>
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listStopHousingEmpsecurity0065'/> </a> </li>
                            <li class="a_2">       <a  onClick="javascript:show_detail_onClick();"><fmt:message key='listStopHousingEmpsecurity0066'/> </a> </li>
                            <li class="bl_1">      <a onClick="javascript:stop_onClick();"><fmt:message key='listStopHousingEmpsecurity0067'/> </a></li>
                            <li class="e">         <a  onClick="javascript:exportExcel_onClick();"><fmt:message key='listStopHousingEmpsecurity0068'/> </a> </li>
                        </ul>
                    -->
                    <input class="a_2" type="button"   value=" <fmt:message key='listStopHousingEmpsecurity0065'/>"  <au:authorityBtn code="view_orderItem22" type="1"/>  onClick="detail_onClick();">
                    <input class="a_2" type="button"   value=" <fmt:message key='listStopHousingEmpsecurity0066'/>"  <au:authorityBtn code="gjjtb_item" type="1"/>  onClick="show_detail_onClick();">
                    <input class="bl_1" type="button"   value=" <fmt:message key='listStopHousingEmpsecurity0067'/>"  <au:authorityBtn code="gjjtb_tb" type="1"/>  onClick="stop_onClick();">
                    <input class="bc" type="button"   value="保存"  <au:authorityBtn code="gjjtb_tb" type="1"/>  onClick="save_onClick();">
                    <input class="e" type="button"   value=" <fmt:message key='listStopHousingEmpsecurity0068'/>"  <au:authorityBtn code="gjjtb_exp" type="1"/>  onClick="exportExcel_onClick();">
                    <!-- add by zhuyj Start 20160614 -->
                    <input class="bl_1" type="button"  Id="gjjbl_line"  value="线路转换"  onClick="getEmpId2();">
                    <!-- add by zhuyj End 20160614 -->
                    </div>
                </div>                    
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=simpleQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=stopSecurity" width="98%"
        xpath="EmpsecurityVo"
        submitXpath="EmpsecurityVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="emp_code" sortAt="none" messagekey='listStopHousingEmpsecurity0033' width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" sortAt="none" messagekey='listStopHousingEmpsecurity0031' width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      <r:field fieldName="group_name" sortAt="none" messagekey="listStopHousingEmpsecurity0110" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" sortAt="none" messagekey='listStopHousingEmpsecurity0075' width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" messagekey='listStopHousingEmpsecurity0076' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_code" sortAt="none" messagekey='listStopHousingEmpsecurity0039' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" sortAt="none" messagekey='listStopHousingEmpsecurity0041' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" sortAt="none" messagekey='listStopHousingEmpsecurity0043' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="social_unit_name" sortAt="none" messagekey='listStopHousingEmpsecurity0047' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_date" sortAt="none" messagekey='listStopHousingEmpsecurity0057' width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd hh:mm:ss" />  
      </r:field>
      
      <!--siqiaopeng<fmt:message key='listStopHousingEmpsecurity0082'/>
      <r:field fieldName="hire_fire_status" sortAt="none" messagekey='listStopHousingEmpsecurity0083' width="100px" allowModify="false">
            <d:select dictTypeId="HIRE_FIRE_STATUS_BD" />
      </r:field>
      --><r:field fieldName="service_big_type_name" sortAt="none" messagekey='listStopHousingEmpsecurity0084' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="next_cust_name" sortAt="none" messagekey='listStopHousingEmpsecurity0085' width="100px">
            <h:text/>      
      </r:field>
      <r:field fieldName="nextcust_account" sortAt="none" messagekey='listStopHousingEmpsecurity0086' width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="the_end_date" sortAt="none" messagekey='listStopHousingEmpsecurity0087' width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" />  
      </r:field>
      
      <r:field fieldName="end_month" sortAt="none" messagekey='listStopHousingEmpsecurity0088' width="100px" >
            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;"/>      
      </r:field>
      
      <r:field fieldName="stop_type_name" sortAt="none" messagekey="listStopHousingEmpsecurity0090" allowModify="true"   >
        <h:text/>
      </r:field>
         <r:field fieldName="stop_remarks" sortAt="none" messagekey="listStopHousingEmpsecurity0112" width="100px">
            <h:text/>      
      </r:field>
       <r:field fieldName="stop_type" sortAt="none" messagekey='listStopHousingEmpsecurity0055' width="100px" allowModify="false">
            <d:select dictTypeId="STOP_TYPE" nullLabel="--请选择--"/>  
      </r:field><!--siqiaopeng<fmt:message key='listStopHousingEmpsecurity0082'/>
      <r:field fieldName="stop_reason_bd" sortAt="none" messagekey='listStopHousingEmpsecurity0094' width="100px" allowModify="false">
            <d:select dictTypeId="OFF_POST_REASON" nullLabel="<fmt:message key='listStopHousingEmpsecurity0028'/>"/>  
      </r:field>
      <r:field fieldName="off_post_desc" sortAt="none" messagekey='listStopHousingEmpsecurity0096' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      <r:field fieldName="transact_date" sortAt="none" messagekey='listStopHousingEmpsecurity0057' width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="transact_date" size="6"/>  
      </r:field>
       -->
      <r:field fieldName="apply_off_post_date" sortAt="none" messagekey='listStopHousingEmpsecurity0098' width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd" name="apply_off_post_date" size="6"/>  
      </r:field>
          
      <r:field fieldName="off_post_date" sortAt="none" messagekey="listStopHousingEmpsecurity0059" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd hh:mm:ss" name="off_post_date"/>  
      </r:field>
      
      <r:field fieldName="start_month" sortAt="none" messagekey='listStopHousingEmpsecurity0100' width="100px" allowModify="false">
            <h:text/>      
      </r:field>  
            <!-- yangyuting add 2014-9-19 -->
           <r:field fieldName="phoenix_offpost_welfare_id" sortAt="none"  messagekey='listStopEmpsecurity0088'  width="0px" >
            <h:text />      
      </r:field>
            <r:field fieldName="sync_status" label="同步状态" width="150px" allowModify="false">
            <d:select dictTypeId="SYNC_STATUS" disabled="true"/>
      </r:field>
      
      <r:field fieldName="sync_remark" label="同步备注" width="150px" allowModify="false">
           <d:select dictTypeId="SYNC_REMARK" disabled="true"/>  
      </r:field>
      
      <r:field fieldName="sync_date" label="最后同步时间" width="150px" allowModify="false">
               <w:date format="yyyy-MM-dd HH:mm:ss" />
      </r:field>
      
      <r:field fieldName="remark" label="同步历史" width="1000px" allowModify="false"></r:field>
      <!-- add by zhuyj 20160603 Start -->
      <r:field fieldName="uav_line_str" sortAt="none" label='办理阶段' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="name" sortAt="none" label='专员' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="emp_service_id" sortAt="none" messagekey='listStopEmpsecurity0035' width="0px" allowModify="false">
            <h:text/>  
      </r:field>
      		<r:field fieldName="uav_status" sortAt="none" messagekey='发送' width="0px" allowModify="false">
            <h:text/>  
      	</r:field>
      <!-- add by zhuyj 20160603 End -->
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

    //解决<fmt:message key='listStopHousingEmpsecurity0010'/>行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell<fmt:message key='listStopHousingEmpsecurity0101'/>
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

    //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        //alert(city_id);
        if (colIndex == 16){
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
    //忽略datacell的<fmt:message key='listStopHousingEmpsecurity0010'/>
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
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listStopHousingEmpsecurity0004'/>
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
   
   
   var field = {
    entityField:"stop_type_id",
    fieldId:"stop_type_id_9999",
    fieldName:"stop_type_id",
    sort:"no",
    allowResize:true,
    label:"停办类型",
    allowModify:true
    };    
    var eos_orgEditor = null;
        //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        if (colIndex == 16){
            if (!$id("new_service_List" + colIndex) || eos_orgEditor == null){
                //div container
                var divA = $createElement("div");
                divA.id = "datacell1"+"_"+"stop_type_id"+"_9999"+"_field_editor_container";
                //alert(divA.style);
                divA.style.width = "0px";
                divA.style.height = "0px";
                //divA.style.z-index = "999";
                divA.style.display = "none";
                
                var htmlString ="" ;
                htmlString += "<div id=\"new_service_List16_container\"  class=\"eos-ic-container\" >";
                htmlString += "<input class=\"eos-combo-select-editor-text\" type=\"text\" id=\"new_service_List16_input\" /><img id='new_service_List16_button' class='eos-ic-button'  /><input type=\"hidden\" id=\"new_service_List16_hidden\" name=\"new_service_List16\" />";
                htmlString += "</div>";
                                
                //append them
                divA.innerHTML = htmlString;
                //alert(divA.toString());
                document.body.appendChild(divA);
                //alert("run hear");
                            
                eos_orgEditor =new ComboSelect('new_service_List' + colIndex); 
                eos_orgEditor.queryAction = "/FAERP/SecuritygroupstopAction.do?cmd=getListStopType"; 
                eos_orgEditor.xpath = "SecuritygroupstopVo"; 
                eos_orgEditor.valueField = "id"; 
                eos_orgEditor.textField = "type_name"; 
                eos_orgEditor.isIeMode = false; 
                eos_orgEditor.readOnly = false; 
                eos_orgEditor.allowInput = false; 
                eos_orgEditor.allowFilter = true; 
                eos_orgEditor.disabled = false; 
                eos_orgEditor.nullText = "--请选择--";
                eos_orgEditor.onPageLoad();
            }
            
            orgEditor = eos_orgEditor;
            var dc1 = $id("datacell1");
            this.activeField = field ? field : null;
            this.activeField.editor = orgEditor;
            this.activeEditor = this.activeField ? this.activeField.editor : null;
            orgEditor.paramList = null;
            orgEditor.addParam("security_group_id",""+security_group_id);
            orgEditor.init();
            orgEditor.loadData();
            orgEditor.refresh(); 
            
        }
        return true;
    } 
   
   //实现on updateCell
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("stop_type_name") >= 0){
            var orgEditor = eos_orgEditor;
            var newDisValue = orgEditor.getDisplayValue(newValue);
            activeEntity.setProperty("stop_type_name", newDisValue);
        }
        return true;
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
    $id("datacell1").afterInit = function (){
	    var isQuery= <%=isQuery%>;
	    var security_group_id='<%=security_group_id%>';
	    var social_unit_id='<%=social_unit_id%>';
	    var cust_name='<%=cust_name%>';
	    var cust_code='<%=cust_code%>';
	    if(isQuery)
	    {
	         if(security_group_id=='<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>')
	        {
	                document.getElementById("security_group_id").options[1].selected=true;
	        }
	        else if(security_group_id=='<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>')
	        {
	                  document.getElementById("security_group_id").options[2].selected=true;
	        }
	        document.all.form.social_unit_id.value= social_unit_id;
	        document.all.form.cust_name.value= cust_name;
	        document.all.form.cust_code.value= cust_code;
	        
	        $id('isClickQuery').value=true;
            $id("datacell1").loadData();
            $id("datacell1").refresh();
	    }
	}

//  make it all default value =  <fmt:message key='listStopHousingEmpsecurity0108'/>
//上海公积金：1099110700000000155/1099111000000000002 <fmt:message key='listStopHousingEmpsecurity0109'/> 1099110700000000156/1099111000000000007

    $id("datacell1").afterLoadData = function(){
	    var datacelll1 = $id("datacell1");
	    var dataset1 = datacelll1.dataset;
	    for(var i=0; i< dataset1.getLength(); i++){
	        //dataset1.setProperty("security_group_id", "1099110700000000155");
	        var entity1 = dataset1.get(i);
	        var group_id=entity1.getProperty("security_group_id");
	        var stop_type_name=entity1.getProperty("stop_type_name");  // modify by sqp 增加了部分判断  2014年3月25日 
	        if(group_id='1099110700000000155'){
	        if(stop_type_name=="欠费封存"){
	            entity1.setProperty("stop_type_id", "2013801300000000001");//更新到生产时需要 把id改为 2019801300000000002
                entity1.setProperty("stop_type_name", "欠费封存");
                }else{
                entity1.setProperty("stop_type_id", "1099111000000000002");
                entity1.setProperty("stop_type_name", "封存");
                }
	        }else if(group_id='1099110700000000156'){
	            if(stop_type_name=="欠费封存"){
                entity1.setProperty("stop_type_id", "2013801300000000002");//更新到生产时需要 把id改为 2019801300000000001
                entity1.setProperty("stop_type_name", "欠费封存");
                }else{
	            entity1.setProperty("stop_type_id", "1099111000000000007");
                entity1.setProperty("stop_type_name", "封存");
                }
	        }
	    }
	    datacelll1.refresh();
    };    

</script>   
