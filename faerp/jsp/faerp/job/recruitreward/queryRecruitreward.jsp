<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
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
        form.action="<%=request.getContextPath()%>/Job_orderAction.do?id=" + ids;
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
            form.action="<%=request.getContextPath()%>/Job_orderAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
       var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
      var isExiseurl="<%=request.getContextPath()%>/RecruitrewardAction.do?cmd=IsExiseRecruitreward&id="+ids;
        jQuery.post(isExiseurl,function(data){
             if(data){
                if(data==0){
                 var url="<%=request.getContextPath()%>/RecruitrewardAction.do?cmd=submitRecruitreward&id="+ids;
        window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=业绩分配');
                }else{
                  alert("此订单业绩已分配，不需要重新分配");
                }
             
             }else{
                alert("程序错误,请重试");
                return;
             }
        })
       
        
    }
    function detail_onClick(){  //实现转到详细页面
     
        form.action="<%=request.getContextPath()%>/Job_orderAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }
    
    //合同参照
    function toFindContract(arg){
        var lookup = $id("lk_contract");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#contract_id").val(arg[0]);       
        return false;
    }
    
    //客户参照
    function rtnFunc(arg){
    var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }
    function simpleQuery_onClick(){  //查询所有记录
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
</script>
</head>
<form name="form" method="post" id="datacell_formid" >
<input type="hidden"  name="cmd" value="queryAll"/>
<input type="hidden" name="backFlag" id="backFlag" value="true">

<div id="right">
<script language="javascript">
    writeTableTopFesco('业绩查看','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_x">
 
 
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
                    lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="444" width="764" style="width:188px"/> 
            </td>
                    <td align="left">订单编号</td>
            <td align="left">
                <input type="text" class="text_field" id="order_code" name="order_code" inputName="订单编号" maxLength="100"/>
            </td>
         
                        <td align="left">订单名称</td>
            <td align="left">
                <input type="text" class="text_field" id="order_name" name="order_name" inputName="订单编号" maxLength="100"/>
            </td>
       
        </tr>
        <tr>
           <td align="left">客户名称</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" readonly="false" displayValue="" id="lk_cust" 
                                   lookupUrl="/JcustomerAction.do?cmd=getJCustRef" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false" style="width:188px"/>
                <input type="hidden" name="cust_id" id="cust_id">
            </td>
                     <td align="left">顾问姓名</td>
            <td align="left">
                <input type="text" class="text_field" id="username" name="username" inputName="订单编号" maxLength="100"/>
            </td>
         
     
            <td align="left" colspan="2">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
                </td>
      
        </tr>
</table>
</div>

<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/RecruitrewardAction.do?cmd=searchRecruitreward" width="98%" height="318px" xpath="RecruitrewardVo" paramFormId="datacell_formid" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px"  onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
 <r:field fieldName="order_code" label="订单编号" width="150px" ></r:field>    
 <r:field fieldName="order_name" label="订单名称" width="150px"></r:field>
  <r:field fieldName="user_name" label="招聘顾问姓名" width="90px"></r:field>
 <r:field fieldName="deptname" label="团队名称"  width="150px"></r:field>
 <r:field fieldName="rewardamount" label="业绩金额" width="100px"></r:field>
<r:field fieldName="invoice_amount" label="开票金额"  width="100px" >
 </r:field>
  <r:field fieldName="outstanding_amount" label="欠款金额"  width="100px" >
 </r:field> 
 </r:datacell>
</div>
</div>

</form>
</fmt:bundle>
</body>
</html>
