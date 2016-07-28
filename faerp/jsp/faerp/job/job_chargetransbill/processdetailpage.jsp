<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salse.salcontract.salcontract_resource" prefix="rayoo.salse.salcontract.">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key="shezhi_price"/></title>
<script language="javascript">

        function toAdd_onClick() { 
            $id("datacell1").addRow();
        }
        
        function deleteMulti_onClick(){ 
           if(confirm('<fmt:message key="sure_to_delete"/>')) { 
                $id("datacell1").deleteRow();
                $id("datacell1").submit();
                alert("<fmt:message key="delete_success"/>");
	        }
        }
        
        //保存信息并校验信息
        function toSave_onClick() {
            var role_ids="";
            var dataset1 = $id("datacell1").dataset;
            var len1=dataset1.getLength();
            for(var i =0 ; i < len1 ; i++){
	            role_ids = role_ids+dataset1.get(i).getProperty("role_id")+",";
	        }

	        var arr = role_ids.split(","); 
			var obj = {};
			for(var i=0;i<arr.length;i++)
			{
				var item = arr[i];
				if(obj[item]==null)obj[item] = 1;
				else obj[item] = obj[item]+1;
			}
			
			for(a in obj)
			{
			var item = obj[a];
			if(item>1){
			     alert("<fmt:message key="juese"/>"+$id("productrole").getDisplayValue(a)+"<fmt:message key="same_modify_save"/>");
			     $id("datacell1").reload();
			     return;
			     }
			} 

            
            $id("datacell1").isModefied = true;
            if($id("datacell1").submit()){
            alert("<fmt:message key="save_success"/>");
            }
        }  
        
         
        function toReload_onClick() {
             $id("datacell1").reload();
        }

            var allacount='${requestScope.product_price}';
		    var rowcoutn =0 ;
		    if(allacount==""){
		     allacount = 0;
		    }else{
		     allacount = allacount-0;
		    } 
    
            function f_check_abc(obj){
                if(!f_check_double(obj)){
                return false;
                }
		       var datacell = $id('datacell1');
		       var trs = datacell.getAllRows(true);
		       var cur = datacell.getActiveRow();
		       var tmp = 0;
		       for(var i=0;i<trs.length;i++){
		           if(cur!=trs[i]){
		            var entity = datacell.getEntity(trs[i]);                    
		            tmp+=(entity.getProperty("deal_money")-0);
		           }
		       }       
		       tmp+=(obj.value-0);
		       if(tmp>allacount){
		          f_alert(obj,'<fmt:message key="bill_sum"/>'+tmp+'<fmt:message key="not_upper"/>'+allacount);
		          return false;
		       }else{
		          return true;
		       }
		    }
</script>
</head>
<body>
<form name="datacell_formid" id="datacell_formid" method="post"> 
<div id="right">
         <!--<w:panel id="panel1" title="设置让利价格">-->
         <div  id="div1" style="margin:5px 5px 0px 5px;">
                            <r:datacell 
                            queryAction="/FAERP/Job_chargetransbillAction.do?cmd=getJobbillSPInto&mid=${param.mid}&wfname=${param.wfname}"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="99%" height="320px" 
                            xpath="GapwfWorkItem" readonly="true">
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="activityname" messagekey="activityname" width="100px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="performername" messagekey="performername" width="100px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="statereason" messagekey="statereason" width="100px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="createddate" messagekey="createddate" width="140px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                          <r:field fieldName="completeddate" messagekey="completeddate" width="140px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                         
                          <r:field fieldName="state" messagekey="state" width="100px">
                            <h:text/>
                          </r:field>
                        </r:datacell>
            </div>
            <!--</w:panel>-->

  </div>

</form>
</body>
</fmt:bundle>
</html>
