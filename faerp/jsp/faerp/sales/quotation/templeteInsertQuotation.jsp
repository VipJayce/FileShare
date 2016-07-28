<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.quotation.vo.QuotationVo" %>
<%@ page import="rayoo.system.product.vo.ProductVo"%>
<%@ page import="rayoo.sales.quotation.util.IQuotationConstants" %>
<%@ page import="rayoo.sales.quotationitem.vo.QuotationitemVo" %>
<%@ page import="java.util.*"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	
	   String customer_id = request.getParameter("customer_id")==null ? "":request.getParameter("customer_id").toString();
	   String customer_code = request.getParameter("customer_code")==null ? "" :request.getParameter("customer_code").toString();
	   String product_price = request.getParameter("product_price")==null ? "" :request.getParameter("product_price").toString();
       String count = request.getParameter("count")==null ? "" :request.getParameter("count").toString();
       String company_id = request.getParameter("company_id")==null ? "" :  request.getParameter("company_id").toString().replace(" ","");
       String add_type_bd = request.getParameter("add_type_bd")==null ? "" :  request.getParameter("add_type_bd").toString();
       String contract_id = request.getParameter("contract_id")==null ? "" :request.getParameter("contract_id").toString();
       String quotation_templete_name = request.getParameter("quotation_templete_name")==null ? "" :request.getParameter("quotation_templete_name").toString();
       String quotationcode= request.getAttribute("quotationcode") == null ? "" : request.getAttribute("quotationcode").toString();

      
       
%>
<html>

<fmt:bundle basename="rayoo.salse.quotation.quotation_resource" prefix="rayoo.salse.quotation.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
   function insert_onClick(){  //插入单条数据
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
         if(isrenewalsign)
         {
              $id("datacell1").addParam("is_renewal_sign","0"); 
         }
         else
         {
             $id("datacell1").addParam("is_renewal_sign","1"); 
         }
         $id("datacell1").addParam("contract_id",$name("contract_id").value); 
         $id("datacell1").addParam("customer_id",$name("customer_id").value); 
         $id("datacell1").addParam("company_id",$name("company_id").value);
         $id("datacell1").addParam("customer_code",$name("customer_code").value);
         $id("datacell1").addParam("quotation_status",$name("quotation_status").value);
         $id("datacell1").addParam("id",$name("id").value); 
         $id("datacell1").submit();
    }

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=queryAll&backFlag=true";
        form.submit();
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
                       newEntity.setProperty("count", "1");
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
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
        writeTableTopFesco('<fmt:message key="add_quotation"/>','<%=request.getContextPath()%>/');
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
               <input type="hidden" name="company_id" value="<%=company_id %>" /> 
               <input type="hidden" name="customer_code"  value="<%=customer_code %>" /> 
               <input type="hidden" name="quotation_status"  value="0" /> 
               <input type="hidden" name="templateid" value="${bean.id}"/>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_code"/></td>
            <td class="td_2 "><input type="text" class="text_field" name="quotation_code" inputName="报价单名称编号" value="${quotationcode}" maxLength="50"  readonly="true" 
                validate="notNull;" /></td>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_name"/></td>
            <td class="td_2 "><input type="text" class="text_field"
                name="quotation_name" inputName="报价单名称" value="${bean.quotation_template_name}" maxLength="50"   
                validate="notNull;" /></td>

        </tr>

        <tr>

            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2 "><input type="text" class="text_field"
                name="customer_name" inputName="客户名称" value="<%=request.getParameter("customer_name")%>" maxLength="50"  readonly="true"
                validate="notNull;" /></td>
            <td class="td_1"><fmt:message key="salse_type"/></td>



            <td class="td_2"><%=gap.rm.tools.helper.RmJspHelper.getSelectField(
                            "biz_type_bd", -1, "SAL_QUO_BIZ_TYPE_BD", "1", "",
                            false)%></td>





            </td>
        </tr>

        <tr>
            <td class="td_1"><fmt:message key="is_renewal_sign"/></td>

            <td class="td_2" class="td_2">

              <input type='checkbox' name="is_renewal_sign"  disabled="disabled"  pdType='control' control='checkbox_template' />
            </td>
            <td class="td_1"></td>
            <td class="td_1"></td>

        </tr>
        <tr>

               <td class="td_1"><fmt:message key="remark"/></td>
              <td colspan="3" class="td_2"><textarea rows="3" class="textarea_limit_words" id="user3" name="remark" value="${bean.remark}"></textarea></td>

        </tr>


    </table>

</div>
<div class="button_right" id="div1" style="margin-top: 15px;">
  <div class="xz_title"><fmt:message key="product_information"/></div>
    <div class="button_right">
        <ul>
           <li class="c_1"><a onClick="javascript:addProductList();"><fmt:message key="add_product"/></a></li>
            <li class="d"  id="del"><a onClick="javascript:remove();"><fmt:message key="delete"/></a></li>
        </ul>
     </div>
    <div class="clear"></div>
   <div style="margin: 0px;">
     <r:datacell 
        id="datacell1"
       
       
       submitAction="/FAERP/QuotationAction.do?cmd=insert"
        width="98%"
        xpath="QuotationitemVo"
        submitXpath="QuotationitemVo"
        paramFormId="datacell_formid"
        pageSize="-1"
        >
       <r:field fieldName="pid"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">

       </r:field>   
       <r:field fieldName="product_name" width="250px" messagekey="product_name">
       </r:field>   

        <r:field fieldName="product_price" width="100px" messagekey="biaozhun_price" >
        <h:text validateAttr="allowNull=false;type=float;message=不是数字或精度有误！;"/>
       </r:field> 
       <r:field fieldName="count" width="250px" messagekey="count" >
         <h:text validateAttr="allowNull=false;type=number;message=不是数字或精度有误！;"/>
       </r:field>   
       <r:field fieldName="product_desc" width="486px" messagekey="product_desc" >
       </r:field> 
          
    </r:datacell>
   </div>


    <div class="mx_button"  style="text-align: center;">
        
          <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%="insert_onClick()"%>" />    
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	 $id("datacell1").beforeInit()
	 {
	       var id = $name("templateid").value
	       jQuery.getJSON("<venus:base/>/QuotationtemplateitemAction.do?cmd=addProduct1&date="+new Date()+"",{"quotation_template_id":id},   function(json){
                        
              if(json.beans!=null&&json.beans!="")
              {
              
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("product_id", json.beans[i].id);
                       newEntity.setProperty("product_name", json.beans[i].product_name);
                       newEntity.setProperty("product_price", json.beans[i].product_price);
                        newEntity.setProperty("count","1");
                       newEntity.setProperty("product_desc", json.beans[i].product_desc);
                       $id("datacell1").addRow(newEntity);
                }
              }
              });
	 }
	   $id("datacell1").afterSubmit = function(ajax){
            form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=queryAll&backFlag=true";
            form.submit();
            }
</script>
</body>
</html>

<script language="javascript">

</script>
