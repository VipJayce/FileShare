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
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("security_group_id") + "\",\"" + entity.getProperty("id") + "\");>";//city_idList
    }

	   function ClickRow(value,value1){
	        $id("security_group_id").value = value;
	        $id("selectid").value = value1;
	        //$id("product_id").addParam("security_group_id",value);
	        //$id("product_id").addParam("city_id",value1);
	        //$id("security_product_id").queryParam= "<param><key>group_id</key><value>" + value + "</value><key>group_shortcut_id</key><value>" + value1 + "</value></param>";
	        $id("security_product_id").queryParam= "<param><key>group_id</key><value>" + value+","+value1 + "</value></param>";
	        $id("celllist1").addParam("security_group_id", $id("security_group_id").value);
	        //alert($id("security_group_id").value);
	        $id("celllist1").addParam("selectid",$id("selectid").value);
	        //alert($id("selectid").value);
	        $id("celllist1").loadData();
	        //$id("celllist1").refresh();
	        //alert("11111");
	        $id("security_product_id").loadData();
	        //alert("222222");
	        $id("security_product_id").refresh();
	        //alert("333333");
	        $id("celllist1").refresh();
	    }
    
	    function showListData(){
	        $id("datacell1").loadData();
	        $id("datacell1").refresh();
	        $id("security_group_id").value = "";
            $id("selectid").value = "";
	        $id("celllist1").paramList = [];
	        $id("celllist1").loadData();      
	        $id("celllist1").refresh();
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
            $id("selectid").value = "";
            }
		}
		function toSave_onClick() {
		    $id("datacell1").submit();
		}   
		function toReload_onClick() {
		     $id("security_group_id").value = "";
            $id("selectid").value = "";
		    $id("datacell1").reload();
		}
           
       //导出数据
      // function exportToExcel() {  
	     //  if(confirm('是否确定要导出数据？')) {
	    //    form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=exportToExcel";
	   //    form.submit();
	  //      }
	 //   }  
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input id="security_group_id" name="security_group_id" type="hidden"  value="" />
<input id="selectid" name="selectid" type="hidden"  value="" />
<div id="right">
	<script language="javascript">
		writeTableTopFesco('社保组快捷设定','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td></td>
        </tr>
                <tr>
            <td align="right">社保组快捷名称&nbsp;&nbsp;</td>
            <td align="left"><input type="text" class="text_field" name="group_shortcut_name"  value=""/> </td>
           
            <td align="right">社保组名称&nbsp;&nbsp;</td>
            <td align="left">
            <r:comboSelect id="security_group_id1" name="group_name1"
            queryAction="/FAERP/SecuritygroupAction.do?cmd=getListData"
            textField="group_name"
            valueField="id"
            xpath="SecuritygroupVo"
            width="200px"
            nullText="请选择"
            ></r:comboSelect>
             </td>
             <td><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()"></td>
                  </tr>
</table>
</div>


<div id="ccParent1" class="button"> 

<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
    <tr>
    <td>
  <div style="display:" id="div1">
 <div class="button_right">
                <ul>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
                    <li class="a">      <a  onClick="javascript:toReload_onClick();">刷新 </a> </li>
                </ul>
         </div>
           <div class="clear"></div>            
</div>
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SecuritygroupAction.do?cmd=searchShortcutSecurityGroupData"
        submitAction="/FAERP/SecuritygroupAction.do?cmd=insertShortcutSecurityGroupData"
        width="98%"
        height="320px"
        xpath="SecuritygroupShortcutVo"
        submitXpath="SecuritygroupShortcutVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
         <r:field fieldName="security_group_id" label="社保组名称" sortAt="server" width="120px">
      <r:comboSelect id="security_group_id" name="group_name"
            queryAction="/FAERP/SecuritygroupAction.do?cmd=getListData"
            textField="group_name"
            valueField="id"
            xpath="SecuritygroupVo"
            width="200px"
            nullText="请选择"
            ></r:comboSelect>
      </r:field> 
       <r:field fieldName="group_shortcut_name" width="140px" label="社保组快捷名称" sortAt="server">
        <h:text validateAttr="maxLength=20;message=社保组名称输入太长;allowNull=true"/>
      </r:field>   
      <r:field fieldName="city_name" label="城市" width="100px" sortAt="s" allowModify="false">
       </r:field>    
     
    </r:datacell>
    </td>
        <td >
            <div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="bc">      <a  onClick="javascript:toSaveSub_onClick();">保存</a> </li>
                </ul>
         </div>
           <div class="clear"></div>            
</div>
                <r:datacell 
				        id="celllist1"
				        isCount="false"
				        paramFormId="datacell_formid"
				        queryAction="/FAERP/SecuritygrouprelAction.do?cmd=searchShortcutSecurityGroupData"
				        submitAction="/FAERP/SecuritygrouprelAction.do?cmd=insertShortcutSecurityGroupData"
				        width="98%" height="320px"
				        xpath="SecuritygroupShortcutItemVo"
                        submitXpath="SecuritygroupShortcutItemVo"
				        >
				      <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>
				      <r:field fieldName="security_product_id" label="产品比例名称" width="215px">
						      <r:comboSelect id="security_product_id" name="security_product_id"
		                       queryAction="/FAERP/SecurityproductAction.do?cmd=getShortcutListData"
		                       textField="product_name"
		                       valueField="id"
		                       xpath="SecurityproductVo"
		                       width="100px"
		                       nullText="请选择" />
				      </r:field>
				      <r:field fieldName="productname" label="产品名称" width="200px"></r:field>
				    </r:datacell>
        </td>
     </tr>
   </table>
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
     //保存子记录
     function toSaveSub_onClick() {
             if(choose_row("security_group_id")){
                    $id("celllist1").isModefied = true;
                    var temp=document.getElementById("security_product_id").value;
                    if(temp==""){
                        alert("请选择产品");
                    }
                     //if($id("celllist1").submit())
                   else if($id("celllist1").submit()){
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

//初始化不加载页面信息<siqp添加>
_$(function(){
    $id("celllist1").isQueryFirst = false;
});
</script>


