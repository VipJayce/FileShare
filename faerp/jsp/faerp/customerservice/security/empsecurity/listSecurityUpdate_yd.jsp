<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listSecurityUpdate_yd_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 

<%
String type = (String)request.getParameter("type");
String tablename = "";
if(type!=null){
    if(type.equals("1")){
        tablename = "异地社保变更";
    }else if(type.equals("2")){
        tablename = "异地公积金变更";
    }
}

%>
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        $id("emppostback_init").isQueryFirst = false;
    });
    var vpath = "<%=request.getContextPath()%>";
    
    jQuery(document).ready(function(){
        searchSecurityGroup();
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp' id='temp_"+rowNo+"' value=\"" + entity.getProperty("emp_post_id") + "\">";
    }

        
    function findSelection(checkboxName) {  //从radio中找出选中的id值列表
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
    
    //<fmt:message key='listSecurityUpdate_yd0030'/>列表，点击全选按钮
    function emp_onClick(obj){
        var datacell = $id("emppostback_init");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            //针对第一行有问题，其他行可行
            if(obj.checked){//勾选上
                $id("temp_"+i).checked=true;
            }else{//勾选去掉
                $id("temp_"+i).checked=false;
            }
        }
       
    }
    
    function searchSecurityGroup(){
        jQuery("#security_group_id").empty();
        var city_id = jQuery("#city_id").val();
        var type='<%=type%>';
        if(city_id!=null && city_id!=''){
            jQuery.getJSON(vpath+"/EmppostAction.do?cmd=searchSecurityGroupByCity&date="+new Date()+"",{"city_id":city_id,"type":type},  function(json){
                 if(json.saia!=null && json.saia.length>0){
                     for(var i = 0; i < json.saia.length; i++){
                        var op = document.createElement("option"); 
		                op.value = json.saia[i].security_group_id;  
		                op.innerHTML =json.saia[i].security_group_name; 
		                document.getElementById("security_group_id").appendChild(op); 
                        
                     }
                 }
                 
            });
        }
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'  value=\"" + entity.getProperty("emp_post_id") + "\">";
    }

        
    function checkradio(xlid){  //点击行，选中对应的radio
        var elementRadio = document.getElementsByName("temp");  //
       
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].value==xlid) {  //如果被选中
                elementRadio[i].checked=true;  
                break;
            }
        }
        
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("emppostback_init").loadData();
        $id("emppostback_init").refresh();
    }

    //<fmt:message key='listSecurityUpdate_yd0070'/>信息 参数为PB_EMP_POST<fmt:message key='listSecurityUpdate_yd0009'/>id
    function detail_onClick(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids<fmt:message key='listSecurityUpdate_yd0010'/>
            alert('<fmt:message key='listSecurityUpdate_yd0011'/>');
            return;
        }
        if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate_yd0012'/>');
            return;
        }
        if(ids!=null && ids!=""){
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+ids,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
            //window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrderBack&id='+ids,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
        }
    }
    
    //<fmt:message key='listSecurityUpdate_yd0070'/>信息 参数为PB_EMP_POST<fmt:message key='listSecurityUpdate_yd0009'/>id
    function detail_update_onClick(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids<fmt:message key='listSecurityUpdate_yd0010'/>
            alert('<fmt:message key='listSecurityUpdate_yd0011'/>');
            return;
        }
        if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate_yd0012'/>');
            return;
        }
        if(ids!=null && ids!=""){
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+ids,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
            //window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrderBack&id='+ids,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
        }
    }
    
    //查看按钮
    function detail_Click(){
        //取得办理ID
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids<fmt:message key='listSecurityUpdate_yd0010'/>
            alert('<fmt:message key='listSecurityUpdate_yd0011'/>');
            return;
        }
        if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate_yd0012'/>');
            return;
        }
        var type = jQuery("#type").val();
        var types = '';
        if(type=='1') types='offsite_social_security';
        if(type=='2') types='offsite_provident_fund';
        
        if(ids!=null && ids!=""){
            var datacell = $id("emppostback_init");//datacell列表对象
            var dataset = datacell.dataset;
            var trentity = dataset.findEntity("emp_post_id", ids);
            var securityId = trentity.getProperty("security_id");
            
            if(securityId == null || securityId == ""){
                alert('<fmt:message key='listSecurityUpdate_yd0022'/>');
                return;
            }
            window.open('<venus:base/>/EmpsecurityAction.do?cmd=detailQuerySocialSecurity&securityId=' + securityId +'&types='+types,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
            
        }
    }
    
    //批量提交审核
    function toUpdateAll_onClick(){
        if(checkAllCont()){
            
            var dc1 = $id("emppostback_init");
            var ids = findSelection("temp");  //取得多选框的选择项
            var postids = '';
            for(var i=0;i<ids.length;i++){
                if(i==0){
                    postids= ids[i];
                }else{
                    postids = postids+','+ids[i];
                }
            }
            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=toUpdateOver";
            var xmlSubmit = dc1.dataset.toString();
            var myAjax = new Ajax(action);
            var form = $id("simpleQuery");
            var group_id = jQuery("#security_group_id").val();
             myAjax.addParam("group_id", group_id);
             myAjax.addParam("ids", postids);
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate_yd0023'/>');
                     window.location.reload();
                 } else if ( myAjax.getValue("root/data/returnValue") == 2 ) {
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate_yd0024'/>');
                     window.location.reload();
                 }else if ( myAjax.getValue("root/data/returnValue") == 0 ) {
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate_yd0025'/>!');
                     window.location.reload();
                 }else{
                     alert(myAjax.getValue("root/data/returnValue"));
                     return;
                 }
            }
            
        }
    }
    
     function checkAllCont(){//页面提交验证
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids<fmt:message key='listSecurityUpdate_yd0010'/>
            alert('<fmt:message key='listSecurityUpdate_yd0011'/>');
            return;
        }
        
        var ali = true;
        var datacell = $id("emppostback_init");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0;i<ids.length;i++){
            var datasettr = dataset.findEntity("emp_post_id",ids[i]);
            var post_id = datasettr.getProperty("emp_post_id");
            
            var is_update_security=datasettr.getProperty("is_update_security");
            //选择了<fmt:message key='listSecurityUpdate_yd0072'/>社保公积金，才需要验证
            if(is_update_security=='1'){
	            var start_month = datasettr.getProperty("start_month");
	            var end_month = datasettr.getProperty("end_month");
	            var securityId = datasettr.getProperty("security_id");
	            var securitystatus = datasettr.getProperty("security_status_bd");
                var empname = datasettr.getProperty("emp_name");
	            if(end_month==null || end_month==''){
	                alert('<fmt:message key='listSecurityUpdate_yd0028'/>');
	                return;
	            }
	            if(start_month==null || start_month==''){
	                alert('<fmt:message key='listSecurityUpdate_yd0029'/>');
	                return;
	            }
	            if(securityId == null || securityId == ""){
                    alert('<fmt:message key='listSecurityUpdate_yd0030'/>:'+empname+'<fmt:message key='listSecurityUpdate_yd0031'/>');
                    return;
                }
                if(securitystatus != null && securitystatus == "2"){
                    alert('<fmt:message key='listSecurityUpdate_yd0030'/>:'+empname+'<fmt:message key='listSecurityUpdate_yd0082'/>');
                    return;
                }
            }
        }
        return ali;
    }
    
    //原先单个提交的方法，已作废
    function toUpdateAll_onClick(type) {
        var ids = findSelection("temp");  //取得多选框的选择项
        var group_id = jQuery("#security_group_id").val();
        if(ids == null) {  //如果ids<fmt:message key='listSecurityUpdate_yd0010'/>
            alert('<fmt:message key="select_one_record"/>');
            return;
        }else{
            var datacell = $id("emppostback_init");
            var dataset = datacell.dataset;//取得页面的datacell
            var datasettr = dataset.findEntity("emp_post_id", ids);
            
            var start_month = datasettr.getProperty("start_month");
            var end_month = datasettr.getProperty("end_month");
            var securityId = datasettr.getProperty("security_id");
            if(end_month==null || end_month==''){
                alert('<fmt:message key='listSecurityUpdate_yd0028'/>');
                return;
            }
            if(start_month==null || start_month==''){
                alert('<fmt:message key='listSecurityUpdate_yd0029'/>');
                return;
            }
            if(securityId == null || securityId == ""){
                alert('<fmt:message key='listSecurityUpdate_yd0040'/>');
                return;
            }
            
            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=toUpdateOver";
            var myAjax = new Ajax(action);
            myAjax.addParam("id", ids);
            myAjax.addParam("group_id", group_id);
            myAjax.addParam("start_month", start_month);
            myAjax.addParam("end_month", end_month);
              
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate_yd0041'/>!');
                 } else if ( myAjax.getValue("root/data/returnValue") == 2 ) {
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate_yd0024'/>');
                 }else{
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate_yd0025'/>!');
                 }
                 window.location.reload();
            }
            
        }
        
    }
    
    //<fmt:message key='listSecurityUpdate_yd0073'/><fmt:message key='listSecurityUpdate_yd0078'/>
    function toRebutAll_onClick(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids<fmt:message key='listSecurityUpdate_yd0010'/>
            alert('<fmt:message key='listSecurityUpdate_yd0011'/>');
            return;
        }
        if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate_yd0046'/>');
            return;
        }
        var security_group_id = jQuery("#security_group_id").val();
        if(ids!=null && ids!=""){
            var val = window.showModalDialog('/FAERP/EmppostAction.do?cmd=toRebutPage&id='+ids+'&group_id='+security_group_id,'','dialogHeight:300px;dialogWidth:600px;center:yes;help:no;resizable:no;scroll:no;status:no;');
            if(val=='1'){
                simpleQuery_onClick();
            }
        }
    }
    
        //新收费起始月有变动，原收费截止月自动<fmt:message key='listSecurityUpdate_yd0072'/>为起始月减一个月
    function anyStartMonth(){
        var datacell = $id("emppostback_init");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前<fmt:message key='listSecurityUpdate_yd0078'/>的行dataset
        
        var fields = datacell.fields;//获得页面所有的列
        
        var start_month = datasettr.getProperty("start_month");
        
        if(!checkMonth(start_month,'<fmt:message key='listSecurityUpdate_yd0047'/>')){
            datasettr.setProperty("start_month","");
            return;
        }
        
        var end_month = toEndmonth(start_month);
        datasettr.setProperty("end_month", end_month);
        
        //其他打钩的行也要联动
        var rowNo=activeRow.rowIndex;
        if($id("temp_"+rowNo).checked){//已经勾选上
            var temps = document.getElementsByName("temp");
            var number = 0;  //定义游标
            var ids = null;  //定义id值的数组
            for(var i=0;i<temps.length;i++){  //循环checkbox组
                 if(temps[i].checked) {  //如果被选中,则替换
                      var enCurEntity = $id("emppostback_init").dataset.get(i);
                      enCurEntity.setProperty("start_month", start_month);
                      enCurEntity.setProperty("end_month", end_month);
                          
                      $id("emppostback_init").refreshRow($id("emppostback_init").getRow(i));
                      
                  }
            }
        }
       
    }
    
    //<fmt:message key='listSecurityUpdate_yd0090'/>为<fmt:message key='listSecurityUpdate_yd0047'/>减一个月
    function toEndmonth(start_month){
        var year=start_month.substring(0,4);
        var month=start_month.substring(4,6);
        
        var end_month='';
        if(parseFloat(month)==1){
            var year1=parseFloat(year)-1;
            var month1=12;
            end_month = year1+''+month1;
        }else{
            var month1=parseFloat(month)-1;
            if(month1<10){
                end_month = year+'0'+month1;
            }else{
                end_month = year+''+month1;
            }
        }
        
        return end_month ;
    
    }
    
//判断某个六位数是不是年份月份格式yyyymm
function checkMonth(yearMonth,msg){
  if(yearMonth=="") return true;  
  var rtn=true;
  var s=yearMonth+"";
  //alert(s.length);
  if(s.length!=6) rtn=false;
  if(!checkNumber(yearMonth))rtn=false; //必须全是数字
  var year=s.substring(0,4);
  var month=s.substring(4,6);
  if(parseFloat(year)<2000 || parseFloat(year)>2030) rtn=false;
  if(parseFloat(month)<1 || parseFloat(month)>12) rtn=false;
  
  if(!rtn){
     alert(msg+"<fmt:message key='listSecurityUpdate_yd0051'/>!");     
  }  
  return rtn;
}

</script>
</head>
<body>


<div id="right">
<script language="javascript">
    writeTableTopFesco('<%=tablename %>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<form name="form" method="post" id="simpleQuery">
<input type="hidden" name="cmd" value="queryAllpost">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listSecurityUpdate_yd0052'/></div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>

        <tr>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0053'/></td>
            <td align="left">
                <select id="city_id" name="city_id" onchange="searchSecurityGroup()">
                    <option value="1099110100000000357"><fmt:message key='listSecurityUpdate_yd0054'/></option>
                    <option value="1099110100000000198"><fmt:message key='listSecurityUpdate_yd0055'/></option>
                </select>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0056'/></td>
            <td align="left">
                <select id="security_group_id" name="security_group_id">
                    
                </select>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0057'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listSecurityUpdate_yd0057'/>" maxLength="25"/>
            </td>
            
           
        </tr>
        <tr>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0059'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listSecurityUpdate_yd0059'/>" maxLength="50"/>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0061'/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="<fmt:message key='listSecurityUpdate_yd0061'/>" maxLength="25"/>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0063'/></td>
            <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listSecurityUpdate_yd0063'/>" maxLength="64"/>
            </td>
            
            
        </tr>
        <tr>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0065'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listSecurityUpdate_yd0065'/>" maxLength="50"/>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0067'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listSecurityUpdate_yd0067'/>" maxLength="64"/>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate_yd0069'/></td>
            <td>
               <faerp:SoialunitSelectTag  tagname="security_unit_id"  beanname="security_unit_id" />
            </td>
            <td align="right"></td>
        </tr>
        <tr>
            <td colspan="6" align="center">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
       
    
</table>

</div>


 


<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="a_4"><a onClick="javascript:detail_update_onClick()"><fmt:message key='listSecurityUpdate_yd0070'/></a></li>
                    <li class="a_2"><a onClick="javascript:detail_Click()"><fmt:message key='listSecurityUpdate_yd0071'/></a></li>
                    <li class="gg"><a onClick="javascript:toUpdateAll_onClick()"><fmt:message key='listSecurityUpdate_yd0072'/></a></li>
                    <li class="gg"><a onClick="javascript:toRebutAll_onClick()"><fmt:message key='listSecurityUpdate_yd0073'/></a></li>
                </ul>
         -->
                     <input class="a_4" type="button"   value=" <fmt:message key='listSecurityUpdate_yd0070'/>"  <au:authorityBtn code="view_orderItem18" type="1"/>  onClick="detail_update_onClick();">
                     <input class="a_2" type="button"   value=" <fmt:message key='listSecurityUpdate_yd0071'/>"  <au:authorityBtn code="ydsbbg_cksbbl" type="1"/>  onClick="detail_Click();">
                     <input class="gg" type="button"   value=" <fmt:message key='listSecurityUpdate_yd0072'/>"  <au:authorityBtn code="ydsbbg_bg" type="1"/>  onClick="toUpdateAll_onClick();">
                     <input class="gg" type="button"   value=" <fmt:message key='listSecurityUpdate_yd0073'/>"  <au:authorityBtn code="ydsbbg_bh" type="1"/>  onClick="toRebutAll_onClick();">
         </div>
           <div class="clear"></div>            
</div>
                    <r:datacell 
                         id="emppostback_init"
                         queryAction="/FAERP/EmppostAction.do?cmd=toRebackQuery"
                         width="100%"
                         xpath="EmppostVo"
                         submitXpath="EmppostVo"
                         paramFormId="simpleQuery"
                         >
                         <r:toolbar  tools="nav,pagesize,info"/>
                         <r:field fieldName="emp" label="<fmt:message key='listSecurityUpdate_yd0078'/><input type='checkbox' name='empselect' onclick='emp_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus" sortAt="none" align="center">
                         </r:field>   
                         <r:field fieldName="emp_name" sortAt="none" label="<fmt:message key='listSecurityUpdate_yd0059'/>">
                         </r:field>
                          <r:field fieldName="emp_code" sortAt="none" messagekey='listSecurityUpdate_yd0057'>
                         </r:field>
                         <r:field fieldName="id_card_type_bd" sortAt="none" messagekey='listSecurityUpdate_yd0081' allowModify="false">
                             <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                         </r:field>
                         <r:field width="160" fieldName="id_card" sortAt="none" messagekey='listSecurityUpdate_yd0063'>
                         </r:field>
                         <r:field fieldName="cust_code" sortAt="none" messagekey='listSecurityUpdate_yd0065'>
                         </r:field>
                         <r:field width="250" fieldName="cust_name" sortAt="none" messagekey='listSecurityUpdate_yd0067'>
                         </r:field>
                         <r:field fieldName="big_type_name" sortAt="none" messagekey='listSecurityUpdate_yd0085'>
                         </r:field>
                         <r:field fieldName="small_type_name" sortAt="none" messagekey='listSecurityUpdate_yd0086'>
                         </r:field>
                         <r:field fieldName="security_unit_id" sortAt="none" messagekey='listSecurityUpdate_yd0069' allowModify="false">
                            <r:comboSelect id="com2" 
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="listSecurityUpdate_yd0034">
                            </r:comboSelect>     
                         </r:field>
                         <r:field fieldName="is_update_security" sortAt="none" label="<fmt:message key='listSecurityUpdate_yd0083'/>">
                             <d:select dictTypeId="TrueOrFalse"/>
                         </r:field>
                         <r:field fieldName="start_month" sortAt="none" messagekey='listSecurityUpdate_yd0047' allowModify="true">
                            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" onchange="javascript:anyStartMonth();"/>
                         </r:field>
                         <r:field fieldName="end_month" sortAt="none" messagekey='listSecurityUpdate_yd0090' allowModify="true">
                            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
                         </r:field>
                       </r:datacell>
    
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>

<script>
$id("emppostback_init").beforeRefreshCell = function(cell,field){
        if(field && field.fieldId && field.fieldId.indexOf("emp") >= 0){
            return false;
        }
        return true;
    }
</script>
