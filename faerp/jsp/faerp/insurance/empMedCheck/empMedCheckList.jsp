<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartyfee.vo.EppartyfeeVo" %>
<%@ page import="rayoo.employeepost.eppartyfee.util.IEppartyfeeConstants" %>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IEppartyfeeConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IEppartyfeeConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    EppartyfeeVo resultVo = null;  //定义一个临时的vo变量
    String partyCode = request.getParameter("partyCode")==null  ? "" :request.getParameter("partyCode").toString();
    String party_name =resultVo==null?"":resultVo.getParty_name();
%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/PartyGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
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
        form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?id=" + ids;
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
            form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function compareTime(t1, t2, format){
      var f = {'yyyy' : 1, 'MM' : 2, 'dd' : 3, 'HH' : 4, 'mm' : 5, 'ss' : 6};
      var x = [], f = format.replace(/(\w+)/g, function(a, b){
             return f[b];
      }).match(/\w+/g).sort(function(a, b){
                x.push(a - b);
                return a - b;
      });
    function FormatTime(t){
             var i = 0, r = t.match(/\d+/g).sort(function(){
                        return x[i ++];
              });
 
              return new Date(r[0] + '/' + r[1] + '/' + r[2] + ' ' + (r[3] || '00') + ':' + (r[4] || '00')+ ':' + (r[5] || '00'));
      }
 
      return FormatTime(t1) > FormatTime(t2);
}
 
    function simpleQuery_onClick(){  //简单的模糊查询
    //  form.cmd.value = "queryPayPartyFee";
   //   form.submit();
     /*   if($id("end_date").value!=null)
        {
            if($id("start_date").value==null)
            {
                alert("开始月不能为空，请选择！");
                return;
            }
            if($id("start_date").value!=null&&compareTime( $id("start_date").value, $id("end_date").value, "yyyy-MM-dd" ))
            {
                alert("开始月不能大于结束月，请重新选择！");
                return;
            }
        }
        else if($id("start_date").value!=null)
        {
            if($id("end_date").value==null)
            {
                alert("结束月不能为空，请选择！");
                return;
            }
            if($id("start_date").value!=null&&compareTime( $id("start_date").value, $id("end_date").value, "yyyy-MM-dd" ))
            {
                alert("开始月不能大于结束月，请重新选择！");
                return;
            }
        }*/
        var reg = new RegExp("^[1-9]{1}[0-9]{3}((0[1-9]{1})|(1[0-2]{1}))$");  
        var start_date = $id("start_date").value;
        var end_date = $id("end_date").value;
        if(start_date!=null&&start_date!="")
        {
            if(!reg.test(start_date))
            {
                alert("日期格式不对！");
                return;
            }
        }
        if(end_date!=null&&end_date!="")
        {
            if(!reg.test(end_date))
            {
                alert("日期格式不对！");
                return;
            }
        }
        $id("datacell1").addParam("emp_name",$id("emp_name").value);
        $id("datacell1").addParam("cust_name",$id("cust_name").value);
        $id("datacell1").addParam("partyCode",$id("partyCode").value);
        $id("datacell1").addParam("is_secretary",$name("is_secretary").value);
        $id("datacell1").addParam("start_date",$id("start_date").value);
        $id("datacell1").addParam("end_date",$id("end_date").value); 
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/insertEppartyfee.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }
 function PartyGroupChange()
 {
        PartyGroupAjax.getPartyGroups(
                        {callback:function(data){
                        setSelectForBean("partyCode",data,"partyId","party_Name","");
                        if(<%=!"".equals(partyCode)%>){
                            document.getElementById("partyCode").value="<%=partyCode%>";
                           
                        }
                      
                    }
                }
        );
 }
  function getcust_name()
 {
    var ids = window.showModalDialog('<venus:base/>/CustomerAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    if(ids==undefined)return;
    document.getElementById("cust_name").value=ids[1];
 }
 function save()
 {
    $id("datacell1").submit();
   //     $id("datacell1").loadData();
        $id("datacell1").refresh();
 }
 
  function exportToExcel() {  
     if(confirm('是否确定要导出数据？')) {
      form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?cmd=PaypartyfeeexportToExcel";
      form.submit();
      }
  }
  
  function errorexportToExcel() {  
     if(confirm('是否确定要导出数据？')) {
      form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?cmd=errorexportToExcel";
      form.submit();
      }
  }
   function importToExcel() {  
     //if(confirm('是否确定要导入数据？')) {
     // form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?cmd=importToExcel";
     // form.submit();
      //}
       window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/importExcel.jsp", "", "dialogWidth=600px; dialogHeight=250px");
  }
    //选择客户
  function rtnFunc(arg)
  {
      var lookup = $id("lk_clz");
      lookup.value = arg[0];
      lookup.displayValue = arg[2];
      jQuery("#h_customer_id").val(arg[0]);        
      return false;
  }
  //选择客服
   function rtnFuncCS(arg){
       var lookup = $id("lk_cs");
       lookup.value = arg[0];
       lookup.displayValue = arg[1];
       jQuery("#h_user_id").val(arg[0]);        
       return false;
   }
   function addData(){  
    showModalCenter("<%=request.getContextPath()%>/jsp/faerp/insurance/empMedCheck/addEmpMedCheck.jsp"
                                                                    ,null,null,800,420,"新增员工体检");                                                
}
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/EppartyfeeAction.do">
<input type="hidden" name="cmd" value="queryAll">
    <div id="right">        
	    <div class="ringht_x">
	         <div class="box_tab">
                <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                   <tr>
                       <td width="15%" class="td_1">体检月份</td>
                       <td width="20%" class="td_2"><input type="text"
                           class="text_field" id="txt_flexible_welfare_time" name="enjoy_date1"/></td>
                       <td width="15%" class="td_1">&nbsp;</td>
                       <td width="20%" class="td_2"><input type="button" class="icon_3"
                           value="导出名单" onclick="elasticityWelfare()" /></td>
                       <td class="td_2"></td>
                   </tr>
                 </table>
                 <div class="dc_button"></div>
            </div>
		    <div class="box_tab">
		        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		          <tr>
		               <td class="td_1" >客户编号</td>		                  
		               <td class="td_2 ">
		                  <input type="text" class="text_field" id="cus_no" name="cus_no" inputName="客户编号" value="" />
		               </td>
		               <td class="td_1" >客户名称</td>
		               <td class="td_2" >
			               <w:lookup onReturnFunc="rtnFunc" readonly="true" id="lk_clz"
			                lookupUrl="/CustomersimpleAction.do?cmd=queryAllGetByID"
			                dialogTitle="选择客户" height="500" width="400" style="width:195px" /> <input type="hidden"
			                name="cust_name" id="h_customer_id" />
		               </td>
		           </tr>
		           <tr>
		             <td class="td_1" >唯一号</td>
		             <td class="td_2 ">
		               <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="25" />
		             </td>
		             <td class="td_1" >员工名称</td>
		             <td class="td_2" >
		                <input type="text" class="text_field" id="emp_name" name="emp_name" inputName="姓名" value="" />                       
		             </td>
		          </tr>
		          <tr>
		            <td class="td_1" >身份证</td>
		            <td class="td_2 ">
		              <input type="text" class="text_field" name="id_card" inputName="证件号码" maxLength="64" />
		            </td>
		            <td class="td_1" >所属客服</td>
		            <td class="td_2" >
		                <w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" 
	                    lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" 
	                    height="500" width="400" style="width:195px"/>
	                    <input type="hidden" name="user_id" id="h_user_id"/>
		            </td>
		         </tr> 		          
		          <tr>
                    <td class="td_1" ></td>
                    <td class="td_2 ">
                     </td>
                    <td class="td_1" ></td>
                    <td class="td_2" >
                        <input type="button" class="icon_2" value="查询" onclick="javascript:simpleQuery_onClick()"/>
                   </td>
                 </tr>                        
		        </table>
		     </div>
	          <div id="ccParent1" class="button"> 
	                <div class="button_right">
	                  <ul>
	                   <li class="c"><a onClick="addData()">新增</a></li>
		               <li class="e_1"><a href="###">导入</a></li>
		               <li class="e"><a href="###">导出</a></li>
	                 </ul>               
	                </div>
	                <div class="clear"></div>            
	         </div>                  
	         <div>
			    <r:datacell 
			        id="datacell1"
			        queryAction="/FAERP/EppartyfeeAction.do?cmd=queryPayPartyFee"
			        submitAction="/FAERP/EppartyfeeAction.do?cmd=update"
			        width="100%"
			        height="318px"
			        xpath="EppartyfeeVo"
			        submitXpath="EppartyfeeVo"
			        paramFormId="datacell_formid"
			        >			
				      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
				      <!--        <r:field fieldName="id" label="操作" width="50px"  align="center">
				       </r:field>    -->        
				      <r:field fieldName="emp_name" label="客户" width="100px">			                       
				       </r:field>    
				      <r:field fieldName="cust_name" width="140px" label="员工唯一号">			
				      </r:field>
				      <r:field fieldName="is_secretary" width="240px" label="员工名称" >			
				      </r:field>
				      <r:field fieldName="party_name" width="210px" label="员工身份证号码">			        
				      </r:field>
				      <r:field fieldName="start_date" label="性别">
				       <w:date format="yyyy-MM-dd" id="start_date1" name="start_date1"/> 
				      </r:field>
				      <r:field fieldName="end_date" label="客服">
				        <w:date format="yyyy-MM-dd" id="end_date1" name="end_date1"/> 
				      </r:field>
				      <r:field fieldName="in_money" label="婚否">
				       <h:text />
				      </r:field>
				      <r:field fieldName="end_date" label="体检开始日期">
	                    <w:date format="yyyy-MM-dd" id="end_date1" name="end_date1"/> 
	                  </r:field>
	                  <r:field fieldName="end_date" label="体检截止日期">
	                    <w:date format="yyyy-MM-dd" id="end_date1" name="end_date1"/> 
	                  </r:field>
	                  <r:field fieldName="end_date" label="结算日期">
	                    <w:date format="yyyy-MM-dd" id="end_date1" name="end_date1"/> 
	                  </r:field>				
			    </r:datacell>
	       </div>
    </div>
</form>
</fmt:bundle>

</body>
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(IEppartyfeeConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEppartyfeeConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
PartyGroupChange();

    
</script>   
