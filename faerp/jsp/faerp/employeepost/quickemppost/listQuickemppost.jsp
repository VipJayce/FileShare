<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>


<%@page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants"%>
<html>
<fmt:bundle basename="rayoo.employeepost.emppostclass.emppostclass_resource" prefix="rayoo.employeepost.emppostclass.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
String company_id=rayoo.common.filter.UserInfoFilter.geCompanyId();
String city_id = (String)request.getAttribute("city_id");
if(city_id==null || "".equals(city_id)){
    city_id = "1099110100000000050";
}
request.setAttribute("city_id",city_id);
%>
<script type="text/javascript">

    function detail_onClick(){  //实现转到详细页面
          /*
          var product_name = document.getElementsByName("temp");
           var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var emp_post_id="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i);
                      emp_post_id = enCurEntity.getProperty("emp_post_id");
                     break;
              }
           }
           */
           var emp_post_id="";
           var dc = $id("datacell1");
           var entity = dc.getActiveEntity();
           emp_post_id = entity.getValue("emp_post_id");
                if(emp_post_id!=null&&emp_post_id!=""){
                    window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
                }else{
                    alert("<fmt:message key="select_records"/>");
                    return;
                }
    }




var cityID_flag = "";
 function setCheckboxStatus(value,entity,rowNo,cellNo){
        var cityID = entity.getProperty("city_id");
        var html = "";
        html = "<input type='checkbox'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("emp_service_id") + "\",\"" + cityID + "\",\"" + entity.getProperty("emp_post_id")  + "\");>";//city_idList
       return html;
    }

 function ClickRow(value,value1,value2){
     //判断是否选择的查询是部分，如果是则只能选择一条记录
     var is_part_savecalss = $id("is_part_savecalss").value  ;
     if(is_part_savecalss !=null&&is_part_savecalss=='1'){
      var ids = findSelections("temp","id");  //取得多选框的选择项
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert("部分提交时只能操作一位员工！");

            return false ;
        }
     }
     $id("v_emp_service_id").value = value ;
       cityID_flag = value1;
       $id("celllist1").queryParam= "<param><key>city_id</key><value>" + value1 +  "</value></param>";
       $id("celllist1").loadData();
       $id("celllist1").refresh();
  }


     function setCheckboxStatus1(value,entity,rowNo,cellNo){
       return "<input type='checkbox'     name='status'    >";
    }






     function setCheckbox1(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp1'   onClick=ClickRow1(\"" + entity.getProperty("emp_service_id") + "\",\"" + entity.getProperty("smaID") + "\",\"" + entity.getProperty("big_name") + "\");>";//city_idList
    }


       function ClickRow1(value,value1,big_name){
                $id("v_big_name").value = big_name ;
                var v_emp_service_id = $id("v_emp_service_id").value ;
                $id("celllist2").queryAction = "/FAERP/QuickemppostAction.do?cmd=findServiceById&smaID="+value1+"&v_emp_service_id="+v_emp_service_id;
		        $id("celllist2").loadData();
		        $id("celllist2").refresh();
    }
     function setCheckbox2(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template'  );>";//city_idList
    }


       function ClickRow2(value,value1){

    }

       function checkAll(field){
         var checkboxes = document.getElementsByName("checkbox_template");
         for(var i=0;i<checkboxes.length;i++){
             checkboxes[i].checked = field.checked;
         }
     }


    function findSelection(radioName, idName) {  //从radio中找出选中的id值列表
        var elementRadio = document.getElementsByName(radioName);  //
        var ids = null;  //定义id值
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].checked) {  //如果被选中
                ids=elementRadio[i].value;
            }
        }
        return ids;
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

     function save(){  //保存修改后的单条数据

        var product_name = document.getElementsByName("temp");
          var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var emp_post_id="";
          var emp_service_id="";
          var service_desc="";
          var status="";
          var is_employ_notice="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i);
                      emp_post_id += enCurEntity.getProperty("emp_post_id")+",";
                      emp_service_id+=enCurEntity.getProperty("emp_service_id")+",";
                      service_desc+=enCurEntity.getProperty("service_desc")+",";
                      status+=enCurEntity.getProperty("status")+",";
                      is_employ_notice+=enCurEntity.getProperty("is_employ_notice")+",";
              }
           }
        if(emp_post_id==null||emp_post_id==""){
            alert("<fmt:message key="select_records"/>");
            return;
        }else{
                    var flags=true;
                                jQuery.ajax({
                                url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=saveClass1&ids='+emp_post_id+"&date="+new Date()+"&emp_service_id="+emp_service_id+"&status="+status+"&is_employ_notice="+is_employ_notice+"&service_desc="+encodeURIComponent(service_desc),
                                type: 'GET',
                                dataType: 'html',
                                 async: false,
                                timeout: 80000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){
                                       if(text=="1"){
                                         alert("<fmt:message key="operation_succuse"/>");
                                     //     simpleQuery_onClick();
                                     } else if(text.length>1000){
                                            alert("<fmt:message key="operation_errer"/>");
                                       }else if(text=="2"){
                                          alert("<fmt:message key="operation_errer"/>");
                                       }
                                    }

                                }
                                });return flags;

        }
     }



















   //保存小类列表
                            function submit_onClick(is_part_savecalss){  //保存修改后的单条数据

                                       var product_name = document.getElementsByName("temp");
								          var number = 0;  //定义游标
								         var ids = null;  //定义id值的数组
								          var emp_post_id="";
								          var emp_service_id="";
								          var service_desc="";
								          var status="";
								            var cust_id="";
                                            var send_id="";
                                            var emp_id ="";
                                            var emp_service_id="";
                                            var cust_receive_id="";

                                            var city_id="";
								          	var big_name="";
								          	var affirm_is_new="";
								          var  n=0;
								         for(var i=0;i<product_name.length;i++){  //循环checkbox组
								          if(product_name[i].checked) {  //如果被选中
								                     var enCurEntity = $id("datacell1").dataset.get(i);
								                      emp_post_id += enCurEntity.getProperty("emp_post_id")+",";
								                      emp_service_id+=enCurEntity.getProperty("emp_service_id")+",";
								                      service_desc+=enCurEntity.getProperty("service_desc")+",";
								                      cust_id+=enCurEntity.getProperty("cust_id")+",";
								                      send_id+=enCurEntity.getProperty("send_id")+",";
								                      emp_id+=enCurEntity.getProperty("emp_id")+",";
								                      cust_receive_id+=enCurEntity.getProperty("cust_receive_id")+",";
								                       status+=enCurEntity.getProperty("status")+",";
								                       big_name+=enCurEntity.getProperty("big_name")+",";
								                       affirm_is_new +=enCurEntity.getProperty("is_new")+",";
								                       var city_idNew=enCurEntity.getProperty("city_id")   ;

								                       if(n!=0){
								                               if(city_id!=city_idNew){
								                                         alert("<fmt:message key="selecte_emp_by_city"/>");
								                                              return ;
								                               }
								                       }
								                       var is_mailcontract = enCurEntity.getProperty("is_mailcontract") ;
								                       var emp_name = enCurEntity.getProperty("emp_name") ;
								                       if(is_mailcontract ==null){
								                          alert("请先到客户级别设置里面设置委派单对应的合同处理类型！") ;
								                          return false  ;
								                       }

								                   city_id=city_idNew;
								                   n++;
								              }
								           }

							//如果是部分提交，则只能选择一位员工进行操作 tanyanjun
						   if(is_part_savecalss =='1'){
						      if(n>1){
						          alert("部分提交只能操作一位员工！") ;
						          return  false ;
						      }
						   }

                            if(emp_post_id==null||emp_post_id==""){
                               alert("<fmt:message key="selecte_emp"/>");
                                   return;
                            }

                          //新增确认转入类型效验 add by liuyu
							if(affirm_is_new==null || affirm_is_new=="" ){
								  alert("请选择确认转入类型！");
								  return false;
							  }


                           //  大类小类
                             var da="";
                              var temp1 = document.getElementsByName("temp1");
                                     for(var i=0;i<temp1.length;i++){  //循环checkbox组
                                          if(temp1[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist1").dataset.get(i);
                                                      da = enCurEntity.getProperty("smaID");
                                                      big_name = enCurEntity.getProperty("big_name");
                                                   //    alert("da="+da);
                                              }
                                           }

                              if(da==null||da==""){
	                                alert("<fmt:message key="classification_can_not_empty"/>");
	                               return;
                              }


                                     //  服务不可以为空（20130123陈小佩修改）
                             var fwids="";
                             var transacttypeids ="" ;  //办理类型
                             var accounts ="" ;    //社保公积金账号
                              var checkbox_template = document.getElementsByName("checkbox_template");
                                     for(var i=0;i<checkbox_template.length;i++){  //循环checkbox组
                                          if(checkbox_template[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist2").dataset.get(i);
                                                      fwids += enCurEntity.getProperty("service_id")+",";

                                                      if(enCurEntity.getProperty("group_type_bd")!=null){
                                                         if (enCurEntity.getProperty("transact_type_id") ==null||enCurEntity.getProperty("transact_type_id") ==''){
                                                            alert("社保公积金必须选择办理类型。") ;
                                                         	return false ;
                                                         }
                                                      }
                                                      //公积金产品非新开都要填写账号
                                                    //  if(enCurEntity.getProperty("group_type_bd")!=null&&enCurEntity.getProperty("group_type_bd")=='2'){
                                                    //     if(enCurEntity.getProperty("transact_type_name_str")!=null&&enCurEntity.getProperty("transact_type_name_str")!='新开'&&(enCurEntity.getProperty("account") == null||enCurEntity.getProperty("account") =='')&&enCurEntity.getProperty("service_name")!='公积金'){
                                                    //        alert("非新开账户，公积金账户必须填写") ;
                                                    //     	return false ;
                                                    //     }
                                                    //  }
                                                      if (enCurEntity.getProperty("transact_type_id") == null||enCurEntity.getProperty("transact_type_id") ==''){
                                                      transacttypeids += null+",";
                                                      }else{
                                                       transacttypeids += enCurEntity.getProperty("transact_type_id")+",";
                                                      }

                                                          accounts += enCurEntity.getProperty("account")+",";


                                                  //     alert("fwids="+fwids);
                                              }
                                           }

                              var security_handle_type = $id("security_handle_type").value ;
                              if (security_handle_type ==null||security_handle_type==''){
                              	alert("办理类型不能为空！") ;
                              	return false ;
                              }
                              if(fwids==null||fwids==""){
                                    if(confirm("<fmt:message key="is_sure_commit"/>")){

		                                //使用ajax保存小类列表及其对应大类
		                                validateSaveFw(emp_post_id,cust_id,send_id,emp_id,emp_service_id,fwids,da,cust_receive_id,status,service_desc,transacttypeids,accounts,security_handle_type,is_part_savecalss,big_name,affirm_is_new);
                                    }else{

                                        return;
                                    }
                              }else{

                                        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
                                            return false;
                                        }


                                    document.getElementById("sub").disabled=true;//防止重复提交
                                        //使用ajax保存小类列表及其对应大类
                                        validateSaveFw(emp_post_id,cust_id,send_id,emp_id,emp_service_id,fwids,da,cust_receive_id,status,service_desc,transacttypeids,accounts,security_handle_type,is_part_savecalss,big_name,affirm_is_new);

                              }




                            }


                            //ajax提交保存数据
                            function validateSaveFw(ids,cust_id,send_id,emp_id,emp_service_id,fwids,da,cust_receive_id,status,service_desc,transacttypeids,accounts,security_handle_type,is_part_savecalss,big_name,affirm_is_new){
                                 var flags=true;
                                 jQuery.ajax({
                                url: '<%=request.getContextPath()%>/QuickemppostAction.do?cmd=saveClassByQuickemppost&ids='+ids+'&da='+da+"&date="+new Date()+"&cust_id="+cust_id+"&send_id="+send_id+"&emp_id="+emp_id+"&emp_service_id="+emp_service_id+"&fwids="+fwids+"&cust_receive_id="+cust_receive_id+"&status="+status+"&service_desc="+encodeURIComponent(service_desc)+"&transacttypeids="+transacttypeids+"&accounts="+accounts+"&security_handle_type="+security_handle_type+"&is_part_savecalss="+is_part_savecalss+"&big_name="+encodeURIComponent(big_name)+"&affirm_is_new="+affirm_is_new,
                                type: 'post',
                                dataType: 'html',
                                error: function(){
                                    alert('Error loading XML document');
                                     document.getElementById("sub").disabled=false;//防止重复提交
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){
                                      //清空大小类和服务
                                       alert("<fmt:message key="operation_succuse"/>");
                                        $id("datacell1").loadData();
                                        $id("datacell1").refresh();
                                         document.getElementById("sub").disabled=false;//防止重复提交
                                      /*
                                       $id('celllist1').dataset = null;
                                       $id('celllist1').refresh();
                                        $id('celllist2').dataset = null;
                                        $id('celllist2').refresh();
                                       */

                                    }
                                }
                                });return flags;
                            }


       //从表单中把所有同名的下拉框取值拼接
                            function findNames(inputname) {
                                var inputvalues = document.getElementsByName(inputname);  //
                                var str = '';
                                for(var i=0;i<inputvalues.length;i++){
                                    if(inputvalues[i].value!=null){
                                        str=str+inputvalues[i].value;
                                    }else{
                                        str='';
                                    }
                                    if(i<inputvalues.length-1){
                                        str=str+",";
                                    }
                                }
                                return str;
                            }
</script>
<script language="javascript">


    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmppostAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/EmppostAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
     //   form.cmd.value = "queryClassList";
     //   form.submit();
       $id("datacell1").loadData();
       $id("datacell1").refresh();
       //add by dongying 20160705 情况说明     start
       jQuery('tr td[fieldid^="remark_"]').each(function(){
    	   //alert(jQuery(this).attr('fieldid'));
       	   jQuery(this).attr('title',jQuery(this).find('div').html());

       });
       //add by dongying 20160705 情况说明     end
   /*    魏佳
       if(cityID != cityID_flag){
          html = "<input type='checkbox'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("emp_service_id") + "\",\"" + cityID + "\");>";//city_idList
       }else{
          html = "<input type='checkbox'  name='temp' >";//city_idList
       }
       $id('celllist1').dataset = null;
       $id('celllist1').refresh();
        $id('celllist2').dataset = null;
        $id('celllist2').refresh();*/
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/emppost/insertEmppost.jsp";
        form.submit();
    }











    function showNewdiv(){
        selectAllRows();
        var ids = findSelections("radio_template","id");  //取得复选框的选择项
        if(ids == null) {  //如果ids为空
             return;
        }
        var obj=document.getElementById("zlTab");
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            var xlid=ids[i];
            var j=document.getElementById(xlid).rowIndex;
            obj.deleteRow(j);
        }
    }

        //客户名称查询条件
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
         document.form.cust_name.value=data[2];
    }

      function exportEmpSend(){
        form.cmd.value = "exportByE";
        form.submit();
    }


   //选择客户
function rtnFunc(obj){
      var lookup = $id("cust_id");
     lookup.value = obj[0];
    lookup.displayValue = obj[1];
      // $id("look_id").value=arg[2];
 //alert(obj[0]);
   //document.form.cust_id.value=obj[0];
//document.form.cust_name.value=obj[2];
}


        function rtnFuncCustomer(arg){
            var lookup = $id("cust_name");
            lookup.value = arg[2];
            lookup.displayValue = arg[2];
            return false;
        }

      //add by dongying 20160311 查询户籍户别
        function discover(){
        	var product_name = document.getElementsByName("temp");
            var number = 0;  //定义游标
            var ids = null;  //定义id值的数组
            var emp_post_id="";
            var emp_service_id="";
            var service_status_bd="";
            for(var i=0;i<product_name.length;i++){  //循环checkbox组
            	if(product_name[i].checked) {  //如果被选中
	            	var enCurEntity = $id("datacell1").dataset.get(i);
            		if(enCurEntity.getProperty("service_status_bd")=="1"){
            			emp_post_id += enCurEntity.getProperty("emp_post_id")+",";
		                emp_service_id+=enCurEntity.getProperty("emp_service_id")+",";
		                service_status_bd+=enCurEntity.getProperty("service_status_bd")+",";
            		}else{
		                alert("<fmt:message key="classification_state_not_classified"/>");
		                return;
            		}
                }
            }
          if(emp_post_id==null||emp_post_id==""){
              alert("<fmt:message key="select_records"/>");
              return;
          }else{
          	var flags=true;
            jQuery.ajax({
            url: '<%=request.getContextPath()%>/ErpUavAction.do?cmd=inquireHujiHubie&ids='+emp_post_id+"&date="+new Date()+"&emp_service_id="+emp_service_id+"&service_status_bd="+service_status_bd,
            type: 'GET',
            dataType: 'html',
            async: false,
            timeout: 80000,
            error: function(){
            	alert('Error loading XML document');
            	return  null;
            },
            success: function(text){
            	if(text!=null){
                		alert(text);
                        //simpleQuery_onClick();
                }

            }
            });
            return flags;
          }
        }
</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid"    action="<%=request.getContextPath()%>/EmppostAction.do">
<input type="hidden" name="cmd" value="queryClassList">
<input type="hidden" name="backFlag" value="true">
<input type="hidden" id="company_id" value="<%=company_id %>">
 <input type="hidden" id="cmd1"   name="cmd1" value="queryClassList">
 <input type="hidden" id="v_emp_service_id" name="v_emp_service_id" value=""/>
 <input type="hidden" id="v_big_name" name="v_big_name" value=""/>

    <input type="hidden"  id="action1"  name="action1" value="EmppostAction.do">
<div id="right">
<script language="javascript">
    writeTableTopFesco("员工属性管理" ,'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="130" rowspan="4" style="padding-top:0;" nowrap="nowrap"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="city"/></td>
             <td align="left" width="210">
                 <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       messagekey="please_choose"
                       value="${requestScope.city_id }"
                        />
             </td>
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
              <w:lookup onReturnFunc="rtnFuncCustomer" id="cust_name" name="cust_name"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="choose_customer" height="440" width="600"  style="width:170px"/>
                  </td>
             <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="50"/>            </td>
            <td rowspan="2" colspan="2">
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="25"/>          </td>

             <td align="right"><fmt:message key="contract_user_id"/></td>
            <td align="left">

              <r:comboSelect id="combo_cs" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_choose" />
            </td>
            <td align="right"><fmt:message key="dept_name"/></td>
            <td align="left">
                <r:comboSelect id="cs_name" name="cs_name" queryAction="/FAERP/FinbillAction.do?cmd=getCustDeptListData"
			         textField="name" valueField="id" xpath="AupartyVO" width="189px" nullText="--请选择--" />
			    </td>
            </td>
        </tr>
        <tr>
          <td align="right">是否部分提交</td>
          <td><d:select dictTypeId="IS_PART_SAVECALSS" style="width:120px" name="is_part_savecalss" id="is_part_savecalss" nullLabel="--请选择--"></d:select></td>
          <td rowspan="5">&nbsp;</td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button">
    <div class="button_right"><!--
        <ul>
            <li class="a_2">      <a  onClick="javascript:detail_onClick();">查看个人订单</a> </li>
            <li class="e">      <a  onclick="exportEmpSend()">导出</a> </li>
            <li class="e">      <a  onclick="save();">保存</a> </li>
            <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
            <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
        </ul>
    -->
    <input class="a_2" type="button"   value="<fmt:message key="look_person_order"/>"  <au:authorityBtn code="view_orderItem2" type="1"/>  onClick="detail_onClick();">
      <input class="e" type="button"   value="<fmt:message key="leading_out"/>"  <au:authorityBtn code="rzfl_exp" type="1"/>  onClick="exportEmpSend();">
      <input class="e" type="button"   value="<fmt:message key="save"/>"  <au:authorityBtn code="rzfl_save" type="1"/>  onClick="save();">
      <input class="a_3" type="button" style="width: 120px" value="<fmt:message key="discover_huji_hubie_attributes"/>" <au:authorityBtn code="rzfl_discover" type = "1"/> onclick="discover();">
    </div>
    <div class="clear"></div>
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell
        id="datacell1"
        queryAction="/FAERP/QuickemppostAction.do?cmd=simpleQueryClassByQuick&city_id=${city_id }"
        width="98%"
        height="190px"
        xpath="EmppostVo"
        submitXpath="EmppostVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp_post_id" label="入离职id" width="0px"></r:field>
       <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>
       <r:field fieldName="send_name" messagekey="send_name" width="100px">

       </r:field>
      <r:field fieldName="cust_name" width="140px" messagekey="cust_name">
      </r:field>
      <r:field fieldName="id_card" messagekey="id_card_num">
      </r:field>
       <r:field fieldName="user_name" messagekey="user_name">
      </r:field>
      <r:field fieldName="dept_name" messagekey="dept_name">
      </r:field>
      <r:field fieldName="emp_code" messagekey="emp_code">
      </r:field>
      <r:field fieldName="emp_name" messagekey="emp_name">
      </r:field>
      <r:field fieldName="resident_city" messagekey="resident_city">
      </r:field>
      <r:field fieldName="resident_type" messagekey="resident_type">
      </r:field>
      <r:field fieldName="is_new" label="确认转入类型" width="100px" allowModify="true">
            <d:select dictTypeId="is_new_status" disabled="false"/>
      </r:field>

      <r:field fieldName="affirm_is_new" label="转入类型" width="100px" allowModify="true">
            <d:select dictTypeId="is_new_status" disabled="true"/>
      </r:field>

      <r:field fieldName="remark" messagekey="remark">
      </r:field>
       <r:field fieldName="status" messagekey="status" width="80px"   align="center">
          <h:switchCheckbox id="status" value="0"  checkedValue="1" uncheckedValue="0"/>
       </r:field>
       <r:field fieldName="is_employ_notice" messagekey="is_employ_notice" width="80px"   align="center">
          <h:switchCheckbox id="is_employ_notice" value="0"  checkedValue="1" uncheckedValue="0"/>
       </r:field>
      <r:field fieldName="post_status_bd" messagekey="emp_status"  allowModify="false">
           <d:select dictTypeId="POST_STATUS_BD" />
      </r:field>
      <r:field fieldName="big_name" messagekey="big_name">
      </r:field>
      <r:field fieldName="service_status_bd" messagekey="sort_status"  allowModify="false">
          <d:select dictTypeId="SERVICE_STATUS_BD" />
      </r:field>
        <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date"  allowModify="false">
          <w:date format="yyyy-MM-dd" />
      </r:field>
           <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1"  allowModify="false">
         <w:date format="yyyy-MM-dd" />
      </r:field>
       <r:field fieldName="service_desc" messagekey="on_post_desc1">
       <h:text/>
      </r:field>
      <r:field fieldName="city_name" messagekey="city">
      </r:field>
      <r:field fieldName="is_part_savecalss" label="是否部分提交">
        <d:select dictTypeId="IS_PART_SAVECALSS" disabled="true"></d:select>
      </r:field>
    </r:datacell>
    </div>
<table    width="100%" >
<tr>
<td  valign="top" style="width:400px;">
  <div style="display:" id="div1">
<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
    <tr>
        <td valign="top" width="100%"> <br>
                <r:datacell
                        id="celllist1"
                        isCount="false"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/EmppostAction.do?cmd=searchClass"
                        width="100%" height="200px"
                        xpath="EmppostVo"
                        submitXpath="EmppostVo"
                        pageSize="-1"
                        >
                <r:field fieldName="emp1" messagekey="Operation" width="50px" onRefreshFunc="setCheckbox1" align="center">
                </r:field>
			      <r:field fieldName="big_name" messagekey="big_name1" width="140px">
			      </r:field>
			      <r:field fieldName="small_name" messagekey="small_name1"  width="240px">
			      </r:field>
			       </r:datacell>
        </td>
     </tr>
     </table>
     </div>
</td>
<td  valign="top" style="width:650px;">
					<div style="display:" id="div1">
					<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
					    <tr>
					        <td valign="top" width="100%"> <br>
					                <r:datacell
					                        id="celllist2"
					                        isCount="false"
					                        paramFormId="datacell_formid"
					                        queryAction="/FAERP/QuickemppostAction.do?cmd=findServiceById"
					                        width="100%" height="203px"
					                        xpath="EmppostVo"
					                        submitXpath="EmppostVo"
					                        pageSize="-1"
					                        >
								     <r:field allowModify="false"  fieldName="id_index" sortAt="none" messagekey="Operation" width="50px"  onRefreshFunc="setCheckbox2">
							        </r:field>
								     <r:field fieldName="service_name" messagekey="on_post_sevise" width="170px"></r:field>
								     <r:field fieldName="transact_type_name" label="办理类型"  allowModify="true" sortAt="none" width="150px">
							          <r:comboSelect id="com1"
						                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
						                    textField="type_name"
						                    valueField="id"
						                    xpath="SecuritygroupnewVo"
						                    nullText=''
						                    width="205px">
                					</r:comboSelect>
							         </r:field>
								     <r:field fieldName="account" label="账号" width="150px">

								     <h:text/>

								     </r:field>
								</r:datacell>
					        </td>
					     </tr>
					     </table>
					     </div>
</td>
</tr>
<tr>
<td colspan="3" align="center">
<br/>
<br/>
<br/>
<div align="center">
    办理类型：
    <d:select dictTypeId="SECURITY_HANDLE_TYPE"  name="security_handle_type" id="security_handle_type" nullLabel="--请选择--" ></d:select>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   </div>
   <br/>
   <br/>
    <div class="mx_button">
        <input type="button" class="icon_3" id="sub" value="<fmt:message key="submit_operation"/>" <au:authorityBtn code="rzfl_appr" type="1"/>" onClick="submit_onClick(0);" />
        <input type="button" class="icon_3" value="部分提交" <au:authorityBtn code="rzfl_appr" type="1"/>" onClick="submit_onClick(1);" />
   </div>
<br/>
<br/>
<br/>
<br/>
</td>
</tr>
</table>


</div>
</div>
</form>

</fmt:bundle>

</body>
</html>
<script language="javascript">

//只有公积金才需要添加账号
$id("celllist2").beforeEdit=function(cell,colIndex,rowIndex)
{
   //获得编辑行的entity
   var entity=this.getEntityByCell(cell)
   //如果编辑是0001返回false,取消编辑操作
    if(colIndex ==3 &&entity.getProperty("group_type_bd")!="2") return false;

}


 $id("celllist2").beforeRefresh = function(){
        $id("com1").refresh();
   }
 $id("celllist2").onClickCell=function(cell,colInde,rowIndex,entity,field,datacell) {
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        //colInde == 3 解决点击单元格com1显示id问题

        if (colInde == 2||colInde == 3){
            var combo1 = $id("com1");
            combo1.addParam("security_group_id",security_group_id);
            combo1.loadData();
            combo1.refresh();
        }
         return true;

}
$id("celllist2").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("transact_type_name") >= 0){
            activeEntity.setProperty("transact_type_id", newValue);
            var orgEditor = $id("com1") ;
            var transact_type_name  = orgEditor.getDisplayValue(newValue);
            activeEntity.setProperty("transact_type_name_str", transact_type_name);

            //判断选择的是否是城保，如果是城保，将办理类型进行联动
            if(activeEntity.getProperty("service_name") !=null&&activeEntity.getProperty("service_name")=='城保'){
               //判断城市是否是上海
               var v_big_name = $id("v_big_name").value ;
              // if(activeEntity.getProperty("city_id") !=null&&activeEntity.getProperty("city_id")=='1099110100000000050'){
              if(v_big_name!=null&&v_big_name.indexOf("上海")==0){
                 //判断是否上海新开还是转入
                 if(activeEntity.getProperty("transact_type_name_str")!=null&&activeEntity.getProperty("transact_type_name_str")=='新开'){
                    $id("security_handle_type").value = '1' ;
                 }else if(activeEntity.getProperty("transact_type_name_str")!=null&&activeEntity.getProperty("transact_type_name_str")=='转入'){
                    $id("security_handle_type").value = '2' ;
                 }
               }else{
                 //判断是否外地新开还是转入
                 if(activeEntity.getProperty("transact_type_name_str")!=null&&activeEntity.getProperty("transact_type_name_str")=='新开'){
                    $id("security_handle_type").value = '3' ;
                 }else if(activeEntity.getProperty("transact_type_name_str")!=null&&activeEntity.getProperty("transact_type_name_str")=='转入'){
                    $id("security_handle_type").value = '4' ;
                 }
               }
            }

       //     alert(newValue) ;
            //设置显示值


           // $id("celllist2").refreshRow(getRow(activeCell) ,activeEntity)  ;
        }
        return true;
   }

        //解决修改行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("emp") >= 0){
            return false;
        }
        return true;
    }
        //解决修改行数据，多选框勾选消失BUG
    $id("celllist2").beforeRefreshCell = function(cell,field){
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    }


//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>


