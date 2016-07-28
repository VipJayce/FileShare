<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%
String security_group_id=request.getAttribute("security_group_id").toString();

%>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<form name="form" id="form1" method="post">
<div style="margin-top:15px;">
<!-- 子表一开始 -->
                 <div id="values_div" class="box" style="width:40%; float:left;" style="margin-left:0px;"> 
                                <div class="button" style="margin:0 0 0 0 px;"> 
                                      <div class="button_right">
                                            <ul>
                                                <li class="c">      <a onClick="javascript:toAddTbale1_onClick();"><fmt:message key="insert"/> </a></li>
                                                <li class="d">      <a onClick="javascript:toDeleteTbale1_onClick();"><fmt:message key="delete"/> </a> </li>
                                                <li class="bc">    <a onClick="javascript:toSaveTbale1_onClick();"><fmt:message key="save"/> </a> </li>
                                            </ul>
                                         </div>
                                     <div class="box_title" style="margin-top:5px;">下属产品比例</div>
                                     <div class="clear"></div>            
                                </div>
                      <table  width="100%" cellspacing="0"  class="datagrid1" id="table1">
                <tr>
                <th  class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
                <th>社保公积金产品</th>
                <th>是否每月支付</th>
                <th>是否可补收</th>
                <th>比例排序</th>
                </tr>
                <logic:iterate     name="relbeans"  id="data_rel" scope="request" indexId="indexs">
                        <tr  id="<bean:write name="data_rel" property="id"/>">
                        <td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data_rel" property="id"/>"/></td>
                            <input type="hidden" name="table1id" value="<bean:write name="data_rel" property="id"/>">
                            <input type="hidden" name="security_group_id1" value="<bean:write name="data_rel" property="security_group_id"/>">
                            <td>
                            <faerp:securityProductSelectTag beanname="data_rel" securityproductid="security_group_id" attribute="security_product_id"  tagname="security_product_id1"  style=" width:100px;"/> 
                            </td>
                            <td>
                            <bean:define id="month_pay_bd" name="data_rel" property="month_pay_bd"/>
                            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("month_pay_bd1", -1, "TrueOrFalse", String.valueOf(month_pay_bd), " style='width:80px;' inputName='是否每月支付'", false) %>
                            </td>
                            <td>
                            <bean:define id="is_supply" name="data_rel" property="is_supply"/>
                            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_supply1", -1, "TrueOrFalse", String.valueOf(is_supply), " style='width:80px;' inputName='是否可补收'", false) %>
                            </td>   
                            <td><input type="text" class='text_field' style='width:80px;' name="serial_no1" value="<bean:write name="data_rel" property="serial_no"/>"></td>
                            </tr>
                </logic:iterate>
                </table>
                </div>
<!-- 子表一结束 -->
<!-- 子表二开始 -->
                <div id="values_div1" class="box" style="width:28%; float:left;" style="margin-left:0px;"> 
                                        <div class="button" style="margin:0 0 0 0 px;"> 
                                              <div class="button_right">
                                                    <ul>
                                                        <li class="c">      <a onClick="javascript:toAddTbale2_onClick();"><fmt:message key="insert"/> </a></li>
                                                        <li class="d">      <a onClick="javascript:toDeleteTbale2_onClick();"><fmt:message key="delete"/> </a> </li>
                                                        <li class="bc">    <a onClick="javascript:toSaveTbale2_onClick();"><fmt:message key="save"/> </a> </li>
                                                    </ul>
                                                 </div>
                                             <div class="box_title" style="margin-top:5px;">新开类别</div>
                                             <div class="clear"></div>            
                                        </div>
                      <table  width="100%" cellspacing="0"  class="datagrid1" id="table2">
                <tr>
                <th  class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
                <th>类型编码</th>
                <th>类型名称</th>
                <th>是否是一次性补缴</th>
                </tr>
                <logic:iterate     name="newbeans"  id="data_new" scope="request" indexId="indexs">
                        <tr id="<bean:write name="data_new" property="id"/>">
                        <td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data_new" property="id"/>" displayName="<bean:write name="data_new" property="id"/>"/></td>
                        <input type="hidden" name="table2id" value="<bean:write name="data_new" property="id"/>">
                        <input type="hidden" name="security_group_id2" value="<bean:write name="data_new" property="security_group_id"/>">
                        <td><input type="text" class='text_field' style='width:100px;' name="type_code2" value="<bean:write name="data_new" property="type_code"/>"></td>
                        <td><input type="text" class='text_field' style='width:100px;' name="type_name2" value="<bean:write name="data_new" property="type_name"/>"></td>
                        <td><bean:define id="is_oneoff2" name="data_new" property="is_oneoff"/>
                                    <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_oneoff2", -1, "TrueOrFalse", String.valueOf(is_oneoff2), " style='width:80px;' inputName='是否是一次性补缴'", false) %>
                        </td>
                          </tr>
                </logic:iterate>
                </table>
                </div>
<!-- 子表二结束 -->
<!-- 子表三开始 -->
                <div id="values_div2" class="box" style="width:26%; float:left;" style="margin-left:0px;"> 
                                        <div class="button" style="margin:0 0 0 0 px;"> 
                                              <div class="button_right">
                                                    <ul>
                                                        <li class="c">      <a onClick="javascript:toAddTbale3_onClick();"><fmt:message key="insert"/> </a></li>
                                                        <li class="d">      <a onClick="javascript:toDeleteTbale3_onClick();"><fmt:message key="delete"/> </a> </li>
                                                        <li class="bc">    <a onClick="javascript:toSaveTbale3_onClick();"><fmt:message key="save"/> </a> </li>
                                                    </ul>
                                                 </div>
                                             <div class="box_title" style="margin-top:5px;">停办类别</div>
                                             <div class="clear"></div>            
                                        </div>
                      <table  width="100%" cellspacing="0"  class="datagrid1" id="table3">
                <tr>
                <th  class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
                <th>类型编码</th>
                <th>类型名称</th>
                </tr>
                <logic:iterate     name="stopbeans"  id="data_stop" scope="request" indexId="indexs">
                        <tr id="<bean:write name="data_stop" property="id"/>">
                        <td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data_stop" property="id"/>" displayName="<bean:write name="data_stop" property="id"/>"/></td>
                         <input type="hidden" name="table3id" value="<bean:write name="data_stop" property="id"/>">
                        <input type="hidden" name="security_group_id3" value="<bean:write name="data_stop" property="security_group_id"/>">
                        <td><input type="text" class='text_field' style='width:100px;' name="type_code3" value="<bean:write name="data_stop" property="type_code"/>"></td>
                        <td><input type="text" class='text_field' style='width:100px;' name="type_name3" value="<bean:write name="data_stop" property="type_name"/>"></td>
                        </tr>
                </logic:iterate>
                </table>
                </div>
<!-- 子表三结束 -->
</div>
</form>

<%

String month_pay_bd=gap.rm.tools.helper.RmJspHelper.getSelectField("month_pay_bd1", -1, "TrueOrFalse", "1", " style='width:80px;' inputName='是否每月支付'", false);
String  is_supply=gap.rm.tools.helper.RmJspHelper.getSelectField("is_supply1", -1, "TrueOrFalse", "1", " style='width:80px;' inputName='是否可补收'", false);

String is_oneoff2=gap.rm.tools.helper.RmJspHelper.getSelectField("is_oneoff2", -1, "TrueOrFalse", "1", " style='width:80px;' inputName='是否是一次性补缴'", false);
%>
<script language="javascript">
//子表一开始
////////////////////////////////////////////////////////////////////table1从单选框中标记添加一条记录
     var table1Index=0;
     //新增大类行
     function toAddTbale1_onClick(){
         var obj=document.getElementById("table1");
         table1Index++;
         //添加行
         var rownum = obj.rows.length;
         var tr0=obj.insertRow(rownum);
         tr0.setAttribute("id","rel"+table1Index);
         var td0 = tr0.insertCell(0);
         //td0.setAttribute("style","padding: 0px 0px;");
         td0.innerHTML="  <input type='hidden' name='table1id'/><input type='checkbox' name='checkbox_template' value='rel"+table1Index+"'/>";
         //添加单元格
         var td1 = tr0.insertCell(1);
         td1.innerHTML="<input type='hidden' name='security_group_id1' value=''/> <select id=\"security_product_id1"+table1Index+"\" name=\"security_product_id1\" style=\" width:100px;\"> ";
         //根据社保组ID得到相关产品
         SecurityGroupAjax.getProductBySecurityGroupID('<%=security_group_id%>',{callback:function(data){
                 setSelectForBean("security_product_id1"+table1Index,data,"id","product_name","");
             }
         });
           
         //添加单元格
         var td2 = tr0.insertCell(2);
         td2.innerHTML="<%=month_pay_bd%>";
         //添加单元格
         var td3 = tr0.insertCell(3);
         td3.innerHTML="<%=is_supply%>";
          //添加单元格
         var td4 = tr0.insertCell(4);
         td4.innerHTML="<input type='text' class='text_field' name='serial_no1' inputName='说明' maxLength='20' style='width:80px;' value=''/>";
     }
////////////////////////////////////////////////////////////////////table1从单选框中标记删除一条记录
      function toDeleteTbale1_onClick(){  
          var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
          if(ids == null) {  //如果ids为空
              alert('请至少选择一条记录');
              return;
          }
          if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
              //删除页面记录
              var ids_str='';
              var obj=document.getElementById("table1");
              for(var i=0;i<ids.length;i++){  //循环checkbox组
                  var table1id=ids[i];
                  var j=document.getElementById(table1id).rowIndex;
                  obj.deleteRow(j);
                  if(i<=ids.length&&table1id.indexOf("rel")==-1){
                      ids_str=ids_str+ids[i]+",";
                  }
              }
              if(ids_str!=""){
              //数据库删除
              validateDeleteRel(ids_str);
              }
          }
              
      }
      //ajax删除记录
      function validateDeleteRel(ids){
             var flags=true;
                 jQuery.ajax({
          url: '<%=request.getContextPath()%>/SecuritygrouprelAction.do?cmd=deleteMulti&ids='+ids,
          type: 'GET',
          dataType: 'html',
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
              if(text!=1){       
               flags=false;
               alert("删除成功！");
              }
          }
          });return flags;
      }
 ////////////////////////////////////////////////////////////////////table1保存所有记录   
     function toSaveTbale1_onClick(){
          var security_group_id="<%=security_group_id%>";
          jQuery.ajax({
          url: '<%=request.getContextPath()%>/SecuritygrouprelAction.do?cmd=insert&security_group_id='+security_group_id,
          type: 'POST',
          data : jQuery("#form1").serialize(),
          dataType: 'html',
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
              if(text==1){       
               alert("保存成功！");
              }
          }
          });
    }                        
//子表一结束

//子表二开始
////////////////////////////////////////////////////////////////////table2从单选框中标记添加一条记录
     var table2Index=0;
     //新增大类行
     function toAddTbale2_onClick(){
         var obj=document.getElementById("table2");
         table2Index++;
         //添加行
         var rownum = obj.rows.length;
         var tr0=obj.insertRow(rownum);
         tr0.setAttribute("id","new"+table2Index);
         var td0 = tr0.insertCell(0);
         td0.innerHTML="  <input type='hidden' name='table2id'/><input type='checkbox' name='checkbox_template' value='new"+table2Index+"'/>";
         //添加单元格
         var td1 = tr0.insertCell(1);
         td1.innerHTML="<input type='hidden' name='security_group_id2' value=''/> <input type='text' class='text_field' validate='notNull;' name='type_code2' inputName='类型编码' maxLength='20' style='width:100px;' value=''/>";
          //添加单元格
         var td2 = tr0.insertCell(2);
         td2.innerHTML="<input type='text' class='text_field' name='type_name2' inputName='类型名称' validate='notNull;' maxLength='20' style='width:100px;' value=''/>";
         //添加单元格
         var td3 = tr0.insertCell(3);
         td3.innerHTML="<%=is_oneoff2%>";
     }
////////////////////////////////////////////////////////////////////table2从单选框中标记删除一条记录
      function toDeleteTbale2_onClick(){  
          var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
          if(ids == null) {  //如果ids为空
              alert('请至少选择一条记录');
              return;
          }
          if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
              //删除页面记录
              var ids_str='';
              var obj=document.getElementById("table2");
              for(var i=0;i<ids.length;i++){  //循环checkbox组
                  var table2id=ids[i];
                  var j=document.getElementById(table2id).rowIndex;
                  obj.deleteRow(j);
                  if(i<=ids.length&&table2id.indexOf("new")==-1){
                      ids_str=ids_str+ids[i]+",";
                  }
              }
              if(ids_str!=""){
              //数据库删除
              //alert("ids_str="+ids_str);
              validateDeleteNew(ids_str);
              }
          }
              
      }
      //ajax删除记录
      function validateDeleteNew(ids){
             var flags=true;
                 jQuery.ajax({
          url: '<%=request.getContextPath()%>/SecuritygroupnewAction.do?cmd=deleteMulti&ids='+ids,
          type: 'GET',
          dataType: 'html',
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
              if(text!=1){       
               flags=false;
               alert("删除成功！");
              }
          }
          });return flags;
      }
 ////////////////////////////////////////////////////////////////////table2保存所有记录   
     function toSaveTbale2_onClick(){
          var security_group_id="<%=security_group_id%>";
          jQuery.ajax({
          url: '<%=request.getContextPath()%>/SecuritygroupnewAction.do?cmd=insert&security_group_id='+security_group_id,
          type: 'POST',
          data : jQuery("#form1").serialize(),
          dataType: 'html',
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
              if(text==1){       
               alert("保存成功！");
              }
          }
          });  
     }     
//子表二结束

//子表三开始
////////////////////////////////////////////////////////////////////table3从单选框中标记添加一条记录
     var table3Index=0;
     //新增大类行
     function toAddTbale3_onClick(){
         var obj=document.getElementById("table3");
         table3Index++;
         //添加行
         var rownum = obj.rows.length;
         var tr0=obj.insertRow(rownum);
         tr0.setAttribute("id","stop"+table3Index);
         var td0 = tr0.insertCell(0);
         td0.innerHTML="  <input type='hidden' name='table3id'/><input type='checkbox' name='checkbox_template' value='stop"+table3Index+"'/>";
         //添加单元格
         var td1 = tr0.insertCell(1);
         td1.innerHTML="<input type='hidden' name='security_group_id3' value=''/> <input type='text' class='text_field' name='type_code3' validate='notNull;' inputName='类型编码' maxLength='20' style='width:100px;' value=''/>";
          //添加单元格
         var td2 = tr0.insertCell(2);
         td2.innerHTML="<input type='text' class='text_field' name='type_name3' inputName='类型名称' validate='notNull;' maxLength='20' style='width:100px;' value=''/>";
     }
////////////////////////////////////////////////////////////////////table3从单选框中标记删除一条记录
      function toDeleteTbale3_onClick(){  
          var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
          if(ids == null) {  //如果ids为空
              alert('请至少选择一条记录');
              return;
          }
          if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
              //删除页面记录
              var ids_str='';
              var obj=document.getElementById("table3");
              for(var i=0;i<ids.length;i++){  //循环checkbox组
                  var table3id=ids[i];
                  var j=document.getElementById(table3id).rowIndex;
                  obj.deleteRow(j);
                  if(i<=ids.length&&table3id.indexOf("stop")==-1){
                      ids_str=ids_str+ids[i]+",";
                  }
              }
              if(ids_str!=""){
              //数据库删除
              //alert("ids_str="+ids_str);
              validateDeleteStop(ids_str);
              }
          }
              
      }
      //ajax删除记录
      function validateDeleteStop(ids){
             var flags=true;
                 jQuery.ajax({
          url: '<%=request.getContextPath()%>/SecuritygroupstopAction.do?cmd=deleteMulti&ids='+ids,
          type: 'GET',
          dataType: 'html',
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
              if(text!=1){       
               flags=false;
               alert("删除成功！");
              }
          }
          });return flags;
      }
 ////////////////////////////////////////////////////////////////////table3保存所有记录   
     function toSaveTbale3_onClick(){
          var security_group_id="<%=security_group_id%>";
          jQuery.ajax({
          url: '<%=request.getContextPath()%>/SecuritygroupstopAction.do?cmd=insert&security_group_id='+security_group_id,
          type: 'POST',
          data : jQuery("#form1").serialize(),
          dataType: 'html',
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
              if(text==1){       
               alert("保存成功！");
              }
          }
          });  
     }     
//子表三结束

</script>
</fmt:bundle>

  
