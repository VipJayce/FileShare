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
	    function getTree(product_dept,product_dept_name, basePath, inputType, rootCode, isSubmitAll, returnValueType, treeLevel, dataLimit){

        //树结点的类型，分radio和checkbox两种，默认radio
        if(inputType==null || inputType=="")
            inputType = "radio";

        //控制树的节点是否全带checkbox（radio），yes全带，no只有树的最末尾一层带
        if(isSubmitAll==null || isSubmitAll=="")
            isSubmitAll = "no";

        //返回值是哪个字段，可以选择partyrelation表的id、party_id和code三者之一，默认为code
        if(returnValueType==null || returnValueType=="")
            returnValueType = "party_id";
            
        //参数：控制树能展示到的层次，0 全部，1 公司，2 部门，3 岗位，-3 去除岗位，默认为0
        if(treeLevel == null || treeLevel=="") {
            treeLevel = "0";
        }
        
        //参数：是否控制数据权限,0 否，1 是
        if(dataLimit == null || dataLimit=="") {
            dataLimit = "0";
        }

        var treePath = basePath+"/jsp/authority/tree/treeRef.jsp?inputType="+inputType+"&nodeRelationType=noRelation&rootXmlSource="
                +basePath+"/jsp/authority/tree/orgTree.jsp?parent_code%3D"+rootCode+"%26submit_all%3D"+isSubmitAll+"%26return_type%3D"+returnValueType+"%26tree_level%3D"+treeLevel+"%26data_limit%3D"+dataLimit;
        
        var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
        if(rtObj != undefined && rtObj.length > 0){
            var allTextValue = "";
            var allTextName = "";
            for(var i=0; i<rtObj.length-1; i++) {
                allTextValue += rtObj[i]['returnValue'] + ",";
                allTextName += rtObj[i]['childName'] + ",";
            }
            allTextValue += rtObj[rtObj.length-1]['returnValue'];
            allTextName += rtObj[rtObj.length-1]['childName'];
            document.form.company_id.value=allTextValue;
            document.form.company_name.value=allTextName;
            showListData();
        } 
    }
    

    function showListData(){
        if($id("company_id").value==""){
        alert("公司名称不能为空！");
        return;
        }
        //alert("company_id="+$id("company_id").value);
        $id("companyid").value = $id("company_id").value;
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        
        $id("celllist2").loadData();
        $id("celllist2").refresh();
    }
 
    function resetDate(){
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        
        $id("celllist2").loadData();
        $id("celllist2").refresh();
    }


     function toSaveSub_onClick() {
            if($id("company_id").value==""){
		            alert("公司名称不能为空！");
		            return false;
            }else{
                    $id("celllist1").isModefied = true;
                    $id("celllist2").isModefied = true;
                    $id("celllist1").submit();
                    $id("celllist2").submit();
                    alert("保存成功！");
             }
     }  

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="2" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td width="461"/>
			<td width="434"/>
			  <td width="32">    </td>
            	<td width="8"/>
		</tr>
				<tr>
			<td colspan="2" align="right"><div align="center">分公司名称	
			  <input type="text" class="text_field_reference_readonly" validators="isSearch" name="company_name" inputName="分公司名称"  maxLength="10" value=""/><input type="hidden" name="company_id" id="company_id"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree('company_id', 'company_name','<venus:base/>','radio','','','','1','');"/>
			  <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
			  <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset(),resetDate()">            
			  </div></td>
			</tr>
</table>
</div>

<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="bc">      <a  onClick="javascript:toSaveSub_onClick();">保存 </a> </li>

                </ul>
                
         </div>
           <div class="clear"></div>            
</div>

 <input id="companyid" name="companyid" type="hidden"  value="" />
    <table cellpadding="0" style="padding:5 0 5 5;">
    <tr>
        <td valign="top">
            本地城市社保组<br>
            <r:datacell 
                id="celllist1"
                queryAction="/FAERP/AucomcityrelAction.do?cmd=searchData&is_local=1"
                submitAction="/FAERP/AucomcityrelAction.do?cmd=insertData&is_local=1"
                width="97%" height="310px"
                xpath="AucomcityrelVo"
                submitXpath="AucomcityrelVo"
                paramFormId="datacell_formid"
                >
        
              <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>
              <r:field fieldName="city_id" label="城市" width="150px">
                        <r:comboSelect id="countryList" name="city_id"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="150px"
                       nullText="请选择" />
              </r:field>
                <r:field fieldName="security_group_name" label="社保公积金组" allowModify="true">
		        <h:text />
		      </r:field>
            </r:datacell>
        </td>
        <td valign="top">
            异地城市社保组<br>
            <r:datacell 
                id="celllist2" 
                queryAction="/FAERP/AucomcityrelAction.do?cmd=searchData&is_local=0"
                submitAction="/FAERP/AucomcityrelAction.do?cmd=insertData&is_local=0"
                width="97%" height="310px"
                xpath="AucomcityrelVo"
                submitXpath="AucomcityrelVo"
                paramFormId="datacell_formid"
                >
        
              <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>           
              <r:field fieldName="city_id" label="城市" width="150px">
		               <r:comboSelect id="countryList1" name="city_id"
				       queryAction="PB_CITYAction.do?cmd=getListData"
				       textField="city_name"
				       valueField="id"
				       xpath="PB_CITYVo"
				       width="150px"
				       nullText="请选择" />
				       
              </r:field>
              <r:field fieldName="security_group_name" label="社保公积金组" allowModify="true">
                <h:text />
              </r:field>
            </r:datacell>
            
        </td>
     </tr>
   </table>
 
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">

    $id("celllist1").beforeAdd=function(){
            if($id("company_id").value==""){
            alert("公司名称不能为空！");
            return false;
            }
            return true;
    }
    
   $id("celllist2").beforeAdd=function(){
            if($id("company_id").value==""){
            alert("公司名称不能为空！");
            return false;
            }
    }
    
   jQuery(function(){
	   $id("celllist1").isQueryFirst = false;
	   $id("celllist2").isQueryFirst = false;
   });
   
   
    var field = {
	    entityField:"security_group_id",
	    fieldId:"security_group_id_9999",
	    fieldName:"security_group_id",
	    sort:"no",
	    allowResize:true,
	    label:"社保公积金组"
	  };    
	  var eos_orgEditor = null;
      
      
      var field2 = {
        entityField:"security_group_id",
        fieldId:"security_group_id_8888",
        fieldName:"security_group_id",
        sort:"no",
        allowResize:true,
        label:"社保公积金组"
      };    
      var eos_orgEditor2 = null;
  
    //实现beforeEdit接口
    $id("celllist1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var city_id = entity.getProperty("city_id");
        var orgEditor = null
        //alert(city_id);
        if (colIndex == 1){
            if (!$id("new_service_List" + colIndex) || eos_orgEditor == null){
                //div container
                var divA = $createElement("div");
                divA.id = "celllist1"+"_"+"security_group_id"+"_9999"+"_field_editor_container";
                divA.style.width = "0px";
                divA.style.height = "0px";
                divA.style.display = "none";
                var htmlString ="" ;
                htmlString += "<div id=\"new_service_List1_container\"  class=\"eos-ic-container\" >";
                htmlString += "<input class=\"eos-combo-select-editor-text\" type=\"text\" id=\"new_service_List1_input\" /><img id='new_service_List1_button' class='eos-ic-button'  /><input type=\"hidden\" id=\"new_service_List1_hidden\" name=\"new_service_List1\" />";
                htmlString += "</div>";          
                //append them
                divA.innerHTML = htmlString;
                //alert(divA.toString());
                document.body.appendChild(divA);
                //alert("run hear");     
                eos_orgEditor =new ComboSelect('new_service_List' + colIndex); 
                eos_orgEditor.queryAction = "/FAERP/AucomcityrelAction.do?cmd=getSecurityGroupList"
                eos_orgEditor.xpath = "SecuritygroupVo"; 
                eos_orgEditor.valueField = "id"; 
                eos_orgEditor.textField = "group_name"; 
                eos_orgEditor.isIeMode = false; 
                eos_orgEditor.readOnly = false; 
                eos_orgEditor.allowInput = false; 
                eos_orgEditor.allowFilter = true; 
                eos_orgEditor.disabled = false; 
                eos_orgEditor.nullText = "请选择";
                eos_orgEditor.onPageLoad();
            }
            orgEditor = eos_orgEditor;
            var dc1 = $id("celllist1");
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
    $id("celllist1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("security_group_name") >= 0){
            var orgEditor = eos_orgEditor;
            activeEntity.setProperty("security_group_name", orgEditor.getDisplayValue(newValue));
        }
        return true;
    } 
    
    
    
        //实现beforeEdit接口
    $id("celllist2").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var city_id = entity.getProperty("city_id");
        var orgEditor = null
       // alert(city_id);
        if (colIndex == 1){
            if (!$id("new_service2_List" + colIndex) || eos_orgEditor2 == null){
                //div container
                var divA = $createElement("div");
                divA.id = "celllist2"+"_"+"security_group_id"+"_8888"+"_field_editor_container";
                divA.style.width = "0px";
                divA.style.height = "0px";
                divA.style.display = "none";
                var htmlString ="" ;
                htmlString += "<div id=\"new_service2_List1_container\"  class=\"eos-ic-container\" >";
                htmlString += "<input class=\"eos-combo-select-editor-text\" type=\"text\" id=\"new_service2_List1_input\" /><img id='new_service2_List1_button' class='eos-ic-button'  /><input type=\"hidden\" id=\"new_service2_List1_hidden\" name=\"new_service2_List1\" />";
                htmlString += "</div>";          
                //append them
                divA.innerHTML = htmlString;
                //alert(divA.toString());
                document.body.appendChild(divA);
                //alert("run hear");     
                eos_orgEditor2 =new ComboSelect('new_service2_List' + colIndex); 
                eos_orgEditor2.queryAction = "/FAERP/AucomcityrelAction.do?cmd=getSecurityGroupList"
                eos_orgEditor2.xpath = "SecuritygroupVo"; 
                eos_orgEditor2.valueField = "id"; 
                eos_orgEditor2.textField = "group_name"; 
                eos_orgEditor2.isIeMode = false; 
                eos_orgEditor2.readOnly = false; 
                eos_orgEditor2.allowInput = false; 
                eos_orgEditor2.allowFilter = true; 
                eos_orgEditor2.disabled = false; 
                eos_orgEditor2.nullText = "请选择";
                eos_orgEditor2.onPageLoad();
            }
            orgEditor = eos_orgEditor2;
            var dc1 = $id("celllist2");
            this.activeField = field2 ? field2 : null;
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
    $id("celllist2").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("security_group_name") >= 0){
            var orgEditor = eos_orgEditor2;
            activeEntity.setProperty("security_group_name", orgEditor.getDisplayValue(newValue));
        }
        return true;
    } 
  
  
</script>	
