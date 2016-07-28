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
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow(value1){
        $id("service_id").value = value1;
    }
    
    function addService(){
        showModalCenter('<%=request.getContextPath()%>/jsp/faerp/system/security/pbservice/insertService.jsp',window,refesh,750,250,"新增服务");
    }
    
    function refesh(ref){
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    function deleteService(){
        var service_id = document.getElementById("service_id").value;
        if(service_id == null || service_id == ""){
            alert("请选择一条需删除的记录！");
            return;
        }
        jQuery.getJSON("<venus:base/>/PbserviceAction.do?cmd=deleteService&date="+new Date()+"",{"service_id":service_id},function(json){
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
    
    function saveService(){
        $id("datacell1").isModefied = true;
        
        var v_datacell = $id("datacell1").dataset;
        var len1 = v_datacell.getLength();
        for(var i =0 ; i < len1 ; i++){
            var city_id=v_datacell.get(i).getProperty("city_id");
            var service_type_bd=v_datacell.get(i).getProperty("service_type_bd");
            var service_code=v_datacell.get(i).getProperty("service_code");
            var service_name=v_datacell.get(i).getProperty("service_name");
            if(city_id==null||city_id==""){
                alert("城市不能为空！");
                return;
            }
            if(service_type_bd==null||service_type_bd==""){
                alert("服务类别不能为空！");
                return;
            }
            if(service_code==null||service_code==""){
                alert("服务编码不能为空！");
                return;
            }
            if(service_name==null||service_name==""){
                alert("服务名称不能为空！");
                return;
            }
        }
         if($id("datacell1").submit()){
           alert("修改成功！");
           $id("datacell1").loadData();
           $id("datacell1").refresh();
        }
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="service_id" name="service_id" value=""/>
 
<div id="right">
<div class="ringht_s">
 
    <div id="ccChild0" class="search"> 
        <table width="100%" cellspacing="0">
            <tr>
                <td width="155" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            </tr>
            <tr>
                <td align="right">服务类别</td>
                <td align="left">
                    <%=gap.rm.tools.helper.RmJspHelper.getSelectField("service_type_bd1", -1, "SERVICE_TYPE_BD", "", "", false) %>
                </td>
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
                <td align="right">服务名称</td>
                <td align="left">
                    <input type="text" class="text_field" name="service_name1" inputName="服务名称" maxLength="50"/>
                </td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td align="right"><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
                <td align="left"><input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();"></td>
            </tr>
        </table>
    </div>
                    
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
    
    <div style="padding: 8 10 8 8;">
	    <r:datacell 
	        id="datacell1"
	        queryAction="/FAERP/PbserviceAction.do?cmd=searchServiceData"
	        submitAction="/FAERP/PbserviceAction.do?cmd=modifyServiceData"
	        width="98%"
	        height="302px"
	        xpath="PbserviceVo"
	        submitXpath="PbserviceVo"
	        paramFormId="datacell_formid"
	        >
	        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	        <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
	        </r:field>
	        <r:field fieldName="city_id" label="城市" width="120px">
                 <r:comboSelect id="countryList" name="city_id"
                      queryAction="PB_CITYAction.do?cmd=getListData"
                      textField="city_name"
                      valueField="id"
                      xpath="PB_CITYVo"
                      width="150px"/>
            </r:field>
            <r:field fieldName="service_type_bd" label="服务类别"  width="120px">
               <d:select dictTypeId="SERVICE_TYPE_BD"/>
           </r:field>
           <r:field fieldName="service_code" label="服务编码"  width="120px">
               <h:text/>   
           </r:field>
           <r:field fieldName="service_name" label="服务名称"  width="150px">
               <h:text/>   
           </r:field>
           <r:field fieldName="remark" label="备注"  width="300px">
               <h:text/>   
           </r:field>
	    </r:datacell>
    </div>
    
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>