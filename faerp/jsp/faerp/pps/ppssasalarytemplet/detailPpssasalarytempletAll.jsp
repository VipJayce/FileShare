<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看薪资模版</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        form_treebasic.action="<%=request.getContextPath()%>/PpssasalarytempletAction.do?cmd=queryAll_toSalaryProject";
        form_treebasic.submit();
    }
    
</script>
</head>
<body >
<div id="right">
<form name="form_treebasic" id="form_treebasic" method="post"  >
<input type="hidden" id="templet_id" name="templet_id" value="${bean.id }">
<script type="text/javascript">
writeTableTopFesco('薪资模版配置','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_x" style="height: 40px;">
<div id="ccChild1"     class="box_xinzeng" style="height: 40px;"> 
<table  width="100%" height="30" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ></span>客户名称</td>
            <td class="td_2"  >
                <input type="text" class="text_field"  id="customer_name"  name="customer_name" inputName="客户名称" value="${bean.customer_name}" maxLength="30" readonly="readonly""/> 
            </td>
            <td class="td_1" > </span>薪资模版代码</td>
            <td class="td_2 " >
            <input type="text" class="text_field"  id="salary_templet_code"  name="salary_templet_code" inputName="薪资模版代码" value="${bean.salary_templet_code}" maxLength="30" readonly="readonly""/>  
            </td>
             <td class="td_1" ></span>薪资模版名称</td>
            <td class="td_2" >
             <input type="text" class="text_field"  id="salary_templet_name"  name="salary_templet_name" inputName="薪资模版名称" value="${bean.salary_templet_name }" maxLength="30"  readonly="readonly""/>
             </td>
        </tr>
    </table>
  </div>
 </div>
    <!-- 收入、支出部分  begin-->
    <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">收入、支出部分</div>
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell1"
        queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getSalaryitemDataForDetail&itemtype=salaryinout&templetid=${bean.id}"   
        width="98%" height="198px" xpath="PpssasalarytempletitemVo" submitXpath="PpssasalarytempletitemVo" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
         <r:field fieldName="sa_item_name" label="薪资项目名称" width="350px" allowModify="false" >
        </r:field>
              <r:field fieldName="is_tax" label="是否扣税" width="300px" allowModify="false" >
        <d:select dictTypeId="TrueOrFalse" disabled="true"/>
        </r:field>
        <r:field fieldName="property" label="增减属性" width="290px" allowModify="false" >
        <d:select dictTypeId="PROPERTY" disabled="true"/>
        </r:field>
         <r:field fieldName="ishide" label="零值是否显示" width="200" allowModify="false"  >
           <d:select dictTypeId="TrueOrFalse"  />
        </r:field>
    </r:datacell>
     <!-- 收入、支出部分  end-->
     
     <!--代扣、代缴部分  begin-->
    <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">代扣、代缴部分</div>
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell2"
        queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getSalaryitemDataForDetail&itemtype=salarydown&templetid=${bean.id}"
        width="98%" height="198px" xpath="PpssasalarytempletitemVo2" submitXpath="PpssasalarytempletitemVo2" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="sa_item_name" label="薪资项目名称" width="350px" allowModify="false" >
        </r:field>
              <r:field fieldName="is_tax" label="是否扣税" width="300px" allowModify="false" >
        <d:select dictTypeId="TrueOrFalse" disabled="true"/>
        </r:field>
        <r:field fieldName="property" label="增减属性" width="290px" allowModify="false" >
        <d:select dictTypeId="PROPERTY" disabled="true"/>
        </r:field>
         <r:field fieldName="ishide" label="零值是否显示" width="200" allowModify="false"  >
           <d:select dictTypeId="TrueOrFalse"  />
        </r:field>
    </r:datacell>
     <!-- 代扣、代缴部分  end-->
     
      <!-- 收入、支出部分  begin-->
    <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">福利项目</div>
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell3"
        queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getSalaryitemData_2&itemtype=welfare&templetid=${bean.id }"
        width="98%" height="198px" xpath="PpssasalarytempletitemVo" submitXpath="PpssasalarytempletitemVo" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
           <r:field fieldName="sa_item_name" label="薪资项目名称" width="300px" allowModify="false" >
        </r:field>
            <r:field fieldName="payroll_name" label="工资单名称" width="300px" allowModify="false" >
        </r:field>
        <!--  
        <r:field fieldName="property" label="增减属性" width="245px" allowModify="false" >
        <d:select dictTypeId="PROPERTY"  />
        </r:field>
        -->
         <r:field fieldName="is_personal" label="是否个人福利" width="260"  sortAt="none" allowModify="false" >
           <d:select dictTypeId="PersonalORCompany" />
        </r:field>
           <r:field fieldName="ishide" label="零值是否显示" width="260" allowModify="false">
           <d:select dictTypeId="TrueOrFalse" />
        </r:field>
        <r:field fieldName="welfare_display_order" label="排序" width="0"  allowModify="false">
        </r:field>
    </r:datacell>
     
       <!--12W年薪  begin-->
    <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">12万年薪部分</div>
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell4"
        queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getSalaryitemData_2&itemtype=12annualsalary&templetid=${bean.id }"
        width="98%" height="198px" xpath="PpssasalarytempletitemVo3" submitXpath="PpssasalarytempletitemVo3" 
         paramFormId="datacell_formid2" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
         <r:field fieldName="sa_item_name" label="薪资项目名称" width="300px" allowModify="false" ></r:field>
        <r:field fieldName="annualsalary_property" label="12万年薪增减属性" width="245px" allowModify="true" >
        <d:select dictTypeId="PROPERTY" />
        </r:field>
    </r:datacell>
     <!-- 12W年薪  end-->
     
     <table class="table_noFrame"  align="center">
    <tr>
         <td >
        <input name="button_back" class="icon_2" type="button" value="返回"  onclick="javascript:cancel_onClick();" >
        </td>
    </tr>
</table>
     
</form>

<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</div>
</div>
</body>

</fmt:bundle>
</html>
<script language="javascript">

</script>
