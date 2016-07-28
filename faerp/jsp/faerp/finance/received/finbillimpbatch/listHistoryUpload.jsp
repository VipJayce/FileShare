<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
String type = request.getAttribute("type")==null ? "" : request.getAttribute("type").toString();
%>
<html>
<fmt:bundle basename="rayoo.finance.received.finbillimpdata2.finbillimpdata2_resource" prefix="rayoo.finance.received.finbillimpdata2.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=\"ClickRow('" + entity.getProperty("id") + "');\">";
     }
    
    function ClickRow(value){
		$id("batch_id").value = value;
    }

    function showListData(){
        var bill_year_month = document.getElementById("bill_year_month1").value;
        if(bill_year_month == null || bill_year_month == ""){
            alert("<fmt:message key='alert_tip_3'/>");
            return;
        }else{
            if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_tip_4'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_tip_5'/>");
               return;
           }
        }
        
         $id("celllist1").loadData();
         $id("celllist1").refresh();
     }

	//导出
    function exportExcelForHistoryUploadData_onClick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpbatchAction.do?cmd=exportExcelForHistoryUploadData";
        $id("datacell_formid").submit();
    }
    
    //详细
    function showDetail(){
         var batch_id=jQuery("#batch_id").val();
         var type=jQuery("#type").val();
         if(batch_id==null || batch_id==""){
            alert("<fmt:message key='select_one_record'/>");
            return;
         }
         if(type==2){
             var url="<%=request.getContextPath()%>/jsp/faerp/finance/received/finbillimpbatch/detailData.jsp?batch_id="+batch_id;
             showModalCenter(url, window,"",900,410,"<fmt:message key='hledetail'/>");
         }else if(type==3){
             var url="<%=request.getContextPath()%>/jsp/faerp/finance/received/finbillimpdata2/detailData2.jsp?batch_id="+batch_id;
             showModalCenter(url, window,"",900,410,"<fmt:message key='bjdbdetail'/>");
         }else{
             alert("<fmt:message key='alert_sys_err_2'/>");
             return;
         }
    }
    
    //删除
    function delete_onClick(){
        var batch_id=jQuery("#batch_id").val();
        if(batch_id == null || batch_id == ""){
            alert("<fmt:message key='select_one_delete'/>");
            return;
        }
        
        jQuery.getJSON("<%=request.getContextPath()%>/FinbillimpbatchAction.do?cmd=deleteData&date="+new Date()+"",{"batch_id":batch_id},function(json){
             if(json.saia!=""){
                alert(json.saia);
             }else{
                alert("<fmt:message key='alert_delete_confirm'/>");
                $id("celllist1").loadData();
                $id("celllist1").refresh();
             }
         });
    }
    
        //导出详细
    function exportExcelForHistory(){
         var batch_id=jQuery("#batch_id").val();
         if(batch_id!=null && batch_id!=""){
            $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpbatchAction.do?cmd=exportExcelForHistory&batch_id="+batch_id;
            $id("datacell_formid").submit();
            return;
         }
        alert("<fmt:message key='select_one_record'/>");
    }
    
    //保存
    function toUpdate_onclick(){
        $id("celllist1").submit();//提交       
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
 <input type="hidden" id="type" name="type" value="<%=type %>">
 <div id="right">
<div class="ringht_s">
 
<div id="ccChild0" class="search"> 
<table width="99%" border="0" cellspacing="0" cellpadding="0">

        <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='batch_id'/></td>
            <td align="left">
               <input type="text" class="text_field" name="bill_imp_batch_id1" id="bill_imp_batch_id1" inputName="批次号" maxLength="64" style="width:215"/>            </td>
            <td align="right"><fmt:message key='create_date'/></td>
            <td align="left"><w:date format="yyyy-MM-dd" name="create_date_from" width="80px"/>&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" name="create_date_to" width="80px"/></td>
            <td align="right"><fmt:message key='create_user'/></td>
            <td align="left">
                <input type="text" class="text_field" name="create_user_name1" id="create_user_name1" inputName="操作人" maxLength="64" style="width:215"/>            </td>
        </tr>
        <tr>
            <td align="right"><font color="red">* </font><fmt:message key='bill_year_month'/></td>
            <td align="left">
                <input type="text" class="text_field" name="bill_year_month1" id="bill_year_month1" inputName="账单年月" maxLength="6" style="width:215" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
            </td>
            <td><fmt:message key='batch_name_'/></td>
            <td><input type="text" class="text_field" name="batch_name" id="batch_name" inputName="批次名称"/></td>
            <td>收费属性</td>
           <td><d:select id="bill_imp_type_db1" name="bill_imp_type_db1" dictTypeId="BILL_IMP_TYPE_BD" nullLabel="--请选择--" /></td>
           </tr><tr>
            <td colspan="4" align="right">
               <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">&nbsp;&nbsp;
           </td>
           <td>   
              <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>

<input type="hidden" name="postid" id="postid" value="">
<input type="hidden" name="batch_id" id="batch_id" value="">
<div id="ccParent1" class="button"> 
     <div class="button_right"><!--
        <ul>
            <li class="e_3"><a onclick="javascript:exportExcelForHistoryUploadData_onClick();">导出</a></li>
            <li class="a"><a onclick="javascript:showDetail()">详细</a></li>
        </ul>
    -->
    <input type="button" class="e_3" value="<fmt:message key='export'/>" <au:authorityBtn code="bjdb_exp" type="1"/> onClick="exportExcelForHistoryUploadData_onClick();" />
    <input type="button" class="a" value="<fmt:message key='detail'/>" <au:authorityBtn code="bjdb_item" type="1"/> onClick="showDetail()" />
    <%if(type.equals("2")){ %>
    <input type="button" class="d" value="<fmt:message key='delete'/>" <au:authorityBtn code="bjdb_shanchu" type="1"/> onClick="delete_onClick()" />
    <%} %>
        <input type="button" class="e_2" value="<fmt:message key='export_detail'/>" <au:authorityBtn code="bjdb_exp" type="1"/> onClick="exportExcelForHistory();" />
        <input class="bc" type="button" value="<fmt:message key='save'/>" onClick="toUpdate_onclick();">
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="celllist1"
        queryAction="/FAERP/FinbillimpbatchAction.do?cmd=queryHistoryUploadData"
        submitAction="/FAERP/FinbillimpbatchnAction.do?cmd=updateBillImpBatchNameByHailar"
        width="97%"
        height="305px" 
        xpath="FinbillimpbatchVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="batch" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
      </r:field>
      <r:field fieldName="bill_imp_batch_id" messagekey="batch_id" width="170">
      </r:field>
      <r:field fieldName="batch_name" messagekey="batch_name_" width="350">
      <h:text/>
      </r:field>
      <r:field fieldName="bill_imp_type_db" label="收费属性" width="70">
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date" width="150">
        <w:date format="yyyy-MM-dd" name="" readOnly="true"/>
      </r:field>
	  <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="100">
      </r:field>
	  <r:field fieldName="succeed_num" messagekey="success_num" width="80">
      </r:field>
	  <r:field fieldName="error_num" messagekey="error_num" width="80">
      </r:field>
	  <r:field fieldName="create_user_name" messagekey="import_user" width="150">
      </r:field>
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

