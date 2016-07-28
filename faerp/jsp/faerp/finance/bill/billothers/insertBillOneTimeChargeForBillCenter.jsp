<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%
	String customer_id = request.getParameter("customer");
	String cost_center_id = request.getParameter("cost_center");
	String billyearmonth = request.getParameter("bill_year");
	String bill_id = request.getParameter("bill_id");
	int showDepIds = 100;
	int showBdIds = 1000;
%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.finance.bill.billothers.billothers_resource"
	prefix="rayoo.finance.bill.billothers.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>一次性收费项目</title>
	<style >
		.yj {
			padding: 10px;
			border: 2px solid #000000;
			-moz-border-radius: 15px;
			-webkit-border-radius: 15px;
			border-radius: 15px;
			display: none;
			 position: absolute;
			  z-index: 999;
		}
    </style>
	<script language="javascript">
           var vpath = "<%=request.getContextPath()%>";
           
/*******************************************************************************************************/
        //保存信息并校验信息
          function toSaveCelllist1_onClick() {
            var customer_id=document.getElementById("customer_id").value;
            var cost_center_id=document.getElementById("cost_center_id").value;
            var billyearmonth=document.getElementById("billyearmonth").value;
            
            var cellLists = $id("celllist1");
            var allRows = cellLists.getAllRows(true);
            var len1=allRows.length;
            for(var i=0;i<len1;i++){
                var dataset = cellLists.getEntity(allRows[i]) ;
                var department = dataset.getProperty("department_name");//部门
                var charge_item_bd = dataset.getProperty("charge_item_bd");//项目名称
                var amount = dataset.getProperty("amount");//金额
                var remark = dataset.getProperty("charge_desc");//备注
                if(department=="请选择" || department == ""){
                    alert("请选择部门！");
                    return;
                }
                if(charge_item_bd=="请选择" || charge_item_bd == ""){
                    alert("请选择项目名称！");
                    return;
                }
                if(amount==""){
                    alert("请输入金额！");
                    return;
                }
                if(charge_item_bd == "31" || charge_item_bd == "32"){
                    var remarkIndex = remark.indexOf("20");
                    if(remarkIndex < 0){
                        alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                        return;
                    }else{
                        var remarkYear = remark.substring(remark.indexOf("20"),remark.indexOf("20")+4);
                        var remarkYearCheck = remark.substring(remark.indexOf("20"),remark.indexOf("20")+5);
                        var lengthVal=remark.length-remark.indexOf("20");
                        if(lengthVal > 4){
                           if(!isNaN(remarkYearCheck)){
                                alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                                return;
                            }
                        }else if(lengthVal == 4){
                           if(isNaN(remarkYear)){
                                alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                                return;
                            }
                        }else if(lengthVal < 4){
                           alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                           return;
                        }
                    }
                }
            }
           cellLists.isModefied = true;
            if(cellLists.submit())
            {
                alert("账单中心计算中......");
                //alert("<fmt:message key='alert_save_success'/>");
                window.close();
                window.opener.showListData();//回调父页面函数
            }
        } 
</script>
	</head>
	<body onclick="hideDiv()">
	<div id="div_mod" class="button">
	<div class="button_right">
	<ul>
		<li class="c"><a onclick="addItem()" href="javascript:void(0);"><fmt:message
			key='button_insert' /></a></li>
		<li class="d"><a onclick="delItem()" href="javascript:void(0);"><fmt:message
			key='button_delete' /></a></li>
	</ul>
	</div>
	<div class="clear"></div>
	</div>
	<form id="datacell_formid" name="datacell_formid" method="post">
	<div id="right">
	<div id="ccChild1" class="box_xinzeng" style="height: 325px">
	<div style="padding: 8 10 8 8;"><input type="hidden"
		value="<%=customer_id %>" id="customer_id" name="customer_id" /> <input
		type="hidden" value="<%=cost_center_id %> " id="cost_center_id"
		name="cost_center_id" /> <input type="hidden"
		value="<%=billyearmonth %> " id="billyearmonth" name="billyearmonth" />
	<input type="hidden" value="<%=bill_id%>" id="bill_id" name="bill_id" />
	<r:datacell id="celllist1" isCount="false"
		paramFormId="datacell_formid"
		queryAction="/FAERP/FinbillAction.do?cmd=searchOneTimeChargesDataByBillId1"
		submitAction="/FAERP/FinbillAction.do?cmd=updateOneTimeChargesDataByBillId2"
		pageSize="100" width="99%" xpath="BillOthersVo"
		submitXpath="BillOthersVo">
		<r:field fieldName="department_name" messagekey="department_name" 
			width="200px">
			<r:comboSelect id="department_name" name="department_name"
				queryAction="/FAERP/FinbillAction.do?cmd=getDeNameFromBaseData"
				textField="description" valueField="description" nullText="请选择"
				xpath="BillOthersVo" width="200px" />
		</r:field>
		<r:field fieldName="name" messagekey="charge_item_bd" width="250px">
			<h:text onclick="javascript:show(this);" readonly="true"/>
		</r:field>
		<r:field fieldName="charge_item_bd" messagekey="charge_item_bd"
			width="0px">
		</r:field>
		<r:field fieldName="id" messagekey="charge_item_bd" width="0px">
		</r:field>
		<r:field fieldName="amount" messagekey="amount" width="200px">
			<h:text validateAttr="type=clearNoNum" />
		</r:field>
		<r:field fieldName="charge_desc" messagekey="charge_desc"
			width="200px">
			<h:text />
		</r:field>
	</r:datacell></div>
	</div>
	</div>
	<div class="foot_button"><input type="button" class="icon_2"
		onclick="javascript:toSaveCelllist1_onClick();"
		value="<fmt:message key='button_save'/>" /> <input type="button"
		class="icon_2" value="<fmt:message key='button_close'/>"
		onClick="window.close();" /></div>
	</form>
	<!--表格 end-->
	<div id="div1" class = "yj" >
	<table width="200" cellspacing="0" class="datagrid1" style="font-size: 13px;">
		<tbody id="showChargeItemBd">
		</tbody>
	</table>
	</div>
	</div>
	<script language="javascript">
	
	    var datacell = $id("celllist1");
        datacell.afterDel = function(row){
            //var dataset1 = $id("celllist1").dataset;
           // var len1=dataset1.getLength();
            //alert(datacell.getCurrentRowCount()   );
        }
	
	 jQuery(document).ready(function(){
        jQuery("#showChargeItemBd tr").live("click", function () {
            updatetoTbody(this);
        });
    });
    
	//点击浮动层的某一条，修改列表中对应的条目（同一个product_id，不同的社保产品）
    //同时，重新根据新的产品判断基数范围，并且重新计算金额
    function updatetoTbody(obj){
         var showChargeItemBd=jQuery(obj);//div浮动层被点击的行对象
         var code_id=jQuery(showChargeItemBd).find("input[name='code']").val();//浮动层被点击的code值
         var id=jQuery(showChargeItemBd).find("input[name='id']").val();//浮动层被点击的code值
         
         var name = jQuery(showChargeItemBd).find('td').eq(0).text();
         
         //var datacell = $id("celllist1");//datacell列表对象
         //var dataset = datacell.dataset;
         //var trentity = dataset.findEntity("id", id);//列表中对应的相同product_id的行
         var celllist1 = $id("celllist1");
         var activeRow = celllist1.activeRow;
         var trentity = celllist1.getEntity(activeRow);
         trentity.setProperty("charge_item_bd", code_id);
         trentity.setProperty("name", name);

         //$id("celllist1").refresh();
         $id("celllist1").refreshRow(datacell.activeRow,trentity) ;
    }
	function emptyChargeItemBd(e){
	        var celllist1 = $id("celllist1");
            var activeRow = celllist1.activeRow;
            var entity = celllist1.getEntity(activeRow);
            //alert(entity.getProperty("department_name"));
            //entity.setProperty("charge_item_bd", "");
           // entity.setProperty("name", "--请选择--");
            //$id("celllist1").refreshRow(activeRow,entity) ;
	}
        //显示浮动层
	    function show(obj){
	        var celllist1 = $id("celllist1");
	        var activeRow = celllist1.activeRow;
	        var entity = celllist1.getEntity(activeRow);
	        var department_name = entity.getProperty("department_name");
	        var id = entity.getProperty("id");
	        //先调用ajax查询与所选社保产品属于同一产品的社保产品列表，加载到浮动层div中
	        toappenddiv(department_name,id);
	        
	        window.event.cancelBubble = true;
	        var divId=document.getElementById("div1");
	        var cellPosition = getPosition(celllist1.activeCell);
	        
	        divId.style.left= cellPosition.left + celllist1.activeCell.offsetWidth + 2;  
	        divId.style.top= cellPosition.top + celllist1.activeCell.offsetHeight + 2;  
	        divId.style.width="200";  
	        divId.style.heigth="300";  
	        divId.style.background = '#F7F8F9';  
	        divId.style.display="block";  
	
	    }  
     //点击其他位置，隐藏浮动层
    function hideDiv(){  
        var divId=document.getElementById("div1");  
       if(!checkEventObj(event.srcElement,"div1"))  
            divId.style.display="none";  
    }
    function checkEventObj(obj,idName){  
        if(obj.tagName == "BODY"){
             return false; 
        }  
        if(obj.id == idName){
            return true; 
        }  
        else{
             return checkEventObj(obj.parentElement, idName); 
        }  
    }  
    
     //生成浮动层列表
    function toappenddiv(department_name,id){
         var showChargeItemBd=jQuery("#showChargeItemBd");
         showChargeItemBd.empty();
         jQuery.getJSON(vpath+"/FinbillAction.do?cmd=getChargeItemFromBaseDataJSON",{"department_name":department_name},  function(json){
            var chargeItemBdList = json.departnamelist;
             for(var i = 0; i < chargeItemBdList.length; i++){
                var chargeItemBd = chargeItemBdList[i];
                var tr = jQuery("<tr onMouseOver=\"this.style.textDecoration='underline'\" onMouseOut=\"this.style.textDecoration='none'\"></tr>");
                jQuery(tr).attr("style","cursor:hand");
                var td0 = jQuery("<td align='left' width='100%'></td>");
                var html1 = jQuery("<input type='hidden' name='code' value=''>");
                jQuery(html1).attr("value",chargeItemBd.code);
                jQuery(td0).append(html1);
                var html2 = jQuery("<input type='hidden' name='id' value=''>");
                jQuery(html2).attr("value",id);
                jQuery(td0).append(html2);
                jQuery(td0).append(chargeItemBd.name);
                jQuery(tr).append(td0);
                jQuery(showChargeItemBd).append(tr);
             }
        });
    }
     
    //新增一条一次性收费账单
    function addItem(){
        $id("celllist1").addRow();
    }
    //删除一条一次性收费账单
    function delItem(){
        if(confirm("<fmt:message key='alert_is_del'/>")){
            $id("celllist1").deleteRow();
            //$id("celllist1").submit();
        }
    }
    
    //判断输入是否为数字
    function f_check_clearNoNum(obj){
       //先把非数字的都替换掉，除了数字和.
       obj.value = obj.value.replace(/[^\d.]/g,"");
       //必须保证第一个为数字而不是.
       obj.value = obj.value.replace(/^\./g,"");
       //保证只有出现一个.而没有多个.
       obj.value = obj.value.replace(/\.{2,}/g,".");
       //保证.只出现一次，而不能出现两次以上
       obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
       return true;
    }
    //刷新行数据4ty
    function refreshRow(){
       var dataset1 = $id("celllist1");
       var entity = dataset1.getActiveEntity();
       var charge_item_bd = $id("charge_item_bd");
       charge_item_bd.freshFromEntity(entity);
    }
    function changeFuc(e){
       var dataset1 = $id("celllist1");
       dataset1.freshFromEntity(e);
    }
     
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
    </script>
	</body>
</fmt:bundle>
</html>


