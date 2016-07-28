<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 

<%
String group_type="";
String type = (String)request.getParameter("type");
String tablename = "";
if(type!=null){
    if(type.equals("1")){
        tablename = "社保变更";
        group_type= "1";
    }else if(type.equals("4")){
        tablename = "公积金变更";
        group_type= "2";
    }
}

%>
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        $id("emppostback_init").isQueryFirst = false;
    });
    var vpath = "<%=request.getContextPath()%>";

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
    
    //员工列表，点击全选按钮
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
        var security_group_id=$id("group_List").getValue();
        if(security_group_id==null || security_group_id==''){
            alert('请选择社保公积金组！');
            return;
        }
        $id("emppostback_init").loadData();
        $id("emppostback_init").refresh();
    }

    //查看个人订单信息 参数为PB_EMP_POST表中的主键id
    function detail_onClick(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('请选择一条入职记录！');
            return;
        }
        if(ids.length>1){
            alert('查看只能选择一条入职记录！');
            return;
        }
        if(ids!=null && ids!=""){
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+ids,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
            //window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrderBack&id='+ids,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
        }
    }
    
    //查看个人订单信息 参数为PB_EMP_POST表中的主键id
    function detail_update_onClick(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('请选择一条入职记录！');
            return;
        }
        if(ids.length>1){
            alert('查看只能选择一条入职记录！');
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
        if(ids == null) {  //如果ids为空
            alert('请选择一条入职记录！');
            return;
        }
        if(ids.length>1){
            alert('查看只能选择一条入职记录！');
            return;
        }
        var type = jQuery("#type").val();
        var types = '';
        if(type=='1') types='social_security';
        if(type=='2') types='town_insurance';
        if(type=='3') types='complex_insurance';
        if(type=='4') types='provident_fund';
        
        if(ids!=null && ids!=""){
	        var datacell = $id("emppostback_init");//datacell列表对象
	        var dataset = datacell.dataset;
	        var trentity = dataset.findEntity("emp_post_id", ids);
	        var securityId = trentity.getProperty("security_id");
	        
	        if(securityId == null || securityId == ""){
	            alert('服务办理在缴数据不存在，请核对后重试！');
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
            var group_id = $id("group_List").getValue();
             myAjax.addParam("group_id", group_id);
             myAjax.addParam("ids", postids);
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
                     alert('<%=tablename%>成功，有记录还需等待其他组审核通过才能正式生效!');
                     window.location.reload();
                 } else if ( myAjax.getValue("root/data/returnValue") == 2 ) {
                     alert('<%=tablename%>成功，所有社保公积金均已完成变更!');
                     window.location.reload();
                 }else if ( myAjax.getValue("root/data/returnValue") == 0 ) {
                     alert('<%=tablename%>失败，请重新选择!');
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
        if(ids == null) {  //如果ids为空
            alert('请选择一条入职记录！');
            return;
        }
        
        var ali = true;
        var datacell = $id("emppostback_init");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0;i<ids.length;i++){
            var datasettr = dataset.findEntity("emp_post_id",ids[i]);
            var post_id = datasettr.getProperty("emp_post_id");
            var is_update_security=datasettr.getProperty("is_update_security");
            //选择了变更社保公积金，才需要验证
            if(is_update_security=='1'){
                var start_month = datasettr.getProperty("start_month");
                var end_month = datasettr.getProperty("end_month");
                var securityId = datasettr.getProperty("security_id");
                var securitystatus = datasettr.getProperty("security_status_bd");
                var empname = datasettr.getProperty("emp_name");
                if(end_month==null || end_month==''){
                    alert('请输入原缴费截止月');
                    return;
                }
                if(start_month==null || start_month==''){
                    alert('请输入新缴费起始月');
                    return;
                }
                if(securityId == null || securityId == ""){
                    alert('员工:'+empname+'，办理数据不存在，请核对后重试！');
                    return;
                }
                if(securitystatus != null && securitystatus == "2"){
                    alert('员工:'+empname+'，办理状态为待办理，“是否变更社保/公积金”请选择“否”！');
                    return;
                }
            }
                
        }
        return ali;
    }
    
    //原先单个提交的方法，已作废
    function toUpdateAll_onClick_one(type) {
        var ids = findSelection("temp");  //取得多选框的选择项
        var group_id = $id("group_List").getValue();
        if(ids == null) {  //如果ids为空
            alert('请选择一条入职记录！');
            return;
        }else{
            var datacell = $id("emppostback_init");
            var dataset = datacell.dataset;//取得页面的datacell
            var datasettr = dataset.findEntity("emp_post_id", ids);
            
            var start_month = datasettr.getProperty("start_month");
            var end_month = datasettr.getProperty("end_month");
            var securityId = datasettr.getProperty("security_id");
            if(end_month==null || end_month==''){
                alert('请输入原缴费截止月');
                return;
            }
            if(start_month==null || start_month==''){
                alert('请输入新缴费起始月');
                return;
            }
            if(securityId == null || securityId == ""){
                alert('服务办理在缴数据不存在，请核对后重试！');
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
	                 alert('<%=tablename%>成功!');
	             } else if ( myAjax.getValue("root/data/returnValue") == 2 ) {
	                 alert('<%=tablename%>成功，所有社保公积金均已完成变更!');
	             }else{
                     alert('<%=tablename%>失败，请重新选择!');
                 }
                 window.location.reload();
	        }
            
        }
        
    }
    
    //驳回操作
    function toRebutAll_onClick(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('请选择一条入职记录！');
            return;
        }
        var security_group_id = $id("group_List").getValue();
        if(ids!=null && ids!=""){
            var val = window.showModalDialog('/FAERP/EmppostAction.do?cmd=toRebutPage&id='+ids+'&group_id='+security_group_id,'','dialogHeight:300px;dialogWidth:600px;center:yes;help:no;resizable:no;scroll:no;status:no;');
            if(val=='1'){
                simpleQuery_onClick();
            }
        }
    }
    
    //新收费起始月有变动，原收费截止月自动变更为起始月减一个月
    function anyStartMonth(){
        var datacell = $id("emppostback_init");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var fields = datacell.fields;//获得页面所有的列
        
        var start_month = datasettr.getProperty("start_month");
        
        if(!checkMonth(start_month,'新缴费起始月')){
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
    
    //原缴费截止月为新缴费起始月减一个月
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
     alert(msg+"输入日期格式不正确!");     
  }  
  return rtn;
}

</script>
</head>
<body>


<div id="right">
<script language="javascript">
    writeTableTopFesco('<%=tablename %>','<%=request.getContextPath()%>/');  //显示本页的页眉
  //  writeTableTopFesco(<%=tablename%>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

 
<div id="ccChild0" class="search"> 
<form name="form" method="post" id="simpleQuery">
<input type="hidden" name="cmd" value="queryAllpost">
<input type="hidden" id="type" name="type" value="<%=type %>">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<input type="hidden" name="group_type" id="group_type" value="<%=group_type %>">


        <tr>
         <td  align="right">
                 <p>城 市&nbsp;</p>
            </td>
              <td align="left">
                        <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       value="1099110100000000357"
                       nullText="请选择" 
                       />
              </td>
                <td align="right">社保/公积金组&nbsp;</td>
              <td align="left">
              <%if(group_type.equals("1")){ %>
                     <r:comboSelect id="group_List" name="security_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=1"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="200px"
                       linkId="city_idList_search"
                       nullText="请选择" />
              <%}else if (group_type.equals("2")){ %>
                     <r:comboSelect id="group_List" name="security_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=2"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="200px"
                       linkId="city_idList_search"
                       nullText="请选择" />
              <%}%>
              </td>
        
            
            <td align="right">唯一号&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="25" />
            </td>
        </tr>
        <tr>
            <td align="right">员工姓名&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="25" />
            </td>
           
        
            <td align="right">客户方编号&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="客户方编号" maxLength="25" />
            </td>
            <td align="right">证件号码&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="证件号码" maxLength="25" />
            </td>
        </tr>
        <tr>
            <td align="right">客户编号&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="25" />
            </td>
               <td align="right">客户名称&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="客户名称" maxLength="25" />
            </td>
            
            <td align="right">福利办理方&nbsp;</td>
            <td>
               <faerp:SoialunitSelectTag  tagname="security_unit_id"  beanname="security_unit_id" style="width:205px" />
            </td>
        </tr>
        <tr>
            <td align="center" colspan="6">
                <input name="button_ok" class="icon_1"    type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
       
    
</table>

</div>


 


<div id="ccParent1" class="button"> 
 <div class="button_right"><!--
                <ul>
                    <li class="a_4"><a onClick="javascript:detail_update_onClick()">查看个人订单</a></li>
                    <li class="a_2"><a onClick="javascript:detail_Click()">查看社保办理</a></li>
                    <li class="gg"><a onClick="javascript:toUpdateAll_onClick()">变更</a></li>
                    <li class="gg"><a onClick="javascript:toRebutAll_onClick()">驳回</a></li>
                </ul>
         -->
                    <input class="a_4" type="button"   value="查看个人订单"  <au:authorityBtn code="view_orderItem12" type="1"/>  onClick="detail_update_onClick();">  
                    <%if(type.equals("4")){ %>
                        <input class="a_3" type="button"   value="查看公积金办理"  <au:authorityBtn code="sbbg_veiwSbbl" type="1"/>  onClick="detail_Click();">  
                   <%}
                    else{%>
                    <input class="a_2" type="button"   value="查看社保办理"  <au:authorityBtn code="sbbg_veiwSbbl" type="1"/>  onClick="detail_Click();">  
                  <%} %>
                    <input class="gg" type="button"   value="变更"  <au:authorityBtn code="sbbg_bg" type="1"/>  onClick="toUpdateAll_onClick();">  
                    <input class="gg" type="button"   value="驳回"  <au:authorityBtn code="sbbg_bh" type="1"/>  onClick="toRebutAll_onClick();">  
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
                         <r:field fieldName="emp" label="操作<input type='checkbox' name='empselect' onclick='emp_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus" sortAt="none" align="center">
                         </r:field> 
                         <r:field fieldName="emp_name" label="员工姓名">
                         </r:field>
                          <r:field fieldName="emp_code" label="唯一号">
                         </r:field>
                         <r:field fieldName="id_card_type_bd" label="证件类别" allowModify="false">
                             <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                         </r:field>
                         <r:field width="160" fieldName="id_card" label="证件号码">
                         </r:field>
                         <r:field fieldName="cust_code" label="客户编号">
                         </r:field>
                         <r:field width="250" fieldName="cust_name" label="客户名称">
                         </r:field>
                         <r:field fieldName="big_type_name" label="大分类">
                         </r:field>
                         <r:field fieldName="small_type_name" label="小分类">
                         </r:field>
                         <r:field fieldName="security_unit_id" label="福利办理方" allowModify="false">
                            <r:comboSelect id="com2" 
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                nullText="">
                            </r:comboSelect>     
                         </r:field>
                         <r:field fieldName="is_update_security" sortAt="none" label="是否变更社保/公积金">
                             <d:select dictTypeId="TrueOrFalse"/>
                         </r:field>
                         <r:field fieldName="start_month" label="新缴费起始月" allowModify="true">
                            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" onchange="javascript:anyStartMonth();"/>
                         </r:field>
                         <r:field fieldName="end_month" label="原缴费截止月" allowModify="true">
                            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
                         </r:field>
                         
                       </r:datacell>
    
</div>
</div>
</fmt:bundle>
</form>
</body>
</html>
<script>
$id("emppostback_init").beforeRefreshCell = function(cell,field){
        if(field && field.fieldId && field.fieldId.indexOf("emp") >= 0){
            return false;
        }
        return true;
    }
</script>
