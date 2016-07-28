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
<title>codegen</title>
<%
String company_id=rayoo.common.filter.UserInfoFilter.geCompanyId();
String city_id = (String)request.getAttribute("city_id");
if(city_id==null || "".equals(city_id)){
    city_id = "1099110100000000050";
}
request.setAttribute("city_id",city_id);
%>
<script type="text/javascript">

function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'   name='temp'   onClick=ClickRow(\"" + entity.getProperty("emp_service_id") +"\",\"" + entity.getProperty("service_small_type_id") + "\",\"" + entity.getProperty("city_id") + "\");>";//city_idList
    }


 function ClickRow(value,value2,value1){
            $id('isClickQuery').value=true;
            $id("celllist1").queryParam= "<param><key>city_id</key><value>" + value1 +  "</value></param>";
            $id("celllist1").loadData();
            $id("celllist1").refresh();




            $id("celllist3").queryParam= "<param><key>emp_service_id</key><value>" + value +  "</value></param>";
            $id("celllist3").loadData();
            $id("celllist3").refresh();


            $id("celllist2").queryParam= "<param><key>smaID</key><value>" + value2 +  "</value></param>";
            $id("celllist2").loadData();
            $id("celllist2").refresh();

  }


     function setCheckboxStatus1(value,entity,rowNo,cellNo){
       return "<input type='checkbox'     name='status'    >";
    }






     function setCheckbox1(value,entity,rowNo,cellNo){
       var product_name = document.getElementsByName("temp");
       var service_small_type_id="";
          for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i);
                      service_small_type_id += enCurEntity.getProperty("service_small_type_id");

                }
       }
       if(entity.getProperty("smaID")==service_small_type_id){
         return "<input type='radio'  name='temp1'   checked='checked'      onClick=ClickRow1(\"" + entity.getProperty("emp_service_id") + "\",\"" + entity.getProperty("smaID") + "\");>";
       }else{
           return "<input type='radio'  name='temp1'   onClick=ClickRow1(\"" + entity.getProperty("emp_service_id") + "\",\"" + entity.getProperty("smaID") + "\");>";
       }



    }


       function ClickRow1(value,value1){
                $id('isClickQuery').value=true;
                $id("celllist2").queryParam= "<param><key>smaID</key><value>" + value1 +  "</value></param>";
               $id("celllist2").loadData();
                $id("celllist2").refresh();
    }
     function setCheckbox2(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template'  );>";
    }

   function setCheckbox3(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp3'   checked='checked'    );>";
    }







       function checkAll(field){
         var checkboxes = document.getElementsByName("checkbox_template1");
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

   function findSelectionno(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
              elementCheckbox[i].checked=false ;
            }
        }
    }



     function findSelections1(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
                if(ids == null) {
                    ids = new Array(0);
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }



       function save_onClick(){  //保存修改后的单条数据
                   var product_name = document.getElementsByName("temp");
			          var number = 0;  //定义游标
			         var ids = null;  //定义id值的数组
			          var emp_post_id="";
			          var emp_service_id="";
			          var service_desc="";
			          var status="";
			         for(var i=0;i<product_name.length;i++){  //循环checkbox组
			          if(product_name[i].checked) {  //如果被选中
			                     var enCurEntity = $id("datacell1").dataset.get(i);
			                      emp_post_id = enCurEntity.getProperty("emp_post_id");
			                      emp_service_id=enCurEntity.getProperty("emp_service_id");
			                      service_desc=enCurEntity.getProperty("service_desc");
			                      status=enCurEntity.getProperty("status");
			                 //      alert(emp_post_id);
			               //       alert(emp_service_id);
			               //       alert(service_desc);
			              //        alert(status);
			              }
			           }
			         //      alert(emp_post_id);
			        if(emp_post_id==null||emp_post_id==""){
			            alert("<fmt:message key="select_records"/>");
			            return;
			        }else{

			                    var flags=true;
			                                jQuery.ajax({
			                                url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=saveClassB&ids='+emp_post_id+"&date="+new Date()+"&emp_service_id="+emp_service_id+"&status="+status+"&service_desc="+encodeURIComponent(service_desc),
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
			                                      } else    if(text.length>1000){
                                                        alert("<fmt:message key="operation_errer"/>");
			                                       }else if(text=="2"){
			                                          alert("<fmt:message key="operation_errer"/>");
			                                       }
			                                    }
			                                }
			                                });return flags;
			        }
       }

   //保存分类和服务
  function submit_onClick(){  //保存修改后的单条数据

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
                                            var is_new ="";
                                            var resident_city ="";
                                            var resident_type ="";
                                            var remark ="";
                                            var affirm_is_new ="";
                                            var is_success = "";
                                            var cust_code ="";
                                            var agent_id ="";
                                            var social_unit_id = "";
                                           	var cust_name="";
                                         for(var i=0;i<product_name.length;i++){  //循环checkbox组
                                          if(product_name[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("datacell1").dataset.get(i);
                                                      emp_post_id += enCurEntity.getProperty("emp_post_id");
                                                      emp_service_id+=enCurEntity.getProperty("emp_service_id");
                                                      service_desc+=enCurEntity.getProperty("service_desc");
                                                      status+=enCurEntity.getProperty("status");
                                                      cust_id+=enCurEntity.getProperty("cust_id");
                                                      send_id+=enCurEntity.getProperty("send_id");
                                                      emp_id+=enCurEntity.getProperty("emp_id");
                                                      cust_receive_id+=enCurEntity.getProperty("cust_receive_id");
                                                      city_id +=enCurEntity.getProperty("city_id");
                                                      is_new +=enCurEntity.getProperty("is_new");
                                                      resident_city +=enCurEntity.getProperty("resident_city");
                                                      resident_type +=enCurEntity.getProperty("resident_type");
                                                      remark +=enCurEntity.getProperty("remark");
                                                      is_success +=enCurEntity.getProperty("is_success");
                                                      affirm_is_new +=enCurEntity.getProperty("affirm_is_new");
                                                      cust_code +=enCurEntity.getProperty("cust_code");
                                                      agent_id +=enCurEntity.getProperty("agent_id");
                                                      social_unit_id +=enCurEntity.getProperty("social_unit_id");
                                                      cust_name += enCurEntity.getProperty("cust_name");
                                             //         alert(emp_post_id);
                                             //         alert(emp_service_id);
                                              //        alert(service_desc);
                                              //        alert(status);
                                              }
                                           }


                              //  大类小类
                             var da="";
                              var temp1 = document.getElementsByName("temp1");
                                     for(var i=0;i<temp1.length;i++){  //循环checkbox组
                                          if(temp1[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist1").dataset.get(i);
                                                      da = enCurEntity.getProperty("smaID");
                                                //       alert("da="+da);
                                              }
                                           }

                              if(da==null||da==""){
                                    alert("<fmt:message key="choose_big_and_small_name"/>");
                                   return;
                              }


                              //  保留
                              var bl = document.getElementsByName("temp3");
                              //  服务
                             var fw = document.getElementsByName("checkbox_template");
                               var blid="";
                               var boo=true;
                               for(var i=0;i<bl.length;i++){  //循环checkbox组
                                           if(bl[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist3").dataset.get(i);
                                                      blid=enCurEntity.getProperty("service_id");
                                                      var fwid="";
                                                           for(var j=0;j<fw.length;j++){  //循环checkbox组
					                                           if(fw[j].checked) {  //如果被选中
					                                                     var enCurEntity1 = $id("celllist2").dataset.get(j);
					                                                      fwid = enCurEntity1.getProperty("service_id");
					                                                      if(blid==fwid){
					                                                          boo =false;
					                                                        break;
					                                                      }
					                                               }
					                                         }
					                           if(boo==false){
                                                  alert("<fmt:message key="save_servise_and_on_post_not_double"/>");
                                                 return;
                                               }
                                               }

                                   }

                                    var blids="";
                                    for(var i=0;i<bl.length;i++){  //循环checkbox组
                                           if(bl[i].checked) {  //如果被选中
                                                     var enCurEntity2 = $id("celllist3").dataset.get(i);
                                                      blids += enCurEntity2.getProperty("service_id")+",";
                                               }
                                   }

                                    //办理中的
                                    for(var i=0;i<bl.length;i++){  //循环checkbox组
                                         var enCurEntity2 = $id("celllist3").dataset.get(i);
                                         var service_status=enCurEntity2.getProperty("service_status");
                                         //alert(service_status);
                                         if(service_status=="2"){
                                             var blids1 = enCurEntity2.getProperty("service_id");
                                             if(blids.indexOf(blids1)==-1){
                                                  alert("<fmt:message key="notice2"/>");
                                                  return;
                                            }
                                         }
                                   }

                               var fwids="";
                               for(var i=0;i<fw.length;i++){  //循环checkbox组
                                           if(fw[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist2").dataset.get(i);
                                                      fwids += enCurEntity.getProperty("service_id")+",";
                                               }
                                   }

                          //      alert("fwids="+fwids);
                               if((null==fwids||fwids=="")&&(null==blids||blids=="")){
                                    alert("<fmt:message key="notice3"/>");
                                    return;
                               }




                               if(!getConfirm("<fmt:message key="notice4"/>")) {  //如果用户在确认对话框中点"取消"
                                    return false;
                                }
                                //使用ajax保存小类列表及其对应大类
                                   validateSaveFw(emp_post_id,cust_id,send_id,emp_id,emp_service_id,fwids,da,cust_receive_id,city_id,is_new,resident_city,resident_type,remark,is_success,affirm_is_new,cust_code,agent_id,social_unit_id,cust_name,blids,service_desc,status);
                            }



                            //ajax提交保存数据
                            function validateSaveFw(ids,cust_id,send_id,emp_id,emp_service_id,fwids,da,cust_receive_id,city_id,is_new,resident_city,resident_type,remark,is_success,affirm_is_new,cust_code,agent_id,social_unit_id,cust_name,blids,service_desc,status){
                                   var flags=true;
                                       jQuery.ajax({
                                url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=InsertBiangengFenglei&ids='+ids+"&date="+new Date()+'&da='+da+"&cust_id="+cust_id+"&send_id="+send_id+"&emp_id="+emp_id+"&is_new="+encodeURIComponent(is_new)+"&resident_city="+encodeURIComponent(resident_city)+"&resident_type="+encodeURIComponent(resident_type)+"&remark="+encodeURIComponent(remark)+"&is_success="+is_success+"&affirm_is_new="+encodeURIComponent(affirm_is_new)+"&cust_code="+cust_code+"&agent_id="+agent_id+"&social_unit_id="+social_unit_id+"&cust_name="+encodeURIComponent(cust_name)+"&emp_service_id="+emp_service_id+"&fwids="+fwids+"&cust_receive_id="+cust_receive_id+"&city_id="+city_id+"&blids="+blids+"&status="+status+"&service_desc="+encodeURIComponent(service_desc),
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
                                      //清空大小类和服务
                                      if(text.length>1000){
                                              alert("<fmt:message key="operation_errer"/>");
                                      }else{
                                         alert("<fmt:message key="operation_succuse"/>");
                                      }

                                        $id('celllist1').dataset = null;
                                       $id('celllist1').refresh();
                                         $id('celllist2').dataset = null;
                                       $id('celllist2').refresh();
                                         $id('celllist3').dataset = null;
                                       $id('celllist3').refresh();
                                      simpleQuery_onClick();



                                    }

                                }
                                });return flags;
                            }


       //只保存分类
 function submit_onClick1(){

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
                                            var is_new= "";
                                            var resident_city ="";
                                            var resident_type ="";
                                            var remark ="";
                                            var affirm_is_new ="";
                                            var is_success = "";
                                            var cust_code ="";
                                            var agent_id ="";
                                            var social_unit_id = "";
                                           	var cust_name="";
                                         for(var i=0;i<product_name.length;i++){  //循环checkbox组
                                          if(product_name[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("datacell1").dataset.get(i);
                                                      emp_post_id += enCurEntity.getProperty("emp_post_id");
                                                      emp_service_id+=enCurEntity.getProperty("emp_service_id");
                                                      service_desc+=enCurEntity.getProperty("service_desc");
                                                      status+=enCurEntity.getProperty("status");
                                                      cust_id+=enCurEntity.getProperty("cust_id");
                                                      send_id+=enCurEntity.getProperty("send_id");
                                                      emp_id+=enCurEntity.getProperty("emp_id");
                                                      cust_receive_id+=enCurEntity.getProperty("cust_receive_id");
                                                      city_id +=enCurEntity.getProperty("city_id");
                                                      is_new  +=enCurEntity.getProperty("is_new");
                                                      resident_city +=enCurEntity.getProperty("resident_city");
                                                      resident_type +=enCurEntity.getProperty("resident_type");
                                                      remark +=enCurEntity.getProperty("remark");
                                                      is_success +=enCurEntity.getProperty("is_success");
                                                      affirm_is_new +=enCurEntity.getProperty("affirm_is_new");
                                                      cust_code +=enCurEntity.getProperty("cust_code");
                                                      agent_id +=enCurEntity.getProperty("agent_id");
                                                      social_unit_id +=enCurEntity.getProperty("social_unit_id");
                                                      cust_name += enCurEntity.getProperty("cust_name");
                                               //       alert(emp_post_id);
                                                //      alert(emp_service_id);
                                                //      alert(service_desc);
                                                //      alert(status);
                                              }
                                           }


                              //  大类小类
                             var da="";
                              var temp1 = document.getElementsByName("temp1");
                                     for(var i=0;i<temp1.length;i++){  //循环checkbox组
                                          if(temp1[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist1").dataset.get(i);
                                                      da = enCurEntity.getProperty("smaID");
                                                  //    alert("da="+da);
                                              }
                                           }

                              if(da==null||da==""){
                                    alert("<fmt:message key="classification_can_not_empty"/>");
                                   return;
                              }



                              var bl = document.getElementsByName("temp3");
                               var blids="";
                               for(var i=0;i<bl.length;i++){  //循环checkbox组
                                       //    if(bl[i].checked) {  //如果被选中
                                                     var enCurEntity = $id("celllist3").dataset.get(i);
                                                      blids += enCurEntity.getProperty("service_id")+",";
                                       //        }
                                   }

                                  if(!getConfirm("<fmt:message key="notice5"/>")) {  //如果用户在确认对话框中点"取消"
                                    return false;
                                }
                               //  服务
                               var fwids = "";


                                //使用ajax保存小类列表及其对应大类
                                validateSaveFw1(emp_post_id,cust_id,send_id,emp_id,emp_service_id,fwids,da,cust_receive_id,city_id,is_new,resident_city,resident_type,remark,is_success,affirm_is_new,cust_code,agent_id,social_unit_id,cust_name,blids,service_desc,status);

                            }


                              //ajax提交保存数据
                            function validateSaveFw1(ids,cust_id,send_id,emp_id,emp_service_id,fwids,da,cust_receive_id,city_id,is_new,resident_city,resident_type,remark,is_success,affirm_is_new,cust_code,agent_id,social_unit_id,cust_name,blids,service_desc,status){
                                 var flags=true;
                                 jQuery.ajax({
                                url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=insertUpdate&ids='+ids+'&da='+da+"&date="+new Date()+"&cust_id="+cust_id+"&is_new="+encodeURIComponent(is_new)+"&resident_city="+encodeURIComponent(resident_city)+"&resident_type="+encodeURIComponent(resident_type)+"&remark="+encodeURIComponent(remark)+"&is_success="+is_success+"&affirm_is_new="+encodeURIComponent(affirm_is_new)+"&cust_code="+cust_code+"&agent_id="+agent_id+"&social_unit_id="+social_unit_id+"&cust_name="+encodeURIComponent(cust_name)+"&send_id="+send_id+"&emp_id="+emp_id+"&emp_service_id="+emp_service_id+"&fwids="+fwids+"&cust_receive_id="+cust_receive_id+"&city_id="+city_id+"&blids="+blids+"&status="+status+"&service_desc="+encodeURIComponent(service_desc),
                                type: 'GET',
                                dataType: 'html',
                                async: false,
                                timeout: 800000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){
                                      //清空大小类和服务
                                         if(text.length>1000){
                                                  alert("<fmt:message key="operation_errer"/>");
                                              }else{
			                                      alert("<fmt:message key="operation_succuse"/>");
			                                       $id('celllist1').dataset = null;
			                                       $id('celllist1').refresh();
			                                         $id('celllist2').dataset = null;
			                                       $id('celllist2').refresh();
			                                         $id('celllist3').dataset = null;
			                                       $id('celllist3').refresh();
			                                       simpleQuery_onClick();
			                                     }
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
          $id("datacell1").loadData();
          $id("datacell1").refresh();
          //add by dongying 20160701 情况说明     start
          jQuery('tr td[fieldid^="remark_"]').each(function(){
       	    //alert(jQuery(this).attr('fieldid'));
       	  	jQuery(this).attr('title',jQuery(this).find('div').html());

          });
          //add by dongying 20160701 情况说明     start

    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/emppost/insertEmppost.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
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
                if(emp_post_id!=null&&emp_post_id!=""){
                    window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
                }else{
                    alert("<fmt:message key="select_records"/>");
                    return;
                }



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

              function rtnFuncCustomer(arg){
            var lookup = $id("cust_name");
            lookup.value = arg[2];
            lookup.displayValue = arg[2];
            return false;
        }

</script>
</head>
<body>

<form name="form" method="post"   id="datacell_formid"    action="<%=request.getContextPath()%>/EmppostAction.do">
<input type="hidden" name="cmd" value="queryBiangengList">
<input type="hidden" name="backFlag" value="true">
 <input type="hidden" id="isClickQuery" value="false" />

<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key="change_classification"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">


<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

        <tr>
            <td width="55" rowspan="10" style="padding-top:0;"  nowrap="nowrap"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="city"/></td>
            <td align="left" width="210">
              <r:comboSelect id="city_id" name="city_id"
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



        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="25"/>          </td>

             <td align="right"><fmt:message key="post_status1"/></td>
            <td align="left">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("service_status_bd", -1,"SERVICE_STATUS_BD",""," id=service_status_bd",false) %>
            </td>
             <td align="right"></td>
            <td align="left"><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
        </tr>

</table>
</div>

<div id="ccParent1" class="button">
    <div class="button_right"><!--
        <ul>
            <li class="a_2">      <a  onClick="javascript:detail_onClick();">查看个人订单</a> </li>
           <li class="a">      <a  onClick="javascript:save_onClick();">保存</a> </li>
            <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
            <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
        </ul>
    -->
    <input type="button" class="a_2" value="<fmt:message key="look_person_order"/>" <au:authorityBtn code="view_orderItem5" type="1"/> onClick="detail_onClick();" />
    <input type="button" class="a" value="<fmt:message key="save"/>" <au:authorityBtn code="bgfl_save" type="1"/> onClick="save_onClick();" />
    </div>
    <div class="clear"></div>
</div>


 <div style="padding: 8 10 8 8;">
    <r:datacell
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=queryBiangengList"
        width="98%"
        height="190px"
        xpath="EmppostVo"
        submitXpath="EmppostVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp"  messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>
       <r:field fieldName="is_phoenix" label="入职E化">
       	<select name="is_phoenix">
                  <option value="1">是</option>
                  <option value="0">否</option>
              </select>
       </r:field>
      <r:field fieldName="cust_name" width="140px" messagekey="cust_name">
      </r:field>
      <r:field fieldName="id_card" messagekey="id_card_num">
      </r:field>
       <r:field fieldName="user_name" messagekey="user_name">
      </r:field>


      <r:field fieldName="emp_code" messagekey="emp_code">
      </r:field>

      <r:field fieldName="emp_name" messagekey="emp_name">
      </r:field>


       <r:field fieldName="status" messagekey="status" width="80px"   align="center">
          <h:switchCheckbox id="status" value="0"  checkedValue="1" uncheckedValue="0"/>
       </r:field>


      <r:field fieldName="post_status_bd" messagekey="status_name"  allowModify="false">
           <d:select dictTypeId="POST_STATUS_BD" />
      </r:field>



      <r:field fieldName="big_name" messagekey="big_name">
      </r:field>
     <r:field fieldName="small_name" messagekey="small_name">
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

      <r:field fieldName="resident_city" messagekey="resident_city">
      </r:field>

      <r:field fieldName="resident_type" messagekey="resident_type">
      </r:field>

      <r:field fieldName="remark" messagekey="remark">
      </r:field>
      <r:field fieldName="is_success" label="is_success" width="0px;" sortAt="none"></r:field>
      <r:field fieldName="cust_code" label="cust_code" width="0px;" sortAt="none"></r:field>
      <r:field fieldName="agent_id" label="agent_id" width="0px;" sortAt="none"></r:field>
       <r:field fieldName="social_unit_id" label="social_unit_id" width="0px;" sortAt="none"></r:field>
      <r:field fieldName="is_new" label="确认转入类型" width="100px" allowModify="true">
      	<d:select dictTypeId="is_new_status" disabled="true"/>
      </r:field>

      <r:field fieldName="affirm_is_new" label="转入类型" width="100px" allowModify="true">
		<d:select dictTypeId="is_new_status" disabled="true"/>
      </r:field>
    </r:datacell>
    </div>









<table    width="100%" >
<tr>
<td  valign="top">

<div style="display:" id="div1">
<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
    <tr>
        <td valign="top" width="100%"> <br>
                <r:datacell
                        id="celllist1"
                        isCount="false"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/EmppostAction.do?cmd=searchClass"
                        width="97%" height="200px"
                        xpath="EmppostVo"
                        submitXpath="EmppostVo"
                        pageSize="-1"
                        >
                <r:field fieldName="emp1" messagekey="Operation" width="50px" onRefreshFunc="setCheckbox1" align="center">
                </r:field>

                  <r:field fieldName="big_name" messagekey="big_name1">
                  </r:field>
                  <r:field fieldName="small_name" messagekey="small_name1">
                  </r:field>
                   </r:datacell>
        </td>
     </tr>
     </table>
     </div>
</td>

<td  valign="top">

    <div style="display:" id="div1">
                    <table cellpadding="0" style="padding: 8 10 8 8;" border="0">
                        <tr>
                            <td valign="top" width="100%"> <br>
                                    <r:datacell
                                            id="celllist2"
                                            isCount="false"
                                            paramFormId="datacell_formid"
                                            queryAction="/FAERP/EmppostAction.do?cmd=findServiceById"
                                            width="97%" height="200px"
                                            xpath="EmppostVo"
                                            submitXpath="EmppostVo"
                                            pageSize="-1"
                                            >

         <r:field allowModify="false"  fieldName="id_index" sortAt="none" label="" width="30px"  onRefreshFunc="setCheckbox2">

        </r:field>
        <!--
        <input type='checkbox' name='checkbox_template1' value='' onclick='checkAll(this);' />

         -->

                                     <r:field fieldName="service_name" messagekey="on_post_sevise" sortAt="none">
                                      </r:field>
                                      </r:datacell>
                            </td>
                         </tr>
                         </table>
                         </div>

</td>

<td   valign="top">

					    <div style="display:" id="div1">
								<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
								    <tr>
								        <td valign="top" width="100%"> <br>
								                <r:datacell
								                        id="celllist3"
								                        isCount="false"
								                        paramFormId="datacell_formid"
								                        queryAction="/FAERP/EmppostAction.do?cmd=findServiceByEmpServiceId"
								                        width="97%" height="200px"
								                        xpath="EmppostVo"
								                        submitXpath="EmppostVo"
								                        pageSize="-1"
								                        >


								                  <r:field fieldName="service_name" messagekey="service_name">
								                  </r:field>
								                  <r:field fieldName="service_status" messagekey="service_status" allowModify="false">
								                  <d:select dictTypeId="SERVICE_STATUS" />
								                  </r:field>
								                <r:field fieldName="emp1" messagekey="emp1" width="50px" onRefreshFunc="setCheckbox3" align="center"   >
                                                </r:field>
								                   </r:datacell>
								        </td>
								     </tr>
								     </table>
					     </div>

</td>





</tr>
<tr>
<td colspan="4" align="center">

    <div class="mx_button">
        <input type="button" name="button1" class="icon_3" value="<fmt:message key="only_save_classification"/>" <au:authorityBtn code="bgfl_sfl" type="1"/> onClick="submit_onClick1();"  />

        <input type="button"  name="button2" class="icon_3" value="<fmt:message key="save_classification_and_service"/>" <au:authorityBtn code="bgfl_sflfw" type="1"/> onClick="submit_onClick();"   width="200"/>
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


  $id("celllist1").beforeLoadData = function(){
        if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
           return false;
        }
        return true;
    }

       $id("celllist2").beforeLoadData = function(){
        if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
           return false;
        }
        return true;
    }

        $id("celllist3").beforeLoadData = function(){
        if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
           return false;
        }
        return true;
    }


    //初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});


</script>

