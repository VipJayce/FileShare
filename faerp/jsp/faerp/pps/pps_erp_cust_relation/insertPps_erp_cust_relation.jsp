<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.pps_erp_cust_relation.vo.Pps_erp_cust_relationVo" %>
<%@ page import="rayoo.pps.pps_erp_cust_relation.util.IPps_erp_cust_relationConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPps_erp_cust_relationConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    //resultVo = (Pps_erp_cust_relationVo)request.getAttribute(IPps_erp_cust_relationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		//var pps_cust_mapping_id = $id("lk_clz").getValue();
		var pps_cust_mapping_id = document.getElementById("pps_cust_mapping_id").value;
		if(pps_cust_mapping_id==null || pps_cust_mapping_id==""){
           alert("PPS客户不能为空！");
           return;
        }else{
        	 var isTure = "false";
	         jQuery.ajax({
	           url: '<%=request.getContextPath()%>/Pps_erp_cust_relationAction.do?cmd=vailCust&id='+pps_cust_mapping_id,
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	               error: function(){
	                  alert("请重新选择PPS客户");
	                  $id("lk_clz").setValue("");
        			  $id("lk_clz").setDisplayValue("");
	                  isTure = "true";
	                  return;
	               },
	                success: function(data){
		                if(data=='true'){
		                   alert("请重新选择PPS客户");
		                   $id("lk_clz").setValue("");
        			       $id("lk_clz").setDisplayValue("");
		                   isTure = "true";
		                   return;
		               }else{
		               	   isTure = "false";
		               }
	               }
	        });
	        if(isTure == "true"){
	        	return;
	        }
        }
        $id("datacell1").isModefied = true;
	    $id("datacell1").addParam('pps_cust_mapping_id', pps_cust_mapping_id);	  
	    var v_datacell = $id("datacell1").dataset;
	    var isTure = "0";
        var len1 = v_datacell.getLength();
        if(len1<=0){
        	alert("请添加ERP客户！");
        	return;
        }
        var elementCheckbox = document.getElementsByName("is_pay_im_belong");  //通过name取出所有的radio
        for(var i =0 ; i < len1 ; i++){
            var erp_cust_name=v_datacell.get(i).getProperty("erp_cust_name");
            var is_pay_im_belong = elementCheckbox[i].value;
            if(is_pay_im_belong=="1"){
            	v_datacell.get(i).setProperty("is_pay_im_belong","1");
                isTure = "1";
            }
        }
        if(isTure == "0"){
	    	alert("请选择工资导入所属！");
	    	return;
	    }
	    if($id("datacell1").submit()) {
	    	alert("操作成功！");
            window.close();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		var pps_cust_mapping_id = document.getElementById("pps_cust_mapping_id").value;
	    var v_datacell = $id("datacell1").dataset;
	    var isTure = "0";
        var len1 = v_datacell.getLength();
        if(len1<=0){
        	alert("请添加ERP客户！");
        	return;
        }
        $id("datacell1").isModefied = true;
	    $id("datacell1").addParam('pps_cust_mapping_id', pps_cust_mapping_id);	
        var elementCheckbox = document.getElementsByName("is_pay_im_belong");  //通过name取出所有的radio
        for(var i =0 ; i < len1 ; i++){
            var erp_cust_name=v_datacell.get(i).getProperty("erp_cust_name");
            var is_pay_im_belong = elementCheckbox[i].value;
            if(is_pay_im_belong=="1"){
            	v_datacell.get(i).setProperty("is_pay_im_belong","1");
                isTure = "1";
            }else{
            	v_datacell.get(i).setProperty("is_pay_im_belong","0");
            }
        }
        if(isTure == "0"){
	    	alert("请选择工资导入所属！");
	    	return;
	    }
	    if($id("datacell1").submit()) {
	    	alert("操作成功！");
            window.close();
		}
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='customer_id'  value ="+entity.getProperty("erp_cust_id")+" onClick=ClickRow(\"" + entity.getProperty("erp_cust_id") + "\");>";
    }
    
    function setRadioStatus(value,entity,rowNo,cellNo){
    	return entity.getProperty("is_pay_im_belong")=="1"?"<input type='radio' checked name='is_pay_im_belong' value ="+entity.getProperty("is_pay_im_belong")+" onClick=ClickRow1(\"" + entity.getProperty("is_pay_im_belong") + "\");>":"<input type='radio' name='is_pay_im_belong' value ="+entity.getProperty("is_pay_im_belong")+" onClick=ClickRow1(\"" + entity.getProperty("is_pay_im_belong") + "\");>";
    }
    
    function ClickRow(){}
    
    function ClickRow1(){
    	var elementCheckbox = document.getElementsByName("is_pay_im_belong");  //通过name取出所有的radio
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                elementCheckbox[i].value="1"
            }else{
            	elementCheckbox[i].value="0"
            }
        }
    }
    
    function remove()
    {
        var elementCheckbox = document.getElementsByName("customer_id");
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
    
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        document.getElementById("pps_cust_mapping_id").value = arg[4];
        return false;
    }
    
    function addERPCustList() {
        var url="<%=request.getContextPath()%>/Pps_erp_cust_relationAction.do?cmd=queryAllCust";
        <% if(isModify){%>
            url+="&pps_cust_mapping_id=${bean.id}";
        <% }%>
        showModalCenter(url, window,toaddERPCustlistrollback,600,510,"添加ERP客户");
    }
    
    function toaddERPCustlistrollback(obj)
    {
       var ids=checkpageerpcust(obj);
        if(ids[1]!=null&&ids[1]!="")
        {
            alert(ids[1]);
        }
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/Pps_erp_cust_relationAction.do?cmd=addERPCust&date="+new Date()+"",{"ids":ids[0]},   function(json){
                        
              if(json.error!=null&&json.error!="")
              {
                    alert(json.error);
              }
              if(json.beans!=null&&json.beans!="")
              {              
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("erp_cust_id", json.beans[i].erp_cust_id);
                       newEntity.setProperty("erp_cust_name", json.beans[i].erp_cust_name);
                       newEntity.setProperty("erp_cust_code", json.beans[i].erp_cust_code);
                       newEntity.setProperty("is_pay_im_belong", json.beans[i].is_pay_im_belong==null||json.beans[i].is_pay_im_belong==""?"0":json.beans[i].is_pay_im_belong);
                       $id("datacell1").addRow(newEntity);
                }
              }
              });
        }
    }
    
    function checkpageerpcust(obj)
    {
        var addids="";
        var deleteids="";        
        var customerid = document.getElementsByName("customer_id");
        var ids = obj;
        for(var i = 0;i<ids.length;i++)
        { 
            var istrue='false';
            for(var j=0;j<customerid.length;j++)
            {
                var entity=$id("datacell1").dataset.get(j);   
                if(entity.getProperty("erp_cust_id")==(ids+",").split(",")[i])
                {
                   istrue="true";
                   deleteids+=entity.getProperty("erp_cust_name")+"已在列表中存在，不能重复添加！\n";
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
</script>
</head>
<body>

<form name="form" method="post">
<input type="hidden" name="pps_cust_mapping_id" id="pps_cust_mapping_id" value="${bean.id }">
<div id="right">
<div class="xz_title" style="padding-top:10px; ">PPS客户</div>
 <div class="ringht_x" style="padding-top: -10px;">
<div id="ccParent0" class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	<tr>
	 <td class="td_1"><span style="color:red;">*</span>PPS客户</td>
	 <td colspan="3" class="td_2" >
	 	<%if(isModify) { %>
	     <w:lookup name="cust_name" onReturnFunc="rtnFuncCustomer" readOnly="true" value="${bean.pps_cust_id}" displayValue="${bean.pps_cust_name}" id="lk_clz" lookupUrl="/Pps_au_party_check_relationAction.do?cmd=getCheckCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:195px"/>
	     <%}else{ %>
	     <w:lookup name="cust_name" onReturnFunc="rtnFuncCustomer" readonly="true" id="lk_clz" lookupUrl="/Pps_au_party_check_relationAction.do?cmd=getCheckCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:195px"/>
	     <%} %>
	 </td>
	</tr>        
</table></div>
<div class="button_right" id="div1" style="margin-top: 15px;">
      <div class="xz_title">ERP客户</div>
      <table width="20%" height="40" border="0" cellpadding="0" cellspacing="1" >
	   <tr>
	     <td class="td_1"><div class="button_right"><input class="g_1" type="button"  value="选择客户" onClick="addERPCustList();"></div></td>
         <td class="td_1"><div class="button_right"><input class="d" id="del" type="button"  value="删除" onClick="remove();"></div></td>
         <td class="td_1"><div class="button_right"><input type="button" class="c" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" /></div></td>
         <td class="td_1"><div class="button_right"><input type="button" class="f" value='关闭'  onClick="javascript:cancel_onClick()"/></div></td>
	   </tr>
	 </table>
        <div class="clear"></div>
    <div style="margin: 0px; padding-left: 10px;">
      <r:datacell 
        id="datacell1"
       queryAction="/FAERP/Pps_erp_cust_relationAction.do?cmd=getERPCust&pps_cust_mapping_id=${bean.id}"       
       submitAction="/FAERP/Pps_erp_cust_relationAction.do?cmd=insert"
        width="98%"
        xpath="Pps_erp_cust_relationVo"
        submitXpath="Pps_erp_cust_relationVo"
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>  
       <r:field fieldName="erp_cust_id" width="0px" label="" >
       </r:field> 
       <r:field fieldName="erp_cust_name" width="250px" label="ERP客户名称" >
       </r:field>
       <r:field fieldName="erp_cust_code" width="235px" label="ERP客户编号" >
       </r:field> 
       <r:field fieldName="is_pay_im_belong"  label="工资导入所属" width="130px" onRefreshFunc="setRadioStatus" align="center">
       </r:field> 
    </r:datacell>
    </div>
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
		//out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
