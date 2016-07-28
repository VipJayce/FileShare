<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.laborcontract.vo.LaborcontractVo" %>
<%@ page import="rayoo.customerservice.laborcontract.util.ILaborcontractConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ILaborcontractConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ILaborcontractConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    LaborcontractVo resultVo = null;  //定义一个临时的vo变量
    Map map = request.getAttribute("map") == null?new HashMap():(Map)request.getAttribute("map");
    //从首页跳转过来的标志flag
    String flag=request.getParameter("flag")==null?"false":request.getParameter("flag");
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.laborcontract.listLaborcontract_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript" src="<venus:base/>/jsp/faerp/customerservice/laborcontract/listLaborcontract.js"></script>
<script language="javascript">
    function execl_onClick(){  //<fmt:message key='listLaborcontract0038'/>Excel
         var emp_name = $id("emp_name").value ;// 员工名称 
        var emp_code = $id("emp_code").value ;//员工唯一号
        var id_card = $id("id_card").value ;//身份证
        var cust_code = $id("cust_code").value ;//客户编号
        var cust_name = $id("cust_name").value ;//客户名称
        var renew_status = $id("renew_status").value ;
        var last_update_date_from = $id("last_update_date_from").value ;
        var last_update_date_to = $id("last_update_date_to").value ;
        var availability = $id("availability").value ;//合同有效性
        var labor_status_bd = $id("labor_status_bd").value ;//签署状态
        var labor_type_bd = $id("labor_type_bd").value ;//合同类型
        var post_status_bd = $id("post_status_bd").value ;//入离职状态
        var emp_post_type_bd = $id("emp_post_type_bd").value ;//合同类型
         var cust_level_bd = $id("cust_level_bd").value ;//是否入职E化
         var contractmail_type_search = $id("contractmail_type_search").value ; //合同处理类型
        var contractmail_bd = $id("contractmail_bd").value ;  //合同邮寄状态
        var user_id = $id("combo_cs").value ;
        var send_end_date_to = $id("send_end_date_to").value ;//派遣截止日
         $id("expot_execl").disabled ="disabled" ;
         jQuery.ajax({
                     url: '<%=request.getContextPath()%>/LaborcontractAction.do?cmd=exportExcelGetCount',
                     data: {emp_name:emp_name,emp_code:emp_code,id_card:id_card,cust_code:cust_code,cust_name:cust_name,
                                last_update_date_from:last_update_date_from,last_update_date_to:last_update_date_to,availability:availability,labor_status_bd:labor_status_bd,
                                labor_type_bd:labor_type_bd,post_status_bd:post_status_bd,emp_post_type_bd:emp_post_type_bd,cust_level_bd:cust_level_bd,
                                contractmail_type_search:contractmail_type_search,contractmail_bd:contractmail_bd,user_id:user_id,send_end_date_to:send_end_date_to},
                     type: 'POST',
                     dataType: 'html',
                     async: false,
                     error: function(){
                         alert('Error loading XML document');
                         return  null;
                     },
                     success: function(data){
                         if(data!=null){       
                            if(data=="1"){
                               alert("导出数据超出范围,请导出少于65536条的数据!");
                               $id("expot_execl").disabled ="" ;
                            }else if (data=="2"){
                                alert("没有对应的数据导出,请重新调整导出条件!");
                                $id("expot_execl").disabled ="" ;
                            }else{
                            	var param = jQuery("#datacell_formid").serialize();
                            	form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=exportExcel&"+param;
               					form.submit();
                                $id("expot_execl").disabled ="" ;
                            }
                         }
                     }
                 }); 
    }  
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/LaborcontractAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true"> 
<input type="hidden" name="flag" id="flag" value="<%=flag %>">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key='listLaborcontract0006'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="125px" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listLaborcontract0007'/></div> </td>
           </tr>
           
           <tr>
            <td align="left"><fmt:message key='listLaborcontract0008'/></td>
            <td align="left">
                <input type="text" class="text_field" id="emp_name" name="emp_name" inputName="<fmt:message key='listLaborcontract0009'/>" value="" maxLength="50"/>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0010'/></td>
            <td align="left">
                <input type="text" class="text_field" id="emp_code" name="emp_code" inputName="<fmt:message key='listLaborcontract0010'/>" value="" maxLength="64"/>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0050'/></td>
            <td align="left">
                <input type="text" class="text_field" id="id_card" name="id_card" inputName="<fmt:message key='listLaborcontract0050'/>" value="" maxLength="50"/>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborcontract0014'/></td>
            <td align="left">
                <input type="text" class="text_field" id="cust_code" name="cust_code" inputName="<fmt:message key='listLaborcontract0014'/>" value="" maxLength="64"/>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0016'/></td>
            <td align="left">
                <input type="text" class="text_field" id="cust_name" name="cust_name" inputName="<fmt:message key='listLaborcontract0017'/>" value="" maxLength="50"/>
            </td>
            <td align="left">续签状态</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("renew_status", -1,"RENEW_STATUS","","id=renew_status",false) %>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborcontract0020'/></td>
            <td align="left">
                <w:date allowInput="true" id="last_update_date_from" name="last_update_date_from" format="yyyy-MM-dd" style="width:75px;"/>
                &nbsp;<fmt:message key='listLaborcontract0019'/>&nbsp;
                <w:date allowInput="true" id="last_update_date_to" name="last_update_date_to" format="yyyy-MM-dd" style="width:75px;"/>               
            </td>
            <td align="left">合同有效性</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("availability", -1,"AVAILABILITY","","id=availability",false) %>
                <!-- <w:date allowInput="true" id="start_date_from" name="start_date_from" format="yyyy-MM-dd" style="width:75px;"/>
                &nbsp;<fmt:message key='listLaborcontract0019'/>&nbsp;
                <w:date allowInput="true" id="start_date_to" name="start_date_to" format="yyyy-MM-dd" style="width:75px;"/>          -->      
            </td>
           <td align="left"><fmt:message key='listLaborcontract0031'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_post_type_bd", -1,"EMP_POST_TYPE_BD",""," id=emp_post_type_bd",false) %>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborcontract0028'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("labor_status_bd", -1,"LABOR_STATUS_BD","","id=labor_status_bd",false) %>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0029'/></td>
            <td align="left">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("labor_type_bd", -1,"LABOR_TYPE_BD",""," id=labor_type_bd",false) %>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0030'/></td>
            <td align="left">
            <select  id="post_status_bd" name="post_status_bd">
            <option value="0">--请选择--</option><!-- 0代表请选择，1对应在职，2对应离职，具体对应条件在后台对照 -->
            <option value="1">在职</option>
            <option value="2">离职</option>
            </select>
            </td>
        </tr>
        <tr>
            <td align="left">是否入职E化</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("cust_level_bd", -1,"CUST_LEVEL_BD","","id=cust_level_bd",false) %>
            </td>
            <td align="left">合同处理类型</td>
            <td align="left">
                  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contractmail_type_search",-1,"CONTRACTMAIL_TYPE", "", "id='contractmail_type_search'", false) %>
            </td>
            <td align="left">合同邮寄状态</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contractmail_bd",-1,"CONTRACTMAIL_BD", "", "id='contractmail_bd'", false) %>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborcontract0032'/></td>
            <td align="left">
                <r:comboSelect id="combo_cs" name="user_id" queryAction="CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                 textField="name" valueField="partyId" xpath="CustServiceVo" width="200px" nullText="" />
            </td>
            <td align="left">派遣截止期</td>
            <td align="left">
                <w:date allowInput="true" id="send_end_date_to" name="send_end_date_to" format="yyyy-MM-dd"  style="width:185px;"/>
            </td>
            <td align="left" colspan="2">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="listLaborcontract0173"/>' onClick="javascript:simpleQuery_onClick()">
            <input type="reset" class="icon_1"   type="button" value="<fmt:message key='listLaborcontract0034'/>" >
            </td>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="g">    <a  onClick="javascript:submit_onClick();"><fmt:message key='listLaborcontract0035'/></a> </li>
                    <li class="bl">   <a  onClick="javascript:torenew_onClick();"><fmt:message key='listLaborcontract0036'/></a></li>
                    <li class="a_2"><a  onClick="javascript:info_onClick();"><fmt:message key='listLaborcontract0037'/> </a> </li>
                    <li class="e">    <a  onClick="javascript:execl_onClick();"><fmt:message key='listLaborcontract0038'/></a> </li>
                </ul>
         -->
         <input class="g" type="button"   value="<fmt:message key='listLaborcontract0035'/>"  <au:authorityBtn code="ldhtgl_tj" type="1"/>  onClick="submit_onClick();">
          <input class="bl" type="button"   value="<fmt:message key='listLaborcontract0036'/>"  <au:authorityBtn code="ldhtgl_xq" type="1"/>  onClick="torenew_onClick();">
           <input class="a_2" type="button"   value="<fmt:message key='listLaborcontract0037'/>"  <au:authorityBtn code="view_orderItem7" type="1"/>  onClick="info_onClick();">
            <input class="e" type="button" id="expot_execl" name="expot_execl"   value="<fmt:message key='listLaborcontract0038'/>"  <au:authorityBtn code="ldhtgl_exp" type="1"/>  onClick="execl_onClick();">
            <%if(flag.equals("true")){ %>
                    <input class="m_1" type="button"   value="<fmt:message key='listLaborcontract0043'/>"  onClick="back_to();">
                    <input class="approdetial" type="button"   value="<fmt:message key='listLaborcontract0044'/>"  onClick="tonotNeedRemind_onClick();">
                    <%} %> 
         </div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/LaborcontractAction.do?cmd=queryLaborData" 
    submitAction="/FAERP/LaborcontractAction.do?cmd=Save" width="98%" height="320px" xpath="LaborcontractVo" 
    paramFormId="datacell_formid" pageSize="100">
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <!--<r:field fieldName="id" messagekey='listLaborcontract0045' 
    label="<fmt:message key='listLaborcontract0045'/><input type='checkbox' name='checkall' onclick='emp_onClick(this);' />"
     width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>-->
     <r:field allowModify="false" fieldName="id"
            label="<fmt:message key='listLaborcontract0045'/><input type='checkbox' name='checkall' onclick='checkAll(this)' />"
            onRefreshFunc="setCheckboxStatus"
            sortAt="none" width="50px">
        </r:field>
    <!--<r:field allowModify="false" fieldName="chk"
            label="<fmt:message key='listLaborcontract0045'/><input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            onRefreshFunc="setCheckboxStatus"
            sortAt="none" width="50px">
            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
                uncheckedValue="0" onclick="checkRow();" />
        </r:field>-->
  
  <!-- <r:field fieldName="chk" messagekey="listLaborcontract0045" width="50px" onRefreshFunc="setCheckboxStatus" align="center">  
       </r:field>    -->
    <r:field fieldName="emp_post_id" messagekey='listLaborcontract0047' width="0px;"></r:field>
    <r:field fieldName="emp_name" messagekey='listLaborcontract0009' width="60"></r:field>   
    <r:field fieldName="emp_code" messagekey='listLaborcontract0049'></r:field>
    <r:field fieldName="id_card" messagekey='listLaborcontract0050'></r:field>
    <r:field fieldName="emp_post_type_bd" messagekey='listLaborcontract0031' allowModify="false" width="60">
        <d:select dictTypeId="EMP_POST_TYPE_BD"></d:select>
    </r:field>
    <r:field fieldName="post_status_bd"  label="入离职状态" allowModify="false" width="80">
    <d:select  dictTypeId="POST_STATUS_BD"></d:select>
    </r:field>
    <r:field fieldName="availability" label="合同有效性"  width="80">
     <d:select dictTypeId="AVAILABILITY"  disabled="true"></d:select>
    </r:field>
    <r:field fieldName="cust_name" messagekey='listLaborcontract0052'></r:field>
    <r:field fieldName="user_name" messagekey='listLaborcontract0032'  width="60"></r:field>
    <r:field fieldName="dept_name" label="客服部门"></r:field>
    <r:field fieldName="salary" messagekey='listLaborcontract0054'  width="60" >
        <h:text name="salary" value="" onblur="batch_blue('salary');"/>
    </r:field>
    <r:field fieldName="contract_properties" messagekey='listLaborcontract0175'  width="60">
        <d:select dictTypeId="CONTRACT_PROPERTIES"></d:select>
    </r:field>
    
    <r:field fieldName="labor_status_bd" messagekey='listLaborcontract0028'  width="60">
        <!--<d:select dictTypeId="LABOR_STATUS_BD" onchange="btach_change(this,9,'labor_status_bd');"></d:select>-->
        <d:select dictTypeId="LABOR_STATUS_BD" onchange="changeCheckStates(this,9,'labor_status_bd');"></d:select>
    </r:field>
    <r:field fieldName="subscribe_date" messagekey='listLaborcontract0057'>
        <w:date allowInput="true" id="subscribe_date" name="subscribe_date" format="yyyy-MM-dd" onSelectFunc ="subscribe_date"/>
    </r:field>
    <r:field fieldName="welfare_address" messagekey='listLaborcontract0058'  width="80">
       <h:text name="welfare_address" value="" onblur="batch_blue('welfare_address');"/>
    </r:field>
    <r:field fieldName="position" messagekey='listLaborcontract0059'  width="60">
        <h:text name="position" value="" onblur="batch_blue('position');"/>
    </r:field>
    <r:field fieldName="working_bd" messagekey='listLaborcontract0060'  width="60">
        <d:select dictTypeId="WORKING_BD" onchange="btach_change(this,13,'working_bd');"></d:select>
    </r:field>
     <r:field fieldName="fixed_term" label="合同期限">
     <d:select dictTypeId="FIXED_TERM"></d:select>
    </r:field>
    <r:field fieldName="send_start_date" messagekey='listLaborcontract0018'>
         <w:date allowInput="true" id="send_start_date" name="send_start_date" format="yyyy-MM-dd" onSelectFunc="send_start_date"/>
    </r:field>
    <r:field fieldName="send_end_date" messagekey='listLaborcontract0062'>
         <w:date allowInput="true" id="send_end_date" name="send_end_date" format="yyyy-MM-dd" onSelectFunc="send_end_date"/>
    </r:field>
    <r:field fieldName="start_date" messagekey='listLaborcontract0022'>
         <w:date allowInput="true" id="start_date" name="start_date" format="yyyy-MM-dd" onSelectFunc="start_date"/>
    </r:field>
    <r:field fieldName="end_date" messagekey='listLaborcontract0064'>
         <w:date allowInput="true" id="end_date" name="end_date" format="yyyy-MM-dd" onSelectFunc="end_date"/>
    </r:field>
    <r:field fieldName="try_start_date" messagekey='listLaborcontract0065'>
         <w:date allowInput="true" id="try_start_date" name="try_start_date" format="YYYY-MM-DD" onSelectFunc="try_start_date"/>
    </r:field>
    <r:field fieldName="try_end_date" messagekey='listLaborcontract0066'>
         <w:date allowInput="true" id="try_end_date" name="try_end_date" format="yyyy-MM-dd" onSelectFunc="try_end_date"/>
    </r:field>
    <r:field fieldName="try_salary" messagekey='listLaborcontract0026'  width="60">
        <h:text name="try_salary" value="" onblur="batch_blue('try_salary');"/>
    </r:field>
    <r:field fieldName="labor_type_bd" messagekey='listLaborcontract0029' allowModify="false"  width="60">
        <d:select dictTypeId="LABOR_TYPE_BD" onchange="btach_change(this,21,'labor_type_bd');"></d:select>
    </r:field>
    <r:field fieldName="last_update_user_name" label="操作人" allowModify="false">
        <h:text name="last_update_user_name" value=""/>
    </r:field>
    <r:field fieldName="last_update_date" messagekey='listLaborcontract0020' allowModify="false">
         <w:date allowInput="true" id="last_update_date" name="last_update_date" format="yyyy-MM-dd" onblur="batch_blue('last_update_date');"/>
    </r:field>
    <r:field fieldName="remark" messagekey='listLaborcontract0071'>
        <h:text name="remark" value="" onblur="batch_blue('remark');"/>
    </r:field>
    
    <r:field fieldName="contractmail_type" label="合同处理类型">
    <d:select dictTypeId="CONTRACTMAIL_TYPE"></d:select>
    </r:field>
    <r:field fieldName="contractmail_status_bd_name" label="邮寄状态"  width="60">
    <d:select dictTypeId="CONTRACTMAIL_BD"></d:select>
    </r:field>
    <r:field fieldName="post_no" label='寄出单号'  width="60">
        <h:text name="post_no" value=""/>
    </r:field>
    <r:field fieldName="return_no" label='返还单号'  width="60">
        <h:text name="return_no" value=""/>
    </r:field>
    <r:field fieldName="address" label="联系地址" width="250">
    	<h:text name="address" value=""/>
    </r:field>
    
    <r:field fieldName="renew_status" label="续签状态"  width="60">
     <d:select dictTypeId="RENEW_STATUS" disabled="true"></d:select>
    </r:field>
    <r:field fieldName="is_fixed_term" label="自动延续状态">
    <d:select dictTypeId="IS_FIXED_TERM"></d:select>
    </r:field>
    <r:field fieldName="continuation_years" label="自动延续年数">
     <d:select dictTypeId="CONTINUATION_YEARS"></d:select>
    </r:field>
 </r:datacell>
</div> 
 
 
</div>
</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
    
        //<fmt:message key='listSecurityUpdate0032'/>列表，点击全选按钮
    function emp_onClick(obj){
        var datacell = $id("emppostback_init");
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
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       var emp_post_id = entity.getProperty("emp_post_id");
       return "<input type='checkbox'  name='temp' id='temp_"+rowNo+"' value=\"" + emp_post_id + "\">";
    }
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(ILaborcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ILaborcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
$id("datacell1").beforeRefreshCell = function(cell,field){
        if(field && field.fieldId && field.fieldId.indexOf("id") >= 0){
            return false;
        }
        return true;
    } 
//初始化不加载页面信息<siqp<fmt:message key='listLaborcontract0074'/>>
var temp=<%=flag%>;
jQuery(function(){
	if(!temp){
	    $id("datacell1").isQueryFirst = false;
	}else{
	   _$("#labor_status_bd").val("2");
	}
});

function selectIds() {
    var myids = new Array(0);
    var dc = $id("datacell1");
    var ds = dc.dataset;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            myids.push(entity.getValue("id"));
        }
    });
    return myids;
}

    //魏佳新增方法，用于在变更签署状态时，批量变更所有前面的勾选项中已勾选的记录的相应签署状态。
    function changeCheckStates(obj,num,name){
        var ids = selectIds();//获取所有选中行的id
        var dc = $id("datacell1");//获取datacell对象
	    _$("input[type='checkbox']").each(function(i) {
	        //第0个为全选按钮
	        if (i != 0 && _$(this).attr("checked")) {
	            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	            var entity = dc.getEntity(row);
	            if(ids.indexOf(entity.getValue("id")) >=0){
	               dc.selectRow(row);//只有选中改行后才可以对该行的数据进行赋值操作
                   entity.setProperty(name,obj.value);//设置状态
	            }
	        }
	    });
    }
</script>   
