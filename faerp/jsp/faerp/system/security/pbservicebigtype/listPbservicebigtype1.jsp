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
    jQuery(function(){
        $id("datacell2").isQueryFirst = false;
    });
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
    
    function setCheckbox(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow1(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow(value1){
        $id("big_type_id").value = value1;
        
        $id("datacell2").addParam("big_type_id",value1);
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
    
    function ClickRow1(value1){
        $id("small_type_id").value = value1;
    }
    
    function addBigType(){
        showModalCenter('<%=request.getContextPath()%>/jsp/faerp/system/security/pbservicebigtype/insertBigType.jsp',window,refesh,750,250,"新增大分类");
    }
    
    function refesh(ref){
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    function saveBigType() {
        $id("datacell1").isModefied = true;
        
        var v_datacell = $id("datacell1").dataset;
        var len1 = v_datacell.getLength();
        for(var i =0 ; i < len1 ; i++){
            var big_name=v_datacell.get(i).getProperty("name");
            var city_id=v_datacell.get(i).getProperty("city_id");
            if(big_name==null||big_name==""){
                alert("大分类名称不能为空！");
                return;
            }
            if(city_id==null||city_id==""){
                alert("城市不能为空！");
                return;
            }
        }
         if($id("datacell1").submit()){
           alert("大分类修改成功！");
           $id("datacell1").loadData();
           $id("datacell1").refresh();
           $id("datacell2").loadData();
           $id("datacell2").refresh();
        }
    }
    
    function adddSmallType(){
        var big_type_id = document.getElementById("big_type_id").value;
        if(big_type_id == null || big_type_id == ""){
            alert("请选择一条大类！");
            return;
        }
        showModalCenter('<%=request.getContextPath()%>/jsp/faerp/system/security/pbservicebigtype/insertSmallType.jsp?big_type_id='+big_type_id,window,refesh1,750,250,"新增小分类");
    }
    
    function refesh1(ref){
        $id("datacell2").addParam("big_type_id",ref);
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
    
    function saveSmallType(){
        var big_type_id = document.getElementById("big_type_id").value;
        if(big_type_id == null || big_type_id == ""){
            alert("请选择一条大类！");
            return;
        }
    
        $id("datacell2").isModefied = true;
        
        var v_datacell = $id("datacell2").dataset;
        var len1 = v_datacell.getLength();
        for(var i =0 ; i < len1 ; i++){
            var small_name=v_datacell.get(i).getProperty("small_name");
            if(small_name==null||small_name==""){
                alert("小分类名称不能为空！");
                return;
            }
        }
         if($id("datacell2").submit()){
           alert("小分类修改成功！");
           $id("datacell2").addParam("big_type_id",big_type_id);
           $id("datacell2").loadData();
           $id("datacell2").refresh();
        }
    }
    
    function deleteBigType(){
        var big_type_id = document.getElementById("big_type_id").value;
        if(big_type_id == null || big_type_id == ""){
            alert("请选择一条需删除的大类！");
            return;
        }
        jQuery.getJSON("<venus:base/>/PbservicebigtypeAction.do?cmd=deleteBigType&date="+new Date()+"",{"big_type_id":big_type_id},function(json){
            if(json.saia != ""){
                alert(json.saia);
                return;
            }else{
                alert("删除成功！");
                $id("datacell1").loadData();
                $id("datacell1").refresh();
            }
        });
    }
    
    function deleteSmallType(){
        var big_type_id = document.getElementById("big_type_id").value;
        var small_type_id = document.getElementById("small_type_id").value;
        if(big_type_id == null || big_type_id == ""){
            alert("请选择一条大类！");
            return;
        }
        if(small_type_id == null || small_type_id == ""){
            alert("请选择一条需删除的小类！");
            return;
        }
        jQuery.getJSON("<venus:base/>/PbservicebigtypeAction.do?cmd=deleteSmallType&date="+new Date()+"",{"big_type_id":big_type_id,"small_type_id":small_type_id},function(json){
            if(json.saia != ""){
                alert(json.saia);
                return;
            }else{
                alert("删除成功！");
                $id("datacell2").addParam("big_type_id",big_type_id);
                $id("datacell2").loadData();
                $id("datacell2").refresh();
            }
        });
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="big_type_id" name="big_type_id" value=""/>
<input type="hidden" id="small_type_id" name="small_type_id" value=""/>
 
<div id="right">

<div class="ringht_s">
 
	<div id="ccChild0" class="search"> 
	    <table width="100%" cellspacing="0">
	        <tr>
	            <td width="155" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
	        </tr>
	        <tr>
	            <td align="right">城市</td>
	            <td align="left" width="210">
	                <r:comboSelect id="city_idList_search" name="city_id1"
	                           queryAction="PB_CITYAction.do?cmd=getListData"
	                           textField="city_name"
	                           valueField="id"
	                           xpath="PB_CITYVo"
	                           width="200px"
	                           value=""
	                           nullText="请选择"/>
	            </td>
	            <td align="right">大分类名称</td>
	            <td align="left">
	                <input type="text" class="text_field" name="big_name1" inputName="大分类名称" maxLength="50"/>
	            </td>
	            <td align="right"><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
	            <td align="left"><input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();"></td>
	        </tr>
	    </table>
	</div>
                    
    <table cellpadding="0" style="padding: 8 10 8 8;" border="0">
        <tr>
            <td width="50%">
                <div id="ccParent1" class="button"> 
			        <div class="button_right">
			                <ul>
			                    <li class="c">      <a onClick="javascript:addBigType();"><fmt:message key="insert"/> </a></li>
			                    <li class="d">      <a  onClick="javascript:deleteBigType();"><fmt:message key="delete"/> </a> </li>
			                    <li class="bc">      <a  onClick="javascript:saveBigType();"><fmt:message key="save"/> </a> </li>
			                </ul>
			         </div>
			         <div class="clear"></div>          
			     </div>
                <r:datacell 
			        id="datacell1"
			        queryAction="/FAERP/PbservicebigtypeAction.do?cmd=searchBigTypeData"
			        submitAction="/FAERP/PbservicebigtypeAction.do?cmd=modifySmallTypeData"
			        width="98%"
			        height="302px"
			        xpath="PbservicebigtypeVo"
			        submitXpath="PbservicebigtypeVo"
			        paramFormId="datacell_formid"
			        >
			       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
			       <r:field fieldName="big" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
                   </r:field>
			       <r:field fieldName="name" label="大分类名称" width="120px">
		               <h:text/>   
		           </r:field>
		           <r:field fieldName="city_id" label="城市" width="100px">
		                <r:comboSelect id="countryList" name="city_id"
		                     queryAction="PB_CITYAction.do?cmd=getListData"
		                     textField="city_name"
		                     valueField="id"
		                     xpath="PB_CITYVo"
		                     width="150px"/>
		           </r:field>
		           <r:field fieldName="remark" label="备注" width="200px">
                       <h:text/>   
                   </r:field>
                </r:datacell>
            </td>
            <td width="50%">
                <div id="ccParent1" class="button"> 
                    <div class="button_right">
                            <ul>
                                <li class="c">      <a onClick="javascript:adddSmallType();"><fmt:message key="insert"/> </a></li>
                                <li class="d">      <a  onClick="javascript:deleteSmallType();"><fmt:message key="delete"/> </a> </li>
                                <li class="bc">      <a  onClick="javascript:saveSmallType();"><fmt:message key="save"/> </a> </li>
                            </ul>
                     </div>
                     <div class="clear"></div>          
                 </div>
                <r:datacell 
			        id="datacell2"
			        queryAction="/FAERP/PbservicebigtypeAction.do?cmd=searchSmallTypeData"
			        submitAction="/FAERP/PbservicebigtypeAction.do?cmd=modifySmallTypeData"
			        width="98%"
			        height="302px"
			        xpath="PbServiceSmallTypeVo"
			        submitXpath="PbServiceSmallTypeVo"
			        paramFormId="datacell_formid"
			        >
			       
			       <r:field fieldName="small" label="操作" width="50px" onRefreshFunc="setCheckbox" align="center">
                   </r:field>
			       <r:field fieldName="small_name" label="小分类名称" width="120px">
		               <h:text/>   
		           </r:field>
		           <r:field fieldName="small_remark" label="备注" width="300px">
                       <h:text/>   
                   </r:field>
                </r:datacell>
            </td>
        </tr>
    </table>
    
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>