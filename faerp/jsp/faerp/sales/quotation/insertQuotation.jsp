<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.quotation.vo.QuotationVo" %>
<%@ page import="rayoo.system.product.vo.ProductVo"%>
<%@ page import="rayoo.sales.quotation.util.IQuotationConstants" %>
<%@ page import="rayoo.sales.quotationitem.vo.QuotationitemVo" %>
<%@page import="rayoo.sales.quotation.dao.impl.QuotationDao"%>
<%@ page import="java.util.*"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<h:script src="/js/common/taxGenerate.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	    QuotationVo resultVo = null;  //定义一个临时的vo变量
	    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
	        isModify = true;  //赋值isModify为true
	        if(request.getAttribute(IQuotationConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
	            resultVo = (QuotationVo)request.getAttribute(IQuotationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	        }
	    }
       String customer_id = request.getParameter("customer_id")==null ? "":request.getParameter("customer_id").toString();
       String customer_code = request.getParameter("customer_code")==null ? "" :request.getParameter("customer_code").toString();
       String customer_name = request.getParameter("customer_name")==null ? "" : request.getParameter("customer_name").toString();
       String product_price = request.getParameter("product_price")==null ? "0" :request.getParameter("product_price").toString();
       String company_id = request.getParameter("company_id")==null ? "" :  request.getParameter("company_id").toString().trim();
       String add_type_bd = request.getParameter("add_type_bd")==null ? "" :  request.getParameter("add_type_bd").toString();
       String contract_id = request.getParameter("contract_id")==null ? "" :request.getParameter("contract_id").toString();
       String quotation_name = request.getParameter("quotation_name")==null ? "" :request.getParameter("quotation_name").toString();
       String quotation_code= request.getParameter("quotation_code") == null ? "" : request.getParameter("quotation_code").toString();
       //获取登录人公司ID
       String com_id = "'"+rayoo.common.pub.PubHelper.getCompanyID((HttpServletRequest) request)+"'";
       String  contract_type_bd=request.getParameter("contract_type_bd")==null?"":request.getParameter("contract_type_bd").toString();
       if(contract_type_bd==null||"".equals(contract_type_bd)){
       	contract_type_bd=request.getAttribute("contract_type_bd")==null?"":request.getAttribute("contract_type_bd").toString();
       }
%>

<html>

<fmt:bundle basename="rayoo.salse.quotation.quotation_resource" prefix="rayoo.salse.quotation.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
window.onload=function(){
	var a = '<%=contract_type_bd %>';
	if(a==null||a==""){//找不到合同
		alert("该合同类型未配置业务类型，请联系管理员！");
		return false;
	}
	jQuery.getJSON("<venus:base/>/QuotationAction.do?cmd=getTaxrate",{"contract_type_bd":"<%=contract_type_bd %>"},   function(json){
		$name("taxrate").value=json.taxrate;//增值税税率
		$name("add_taxrate").value=json.add_taxrate;
		$name("taxrateBu").value=json.taxrateBu;//增值税税率
		$name("add_taxrateBu").value=json.add_taxrateBu;//增值税税率
	});

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

    function insert_onClick(obj){  //插入单条数据
        if($name("quotation_name").value==null||$name("quotation_name").value=="")
        {
            alert("<fmt:message key="quotation_not_null"/>");
            return;
        }
        var productid = document.getElementsByName("product_id");
        if(productid.length<=0)
        {
            alert("<fmt:message key="product_not_null"/>");
            return ;
        }
         $id("datacell1").isModefied = true;
         $id("datacell1").addParam("quotation_name",$name("quotation_name").value); 
         $id("datacell1").addParam("biz_type_bd",$name("biz_type_bd").value); 
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
         $id("datacell1").addParam("customer_code",$name("customer_code").value);
         $id("datacell1").addParam("quotation_status",$name("quotation_status").value);
         $id("datacell1").addParam("id",$name("id").value); 
         if(obj == 1){
         	$id("datacell1").addParam("flag",obj); 
         }
         
         if(<%=com_id%> == "7779100700000000083"){
            $id("datacell1").submitAction="/FAERP/QuotationAction.do?cmd=insertHZ";
         }else{
            $id("datacell1").submitAction="/FAERP/QuotationAction.do?cmd=insert";
         }
         $id("datacell1").submit();
    }

    function update_onClick(obj){  //保存修改后的单条数据
          $id("datacell1").isModefied = true;
          $id("datacell1").addParam("quotation_name",$name("quotation_name").value); 
         $id("datacell1").addParam("biz_type_bd",$name("biz_type_bd").value); 
         $id("datacell1").addParam("add_type_bd",$name("add_type_bd").value); 
         $id("datacell1").addParam("quotation_code",$name("quotation_code").value); 
         $id("datacell1").addParam("customer_name",$name("customer_name").value); 
         $id("datacell1").addParam("oldid",$name("oldid").value); 
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
         $id("datacell1").addParam("customer_code",$name("customer_code").value);
         $id("datacell1").addParam("quotation_status",$name("quotation_status").value);
         $id("datacell1").addParam("id",$name("id").value); 
         if(obj != 1){
         	$id("datacell1").addParam("flag",obj);
         }
         if(<%=com_id%> == "7779100700000000083"){
            $id("datacell1").submitAction="/FAERP/QuotationAction.do?cmd=insertHZ";
         }else{
            $id("datacell1").submitAction="/FAERP/QuotationAction.do?cmd=insert";
         }
         $id("datacell1").submit();

    }

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }
    
     //添加产品
  function checkpageproduct(obj){
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
                   deleteids+=entity.getProperty("product_name")+"<fmt:message key="not_add_delete"/>";
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
              var taxrate = $name("taxrate").value;
              var add_taxrate = $name("add_taxrate").value;

              if(json.error!=null&&json.error!="")
              {
                    alert(json.error);
              }
              if(json.beans!=null&&json.beans!="")
              {
              
                for(var i = 0 ;i<json.beans.length;i++)
                {
                	if("Y"==json.beans[i].if_dept_bu){
            			taxrate = $name("taxrateBu").value;
            			add_taxrate = $name("add_taxrateBu").value;
            		}else{
            			taxrate = $name("taxrate").value;
            			add_taxrate = $name("add_taxrate").value;
            		} 
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("if_dept_bu",
                               json.beans[i].if_dept_bu);
                       newEntity.setProperty("product_id", json.beans[i].id);
                       newEntity.setProperty("product_name", json.beans[i].product_name);
                       newEntity.setProperty("product_price", json.beans[i].product_price);
                       newEntity.setProperty("product_desc", json.beans[i].product_desc);
                       var returnValue = taxGenerate(parseFloat(json.beans[i].product_price),parseFloat(taxrate),parseFloat(add_taxrate));//获取增值税、附加税金额
                       newEntity.setProperty("vat_amount", returnValue[0]);
                       newEntity.setProperty("add_vat_amount", returnValue[1]);
                       newEntity.setProperty("add_vat_rate", add_taxrate);
                       newEntity.setProperty("vat_rate", taxrate);
                       newEntity.setProperty("count", "1");
                       $id("datacell1").addRow(newEntity);
                       delProducts[json.beans[i].id] = false;
                }
              }
              });
        }
        checkSum();
        //checkPrice('product_price','vat_amount','add_vat_amount','产品价格');
      //  $id("datacell1").submit();
      //  $id("datacell1").loadData();
      //  $id("datacell1").refresh();
    }
    function addProductList() {
              var url="<%=request.getContextPath()%>/ProductAction.do?cmd=queryAllProduct&checkQuotation=true";
             showModalCenter(url, window,toaddProductlistrollback,780,447,"添加产品");
    }
    
      function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='product_id'  value ="+entity.getProperty("product_id")+" onClick=ClickRow(\"" + entity.getProperty("product_id") + "\");>";
    }
    
    
     function ClickRow(){}
     
     var delProducts = {};
     
     function remove()
    {
           var elementCheckbox = document.getElementsByName("product_id");
           var datacell = $id("datacell1");
           for(var i=elementCheckbox.length-1;i>=0;i--){  //循环checkbox组
	            if(elementCheckbox[i].checked) {  //如果被选中
	            	var row = datacell.getRow(i);
	                var datasettr = datacell.getEntity(row);
	                var product_id = datasettr.getProperty("product_id");
		            delProducts[product_id] = true;
	                datacell.deleteRow(i);
	            }
	        }
           checkSum();
           //checkPrice('product_price','vat_amount','add_vat_amount','产品价格');

    } 
    

</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>){
        writeTableTopFesco('<fmt:message key="modify_quotation"/>','<%=request.getContextPath()%>');
    }else{
        writeTableTopFesco('<fmt:message key="add_quotation"/>','<%=request.getContextPath()%>');
    }
</script>
 <div class="ringht_x">
   <div id="ccParent0" class="box_3"> 
<div class="xz_title"><fmt:message key="basic_information"/></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0"
        bgcolor="#c5dbe2">
      
        <tr>
               <input type="hidden" name="contract_id"  value="<%=contract_id%>" /> 
               <input type="hidden" name="customer_id"  value="<%=customer_id%>" /> 
               <input type="hidden" name="add_type_bd"  value="<%=add_type_bd%>" /> 
               <input type="hidden" name="company_id" value="<%=company_id.trim() %>" /> 
               <input type="hidden" name="customer_code"  value="<%=customer_code %>" /> 
                <input type="hidden" name="quotation_status"  value="0"/> 
                <input type="hidden" name ="oldid" value="${bean.id}"/>
                <input type="hidden" name="biz_type_bd"  value="0" /> 
                 <input type="hidden" name ="id" value="${bean.id}"/>
                <input type="hidden" name="taxrate"  value="" />
                <input type="hidden" name="add_taxrate"  value="" />
                <input type="hidden" name="taxrateBu"  id="taxrateBu" value="" />
            <input type="hidden" name="add_taxrateBu"  id="add_taxrateBu" value="" />
                 
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_code"/></td>
            <td class="td_2 "><input type="text" class="text_field"
                name="quotation_code" inputName="报价单名称编号" value="<%=quotation_code %>" readonly="true" maxLength="50"
                validate="notNull;notNullWithoutTrim " /></td>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_name"/></td>
            <td class="td_2 "><input type="text" class="text_field"
                name="quotation_name" inputName="报价单名称" value="" maxLength="50"
                validate="notNull;notNullWithoutTrim" /></td>
        </tr>
        <tr>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2 ">
            <input type="text" class="text_field" name="customer_name" inputName="客户名称" value="<%=customer_name%>" maxLength="50" readonly="true" />
            </td>
            <td class="td_1"><fmt:message key="is_renewal_sign"/></td>

            <td class="td_2" class="td_2">
            <%if(resultVo==null){ %> 
                 <input type='checkbox' name="is_renewal_sign"   disabled="disabled"    pdType='control' control='checkbox_template' /> 
            <%}else{ 
                if((resultVo.getIs_renewal_sign())!=null&&(resultVo.getIs_renewal_sign()).equals("1")) {%>
                 <input type='checkbox' name="is_renewal_sign"  disabled="disabled"   pdType='control' control='checkbox_template' checked="checked" />
            <%}else {%>
                 <input type='checkbox' name="is_renewal_sign"  disabled="disabled"  pdType='control' control='checkbox_template' />
            <%}
                } %>
        </tr>
        <tr>
               <td class="td_1"><fmt:message key="remark"/></td>
               <td class="td_2"><textarea rows="3" class="textarea_limit_words" name="remark"></textarea></td>
               <td class="td_1">标准报价单</br>新建指引</td>
	           <td class="td_2 " style="padding: 4 4 4 4;">
	              <a href="#" style="font-size: 12px;color:blue;" onclick="toHelp('A');"> 
                       A.  公司标准报价单对应的ERP报价单中的产品名称
                  </a>
	              </br></br>
	               <a href="#" style="font-size: 12px;color:blue;" onclick="toHelp('B');"> 
	                   B.  新建报价单注意点
	               </a>
	               </br></br>
	               <a href="#" style="font-size: 12px;color:blue;" onclick="toHelp('C');"> 
	                   C.  常见Q&A
                    </a>
	           </td>
        </tr>
    </table>
</div>

<div class="button_right" id="div1" style="margin-top: 15px;">
 <div class="xz_title"><fmt:message key="product_information"/></div>
    <div id="addFlag" class="button_right" >
        <ul>
           <li class="c_1"  id="add" style="display:block"><a onClick="javascript:addProductList();"><fmt:message key="add_product"/></a></li>
            <li class="d"  id="del" style="display:block"><a onClick="javascript:remove();"><fmt:message key="delete"/></a></li>
            <li   class="approdetial" ><a onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>;"><fmt:message key="save"/></a></li>
            <li class="approdetial" id="approval" style="display:block"><a onClick="javascript:<%=isModify?"update_onClick(1)":"insert_onClick(1)"%>;"><fmt:message key="save_submit_examine"/></a></li>
            <li class="approdetial" ><a onClick="javascript:cancel_onClick();"><fmt:message key="cancel"/></a></li>
        </ul>
     </div>
     <div class="clear" ></div> 
     <div>
     <label name="serviceSum" id="serviceSum" color="blue"></label>
     		     		<label name="addedSum" id="addedSum" color="blue"></label>
     		
     		     		<label name="surtaxSum" id="surtaxSum" color="blue"></label>
     		
     		     		<label name="quotationSum" id="quotationSum" color="blue"></label>
           <!--  <input name="serviceSum" type="text"  id="serviceSum" onchange="" style="width:150px;"/>
            <input name="addedSum" type="text"  id="addedSum" onchange="" style="width:150px;"/>
            <input name="surtaxSum" type="text"  id="surtaxSum" onchange="" style="width:150px;"/>
            <input name="quotationSum" type="text" id="quotationSum" onchange="" style="width:150px;"/> -->
     </div>
    <div class="clear"></div>
   <div style="margin: 0px;">
     <r:datacell 
        id="datacell1"
       queryAction="/FAERP/QuotationAction.do?cmd=getProduct&quotationid='${bean.id}'"
       submitAction=""
        width="98%"
        xpath="QuotationitemVo"
        submitXpath="QuotationitemVo"
        paramFormId="datacell_formid"
        pageSize="-1"
        
        >
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">

       </r:field>   
       <r:field fieldName="product_name" width="250px" messagekey="product_name" >
       </r:field>   

       <r:field fieldName="product_price" width="100px" messagekey="product_price" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})" >
        <h:text validateAttr="allowNull=false;type=float;message=不是数字或精度有误！;" onchange="javascript:checkPrice('product_price','vat_amount','add_vat_amount','产品价格');"/>
       </r:field> 
      <r:field fieldName="vat_amount" width="100px" label="增值税" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})" >
       </r:field> 
       <r:field fieldName="vat_rate" width="100px" label="增值税税率">
       </r:field>
       <r:field fieldName="add_vat_amount" width="100px" label="附加税" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})" >
       </r:field>
       <r:field fieldName="add_vat_rate" width="100px" label="附加税税率">
       </r:field>  
       <r:field fieldName="product_desc" width="486px" messagekey="product_desc" >
       </r:field> 
          
    </r:datacell>
   </div>
</div>         
	
    </div>           
 </div>


    
<input type="hidden" name="id" value=""/>
<input type="hidden" name="create_date" />

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
          //判断是否有子表信息
    }
%>

var modify_type = "${modify_type}";
	if(modify_type == '5'){
		document.getElementById("add").style.display='none';
		document.getElementById("del").style.display='none';
		document.getElementById("approval").style.display='none';
		$id("datacell1").readonly="true";
	}
   	$id("datacell1").afterSubmit = function(ajax){
   			var rst = ajax.getProperty("returnValue");
   			alert(rst);
         	/*form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=queryAll&backFlag=true";
         	form.submit();*/
         	window.close();
   		 
	}
	
	//魏佳新增--新建报价单时可以查看相关帮助信息
	function toHelp(type){
	    var url = "";
	    if(type == "A"){
	       url = "<%=request.getContextPath()%>/jsp/faerp/sales/quotation/newQuotationHelp.jsp?type=A"
	    }
	    if(type == "B"){
           url = "<%=request.getContextPath()%>/jsp/faerp/sales/quotation/newQuotationHelp.jsp?type=B"
        }
        if(type == "C"){
           url = "<%=request.getContextPath()%>/jsp/faerp/sales/quotation/newQuotationHelp.jsp?type=C"
        }
        window.open(url,'','height=500px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listHire0002'/>');
    }
	
	$id("datacell1").afterRefresh = function (){
		jQuery.getJSON("<venus:base/>/QuotationAction.do?cmd=getTaxrate",{"contract_type_bd":"<%=contract_type_bd %>"},   function(json){
			$name("taxrate").value=json.taxrate;//增值税税率
			$name("add_taxrate").value=json.add_taxrate;//增值税税率
			$name("taxrateBu").value=json.taxrateBu;//增值税税率
			$name("add_taxrateBu").value=json.add_taxrateBu;//增值税税率
			//checkPrice('product_price','vat_amount','add_vat_amount','产品价格');
			checkSum();
		});
	}
	
	function checkSum(){
		 var datacell = $id("datacell1");
		    var dataset = datacell.dataset;//取得页面的datacell
		 //联动总额
	       var serviceSum=0;
	       var addedSum=0;
	       var surtaxSum=0;
	       var quotationSum=0;
	       for(var i=0; i<dataset.getLength(); i++){
	    	   var product_id = dataset.get(i).getProperty("product_id");
	    	   var product_price = dataset.get(i).getProperty("product_price");
	    	   var vat_amount = dataset.get(i).getProperty("vat_amount");
	    	   var add_vat_amount = dataset.get(i).getProperty("add_vat_amount");
	    	   if(delProducts[product_id] != true){
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
	      }
	       
	       /* for(var i=0; i<dataset.getLength(); i++){
	    	   var product_id = dataset.get(i).getProperty("product_id");
	           if(delProducts[product_id] != true){
	        	   serviceSum+=parseFloat(dataset.get(i).getProperty("product_price"));
		    	   addedSum+=parseFloat(dataset.get(i).getProperty("vat_amount"));
		    	   surtaxSum+=parseFloat(dataset.get(i).getProperty("add_vat_amount"));
	           }
	      } */
	       $name("serviceSum").innerText = "服务费合计："+serviceSum.toFixed(2);
	       //$name("serviceSum").value="服务费合计："+serviceSum.toFixed(2);
	       $name("addedSum").innerText="  增值税合计："+addedSum.toFixed(2);
	       $name("surtaxSum").innerText="  附加税合计："+surtaxSum.toFixed(2);
	       $name("quotationSum").innerText="  报价单总额："+parseFloat(serviceSum+addedSum+surtaxSum).toFixed(2);
	       
	       /* $name("serviceSum").value="服务费合计："+serviceSum.toFixed(2);
	       $name("addedSum").value="增值税合计："+addedSum.toFixed(2);
	       $name("surtaxSum").value="附加税合计："+surtaxSum.toFixed(2);
	       $name("quotationSum").value="报价单总额："+parseFloat(serviceSum+addedSum+surtaxSum).toFixed(2); */
	}
	
	 function  checkPrice(fieldname,freshFiledname1,freshFiledname2,msgname){
	        var datacell = $id("datacell1");
		    var dataset = datacell.dataset;//取得页面的datacell

	        var activeRow = datacell.activeRow;
	        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
	        if(dataset.getLength()>0){
	        	var price = datasettr.getProperty(fieldname);
	        	 var if_dept_bu = datasettr.getProperty("if_dept_bu");
	 	       if(!checkFloat(price)){
	 	           alert(msgname+"输入有误！");
	 	           datasettr.setProperty(fieldname,"0");
	 	           return;
	 	       } 
	 	       
	 	       var taxrate = $name("taxrate").value;
	 	      var add_taxrate = $name("add_taxrate").value;
	 	     if("Y"==if_dept_bu){
	       			taxrate = $name("taxrateBu").value;
	       			add_taxrate = $name("add_taxrateBu").value;
	       		}else{
	       			taxrate = $name("taxrate").value;
	       			add_taxrate = $name("add_taxrate").value;
	       		}
	 	       //计算附加税和增值税
	 	       var returnValue = taxGenerate(price,parseFloat(taxrate),parseFloat(add_taxrate));//获取增值税、附加税金额
	 	       datasettr.setProperty(freshFiledname1,returnValue[0]);
	 	       datasettr.setProperty(freshFiledname2,returnValue[1]);
	        }
			checkSum();
	    
	    }
	    
	  //检查输入参数是否为浮点数
		function checkFloat(str){
		    var rc=true;
		    oneDecimal=false;
		    if (str+"" == "undefined" || str == null || str==''){
		        rc=false;
		    } else{
		        for(i=0;i<str.length;i++){
		            ch=str.charAt(i);
		            if(i==0 && ch=='-'){
		                continue;
		            }
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
