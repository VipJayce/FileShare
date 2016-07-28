<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新增PPS账套与ERP薪资类别关联</title>
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script language="javascript">

var vpath = "<%=request.getContextPath()%>";
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);   
        
        var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            $id("datacell1").deleteRow(i);
        }
        return false;
    }

    
    function toAdd_onClick(){ 
        var cust_id=jQuery("#cust_id").val();
        if(cust_id==null || cust_id==''){
            alert("请选择一个客户！");
            return false;
        }else{
            //查询对应的ERP客户
            jQuery.getJSON(vpath+"/Pps_erp_salary_relationAction.do?cmd=checkAllBycustid&date="+new Date()+"",{"cust_id":cust_id},  function(json){
                if(json.saia!=null && json.saia.length>0){
                    if(json.saia[0].result=='1'){
	                    alert('该客户尚未与ERP客户作关联，请先关联ERP客户！');
	                }
	                if(json.saia[0].result=='2'){
                        alert('该客户已经做了账套与ERP薪资类别关联，如有更改，请在关联列表中查询修改！');
                    }
                    if(json.saia[0].result=='0'){
                        var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                           
                        newEntity.setProperty("erp_customer_id",json.saia[0].erp_cust_id);
                        newEntity.setProperty("erp_customer_name",json.saia[0].erp_cust_name);
                        
                        $id("datacell1").insertRow(newEntity);
                            
                        //初始化账套下拉框
	                    $id("pps_bas_id").addParam("cust_id", cust_id);
	                    $id("pps_bas_id").loadData();
	                    $id("pps_bas_id").refresh();
	                    
	                    $id("erp_salary_id").addParam("cust_id", json.saia[0].erp_cust_id);   
                        $id("erp_salary_id").loadData();
                        $id("erp_salary_id").refresh();
	                    
	            
	                    
                    }
                }
                
             });
            
	    }
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
        
    function toSave_onClick() {
        $id("datacell1").isModefied = true;
        
        var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            
            var datasettr = dataset1.get(i);
            if(datasettr.status==3||datasettr.status==4){
                continue;
            }
            
            var pps_bas_id = datasettr.getProperty("pps_bas_id");
            var erp_salary_id = datasettr.getProperty("erp_salary_id");
            if(pps_bas_id==null || pps_bas_id==''){
                alert('请选择一个账套！');
                return;
            }
            if(erp_salary_id==null || erp_salary_id==''){
                alert('请选择一个薪资类别!');
                return;
            }
            
            //验证重复
            for(var j=0; j<dataset1.getLength(); j++){
                
                var datasettr1 = dataset1.get(j);
                if(datasettr1.status==3||datasettr1.status==4){
                    continue;
                }
                
                var pps_bas_id1 = datasettr1.getProperty("pps_bas_id");
                var erp_salary_id1 = datasettr1.getProperty("erp_salary_id");
                
                if(i!=j && pps_bas_id==pps_bas_id1 && erp_salary_id==erp_salary_id1){
                    alert('账套与薪资类别关联不能新增重复，请删除重复后提交！');
                    return false;
                }
                
            }
        }
        
        if($id("datacell1").submit()){
            alert("保存成功！");
            this.window.close();
            window.opener.simpleQuery_onClick();
        }
    }   
    
    function toReload_onClick() {
        var cust_id=jQuery("#cust_id").val();
     if(cust_id==null || cust_id==''){
         alert("请选择一个客户！");
         return false;
     }
        $id("datacell1").reload();
    }

</script>
</head>
<body>
<div>
<div class="zbox" style="float:left; width:100%">
<form name="form" method="post" id="simpleQuery">
<div class="xz_title" style="margin-top:10px;">新增账套与ERP薪资类别关联</div>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
  <tr>
    <td align="right">PPS客户</td>
    <td align="left">
        <w:lookup name="customer_name" readonly="true" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/Pps_au_party_check_relationAction.do?cmd=getCheckCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
        <input type="hidden" id="cust_id" name="cust_id" value="" />
    </td>
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
         <!-- 
         <input class="bc" type="button"  value="保存"   onClick="toSave_onClick();">
          -->
    </div>
    <div class="clear"></div>            
  </div>
    
  <div>
                    <r:datacell 
                         id="datacell1"
                         queryAction=""
                         submitAction="/FAERP/Pps_erp_salary_relationAction.do?cmd=saveAddrelation"
                         width="100%"
                         xpath="Pps_erp_salary_relationVo"
                         submitXpath="Pps_erp_salary_relationVo"
                         paramFormId="simpleQuery" 
                         pageSize="-1"
                         >
                         <r:toolbar location="bottom" tools="info"/>
                         <r:field width="200" fieldName="pps_bas_id" label="账套">
                            <r:comboSelect id="pps_bas_id"
			                    name="pps_bas_id"
			                    queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getPpsTempletByCustomerID"
			                    textField="salary_templet_name" valueField="id" xpath="PpssasalarytempletVo"
			                 width="190" messagekey="please_select"/>
                         </r:field>
                         <r:field width="250" fieldName="erp_customer_name" label="ERP客户">
                            
                         </r:field>
                         <r:field width="200" fieldName="erp_salary_id" label="ERP薪资类别">
                            <r:comboSelect id="erp_salary_id"
                                name="erp_salary_id"
                                queryAction="/FAERP/SalaryclassAction.do?cmd=getSalaryclassByCust"
                                textField="sa_class_name" valueField="id" xpath="SalaryclassVo"
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