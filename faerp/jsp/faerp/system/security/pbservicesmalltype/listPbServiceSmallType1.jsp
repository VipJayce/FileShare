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
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\""+entity.getProperty("city_id")+"\");>";
    }
    
    function setCheckbox(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow1(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow(value1,value2){
        $id("small_type_id").value = value1;
        $id("city_id").value = value2;
        
        $id("datacell2").addParam("small_type_id",value1);
        $id("datacell2").loadData();

        $id("servicelist").queryParam= "<param><key>city_id</key><value>" + value2 + "</value></param>";
        $id("servicelist").loadData();
        $id("servicelist").refresh();
        $id("datacell2").refresh();
    }
    
    function ClickRow1(value1){
        $id("rel_id").value = value1;
    }
    
    function addService(){
        var small_type_id = document.getElementById("small_type_id").value;
        var city_id = document.getElementById("city_id").value;
        if(small_type_id == null || small_type_id == ""){
            alert("请选择一条分类！");
            return;
        }
        if(city_id == null || city_id == ""){
            alert("分类城市不能为空，请选择一条分类！");
            return;
        }
        showModalCenter('<%=request.getContextPath()%>/jsp/faerp/system/security/pbservicesmalltype/insertService.jsp?small_type_id='+small_type_id+'&city_id='+city_id,window,refesh1,750,250,"新增服务");
    }
    
    function refesh1(ref){
        $id("datacell2").addParam("small_type_id",ref);
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
    
    function saveService(){
        var small_type_id = document.getElementById("small_type_id").value;
        if(small_type_id == null || small_type_id == ""){
            alert("请选择一条分类！");
            return;
        }
    
        $id("datacell2").isModefied = true;
        
        var v_datacell = $id("datacell2").dataset;
        var len1 = v_datacell.getLength();
        for(var i =0 ; i < len1 ; i++){
            var service_id=v_datacell.get(i).getProperty("service_id");
            if(service_id==null||service_id==""){
                alert("服务名称不能为空！");
                return;
            }
        }
         if($id("datacell2").submit()){
           alert("服务名称修改成功！");
           $id("datacell2").addParam("small_type_id",small_type_id);
           $id("datacell2").loadData();
           $id("datacell2").refresh();
        }
    }
    
    function deleteService(){
        var small_type_id = document.getElementById("small_type_id").value;
        var rel_id = document.getElementById("rel_id").value;
        if(small_type_id == null || small_type_id == ""){
            alert("请选择一条分类！");
            return;
        }
        if(rel_id == null || rel_id == ""){
            alert("请选择一条需删除的服务！");
            return;
        }
        jQuery.getJSON("<venus:base/>/PbServiceSmallTypeAction.do?cmd=deleteService&date="+new Date()+"",{"small_type_id":small_type_id,"rel_id":rel_id},function(json){
            if(json.saia != ""){
                alert(json.saia);
                return;
            }else{
                alert("删除成功！");
                $id("datacell2").addParam("small_type_id",small_type_id);
                $id("datacell2").loadData();
                $id("datacell2").refresh();
            }
        });
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="small_type_id" name="small_type_id" value=""/>
<input type="hidden" id="rel_id" name="rel_id" value=""/>
<input type="hidden" id="city_id" name="city_id" value=""/>
 
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
                                <li></li>
                            </ul>
                     </div>
                     <div class="clear"></div>          
                 </div>
                <r:datacell 
                    id="datacell1"
                    queryAction="/FAERP/PbServiceSmallTypeAction.do?cmd=searchBigSmallTypeData"
                    width="98%"
                    height="320px"
                    xpath="PbServiceSmallTypeVo"
                    paramFormId="datacell_formid"
                    readonly="true"
                    >
                   <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                   <r:field fieldName="big" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
                   </r:field>
                   <r:field fieldName="service_big_type_name" label="大分类名称" width="120px">
                       <h:text/>   
                   </r:field>
                   <r:field fieldName="name" label="小分类名称" width="120px">
                       <h:text/>   
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
                                <li class="c">      <a onClick="javascript:addService();"><fmt:message key="insert"/> </a></li>
                                <li class="d">      <a  onClick="javascript:deleteService();"><fmt:message key="delete"/> </a> </li>
                                <li class="bc">      <a  onClick="javascript:saveService();"><fmt:message key="save"/> </a> </li>
                            </ul>
                     </div>
                     <div class="clear"></div>          
                 </div>
                <r:datacell 
                    id="datacell2"
                    queryAction="/FAERP/PbServiceSmallTypeAction.do?cmd=searchRelData"
                    submitAction="/FAERP/PbServiceSmallTypeAction.do?cmd=modifyRelData"
                    width="98%"
                    height="320px"
                    xpath="PbServiceTypeRelVo"
                    submitXpath="PbServiceTypeRelVo"
                    paramFormId="datacell_formid"
                    >
                   <r:field fieldName="small" label="操作" width="50px" onRefreshFunc="setCheckbox" align="center">
                   </r:field>
                   <r:field fieldName="service_id" label="服务" width="180px">
                        <r:comboSelect id="servicelist" name="service_id"
                             queryAction="PbserviceAction.do?cmd=getServiceListData"
                             textField="service_name"
                             valueField="id"
                             xpath="PbserviceVo"
                             width="150px"
                             nullText="请选择"/>
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