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
    function toselect_onclick() { 
        $id("dc_Applyinsuranceid").reload() ;
    }
    function toupdate_onclick() { 
       if(confirm('您确定执行该操作?该操作会提交当页所有数据!')) {
        var dc1 = $id("dc_Applyinsuranceid");
        var ajax = new HideSubmit("/FAERP/ApplyinsuranceAction.do?cmd=updateApplyinsurance");
        ajax.loadData(dc1.dataset.toString());
        xmlDom = ajax.retDom;
        var ret = xmlDom.selectSingleNode("/root/data/returnValue");    
         $id("dc_Applyinsuranceid").reload() ;
     }
    }
    //全部办理加退保
 function toupdate_all_onclick() { 
       if(confirm('您确定执行该操作?该操作会提交本次所有数据!')) {
       var action="<%=request.getContextPath()%>/ApplyinsuranceAction.do?cmd=updateApplyinsuranceForAll";
          var myAjax = new Ajax(action);
          if (datacell_formid) {
                for (var i = 0; i < datacell_formid.elements.length; i++) {
                    var elem = datacell_formid.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
              myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom(); 
              if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue")=="true" ) {
                    alert("办理完成");
                      $id("dc_Applyinsuranceid").reload() ;
                       }
         }else{
         alert("系统出错，请重新查询后办理或联系管理员！");
         }
    }
    }
    
    
    
    function export_submit(){
	    if(confirm('确定导出数据')) {
	        $id("datacell_formid").submit() ;
	    }
    }
   function addchil_onclick(){
        var dc = $id("dc_Applyinsuranceid");
        var clz = dc.getActiveEntity();
        if(!clz){
            alert("请先选择一条记录");
            return ;
        }
        var apply_status_bd = clz.getValue("apply_status_bd");
        var apply_type_bd = clz.getValue("apply_type_bd");
        var sfyfxr = clz.getValue("sfyfxr");
        
        if(sfyfxr !='1'){
            alert("只有能添加付险人的产品才能添加付险人") ;
            return false ;
        }
        if(apply_type_bd !='1'){
            alert("只有加保才能添加付险人") ;
            return false ;
        }
        if(apply_status_bd =='0'){
            alert("只有已经加保过才能添加付险人") ;
            return false ;
        }
        var apply_insurance_id = clz.getValue("id");
        var emp_id = clz.getValue("emp_id");
        url="<%=request.getContextPath()%>/jsp/faerp/insurance/addbackinsuranceitem/listAddbackinsuranceitem.jsp?apply_insurance_id="+apply_insurance_id+"&emp_id="+emp_id ;
        showModalCenter(url, window, "", 1100, 530, '附险人维护');  
    }
    
    
     function rtnFunc(arg){
        var lookup = $id("policy_name");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];   
        return false ;
    }
</script>
</head>
<body>

<form name="datacell_formid" id="datacell_formid" method="post" action="<%=request.getContextPath()%>/ApplyinsuranceAction.do?cmd=exportAddBackInsurance">
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"> 加退保管理</div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">  
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="146" rowspan="4" valign="top"><div class="search_title">查询条件</div></td>
        <td width="99">产品名称</td>
        <td width="226"><input name="product_name_s" type="text" class="sText" id="product_name_s" value=""/></td>
        <td width="78">办理类型</td>
        <td width="260"><span class="td_2">
        <d:select dictTypeId="APPLY_TYPE_BD" name="apply_type_bd_s"  property="apply_type_bd_s" id="apply_type_bd_s"   style="width:190px" />
        </span>
        <td>
      办理状态 
</td>
        <td><h:select property="apply_status_bd_s" name="apply_status_bd_s" style="width:180px" id="apply_status_bd_s">
                        <h:option value="0" label="待办理" />
                        <h:option value="1" label="已办理"/>
                        <h:option value="2" label="延期办理"/>
                  </h:select></td>
        
      </tr>
      <tr>
        </td>
        <td width="83">福利开始日期</td>
        <td width="200">
        <w:date format="yyyy/MM/dd" id="start_date_s" name="start_date_s" width="170px"/>
        </td>
        
        <td width="83">福利结束日期</td>
        <td width="200">
        <w:date format="yyyy/MM/dd" id="end_date_s" name="end_date_s" width="170px"/>
        </td>
        <td>员工姓名</td>
        <td><input name="emp_name_s" type="text" class="sText" id="emp_name_s" value=""/></td>
      </tr>
      <tr>
        <td>唯一号 
</td>
        <td><input name="emp_code_s" type="text" class="sText" id="emp_code_s" value=""/></td>
        <td>保单名称</td>
        <td>
      <w:lookup onReturnFunc="rtnFunc" readonly="true" id="policy_name" name="policy_name" lookupUrl="/PolicyAction.do?cmd=toPolicyLookup"  dialogTitle="选择保单" height="480"  width="770"/>
       </td>
        <td width="90">产品三级类别</td>
        <td width="218">
        <r:comboSelect
                id="productid" name="productid"
                queryAction="/FAERP/ProductAction.do?cmd=getAllThreetypeProduct"
                textField="product_name" valueField="three_type_id" xpath="ProductVo"
                width="170px" nullText="请选择" />
            </span>
            <input name="product_type_id" type="hidden" class="sText" id="product_type_id"  />
        </td>
      </tr>
       <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td width="65">&nbsp;</td>
        <td width="218"><input name="button1" type="button" class="icon_1" onclick="toselect_onclick()" value="查询" /></td>
      </tr>
      </table>
  </div>
    <!--查询 end-->
    <!--按钮-->
        <div class="button">
            <div class="button_right">
                <!--<ul>
                  <li class="bl_2"><a onclick="toupdate_onclick()">加退保办理</a></li>
                  <li class="e"><a onclick="export_submit()">导出</a></li> 
                  <li class="bl_2"><a onclick="addchil_onclick()">添加附险人</a></li>
                </ul>
                --><input class="bl_2" type="button"   value="加退保办理"  <au:authorityBtn code="jtbbl_jtbbl" type="1"/>  onClick="toupdate_onclick();">
                <input class="e" type="button"   value="导出"  <au:authorityBtn code="jtbbl_exp" type="1"/>  onClick="export_submit();">
                <input class="bl_2" type="button"   value="添加附险人"  <au:authorityBtn code="jtbbl_tjfxr" type="1"/>  onClick="addchil_onclick();">
                <input class="bl_4" type="button"   value="加退保办理（全部）"  <au:authorityBtn code="jtbbl_jtbbl_all" type="1"/>  onClick="toupdate_all_onclick();">
            </div>
            <div class="clear"></div>
        </div>
    <!--按钮 end-->
    <!--表格 -->
    <div class="" id="values_div"> 
    <r:datacell id="dc_Applyinsuranceid"
            queryAction="/FAERP/ApplyinsuranceAction.do?cmd=SearchApplyinsurance"
            submitAction="/FAERP/ApplyinsuranceAction.do?cmd=updateApplyinsurance"
            width="100%" xpath="ApplyinsuranceVo" submitXpath="ApplyinsuranceVo"
            paramFormId="datacell_formid" height="340px" pageSize="50">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="emp_code" label="唯一号" width="100px">
            </r:field>
            <r:field fieldName="emp_name" label="姓名" width="100px">
            </r:field>
            <r:field fieldName="policy_name" label="保单名称" width="180px">
            </r:field>
            <r:field fieldName="emp_sex" label="性别" width="100px">
             <h:select property="emp_sex" disabled="true">
                         <h:option value="1" label="男"/>
                         <h:option value="0" label="女"/>
                  </h:select>
            </r:field>
            <r:field fieldName="birth_date" label="出生日期" width="100px">
            <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
            </r:field>
            <r:field fieldName="id_card" label="身份证号" width="100px">
            </r:field>
            <r:field fieldName="product_name" label="产品名称" width="130px">
            </r:field>
            <r:field fieldName="apply_status_bd" label="办理状态" width="100px">
            <h:select property="apply_status_bd" disabled="true">
                         <h:option value="1" label="已办理"/>
                         <h:option value="0" label="待办理"/>
                  </h:select>
            </r:field>
            <r:field fieldName="apply_type_bd" label="办理类型" width="100px">
                <d:select dictTypeId="APPLY_TYPE_BD" disabled="true"/>
            </r:field>
            <r:field fieldName="insurance_property_bd" label="医保属性" width="100px">
             <h:select property="insurance_property_bd" disabled="true">
                         <h:option value="1" label="有医保"/>
                         <h:option value="0" label="无医保"/>
                  </h:select>
            </r:field>
            <r:field fieldName="city_name" label="医保属地" width="100px">
            </r:field>
            <r:field fieldName="apply_date" label="福利办理日期" width="100px">
            <w:date format="yyyy-MM-dd"  /> 
            </r:field>
            <r:field fieldName="remark" label="备注" width="200px">
            </r:field>
            <r:field fieldName="chil_name" label="子女姓名" width="100px">
            </r:field>
            <r:field fieldName="chil_sex_bd" label="子女性别" width="100px">
            <h:select property="chil_sex_bd" disabled="true">
                         <h:option value="1" label="男"/>
                         <h:option value="0" label="女"/>
                  </h:select>
            </r:field>
            <r:field fieldName="chil_birthday" label="出生日期" width="100px">
               <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
            </r:field>
            <r:field fieldName="chil_applicant_date" label="子女投保日期" width="100px">
            <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
            </r:field>
            <!--<r:field fieldName="chil_append_item" label="子女福利附加项" width="120px">
            </r:field>
            --><!--<r:field fieldName="chil_append_item" label="比例" width="100px">
            </r:field>
            <r:field fieldName="chil_append_item" label="主被保险人原比例" width="100px">
            </r:field>
            <r:field fieldName="chil_append_item" label="主被保险人现比例" width="100px">
            </r:field>
            <r:field fieldName="chil_append_item" label="连带保险人原比例" width="100px">
            </r:field>
            <r:field fieldName="chil_append_item" label="连带保险人现比例" width="100px">
            </r:field>
            <r:field fieldName="chil_append_item" label="变更生效日期" width="100px">
            <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
            </r:field>
        -->
        </r:datacell>
  </div>
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>