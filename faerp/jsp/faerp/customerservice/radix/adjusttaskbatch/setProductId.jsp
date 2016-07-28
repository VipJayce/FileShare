<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.customerservice.radix.adjusttaskbatch.adjusttaskbatch_resource" prefix="rayoo.customerservice.radix.adjusttaskbatch.">
<head>
<%
String batch_id = request.getParameter("id"); 
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="set_change_prudocut_rep"/></title>
<script language="javascript">
var vpath = "<%=request.getContextPath()%>";

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("product_id") + ">";
    }
    
//********************************以下为弹出层选择比例的js方法***************************
    jQuery(document).ready(function(){
        jQuery("#showratio tr").live("click", function () {
            updatetoTbody(this);
        });
        
    });
    
    function toappenddiv(group_id,product_id){
         var showratio=jQuery("#showratio");
         showratio.empty();
         
         jQuery.getJSON(vpath+"/EmppostAction.do?cmd=searchProductsByProductId&date="+new Date()+"",{"group_id":group_id,"product_id":product_id},  function(json){
             
                 for(var i = 0; i < json.saia.length; i++){
                    
                    var tr = jQuery("<tr onMouseOver=\"this.style.textDecoration='underline'\" onMouseOut=\"this.style.textDecoration='none'\"></tr>");
                    jQuery(tr).attr("style","cursor:hand");
                    
                    var td0 = jQuery("<td align='center' width='15%'></td>");
                    var html1 = jQuery("<input type='hidden' name='div_security_product_id' value=''>");
                    jQuery(html1).attr("value",json.saia[i].id);
                    jQuery(td0).append(html1);
                    var html2 = jQuery("<input type='hidden' name='div_product_id' value=''>");
                    jQuery(html2).attr("value",json.saia[i].product_id);
                    jQuery(td0).append(html2);
                    var html3 = jQuery("<input type='hidden' name='div_e_precision_bd' value=''>");
                    jQuery(html3).attr("value",json.saia[i].e_precision_bd);
                    jQuery(td0).append(html3);
                    var html4 = jQuery("<input type='hidden' name='div_e_caculate_type_bd' value=''>");
                    jQuery(html4).attr("value",json.saia[i].e_caculate_type_bd);
                    jQuery(td0).append(html4);
                    var html5 = jQuery("<input type='hidden' name='div_p_precision_bd' value=''>");
                    jQuery(html5).attr("value",json.saia[i].p_precision_bd);
                    jQuery(td0).append(html5);
                    var html6 = jQuery("<input type='hidden' name='div_p_caculate_type_bd' value=''>");
                    jQuery(html6).attr("value",json.saia[i].p_caculate_type_bd);
                    jQuery(td0).append(html6);
                    jQuery(td0).append(json.saia[i].product_name);
                    jQuery(tr).append(td0);
                    
                    var td5 = jQuery("<td align='center'></td>");
                    jQuery(td5).append(json.saia[i].e_ratio);
                    jQuery(tr).append(td5);
                    
                    var td6 = jQuery("<td align='center'></td>");
                    jQuery(td6).append(json.saia[i].p_ratio);
                    jQuery(tr).append(td6);
                    
                    var td2 = jQuery("<td align='center'></td>");
                    jQuery(td2).append(json.saia[i].charge_frequency_bd);
                    jQuery(tr).append(td2);
                    
                    var td3 = jQuery("<td align='center'></td>");
                    jQuery(td3).append(json.saia[i].e_add_ratio);
                    jQuery(tr).append(td3);
                    
                    var td4 = jQuery("<td align='center'></td>");
                    jQuery(td4).append(json.saia[i].p_add_ratio);
                    jQuery(tr).append(td4);
        
                    jQuery(showratio).append(tr);
                
             }
        });
    }
    
    //点击浮动层的某一条，修改列表中对应的条目（同一个product_id，不同的社保产品）
    //同时，重新根据新的产品判断基数范围，并且重新计算金额
    function updatetoTbody(obj){
         var showratio=jQuery(obj);//div浮动层被点击的行对象
         var product_id=jQuery(showratio).find("input[name='div_product_id']").val();//浮动层被点击的product_id值
         
         var security_product_id = jQuery(showratio).find("input[name='div_security_product_id']").val();
         var e_ratio = jQuery(showratio).find('td').eq(1).text();
         var p_ratio = jQuery(showratio).find('td').eq(2).text();
         //var charge_frequency_bd = jQuery(showratio).find('td').eq(3).text();
         //var e_add_ratio = jQuery(showratio).find('td').eq(4).text();
         //var p_add_ratio = jQuery(showratio).find('td').eq(5).text();
         //var e_precision_bd = jQuery(showratio).find("input[name='div_e_precision_bd']").val();
         //var p_precision_bd = jQuery(showratio).find("input[name='div_p_precision_bd']").val();
         //var e_caculate_type_bd = jQuery(showratio).find("input[name='div_e_caculate_type_bd']").val();
         //var p_caculate_type_bd = jQuery(showratio).find("input[name='div_p_caculate_type_bd']").val();
         
         var datacell = $id("grdCityEnsureTbody");//datacell列表对象
         var dataset = datacell.dataset;
         var trentity = dataset.findEntity("product_id", product_id);//列表中对应的相同product_id的行
         trentity.setProperty("id", security_product_id);
         trentity.setProperty("e_ratio", e_ratio);
         trentity.setProperty("p_ratio", p_ratio);
         //trentity.setProperty("frequency_bd", charge_frequency_bd);
         //trentity.setProperty("e_add_ratio", e_add_ratio);
         //trentity.setProperty("p_add_ratio", p_add_ratio);
         //trentity.setProperty("e_precision_bd", e_precision_bd);
         //trentity.setProperty("p_precision_bd", p_precision_bd);
         //trentity.setProperty("e_caculate_type_bd", e_caculate_type_bd);
         //trentity.setProperty("p_caculate_type_bd", p_caculate_type_bd);
         
    }
    
    //显示浮动层
    function show(obj){
        var dc1 = $id("grdCityEnsureTbody");
        var activeRow = dc1.activeRow;
        var entity = dc1.getEntity(activeRow);
        var group_id = entity.getProperty("group_id");
        var product_id = entity.getProperty("product_id");
        //先调用ajax查询与所选社保产品属于同一产品的社保产品列表，加载到浮动层div中
        toappenddiv(group_id,product_id);
        
        window.event.cancelBubble = true;
        var divId=document.getElementById("div1");
        var cellPosition = getPosition(dc1.activeCell);
        
        divId.style.left= cellPosition.left + dc1.activeCell.offsetWidth + 2;  
        divId.style.top= cellPosition.top + dc1.activeCell.offsetHeight + 2;  
        divId.style.width="500";  
        divId.style.heigth="400";  
        divId.style.background = '#FFFFFF';  
        divId.style.display="block";  

    }  
    //点击其他位置，隐藏浮动层
    function hideDiv(){  
        var divId=document.getElementById("div1");  
        //alert(event.srcElement.tagName);
        if(!checkEventObj(event.srcElement,"div1"))  
            divId.style.display="none";  
    }
    
    function checkEventObj(obj,idName){ 
        //alert(obj.tagName);
        if (obj && obj.tagName){
            if(obj.tagName == "BODY"){ return false; }  
            if(obj.id == idName){ return true; }  
            else{ return checkEventObj(obj.parentElement, idName); }
        }
        return;
    }  
    
    function saveNew(){
        
       var datacell1 = $id("grdCityEnsureTbody");
       var batch_id = jQuery("#batch_id").val();
        var product_id = document.getElementsByName("checkbox_template");
         var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
         for(var i=0;i<product_id.length;i++){  //循环checkbox组
              if(product_id[i].checked) {  //如果被选中
                     var enCurEntity = datacell1.dataset.get(i); 
                     number += 1;  //游标加1
                     if(ids == null) {
                        ids = product_id[i].value;
                     }else{
                        ids = ids+','+product_id[i].value;
                     }
                     
                     //比例值没有输入，则需要提示
                     var e_ratio = enCurEntity.getProperty("e_ratio");
                     var p_ratio = enCurEntity.getProperty("p_ratio");
                     
                     if(e_ratio==null||e_ratio==""||p_ratio==null||p_ratio==""){
                         alert("<fmt:message key="please_check_in_new_rep"/>");
                         ali = false;
                         return ali;
                     }
                     
                     
               }
         }
         if(ids==null||ids==""){
            alert("<fmt:message key="please_choose_one_need_change_rep_product"/>");
            return;
         }
         
         jQuery("input[name='button_reset1']").attr('disabled','disabled');
         
         var dc1 = $id("grdCityEnsureTbody");
         var action = "<%=request.getContextPath()%>/AdjustTaskBatchAction.do?cmd=saveNewRatio";
         var xmlSubmit = dc1.dataset.toString();
         var myAjax = new Ajax(action);
         myAjax.addParam("ids", ids);
         myAjax.addParam("batch_id", batch_id);
          myAjax.submitXML(xmlSubmit, 'UTF-8');
          var returnNode = myAjax.getResponseXMLDom();
          if( returnNode ) {
              if( myAjax.getValue("root/data/returnValue") == 1 ) {
                   alert('<fmt:message key="change_new_rep_save_seccuse"/>' );
                   window.opener.simpleQuery_onClick();
                   window.close();
               }else if( myAjax.getValue("root/data/returnValue") == -1 ) {
                   alert('<fmt:message key="you_check_in_rep_value_not_exise"/>' );
                   jQuery("input[name='button_reset1']").removeAttr("disabled");
               }else {
                   alert('<fmt:message key="change_new_rep_error"/>' ); 
                   jQuery("input[name='button_reset1']").removeAttr("disabled");
               }
               
          }
            
    }
    
    function anyAmount1(){
       
        var datacell = $id("grdCityEnsureTbody");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
       var e_ratio = datasettr.getProperty("e_ratio");
       
       if(!checkFloat(e_ratio)){
           alert('<fmt:message key="check_in_e_rep_must_float_type"/>');
           datasettr.setProperty("e_ratio","0");
           return;
       }
      
       if(e_ratio>1){
           alert('<fmt:message key="check_in_e_rep_value_gt_one"/>');
           datasettr.setProperty("e_ratio","0");
           return;
       }
       
    }
    
    function anyAmount2(){
       
        var datacell = $id("grdCityEnsureTbody");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
       var p_ratio = datasettr.getProperty("p_ratio");
       
       if(!checkFloat(p_ratio)){
           alert('<fmt:message key="check_in_p_rep_must_float_type"/>');
           datasettr.setProperty("p_ratio","0");
           return;
       }
      
       if(p_ratio>1){
           alert('<fmt:message key="check_in_p_rep_value_gt_one"/>');
           datasettr.setProperty("p_ratio","0");
           return;
       }
      
    }
    
    function checkFloat(str){
	    var rc=true;
	    oneDecimal=false;
	    if (str+"" == "undefined" || str == null || str==''){
	        rc=false;
	    } else{
	        for(i=0;i<str.length;i++){
	            ch=str.charAt(i);
	            if(ch=="." && !oneDecimal){
	                oneDecimal=true;
	                continue;
	            }
	            if ((ch< "0") || (ch >'9')){
	                rc=false;
	                break;
	            }
	        }
	    }
	    return rc;
	}   
</script>
</head>
<body onclick="hideDiv()">
<h4><font color="red"><fmt:message key="noticees"/>  </font></h4>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="batch_id" name="batch_id" value="<%=batch_id %>"/>
<div id="right">

<div class="ringht_s">                           

    <div id="values_div">
       <r:datacell 
            id="grdCityEnsureTbody"
            queryAction="/FAERP/AdjustTaskBatchAction.do?cmd=searchSetProductId"
            submitAction="/FAERP/AdjustTaskBatchAction.do?cmd=savaSetProductId"
            width="100%"
            xpath="SecurityAllVo"
            submitXpath="SecurityAllVo"
            paramFormId="datacell_formid"
            pageSize="-1" readonly="false"
            >
            <r:field  fieldName="id_index" messagekey="choice" width="50px" onRefreshFunc="setCheckboxStatus" sortAt="none">
            </r:field>
            <r:field  fieldName="product_name" messagekey="product" width="120px">
            </r:field>
            <r:field fieldName="group_name" messagekey="ss_fund_group" width="120px">
            </r:field>
            <r:field fieldName="e_ratio" messagekey="new_e_redio" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.####');})">
                <h:text onclick="javascript:show(this);" onchange="javascript:anyAmount1();"/>
            </r:field>
            <r:field fieldName="p_ratio" messagekey="new_p_redio" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.####');})">
                <h:text onclick="javascript:show(this);" onchange="javascript:anyAmount2();"/>
            </r:field>
            
            
          </r:datacell>
           
    </div>
    <!--社保公积金产品列表 end-->
    </div>
    <div id="div1" style="display: none; border: #000 1px solid; position: absolute;z-index:999;">
        <table  width="500" cellspacing="0"  class="datagrid1">
            <tr>
              <th width="9%"><fmt:message key="product"/></th>
              <th width="10%"><fmt:message key="e_redio"/></th>
              <th width="10%"><fmt:message key="p_redio"/></th>
              <th width="10%"><fmt:message key="pay_frequency"/></th>
              <th width="10%"><fmt:message key="e_add_monery"/></th>
              <th width="10%"><fmt:message key="p_add_monery"/></th>
              </tr>
              <tbody id="showratio">
              
              
              </tbody>
        </table>
    </div>

    <div class="foot_button">
          <input type="button" class="foot_icon_1" value="<fmt:message key="save"/>" onClick="javascript:saveNew();"/>
          
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script language="javascript">
//解决修改行数据，多选框勾选消失BUG
    $id("grdCityEnsureTbody").beforeRefreshCell = function(cell,field){
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
</script>
