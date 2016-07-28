<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.sales.quotation.vo.QuotationVo" %>
<%@ page import="rayoo.sales.quotation.util.IQuotationConstants" %>
<%@ page import="java.util.*"%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //取出本条记录
	QuotationVo resultVo = null;  //定义一个临时的vo变量
    List list =null;
	List qtitemlist = null;
    if(request.getAttribute("list") != null) {  //如果request中取出的bean不为空
        list = (List)request.getAttribute("list");  
    if(request.getAttribute("qtitemlist")!=null)
    {
        qtitemlist=(List)request.getAttribute("qtitemlist");
       
    }
    }
	resultVo = (QuotationVo)request.getAttribute(IQuotationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	//RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤

	
	 String customer_id = request.getParameter("customer_id")==null ? "":request.getParameter("customer_id").toString()+" ";
     String customer_code = request.getParameter("customer_code")==null ? "" :request.getParameter("customer_code").toString();
     String product_price = request.getParameter("product_price")==null ? "" :request.getParameter("product_price").toString();
     String count = request.getParameter("count")==null ? "" :request.getParameter("count").toString();
     String company_id = request.getParameter("company_id")==null ? "" :  request.getParameter("company_id").toString().replace(" ","");
     String add_type_bd = request.getParameter("add_type_bd")==null ? "" :  request.getParameter("add_type_bd").toString();
     String contract_id = request.getParameter("contract_id")==null ? "" :request.getParameter("contract_id").toString();
   
%>
<html>
<fmt:bundle basename="rayoo.salse.quotation.quotation_resource" prefix="rayoo.salse.quotation.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        window.close();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 
	
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	<fmt:message key="detail_page"/>
	 </div>
	 </div>
    	<div class="ringht_s">
 

   <div id="ccParent0" class="box_3">  
 <div class="xz_title"><fmt:message key="basic_information"/></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0"
        bgcolor="#c5dbe2">

        <tr>
             <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_code"/></td>
           <td class="td_2" ><%=RmStringHelper.prt(resultVo.getQuotation_code())%></td>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_name"/></td>
         <td class="td_2" ><%=RmStringHelper.prt(resultVo.getQuotation_name())%></td>

        </tr>

        <tr>

        <td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_name())%></td>
               <td class="td_1"><fmt:message key="is_renewal_sign"/></td>

            <td class="td_2">  <%if(resultVo==null){ %> 
                 <input type='checkbox' name="is_renewal_sign" disabled="disabled"  value="<bean:write name="bean" property="is_renewal_sign"/>" pdType='control' control='checkbox_template'  readonly="true"/> 
            <%}else{ if((resultVo.getIs_renewal_sign())!=null&&(resultVo.getIs_renewal_sign()).equals("1")) {%>
                 <input type='checkbox' name="is_renewal_sign" disabled="disabled"  value="<bean:write name="bean" property="is_renewal_sign" />" pdType='control' control='checkbox_template' checked="checked"  readonly="true"/>
            <%}else {%>
                 <input type='checkbox' name="is_renewal_sign" disabled="disabled"  value="<bean:write name="bean" property="is_renewal_sign" />" pdType='control' control='checkbox_template'  readonly="true"/>
            <%}} %>
            </td>
        </tr>

        <tr>
             <td class="td_1"><fmt:message key="remark"/></td>
             <td colspan="3" class="td_2"><textarea rows="3" class="xText_d"  name="remark" readonly="readonly"><%=RmStringHelper.prt(resultVo.getRemark())%></textarea></td>

        
            
        </tr>


    </table>
</div>
<div class="button_right" id="div1" style="margin-top: 15px;">
	
	<div class="xz_title"><fmt:message key="product_information"/></div>
 <div class="clear" ></div> 
     <div>
     <label name="serviceSum" id="serviceSum" color="blue"></label>
     		     		<label name="addedSum" id="addedSum" color="blue"></label>
     		
     		     		<label name="surtaxSum" id="surtaxSum" color="blue"></label>
     		
     		     		<label name="quotationSum" id="quotationSum" color="blue"></label>
            <!-- <input name="serviceSum" type="text"  id="serviceSum" onchange="" style="width:150px;"/>
            <input name="addedSum" type="text"  id="addedSum" onchange="" style="width:150px;"/>
            <input name="surtaxSum" type="text"  id="surtaxSum" onchange="" style="width:150px;"/>
            <input name="quotationSum" type="text" id="quotationSum" onchange="" style="width:150px;"/> -->
     </div>
    <div class="clear"></div>
    

    <r:datacell 
        id="datacell1"
       queryAction="/FAERP/QuotationAction.do?cmd=getProduct&quotationid='${bean.id}'&quotation_code=${quotation_code }&quotation_name=${quotation_name }&quotation_status=${quotation_status }&customer_name1=${customer_name }"
        width="98%"
        xpath="QuotationitemVo"
        submitXpath="QuotationitemVo"
        paramFormId="datacell_formid"
        pageSize="-1"
        readonly="true"
        >
       <r:field fieldName="product_name" width="250px" messagekey="product_name" >
       </r:field>   
       <r:field fieldName="product_price" width="100px" messagekey="biaozhun_price" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
        <h:text validateAttr="allowNull=false;"/>
       </r:field> 
       <r:field fieldName="vat_amount" width="100px" label="增值税" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
       </r:field> 
       <r:field fieldName="vat_rate" width="100px" label="增值税税率">
       </r:field>
       <r:field fieldName="add_vat_amount" width="100px" label="附加税" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
       </r:field>
       <r:field fieldName="add_vat_rate" width="100px" label="附加税税率">
       </r:field>  
       <r:field fieldName="product_desc" width="486px" messagekey="product_desc" >
       </r:field> 
          
    </r:datacell>


  	
<div class="foot_button" style="text-align: center;">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	$id("datacell1").afterRefresh = function(){
		checkPrice('product_price','vat_amount','add_vat_amount','产品价格');
	}
	
	function formatNumber(srcStr, formatStr){
		  //var srcStr,
		  formatStr = ""+formatStr+"";
		  formatLen = formatStr.length;
		  formatPos = formatStr.indexOf(".",0);
		  nAfterDot = formatPos == -1 ? 0 : formatLen - formatPos - 1;
		  isFill = formatStr.substring(formatLen-1, formatLen)=="0";//是否补0

		  var resultStr, nTen;
		  srcStr = ""+srcStr+"";
		  strLen = srcStr.length;
		  dotPos = srcStr.indexOf(".",0);
		  if (dotPos == -1){
		    if(nAfterDot >0 && isFill){
		      resultStr = srcStr + ".";
		      for (i=0; i<nAfterDot; i++)
		        resultStr = resultStr+"0";
		    }
		    else
		      resultStr = srcStr;
		    return resultStr;
		  }
		  else
		  {
		    if ((strLen - dotPos - 1) >= nAfterDot){
		      nAfter = dotPos + nAfterDot + 1;
		      nTen =1;
		      for(j=0;j<nAfterDot;j++){
		        nTen = nTen*10;
		      }
		      resultStr = Math.round(parseFloat(srcStr)*nTen)/nTen;
		      //if(isFill)
		        //return formatNumber(resultStr, formatStr);
		      return resultStr;
		    }
		    else{
		      resultStr = srcStr;
		      for (i=0; isFill && i<(nAfterDot - strLen + dotPos + 1); i++){
		        resultStr = resultStr+"0";
		      }
		      return resultStr;
		    }
		  }
		}
	
	function  checkPrice(fieldname,freshFiledname1,freshFiledname2,msgname){
	    var datacell = $id("datacell1");
	    var dataset = datacell.dataset;//取得页面的datacell
	   
	   
	 //联动总额
	   var serviceSum=0;
	   var addedSum=0;
	   var surtaxSum=0;
	   var quotationSum=0;
	   for(var i=0; i<dataset.getLength(); i++){
    	   var product_price = dataset.get(i).getProperty("product_price");
    	   var vat_amount = dataset.get(i).getProperty("vat_amount");
    	   var add_vat_amount = dataset.get(i).getProperty("add_vat_amount");
    	   if(product_price!=null&&product_price!=''&&product_price!='0'){
        	   serviceSum+=parseFloat(product_price);
    	   }
    	   if(vat_amount!=null&&vat_amount!=''){
        	   addedSum+=parseFloat(vat_amount);
    	   }
    	   if(add_vat_amount!=null&&add_vat_amount!=''){
    		   surtaxSum+=parseFloat(add_vat_amount);
    	   }
      }
	   
	  /*  for(var i=0; i<dataset.getLength(); i++){
	    	   serviceSum+=parseFloat(dataset.get(i).getProperty("product_price"));
	    	   addedSum+=parseFloat(dataset.get(i).getProperty("vat_amount"));
	    	   surtaxSum+=parseFloat(dataset.get(i).getProperty("add_vat_amount"));
	       
	  } */
	   $name("serviceSum").innerText = "服务费合计："+serviceSum.toFixed(2);
	   //$name("serviceSum").value="服务费合计："+serviceSum.toFixed(2);
	   $name("addedSum").innerText="  增值税合计："+addedSum.toFixed(2);
	   $name("surtaxSum").innerText="  附加税合计："+surtaxSum.toFixed(2);
	   $name("quotationSum").innerText="  报价单总额："+parseFloat(serviceSum+addedSum+surtaxSum).toFixed(2);
	}
</script>
</body>
</html>
