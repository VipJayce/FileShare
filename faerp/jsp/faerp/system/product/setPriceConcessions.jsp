<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>设置让利价格</title>
<script language="javascript">

        function toAdd_onClick() { 
            $id("datacell1").addRow();
        }
        
        function deleteMulti_onClick(){ 
           if(confirm('确定要删除所选择的数据么！')) { 
                $id("datacell1").deleteRow();
                $id("datacell1").submit();
                alert("删除成功");
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
			     alert("角色【"+$id("productrole").getDisplayValue(a)+"】重复,请修改后再保存！");
			     $id("datacell1").reload();
			     return;
			     }
			} 

            
            $id("datacell1").isModefied = true;
            if($id("datacell1").submit()){
            alert("保存成功");
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
		          f_alert(obj,'金额总数'+tmp+'不能超过'+allacount);
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
            <div id="ccParent1" class="button"> 
			 <div class="button_right">
			                <ul>
			                    <li class="c">      <a onClick="javascript:toAdd_onClick();">新增</a></li>
			                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();">删除</a> </li>
			                    <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
			                    <li class="a">      <a  onClick="javascript:toReload_onClick();">刷新 </a> </li>
			                </ul>
			         </div>
			           <div class="clear"></div>            
			</div>
         <!--<w:panel id="panel1" title="设置让利价格">-->
         <div  id="div1" style="margin:5px 0px 0px 10px;">
                            <r:datacell 
                            queryAction="/FAERP/ProductAction.do?cmd=getListPriceConcessions&product_id=${requestScope.product_id}"
                            submitAction="/FAERP/PbproductrolerightAction.do?cmd=savePriceConcessions&product_id=${requestScope.product_id}"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="97%" height="270px" 
                            xpath="PbproductrolerightVo"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="role_id" label="角色" width="140px">
                            <r:comboSelect id="productrole" name="productrole"
			                       queryAction="ProductAction.do?cmd=getProductRoleListData"
			                       textField="name"
			                       valueField="id"
			                       xpath="ProductRoleVo"
			                       width="140px"
			                       nullText="请选择" />
                          </r:field>
                          <r:field fieldName="deal_money" label="让利金额" width="140px">
                            <h:text  maxlength="12" validateAttr="totalDigit=13;fracDigit=4;type=abc;allowNull=false"/>
                          </r:field>
                        </r:datacell>
            </div>
            <!--</w:panel>-->

  </div>

</form>
</body>
</html>
