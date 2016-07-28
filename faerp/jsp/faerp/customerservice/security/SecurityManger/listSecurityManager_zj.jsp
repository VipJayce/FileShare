<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>


<html>
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
		var ids = findSelections("checkbox_template","cust_id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	  // form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/settlementclaim/insertSettlementclaim.jsp?id="+ids;
      //  form.submit();
	}  

	function simpleQuery_onClick(){  //简单的模糊查询

       //$id("datacell").addParam("query_security_group_id",$id("query_security_group_id").value); 
       //$id("datacell").addParam("cs_social_unit_id",$name("social_unit_id").value); 
       //$id("datacell").addParam("query_cust_code",$id("query_cust_code").value); 
       //$id("datacell").addParam("query_cust_name",$id("query_cust_name").value); 
       //$id("datacell").addParam("query_name",$id("query_name").getValue()); 
       var security_group_id=$id("query_security_group_id").getValue();
       if(security_group_id==null || security_group_id==''){
        alert('请选择社保公积金组！');
        return;
       }
       $id("datacell").loadData();
       $id("datacell").refresh();
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
		form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio' value='"+ value+"' name='checkbox_template' >";
    }
   function checkAll(){
   var element = document.getElementsByTagName("input");
   for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
               element[i].checked= !element[i].checked ? true : false;
           }
   } 
 }

//取得选中行
    function checkSelections() {  
        var dc = $id("datacell");
	    var enCur = dc.getActiveEntity();
	    if(enCur){
            var ids = null;
            if(ids == null) {
                ids = new Array(0);
            }
            ids.push(enCur.getProperty("group_name"));  //加入选中的checkbox
            ids.push(enCur.getProperty("hire_unit_short_name"));
            ids.push(enCur.getProperty("customer_name"));
            ids.push(enCur.getProperty("customer_code"));
            ids.push(enCur.getProperty("cust_id"));
            return ids;
        }
        return null;
    }
function toAdd_onClick()
{
   var ids = checkSelections();
    
   if(ids==null){
       alert("请先选择一条记录");
       return ;
   }
    var datacell = $id("datacell");
    var activeRow = datacell.activeRow;
    var enCurEntity = datacell.getEntity(activeRow);//得到当前操作的行dataset
    var security_group_id=enCurEntity.getProperty('security_group_id');
    var social_unit_id = enCurEntity.getProperty('social_unit_id');
   var report_month = enCurEntity.getProperty('report_month');
   if(report_month==null || report_month=="null" || report_month=="undefined"){
       report_month = "";
   }
   var selectedEnt = $id("city_idList_search").getSelectEntity();
   var city_id= selectedEnt.getProperty("id");

   var customer_name  =ids[2]=="无客户名称"?"":ids[2];
   var customer_code = ids[3]=="无客户编号"?"":ids[3];
   var  url = "<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity_zj/listTransactionHousingEmpsecurity.jsp?city_id="+city_id+"&security_group_id="+security_group_id+"&report_month="+report_month+"&social_unit_id="+social_unit_id+"&customer_name="+encodeURIComponent(customer_name)+"&customer_code="+customer_code+"&isQuery=true";
  window.open(url,'','height=600px,width=1200px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金办理');
    //showModalCenter(url, window,"",1200,600,"公积金办理");
}
function toStopAdd_onClick()
{
   var ids = checkSelections();
   if(ids==null){
       alert("请先选择一条记录");
       return ;
   }
    var datacell = $id("datacell");
    var activeRow = datacell.activeRow;
    var enCurEntity = datacell.getEntity(activeRow);//得到当前操作的行dataset
    var security_group_id=enCurEntity.getProperty('security_group_id');
    var social_unit_id = enCurEntity.getProperty('social_unit_id');
   var report_month = enCurEntity.getProperty('report_month');
   if(report_month==null || report_month=="null" || report_month=="undefined"){
       report_month = "";
   }
   var selectedEnt = $id("city_idList_search").getSelectEntity();
   var city_id= selectedEnt.getProperty("id");
   
   var customer_name  =ids[2]=="无客户名称"?"":ids[2];
   var customer_code = ids[3]=="无客户编号"?"":ids[3];
   var  url = "<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity_zj/listStopHousingEmpsecurity.jsp?city_id="+city_id+"&security_group_id="+security_group_id+"&report_month="+report_month+"&social_unit_id="+social_unit_id+"&customer_name="+encodeURIComponent(customer_name)+"&customer_code="+customer_code+"&isQuery=true";
    window.open(url,'','height=600px,width=1200px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金停办');
    //showModalCenter(url, window,"",1050,600,"公积金停办");
}
function toReport_onClick()
{
    var ids = checkSelections();
    if(ids==null){
       alert("请先选择一条记录");
       return ;
   }
    var datacell = $id("datacell");
    var activeRow = datacell.activeRow;
    var enCurEntity = datacell.getEntity(activeRow);//得到当前操作的行dataset
    var security_group_id=enCurEntity.getProperty('security_group_id');
    var social_unit_id = enCurEntity.getProperty('social_unit_id');
    var report_month = enCurEntity.getProperty('report_month');
   if(report_month==null || report_month=="null" || report_month=="undefined"){
       report_month = "";
   }
   var selectedEnt = $id("city_idList_search").getSelectEntity();
   var city_id= selectedEnt.getProperty("id");
   
   var customer_name  =ids[2]=="无客户名称"?"":ids[2];
   var cust_id = ids[4]==""?"":ids[4];
   var  url = "<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity_zj/listSocialSecurityStatementsGongJin.jsp?city_id="+city_id+"&security_group_id="+security_group_id+"&report_month="+report_month+"&social_unit_id="+social_unit_id+"&customer_name="+encodeURIComponent(customer_name)+"&cust_id="+cust_id+"&isQuery=true";
   window.open(url,'','height=600px,width=1200px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金报表');
   //showModalCenter(url, window,"",1050,400,"公积金报表");
}
function toPay_onClick()
{

  var ids = checkSelections();
  if(ids==null){
       alert("请先选择一条记录");
       return ;
   }
    var datacell = $id("datacell");
    var activeRow = datacell.activeRow;
    var enCurEntity = datacell.getEntity(activeRow);//得到当前操作的行dataset
    var security_group_id=enCurEntity.getProperty('security_group_id');
    var social_unit_id = enCurEntity.getProperty('social_unit_id');
    var report_month = enCurEntity.getProperty('report_month');
   if(report_month==null || report_month=="null" || report_month=="undefined"){
       report_month = "";
   }
   var selectedEnt = $id("city_idList_search").getSelectEntity();
   var city_id= selectedEnt.getProperty("id");
   var customer_name  =ids[2]=="无客户名称"?"":ids[2];
   var customer_code = ids[3]=="无客户编号"?"":ids[3];
   var cust_id = ids[4]==""?"":ids[4];
   if(social_unit_id==null || social_unit_id=="" ){
    alert("没有客户或福利办理方无法支付");
    return;
   }
  var  url= "<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity_zj/listSecurityPay.jsp?city_id="+city_id+"&security_group_id="+security_group_id+"&report_month="+report_month+"&social_unit_id="+social_unit_id+"&customer_name="+encodeURIComponent(customer_name)+"&customer_code="+customer_code+"&isQuery=true&security_type=2&group_type=2&cust_id="+cust_id;
   window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金支付');
   //showModalCenter(url, window,"",1050,400,"公积金支付");
}
function chanage()
{
    alert(document.getElementById("query_security_group_id").selectedIndex);
}
</script>
</head>
<body>

<form id="datacell_formid" name="form" method="post" >

<div id="right">
<script language="javascript">
	writeTableTopFesco('公积金管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
		<tr>
		
		
		 <td align="right" >
                 <p><font color="red">*</font>城市</p>
            </td>
            <td align="left">
                 <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="205px"
                       value="1099110100000000357"
                       nullText="请选择"
                       />
            </td>
          
              <td align="right"><font color="red">*</font>公积金组</td>
              <td align="left">
                     <r:comboSelect id="query_security_group_id" name="query_security_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=2"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="205px"
                       linkId="city_idList_search"
                       value="1099110700000000203"
                       nullText="请选择" />
              </td>
		
			
		    <td align="right">福利办理方</td>
            <td align="left">
                <r:comboSelect id="com2"  name="social_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                nullText="--请选择--"
                width="185px">
            </r:comboSelect> 
            </td>
            
		</tr>
        <tr>
        <td align="right">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" id="query_cust_code" name="query_cust_code" inputName="客户编号" maxLength="50"/>
            </td>
            <td align="right">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" id="query_cust_name" name="query_cust_name" inputName="客户名称" maxLength="64" style="width: 185px;"/>
            </td>
            <td align="right">客服</td><!-- siqp添加接单客服 -->
            <td align="left">
              <r:comboSelect id="query_name" name="query_name"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="185" nullText="--请选择--"
                >
                <!-- 客服下拉注释 onChangeFunc="pushSelectName" -->
            </r:comboSelect>
            </td>
        </tr>
            <tr>
            <td />
           <td />
            <td />
             <td />
              <td />
              <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
					<li class="bl">  	<a onClick="javascript:toAdd_onClick();">办理 </a></li>
					<li class="tb">  	<a  onClick="javascript:toStopAdd_onClick();">停办</a> </li>
					<li class="bb">  	<a  onClick="javascript:toReport_onClick();">报表</a> </li>
					<li class="zf">     <a  onClick="javascript:toPay_onClick();">支付</a> </li>
				</ul>
		 -->
		 <input class="bl" type="button"   value=" 办理"  <au:authorityBtn code="gjjgl_bl" type="1"/>  onClick="toAdd_onClick();">
         <input class="tb" type="button"   value=" 停办"  <au:authorityBtn code="gjjgl_tb" type="1"/>  onClick="toStopAdd_onClick();">
         <input class="bb" type="button"   value=" 报表"  <au:authorityBtn code="gjjgl_bb" type="1"/>  onClick="toReport_onClick();">
         <input class="zf" type="button"   value=" 支付"  <au:authorityBtn code="gjjgl_zf" type="1"/>  onClick="toPay_onClick();">
		 </div>
           <div class="clear"></div>			
</div>
        <r:datacell 
        id="datacell"
       queryAction="/FAERP/SecurityManagerAction.do?cmd=queryAll"
       isCount="false"
        width="100%"
        xpath="SecurityManagerVo"
        height="319"
        submitXpath="SecurityManagerVo"
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        
        <r:field fieldName="group_name" width="100px" label="公积金组">
       </r:field> 
       <r:field fieldName="hire_unit_short_name" width="150px"  label="福利办理方">
       </r:field>
       <r:field fieldName="customer_code" width="100px" label="客户编号">
       </r:field> 
       <r:field fieldName="customer_name" width="150px" label="客户名称">
       </r:field> 
       <r:field fieldName="user_name" width="100px" label="客服">
       </r:field> 
       <r:field fieldName="report_month" width="100px" label="报表月">
        <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
       </r:field>
        <r:field fieldName="is_fesco_pay" width="120px" label="是否由Fesco支付">
       </r:field> 
       <r:field fieldName="open_unit" width="150px" label="帐号">
       </r:field> 
       <r:field fieldName="open_unit" width="200px" label="开户帐号">
       </r:field> 
       <r:field fieldName="open_unit_accounts" width="200px" label="开户单位">
       </r:field> 
      <r:field fieldName="end_date" width="100px" label="办理截止日">
       </r:field> 
        <r:field fieldName="get_day" width="100px" label="应进帐日">
       </r:field> 
       <r:field fieldName="seal_party" width="100px" label="盖章方">
       </r:field> 
       
       <r:field fieldName="remarks" width="100px" label="备注">
       </r:field> 
    </r:datacell>

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<script type="text/javascript">
jQuery(function(){
    $id("datacell").isQueryFirst = false;
    });
</script>
