<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartyrelation.vo.EppartyrelationVo" %>
<%@page import="rayoo.employeepost.eppartymemer.vo.PartyRelationEmployeeVo"%>
<%@ page import="rayoo.employeepost.eppartyrelation.util.IEppartyrelationConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IEppartyrelationConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IEppartyrelationConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    EppartyrelationVo resultVo = null;  //定义一个临时的vo变量
    PartyRelationEmployeeVo vo = null;
    List employeelist = null;
    if(request.getAttribute("employeelist")!=null)
    {
        employeelist = (List)request.getAttribute("employeelist");
    }

%>


<%@page import="java.text.SimpleDateFormat"%>
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
                    ids =elementCheckbox[i].value;
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
        form.action="<%=request.getContextPath()%>/EppartyrelationAction.do?id=" + ids;
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
            form.action="<%=request.getContextPath()%>/EppartyrelationAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //按条件查询
        $id("datacell1").addParam("emp_name",$id("emp_name").value); 
        $id("datacell1").addParam("id_card",$id("id_card").value); 
        $id("datacell1").addParam("emp_code",$id("emp_code").value); 
        $id("datacell1").addParam("cust_name",$id("query_cust_name").value); 
        $id("datacell1").addParam("emp_sex",$name("emp_sex").value); 
        $id("datacell1").addParam("partyCode",$id("partyCode").getValue()); 
        $id("datacell1").addParam("status1",$name("status1").value); 
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyrelation/insertEppartyrelation.jsp";
        form.submit();
    }

 function getcust_name()
 {
    var ids = window.showModalDialog('<venus:base/>/CustomerAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    if(ids==undefined)return;
    document.getElementById("cust_name").value=ids[1];
 }
 function exportExcel_onClick()
 {
        form.action="<%=request.getContextPath()%>/EppartyrelationAction.do" ;
        form.cmd.value = "exportExcel";
        form.submit();
 }

    function setTab001Syn ( i )
    {  
        if(document.getElementById("emp_id").value==null||document.getElementById("emp_id").value=="")
        {
            alert("请先选择一名党员！");
            return;
        }
        document.getElementById('bg').className='reserve_xixi'+i;
        selectTab001Syn(i);
      
    }
    
    function selectTab001Syn ( i )
    {
        switch(i){
            case 1:
                document.getElementById("TabCon1").style.display="block";
                document.getElementById("TabCon2").style.display="none";
                document.getElementById("TabCon3").style.display="none";
                document.getElementById("font1").style.color="#FFFFFF";
                document.getElementById("font2").style.color="#000000";
                document.getElementById("font3").style.color="#000000";
                var status = document.getElementById("relation_status").value;
                var moveform =document.getElementById("relation_area").value
                var emp_status=document.getElementById("emp_status1").value;
                var rid =document.getElementById("rid").value;
	                   if(status=="0")
	                   {
	                              jQuery("#TabCon1").empty();
                                  jQuery("#TabCon2").empty();
                                  jQuery("#TabCon3").empty();
                                  jQuery("#TabCon1").append(" <iframe id = \"move_in\" name=\"move_in\"  src=\"<%=request.getContextPath()%>\/jsp/faerp/employeepost/eppartyrelation/move_in.jsp?movefrom="+moveform+"&emp_status="+emp_status+"&rid="+rid+"\" scrolling=\"no\"  frameBorder=0 width=\"100%\" height=\"170px;\"><\/iframe>");                                
	                    } else{
	                        alert("该员工不能再进行转入操作！");
	                         if(status1!=null&&status1!="")
	                         {
	                                   if(status1=="4"||status=="1")
			                            {
			                                  setTab001Syn ( 2 );
			                                  document.getElementById('bg').className='reserve_xixi2';
			                            }
			                            else if(status1=="5")
			                            {
			                                    document.getElementById("bg").className="reserve_xixi3";
			                                    setTab001Syn ( 3 );
			                            }
	                         }else
	                         {    
	                                 if(status=="4"||status=="1")
                                        {
                                              setTab001Syn ( 2 );
                                              document.getElementById('bg').className='reserve_xixi2';
                                        }
                                        else if(status=="5")
                                        {
                                                document.getElementById("bg").className="reserve_xixi3";
                                                setTab001Syn ( 3 );
                                        }
	                         }
	                    }
                
                break;

            case 2:
                document.getElementById("TabCon1").style.display="none";
                document.getElementById("TabCon2").style.display="block";
                document.getElementById("TabCon3").style.display="none";
                document.getElementById("font1").style.color="#000000";
                document.getElementById("font2").style.color="#FFFFFF";
                document.getElementById("font3").style.color="#000000";
                var status = document.getElementById("relation_status").value;
                var empstatus = document.getElementById("emp_status1").value;
                var status1 = document.all.form.status1.value;
                var rid =document.getElementById("rid").value;
                if(status== "1"||status=="4")
                {
                    jQuery("#TabCon1").empty();
                    jQuery("#TabCon2").empty();
                    jQuery("#TabCon3").empty();
                    jQuery("#TabCon2").append(" <iframe id = \"move_out\" name=\"move_out\"  src=\"<%=request.getContextPath()%>\/jsp/faerp/employeepost/eppartyrelation/move_out.jsp?rid="+rid+" \" scrolling=\"no\"  frameBorder=0 width=\"100%\" height=\"170px;\"><\/iframe>");
                }
                 else
                {
                              alert("该员工不能进行转出操作！");
                           
                }
                
                break;

            case 3:
                document.getElementById("TabCon1").style.display="none";
                document.getElementById("TabCon2").style.display="none";
                document.getElementById("TabCon3").style.display="block";
                document.getElementById("font1").style.color="#000000";
                document.getElementById("font2").style.color="#000000";
                document.getElementById("font3").style.color="#FFFFFF";
                var status = document.getElementById("relation_status").value;
                var empstatus = document.getElementById("emp_status1").value;
                var status1 = document.all.form.status1.value;
                var rid =document.getElementById("rid").value;
                       if(status== "1"||status1=="4")
		               {
                            jQuery("#TabCon1").empty();
		                    jQuery("#TabCon2").empty();
		                    jQuery("#TabCon3").empty();
		                    jQuery("#TabCon3").append(" <iframe id = \"move_ternal\" name=\"move_ternal\"  src=\"<%=request.getContextPath()%>\/jsp/faerp/employeepost/eppartyrelation/move_ternal.jsp?rid="+rid+"\" scrolling=\"no\"  frameBorder=0 width=\"90%\" height=\"170px;\"><\/iframe>");
		               }
		               else
		               {
		                      if(status1=="0")
		                      {
		                                alert("该员工不能进行内部转移！");
		                                setTab001Syn ( 1 );
		                                 document.getElementById("bg").className="reserve_xixi1";
                                        document.getElementById("TabCon1").style.display="block";
                                        document.getElementById("TabCon2").style.display="none";
                                        document.getElementById("TabCon3").style.display="none";
		                      }
                            else
                            {
                                 alert("该员工不能进行内部转移！");
                            }
                             if(status1=="3")
                            {
                                    alert("已经转出的员工不能进行内部转移！");
                                    document.getElementById("bg").className="reserve_xixi2";
                                    setTab001Syn ( 2 );
                            }
		               }

                break;
     
        }
    }
    function ClickRow(obj)
    {
                  document.getElementById("emp_id").value=obj;
                  jQuery.getJSON("<venus:base/>/EppartymemerAction.do?cmd=detail1&date="+new Date()+"",{"empid":obj},function(json){
                            
                    if(json!=null)
                    {
                        document.getElementById("in_date").value=json.bean.in_date;
                        document.getElementById("become_date").value=json.bean.become_date;
                        document.getElementById("relation_area0").value=json.bean.relation_area;
                        document.getElementById("rid").value=json.bean.rid;
                     
                        if(json.bean.relation_area!=null)
                        {
                            document.getElementById("relation_area").value=json.bean.relation_area;
                        }
                        if(json.bean.inside_position)
                        {
                               document.getElementById("inside_position").value=json.bean.inside_position;
                        }
                     
                        document.getElementById("is_secretary").value=json.bean.is_secretary;
                        if(json.bean.is_secretary=="0")
                        {
                                document.getElementById("is_secretary").checked = false;
                        }
                        else
                        {
                                document.getElementById("is_secretary").checked = true;
                        }
                        document.getElementById("is_over_sea_in").value=json.bean.is_over_sea_in;
                        if(json.bean.is_over_sea_in=="0")
                        {
                                document.getElementById("is_over_sea_in").checked = false;
                        }
                        else
                        {
                                document.getElementById("is_over_sea_in").checked = true;
                        }
                        document.getElementById("party_member_id").value=json.bean.party_memer_id;
                        document.getElementById("relation_status").value=json.bean.status;
                        document.getElementById("emp_status1").value=json.bean.emp_status;
                        document.getElementById("emp_post_id").value=json.bean.emp_post_id;
                        var status = json.bean.status;
                        if(status=="0")
                        {
                              document.getElementById('bg').className='reserve_xixi1';
                              setTab001Syn ( 1 );
                        }else if(status=="1"||status=="4")
                        {                
                           var status1= "";
                            status1=document.getElementById("status1").value;

                              if((status1!=""&&status1=="1")||(status1!=""&&status1=="4"))
                              {
	                              document.getElementById('bg').className='reserve_xixi2';
	                              setTab001Syn ( 2 );
                              }
                               else if(status=="1"&&status1=="5")
		                        {
		                               document.getElementById('bg').className='reserve_xixi3';
		                              setTab001Syn ( 3 );
		                        }
                        }
                     
                    }
                  });
          
    }
   
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio' name='checkbox_template' value=" + entity.getProperty("id") + "  onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
    function ClickRow1(id)
    {
    
    }
     function toFindCustomer(obj)
	 {
	     document.getElementById("query_cust_name").value=obj[1];
	 }
    function querydetail()
    {
        var selectitems = document.getElementsByName("checkbox_template");
        var selected=false;
        for(var i =0;i<selectitems.length;i++)
        {
            if(selectitems[i].checked)
            {
                selected=true;                
            }
        }
        
        if(selected)
        {
                var emp_id =  document.getElementById("emp_id").value;
		        var url="<%=request.getContextPath()%>/EppartyrelationAction.do?cmd=partyRecord&emp_id="+emp_id;
		        showModalCenter(url, window,"",650,300,"查看维护详情");
        }else
        {
            alert("请选择一名党员！");
            return;
        }
   
    }
</script>

</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/EppartyrelationAction.do">
<input type="hidden" name="cmd" value="queryByParty">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('党组织关系维护');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td/>
            <td/>
            <td/>   
            <td/>
        </tr>

        <tr>
            <td align="right">员工姓名</td>
            <td align="left">
                <input type="text" class="text_field" id="emp_name" name="emp_name" inputName="员工姓名" />
            </td>
            <td align="right">身份证</td>
            <td align="left">
                 <input type="text" class="text_field" id = "id_card" name="id_card" inputName="身份证" />
            </td>
            <td align="right">唯一号</td>
            <td align="left">
                 <input type="text" class="text_field" id="emp_code" name="emp_code" inputName="唯一号" />
            </td>
        </tr>
        
        <tr>
            <td align="right">公司名称</td>
            <td align="left">
             <input type="hidden" name="query_cust_name" id ="query_cust_name" />
             <w:lookup onReturnFunc="toFindCustomer" readonly="true" id="cust_name"   name="cust_name" lookupUrl="/jsp/faerp/common/sales/allCustomer1.jsp"  dialogTitle="选择客户" height="450" width="800" style="width:188px"/>
            </td>
            <td align="right">性别</td>
            <td align="left">
          <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_sex", -1,"EMP_SEX", "", "", false) %>
            </td>
             <td align="right">所属支部</td>
            <td align="left">
             <r:comboSelect id="partyCode" name="partyCode"  queryAction="/FAERP/EppartycomponentAction.do?cmd=getPartyCode"
                       textField="party_name" valueField="id" xpath="EppartycomponentVo" width="200px" nullText="请选择" />
            </td>
        </tr>
        <tr>
            <td align="right">维护类型</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("status1", -1,"RELATION_STATUS_BD", "", "id='status1'", false) %>
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
            <td align="left">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             <input type="reset" class="icon_1"  />
            </td>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="e">      <a  onClick="javascript:exportExcel_onClick();"><fmt:message key="export"/> </a> </li>
                    <li class="p_1">    <a  onClick="javascript:querydetail();">查看维护详细</a> </li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
 <div style="padding: 8 5 8 8;">
 <r:datacell 
        id="datacell1"
       queryAction="/FAERP/EppartyrelationAction.do?cmd=simpleQuery2"
        width="98%"
        height="302px"
        xpath="PartyRelationEmployeeVo"
        submitXpath="PartyRelationEmployeeVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="cid"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       <r:field fieldName="emp_name" width="178px" label="员工姓名">
       </r:field>    
       <r:field fieldName="emp_sex" width="50px" label="性别" >
       </r:field>    
      <r:field fieldName="id_card" width="150px" label=" 身份证" >
       </r:field>    
       <r:field fieldName="emp_code" width="80px" label="唯一号" >
       </r:field>    
       <r:field fieldName="cust_name" width="237px" label="公司名称" >
       </r:field>   
       <r:field fieldName="emp_status" width="100px" label="在职状态" >
       </r:field>   
       <r:field fieldName="au_name" width="100px" label="客服" >
       </r:field> 
       <r:field fieldName="party_component_id" width="200px" label="党支部" >
       </r:field>   
    </r:datacell>
</div>
 
 

</div>

    
</div>
 <div class="reserve_tab">
        <div id="bg" class="reserve_xixi1">
            <div id="font1" class="reserve_tab1" onMouseDown="setTab001Syn(1);">转入   </div>
            <div id="font2" class="reserve_tab2" onMouseDown="setTab001Syn(2);">转出</div>
            <div id="font3" class="reserve_tab3" onMouseDown="setTab001Syn(3);">内部转移</div>
        </div>
    </div>
    <input type="hidden" name = "moveid" id="moveid"/>
     <input type="hidden" name="rid" id ="rid"/>
    <input type="hidden" name="relationship_to0" id ="relationship_to0"/>
    <input type="hidden" name="party_memer_id" id="party_memer_id"/>
    <input type="hidden" name="emp_id" id="emp_id"/>
    <input type="hidden" name="relation_area0" id="relation_area0"/>
    <input type="hidden" name="relation_status" id="relation_status"/>
    <input type="hidden" name="party_member_id" id="party_member_id"/>
    <input type="hidden" name="emp_status1" id="emp_status1"/>
    <input type="hidden" name ="emp_post_id" id ="emp_post_id"/>
    <div id="ccChild1"     class="box_xinzeng"> 
    <div id="TabCon1" style="font-size: 12"> 

    </div>
    <div id="TabCon2" style="font-size: 12">

    </div>
    <div id="TabCon3" style="font-size: 12">

    </div>
    <div class="xz_title">党员资料</div>
 <div class="ringht_s">
 <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="font-size: 12">
        <tr>
            <td class="td_1" >入党时间</td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="in_date" id="in_date" inputName="转入日期" style="width: 205px;" readonly="readonly"/>
            </td>
            <td  class="td_1" >转正时间</td>
            <td class="td_2" >
             <input type="text" class="text_field_reference_readonly" name="become_date" id="become_date" inputName="转入日期" style="width: 205px;" readonly="readonly"/>
        </tr>
        <tr>
            <td class="td_1" >原组织关系 所在(支部)</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id ="relation_area" name="relation_area" inputName="原组织关系 所在(支部)" value=""readonly="readonly"/>
            </td>
            <td class="td_1" >党内职务</td>
            <td class="td_2" >
                <input type="text" class="text_field" id="inside_position" name="inside_position" inputName="党内职务" value="" readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >是否党支部书记</td>
            <td class="td_2 ">
                 <input type='checkbox'  id="is_secretary" name="is_secretary"  value="0" pdType='control' control='checkbox_template' disabled="disabled"  />
                
            </td>
            <td class="td_1" >是否海外留学或工作</td>
            <td class="td_2 ">
                 <input type='checkbox'  id="is_over_sea_in" name="is_over_sea_in"  value="0" pdType='control' control='checkbox_template'  disabled="disabled" />
            </td>
        </tr>
  
        
    </table>
 </div>
 </div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
    <% //表单回写
    if(request.getAttribute(IEppartyrelationConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEppartyrelationConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>

</body>
</html>
