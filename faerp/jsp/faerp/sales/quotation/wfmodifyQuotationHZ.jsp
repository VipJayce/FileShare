<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.quotation.vo.QuotationVo" %>
<%@ page import="rayoo.system.product.vo.ProductVo"%>
<%@ page import="rayoo.sales.quotation.util.IQuotationConstants" %>
<%@ page import="rayoo.sales.quotationitem.vo.QuotationitemVo" %>
<%@page import="rayoo.sales.quotation.dao.impl.QuotationDao"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@ page import="java.util.*"%>
<%  //判断是否为修改页面
    QuotationVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    
if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        
    isModify = true;  //赋值isModify为true
    if(request.getAttribute(IQuotationConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (QuotationVo)request.getAttribute(IQuotationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    //RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
    String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();

%>

<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle basename="rayoo.salse.quotation.quotation_resource" prefix="rayoo.salse.quotation.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox  
        var number = 0;  //定义游标
        var ids = '';  
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
                number += 1;  //游标加1
                 ids=ids+elementCheckbox[i].value+',';  //加入选中的checkbox
        }
        return ids;
    }
    function findSelections1(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox  
        var number = 0;  //定义游标
        var ids = '';  
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                ids=ids+elementCheckbox[i].value+',';  //加入选中的checkbox
            }
        }
        return ids;
    }

         //添加产品
  function checkpageproduct(obj)
    {
        var addids="";
        var deleteids="";
        
        var productid = document.getElementsByName("product_id");
        var ids = obj;
          
            
        for(var i = 0;i<ids.length;i++)
        { 
            var istrue='false';
            for(var j=0;j<productid.length;j++)
            {
            
                var entity=$id("datacell1").dataset.get(j);   
                if(entity.getProperty("product_id")==(ids+",").split(",")[i])
                {
                   istrue="true";
                   deleteids+=entity.getProperty("product_name")+"<fmt:message key="not_add_delete"/>\n";
                   break;
                }
                else
                {
                     istrue="false";                       
                }
             }
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        returnAry[1]=deleteids;
        return returnAry;
    }
    function toaddProductlistrollback(obj)
    {
       var ids=checkpageproduct(obj);
        if(ids[1]!=null&&ids[1]!="")
        {
            alert(ids[1]);
        }

        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/QuotationitemAction.do?cmd=addProduct&date="+new Date()+"",{"ids":ids[0]},   function(json){
                        
              if(json.error!=null&&json.error!="")
              {
                    alert(json.error);
              }
              if(json.beans!=null&&json.beans!="")
              {
              
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("product_id", json.beans[i].id);
                       newEntity.setProperty("product_name", json.beans[i].product_name);
                       newEntity.setProperty("product_price", json.beans[i].product_price);
                       newEntity.setProperty("product_desc", json.beans[i].product_desc);
                       $id("datacell1").addRow(newEntity);
                }
              }
              });
        }
      //  $id("datacell1").submit();
      //  $id("datacell1").loadData();
      //  $id("datacell1").refresh();
    }
    function addProductList() {
              var url="<%=request.getContextPath()%>/ProductAction.do?cmd=queryAllProduct";
             showModalCenter(url, window,toaddProductlistrollback,750,447,"<fmt:message key="add_product"/>");
    }
    
      function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='product_id'  value ="+entity.getProperty("product_id")+" onClick=ClickRow(\"" + entity.getProperty("product_id") + "\");>";
    }
    
    
     function ClickRow(){}
    function remove()
    {
            var elementCheckbox = document.getElementsByName("product_id");
            for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
               $id("datacell1").deleteRow(i);
            
            }
        }
         
    }
    
    
            //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=${done}";
        form.submit();
    }
    
    //审批操作
    function saveAndagainApproval_onClick(){
         $id("datacell1").isModefied = true;
         $id("datacell1").addParam("quotation_name",$name("quotation_name").value); 
        // $id("datacell1").addParam("biz_type_bd",$name("biz_type_bd").value); 
         $id("datacell1").addParam("add_type_bd",$name("add_type_bd").value); 
         $id("datacell1").addParam("quotation_code",$name("quotation_code").value); 
         $id("datacell1").addParam("customer_name",$name("customer_name").value); 
         $id("datacell1").addParam("remark",$name("remark").value); 
         var isrenewalsign = document.getElementById("is_renewal_sign").checked;
         if(!!isrenewalsign)
         {
              $id("datacell1").addParam("is_renewal_sign","1"); 
         }
         else
         {
             $id("datacell1").addParam("is_renewal_sign","0"); 
         }
         $id("datacell1").addParam("contract_id",$name("contract_id").value); 
         $id("datacell1").addParam("customer_id",$name("customer_id").value); 
         $id("datacell1").addParam("company_id",$name("company_id").value);
         $id("datacell1").addParam("customer_code",$name("customer_code").value == "" ? "${customer_code}" : "");
         $id("datacell1").addParam("quotation_status",$name("quotation_status").value);
         $id("datacell1").addParam("id",$name("id").value); 
          $id("datacell1").addParam("quotation_status_modify",$name("quotation_status_modify").value); 
         $id("datacell1").submit();
    }
    
    //撤销操作
    function cancelOperate_onClick(){
        //撤销原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/QuotationAction.do?message="+message[0];
        document.getElementById("cmd").value="cancelOperateHZ";
        form.submit();
    }
    
    
</script>
</head>
<body>

<form name="form" method="post">

 <input  type="hidden"  value="" name="cmd" id="cmd"  >
 <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >
 
<table class="table_noFrame" >
    <tr>
         <td >
         <c:if test="${done=='true'}">
                <input name="button_back" class="icon_2" type="button" value="<fmt:message key="go_back"/>"  onclick="javascript:backTask_onClick();" >
		</c:if>
		<c:if test="${done=='false'}">
		    <input name="button_back" class="icon_2" type="button" value="<fmt:message key='go_back'/>"  onclick="javascript:backTask_onClick();" >
            <input name="button_app" class="icon_2" type="button" value="<fmt:message key='save_and_examine'/>"  onclick="javascript:saveAndagainApproval_onClick();" >
            <input name="button_back" class="icon_2"  type="button" value="<fmt:message key='chexiao'/>"  onclick="javascript:cancelOperate_onClick();" >
		</c:if>
        </td>
    </tr>
</table>


<div id="right">
 <div class="ringht_x">
   <div id="ccParent0" class="box_3"> 
<div class="xz_title"><fmt:message key="basic_information"/></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0"
        bgcolor="#c5dbe2">
      
        <tr>
               <input type="hidden" name="id" value="">
               <input type="hidden" name="contract_id"  value="" /> 
               <input type="hidden" name="customer_id"  value="" /> 
               <input type="hidden" name="company_id" value="" /> 
               <input type="hidden" name="customer_code"  value="" />
               <input type="hidden" name="quotation_status"  value="" />
               <input type="hidden" name="quotation_status_modify"  value="1" />
               <input type="hidden" name="create_user_id"  value="" />
               <input type="hidden" name="create_date"  value="" />
               <input type="hidden" name="quotation_title"  value="" />
               <input type="hidden" name="is_valid"  value="" />
               <input type="hidden" name="is_del"  value="" />
               <input type="hidden" name="add_type_bd"  value="" />
               

             <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_code"/></td>
            <td class="td_2 "><input type="text" class="text_field"
                name="quotation_code" inputName="报价单名称编号" value="" readonly="true" maxLength="50"
                validate="notNull;notNullWithoutTrim " /></td>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_name"/></td>
            <td class="td_2 "><input type="text" class="text_field"
                name="quotation_name" inputName="报价单名称" value="" maxLength="50"
                validate="notNull;notNullWithoutTrim" /></td>

        </tr>

        <tr>

            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2 " ><input type="text" class="text_field"
                name="customer_name" inputName="客户名称" value="" maxLength="50" readonly="true"
                /></td>
             <td class="td_1"><fmt:message key="is_renewal_sign"/></td>

            <td class="td_2" class="td_2">
            <%if(resultVo==null){ %> 
                 <input type='checkbox' name="is_renewal_sign" pdType='control' control='checkbox_template' disabled="disabled"/> 
            <%}else{ if(resultVo.getIs_renewal_sign().equals("1")) {%>
                 <input type='checkbox' name="is_renewal_sign" pdType='control' control='checkbox_template' checked="checked" disabled="disabled"/>
            <%}else {%>
                 <input type='checkbox' name="is_renewal_sign" pdType='control' control='checkbox_template' disabled="disabled"/>
            <%}} %></td>
        </tr>
        <tr>
            <td class="td_1">客户编号</td>
            <td class="td_2">
                <input type="text" class="text_field" name="customer_code" inputName="客户编号" value="${customer_code }" readonly="true" />
             </td>
            <td class="td_1">提交审批人</td>
            <td class="td_2">
                <input type="text" class="text_field" name="creator" inputName="提交审批人" value="${creator }" readonly="true" />
            </td>
        </tr>
        <tr>

               <td class="td_1"><fmt:message key="remark"/></td>
               <td colspan="3" class="td_2"><textarea rows="3" class="textarea_limit_words" id="remark" name="remark"  value="" ></textarea></td>

        </tr>


    </table>

</div>
<div class="button_right" id="div1" style="margin-top: 15px;">
 <div class="xz_title"><fmt:message key="product_information"/></div>
    <div class="button_right" id="productbutton" >
        <ul>
           <li class="c_1"><a onClick="javascript:addProductList();"><fmt:message key="add_product"/></a></li>
            <li class="d"  id="del"><a onClick="javascript:remove();"><fmt:message key="delete"/></a></li>
        </ul>
     </div>
    <div class="clear"></div>
   <div style="margin: 0px;">
     <r:datacell 
        id="datacell1"
        queryAction="/FAERP/QuotationAction.do?cmd=getProduct&quotationid='${bean.id}'"
       
        submitAction="/FAERP/QuotationAction.do?cmd=insertHZ"
        width="98%"
        xpath="QuotationitemVo"
        submitXpath="QuotationitemVo"
        paramFormId="datacell_formid"
        pageSize="-1"
        >
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">

       </r:field>   
      	<r:field fieldName="product_name" width="250px" messagekey="product_name">
		</r:field>

		<r:field fieldName="standard_price" width="100px" messagekey="biaozhun_price">
		</r:field>
		<%if(resultVo!=null && resultVo.getIs_renewal_sign().equals("1")) {%>
		<r:field fieldName="old_price" width="100px" messagekey="oid_price">
		</r:field>
		<%} %>
		<r:field fieldName="product_price" width="100px" messagekey="one_price">
			<h:text validateAttr="allowNull=false;type=float;message=不是数字或精度有误！;"/>
		</r:field>
		<r:field fieldName="product_desc" width="426px" messagekey="product_desc">
		</r:field>

          
    </r:datacell>
   </div>
</div>      

  
   
</div>
<!-- 
<div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%//=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>           
 </div>
 -->

</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
        out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
var quotationstatus=${bean.quotation_status};
//if(quotationstatus=="2")
//{
     jQuery("#productbutton").attr("style", "display:block;");
     jQuery("#remark").attr("readOnly", false);
    
     
//}
	var flag ;
	<%if(resultVo!=null && resultVo.getIs_renewal_sign().equals("1")) {%>
		flag = 1;
		<%} %>
	var a;
	var b;
	 $id("datacell1").afterRefresh = function(){
		var Me = $id("datacell1");
		var rows = Me.allTR;
		for (var i=0;i<rows.length;i++ ){
			var entity1 = Me.dataset.get(i);
			var cells = rows[i].cells;
			for (var j=0;j<cells.length;j++ ){
				var cell = cells[j];
				var field = Me.getField(cell);
				if(flag == 1){
					if(field.fieldName=="old_price"){
					    a =entity1.getProperty(field.fieldName);
					}
				}else{
					if(field.fieldName=="standard_price"){
					    a =entity1.getProperty(field.fieldName);
					}
				}
				if(field.fieldName=="product_price"){
				    b =entity1.getProperty(field.fieldName);
				    if(a != b){
						cell.style.backgroundColor = "red";
					}
				}
			}
			
		}
	}
   $id("datacell1").afterSubmit = function(ajax){
           //  var message =addAppReason("<%=request.getContextPath()%>");
             //alert('message='+message);
           // if(message==null)return;
            var rst = ajax.getProperty("returnValue");
		 		alert(rst);
            	form.action="<venus:base/>/QuotationAction.do?";
           		document.getElementById("cmd").value="saveAndAgainApprovalHZ";
           		form.submit();
   }
</script>
