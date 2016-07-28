<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<fmt:bundle basename='rayoo.customerservice.custservice.laborcontract.listLaborcontract_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
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
      
    function deleteMulti_onClick(){  //从多选框逻辑删除多条记录
        var ids = selectIds();  //取得多选框的选择项
        if(ids == null || ids == '') {
	        alert("请选择要删除的数据！");
	        return;
	    }
        if(confirm('是否确定删除所有选中的数据')) {  //如果用户在确认对话框按"确定"
           jQuery.ajax({
	            url: "<%=request.getContextPath()%>/LaborcontractmailAction.do?cmd=deleteMulti&ids=" + ids,
	            type: 'post',
	            dataType: 'html',
	            async: false,
	            timeout: 80000,
	            error: function() {
	                alert('Error loading XML document');
	                return null;
	            },
	            success: function(text) {
	                if (text == "0") {
	                   alert("删除失败！");
	                }else if(text == "1") {
	                   alert("删除成功！");
	                   simpleQuery_onClick();
	                }
	            }
	        });
           
        }
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").addParam("customer_name",$id("custname").value);
        $id("datacell1").addParam("customer_code",$id("custcode").value);
        $id("datacell1").addParam("contractmail_type_search",$id("contractmail_type_search").value);
        $id("datacell1").addParam("contractmail_bd",$id("contractmail_bd").value);
        $id("datacell1").addParam("employee_name",$id("employee_name").value);
           
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function toAdd_onClick() {  //到增加记录页面
        var url = "<%=request.getContextPath()%>/LaborcontractAction.do?cmd=queryAllForMail";
        window.open(url,'','height=600px,width=1200px,top =50,left=100,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
    }
    
    
    /**
     * 个人订单查看
     */
    function detail_onClick(){  //实现转到详细页面
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('请选择一条记录！');
            return;
        }
        if(ids.length > 1) {//如果ids有2条以上的纪录
            alert('只能选择一条记录！');
            return;
        }
        var enCurEntity = $id("datacell1").getActiveEntity();
        var post_id = enCurEntity.getValue("emp_post_id");
        window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrder&id='+post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
    }

    function getcustomerList(){   
         var url="<%=request.getContextPath()%>/jsp/faerp/common/sales/allCustomer.jsp";
         showModalCenter(url, window,toFindCustomer,750,434,"<fmt:message key="choose_customer"/>");
    }
    
    function toFindCustomer(obj) {
        var lookup = $id("customer_name");
        lookup.value = obj[2];
        lookup.displayValue = obj[2];
        document.getElementById("custname").value=obj[2];
        document.getElementById("custcode").value=obj[1];
        //alert(obj[0]);
        return false;
    }
    
    //显示一列chkbox
    function setCheckBoxStatus(value,entity,rowNo,cellNo){
        //初始化checkbox时设置是否选中
        if(value != "" && value !="null" && value != null){//设置最后一行合计不添加复选框
            var flag = entity.getProperty("chk")=="1"? "checked" : "";
            return "<input "+flag+" onclick='chkEntity("+rowNo+");' type='checkbox' name='checkbox_template' value='" + value + "' />";
        }
    }
    
    //全选
    function checkAllPro(item){
        if (jQuery(item).attr("checked")) {
            chkAllEntity(1);
            jQuery(":checkbox").attr("checked", true);
        } else {
            chkAllEntity(0);
            jQuery(":checkbox").attr("checked", false);
        }
    }
    
    //设置ENTITY的chk属性
    function chkEntity(rowNo){
        var emps = $id("datacell1").dataset.values;
        var entity = emps[rowNo];
        var chk = entity.getProperty("chk");
        entity.setProperty("chk",1-chk);
    }
    
    //设置选中ENTITY的chk属性
    function chkAllEntity(flag){
        var ds = $id("datacell1").dataset;
        var values = ds.values;
        for(var i=0; i<values.length; i++){
            var entity = values[i];
            entity.setProperty("chk", flag);
        }
    }
    
    function modify_onClick(){
        if(confirm("是否确定修改数据！")){
            if($id("datacell1").isModefied == true){
                $id("datacell1").submit();
	        }else{
	           alert("未变更任何数据！");
	        }
        }
    }
</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/LaborcontractmailAction.do">
<input type="hidden" id="custname" name="custname" value=""/>
<input type="hidden" id="custcode" name="custcode" value=""/>
<input type="hidden" id="cmd" name="cmd" value=""/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="listLaborcontract0082"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
                <div class="search_title"><fmt:message key="listLaborcontract0007"/></div>
            </td>
            <td><fmt:message key="listLaborcontract0077"/></td>
            <td>
                <w:lookup onReturnFunc="toFindCustomer" id="customer_name" name="customer_name" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"  messagekey="choose_customer" height="434" width="750" style="width:188px" value=""/> 
            </td>  
            <td><fmt:message key="listLaborcontract0009"/></td>
            <td>
                <input type="text" class="text_field"  id = "employee_name" name="employee_name" inputName="员工姓名" maxLength="50" value="" />
            </td>
        </tr>
    
        <tr>
            <td><fmt:message key="listLaborcontract0072"/></td>
            <td>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contractmail_type_search",-1,"CONTRACTMAIL_TYPE", "", "id='contractmail_type_search'", false) %>
            </td>

            <td><fmt:message key="listLaborcontract0073"/></td>
            <td>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contractmail_bd",-1,"CONTRACTMAIL_BD", "", "id='contractmail_bd'", false) %>
            </td>
            <td>
                <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="listLaborcontract0173"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
            </td>
            <td />
        </tr>
    </table>
</div>
                    
<div id="ccParent1" class="button"> 
	<div class="button_right">
		<input class="a_2" type="button" value="<fmt:message key="listLaborcontract0037"/>"  <au:authorityBtn code="quot_view" type="1"/>  onClick="detail_onClick();">
		<input class="c" type="button" value="<fmt:message key="listLaborcontract0075"/>"  <au:authorityBtn code="quot_add" type="1"/>  onClick="toAdd_onClick();">
		<input class="b" type="button" value="<fmt:message key="listLaborcontract0035"/>"  <au:authorityBtn code="quot_modify" type="1"/>  onClick="modify_onClick();">
		<input class="d" type="button" value="<fmt:message key="listLaborcontract0076"/>"  <au:authorityBtn code="quot_del" type="1"/>  onClick="deleteMulti_onClick();">
	</div>
	<div class="clear"></div>            
</div>
 
 <div style="padding: 8 5 8 8;">
  <r:datacell 
        id="datacell1"
       queryAction="/FAERP/LaborcontractmailAction.do?cmd=queryLabormailDatal"
       submitAction="/FAERP/LaborcontractmailAction.do?cmd=update"
        width="98%"
        height="320"
        xpath="LaborcontractmailVo"
        submitXpath="LaborcontractmailVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id" label="<input type='checkbox' id='chkbox_all' name='checkAll' onclick='checkAllPro(this);'/>" 
        width="35px" sortAt="none" onRefreshFunc="setCheckBoxStatus"  align="center"></r:field> 
       <r:field fieldName="emp_code" width="90px" messagekey="listLaborcontract0010" >
       </r:field>
       <r:field fieldName="emp_post_id" width="0px" messagekey="listLaborcontract0047" >
       </r:field>
      <r:field fieldName="emp_name" width="100px" messagekey="listLaborcontract0009" >
       </r:field>
       <r:field fieldName="cust_name" width="180px" messagekey="listLaborcontract0077" >
       </r:field>
       <r:field fieldName="cust_code" width="90px" messagekey="listLaborcontract0014" >
       </r:field>
       <r:field fieldName="contractmail_type" width="100px"  messagekey="listLaborcontract0072" allowModify="true">
            <d:select dictTypeId="CONTRACTMAIL_TYPE"></d:select>
       </r:field>
       <r:field fieldName="contract_properties" messagekey='listLaborcontract0175' allowModify="false">
        <d:select dictTypeId="CONTRACT_PROPERTIES"></d:select>
    </r:field>
       <r:field fieldName="contractmail_status_bd" width="100px"  messagekey="listLaborcontract0073" allowModify="true">
            <d:select dictTypeId="CONTRACTMAIL_BD"></d:select>
       </r:field> 
       
       <r:field fieldName="address" label="联系地址" width="180px" allowModify="false">
    </r:field>
       <r:field fieldName="email" label="邮箱" width="180px" allowModify="false">
      </r:field>
       
       <r:field fieldName="create_user_name" width="100px" label="" messagekey="listLaborcontract0078">
       </r:field>
       <r:field fieldName="create_date" width="105px" messagekey="listLaborcontract0079" allowModify="false">
        <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>  
       <r:field fieldName="update_user_name" width="100px" label="" messagekey="listLaborcontract0080">
       </r:field>
       <r:field fieldName="last_update_date" width="105px" messagekey="listLaborcontract0081" allowModify="false">
        <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>
    </r:datacell>
</div>

</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<script language="javascript">
    jQuery(function(){
        $id("datacell1").afterRefresh = function() {
            chkAllEntity(0);
            jQuery(":checkbox").attr("checked", false);
            $id("datacell1").isModefied = false;
        }
	    //修改cell值以后操作
	    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
	      var rc = this.dataset.getLength();
	      var orderitems = this.dataset.values;
	      for(var i=0; i<rc; i++){
	         var entity = orderitems[i];
	         var chk = entity.getProperty("chk");
	         if(chk == "1"){
	          var curCell = this.getCell(i,activeCell.cellIndex);
	          this.setCellValue(curCell,newValue); 
	         }
	      }
	   }
    });
</script>
