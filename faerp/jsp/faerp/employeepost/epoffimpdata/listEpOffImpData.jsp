<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.employeepost.epoffimpdata.epoffimpdata_resource" prefix="rayoo.employeepost.epoffimpdata.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
   window.onload=function impmessage(){
   var message="<%=request.getAttribute("impresult")%>";
   var impmessage=document.getElementById("impmessage");
   //2016-04-11 by zhouxiaolong  优化导入离职页面提示信息  begin
   impmessage.innerHTML=message;
   //2016-04-11 by zhouxiaolong  优化导入离职页面提示信息  end
   }

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   );>";
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
        form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?id=" + ids;
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
            form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
    //    form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?cmd=simpleQuery";
    //  form.cmd.value = "simpleQuery";
   //      form.submit();
        
           $id("datacell1").loadData();
           $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/epoffimpdata/insertEpOffImpData.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
        form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?cmd=export";
     //     form.cmd.value = "export";
        form.submit();
       /*       
        var batch_id = document.getElementById("batch_id").value;
        var imp_flag = document.getElementById("imp_flag").value;
        var  failure_reason =  document.form.failure_reason.value;    //document.getElementById("failure_reason").value;
        var url='<%=request.getContextPath()%>/EpOffImpDataAction.do?cmd=export&batch_id='+batch_id+"&imp_flag="+imp_flag+"&failure_reason="+failure_reason;
    
                              var flags=true;
                                jQuery.ajax({
                      //          url: '<%=request.getContextPath()%>/EpOffImpDataAction.do?cmd=export&batch_id='+batch_id+"&imp_flag="+imp_flag+"&failure_reason="+failure_reason+"",
                              url: url,
                                type: 'GET',
                                dataType: 'html',
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                         if(text==1){
                                            alert("由于数据太多，请重新选择查询条件再导出！");
                                         }
                                         if(text==2){
                                            alert("数据总量为0，请重新选择查询条件再导出！");
                                         }
                                    }
                                    
                                }
                                });return flags;
        
    */      
        
        
        
        
    }

</script>
</head>
<body>
<form name="form" method="post"  id ="datacell_formid"   action="<%=request.getContextPath()%>/EpOffImpDataAction.do">
    <input type="hidden" name="cmd" value="queryAll">
     <input type="hidden" id="cmd1"   name="cmd1" value="queryAll">
    <input type="hidden"  id="action1"  name="action1" value="EpOffImpDataAction.do">

<input type="hidden" name="backFlag" value="true">
<%   
String batch_id="";
batch_id=(String)request.getAttribute("batch_id");


%>
<input  type="hidden"  name="batch_id" id="batch_id" value="<%=batch_id %>">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="look_imp_rs"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>






    
    
        
        
        <tr>
            <td align="right"><fmt:message key="imp_rs"/></td>
            <td align="left">
                <select  id="imp_flag" name="imp_flag">
                <option value="0"><fmt:message key="error"/></option>
                <option value="1"><fmt:message key="succese"/></option>
                </select>
            </td>
            <td align="right"><fmt:message key="error_reason"/></td>
            <td align="left">
               <%=gap.rm.tools.helper.RmJspHelper.getSelectField("failure_reason", -1,"FAILURE_REASON", "", "", false) %>
            </td>
        </tr>
        <tr>
            <td/>
          
            <td/>
            <td/>
              <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            </td>
                <td/>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="a">      <a  onClick="javascript:detail_onClick();"><fmt:message key="imp_problems_date"/></a> </li>
                </ul>
                
         </div>
       <span id="impmessage" style="color:blue;font-size:18px">导入结果：</span>
           <div class="clear"></div>


</div>
 
 
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EpOffImpDataAction.do?cmd=queryAll"
        width="99%"
        xpath="EpOffImpDataVo"
        submitXpath="EpOffImpDataVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>           
       <r:field fieldName="employee_name" messagekey="emp_name" width="100px">
                  
       </r:field>    
      <r:field fieldName="employee_code" width="140px" messagekey="emp_code">
      </r:field>
      <r:field fieldName="company_code" messagekey="cust_code">
      </r:field>
       <r:field fieldName="off_post_date" messagekey="off_post_date">
      </r:field>
      
      
      <r:field fieldName="end_date" messagekey="fee_end_date"   allowModify="false">
      <w:date format="yyyy-MM-dd" />
      </r:field>
      
      <r:field fieldName="off_reason" messagekey="off_post_reason">
        <d:select dictTypeId="OFF_POST_REASON" />
      </r:field>
      
      
         <r:field fieldName="off_memo" messagekey="off_post_desc">
      </r:field>
      <!-- <siqp注销>
        <r:field fieldName="labor_notebook_type" label="劳动手册领取方式">
      </r:field>
       -->
        <r:field fieldName="acc_transfer_type" messagekey="method_accu_move">
      </r:field>
      
      
          <r:field fieldName="fire_address" messagekey="location_retrieve_doc">
      </r:field>
      
      <r:field fieldName="ge_off_reason" messagekey="ge_off_post_reason">
        <d:select dictTypeId="GE_OFF_POST_REASON" />
      </r:field>
      
      
      <r:field fieldName="imp_flag" messagekey="imp_rs"  allowModify="false">
           <d:select dictTypeId="IMP_FLAG" />
      </r:field>
      
            <r:field width="380" fieldName="failure_reason" messagekey="error_reason"  allowModify="false">
           <d:select dictTypeId="FAILURE_REASON" />
      </r:field>
      
      
      
     
      
      
      

      
      
      
    </r:datacell>
    </div>
 
 

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写

%>
</script>   
