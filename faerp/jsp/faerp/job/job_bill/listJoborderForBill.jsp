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
<%@ page import="rayoo.job.job_order.vo.Job_orderVo" %>
<%@ page import="rayoo.job.job_order.util.IJob_orderConstants" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>招聘账单</title>
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
   

    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

    function generate_onClick(){  //实现招聘账单生成
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
            alert('请选择一条记录！');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('只能选择一条记录！');
            return;
        }
    
        //获取选中行的订单信息
        var entity = $id("datacell1").getActiveEntity() ;
        //if(entity.getProperty("billgenerated") == 1){
          //  alert("该订单已生成账单！");
           // return ;
        //}
        var order_id = entity.getProperty("id");//订单ID
        var cust_id = entity.getProperty("cust_id");//客户ID
        
       //var url = "<%=request.getContextPath()%>/jsp/faerp/job/job_bill/insertJobBill.jsp";
       var url = "<%=request.getContextPath()%>/Job_orderAction.do?cmd=toinsertJobBill";
       showModalCenter(url,$id("datacell1"),null,850,450,"生成招聘账单");
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

//每行数据第一列生成复选框
function setCheckboxStatus(value,entity,rowNo,cellNo){
       //return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  >";
       //return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";
       return "<input type='radio' name='temp' value=" + entity.getProperty("id") + "  >";
    }

//账单是否已生成   
function setBillgenerated(value,entity,rowNo,cellNo){
       if("1" == value)
            return "已生成";
       else{
            return "未生成";
       }
    }

</script>
</head>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/Job_orderAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<div id="right">
<script language="javascript">
    writeTableTopFesco('招聘账单','<%=request.getContextPath()%>/');  //显示本页的页眉
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
                <input type="hidden" name="contract_id"/>
                <w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract" 
                    lookupUrl="/jsp/faerp/common/sales/RefJobContract.jsp"  dialogTitle="选择合同" height="444" width="764" style="width:188px"/> 
            </td>
             <td align="left">订单状态</td>
            <td align="left">
                 <d:select dictTypeId="ORDER_STATUS_BD" id="order_status" name="order_status" nullLabel="--请选择--"></d:select>
            </td>
            <td align="left">客户名称</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFunc" readonly="false" displayValue="" id="lk_cust" 
                                   lookupUrl="/JcustomerAction.do?cmd=getJCustRef" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
                <input type="hidden" name="cust_id" id="cust_id">
            </td>
        </tr>
        <tr>
            <td align="left">订单编号</td>
            <td align="left">
                <input type="text" class="text_field" id="order_code" name="order_code" inputName="订单编号" maxLength="100"/>
            </td>
             <td align="left"></td>
            <td align="left">
                 <!--<d:select dictTypeId="BILL_GENERATED_BD" id="billgenerated" name="billgenerated" nullLabel="--请选择--" value="0"></d:select>-->
            </td>
            <td align="left"></td>
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
            <li class="i"><a onClick="javascript:generate_onClick();">生成账单</a></li>                     
        </ul>
</div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 0 8 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/Job_orderAction.do?cmd=simpleQuery&order_type=1" width="98%" height="318px" xpath="Job_orderVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="order_code" label="订单编号" width="110px" ></r:field>    
 <r:field fieldName="order_name" label="订单名称" width="110px"></r:field>
 <r:field fieldName="contract_name" label="关联合同" allowModify="false" width="110px"></r:field>
 <r:field fieldName="customer_name" label="客户" allowModify="false" width="110px"></r:field>
 <r:field fieldName="warranty" label="担保期" allowModify="false" width="110px"></r:field>
 <r:field fieldName="order_status" label="订单状态" allowModify="false" width="110px">
    <d:select dictTypeId="ORDER_STATUS_BD"></d:select>
 </r:field>
 <r:field fieldName="create_user_name" label="录入人" width="110px"></r:field>
 <r:field fieldName="create_date" label="录入时间" allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
<!--  <r:field fieldName="billgenerated" label="账单是否生成" allowModify="false" width="110px" onRefreshFunc="setBillgenerated">
 </r:field> -->
 </r:datacell>
</div>

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(IJob_orderConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IJob_orderConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>
