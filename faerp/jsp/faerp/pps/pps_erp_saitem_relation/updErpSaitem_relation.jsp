<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.pps.ppssasalarytemplet.vo.PpssasalarytempletVo" %>
<%@ page import="rayoo.salary.salaryclass.vo.SalaryclassVo" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>配置PPS账套项与ERP薪资项关联</title>
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">

<%  
PpssasalarytempletVo tempvo = (PpssasalarytempletVo)request.getAttribute("ppstempletvo"); 
SalaryclassVo calssvo = (SalaryclassVo)request.getAttribute("erpclassvo"); 

String rel_id = (String)request.getAttribute("rel_id"); 
    
%>

<script language="javascript">

var vpath = "<%=request.getContextPath()%>";

    
    
    function toAdd_onClick(){ 
        var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                           
        var ppeerpid = jQuery("#rel_id").val();
        newEntity.setProperty("pps_erp_id",ppeerpid);
        
        $id("datacell1").insertRow(newEntity);
        
    }
    
    function deleteMulti_onClick(){
        var datacell = $id("datacell1");
        //var dataset1 = datacell.dataset;//取得页面的datacell
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
       if(confirm('确定要删除该关联关系吗？')) {  //如果用户在确认对话框按"确定"
            $id("datacell1").deleteRow();
            //dataset1.removeEntity(datasettr,true);
       }
    }
    
    //自动匹配
    function setItemRelation_onClick(){
        var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        
        var ppeerpid = jQuery("#rel_id").val();
        var templet_id = jQuery("#templet_id").val();
        var class_id = jQuery("#class_id").val();
        if(ppeerpid==null){
            alert('PPS账套与ERP薪资类别匹配为空，不能自动匹配！');
            return;
        }else{
	        jQuery.getJSON(vpath+"/Pps_erp_saitem_relationAction.do?cmd=checkAutoRelation&date="+new Date()+"",{"templet_id":templet_id,"class_id":class_id},  function(json){
	            if(json.saia!=null && json.saia.length>0){
	               for(var i=0;i<json.saia.length;i++){
		                var sign='0';
		                //验证是否与列表已有的配置重复
			            for(var j=0; j<dataset1.getLength(); j++){
			                var datasettr1 = dataset1.get(j);
			                
			                if(datasettr1.status==3||datasettr1.status==4){
			                    continue;
			                }
			                var pps_templ_item_id = datasettr1.getProperty("pps_templ_item_id");
			                var erp_item_id = datasettr1.getProperty("erp_item_id");
			                if(json.saia[i].pps_templ_item_id==pps_templ_item_id || json.saia[i].erp_item_id==erp_item_id){
			                    sign='1';
			                    break;
			                }
			            }
			            if(sign=='0'){
		                    var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
	                       
		                    newEntity.setProperty("pps_erp_id",ppeerpid);
		                    newEntity.setProperty("pps_templ_item_id",json.saia[i].pps_templ_item_id);
		                    newEntity.setProperty("erp_item_id",json.saia[i].erp_item_id);
		                    newEntity.setProperty("pps_def_index","def"+json.saia[i].pps_def_index);
	                        newEntity.setProperty("erp_def_index","def"+json.saia[i].erp_def_index);
		                    
		                    $id("datacell1").insertRow(newEntity);
		                    //alert(dc1.activeField.fieldId);
		                    $id("datacell1").activeField.editor.hideEditor();   
		                }
		                
		            }
		            
		            $id("datacell1").refresh();
	            }
	            
	         });
	     }
    }
        
    function toSave_onClick() {
        $id("datacell1").isModefied = true;
        
        var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            
            if(datasettr.status==3||datasettr.status==4){
                continue;
            }
        
            var pps_templ_item_id = datasettr.getProperty("pps_templ_item_id");
            var erp_item_id = datasettr.getProperty("erp_item_id");
            if(pps_templ_item_id==null || pps_templ_item_id==''){
                alert('账套项不能为空！');
                return;
            }
            if(erp_item_id==null || erp_item_id==''){
                alert('薪资项不能为空!');
                return;
            }
            
            //验证重复
            for(var j=i+1; j<dataset1.getLength(); j++){
                var datasettr1 = dataset1.get(j);
                
                if(i==j||datasettr1.status==3||datasettr1.status==4){
                    continue;
                }
                var pps_templ_item_id1 = datasettr1.getProperty("pps_templ_item_id");
                var erp_item_id1 = datasettr1.getProperty("erp_item_id");
                if(pps_templ_item_id==pps_templ_item_id1 || erp_item_id==erp_item_id1){
                    alert('账套项与薪资项关联不能配置重复，请删除重复后提交！');
                    return false;
                }
            }
        }
        
        if($id("datacell1").submit()){
            alert("保存成功！");
            this.window.close();
            //window.opener.simpleQuery_onClick();
        }
    }   
        
</script>
</head>
<body>
<div>
<div class="zbox" style="float:left; width:100%">
<form name="form" method="post" id="simpleQuery">
<div class="xz_title" style="margin-top:10px;">修改账套与ERP薪资类别关联</div>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
  <tr>
    <td align="right">PPS账套</td>
    <td align="left">
        <input type="text" readonly="readonly" class="text_field" value="<%=tempvo.getSalary_templet_name() %>"/>
        <input type="hidden" id="templet_id" name="templet_id" value="<%=tempvo.getId() %>" />
    </td>
    <td align="right">ERP薪资类别</td>
    <td align="left">
        <input type="text" readonly="readonly" class="text_field" value="<%=calssvo.getSa_class_name() %>"/>
        <input type="hidden" id="class_id" name="class_id" value="<%=calssvo.getId() %>" />
    </td>
    <input type="hidden" id="rel_id" name="rel_id" value="<%=rel_id %>" />
    <!-- 
    <td align="left">
        <div class="foot_button">
          <input type="button" class="foot_icon_4" value="新增PPS账套与薪资类别关联" onClick="javascript:simpleQuery_onClick()">
        </div>
    </td>
     -->
   </tr>
  </table>
 
 <div id="ccParent1" class="button"> 
    <div class="button_right">
         <input class="c" type="button"   value="新增"  onClick="toAdd_onClick();">
         <input class="d" type="button"   value="删除"  onClick="deleteMulti_onClick();">
         <input class="m_2" type="button" value="帐套项与薪资项自动比对" onClick="setItemRelation_onClick();">
         <!-- 
         <input class="bc" type="button"  value="保存"   onClick="toSave_onClick();">
          -->
    </div>
    <div class="clear"></div>            
  </div>
    
  <div>
                    <r:datacell 
                         id="datacell1"
                         queryAction="/FAERP/Pps_erp_saitem_relationAction.do?cmd=searchRelation"
                         submitAction="/FAERP/Pps_erp_saitem_relationAction.do?cmd=saveAddrelation"
                         width="100%"
                         xpath="Pps_erp_saitem_relationVo"
                         submitXpath="Pps_erp_saitem_relationVo"
                         paramFormId="simpleQuery" 
                         pageSize="-1"
                         >
                         <r:toolbar location="bottom" tools="info"/>
                         <r:field width="200" fieldName="pps_templ_item_id" label="PPS账套项目">
                            <r:comboSelect id="pps_templ_item_id"
                                name="pps_templ_item_id"
                                queryAction="/FAERP/Pps_erp_saitem_relationAction.do?cmd=getPpsTempletitemBytempletID&templet_id=${salary_temp_id}"
                                textField="sa_item_name" valueField="id" xpath="PpssasalarytempletitemVo"
                             width="190" messagekey="please_select"/>
                         </r:field>
                         
                         <r:field width="200" fieldName="erp_item_id" label="ERP薪资项目">
                            <r:comboSelect id="erp_item_id"
                                name="erp_item_id"
                                queryAction="/FAERP/Pps_erp_saitem_relationAction.do?cmd=getClassitemByclassId&class_id=${erp_class_id}"
                                textField="sa_item_name" valueField="id" xpath="SaleryitemVo"
                                width="190" messagekey="please_select"/>
                         </r:field>
                    </r:datacell>
  </div>
  
  </div>
  
  </form>
  
    <div class="foot_button">
      <input type="button" class="foot_icon_1" value="保存" onClick="toSave_onClick();">
      <input type="button" class="foot_icon_1" value="关闭" onClick="javascript:window.close()">
    </div>
</div>
</body>

</html>