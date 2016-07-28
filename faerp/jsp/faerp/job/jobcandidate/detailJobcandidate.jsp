<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@page import="rayoo.job.job_adviser.vo.JobPositionVo"%>
<%@page import="gap.authority.helper.LoginHelper"%>

<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<%
JobPositionVo vo = (JobPositionVo)request.getAttribute("bean");
String position_id = vo.getId();
//当前登录人ID
String user_id =  LoginHelper.getPartyId(request);
%>

<%@page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>候选人维护</title>
<script language="javascript">

//每行数据第一列生成单选按钮
function generetCheckbox(value,entity,rowNo,cellNo){
       //return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  >";
       return "<input type='radio' name='temp' value=" + entity.getProperty("id") + "  >";
}
//生成候选人链接
function generetHref(value,entity,rowNo,cellNo){
    var url = "<%=request.getContextPath()%>/JOB_PERSONAction.do?id=" + entity.getProperty("person_id") + "&cmd=detail";
    return "<a href='"+ url +"' target='_blank'  style='text-decoration:underline;'>"+ entity.getProperty("person_name") +"</a>";
}

function add_click(){
if("2"==<%=vo.getPositiontype()%>){
    alert("预开票职位不能添加候选人！");
    return ;
}

 _jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/Job_adviserAction.do?cmd=checkAdviserState&position_id=<%=vo.getId()%>&adviser_id=<%=user_id%>",
            dataType : "html",
            success : function(data) {
                   if(data=="2"){
                       alert("顾问状态已暂停，不能添加候选人！");
                       return ;
                   }else{
                         var url="<%=request.getContextPath()%>/JOB_PERSONAction.do?cmd=queryAll&user_id=<%=user_id%>&position_id=<%=position_id%>&warranty=<%=vo.getWarranty()%>";
						 url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
						 var dc1 = $id("datacell1");
						showModalCenter(url,dc1,null,1100,670,"增加候选人");
                        return ;
                   }
              }
            });
}
   
   //datacell提交
   function toSave_onClick() {
    var datacell = $id("datacell1");
            if(datacell.isModefied){
                var uEntities = datacell.dataset.getModifiedEntities();
                for(i=0;i<uEntities.length;i++){
                    var entity = uEntities[i];
                    var status = entity.getProperty("status");
                    var duedate = entity.getProperty("duedate");
                    var employee_id = entity.getProperty("employee_id");
                    var confirmsalary = entity.getProperty("confirmsalary");
                    if(status == "8" && (duedate == "null" || duedate == "" || duedate == null)){
	                    alert("状态为ONBOARD时任职日期不能为空！");
	                    return ;
                    }
                    if(employee_id != null && employee_id != "null" && employee_id != "" && (confirmsalary == "" || confirmsalary == "null" || confirmsalary == null)){
                        alert("关联员工后必须填写确认薪资！");
                        return ;
                    }
                }
                $id("datacell1").submit();
                alert("保存成功！");
            }else{
                alert("数据未修改！");
            }
    }  
   
   //取消保存
   function cancel(){
   var isModefied = $id("datacell1").isModefied;
        if(isModefied){
            if(!window.confirm("还有尚未保存的数据，是否确认放弃？"))
                return ;
        }
    $id("datacell1").reload();
    $id("datacell1").refresh();
   }
   
   
   //查看候选人状态历史
   function candidateStateList(){
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/jsp/faerp/job/jobcandidate/candidateStateList.jsp?id="+ids;        
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        //window.open(url,'','height=600px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=候选人状态变化');
        window.showModalDialog(url,"","dialogHeight :400px;dialogWidth:920px;center:yes;status:no;scroll:no;resizable:no;");
    }
    
    function winclose(){
        var isModefied = $id("datacell1").isModefied;
        if(isModefied){
            if(!window.confirm("还有尚未保存的数据，是否确认放弃？"))
                return ;
        }
        window.close();
    }
    
</script>
</head>
<body>
 
<form name="form" method="post">
       <div id="right">
        <div class="right_title_bg">
       <div class=" right_title">   <fmt:message key="detail_page"/>
       </div>
     </div>
    <div class="ringht_s">

<div id="ccChild0" class="box_3"> 
<div class="xz_title">招聘订单信息</div>
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >订单编号</td>
            <td class="td_2" >
            <input type="hidden" id="order_id" value="<%=vo.getOrder_id() %>"/>
            <input type="text" value="<%=vo.getOrder_code() %>" class="text_field" id="order_code" readonly="readonly"/>
            </td>
            <td class="td_1" >订单名称</td>
            <td class="td_2" >
            <input  type="text" value="<%=vo.getOrder_name() %>" class="text_field" id="order_name" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >关联合同</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getContract_name() %>" class="text_field" id="contract_name" readonly="readonly"/>
            </td>
            <td class="td_1" >客户名称</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getCustomer_name() %>" class="text_field" id="customer_name" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >担保期</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getWarranty()==null?"":vo.getWarranty() %>" class="text_field" id="warranty" readonly="readonly"/>
            </td>
            <td class="td_1" >订单状态</td>
            <td class="td_2" >
            <%=RmJspHelper.getSelectField("order_status",-1,"ORDER_STATUS_BD",vo.getOrder_status()," disabled='disabled' ",false) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" >订单日期</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getOrder_create_date().toLocaleString().substring(0,9) %>" class="text_field" id="order_create_date" readonly="readonly"/>
            </td>
               <td class="td_1" >订单类型</td>
            <td class="td_2" >
            <%=RmJspHelper.getSelectField("recruittype",-1,"RECURITTYPE",vo.getRecruittype()," disabled='disabled' ",false) %>
            </td>     
        </tr>
        <tr>
             <td class="td_1" >录入人</td>
            <td class="td_2" colspan="3">
             <input type="text" value="<%=vo.getOrder_create_user_name() %>" class="text_field" id="order_create_user_name" readonly="readonly"/>
            </td>
        </tr>
    </table>
</div>

<div id="ccChild0" class="box_3"> 
<div class="xz_title">招聘职位信息</div>
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >招聘职位</td>
            <td class="td_2" >
             <input type="hidden" id="id" value="<%=vo.getId() %>"/>
            <input type="text" value="<%=vo.getPosition() %>" class="text_field" id="position" readonly="readonly"/>
            </td>
            <td class="td_1" >招聘地区</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getArea() %>" class="text_field" id="area" readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >招聘数量</td>
            <td class="td_2" >
            <input type="text" value="<%=vo.getJob_number() %>" class="text_field" id="job_number" readonly="readonly"/>
            </td>
            <td class="td_1" >薪资范围</td>
            <td class="td_2" >
            <%=RmJspHelper.getSelectField("salary_range",-1,"SALARY_RANGE_BD",vo.getSalary_range()," disabled='disabled' ",false) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" >职位要求</td>
            <td class="td_2"  colspan="3">
                <textarea rows="10" cols="75" readonly="readonly"><%=vo.getRequirement() %></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1" >职位状态</td>
            <td class="td_2" colspan="3" >
           <%=RmJspHelper.getSelectField("position_status",-1,"ORDER_STATUS_BD",vo.getPosition_status()," disabled='disabled' ",false) %>
            </td>
        </tr>
    </table>
</div>


 <div class="xz_title">候选人</div>
 <div class="button_right"  style="padding-left: 15px;">
        <ul>
             <li class="a"><a onClick="javascript:candidateStateList();">查看状态</a></li>
             <li class="c"><a onClick="javascript:add_click();">新增</a></li>
             <li class="bc"><a onClick="javascript:toSave_onClick();">保存</a></li>
             <li class="m"><a onClick="javascript:cancel();">取消</a></li> 
        </ul>
</div>

 <div class="clear"></div>
<div class="box_bjd" id="values_div" style="padding-left: 10px;">
 <r:datacell id="datacell1" 
 queryAction="/FAERP/JobcandidateAction.do?cmd=getCandidateByPositionID&position_id=${param.id}"
 submitAction="/FAERP/JobcandidateAction.do?cmd=insertAndUpdateAndDel&position_id=${param.id}"
 submitXpath="JobcandidateVo" xpath="JobcandidateVo" width="98%" height="318px" >
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
<r:field fieldName="id" label="操作" width="50px" onRefreshFunc="generetCheckbox"  align="center" ></r:field>
 <r:field fieldName="person_name" label="候选人姓名" width="100px" onRefreshFunc="generetHref">
 </r:field>
 <r:field fieldName="idegree" label="学历" width="100px" allowModify="false">
    <d:select dictTypeId="YINGRUI_DEGREE" ></d:select>
 </r:field>
 <r:field fieldName="startwork" label="开始工作日期" allowModify="false" width="100px">
    <w:date format="yyyy-MM-dd" readonly="true" readOnly="true"/>
 </r:field>
 <r:field fieldName="sex" label="性别" allowModify="false" width="50px">
     <d:select dictTypeId="YINGRUI_SEX"></d:select>
 </r:field>
 <r:field fieldName="ifuturewage" label="薪资要求" allowModify="false" width="120px" >
    <d:select dictTypeId="YINGRUI_WAGE"></d:select>
 </r:field>
 <r:field fieldName="status" label="目前状态" width="80px" allowModify="true">
    <d:select dictTypeId="CANDIDATE_STATUS_BD" ></d:select>
 </r:field>
 <r:field fieldName="remark" label="备注" width="200px" allowModify="true">
    <h:textarea rows="6" cols="23" />
 </r:field>
 <r:field fieldName="duedate" label="任职日期" allowModify="true" width="100px">
    <w:date format="yyyy-MM-dd" />
 </r:field>
  <% if(("2").equals(vo.getRecruittype())){%>
 <r:field fieldName="employee_name" label="关联员工" allowModify="true" width="100px">
 <w:lookup onReturnFunc="rtnFunc" readonly="false" displayValue="" id="lk_cust" 
                                   lookupUrl="/JcustomerAction.do?cmd=getEmppostPage&cust_id=${bean.cust_id}" dialogTitle="选择员工" 
                                   height="440" width="710" allowInput="false" readOnly="false"></w:lookup>
 </r:field>
   
 <r:field fieldName="confirmsalary" label="确认薪资" allowModify="true" width="100px">
    <h:text name="hconfirmsalary" validateAttr="type=number;" />
 </r:field>
<%} %>

 <r:field fieldName="is_cancelprotect" label="是否取消保护期" width="100px" align="center">
     <!--<d:select dictTypeId="TrueOrFalse"></d:select>-->
     <h:switchCheckbox checkedValue="1" uncheckedValue="0"/>
 </r:field>
<r:field fieldName="employee_id" label="" allowModify="true" width="0px"></r:field>
 </r:datacell>  
 </div>
    
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:winclose();" />
</div>


</div>

</div>

</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>

</body>
</html>

<script language="javascript">
$id("datacell1").beforeEdit= function(cell,colIndex,rowIndex){
if(colIndex == 6 || colIndex == 7 || colIndex == 8 || colIndex==9 || colIndex == 10)//目前状态、备注、任职日期、关联员工、确认薪资
    return true;
return false;
}
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
  var entity= $id("datacell1").getActiveEntity();
        var sal=arg[1]==null?0:arg[1];
     entity.setProperty("confirmsalary",sal);
      entity.setProperty("employee_id",arg[0]);
    return false;
}
</script>
