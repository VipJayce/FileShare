<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>

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
       if(cityID != cityID_flag){
          html = "<input type='checkbox'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("emp_service_id") + "\",\"" + cityID + "\",\"" + entity.getProperty("emp_post_id")  + "\");>";//city_idList
       }else{
          //提交完后再操作则只刷新材料
          html = "<input type='checkbox'  name='temp'   onClick=ClickRow3(\"" + entity.getProperty("emp_service_id") + "\",\"" + cityID + "\",\"" + entity.getProperty("emp_post_id")  + "\");>";//city_idList
       }
       return html;
    }
 //刷新材料
 function ClickRow3(value,value1,value2){
       $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_post_id="+value2;
       $id("datacell2").loadData();
       $id("datacell2").refresh();
  }
    
 function ClickRow(value,value1,value2){
       cityID_flag = value1;
       $id("celllist1").queryParam= "<param><key>city_id</key><value>" + value1 +  "</value></param>"; 
       $id("celllist1").loadData();
       $id("celllist1").refresh();
       $id("datacell2").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll&type=2&emp_post_id="+value2;
       $id("datacell2").loadData();
       $id("datacell2").refresh();
  }
    
    
     function setCheckboxStatus1(value,entity,rowNo,cellNo){
       return "<input type='checkbox'     name='status'    >";
    }

    

    
    
    
     function setCheckbox1(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp1'   onClick=ClickRow1(\"" + entity.getProperty("emp_service_id") + "\",\"" + entity.getProperty("smaID") + "\");>";//city_idList
    }
    
    
       function ClickRow1(value,value1){
                $id("celllist2").queryParam= "<param><key>smaID</key><value>" + value1 +  "</value></param>"; 
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
          var  unit_id="";//用退工办理方id
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                      emp_post_id += enCurEntity.getProperty("emp_post_id")+","; 
                      emp_service_id+=enCurEntity.getProperty("emp_service_id")+","; 
                      service_desc+=enCurEntity.getProperty("service_desc")+","; 
                      status+=enCurEntity.getProperty("status")+","; 
                      is_employ_notice+=enCurEntity.getProperty("is_employ_notice")+","; 
                      if(enCurEntity.getProperty("hire_security_unit_id")==""){
                            alert("请选择用退工办理方!");
                            return false;
                      }else{
                            unit_id+=enCurEntity.getProperty("hire_security_unit_id")+","; 
                      }
              }
           }
        if(emp_post_id==null||emp_post_id==""){
            alert("<fmt:message key="select_records"/>");
            return;
        }else{
                    var flags=true;
                                jQuery.ajax({
                                url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=saveClass1&ids='+emp_post_id+"&date="+new Date()+"&emp_service_id="+emp_service_id+"&status="+status+"&is_employ_notice="+is_employ_notice+"&service_desc="+encodeURIComponent(service_desc)+"&unit_id="+unit_id,
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
                            function submit_onClick(type){  //保存修改后的单条数据
							   jQuery("#flsq").attr({"disabled":"disabled"});
							   jQuery("#flbt").attr({"disabled":"disabled"});
                            
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
                                            var apply_on_post_date="";
											var affirm_is_new="";
                                            var city_id="";
								           var  unit_id="";//用退工办理方id
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
								                       var city_idNew=enCurEntity.getProperty("city_id")   ;
								                       affirm_is_new =enCurEntity.getProperty("is_new");
								                       apply_on_post_date=enCurEntity.getProperty("apply_on_post_date")   ;
								                        if(enCurEntity.getProperty("hire_security_unit_id")==""){
                                                                  alert("请选择用退工办理方!");
                                                                  return false;
                                                          }else{
                                                           unit_id+=enCurEntity.getProperty("hire_security_unit_id")+","; 
                                                         }
								                       if(n!=0){
								                               if(city_id!=city_idNew){
								                                         alert("<fmt:message key="selecte_emp_by_city"/>");
								                                              return ;
								                               }
								                       }
								                     
								                   city_id=city_idNew;
								                   n++;
								              }
								           }
								           if(n!=1){
								           	alert("只能选择一条记录！");
								           	return;
								           }
                            
                            if(emp_post_id==null||emp_post_id==""){
                               alert("<fmt:message key="selecte_emp"/>");
                                   return;
                            }
                            
                            //新增确认转入类型效验 add by liuyu
							if(type=='1' && (affirm_is_new==null || affirm_is_new=="") ){
								  alert("请选择确认转入类型！");
								  return false;
							  }
                            
                            
                            
                           //  大类小类 
                             var big_name="";
                             var big_id = "";
                              var temp1 = document.getElementsByName("temp1");
                                     for(var i=0;i<temp1.length;i++){  //循环checkbox组
                                          if(temp1[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist1").dataset.get(i); 
                                                      big_name = enCurEntity.getProperty("big_name");
                                                      big_id = enCurEntity.getProperty("big_id");
                                              }
                                           }
                              
                              if(big_name==null||big_name==""){
	                                alert("<fmt:message key="classification_can_not_empty"/>");
	                               return;
                              }
                              
                              
                                     //  服务不可以为空（20130123陈小佩修改）
                             var fwids="";
                              var checkbox_template = document.getElementsByName("checkbox_template");
                                     for(var i=0;i<checkbox_template.length;i++){  //循环checkbox组
                                          if(checkbox_template[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist2").dataset.get(i); 
                                                      fwids += enCurEntity.getProperty("service_id")+","; 
                                                  //     alert("fwids="+fwids);
                                              }
                                           }
                           validateSaveFw(emp_post_id,cust_id,send_id,emp_id,emp_service_id,fwids,big_name,big_id,cust_receive_id,status,service_desc,unit_id,apply_on_post_date,type,affirm_is_new);
                              
                              /**if(fwids==null||fwids==""){
                                    if(confirm("<fmt:message key="is_sure_commit"/>")){
                                        
		                                //使用ajax保存小类列表及其对应大类
		                                validateSaveFw(emp_post_id,cust_id,send_id,emp_id,emp_service_id,fwids,big_name,big_id,cust_receive_id,status,service_desc,unit_id,apply_on_post_date);
                                    }else{
                                    
                                        return;
                                    }
                              }else{
                              
                                        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
                                            return false;
                                        }
                                        
                                          
                                   
                                        //使用ajax保存小类列表及其对应大类
                                        validateSaveFw(emp_post_id,cust_id,send_id,emp_id,emp_service_id,fwids,big_name,big_id,cust_receive_id,status,service_desc,unit_id,apply_on_post_date);
                                    
                              }*/
                              
                            
                             
                                
                            }
                            
               
                            //ajax提交保存数据
                            function validateSaveFw(ids,cust_id,send_id,emp_id,emp_service_id,fwids,da,big_id,cust_receive_id,status,service_desc,unit_id,apply_on_post_date,type,affirm_is_new){
                                 var flags=true;
                                 jQuery.ajax({
                                url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=saveClass&ids='+ids+'&da='+encodeURIComponent(da)+"&date="+new Date()+"&cust_id="+cust_id+"&send_id="+send_id+"&emp_id="+emp_id+"&emp_service_id="+emp_service_id+"&fwids="+fwids+"&cust_receive_id="+cust_receive_id+"&status="+status+"&service_desc="+encodeURIComponent(service_desc)+"&unit_id="+unit_id+"&big_id="+big_id+"&apply_on_post_date="+apply_on_post_date+"&type="+type+"&affirm_is_new="+affirm_is_new,
                                type: 'GET',
                                dataType: 'html',
                                //timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                      //清空大小类和服务
                                       alert(text);
                                       jQuery("#flsq").removeAttr("disabled");//将按钮可用
                                   	jQuery("#flbt").removeAttr("disabled");//将按钮可用
                                        $id("datacell1").loadData();
                                        $id("datacell1").refresh();
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

       //add by dongying 20160701 情况说明     start
       jQuery('tr td[fieldid^="remark_"]').each(function(){
    	   //alert(jQuery(this).attr('fieldid'));
       	   jQuery(this).attr('title',jQuery(this).find('div').html());

       });
       //add by dongying 20160701 情况说明     end

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
        form.cmd.value = "export";
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
        
   function toShenbao(){
        var company_id = jQuery("#company_id").val();
        if(company_id !=null && company_id=='1099100700000000005'){
            var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listApplyEmpsecurity.jsp?group_type=1&security_type=1&flag=1";
         }else{//杭州分公司页面
            var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity_zj/listApplyEmpsecurity.jsp?group_type=1&security_type=1&flag=1";
         }
         url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        //showModalCenter(url, window, null, 900, 500, "社保申请");
        window.open(url,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
    
    }
   function toGongjin(){
        var company_id = jQuery("#company_id").val();
        if(company_id !=null && company_id=='1099100700000000005'){
            var url1="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listApplyHousingEmpsecurity.jsp?flag=1"; 
        }else{
            var url1="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity_zj/listApplyHousingEmpsecurity.jsp?flag=1"; 
        }
        url1=url1+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        //showModalCenter(url1, window, null, 900, 500, "公积金申请");
        window.open(url1,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
    }
    
    function toZongbao(){
        var url1="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listApplyEmpsecurity.jsp?group_type=1&security_type=3&flag=1";
        url1=url1+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        //showModalCenter(url1, window, null, 900, 500, "综保申请");
        window.open(url1,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
    }
    
    //add by dongying 20160316 户籍户别查询
    function discover(){  //保存修改后的单条数据
    	var product_name = document.getElementsByName("temp");
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        var emp_post_id="";
        var emp_service_id="";
        var service_desc="";
        var service_status_bd="";
        for(var i=0;i<product_name.length;i++){  //循环checkbox组
        	if(product_name[i].checked) {  //如果被选中
            	var enCurEntity = $id("datacell1").dataset.get(i);
            	if(enCurEntity.getProperty("service_status_bd")=="1"){
                emp_post_id += enCurEntity.getProperty("emp_post_id")+",";
                emp_service_id+=enCurEntity.getProperty("emp_service_id")+",";
                service_desc+=enCurEntity.getProperty("service_desc")+",";
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
    <input type="hidden"  id="action1"  name="action1" value="EmppostAction.do">
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key="on_post_classification"/>" ,'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="55" rowspan="10" style="padding-top:0;" nowrap="nowrap"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
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
      <input class="a_3" type="button" style="width: 120px" value="<fmt:message key="discover_huji_hubie_attributes"/>" <au:authorityBtn code="rzfl_discover" type = "1"/> onclick="discover()">
    </div>
    <div class="clear"></div>           
</div>
 
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=queryClassList&city_id=${city_id }"
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
      <r:field fieldName="post_status_bd" messagekey="emp_status"  allowModify="false">
           <d:select dictTypeId="POST_STATUS_BD" />
      </r:field>
      <r:field fieldName="big_name" messagekey="big_name">
      </r:field>
      <r:field fieldName="class_note" label="分类记录">
      </r:field>
        <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date"  allowModify="false">
          <w:date format="yyyy-MM-dd" />
      </r:field>
           <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1"  allowModify="false">
         <w:date format="yyyy-MM-dd" />
      </r:field>
       <r:field fieldName="hire_security_unit_id" label="用退工办理方">
       <select name="unit_id">
       		<option value="" selected="selected">请选择</option>
       		<option value="2013300100000000015">外地大库</option>
       		<option value="1099141600000000111">单立户</option>
       		<option value="1099141600000000108">上海公司大库</option>
       		<option value="1099141600000000107">诺华贸易单立户</option>
       		<option value="1099141600000000105">财务外包公司大库</option>
       </select>

      </r:field>
       <r:field fieldName="service_desc" messagekey="on_post_desc1">
       <h:text/>
      </r:field>
      <r:field fieldName="city_name" messagekey="city">
      </r:field>
    </r:datacell>
    </div>
<table    width="100%" >
<tr>
<td  valign="top" style="width:500px;">
  <div style="display:" id="div1">
<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
    <tr>
        <td valign="top" width="100%"> <br>
                <r:datacell 
                        id="celllist1"
                        isCount="false"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/EmppostAction.do?cmd=searchClass&fromType=autoClass"
                        width="100%" height="200px"
                        xpath="EmppostVo"
                        submitXpath="EmppostVo"
                        pageSize="-1"  >
                <r:field fieldName="emp1" messagekey="Operation" width="50px" onRefreshFunc="setCheckbox1" align="center">
                </r:field>   
			      <r:field fieldName="big_name" messagekey="big_name1" width="380px">
			      </r:field>
			      <!--<r:field fieldName="small_name" messagekey="small_name1"  width="240px">
			      </r:field> -->
			     	<r:field fieldName="big_id" label="大分类ID" width="0px;" sortAt="none"></r:field>
			       </r:datacell>
        </td>
     </tr>
     </table>
     </div>
</td>
<!-- <td  valign="top" style="width:350px;">
					<div style="display:" id="div1">
					<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
					    <tr>
					        <td valign="top" width="100%"> <br>
					                <r:datacell 
					                        id="celllist2"
					                        isCount="false"
					                        paramFormId="datacell_formid"
					                        queryAction="/FAERP/EmppostAction.do?cmd=findServiceById"
					                        width="100%" height="203px"
					                        xpath="EmppostVo"
					                        submitXpath="EmppostVo"
					                        pageSize="-1"
					                        >
	     <r:field allowModify="false"  fieldName="id_index" sortAt="none" messagekey="Operation" width="50px"  onRefreshFunc="setCheckbox2">
	     <!-- 
	     <input type='checkbox' name='checkbox_template' value='' onclick='checkAll(this);' />
	     
	      -->
       <!-- </r:field>     
					                      
								     <r:field fieldName="service_name" messagekey="on_post_sevise" sortAt="none">
					                  </r:field>        
									  </r:datacell>
					        </td>
					     </tr>
					     </table>
					     </div>
</td> -->
<td  valign="top" style="width:400px;">
           <div style="display:" id="div1">
              <table cellpadding="0" style="padding: 8 10 8 8;" border="0">
                  <tr>
                      <td valign="top" width="100%"> <br>
                              <r:datacell id="datacell2" queryAction="/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAll" 
                   pageSize="100"
                   width="350px" height="200px" xpath="EmpMaterialVo" >
                   <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                       <r:field fieldName="material_id" label="操作" width="0px"  align="center" ></r:field>
                       <r:field fieldName="material_name" label="材料名称" width="110px"  allowModify="false"><h:text ></h:text> </r:field>    
                       <r:field fieldName="remark" label="备注" width="150px"  allowModify="false" ><h:text></h:text> </r:field>    
                       <r:field fieldName="is_receive" label="是否收到" width="80px"  allowModify="false">
                          <select onchange="selectIsReceive(this.value)">
                              <option value="0">否</option>
                              <option value="1">是</option>
                          </select>
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
    <div class="mx_button">
        <input type="button" id="flsq" class="a_2" value="分类且福利申请" <au:authorityBtn code="rzfl_appr" type="1"/> onClick="submit_onClick(1);" />
        <input type="button" id="flbt" class="a_2" value="分类且福利不停" <au:authorityBtn code="rzfl_appr1" type="1"/> onClick="submit_onClick(2);" />
        <!--  <input type="button" class="icon_3" value="<fmt:message key="ss_application"/>" <au:authorityBtn code="rzfl_sbsq" type="1"/> onClick="toShenbao();" />
         <input type="button" class="icon_3" value="<fmt:message key="fund_application"/>" <au:authorityBtn code="rzfl_gjjsq" type="1"/> onClick="toGongjin();" />
         <%if(company_id!=null && company_id.equals("1099100700000000005")){ %>
        <input type="button" class="icon_3" value="<fmt:message key="cs_application"/>" <au:authorityBtn code="rzfl_gjjsq" type="1"/> onClick="toZongbao();" />
        <%} %>-->
        </div>

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

    //解决修改行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("emp") >= 0){
            return false;
        }
        return true;
    } 
    
    
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
    $id("datacell2").isQueryFirst = false;
});
    
</script>


