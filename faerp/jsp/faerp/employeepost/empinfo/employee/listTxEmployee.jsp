<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.employeepost.empinfo.employee.employee_resource" prefix="rayoo.employeepost.empinfo.employee.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="emp_info_protect"/></title>
<%
String kefuid = (String)request.getAttribute("kefuid");
if(kefuid==null || "".equals(kefuid)){
    kefuid = "1099100700000000105";
}
request.setAttribute("kefuid",kefuid);
%>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" id="emp_id" name="emp_id" value=""/>
<input type="hidden" id="id_Card" name="id_Card" value="" />
<input type="hidden" id="id_Card_Type_BD" name="id_Card_Type_BD" value="" />
 
<div id="right">
<script language="javascript">
	writeTableTopFesco("退休员工信息",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccParent1" class="button"> 
 <div class="button_right">
	  <input type="button" class="bl_1" value="保存" onClick="save_onClick();"/>
	        <input class="e" type="button" value="导出" onClick="javascript:exportExcel();">
	 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/FaerpEmployeeAction.do?cmd=listTxEmployeeData"
        submitAction="/FAERP/FaerpEmployeeAction.do?cmd=updateTxEmployee"
        width="98%"
        height="320px"
        xpath="EmployeeVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="id" label="<input type='checkbox' name='checkAll' onclick='checkAll(this);'/>" 
        width="35px" sortAt="none" onRefreshFunc="setCheckBoxStatus"  align="center"></r:field>
          <r:field fieldName="emp_name" messagekey="employee_name">
            <h:text/>
          </r:field>
          <r:field fieldName="emp_code" messagekey="emp_unique_num">
               <h:text/>   
           </r:field>
           <r:field fieldName="emp_sex" label="员工性别" allowModify="false">
                <d:select dictTypeId="EMP_SEX"/>
          </r:field>
           <r:field fieldName="employee_status" label="员工身份" allowModify="true">
                <d:select dictTypeId="EMPLOYEE_STATUS" onchange="modifyMany('employee_status',this.value);"/>
          </r:field>
          <r:field fieldName="reminder_duration" label="提醒期限" allowModify="true">
                <d:select dictTypeId="REMINDER_DURATION"  onchange="modifyMany('reminder_duration',this.value);"/>
          </r:field>
          <r:field fieldName="internal_code" messagekey="internal_code">
               <h:text/>
           </r:field>
          <r:field fieldName="id_card_type_bd" messagekey="credentials_type">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="id_card" messagekey="id_card" width="180px">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" messagekey="customer_code">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey="customer_name" width="220px">
            <h:text/>
          </r:field>
          <r:field fieldName="user_name" messagekey="user_name">
            <h:text/>
          </r:field>
          <r:field fieldName="post_status_bd" messagekey="status">
            <d:select dictTypeId="POST_STATUS_BD" />
          </r:field>
    </r:datacell>
    </div>
 
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
var ids = "";//定义全局变量接收复选框选中的行id
//魏佳新增方法，初始化复选框
function setCheckBoxStatus(value,entity,rowNo,cellNo){
    return "<input id='"+value+"' type='checkbox' name='checkbox_template'  value='"+value+"' onclick='checkRow();'>";
}

    //魏佳新增方法，用于批量修改员工身份和提醒期限，获取复选框选中的行id
    function checkRow(){
        ids = "";
        var id = "";
        var dc = $id("datacell1");//获取datacell对象
        var checkBoxObj = document.getElementsByName("checkbox_template");//获取所有checkbox元素
        var objLength = checkBoxObj.length;//获取checkbox元素的长度
        for(var i = 0 ; i < objLength ; i++){
            if (checkBoxObj[i].checked) {//如果被选中则添加到全局变量
                var row = dc.table.tBodies[0].rows[i];//获取选中行对象
                var entity = dc.getEntity(row);//获取选中行的数据对象
                id = entity.getValue("id");//获取选中行的id
                if(id != "" && id != "null" && id != null){
                    ids += id+",";//添加到全局变量
                }
            }
        }
    }

jQuery(document).ready(function(){
    $id("datacell1").isQueryFirst = true;
});

function save_onClick(){
	if($id("datacell1").isModefied == true){
	   $id("datacell1").submit();
	   $id("datacell1").loadData();
       $id("datacell1").refresh();
	}else{
	   alert("未变更任何数据！");
	}
}

//选择所有项，和取消选中所有项
    function checkAll(obj){
        var checkAllButton = obj.checked;
        ids = "";
        var id = "";
        var dc = $id("datacell1");//获取datacell对象
        var checkBoxObj = document.getElementsByName("checkbox_template");//获取所有checkbox元素
        var objLength = checkBoxObj.length;//获取checkbox元素的长度
        for(var i = 0 ; i < objLength ; i++){
            var row = dc.table.tBodies[0].rows[i];//获取选中行对象
            var entity = dc.getEntity(row);//获取选中行的数据对象
            id = entity.getValue("id");//获取选中行的id
            if(id != "" && id != "null" && id != null){
                ids += id+",";//添加到全局变量
            }
            if(checkAllButton){//如果全选按钮是选中状态，则选中所有行
                checkBoxObj[i].checked = true;
            }else{//如果全选按钮是未选中状态，则取消选中所有行
                ids = "";//重置所有选中的id集合
                checkBoxObj[i].checked = false;
            }
        }
    }
    
    //魏佳新增方法，用于在变更员工身份和提醒期限时，批量变更所有前面的勾选项中已勾选的记录的相应员工身份和提醒期限状态。
     //魏佳新增方法，用于用于批量修改员工身份和提醒期限功能,并回显已选中的数据
    function modifyMany(cellType,val){
        var id = "";
        var dc = $id("datacell1");//获取datacell对象
        var checkBoxObj = document.getElementsByName("checkbox_template");//获取所有checkbox元素
        var objLength = checkBoxObj.length;//获取checkbox元素的长度
        
        //按险种一起修改或可以做一个按钮（打钩后批量修改）功能
        for(var j = 0 ; j < objLength ; j++){
            var row1 = dc.table.tBodies[0].rows[j];//获取行对象
            var entity1 = dc.getEntity(row1);//获取行的数据对象
            id = entity1.getValue("id");//获取行的id
            if(ids.indexOf(dc.getActiveEntity().getValue("id")) >= 0 ){//如果改行在全局变量中存在，则更改所有选中行的状态，否则只更改当前操作行的状态
                if(checkBoxObj[j].checked){
                    dc.selectRow(row1);//选中改行，只有选中改行后才可以对该行的数据进行赋值操作
                    entity1.setProperty(cellType,val);//设置状态
                }
            }
        }
        
        //回显已选中的数据
        for(var i = 0 ; i < objLength ; i++){
            var row1 = dc.table.tBodies[0].rows[i];//获取行对象
            var entity1 = dc.getEntity(row1);//获取行的数据对象
            id = entity1.getValue("id");//获取行的product_id
            if(id != "" && id != "null" && id != null){
                if(ids.indexOf(id) >= 0 ){//如果改行的product_id在全局变量中存在，则重新选中改行已达到回显已选中行的效果
                    document.getElementById(id).checked = true;//设置为选中状态
                }
            }
        }
    }
    
    //导出明细
     function exportExcel(type){
        var form = document.getElementById("datacell_formid");
        form.action="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=exportTxtxExcel";
        form.submit();
     }
</script>	
