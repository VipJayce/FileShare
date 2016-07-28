<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%
String source = request.getParameter("source");//页面来源
System.out.println(source);
String type_re = request.getParameter("type_re");//提醒类型
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>候选人提醒</title>
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
        form.action="<%=request.getContextPath()%>/Job_adviserAction.do?id=" + ids;
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
            form.action="<%=request.getContextPath()%>/Job_adviserAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    //确定
    function ok(){
        var id_check = document.getElementsByName("checkbox_template");
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
         window['returnValue'] = ids[0];
         window.close();
    }


//设置为已知道
    function toUpdate_onClick(){
        var idarray = findSelections("checkbox_template");  //取得多选框的选择项
        var ids='';
        if(idarray == null) {  //如果ids为空
            alert('请至少选择一条提醒记录！');
            return;
        }else{
            for(var i=0;i<idarray.length;i++){
                   
                if(i==0){
                    ids=idarray[0];
                }else{
                    ids = ids+','+idarray[i];
                }
            }
               
           jQuery.ajax({
               url: '<%=request.getContextPath()%>/JobcandidateAction.do?cmd=updateKnowed&type_re=<%=type_re%>&ids='+ids,
               type: 'GET',
               dataType: 'html',
               timeout: 10000,
               error: function(){
                   alert('Error loading XML document'); 
                       return  null;
                   },
               success: function(text){
                   if(text==1){       
                       alert('设置成功！');
                       simpleQuery_onClick();
                   }else{
                       alert('没有任何更改！');
                   }
               }
           });
       }
    }

</script>


<script type="text/javascript">

//每行数据第一列生成复选框
function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value=" + entity.getProperty("id") + "  >";
       //return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";
       //return "<input type='radio' name='temp' value=" + entity.getProperty("id") + "  >";
    }

//选择合同
    function toFindContract(arg){
        var lookup = $id("lk_contract");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#contract_id").val(arg[0]);       
        return false;
    }

 //选择客户
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);      
    jQuery("#cust_a_name").val(arg[2]);       
    return false;
}

</script>

</head>
<body>

<form name="form" method="post"  id = "datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
  <input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">

<div id="right">
<script language="javascript">
    writeTableTopFesco('候选人提醒','<%=request.getContextPath()%>/');  //显示本页的页眉
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
            <td align="left">关联合同</td>
            <td align="left">
                <input type="hidden" name="contract_id" id="contract_id"/>
                <w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract" 
                    lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="460" width="760" style="width:188px"/>
            </td>
            <td align="left">客户名称</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=zp" dialogTitle="选择客户" height="460" width="600"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
            </td>
        </tr>
        <tr>
            <td align="left">订单编号</td>
            <td align="left"><input type="text" class="text_field" name="order_code" id="order_code" inputName="订单编号" maxLength="25" /></td>
            <td align="left">订单状态</td>
            <td align="left">
                <%=RmJspHelper.getSelectField("order_status",-1,"ORDER_STATUS_BD","","",false) %>
            </td>
        </tr>
        <tr>
            <td align="left">职位名称</td>
            <td align="left">
                <input type="text" class="text_field" name="position_name" id="position_name" inputName="职位名称" maxLength="25"/>
            </td>
            <td align="left" colspan="2">
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
 

 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
        <ul>
            <li class="o"><a onClick="javascript:toUpdate_onClick();">知道了</a></li>
            <li class="m_1"><a href="##" onClick="location.href='javascript:history.go(-1);'">返回首页</a></li>
        </ul>
</div>
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/JobcandidateAction.do?cmd=getJobCandidateRemindInfo&type_re=${param.type_re}" width="98%" height="318px" xpath="JobCandidateRemindVO" paramFormId="datacell_formid" >
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus"   ></r:field>
 <r:field fieldName="order_code" label="订单编号" allowModify="false" width="110px"> </r:field>
 <r:field fieldName="order_name" label="订单名称" allowModify="false" width="110px"> </r:field>
 <r:field fieldName="contract_name" label="关联合同" allowModify="false" width="180px"> </r:field>
 <r:field fieldName="cust_name" label="客户" allowModify="false" width="180px"> </r:field>
  <r:field fieldName="position_name" label="招聘职位" allowModify="false" width="110px"> </r:field>
  <r:field fieldName="person_name" label="候选人" allowModify="false" width="110px"> </r:field>
  <r:field fieldName="duedate" label="任职日期" allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
 <r:field fieldName="warrantyperiod" label="担保截止日期" allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
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

