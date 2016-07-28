<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="rayoo.system.product.vo.ProductVo"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.quotationtemplate.vo.QuotationVo"%>
<%@ page import="rayoo.sales.quotationtemplateitem.vo.QuotationitemVo" %>
<%@ page import="rayoo.sales.quotationtemplate.util.IQuotationConstants"%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%
    //判断是否为修改页面
    QuotationVo resultVo = null; //定义一个临时的vo变量
    boolean isModify = false; //定义变量,标识本页面是否修改(或者新增)
    if (request.getParameter("isModify") != null) { //如果从request获得参数"isModify"不为空
        isModify = true; //赋值isModify为true
        if (request.getAttribute(IQuotationConstants.REQUEST_BEAN) != null) { //如果request中取出的bean不为空
            resultVo = (QuotationVo) request .getAttribute(IQuotationConstants.REQUEST_BEAN); //从request中取出vo, 赋值给resultVo
        }
    }
%>
<html>
<fmt:bundle basename="rayoo.salse.quotationtemplate.quotationtemplate_resource" prefix="rayoo.salse.quotationtemplate.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
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
	function insert_onClick(){  //插入单条数据
	    selectAllRows();
	    var trids = findSelections1("checkbox_template","id");
	    var quotation_template_name=document.form.quotation_template_name.value;
	    var biz_type_bd=document.form.biz_type_bd.value;
	    var effect_date = document.form.effect_date.value;
	    var lapse_date = document.form.lapse_date.value;
	    var aStart=effect_date.replace(/-/g,"\/"); //转成成数组，分别为年，月，日，下同
	    var aEnd=lapse_date.replace(/-/g,"\/");
	    if(quotation_template_name==""){
            alert("<fmt:message key="template_name_not_null"/>");
            document.form.quotation_template_name.focus();
            return;
        }
        if(biz_type_bd==""||biz_type_bd=="0"){
            alert("<fmt:message key="biz_type_not_null"/>");
            return;
        }
        if(effect_date==""&&lapse_date!=""){
           alert("<fmt:message key="input_effect_date"/>");
           return;
        }
        if(effect_date!=""&&lapse_date==""){
           alert("<fmt:message key="input_lapse_date"/>");
           return;
        }
        if (aStart > aEnd) {
            alert("<fmt:message key="effect_less_lapse"/>");
            return;
        }
         $id("datacell1").isModefied = true;
         $id("datacell1").addParam("quotation_template_name",$name("quotation_template_name").value); 
         $id("datacell1").addParam("biz_type_bd",$name("biz_type_bd").value); 
         $id("datacell1").addParam("effect_date",$name("effect_date").value); 
         $id("datacell1").addParam("lapse_date",$name("lapse_date").value); 
         $id("datacell1").addParam("remark",$name("remark").value); 
         $id("datacell1").addParam("pro_desc",$name("pro_desc").value); 
         $id("datacell1").addParam("id",$name("id").value); 
         $id("datacell1").submit();

	}

  	function update_onClick(id){  //保存修改后的单条数据
  	    selectAllRows();
        var trids = findSelections1("checkbox_template","id");
    	var quotation_template_name=document.form.quotation_template_name.value;
        var biz_type_bd=document.form.biz_type_bd.value;
        var effect_date = document.form.effect_date.value;
        var lapse_date = document.form.lapse_date.value;
        var aStart=effect_date.replace(/-/g,"\/"); //转成成数组，分别为年，月，日，下同
        var aEnd=lapse_date.replace(/-/g,"\/");
        if(quotation_template_name==""){
            alert("<fmt:message key="template_name_not_null"/>");
            document.form.quotation_template_name.focus();
            return;
        }
        if(biz_type_bd==""||biz_type_bd=="0"){
            alert("<fmt:message key="biz_type_not_null"/>");
            return;
        }
        if(effect_date==""&&lapse_date!=""){
           alert("<fmt:message key="input_effect_date"/>");
           return;
        }
        if(effect_date!=""&&lapse_date==""){
           alert("<fmt:message key="input_lapse_date"/>");
           return;
        }
        if (aStart > aEnd) {
            alert("<fmt:message key="effect_less_lapse"/>");
            return;
        }
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		  if($name("pro_desc").checked)
		  {
		            $id("datacell1").addParam("pro_desc","1"); 
		  }
		  else
		  {
		            $id("datacell1").addParam("pro_desc","0"); 
		  }
		  $id("datacell1").isModefied = true;
	      $id("datacell1").addParam("quotation_template_name",$name("quotation_template_name").value); 
          $id("datacell1").addParam("biz_type_bd",$name("biz_type_bd").value); 
          $id("datacell1").addParam("effect_date",$name("effect_date").value); 
          $id("datacell1").addParam("lapse_date",$name("lapse_date").value); 
          $id("datacell1").addParam("remark",$name("remark").value); 

           $id("datacell1").addParam("id",$name("id").value); 
          $id("datacell1").submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/QuotationtemplateAction.do?cmd=queryAll";
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
            if(productid.length>0)
            {
                 for(var j=0;j<productid.length;j++)
	            {
	
	                var entity=$id("datacell1").dataset.get(j);   
	                if(entity.getProperty("product_id")==(ids+",").split(",")[i])
	                {
	                   istrue="true";
	                   deleteids+="【"+entity.getProperty("product_name")+"】\n";
	                   break;
	                }
	                else
	                {
	                     istrue="false";                       
	                }
	             }
            }
           
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        
        if(deleteids!=""){
               deleteids+="<fmt:message key="table_not_add"/>\n";
               }
        var returnAry = new Array();
        returnAry[0]=addids;
        returnAry[1]=deleteids;
        return returnAry;
    }
    function toaddProductlistrollback(obj)
    {
        var pro_desc = document.getElementById("pro_desc").checked;
       var ids=checkpageproduct(obj);
        if(ids[1]!=null&&ids[1]!="")
        {
            alert(ids[1]);
        }
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/QuotationtemplateitemAction.do?cmd=addProduct&date="+new Date()+"",{"ids":ids[0],"pro_desc":pro_desc},   function(json){
                        
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
	                   newEntity.setProperty("scheme_type", json.beans[i].scheme_type);
	                   newEntity.setProperty("big_type_id", json.beans[i].big_type_id);
	                   newEntity.setProperty("small_type_id", json.beans[i].small_type_id);
	                   newEntity.setProperty("three_type_id", json.beans[i].three_type_id);
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
       // var pro_desc = findSelections("pro_desc","id");
        
               
    //    if(pro_desc==null){
      //      var ids = window.showModalDialog('<venus:base/>/ProductAction.do?cmd=queryAllProduct&pro_desc=0&date='+new Date(),'','dialogHeight:510px;dialogWidth:810px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    //         var url="<%=request.getContextPath()%>/ProductAction.do?cmd=queryAllProduct&pro_desc=0";
   //          showModalCenter(url, window,toaddProductlistrollback,750,447,"添加产品");
    //    }else{
   //         var ids = window.showModalDialog('<venus:base/>/ProductAction.do?cmd=queryAllProduct&pro_desc=1&date='+new Date(),'','dialogHeight:510px;dialogWidth:810px;center:yes;help:no;resizable:no;scroll:no;status:no;');
             var url="<%=request.getContextPath()%>/ProductAction.do?cmd=queryAllProduct";
             showModalCenter(url, window,toaddProductlistrollback,750,447,"<fmt:message key="add_product"/>");
    //    }

    }
    
      function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='product_id'  value ="+entity.getProperty("product_id")+" onClick=ClickRow(\"" + entity.getProperty("product_id") + "\");>";
    }
    function ClickRow()
    {}
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
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_quotation_template"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="add_quotation_template"/>','<%=request.getContextPath()%>/');
</script>

	<div class="ringht_x">
   <div id="ccParent0" class="box_3"> 
	<div class="xz_title"><fmt:message key="basic_information"/></div>
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <input type="hidden" name ="id" value="${bean.id}"/>
        <tr>
            <td width="15%" class="td_1"><span class="style_required_red">*
            </span><fmt:message key="template_name"/></td>
            <td width="26%" class="td_2 "><input type="text"
                class="text_field" name="quotation_template_name" inputName="模板名称"
                value="" maxLength="50" validate="notNull;" /></td>
            <td width="19%" class="td_1"><span class="style_required_red">*
            </span><fmt:message key="salse_type"/></td>
            <td width="40%" class="td_2"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("biz_type_bd", -1, "SAL_QUO_BIZ_TYPE_BD", "1","id='biz_type_bd'", false)%>
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("biz_type_bd", -1, "SAL_QUO_BIZ_TYPE_BD", "1","id='biz_type_bd1'", false)%>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="effect_date"/></td>
            <td class="td_2"><w:date format="yyyy-MM-dd" id="effect_date" name="effect_date" width="200" readonly="true" property="bean/effect_date"/> 
            </td>

            <td class="td_1"><fmt:message key="lapse_date"/></td>
            <td class="td_2"> <w:date format="yyyy-MM-dd" id="lapse_date" name="lapse_date" width="200" readonly="true"  property="bean/lapse_date"/> 
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="product_info_desc"/></td>
            <td class="td_2 ">
            <%if(resultVo==null){ %> 
                 <input type='checkbox' name="pro_desc" value="1" pdType='control' control='checkbox_template' onclick="checkbox()"/> 
            <%}else{ if((resultVo.getIs_detail_bd())!=null&&(resultVo.getIs_detail_bd()).equals("1")) {%>
                 <input type='checkbox' name="pro_desc" value="1" pdType='control' control='checkbox_template' checked="checked" />
            <%}else {%>
                 <input type='checkbox' name="pro_desc" value="0" pdType='control' control='checkbox_template' onclick="checkbox()"/>
            <%}} %>
            </td>
            <td class="td_1"><fmt:message key="remark"/></td>
            <td class="td_2"><textarea rows="1" name="remark" style="width: 350px" inputName="备注" maxLength="50"></textarea></td>
        </tr>
    </table>

    </br>
    </div>
    <div class="xz_title"><fmt:message key="product_information"/></div>
    <div class="button_right">
	    <ul>
	       <li class="c_1"><a onClick="javascript:addProductList();"><fmt:message key="add_product"/></a></li>
	        <li class="d"  id="del"><a onClick="javascript:remove();"><fmt:message key="delete"/></a></li>
	    </ul>
     </div>
    <div class="clear"></div>
     <r:datacell 
        id="datacell1"
       queryAction="/FAERP/QuotationtemplateAction.do?cmd=getProduct&quotationtemlateid='${bean.id}'"
       
       submitAction="/FAERP/QuotationtemplateAction.do?cmd=insert"
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
       <r:field fieldName="scheme_type" width="150px"  messagekey="scheme_type">
       </r:field> 
       <r:field fieldName="big_type_id" width="150px" messagekey="big_type_id" >
       </r:field> 
       <r:field fieldName="small_type_id" width="150px" messagekey="small_type_id" >
       </r:field> 
       <r:field fieldName="three_type_id" width="150px" messagekey="three_type_id">
       </r:field> 
       <r:field fieldName="product_price" width="100px"  messagekey="product_price" >
       </r:field>
       <r:field fieldName="product_desc" width="136px"  messagekey="product_desc">
       </r:field> 
          
    </r:datacell>
    <div class="mx_button" style="text-align: center;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>' onClick="javascript:cancel_onClick()" />
    </div>
    </div>           
 </div>
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
         $id("datacell1").afterSubmit = function(ajax){
              form.action="<%=request.getContextPath()%>/QuotationtemplateAction.do?cmd=queryAll";
              form.submit();
            }
           if(<%=isModify%>)
           {
                jQuery("#biz_type_bd").attr("disabled", "disabled");
                jQuery("#biz_type_bd").show();
                jQuery("#biz_type_bd1").hide();
           }
          else
          {
                jQuery("#biz_type_bd").attr("disabled", "disabled");
                jQuery("#biz_type_bd1").show();
                jQuery("#biz_type_bd").hide();
          }
</script>
