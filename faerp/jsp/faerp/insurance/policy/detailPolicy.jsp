<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %> 
<%@ page import="rayoo.insurance.policy.vo.PolicyVo" %>
<%@ page import="rayoo.insurance.policy.util.IPolicyConstants" %>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="rayoo.sales.customersimple.vo.CustomersimpleVo"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
	PolicyVo resultVo = null;  //定义一个临时的vo变量
	if(request.getAttribute(IPolicyConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (PolicyVo)request.getAttribute(IPolicyConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
    String policy_id = null;
    String itemId = "";
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        //form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }

   
   //分配客户
    function allocatContemer(){
        if(!choose_row("policy_item_id_temp")){
        return;
        }
        var policy_item_id=$id("policy_item_id_temp").value;
        //var ids = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllCustomer&pitem_ids=&date='+new Date(),'','dialogHeight:510px;dialogWidth:810px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        //alert(ids);
        var url = "<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=queryAllCustomer&policy_item_id="+policy_item_id+"&_ts='+(new Date()).getTime()";
        showModalCenter(url, window, callBack, 800, 450, "分配客户"); 
     }
     
     function callBack(ids){
            if(ids!=""){
                alert(ids+"已经存在列表中！");
            }
            $id("datacell2").loadData();
            $id("datacell2").refresh();
     }
     
     function add_CustomerForPitme(){  //插入分配客户数据
     var custids = '';
        jQuery("#div input[type='checkbox']:visible").each(function(index){
            if(index>0){
                  //0 是最上面的复选框
                 //this为当前复选框
                 custids += this.value+',';
            }
         });
        form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=add_CustomerForPitme&policyiid="+objs+"&cid="+custids;
        form.submit();
    }
   function showdata(obj)
    {
        objs = jQuery(obj).val();
        jQuery("#div tr").hide();
        jQuery("#div tr:eq(0)").show();
        jQuery("#div tr[id='tr"+jQuery(obj).val()+"']").show();
        var custids = '';
        jQuery("#div input[type='checkbox']:visible").each(function(index){
		    if(index>0){
				  //0 是最上面的复选框
				 //this为当前复选框
				 custids += this.value+',';
		    }
		 });
    }
    
    //移除一行子记录
     function remove(){
        var arrayObj = new Array(); 
        var custids = '';
        function selectIdCount(){
            selecCount=0;            
            var idTag=  document.getElementsByName("checkbox_template_cust");
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
         jQuery("#div input[type='checkbox']:visible:checked").each(function(){
		  jQuery(this).parents("tr").remove() 
		});
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio' name='temp'  onClick=ClickRow(\"" + entity.getProperty("policy_item_id") + "\");>";
    }
    
    function ClickRow(policy_item_id){
        //alert("policy_item_id="+policy_item_id);
        $id("policy_item_id_temp").value=policy_item_id;
        $id("datacell2").addParam("policy_item_id",policy_item_id);
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }

    
    jQuery(function(){
        $id("datacell2").isQueryFirst = false;
    });
    
      function choose_row(tagid) {
	        if($id(tagid).value==""){
	               alert("请选择一条产品记录！");
	               return false;
	        }
	        return true;
	   }
    
</script>
</head>
<body> 
<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="policy_str_date">
<input type="hidden" name="policy_end_date">
<input type="hidden" name="is_open_pb_hospital">
<input type="hidden" name="is_open_private_hospital">
<input type="hidden" name="clearing_mode">
<input type="hidden" name="pay_mode">
<input type="hidden" name="policy_item_id_temp" id="policy_item_id_temp">
       <div id="right">
		<!--<div class="right_title_bg"><div class=" right_title">保单产品-分配客户</div></div>-->
    	<div class="ringht_s">
<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >保单编号</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="policy_code" inputName="保单编号" value="${bean.policy_code }" readonly /></td>
			<td class="td_1" >保单名称</td>
            <td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="policy_name" inputName="保单名称" value="${bean.policy_name }" readonly /></td>
			<td class="td_1" >保险开始日期</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="保险开始日期" value="<%=RmStringHelper.prt(resultVo.getPolicy_str_date(), 10)%>" readonly /></td>
		</tr>
		<tr>
			<td class="td_1" >保险结束日期</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="保险结束日期" value="<%=RmStringHelper.prt(resultVo.getPolicy_str_date(), 10)%>" readonly /></td>
			<td class="td_1" >公共保额</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="public_insurance" inputName="公共保额" value="${bean.public_insurance }" readonly /></td>
			<td class="td_1">保险公司名称</td>
            <td class="td_2"><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="insurance_agent_name" inputName="保险公司名称" value="${bean.insurance_agent_name }" readonly />
            <input type="hidden" name="insurance_agent_id" id="insurance_agent_id" value="${bean.insurance_agent_id}">
		</tr>
		<tr>
			<td class="td_1" >结算方式</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="结算方式" value="<%=BaseDataHelper.getNameByCode("CLEARING_MODE_BD",String.valueOf(resultVo.getClearing_mode())) %>" readonly /></td>
			<td class="td_1" >支付方式</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="支付方式" value="<%=BaseDataHelper.getNameByCode("PAY_MODE_BD",String.valueOf(resultVo.getPay_mode())) %>" readonly /></td>
			<td class="td_1" >追溯期</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" name="back_stage" inputName="追溯期" value="${bean.back_stage }" readonly /></td>
		</tr>
		<tr>
			<td class="td_1" >是否开放公立一级医院</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="是否开放公立一级医院" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getIs_open_pb_hospital())) %>" readonly /></td>
			<td class="td_1" >是否开放定点私立医院</td>
			<td class="td_2" ><input type="text" style="background: url() #fff repeat-x right top;" class="xText_bttm" inputName="是否开放定点私立医院" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getIs_open_private_hospital())) %>" readonly /></td>
			<td class="td_1" ></td>
            <td class="td_2" ></td>
		</tr>
	</table>
</div>
<div class="button">
      <div class="button_right">
        <ul>
          <li class="p"><a onClick="javascript:allocatContemer();">分配客户</a></li>
        </ul>
        <div class="clear"></div>
      </div>
    </div>    
    <div>    
    <table cellpadding="0" style="padding: 5 10 8 8;" border="0">
    <tr>
        <td valign="top" width="40%">
                <r:datacell 
			        id="datacell1"
			        queryAction="/FAERP/PolicyAction.do?cmd=searchPolicytData&parentId=${bean.id}"
			        width="98%"
			        height="250px"
			        xpath="PolicyVo"
			        paramFormId="datacell_formid"
			        >
			      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
			       <r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center" >
			       </r:field>
			      <r:field fieldName="product_name" label="名称" width="200px">
			      </r:field>
			      <r:field fieldName="big_type_id" label="产品大类" allowModify="false" width="150px">
			      <d:select dictTypeId="big_type_id" />
			      </r:field>
			      <r:field fieldName="small_type_id" label="产品小类" allowModify="false" width="95px">
			      <d:select dictTypeId="big_type_id" />
			      </r:field>
			      <r:field fieldName="insure_price" label="投保价" width="80px">
			      </r:field>
			      <!-- 
			      <r:field fieldName="policy_item_id" label="保单明细ID" width="150px">
                  </r:field>
                   -->
			    </r:datacell>
        </td>
        <td valign="top" width="35%">
	        <r:datacell 
	            id="datacell2"
	            paramFormId="datacell_formid"
	            queryAction="/FAERP/PolicyAction.do?cmd=searchCustomerData"
	            submitAction="/FAERP/PolicyAction.do?cmd=updateCustomerData"
	            width="98%" height="250px"
	            xpath="CustomerVo">	    
	          <r:toolbar location="bottom" tools="nav,edit:del,pagesize,info"/>
	          <r:field fieldName="customer_code" label="客户编号" width="100px">
	          </r:field>
	          <r:field fieldName="customer_name" label="客户名称" width="135px">
	          </r:field>
	          <r:field fieldName="contact_person" label="客户联系人" width="130px">
	          </r:field>
	          <r:field fieldName="bank_account" label="银行账号" width="140px">
	          </r:field>
	        </r:datacell>            
        </td>
        </tr>
   </table>    
    </div>    
<div class="foot_button">
<input type="button" class="foot_icon_1" value='关闭'  onclick="javascript:back_onClick();" />
</div>
</div>
	 </div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	<%
	//out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo))); 	
	%>	
</script>

<script language="javascript">

function firstdata(val)
    {  
        objs = val;
        jQuery("#div tr").hide();
        jQuery("#div tr:eq(0)").show();
        jQuery("#div tr[id='tr"+val+"']").show();
        var custids = '';
        jQuery("#div input[type='checkbox']:visible").each(function(index){
            if(index>0){
                  //0 是最上面的复选框
                 //this为当前复选框
                 custids += this.value+',';
            }
         });
    }
    
    function CheckAll(item) {
	    if (_$(item).attr("checked")) {
	        _$(":checkbox").attr("checked", true);
	    } else {	
	        _$(":checkbox").attr("checked", false);
	    }
	}
	
	
    $id("datacell2").afterDel= function(row){
	    isModefied = true;
	    if($id("datacell2").submit()){
	        alert("操作成功！");
	     }
	    return true;
    }
    
    $id("datacell2").beforeDel= function(row){
        if(confirm('您确定要删除所选择的记录吗？')) {  //如果用户在确认对话框按"确定"
            return true;
        }else{
           return false;
        }
    }
    
</script>

</body>
</html>
