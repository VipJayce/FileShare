<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datacell</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        /*
        for(var pops in entity){
            alert(pops + "=" + entity[pops]);
        }
        */
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("city_id") + "\");>";//city_idList
    }

	   function ClickRow(value,value1){
	        $id("security_group_id").value = value;
	        $id("selectcity_id").value = value1;
	        //$id("product_id").addParam("security_group_id",value);
	        //$id("product_id").addParam("city_id",value1);
	        $id("product_id").queryParam= "<param><key>security_group_id</key><value>" + value + "</value><key>city_id</key><value>" + value1 + "</value></param>";
	        $id("celllist1").addParam("security_group_id", $id("security_group_id").value);
	        $id("celllist1").loadData();
	        //$id("celllist1").refresh();
	        $id("product_id").loadData();
	        $id("product_id").refresh();
	        $id("celllist1").refresh();
	
	        $id("celllist2").loadData();
	        $id("celllist2").refresh();
	        
	        $id("celllist3").loadData();
	        $id("celllist3").refresh();
	    }
    
	    function showListData(){
	        $id("datacell1").loadData();
	        $id("datacell1").refresh();
	        $id("security_group_id").value = "";
            $id("selectcity_id").value = "";
	        $id("celllist1").paramList = [];
	        $id("celllist2").paramList = [];
	        $id("celllist3").paramList = [];
	        $id("celllist1").loadData();      
	        $id("celllist1").refresh();
    
            $id("celllist2").loadData();
            $id("celllist2").refresh();
            
            $id("celllist3").loadData();
            $id("celllist3").refresh();
	    }

		function toAdd_onClick() { 
		    $id("datacell1").addRow();
		}
		
		function deleteMulti_onClick(){
		    if(!choose_row("security_group_id")){
               return;
            }
            if(!confirm('是否确定要删除选择的数据？')) {
                return;
            }
            $id("datacell1").isModefied = true;
            $id("datacell1").deleteRow();
            if($id("datacell1").submit()){
            alert("操作成功！");
             $id("security_group_id").value = "";
            $id("selectcity_id").value = "";
            }
		}
		function toSave_onClick() {
		    $id("datacell1").submit();
		}   
		function toReload_onClick() {
		     $id("security_group_id").value = "";
            $id("selectcity_id").value = "";
		    $id("datacell1").reload();
		}
           
       //导出数据
       function exportToExcel() {  
	       if(confirm('是否确定要导出数据？')) {
	        form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=exportToExcel";
	        form.submit();
	        }
	    }  
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input id="security_group_id" name="security_group_id" type="hidden"  value="" />
<input id="selectcity_id" name="selectcity_id" type="hidden"  value="" />
<div id="right">
	<script language="javascript">
		writeTableTopFesco('社保公积金分组管理','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
                <tr>
            <td align="right">省市</td>
            <td align="left">
            <r:comboSelect id="city_idList_search" name="city_id1"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
            </td>
            <td align="right">社保组名称</td>
            <td align="left"><input type="text" class="text_field" name="group_name" inputName="社保组名称" maxLength="20" value=""/>            </td>
            <td width="100" align="right">入职服务名称</td>
            <td width="213" align="left">
            <r:comboSelect id="service_List" name="service_id"
                       queryAction="/FAERP/PbserviceAction.do?cmd=getServiceList&param=search"
                       valueField="id"
                       textField="service_name"
                       xpath="PbserviceVo"
                       width="200px"
                       linkId="city_idList_search"
                       nullText="请选择" />
            
            </td>
        </tr>
        
        
        <tr>
            <td align="right">年度调整月</td>
            <td align="left">
                <input type="text" class="text_field" name="adjust_month" inputName="年度调整月" onkeyup="value=this.value.replace(/\D/g,'')" maxLength="8" value=""/>           </td>
            <td align="right">办理截止日</td>
                        <td align="left">
            <input type="text" class="text_field"  style="width:90px" name="transact_day_from" value="" maxLength="3" onkeyup="value=this.value.replace(/\D/g,'')" id="transact_day_from" inputName="每月办理截止日"/>&nbsp;到&nbsp;<input type="text" class="text_field" style="width:90px" maxLength="3" onkeyup="value=this.value.replace(/\D/g,'')" name="transact_day_to" value=""  id="transact_day_to" inputName="每月办理截止日"/></td>
            <td align="right">停办截止日</td>
                        <td align="left">
                <input type="text" class="text_field"  style="width:90px" name="stop_day_from" value="" maxLength="3" onkeyup="value=this.value.replace(/\D/g,'')" id="stop_day_from" inputName="每月停办截止日"/>&nbsp;到&nbsp;<input type="text" class="text_field" style="width:90px" maxLength="3" onkeyup="value=this.value.replace(/\D/g,'')" name="stop_day_to" value="" id="stop_day_to" inputName="每月停办截止日"/></td>
        </tr>
        
        <tr>
            <td/>
            <td/>
              <td>&nbsp;</td>
                <td/><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
        </tr>
</table>
</div>


<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
                    <li class="a">      <a  onClick="javascript:toReload_onClick();">刷新 </a> </li>
                    <li class="e_3">   <a onClick="javascript:exportToExcel();">导出分组</a> </li>
                </ul>
         </div>
           <div class="clear"></div>            
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SecuritygroupAction.do?cmd=searchSecurityGroupData"
        submitAction="/FAERP/SecuritygroupAction.do?cmd=insertSecurityGroupData"
        width="98%"
        height="318px"
        xpath="SecuritygroupVoExt"
        submitXpath="SecuritygroupVoExt"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>           
      <r:field fieldName="city_id" label="城市" width="100px" sortAt="s">
                        <r:comboSelect id="countryList" name="city_id"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="150px"
                       nullText="请选择" />
       </r:field>    
      <r:field fieldName="group_name" width="140px" label="社保组名称" sortAt="server">
        <h:text validateAttr="maxLength=20;message=社保组名称输入太长;allowNull=true"/>
      </r:field>
      <r:field fieldName="service_name" label="入职服务名称" allowModify="true" sortAt="server">
        <h:text/>
      </r:field>
      <r:field fieldName="group_type_bd" label="社保组类别" sortAt="server">
        <d:select dictTypeId="GROUP_TYPE_BD" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="adjust_month" label="年度调整月" sortAt="server">
        <h:text validateAttr="minValue=1;maxValue=12;maxLength=2;type=integer;message=年度调整月输入有误;allowNull=false"/>
      </r:field>
      <r:field fieldName="transact_day" label="每月办理截止日" sortAt="server">
        <h:text validateAttr="minValue=1;maxValue=31;maxLength=2;type=integer;message=每月办理截止日输入有误;allowNull=false"/>
      </r:field>
      <r:field fieldName="stop_day" label="每月停缴截止日" sortAt="server">
        <h:text validateAttr="minValue=1;maxValue=31;maxLength=2;type=integer;message=每月停缴截止日输入有误;allowNull=false"/>
      </r:field>
      <r:field fieldName="ss_collection_type_bd" label="保险托收" sortAt="server">
        <d:select dictTypeId="SS_COLLECTION_TYPE" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="collection_type_bd" label="托收方式" sortAt="server">
        <d:select dictTypeId="COLLECTION_TYPE_BD" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="stop_month_type_bd" label="停办方式" sortAt="server">
        <d:select dictTypeId="STOP_MONTH_TYPE_BD" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="supply_month_type_bd" label="补缴月类型" sortAt="server">
        <d:select dictTypeId="SUPPLY_MONTH_TYPE_BD" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="is_default_show" label="是否默认显示" sortAt="server">
        <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="bind_radix_bd" label="绑定基数" sortAt="server">
       <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="use_account_or_num_bd" label="使用员工账号" sortAt="server">
       <d:select dictTypeId="USE_ACCOUNT_OR_NUM" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="e_pay_policy_bd" label="企业支付方式" sortAt="server">
        <d:select dictTypeId="E_PAY_POLICY_BD" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="p_pay_policy_bd" label="个人支付方式" sortAt="server">
       <d:select dictTypeId="P_PAY_POLICY_BD" extAttr="validateAttr='allowNull=false'"/>
      </r:field>
      <r:field fieldName="explanation" label="说明">
        <h:text/>
      </r:field>
    </r:datacell>
    </div>

<div style="display:" id="div1">
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="bc">      <a  onClick="javascript:toSaveSub_onClick();">保存</a> </li>
                </ul>
         </div>
           <div class="clear"></div>            
</div>

<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
    <tr>
        <td valign="top" width="40%">下属产品比例<br>
                <r:datacell 
				        id="celllist1"
				        isCount="false"
				        paramFormId="datacell_formid"
				        queryAction="/FAERP/SecuritygrouprelAction.do?cmd=searchSecurityGroupData"
				        submitAction="/FAERP/SecuritygrouprelAction.do?cmd=insertSecurityGroupData"
				        width="97%" height="200px"
				        xpath="SecuritygrouprelVo"
                        submitXpath="SecuritygrouprelVo"
				        >
				
				      <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>
				      <r:field fieldName="security_product_id" label="社保公积金产品" width="100px">
						      <r:comboSelect id="product_id" name="security_product_id"
		                       queryAction="SecurityproductAction.do?cmd=getProductListData"
		                       textField="product_name"
		                       valueField="id"

		                       xpath="SecurityproductVo"
		                       width="100px"
		                       nullText="请选择" />
				      </r:field>
				      <r:field fieldName="month_pay_bd" label="是否每月支付">
				        <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'"/>
				      </r:field>
				      <r:field fieldName="is_supply" label="是否可补收">
				        <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'"/>
				      </r:field>
				      <r:field fieldName="serial_no" label="比例排序">
				        <h:text/>
				      </r:field>
				    </r:datacell>
        </td>
        <td valign="top" width="35%">
            新开类别<br>
				    <r:datacell 
				        id="celllist2"
				        paramFormId="datacell_formid"
                        queryAction="/FAERP/SecuritygroupnewAction.do?cmd=searchSecurityGroupData"
                        submitAction="/FAERP/SecuritygroupnewAction.do?cmd=insertSecurityGroupData"
				        width="97%" height="200px"
				        xpath="SecuritygroupnewVo">
				
				      <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>
				      <r:field fieldName="type_code" label="新开类型编码">
				        <h:text/>
				      </r:field>
				      <r:field fieldName="type_name" label="新开类型名称">
				        <h:text/>
				      </r:field>
				      <r:field fieldName="is_oneoff" label="是否是一次性补缴方式" width="150px">
				        <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'"/>
				      </r:field>
				    </r:datacell>
            
        </td>
		<td valign="top" width="25%">
            停办类别<br>
	                <r:datacell 
			        id="celllist3"
			        paramFormId="datacell_formid"
                    queryAction="/FAERP/SecuritygroupstopAction.do?cmd=searchSecurityGroupData"
                    submitAction="/FAERP/SecuritygroupstopAction.do?cmd=insertSecurityGroupData"
			        width="100%" height="200px"
			        xpath="SecuritygroupstopVo">
			
			      <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>
			      <r:field fieldName="type_code" label="停办类型编码">
			        <h:text/>
			      </r:field>
			      <r:field fieldName="type_name" label="停办类型名称">
			        <h:text/>
			      </r:field>
			    </r:datacell>
            
        </td>
     </tr>
   </table>
</div>
   
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script>
      //添加记录前判断是否选择了主表记录
      $id("celllist1").beforeAdd=function(){
         if(!choose_row("security_group_id")){
         return false;
         }
         return true;
      }
      //添加记录前判断是否选择了主表记录
      $id("celllist2").beforeAdd=function(){
         if(!choose_row("security_group_id")){
         return false;
         }
         return true;
      }
      //添加记录前判断是否选择了主表记录
      $id("celllist3").beforeAdd=function(){
         if(!choose_row("security_group_id")){
         return false;
         }
         return true;
      }
     //保存子记录
     function toSaveSub_onClick() {
             if(choose_row("security_group_id")){
                    $id("celllist1").isModefied = true;
                    $id("celllist2").isModefied = true;
                    $id("celllist3").isModefied = true;
                    if($id("celllist1").submit()&&$id("celllist2").submit()&&$id("celllist3").submit()){
                        alert("保存成功！");
                    }
             }
     }  
     
       function choose_row(tagid) {
             if($id(tagid).value==""){
                    alert("请选择一条主表记录！");
                    return false;
             }
             return true;
        }



    function choose_datacell_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }
    
    
    
 var field = {
    entityField:"service_id",
    fieldId:"service_id_9999",
    fieldName:"service_id",
    sort:"no",
    allowResize:true,
    label:"入职服务名称"
  };    
  var eos_orgEditor = null;
// --      完成定义替换combselect的全局对象                   //


	$id("datacell1").afterSubmit= function(ajax){
	           //alert("ajax="+ajax.getProperty("returnValue"));
	}

    //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var city_id = entity.getProperty("city_id");
        var orgEditor = null
        //alert(city_id);
        if (colIndex == 3){
            if (!$id("new_service_List" + colIndex) || eos_orgEditor == null){
                //div container
                var divA = $createElement("div");
                divA.id = "datacell1"+"_"+"service_id"+"_9999"+"_field_editor_container";
                //alert(divA.style);
                divA.style.width = "0px";
                divA.style.height = "0px";
                //divA.style.z-index = "999";
                divA.style.display = "none";
                
                var htmlString ="" ;
                htmlString += "<div id=\"new_service_List3_container\"  class=\"eos-ic-container\" >";
                htmlString += "<input class=\"eos-combo-select-editor-text\" type=\"text\" id=\"new_service_List3_input\" /><img id='new_service_List3_button' class='eos-ic-button'  /><input type=\"hidden\" id=\"new_service_List3_hidden\" name=\"new_service_List3\" />";
                htmlString += "</div>";
                                
                //append them
                divA.innerHTML = htmlString;
                //alert(divA.toString());
                document.body.appendChild(divA);
                //alert("run hear");
                            
                eos_orgEditor =new ComboSelect('new_service_List' + colIndex); 
                eos_orgEditor.queryAction = "PbserviceAction.do?cmd=getServiceList4DC"; 
                eos_orgEditor.xpath = "PbserviceVo"; 
                eos_orgEditor.valueField = "id"; 
                eos_orgEditor.textField = "service_name"; 
                eos_orgEditor.isIeMode = false; 
                eos_orgEditor.readOnly = false; 
                eos_orgEditor.allowInput = false; 
                eos_orgEditor.allowFilter = true; 
                eos_orgEditor.disabled = false; 
                eos_orgEditor.nullText = "请选择";
                eos_orgEditor.onPageLoad();
            }
            orgEditor = eos_orgEditor;
            var dc1 = $id("datacell1");
            this.activeField = field ? field : null;
            this.activeField.editor = orgEditor;
            this.activeEditor = this.activeField ? this.activeField.editor : null;
            orgEditor.paramList = null;
            orgEditor.addParam("city_id",""+city_id);
            orgEditor.init();
            orgEditor.loadData();
            orgEditor.refresh(); 
        }
        return true;
    }
   //实现on updateCell
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        //alert(activeCell.getAttribute("fieldId").indexOf("service_name2"));
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("service_name") >= 0){
	        var orgEditor = eos_orgEditor;
	        activeEntity.setProperty("service_name", orgEditor.getDisplayValue(newValue));
        }
        return true;
    } 

//$id("datacell1").beforeEdit= function(cell,colIndex,rowIndex){
/*
    if(colIndex==3){
      //alert( $id("product_id").getFilterNum());
        var comS = $id("service_idList");
        var rows = comS.optionsTable.tBodies[0].rows;
        var fValue = "1099110100000000050";
        //fValue= fValue || comS.inputObject.value || "" ;
        fValue = fValue.toLowerCase();
        var f=0;
        var newFirst=null;
        var _newSelectRow=false;
        for (var i=0;i<rows.length;i++ ){
            var entity=comS.dataset.get(i);
            var eValue=entity?entity.getProperty(comS.filterField):null;
            //alert(eValue);
            comS.dataset.removeEntity(comS.dataset.get(i), true);
            alert(comS.dataset.getLength());
            if (comS.selectOptionRow==rows[i]){
                _newSelectRow=true;
            }
        }
    }
*/
//}

       function choose_row(tagid) {
             if($id(tagid).value==""){
                    alert("请选择一条记录！");
                    return false;
             }
             return true;
        }

</script>


