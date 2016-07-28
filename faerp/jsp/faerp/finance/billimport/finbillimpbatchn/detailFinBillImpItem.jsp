<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择员工</title>
    <script language="javascript">
        //查询
        function simpleQuery_onClick(){  //简单的模糊查询
              $id("celllist1").loadData();
              $id("celllist1").refresh();
        }
        
        //datacell checkbox begin
	    function setCheckboxStatus(value,entity,rowNo,cellNo){
	         var returnStr = "";
	        returnStr =  "<input   type='checkbox' name='checkbox1'  id='" + entity.getProperty("id") + "'  onclick=\"loadMoreData('"+ entity.getProperty("id") +"')\"  value='" + entity.getProperty("id") + "'>";
	        return returnStr;
	    }
	    //导出
        function exportBillItem(){
            $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpbatchnAction.do?cmd=exportExpressBillItem";
            $id("datacell_formid").submit();
        }
        //计入下月
        function deleteBillItem(){
            var cid = _$("#cid").val();//批次主表id
            
            var ds = $id("celllist1").dataset;
            var ids = new Array();
           // var is_add = 0;
            jQuery("input[name='checkbox1']").each(function(){
                if(jQuery(this).attr("checked") && this.value !=""){
                   ids.push(this.value);
                   /**var entity = ds.findEntity("id",this.value);
                   var change_type  =  entity.getValue("change_type"); 
                   if(change_type !="2"){
                      is_add ++ ;
                   }**/
                }
            });
            /**if (is_add >0){
                    alert("只有差异状态为新增的导入明细，才能计入下月!") ;
                    return false ;
            }**/
            if(ids == "" || ids == null){
              alert("请选择一条记录");
              return false;
            }
            
            var turl = "<%=request.getContextPath()%>/FinbillimpbatchnAction.do?cmd=setExpressItemToNext&item_ids="+ids.join()+"&cid="+cid;
            jQuery.ajax({
               url: turl,
               type: 'GET',
               dataType: 'html',
               async: false,
               timeout: 10000,
               success: function(text){
                        alert(text);
                        $id("celllist1").loadData();
                        $id("celllist1").refresh();
               }
           });
        }
        //全选
        function checkAll(item) {
	        if (_$(item).attr("checked")) {
	            _$(":checkbox").attr("checked", true);
	        } else {
	            _$(":checkbox").attr("checked", false);
	        }
        }
    </script>
</head>
<body>
   <form name="form" method="post"  id="datacell_formid">
   <input  type="hidden" name="cid" id ="cid" value="${cId}"/>
    <div id="ccChild0" class="search">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="270" rowspan="4" style="padding-top: 0;">
                    <div class="search_title">查询条件</div> 
                </td>
            </tr>
                <tr>
                    <td align="left">员工编号</td>
                    <td align="left">
                        <input type="text" class="text_field" name="emp_code" id="emp_code" inputName="员工编号"  />      
                    </td>
                    <td width="166" align="left">员工姓名</td>
                    <td width="328" align="left">
                        <input type="text" class="text_field" name="emp_name" id="emp_name" inputName="员工姓名"  />         
                    </td>
                </tr>
                <tr>
                    <td align="left">差异类型</td>
		            <td align="left">
		                <d:select dictTypeId="CHANGE_TYPE" name="change_type" nullLabel="--请选择--" id="change_type" style="width:200px;"/>
		            </td>
                </tr>
                 <tr>
                    <td width="378" rowspan="8" align="left" >
                          <input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()">
                     </td>
                 </tr>
        </table>
    </div>
    
    <div id="ccParent1" class="button">
        <div class="button_right">
            <ul>
                <input type="button" class="d" value="计下月" <au:authorityBtn code="qgzdmx_delete" type="1"/> onClick="deleteBillItem()" />
                <input type="button" class="e_2" value="导出" <au:authorityBtn code="qgzdmx_export" type="1"/> onClick="exportBillItem()" />
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    
    <div  id="div1" style="margin:5 0 0 10px;">
              <r:datacell 
              queryAction="/FAERP/FinbillimpbatchnAction.do?cmd=queryExpressBillItem&cid=${cId}"
              id="celllist1"
              paramFormId="datacell_formid" 
              width="97%" height="305px" pageSize="50"
              xpath="FinBillImpItemVo"
              readonly="true"
              >
                <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                <r:field fieldName="id" label="<input type='checkbox' name='temp' onclick='checkAll(this);'  value=''/>" 
                width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
                <r:field fieldName="emp_code" label="员工编号" width="70px">
                </r:field>
                <r:field fieldName="emp_name" label="员工名称" width="70px">
                </r:field>
                <r:field fieldName="p_product_name" label="产品名称" width="100px">
                </r:field>
                <r:field fieldName="bill_year_month" label="账单年月" width="100px">
                </r:field>
                <r:field fieldName="service_year_month" label="服务年月" width="100px">
                </r:field>
                <r:field fieldName="amount" label="合计金额" width="100px">
                </r:field>
                <r:field fieldName="p_money" label="个人金额" width="100px">
                </r:field>
                <r:field fieldName="e_money" label="企业金额" width="100px">
                </r:field>
                <r:field fieldName="p_add_money" label="个人附加金额" width="100px">
                </r:field>
                <r:field fieldName="e_add_money" label="企业附加金额" width="100px">
                </r:field>
                <r:field fieldName="change_type" label="差异状态" width="150px"  allowModify="false">
                       <d:select dictTypeId="CHANGE_TYPE" />
                </r:field>
            </r:datacell>
   </div>
</form>
</body>
</html>
