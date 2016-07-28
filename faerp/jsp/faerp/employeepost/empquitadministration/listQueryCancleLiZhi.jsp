<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.project.IToolsConstants"%>

<html>
<fmt:bundle basename="rayoo.employeepost.empquitadministration.empquitadministration_resource" prefix="rayoo.employeepost.empquitadministration.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<%
String kefuid = (String)request.getAttribute("kefuid");
if(kefuid==null || "".equals(kefuid)){
    kefuid = "1099100700000000105";
}
request.setAttribute("kefuid",kefuid);
%>
<script language="javascript">

        //客户名称查询条件
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         document.form.cust_name.value=data[2];
    }


     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'         value=" + entity.getProperty("id") + "       >";
    }
    
       function tolistservice(value,entity,rowNo,cellNo){
       return "<a onClick='javascript:openTOListService();'><fmt:message key="setted"/></a>";
    }
    
      function   openTOListService(){
    //  alert("123");
    var enCurEntity = $id("datacell1").activeEntity;
    var end_date = enCurEntity.getProperty("end_date1");
        var id = enCurEntity.getProperty("id");
        
        if(end_date==null||end_date==""){
        
              alert("<fmt:message key="please_check_in_fee_end_date"/>");
        return;
        }
        
        var url="<venus:base/>/EmppostAction.do?cmd=tolistService&id="+id+"&end_date="+end_date; 
        showModalCenter(url, window, "", 800, 430, '设定服务');  //增加子岗位
  //    window.showModalDialog(','','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    }

    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function toAdd_onClick() { 
        $id("datacell1").addRow();
    }
    
    function deleteMulti_onClick(){ 
             $id("datacell1").deleteRow();
    }
    
    function toSave_onClick() { 
    
          var product_name = document.getElementsByName("temp");
          //alert(product_name.length);
          var number = 0;  //定义游标
          var ids = null;  //定义id值的数组
          var emp_names=null;//2015-5-4 yangyuting 
          for(var i=0;i<product_name.length;i++){  //循环checkbox组
                if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                     $id("datacell1").isModefied = true;
                     enCurEntity.status = Entity.STATUS_MODIFIED;
                     number += 1;  //游标加1
                     if(ids == null) {
                        ids = product_name[i].value;
                     }else{
                        ids = ids+','+product_name[i].value;
                     }
                     //2015-5-4 yangyuting add
                      if(enCurEntity.getProperty("is_Offpost_phoenix")=="1"){
                            if(emp_names==null)
                              emp_names=enCurEntity.getProperty("emp_name") ;
                            else
                              emp_names=emp_names+','+enCurEntity.getProperty("emp_name") ;
                     }
                }
         }
        
         if(ids==null||ids==""){
            alert("<fmt:message key="please_choose_emp"/>");
            return;
         }
         //2015-5-4 yangyuting add
         if(emp_names!=null){
	         if(confirm(emp_names+"员工已经选择离职E化，撤销离职需要线下邮件至ruzhi@fescoadecco.com通知call center，若要继续撤销报离，请按确认！"))
	         {
	         }else{
	           return;
	         }
         }
         var dc1 = $id("datacell1");
         var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=undoOffPost";
         var xmlSubmit = dc1.dataset.toString();
         var myAjax = new Ajax(action);
            
         myAjax.addParam("ids", ids);
         myAjax.submitXML(xmlSubmit, 'UTF-8');
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
            if( myAjax.getValue("root/data/returnValue") !=null && myAjax.getValue("root/data/returnValue")!='') {
                 alert( myAjax.getValue("root/data/returnValue") );
                 $id("datacell1").reload();
            } else {
                 alert( '<fmt:message key="no_any_cancle_off_post_info"/>' ); 
            }
         }
         //$id("datacell1").submit();
    }
    
    function toReload_onClick() {
         $id("datacell1").reload();
    }
    /* 
   function custInit(){
      $id('lk_cust').beforeOpenDialog= function(lookup){
         var enCurEntity = $id("datacell1").activeEntity;
        lookup.clearParam();
        var end_date = enCurEntity.getProperty("end_date1");
        var id = enCurEntity.getProperty("id");
        lookup.addParam("end_date",end_date);
        lookup.addParam("id",id);
        return true;
      }
    }
    */ 
    
    

    
    
  function detail_onClick(){  //实现转到详细页面
          var enCurEntity = $id("datacell1").activeEntity;
          var emp_post_id = enCurEntity.getProperty("id");
        
        if(emp_post_id!=null&&emp_post_id!=""){
            //window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:no;status:no;');
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
        }else{
            alert("<fmt:message key="select_records"/>");
            return;
        }
    }
    
    
    
            //派出单位选择回调函数
    function rtnFuncSend(arg){
        var lookup = $id("cust_send_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    
    //接收单位选择回调函数
    function rtnFuncRecive(arg){
        var lookup = $id("cust_receive_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    
    
    
   
    


</script>
</head>
<body>

<form name="form" method="post" id="empqeclarqepart_formid">
 <input type="hidden" id="isClickQuery" value="false" />
<div id="right">
<script language="javascript">
      writeTableTopFesco('<fmt:message key="cancle_off_post"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

        <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left">
               <input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="10"/>            </td>
            <td align="right"><fmt:message key="internal_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="客户方编号" maxLength="64" style="width:250"/>            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" inputName="身份证号" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="cust_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="64"/>           </td>
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
                <input type="text" class="text_field" id="cust_name" name="cust_name"  validators="isSearch" inputName="客户名称" maxLength="50" style="width:250"/>
           </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key="user_name"/></td>
          <td align="left">
          
          
            <r:comboSelect id="combo_cs" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_choose" />
          
          
           </td>
            <td align="right"><fmt:message key="cust_send_id"/></td>
            <td align="left">
         <w:lookup onReturnFunc="rtnFuncSend" readonly="false" id="cust_send_id" displayValue=""   name="cust_send_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" messagekey="choose_agent" height="440" width="800" style="width:170px">
                </w:lookup>
            
              </td>
            <td align="right"><fmt:message key="cust_receive_id"/></td>
            <td align="left">            
              <select name="cust_receive_id" id="cust_receive_id" style="width:250">
                     <option value="">请选择</option>
                     <option value="<%=IToolsConstants.AGENT_SH%>">北京外企德科人力资源服务上海有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_BJ%>">北京外企人力资源服务有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_WD%>">外地供应商</option>
               </select>                      
        </td>
        </tr>
        <tr>
              <td align="right"><fmt:message key="send_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="send_name" inputName="委派单名称" maxLength="64"/>            </td>
              <td align="right"><fmt:message key="off_post_date"/></td>
              <td>  <w:date  format="yyyy-MM-dd" name="off_post_date"  />            &nbsp;<fmt:message key="to"/>             <w:date  format="yyyy-MM-dd" name="off_post_date1"  /></td>
              
              
              
              <td>
                 <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;showListData()">
             </td>
             <td>   
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
        </tr>
</table>
</div>

<input type="hidden" name="empid" id="empid" value="">                  
<div id="ccParent1" class="button"> 
     <div class="button_right">
        <!--<ul>
                     <li class="a">      <a  onClick="javascript:detail_onClick();">查看</a> </li>
                     <li class="bc">      <a  onClick="javascript:toSave_onClick();">撤销离职</a> </li>
        </ul>
    -->
    <input type="button" class="a" value='<fmt:message key="view"/>' <au:authorityBtn code="cxlz_view" type="1"/> onClick="detail_onClick();" />
    <input type="button" class="bc" value='<fmt:message key="cancle_off_post"/>' <au:authorityBtn code="cxlz_cxlz" type="1"/> onClick="toSave_onClick();" />
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=queryListCancleLizhi"
        submitAction="/FAERP/EmppostAction.do?cmd=undoOffPost"
        width="98%"
        height="320px"
        xpath="EmppostVo"
        submitXpath="EmppostVo"
        paramFormId="empqeclarqepart_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
      </r:field>
      <r:field fieldName="emp_code" messagekey="emp_code">
      </r:field>
      <r:field fieldName="emp_name" messagekey="emp_name">
       </r:field>    
      <r:field fieldName="internal_code" messagekey="internal_code">
       </r:field>
       <r:field fieldName="id_card_type_bd" messagekey="credentials_type" allowModify="false">
        <d:select dictTypeId="ID_CARD_TYPE_BD" />
      </r:field>
      <r:field fieldName="id_card" messagekey="emp_card_no1" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="cust_name" messagekey="cust_name" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="send_name" messagekey="send_name" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="emp_post_type_bd" messagekey="on_post_type" allowModify="false">
        <d:select dictTypeId="EMP_POST_TYPE_BD" />
      </r:field>    
      <r:field fieldName="start_date" messagekey="fee_start" allowModify="false">
          <w:date  format="yyyy-MM-dd" name=""  />
      </r:field>
      <r:field fieldName="end_date" messagekey="fee_end" allowModify="false">
         <w:date  format="yyyy-MM-dd" name=""  />
      </r:field>
      <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date"   allowModify="false">
       <w:date  format="yyyy-MM-dd" name=""  />
      </r:field>
      
      
      
      
      <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1"   allowModify="false">
          <w:date  format="yyyy-MM-dd" name=""  />
      </r:field>
      <r:field fieldName="off_post_date" messagekey="off_post_date1"  allowModify="false">
        <w:date format="yyyy-MM-dd" name=""/>
      </r:field>
      
      
      
      <r:field fieldName="off_post_user_name" messagekey="off_post_user_id">
      </r:field>
      
      <r:field fieldName="off_post_reason" messagekey="off_post_reason"  allowModify="false">
        <d:select dictTypeId="OFF_POST_REASON" />
      </r:field>
      
      <r:field fieldName="ge_off_post_reason" messagekey="ge_off_post_reason"  allowModify="false">
        <d:select dictTypeId="GE_OFF_POST_REASON" />
      </r:field>
      
      <r:field fieldName="off_post_desc" messagekey="off_post_desc">
        </r:field>
        <r:field fieldName="name" messagekey="user_name">
      </r:field>
      <r:field fieldName="off_post_desc" messagekey="off_post_desc">
        </r:field>
      <r:field fieldName="isonline" label="是否线上" width="0">
      </r:field>
      <r:field fieldName="is_Offpost_phoenix" label="是否E化离职" width="0">
      </r:field>
   
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">

    //解决修改行数据，多选框勾选消失BUG
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
    
    
    
<!--
   

 //  eventManager.add(window,"load",custInit);
  



  //根据离职日期得到收费结束日期
  
  function    getDate(newValue){
                 var  apply_off_post_date="";
                  var apply_on_post_date=newValue;
                  var  date =apply_on_post_date.split('-');
                  var day=date[2];
                  var month=date[1];
                  var year=date[0];
                    if(day>=16){
                        month=date[1];
                    }else{
                        month=month-1;
                    }
                      if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
                         day=31;
                       }else if(month==4||month==6||month==9||month==11){
                         day=30
                       }else {
                             if((year%4==0 && year%l00!=0) || year%400==0){
                                day=29;
                             }else{
                                day=28;
                             }
                       }
                      apply_off_post_date=date[0]+"-"+month+"-"+day;
          
          return apply_off_post_date;
  }
  
      //初次进来页面 datacell不进行查询
    $id("datacell1").afterSubmit = function(ajax){
       alert(""+ajax.getProperty("returnValue"));
    }
  

//-->
</script>

