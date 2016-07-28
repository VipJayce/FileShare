<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.policy.vo.PolicyVo" %>
<%@ page import="rayoo.insurance.policy.util.IPolicyConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	PolicyVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	String insurance_agent_name = "";
	String insurance_agent_id = "";
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPolicyConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (PolicyVo)request.getAttribute(IPolicyConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		    insurance_agent_name = resultVo.getInsurance_agent_name();
  		    insurance_agent_id = resultVo.getInsurance_agent_id();
  		}
	}
	String policycode = request.getAttribute("policycode")==null?"":request.getAttribute("policycode").toString();
%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(document.form.policy_name.value==null || document.form.policy_name.value==""){
           alert("保单名称不能为空！");
           return;
        }
	    if(document.form.policy_str_date.value==null || document.form.policy_str_date.value==""){
	       alert("保险开始日期不能为空！");
	       return;
	    }
	     if(document.form.policy_end_date.value==null || document.form.policy_end_date.value==""){
	          alert("保险结束日期不能为空！");
	          return;
	       }else{
	           var beginTime =document.form.policy_str_date.value.trim();
	           var endTime = document.form.policy_end_date.value.trim();
	           var beginTimes=beginTime.substring(0,10).split('-');
	           var endTimes=endTime.substring(0,10).split('-');
	           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
	           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
	           if(beginTime>endTime){
	               alert("保险结束日期小于保险开始日期！");
	               return;
	           }
	       }
	       if(document.form.insurance_agent_name.value==null || document.form.insurance_agent_name.value==""){
	           alert("保险公司名称不能为空！");
	           return;
	       }
	       var isMonery=/^[0-9]+\.{0,1}[0-9]{0,2}$/;
	       var public_insurance = document.form.public_insurance.value;
	       if(!isMonery.test(public_insurance)&&public_insurance!=""&&public_insurance!=null){
	          alert("请输入正确的公共保额！");
	          document.form.public_insurance.focus();
	          return;
	       }
		   $id("datacell1").isModefied = true;
	       $id("datacell1").addParam('policy_code', document.form.policy_code.value);
	       $id("datacell1").addParam('policy_name', document.form.policy_name.value);
	       $id("datacell1").addParam('policy_type', document.getElementById('policy_type').value);
	       $id("datacell1").addParam('policy_str_date', document.form.policy_str_date.value);
	       $id("datacell1").addParam('policy_end_date', document.form.policy_end_date.value);
	       $id("datacell1").addParam('public_insurance', document.form.public_insurance.value);
	       $id("datacell1").addParam('insurance_agent_name', document.form.insurance_agent_name.value);
	       $id("datacell1").addParam('insurance_agent_id', document.form.insurance_agent_id.value);
	       $id("datacell1").addParam('clearing_mode', document.getElementById('clearing_mode').value);
	       $id("datacell1").addParam('pay_mode', document.getElementById('pay_mode').value);
	       $id("datacell1").addParam('back_stage', document.form.back_stage.value);
	       $id("datacell1").addParam('is_open_pb_hospital', document.getElementById('is_open_pb_hospital').value);
	       $id("datacell1").addParam('is_open_private_hospital', document.getElementById('is_open_private_hospital').value);
	       $id("datacell1").addParam('remark', document.form.remark.value);
	          $id("datacell1").submit();
	       //var returnNode = myAjax.getResponseXMLDom();
	       //if( returnNode ) {
	         // alert(""+myAjax.getProperty("returnValue"));
	         // window['returnValue'] = ""+myAjax.getProperty("returnValue");
	          window.close();
	      // }		
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	   if(document.form.policy_name.value==null || document.form.policy_name.value==""){
         alert("保单名称不能为空！");
         return;
      }
    if(document.form.policy_str_date.value==null || document.form.policy_str_date.value==""){
         alert("保险开始日期不能为空！");
         return;
      }
       if(document.form.policy_end_date.value==null || document.form.policy_end_date.value==""){
         alert("保险结束日期不能为空！");
         return;
      }else{
          var beginTime =document.form.policy_str_date.value.trim();
          var endTime = document.form.policy_end_date.value.trim();
          var beginTimes=beginTime.substring(0,10).split('-');
          var endTimes=endTime.substring(0,10).split('-');
          beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
          endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
          if(beginTime>endTime){
              alert("保险结束日期小于保险开始日期！");
              return;
          }
      }
      if(document.form.insurance_agent_name.value==null || document.form.insurance_agent_name.value==""){
          alert("保险公司名称不能为空！");
          return;
      }
   var isMonery=/^[0-9]+\.{0,1}[0-9]{0,2}$/;
      var public_insurance = document.form.public_insurance.value;
      if(!isMonery.test(public_insurance)&&public_insurance!=""&&public_insurance!=null){
         alert("请输入正确的公共保额！");
         document.form.public_insurance.focus();
         return;
      }
     //form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=update";
	   //form.submit();
	   $id("datacell1").isModefied = true;
	    $id("datacell1").addParam('policy_code', document.form.policy_code.value);
        $id("datacell1").addParam('policy_name', document.form.policy_name.value);
        $id("datacell1").addParam('policy_type', document.getElementById('policy_type').value);
        $id("datacell1").addParam('policy_str_date', document.form.policy_str_date.value);
        $id("datacell1").addParam('policy_end_date', document.form.policy_end_date.value);
        $id("datacell1").addParam('public_insurance', document.form.public_insurance.value);
        $id("datacell1").addParam('insurance_agent_name', document.form.insurance_agent_name.value);
        $id("datacell1").addParam('insurance_agent_id', document.form.insurance_agent_id.value);
        $id("datacell1").addParam('clearing_mode', document.getElementById('clearing_mode').value);
        $id("datacell1").addParam('pay_mode', document.getElementById('pay_mode').value);
        $id("datacell1").addParam('back_stage', document.form.back_stage.value);
        $id("datacell1").addParam('is_open_pb_hospital', document.getElementById('is_open_pb_hospital').value);
        $id("datacell1").addParam('is_open_private_hospital', document.getElementById('is_open_private_hospital').value);
        $id("datacell1").addParam('remark', document.form.remark.value);
        $id("datacell1").addParam('id', document.form.id.value);
        $id("datacell1").addParam('create_date', document.form.create_date.value);
        $id("datacell1").addParam('create_user', document.form.create_user.value);
        $id("datacell1").addParam('company_id', document.form.company_id.value);
        $id("datacell1").submit();
        window.close();
	}

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }
    
    //保險供應商名稱查询条件   --遗弃
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/InsuranceAegntAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         document.form.insurance_agent_name.value=data[2];
         document.form.insurance_agent_id.value=data[0];
    }
    
    function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#insurance_agent_id").val(arg[0]);      
        jQuery("#insurance_agent_name").val(arg[2]);       
        return false;
    }
    
     //添加产品   --遗弃
    function addProductList1() {
        var ids = window.showModalDialog('<venus:base/>/PolicyAction.do?cmd=queryAllPolicy&date='+new Date(),'','dialogHeight:510px;dialogWidth:810px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids) {
            if(findSelections("checkbox_template","id")!=null){
                //得到当前有多少行数据
                var trids = ids+findSelections("checkbox_template","id");
            }else{
                var trids = ids;
            }
            var table1=document.getElementById('tab');
            var rows=table1.rows;
            var row=rows.length;
            if(rows!="undefined"){
                //显示删除按钮
                if(row>=1)document.getElementById("del").style.display='';
            }
            jQuery.ajax({
            url: '<%=request.getContextPath()%>/PolicyAction.do?cmd=vailPolicyId&trids='+trids+'',
            type: 'POST',
            dataType: 'html',
            timeout: 10000,
            error: function(){
                alert('Error loading XML document');
                return null;
            },
            success: function(data){
                if(data=='true'){
                    //后台取到数据
                    jQuery.getJSON("<venus:base/>/PolicyAction.do?cmd=getChooseData1&date="+new Date()+"",{"ids":ids},   function(json){
                    for(var i = 0; i < json.saia.length; i++){
                        jQuery("#tab").append("<tr id=tr"+json.saia[i].product_id+"><td ><input type=\"hidden\" name=\"trid\" value="+json.saia[i].product_id+"><input type=\"checkbox\" class=\"fex_row\" name=\"checkbox_template\" value="+json.saia[i].product_id+"></td><td class=\"fex_row\" >"+json.saia[i].product_name+"</td><td class=\"fex_row\">"+json.saia[i].big_type_id+"</td><td class=\"fex_row\">"+json.saia[i].small_type_id+"</td><td><span class=\"td_2\"><input type=\"text\" class=\"sText_1\"  name=\"insure_price\" value=\""+json.saia[i].insure_price+"\" validate=\"notNull\;notNullWithoutTrim\;checkCurrency\;notChinese\;\" ><span</td></tr>");
                    }
                    }); 
                }else{
                    alert('添加产品不能有重复，请删除重复产品！');
                    return null;
                }
            }
        });
            document.getElementById("values_div").style.display='';
        }
    }
    
     //移除一行子记录   --遗弃
     function remove1(){
        var arrayObj = new Array(); 
        function selectIdCount(){
            selecCount=0;
            var idTag=  document.getElementsByName("checkbox_template");
            for(i=0;i<idTag.length;i++){
                if(idTag[i].checked==true){
                    selecCount++;
                    arrayObj.push(idTag[i].value);
                }
            }
         }       
         selectIdCount();
         if(selecCount<1){
           alert('请选择一条以上的记录');
           return;
         }
        
        for(var i =0;i<arrayObj.length;i++){
        jQuery("#tr"+arrayObj[i]).remove();
        }
        
        //隐藏删除按钮
        var table1=document.getElementById('tab');
        var rows=table1.rows;
        var row=0;
        if(rows!="undefined"){
        row=rows.length;
               if(row<=1){
               document.getElementById("del").style.display='none';
               }
        }
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
                   deleteids+=entity.getProperty("product_name")+"已在列表中存在，不能重复添加！\n";
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
              jQuery.getJSON("<venus:base/>/PolicyAction.do?cmd=addProduct&date="+new Date()+"",{"ids":ids[0]},   function(json){
                        
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
                       newEntity.setProperty("small_type_id", json.beans[i].small_type_id);
                       newEntity.setProperty("big_type_id", json.beans[i].big_type_id);
                       newEntity.setProperty("insure_price", json.beans[i].insure_price==null||json.beans[i].insure_price==""?"0": json.beans[i].insure_price);
                       $id("datacell1").addRow(newEntity);
                }
              }
              });
        }
    }
    function addProductList() {
        var url="<%=request.getContextPath()%>/ProductAction.do?cmd=queryAllProduct&bigtypeid=104";
        <% if(isModify){%>
            url+="&PolicyId=${bean.id}";
        <% }%>
        showModalCenter(url, window,toaddProductlistrollback,810,510,"添加产品");
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='product_id'  value ="+entity.getProperty("product_id")+" onClick=ClickRow(\"" + entity.getProperty("product_id") + "\");>";
    }
    
    function ClickRow(){}
    
    function remove()
    {
        var elementCheckbox = document.getElementsByName("product_id");
        var ids = null;  //定义id值的数组
        var number = 0;  //定义游标
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
	       if(elementCheckbox[i].checked) {  //如果被选中
	           number += 1;  //游标加1
	           if(ids == null) {
                    ids = new Array(0);
               }
               ids.push(elementCheckbox[i].value);  //加入选中的checkbox
	           $id("datacell1").deleteRow(i);
	           <% if(isModify){%>
	           $id("datacell1").addParam("del","true");
	           if($id("datacell1").submit()){
	               alert("删除成功！");
	               $id("datacell1").loadData();
                   $id("datacell1").refresh();
	           }
	           <% }%>
	       }
        }
        if(ids==null){
            alert('请选择需要删除的记录！');
            return;
        }
    }
    function showListData(){
        $id("datacell1").addParam("product_name1",$id("product_name1").value);
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function exportProduct(){
        if(confirm('是否确定要导出数据？')) {
            document.form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=exportToExcelProduct&PolicyId=${bean.id}";
            document.form.submit();
        }
    }
</script>
</head>
<body>

<form name="form" method="post">
<div id="right">
<div class="xz_title" style="padding-top:10px; ">表头信息</div>
 <div class="ringht_x" style="padding-top: -10px;">
<div id="ccParent0" class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="25%"><span style="color:red;">*</span>保单编号</td>
            <td class="td_2" width="15%"><input type="text" class="text_field" name="policy_code" inputName="保单编号" value="<%=policycode %>" maxLength="64" disabled="disabled" style="width: 100px;" /></td>
            <td class="td_1" width="25%"><span style="color:red;">*</span>保单名称</td>
            <td class="td_2" width="15%"><input type="text" class="text_field" name="policy_name" inputName="保单名称" value="" maxLength="50" style="width: 100px;" /></td>
            <td class="td_1" width="25%">保单类型</td>
            <td class="td_2" width="15%">
              <d:select dictTypeId="POLICY_TYPE_BD" id="policy_type" property="bean/policy_type" style="width:100px;" />
            </td>
          </tr>
          <tr>
            <td class="td_1"><span style="color:red;">*</span>保险开始日期</td>
            <td class="td_2"><w:date format="yyyy-MM-dd" id="policy_str_date" name="policy_str_date" property="bean/policy_str_date" width="85px"/></td>
            <td class="td_1"><span style="color:red;">*</span>保险结束日期</td>
            <td class="td_2"><w:date format="yyyy-MM-dd" id="policy_end_date" name="policy_end_date" property="bean/policy_end_date"  width="85px"/></td>
            <td class="td_1">公共保额</td>
            <td class="td_2"><input type="text" class="text_field" name="public_insurance" inputName="公共保额" maxLength="23" integerDigits="18" decimalDigits="4" style="width: 100px;" /></td>
          </tr>
          <tr>
            <td class="td_1"><span style="color:red;">*</span>保险公司名称</td>
            <td class="td_2">
	            <w:lookup onReturnFunc="rtnFunc" lookupWidth="85px" readonly="true" id="lk_cust" displayValue="<%=insurance_agent_name %>" lookupUrl="/InsuranceAegntAction.do?cmd=queryAllGetByID" dialogTitle="选择保险公司" height="500" width="800"/>
	            <input type="hidden" name="insurance_agent_name" id="insurance_agent_name" value="<%=insurance_agent_name %>"/>
	            <input type="hidden" name="insurance_agent_id" id="insurance_agent_id" value="<%=insurance_agent_id %>"/>
            </td>
            <td class="td_1">结算方式</td>
            <td class="td_2"><d:select dictTypeId="CLEARING_MODE_BD" id="clearing_mode" property="bean/clearing_mode" style="width: 100px;" /></td>
            <td class="td_1">支付方式</td>
            <td class="td_2"><d:select dictTypeId="PAY_MODE_BD" id="pay_mode" property="bean/pay_mode" style="width: 100px;" /></td>
          </tr>
          <tr>
            <td class="td_1">追溯期</td>
            <td class="td_2"><input type="text" class="text_field" name="back_stage" inputName="追溯期" maxLength="19" integerDigits="18" decimalDigits="0" style="width: 100px;" /></td>
            <td class="td_1"><span style="color:red;">*</span>是否开放公立一级医院</td>
            <td class="td_2"><d:select dictTypeId="TrueOrFalse" id="is_open_pb_hospital" property="bean/is_open_pb_hospital" style="width: 100px;" /></td>
            <td class="td_1"><span style="color:red;">*</span>是否开放定点私立医院</td>
            <td class="td_2"><d:select dictTypeId="TrueOrFalse" id="is_open_private_hospital" property="bean/is_open_private_hospital" style="width: 100px;" /></td>
          </tr> 
          <tr>
            <td class="td_1">备注</td>
            <td colspan="5" class="td_2" >
                <textarea class="textarea_limit_words" rows="5" name="remark" inputName="备注" maxLength="1000" style="width:80%"></textarea>
            </td>
          </tr>        
	</table></div>
<div class="button_right" id="div1" style="margin-top: 15px;">
      <div class="xz_title">明细信息</div>
      <table width="<%=isModify?"60%":"20%" %>" height="40" border="0" cellpadding="0" cellspacing="1" >
	   <tr>
	     <td class="td_1"><div class="button_right"><input class="g_1" type="button"  value="选择产品" onClick="addProductList();"></div></td>
         <td class="td_1"><div class="button_right"><input class="d" id="del" type="button"  value="删除" onClick="remove();"></div></td>
	     <% if(isModify){%>
	     <td class="td_2">
	    产品名称：<input type="text" name="product_name1" class="text_field" id="product_name1" style="border-style: solid;border-color: #90b3cf;border-width: 1px;">
	     </td>
         <td class="td_1"><div class="button_right"><input class="a" type="button"  value="查询" onClick="showListData();"></div></td>
         <td class="td_1"><div class="button_right"><input class="e_1" type="button"  value="导出" onClick="exportProduct();"></div></td>
         <%} %>
	   </tr>
	 </table>
        <div class="clear"></div>
    <div style="margin: 0px;">
      <r:datacell 
        id="datacell1"
       queryAction="/FAERP/PolicyAction.do?cmd=getProduct&PolicyId='${bean.id}'"       
       submitAction="/FAERP/PolicyAction.do?cmd=insert"
        width="100%"
        xpath="PolicyVo"
        submitXpath="PolicyVo"
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       <r:field fieldName="product_id" width="0px" label="" >
       </r:field>
       <r:field fieldName="product_name" width="250px" label="产品名称" >
       </r:field>
       <r:field fieldName="big_type_id" width="250px" label="产品大类" >
       </r:field> 
       <r:field fieldName="small_type_id" width="250px" label="产品小类" >
       </r:field>   
       <r:field fieldName="insure_price" width="150px" label="投保价" >
               <h:text validateAttr="allowNull=true;type=float;message=不是数字或精度有误！;"/>
       </r:field>          
    </r:datacell>
    </div>
    </div>
    <div class="mx_button"  style="text-align: center; margin-top: 30px;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
       </div>     
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />
<input type="hidden" name="create_user" />
<input type="hidden" name="company_id" />

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
	    if(request.getAttribute("list") != null) {  //如果request中取出的bean不为空
	         List list = (List)request.getAttribute("list");  
	                if(list.size()>0){
	                %>
	                document.getElementById("del").style.display='';
	             <%}
	    }
  	}
%>
</script>
