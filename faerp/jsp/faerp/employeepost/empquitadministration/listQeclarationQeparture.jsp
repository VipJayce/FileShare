<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.project.IToolsConstants"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<script type="text/javascript">
    jQuery.noConflict();
</script>

<fmt:bundle basename="rayoo.employeepost.empquitadministration.empquitadministration_resource" prefix="rayoo.employeepost.empquitadministration.">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>code generate</title>
<%
//客服主键
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
       return "<input type='checkbox'  name='temp'    id='temp_"+rowNo+"'    value=" + entity.getProperty("id") + "   >";
    }
    
    //员工列表，点击全选按钮
    function emp_onClick(obj){
        var datacell = $id("datacell1");
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
    
       function tolistservice(value,entity,rowNo,cellNo){
       return "<a onClick='javascript:openTOListService();'><fmt:message key="setted"/></a>";
    }
    
      function   openTOListService(){
    //  alert("123");
    var enCurEntity = $id("datacell1").activeEntity;
    var end_date = enCurEntity.getProperty("end_date1");
     var start_date = enCurEntity.getProperty("start_date");
        var id = enCurEntity.getProperty("id");
        
        if(end_date==null||end_date==""){
        
              alert("<fmt:message key="please_check_in_fee_end_date"/>");
        return;
        }
        
        var url="<venus:base/>/EmppostAction.do?cmd=tolistService&id="+id+"&end_date="+end_date+"&start_date="+start_date; 
        showModalCenter(url, window, "", 800, 430, '设定服务');  //增加子岗位
  //    window.showModalDialog(','','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    }
    
    //查询需要申报离职的人员
    function showListData(){
        //唯一号、姓名、身份证、公司4个选项任意必填2项
        //魏佳修改--原限定条件更改为 唯一号、姓名、身份证三个条件中至少选择一条，客户名称和客户编码至少选择一条公司
        var empCode = trim(jQuery("#emp_code1").val());
        var idCard = trim(jQuery("#id_card1").val());
        var empName = trim(jQuery("#emp_name1").val());
        var custName = trim(jQuery("#cust_name").val());
        var custCode = trim(jQuery("#cust_code1").val());
        var internalCode=trim(jQuery("#internal_code").val());
        var conditionCount2 = 0;
        var conditionCount3 = 0;
        if (custName != null && custName != "") {
            conditionCount2 += 1;
        }
        if (custCode != null && custCode != "") {
            conditionCount2 += 1;
        }
        
         if (conditionCount2 < 1) {
            alert("<fmt:message key='code_and_name_card_cust_must_check_in_two1'/>");
            return;
        }else{
            if (empCode != null && empCode != "") {
                conditionCount3 += 1;
            }
            if (idCard != null && idCard != "") {
                conditionCount3 += 1;
            }
            if (empName != null && empName != "") {
                conditionCount3 += 1;
            }
            if(internalCode!=null && internalCode!=""){
                conditionCount3 += 1;
            }
            if (conditionCount3 < 1) {
                alert("<fmt:message key='code_and_name_card_cust_must_check_in_two'/>");
                return;
            }
        }
        
        if (conditionCount3 < 1 || conditionCount2 < 1) {
            alert("<fmt:message key="code_and_name_card_cust_must_check_in_two"/>");
            return;
        }
        
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
         var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
         var flag = "";
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
                     
                     //2015-3-23 yangyuting 检查该委派单是否是E化户，若不是则不给用户选择‘是’
                      var is_Offpost_phoenix = enCurEntity.getProperty("is_Offpost_phoenix");
                      var send_id = enCurEntity.getProperty("send_id");
                      var emp_post_id = enCurEntity.getProperty("id");
                      if(is_Offpost_phoenix=="1"){
                                var flagIsE=false;
                                var flagIsSHSB=false;
                                //2015-3-23 yangyuting 检查该委派单是否是E化户，若不是则不给用户选择‘是’
								     jQuery.ajax({
								           url: '<%=request.getContextPath()%>/QuickemppostAction.do?cmd=checkIsE&send_id='+send_id,
								           type: 'GET',
								           dataType: 'html',
								            async: false,
								           timeout: 80000,
								           error: function(){
								               alert('查询该客户是否为E化客户失败， 请联系管理员。');
								           },
								           success: function(text){
								               if(text!=null){     
								                  if(text=="0"){
								                    alert("您选择该员工的客户是'非E化客户'，故不能走E化，请选择‘否’！");
								                   } 
								                   else {
								                   flagIsE=true;
								                   }
								               }
								           }
								           });
								              if(flagIsE==false){
                                                return;
                                              } 
								            //2015-4-13 yangyuting 检查该员工的最新订单中是否是上海社保 若是才能做E化离职
								  //          jQuery.ajax({
                                 //          url: '<%=request.getContextPath()%>/QuickemppostAction.do?cmd=checkIsSHSB&emp_post_id='+emp_post_id,
                                 //          type: 'GET',
                                 //          dataType: 'html',
                               //             async: false,
                               //            timeout: 80000,
                                  //         error: function(){
                                 //              alert('查询该员工是否为上海社保失败， 请联系管理员。');
                               //            },
                                //           success: function(text){
                                 //              if(text!=null){     
                                 //                 if(text=="0"){
                                 //                   alert("您选择该员工的订单不是上海社保，所以无法走E化流程！");
                                //                   } 
                                //                   else {
                                  //                 flagIsSHSB=true;
                                //                   }
                                //               }
                                //           }
                                 //          });
								 //       if(flagIsSHSB==false){
								//            return;
							//	        } 
								        
                      }
                     var apply_off_post_date = enCurEntity.getProperty("apply_off_post_date");
                     if(apply_off_post_date==null||apply_off_post_date==""){
                            alert("<fmt:message key="off_post_not_null"/>");
                            return;
                     }
                     //alert("apply_off_post_date="+apply_off_post_date);
                     
                     var end_date1 = enCurEntity.getProperty("end_date1");
                     if(end_date1==null||end_date1==""){
                          alert("<fmt:message key="fee_end_date_not_null"/>");
                          return;
                     }
                     
                     
                     var off_post_reason = enCurEntity.getProperty("off_post_reason");
                              if(off_post_reason==null||off_post_reason==""){
                                     alert("<fmt:message key="off_post_reason_not_null"/>");
                                  return;
                         }      
                     
                     var emp_post_id = enCurEntity.getProperty("id");
                     var emp_name = encodeURI(enCurEntity.getProperty("emp_name"));
                     var emp_code = enCurEntity.getProperty("emp_code");
                     var start_date = enCurEntity.getProperty("start_date");
                     var isonline = enCurEntity.getProperty("isonline");
                     //魏佳新增
                    jQuery.ajax({
                        type : "post",
                        url : "<%=request.getContextPath()%>/EmppostAction.do?cmd=getLastPaymentDate&emp_post_id=" +emp_post_id+"&end_date="+end_date1+"&emp_name="+emp_name+"&emp_code="+emp_code+"&start_date="+start_date+"&send_id="+send_id+"&isonline="+isonline,
                        dataType : "html",
                        async:false,
                        success : function(data) {
                            flag += data+"||";
                        }
                    });
                    if(flag!=""){
                        break;
                    }
               }
        }
       if(flag!="" && flag!="0||" ){
           alert(flag.substr(0,flag.lastIndexOf('||')-1)); 
           return;
       }else{
            if(ids==null || ids==""){
	           alert("<fmt:message key="please_choose_emp"/>");
	           return;
	       }
	       var dc1 = $id("datacell1");
	       var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=offPost";
	       var xmlSubmit = dc1.dataset.toString();
	       var myAjax = new Ajax(action);
	           
	       myAjax.addParam("ids", ids);
	       myAjax.submitXML(xmlSubmit, 'UTF-8');
	       var returnNode = myAjax.getResponseXMLDom();
	       if( returnNode ) {
	           var returnStr = myAjax.getValue("root/data/returnValue");
	           if( returnStr == "1" ) {
	                alert( '<fmt:message key="apply_off_post_succese"/>' );
	                $id("datacell1").reload();
	           } else if( returnStr == "0") {
	                alert( '<fmt:message key="no_any_apply_off_post_info"/>' ); 
	                return;
	           } else if( returnStr == "2") {
                    alert( '<fmt:message key="no_any_apply_off_post_quanguo_info"/>' ); 
                    return;
               } /*else if( myAjax.getValue("root/data/returnValue") == "3") {
                    alert( '调用Xpress接口后处理返回的申报离职数据异常!' ); 
                    return;
               } else if( myAjax.getValue("root/data/returnValue") == "4") {
                    alert( '尚未分配项目书协议书，不能报离职' ); 
                    return;
               } else if( myAjax.getValue("root/data/returnValue") == "5") {
                    alert( '系统异常,数据交互失败' ); 
                    return;
               } else if( myAjax.getValue("root/data/returnValue") == "6") {
                    alert( '员工信息不存在' ); 
                    return;
               } else if( myAjax.getValue("root/data/returnValue") == "7") {
                    alert( '调用Xpress接口未返回任何数据!' ); 
                    return;
               } else if( myAjax.getValue("root/data/returnValue") == "8") {
                    alert( '交换平台与Xpress通讯失败，请稍后再试!' ); 
                    return;
               } else if( myAjax.getValue("root/data/returnValue") == "9") {
                    alert( '该员工有变更未审核通过，不能申报离职！' ); 
                    return;
               } */else{
                   if(returnStr.indexOf("#")>0){
                        alert( returnStr.replace("#","\n") ); 
                        $id("datacell1").reload();
                   }else{
                        alert( returnStr ); 
                        return;
                   }
	           }
	       }
	       //$id("datacell1").submit();
       }
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
          var emp_ids = document.getElementsByName("temp");
          var emp_post_id;
          
           for(var i=0;i<emp_ids.length;i++){  //循环checkbox组
              if(emp_ids[i].checked) { 
               if(emp_post_id == null) {
                        emp_post_id = emp_ids[i].value;
                     }else{
                         emp_post_id=emp_post_id+','+emp_ids[i].value;
                     }
                  }
              }
      if(emp_post_id!=null&&emp_post_id!=""){
         if(emp_post_id.split(',').length>1){
          alert("<fmt:message key="only_can_a_record"/>");
          return;
          }
          //var enCurEntity = $id("datacell1").activeEntity;
         // var emp_post_id = enCurEntity.getProperty("id");
          //  window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
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
      writeTableTopFesco('<fmt:message key="apply_off_post"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
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
               <input type="text" class="text_field" name="emp_code1" id="emp_code1" inputName="唯一号" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name1" id="emp_name1" inputName="员工姓名" maxLength="10"/>         </td>
            <td align="right"><fmt:message key="internal_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code"  id="internal_code" inputName="客户方编号" maxLength="64" style="width:250"/>            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left">
               <input type="text" class="text_field" name="id_card1" id="id_card1" inputName="身份证号" maxLength="64"/>            </td>
            <td align="right"><fmt:message key="cust_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" id="cust_code1" inputName="客户编号" maxLength="64"/>           </td>
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
                <input type="text"   class="text_field"  name="cust_name"  id="cust_name"  validators="isSearch" inputName="客户名称" maxLength="50"  style="width:250"/>
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
              <td>&nbsp;</td>
              <td>&nbsp;</td>
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
                     <li class="bc">      <a  onClick="javascript:toSave_onClick();">报离职</a> </li>
        </ul>
    -->
    <input type="button" class="a" value='<fmt:message key="view"/>' <au:authorityBtn code="sblz_view" type="1"/> onClick="detail_onClick();" />
    <input type="button" class="bc" value='<fmt:message key="off_post1"/>' <au:authorityBtn code="sblz_blz" type="1"/> onClick="toSave_onClick();" />
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=queryListShenbaoLizhi"
        submitAction="/FAERP/EmppostAction.do?cmd=offPost"
        width="98%"
        height="320px"
        xpath="EmppostVo"
        submitXpath="EmppostVo"
        paramFormId="empqeclarqepart_formid"
        freezeNumber="3"
        pageSize="50"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="<input type='checkbox' name='empselect' onclick='emp_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus" sortAt="none" align="center">
      </r:field>
      <r:field fieldName="emp_code" messagekey="emp_code" sortAt="none">
      </r:field>
      <r:field fieldName="emp_name" messagekey="emp_name" sortAt="none">
       </r:field>    
      <r:field fieldName="internal_code" messagekey="internal_code" sortAt="none">
       </r:field>
       <r:field fieldName="id_card_type_bd" messagekey="credentials_type" sortAt="none">
        <d:select dictTypeId="ID_CARD_TYPE_BD" />
      </r:field>
      <r:field fieldName="id_card" messagekey="emp_card_no1" sortAt="none">
        <h:text readonly="true"/>
      </r:field>
      <r:field width="200" fieldName="cust_name" messagekey="cust_name" sortAt="none">
        <h:text readonly="true"/>
      </r:field>
      <r:field width="220" fieldName="send_name" messagekey="send_name" sortAt="none">
        <h:text readonly="true"/>
      </r:field>
      <r:field fieldName="emp_post_type_bd" messagekey="on_post_type" sortAt="none">
        <d:select dictTypeId="EMP_POST_TYPE_BD" />
      </r:field>    
      <r:field fieldName="start_date" messagekey="fee_start" sortAt="none">
          <w:date  format="yyyy-MM-dd" name=""  />
      </r:field>
      <r:field fieldName="end_date" messagekey="fee_end" sortAt="none">
         <w:date  format="yyyy-MM-dd" name=""  />
      </r:field>
      <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date" sortAt="none">
       <w:date  format="yyyy-MM-dd" name=""  />
      </r:field>
      <!-- 2015-3-24 yangyuting add  E化离职-->
       <r:field fieldName="is_Offpost_phoenix" label="是否E化离职" sortAt="none">
        <d:select dictTypeId="IS_FOREIGNER" />
      </r:field>
      <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1" sortAt="none">
        <w:date id="wdate_off_date"  format="yyyy-MM-dd" name=""  />
      </r:field>
      <r:field fieldName="end_date1" messagekey="fee_end_date" sortAt="none">
        <w:date format="yyyy-MM-dd" name=""/>
      </r:field>
      <r:field fieldName="off_post_reason" messagekey="off_post_reason" sortAt="none">
        <d:select dictTypeId="OFF_POST_REASON" />
      </r:field>
      <r:field fieldName="end_date2" messagekey="fee_end_date1"  onRefreshFunc="tolistservice" sortAt="none">
      </r:field>
      <r:field fieldName="off_post_desc" messagekey="off_post_desc" sortAt="none">
        <h:text/>
      </r:field>
       <r:field fieldName="city_name" messagekey="send_city" sortAt="none">
        <h:text readonly="true"/>
      </r:field>
         <r:field fieldName="ge_off_post_reason" messagekey="ge_off_post_reason" sortAt="none">
        <d:select dictTypeId="GE_OFF_POST_REASON" />
      </r:field>
      <r:field fieldName="method_accu_move_bd" messagekey="method_accu_move" sortAt="none">
        <d:select dictTypeId="METHOD_ACCU_MOVE_BD" />
      </r:field>
      <r:field fieldName="location_retrieve_doc" messagekey="location_retrieve_doc" sortAt="none">
        <h:text    validateAttr="allowNull=false;"  />
      </r:field>
      <r:field fieldName="phoenix_emp_post_id" messagekey="phoenix_emp_post_id" width='0' sortAt="none">
      </r:field>
      <r:field fieldName="isonline" label="是否线上" width="0">
      </r:field>
      <r:field fieldName="send_id" label="send_id" width="0">
      </r:field>
    </r:datacell>
    </div>

</div>
</div>
</form>
</body>
</html>
<script type="text/javascript">

    //解决修改行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("emp") >= 0){
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
    //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
   //      var end_date1 = entity.getProperty("end_date1");
            var end_date1=this.getEntityByCell(cell).getProperty("end_date1");
         if (colIndex == 15){   
                if(null==end_date1||end_date1==""){
                   alert("<fmt:message key="please_check_in_fee_end_date"/>");
                return false;
                }
         }
          if (colIndex == 11||colIndex==10||colIndex==9||colIndex==8||colIndex==7||colIndex==6||colIndex==5||colIndex==4){  
                return false;
           }
           
         
        return true;
    }  

 //  eventManager.add(window,"load",custInit);
 //修改了一个离职日期，其他勾选的行也要跟着变化（由于与下面js有冲突，暂时屏蔽）
   // eventManager.add($id("wdate_off_date").inputObject,"change",clickIt);
  function clickIt (){
       //alert($id("wdate_apply_date").inputObject.value) ;
       var newValue = $id("wdate_off_date").inputObject.value;
       var end_date1=getDate(newValue);
       
       var product_name = document.getElementsByName("temp");
         //alert(product_name.length);
         var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
              if(product_name[i].checked) {  //如果被选中,全部替换
                   var enCurEntity = $id("datacell1").dataset.get(i);
                   enCurEntity.setProperty("apply_off_post_date", newValue);
                   enCurEntity.setProperty("end_date1", end_date1);
                   
                   $id("datacell1").refreshRow($id("datacell1").getRow(i));
               }
         }

  }
   
   //输入了离职日期，把前面的勾打上，清空离职日期，把勾去掉
  $id("datacell1").afterEdit = function (newValue,oldValue){
      var activeFieldName = $id("datacell1").activeField.fieldName;
      if (activeFieldName && activeFieldName != "apply_off_post_date" && activeFieldName != "end_date1" && activeFieldName != "off_post_reason") return true;
      
      var datacell = $id("datacell1");
      var activeRow = datacell.activeRow;
      var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
      var rowNo=activeRow.rowIndex;
      var input_date = newValue;
      
      //离职日期变化了，需要监控左边勾选变化
      if(activeFieldName == "apply_off_post_date"){
          if(input_date==null || input_date==''){
              if($id("temp_"+rowNo).checked){//已经勾选上
                  $id("temp_"+rowNo).checked=false;
              }
          }else{
             var end_date1=getDate(newValue);
             if(!$id("temp_"+rowNo).checked){//没有勾选上
                  $id("temp_"+rowNo).checked=true;
              }
              datasettr.setProperty("apply_off_post_date", newValue);
              datasettr.setProperty("end_date1", end_date1);//收费结束日期联动变化
              $id("datacell1").refreshRow(activeRow);
              
              //把其他打钩行同步更新
              changeAll(activeFieldName,input_date);
              
          }
      }
      
      //收费结束日期或离职原因变化了，联动变化其他勾选行
      if(activeFieldName == "end_date1" || activeFieldName == "off_post_reason"){
          if(input_date==null || input_date==''){//清空不作处理
          }else{
              if(!$id("temp_"+rowNo).checked){//没有勾选上，把勾打上
                   $id("temp_"+rowNo).checked=true;
               }
               datasettr.setProperty(activeFieldName, newValue);//收费结束日期或离职原因联动变化
               $id("datacell1").refreshRow(activeRow);
               
               //把其他打钩行同步更新
               changeAll(activeFieldName,input_date);
           }
      }

      
      
      
      return true;
  
  }
  
  //修改了一行的值，其他勾选的行,要跟着变化
    function changeAll(activeFieldName,newValue){
       
       var product_name = document.getElementsByName("temp");
         //alert(product_name.length);
         var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
              if(product_name[i].checked) {  //如果被选中,且离职日期为空，则替换
                   var enCurEntity = $id("datacell1").dataset.get(i);
                   if(activeFieldName == "apply_off_post_date"){
                       var end_date1=getDate(newValue);
                       enCurEntity.setProperty("apply_off_post_date", newValue);
                       enCurEntity.setProperty("end_date1", end_date1);
                   }else{
                       enCurEntity.setProperty(activeFieldName, newValue);
                   }
                       
                   $id("datacell1").refreshRow($id("datacell1").getRow(i));
                   
               }
         }
  }
  
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
                        if(month==1){
                            year=year-1;
                            month='12';
                        }else{
                            month=month-1;
                            month=month+'';
                        }
                    }
                      if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
                         day=31;
                       }else if(month==4||month==6||month==9||month==11){
                         day=30
                       }else {
                             if((year%4==0 && year%100!=0) || year%400==0){
                                day=29;
                             }else{
                                day=28;
                             }
                       }
                       if(month<10 && month.length==1){
                         apply_off_post_date=year+"-0"+month+"-"+day;
                       }else{
                         apply_off_post_date=year+"-"+month+"-"+day;
                       }
          
          return apply_off_post_date;
  }
  
      //初次进来页面 datacell不进行查询
    $id("datacell1").afterSubmit = function(ajax){
        alert(""+ajax.getProperty("returnValue"));
      //     alert("操作成功！");
     //       return true;
    }
  

//-->
</script>
</fmt:bundle>
