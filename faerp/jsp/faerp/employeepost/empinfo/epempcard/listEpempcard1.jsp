<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp' onClick=\"ClickRow('" + entity.getProperty("eid") + "','" + entity.getProperty("id") + "');\">";
    }

    function showListData(){
	    $id("datacell1").loadData();
	    $id("datacell1").refresh();
    }
    
    function toAdd_onClick() { 
        $id("datacell1").addRow();
    }
    
    function deleteMulti_onClick(){ 
             $id("datacell1").deleteRow();
    }
    
    function toSave_onClick() { 
        $id("datacell1").submit();
    }
    
    function toReload_onClick() {
         $id("datacell1").reload();
    }
    
    //获得员工，把lookUp返回值设置到datacell1的单元格中
    function returnFuncPosi(arg){    
        var lookup = $id("lookupID1");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        var row = $id("datacell1").getActiveRow();
        var entity = $id("datacell1").getEntity(row);
        entity.setProperty("emp_id",arg[0]);
        entity.setProperty("emp_name",arg[1]);
        entity.setProperty("emp_code", arg[2]);
        entity.setProperty("id_card",arg[3] );
        entity.setProperty("cust_name",arg[4] );
        entity.setProperty("cust_code",arg[5] );
        
        $id("datacell1").refreshRow(row);
    }

</script>
</head>
<body>

<form name="form" method="post" id="empcard_formid">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

		<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
		</tr>
		<tr>
			<td align="right">员工姓名</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="10"/>			</td>
			<td align="right">唯一号</td>
			<td align="left">
			   <input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>            </td>
			<td align="right">身份证号</td>
			<td align="left">
			   <input type="text" class="text_field" name="id_card1" inputName="身份证号" maxLength="64"/>            </td>
		</tr>
		<tr>
			<td align="right">客户编号</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="64"/>			</td>
			<td align="right">客户名称</td>
			<td align="left">
			    <input type="text" class="text_field" name="cust_name1" inputName="客户名称" maxLength="64"/>            </td>
			<td align="right">客户方编号</td>
			<td align="left">
			    <input type="text" class="text_field" name="internal_code" inputName="客户方编号" maxLength="64"/>            </td>
		</tr>
		<tr>
		  <td align="right">银行类别</td>
		  <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("bank_type_bd1", -1, "BANK_TYPE_BD", "", "", false) %> </td>
			<td align="right">银行卡状态</td>
			<td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_valid1", -1, "BANK_STATUS", "","", false) %> </td>
			<td align="right">账号</td>
			<td align="left">
			    <input type="text" class="text_field" name="account_num1" inputName="账号" maxLength="64"/>            </td>
		</tr>
		<tr>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>
			     <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
             </td>
             <td>   
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
		</tr>
</table>
</div>

<input type="hidden" name="empid" id="empid" value="">					
<div id="ccParent1" class="button"> 
	 <div class="button_right">
		<ul>
			<li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
	                 <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
	                 <li class="f">      <a  onClick="javascript:deleteMulti_onClick();">撤销 </a> </li>
	                 <li class="a">      <a  onClick="javascript:toReload_onClick();">刷新 </a> </li>
		</ul>
	</div>
    <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EpempcardAction.do?cmd=searchEmpCardData"
        submitAction="/FAERP/EpempcardAction.do?cmd=insertEmpCardData"
        width="99%"
        xpath="EpempcardVo"
        submitXpath="EpempcardVo"
        paramFormId="empcard_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
      </r:field>
       <r:field fieldName="emp_id" label="员工ID" width="0"/>
      <r:field fieldName="emp_name" label="员工姓名" width="100px"  editId="lookupID1">
           <w:lookup id="lookupID1"  validateAttr="allowNull=false" lookupUrl="/FAERP/jsp/faerp/employeepost/empinfo/epempcard/searchEmpName.jsp"  width="750" height="650" top="0"  dialogTitle="选择员工" readonly="true" onReturnFunc="returnFuncPosi"></w:lookup>    
       </r:field>    
      <r:field fieldName="emp_code" width="140px" label="唯一号">
        <h:text readonly="true"/>
      </r:field>
      <r:field fieldName="id_card" label="身份证号">
        <h:text readonly="true"/>
      </r:field>
      <r:field fieldName="cust_name" label="客户名称">
        <h:text readonly="true"/>
      </r:field>
      <r:field fieldName="cust_code" label="客户编号">
        <h:text readonly="true"/>
      </r:field>
      <r:field fieldName="bank_name" label="开户行名称">
        <h:text validateAttr="message=开户行名称不能为空;allowNull=false"/>
      </r:field>
      <r:field fieldName="account_num" label="账号">
        <h:text validateAttr="type=number;maxLength=20;message=账号输入有误;allowNull=false"/>
      </r:field>
      <r:field fieldName="account_name" label="账户名">
        <h:text validateAttr="message=账户名不能为空;allowNull=false"/>
      </r:field>
      <r:field fieldName="province_name" label="账号省名">
        <h:text validateAttr="message=账号省名不能为空;allowNull=false"/>
      </r:field>
      <r:field fieldName="city_area_name" label="账号市区名">
        <h:text validateAttr="message=账号市区名不能为空;allowNull=false"/>
      </r:field>
      <r:field fieldName="bank_type_bd" label="银行类别">
        <d:select dictTypeId="BANK_TYPE_BD" />
      </r:field>
      <r:field fieldName="city_code" label="城市编码">
        <h:text/>
      </r:field>
      <r:field fieldName="is_valid" label="银行卡状态">
        <d:select dictTypeId="BANK_STATUS" />
      </r:field>
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

