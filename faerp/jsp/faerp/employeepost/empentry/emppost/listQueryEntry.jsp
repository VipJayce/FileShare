<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
String city_id = (String)request.getAttribute("city_id");
if(city_id==null || "".equals(city_id)){
    city_id = "1099110100000000050";
}
request.setAttribute("city_id",city_id);
%>
<script language="javascript">
    jQuery(function(){
        $id("datacell2").isQueryFirst = false;
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        //2015-3-25 yangyuting add      
//       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("emp_service_id")+"\");>";
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("emp_service_id")+"\",\""+entity.getProperty("emp_code")+"\",\""+entity.getProperty("is_phoenix")+"\",\""+entity.getProperty("phoenix_status")+"\");>";
    }
    
    function setCheckbox(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("emp_service_id")+"\",\""+entity.getProperty("emp_code")+"\",\""+entity.getProperty("is_phoenix")+"\",\""+entity.getProperty("phoenix_status")+"\");>";
//       return "<input type='radio'  name='temp'   onClick=ClickRow1(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow(value,value1,value2,value3,value4){
        $id("post_id").value = value;

        $id("datacell2").addParam("emp_service_id",value1);
        $id("datacell2").loadData();
        $id("datacell2").refresh();
         //value 为新选择的empid yangyuting 2014-8-12
         var emp_post_id = $id("post_id").value;
          $id("datacell3").isQueryFirst = true;
          $id("datacell3").queryAction = "/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAllByIsReceive&emp_post_id="+emp_post_id;
          $id("datacell3").loadData();
          $id("datacell3").refresh();
          //2015-3-25 yangyuting add
         $id("emp_code").value = value2;
        $id("is_phoenix").value = value3;
        $id("phoenix_status").value = value4;
    }
    
    function ClickRow1(value){
        
    }

     function exportEmpSend(){ 
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=exportRiZhiMingDan";
       form.submit();
    }
    
    
    
    //2015-3-23 yangyuting add 终止入职E化
     function kill_phoenix(){ 
        var emp_code = $id("emp_code").value;
        var emp_post_id = $id("post_id").value;
       var phoenix_status = $id("phoenix_status").value;
        var is_phoenix = $id("is_phoenix").value;
        if(is_phoenix=="0"){
            alert("该员工的状态已是不走E化流程！");
            return;
        }
        else{
            if(phoenix_status=="4"){
                  alert("该员工已在福利办理阶段无需再终止入职E化！");
                  return;
            }
            else if(phoenix_status=="5"){
                  alert("该员工已终止入职E化！");
                  return;
            }
            else if(phoenix_status=="0"){
                  alert("该员工的状态已是不走E化流程！");
                  return;
            }
            else if(phoenix_status=="1"||phoenix_status=="2"){
               //该员工的状态已分类，确认需要终止入职E化phoenix_status=="2"
                 //该员工的状态已报入职，但未分类phoenix_status=="1"
                   document.getElementById("sub").disabled=true;//防止重复提交
                                  var flags=false;
                                     jQuery.ajax({
                                           url: '<%=request.getContextPath()%>/QuickemppostAction.do?cmd=killPhoenix&emp_code='+emp_code+"&phoenix_status="+phoenix_status+"&emp_post_id="+emp_post_id,
                                           type: 'GET',
                                           dataType: 'html',
                                            async: false,
                                           timeout: 80000,
                                           error: function(){
                                               alert('查询该客户是否为E化客户失败， 请联系管理员。');
                                                document.getElementById("sub").disabled=false;//防止重复提交
                                           },
                                           success: function(text){
                                               if(text!=null){     
                                                  if(text=="0"){
                                                    alert("操作成功！");
                                                    flags=true;
                                                   } 
                                                   else {
                                                    alert(text);
                                                   }
                                               }
                                                document.getElementById("sub").disabled=false;//防止重复提交
                                           }
                                           });
            }
            
            
        }
      document.getElementById("sub").disabled=false;//防止重复提交
    }

    function simpleQuery_onClick(){  //简单的模糊查询
        var classify_date_from = $id("classify_date_from").value;
        var classify_date_to = $id("classify_date_to").value;
        if(classify_date_from!=null && classify_date_from != "" && classify_date_from != "null"){
            var aStart=classify_date_from.replace(/-/g,"\/"); //转成成数组，分别为年，月，日，下同
        }
        if(classify_date_to!=null && classify_date_to != "" && classify_date_to != "null"){
            var aEnd=classify_date_to.replace(/-/g,"\/");
        }
        if (aStart > aEnd) {
            alert("<fmt:message key="begin_time_gt_end_time"/>");
            return;
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //查看个人订单信息 参数为PB_EMP_POST表中的主键id
    function detail_onClick(){
        var emp_post_id = $id("post_id").value;
        if(emp_post_id!=null&&emp_post_id!=""){
	        //$id("datacell_formid").action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id="+emp_post_id;
	        //$id("datacell_formid").submit();
	         //window.showModalDialog('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'个人订单信息','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
	         window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
	        //showModalCenter('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,window,'',950,450,"个人订单信息");
        }else{
            alert("<fmt:message key="select_records"/>");
            return;
        }
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];//按名称查询
        lookup.displayValue = arg[2];
        jQuery("#h_customer_name").val(arg[2]);
        return false;
    }
    //选择客服
    function rtnFuncCS(arg){
        var lookup = $id("lk_cs");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#h_user_id").val(arg[0]);
        jQuery("#h_user_name").val(arg[1]);
        return false;
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid"  action="<%=request.getContextPath()%>/EmppostAction.do">
    <input type="hidden" id="post_id" name="post_id" value=""/>
    <input type="hidden" id="emp_code" name="emp_code" value=""/>
    <input type="hidden" id="is_phoenix" name="is_phoenix" value=""/>
    <input type="hidden" id="phoenix_status" name="phoenix_status" value=""/>
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key="on_post_query"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
    <table width="100%" cellspacing="0">
        <tr>
            <td width="130" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="city"/></td>
            <td align="left" width="210">
                <r:comboSelect id="city_idList_search" name="city_id1"
                           queryAction="PB_CITYAction.do?cmd=getListData"
                           textField="city_name"
                           valueField="id"
                           xpath="PB_CITYVo"
                           width="200px"
                           value="${requestScope.city_id }"
                           messagekey="please_choose"/>
            </td>
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer"  id="lk_clz" name="customer_name" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
                <input type="hidden" name="cust_name1" id="h_customer_name" value=""/>
            </td>
            <td width="73" align="right"><fmt:message key="sort_date"/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" id="classify_date_from" name="classify_date_from" width="80px"/>&nbsp;<fmt:message key="to"/>&nbsp;<w:date format="yyyy-MM-dd" id="classify_date_to" name="classify_date_to" width="80px"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="25"/>          </td>
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="50"/>            </td>
            <td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left"><input type="text" class="text_field" name="id_card1" inputName="证件号码" maxLength="64"/></td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="sort_status"/></td>
            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("service_status_bd1", -1,"SERVICE_STATUS_BD", "", "", false) %></td>
            <td align="right"><fmt:message key="is_current_effective"/></td>
            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_valid1", -1,"TrueOrFalse", "1", "", false) %></td>
            <td align="right"><fmt:message key="contract_user_id"/></td>
            <td align="left">
                <r:comboSelect id="combo_cs" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_choose" />
                <!--<w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs"
                    lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" 
                    height="500" width="400" style="width:195px"/>
                    <input type="hidden" name="user_id" id="h_user_id"/>
                    <input type="hidden" name="user_name" id="h_user_name"/>-->
            </td>
        </tr>
        <tr>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
            <td align="left"><input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();"></td>
         </tr>
</table>
</div>
                    
<div id="ccParent1" class="button"> 
    <div class="button_right"><!--
        <ul>
            <li class="a_2">      <a  onClick="javascript:detail_onClick();">查看个人订单</a> </li>
            <li class="e">      <a  onclick="exportEmpSend();">导出</a> </li>
        </ul>
    -->
     <input class="a_2" type="button"   value="<fmt:message key="look_person_order"/>"  <au:authorityBtn code="view_orderItem0" type="1"/>  onClick="detail_onClick();">
     <input class="e" type="button"   value="<fmt:message key="leading_out"/>"  <au:authorityBtn code="declIn_exp" type="1"/>  onClick="exportEmpSend();">
     <input class="a_2" type="button"  id="sub" value="终止入职E化"  <au:authorityBtn code="kill_phoenix" type="1"/>  onClick="kill_phoenix();">
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=searchEntryData"
        width="98%"
        height="320px"
        xpath="EmppostVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="send_name" messagekey="send_name">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey="cust_name">
               <h:text/>   
           </r:field>    
          <r:field fieldName="city_id" messagekey="city" width="100px">
                <r:comboSelect id="countryList" name="city_id"
                     queryAction="PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px"/>
           </r:field>   
          <r:field fieldName="id_card" messagekey="emp_card_no1">
               <h:text/>
           </r:field>
           <r:field fieldName="emp_code" messagekey="emp_code">
            <h:text/>
          </r:field>
          <r:field fieldName="emp_name" messagekey="emp_name">
            <h:text/>
          </r:field>
          <r:field fieldName="post_status_bd" messagekey="status_name">
            <d:select dictTypeId="POST_STATUS_BD" />
          </r:field>
          <r:field fieldName="big_name" messagekey="big_name">
            <h:text/>
          </r:field>
          <r:field fieldName="small_name" messagekey="small_name">
            <h:text/>
          </r:field>
          <r:field fieldName="service_status_bd" messagekey="sort_status">
            <d:select dictTypeId="SERVICE_STATUS_BD" />
          </r:field>
          <r:field fieldName="classify_date" messagekey="sort_date">
            <w:date format="yyyy-MM-dd" />
          </r:field>
          <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date">
            <w:date format="yyyy-MM-dd" />
          </r:field>
          <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1">
            <w:date format="yyyy-MM-dd" />
          </r:field>
          <r:field fieldName="user_name" messagekey="user_name">
            <h:text/>
          </r:field>
          <r:field fieldName="is_phoenix" label="是否E化入职" width="0">
           <d:select dictTypeId="IS_FOREIGNER" nullLabel="--请选择--" />
          </r:field>
          <r:field fieldName="phoenix_status" label="E化入职状态" width="0">
                <h:text/>
          </r:field>
    </r:datacell>
    </div>
                
         <div style="padding: 8 10 8 8;">
            <div style="float: left;">
        <r:datacell 
	        id="datacell2"
	        paramFormId="datacell_formid"
	        queryAction="/FAERP/EmppostAction.do?cmd=searchZlitem"
	        width="540px"
	        height="304px"
	        xpath="EmpserviceitemVo"
	        readonly="true"
	        pageSize="-1"
	        >
	       <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckbox" align="center" >
	       </r:field> 
	      <!--<r:field fieldName="agent_name" messagekey="agent" width="300px">
	        <h:text/>
	      </r:field>
	      --><r:field fieldName="service_name" messagekey="service_name" width="180px">
	        <h:text/>
	      </r:field>
	      <r:field fieldName="service_status" messagekey="status_name" width="180px">
	        <d:select dictTypeId="SERVICE_STATUS" />
	      </r:field>
	      <r:field fieldName="service_date" messagekey="service_date" width="180px">
	       <w:date format="yyyy-MM-dd"/>
	      </r:field>
	    </r:datacell>
	    </div>
	    
	    
	     <div style="float: right;margin-right:11px;">
                     <r:datacell id="datacell3" queryAction="/FAERP/EmpMaterialAction.do?cmd=searchEmpMaterialAllByIsReceive" 
                      submitXpath="EmpMaterialVo" pageSize="100"
                     width="550px" height="300px" xpath="EmpMaterialVo" >
                     <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                         <r:field fieldName="material_name" label="材料名称" width="110px"  allowModify="false"> </r:field>    
                         <r:field fieldName="remark" label="备注" width="110px"  allowModify="true" ></r:field>    
                         <r:field fieldName="is_receive" label="是否收到" width="80px"  allowModify="false">
                            <select onchange="selectIsReceive(this.value)">
                                <option value="1">是</option>
                                <option value="2">缺失</option>
                            </select>
                        </r:field>    
                         <r:field fieldName="receive_user" label="签收人员" width="80px"  allowModify="false"></r:field>
                         <r:field fieldName="receive_date" label="签收日期" width="80px"  allowModify="false">
                            <w:date allowInput="true" id="receive_date1" name="receive_date1" format="YYYY-MM-DD" property="bean/receive_date" width="110px" />
                         </r:field>     
                     </r:datacell>
             </div>
	    
	    
	</div>  
    
</div>
</div>
</form>

</fmt:bundle>

</body>
</html>
<script type="text/javascript">
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
         
});
</script>
