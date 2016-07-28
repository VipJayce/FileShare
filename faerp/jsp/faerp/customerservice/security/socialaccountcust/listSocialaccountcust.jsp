<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.socialaccountcust.vo.SocialaccountcustVo" %>
<%@ page import="rayoo.customerservice.security.socialaccountcust.util.ISocialaccountcustConstants" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ISocialaccountcustConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ISocialaccountcustConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    SocialaccountcustVo resultVo = null;  //定义一个临时的vo变量
    String social_group_id=request.getParameter("social_group_id")==null? "" : request.getParameter("social_group_id").toString();
    String customer_code=request.getParameter("customer_code")==null? "" : request.getParameter("customer_code").toString();
    String customer_name=request.getParameter("customer_name")==null? "" : request.getParameter("customer_name").toString();
    String group_type = request.getAttribute("group_type")==null?"":request.getAttribute("group_type").toString();
    String security_type = request.getAttribute("security_type")==null?"":request.getAttribute("security_type").toString();
    
%>
<html>
<fmt:bundle basename="rayoo.customerservice.security.socialaccountcust.socialaccountcust_resource" prefix="rayoo.customerservice.security.socialaccountcust.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
var vpath = "<%=request.getContextPath()%>";
function citySecurityGroupchange(seletvalue){
    //alert(seletvalue);
    var group_type = '<%=group_type%>';
      SecurityGroupAjax.getCitySecurityGroup1(seletvalue,group_type,{callback:function(data){
                    setSelectForBean("social_group_id",data,"id","group_name","");
                    if(<%=!"".equals(social_group_id)%>){
                        document.getElementById("social_group_id").value="<%=social_group_id%>";
                    }
                    //
                }
            });
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
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    function findCheckbox_onClick() {  //从多选框到修改页面
        var group_type= document.getElementById('group_type').value;
        var security_type= document.getElementById('security_type').value;
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/SocialaccountcustAction.do?id=" + ids+"&cmd=find&group_type="+group_type+"&security_type="+security_type;;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=500px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改客户账号');
        ///showModalCenter(url, window, callBack, 800, 300, "修改客户账号"); 
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var idarray = findSelections("checkbox_template","id");  //取得多选框的选择项
        var ids='';
        if(idarray == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        for(var i=0;i<idarray.length;i++){
             ids = ids+','+idarray[i];
        }
        //ajax查询该供应商对应的福利办理方是否已被公积金办理表的员工引用
        //判断订单表中有没有该入离职ID有没有对应的订单
        jQuery.getJSON(vpath+"/SocialaccountcustAction.do?cmd=checkSocialUnit&date="+new Date()+"",{"ids":ids},  function(json){
             if(json.saia!=null && json.saia.length>0){
                 for(var i = 0; i < json.saia.length; i++){
                    alert("<fmt:message key="cust"/>："+json.saia[i].cust_name+"<fmt:message key="notices"/>");
                 }
             }else{
                if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
                   $id("datacell1").submitAction="/FAERP/SocialaccountcustAction.do?cmd=deleteMulti&ids="+idarray; 
                   $id("datacell1").submit();//提交 
               }
                
             }
         });
        
    }
 
    function toAdd_onClick() {  //到增加记录页面
       var group_type= document.getElementById('group_type').value;
        var security_type= document.getElementById('security_type').value;
        var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/socialaccountcust/insertSocialaccountcust.jsp?group_type="+group_type+"&security_type="+security_type;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=400px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增客户账号');
        //showModalCenter(url, window, callBack, 800, 300, "新增客户账号");  
    }
    
    function callBack(reg){
        if(reg!=""&&reg!=null){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
    }
    
    function detail_onClick(){  //实现转到详细页面
       var group_type= document.getElementById('group_type').value;
        var security_type= document.getElementById('security_type').value;
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/SocialaccountcustAction.do?id=" + ids+"&group_type="+group_type+"&security_type="+security_type+"&cmd=detail";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=320px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看详细信息');
        //showModalCenter(url, window, "", 800, 300, "查看详细信息");  
    }
    
    
     //简单的模糊查询
    function simpleQuery_onClick(){  
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    
     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + ">";
    }
    
    function changeCheck(rowNo,checkB){
        //alert(checkB.value + "" + rowNo);
        //alert(rowNo);
        var enCur = $id("datacell1").dataset.get(rowNo);
        $id("datacell1").isModefied = true;
        enCur.status = Entity.STATUS_MODIFIED;
    }


    function exportExcel_onClick()
    {
      if(confirm('<fmt:message key="is_sure_export_date"/>')) {
      form.action="<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=exportSocialaccountcustToExcel";
      form.submit();
      }
    }

</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" name="group_type" value="${group_type}">
<input type="hidden" name="security_type" value="${security_type}">
 <div  id="right">
 <div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td align="right"><span class="style_required_red">* </span><fmt:message key="ss_fund_group"/></td>
         <td align="left">
            <c:choose>
                            <c:when test="${group_type=='1'&&security_type=='1'}">
                                <select id="social_group_id" name="social_group_id" >
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key="sh_shss"/></option>
                                </select>
                            </c:when>
                            <c:when test="${group_type=='1'&&security_type=='2'}">
                                <select id="social_group_id" name="social_group_id" >
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key="sh_shti"/></option>
                                </select>
                            </c:when>
                            <c:when test="${group_type=='1'&&security_type=='3'}">
                                <select id="social_group_id" name="social_group_id" >
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key="sh_shcs"/>上海--上海综保</option>
                                </select>
                            </c:when>
                            <c:when test="${group_type=='2'}">
                                <select id="social_group_id" name="social_group_id" >
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message key="sh_shfund"/>上海--上海公积金</option>
                                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message key="sh_shbcfund"/>上海--上海补充公积金</option>
                                </select>
                            </c:when>
                        </c:choose>
                        
                        
          </td>
           <td align="left"><fmt:message key="cust_code"/><input type="text" class="text_field" name="customer_code" value="<%= customer_code%>" inputName="客户编号" maxLength="19"/></td>
            <td align="left">
                
            </td>
            <td align="right">&nbsp;</td>
        </tr>
         <tr>
       <td align="right"><fmt:message key="cust_name"/></td>
         <td align="left">
                <input type="text" class="text_field" name="customer_name" value="<%= customer_name%>" inputName="客户名称" maxLength="50"/>
          </td>
           

			<td align="left">
               同步状态<d:select name="sync_status" id="sync_status" dictTypeId="SYNC_STATUS" nullLabel="--请选择--" style="width:200px;"/>
            </td>
            
            <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>

</table>
</div>
                    
<div id="ccParent1" class="button"> 
 <div class="button_right"><!--
                <ul>
                    <li class="a">      <a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="e">     <a  onClick="javascript:exportExcel_onClick();">导出 </a> </li>        
                </ul>
         -->
        <input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="sbzh_view2" type="1"/>  onClick="detail_onClick();">
         <input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="sbzh_add2" type="1"/>  onClick="toAdd_onClick();">
         <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="sbzh_modify2" type="1"/>  onClick="findCheckbox_onClick();">
         <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="sbzh_del2" type="1"/>  onClick="deleteMulti_onClick();">
          <input class="e" type="button"   value="<fmt:message key="export"/>"  <au:authorityBtn code="sbzh_exp" type="1"/>  onClick="exportExcel_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
    
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SocialaccountcustAction.do?cmd=simpleQuery" 
        submitAction="/FAERP/SocialaccountcustAction.do?cmd=sunbmitID" width="98%"
        xpath="SocialaccountcustVo"
        submitXpath="SocialaccountcustVo"
        paramFormId="datacell_formid" height="318px"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false"  fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>           
      <r:field fieldName="group_name" messagekey="ss_fund_group" width="150px" allowModify="false">
              
      </r:field>
      
      <r:field fieldName="customer_code" messagekey="cust_code" width="100px" allowModify="false">
      </r:field>
      
      <r:field fieldName="customer_name" messagekey="cust_name" width="250px" allowModify="false">
      </r:field>
      <r:field fieldName="accounts" messagekey="account" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
       <c:choose>
        <c:when test="${group_type=='2'}">
            <r:field fieldName="paying_bank" messagekey="paying_bank" width="150px" allowModify="false">
            <h:text/> 
            </r:field>
        </c:when>
      </c:choose>
      <r:field fieldName="user_name" messagekey="user_name" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="open_unit" messagekey="open_unit" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="open_unit_accounts" messagekey="open_unit_account" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="is_fesco_pay" messagekey="is_fesco_pay" width="100px" allowModify="false">
           
      </r:field>
       <r:field fieldName="hire_unit" messagekey="hire_unit" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
       <r:field fieldName="cust_password" messagekey="cust_password" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
       <r:field fieldName="emp_code_type" messagekey="emp_code_type" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      <c:choose>
        <c:when test="${group_type=='2'}">
            <r:field fieldName="end_date" messagekey="end_date" width="150px" allowModify="false">
            <h:text/> 
      </r:field>
      <r:field fieldName="get_day" messagekey="get_day" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="seal_party" messagekey="seal_party" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="remarks" messagekey="remarks" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="is_del" label="是否有效" width="150px" allowModify="false">
            <d:select dictTypeId="DELFLAG" disabled="true"/>
      </r:field>
      <r:field fieldName="sync_status" label="同步状态" width="150px" allowModify="false">
            <d:select dictTypeId="SYNC_STATUS" disabled="true"/>
      </r:field>
      
      <r:field fieldName="sync_remark" label="同步备注" width="150px" allowModify="false">
           <d:select dictTypeId="SYNC_REMARK" disabled="true"/>  
      </r:field>
      
      <r:field fieldName="sync_date" label="最后同步时间" width="150px" allowModify="false">
            <w:date format="yyyy-MM-dd HH:mm:ss" />
      </r:field>
      
      <r:field fieldName="remark" label="同步历史" width="1000px" allowModify="false"></r:field>
      
        </c:when>
      </c:choose>
      
    </r:datacell>
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
$id("datacell1").headTextAlign="center";
    //解决修改行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell不进行查询
    $id("datacell1").beforeLoadData = function(){
        if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
           //alert("run hear");
           return false;
        }
        return true;
    }
    //后台返回的信息
    $id("datacell1").afterSubmit= function(ajax){
           alert(""+ajax.getProperty("returnValue"));
    }
    //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        //alert(city_id);
        if (colIndex == 15){
            var combo1 = $id("com1");
            combo1.addParam("security_group_id",security_group_id);
            combo1.loadData();
            combo1.refresh();
        }
        return true;
    }    
   //实现on updateCell
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        //alert(activeCell.getAttribute("fieldId").indexOf("service_name2"));
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("transact_type_name") >= 0){
            var activeEditor = $id("datacell1").activeEditor;
            activeEntity.setProperty("transact_type_name", activeEditor.getDisplayValue(newValue));
            activeEntity.setProperty("transact_type_id", newValue);
        }
        return true;
    }
//忽略datacell的修改
    $id("datacell1").afterEdit = function( newValue, oldValue , datacell1 ){
        $id("datacell1").isModefied = false;
    }    
</script>   
